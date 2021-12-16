Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2070F476A86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhLPGmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhLPGmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:42:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70004C061574;
        Wed, 15 Dec 2021 22:42:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E156DB822C9;
        Thu, 16 Dec 2021 06:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FADC36AE2;
        Thu, 16 Dec 2021 06:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639636935;
        bh=JQSYtEHZfLgrDLv5Ma3M8BEnAsbOp4n74FL5RXLsOLs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=r7LMYO0HwQG/5KO5hAMAIuG4PEN9HShNAppxaA8E6d+baCS0+Y7KJl4hKY6cCL7aG
         d1tPc+QGKnqEC1K8zoz1/rk8fFAMTX9Ou+KaVB0e4V6ocBHgdIXhZubmtDB5hTS7gd
         bLG9A+YbMjPppkftgrcH5i+OieucyiFVbkhfwSSIar7N6t1+1py9Ilso3ZGMew3kW1
         zHVUQeguhXV07b4cibdcNY5pkrtdIyrPYCyixfRjhTO0IJQxQZ3JyiCX+Ug9Wd334k
         7dxbXSnD7y1tFVUmCeaF56/ZQEFqOkOjo/07B1B1QASm0FXSZcMK54LYRJlYhwIfI/
         AWu1GIS3TH24w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8d23a5e00d870173993032c6a68fb5f48182691d.1638515726.git.qinjian@cqplus1.com>
References: <cover.1638515726.git.qinjian@cqplus1.com> <8d23a5e00d870173993032c6a68fb5f48182691d.1638515726.git.qinjian@cqplus1.com>
Subject: Re: [PATCH v5 06/10] clk: Add Sunplus SP7021 clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, wells.lu@sunplus.com,
        Qin Jian <qinjian@cqplus1.com>
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Date:   Wed, 15 Dec 2021 22:42:14 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216064215.96FADC36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qin Jian (2021-12-02 23:34:23)
> diff --git a/drivers/clk/clk-sp7021.c b/drivers/clk/clk-sp7021.c
> new file mode 100644
> index 000000000..040578e82
> --- /dev/null
> +++ b/drivers/clk/clk-sp7021.c
> @@ -0,0 +1,738 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + */
> +//#define DEBUG
> +#include <linux/module.h>

It's not a module, don't include this.

> +#include <linux/clk.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/bitfield.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>

Is this include used?

> +#include <dt-bindings/clock/sp-sp7021.h>
> +
> +#ifndef clk_readl
> +#define clk_readl  readl
> +#define clk_writel writel
> +#endif

Please remove these and use readl/writel directly.

> +
> +#define REG(i)         (pll_regs + (i) * 4)
> +
> +#define PLLA_CTL       REG(7)
> +#define PLLE_CTL       REG(12)
> +#define PLLF_CTL       REG(13)
> +#define PLLTV_CTL      REG(14)
> +#define PLLSYS_CTL     REG(26)
> +
> +#define EXTCLK         "extclk"
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
> +#define MASK_PH_SEL            GENMASK(4, 4)
> +#define MASK_NFRA              GENMASK(12, 6)
> +#define MASK_DIVR              GENMASK(8, 7)
> +#define MASK_DIVN              GENMASK(7, 0)
> +#define MASK_DIVM              GENMASK(14, 8)
> +
> +/* HIWORD_MASK FIELD_PREP */
> +#define HWM_FIELD_PREP(mask, value) \
> +({\
> +       u32 m =3D mask; \
> +       (m << 16) | FIELD_PREP(m, value); \

Please tab out the \ to a single column that's the same for all.

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
> +       u32 p[P_MAX];   /* for hold PLLTV/PLLA parameters */
> +};
> +
> +#define to_sp_pll(_hw) container_of(_hw, struct sp_pll, hw)
> +
> +#define clk_regs       (moon_regs + 0x000) /* G0 ~ CLKEN */
> +#define pll_regs       (moon_regs + 0x200) /* G4 ~ PLL */
> +static void __iomem *moon_regs;
> +
> +#define P_EXTCLK       BIT(16)
> +static const char * const parents[] =3D {

Can we use clk_parent_data instead?

> +       "pllsys",
> +       "extclk",
> +};
> +
> +static const u32 gates[] =3D {
> +       CLK_SYSTEM,
> +       CLK_RTC,
> +       CLK_IOCTL,
> +       CLK_IOP,
> +       CLK_OTPRX,
> +       CLK_NOC,
> +       CLK_BR,
> +       CLK_RBUS_L00,
> +       CLK_SPIFL,
> +       CLK_SDCTRL0,
> +       CLK_PERI0 | P_EXTCLK,
> +       CLK_A926,
> +       CLK_UMCTL2,
> +       CLK_PERI1 | P_EXTCLK,
> +
> +       CLK_DDR_PHY0,
> +       CLK_ACHIP,
> +       CLK_STC0,
> +       CLK_STC_AV0,
> +       CLK_STC_AV1,
> +       CLK_STC_AV2,
> +       CLK_UA0 | P_EXTCLK,
> +       CLK_UA1 | P_EXTCLK,
> +       CLK_UA2 | P_EXTCLK,
> +       CLK_UA3 | P_EXTCLK,
> +       CLK_UA4 | P_EXTCLK,
> +       CLK_HWUA | P_EXTCLK,
> +       CLK_DDC0,
> +       CLK_UADMA | P_EXTCLK,
> +
> +       CLK_CBDMA0,
> +       CLK_CBDMA1,
> +       CLK_SPI_COMBO_0,
> +       CLK_SPI_COMBO_1,
> +       CLK_SPI_COMBO_2,
> +       CLK_SPI_COMBO_3,
> +       CLK_AUD,
> +       CLK_USBC0,
> +       CLK_USBC1,
> +       CLK_UPHY0,
> +       CLK_UPHY1,
> +
> +       CLK_I2CM0,
> +       CLK_I2CM1,
> +       CLK_I2CM2,
> +       CLK_I2CM3,
> +       CLK_PMC,
> +       CLK_CARD_CTL0,
> +       CLK_CARD_CTL1,
> +
> +       CLK_CARD_CTL4,
> +       CLK_BCH,
> +       CLK_DDFCH,
> +       CLK_CSIIW0,
> +       CLK_CSIIW1,
> +       CLK_MIPICSI0,
> +       CLK_MIPICSI1,
> +
> +       CLK_HDMI_TX,
> +       CLK_VPOST,
> +
> +       CLK_TGEN,
> +       CLK_DMIX,
> +       CLK_TCON,
> +       CLK_INTERRUPT,
> +
> +       CLK_RGST,
> +       CLK_GPIO,
> +       CLK_RBUS_TOP,
> +
> +       CLK_MAILBOX,
> +       CLK_SPIND,
> +       CLK_I2C2CBUS,
> +       CLK_SEC,
> +       CLK_GPOST0,
> +       CLK_DVE,
> +
> +       CLK_OSD0,
> +       CLK_DISP_PWM,
> +       CLK_UADBG,
> +       CLK_DUMMY_MASTER,
> +       CLK_FIO_CTL,
> +       CLK_FPGA,
> +       CLK_L2SW,
> +       CLK_ICM,
> +       CLK_AXI_GLOBAL,
> +};
> +
> +static struct clk *clks[CLK_MAX];
> +static struct clk_onecell_data clk_data;
> +
> +static DEFINE_SPINLOCK(plla_lock);
> +static DEFINE_SPINLOCK(plle_lock);
> +static DEFINE_SPINLOCK(pllf_lock);
> +static DEFINE_SPINLOCK(pllsys_lock);
> +static DEFINE_SPINLOCK(plltv_lock);
> +
> +#define _M                     1000000UL
> +#define F_27M          (27 * _M)
> +
> +/******************************************** PLL_TV *******************=
************************/
> +
> +//#define PLLTV_STEP_DIR (?) /* Unit: HZ */
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
> +#ifdef PLLTV_STEP_DIR
> +       u32 step =3D (PLLTV_STEP_DIR > 0) ? PLLTV_STEP_DIR : -PLLTV_STEP_=
DIR;
> +       int calc_times =3D 1000000 / step;
> +#endif
> +       unsigned long fvco, nf;
> +
> +       /* check freq */
> +       if (freq < F_MIN) {
> +               pr_warn("%s: %s freq:%lu < F_MIN:%lu, round up\n",
> +                       __func__, clk_hw_get_name(&clk->hw), freq, F_MIN);
> +               freq =3D F_MIN;
> +       } else if (freq > F_MAX) {
> +               pr_warn("%s: %s freq:%lu > F_MAX:%lu, round down\n",
> +                       __func__, clk_hw_get_name(&clk->hw), freq, F_MAX);
> +               freq =3D F_MAX;
> +       }
> +
> +#ifdef PLLTV_STEP_DIR
> +       if ((freq % step) !=3D 0)
> +               freq +=3D step - (freq % step) + ((PLLTV_STEP_DIR > 0) ? =
0 : PLLTV_STEP_DIR);
> +#endif
> +
> +#ifdef PLLTV_STEP_DIR
> +CALC:
> +       if (!calc_times) {
> +               pr_err("%s: %s freq:%lu out of recalc times\n",
> +                      __func__, clk_hw_get_name(&clk->hw), freq);
> +               return -ETIMEOUT;
> +       }
> +#endif
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
> +               nf =3D fvco * m_table[m];
> +               n =3D nf / F_27M;
> +               if ((n * F_27M) =3D=3D nf)
> +                       break;
> +       }
> +       m =3D m_table[m];
> +
> +       if (!m) {
> +#ifdef PLLTV_STEP_DIR
> +               freq +=3D PLLTV_STEP_DIR;
> +               calc_times--;
> +               goto CALC;
> +#else

Please remove the debugging code.

> +               pr_err("%s: %s freq:%lu not found a valid setting\n",
> +                      __func__, clk_hw_get_name(&clk->hw), freq);
> +               return -EINVAL;
> +#endif
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
> +
> +static long plltv_fractional_div(struct sp_pll *clk, unsigned long freq)
> +{
> +       u32 m, r;
> +       u32 nint, nfra;
> +       u32 diff_min_quotient =3D 210000000, diff_min_remainder =3D 0;
> +       u32 diff_min_sign =3D 0;
> +       unsigned long fvco, nf, f, fout =3D 0;
> +       int sdm, ph;
> +
> +       /* check freq */
> +       if (freq < F_MIN) {
> +               pr_warn("%s: %s freq:%lu < F_MIN:%lu, round up\n",
> +                       __func__, clk_hw_get_name(&clk->hw), freq, F_MIN);
> +               freq =3D F_MIN;
> +       } else if (freq > F_MAX) {
> +               pr_warn("%s: %s freq:%lu > F_MAX:%lu, round down\n",
> +                       __func__, clk_hw_get_name(&clk->hw), freq, F_MAX);
> +               freq =3D F_MAX;
> +       }
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
> +
> +               /* SDM_MOD 0/1 */
> +               for (sdm =3D 0; sdm <=3D 1; sdm++) {
> +                       u32 mod =3D mods[sdm];
> +
> +                       /* DIVM 1~32 */
> +                       for (m =3D ms; m <=3D 32; m++) {
> +                               u32 diff_freq;
> +                               u32 diff_freq_quotient =3D 0, diff_freq_r=
emainder =3D 0;
> +                               u32 diff_freq_sign =3D 0; /* 0:Positive n=
umber, 1:Negative number */
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
> +                                       diff_freq =3D (f * (nint + pp[2])=
 / pp[0]) -
> +                                                               (f * (mod=
 - nfra) / mod / pp[4]);
> +                               else
> +                                       diff_freq =3D (f * (nint) / pp[0]=
);
> +
> +                               diff_freq_quotient  =3D diff_freq / m;
> +                               diff_freq_remainder =3D ((diff_freq % m) =
* 1000) / m;
> +
> +                               if (freq > diff_freq_quotient) {
> +                                       diff_freq_quotient  =3D freq - di=
ff_freq_quotient - 1;
> +                                       diff_freq_remainder =3D 1000 - di=
ff_freq_remainder;
> +                                       diff_freq_sign =3D 1;
> +                               } else {
> +                                       diff_freq_quotient =3D diff_freq_=
quotient - freq;
> +                                       diff_freq_sign =3D 0;
> +                               }
> +
> +                               if (diff_min_quotient > diff_freq_quotien=
t ||
> +                                   (diff_min_quotient =3D=3D diff_freq_q=
uotient &&
> +                                   diff_min_remainder > diff_freq_remain=
der)) {
> +                                       /* found a closer freq, save para=
meters */
> +                                       clk->p[SEL_FRA] =3D 1;
> +                                       clk->p[SDM_MOD] =3D sdm;
> +                                       clk->p[PH_SEL]  =3D ph;
> +                                       clk->p[NFRA]    =3D nfra;
> +                                       clk->p[DIVR]    =3D r;
> +                                       clk->p[DIVM]    =3D m;
> +
> +                                       fout =3D diff_freq / m;
> +                                       diff_min_quotient =3D diff_freq_q=
uotient;
> +                                       diff_min_remainder =3D diff_freq_=
remainder;
> +                                       diff_min_sign =3D diff_freq_sign;
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
> +       else
> +               return plltv_integer_div(clk, freq);
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
> +       clk_writel(reg, clk->reg);
> +
> +       reg  =3D HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
> +       clk_writel(reg, clk->reg + 4);
> +
> +       reg  =3D HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
> +       reg |=3D HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
> +       clk_writel(reg, clk->reg + 8);
> +}
> +
> +/******************************************** PLL_A ********************=
************************/
> +
> +/* from Q628_PLLs_REG_setting.xlsx */
> +struct {
> +       u32 rate;
> +       u32 regs[5];
> +} pa[] =3D {

Can this be const? and static?

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
> +               clk_writel(0xffff0000 | pp[i], clk->reg + (i * 4));
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
> +       return pa[i].rate;
> +}
> +
> +/******************************************* SP_PLL ********************=
************************/
> +
> +static long sp_pll_calc_div(struct sp_pll *clk, unsigned long rate)
> +{
> +       u32 fbdiv;
> +       u32 max =3D 1 << clk->div_width;
> +
> +       fbdiv =3D DIV_ROUND_CLOSEST(rate, clk->brate);
> +       if (fbdiv > max)
> +               fbdiv =3D max;
> +       return fbdiv;
> +}
> +
> +static long sp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                             unsigned long *prate)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +       long ret;
> +
> +       if (rate =3D=3D *prate)
> +               ret =3D *prate; /* bypass */
> +       else if (clk->div_width =3D=3D DIV_A) {
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
> +       u32 reg =3D clk_readl(clk->reg);
> +       unsigned long ret;
> +
> +       if (reg & BIT(clk->bp_bit)) {
> +               ret =3D prate; /* bypass */
> +       } else if (clk->div_width =3D=3D DIV_A) {
> +               ret =3D pa[clk->p[0]].rate;
> +       } else if (clk->div_width =3D=3D DIV_TV) {
> +               u32 m, r, reg2;
> +
> +               r =3D FIELD_GET(MASK_DIVR, clk_readl(clk->reg + 4));
> +               reg2 =3D clk_readl(clk->reg + 8);
> +               m =3D FIELD_GET(MASK_DIVM, reg2) + 1;
> +
> +               if (reg & BIT(1)) { /* SEL_FRA */
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
> +               u32 fbdiv =3D (reg >> clk->div_shift) & ((1 << clk->div_w=
idth) - 1);
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
> +
> +       reg =3D BIT(clk->bp_bit + 16); /* HIWORD_MASK */
> +
> +       if (rate =3D=3D prate)
> +               reg |=3D BIT(clk->bp_bit); /* bypass */
> +       else if (clk->div_width =3D=3D DIV_A)
> +               plla_set_rate(clk);
> +       else if (clk->div_width =3D=3D DIV_TV)
> +               plltv_set_rate(clk);
> +       else if (clk->div_width) {
> +               u32 fbdiv =3D sp_pll_calc_div(clk, rate);
> +               u32 mask =3D GENMASK(clk->div_shift + clk->div_width - 1,=
 clk->div_shift);
> +
> +               reg |=3D (mask << 16) | (((fbdiv - 1) << clk->div_shift) =
& mask);
> +       }
> +
> +       clk_writel(reg, clk->reg);
> +
> +       spin_unlock_irqrestore(clk->lock, flags);
> +
> +       return 0;
> +}
> +
> +static int sp_pll_enable(struct clk_hw *hw)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(clk->lock, flags);
> +       clk_writel(BIT(clk->pd_bit + 16) | BIT(clk->pd_bit), clk->reg); /=
* power up */
> +       spin_unlock_irqrestore(clk->lock, flags);
> +
> +       return 0;
> +}
> +
> +static void sp_pll_disable(struct clk_hw *hw)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(clk->lock, flags);
> +       clk_writel(BIT(clk->pd_bit + 16), clk->reg); /* power down */
> +       spin_unlock_irqrestore(clk->lock, flags);
> +}
> +
> +static int sp_pll_is_enabled(struct clk_hw *hw)
> +{
> +       struct sp_pll *clk =3D to_sp_pll(hw);
> +
> +       return clk_readl(clk->reg) & BIT(clk->pd_bit);
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
> +struct clk *clk_register_sp_pll(const char *name, const char *parent,
> +                               void __iomem *reg, int pd_bit, int bp_bit,
> +                               unsigned long brate, int shift, int width,
> +                               spinlock_t *lock)
> +{
> +       struct sp_pll *pll;
> +       struct clk *clk;
> +       struct clk_init_data initd =3D {
> +               .name =3D name,
> +               .parent_names =3D &parent,
> +               .ops =3D (bp_bit >=3D 0) ? &sp_pll_ops : &sp_pll_sub_ops,
> +               .num_parents =3D 1,
> +               .flags =3D CLK_IGNORE_UNUSED

Why? Preferably this flag is removed and either CLK_IS_CRITICAL is used,
with a comment indicating what is critical, or the clk is removed
entirely and driver probe just turns the clk on and forgets about it.

> +       };
> +
> +       pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       if (reg =3D=3D PLLSYS_CTL)
> +               initd.flags |=3D CLK_IS_CRITICAL;

Please comment why it is critical.

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
> +       clk =3D clk_register(NULL, &pll->hw);

Please use clk_hw_register

> +       if (WARN_ON(IS_ERR(clk))) {
> +               kfree(pll);
> +       } else {
> +               pr_info("%-20s%lu\n", name, clk_get_rate(clk));
> +               clk_register_clkdev(clk, NULL, name);
> +       }
> +
> +       return clk;
> +}
> +
> +static void __init sp_clk_setup(struct device_node *np)
> +{
> +       int i, j;
> +
> +       moon_regs =3D of_iomap(np, 0);

Why moon_ prefix?

> +       if (WARN_ON(!moon_regs))
> +               return; /* -ENXIO */
> +
> +       /* PLL_A */
> +       clks[PLL_A] =3D clk_register_sp_pll("plla", EXTCLK,
> +                                         PLLA_CTL, 11, 12, 27000000, 0, =
DIV_A, &plla_lock);
> +
> +       /* PLL_E */
> +       clks[PLL_E] =3D clk_register_sp_pll("plle", EXTCLK,
> +                                         PLLE_CTL, 6, 2, 50000000, 0, 0,=
 &plle_lock);
> +       clks[PLL_E_2P5] =3D clk_register_sp_pll("plle_2p5", "plle",
> +                                             PLLE_CTL, 13, -1, 2500000, =
0, 0, &plle_lock);
> +       clks[PLL_E_25] =3D clk_register_sp_pll("plle_25", "plle",
> +                                            PLLE_CTL, 12, -1, 25000000, =
0, 0, &plle_lock);
> +       clks[PLL_E_112P5] =3D clk_register_sp_pll("plle_112p5", "plle",
> +                                               PLLE_CTL, 11, -1, 1125000=
00, 0, 0, &plle_lock);
> +
> +       /* PLL_F */
> +       clks[PLL_F] =3D clk_register_sp_pll("pllf", EXTCLK,
> +                                         PLLF_CTL, 0, 10, 13500000, 1, 4=
, &pllf_lock);
> +
> +       /* PLL_TV */
> +       clks[PLL_TV] =3D clk_register_sp_pll("plltv", EXTCLK,
> +                                          PLLTV_CTL, 0, 15, 27000000, 0,=
 DIV_TV, &plltv_lock);
> +       clks[PLL_TV_A] =3D clk_register_divider(NULL, "plltv_a", "plltv",=
 0,
> +                                             PLLTV_CTL + 4, 5, 1,
> +                                             CLK_DIVIDER_POWER_OF_TWO, &=
plltv_lock);
> +       clk_register_clkdev(clks[PLL_TV_A], NULL, "plltv_a");
> +
> +       /* PLL_SYS */
> +       clks[PLL_SYS] =3D clk_register_sp_pll("pllsys", EXTCLK,
> +                                           PLLSYS_CTL, 10, 9, 13500000, =
0, 4, &pllsys_lock);
> +
> +       /* gates */
> +       for (i =3D 0; i < ARRAY_SIZE(gates); i++) {
> +               char s[10];
> +
> +               j =3D gates[i] & 0xffff;
> +               sprintf(s, "clken%02x", j);
> +               clks[j] =3D clk_register_gate(NULL, s, parents[gates[i] >=
> 16], CLK_IGNORE_UNUSED,

Please use hw based registration.

> +                                           clk_regs + (j >> 4) * 4, j & =
0x0f,
> +                                           CLK_GATE_HIWORD_MASK, NULL);
> +       }
> +
> +       clk_data.clks =3D clks;
> +       clk_data.clk_num =3D ARRAY_SIZE(clks);
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);

Please use a hw based provider instead of a clk one.

> +}
> +
> +CLK_OF_DECLARE(sp_clkc, "sunplus,sp7021-clkc", sp_clk_setup);

Why can't this be a platform driver?

> +
> +MODULE_AUTHOR("Qin Jian <qinjian@cqplus1.com>");
> +MODULE_DESCRIPTION("Sunplus SP7021 Clock Driver");
> +MODULE_LICENSE("GPL v2");

It's not a module, so these macros should be removed.
