//
//  ViewController.m
//  ZhuZhenAmation
//
//  Created by 阳永辉 on 16/3/9.
//  Copyright © 2016年 HuiDe. All rights reserved.
//

#import "ViewController.h"
#define IMAGE_COUNT 10
@interface ViewController () {
    CALayer *_layer;
    int _index;
    NSMutableArray *_images;
    CADisplayLink *_displayLink;
    UIImageView * animationImageView;
    BOOL isPause;
}

@end

@implementation ViewController
@synthesize <#property#>
- (void)viewDidLoad {
    [super viewDidLoad];
    
    animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 150, CGRectGetWidth(self.view.frame)-20*2, 200)];
    [self.view addSubview:animationImageView];
    
    CGFloat buttonWidth = 100;
    CGFloat xpad = (CGRectGetWidth(self.view.frame)-buttonWidth*2)/3;
    for (int i = 0; i < 2; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(xpad+(xpad+buttonWidth)*i, CGRectGetMaxY(animationImageView.frame)+100, buttonWidth, 30);
        [button setTitle:@[@"播放动画",@"暂停动画"][i] forState:UIControlStateNormal];
        [button addTarget:self action:NSSelectorFromString(@[@"animationStartOrStop:",@"animationPauseOrResume:"][i]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"background.png"].CGImage;
    
//    _layer = [[CALayer alloc] init];
//    _layer.bounds = CGRectMake(0, 0, 87, 32);
//    _layer.position = CGPointMake(160, 284);
//    [self.view.layer addSublayer:_layer];
//    
//    _images = [NSMutableArray array];
//    for (int i = 1; i<11; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"fish%i.png",i];
//        UIImage *image = [UIImage imageNamed:imageName];
//        [_images addObject:image];
//    }
//    
//    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
//    _displayLink.frameInterval = 6;
//    
//    
//    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self dataConfig];

}

- (void)dataConfig {
    
    NSMutableArray * array = [[NSMutableArray alloc]init];
    //No.1
    //开始写代码，用一组图片（14030708－01.tiff~14030708－22.tiff）实现逐帧动画，要求：动画开始前显示firstImage，动画持续3秒，不重复播放。
    for(int i = 1;i<11;i++){
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"fish%d.png",i]];
        [array addObject:image];
    }
    
    animationImageView.animationImages = array;
    animationImageView.animationDuration = 3;
    animationImageView.animationRepeatCount = 1;
    
//    [animationImageView startAnimating];


}

//- (void)step {
//    static int s = 1;
//    
//    if (++s <11 ) {
//        
//        UIImage *image = _images[_index];
//        _layer.contents = (id)image.CGImage;
//        _index = (_index + 1)%IMAGE_COUNT;
//    }
//}

- (void)animationStartOrStop:(UIButton *)sender {
//    No.2
//    开始写代码，完成“播放动画”按钮的点击事件，实现动画开关控制。即动画未播放时开始播放；正在播放时停止动画。
    if (!animationImageView.isAnimating) {
        [animationImageView startAnimating];
    }else {
        [self pauseAnimationLayer:animationImageView.layer];

    }
    
}

///*“暂停播放”按钮的点击事件，实现动画播放时的暂停和恢复暂停功能*/
- (void)animationPauseOrResume:(UIButton *)sender {
    if (isPause) {
        [self resumeAnimationLayer:animationImageView.layer];
    }else{
        [self pauseAnimationLayer:animationImageView.layer];
    }
}
//暂停播放
-(void)pauseAnimationLayer:(CALayer*)layer{
    isPause = YES;
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
    
}

//恢复播放
-(void)resumeAnimationLayer:(CALayer*)layer{
    isPause = NO;
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
