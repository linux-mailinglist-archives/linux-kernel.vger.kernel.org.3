Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288AD4FB440
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245238AbiDKHAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245226AbiDKG7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:59:43 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BC2C3DDC4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:57:12 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1173:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Mon, 11 Apr 2022 14:49:05 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v13 5/9] clk: Add Sunplus SP7021 clock driver
Date:   Mon, 11 Apr 2022 14:49:55 +0800
Message-Id: <c66c84f1c834a16ca0cba6272b73644946a4d09b.1649659095.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1649659095.git.qinjian@cqplus1.com>
References: <cover.1649659095.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock driver for Sunplus SP7021 SoC.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
Fix the comments from Arnd.
---
 MAINTAINERS              |   1 +
 drivers/clk/Kconfig      |  10 +
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-sp7021.c | 721 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 733 insertions(+)
 create mode 100644 drivers/clk/clk-sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d8b420d0..8b77f7ae4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2746,6 +2746,7 @@ W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	drivers/clk/clk-sp7021.c
 F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/clock/sp-sp7021.h
 F:	include/dt-bindings/reset/sp-sp7021.h
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d4d67fbae..9eedeea78 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -351,6 +351,16 @@ config COMMON_CLK_VC5
 	  This driver supports the IDT VersaClock 5 and VersaClock 6
 	  programmable clock generators.
 
+config COMMON_CLK_SP7021
+	bool "Clock driver for Sunplus SP7021 SoC"
+	depends on SOC_SP7021 || COMPILE_TEST
+	default SOC_SP7021
+	help
+	  This driver supports the Sunplus SP7021 SoC clocks.
+	  It implements SP7021 PLLs/gate.
+	  Not all features of the PLL are currently supported
+	  by the driver.
+
 config COMMON_CLK_STM32MP157
 	def_bool COMMON_CLK && MACH_STM32MP157
 	help
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 16e588630..377ea7f7b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
 obj-$(CONFIG_COMMON_CLK_SI514)		+= clk-si514.o
 obj-$(CONFIG_COMMON_CLK_SI544)		+= clk-si544.o
 obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
+obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
 obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
 obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
 obj-$(CONFIG_COMMON_CLK_STM32MP157)	+= clk-stm32mp1.o
diff --git a/drivers/clk/clk-sp7021.c b/drivers/clk/clk-sp7021.c
new file mode 100644
index 000000000..f82231252
--- /dev/null
+++ b/drivers/clk/clk-sp7021.c
@@ -0,0 +1,721 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#include <linux/module.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/bitfield.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/sp-sp7021.h>
+
+#define REG(i)		(pll_regs + (i) * 4)
+
+#define PLLA_CTL	REG(7)
+#define PLLE_CTL	REG(12)
+#define PLLF_CTL	REG(13)
+#define PLLTV_CTL	REG(14)
+#define PLLSYS_CTL	REG(26)
+
+/* speical div_width values for PLLTV/PLLA */
+#define DIV_TV		33
+#define DIV_A		34
+
+/* PLLTV parameters */
+enum {
+	SEL_FRA,
+	SDM_MOD,
+	PH_SEL,
+	NFRA,
+	DIVR,
+	DIVN,
+	DIVM,
+	P_MAX
+};
+
+#define MASK_SEL_FRA	GENMASK(1, 1)
+#define MASK_SDM_MOD	GENMASK(2, 2)
+#define MASK_PH_SEL	GENMASK(4, 4)
+#define MASK_NFRA	GENMASK(12, 6)
+#define MASK_DIVR	GENMASK(8, 7)
+#define MASK_DIVN	GENMASK(7, 0)
+#define MASK_DIVM	GENMASK(14, 8)
+
+/* HIWORD_MASK FIELD_PREP */
+#define HWM_FIELD_PREP(mask, value)		\
+({						\
+	u32 m = mask;				\
+	(m << 16) | FIELD_PREP(m, value);	\
+})
+
+struct sp_pll {
+	struct clk_hw hw;
+	void __iomem *reg;
+	spinlock_t *lock;	/* lock for reg */
+	int div_shift;
+	int div_width;
+	int pd_bit;		/* power down bit idx */
+	int bp_bit;		/* bypass bit idx */
+	unsigned long brate;	/* base rate, TODO: replace brate with muldiv */
+	u32 p[P_MAX];		/* for hold PLLTV/PLLA parameters */
+};
+
+#define to_sp_pll(_hw)	container_of(_hw, struct sp_pll, hw)
+
+#define clk_regs	(sp_clk_base + 0x000) /* G0 ~ CLKEN */
+#define pll_regs	(sp_clk_base + 0x200) /* G4 ~ PLL */
+static void __iomem *sp_clk_base;
+static struct clk_hw_onecell_data *sp_clk_data;
+
+#define F_EXTCLK	BIT(16)	/* parent clock is EXTCLK */
+
+/* gates HW info: reg_index_shift | parent */
+static const u32 sp_clk_gates[] = {
+	0x12,
+	0x15,
+	0x16,
+	0x17,
+	0x19,
+	0x1b | F_EXTCLK,
+	0x1f | F_EXTCLK,
+	0x24,
+	0x25,
+	0x26,
+	0x27,
+	0x28 | F_EXTCLK,
+	0x29 | F_EXTCLK,
+	0x2a | F_EXTCLK,
+	0x2b | F_EXTCLK,
+	0x2c | F_EXTCLK,
+	0x2d | F_EXTCLK,
+	0x2e,
+	0x2f | F_EXTCLK,
+	0x30,
+	0x31,
+	0x32,
+	0x33,
+	0x34,
+	0x35,
+	0x36,
+	0x3a,
+	0x3b,
+	0x3d,
+	0x3e,
+	0x40,
+	0x41,
+	0x42,
+	0x43,
+	0x4d,
+	0x4e,
+	0x4f,
+	0x52,
+	0x54,
+	0x5b,
+	0x5c,
+	0x5d,
+	0x5e,
+	0x5f,
+	0x60,
+	0x65,
+	0x70,
+	0x71,
+	0x7a,
+	0x83,
+	0x96,
+	0x9a,
+	0x9b,
+	0x9d,
+	0x9e,
+	0x9f,
+	0xa0,
+	0xa2,
+	0xa3,
+	0xa5,
+	0xa6,
+	0xa7,
+	0xa8,
+	0xa9,
+};
+
+static DEFINE_SPINLOCK(plla_lock);
+static DEFINE_SPINLOCK(plle_lock);
+static DEFINE_SPINLOCK(pllf_lock);
+static DEFINE_SPINLOCK(pllsys_lock);
+static DEFINE_SPINLOCK(plltv_lock);
+
+#define _M		1000000UL
+#define F_27M		(27 * _M)
+
+/*********************************** PLL_TV **********************************/
+
+/* TODO: set proper FVCO range */
+#define FVCO_MIN	(100 * _M)
+#define FVCO_MAX	(200 * _M)
+
+#define F_MIN		(FVCO_MIN / 8)
+#define F_MAX		(FVCO_MAX)
+
+static long plltv_integer_div(struct sp_pll *clk, unsigned long freq)
+{
+	/* valid m values: 27M must be divisible by m, 0 means end */
+	static const u32 m_table[] = {
+		1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 16, 18, 20, 24, 25, 27, 30, 32, 0
+	};
+	u32 m, n, r;
+	unsigned long fvco, nf;
+
+	freq = clamp(freq, F_MIN, F_MAX);
+
+	/* DIVR 0~3 */
+	for (r = 0; r <= 3; r++) {
+		fvco = freq << r;
+		if (fvco <= FVCO_MAX)
+			break;
+	}
+
+	/* DIVM */
+	for (m = 0; m_table[m]; m++) {
+		nf = fvco * m_table[m];
+		n = nf / F_27M;
+		if ((n * F_27M) == nf)
+			break;
+	}
+	m = m_table[m];
+
+	if (!m) {
+		pr_err("%s: %s freq:%lu not found a valid setting\n",
+		       __func__, clk_hw_get_name(&clk->hw), freq);
+		return -EINVAL;
+	}
+
+	/* save parameters */
+	clk->p[SEL_FRA] = 0;
+	clk->p[DIVR]    = r;
+	clk->p[DIVN]    = n;
+	clk->p[DIVM]    = m;
+
+	return freq;
+}
+
+/* parameters for PLLTV fractional divider */
+static const u32 pt[][5] = {
+	/* conventional fractional */
+	{
+		1,			// factor
+		5,			// 5 * p0 (nint)
+		1,			// 1 * p0
+		F_27M,			// F_27M / p0
+		1,			// p0 / p2
+	},
+	/* phase rotation */
+	{
+		10,			// factor
+		54,			// 5.4 * p0 (nint)
+		2,			// 0.2 * p0
+		F_27M / 10,		// F_27M / p0
+		5,			// p0 / p2
+	},
+};
+
+static const u32 mods[] = { 91, 55 }; /* SDM_MOD mod values */
+
+static long plltv_fractional_div(struct sp_pll *clk, unsigned long freq)
+{
+	u32 m, r;
+	u32 nint, nfra;
+	u32 df_quotient_min = 210000000;
+	u32 df_remainder_min = 0;
+	unsigned long fvco, nf, f, fout = 0;
+	int sdm, ph;
+
+	freq = clamp(freq, F_MIN, F_MAX);
+
+	/* DIVR 0~3 */
+	for (r = 0; r <= 3; r++) {
+		fvco = freq << r;
+		if (fvco <= FVCO_MAX)
+			break;
+	}
+	f = F_27M >> r;
+
+	/* PH_SEL 1/0 */
+	for (ph = 1; ph >= 0; ph--) {
+		const u32 *pp = pt[ph];
+		u32 ms = 1;
+
+		/* SDM_MOD 0/1 */
+		for (sdm = 0; sdm <= 1; sdm++) {
+			u32 mod = mods[sdm];
+
+			/* DIVM 1~32 */
+			for (m = ms; m <= 32; m++) {
+				u32 df; /* diff freq */
+				u32 df_quotient, df_remainder;
+
+				nf = fvco * m;
+				nint = nf / pp[3];
+
+				if (nint < pp[1])
+					continue;
+				if (nint > pp[1])
+					break;
+
+				nfra = (((nf % pp[3]) * mod * pp[4]) + (F_27M / 2)) / F_27M;
+				if (nfra)
+					df = (f * (nint + pp[2]) / pp[0]) -
+					     (f * (mod - nfra) / mod / pp[4]);
+				else
+					df = (f * (nint) / pp[0]);
+
+				df_quotient  = df / m;
+				df_remainder = ((df % m) * 1000) / m;
+
+				if (freq > df_quotient) {
+					df_quotient  = freq - df_quotient - 1;
+					df_remainder = 1000 - df_remainder;
+				} else {
+					df_quotient = df_quotient - freq;
+				}
+
+				if (df_quotient_min > df_quotient ||
+				    (df_quotient_min == df_quotient &&
+				    df_remainder_min > df_remainder)) {
+					/* found a closer freq, save parameters */
+					clk->p[SEL_FRA] = 1;
+					clk->p[SDM_MOD] = sdm;
+					clk->p[PH_SEL]  = ph;
+					clk->p[NFRA]    = nfra;
+					clk->p[DIVR]    = r;
+					clk->p[DIVM]    = m;
+
+					fout = df / m;
+					df_quotient_min = df_quotient;
+					df_remainder_min = df_remainder;
+				}
+			}
+		}
+	}
+
+	if (!fout) {
+		pr_err("%s: %s freq:%lu not found a valid setting\n",
+		       __func__, clk_hw_get_name(&clk->hw), freq);
+		return -EINVAL;
+	}
+
+	return fout;
+}
+
+static long plltv_div(struct sp_pll *clk, unsigned long freq)
+{
+	if (freq % 100)
+		return plltv_fractional_div(clk, freq);
+
+	return plltv_integer_div(clk, freq);
+}
+
+static void plltv_set_rate(struct sp_pll *clk)
+{
+	u32 reg;
+
+	reg  = HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
+	reg |= HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
+	reg |= HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
+	reg |= HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
+	writel(reg, clk->reg);
+
+	reg  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
+	writel(reg, clk->reg + 4);
+
+	reg  = HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
+	reg |= HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
+	writel(reg, clk->reg + 8);
+}
+
+/*********************************** PLL_A ***********************************/
+
+/* from Q628_PLLs_REG_setting.xlsx */
+static const struct {
+	u32 rate;
+	u32 regs[5];
+} pa[] = {
+	{
+		.rate = 135475200,
+		.regs = {
+			0x4801,
+			0x02df,
+			0x248f,
+			0x0211,
+			0x33e9
+		}
+	},
+	{
+		.rate = 147456000,
+		.regs = {
+			0x4801,
+			0x1adf,
+			0x2490,
+			0x0349,
+			0x33e9
+		}
+	},
+	{
+		.rate = 196608000,
+		.regs = {
+			0x4801,
+			0x42ef,
+			0x2495,
+			0x01c6,
+			0x33e9
+		}
+	},
+};
+
+static void plla_set_rate(struct sp_pll *clk)
+{
+	const u32 *pp = pa[clk->p[0]].regs;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pa->regs); i++)
+		writel(0xffff0000 | pp[i], clk->reg + (i * 4));
+}
+
+static long plla_round_rate(struct sp_pll *clk, unsigned long rate)
+{
+	int i = ARRAY_SIZE(pa);
+
+	while (--i) {
+		if (rate >= pa[i].rate)
+			break;
+	}
+	clk->p[0] = i;
+
+	return pa[i].rate;
+}
+
+/********************************** SP_PLL ***********************************/
+
+static long sp_pll_calc_div(struct sp_pll *clk, unsigned long rate)
+{
+	u32 fbdiv;
+	u32 max = 1 << clk->div_width;
+
+	fbdiv = DIV_ROUND_CLOSEST(rate, clk->brate);
+	if (fbdiv > max)
+		fbdiv = max;
+
+	return fbdiv;
+}
+
+static long sp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *prate)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+	long ret;
+
+	if (rate == *prate) {
+		ret = *prate; /* bypass */
+	} else if (clk->div_width == DIV_A) {
+		ret = plla_round_rate(clk, rate);
+	} else if (clk->div_width == DIV_TV) {
+		ret = plltv_div(clk, rate);
+		if (ret < 0)
+			ret = *prate;
+	} else {
+		ret = sp_pll_calc_div(clk, rate) * clk->brate;
+	}
+
+	return ret;
+}
+
+static unsigned long sp_pll_recalc_rate(struct clk_hw *hw,
+					unsigned long prate)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+	u32 reg = readl(clk->reg);
+	unsigned long ret;
+
+	if (reg & BIT(clk->bp_bit)) {
+		ret = prate; /* bypass */
+	} else if (clk->div_width == DIV_A) {
+		ret = pa[clk->p[0]].rate;
+	} else if (clk->div_width == DIV_TV) {
+		u32 m, r, reg2;
+
+		r = FIELD_GET(MASK_DIVR, readl(clk->reg + 4));
+		reg2 = readl(clk->reg + 8);
+		m = FIELD_GET(MASK_DIVM, reg2) + 1;
+
+		if (reg & BIT(1)) { /* SEL_FRA */
+			/* fractional divider */
+			u32 sdm  = FIELD_GET(MASK_SDM_MOD, reg);
+			u32 ph   = FIELD_GET(MASK_PH_SEL, reg);
+			u32 nfra = FIELD_GET(MASK_NFRA, reg);
+			const u32 *pp = pt[ph];
+
+			ret = prate >> r;
+			ret = (ret * (pp[1] + pp[2]) / pp[0]) -
+				  (ret * (mods[sdm] - nfra) / mods[sdm] / pp[4]);
+			ret /= m;
+		} else {
+			/* integer divider */
+			u32 n = FIELD_GET(MASK_DIVN, reg2) + 1;
+
+			ret = (prate / m * n) >> r;
+		}
+	} else {
+		u32 fbdiv = ((reg >> clk->div_shift) & ((1 << clk->div_width) - 1)) + 1;
+
+		ret = clk->brate * fbdiv;
+	}
+
+	return ret;
+}
+
+static int sp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long prate)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(clk->lock, flags);
+
+	reg = BIT(clk->bp_bit + 16); /* HIWORD_MASK */
+
+	if (rate == prate) {
+		reg |= BIT(clk->bp_bit); /* bypass */
+	} else if (clk->div_width == DIV_A) {
+		plla_set_rate(clk);
+	} else if (clk->div_width == DIV_TV) {
+		plltv_set_rate(clk);
+	} else if (clk->div_width) {
+		u32 fbdiv = sp_pll_calc_div(clk, rate);
+		u32 mask = GENMASK(clk->div_shift + clk->div_width - 1, clk->div_shift);
+
+		reg |= (mask << 16) | (((fbdiv - 1) << clk->div_shift) & mask);
+	}
+
+	writel(reg, clk->reg);
+
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return 0;
+}
+
+static int sp_pll_enable(struct clk_hw *hw)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+
+	writel(BIT(clk->pd_bit + 16) | BIT(clk->pd_bit), clk->reg); /* power up */
+
+	return 0;
+}
+
+static void sp_pll_disable(struct clk_hw *hw)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+
+	writel(BIT(clk->pd_bit + 16), clk->reg); /* power down */
+}
+
+static int sp_pll_is_enabled(struct clk_hw *hw)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+
+	return readl(clk->reg) & BIT(clk->pd_bit);
+}
+
+static const struct clk_ops sp_pll_ops = {
+	.enable = sp_pll_enable,
+	.disable = sp_pll_disable,
+	.is_enabled = sp_pll_is_enabled,
+	.round_rate = sp_pll_round_rate,
+	.recalc_rate = sp_pll_recalc_rate,
+	.set_rate = sp_pll_set_rate
+};
+
+static const struct clk_ops sp_pll_sub_ops = {
+	.enable = sp_pll_enable,
+	.disable = sp_pll_disable,
+	.is_enabled = sp_pll_is_enabled,
+	.recalc_rate = sp_pll_recalc_rate,
+};
+
+static void dbg_clk(struct clk_hw *hw)
+{
+	const char *name = clk_hw_get_name(hw);
+	unsigned long rate = clk_hw_get_rate(hw);
+
+	pr_debug("%-20s%lu\n", name, rate);
+}
+
+struct clk_hw *sp_pll_register(struct device *dev, const char *name,
+			       const struct clk_parent_data *parent_data,
+			       void __iomem *reg, int pd_bit, int bp_bit,
+			       unsigned long brate, int shift, int width,
+			       spinlock_t *lock)
+{
+	struct sp_pll *pll;
+	struct clk_hw *hw;
+	struct clk_init_data initd = {
+		.name = name,
+		.parent_data = parent_data,
+		.ops = (bp_bit >= 0) ? &sp_pll_ops : &sp_pll_sub_ops,
+		.num_parents = 1,
+		/* system clock, should not be disabled */
+		.flags = (reg == PLLSYS_CTL) ? CLK_IS_CRITICAL : 0,
+	};
+	int ret;
+
+	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->hw.init = &initd;
+	pll->reg = reg;
+	pll->pd_bit = pd_bit;
+	pll->bp_bit = bp_bit;
+	pll->brate = brate;
+	pll->div_shift = shift;
+	pll->div_width = width;
+	pll->lock = lock;
+
+	hw = &pll->hw;
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+	dbg_clk(hw);
+
+	return hw;
+}
+
+static int sp7021_clk_probe(struct platform_device *pdev)
+{
+	static const u32 sp_clken[] = {
+		0x67ef, 0x03ff, 0xff03, 0xfff0, 0x0004, /* G0.1~5  */
+		0x0000, 0x8000, 0xffff, 0x0040, 0x0000, /* G0.6~10 */
+	};
+	static struct clk_parent_data pd_ext, pd_sys, pd_e;
+	struct device *dev = &pdev->dev;
+	struct clk_hw **hws;
+	struct resource *res;
+	int i;
+
+	/* This memory region include multi HW regs in discontinuous order.
+	 * clk driver used some discontinuous areas in the memory region.
+	 * Using devm_platform_ioremap_resource() would conflicted with other drivers.
+	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sp_clk_base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!sp_clk_base)
+		return -ENXIO;
+
+	/* enable default clks */
+	for (i = 0; i < ARRAY_SIZE(sp_clken); i++)
+		writel((sp_clken[i] << 16) | sp_clken[i], sp_clk_base + 4 * (1 + i));
+
+	sp_clk_data = devm_kzalloc(dev, struct_size(sp_clk_data, hws, CLK_MAX),
+				   GFP_KERNEL);
+	if (!sp_clk_data)
+		return -ENOMEM;
+
+	hws = sp_clk_data->hws;
+	pd_ext.fw_name = "extclk";
+
+	/* PLL_A */
+	hws[PLL_A] = sp_pll_register(dev, "plla", &pd_ext, PLLA_CTL,
+				     11, 12, 27000000, 0, DIV_A, &plla_lock);
+	if (IS_ERR(hws[PLL_A]))
+		return PTR_ERR(hws[PLL_A]);
+
+	/* PLL_E */
+	hws[PLL_E] = sp_pll_register(dev, "plle", &pd_ext, PLLE_CTL,
+				     6, 2, 50000000, 0, 0, &plle_lock);
+	if (IS_ERR(hws[PLL_E]))
+		return PTR_ERR(hws[PLL_E]);
+	pd_e.hw = hws[PLL_E];
+	hws[PLL_E_2P5] = sp_pll_register(dev, "plle_2p5", &pd_e, PLLE_CTL,
+					 13, -1, 2500000, 0, 0, &plle_lock);
+	if (IS_ERR(hws[PLL_E_2P5]))
+		return PTR_ERR(hws[PLL_E_2P5]);
+	hws[PLL_E_25] = sp_pll_register(dev, "plle_25", &pd_e, PLLE_CTL,
+					12, -1, 25000000, 0, 0, &plle_lock);
+	if (IS_ERR(hws[PLL_E_25]))
+		return PTR_ERR(hws[PLL_E_25]);
+	hws[PLL_E_112P5] = sp_pll_register(dev, "plle_112p5", &pd_e, PLLE_CTL,
+					   11, -1, 112500000, 0, 0, &plle_lock);
+	if (IS_ERR(hws[PLL_E_112P5]))
+		return PTR_ERR(hws[PLL_E_112P5]);
+
+	/* PLL_F */
+	hws[PLL_F] = sp_pll_register(dev, "pllf", &pd_ext, PLLF_CTL,
+				     0, 10, 13500000, 1, 4, &pllf_lock);
+	if (IS_ERR(hws[PLL_F]))
+		return PTR_ERR(hws[PLL_F]);
+
+	/* PLL_TV */
+	hws[PLL_TV] = sp_pll_register(dev, "plltv", &pd_ext, PLLTV_CTL,
+				      0, 15, 27000000, 0, DIV_TV, &plltv_lock);
+	if (IS_ERR(hws[PLL_TV]))
+		return PTR_ERR(hws[PLL_TV]);
+	hws[PLL_TV_A] = devm_clk_hw_register_divider(dev, "plltv_a", "plltv", 0,
+						     PLLTV_CTL + 4, 5, 1,
+						     CLK_DIVIDER_POWER_OF_TWO,
+						     &plltv_lock);
+	if (IS_ERR(hws[PLL_TV_A]))
+		return PTR_ERR(hws[PLL_TV_A]);
+	dbg_clk(hws[PLL_TV_A]);
+
+	/* PLL_SYS */
+	hws[PLL_SYS] = sp_pll_register(dev, "pllsys", &pd_ext, PLLSYS_CTL,
+				       10, 9, 13500000, 0, 4, &pllsys_lock);
+	if (IS_ERR(hws[PLL_SYS]))
+		return PTR_ERR(hws[PLL_SYS]);
+	pd_sys.hw = hws[PLL_SYS];
+
+	/* gates */
+	for (i = 0; i < ARRAY_SIZE(sp_clk_gates); i++) {
+		char name[10];
+		u32 f = sp_clk_gates[i];
+		int j = f & 0xffff;
+		struct clk_parent_data *pd = (f & F_EXTCLK) ? &pd_ext : &pd_sys;
+
+		sprintf(name, "%02d_0x%02x", i, j);
+		hws[i] = clk_hw_register_gate_parent_data(dev, name, pd, 0,
+							  clk_regs + (j >> 4) * 4,
+							  j & 0x0f,
+							  CLK_GATE_HIWORD_MASK,
+							  NULL);
+		if (IS_ERR(hws[i]))
+			return PTR_ERR(hws[i]);
+		dbg_clk(hws[i]);
+	}
+
+	sp_clk_data->num = CLK_MAX;
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, sp_clk_data);
+}
+
+static const struct of_device_id sp7021_clk_dt_ids[] = {
+	{ .compatible = "sunplus,sp7021-clkc", },
+	{ }
+};
+
+static struct platform_driver sp7021_clk_driver = {
+	.probe  = sp7021_clk_probe,
+	.driver = {
+		.name = "sp7021-clk",
+		.of_match_table = sp7021_clk_dt_ids,
+	},
+};
+module_platform_driver(sp7021_clk_driver);
+
+MODULE_AUTHOR("Sunplus Technology");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Clock driver for Sunplus SP7021 SoC");
-- 
2.33.1

