Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9306B46C677
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbhLGVQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:16:28 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:36378 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241674AbhLGVQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:16:27 -0500
Received: by mail-oo1-f53.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so150808oof.3;
        Tue, 07 Dec 2021 13:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eo21eWMJN2rAZ8++LaOblIQsug85M+gQqpl2yK+WXkc=;
        b=eU//mVAAFa68im6fi3kaxrc5iw2/bTHpiduVWcFNbSwioN6X5gttzt0CasnKzaLD8/
         mpyosxrSK/ZUf+revY6kEs5Dga6OdlXsTqdia9qe2H8dG3sGbsPRPrk9EQ/gm8yw0wJQ
         1DJVcWhUrJ1l+0VSEkAzdWyuDvC2JVFA+AtYXla1WV0XRrSfi55UGlX30Ca0E8zZ2CHt
         QLw4PSjRj8boI6moES9ADO2teNgOl0K/r0xh6DqVEB0fbLnnUI8CnWcUe7VcBCYUHnln
         iCcZ03uG6PaPu2JeZMBPvWNT7Za7sAZKGr4ShIdrF0joB6a5gxbaWVmhnCFDZ4ce/IJM
         b0PA==
X-Gm-Message-State: AOAM530bFgoowAIOc8+uz/JoauCnXzDJ/fwRed4njm0nM3K7RHyc7QCt
        kcWPY/XI3jktgEEnIjWN0w==
X-Google-Smtp-Source: ABdhPJzITAt2Uteo8b4ECbO9D7wITz3gthziIwEy57cAREbwksMIjJf2ZMfadsjoEfS3ebc9LabV/g==
X-Received: by 2002:a4a:af02:: with SMTP id w2mr28825840oon.7.1638911575927;
        Tue, 07 Dec 2021 13:12:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l6sm138044otu.12.2021.12.07.13.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:12:55 -0800 (PST)
Received: (nullmailer pid 839945 invoked by uid 1000);
        Tue, 07 Dec 2021 21:12:54 -0000
Date:   Tue, 7 Dec 2021 15:12:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        ~okias/devicetree@lists.sr.ht, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: pwm-vibrator: Convert txt bindings
 to yaml
Message-ID: <Ya/OVqLj5gbkBpuj@robh.at.kernel.org>
References: <20211127130941.38684-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127130941.38684-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 02:09:40PM +0100, David Heidelberg wrote:
> Converts txt binding to new YAML format and simplify example.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/input/pwm-vibrator.txt           | 66 -------------------
>  .../bindings/input/pwm-vibrator.yaml          | 59 +++++++++++++++++
>  2 files changed, 59 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.txt b/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> deleted file mode 100644
> index 88c775a3fe21..000000000000
> --- a/Documentation/devicetree/bindings/input/pwm-vibrator.txt
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -* PWM vibrator device tree bindings
> -
> -Registers a PWM device as vibrator. It is expected, that the vibrator's
> -strength increases based on the duty cycle of the enable PWM channel
> -(100% duty cycle meaning strongest vibration, 0% meaning no vibration).
> -
> -The binding supports an optional direction PWM channel, that can be
> -driven at fixed duty cycle. If available this is can be used to increase
> -the vibration effect of some devices.
> -
> -Required properties:
> -- compatible: should contain "pwm-vibrator"
> -- pwm-names: Should contain "enable" and optionally "direction"
> -- pwms: Should contain a PWM handle for each entry in pwm-names
> -
> -Optional properties:
> -- vcc-supply: Phandle for the regulator supplying power
> -- direction-duty-cycle-ns: Duty cycle of the direction PWM channel in
> -                           nanoseconds, defaults to 50% of the channel's
> -			   period.
> -
> -Example from Motorola Droid 4:
> -
> -&omap4_pmx_core {
> -	vibrator_direction_pin: pinmux_vibrator_direction_pin {
> -		pinctrl-single,pins = <
> -		OMAP4_IOPAD(0x1ce, PIN_OUTPUT | MUX_MODE1) /* dmtimer8_pwm_evt (gpio_27) */
> -		>;
> -	};
> -
> -	vibrator_enable_pin: pinmux_vibrator_enable_pin {
> -		pinctrl-single,pins = <
> -		OMAP4_IOPAD(0X1d0, PIN_OUTPUT | MUX_MODE1) /* dmtimer9_pwm_evt (gpio_28) */
> -		>;
> -	};
> -};
> -
> -/ {
> -	pwm8: dmtimer-pwm {
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vibrator_direction_pin>;
> -
> -		compatible = "ti,omap-dmtimer-pwm";
> -		#pwm-cells = <3>;
> -		ti,timers = <&timer8>;
> -		ti,clock-source = <0x01>;
> -	};
> -
> -	pwm9: dmtimer-pwm {
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vibrator_enable_pin>;
> -
> -		compatible = "ti,omap-dmtimer-pwm";
> -		#pwm-cells = <3>;
> -		ti,timers = <&timer9>;
> -		ti,clock-source = <0x01>;
> -	};
> -
> -	vibrator {
> -		compatible = "pwm-vibrator";
> -		pwms = <&pwm9 0 1000000000 0>,
> -                       <&pwm8 0 1000000000 0>;
> -		pwm-names = "enable", "direction";
> -		direction-duty-cycle-ns = <1000000000>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/input/pwm-vibrator.yaml b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> new file mode 100644
> index 000000000000..ec2466c63fe6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pwm-vibrator.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/input/pwm-vibrator.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: PWM vibrator
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description: >
> +  Registers a PWM device as vibrator. It is expected, that the vibrator's
> +  strength increases based on the duty cycle of the enable PWM channel
> +  (100% duty cycle meaning strongest vibration, 0% meaning no vibration).
> +
> +  The binding supports an optional direction PWM channel, that can be
> +  driven at fixed duty cycle. If available this is can be used to increase
> +  the vibration effect of some devices.
> +
> +properties:
> +  compatible:
> +    const: pwm-vibrator
> +
> +  pwm-names:
> +    anyOf:
> +      - items:
> +          - const: enable
> +      - items:
> +          - const: enable
> +          - const: direction

This can be expressed with just the 2nd entry and 'minItems: 1'.

> +
> +  pwms:
> +    minItems: 1
> +    maxItems: 2
> +
> +  vcc-supply: true
> +
> +  direction-duty-cycle-ns:
> +    description: >
> +      Duty cycle of the direction PWM channel in nanoseconds,
> +      defaults to 50% of the channel's period.
> +
> +required:
> +  - compatible
> +  - pwm-names
> +  - pwms
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    vibrator {
> +        compatible = "pwm-vibrator";
> +        pwms = <&pwm9 0 1000000000 0>,
> +               <&pwm8 0 1000000000 0>;
> +        pwm-names = "enable", "direction";
> +        direction-duty-cycle-ns = <1000000000>;
> +    };
> -- 
> 2.33.0
> 
> 
