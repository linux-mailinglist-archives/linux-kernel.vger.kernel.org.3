Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC70485D57
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbiAFAm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:42:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57056 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbiAFAmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:42:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C17661994;
        Thu,  6 Jan 2022 00:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90484C36AEB;
        Thu,  6 Jan 2022 00:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641429769;
        bh=vtimmQ28wainiKtWcG8uQ33IVRXXuC+e2F6vR9sFu40=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Jo36njXNFq3YMd1wpsP/Ey52Q5+Cy2DOlbNf8arkL69LuS1EAOD2FdlLnDA/aIZcC
         mWivG7Mx1+nVT743n8x3mkvFurXD393On72sVFkLFxkdA5YxI1X0nIc17E0Tcs6ZM0
         CQUWiewCbReAMywEG+OBKwHRkkFfVQRxqMZDPUgWGZsjCnMqZxSM9gDhxsL12mc9dd
         6j+3sGzYCC1jdtUI4dtTYa2Qnue6sn3RYld1g2a9dQSv5Lp56Bw3wn7UFrdK0YTmTU
         yQAeCmsgKp57vcUhds1/OIC/pRz7mkE6rkMzH++LsNZdkwUDR4reeAT9OfXdUyBF7p
         bpFY93Egfsavw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7f8302e2c1d02141dd69d2524eaa857d6494fdc7.1640154492.git.qinjian@cqplus1.com>
References: <cover.1640154492.git.qinjian@cqplus1.com> <7f8302e2c1d02141dd69d2524eaa857d6494fdc7.1640154492.git.qinjian@cqplus1.com>
Subject: Re: [PATCH v7 06/10] clk: Add Sunplus SP7021 clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Date:   Wed, 05 Jan 2022 16:42:48 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106004249.90484C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qin Jian (2021-12-21 23:06:02)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c5b3dc973..4a186ccf6 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -334,6 +334,15 @@ config COMMON_CLK_VC5
>           This driver supports the IDT VersaClock 5 and VersaClock 6
>           programmable clock generators.
> =20
> +config COMMON_CLK_SP7021
> +       bool "Clock driver for Sunplus SP7021 SoC"
> +       default SOC_SP7021
> +       help
> +         This driver supports the Sunplus SP7021 SoC clocks.
> +         It implements SP7021 PLLs/gate.
> +         Not all features of the PLL are currently supported
> +         by the driver.
> +
>  config COMMON_CLK_STM32MP157
>         def_bool COMMON_CLK && MACH_STM32MP157
>         help
> @@ -366,7 +375,6 @@ config COMMON_CLK_MMP2
> =20
>  config COMMON_CLK_MMP2_AUDIO
>          tristate "Clock driver for MMP2 Audio subsystem"
> -        depends on COMMON_CLK_MMP2 || COMPILE_TEST
>          help
>            This driver supports clocks for Audio subsystem on MMP2 SoC.
> =20

What's the relevance of this hunk to this patch? Can you drop this part?

> diff --git a/drivers/clk/clk-sp7021.c b/drivers/clk/clk-sp7021.c
> new file mode 100644
> index 000000000..6df87f0a6
> --- /dev/null
> +++ b/drivers/clk/clk-sp7021.c
> @@ -0,0 +1,705 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + */
> +//#define DEBUG
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/bitfield.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <dt-bindings/clock/sp-sp7021.h>
> +
> +#define REG(i)         (pll_regs + (i) * 4)
> +
[....]
> +
> +static long plltv_div(struct sp_pll *clk, unsigned long freq)
> +{
> +       if (freq % 100)
> +               return plltv_fractional_div(clk, freq);
> +       else
> +               return plltv_integer_div(clk, freq);

Drop else please

> +}
> +
> +static void plltv_set_rate(struct sp_pll *clk)
> +{
> +       u32 reg;
> +
> +       reg  =3D HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
> +       reg |=3D HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
> +       reg |=3D HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
> +       reg |=3D HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
> +       writel(reg, clk->reg);
> +
> +       reg  =3D HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
[...]
> +       .set_rate =3D sp_pll_set_rate
> +};
> +
> +static const struct clk_ops sp_pll_sub_ops =3D {
> +       .enable =3D sp_pll_enable,
> +       .disable =3D sp_pll_disable,
> +       .is_enabled =3D sp_pll_is_enabled,
> +       .recalc_rate =3D sp_pll_recalc_rate,
> +};
> +
> +struct clk_hw *sp_pll_register(const char *name, const char *parent,
> +                              void __iomem *reg, int pd_bit, int bp_bit,
> +                              unsigned long brate, int shift, int width,
> +                              spinlock_t *lock)
> +{
> +       struct sp_pll *pll;
> +       struct clk_hw *hw;
> +       struct clk_init_data initd =3D {
> +               .name =3D name,
> +               .parent_names =3D &parent,

Any chance clk_parent_data can be used instead of string names?

> +               .ops =3D (bp_bit >=3D 0) ? &sp_pll_ops : &sp_pll_sub_ops,
> +               .num_parents =3D 1,
> +       };
> +       int ret;
> +
> +       pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       if (reg =3D=3D PLLSYS_CTL) /* system clock, should not be closed =
*/

s/closed/disabled/

> +               initd.flags |=3D CLK_IS_CRITICAL;
> +
> +       pll->hw.init =3D &initd;
> +       pll->reg =3D reg;
> +       pll->pd_bit =3D pd_bit;
> +       pll->bp_bit =3D bp_bit;
> +       pll->brate =3D brate;
> +       pll->div_shift =3D shift;
> +       pll->div_width =3D width;
> +       pll->lock =3D lock;
> +
> +       hw =3D &pll->hw;
> +       ret =3D clk_hw_register(NULL, hw);
> +       if (ret) {
> +               kfree(pll);
> +               hw =3D ERR_PTR(ret);
> +       } else {
> +               pr_info("%-20s%lu\n", name, clk_hw_get_rate(hw));

Drop this print or make it pr_debug()

> +               clk_hw_register_clkdev(hw, NULL, name);
> +       }
> +
> +       return hw;
> +}
> +
> +static void __init sp_clk_setup(struct device_node *np)
> +{
> +       int i, j;
> +       struct clk_hw **hws;
> +
> +       sp_clk_base =3D of_iomap(np, 0);
> +       if (WARN_ON(!sp_clk_base))
> +               return; /* -ENXIO */
> +
> +       sp_clk_data =3D kzalloc(struct_size(sp_clk_data, hws, CLK_MAX), G=
FP_KERNEL);
> +       if (!sp_clk_data)
> +               return; /* -ENOMEM */
> +
> +       hws =3D sp_clk_data->hws;
> +
> +       /* PLL_A */
> +       hws[PLL_A] =3D sp_pll_register("plla", EXTCLK, PLLA_CTL, 11, 12,
> +                                    27000000, 0, DIV_A, &plla_lock);
> +
> +       /* PLL_E */
> +       hws[PLL_E] =3D sp_pll_register("plle", EXTCLK, PLLE_CTL, 6, 2,
> +                                    50000000, 0, 0, &plle_lock);
> +       hws[PLL_E_2P5] =3D sp_pll_register("plle_2p5", "plle", PLLE_CTL, =
13, -1,
> +                                        2500000, 0, 0, &plle_lock);
> +       hws[PLL_E_25] =3D sp_pll_register("plle_25", "plle", PLLE_CTL, 12=
, -1,
> +                                       25000000, 0, 0, &plle_lock);
> +       hws[PLL_E_112P5] =3D sp_pll_register("plle_112p5", "plle", PLLE_C=
TL, 11, -1,
> +                                          112500000, 0, 0, &plle_lock);
> +
> +       /* PLL_F */
> +       hws[PLL_F] =3D sp_pll_register("pllf", EXTCLK, PLLF_CTL, 0, 10,
> +                                    13500000, 1, 4, &pllf_lock);
> +
> +       /* PLL_TV */
> +       hws[PLL_TV] =3D sp_pll_register("plltv", EXTCLK, PLLTV_CTL, 0, 15,
> +                                     27000000, 0, DIV_TV, &plltv_lock);
> +       hws[PLL_TV_A] =3D clk_hw_register_divider(NULL, "plltv_a", "plltv=
", 0,
> +                                               PLLTV_CTL + 4, 5, 1,
> +                                               CLK_DIVIDER_POWER_OF_TWO,
> +                                               &plltv_lock);
> +       clk_hw_register_clkdev(hws[PLL_TV_A], NULL, "plltv_a");
> +
> +       /* PLL_SYS */
> +       hws[PLL_SYS] =3D sp_pll_register("pllsys", EXTCLK, PLLSYS_CTL, 10=
, 9,
> +                                      13500000, 0, 4, &pllsys_lock);
> +
> +       /* gates */
> +       for (i =3D 0; i < ARRAY_SIZE(gates); i++) {
> +               char s[10];
> +
> +               j =3D gates[i] & 0xffff;
> +               sprintf(s, "clken%02x", j);
> +               hws[j] =3D clk_hw_register_gate(NULL, s,
> +                                             parents[gates[i] >> 16].fw_=
name,
> +                                             CLK_IGNORE_UNUSED,

Why CLK_IGNORE_UNUSED? There should be a comment or it should be
replaced with CLK_IS_CRITICAL.

> +                                             clk_regs + (j >> 4) * 4, j =
& 0x0f,
> +                                             CLK_GATE_HIWORD_MASK, NULL);
> +       }
> +
> +       sp_clk_data->num =3D CLK_MAX;
> +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, sp_clk_data);
> +}
> +
> +CLK_OF_DECLARE_DRIVER(sp_clkc, "sunplus,sp7021-clkc", sp_clk_setup);

Why CLK_OF_DECLARE_DRIVER? There should be a comment but better would be
to make a platform driver instead. If the platform driver can't be used,
we need to know what other device driver is probing based on this clkc
compatible string.
