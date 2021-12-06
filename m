Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC54A469682
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244111AbhLFNQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:16:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:41243 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244041AbhLFNQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:16:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="236046871"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="236046871"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:13:01 -0800
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="604986568"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:12:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muDmW-002mwh-84;
        Mon, 06 Dec 2021 15:11:48 +0200
Date:   Mon, 6 Dec 2021 15:11:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Baruch Siach <baruch@tkos.co.il>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
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
Message-ID: <Ya4MFMWSyj4YbdNG@smile.fi.intel.com>
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZbpKqG_uS2N8TW2-HL5CqnuKDpHVCabf66MyQQof0jOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZbpKqG_uS2N8TW2-HL5CqnuKDpHVCabf66MyQQof0jOw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 01:06:07AM +0100, Linus Walleij wrote:
> On Thu, Dec 2, 2021 at 10:17 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > GPIO library does copy the of_node from the parent device of
> > the GPIO chip, there is no need to repeat this in the individual
> > drivers. Remove these assignment all at once.
> >
> > For the details one may look into the of_gpio_dev_init() implementation.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> This is definitely a patch in the right direction, as Bart says
> it can be a bit dangerous, the outliers are those drivers that
> assign the .dev to something completely different than the
> the dev where the of_node is copied from.

I carefully checked these all and this patch series is only for the cases
when I'm sure it's the same device, which is used as parent, and its of_node
supplied.

> The idea was definitely always to only assign it in the core
> *unless* there is a reason to have a completely different
> of_node for some reason.
> 
> > +++ b/drivers/gpio/gpio-rda.c
> > @@ -240,8 +240,6 @@ static int rda_gpio_probe(struct platform_device *pdev)
> >         rda_gpio->chip.label = dev_name(dev);
> >         rda_gpio->chip.ngpio = ngpios;
> >         rda_gpio->chip.base = -1;
> > -       rda_gpio->chip.parent = dev;
> > -       rda_gpio->chip.of_node = np;
> 
> Mention in the commit message that in this driver
> you also drop the the .parent assignment because the
> core will handle it.

Okay, I will update it. Also I'll update to the last codebase (dunno if Bart
is going to pull the IB from Lee where one of the drivers is gone: da53cc634cea
("gpio: bd70528 Drop BD70528 support").

-- 
With Best Regards,
Andy Shevchenko


