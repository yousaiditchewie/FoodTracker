//
//  RatingControl.swift
//  FoodTracker
//
//  Created by jacob on 7/6/19.
//  Copyright © 2019 jacob. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: Properties
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
    }
    
    // MARK: Private Methods
    
    private func setupButtons() {
        
        // Clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // Load button Images
        let bundle = Bundle(for: type(of: self))
        
        // I made this a little more DRY than the tutorial 😇
        func generateImage(imageName: String) -> UIImage {
            return UIImage(named: imageName, in: bundle, compatibleWith: self.traitCollection)!
        }
        
        let filledStar = generateImage(imageName: "filledStar")
        let emptyStar = generateImage(imageName: "emptyStar")
        let highlightedStar = generateImage(imageName: "highlightedStar")
        
        for _ in 0..<starCount {
        
            // Create the button
            let button = UIButton()
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add contstraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set up button action
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating buttons array
            ratingButtons.append(button)
        }
    }
    
}
