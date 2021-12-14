Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B37474A55
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhLNSET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:04:19 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:33782 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhLNSEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:04:13 -0500
Received: by mail-oi1-f171.google.com with SMTP id q25so28358285oiw.0;
        Tue, 14 Dec 2021 10:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9hI2EmXHnui1ismThJSKFmhiVpetBd29iuU2vJbk3UE=;
        b=3Sg+lihSxYxYGzFHTnxVSGxrpl7oGvMZSUC8s3Y6NTFty2EFe/c4petHdFj9pAcvcO
         5fDUqRyzkVLlTaoTy4DVqtGyPfdgIN/gNlV0IXz0UeRAgn98F2Yw6ADF8L7ttWbPr8WE
         E905iJhkVqOC42UVi/GsdRz3HNwXPpCXPgTJRXsELi3tlSyb2V75IlhxW/r8QIf/WAsN
         DGihIXWNO2bYHFK9ueNwAmeQdz3VCi71QtVU3W6+5AS3jGH6+uS+RNaKvkk+6dmnzbsz
         QXefyXK6bV38widZNHZhW+5XshYHAWcOj/qx35FxcZLxAn55WrNHKo+3cxGk7oCBI80g
         HHqg==
X-Gm-Message-State: AOAM5325zUzQO/hUUn7SyS4dfNI2O8jEUnI0L8bWtx4Uiw2EPOkqdyQ4
        9wqOikq3N+pL3iupPAYloQ==
X-Google-Smtp-Source: ABdhPJxYJ6B9y+lYradhAM8Cs39zXalN9xut86nZ8NeK2AN1p0yWqZxIAk0xBcaxbFIJZa3LaAypAg==
X-Received: by 2002:aca:1c07:: with SMTP id c7mr34490624oic.133.1639505052816;
        Tue, 14 Dec 2021 10:04:12 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k4sm102058oij.54.2021.12.14.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:04:11 -0800 (PST)
Received: (nullmailer pid 3647417 invoked by uid 1000);
        Tue, 14 Dec 2021 18:04:10 -0000
Date:   Tue, 14 Dec 2021 12:04:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-crypto@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Al Cooper <alcooperx@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, linux-usb@vger.kernel.org,
        Doug Berger <opendmb@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ray Jui <rjui@broadcom.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Markus Mayer <mmayer@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 06/15] dt-binding: interrupt-controller: Convert
 BCM7038 L1 intc to YAML
Message-ID: <Ybjcmi3MlGOnOhK7@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-7-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-7-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:37:17 -0800, Florian Fainelli wrote:
> Convert the Broadcom STB BCM7038 Level 1 interrupt controller Device
> Tree binding to YAML to help with validation.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../brcm,bcm7038-l1-intc.txt                  | 61 -------------
>  .../brcm,bcm7038-l1-intc.yaml                 | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 61 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7038-l1-intc.yaml
> 

Applied, thanks!
