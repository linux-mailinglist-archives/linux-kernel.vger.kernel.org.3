Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9277A46BE7F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbhLGPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:01:59 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42771 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238379AbhLGPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:01:53 -0500
Received: by mail-oi1-f177.google.com with SMTP id n66so28109787oia.9;
        Tue, 07 Dec 2021 06:58:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+5Z+s+qZr/dqYuPrhwxEsfm4VoIv7raKxg2fSVPXZ1s=;
        b=xHQOICTa9TFDdai7dyn7nNyifSpUKGxOiCiW3C2SPZoYHQ+RXcnFJ9syWxKMqNP3dc
         nvj6KKiAphfkzpfoiy4y2YlBQ0P5a+03m4PnZ3xxho5SDcmoNTX1BU80dpRc0CwfvE1g
         Zl7f0yUp4174Or9MbhiaGVDyO6ehhjIKGoj2Q02m1SC33vwbDfDdwCoNAbgxlyjpUEWn
         6HJSkQptPRJY7vS9LnStrr8ph1AJNl/feYoHqnY+tEcd4uoCr277e3BoCyD0aD8We4Ok
         LfE479Ik4GyC7ZZcG4MtUTFgXyZhoLkvcUO8NvIx26+6Jtal82au5ONlY8S/swruJ1bD
         kCKw==
X-Gm-Message-State: AOAM5324MyjTZfuHjYcnkULfJZv3SzXU+xoBzPIEx1iVsJO8JQPsCvPZ
        jDMTFAdwkfIJxOxt3bnjoQ==
X-Google-Smtp-Source: ABdhPJyPQz8MGdEnpy+dfjpiUez2RQSbPKGqr/ncBa0qgl3Qa9MdN4Hom3+TzcbiAkTw6HJamzmPOA==
X-Received: by 2002:a54:4104:: with SMTP id l4mr5476582oic.17.1638889102302;
        Tue, 07 Dec 2021 06:58:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id be12sm3524103oib.50.2021.12.07.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:58:21 -0800 (PST)
Received: (nullmailer pid 5804 invoked by uid 1000);
        Tue, 07 Dec 2021 14:58:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-rtc@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Marc Zyngier <maz@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>, linux-pm@vger.kernel.org,
        Markus Mayer <mmayer@broadcom.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Zhang Rui <rui.zhang@intel.com>, linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-crypto@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Scott Branden <sbranden@broadcom.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <20211206182616.2089677-13-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com> <20211206182616.2089677-13-f.fainelli@gmail.com>
Subject: Re: [PATCH v2 12/14] dt-bindings: ata: Convert Broadcom SATA to YAML
Date:   Tue, 07 Dec 2021 08:58:10 -0600
Message-Id: <1638889090.722845.5803.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 10:26:14 -0800, Florian Fainelli wrote:
> Convert the Broadcom SATA3 AHCI controller Device Tree binding to YAML
> to help with validation.
> 
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/ata/brcm,sata-brcm.txt           | 45 ---------
>  .../bindings/ata/brcm,sata-brcm.yaml          | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 45 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1564108


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

ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'dma-coherent', 'sata-port@0', 'sata-port@1' were unexpected)
	arch/arm/boot/dts/bcm958522er.dt.yaml
	arch/arm/boot/dts/bcm958525er.dt.yaml
	arch/arm/boot/dts/bcm958525xmc.dt.yaml
	arch/arm/boot/dts/bcm958622hr.dt.yaml
	arch/arm/boot/dts/bcm958623hr.dt.yaml
	arch/arm/boot/dts/bcm958625hr.dt.yaml
	arch/arm/boot/dts/bcm958625k.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
	arch/arm/boot/dts/bcm988312hr.dt.yaml

ahci@41000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'sata-port@0', 'sata-port@1' were unexpected)
	arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml

sata@a000: compatible: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/bcm963138dvt.dt.yaml

