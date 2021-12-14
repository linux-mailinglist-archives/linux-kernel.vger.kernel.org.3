Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927AB474B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhLNTKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:10:41 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43639 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbhLNTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:10:40 -0500
Received: by mail-ot1-f41.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so21988085otu.10;
        Tue, 14 Dec 2021 11:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fxhxkz2aoYllAmdfG4616pgL5EaaxJAxwpcl6MIvTl0=;
        b=lYWi4SHlwCEFkR2PYwJ0hkeRR6CKKAEd27O/ei3RXZuJt9nG/Tcg2oAj5BuzISLsif
         /oulKgcKy5xNxClErx2+Gl+r/tJ+QckALDZLzfjl3UiL25qVZWLHmls/jGM2hkwV099V
         nCye69YOBKddKgakiC1SJhy6H5MdTlrQ3qYCa1ATiSDFM17pREw8viHnLkKa+th6IYW2
         2tJpQ/HZNXlQrrqO/BzKAuTuP93gr0MVP24lu/42bqsmSGuNAvOsVV0YxG6G4KRUjhxO
         V6a0RxZR1C9qxo3HY/vOaM+aBLxoO5Wllrt86Xb9C+Zc2iyr2HaSUfwbSfYWX0sl22TU
         bmyQ==
X-Gm-Message-State: AOAM530UWprJrTX6ddxtRNmMW/WFz0QUUjYTFlUdpQEdAH1fnTDyfZ71
        IWSSbcZb3HFkzPQ3jz3QdQ==
X-Google-Smtp-Source: ABdhPJwCUWSkJn72NBbr1bR0cPFzwBKb26YGLLV1cBTZ7fWHeLCqv486JywNBLLSPFL4EvCYXCVqow==
X-Received: by 2002:a9d:1726:: with SMTP id i38mr5644825ota.176.1639509039052;
        Tue, 14 Dec 2021 11:10:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x16sm134876otq.47.2021.12.14.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:10:37 -0800 (PST)
Received: (nullmailer pid 3743254 invoked by uid 1000);
        Tue, 14 Dec 2021 19:10:35 -0000
Date:   Tue, 14 Dec 2021 13:10:35 -0600
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
Subject: Re: [PATCH v3 13/15] dt-bindings: ata: Convert Broadcom SATA to YAML
Message-ID: <YbjsK50twTm0PWj9@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-14-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-14-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:37:24PM -0800, Florian Fainelli wrote:
> Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
> to help with validation.
> 
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/ata/brcm,sata-brcm.txt           | 45 ---------
>  .../bindings/ata/brcm,sata-brcm.yaml          | 98 +++++++++++++++++++
>  2 files changed, 98 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
> deleted file mode 100644
> index b9ae4ce4a0a0..000000000000
> --- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -* Broadcom SATA3 AHCI Controller
> -
> -SATA nodes are defined to describe on-chip Serial ATA controllers.
> -Each SATA controller should have its own node.
> -
> -Required properties:
> -- compatible         : should be one or more of
> -			"brcm,bcm7216-ahci"
> -			"brcm,bcm7425-ahci"
> -			"brcm,bcm7445-ahci"
> -			"brcm,bcm-nsp-ahci"
> -			"brcm,sata3-ahci"
> -			"brcm,bcm63138-ahci"
> -- reg                : register mappings for AHCI and SATA_TOP_CTRL
> -- reg-names          : "ahci" and "top-ctrl"
> -- interrupts         : interrupt mapping for SATA IRQ
> -
> -Optional properties:
> -
> -- reset: for "brcm,bcm7216-ahci" must be a valid reset phandle
> -  pointing to the RESCAL reset controller provider node.
> -- reset-names: for "brcm,bcm7216-ahci", must be "rescal".
> -
> -Also see ahci-platform.txt.
> -
> -Example:
> -
> -	sata@f045a000 {
> -		compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> -		reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
> -		reg-names = "ahci", "top-ctrl";
> -		interrupts = <0 30 0>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		sata0: sata-port@0 {
> -			reg = <0>;
> -			phys = <&sata_phy 0>;
> -		};
> -
> -		sata1: sata-port@1 {
> -			reg = <1>;
> -			phys = <&sata_phy 1>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> new file mode 100644
> index 000000000000..3e24f45c65af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/brcm,sata-brcm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom SATA3 AHCI Controller
> +
> +description:
> +  SATA nodes are defined to describe on-chip Serial ATA controllers.
> +  Each SATA controller should have its own node.
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +allOf:
> +  - $ref: sata-common.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm7216-ahci
> +          - const: brcm,sata3-ahci
> +      - items:
> +          - enum:
> +              - brcm,bcm7445-ahci
> +          - const: brcm,sata3-ahci
> +      - items:
> +          - enum:
> +              - brcm,bcm7425-ahci
> +          - const: brcm,sata3-ahci
> +      - items:
> +          - const: brcm,bcm-nsp-ahci
> +      - items:
> +          - enum:
> +              - brcm,bcm63138-ahci
> +          - const: brcm,sata3-ahci

Is there some reason this is not grouped into 2 oneOf entries? If not, I 
can fixup.

> +
> +  reg:
> +    minItems: 2
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: ahci
> +      - const: top-ctrl
> +
> +  interrupts: true

maxItems: 1 ?

> +
> +  dma-coherent: true
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - brcm,bcm7216-ahci
> +          - brcm,bcm63138-ahci
> +then:
> +  properties:
> +    resets:
> +      maxItems: 1
> +    reset-names:
> +      enum:
> +        - rescal
> +        - ahci
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sata@f045a000 {
> +        compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> +        reg = <0xf045a000 0xa9c>, <0xf0458040 0x24>;
> +        reg-names = "ahci", "top-ctrl";
> +        interrupts = <0 30 0>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        sata0: sata-port@0 {
> +            reg = <0>;
> +            phys = <&sata_phy 0>;
> +        };
> +
> +        sata1: sata-port@1 {
> +            reg = <1>;
> +            phys = <&sata_phy 1>;
> +        };
> +    };
> -- 
> 2.25.1
> 
> 
