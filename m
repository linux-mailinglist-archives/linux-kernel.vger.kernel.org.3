Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08338550BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 17:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbiFSPOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 11:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbiFSPM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:12:56 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 069A56388;
        Sun, 19 Jun 2022 08:12:50 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 0DF961C8123A;
        Sun, 19 Jun 2022 23:12:30 +0800 (CST)
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 19 Jun
 2022 23:12:29 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Sun, 19 Jun
 2022 23:12:29 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sun, 19 Jun 2022 23:12:29 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 4D5C963A1D; Sun, 19 Jun 2022 18:12:27 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <jirislaby@kernel.org>,
        <shawnguo@kernel.org>, <bjorn.andersson@linaro.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <vkoul@kernel.org>, <biju.das.jz@bp.renesas.com>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robert.hancock@calian.com>,
        <j.neuschaefer@gmx.net>, <lkundrak@v3.sk>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 06/18] clk: npcm8xx: add clock controller
Date:   Sun, 19 Jun 2022 18:12:13 +0300
Message-ID: <20220619151225.209029-7-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220619151225.209029-1-tmaimon77@gmail.com>
References: <20220619151225.209029-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller which
generates and supplies clocks to all modules within the BMC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/clk/Kconfig       |   6 +
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm8xx.c | 760 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 767 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 48f8f4221e21..9aa915f6e233 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -428,6 +428,12 @@ config COMMON_CLK_K210
 	help
 	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
 
+config COMMON_CLK_NPCM8XX
+	tristate "Clock driver for the NPCM8XX SoC Family"
+	depends on ARCH_NPCM || COMPILE_TEST
+	help
+          This driver supports the clocks on the Nuvoton BMC NPCM8XX SoC Family.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d5db170d38d2..b0ec1184a744 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_ARCH_MILBEAUT_M10V)	+= clk-milbeaut.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NPCM7XX)	    	+= clk-npcm7xx.o
+obj-$(CONFIG_COMMON_CLK_NPCM8XX)	+= clk-npcm8xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_OXNAS)		+= clk-oxnas.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
new file mode 100644
index 000000000000..0b23d638a47a
--- /dev/null
+++ b/drivers/clk/clk-npcm8xx.c
@@ -0,0 +1,760 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton NPCM8xx Clock Generator
+ * All the clocks are initialized by the bootloader, so this driver allow only
+ * reading of current settings directly from the hardware.
+ *
+ * Copyright (C) 2020 Nuvoton Technologies
+ * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/nuvoton,npcm8xx-clock.h>
+
+#define NPCM8XX_REF_CLK		25000000
+
+struct npcm8xx_clk_pll {
+	struct clk_hw	hw;
+	void __iomem	*pllcon;
+	u8		flags;
+};
+
+#define to_npcm8xx_clk_pll(_hw) container_of(_hw, struct npcm8xx_clk_pll, hw)
+
+#define PLLCON_LOKI	BIT(31)
+#define PLLCON_LOKS	BIT(30)
+#define PLLCON_FBDV	GENMASK(27, 16)
+#define PLLCON_OTDV2	GENMASK(15, 13)
+#define PLLCON_PWDEN	BIT(12)
+#define PLLCON_OTDV1	GENMASK(10, 8)
+#define PLLCON_INDV	GENMASK(5, 0)
+
+static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct npcm8xx_clk_pll *pll = to_npcm8xx_clk_pll(hw);
+	unsigned long fbdv, indv, otdv1, otdv2;
+	unsigned int val;
+	u64 ret;
+
+	if (parent_rate == 0) {
+		pr_debug("%s: parent rate is zero\n", __func__);
+		return 0;
+	}
+
+	val = readl_relaxed(pll->pllcon);
+
+	indv = FIELD_GET(PLLCON_INDV, val);
+	fbdv = FIELD_GET(PLLCON_FBDV, val);
+	otdv1 = FIELD_GET(PLLCON_OTDV1, val);
+	otdv2 = FIELD_GET(PLLCON_OTDV2, val);
+
+	ret = (u64)parent_rate * fbdv;
+	do_div(ret, indv * otdv1 * otdv2);
+
+	return ret;
+}
+
+static const struct clk_ops npcm8xx_clk_pll_ops = {
+	.recalc_rate = npcm8xx_clk_pll_recalc_rate,
+};
+
+static struct clk_hw *
+npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
+			 const char *name, const char *parent_name,
+			 unsigned long flags)
+{
+	struct npcm8xx_clk_pll *pll;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pr_debug("%s reg, name=%s, p=%s\n", __func__, name, parent_name);
+
+	init.name = name;
+	init.ops = &npcm8xx_clk_pll_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = flags;
+
+	pll->pllcon = pllcon;
+	pll->hw.init = &init;
+
+	hw = &pll->hw;
+
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+#define NPCM8XX_CLKEN1          (0x00)
+#define NPCM8XX_CLKEN2          (0x28)
+#define NPCM8XX_CLKEN3          (0x30)
+#define NPCM8XX_CLKEN4          (0x70)
+#define NPCM8XX_CLKSEL          (0x04)
+#define NPCM8XX_CLKDIV1         (0x08)
+#define NPCM8XX_CLKDIV2         (0x2C)
+#define NPCM8XX_CLKDIV3         (0x58)
+#define NPCM8XX_CLKDIV4         (0x7C)
+#define NPCM8XX_PLLCON0         (0x0C)
+#define NPCM8XX_PLLCON1         (0x10)
+#define NPCM8XX_PLLCON2         (0x54)
+#define NPCM8XX_SWRSTR          (0x14)
+#define NPCM8XX_IRQWAKECON      (0x18)
+#define NPCM8XX_IRQWAKEFLAG     (0x1C)
+#define NPCM8XX_IPSRST1         (0x20)
+#define NPCM8XX_IPSRST2         (0x24)
+#define NPCM8XX_IPSRST3         (0x34)
+#define NPCM8XX_WD0RCR          (0x38)
+#define NPCM8XX_WD1RCR          (0x3C)
+#define NPCM8XX_WD2RCR          (0x40)
+#define NPCM8XX_SWRSTC1         (0x44)
+#define NPCM8XX_SWRSTC2         (0x48)
+#define NPCM8XX_SWRSTC3         (0x4C)
+#define NPCM8XX_SWRSTC4         (0x50)
+#define NPCM8XX_CORSTC          (0x5C)
+#define NPCM8XX_PLLCONG         (0x60)
+#define NPCM8XX_AHBCKFI         (0x64)
+#define NPCM8XX_SECCNT          (0x68)
+#define NPCM8XX_CNTR25M         (0x6C)
+#define NPCM8XX_THRTL_CNT       (0xC0)
+
+struct npcm8xx_clk_gate_data {
+	u32 reg;
+	u8 bit_idx;
+	const char *name;
+	const char *parent_name;
+	unsigned long flags;
+	/*
+	 * If this clock is exported via DT, set onecell_idx to constant
+	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
+	 * this specific clock.  Otherwise, set to -1.
+	 */
+	int onecell_idx;
+};
+
+struct npcm8xx_clk_mux_data {
+	u8 shift;
+	u8 mask;
+	u32 *table;
+	const char *name;
+	const char * const *parent_names;
+	u8 num_parents;
+	unsigned long flags;
+	/*
+	 * If this clock is exported via DT, set onecell_idx to constant
+	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
+	 * this specific clock.  Otherwise, set to -1.
+	 */
+	int onecell_idx;
+};
+
+struct npcm8xx_clk_div_fixed_data {
+	u8 mult;
+	u8 div;
+	const char *name;
+	const char *parent_name;
+	u8 clk_divider_flags;
+	/*
+	 * If this clock is exported via DT, set onecell_idx to constant
+	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
+	 * this specific clock.  Otherwise, set to -1.
+	 */
+	int onecell_idx;
+};
+
+struct npcm8xx_clk_div_data {
+	u32 reg;
+	u8 shift;
+	u8 width;
+	const char *name;
+	const char *parent_name;
+	u8 clk_divider_flags;
+	unsigned long flags;
+	/*
+	 * If this clock is exported via DT, set onecell_idx to constant
+	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
+	 * this specific clock.  Otherwise, set to -1.
+	 */
+	int onecell_idx;
+};
+
+struct npcm8xx_clk_pll_data {
+	u32 reg;
+	const char *name;
+	const char *parent_name;
+	unsigned long flags;
+	/*
+	 * If this clock is exported via DT, set onecell_idx to constant
+	 * defined in include/dt-bindings/clock/nuvoton, NPCM8XX-clock.h for
+	 * this specific clock.  Otherwise, set to -1.
+	 */
+	int onecell_idx;
+};
+
+/*
+ * Single copy of strings used to refer to clocks within this driver indexed by
+ * above enum.
+ */
+#define NPCM8XX_CLK_S_REFCLK      "refclk"
+#define NPCM8XX_CLK_S_SYSBYPCK    "sysbypck"
+#define NPCM8XX_CLK_S_MCBYPCK     "mcbypck"
+#define NPCM8XX_CLK_S_PLL0        "pll0"
+#define NPCM8XX_CLK_S_PLL1        "pll1"
+#define NPCM8XX_CLK_S_PLL1_DIV2   "pll1_div2"
+#define NPCM8XX_CLK_S_PLL2        "pll2"
+#define NPCM8XX_CLK_S_PLL_GFX     "pll_gfx"
+#define NPCM8XX_CLK_S_PLL2_DIV2   "pll2_div2"
+#define NPCM8XX_CLK_S_PIX_MUX     "gfx_pixel"
+#define NPCM8XX_CLK_S_MC_MUX      "mc_phy"
+#define NPCM8XX_CLK_S_CPU_MUX     "cpu"  /* AKA system clock */
+#define NPCM8XX_CLK_S_MC          "mc"
+#define NPCM8XX_CLK_S_AXI         "axi"  /* AKA CLK2 */
+#define NPCM8XX_CLK_S_AHB         "ahb"  /* AKA CLK4 */
+#define NPCM8XX_CLK_S_CLKOUT_MUX  "clkout_mux"
+#define NPCM8XX_CLK_S_UART_MUX    "uart_mux"
+#define NPCM8XX_CLK_S_SD_MUX      "sd_mux"
+#define NPCM8XX_CLK_S_GFXM_MUX    "gfxm_mux"
+#define NPCM8XX_CLK_S_SU_MUX      "serial_usb_mux"
+#define NPCM8XX_CLK_S_DVC_MUX     "dvc_mux"
+#define NPCM8XX_CLK_S_GFX_MUX     "gfx_mux"
+#define NPCM8XX_CLK_S_ADC_MUX     "adc_mux"
+#define NPCM8XX_CLK_S_SPI0        "spi0"
+#define NPCM8XX_CLK_S_SPI1        "spi1"
+#define NPCM8XX_CLK_S_SPI3        "spi3"
+#define NPCM8XX_CLK_S_SPIX        "spix"
+#define NPCM8XX_CLK_S_APB1        "apb1"
+#define NPCM8XX_CLK_S_APB2        "apb2"
+#define NPCM8XX_CLK_S_APB3        "apb3"
+#define NPCM8XX_CLK_S_APB4        "apb4"
+#define NPCM8XX_CLK_S_APB5        "apb5"
+#define NPCM8XX_CLK_S_APB19       "apb19"
+#define NPCM8XX_CLK_S_TOCK        "tock"
+#define NPCM8XX_CLK_S_CLKOUT      "clkout"
+#define NPCM8XX_CLK_S_PRE_ADC     "pre adc"
+#define NPCM8XX_CLK_S_UART        "uart"
+#define NPCM8XX_CLK_S_UART2       "uart2"
+#define NPCM8XX_CLK_S_TIMER       "timer"
+#define NPCM8XX_CLK_S_MMC         "mmc"
+#define NPCM8XX_CLK_S_SDHC        "sdhc"
+#define NPCM8XX_CLK_S_ADC         "adc"
+#define NPCM8XX_CLK_S_GFX         "gfx0_gfx1_mem"
+#define NPCM8XX_CLK_S_USBIF       "serial_usbif"
+#define NPCM8XX_CLK_S_USB_HOST    "usb_host"
+#define NPCM8XX_CLK_S_USB_BRIDGE  "usb_bridge"
+#define NPCM8XX_CLK_S_PCI         "pci"
+#define NPCM8XX_CLK_S_TH          "th"
+#define NPCM8XX_CLK_S_ATB         "atb"
+#define NPCM8XX_CLK_S_PRE_CLK     "pre_clk"
+
+#define NPCM8XX_CLK_S_RG_MUX	  "rg_mux"
+#define NPCM8XX_CLK_S_RCP_MUX	  "rcp_mux"
+#define NPCM8XX_CLK_S_RG	  "rg"
+#define NPCM8XX_CLK_S_RCP	  "rcp"
+
+static u32 pll_mux_table[] = {0, 1, 2, 3};
+static const char * const pll_mux_parents[] = {
+	NPCM8XX_CLK_S_PLL0,
+	NPCM8XX_CLK_S_PLL1,
+	NPCM8XX_CLK_S_REFCLK,
+	NPCM8XX_CLK_S_PLL2_DIV2,
+};
+
+static u32 cpuck_mux_table[] = {0, 1, 2, 3, 7};
+static const char * const cpuck_mux_parents[] = {
+	NPCM8XX_CLK_S_PLL0,
+	NPCM8XX_CLK_S_PLL1,
+	NPCM8XX_CLK_S_REFCLK,
+	NPCM8XX_CLK_S_SYSBYPCK,
+	NPCM8XX_CLK_S_PLL2,
+};
+
+static u32 pixcksel_mux_table[] = {0, 2};
+static const char * const pixcksel_mux_parents[] = {
+	NPCM8XX_CLK_S_PLL_GFX,
+	NPCM8XX_CLK_S_REFCLK,
+};
+
+static u32 sucksel_mux_table[] = {2, 3};
+static const char * const sucksel_mux_parents[] = {
+	NPCM8XX_CLK_S_REFCLK,
+	NPCM8XX_CLK_S_PLL2_DIV2,
+};
+
+static u32 mccksel_mux_table[] = {0, 2, 3};
+static const char * const mccksel_mux_parents[] = {
+	NPCM8XX_CLK_S_PLL1_DIV2,
+	NPCM8XX_CLK_S_REFCLK,
+	NPCM8XX_CLK_S_MCBYPCK,
+};
+
+static u32 clkoutsel_mux_table[] = {0, 1, 2, 3, 4};
+static const char * const clkoutsel_mux_parents[] = {
+	NPCM8XX_CLK_S_PLL0,
+	NPCM8XX_CLK_S_PLL1,
+	NPCM8XX_CLK_S_REFCLK,
+	NPCM8XX_CLK_S_PLL_GFX, // divided by 2
+	NPCM8XX_CLK_S_PLL2_DIV2,
+};
+
+static u32 gfxmsel_mux_table[] = {2, 3};
+static const char * const gfxmsel_mux_parents[] = {
+	NPCM8XX_CLK_S_REFCLK,
+	NPCM8XX_CLK_S_PLL2_DIV2,
+};
+
+static u32 dvcssel_mux_table[] = {2, 3};
+static const char * const dvcssel_mux_parents[] = {
+	NPCM8XX_CLK_S_REFCLK,
+	NPCM8XX_CLK_S_PLL2,
+};
+
+static const struct npcm8xx_clk_pll_data npcm8xx_plls[] = {
+	{NPCM8XX_PLLCON0, NPCM8XX_CLK_S_PLL0, NPCM8XX_CLK_S_REFCLK, 0, -1},
+	{NPCM8XX_PLLCON1, NPCM8XX_CLK_S_PLL1, NPCM8XX_CLK_S_REFCLK, 0, -1},
+	{NPCM8XX_PLLCON2, NPCM8XX_CLK_S_PLL2, NPCM8XX_CLK_S_REFCLK, 0, -1},
+	{NPCM8XX_PLLCONG, NPCM8XX_CLK_S_PLL_GFX, NPCM8XX_CLK_S_REFCLK, 0, -1},
+};
+
+static const struct npcm8xx_clk_mux_data npcm8xx_muxes[] = {
+	{0, GENMASK(1, 0), cpuck_mux_table, NPCM8XX_CLK_S_CPU_MUX,
+	cpuck_mux_parents, ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL,
+	NPCM8XX_CLK_CPU},
+
+	{4, GENMASK(1, 0), pixcksel_mux_table, NPCM8XX_CLK_S_PIX_MUX,
+	pixcksel_mux_parents, ARRAY_SIZE(pixcksel_mux_parents), 0,
+	NPCM8XX_CLK_GFX_PIXEL},
+
+	{6, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_SD_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
+
+	{8, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_UART_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
+
+	{10, GENMASK(1, 0), sucksel_mux_table, NPCM8XX_CLK_S_SU_MUX,
+	sucksel_mux_parents, ARRAY_SIZE(sucksel_mux_parents), 0, -1},
+
+	{12, GENMASK(1, 0), mccksel_mux_table, NPCM8XX_CLK_S_MC_MUX,
+	mccksel_mux_parents, ARRAY_SIZE(mccksel_mux_parents), 0, -1},
+
+	{14, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_ADC_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
+
+	{16, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_GFX_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
+
+	{18, GENMASK(2, 0), clkoutsel_mux_table, NPCM8XX_CLK_S_CLKOUT_MUX,
+	clkoutsel_mux_parents, ARRAY_SIZE(clkoutsel_mux_parents), 0, -1},
+
+	{21, GENMASK(1, 0), gfxmsel_mux_table, NPCM8XX_CLK_S_GFXM_MUX,
+	gfxmsel_mux_parents, ARRAY_SIZE(gfxmsel_mux_parents), 0, -1},
+
+	{23, GENMASK(1, 0), dvcssel_mux_table, NPCM8XX_CLK_S_DVC_MUX,
+	dvcssel_mux_parents, ARRAY_SIZE(dvcssel_mux_parents), 0, -1},
+
+	{25, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_RG_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
+
+	{27, GENMASK(1, 0), pll_mux_table, NPCM8XX_CLK_S_RCP_MUX,
+	pll_mux_parents, ARRAY_SIZE(pll_mux_parents), 0, -1},
+};
+
+/* fixed ratio dividers (no register): */
+static const struct npcm8xx_clk_div_fixed_data npcm8xx_divs_fx[] = {
+	{ 1, 2, NPCM8XX_CLK_S_MC, NPCM8XX_CLK_S_MC_MUX, 0, NPCM8XX_CLK_MC},
+	{ 1, 2, NPCM8XX_CLK_S_AXI, NPCM8XX_CLK_S_TH, 0, NPCM8XX_CLK_AXI},
+	{ 1, 2, NPCM8XX_CLK_S_ATB, NPCM8XX_CLK_S_AXI, 0, NPCM8XX_CLK_ATB},
+	{ 1, 2, NPCM8XX_CLK_S_PRE_CLK, NPCM8XX_CLK_S_CPU_MUX, 0, -1},
+	{ 1, 2, NPCM8XX_CLK_S_PLL1_DIV2, NPCM8XX_CLK_S_PLL1, 0, -1},
+	{ 1, 2, NPCM8XX_CLK_S_PLL2_DIV2, NPCM8XX_CLK_S_PLL2, 0, -1},
+};
+
+/* configurable dividers: */
+static const struct npcm8xx_clk_div_data npcm8xx_divs[] = {
+	{NPCM8XX_CLKDIV1, 28, 3, NPCM8XX_CLK_S_ADC, NPCM8XX_CLK_S_PRE_ADC,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_ADC},
+	/* bit 30-28 ADCCKDIV*/
+	{NPCM8XX_CLKDIV1, 26, 2, NPCM8XX_CLK_S_AHB, NPCM8XX_CLK_S_PRE_CLK,
+		CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB},
+	/* bit 28-26 CLK4DIV*/
+	{NPCM8XX_CLKDIV1, 21, 5, NPCM8XX_CLK_S_PRE_ADC,
+	NPCM8XX_CLK_S_ADC_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PRE_ADC},
+	/* bit 25-21 PRE-ADCCKDIV*/
+	{NPCM8XX_CLKDIV1, 16, 5, NPCM8XX_CLK_S_UART,
+	NPCM8XX_CLK_S_UART_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UART},
+	/* bit 20-16 UARTDIV*/
+	{NPCM8XX_CLKDIV1, 11, 5, NPCM8XX_CLK_S_MMC,
+	NPCM8XX_CLK_S_SD_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_MMC},
+	/* bit 15-11 MMCCKDIV*/
+	{NPCM8XX_CLKDIV1, 6, 5, NPCM8XX_CLK_S_SPI3,
+	NPCM8XX_CLK_S_AHB, 0, 0, NPCM8XX_CLK_SPI3},
+	/* bit 10-6 AHB3CKDIV*/
+	{NPCM8XX_CLKDIV1, 2, 4, NPCM8XX_CLK_S_PCI,
+	NPCM8XX_CLK_S_GFX_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PCI},
+	/* bit 5-2 PCICKDIV*/
+
+	{NPCM8XX_CLKDIV2, 30, 2, NPCM8XX_CLK_S_APB4, NPCM8XX_CLK_S_AHB,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB4},
+	/* bit 31-30 APB4CKDIV*/
+	{NPCM8XX_CLKDIV2, 28, 2, NPCM8XX_CLK_S_APB3, NPCM8XX_CLK_S_AHB,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB3},
+	/* bit 29-28 APB3CKDIV*/
+	{NPCM8XX_CLKDIV2, 26, 2, NPCM8XX_CLK_S_APB2, NPCM8XX_CLK_S_AHB,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB2},
+	/* bit 28-26 APB2CKDIV*/
+	{NPCM8XX_CLKDIV2, 24, 2, NPCM8XX_CLK_S_APB1, NPCM8XX_CLK_S_AHB,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB1},
+	/* bit 25-24 APB1CKDIV*/
+	{NPCM8XX_CLKDIV2, 22, 2, NPCM8XX_CLK_S_APB5, NPCM8XX_CLK_S_AHB,
+		CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0,
+		NPCM8XX_CLK_APB5},
+	/* bit 23-22 APB5CKDIV*/
+	{NPCM8XX_CLKDIV2, 16, 5, NPCM8XX_CLK_S_CLKOUT, NPCM8XX_CLK_S_CLKOUT_MUX,
+		 CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_CLKOUT},
+	/* bit 20-16 CLKOUTDIV*/
+	{NPCM8XX_CLKDIV2, 13, 3, NPCM8XX_CLK_S_GFX, NPCM8XX_CLK_S_GFX_MUX,
+		CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_GFX},
+	/* bit 15-13 GFXCKDIV*/
+	{NPCM8XX_CLKDIV2, 8, 5, NPCM8XX_CLK_S_USB_BRIDGE, NPCM8XX_CLK_S_SU_MUX,
+		CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU},
+	/* bit 12-8 SUCKDIV*/
+	{NPCM8XX_CLKDIV2, 4, 4, NPCM8XX_CLK_S_USB_HOST, NPCM8XX_CLK_S_SU_MUX,
+		CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU48},
+	/* bit 8-4 SU48CKDIV*/
+	{NPCM8XX_CLKDIV2, 0, 4, NPCM8XX_CLK_S_SDHC,
+	NPCM8XX_CLK_S_SD_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SDHC}
+	,/* bit 3-0 SD1CKDIV*/
+
+	{NPCM8XX_CLKDIV3, 16, 8, NPCM8XX_CLK_S_SPI1,
+	NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI1},
+	/* bit 23-16 SPI1CKDV*/
+	{NPCM8XX_CLKDIV3, 11, 5, NPCM8XX_CLK_S_UART2,
+	NPCM8XX_CLK_S_UART_MUX, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UART2},
+	/* bit 15-11 UARTDIV2*/
+	{NPCM8XX_CLKDIV3, 6, 5, NPCM8XX_CLK_S_SPI0,
+	NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0},
+	/* bit 10-6 SPI0CKDV*/
+	{NPCM8XX_CLKDIV3, 1, 5, NPCM8XX_CLK_S_SPIX,
+	NPCM8XX_CLK_S_AHB, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX},
+
+	/* bit 5-1 SPIXCKDV*/
+	{NPCM8XX_CLKDIV4, 28, 4, NPCM8XX_CLK_S_RG, NPCM8XX_CLK_S_RG_MUX,
+	CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG},
+	/* bit 31-28 RGREFDIV*/
+	{NPCM8XX_CLKDIV4, 12, 4, NPCM8XX_CLK_S_RCP, NPCM8XX_CLK_S_RCP_MUX,
+	CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP},
+	/* bit 15-12 RCPREFDIV*/
+	{NPCM8XX_THRTL_CNT, 0, 2, NPCM8XX_CLK_S_TH, NPCM8XX_CLK_S_CPU_MUX,
+	CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_TH},
+	/* bit 1-0 TH_DIV*/
+};
+
+static const struct npcm8xx_clk_gate_data npcm8xx_gates[] = {
+	{NPCM8XX_CLKEN1, 31, "smb1-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN1, 30, "smb0-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN1, 29, "smb7-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN1, 28, "smb6-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN1, 27, "adc-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN1, 26, "wdt-gate", NPCM8XX_CLK_S_TIMER, 0},
+	{NPCM8XX_CLKEN1, 25, "usbdev3-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 24, "usbdev6-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 23, "usbdev5-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 22, "usbdev4-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 21, "gmac4-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 20, "timer5_9-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN1, 19, "timer0_4-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN1, 18, "pwmm0-gate", NPCM8XX_CLK_S_APB3, 0},
+	{NPCM8XX_CLKEN1, 17, "huart-gate", NPCM8XX_CLK_S_UART, 0},
+	{NPCM8XX_CLKEN1, 16, "smb5-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN1, 15, "smb4-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN1, 14, "smb3-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN1, 13, "smb2-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN1, 12, "mc-gate", NPCM8XX_CLK_S_MC, 0},
+	{NPCM8XX_CLKEN1, 11, "uart01-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN1, 10, "aes-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 9, "peci-gate", NPCM8XX_CLK_S_APB3, 0},
+	{NPCM8XX_CLKEN1, 8, "usbdev2-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 7, "uart23-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN1, 6, "gmac3-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 5, "usbdev1-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 4, "shm-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 3, "gdma0-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 2, "kcs-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN1, 1, "spi3-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN1, 0, "spi0-gate", NPCM8XX_CLK_S_AHB, 0},
+
+	{NPCM8XX_CLKEN2, 31, "cp-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 30, "tock-gate", NPCM8XX_CLK_S_TOCK, 0},
+	/* bit 29 is reserved */
+	{NPCM8XX_CLKEN2, 28, "gmac1-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 27, "usbif-gate", NPCM8XX_CLK_S_USBIF, 0},
+	{NPCM8XX_CLKEN2, 26, "usbhost1-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 25, "gmac2-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 24, "spi1-gate", NPCM8XX_CLK_S_APB5, 0},
+	{NPCM8XX_CLKEN2, 23, "pspi2-gate", NPCM8XX_CLK_S_APB5, 0},
+	/* bit 22 is reserved */
+	{NPCM8XX_CLKEN2, 21, "3des-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 20, "bt-gate", NPCM8XX_CLK_S_APB3, 0},
+	{NPCM8XX_CLKEN2, 19, "siox2-gate", NPCM8XX_CLK_S_APB3, 0},
+	{NPCM8XX_CLKEN2, 18, "siox1-gate", NPCM8XX_CLK_S_APB3, 0},
+	{NPCM8XX_CLKEN2, 17, "viruart2-gate", NPCM8XX_CLK_S_APB5, 0},
+	{NPCM8XX_CLKEN2, 16, "viruart1-gate", NPCM8XX_CLK_S_APB5, 0},
+	/*  bit 15 is reserved */
+	{NPCM8XX_CLKEN2, 14, "vcd-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 13, "ece-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 12, "vdma-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 11, "ahbpcibrg-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 10, "gfxsys-gate", NPCM8XX_CLK_S_APB1, 0},
+	//{NPCM8XX_CLKEN2, 9, "sdhc-gate", NPCM8XX_CLK_S_AHB, 0},
+	/*  bit 9 is reserved */
+	{NPCM8XX_CLKEN2, 8, "mmc-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN2, 7, "mft7-gate", NPCM8XX_CLK_S_APB4, 0},
+	{NPCM8XX_CLKEN2, 6, "mft6-gate", NPCM8XX_CLK_S_APB4, 0},
+	{NPCM8XX_CLKEN2, 5, "mft5-gate", NPCM8XX_CLK_S_APB4, 0},
+	{NPCM8XX_CLKEN2, 4, "mft4-gate", NPCM8XX_CLK_S_APB4, 0},
+	{NPCM8XX_CLKEN2, 3, "mft3-gate", NPCM8XX_CLK_S_APB4, 0},
+	{NPCM8XX_CLKEN2, 2, "mft2-gate", NPCM8XX_CLK_S_APB4, 0},
+	{NPCM8XX_CLKEN2, 1, "mft1-gate", NPCM8XX_CLK_S_APB4, 0},
+	{NPCM8XX_CLKEN2, 0, "mft0-gate", NPCM8XX_CLK_S_APB4, 0},
+
+	{NPCM8XX_CLKEN3, 31, "gpiom7-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 30, "gpiom6-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 29, "gpiom5-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 28, "gpiom4-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 27, "gpiom3-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 26, "gpiom2-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 25, "gpiom1-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 24, "gpiom0-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 23, "espi-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN3, 22, "smb11-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN3, 21, "smb10-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN3, 20, "smb9-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN3, 19, "smb8-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN3, 18, "smb15-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN3, 17, "rng-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 16, "timer10_14-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN3, 15, "pcirc-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 14, "sececc-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 13, "sha-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 12, "smb14-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN3, 11, "gdma2-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 10, "gdma1-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 9, "pcimbx-gate", NPCM8XX_CLK_S_AHB, 0},
+	/* bit 8 is reserved */
+	{NPCM8XX_CLKEN3, 7, "usbdev9-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 6, "usbdev8-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 5, "usbdev7-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 4, "usbdev0-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 3, "smb13-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN3, 2, "spix-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN3, 1, "smb12-gate", NPCM8XX_CLK_S_APB2, 0},
+	{NPCM8XX_CLKEN3, 0, "pwmm1-gate", NPCM8XX_CLK_S_APB3, 0},
+
+	{NPCM8XX_CLKEN4, 31, "usbhost2-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN4, 30, "jtm2-gate", NPCM8XX_CLK_S_APB5, 0},
+	{NPCM8XX_CLKEN4, 29, "jtm1-gate", NPCM8XX_CLK_S_APB5, 0},
+	{NPCM8XX_CLKEN4, 28, "pwmm2-gate", NPCM8XX_CLK_S_APB3, 0},
+	/* bit 27 is reserved */
+	/* bit 26 is reserved */
+	/* bit 25 is reserved */
+	{NPCM8XX_CLKEN4, 24, "smb26-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 23, "smb25-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 22, "smb24-gate", NPCM8XX_CLK_S_APB19, 0},
+	/* bit 21 is reserved */
+	/* bit 20 is reserved */
+	{NPCM8XX_CLKEN4, 19, "pcimbx2-gate", NPCM8XX_CLK_S_AHB, 0},
+	{NPCM8XX_CLKEN4, 18, "uart6-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN4, 17, "uart5-gate", NPCM8XX_CLK_S_APB1, 0},
+	{NPCM8XX_CLKEN4, 16, "uart4-gate", NPCM8XX_CLK_S_APB1, 0},
+	/* bit 15 is reserved */
+	/* bit 14 is reserved */
+	{NPCM8XX_CLKEN4, 13, "i3c5-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 12, "i3c4-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 11, "i3c3-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 10, "i3c2-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 9, "i3c1-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 8, "i3c0-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 7, "smb23-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 6, "smb22-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 5, "smb21-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 4, "smb20-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 3, "smb19-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 2, "smb18-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 1, "smb17-gate", NPCM8XX_CLK_S_APB19, 0},
+	{NPCM8XX_CLKEN4, 0, "smb16-gate", NPCM8XX_CLK_S_APB19, 0},
+
+};
+
+static DEFINE_SPINLOCK(npcm8xx_clk_lock);
+
+static int npcm8xx_clk_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *npcm8xx_clk_data;
+	struct device *dev = &pdev->dev;
+	void __iomem *clk_base;
+	struct clk_hw *hw;
+	int i;
+
+	npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
+							 NPCM8XX_NUM_CLOCKS),
+					GFP_KERNEL);
+	if (!npcm8xx_clk_data)
+		return -ENOMEM;
+
+	clk_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(clk_base))
+		return PTR_ERR(clk_base);
+
+	npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
+
+	for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
+		npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	/* Reference 25MHz clock */
+	hw = clk_hw_register_fixed_rate(dev, "refclk", NULL, 0, NPCM8XX_REF_CLK);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK] = hw;
+
+	/* Register plls */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_plls); i++) {
+		const struct npcm8xx_clk_pll_data *pll_data = &npcm8xx_plls[i];
+
+		hw = npcm8xx_clk_register_pll(dev, clk_base + pll_data->reg,
+					      pll_data->name,
+					      pll_data->parent_name,
+					      pll_data->flags);
+		if (IS_ERR(hw)) {
+			dev_err(dev, "npcm8xx_clk: Can't register pll\n");
+			return PTR_ERR(hw);
+		}
+
+		if (pll_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[pll_data->onecell_idx] = hw;
+	}
+
+	/* Register fixed dividers */
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL1_DIV2,
+					       NPCM8XX_CLK_S_PLL1, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register fixed div\n");
+		return PTR_ERR(hw);
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL2_DIV2,
+					       NPCM8XX_CLK_S_PLL2, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register pll div2\n");
+		return PTR_ERR(hw);
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PRE_CLK,
+					       NPCM8XX_CLK_S_CPU_MUX, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register ckclk div2\n");
+		return PTR_ERR(hw);
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI,
+					       NPCM8XX_CLK_S_TH, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register axi div2\n");
+		return PTR_ERR(hw);
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_ATB,
+					       NPCM8XX_CLK_S_AXI, 0, 1, 2);
+	if (IS_ERR(hw)) {
+		dev_err(dev, "npcm8xx_clk: Can't register atb div2\n");
+		return PTR_ERR(hw);
+	}
+
+	/* Register muxes */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
+		const struct npcm8xx_clk_mux_data *mux_data = &npcm8xx_muxes[i];
+
+		hw = clk_hw_register_mux_table(dev, mux_data->name,
+					       mux_data->parent_names,
+					       mux_data->num_parents,
+					       mux_data->flags,
+					       clk_base + NPCM8XX_CLKSEL,
+					       mux_data->shift,
+					       mux_data->mask, 0,
+					       mux_data->table,
+					       &npcm8xx_clk_lock);
+
+		if (IS_ERR(hw)) {
+			dev_err(dev, "npcm8xx_clk: Can't register mux\n");
+			return PTR_ERR(hw);
+		}
+
+		if (mux_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[mux_data->onecell_idx] = hw;
+	}
+
+	/* Register clock dividers specified in npcm8xx_divs */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
+		const struct npcm8xx_clk_div_data *div_data = &npcm8xx_divs[i];
+
+		hw = clk_hw_register_divider(dev, div_data->name,
+					     div_data->parent_name,
+					     div_data->flags,
+					     clk_base + div_data->reg,
+					     div_data->shift, div_data->width,
+					     div_data->clk_divider_flags,
+					     &npcm8xx_clk_lock);
+		if (IS_ERR(hw)) {
+			dev_err(dev, "npcm8xx_clk: Can't register div table\n");
+			return PTR_ERR(hw);
+		}
+
+		if (div_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   npcm8xx_clk_data);
+}
+
+static const struct of_device_id npcm8xx_clk_dt_ids[] = {
+	{ .compatible = "nuvoton,npcm845-clk", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, npcm8xx_clk_dt_ids);
+
+static struct platform_driver npcm8xx_clk_driver = {
+	.probe  = npcm8xx_clk_probe,
+	.driver = {
+		.name = "npcm8xx_clk",
+		.of_match_table = npcm8xx_clk_dt_ids,
+	},
+};
+
+static int __init npcm8xx_clk_driver_init(void)
+{
+	return platform_driver_register(&npcm8xx_clk_driver);
+}
+arch_initcall(npcm8xx_clk_driver_init);
+
-- 
2.33.0

