Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DFD474A00
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhLNRr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:47:26 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:44620 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhLNRrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:47:25 -0500
Received: by mail-ot1-f46.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso21678793otj.11;
        Tue, 14 Dec 2021 09:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBOnaxzXfCDyZtrqhrW8rtGcUQ7HznDbf48Z3QQIJVI=;
        b=a0DiRELJ5iuqdh/1tIYpypUhBwhCdJ6ziiuTxS8bW+FA5nOpUXunWgVYrLoyXtbmio
         wHKE5s9VN3gi6D1TycGeN8FBrlEBlkSIHtSpjOmL8xbWhOhRDvvV0nbx+FzrZqp+38vh
         PfvCB2IMytVMI/u84u5zBRYr7vqVcCWy7fSKlAN8WJkNN3hbtunJ0Ie95aYJxJ22oKgm
         ZWvAt4y4TaNFnDM8VGOeTvbTGmSzUiP0QBhDqDZabGDXaVEE2efcefmi0F+0TjtTgGbT
         6aC/laOaJc701A7H9hjyKDjsQelyI2H7kYz8ttRrHDYWhsdXFa19SlIoaihs0gjyMw0y
         L2Tg==
X-Gm-Message-State: AOAM533GgNMxUrHixrh8xV1M1j70gfGrZ1IbniGvetzLKu1GcjV3y3Qa
        JIQm5uC7Rn0kZZhZoAhL3Q==
X-Google-Smtp-Source: ABdhPJymNqHOf+pzQ6TP5Ecr3rl8MlTkcaOtkQTwS98dn07H5PgHTQ7hiMxMjBWZBkxzUOOvW7CnYg==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr5462504otl.137.1639504044111;
        Tue, 14 Dec 2021 09:47:24 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h1sm99241oog.26.2021.12.14.09.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:47:23 -0800 (PST)
Received: (nullmailer pid 3618988 invoked by uid 1000);
        Tue, 14 Dec 2021 17:47:21 -0000
Date:   Tue, 14 Dec 2021 11:47:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-rtc@vger.kernel.org,
        Markus Mayer <mmayer@broadcom.com>, linux-mmc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        linux-pwm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-ide@vger.kernel.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Doug Berger <opendmb@gmail.com>, linux-usb@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Cooper <alcooperx@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 02/15] dt-bindings: reset: Convert Broadcom STB reset
 to YAML
Message-ID: <YbjYqYHR7i9XXAuH@robh.at.kernel.org>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
 <20211208003727.3596577-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208003727.3596577-3-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Dec 2021 16:37:13 -0800, Florian Fainelli wrote:
> Convert the Broadcom STB SW_INIT style reset controller binding to YAML.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/reset/brcm,brcmstb-reset.txt     | 27 -----------
>  .../bindings/reset/brcm,brcmstb-reset.yaml    | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.yaml
> 

Applied, thanks!
