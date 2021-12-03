Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960374672CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379018AbhLCHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:46:20 -0500
Received: from [113.204.237.245] ([113.204.237.245]:44216 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1378987AbhLCHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:46:04 -0500
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(21484:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 03 Dec 2021 15:35:51 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v5 06/10] clk: Add Sunplus SP7021 clock driver
Date:   Fri,  3 Dec 2021 15:34:23 +0800
Message-Id: <8d23a5e00d870173993032c6a68fb5f48182691d.1638515726.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638515726.git.qinjian@cqplus1.com>
References: <cover.1638515726.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock driver for Sunplus SP7021 SoC.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS              |   1 +
 drivers/clk/Kconfig      |   9 +
 drivers/clk/Makefile     |   1 +
 drivers/clk/clk-sp7021.c | 738 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 749 insertions(+)
 create mode 100644 drivers/clk/clk-sp7021.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 90ebb823f..5069f552f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2663,6 +2663,7 @@ W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	drivers/clk/clk-sp7021.c
 F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/clock/sp-sp7021.h
 F:	include/dt-bindings/reset/sp-sp7021.h
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c5b3dc973..b92a176c7 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -334,6 +334,15 @@ config COMMON_CLK_VC5
 	  This driver supports the IDT VersaClock 5 and VersaClock 6
 	  programmable clock generators.
 
+config COMMON_CLK_SP7021
+	bool "Clock driver for Sunplus SP7021 SoC"
+	help
+	  This driver supports the Sunplus SP7021 SoC clocks.
+	  It implements SP7021 PLLs/gate.
+	  Not all features of the PLL are currently supported
+	  by the driver.
+	  This driver is selected automatically by platform config.
+
 config COMMON_CLK_STM32MP157
 	def_bool COMMON_CLK && MACH_STM32MP157
 	help
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e42312121..f15bb5070 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_COMMON_CLK_SI5351)		+= clk-si5351.o
 obj-$(CONFIG_COMMON_CLK_SI514)		+= clk-si514.o
 obj-$(CONFIG_COMMON_CLK_SI544)		+= clk-si544.o
 obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
+obj-$(CONFIG_COMMON_CLK_SP7021)		+= clk-sp7021.o
 obj-$(CONFIG_COMMON_CLK_STM32F)		+= clk-stm32f4.o
 obj-$(CONFIG_COMMON_CLK_STM32H7)	+= clk-stm32h7.o
 obj-$(CONFIG_COMMON_CLK_STM32MP157)	+= clk-stm32mp1.o
diff --git a/drivers/clk/clk-sp7021.c b/drivers/clk/clk-sp7021.c
new file mode 100644
index 000000000..040578e82
--- /dev/null
+++ b/drivers/clk/clk-sp7021.c
@@ -0,0 +1,738 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+//#define DEBUG
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/bitfield.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <dt-bindings/clock/sp-sp7021.h>
+
+#ifndef clk_readl
+#define clk_readl  readl
+#define clk_writel writel
+#endif
+
+#define REG(i)		(pll_regs + (i) * 4)
+
+#define PLLA_CTL	REG(7)
+#define PLLE_CTL	REG(12)
+#define PLLF_CTL	REG(13)
+#define PLLTV_CTL	REG(14)
+#define PLLSYS_CTL	REG(26)
+
+#define EXTCLK		"extclk"
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
+#define MASK_PH_SEL		GENMASK(4, 4)
+#define MASK_NFRA		GENMASK(12, 6)
+#define MASK_DIVR		GENMASK(8, 7)
+#define MASK_DIVN		GENMASK(7, 0)
+#define MASK_DIVM		GENMASK(14, 8)
+
+/* HIWORD_MASK FIELD_PREP */
+#define HWM_FIELD_PREP(mask, value) \
+({\
+	u32 m = mask; \
+	(m << 16) | FIELD_PREP(m, value); \
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
+	u32 p[P_MAX];	/* for hold PLLTV/PLLA parameters */
+};
+
+#define to_sp_pll(_hw)	container_of(_hw, struct sp_pll, hw)
+
+#define clk_regs	(moon_regs + 0x000) /* G0 ~ CLKEN */
+#define pll_regs	(moon_regs + 0x200) /* G4 ~ PLL */
+static void __iomem *moon_regs;
+
+#define P_EXTCLK	BIT(16)
+static const char * const parents[] = {
+	"pllsys",
+	"extclk",
+};
+
+static const u32 gates[] = {
+	CLK_SYSTEM,
+	CLK_RTC,
+	CLK_IOCTL,
+	CLK_IOP,
+	CLK_OTPRX,
+	CLK_NOC,
+	CLK_BR,
+	CLK_RBUS_L00,
+	CLK_SPIFL,
+	CLK_SDCTRL0,
+	CLK_PERI0 | P_EXTCLK,
+	CLK_A926,
+	CLK_UMCTL2,
+	CLK_PERI1 | P_EXTCLK,
+
+	CLK_DDR_PHY0,
+	CLK_ACHIP,
+	CLK_STC0,
+	CLK_STC_AV0,
+	CLK_STC_AV1,
+	CLK_STC_AV2,
+	CLK_UA0 | P_EXTCLK,
+	CLK_UA1 | P_EXTCLK,
+	CLK_UA2 | P_EXTCLK,
+	CLK_UA3 | P_EXTCLK,
+	CLK_UA4 | P_EXTCLK,
+	CLK_HWUA | P_EXTCLK,
+	CLK_DDC0,
+	CLK_UADMA | P_EXTCLK,
+
+	CLK_CBDMA0,
+	CLK_CBDMA1,
+	CLK_SPI_COMBO_0,
+	CLK_SPI_COMBO_1,
+	CLK_SPI_COMBO_2,
+	CLK_SPI_COMBO_3,
+	CLK_AUD,
+	CLK_USBC0,
+	CLK_USBC1,
+	CLK_UPHY0,
+	CLK_UPHY1,
+
+	CLK_I2CM0,
+	CLK_I2CM1,
+	CLK_I2CM2,
+	CLK_I2CM3,
+	CLK_PMC,
+	CLK_CARD_CTL0,
+	CLK_CARD_CTL1,
+
+	CLK_CARD_CTL4,
+	CLK_BCH,
+	CLK_DDFCH,
+	CLK_CSIIW0,
+	CLK_CSIIW1,
+	CLK_MIPICSI0,
+	CLK_MIPICSI1,
+
+	CLK_HDMI_TX,
+	CLK_VPOST,
+
+	CLK_TGEN,
+	CLK_DMIX,
+	CLK_TCON,
+	CLK_INTERRUPT,
+
+	CLK_RGST,
+	CLK_GPIO,
+	CLK_RBUS_TOP,
+
+	CLK_MAILBOX,
+	CLK_SPIND,
+	CLK_I2C2CBUS,
+	CLK_SEC,
+	CLK_GPOST0,
+	CLK_DVE,
+
+	CLK_OSD0,
+	CLK_DISP_PWM,
+	CLK_UADBG,
+	CLK_DUMMY_MASTER,
+	CLK_FIO_CTL,
+	CLK_FPGA,
+	CLK_L2SW,
+	CLK_ICM,
+	CLK_AXI_GLOBAL,
+};
+
+static struct clk *clks[CLK_MAX];
+static struct clk_onecell_data clk_data;
+
+static DEFINE_SPINLOCK(plla_lock);
+static DEFINE_SPINLOCK(plle_lock);
+static DEFINE_SPINLOCK(pllf_lock);
+static DEFINE_SPINLOCK(pllsys_lock);
+static DEFINE_SPINLOCK(plltv_lock);
+
+#define _M			1000000UL
+#define F_27M		(27 * _M)
+
+/******************************************** PLL_TV *******************************************/
+
+//#define PLLTV_STEP_DIR (?) /* Unit: HZ */
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
+#ifdef PLLTV_STEP_DIR
+	u32 step = (PLLTV_STEP_DIR > 0) ? PLLTV_STEP_DIR : -PLLTV_STEP_DIR;
+	int calc_times = 1000000 / step;
+#endif
+	unsigned long fvco, nf;
+
+	/* check freq */
+	if (freq < F_MIN) {
+		pr_warn("%s: %s freq:%lu < F_MIN:%lu, round up\n",
+			__func__, clk_hw_get_name(&clk->hw), freq, F_MIN);
+		freq = F_MIN;
+	} else if (freq > F_MAX) {
+		pr_warn("%s: %s freq:%lu > F_MAX:%lu, round down\n",
+			__func__, clk_hw_get_name(&clk->hw), freq, F_MAX);
+		freq = F_MAX;
+	}
+
+#ifdef PLLTV_STEP_DIR
+	if ((freq % step) != 0)
+		freq += step - (freq % step) + ((PLLTV_STEP_DIR > 0) ? 0 : PLLTV_STEP_DIR);
+#endif
+
+#ifdef PLLTV_STEP_DIR
+CALC:
+	if (!calc_times) {
+		pr_err("%s: %s freq:%lu out of recalc times\n",
+		       __func__, clk_hw_get_name(&clk->hw), freq);
+		return -ETIMEOUT;
+	}
+#endif
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
+#ifdef PLLTV_STEP_DIR
+		freq += PLLTV_STEP_DIR;
+		calc_times--;
+		goto CALC;
+#else
+		pr_err("%s: %s freq:%lu not found a valid setting\n",
+		       __func__, clk_hw_get_name(&clk->hw), freq);
+		return -EINVAL;
+#endif
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
+	u32 diff_min_quotient = 210000000, diff_min_remainder = 0;
+	u32 diff_min_sign = 0;
+	unsigned long fvco, nf, f, fout = 0;
+	int sdm, ph;
+
+	/* check freq */
+	if (freq < F_MIN) {
+		pr_warn("%s: %s freq:%lu < F_MIN:%lu, round up\n",
+			__func__, clk_hw_get_name(&clk->hw), freq, F_MIN);
+		freq = F_MIN;
+	} else if (freq > F_MAX) {
+		pr_warn("%s: %s freq:%lu > F_MAX:%lu, round down\n",
+			__func__, clk_hw_get_name(&clk->hw), freq, F_MAX);
+		freq = F_MAX;
+	}
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
+				u32 diff_freq;
+				u32 diff_freq_quotient = 0, diff_freq_remainder = 0;
+				u32 diff_freq_sign = 0; /* 0:Positive number, 1:Negative number */
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
+					diff_freq = (f * (nint + pp[2]) / pp[0]) -
+								(f * (mod - nfra) / mod / pp[4]);
+				else
+					diff_freq = (f * (nint) / pp[0]);
+
+				diff_freq_quotient  = diff_freq / m;
+				diff_freq_remainder = ((diff_freq % m) * 1000) / m;
+
+				if (freq > diff_freq_quotient) {
+					diff_freq_quotient  = freq - diff_freq_quotient - 1;
+					diff_freq_remainder = 1000 - diff_freq_remainder;
+					diff_freq_sign = 1;
+				} else {
+					diff_freq_quotient = diff_freq_quotient - freq;
+					diff_freq_sign = 0;
+				}
+
+				if (diff_min_quotient > diff_freq_quotient ||
+				    (diff_min_quotient == diff_freq_quotient &&
+				    diff_min_remainder > diff_freq_remainder)) {
+					/* found a closer freq, save parameters */
+					clk->p[SEL_FRA] = 1;
+					clk->p[SDM_MOD] = sdm;
+					clk->p[PH_SEL]  = ph;
+					clk->p[NFRA]    = nfra;
+					clk->p[DIVR]    = r;
+					clk->p[DIVM]    = m;
+
+					fout = diff_freq / m;
+					diff_min_quotient = diff_freq_quotient;
+					diff_min_remainder = diff_freq_remainder;
+					diff_min_sign = diff_freq_sign;
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
+	else
+		return plltv_integer_div(clk, freq);
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
+	clk_writel(reg, clk->reg);
+
+	reg  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
+	clk_writel(reg, clk->reg + 4);
+
+	reg  = HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
+	reg |= HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
+	clk_writel(reg, clk->reg + 8);
+}
+
+/******************************************** PLL_A ********************************************/
+
+/* from Q628_PLLs_REG_setting.xlsx */
+struct {
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
+		clk_writel(0xffff0000 | pp[i], clk->reg + (i * 4));
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
+	return pa[i].rate;
+}
+
+/******************************************* SP_PLL ********************************************/
+
+static long sp_pll_calc_div(struct sp_pll *clk, unsigned long rate)
+{
+	u32 fbdiv;
+	u32 max = 1 << clk->div_width;
+
+	fbdiv = DIV_ROUND_CLOSEST(rate, clk->brate);
+	if (fbdiv > max)
+		fbdiv = max;
+	return fbdiv;
+}
+
+static long sp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *prate)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+	long ret;
+
+	if (rate == *prate)
+		ret = *prate; /* bypass */
+	else if (clk->div_width == DIV_A) {
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
+	u32 reg = clk_readl(clk->reg);
+	unsigned long ret;
+
+	if (reg & BIT(clk->bp_bit)) {
+		ret = prate; /* bypass */
+	} else if (clk->div_width == DIV_A) {
+		ret = pa[clk->p[0]].rate;
+	} else if (clk->div_width == DIV_TV) {
+		u32 m, r, reg2;
+
+		r = FIELD_GET(MASK_DIVR, clk_readl(clk->reg + 4));
+		reg2 = clk_readl(clk->reg + 8);
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
+		u32 fbdiv = (reg >> clk->div_shift) & ((1 << clk->div_width) - 1);
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
+	if (rate == prate)
+		reg |= BIT(clk->bp_bit); /* bypass */
+	else if (clk->div_width == DIV_A)
+		plla_set_rate(clk);
+	else if (clk->div_width == DIV_TV)
+		plltv_set_rate(clk);
+	else if (clk->div_width) {
+		u32 fbdiv = sp_pll_calc_div(clk, rate);
+		u32 mask = GENMASK(clk->div_shift + clk->div_width - 1, clk->div_shift);
+
+		reg |= (mask << 16) | (((fbdiv - 1) << clk->div_shift) & mask);
+	}
+
+	clk_writel(reg, clk->reg);
+
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return 0;
+}
+
+static int sp_pll_enable(struct clk_hw *hw)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(clk->lock, flags);
+	clk_writel(BIT(clk->pd_bit + 16) | BIT(clk->pd_bit), clk->reg); /* power up */
+	spin_unlock_irqrestore(clk->lock, flags);
+
+	return 0;
+}
+
+static void sp_pll_disable(struct clk_hw *hw)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(clk->lock, flags);
+	clk_writel(BIT(clk->pd_bit + 16), clk->reg); /* power down */
+	spin_unlock_irqrestore(clk->lock, flags);
+}
+
+static int sp_pll_is_enabled(struct clk_hw *hw)
+{
+	struct sp_pll *clk = to_sp_pll(hw);
+
+	return clk_readl(clk->reg) & BIT(clk->pd_bit);
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
+struct clk *clk_register_sp_pll(const char *name, const char *parent,
+				void __iomem *reg, int pd_bit, int bp_bit,
+				unsigned long brate, int shift, int width,
+				spinlock_t *lock)
+{
+	struct sp_pll *pll;
+	struct clk *clk;
+	struct clk_init_data initd = {
+		.name = name,
+		.parent_names = &parent,
+		.ops = (bp_bit >= 0) ? &sp_pll_ops : &sp_pll_sub_ops,
+		.num_parents = 1,
+		.flags = CLK_IGNORE_UNUSED
+	};
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	if (reg == PLLSYS_CTL)
+		initd.flags |= CLK_IS_CRITICAL;
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
+	clk = clk_register(NULL, &pll->hw);
+	if (WARN_ON(IS_ERR(clk))) {
+		kfree(pll);
+	} else {
+		pr_info("%-20s%lu\n", name, clk_get_rate(clk));
+		clk_register_clkdev(clk, NULL, name);
+	}
+
+	return clk;
+}
+
+static void __init sp_clk_setup(struct device_node *np)
+{
+	int i, j;
+
+	moon_regs = of_iomap(np, 0);
+	if (WARN_ON(!moon_regs))
+		return; /* -ENXIO */
+
+	/* PLL_A */
+	clks[PLL_A] = clk_register_sp_pll("plla", EXTCLK,
+					  PLLA_CTL, 11, 12, 27000000, 0, DIV_A, &plla_lock);
+
+	/* PLL_E */
+	clks[PLL_E] = clk_register_sp_pll("plle", EXTCLK,
+					  PLLE_CTL, 6, 2, 50000000, 0, 0, &plle_lock);
+	clks[PLL_E_2P5] = clk_register_sp_pll("plle_2p5", "plle",
+					      PLLE_CTL, 13, -1, 2500000, 0, 0, &plle_lock);
+	clks[PLL_E_25] = clk_register_sp_pll("plle_25", "plle",
+					     PLLE_CTL, 12, -1, 25000000, 0, 0, &plle_lock);
+	clks[PLL_E_112P5] = clk_register_sp_pll("plle_112p5", "plle",
+						PLLE_CTL, 11, -1, 112500000, 0, 0, &plle_lock);
+
+	/* PLL_F */
+	clks[PLL_F] = clk_register_sp_pll("pllf", EXTCLK,
+					  PLLF_CTL, 0, 10, 13500000, 1, 4, &pllf_lock);
+
+	/* PLL_TV */
+	clks[PLL_TV] = clk_register_sp_pll("plltv", EXTCLK,
+					   PLLTV_CTL, 0, 15, 27000000, 0, DIV_TV, &plltv_lock);
+	clks[PLL_TV_A] = clk_register_divider(NULL, "plltv_a", "plltv", 0,
+					      PLLTV_CTL + 4, 5, 1,
+					      CLK_DIVIDER_POWER_OF_TWO, &plltv_lock);
+	clk_register_clkdev(clks[PLL_TV_A], NULL, "plltv_a");
+
+	/* PLL_SYS */
+	clks[PLL_SYS] = clk_register_sp_pll("pllsys", EXTCLK,
+					    PLLSYS_CTL, 10, 9, 13500000, 0, 4, &pllsys_lock);
+
+	/* gates */
+	for (i = 0; i < ARRAY_SIZE(gates); i++) {
+		char s[10];
+
+		j = gates[i] & 0xffff;
+		sprintf(s, "clken%02x", j);
+		clks[j] = clk_register_gate(NULL, s, parents[gates[i] >> 16], CLK_IGNORE_UNUSED,
+					    clk_regs + (j >> 4) * 4, j & 0x0f,
+					    CLK_GATE_HIWORD_MASK, NULL);
+	}
+
+	clk_data.clks = clks;
+	clk_data.clk_num = ARRAY_SIZE(clks);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+
+CLK_OF_DECLARE(sp_clkc, "sunplus,sp7021-clkc", sp_clk_setup);
+
+MODULE_AUTHOR("Qin Jian <qinjian@cqplus1.com>");
+MODULE_DESCRIPTION("Sunplus SP7021 Clock Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.33.1

