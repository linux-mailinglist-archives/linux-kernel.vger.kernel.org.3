Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E216246735B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379246AbhLCIoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbhLCIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:44:31 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4CBC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 00:41:07 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x6so8501939edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 00:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLBHn9jsbKV7jZYY7Dm+t8lPDQRTZnoOfAaLgWh49GU=;
        b=LsIAHi4O7+rAKszJKyJ/QwZwolqgX7Xp85HCfWi/OAlf7oOjExVQVB3A1uF6oJMxXi
         gPosTZ3PyRq9IbJKMX4ESqDGYZZYcom4XQ8JtyMRl5tOE7xlwAkd4FpJbONadp6pWo7I
         oUoB99whrPg0HGUqiRetXBExiz97qDkf5NdxXb1GpetgxbWitUxWw81WWVuMwB7DeHg4
         F4fsE0Im8ySC6EvPdTGuYxXIdnTwT10W+OMVEHRanF7YSviRe6CvO4rDs/Sfax7qLy0G
         GQ8KIQPRWvs0w82uwlN5lRnk2skx92g4UPLasKF6asjvNdNubK/yYeFyTDsn7OcD+219
         BK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLBHn9jsbKV7jZYY7Dm+t8lPDQRTZnoOfAaLgWh49GU=;
        b=TCSCDO3nLY7tEK3N1GGr2CpxiU8CzT2ZD66L8rIUq96dRTEdRzl7Zzi3J8GP1SCPXB
         J9BmoQM4iXFFIoTwAPnEX3wPXA2D7Tjx2cqYf2tQhYkdPaRmxCx9GmYg4dJ6ramE0bOw
         M5mI89sOm/TC4V2Etb3T1O5g+9xUguvXnV91yeD982p60mfOAiZSPn+P+uV88d0nfepP
         8hShY49OOV2+b/J4w5Id9MrLzNcXFJEYn+/G8gl/vNM6pSYEURNYAzO0Frq5X0s3fWet
         FEmEMWrC9GoawnjPmPANRh2EPnlhZzijP9xysfAUvKStcsffLKCTMab8AaspL0n9+0OH
         klmg==
X-Gm-Message-State: AOAM532225YvRtM5LrI6BLfkqyZHZvfm4H0ElMho6Ae95md0tTYE/BVc
        74TcTEuAwKaygexBEDs1ZdkyzDBrndsjwCoFuLmSGg==
X-Google-Smtp-Source: ABdhPJzNHiauf+pMC5f/US+c9OIXcWbcKMNg90ABw6xCvQOgNu83JV2BIOiQy03TdGH6uVMTEr4y57dSuqO0jiYbpps=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr22268827ejc.77.1638520866276;
 Fri, 03 Dec 2021 00:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 3 Dec 2021 09:40:55 +0100
Message-ID: <CAMRc=Md-TKUETLzf41D2KeQODac153_AumMTW4928XfJ70GRxQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: Get rid of duplicate of_node assignment in
 the drivers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Thierry Reding <treding@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-unisoc@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Keerthy <j-keerthy@ti.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 10:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove these assignment all at once.
>
> For the details one may look into the of_gpio_dev_init() implementation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

I have a bad feeling about this but I've gone through the drivers in
this patch and it seems like you don't update any of the drivers that
use multiple child OF nodes so I can't really point out any obvious
bug.

I have another change I'm working on that's related, let me send it shortly.

Bart
