Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB04791FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbhLQQyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbhLQQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:54:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16589C061746
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:54:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y12so10055026eda.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 08:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ty3idGCi5XDl9xKvErHWNjIC6p7/NuEe9TiwxcVy8Us=;
        b=u9I1oPvsJNdQBSYXsGSVFvOEzPGh8YHNrcZyV4Kd4Ux0b007WnOatjgAjtpO7ElHj+
         hGmuiwerkfDuIqCHLAo613SY2tvmSUxTdYM0wU8p9QmiQVr9m9JA3Naueo3Yfodz6PXK
         87Kghc+eG799moXmgTvzehIou/OBfRSxy6uKhrkhotiEqkh8JRKrsnfTTnYL5U6M1B7t
         FETyeoncmUeYZBM045702egEznZCU4GjmYR8491uENA8sjto4EZdTiZlL58Y1yKTVgEN
         CaZJ582PxifNLXiMmL7WreCUCgOo3GYwkOWTOTqbS20yiN2i6DT8eADFIDVoM7GOLwCY
         9cRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ty3idGCi5XDl9xKvErHWNjIC6p7/NuEe9TiwxcVy8Us=;
        b=WuPi/6JwZ1me86oXVN3zDYIeVbZ0x1e2WCTsqtQCtUU+YHp0y9lu4BQAiorsTVMLKY
         r5gtkYlK1N0x405Kv7L9gWyvI+dDrVRCP39o4/0rWcE7llH5jQ78N0E53EmxnSgjvsQN
         3ERX664d1kbJv5m+R9y8Pgis4xw4U0EujH1AF26jkvsiUJd9S9tqPUWyfbfAxaMSTG8t
         KbKIn5HndPlBlg126BUN5JStpFO2hP2IzeK31mQOyoym/773MA7WxBVK2ITBQl8Bnq4U
         OuaRPXBXYzqICyzEXQfY3HvmfPQM5oPAlaXjwoMMqGmWw4v/MghfR/oA5bQVcgIslIzH
         xL7g==
X-Gm-Message-State: AOAM532detxt+jN89xueYQf4oZHfz9euqZeamlZg1qEEigot3E3H2Qa/
        ayHxKZynwvLaybQq55mIQflFbl5oKG3tNLAqHhY8OA==
X-Google-Smtp-Source: ABdhPJx8NgewPvw8C9vg5xgAqhhQeH0jCc31PRQMmf/5wN37PHnQyAoHsmmMeZhdRGMORIs9EvU83ilcsDAuLWfaiLU=
X-Received: by 2002:a17:906:249a:: with SMTP id e26mr3225602ejb.492.1639760051506;
 Fri, 17 Dec 2021 08:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 17 Dec 2021 17:54:00 +0100
Message-ID: <CAMRc=Mct9FuYvT-0gFrpUuNBnCVdmCp_cNESkL5NSgVVP6vezQ@mail.gmail.com>
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
        <linux-mediatek@lists.infradead.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
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

Queued the series for next, thanks!

Bart
