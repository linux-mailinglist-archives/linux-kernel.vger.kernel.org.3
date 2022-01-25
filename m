Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0449A84F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1317699AbiAYDCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415407AbiAYBqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:46:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C63EC0A8875;
        Mon, 24 Jan 2022 17:39:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B468B8160D;
        Tue, 25 Jan 2022 01:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A71C340E5;
        Tue, 25 Jan 2022 01:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643074777;
        bh=5xtcGLULix70Ajmore5rhk1SufpnN6H8pFyvXyEoK10=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g7scaRmimXUmjhj1P4VNCLLpQ7c8MqDsKYlOv2oCk/v+S0YbRWRXbCjYL6Z4Cl6Qx
         6jch5YggWSi+6HGT9CCS29xfRVLYUEzQwtPYAQp1VUW8EPRCmhPjFq17qqQtNmzU4q
         XMjF/GJ0/A+E5zKnzQnC0KuMfom68kfexj7brqr/+0ua+GVmjDXmRzfIUIAQdDDkft
         y50xmmyyzrTq+1BhWgOcOnTVGG1HDrNqVVWGkceJAdZAYuRaDKBO79SFLdCEBJK6mp
         e7SNfk+JFjr5RhW7cueh9jsPr5/uPHJyaAsl5WoNs9m/8h/aq0tMYe99Th0I1ETZdb
         PUrXHXGWsY7vQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <34eeb839f4657491a704d00b532b2d8858eb35b6.1642751015.git.qinjian@cqplus1.com>
References: <cover.1642751015.git.qinjian@cqplus1.com> <34eeb839f4657491a704d00b532b2d8858eb35b6.1642751015.git.qinjian@cqplus1.com>
Subject: Re: [PATCH v8 06/10] clk: Add Sunplus SP7021 clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, broonie@kernel.org,
        arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Date:   Mon, 24 Jan 2022 17:39:35 -0800
User-Agent: alot/0.10
Message-Id: <20220125013936.D7A71C340E5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qin Jian (2022-01-20 23:53:14)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c5b3dc973..91656de22 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -334,6 +334,15 @@ config COMMON_CLK_VC5
>           This driver supports the IDT VersaClock 5 and VersaClock 6
>           programmable clock generators.
> =20
> +config COMMON_CLK_SP7021
> +       bool "Clock driver for Sunplus SP7021 SoC"
> +       default SOC_SP7021

Also would be good to have

	depends on SOC_SP7021 || COMPILE_TEST

> +       help
> +         This driver supports the Sunplus SP7021 SoC clocks.
> +         It implements SP7021 PLLs/gate.
> +         Not all features of the PLL are currently supported
> +         by the driver.
> +
>  config COMMON_CLK_STM32MP157
>         def_bool COMMON_CLK && MACH_STM32MP157
>         help
> diff --git a/drivers/clk/clk-sp7021.c b/drivers/clk/clk-sp7021.c
> new file mode 100644
> index 000000000..8a3e28a2a
> --- /dev/null
> +++ b/drivers/clk/clk-sp7021.c
> @@ -0,0 +1,753 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Copyright (C) Sunplus Technology Co., Ltd.
> + *       All rights reserved.
> + */
> +//#define DEBUG
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

IS the clkdev get path used? If not, please drop it.

> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/bitfield.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/sp-sp7021.h>
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
> +
> +#define F_CRITICAL     BIT(31) /* clock is critical */
> +#define F_EXTCLK       BIT(16) /* parent clock is EXTCLK */
> +const struct clk_parent_data parents[] =3D {

static? 'parents' is too generic, and this is in the global namespace.
Please make it driver specific.

> +       { .name =3D "pllsys" },
> +       { .name =3D "extclk" },
> +       { .name =3D "plle" },

The .name member of clk_parent_data shouldn't be used for new drivers or
bindings. Instead, use .fw_name or the .index, preferably the index so
the struct is smaller.

> +};
> +
> +#define PD_PLLSYS      (&parents[0])
> +#define PD_EXTCLK      (&parents[1])
> +#define PD_PLLE                (&parents[2])
> +
> +static const u32 gates[] =3D {

'gates' is too generic, please name this something driver specific.

> +       CLK_SYSTEM                      | F_CRITICAL,
> +       CLK_RTC,
> +       CLK_IOCTL                       | F_CRITICAL,
> +       CLK_IOP                         | F_CRITICAL,
> +       CLK_OTPRX,
> +       CLK_NOC,
> +       CLK_BR,
> +       CLK_RBUS_L00                    | F_CRITICAL,
> +       CLK_SPIFL,
> +       CLK_SDCTRL0                     | F_CRITICAL,
> +       CLK_PERI0       | F_EXTCLK,
> +       CLK_A926                        | F_CRITICAL,
> +       CLK_UMCTL2                      | F_CRITICAL,
> +       CLK_PERI1       | F_EXTCLK,
> +
> +       CLK_DDR_PHY0                    | F_CRITICAL,
> +       CLK_ACHIP                       | F_CRITICAL,

Do these gates have children? What is the benefit of modeling critical
clks that have no children? It would be simpler to make sure they're
enabled at driver probe time and then not do anything else and skip
registering them with the clk framework when they'll do nothing.

> +       CLK_STC0,
> +       CLK_STC_AV0,
> +       CLK_STC_AV1,
> +       CLK_STC_AV2,
> +       CLK_UA0         | F_EXTCLK,
> +       CLK_UA1         | F_EXTCLK,
> +       CLK_UA2         | F_EXTCLK,
> +       CLK_UA3         | F_EXTCLK,
> +       CLK_UA4         | F_EXTCLK,
> +       CLK_HWUA        | F_EXTCLK,
> +       CLK_DDC0,
> +       CLK_UADMA       | F_EXTCLK,
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
> +       CLK_INTERRUPT                   | F_CRITICAL,
> +
> +       CLK_RGST                        | F_CRITICAL,
> +       CLK_GPIO,
> +       CLK_RBUS_TOP                    | F_CRITICAL,
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
> +static DEFINE_SPINLOCK(plla_lock);
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

Just use clamp() and ignore the warnings?

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
> +       u32 df_quotient_min =3D 210000000;
> +       u32 df_remainder_min =3D 0;
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

Just use clamp() and ignore the warnings?

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
> +                               u32 df; /* diff freq */
> +                               u32 df_quotient =3D 0, df_remainder =3D 0;

Please leave these unassigned.

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
> +                               else
> +                                       df =3D (f * (nint) / pp[0]);
> +
> +                               df_quotient  =3D df / m;
> +                               df_remainder =3D ((df % m) * 1000) / m;
> +
> +                               if (freq > df_quotient) {
> +                                       df_quotient  =3D freq - df_quotie=
nt - 1;
> +                                       df_remainder =3D 1000 - df_remain=
der;
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
> +       u32 reg =3D readl(clk->reg);
> +       unsigned long ret;
> +
> +       if (reg & BIT(clk->bp_bit))
> +               ret =3D prate; /* bypass */
> +       else if (clk->div_width =3D=3D DIV_A)
> +               ret =3D pa[clk->p[0]].rate;
> +       else if (clk->div_width =3D=3D DIV_TV) {
> +               u32 m, r, reg2;
> +
> +               r =3D FIELD_GET(MASK_DIVR, readl(clk->reg + 4));
> +               reg2 =3D readl(clk->reg + 8);
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
> +
> +       reg =3D BIT(clk->bp_bit + 16); /* HIWORD_MASK */
> +
> +       if (rate =3D=3D prate)
> +               reg |=3D BIT(clk->bp_bit); /* bypass */
> +       else if (clk->div_width =3D=3D DIV_A)
> +               plla_set_rate(clk);
> +       else if (clk->div_width =3D=3D DIV_TV)
> +               plltv_set_rate(clk);

Please add braces to all these if arms, because the else if below has
one.

> +       else if (clk->div_width) {
> +               u32 fbdiv =3D sp_pll_calc_div(clk, rate);
> +               u32 mask =3D GENMASK(clk->div_shift + clk->div_width - 1,=
 clk->div_shift);
> +
> +               reg |=3D (mask << 16) | (((fbdiv - 1) << clk->div_shift) =
& mask);
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
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(clk->lock, flags);
> +       writel(BIT(clk->pd_bit + 16) | BIT(clk->pd_bit), clk->reg); /* po=
wer up */
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
> +       writel(BIT(clk->pd_bit + 16), clk->reg); /* power down */
> +       spin_unlock_irqrestore(clk->lock, flags);
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
> +struct clk_hw *sp_pll_register(struct device *dev, const char *name,
> +                              const struct clk_parent_data *parent_data,
> +                              void __iomem *reg, int pd_bit, int bp_bit,
> +                              unsigned long brate, int shift, int width,
> +                              spinlock_t *lock)
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
> +               hw =3D ERR_PTR(ret);
> +       } else {
> +               pr_debug("%-20s%lu\n", name, clk_hw_get_rate(hw));
> +               devm_clk_hw_register_clkdev(dev, hw, NULL, name);
> +       }
> +
> +       return hw;
> +}
> +
> +static int sp7021_clk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       int i, ret;
> +       struct clk_hw **hws;
> +       struct resource *res;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       sp_clk_base =3D devm_ioremap(dev, res->start, resource_size(res));

Use devm_platform_ioremap_resource()?

> +       if (WARN_ON(!sp_clk_base))

Drop the WARN_ON() as it already prints a stacktrace if things fail.

> +               return -ENXIO;
> +
> +       sp_clk_data =3D devm_kzalloc(dev, struct_size(sp_clk_data, hws, C=
LK_MAX),
> +                                  GFP_KERNEL);
> +       if (!sp_clk_data)
> +               return -ENOMEM;
> +
> +       hws =3D sp_clk_data->hws;
> +
> +       /* PLL_A */
> +       hws[PLL_A] =3D sp_pll_register(dev, "plla", PD_EXTCLK, PLLA_CTL,
> +                                    11, 12, 27000000, 0, DIV_A, &plla_lo=
ck);
> +       if (IS_ERR(hws[PLL_A]))
> +               return PTR_ERR(hws[PLL_A]);
> +
> +       /* PLL_E */
> +       hws[PLL_E] =3D sp_pll_register(dev, "plle", PD_EXTCLK, PLLE_CTL,
> +                                    6, 2, 50000000, 0, 0, &plle_lock);
> +       if (IS_ERR(hws[PLL_E]))
> +               return PTR_ERR(hws[PLL_E]);
> +       hws[PLL_E_2P5] =3D sp_pll_register(dev, "plle_2p5", PD_PLLE, PLLE=
_CTL,
> +                                        13, -1, 2500000, 0, 0, &plle_loc=
k);
> +       if (IS_ERR(hws[PLL_E_2P5]))
> +               return PTR_ERR(hws[PLL_E_2P5]);
> +       hws[PLL_E_25] =3D sp_pll_register(dev, "plle_25", PD_PLLE, PLLE_C=
TL,
> +                                       12, -1, 25000000, 0, 0, &plle_loc=
k);
> +       if (IS_ERR(hws[PLL_E_25]))
> +               return PTR_ERR(hws[PLL_E_25]);
> +       hws[PLL_E_112P5] =3D sp_pll_register(dev, "plle_112p5", PD_PLLE, =
PLLE_CTL,
> +                                          11, -1, 112500000, 0, 0, &plle=
_lock);
> +       if (IS_ERR(hws[PLL_E_112P5]))
> +               return PTR_ERR(hws[PLL_E_112P5]);
> +
> +       /* PLL_F */
> +       hws[PLL_F] =3D sp_pll_register(dev, "pllf", PD_EXTCLK, PLLF_CTL,
> +                                    0, 10, 13500000, 1, 4, &pllf_lock);
> +       if (IS_ERR(hws[PLL_F]))
> +               return PTR_ERR(hws[PLL_F]);
> +
> +       /* PLL_TV */
> +       hws[PLL_TV] =3D sp_pll_register(dev, "plltv", PD_EXTCLK, PLLTV_CT=
L,
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
> +       ret =3D devm_clk_hw_register_clkdev(dev, hws[PLL_TV_A], NULL, "pl=
ltv_a");
> +       if (ret)
> +               return ret;
> +
> +       /* PLL_SYS */
> +       hws[PLL_SYS] =3D sp_pll_register(dev, "pllsys", PD_EXTCLK, PLLSYS=
_CTL,
> +                                      10, 9, 13500000, 0, 4, &pllsys_loc=
k);
> +       if (IS_ERR(hws[PLL_SYS]))
> +               return PTR_ERR(hws[PLL_SYS]);
> +
> +       /* gates */
> +       for (i =3D 0; i < ARRAY_SIZE(gates); i++) {
> +               u32 f =3D gates[i];
> +               const char *parent_name =3D parents[!!(f & F_EXTCLK)].nam=
e;
> +               bool critical =3D f & F_CRITICAL;
> +               int j =3D f & 0xffff;
> +               char s[10];
> +
> +               sprintf(s, "clken%02x", j);
> +               hws[j] =3D clk_hw_register_gate(dev, s, parent_name,
> +                                             critical ? CLK_IS_CRITICAL =
: 0,
> +                                             clk_regs + (j >> 4) * 4,
> +                                             j & 0x0f,
> +                                             CLK_GATE_HIWORD_MASK, NULL);
> +               if (IS_ERR(hws[j]))
> +                       return PTR_ERR(hws[j]);
> +       }
> +
> +       sp_clk_data->num =3D CLK_MAX;
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, sp=
_clk_data);
> +}
> +
> +static const struct of_device_id sp7021_clk_dt_ids[] =3D {
> +       { .compatible =3D "sunplus,sp7021-clkc", },
> +       { }
> +};
> +
> +static struct platform_driver sp7021_clk_driver =3D {
> +       .probe  =3D sp7021_clk_probe,
> +       .driver =3D {
> +               .name =3D "sp7021-clk",
> +               .of_match_table =3D sp7021_clk_dt_ids,
> +       },
> +};
> +builtin_platform_driver(sp7021_clk_driver);

Can it be a module?
