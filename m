Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3625046B579
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhLGISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:18:36 -0500
Received: from bzq-84-110-109-230.red.bezeqint.net ([84.110.109.230]:49891
        "EHLO mx.tkos.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232151AbhLGISf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:18:35 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2021 03:18:34 EST
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id E1A8A440855;
        Tue,  7 Dec 2021 10:06:08 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1638864370;
        bh=esweGkmM1TaFxAsLsotS7LKsL2FjaGbpG3oTnnMt2EY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=GcPgxTp47EJex9304Cwrh1a93q3dHMKWiHIjz8ZTn4NegGPU69yqh7Su5vmg5fO+P
         Kh7nqdgkBIpI3Rf9UzzHq/x7N7cBaA/7R0ZE12PQaFHPd0XT3nfMmWwSoc6YNW6HJ/
         sY7u4RIykgN0trrfVUJdtS/HSKo97dqJciT8yZxSr0wjGT9g5g4otk+PHV0JYm9p9k
         P9YzQWW8WWhUeig+fPqnm1HPGtUlIZxk5urZr4h4aKbE+4xA9oZm9Je0d93bTim8GN
         1As0GD0fgMDT/yrRdfvnw9AkNJRlBW1Fj0uJad+Crzam3J4mee0elu9epTaexUTQ7t
         Pqt45gjbFAkpw==
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
 <20211207080325.6hfokrrcs45iucx6@pengutronix.de>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-power@fi.rohmeurope.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
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
Subject: Re: [PATCH v1 1/3] gpio: Get rid of duplicate of_node assignment in
 the drivers
Date:   Tue, 07 Dec 2021 10:05:08 +0200
In-reply-to: <20211207080325.6hfokrrcs45iucx6@pengutronix.de>
Message-ID: <87ilw0on3z.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Tue, Dec 07 2021, Uwe Kleine-K=C3=B6nig wrote:
> Hello Andy,
>
> you Cc: linux-pwm and the pwm maintainers in this series. I don't spot
> anything pwm specific here (apart from touching gpio-mvebu which also
> contains a PWM driver). Do I miss something?

That's probably because of drivers/gpio/gpio-mvebu.c that appears in the
MAINTAINERS PWM entry.

baruch

--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
