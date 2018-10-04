//
//  AWCircularProgressView.swift
//  AWSpotight
//
//  Created by adam.wienconek on 04.10.2018.
//  Copyright © 2018 adam.wienconek. All rights reserved.
//

import UIKit

class AWCircularProgressView: UIView {

    fileprivate var _value: Float = 0.0
    var value: Float {
        get {
            return _value
        } set {
            _value = max(0, min(1, newValue))
        }
    }
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var trackLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    @IBInspectable var progressWidth: CGFloat = 10.0 {
        didSet {
            progressLayer.lineWidth = progressWidth;
        }
    }
    
    @IBInspectable var trackWidth: CGFloat = 10.0 {
        didSet {
            trackLayer.lineWidth = trackWidth;
        }
    }
    
    @IBInspectable var progressColor: UIColor = UIColor.red {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    @IBInspectable var trackColor: UIColor = UIColor.red.withAlphaComponent(0.2) {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    fileprivate func createCircularPath() {
        backgroundColor = .clear
        layer.cornerRadius = frame.width / 2.0
        
        let radius = (frame.width - 1.5) / 2
        let startAngle = CGFloat(-0.5 * Double.pi)
        let endAngle = CGFloat(1.5 * Double.pi)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = 0.0
        layer.addSublayer(progressLayer)
    }
    
    func setProgress(_ value: Float, duration: TimeInterval? = nil) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration ?? 0
        animation.fromValue = self.value
        animation.toValue = value
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: "animateCircle")
        _value = value
    }

}
