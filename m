Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70020529747
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 04:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiEQCSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 22:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiEQCR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 22:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96F3D1D1;
        Mon, 16 May 2022 19:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6D2A61350;
        Tue, 17 May 2022 02:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D05C385B8;
        Tue, 17 May 2022 02:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652753876;
        bh=dsTgI9KNIqPX3fHe5LWju+wnSWRKcqQZMa7NJjCAOW0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BPlJX8i7Apz8eDsnPK0NkA2xmjui87l9vVRXnL1HsAveEWwflQN6J3JdKZNEHzSfZ
         7Hs17YFN/CeJ/Z1Sq68ejGAnTZU9HVS0ebMvfA+ErGR0HZjuL+TCQnWOJ1HZXiXLn0
         n7hwbSn4QNWd0CjxBgNQIC+UO5BHc57TPQe8TjaEYrbqEqCcdY25Klb8pEKh2AOr8d
         oXw7OOXLIG6KSF3ZPly8kJNHS3k/6QLYxxZIicIAZeUPITufci+Nu7LBvJH8/8RXgx
         oLjJ4ONa8Ps0UhOz8fTMvqxg1FCJCiivWviB+4MQ7mZOoUZF+q2mzXPKjf8ec/UM/7
         5Q4GCkRIUOIQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9a71d17e9c70051db44c5545453ae8320ed8e0f8.1652329411.git.qinjian@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com> <9a71d17e9c70051db44c5545453ae8320ed8e0f8.1652329411.git.qinjian@cqplus1.com>
Subject: Re: [PATCH v15 05/10] clk: Add Sunplus SP7021 clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
To:     Qin Jian <qinjian@cqplus1.com>
Date:   Mon, 16 May 2022 19:17:54 -0700
User-Agent: alot/0.10
Message-Id: <20220517021755.F1D05C385B8@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qin Jian (2022-05-11 23:31:00)
> diff --git a/drivers/clk/clk-sp7021.c b/drivers/clk/clk-sp7021.c
> new file mode 100644
> index 000000000..7d71bc276
> --- /dev/null
> +++ b/drivers/clk/clk-sp7021.c
> @@ -0,0 +1,721 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + */
> +#include <linux/module.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/bitfield.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/sunplus,sp7021-clkc.h>
> +
> +#define REG(i)         (pll_regs + (i) * 4)
> +
> +#define PLLA_CTL       REG(7)
> +#define PLLE_CTL       REG(12)
> +#define PLLF_CTL       REG(13)
> +#define PLLTV_CTL      REG(14)
> +#define PLLSYS_CTL     REG(26)
> +
> +/* speical div_width values for PLLTV/PLLA */
> +#define DIV_TV         33
> +#define DIV_A          34
> +
> +/* PLLTV parameters */
> +enum {
> +       SEL_FRA,
> +       SDM_MOD,
> +       PH_SEL,
> +       NFRA,
> +       DIVR,
> +       DIVN,
> +       DIVM,
> +       P_MAX
> +};
> +
> +#define MASK_SEL_FRA   GENMASK(1, 1)
> +#define MASK_SDM_MOD   GENMASK(2, 2)
> +#define MASK_PH_SEL    GENMASK(4, 4)
> +#define MASK_NFRA      GENMASK(12, 6)
> +#define MASK_DIVR      GENMASK(8, 7)
> +#define MASK_DIVN      GENMASK(7, 0)
> +#define MASK_DIVM      GENMASK(14, 8)
> +
> +/* HIWORD_MASK FIELD_PREP */
> +#define HWM_FIELD_PREP(mask, value)            \
> +({                                             \
> +       u32 m =3D mask;                           \
> +       (m << 16) | FIELD_PREP(m, value);       \
> +})
> +
> +struct sp_pll {
> +       struct clk_hw hw;
> +       void __iomem *reg;
> +       spinlock_t *lock;       /* lock for reg */
> +       int div_shift;
> +       int div_width;
> +       int pd_bit;             /* power down bit idx */
> +       int bp_bit;             /* bypass bit idx */
> +       unsigned long brate;    /* base rate, TODO: replace brate with mu=
ldiv */
> +       u32 p[P_MAX];           /* for hold PLLTV/PLLA parameters */
> +};
> +
> +#define to_sp_pll(_hw) container_of(_hw, struct sp_pll, hw)
> +
> +#define clk_regs       (sp_clk_base + 0x000) /* G0 ~ CLKEN */
> +#define pll_regs       (sp_clk_base + 0x200) /* G4 ~ PLL */
> +static void __iomem *sp_clk_base;
> +static struct clk_hw_onecell_data *sp_clk_data;

Why are these globals? Please allocate them locally in driver probe and
reference them without using a global.

> +
> +#define F_EXTCLK       BIT(16) /* parent clock is EXTCLK */
> +
> +/* gates HW info: reg_index_shift | parent */
> +static const u32 sp_clk_gates[] =3D {

Please make a struct sp_clk_gate_info

	struct sp_clk_gate_info {
		u16	reg;
		bool	ext_parent;
	};

Or 'ext_parent' can be u16 if struct packing with a bool on the end
fails due to alignment issues.

> +       0x12,
> +       0x15,
> +       0x16,
> +       0x17,
> +       0x19,
> +       0x1b | F_EXTCLK,
> +       0x1f | F_EXTCLK,
> +       0x24,
> +       0x25,
> +       0x26,
> +       0x27,
> +       0x28 | F_EXTCLK,
> +       0x29 | F_EXTCLK,
> +       0x2a | F_EXTCLK,
> +       0x2b | F_EXTCLK,
> +       0x2c | F_EXTCLK,
> +       0x2d | F_EXTCLK,
> +       0x2e,
> +       0x2f | F_EXTCLK,
> +       0x30,
> +       0x31,
> +       0x32,
> +       0x33,
> +       0x34,
> +       0x35,
> +       0x36,
> +       0x3a,
> +       0x3b,
> +       0x3d,
> +       0x3e,
> +       0x40,
> +       0x41,
> +       0x42,
> +       0x43,
> +       0x4d,
> +       0x4e,
> +       0x4f,
> +       0x52,
> +       0x54,
> +       0x5b,
> +       0x5c,
> +       0x5d,
> +       0x5e,
> +       0x5f,
> +       0x60,
> +       0x65,
> +       0x70,
> +       0x71,
> +       0x7a,
> +       0x83,
> +       0x96,
> +       0x9a,
> +       0x9b,
> +       0x9d,
> +       0x9e,
> +       0x9f,
> +       0xa0,
> +       0xa2,
> +       0xa3,
> +       0xa5,
> +       0xa6,
> +       0xa7,
> +       0xa8,
> +       0xa9,
> +};
> +
> +static DEFINE_SPINLOCK(plla_lock);

The name of the spinlock will be inserted directly into any lockdep
report. Can these locks be part of some allocated structure instead of
being static globals? Then the struct name will be encoded during
spin_lock_init() which will be more helpful assuming the struct name is
driver specific.

> +static DEFINE_SPINLOCK(plle_lock);
> +static DEFINE_SPINLOCK(pllf_lock);
> +static DEFINE_SPINLOCK(pllsys_lock);
> +static DEFINE_SPINLOCK(plltv_lock);
> +
> +#define _M             1000000UL
> +#define F_27M          (27 * _M)
> +
> +/*********************************** PLL_TV ****************************=
******/
> +
> +/* TODO: set proper FVCO range */
> +#define FVCO_MIN       (100 * _M)
> +#define FVCO_MAX       (200 * _M)
> +
> +#define F_MIN          (FVCO_MIN / 8)
> +#define F_MAX          (FVCO_MAX)
> +
> +static long plltv_integer_div(struct sp_pll *clk, unsigned long freq)
> +{
> +       /* valid m values: 27M must be divisible by m, 0 means end */
> +       static const u32 m_table[] =3D {
> +               1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 2=
7, 30, 32, 0
> +       };
> +       u32 m, n, r;
> +       unsigned long fvco, nf;
> +
> +       freq =3D clamp(freq, F_MIN, F_MAX);
> +
> +       /* DIVR 0~3 */
> +       for (r =3D 0; r <=3D 3; r++) {
> +               fvco =3D freq << r;
> +               if (fvco <=3D FVCO_MAX)
> +                       break;
> +       }
> +
> +       /* DIVM */
> +       for (m =3D 0; m_table[m]; m++) {

Use ARRAY_SIZE and remove the comment about and value of 0 from the end?

> +               nf =3D fvco * m_table[m];
> +               n =3D nf / F_27M;
> +               if ((n * F_27M) =3D=3D nf)
> +                       break;
> +       }
> +       m =3D m_table[m];
> +
> +       if (!m) {

This can be resolved with a 'return' from a subfunction or a goto.

> +               pr_err("%s: %s freq:%lu not found a valid setting\n",
> +                      __func__, clk_hw_get_name(&clk->hw), freq);
> +               return -EINVAL;
> +       }
> +
> +       /* save parameters */
> +       clk->p[SEL_FRA] =3D 0;
> +       clk->p[DIVR]    =3D r;
> +       clk->p[DIVN]    =3D n;
> +       clk->p[DIVM]    =3D m;
> +
> +       return freq;
> +}
> +
> +/* parameters for PLLTV fractional divider */
> +static const u32 pt[][5] =3D {
> +       /* conventional fractional */
> +       {
> +               1,                      // factor

Don't use // for comments.

> +               5,                      // 5 * p0 (nint)
> +               1,                      // 1 * p0
> +               F_27M,                  // F_27M / p0
> +               1,                      // p0 / p2
> +       },
> +       /* phase rotation */
> +       {
> +               10,                     // factor
> +               54,                     // 5.4 * p0 (nint)
> +               2,                      // 0.2 * p0
> +               F_27M / 10,             // F_27M / p0
> +               5,                      // p0 / p2
> +       },
> +};
> +
> +static const u32 mods[] =3D { 91, 55 }; /* SDM_MOD mod values */

Maybe call it sdm_mod_vals[] and drop the comment?

> +
> +static long plltv_fractional_div(struct sp_pll *clk, unsigned long freq)
> +{
> +       u32 m, r;
> +       u32 nint, nfra;
> +       u32 df_quotient_min =3D 210000000;
> +       u32 df_remainder_min =3D 0;
> +       unsigned long fvco, nf, f, fout =3D 0;
> +       int sdm, ph;
> +
> +       freq =3D clamp(freq, F_MIN, F_MAX);
> +
> +       /* DIVR 0~3 */
> +       for (r =3D 0; r <=3D 3; r++) {
> +               fvco =3D freq << r;
> +               if (fvco <=3D FVCO_MAX)
> +                       break;
> +       }
> +       f =3D F_27M >> r;
> +
> +       /* PH_SEL 1/0 */
> +       for (ph =3D 1; ph >=3D 0; ph--) {
> +               const u32 *pp =3D pt[ph];
> +               u32 ms =3D 1;

this is 1

> +
> +               /* SDM_MOD 0/1 */
> +               for (sdm =3D 0; sdm <=3D 1; sdm++) {
> +                       u32 mod =3D mods[sdm];
> +
> +                       /* DIVM 1~32 */
> +                       for (m =3D ms; m <=3D 32; m++) {

and still 1? Just use 1 instead of another local variable?

> +                               u32 df; /* diff freq */
> +                               u32 df_quotient, df_remainder;
> +
> +                               nf =3D fvco * m;
> +                               nint =3D nf / pp[3];
> +
> +                               if (nint < pp[1])
> +                                       continue;
> +                               if (nint > pp[1])
> +                                       break;
> +
> +                               nfra =3D (((nf % pp[3]) * mod * pp[4]) + =
(F_27M / 2)) / F_27M;
> +                               if (nfra)
> +                                       df =3D (f * (nint + pp[2]) / pp[0=
]) -
> +                                            (f * (mod - nfra) / mod / pp=
[4]);

This is quite long and I am concerned about overflow. Can we have more
local variables to help break up the statement?

> +                               else
> +                                       df =3D (f * (nint) / pp[0]);

Drop useless parenthesis please.

> +
> +                               df_quotient  =3D df / m;
> +                               df_remainder =3D ((df % m) * 1000) / m;
> +
> +                               if (freq > df_quotient) {
> +                                       df_quotient  =3D freq - df_quotie=
nt - 1;
> +                                       df_remainder =3D 1000 - df_remain=
der;

Where does 1000 come from?

> +                               } else {
> +                                       df_quotient =3D df_quotient - fre=
q;
> +                               }
> +
> +                               if (df_quotient_min > df_quotient ||
> +                                   (df_quotient_min =3D=3D df_quotient &&
> +                                   df_remainder_min > df_remainder)) {
> +                                       /* found a closer freq, save para=
meters */
> +                                       clk->p[SEL_FRA] =3D 1;
> +                                       clk->p[SDM_MOD] =3D sdm;
> +                                       clk->p[PH_SEL]  =3D ph;
> +                                       clk->p[NFRA]    =3D nfra;
> +                                       clk->p[DIVR]    =3D r;
> +                                       clk->p[DIVM]    =3D m;
> +
> +                                       fout =3D df / m;
> +                                       df_quotient_min =3D df_quotient;
> +                                       df_remainder_min =3D df_remainder;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       if (!fout) {
> +               pr_err("%s: %s freq:%lu not found a valid setting\n",
> +                      __func__, clk_hw_get_name(&clk->hw), freq);
> +               return -EINVAL;
> +       }
> +
> +       return fout;
> +}
> +
> +static long plltv_div(struct sp_pll *clk, unsigned long freq)
> +{
> +       if (freq % 100)
> +               return plltv_fractional_div(clk, freq);
> +
> +       return plltv_integer_div(clk, freq);
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
> +       writel(reg, clk->reg + 4);
> +
> +       reg  =3D HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
> +       reg |=3D HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
> +       writel(reg, clk->reg + 8);
> +}
> +
> +/*********************************** PLL_A *****************************=
******/
> +
> +/* from Q628_PLLs_REG_setting.xlsx */
> +static const struct {
> +       u32 rate;
> +       u32 regs[5];
> +} pa[] =3D {
> +       {
> +               .rate =3D 135475200,
> +               .regs =3D {
> +                       0x4801,
> +                       0x02df,
> +                       0x248f,
> +                       0x0211,
> +                       0x33e9
> +               }
> +       },
> +       {
> +               .rate =3D 147456000,
> +               .regs =3D {
> +                       0x4801,
> +                       0x1adf,
> +                       0x2490,
> +                       0x0349,
> +                       0x33e9
> +               }
> +       },
> +       {
> +               .rate =3D 196608000,
> +               .regs =3D {
> +                       0x4801,
> +                       0x42ef,
> +                       0x2495,
> +                       0x01c6,
> +                       0x33e9
> +               }
> +       },
> +};
> +
> +static void plla_set_rate(struct sp_pll *clk)
> +{
> +       const u32 *pp =3D pa[clk->p[0]].regs;
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(pa->regs); i++)
> +               writel(0xffff0000 | pp[i], clk->reg + (i * 4));
> +}
> +
> +static long plla_round_rate(struct sp_pll *clk, unsigned long rate)
> +{
> +       int i =3D ARRAY_SIZE(pa);
> +
> +       while (--i) {
> +               if (rate >=3D pa[i].rate)
> +                       break;
> +       }
> +       clk->p[0] =3D i;
> +
> +       return pa[i].rate;
> +}
> +
> +/********************************** SP_PLL *****************************=
******/
> +
> +static long sp_pll_calc_div(struct sp_pll *clk, unsigned long rate)
> +{
> +       u32 fbdiv;
> +       u32 max =3D 1 << clk->div_width;
> +
> +       fbdiv =3D DIV_ROUND_CLOSEST(rate, clk->brate);
> +       if (fbdiv > max)
> +               fbdiv =3D max;
> +
> +       return fbdiv;
> +}
> +
> +static long sp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                             unsigned long *prate)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +       long ret;
> +
> +       if (rate =3D=3D *prate) {
> +               ret =3D *prate; /* bypass */
> +       } else if (clk->div_width =3D=3D DIV_A) {
> +               ret =3D plla_round_rate(clk, rate);
> +       } else if (clk->div_width =3D=3D DIV_TV) {
> +               ret =3D plltv_div(clk, rate);
> +               if (ret < 0)
> +                       ret =3D *prate;
> +       } else {
> +               ret =3D sp_pll_calc_div(clk, rate) * clk->brate;
> +       }
> +
> +       return ret;
> +}
> +
> +static unsigned long sp_pll_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long prate)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +       u32 reg =3D readl(clk->reg);
> +       unsigned long ret;
> +
> +       if (reg & BIT(clk->bp_bit)) {
> +               ret =3D prate; /* bypass */
> +       } else if (clk->div_width =3D=3D DIV_A) {
> +               ret =3D pa[clk->p[0]].rate;
> +       } else if (clk->div_width =3D=3D DIV_TV) {
> +               u32 m, r, reg2;
> +
> +               r =3D FIELD_GET(MASK_DIVR, readl(clk->reg + 4));
> +               reg2 =3D readl(clk->reg + 8);
> +               m =3D FIELD_GET(MASK_DIVM, reg2) + 1;
> +
> +               if (reg & BIT(1)) { /* SEL_FRA */

Make a define for BIT(1) please. SEL_FRA?

> +                       /* fractional divider */
> +                       u32 sdm  =3D FIELD_GET(MASK_SDM_MOD, reg);
> +                       u32 ph   =3D FIELD_GET(MASK_PH_SEL, reg);
> +                       u32 nfra =3D FIELD_GET(MASK_NFRA, reg);
> +                       const u32 *pp =3D pt[ph];
> +
> +                       ret =3D prate >> r;
> +                       ret =3D (ret * (pp[1] + pp[2]) / pp[0]) -
> +                                 (ret * (mods[sdm] - nfra) / mods[sdm] /=
 pp[4]);
> +                       ret /=3D m;
> +               } else {
> +                       /* integer divider */
> +                       u32 n =3D FIELD_GET(MASK_DIVN, reg2) + 1;
> +
> +                       ret =3D (prate / m * n) >> r;
> +               }
> +       } else {
> +               u32 fbdiv =3D ((reg >> clk->div_shift) & ((1 << clk->div_=
width) - 1)) + 1;
> +
> +               ret =3D clk->brate * fbdiv;
> +       }
> +
> +       return ret;
> +}
> +
> +static int sp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +                          unsigned long prate)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +       unsigned long flags;
> +       u32 reg;
> +
> +       spin_lock_irqsave(clk->lock, flags);

Please push the lock down. Maybe that means having two conditionals?
Either way, it is too large because it calls into plla_set_rate() and
plltv_set_rate() with the lock held.

> +
> +       reg =3D BIT(clk->bp_bit + 16); /* HIWORD_MASK */
> +
> +       if (rate =3D=3D prate) {
> +               reg |=3D BIT(clk->bp_bit); /* bypass */
> +       } else if (clk->div_width =3D=3D DIV_A) {
> +               plla_set_rate(clk);
> +       } else if (clk->div_width =3D=3D DIV_TV) {
> +               plltv_set_rate(clk);
> +       } else if (clk->div_width) {
> +               u32 fbdiv =3D sp_pll_calc_div(clk, rate);
> +               u32 mask =3D GENMASK(clk->div_shift + clk->div_width - 1,=
 clk->div_shift);
> +
> +               reg |=3D (mask << 16) | (((fbdiv - 1) << clk->div_shift) =
& mask);

This is a really long line.

> +       }
> +
> +       writel(reg, clk->reg);
> +
> +       spin_unlock_irqrestore(clk->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int sp_pll_enable(struct clk_hw *hw)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +
> +       writel(BIT(clk->pd_bit + 16) | BIT(clk->pd_bit), clk->reg); /* po=
wer up */

The comment is pretty useless, this is what pll enable would do.
> +
> +       return 0;
> +}
> +
> +static void sp_pll_disable(struct clk_hw *hw)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +
> +       writel(BIT(clk->pd_bit + 16), clk->reg); /* power down */

Same.

> +}
> +
> +static int sp_pll_is_enabled(struct clk_hw *hw)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +
> +       return readl(clk->reg) & BIT(clk->pd_bit);
> +}
> +
> +static const struct clk_ops sp_pll_ops =3D {
> +       .enable =3D sp_pll_enable,
> +       .disable =3D sp_pll_disable,
> +       .is_enabled =3D sp_pll_is_enabled,
> +       .round_rate =3D sp_pll_round_rate,
> +       .recalc_rate =3D sp_pll_recalc_rate,
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
> +static void dbg_clk(struct clk_hw *hw)
> +{
> +       const char *name =3D clk_hw_get_name(hw);
> +       unsigned long rate =3D clk_hw_get_rate(hw);
> +
> +       pr_debug("%-20s%lu\n", name, rate);

This doesn't provide anything more than normal clk debugfs so just
remove?

> +}
> +
> +static struct clk_hw *sp_pll_register(struct device *dev, const char *na=
me,
> +                                     const struct clk_parent_data *paren=
t_data,
> +                                     void __iomem *reg, int pd_bit, int =
bp_bit,
> +                                     unsigned long brate, int shift, int=
 width,
> +                                     spinlock_t *lock)
> +{
> +       struct sp_pll *pll;
> +       struct clk_hw *hw;
> +       struct clk_init_data initd =3D {
> +               .name =3D name,
> +               .parent_data =3D parent_data,
> +               .ops =3D (bp_bit >=3D 0) ? &sp_pll_ops : &sp_pll_sub_ops,
> +               .num_parents =3D 1,
> +               /* system clock, should not be disabled */
> +               .flags =3D (reg =3D=3D PLLSYS_CTL) ? CLK_IS_CRITICAL : 0,
> +       };
> +       int ret;
> +
> +       pll =3D devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
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
> +       ret =3D devm_clk_hw_register(dev, hw);
> +       if (ret) {
> +               kfree(pll);
> +               return ERR_PTR(ret);
> +       }
> +       dbg_clk(hw);
> +
> +       return hw;
> +}
> +
> +static int sp7021_clk_probe(struct platform_device *pdev)
> +{
> +       static const u32 sp_clken[] =3D {
> +               0x67ef, 0x03ff, 0xff03, 0xfff0, 0x0004, /* G0.1~5  */
> +               0x0000, 0x8000, 0xffff, 0x0040, 0x0000, /* G0.6~10 */
> +       };
> +       static struct clk_parent_data pd_ext, pd_sys, pd_e;
> +       struct device *dev =3D &pdev->dev;
> +       struct clk_hw **hws;
> +       struct resource *res;
> +       int i;
> +
> +       /* This memory region include multi HW regs in discontinuous orde=
r.

The /* should be on a line by itself.

> +        * clk driver used some discontinuous areas in the memory region.
> +        * Using devm_platform_ioremap_resource() would conflicted with o=
ther drivers.

What other drivers?

> +        */
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       sp_clk_base =3D devm_ioremap(dev, res->start, resource_size(res));
> +       if (!sp_clk_base)
> +               return -ENXIO;
> +
> +       /* enable default clks */
> +       for (i =3D 0; i < ARRAY_SIZE(sp_clken); i++)
> +               writel((sp_clken[i] << 16) | sp_clken[i], sp_clk_base + 4=
 * (1 + i));
> +
> +       sp_clk_data =3D devm_kzalloc(dev, struct_size(sp_clk_data, hws, C=
LK_MAX),
> +                                  GFP_KERNEL);
> +       if (!sp_clk_data)
> +               return -ENOMEM;
> +
> +       hws =3D sp_clk_data->hws;
> +       pd_ext.index =3D 0; /* clocks =3D <&extclk>; */

Remove comment please.

> +
> +       /* PLL_A */
> +       hws[PLL_A] =3D sp_pll_register(dev, "plla", &pd_ext, PLLA_CTL,
> +                                    11, 12, 27000000, 0, DIV_A, &plla_lo=
ck);
> +       if (IS_ERR(hws[PLL_A]))
> +               return PTR_ERR(hws[PLL_A]);
> +
> +       /* PLL_E */
> +       hws[PLL_E] =3D sp_pll_register(dev, "plle", &pd_ext, PLLE_CTL,
> +                                    6, 2, 50000000, 0, 0, &plle_lock);
> +       if (IS_ERR(hws[PLL_E]))
> +               return PTR_ERR(hws[PLL_E]);
> +       pd_e.hw =3D hws[PLL_E];
> +       hws[PLL_E_2P5] =3D sp_pll_register(dev, "plle_2p5", &pd_e, PLLE_C=
TL,
> +                                        13, -1, 2500000, 0, 0, &plle_loc=
k);
> +       if (IS_ERR(hws[PLL_E_2P5]))
> +               return PTR_ERR(hws[PLL_E_2P5]);
> +       hws[PLL_E_25] =3D sp_pll_register(dev, "plle_25", &pd_e, PLLE_CTL,
> +                                       12, -1, 25000000, 0, 0, &plle_loc=
k);
> +       if (IS_ERR(hws[PLL_E_25]))
> +               return PTR_ERR(hws[PLL_E_25]);
> +       hws[PLL_E_112P5] =3D sp_pll_register(dev, "plle_112p5", &pd_e, PL=
LE_CTL,
> +                                          11, -1, 112500000, 0, 0, &plle=
_lock);
> +       if (IS_ERR(hws[PLL_E_112P5]))
> +               return PTR_ERR(hws[PLL_E_112P5]);
> +
> +       /* PLL_F */
> +       hws[PLL_F] =3D sp_pll_register(dev, "pllf", &pd_ext, PLLF_CTL,
> +                                    0, 10, 13500000, 1, 4, &pllf_lock);
> +       if (IS_ERR(hws[PLL_F]))
> +               return PTR_ERR(hws[PLL_F]);
> +
> +       /* PLL_TV */
> +       hws[PLL_TV] =3D sp_pll_register(dev, "plltv", &pd_ext, PLLTV_CTL,
> +                                     0, 15, 27000000, 0, DIV_TV, &plltv_=
lock);
> +       if (IS_ERR(hws[PLL_TV]))
> +               return PTR_ERR(hws[PLL_TV]);
> +       hws[PLL_TV_A] =3D devm_clk_hw_register_divider(dev, "plltv_a", "p=
lltv", 0,
> +                                                    PLLTV_CTL + 4, 5, 1,
> +                                                    CLK_DIVIDER_POWER_OF=
_TWO,
> +                                                    &plltv_lock);
> +       if (IS_ERR(hws[PLL_TV_A]))
> +               return PTR_ERR(hws[PLL_TV_A]);
> +       dbg_clk(hws[PLL_TV_A]);
> +
> +       /* PLL_SYS */
> +       hws[PLL_SYS] =3D sp_pll_register(dev, "pllsys", &pd_ext, PLLSYS_C=
TL,
> +                                      10, 9, 13500000, 0, 4, &pllsys_loc=
k);
> +       if (IS_ERR(hws[PLL_SYS]))
> +               return PTR_ERR(hws[PLL_SYS]);
> +       pd_sys.hw =3D hws[PLL_SYS];
> +
> +       /* gates */
> +       for (i =3D 0; i < ARRAY_SIZE(sp_clk_gates); i++) {
> +               char name[10];
> +               u32 f =3D sp_clk_gates[i];
> +               int j =3D f & 0xffff;
> +               struct clk_parent_data *pd =3D (f & F_EXTCLK) ? &pd_ext :=
 &pd_sys;
> +
> +               sprintf(name, "%02d_0x%02x", i, j);
> +               hws[i] =3D clk_hw_register_gate_parent_data(dev, name, pd=
, 0,
> +                                                         clk_regs + (j >=
> 4) * 4,
> +                                                         j & 0x0f,
> +                                                         CLK_GATE_HIWORD=
_MASK,
> +                                                         NULL);
> +               if (IS_ERR(hws[i]))
> +                       return PTR_ERR(hws[i]);
> +               dbg_clk(hws[i]);
> +       }
> +
> +       sp_clk_data->num =3D CLK_MAX;
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, sp=
_clk_data);

We leaked a bunch of clk_hw_register_gate_parent_data() calls here if
this failed.

> +}
> +
> +static const struct of_device_id sp7021_clk_dt_ids[] =3D {
> +       { .compatible =3D "sunplus,sp7021-clkc", },
> +       { }
> +};

Missing MODULE_DEVICE_TABLE, but see below.

> +
> +static struct platform_driver sp7021_clk_driver =3D {
> +       .probe  =3D sp7021_clk_probe,
> +       .driver =3D {
> +               .name =3D "sp7021-clk",
> +               .of_match_table =3D sp7021_clk_dt_ids,
> +       },
> +};
> +module_platform_driver(sp7021_clk_driver);
> +
> +MODULE_AUTHOR("Sunplus Technology");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Clock driver for Sunplus SP7021 SoC");

Is it a module? The Kconfig is bool, so either make that tristate or
remove modular support from this driver. Preferably make it tristate.
