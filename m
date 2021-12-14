Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD2B474BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbhLNTQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:16:55 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:41833 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhLNTQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:16:54 -0500
Received: by mail-oo1-f41.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so5190268oos.8;
        Tue, 14 Dec 2021 11:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=89n65Un8cdRTY4y4wD+F3ML7dLYicStqDZBe3YLsEnU=;
        b=3LDLW0Vh3XUcgyrKEsXwIVdt3SJ3946Km/cu7KtINDmL52qMjykOxTPOk0rP6N9pv7
         dK24pHXwI/T1KxxZzDa7uaOVW0qCp3Hr4cQqSaMbX/4zo4mlKBBY4p+H9G2jl2R6sS7c
         IuC23Nf7hZzFcdQ1ExmORpwLGjppXnObe5R6ek0pA5v/DTSWTKGQzinABd7Fmw/eWgQn
         iwV+n+REcYRuAkYzHA8WDltqO7XDbDkOol/Gf7DfaVqrtMtel8iqEcZ+aeC3pyZY2bWC
         YUHrcDiQLrL63coSgSNKGAQI9ZOYmKg/DVIMECxjrEvjvGStg+K/8SylpsIGDlVKBVzy
         zV9Q==
X-Gm-Message-State: AOAM532UdzsUnPw8juIT5mj6iN64DEp5YAfDSMBs8JKNQkFzP8H8bLdH
        rIjwlqPSxbdsSx5TW++uBQ==
X-Google-Smtp-Source: ABdhPJyeCEbnQ7XaJPNry6GKTjo/HWhUc4nu6pM+aJJIYgeHF6KaJ85nlYancGJ9nuUHNIqHKd9Rng==
X-Received: by 2002:a4a:88cc:: with SMTP id q12mr4719066ooh.29.1639509413108;
        Tue, 14 Dec 2021 11:16:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o10sm140154oom.32.2021.12.14.11.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:16:52 -0800 (PST)
Received: (nullmailer pid 3751604 invoked by uid 1000);
        Tue, 14 Dec 2021 19:16:50 -0000
Date:   Tue, 14 Dec 2021 13:16:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v3 15/15] dt-bindings: usb: Convert BDC to YAML
Message-ID: <Ybjtoj8/wAllmxP5@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-16-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-16-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:37:26PM -0800, Florian Fainelli wrote:
> Convert the Broadcom BDC device controller Device Tree binding to YAML
> to help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/usb/brcm,bdc.txt      | 29 ------------
>  .../devicetree/bindings/usb/brcm,bdc.yaml     | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 47 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/brcm,bdc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/brcm,bdc.txt b/Documentation/devicetree/bindings/usb/brcm,bdc.txt
> deleted file mode 100644
> index c9f52b97cef1..000000000000
> --- a/Documentation/devicetree/bindings/usb/brcm,bdc.txt
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -Broadcom USB Device Controller (BDC)
> -====================================
> -
> -Required properties:
> -
> -- compatible: must be one of:
> -                "brcm,bdc-udc-v2"
> -                "brcm,bdc"
> -- reg: the base register address and length
> -- interrupts: the interrupt line for this controller
> -
> -Optional properties:
> -
> -On Broadcom STB platforms, these properties are required:
> -
> -- phys: phandle to one or two USB PHY blocks
> -        NOTE: Some SoC's have a single phy and some have
> -        USB 2.0 and USB 3.0 phys
> -- clocks: phandle to the functional clock of this block
> -
> -Example:
> -
> -        bdc@f0b02000 {
> -                compatible = "brcm,bdc-udc-v2";
> -                reg = <0xf0b02000 0xfc4>;
> -                interrupts = <0x0 0x60 0x0>;
> -                phys = <&usbphy_0 0x0>;
> -                clocks = <&sw_usbd>;
> -        };
> diff --git a/Documentation/devicetree/bindings/usb/brcm,bdc.yaml b/Documentation/devicetree/bindings/usb/brcm,bdc.yaml
> new file mode 100644
> index 000000000000..48831b62ab31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/brcm,bdc.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/brcm,bdc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom USB Device Controller (BDC)
> +
> +maintainers:
> +  - Al Cooper <alcooperx@gmail.com>
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bdc-udc-v2
> +          - brcm,bdc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +
> +  phys:
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"

Already has a type. And we've lost how many and what each one is.

> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        bdc@f0b02000 {

usb@...

> +                compatible = "brcm,bdc-udc-v2";
> +                reg = <0xf0b02000 0xfc4>;
> +                interrupts = <0x0 0x60 0x0>;
> +                phys = <&usbphy_0 0x0>;
> +                clocks = <&sw_usbd>;
> +        };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2109b6fe8ea3..b18c7fa42a4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3679,7 +3679,7 @@ M:	Al Cooper <alcooperx@gmail.com>
>  L:	linux-usb@vger.kernel.org
>  L:	bcm-kernel-feedback-list@broadcom.com
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/usb/brcm,bdc.txt
> +F:	Documentation/devicetree/bindings/usb/brcm,bdc.yaml
>  F:	drivers/usb/gadget/udc/bdc/
>  
>  BROADCOM BMIPS CPUFREQ DRIVER
> -- 
> 2.25.1
> 
> 
