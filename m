Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14759474A68
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbhLNSG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:06:59 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:38754 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLNSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:06:58 -0500
Received: by mail-oo1-f42.google.com with SMTP id w15-20020a4a9d0f000000b002c5cfa80e84so5149742ooj.5;
        Tue, 14 Dec 2021 10:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MiD7xUpDcRNWoT41V1AHd27dlViEpQzGo4jjYpcuCTg=;
        b=jyBeGkgacTlVNuwDC7pXwPND3FEo4/QbjuSPC5mkJp0+peyBE4RfLtBl74ukcAl9Hn
         QrkODPtGMujyBQnjvGuo97OPxgJhIv+MBdIEdpoMIZT40K+BYdhhu1fQDYpKh1N0SErg
         co5Pf9JFfWGBL/j68oskLyG8sxvLH3Wfv4sBLw8ZuOjCobsIvh6gUWL3hLuUPbv4Kb8d
         PSqduNrOlQT4UKbx2bFkWNd0TBdQkK+Ng3rK+FqHvk5/ih8fp51U270Ku6KR6kEbGnRv
         CajTNQ97AVc5xwfYWl1xzfdxF6351rrAWyMspcU1arQ1MtCuqvTPeNu+/L80QLB7aTiK
         /fpA==
X-Gm-Message-State: AOAM532Sfhvqfut9CYGoLUXp+V5zSFqZ+kAoJeaqGXvXurOXUJKEsN71
        VZjexkjrkz55B2amUKVdlQ==
X-Google-Smtp-Source: ABdhPJz7SI7Vj8m407kJe3fzvWkVvhKt/vVWfx8NKW5bPAlBLuytvepeIuN0sSHFQQZQViKILkdQ0Q==
X-Received: by 2002:a4a:c890:: with SMTP id t16mr4437296ooq.95.1639505217170;
        Tue, 14 Dec 2021 10:06:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d6sm102008otb.4.2021.12.14.10.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:06:56 -0800 (PST)
Received: (nullmailer pid 3651445 invoked by uid 1000);
        Tue, 14 Dec 2021 18:06:55 -0000
Date:   Tue, 14 Dec 2021 12:06:55 -0600
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
Subject: Re: [PATCH v3 07/15] dt-bindings: interrupt-controller: Convert
 BCM7120 L2 to YAML
Message-ID: <YbjdP8REzyf7oSQw@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-8-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-8-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:37:18PM -0800, Florian Fainelli wrote:
> Convert the Broadcom BCM7120 Level 2 interrupt controller Device Tree
> binding to YAML to help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../brcm,bcm7120-l2-intc.txt                  |  88 -------------
>  .../brcm,bcm7120-l2-intc.yaml                 | 123 ++++++++++++++++++
>  2 files changed, 123 insertions(+), 88 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
> deleted file mode 100644
> index addd86b6ca2f..000000000000
> --- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -Broadcom BCM7120-style Level 2 interrupt controller
> -
> -This interrupt controller hardware is a second level interrupt controller that
> -is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
> -platforms. It can be found on BCM7xxx products starting with BCM7120.
> -
> -Such an interrupt controller has the following hardware design:
> -
> -- outputs multiple interrupts signals towards its interrupt controller parent
> -
> -- controls how some of the interrupts will be flowing, whether they will
> -  directly output an interrupt signal towards the interrupt controller parent,
> -  or if they will output an interrupt signal at this 2nd level interrupt
> -  controller, in particular for UARTs
> -
> -- has one 32-bit enable word and one 32-bit status word
> -
> -- no atomic set/clear operations
> -
> -- not all bits within the interrupt controller actually map to an interrupt
> -
> -The typical hardware layout for this controller is represented below:
> -
> -2nd level interrupt line		Outputs for the parent controller (e.g: ARM GIC)
> -
> -0 -----[ MUX ] ------------|==========> GIC interrupt 75
> -          \-----------\
> -                       |
> -1 -----[ MUX ] --------)---|==========> GIC interrupt 76
> -          \------------|
> -                       |
> -2 -----[ MUX ] --------)---|==========> GIC interrupt 77
> -          \------------|
> -                       |
> -3 ---------------------|
> -4 ---------------------|
> -5 ---------------------|
> -7 ---------------------|---|===========> GIC interrupt 66
> -9 ---------------------|
> -10 --------------------|
> -11 --------------------/
> -
> -6 ------------------------\
> -                           |===========> GIC interrupt 64
> -8 ------------------------/
> -
> -12 ........................ X
> -13 ........................ X 		(not connected)
> -..
> -31 ........................ X
> -
> -Required properties:
> -
> -- compatible: should be "brcm,bcm7120-l2-intc"
> -- reg: specifies the base physical address and size of the registers
> -- interrupt-controller: identifies the node as an interrupt controller
> -- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> -  source, should be 1.
> -- interrupts: specifies the interrupt line(s) in the interrupt-parent controller
> -  node, valid values depend on the type of parent interrupt controller
> -- brcm,int-map-mask: 32-bits bit mask describing how many and which interrupts
> -  are wired to this 2nd level interrupt controller, and how they match their
> -  respective interrupt parents. Should match exactly the number of interrupts
> -  specified in the 'interrupts' property.
> -
> -Optional properties:
> -
> -- brcm,irq-can-wake: if present, this means the L2 controller can be used as a
> -  wakeup source for system suspend/resume.
> -
> -- brcm,int-fwd-mask: if present, a bit mask to configure the interrupts which
> -  have a mux gate, typically UARTs. Setting these bits will make their
> -  respective interrupt outputs bypass this 2nd level interrupt controller
> -  completely; it is completely transparent for the interrupt controller
> -  parent. This should have one 32-bit word per enable/status pair.
> -
> -Example:
> -
> -irq0_intc: interrupt-controller@f0406800 {
> -	compatible = "brcm,bcm7120-l2-intc";
> -	interrupt-parent = <&intc>;
> -	#interrupt-cells = <1>;
> -	reg = <0xf0406800 0x8>;
> -	interrupt-controller;
> -	interrupts = <0x0 0x42 0x0>, <0x0 0x40 0x0>;
> -	brcm,int-map-mask = <0xeb8>, <0x140>;
> -	brcm,int-fwd-mask = <0x7>;
> -};
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
> new file mode 100644
> index 000000000000..e0c6dce40d13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm7120-l2-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM7120-style Level 2 interrupt controller
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +description: >
> +  This interrupt controller hardware is a second level interrupt controller that
> +  is hooked to a parent interrupt controller: e.g: ARM GIC for ARM-based
> +  platforms. It can be found on BCM7xxx products starting with BCM7120.
> +
> +  Such an interrupt controller has the following hardware design:
> +
> +  - outputs multiple interrupts signals towards its interrupt controller parent
> +
> +  - controls how some of the interrupts will be flowing, whether they will
> +    directly output an interrupt signal towards the interrupt controller parent,
> +    or if they will output an interrupt signal at this 2nd level interrupt
> +    controller, in particular for UARTs
> +
> +  - has one 32-bit enable word and one 32-bit status word
> +
> +  - no atomic set/clear operations
> +
> +  - not all bits within the interrupt controller actually map to an interrupt
> +
> +  The typical hardware layout for this controller is represented below:
> +
> +  2nd level interrupt line		Outputs for the parent controller (e.g: ARM GIC)
> +
> +  0 -----[ MUX ] ------------|==========> GIC interrupt 75
> +            \-----------\
> +                         |
> +  1 -----[ MUX ] --------)---|==========> GIC interrupt 76
> +            \------------|
> +                         |
> +  2 -----[ MUX ] --------)---|==========> GIC interrupt 77
> +            \------------|
> +                         |
> +  3 ---------------------|
> +  4 ---------------------|
> +  5 ---------------------|
> +  7 ---------------------|---|===========> GIC interrupt 66
> +  9 ---------------------|
> +  10 --------------------|
> +  11 --------------------/
> +
> +  6 ------------------------\
> +                            |===========> GIC interrupt 64
> +  8 ------------------------/
> +
> +  12 ........................ X
> +  13 ........................ X 		(not connected)

space followed by tab.

> +  ..
> +  31 ........................ X
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm7120-l2-intc
> +
> +  reg:
> +    description: >
> +      Specifies the base physical address and size of the registers

That's every 'reg'. How many?

> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupts: true

No, how many and what are they if more than 1.

> +
> +  "brcm,int-map-mask":

No need for quotes.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: >
> +      32-bits bit mask describing how many and which interrupts are wired to
> +      this 2nd level interrupt controller, and how they match their respective
> +      interrupt parents. Should match exactly the number of interrupts
> +      specified in the 'interrupts' property.
> +
> +  brcm,irq-can-wake:
> +    type: boolean
> +    description: >
> +      If present, this means the L2 controller can be used as a wakeup source
> +      for system suspend/resume.
> +
> +  brcm,int-fwd-mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: >
> +      if present, a bit mask to configure the interrupts which have a mux gate,
> +      typically UARTs. Setting these bits will make their respective interrupt
> +      outputs bypass this 2nd level interrupt controller completely; it is
> +      completely transparent for the interrupt controller parent. This should
> +      have one 32-bit word per enable/status pair.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - interrupts
> +
> +examples:
> +  - |
> +    irq0_intc: interrupt-controller@f0406800 {
> +      compatible = "brcm,bcm7120-l2-intc";
> +      interrupt-parent = <&intc>;
> +      #interrupt-cells = <1>;
> +      reg = <0xf0406800 0x8>;
> +      interrupt-controller;
> +      interrupts = <0x0 0x42 0x0>, <0x0 0x40 0x0>;
> +      brcm,int-map-mask = <0xeb8>, <0x140>;
> +      brcm,int-fwd-mask = <0x7>;
> +    };
> -- 
> 2.25.1
> 
> 
