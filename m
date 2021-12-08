Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB246D4A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhLHNsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:48:10 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:37831 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbhLHNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:48:07 -0500
Received: by mail-oi1-f170.google.com with SMTP id bj13so4210216oib.4;
        Wed, 08 Dec 2021 05:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=AZBxD1twEMvgqXTIpZvt6tYC7fmZq91YhBKnG1gw4/g=;
        b=Ctio7YKmVOvmIo2alUmlLxrFwZj+5ThytJlAoYT5Eo2vB6Up7mCWUAWVCnSAqL1AoZ
         kUGHlUiaeCqqeS9NohO8VS8NukDe1VihtmfdtUlB1QWFhJtglT0HmZxTxxt/JcaNsm7Q
         lEVx6lDOYwfxLq5Mlh3nu4bGh+QPxTQ0JRYAAXSwL5AKWQWxQRxRAOh8D5N00O1ksmph
         TKWrv+sm79hKOoVTTgEI41xSQqy7ef4vaq+5UrJROGhJRiybacJx0Z4/szbp3zDzvS/m
         LVYgEtjjKcAWqtuD6QFftT8/nWm1uTf+sIMJR7XRxdL3Bbrp546bqDxwndZq3dy5ek+/
         RLWA==
X-Gm-Message-State: AOAM530Dv2Chsg2D8+cKegheS8aOl9Sniucup+UxiPFzPAHAipNcX8sf
        D5owCTKIxu2mCaglG/wWSA==
X-Google-Smtp-Source: ABdhPJw4CWIcu/zTZI0dRGziIGXUDpc471o4rTBw285IjDnHYfSE7mTOtDyDKGZQGTPSbpBTZ+LVug==
X-Received: by 2002:a05:6808:124d:: with SMTP id o13mr11998548oiv.91.1638971074539;
        Wed, 08 Dec 2021 05:44:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n189sm602044oif.33.2021.12.08.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:44:33 -0800 (PST)
Received: (nullmailer pid 3857736 invoked by uid 1000);
        Wed, 08 Dec 2021 13:44:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>, Amit Kucheria <amitk@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-usb@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-rtc@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org
In-Reply-To: <20211208003727.3596577-14-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com> <20211208003727.3596577-14-f.fainelli@gmail.com>
Subject: Re: [PATCH v3 13/15] dt-bindings: ata: Convert Broadcom SATA to YAML
Date:   Wed, 08 Dec 2021 07:44:28 -0600
Message-Id: <1638971068.770579.3857735.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:37:24 -0800, Florian Fainelli wrote:
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

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1565011


ahci@41000: $nodename:0: 'ahci@41000' does not match '^sata(@.*)?$'
	arch/arm/boot/dts/bcm958522er.dt.yaml
	arch/arm/boot/dts/bcm958525er.dt.yaml
	arch/arm/boot/dts/bcm958525xmc.dt.yaml
	arch/arm/boot/dts/bcm958622hr.dt.yaml
	arch/arm/boot/dts/bcm958623hr.dt.yaml
	arch/arm/boot/dts/bcm958625hr.dt.yaml
	arch/arm/boot/dts/bcm958625k.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
	arch/arm/boot/dts/bcm988312hr.dt.yaml

ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
	arch/arm/boot/dts/bcm958522er.dt.yaml
	arch/arm/boot/dts/bcm958525er.dt.yaml
	arch/arm/boot/dts/bcm958525xmc.dt.yaml
	arch/arm/boot/dts/bcm958622hr.dt.yaml
	arch/arm/boot/dts/bcm958623hr.dt.yaml
	arch/arm/boot/dts/bcm958625hr.dt.yaml
	arch/arm/boot/dts/bcm958625k.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
	arch/arm/boot/dts/bcm988312hr.dt.yaml

