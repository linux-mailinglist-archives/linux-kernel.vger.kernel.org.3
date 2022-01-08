Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30C48807C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiAHBZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:25:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53170 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiAHBZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:25:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE5362067;
        Sat,  8 Jan 2022 01:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1213C36AEB;
        Sat,  8 Jan 2022 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641605115;
        bh=v1vebky/9GnLagkGynvqtgjDpMQBlowovWEx91dudUY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mRLHPB4X3kKqnucf9F9fRj4EXY+Y4mtUwNFWFobH1SHDxgJ/VSLFRxeToOYkKxqbe
         ajOZBSlMV+BCTSb7kmQ3akR2Xw3qobBsPb86Ma9or+o+lJbwYiEwHfD2di9U2RDy6z
         eFemUPkYzlRBn/zbDyuHNz9+6JwYLELybr9PrtyNANGXbGQeY/o2sDLvbEM1FYe9Ng
         1NA/0xHiBSlxfmPJNgLa8Oq9jog4PS4nrLlnb7oDiNLojhf3urnO2LotFWx2Y822Nu
         huBGfOr1akH7vayogXJcMNODYfz80t9DkhdAdPIEFKfSH+2+ztm4o96cjsQ5Ljh11p
         s+F7ygQjNjeIQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220102165730.50190-3-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com> <20220102165730.50190-3-romain.perier@gmail.com>
Subject: Re: [PATCH v2 2/9] clk: mstar: msc313 cpupll clk driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Fri, 07 Jan 2022 17:25:14 -0800
User-Agent: alot/0.9.1
Message-Id: <20220108012515.D1213C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Romain Perier (2022-01-02 08:57:23)
> diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
> index de37e1bce2d2..a44ca2b180ff 100644
> --- a/drivers/clk/mstar/Kconfig
> +++ b/drivers/clk/mstar/Kconfig
> @@ -7,3 +7,10 @@ config MSTAR_MSC313_MPLL
>         help
>           Support for the MPLL PLL and dividers block present on
>           MStar/Sigmastar SoCs.
> +
> +config MSTAR_MSC313_CPUPLL

Can this file be sorted on Kconfig name?

> +       bool "MStar CPUPLL driver"
> +       depends on ARCH_MSTARV7 || COMPILE_TEST
> +       default ARCH_MSTARV7
> +       help
> +         Support for the CPU PLL present on MStar/Sigmastar SoCs.
> diff --git a/drivers/clk/mstar/Makefile b/drivers/clk/mstar/Makefile
> index f8dcd25ede1d..9f05b73a0619 100644
> --- a/drivers/clk/mstar/Makefile
> +++ b/drivers/clk/mstar/Makefile
> @@ -4,3 +4,4 @@
>  #
> =20
>  obj-$(CONFIG_MSTAR_MSC313_MPLL) +=3D clk-msc313-mpll.o
> +obj-$(CONFIG_MSTAR_MSC313_CPUPLL) +=3D clk-msc313-cpupll.o
> diff --git a/drivers/clk/mstar/clk-msc313-cpupll.c b/drivers/clk/mstar/cl=
k-msc313-cpupll.c
> new file mode 100644
> index 000000000000..2229b16475eb
> --- /dev/null
> +++ b/drivers/clk/mstar/clk-msc313-cpupll.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Daniel Palmer <daniel@thingy.jp>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Is this include used? Please drop unused includes.

> +#include <linux/of_address.h>
> +#include <linux/module.h>

It isn't a module though.

> +#include <linux/kernel.h>

Preferably sort includes alphabetically too.

> +
> +/*
> + * This IP is not documented outside of the messy vendor driver.
> + * Below is what we think the registers look like based on looking at
> + * the vendor code and poking at the hardware:
> + *
> + * 0x140 -- LPF low. Seems to store one half of the clock transition
> + * 0x144 /
> + * 0x148 -- LPF high. Seems to store one half of the clock transition
> + * 0x14c /
> + * 0x150 -- vendor code says "toggle lpf enable"
> + * 0x154 -- mu?
> + * 0x15c -- lpf_update_count?
> + * 0x160 -- vendor code says "switch to LPF". Clock source config? Regis=
ter bank?
> + * 0x164 -- vendor code says "from low to high" which seems to mean tran=
sition from LPF low to
> + * LPF high.
> + * 0x174 -- Seems to be the PLL lock status bit
> + * 0x180 -- Seems to be the current frequency, this might need to be pop=
ulated by software?
> + * 0x184 /  The vendor driver uses these to set the initial value of LPF=
 low
> + *
> + * Frequency seems to be calculated like this:
> + * (parent clock (432mhz) / register_magic_value) * 16 * 524288
> + * Only the lower 24 bits of the resulting value will be used. In additi=
on, the
> + * PLL doesn't seem to be able to lock on frequencies lower than 220 MHz=
, as
> + * divisor 0xfb586f (220 MHz) works but 0xfb7fff locks up.
> + *
> + * Vendor values:
> + * frequency - register value
> + *
> + * 400000000  - 0x0067AE14
> + * 600000000  - 0x00451EB8,
> + * 800000000  - 0x0033D70A,
> + * 1000000000 - 0x002978d4,
> + */
> +
> +#define REG_LPF_LOW_L          0x140
> +#define REG_LPF_LOW_H          0x144
> +#define REG_LPF_HIGH_BOTTOM    0x148
> +#define REG_LPF_HIGH_TOP       0x14c
> +#define REG_LPF_TOGGLE         0x150
> +#define REG_LPF_MYSTERYTWO     0x154
> +#define REG_LPF_UPDATE_COUNT   0x15c
> +#define REG_LPF_MYSTERYONE     0x160
> +#define REG_LPF_TRANSITIONCTRL 0x164
> +#define REG_LPF_LOCK           0x174
> +#define REG_CURRENT            0x180
> +
> +#define MULTIPLIER_1           16
> +#define MULTIPLIER_2           524288
> +#define MULTIPLIER             (MULTIPLIER_1 * MULTIPLIER_2)
> +
> +struct msc313_cpupll {
> +       void __iomem *base;
> +       struct clk_hw clk_hw;
> +};
> +
> +#define to_cpupll(_hw) container_of(_hw, struct msc313_cpupll, clk_hw)
> +
> +static u32 msc313_cpupll_reg_read32(struct msc313_cpupll *cpupll, unsign=
ed int reg)
> +{
> +       u32 value;
> +
> +       value =3D ioread16(cpupll->base + reg + 4) << 16;
> +       value |=3D ioread16(cpupll->base + reg);
> +
> +       return value;
> +}
> +
> +static void msc313_cpupll_reg_write32(struct msc313_cpupll *cpupll, unsi=
gned int reg, u32 value)
> +{
> +       u16 l =3D value & 0xffff, h =3D (value >> 16) & 0xffff;
> +
> +       iowrite16(l, cpupll->base + reg);

We don't usually see 16-bit accesses but if that's what the hardware
wants then OK.

> +       iowrite16(h, cpupll->base + reg + 4);
> +}
> +
> +static void msc313_cpupll_setfreq(struct msc313_cpupll *cpupll, u32 regv=
alue)
> +{
> +       msc313_cpupll_reg_write32(cpupll, REG_LPF_HIGH_BOTTOM, regvalue);
> +
> +       iowrite16(0x1, cpupll->base + REG_LPF_MYSTERYONE);
> +       iowrite16(0x6, cpupll->base + REG_LPF_MYSTERYTWO);
> +       iowrite16(0x8, cpupll->base + REG_LPF_UPDATE_COUNT);
> +       iowrite16(BIT(12), cpupll->base + REG_LPF_TRANSITIONCTRL);
> +
> +       iowrite16(0, cpupll->base + REG_LPF_TOGGLE);
> +       iowrite16(1, cpupll->base + REG_LPF_TOGGLE);
> +
> +       while (!(ioread16(cpupll->base + REG_LPF_LOCK)))
> +               cpu_relax();

Any timeout? Can this use the io read timeout APIs?

> +
> +       iowrite16(0, cpupll->base + REG_LPF_TOGGLE);
> +
> +       msc313_cpupll_reg_write32(cpupll, REG_LPF_LOW_L, regvalue);
> +}
> +
> +static unsigned long msc313_cpupll_frequencyforreg(u32 reg, unsigned lon=
g parent_rate)
> +{
> +       unsigned long long prescaled =3D ((unsigned long long)parent_rate=
) * MULTIPLIER;
> +       unsigned long long scaled;
> +
> +       if (prescaled =3D=3D 0 || reg =3D=3D 0)
> +               return 0;
> +       scaled =3D DIV_ROUND_DOWN_ULL(prescaled, reg);
> +
> +       return scaled;

Just

	return DIV_ROUND_DOWN_ULL(...);

> +}
> +
> +static u32 msc313_cpupll_regforfrequecy(unsigned long rate, unsigned lon=
g parent_rate)
> +{
> +       unsigned long long prescaled =3D ((unsigned long long)parent_rate=
) * MULTIPLIER;
> +       unsigned long long scaled;
> +       u32 reg;
> +
> +       if (prescaled =3D=3D 0 || rate =3D=3D 0)
> +               return 0;
> +
> +       scaled =3D DIV_ROUND_UP_ULL(prescaled, rate);
> +       reg =3D scaled;
> +
> +       return reg;

Just

	return DIV_ROUND_UP_ULL(...);

> +}
> +
> +static unsigned long msc313_cpupll_recalc_rate(struct clk_hw *hw, unsign=
ed long parent_rate)
> +{
> +       struct msc313_cpupll *cpupll =3D to_cpupll(hw);
> +
> +       return msc313_cpupll_frequencyforreg(msc313_cpupll_reg_read32(cpu=
pll, REG_LPF_LOW_L),
> +                                            parent_rate);
> +}
> +
> +static long msc313_cpupll_round_rate(struct clk_hw *hw, unsigned long ra=
te,
> +                                    unsigned long *parent_rate)
> +{
> +       u32 reg =3D msc313_cpupll_regforfrequecy(rate, *parent_rate);
> +       long rounded =3D msc313_cpupll_frequencyforreg(reg, *parent_rate);
> +
> +       /*
> +        * This is my poor attempt at making sure the resulting
> +        * rate doesn't overshoot the requested rate.

If you want better bounds you can use determine_rate and then look at
the min/max constraints to make sure you don't overshoot. But otherwise
round_rate implementation is up to the provider to figure out what
should happen, i.e. overshooting could be OK if the provider intends for
it.

> +        */
> +       for (; rounded >=3D rate && reg > 0; reg--)
> +               rounded =3D msc313_cpupll_frequencyforreg(reg, *parent_ra=
te);
> +
> +       return rounded;
> +}
> +
> +static int msc313_cpupll_set_rate(struct clk_hw *hw, unsigned long rate,=
 unsigned long parent_rate)
> +{
> +       struct msc313_cpupll *cpupll =3D to_cpupll(hw);
> +       u32 reg =3D msc313_cpupll_regforfrequecy(rate, parent_rate);
> +
> +       msc313_cpupll_setfreq(cpupll, reg);
> +
> +       return 0;
> +}
> +
> +static const struct clk_ops msc313_cpupll_ops =3D {
> +       .recalc_rate    =3D msc313_cpupll_recalc_rate,
> +       .round_rate     =3D msc313_cpupll_round_rate,
> +       .set_rate       =3D msc313_cpupll_set_rate,
> +};
> +
> +static const struct of_device_id msc313_cpupll_of_match[] =3D {
> +       {
> +               .compatible =3D "mstar,msc313-cpupll",
> +       },
> +       {}

This can and should be less lines

	{ .compatible =3D "mstar,msc313-cpupll", },
	{}

> +};
> +
> +static const struct clk_parent_data cpupll_parent =3D {
> +       .index  =3D 0,
> +};
> +
> +static int msc313_cpupll_probe(struct platform_device *pdev)
> +{
> +       struct clk_init_data clk_init =3D {};
> +       struct device *dev =3D &pdev->dev;
> +       struct msc313_cpupll *cpupll;
> +       int ret;
> +
> +       cpupll =3D devm_kzalloc(&pdev->dev, sizeof(*cpupll), GFP_KERNEL);
> +       if (!cpupll)
> +               return -ENOMEM;
> +
> +       cpupll->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(cpupll->base))
> +               return PTR_ERR(cpupll->base);
> +
> +       /* LPF might not contain the current frequency so fix that up */
> +       msc313_cpupll_reg_write32(cpupll, REG_LPF_LOW_L,
> +                                 msc313_cpupll_reg_read32(cpupll, REG_CU=
RRENT));
> +
> +       clk_init.name =3D dev_name(dev);
> +       clk_init.ops =3D &msc313_cpupll_ops;
> +       clk_init.flags =3D CLK_IS_CRITICAL;

Why is it critical? Can we have a comment? The clk ops don't have enable
or disable so it seems like the flag won't do anything.

> +       clk_init.parent_data =3D &cpupll_parent;
> +       clk_init.num_parents =3D 1;
> +       cpupll->clk_hw.init =3D &clk_init;
> +
> +       ret =3D devm_clk_hw_register(dev, &cpupll->clk_hw);
> +       if (ret)
> +               return ret;
> +
> +       return of_clk_add_hw_provider(pdev->dev.of_node, of_clk_hw_simple=
_get, &cpupll->clk_hw);
> +}
> +
> +static struct platform_driver msc313_cpupll_driver =3D {
> +       .driver =3D {
> +               .name =3D "mstar-msc313-cpupll",
> +               .of_match_table =3D msc313_cpupll_of_match,
> +       },
> +       .probe =3D msc313_cpupll_probe,
> +};
> +builtin_platform_driver(msc313_cpupll_driver);
