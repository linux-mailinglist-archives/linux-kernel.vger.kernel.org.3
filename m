Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ADB4640CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhK3V4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:56:46 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35664 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhK3V4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:56:42 -0500
Received: by mail-oi1-f175.google.com with SMTP id m6so44149236oim.2;
        Tue, 30 Nov 2021 13:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5X/Qql5hBDqUfsZtv3GduzHLE5CLmP1qNPAKyjU+Zyo=;
        b=rgJOuCPR24yr4SN/SAQq4aEPB/n/ALKBR5jiTLPfEWEbcTK2vg4AZt6IVfI5JeT3eh
         w9DoQvyA2rlHQanl82fmyud3Xjcm77cObFNvyI0Gg7VZb4IVvhkwDD0yhD9t9QIoymTB
         UUTGKaFLgQaILDX1YuZre4fiiF6ofjx3XQRMLVPPm9P56gauxKAwDTFeIY5UVvl51+uM
         Lmc0A3wPt+UvuoxrA9hO5kr3RewyDMFml86AW4NW7aPL9Z+XZrDFAm+cRr53q5P0H2QW
         h1a/o78eqNHUpesy8pEnsbX3Rr+hG5HuY0TKlLC4ak+JNEfSSMO+7NaMNr2Zc2RcL6+f
         DCHA==
X-Gm-Message-State: AOAM530hO8ciR4KF6hzWk1iVjHAGZhAaeC0Nw0+qAPWSZIIKJ8kb9dSq
        X1WNRjH+UI/RHQ0GUdVY5KGdyjkvDA==
X-Google-Smtp-Source: ABdhPJzZPwVGLLWW4rzxtmvJn17EbkQQR9aplJI0CjgjOvVJCAglxbO4FXMk3Jh6aQ57EXjbN458Gw==
X-Received: by 2002:aca:2207:: with SMTP id b7mr1841263oic.24.1638309202706;
        Tue, 30 Nov 2021 13:53:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t14sm3396442oth.81.2021.11.30.13.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:53:22 -0800 (PST)
Received: (nullmailer pid 3076551 invoked by uid 1000);
        Tue, 30 Nov 2021 21:53:21 -0000
Date:   Tue, 30 Nov 2021 15:53:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt: bindings: KTD20xx: Introduce the ktd20xx
 family of RGB drivers
Message-ID: <YaadUU6bd9pradbQ@robh.at.kernel.org>
References: <20211123101826.9069-1-fe@dev.tdt.de>
 <20211123101826.9069-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123101826.9069-3-fe@dev.tdt.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:18:26AM +0100, Florian Eckert wrote:
> Introduce the bindings for the Kinetic KTD2061/58/59/60RGB LED device
> driver. The KTD20xx can control RGB LEDs individually or as part of a
> control bank group.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  .../bindings/leds/leds-ktd20xx.yaml           | 123 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml b/Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml
> new file mode 100644
> index 000000000000..b10b5fd507db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-ktd20xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LED driver for KTD20xx RGB LED from Kinetic.
> +
> +maintainers:
> +  - Florian Eckert <fe@dev.tdt.de>
> +
> +description: |
> +  The KTD20XX is multi-channel, I2C RGB LED Drivers that can group RGB LEDs into
> +  a LED group or control them individually.
> +
> +  The difference in these RGB LED drivers is I2C address number the device is
> +  listen on.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - kinetic,ktd20xx
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      I2C slave address
> +      ktd2061/58/59/60 0x68 0x69 0x6A 0x6B
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  'kinetic,color-current0':
> +    description:
> +      Specifies the current selection for the RGB color0.
> +      Value 1 must be the current value for the color red.
> +      Value 2 must be the current value for the color green.
> +      Value 3 must be the current value for the color blue.
> +      The current setting range is from 0mA to 24mA with 125uA steps.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    items:
> +      - minItems: 3
> +      - maxItems: 3

You've defined a 2x3 matrix. I think you want something like:

items:
  - description: current value for the color red
  - description: current value for the color green
  - description: current value for the color blue
  

> +
> +  'kinetic,color-current1':
> +    description:
> +      Specifies the current selection for the RGB color0.

color1? 

> +      Value 1 must be the current value for the color red.
> +      Value 2 must be the current value for the color green.
> +      Value 3 must be the current value for the color blue.
> +      The current setting range is from 0mA to 24mA with 125uA steps.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    items:
> +      - minItems: 3
> +      - maxItems: 3
> +
> +patternProperties:
> +  '^multi-led@[0-9a-f]$':
> +    type: object
> +    allOf:

Don't need 'allOf'.

> +      - $ref: leds-class-multicolor.yaml#
> +    properties:
> +      reg:
> +        minItems: 1
> +        maxItems: 12
> +        description:
> +          This property denotes the LED module number(s) that is used on the
> +          for the child node.

blank line.

> +      'kinetic,color-selection':
> +        description:
> +          Specifies the color selection for this LED.
> +          Value 1 selects the color register for color red.
> +          Value 2 selects the color register for color green.
> +          Value 3 selects the color register for color blue.
> +          The value can be either 0 or 1. If 0, the current for the color
> +          from color register 0 is used. If 1, the current for the color
> +          from color register 1 is used.
> +     $ref: /schemas/types.yaml#/definitions/uint8-array
> +     items:

Indentation is wrong. That should be an error...

> +       - minItems: 3
> +       - maxItems: 3
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/leds/common.h>
> +
> +   i2c {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       led-controller@14 {
> +           compatible = "ti,lp5009";

Not the right compatible.

> +           reg = <0x14>;
> +           #address-cells = <1>;
> +           #size-cells = <0>;
> +           color-current0 = [ 00 00 00 ] // Current for RGB is 0mA
> +           color-current1 = [ 28 28 28 ] // Current for RGB is 5mA

If these are already used for other bindings, then reuse the same 
property names.

> +
> +           multi-led@0 {
> +               reg = <0x0>;
> +               color = <LED_COLOR_ID_RGB>;
> +               function = LED_FUNCTION_CHARGING;
> +                kinetic,color-selection = [ 00 01 00 ]; // Red=0mA Green=5mA Blue=0mA
> +          };
> +
> +          multi-led@2 {
> +            reg = <0x2>;
> +            color = <LED_COLOR_ID_RGB>;
> +            function = LED_FUNCTION_STANDBY;
> +         };
> +       };

Fix the indentation.

> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 736d564f7e93..125bae48c2d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10607,6 +10607,7 @@ KTD20XX LED CONTROLLER DRIVER
>  M:	Florian Eckert <fe@dev.tdt.de>
>  L:	linux-leds@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/leds/leds-ktd20xx.yaml
>  F:	drivers/leds/leds-ktd20xx.c
>  
>  KTEST
> -- 
> 2.20.1
> 
> 
