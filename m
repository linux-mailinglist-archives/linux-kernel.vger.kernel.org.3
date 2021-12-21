Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5423147C13E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbhLUOP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:15:27 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:41637 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhLUOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:15:26 -0500
Received: by mail-qt1-f171.google.com with SMTP id v22so12896286qtx.8;
        Tue, 21 Dec 2021 06:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=69nrdsWG73ElLKj9F0t0Q7UNqrFTsr84U6xlLpIyT+k=;
        b=xjFKmW8hVQlAPsYqxmCWzYFRrp5oVP9PplfOn2NNsYfg0FXAdkP77HWoJXds+waq38
         rG51zY/Kvclw6I7w1JNjGZL4nXFdua3gt2Hd0wm8QsMfFZ1Sgt+OLh7JN154NeCt1q+8
         mj+Px+Td6YFfb5c/XpIHYDh0AOm9jd+NEEzzB97f/qNtEt/kBVaVZJOZ/7Nyuy9tgGpp
         YZr3Nu2QzekMPcAOLE49BcAbXHBbICH1XnEsDLWF6gArp4+O9IjGuTCDhHxeRiF0oDIQ
         6XtvXJK83vZM+zZEJLzLrXREhkt7HIF4BmGMt0oyqv0eMJh1hy2RKzLiQHzRqS5AWmX5
         qkWw==
X-Gm-Message-State: AOAM530Tw5OrVvOqAs0pYFkP5UvAVqqGs8vP2RSiO1u6+DbGS5Yacac1
        Bc55r/KEYgfYo9mz5hV9xJMdmPbBtqnl
X-Google-Smtp-Source: ABdhPJyiqURoqojlQCIHW7gbE5+4gGnRcBu6ZZGRfPexQhP9AMipOIo4xUaJJVqjhq2UvhekQ4IwwA==
X-Received: by 2002:a05:622a:15c5:: with SMTP id d5mr2296603qty.227.1640096124824;
        Tue, 21 Dec 2021 06:15:24 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id v5sm495801qkp.126.2021.12.21.06.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:15:24 -0800 (PST)
Received: (nullmailer pid 1331994 invoked by uid 1000);
        Tue, 21 Dec 2021 14:15:22 -0000
Date:   Tue, 21 Dec 2021 10:15:22 -0400
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: regulator: palmas: Convert to
 json-schema
Message-ID: <YcHhev+2gnDt0dPt@robh.at.kernel.org>
References: <20211217170507.2843568-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217170507.2843568-1-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 06:05:02PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Texas Instruments Palmas bindings from the free-form text
> format to json-schema.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../clock/clk-palmas-clk32kg-clocks.txt       |  35 ----
>  .../bindings/clock/ti,palmas-clk32k.yaml      |  68 ++++++++
>  .../bindings/extcon/extcon-palmas.txt         |  22 ---
>  .../bindings/extcon/ti,palmas-usb-vid.yaml    |  65 ++++++++
>  .../devicetree/bindings/gpio/gpio-palmas.txt  |  27 ---
>  .../bindings/gpio/ti,palmas-gpio.yaml         |  53 ++++++
>  .../bindings/iio/adc/ti,palmas-gpadc.yaml     |  26 ++-
>  .../bindings/input/ti,palmas-pwrbutton.txt    |  35 ----
>  .../bindings/input/ti,palmas-pwrbutton.yaml   |  76 +++++++++
>  .../devicetree/bindings/mfd/palmas.txt        |  52 ------
>  .../devicetree/bindings/mfd/ti,palmas.yaml    | 117 +++++++++++++
>  .../bindings/pinctrl/pinctrl-palmas.txt       | 105 ------------
>  .../bindings/pinctrl/ti,palmas-pinctrl.yaml   | 154 ++++++++++++++++++
>  .../bindings/regulator/palmas-pmic.txt        |  89 ----------
>  .../bindings/regulator/ti,palmas-pmic.yaml    | 144 ++++++++++++++++
>  .../devicetree/bindings/rtc/rtc-palmas.txt    |  32 ----
>  .../bindings/rtc/ti,palmas-rtc.yaml           |  62 +++++++
>  17 files changed, 756 insertions(+), 406 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/clk-palmas-clk32kg-clocks.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,palmas-clk32k.yaml
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/ti,palmas-usb-vid.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/ti,palmas-gpio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
>  create mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,palmas.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,palmas-pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/palmas-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/ti,palmas-pmic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-palmas.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/clk-palmas-clk32kg-clocks.txt b/Documentation/devicetree/bindings/clock/clk-palmas-clk32kg-clocks.txt
> deleted file mode 100644
> index 4208886d834a..000000000000
> --- a/Documentation/devicetree/bindings/clock/clk-palmas-clk32kg-clocks.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -* Palmas 32KHz clocks *
> -
> -Palmas device has two clock output pins for 32KHz, KG and KG_AUDIO.
> -
> -This binding uses the common clock binding ./clock-bindings.txt.
> -
> -Required properties:
> -- compatible :	"ti,palmas-clk32kg" for clk32kg clock
> -		"ti,palmas-clk32kgaudio" for clk32kgaudio clock
> -- #clock-cells : shall be set to 0.
> -
> -Optional property:
> -- ti,external-sleep-control: The external enable input pins controlled the
> -	enable/disable of clocks.  The external enable input pins ENABLE1,
> -	ENABLE2 and NSLEEP. The valid values for the external pins are:
> -		PALMAS_EXT_CONTROL_PIN_ENABLE1 for ENABLE1 pin
> -		PALMAS_EXT_CONTROL_PIN_ENABLE2 for ENABLE2 pin
> -		PALMAS_EXT_CONTROL_PIN_NSLEEP for NSLEEP pin
> -	Option 0 or missing this property means the clock is enabled/disabled
> -	via register access and these pins do not have any control.
> -	The macros of external control pins for DTS is defined at
> -	dt-bindings/mfd/palmas.h
> -
> -Example:
> -	#include <dt-bindings/mfd/palmas.h>
> -	...
> -	palmas: tps65913@58 {
> -		...
> -		clk32kg: palmas_clk32k@0 {
> -			compatible = "ti,palmas-clk32kg";
> -			#clock-cells = <0>;
> -			ti,external-sleep-control = <PALMAS_EXT_CONTROL_PIN_NSLEEP>;
> -		};
> -		...
> -	};
> diff --git a/Documentation/devicetree/bindings/clock/ti,palmas-clk32k.yaml b/Documentation/devicetree/bindings/clock/ti,palmas-clk32k.yaml
> new file mode 100644
> index 000000000000..c24887e76481
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,palmas-clk32k.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ti,palmas-clk32k.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Palmas family of Power-Management ICs (clocks)
> +
> +maintainers:
> +  - Michael Turquette <mturquette@baylibre.com>
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +description:
> +  Palmas devices have two clock output pins for 32KHz, KG and KG_AUDIO. This binding uses the
> +  common clock binding ./clock-bindings.txt.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,palmas-clk32kg
> +      - ti,palmas-clk32kgaudio
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  ti,external-sleep-control:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      The external enable input pins controlled the enable/disable of clocks. The external enable
> +      input pins ENABLE1, ENABLE2 and NSLEEP. The valid values for the external pins are:
> +
> +        PALMAS_EXT_CONTROL_PIN_ENABLE1 for ENABLE1 pin
> +        PALMAS_EXT_CONTROL_PIN_ENABLE2 for ENABLE2 pin
> +        PALMAS_EXT_CONTROL_PIN_NSLEEP for NSLEEP pin
> +
> +      Option 0 or missing this property means the clock is enabled/disabled via register access
> +      and these pins do not have any control. The macros of external control pins for DTS are
> +      defined in dt-bindings/mfd/palmas.h.
> +    enum: [ 0, 1, 2, 3 ]
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/mfd/palmas.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      tps65913@58 {
> +        compatible = "ti,tps65913", "ti,palmas";
> +        reg = <0x58>;
> +
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +
> +        clk32k {
> +          compatible = "ti,palmas-clk32kg";
> +          #clock-cells = <0>;
> +          ti,external-sleep-control = <PALMAS_EXT_CONTROL_PIN_NSLEEP>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
> deleted file mode 100644
> index f61d5af44a27..000000000000
> --- a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -EXTCON FOR PALMAS/TWL CHIPS
> -
> -PALMAS USB COMPARATOR
> -Required Properties:
> - - compatible: should contain one of:
> -   * "ti,palmas-usb-vid".
> -   * "ti,twl6035-usb-vid".
> -   * "ti,palmas-usb" (DEPRECATED - use "ti,palmas-usb-vid").
> -   * "ti,twl6035-usb" (DEPRECATED - use "ti,twl6035-usb-vid").
> -
> -Optional Properties:
> - - ti,wakeup : To enable the wakeup comparator in probe
> - - ti,enable-id-detection: Perform ID detection. If id-gpio is specified
> -		it performs id-detection using GPIO else using OTG core.
> - - ti,enable-vbus-detection: Perform VBUS detection.
> - - id-gpio: gpio for GPIO ID detection. See gpio binding.
> - - debounce-delay-ms: debounce delay for GPIO ID pin in milliseconds.
> -
> -palmas-usb {
> -       compatible = "ti,twl6035-usb", "ti,palmas-usb";
> -       ti,wakeup;
> -};
> diff --git a/Documentation/devicetree/bindings/extcon/ti,palmas-usb-vid.yaml b/Documentation/devicetree/bindings/extcon/ti,palmas-usb-vid.yaml
> new file mode 100644
> index 000000000000..29cd9bd68676
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/ti,palmas-usb-vid.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/ti,palmas-usb-vid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Palmas family of Power-Management ICs (extcon)
> +
> +maintainers:
> +  - MyungJoo Ham <myungjoo.ham@samsung.com>
> +  - Chanwoo Choi <cw00.choi@samsung.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,palmas-usb-vid
> +      - const: ti,twl6035-usb-vid
> +      - const: ti,palmas-usb
> +        deprecated: true
> +      - const: ti,twl6035-usb
> +        deprecated: true
> +
> +  ti,wakeup:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: To enable the wakeup comparator in probe
> +
> +  ti,enable-id-detection:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Perform ID detection. If id-gpios is specified it performs id-detection using
> +      GPIO else using OTG core.
> +
> +  ti,enable-vbus-detection:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Perform VBUS detection.
> +
> +  id-gpios:
> +    description: GPIO for GPIO ID detection. See GPIO bindings.

maxItems: 1

> +
> +  debounce-delay-ms:
> +    description: debounce delay for GPIO ID pin in milliseconds
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@38 {
> +        compatible = "ti,tps65913", "ti,palmas";
> +        reg = <0x38>;
> +
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +
> +        palmas_usb {
> +          compatible = "ti,palmas-usb-vid";
> +          ti,wakeup;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-palmas.txt b/Documentation/devicetree/bindings/gpio/gpio-palmas.txt
> deleted file mode 100644
> index 08b5b52a3ae0..000000000000
> --- a/Documentation/devicetree/bindings/gpio/gpio-palmas.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -Palmas GPIO controller bindings
> -
> -Required properties:
> -- compatible:
> -  - "ti,palams-gpio" for palma series of the GPIO controller
> -  - "ti,tps80036-gpio" for Palma series device TPS80036.
> -  - "ti,tps65913-gpio" for palma series device TPS65913.
> -  - "ti,tps65914-gpio" for palma series device TPS65914.
> -- #gpio-cells : Should be two.
> -  - first cell is the gpio pin number
> -  - second cell is used to specify the gpio polarity:
> -      0 = active high
> -      1 = active low
> -- gpio-controller : Marks the device node as a GPIO controller.
> -
> -Note: This gpio node will be sub node of palmas node.
> -
> -Example:
> -	palmas: tps65913@58 {
> -		:::::::::::
> -		palmas_gpio: palmas_gpio {
> -			compatible = "ti,palmas-gpio";
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -		};
> -		:::::::::::
> -	};
> diff --git a/Documentation/devicetree/bindings/gpio/ti,palmas-gpio.yaml b/Documentation/devicetree/bindings/gpio/ti,palmas-gpio.yaml
> new file mode 100644
> index 000000000000..46cd30b5541a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/ti,palmas-gpio.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/ti,palmas-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Palmas family of Power-Management ICs (GPIO)
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,palmas-gpio
> +      - ti,tps80036-gpio
> +      - ti,tps65913-gpio
> +      - ti,tps65914-gpio
> +
> +  # from gpio.yaml
> +  gpio-controller: true
> +  "#gpio-cells": true
> +
> +allOf:
> +  - $ref: gpio.yaml
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@58 {
> +        compatible = "ti,tps65913", "ti,palmas";
> +        reg = <0x58>;
> +
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +
> +        palmas_gpio {
> +          compatible = "ti,palmas-gpio";
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
> index 7b895784e008..a1f4271b9aa6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
> @@ -70,16 +70,24 @@ required:
>  examples:
>    - |
>      #include <dt-bindings/clock/mt8183-clk.h>
> -    pmic {
> -        compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cels = <0>;
> +
> +      pmic@48 {
> +        compatible = "ti,palmas";
> +        reg = <0x48>;
> +
>          adc {
> -            compatible = "ti,palmas-gpadc";
> -            interrupts = <18 0
> -                          16 0
> -                          17 0>;
> -            #io-channel-cells = <1>;
> -            ti,channel0-current-microamp = <5>;
> -            ti,channel3-current-microamp = <10>;
> +          compatible = "ti,palmas-gpadc";
> +          interrupts = <18 0>,
> +                       <16 0>,
> +                       <17 0>;
> +          #io-channel-cells = <1>;
> +          ti,channel0-current-microamp = <5>;
> +          ti,channel3-current-microamp = <10>;
>          };
> +      };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
> deleted file mode 100644
> index c829e18e1a05..000000000000
> --- a/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -Texas Instruments Palmas family power button module
> -
> -This module is part of the Palmas family of PMICs. For more details
> -about the whole chip see:
> -Documentation/devicetree/bindings/mfd/palmas.txt.
> -
> -This module provides a simple power button event via an Interrupt.
> -
> -Required properties:
> -- compatible: should be one of the following
> -   - "ti,palmas-pwrbutton": For Palmas compatible power on button
> -- interrupts: Interrupt number of power button submodule on device.
> -
> -Optional Properties:
> -
> -- ti,palmas-long-press-seconds: Duration in seconds which the power
> -  button should be kept pressed for Palmas to power off automatically.
> -  NOTE: This depends on OTP support and POWERHOLD signal configuration
> -  on platform. Valid values are 6, 8, 10 and 12.
> -- ti,palmas-pwron-debounce-milli-seconds: Duration in milliseconds
> -  which the power button should be kept pressed for Palmas to register
> -  a press for debouncing purposes. NOTE: This depends on specific
> -  Palmas variation capability. Valid values are 15, 100, 500 and 1000.
> -
> -Example:
> -
> -&palmas {
> -	palmas_pwr_button: pwrbutton {
> -		compatible = "ti,palmas-pwrbutton";
> -		interrupt-parent = <&tps659038>;
> -		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> -		ti,palmas-long-press-seconds = <12>;
> -		ti,palmas-pwron-debounce-milli-seconds = <15>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml
> new file mode 100644
> index 000000000000..c248ed1d0e67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/ti,palmas-pwrbutton.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Palmas family of Power-Management ICs (power button)
> +
> +maintainers:
> +  - Nishanth Menon <nm@ti.com>
> +
> +description: |
> +  This module is part of the Palmas family of PMICs. For more details about the whole chip see:
> +
> +    Documentation/devicetree/bindings/mfd/palmas.txt
> +
> +  This module provides a simple power button event via an interrupt.
> +
> +properties:
> +  compatible:
> +    const: ti,palmas-pwrbutton
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Enables wake up of host system on power button press.
> +
> +  ti,palmas-long-press-seconds:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Duration in seconds which the power button should be kept pressed for Palmas to power off
> +      automatically.
> +
> +      NOTE: This depends on OTP support and POWERHOLD signal configuration on platform.
> +    enum: [ 6, 8, 10, 12 ]
> +
> +  ti,palmas-pwron-debounce-milli-seconds:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Duration in milliseconds which the power button should be kept pressed for Palmas to
> +      register a press for debouncing purposes. NOTE: This depends on specific Palmas variation
> +      capability.
> +    enum: [ 15, 100, 500, 1000 ]
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@48 {
> +        compatible = "ti,tps65913", "ti,palmas";
> +        reg = <0x48>;
> +
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +
> +        pwrbutton {
> +          compatible = "ti,palmas-pwrbutton";
> +          interrupt-parent = <&tps659038>;
> +          interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +          ti,palmas-long-press-seconds = <12>;
> +          ti,palmas-pwron-debounce-milli-seconds = <15>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/mfd/palmas.txt b/Documentation/devicetree/bindings/mfd/palmas.txt
> deleted file mode 100644
> index e736ab3012a6..000000000000
> --- a/Documentation/devicetree/bindings/mfd/palmas.txt
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -* palmas device tree bindings
> -
> -The TI palmas family current members :-
> -twl6035 (palmas)
> -twl6037 (palmas)
> -tps65913 (palmas)
> -tps65914 (palmas)
> -tps659038
> -tps65917
> -
> -Required properties:
> -- compatible : Should be from the list
> -  ti,twl6035
> -  ti,twl6036
> -  ti,twl6037
> -  ti,tps65913
> -  ti,tps65914
> -  ti,tps80036
> -  ti,tps659038
> -  ti,tps65917
> -and also the generic series names
> -  ti,palmas
> -- interrupt-controller : palmas has its own internal IRQs
> -- #interrupt-cells : should be set to 2 for IRQ number and flags
> -  The first cell is the IRQ number.
> -  The second cell is the flags, encoded as the trigger masks from
> -  Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -
> -Optional properties:
> -  ti,mux-padX : set the pad register X (1-2) to the correct muxing for the
> -		hardware, if not set will use muxing in OTP.
> -
> -Example:
> -
> -palmas {
> -	compatible = "ti,twl6035", "ti,palmas";
> -	reg = <0x48>
> -	interrupt-parent = <&intc>;
> -	interrupt-controller;
> -	#interrupt-cells = <2>;
> -
> -	ti,mux-pad1 = <0>;
> -	ti,mux-pad2 = <0>;
> -
> -	#address-cells = <1>;
> -	#size-cells = <0>;
> -
> -	pmic {
> -		compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> -		....
> -	};
> -}
> diff --git a/Documentation/devicetree/bindings/mfd/ti,palmas.yaml b/Documentation/devicetree/bindings/mfd/ti,palmas.yaml
> new file mode 100644
> index 000000000000..3d8c823bba13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,palmas.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,palmas.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Palmas family of Power-Management ICs
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,twl6035
> +          - ti,twl6036
> +          - ti,twl6037
> +          - ti,tps65913
> +          - ti,tps65914
> +          - ti,tps80036
> +          - ti,tps659038
> +          - ti,tps65917
> +      - const: ti,palmas
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller:
> +    description: The Palmas chip has its own internal IRQs.
> +
> +  "#interrupt-cells":
> +    description: The first cell is the IRQ number and the second cell is the flags, encoded as the
> +      trigger mask from ../interrupt-controller/interrupts.txt.
> +    const: 2
> +
> +  ti,mux-pad1:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Set the pad register 1 to the correct muxing for the hardware. Otherwise the
> +     muxing will be obtained from OTP.
> +
> +  ti,mux-pad2:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Set the pad register 2 to the correct muxing for the hardware. Otherwise the
> +     muxing will be obtained from OTP.
> +
> +  ti,power-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Specifies the value to program into the POWER_CTRL register.
> +
> +  ti,system-power-controller:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Specifies whether or not this PMIC is controlling the system power.
> +
> +  pinctrl:
> +    $ref: ../pinctrl/ti,palmas-pinctrl.yaml

Don't use relative paths. /schemas/pinctrl/...

> +
> +  pwrbutton:
> +    $ref: ../input/ti,palmas-pwrbutton.yaml
> +
> +  rtc:
> +    $ref: ../rtc/ti,palmas-rtc.yaml
> +
> +patternProperties:
> +  "^(palmas_)?adc$":
> +    $ref: ../iio/adc/ti,palmas-gpadc.yaml
> +
> +  "^(palmas_)?(clk32k|clk32kg|clk32kgaudio)$":
> +    $ref: ../clock/ti,palmas-clk32k.yaml
> +
> +  "^(palmas_)?gpio$":
> +    $ref: ../gpio/ti,palmas-gpio.yaml
> +
> +  "^(palmas_)?pinmux$":
> +    $ref: ../pinctrl/ti,palmas-pinctrl.yaml
> +
> +  "^(palmas_)?pmic$":
> +    $ref: ../regulator/ti,palmas-pmic.yaml
> +
> +  "^(palmas_)?usb$":
> +    $ref: ../extcon/ti,palmas-usb-vid.yaml
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@48 {
> +        compatible = "ti,twl6035", "ti,palmas";
> +        reg = <0x48>;
> +        interrupts = <16 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-parent = <&intc>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +
> +        ti,mux-pad1 = <0>;
> +        ti,mux-pad2 = <0>;
> +
> +        pmic {
> +          compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
> deleted file mode 100644
> index c28d4eb83b76..000000000000
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
> +++ /dev/null
> @@ -1,105 +0,0 @@
> -Palmas Pincontrol bindings
> -
> -The pins of Palmas device can be set on different option and provides
> -the configuration for Pull UP/DOWN, open drain etc.
> -
> -Required properties:
> -- compatible: It must be one of following:
> -  - "ti,palmas-pinctrl" for Palma series of the pincontrol.
> -  - "ti,tps65913-pinctrl" for Palma series device TPS65913.
> -  - "ti,tps80036-pinctrl" for Palma series device TPS80036.
> -
> -Please refer to pinctrl-bindings.txt in this directory for details of the
> -common pinctrl bindings used by client devices, including the meaning of the
> -phrase "pin configuration node".
> -
> -Palmas's pin configuration nodes act as a container for an arbitrary number of
> -subnodes. Each of these subnodes represents some desired configuration for a
> -list of pins. This configuration can include the mux function to select on
> -those pin(s), and various pin configuration parameters, such as pull-up,
> -open drain.
> -
> -The name of each subnode is not important; all subnodes should be enumerated
> -and processed purely based on their content.
> -
> -Each subnode only affects those parameters that are explicitly listed. In
> -other words, a subnode that lists a mux function but no pin configuration
> -parameters implies no information about any pin configuration parameters.
> -Similarly, a pin subnode that describes a pullup parameter implies no
> -information about e.g. the mux function.
> -
> -Optional properties:
> -- ti,palmas-enable-dvfs1: Enable DVFS1. Configure pins for DVFS1 mode.
> -	Selection primary or secondary function associated to I2C2_SCL_SCE,
> -	I2C2_SDA_SDO pin/pad for DVFS1 interface
> -- ti,palmas-enable-dvfs2: Enable DVFS2. Configure pins for DVFS2 mode.
> -	Selection primary or secondary function associated to GPADC_START
> -	and SYSEN2 pin/pad for DVFS2 interface
> -- ti,palmas-override-powerhold: This is applicable for PMICs for which
> -	GPIO7 is configured in POWERHOLD mode which has higher priority
> -	over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
> -	bit is turned off. This property enables driver to over ride the
> -	POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
> -	scenarios. So for GPIO7 if ti,palmas-override-powerhold is set
> -	then the GPIO_7 field should never be muxed to anything else.
> -	It should be set to POWERHOLD by default and only in case of
> -	power off scenarios the driver will over ride the mux value.
> -
> -This binding uses the following generic properties as defined in
> -pinctrl-bindings.txt:
> -
> -Required: pins
> -Options: function, bias-disable, bias-pull-up, bias-pull-down,
> -	 drive-open-drain.
> -
> -Note that many of these properties are only valid for certain specific pins.
> -See the Palmas device datasheet for complete details regarding which pins
> -support which functionality.
> -
> -Valid values for pin names are:
> -	gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpio7, gpio8, gpio9,
> -	gpio10, gpio11, gpio12, gpio13, gpio14, gpio15, vac, powergood,
> -	nreswarm, pwrdown, gpadc_start, reset_in, nsleep, enable1, enable2,
> -	int.
> -
> -Valid value of function names are:
> -	gpio, led, pwm, regen, sysen, clk32kgaudio, id, vbus_det, chrg_det,
> -	vac, vacok, powergood, usb_psel, msecure, pwrhold, int, nreswarm,
> -	simrsto, simrsti, low_vbat, wireless_chrg1, rcm, pwrdown, gpadc_start,
> -	reset_in, nsleep, enable.
> -
> -There are 4 special functions: opt0, opt1, opt2 and opt3. If any of these
> -functions is selected then directly pins register will be written with 0, 1, 2
> -or 3 respectively if it is valid for that pins or list of pins.
> -
> -Example:
> -	palmas: tps65913 {
> -		....
> -		pinctrl {
> -			compatible = "ti,tps65913-pinctrl";
> -			ti,palmas-enable-dvfs1;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&palmas_pins_state>;
> -
> -			palmas_pins_state: pinmux {
> -				gpio0 {
> -					pins = "gpio0";
> -					function = "id";
> -					bias-pull-up;
> -				};
> -
> -				vac {
> -					pins = "vac";
> -					function = "vacok";
> -					bias-pull-down;
> -				};
> -
> -				gpio5 {
> -					pins = "gpio5";
> -					function = "opt0";
> -					drive-open-drain = <1>;
> -				};
> -			};
> -		};
> -		....
> -	};
> diff --git a/Documentation/devicetree/bindings/pinctrl/ti,palmas-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ti,palmas-pinctrl.yaml
> new file mode 100644
> index 000000000000..63f3b858fd62
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/ti,palmas-pinctrl.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/ti,palmas-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Palmas family of Power-Management ICs (pin control)
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: The pins of Palmas device can be set on different option and provides the
> +  configuration for Pull UP/DOWN, open drain etc.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,palmas-pinctrl
> +      - ti,tps65913-pinctrl
> +      - ti,tps80036-pinctrl
> +
> +  ti,palmas-enable-dvfs1:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Enable DVFS1. Configure pins for DVFS1 mode. Selection primary or secondary
> +      function associated to I2C2_SCL_SCE, I2C2_SDA_SDO pin/pad for DVFS1 interface.
> +
> +  ti,palmas-enable-dvfs2:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Enable DVFS2. Configure pins for DVFS2 mode. Selection primary or secondary
> +      function associated to GPADC_START and SYSEN2 pin/pad for DVFS2 interface.
> +
> +  ti,palmas-override-powerhold:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: This is applicable for PMICs for which GPIO7 is configured in POWERHOLD mode
> +      which has higher priority over DEV_ON bit and keeps the PMIC supplies on even after the
> +      DEV_ON bit is turned off. This property enables driver to over ride the POWERHOLD value to
> +      GPIO7 so as to turn off the PMIC in power off scenarios. So for GPIO7 if
> +      ti,palmas-override-powerhold is set then the GPIO_7 field should never be muxed to anything
> +      else. It should be set to POWERHOLD by default and only in case of power off scenarios the
> +      driver will over ride the mux value.
> +
> +required:
> +  - compatible
> +
> +additionalProperties:
> +  type: object
> +  description: |
> +    Please refer to pinctrl-bindings.txt in this directory for details of the common pinctrl
> +    bindings used by client devices, including the meaning of the phrase "pin configuration node".
> +
> +    Palmas's pin configuration nodes act as a container for an arbitrary number of subnodes. Each
> +    of these subnodes represents some desired configuration for a list of pins. This configuration
> +    can include the mux function to select on those pin(s), and various pin configuration
> +    parameters, such as pull-up, open drain.
> +
> +  properties:
> +    phandle:
> +      $ref: /schemas/types.yaml#/definitions/uint32

Are you sure you still need this? I thought I fixed adding it 
automatically everywhere.

> +
> +  additionalProperties:
> +    type: object
> +    description: |
> +      The name of each subnode is not important; all subnodes should be enumerated and processed
> +      purely based on their content.
> +
> +      Each subnode only affects those parameters that are explicitly listed. In other words, a
> +      subnode that lists a mux function but no pin configuration parameters implies no information
> +      about any pin configuration parameters. Similarly, a pin subnode that describes a pullup
> +      parameter implies no information about e.g. the mux function.
> +
> +      Note that many of these properties are only valid for certain specific pins. See the Palmas
> +      device datasheet for complete details regarding which pins support which functionality.
> +
> +    properties:
> +      pins:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        items:
> +          enum: [ gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpio7, gpio8, gpio9, gpio10,
> +                  gpio11, gpio12, gpio13, gpio14, gpio15, vac, powergood, nreswarm, pwrdown,
> +                  gpadc_start, reset_in, nsleep, enable1, enable2, int ]
> +
> +      function:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: Note that the opt0, opt1, opt2 and opt3 functions are special and if any of
> +          these functions is selected then directly pins register will be written with 0, 1, 2 or 3,
> +          respectively, if the function is valid for that pin or list of pins.
> +        enum: [ gpio, led, pwm, regen, sysen, clk32kgaudio, id, vbus_det, chrg_det, vac, vacok,
> +                powergood, usb_psel, msecure, pwrhold, int, nreswarm, simrsto, simrsti, low_vbat,
> +                wireless_chrg1, rcm, pwrdown, gpadc_start, reset_in, nsleep, enable, opt0, opt1,
> +                opt2, opt3 ]
> +
> +      bias-disable:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: disable bias
> +
> +      bias-pull-up:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: pull-up bias
> +
> +      bias-pull-down:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: pull-down bias
> +
> +      drive-open-drain:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: configure for open drain
> +        enum: [ 0, 1 ]
> +
> +    additionalProperties: false
> +
> +    required:
> +      - pins
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@58 {
> +        compatible = "ti,tps65913", "ti,palmas";
> +        reg = <0x58>;
> +
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +
> +        pinctrl {
> +          compatible = "ti,tps65913-pinctrl";
> +          ti,palmas-enable-dvfs1;
> +          pinctrl-names = "default";
> +          pinctrl-0 = <&palmas_pins_state>;
> +
> +          palmas_pins_state: pinmux {
> +            gpio0 {
> +              pins = "gpio0";
> +              function = "id";
> +              bias-pull-up;
> +            };
> +
> +            vac {
> +              pins = "vac";
> +              function = "vacok";
> +              bias-pull-down;
> +            };
> +
> +            gpio5 {
> +              pins = "gpio5";
> +              function = "opt0";
> +              drive-open-drain = <1>;
> +            };
> +          };
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/regulator/palmas-pmic.txt b/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
> deleted file mode 100644
> index 84bc76a7c39e..000000000000
> --- a/Documentation/devicetree/bindings/regulator/palmas-pmic.txt
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -* palmas regulator IP block devicetree bindings
> -
> -The tps659038 for the AM57x class have OTP spins that
> -have different part numbers but the same functionality. There
> -is not a need to add the OTP spins to the palmas driver. The
> -spin devices should use the tps659038 as it's compatible value.
> -This is the list of those devices:
> -tps659037
> -
> -Required properties:
> -- compatible : Should be from the list
> -  ti,twl6035-pmic
> -  ti,twl6036-pmic
> -  ti,twl6037-pmic
> -  ti,tps65913-pmic
> -  ti,tps65914-pmic
> -  ti,tps65917-pmic
> -  ti,tps659038-pmic
> -and also the generic series names
> -  ti,palmas-pmic
> -- interrupts : The interrupt number and the type which can be looked up here:
> -	       arch/arm/boot/dts/include/dt-bindings/interrupt-controller/irq.h
> -- interrupts-name: The names of the individual interrupts.
> -
> -Optional properties:
> -- ti,ldo6-vibrator : ldo6 is in vibrator mode
> -
> -Optional nodes:
> -- regulators : Must contain a sub-node per regulator from the list below.
> -	       Each sub-node should contain the constraints and initialization
> -	       information for that regulator. See regulator.txt for a
> -	       description of standard properties for these sub-nodes.
> -	       Additional custom properties  are listed below.
> -
> -	       For ti,palmas-pmic - smps12, smps123, smps3 depending on OTP,
> -	       smps45, smps457, smps7 depending on variant, smps6, smps[8-9],
> -	       smps10_out2, smps10_out1, ldo[1-9], ldoln, ldousb.
> -
> -	       Optional sub-node properties:
> -	       ti,warm-reset - maintain voltage during warm reset(boolean)
> -	       ti,roof-floor - This takes as optional argument on platform supporting
> -	       the rail from desired external control. If there is no argument then
> -	       it will be assume that it is controlled by NSLEEP pin.
> -	       The valid value for external pins are:
> -			ENABLE1 then 1,
> -			ENABLE2 then 2 or
> -			NSLEEP then 3.
> -	       ti,mode-sleep - mode to adopt in pmic sleep 0 - off, 1 - auto,
> -	       2 - eco, 3 - forced pwm
> -	       ti,smps-range - OTP has the wrong range set for the hardware so override
> -	       0 - low range, 1 - high range.
> -
> -- ti,system-power-controller: Telling whether or not this pmic is controlling
> -			      the system power.
> -
> -Example:
> -
> -#include <dt-bindings/interrupt-controller/irq.h>
> -
> -pmic {
> -	compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> -	interrupt-parent = <&palmas>;
> -	interrupts = <14 IRQ_TYPE_NONE>;
> -	interrupts-name = "short-irq";
> -
> -	ti,ldo6-vibrator;
> -
> -	ti,system-power-controller;
> -
> -	regulators {
> -		smps12_reg : smps12 {
> -			regulator-name = "smps12";
> -			regulator-min-microvolt = < 600000>;
> -			regulator-max-microvolt = <1500000>;
> -			regulator-always-on;
> -			regulator-boot-on;
> -			ti,warm-reset;
> -			ti,roof-floor = <1>; /* ENABLE1 control */
> -			ti,mode-sleep = <0>;
> -			ti,smps-range = <1>;
> -		};
> -
> -		ldo1_reg: ldo1 {
> -			regulator-name = "ldo1";
> -			regulator-min-microvolt = <2800000>;
> -			regulator-max-microvolt = <2800000>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/regulator/ti,palmas-pmic.yaml b/Documentation/devicetree/bindings/regulator/ti,palmas-pmic.yaml
> new file mode 100644
> index 000000000000..da71e3ebcd32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/ti,palmas-pmic.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/ti,palmas-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Palmas family of PMICs regulator IP block
> +
> +maintainers:
> +  - Mark Brown <broonie@kernel.org>
> +
> +description: |
> +  The TPS659038 for the AM57x class have OTP spins that have different part numbers but the same
> +  functionality. There is not a need to add the OTP spins to the Palmas driver. The spin devices
> +  should use the TPS659038 as it's compatible value.
> +
> +  This is the list of those devices: tps659037
> +
> +definitions:

$defs instead.

> +  regulator:
> +    type: object
> +    properties:
> +      ti,warm-reset:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: maintain voltage during warm reset
> +
> +      ti,roof-floor:
> +        description: This takes as optional argument on platform supporting the rail from
> +          desired external control. If there is no argument then it will be assume that it is
> +          controlled by NSLEEP pin.
> +        oneOf:
> +          - $ref: /schemas/types.yaml#/definitions/flag
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +            #oneOf:
> +            #  - description: ENABLE1 pin
> +            #    const: 1
> +            #  - description: ENABLE2 pin
> +            #    const: 2
> +            #  - description: NSLEEP pin
> +            #    const: 3
> +
> +      ti,mode-sleep:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Mode to adopt in PMIC sleep.
> +        #oneOf:
> +        #  - description: off
> +        #    const: 0
> +        #  - description: auto
> +        #    const: 1
> +        #  - description: ECO
> +        #    const: 2
> +        #  - description: forced PWM
> +        #    const: 3
> +
> +      ti,smps-range:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: OTP has the wrong range set for the hardware so override
> +        #oneOf:
> +        #  - description: low range
> +        #    const: 0
> +        #  - description: high range
> +        #    const: 1
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,twl6035-pmic
> +          - ti,twl6036-pmic
> +          - ti,twl6037-pmic
> +          - ti,tps65913-pmic
> +          - ti,tps65914-pmic
> +          - ti,tps65917-pmic
> +          - ti,tps659038-pmic
> +      - const: ti,palmas-pmic
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,ldo6-vibrator:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Specifies whether LDO6 is in vibrator mode or not.
> +
> +  regulators:
> +    type: object
> +    description: |
> +      Must contain a sub-node per regulator from the list below. Each sub-node should contain the
> +      constraints and initialization information for that regulator. See regulator.txt for a
> +      description of standard properties for these sub-nodes. Additional custom properties are
> +      listed below.
> +
> +    patternProperties:
> +      "^smps(12|123|3|34|457|6|7|8|9|10_out1|10_out2)$":
> +        $ref: "#/definitions/regulator"
> +
> +      "^ldo[1-9]|ldoln|ldousb$":
> +        $ref: "#/definitions/regulator"
> +
> +patternProperties:
> +  "^smps(([1-9]|10)-in-)|(smps10-out2-)supply$":
> +    description: Input supply for the corresponding SMPS regulator.
> +
> +  "^ldo([1-9]|ln|usb)-in-supply$":
> +    description: Input supply for the corresponding LDO regulator.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmic {
> +      compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
> +      interrupt-parent = <&palmas>;
> +      interrupts = <14 IRQ_TYPE_NONE>;
> +      interrupts-name = "short-irq";
> +
> +      ti,ldo6-vibrator;
> +
> +      ti,system-power-controller;
> +
> +      regulators {
> +        smps12_reg: smps12 {
> +          regulator-name = "smps12";
> +          regulator-min-microvolt = < 600000>;
> +          regulator-max-microvolt = <1500000>;
> +          regulator-always-on;
> +          regulator-boot-on;
> +          ti,warm-reset;
> +          ti,roof-floor = <1>; /* ENABLE1 control */
> +          ti,mode-sleep = <0>;
> +          ti,smps-range = <1>;
> +        };
> +
> +        ldo1_reg: ldo1 {
> +          regulator-name = "ldo1";
> +          regulator-min-microvolt = <2800000>;
> +          regulator-max-microvolt = <2800000>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-palmas.txt b/Documentation/devicetree/bindings/rtc/rtc-palmas.txt
> deleted file mode 100644
> index c6cf37758a77..000000000000
> --- a/Documentation/devicetree/bindings/rtc/rtc-palmas.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -Palmas RTC controller bindings
> -
> -Required properties:
> -- compatible:
> -  - "ti,palmas-rtc" for palma series of the RTC controller
> -- interrupts: Interrupt number of RTC submodule on device.
> -
> -Optional properties:
> -
> -- ti,backup-battery-chargeable: The Palmas series device like TPS65913 or
> -	TPS80036 supports the backup battery for powering the RTC when main
> -	battery is removed or in very low power state. The backup battery
> -	can be chargeable or non-chargeable. This flag will tells whether
> -	battery is chargeable or not. If charging battery then driver can
> -	enable the charging.
> -- ti,backup-battery-charge-high-current: Enable high current charging in
> -	backup battery. Device supports the < 100uA and > 100uA charging.
> -	The high current will be > 100uA. Absence of this property will
> -	charge battery to lower current i.e. < 100uA.
> -
> -Example:
> -	palmas: tps65913@58 {
> -		...
> -		palmas_rtc: rtc {
> -			compatible = "ti,palmas-rtc";
> -			interrupt-parent = <&palmas>;
> -			interrupts = <8 0>;
> -			ti,backup-battery-chargeable;
> -			ti,backup-battery-charge-high-current;
> -		};
> -		...
> -	};
> diff --git a/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml b/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> new file mode 100644
> index 000000000000..f236385d5d66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ti,palmas-rtc.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/ti,palmas-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Palmas family of Power-Management ICs (RTC)
> +
> +maintainers:
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +
> +properties:
> +  compatible:
> +    const: ti,palmas-rtc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,backup-battery-chargeable:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: The Palmas series device like TPS65913 or TPS80036 supports the backup battery
> +      for powering the RTC when main battery is removed or in very low power state. The backup
> +      battery can be chargeable or non-chargeable. This flag will tells whether battery is
> +      chargeable or not. If charging battery then driver can enable the charging.
> +
> +  ti,backup-battery-charge-high-current:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Enable high current charging in backup battery. Device supports the < 100uA and >
> +      100uA charging. The high current will be > 100uA. Absence of this property will charge
> +      battery to lower current i.e. < 100uA.
> +
> +allOf:
> +  - $ref: rtc.yaml
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - interrupts
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      tps65913@58 {

pmic@58

Though I prefer if we just have 1 example in the MFD binding instead of 
these partial ones scattered about.

> +        compatible = "ti,tps65913", "ti,palmas";
> +        reg = <0x58>;
> +
> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +
> +        rtc {
> +          compatible = "ti,palmas-rtc";
> +          interrupt-parent = <&palmas>;
> +          interrupts = <8 0>;
> +          ti,backup-battery-chargeable;
> +          ti,backup-battery-charge-high-current;
> +        };
> +      };
> +    };
> -- 
> 2.34.1
> 
> 
