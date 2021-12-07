Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC44246BE6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhLGPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:01:53 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:42929 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbhLGPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:01:49 -0500
Received: by mail-ot1-f53.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so18339311otv.9;
        Tue, 07 Dec 2021 06:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=qKYU7RahhB+pR8vQVfzVcVag502QdQMLxyNdGvE2daw=;
        b=Be8BSG4iikqo0jti6eTs+ebFJlmOULObTuL5JUZ7bKHBkgbh1WUI1Sk8Zl9OECnUsA
         KLIcp6MAW9kDzI20NIM/brR+DV7YtkoGM3T0lkoZNjOjmvwVX4hFZLjz6R3im00jvWB0
         tUrsVU3ZiCk2GvDYkjh5/jqc2vV/SaJmPs2din9N06zwSepFtsMa6knKAKXg44Oelrc5
         KRxLfKOLdslj6x3eeMzd6HcvjGihIQOuUgqjtoOITYyEDfa7X98TamUiVFtiwx12Shhq
         Q8wxRcPLNlx4vNc3lgy3yinzdgebYcxdnR2ofVwuHzZUSHbyAazU5rJLVPlvPMmMMTJC
         cE2Q==
X-Gm-Message-State: AOAM53154mnT6lUy3yH4EuAO/2e3B68Qns4hRYyWBumaVMrd5iUxe2CA
        VhQ57Glf9t/BwldUrqrbGQ==
X-Google-Smtp-Source: ABdhPJyYE5pmNsF0pLu5NUJNgDOTEC8MDLniUWmR0RgVVyGo6aPd5+BUcZ7eVNYaJVTXCG/mVKM0/w==
X-Received: by 2002:a9d:6855:: with SMTP id c21mr36846388oto.357.1638889097578;
        Tue, 07 Dec 2021 06:58:17 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s2sm2778290otr.69.2021.12.07.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:58:16 -0800 (PST)
Received: (nullmailer pid 5800 invoked by uid 1000);
        Tue, 07 Dec 2021 14:58:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Doug Berger <opendmb@gmail.com>,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-crypto@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Gregory Fong <gregory.0xf0@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Scott Branden <sbranden@broadcom.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-ide@vger.kernel.org,
        linux-pwm@vger.kernel.org
In-Reply-To: <20211206182616.2089677-6-f.fainelli@gmail.com>
References: <20211206182616.2089677-1-f.fainelli@gmail.com> <20211206182616.2089677-6-f.fainelli@gmail.com>
Subject: Re: [PATCH v2 05/14] dt-bindings: gpio: Convert Broadcom STB GPIO to YAML
Date:   Tue, 07 Dec 2021 08:58:10 -0600
Message-Id: <1638889090.698687.5799.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 10:26:07 -0800, Florian Fainelli wrote:
> Convert the Broadcom STB GPIO Device Tree binding to YAML to help with
> validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/gpio/brcm,brcmstb-gpio.txt       |  83 --------------
>  .../bindings/gpio/brcm,brcmstb-gpio.yaml      | 105 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 106 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1564132


gpio@4172c0: interrupts-extended: [[6, 6], [7, 5]] is too long
	arch/arm/boot/dts/bcm7445-bcm97445svmb.dt.yaml

