Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9D56B2EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiGHGpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbiGHGo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:44:59 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C54D4FC;
        Thu,  7 Jul 2022 23:44:49 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 8 Jul 2022
 14:29:38 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH 3/3] clk: meson: s4: add s4 SoC clock controller driver
Date:   Fri, 8 Jul 2022 14:27:57 +0800
Message-ID: <20220708062757.3662-4-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220708062757.3662-1-yu.tu@amlogic.com>
References: <20220708062757.3662-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the peripheral clock controller found in the s4 SoC family.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 MAINTAINERS                |    2 +-
 drivers/clk/meson/Kconfig  |   17 +
 drivers/clk/meson/Makefile |    1 +
 drivers/clk/meson/s4.c     | 4678 ++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/s4.h     |  156 ++
 5 files changed, 4853 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/s4.c
 create mode 100644 drivers/clk/meson/s4.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e4ca46c5c8a1..f116ec0642f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1772,7 +1772,7 @@ M:	Jerome Brunet <jbrunet@baylibre.com>
 L:	linux-amlogic@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/amlogic*
-F:	drivers/clk/meson/
+F:	drivers/clk/meson/*
 F:	include/dt-bindings/clock/gxbb*
 F:	include/dt-bindings/clock/meson*
 F:	include/dt-bindings/clock/s*
diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index fc002c155bc3..1a344b0564e8 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -115,4 +115,21 @@ config COMMON_CLK_G12A
 	help
 	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
 	  devices, aka g12a. Say Y if you want peripherals to work.
+
+config COMMON_CLK_S4
+	tristate "S4 SoC clock controllers support"
+	depends on ARM64
+	default y
+	select COMMON_CLK_MESON_REGMAP
+	select HAVE_ARM_SMCCC
+	select COMMON_CLK_MESON_DUALDIV
+	select COMMON_CLK_MESON_MPLL
+	select COMMON_CLK_MESON_PLL
+	select COMMON_CLK_MESON_CPU_DYNDIV
+	select COMMON_CLK_MESON_VID_PLL_DIV
+	select MFD_SYSCON
+	help
+	  Support for the clock controller on Amlogic S805X2 and S905Y4 devices,
+	  aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
+	  Say Y if you want peripherals and CPU frequency scaling to work.
 endmenu
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 6eca2a406ee3..b3ef5f67820f 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
 obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
 obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
+obj-$(CONFIG_COMMON_CLK_S4) += s4.o
diff --git a/drivers/clk/meson/s4.c b/drivers/clk/meson/s4.c
new file mode 100644
index 000000000000..a97159222f0e
--- /dev/null
+++ b/drivers/clk/meson/s4.c
@@ -0,0 +1,4678 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic Meson-S4 Clock Controller Driver
+ *
+ * Copyright (c) 2021 Amlogic, inc.
+ * Author: Yu Tu <yu.tu@amlogic.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <dt-bindings/clock/s4-clkc.h>
+
+#include "clk-mpll.h"
+#include "clk-pll.h"
+#include "clk-regmap.h"
+#include "vid-pll-div.h"
+#include "clk-dualdiv.h"
+#include "s4.h"
+#include "meson-eeclk.h"
+
+static DEFINE_SPINLOCK(meson_clk_lock);
+
+static struct clk_regmap s4_fixed_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = ANACTRL_FIXPLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = ANACTRL_FIXPLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = ANACTRL_FIXPLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = ANACTRL_FIXPLL_CTRL1,
+			.shift   = 0,
+			.width   = 17,
+		},
+		.l = {
+			.reg_off = ANACTRL_FIXPLL_CTRL0,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = ANACTRL_FIXPLL_CTRL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fixed_pll_dco",
+		.ops = &meson_clk_pll_ro_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", }
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_fixed_pll = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = ANACTRL_FIXPLL_CTRL0,
+		.shift = 16,
+		.width = 2,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fixed_pll",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fixed_pll_dco.hw
+		},
+		.num_parents = 1,
+		/*
+		 * This clock won't ever change at runtime so
+		 * CLK_SET_RATE_PARENT is not required
+		 */
+	},
+};
+
+static struct clk_fixed_factor s4_fclk_div2_div = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_fclk_div2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL1,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fclk_div2_div.hw
+		},
+		.num_parents = 1,
+		/*
+		 * Similar to fclk_div3, it seems that this clock is used by
+		 * the resident firmware and is required by the platform to
+		 * operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) Mark the clock used by a firmware resource, if possible
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_fixed_factor s4_fclk_div3_div = {
+	.mult = 1,
+	.div = 3,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_fclk_div3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL1,
+		.bit_idx = 20,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fclk_div3_div.hw
+		},
+		.num_parents = 1,
+		/*
+		 * This clock is used by the resident firmware and is required
+		 * by the platform to operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) Mark the clock used by a firmware resource, if possible
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_fixed_factor s4_fclk_div4_div = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div4_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_fclk_div4 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL1,
+		.bit_idx = 21,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div4",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fclk_div4_div.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_fclk_div5_div = {
+	.mult = 1,
+	.div = 5,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div5_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_fclk_div5 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL1,
+		.bit_idx = 22,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div5",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fclk_div5_div.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_fclk_div7_div = {
+	.mult = 1,
+	.div = 7,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div7_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_fixed_pll.hw },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_fclk_div7 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL1,
+		.bit_idx = 23,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div7",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fclk_div7_div.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_fclk_div2p5_div = {
+	.mult = 2,
+	.div = 5,
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2p5_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fixed_pll.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_fclk_div2p5 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_FIXPLL_CTRL1,
+		.bit_idx = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "fclk_div2p5",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fclk_div2p5_div.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static const struct pll_mult_range s4_gp0_pll_mult_range = {
+	.min = 125,
+	.max = 250,
+};
+
+/*
+ * Internal gp0 pll emulation configuration parameters
+ */
+static const struct reg_sequence s4_gp0_init_regs[] = {
+	{ .reg = ANACTRL_GP0PLL_CTRL1,	.def = 0x00000000 },
+	{ .reg = ANACTRL_GP0PLL_CTRL2,	.def = 0x00000000 },
+	{ .reg = ANACTRL_GP0PLL_CTRL3,	.def = 0x48681c00 },
+	{ .reg = ANACTRL_GP0PLL_CTRL4,	.def = 0x88770290 },
+	{ .reg = ANACTRL_GP0PLL_CTRL5,	.def = 0x39272000 },
+	{ .reg = ANACTRL_GP0PLL_CTRL6,	.def = 0x56540000 }
+};
+
+static struct clk_regmap s4_gp0_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = ANACTRL_GP0PLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = ANACTRL_GP0PLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = ANACTRL_GP0PLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = ANACTRL_GP0PLL_CTRL1,
+			.shift   = 0,
+			.width   = 17,
+		},
+		.l = {
+			.reg_off = ANACTRL_GP0PLL_CTRL0,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = ANACTRL_GP0PLL_CTRL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.range = &s4_gp0_pll_mult_range,
+		.init_regs = s4_gp0_init_regs,
+		.init_count = ARRAY_SIZE(s4_gp0_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gp0_pll_dco",
+		.ops = &meson_clk_pll_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", }
+		},
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_gp0_pll = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = ANACTRL_GP0PLL_CTRL0,
+		.shift = 16,
+		.width = 3,
+		.flags = (CLK_DIVIDER_POWER_OF_TWO |
+			  CLK_DIVIDER_ROUND_CLOSEST),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gp0_pll",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_gp0_pll_dco.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/*
+ * Internal hifi pll emulation configuration parameters
+ */
+static const struct reg_sequence s4_hifi_init_regs[] = {
+	{ .reg = ANACTRL_HIFIPLL_CTRL1,	.def = 0x00010e56 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL2,	.def = 0x00000000 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL3,	.def = 0x6a285c00 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL4,	.def = 0x65771290 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL5,	.def = 0x39272000 },
+	{ .reg = ANACTRL_HIFIPLL_CTRL6,	.def = 0x56540000 }
+};
+
+static struct clk_regmap s4_hifi_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL1,
+			.shift   = 0,
+			.width   = 17,
+		},
+		.l = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL0,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = ANACTRL_HIFIPLL_CTRL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.range = &s4_gp0_pll_mult_range,
+		.init_regs = s4_hifi_init_regs,
+		.init_count = ARRAY_SIZE(s4_hifi_init_regs),
+		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hifi_pll_dco",
+		.ops = &meson_clk_pll_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", }
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_hifi_pll = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = ANACTRL_HIFIPLL_CTRL0,
+		.shift = 16,
+		.width = 2,
+		.flags = (CLK_DIVIDER_POWER_OF_TWO |
+			  CLK_DIVIDER_ROUND_CLOSEST),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hifi_pll",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hifi_pll_dco.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hdmi_pll_dco = {
+	.data = &(struct meson_clk_pll_data){
+		.en = {
+			.reg_off = ANACTRL_HDMIPLL_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.m = {
+			.reg_off = ANACTRL_HDMIPLL_CTRL0,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.n = {
+			.reg_off = ANACTRL_HDMIPLL_CTRL0,
+			.shift   = 10,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = ANACTRL_HDMIPLL_CTRL1,
+			.shift   = 0,
+			.width   = 17,
+		},
+		.l = {
+			.reg_off = ANACTRL_HDMIPLL_CTRL0,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = ANACTRL_HDMIPLL_CTRL0,
+			.shift   = 29,
+			.width   = 1,
+		},
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_pll_dco",
+		.ops = &meson_clk_pll_ro_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", }
+		},
+		.num_parents = 1,
+		/*
+		 * Display directly handle hdmi pll registers ATM, we need
+		 * NOCACHE to keep our view of the clock as accurate as
+		 * possible
+		 */
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_hdmi_pll_od = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = ANACTRL_HDMIPLL_CTRL0,
+		.shift = 16,
+		.width = 4,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_pll_od",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hdmi_pll_dco.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hdmi_pll = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = ANACTRL_HDMIPLL_CTRL0,
+		.shift = 20,
+		.width = 2,
+		.flags = CLK_DIVIDER_POWER_OF_TWO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_pll",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hdmi_pll_od.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor s4_mpll_50m_div = {
+	.mult = 1,
+	.div = 80,
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll_50m_div",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fixed_pll_dco.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_mpll_50m = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = ANACTRL_FIXPLL_CTRL3,
+		.mask = 0x1,
+		.shift = 5,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll_50m",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &s4_mpll_50m_div.hw },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_fixed_factor s4_mpll_prediv = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll_prediv",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_fixed_pll_dco.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static const struct reg_sequence s4_mpll0_init_regs[] = {
+	{ .reg = ANACTRL_MPLL_CTRL2, .def = 0x40000033 }
+};
+
+static struct clk_regmap s4_mpll0_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = ANACTRL_MPLL_CTRL1,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = ANACTRL_MPLL_CTRL1,
+			.shift   = 30,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = ANACTRL_MPLL_CTRL1,
+			.shift   = 20,
+			.width   = 9,
+		},
+		.ssen = {
+			.reg_off = ANACTRL_MPLL_CTRL1,
+			.shift   = 29,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
+		.init_regs = s4_mpll0_init_regs,
+		.init_count = ARRAY_SIZE(s4_mpll0_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll0_div",
+		.ops = &meson_clk_mpll_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_mpll_prediv.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_mpll0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_MPLL_CTRL1,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_mpll0_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct reg_sequence s4_mpll1_init_regs[] = {
+	{ .reg = ANACTRL_MPLL_CTRL4,	.def = 0x40000033 }
+};
+
+static struct clk_regmap s4_mpll1_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = ANACTRL_MPLL_CTRL3,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = ANACTRL_MPLL_CTRL3,
+			.shift   = 30,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = ANACTRL_MPLL_CTRL3,
+			.shift   = 20,
+			.width   = 9,
+		},
+		.ssen = {
+			.reg_off = ANACTRL_MPLL_CTRL3,
+			.shift   = 29,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
+		.init_regs = s4_mpll1_init_regs,
+		.init_count = ARRAY_SIZE(s4_mpll1_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll1_div",
+		.ops = &meson_clk_mpll_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_mpll_prediv.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_mpll1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_MPLL_CTRL3,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_mpll1_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct reg_sequence s4_mpll2_init_regs[] = {
+	{ .reg = ANACTRL_MPLL_CTRL6, .def = 0x40000033 }
+};
+
+static struct clk_regmap s4_mpll2_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = ANACTRL_MPLL_CTRL5,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = ANACTRL_MPLL_CTRL5,
+			.shift   = 30,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = ANACTRL_MPLL_CTRL5,
+			.shift   = 20,
+			.width   = 9,
+		},
+		.ssen = {
+			.reg_off = ANACTRL_MPLL_CTRL5,
+			.shift   = 29,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
+		.init_regs = s4_mpll2_init_regs,
+		.init_count = ARRAY_SIZE(s4_mpll2_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll2_div",
+		.ops = &meson_clk_mpll_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_mpll_prediv.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_mpll2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_MPLL_CTRL5,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_mpll2_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct reg_sequence s4_mpll3_init_regs[] = {
+	{ .reg = ANACTRL_MPLL_CTRL8, .def = 0x40000033 }
+};
+
+static struct clk_regmap s4_mpll3_div = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = ANACTRL_MPLL_CTRL7,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = ANACTRL_MPLL_CTRL7,
+			.shift   = 30,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = ANACTRL_MPLL_CTRL7,
+			.shift   = 20,
+			.width   = 9,
+		},
+		.ssen = {
+			.reg_off = ANACTRL_MPLL_CTRL7,
+			.shift   = 29,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
+		.init_regs = s4_mpll3_init_regs,
+		.init_count = ARRAY_SIZE(s4_mpll3_init_regs),
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll3_div",
+		.ops = &meson_clk_mpll_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_mpll_prediv.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_mpll3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = ANACTRL_MPLL_CTRL7,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mpll3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_mpll3_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/*
+ * rtc 32k clock
+ *
+ * xtal--GATE------------------GATE---------------------|\
+ *		       |  --------                      | \
+ *	               |  |      |                      |  \
+ *	               ---| DUAL |----------------------|   |
+ *	                  |      |                      |   |____GATE__
+ *	                  --------                      |   |           rtc_32k_out
+ *	    PAD-----------------------------------------|  /
+ *	                                                | /
+ *	   D UAL function:                              |/
+ *	   bit 28 in RTC_BY_OSCIN_CTRL0 control the dual function.
+ *	   when bit 28 = 0
+ *	         f = 24M/N0
+ *	   when bit 28 = 1
+ *	         output N1 and N2 in rurn.
+ *	   T = (x*T1 + y*T2)/x+y
+ *	   f = (24M/(N0*M0 + N1*M1)) * (M0 + M1)
+ *	   f: the frequecy value (HZ)
+ *	       |      | |      |
+ *	       | Div1 |-| Cnt1 |
+ *	      /|______| |______|\
+ *	    -|  ______   ______  ---> Out
+ *	      \|      | |      |/
+ *	       | Div2 |-| Cnt2 |
+ *	       |______| |______|
+ */
+
+/*
+ * rtc 32k clock in gate
+ */
+static struct clk_regmap s4_rtc_32k_by_oscin_clkin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "rtc_32k_by_oscin_clkin",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", }
+		},
+		.num_parents = 1,
+	},
+};
+
+static const struct meson_clk_dualdiv_param s4_32k_div_table[] = {
+	{
+		.dual	= 1,
+		.n1	= 733,
+		.m1	= 8,
+		.n2	= 732,
+		.m2	= 11,
+	},
+	{}
+};
+
+static struct clk_regmap s4_rtc_32k_by_oscin_div = {
+	.data = &(struct meson_clk_dualdiv_data){
+		.n1 = {
+			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.n2 = {
+			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.m1 = {
+			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.m2 = {
+			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.dual = {
+			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.table = s4_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "rtc_32k_by_oscin_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_rtc_32k_by_oscin_clkin.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_rtc_32k_by_oscin_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL1,
+		.mask = 0x1,
+		.shift = 24,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "rtc_32k_by_oscin_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_rtc_32k_by_oscin_div.hw,
+			&s4_rtc_32k_by_oscin_clkin.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_rtc_32k_by_oscin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "rtc_32k_by_oscin",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_rtc_32k_by_oscin_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static u32 rtc_clk_sel[] = { 0, 1 };
+static const struct clk_parent_data rtc_clk_sel_parent_data[] = {
+	{ .hw = &s4_rtc_32k_by_oscin.hw },
+	{ .hw = &s4_rtc_32k_by_oscin_div.hw },
+	{ .fw_name = "ext-32k-0",  }
+};
+
+static struct clk_regmap s4_rtc_clk = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_RTC_CTRL,
+		.mask = 0x3,
+		.shift = 0,
+		.table = rtc_clk_sel,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "rtc_clk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = rtc_clk_sel_parent_data,
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* sys clk */
+static u32 mux_table_sys_ab_clk_sel[] = { 0, 1, 2, 3, 4, 6, 7 };
+static const struct clk_parent_data sys_ab_clk_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_fclk_div2.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div5.hw },
+	{ .hw = &s4_fclk_div7.hw },
+	{ .hw = &s4_rtc_clk.hw }
+};
+
+static struct clk_regmap s4_sysclk_b_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_SYS_CLK_CTRL0,
+		.mask = 0x7,
+		.shift = 26,
+		.table = mux_table_sys_ab_clk_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sysclk_b_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_data = sys_ab_clk_parent_data,
+		.num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
+	},
+};
+
+static struct clk_regmap s4_sysclk_b_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_SYS_CLK_CTRL0,
+		.shift = 16,
+		.width = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sysclk_b_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sysclk_b_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sysclk_b = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_SYS_CLK_CTRL0,
+		.bit_idx = 29,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sysclk_b",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sysclk_b_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_regmap s4_sysclk_a_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_SYS_CLK_CTRL0,
+		.mask = 0x7,
+		.shift = 10,
+		.table = mux_table_sys_ab_clk_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sysclk_a_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_data = sys_ab_clk_parent_data,
+		.num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
+	},
+};
+
+static struct clk_regmap s4_sysclk_a_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_SYS_CLK_CTRL0,
+		.shift = 0,
+		.width = 10,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sysclk_a_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sysclk_a_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sysclk_a = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_SYS_CLK_CTRL0,
+		.bit_idx = 13,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sysclk_a",
+		.ops = &clk_regmap_gate_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sysclk_a_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_regmap s4_sys_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_SYS_CLK_CTRL0,
+		.mask = 0x1,
+		.shift = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sys_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sysclk_a.hw,
+			&s4_sysclk_b.hw
+		},
+		.num_parents = 2,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_ceca_32k_clkin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_CECA_CTRL0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "ceca_32k_clkin",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", }
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_ceca_32k_div = {
+	.data = &(struct meson_clk_dualdiv_data){
+		.n1 = {
+			.reg_off = CLKCTRL_CECA_CTRL0,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.n2 = {
+			.reg_off = CLKCTRL_CECA_CTRL0,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.m1 = {
+			.reg_off = CLKCTRL_CECA_CTRL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.m2 = {
+			.reg_off = CLKCTRL_CECA_CTRL1,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.dual = {
+			.reg_off = CLKCTRL_CECA_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.table = s4_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ceca_32k_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_ceca_32k_clkin.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_ceca_32k_sel_pre = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_CECA_CTRL1,
+		.mask = 0x1,
+		.shift = 24,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ceca_32k_sel_pre",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_ceca_32k_div.hw,
+			&s4_ceca_32k_clkin.hw
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_ceca_32k_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_CECA_CTRL1,
+		.mask = 0x1,
+		.shift = 31,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ceca_32k_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_ceca_32k_sel_pre.hw,
+			&s4_rtc_clk.hw
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_ceca_32k_clkout = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_CECA_CTRL0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ceca_32k_clkout",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_ceca_32k_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_cecb_32k_clkin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_CECB_CTRL0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cecb_32k_clkin",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", }
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_cecb_32k_div = {
+	.data = &(struct meson_clk_dualdiv_data){
+		.n1 = {
+			.reg_off = CLKCTRL_CECB_CTRL0,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.n2 = {
+			.reg_off = CLKCTRL_CECB_CTRL0,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.m1 = {
+			.reg_off = CLKCTRL_CECB_CTRL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.m2 = {
+			.reg_off = CLKCTRL_CECB_CTRL1,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.dual = {
+			.reg_off = CLKCTRL_CECB_CTRL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.table = s4_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cecb_32k_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cecb_32k_clkin.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_cecb_32k_sel_pre = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_CECB_CTRL1,
+		.mask = 0x1,
+		.shift = 24,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cecb_32k_sel_pre",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cecb_32k_div.hw,
+			&s4_cecb_32k_clkin.hw
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_cecb_32k_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_CECB_CTRL1,
+		.mask = 0x1,
+		.shift = 31,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cecb_32k_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cecb_32k_sel_pre.hw,
+			&s4_rtc_clk.hw
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_cecb_32k_clkout = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_CECB_CTRL0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cecb_32k_clkout",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cecb_32k_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_parent_data s4_sc_parent_data[] = {
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div5.hw },
+	{ .fw_name = "xtal", }
+};
+
+static struct clk_regmap s4_sc_clk_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_SC_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sc_clk_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_sc_parent_data,
+		.num_parents = ARRAY_SIZE(s4_sc_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sc_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_SC_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sc_clk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sc_clk_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sc_clk_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_SC_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sc_clk_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sc_clk_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_12_24M_clk_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_CLK12_24_CTRL,
+		.bit_idx = 11,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "12_24m_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", }
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_12M_clk_div = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "12M",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_12_24M_clk_gate.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_12_24M_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_CLK12_24_CTRL,
+		.mask = 0x1,
+		.shift = 10,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "12_24m",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_12_24M_clk_gate.hw,
+			&s4_12M_clk_div.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* Video Clocks */
+static struct clk_regmap s4_vid_pll_div = {
+	.data = &(struct meson_vid_pll_div_data){
+		.val = {
+			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
+			.shift   = 0,
+			.width   = 15,
+		},
+		.sel = {
+			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
+			.shift   = 16,
+			.width   = 2,
+		},
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vid_pll_div",
+		.ops = &meson_vid_pll_div_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_hdmi_pll.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_vid_pll_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VID_PLL_CLK_DIV,
+		.mask = 0x1,
+		.shift = 18,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vid_pll_sel",
+		.ops = &clk_regmap_mux_ops,
+		/*
+		 * bit 18 selects from 2 possible parents:
+		 * vid_pll_div or hdmi_pll
+		 */
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vid_pll_div.hw,
+			&s4_hdmi_pll.hw
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_vid_pll = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_PLL_CLK_DIV,
+		.bit_idx = 19,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vid_pll",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vid_pll_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static const struct clk_hw *s4_vclk_parent_hws[] = {
+	&s4_vid_pll.hw,
+	&s4_gp0_pll.hw,
+	&s4_hifi_pll.hw,
+	&s4_mpll1.hw,
+	&s4_fclk_div3.hw,
+	&s4_fclk_div4.hw,
+	&s4_fclk_div5.hw,
+	&s4_fclk_div7.hw
+};
+
+static struct clk_regmap s4_vclk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VID_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_vclk_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_vclk_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_vclk2_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VIID_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_vclk_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_vclk_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_vclk_input = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_DIV,
+		.bit_idx = 16,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_input",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk_sel.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk2_input = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VIID_CLK_DIV,
+		.bit_idx = 16,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_input",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2_sel.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VID_CLK_DIV,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk_input.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_vclk2_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VIID_CLK_DIV,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk2_input.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_vclk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL,
+		.bit_idx = 19,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VIID_CLK_CTRL,
+		.bit_idx = 19,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk_div1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk_div2_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div2_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk_div4_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div4_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk_div6_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div6_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk_div12_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk_div12_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk2_div1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VIID_CLK_CTRL,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk2_div2_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VIID_CLK_CTRL,
+		.bit_idx = 1,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div2_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk2_div4_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VIID_CLK_CTRL,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div4_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk2_div6_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VIID_CLK_CTRL,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div6_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vclk2_div12_en = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VIID_CLK_CTRL,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vclk2_div12_en",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vclk2.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_fixed_factor s4_vclk_div2 = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk_div2_en.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_vclk_div4 = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div4",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk_div4_en.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_vclk_div6 = {
+	.mult = 1,
+	.div = 6,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div6",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk_div6_en.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_vclk_div12 = {
+	.mult = 1,
+	.div = 12,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk_div12",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk_div12_en.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_vclk2_div2 = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk2_div2_en.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_vclk2_div4 = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div4",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk2_div4_en.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_vclk2_div6 = {
+	.mult = 1,
+	.div = 6,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div6",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk2_div6_en.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_fixed_factor s4_vclk2_div12 = {
+	.mult = 1,
+	.div = 12,
+	.hw.init = &(struct clk_init_data){
+		.name = "vclk2_div12",
+		.ops = &clk_fixed_factor_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk2_div12_en.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
+static const struct clk_hw *s4_cts_parent_hws[] = {
+	&s4_vclk_div1.hw,
+	&s4_vclk_div2.hw,
+	&s4_vclk_div4.hw,
+	&s4_vclk_div6.hw,
+	&s4_vclk_div12.hw,
+	&s4_vclk2_div1.hw,
+	&s4_vclk2_div2.hw,
+	&s4_vclk2_div4.hw,
+	&s4_vclk2_div6.hw,
+	&s4_vclk2_div12.hw
+};
+
+static struct clk_regmap s4_cts_enci_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 28,
+		.table = mux_table_cts_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_enci_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_cts_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_cts_encp_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 20,
+		.table = mux_table_cts_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_encp_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_cts_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_cts_vdac_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VIID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 28,
+		.table = mux_table_cts_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_vdac_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_cts_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+/* TOFIX: add support for cts_tcon */
+static u32 mux_table_hdmi_tx_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
+static const struct clk_hw *s4_cts_hdmi_tx_parent_hws[] = {
+	&s4_vclk_div1.hw,
+	&s4_vclk_div2.hw,
+	&s4_vclk_div4.hw,
+	&s4_vclk_div6.hw,
+	&s4_vclk_div12.hw,
+	&s4_vclk2_div1.hw,
+	&s4_vclk2_div2.hw,
+	&s4_vclk2_div4.hw,
+	&s4_vclk2_div6.hw,
+	&s4_vclk2_div12.hw
+};
+
+static struct clk_regmap s4_hdmi_tx_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_HDMI_CLK_CTRL,
+		.mask = 0xf,
+		.shift = 16,
+		.table = mux_table_hdmi_tx_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_tx_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_cts_hdmi_tx_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_cts_hdmi_tx_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_cts_enci = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL2,
+		.bit_idx = 0,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_enci",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cts_enci_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_cts_encp = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL2,
+		.bit_idx = 2,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_encp",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cts_encp_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_cts_vdac = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL2,
+		.bit_idx = 4,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_vdac",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cts_vdac_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_hdmi_tx = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL2,
+		.bit_idx = 5,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hdmi_tx",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hdmi_tx_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+/* HDMI Clocks */
+static const struct clk_parent_data s4_hdmi_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div5.hw }
+};
+
+static struct clk_regmap s4_hdmi_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_HDMI_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_hdmi_parent_data,
+		.num_parents = ARRAY_SIZE(s4_hdmi_parent_data),
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_hdmi_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_HDMI_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdmi_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_hdmi_sel.hw },
+		.num_parents = 1,
+		.flags = CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_regmap s4_hdmi = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_HDMI_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hdmi",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_hdmi_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_ts_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_TS_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ts_clk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "xtal",
+		},
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap s4_ts_clk_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_TS_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ts_clk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_ts_clk_div.hw
+		},
+		.num_parents = 1,
+	},
+};
+
+/*
+ * The MALI IP is clocked by two identical clocks (mali_0 and mali_1)
+ * muxed by a glitch-free switch. The CCF can manage this glitch-free
+ * mux because it does top-to-bottom updates the each clock tree and
+ * switches to the "inactive" one when CLK_SET_RATE_GATE is set.
+ */
+static const struct clk_parent_data s4_mali_0_1_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_gp0_pll.hw },
+	{ .hw = &s4_hifi_pll.hw },
+	{ .hw = &s4_fclk_div2p5.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div5.hw },
+	{ .hw = &s4_fclk_div7.hw }
+};
+
+static struct clk_regmap s4_mali_0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_MALI_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_0_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_mali_0_1_parent_data,
+		.num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
+		/*
+		 * Don't request the parent to change the rate because
+		 * all GPU frequencies can be derived from the fclk_*
+		 * clocks and one special GP0_PLL setting. This is
+		 * important because we need the MPLL clocks for audio.
+		 */
+		.flags = 0,
+	},
+};
+
+static struct clk_regmap s4_mali_0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_MALI_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_mali_0_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_mali_0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_MALI_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_mali_0_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_mali_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_MALI_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_1_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_mali_0_1_parent_data,
+		.num_parents = ARRAY_SIZE(s4_mali_0_1_parent_data),
+		/*
+		 * Don't request the parent to change the rate because
+		 * all GPU frequencies can be derived from the fclk_*
+		 * clocks and one special GP0_PLL setting. This is
+		 * important because we need the MPLL clocks for audio.
+		 */
+		.flags = 0,
+	},
+};
+
+static struct clk_regmap s4_mali_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_MALI_CLK_CTRL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_mali_1_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_mali_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_MALI_CLK_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali_1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_mali_1_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_hw *s4_mali_parent_hws[] = {
+	&s4_mali_0.hw,
+	&s4_mali_1.hw
+};
+
+static struct clk_regmap s4_mali_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_MALI_CLK_CTRL,
+		.mask = 1,
+		.shift = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "mali",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_mali_parent_hws,
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* VDEC clocks */
+static const struct clk_parent_data s4_dec_parent_data[] = {
+	{ .hw = &s4_fclk_div2p5.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div5.hw },
+	{ .hw = &s4_fclk_div7.hw },
+	{ .hw = &s4_hifi_pll.hw },
+	{ .hw = &s4_gp0_pll.hw },
+	{ .fw_name = "xtal", }
+};
+
+static struct clk_regmap s4_vdec_p0_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VDEC_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_p0_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_dec_parent_data,
+		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vdec_p0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VDEC_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_p0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vdec_p0_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vdec_p0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VDEC_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_p0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vdec_p0_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vdec_p1_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VDEC3_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_p1_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_dec_parent_data,
+		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vdec_p1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VDEC3_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_p1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vdec_p1_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vdec_p1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VDEC3_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdec_p1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vdec_p1_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_hw *s4_vdec_mux_parent_hws[] = {
+	&s4_vdec_p0.hw,
+	&s4_vdec_p1.hw
+};
+
+static struct clk_regmap s4_vdec_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VDEC3_CLK_CTRL,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdec_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_vdec_mux_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_vdec_mux_parent_hws),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hevcf_p0_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VDEC2_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hevcf_p0_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_dec_parent_data,
+		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hevcf_p0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VDEC2_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hevcf_p0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hevcf_p0_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hevcf_p0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VDEC2_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hevcf_p0_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hevcf_p0_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hevcf_p1_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VDEC4_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hevcf_p1_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_dec_parent_data,
+		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hevcf_p1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VDEC4_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hevcf_p1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hevcf_p1_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hevcf_p1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VDEC4_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hevcf_p1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hevcf_p1_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_hw *s4_hevcf_mux_parent_hws[] = {
+	&s4_hevcf_p0.hw,
+	&s4_hevcf_p1.hw
+};
+
+static struct clk_regmap s4_hevcf_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VDEC4_CLK_CTRL,
+		.mask = 0x1,
+		.shift = 15,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hevcf",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_hevcf_mux_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_hevcf_mux_parent_hws),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* VPU Clock */
+
+static const struct clk_hw *s4_vpu_parent_hws[] = {
+	&s4_fclk_div3.hw,
+	&s4_fclk_div4.hw,
+	&s4_fclk_div5.hw,
+	&s4_fclk_div7.hw,
+	&s4_mpll1.hw,
+	&s4_vid_pll.hw,
+	&s4_hifi_pll.hw,
+	&s4_gp0_pll.hw
+};
+
+static struct clk_regmap s4_vpu_0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VPU_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_0_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_vpu_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_vpu_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VPU_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_sel.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VPU_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_0_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vpu_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VPU_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_1_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_vpu_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_vpu_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VPU_CLK_CTRL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_sel.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VPU_CLK_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vpu_1_div.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vpu = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VPU_CLK_CTRL,
+		.mask = 1,
+		.shift = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu",
+		.ops = &clk_regmap_mux_ops,
+		/*
+		 * bit 31 selects from 2 possible parents:
+		 * vpu_0 or vpu_1
+		 */
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vpu_0.hw,
+			&s4_vpu_1.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static const struct clk_parent_data vpu_clkb_tmp_parent_data[] = {
+	{ .hw = &s4_vpu.hw },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div5.hw },
+	{ .hw = &s4_fclk_div7.hw }
+};
+
+static struct clk_regmap s4_vpu_clkb_tmp_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VPU_CLKB_CTRL,
+		.mask = 0x3,
+		.shift = 20,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_clkb_tmp_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = vpu_clkb_tmp_parent_data,
+		.num_parents = ARRAY_SIZE(vpu_clkb_tmp_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_clkb_tmp_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VPU_CLKB_CTRL,
+		.shift = 16,
+		.width = 4,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_clkb_tmp_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vpu_clkb_tmp_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_clkb_tmp = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VPU_CLKB_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_clkb_tmp",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vpu_clkb_tmp_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_clkb_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VPU_CLKB_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_clkb_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vpu_clkb_tmp.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_clkb = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VPU_CLKB_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_clkb",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vpu_clkb_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_hw *vpu_clkc_parent_hws[] = {
+	&s4_fclk_div4.hw,
+	&s4_fclk_div3.hw,
+	&s4_fclk_div5.hw,
+	&s4_fclk_div7.hw,
+	&s4_mpll1.hw,
+	&s4_vid_pll.hw,
+	&s4_mpll2.hw,
+	&s4_gp0_pll.hw
+};
+
+static struct clk_regmap s4_vpu_clkc_p0_mux  = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VPU_CLKC_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_clkc_p0_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = vpu_clkc_parent_hws,
+		.num_parents = ARRAY_SIZE(vpu_clkc_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_clkc_p0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VPU_CLKC_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_clkc_p0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vpu_clkc_p0_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_clkc_p0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VPU_CLKC_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_clkc_p0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vpu_clkc_p0_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vpu_clkc_p1_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VPU_CLKC_CTRL,
+		.mask = 0x7,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_clkc_p1_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = vpu_clkc_parent_hws,
+		.num_parents = ARRAY_SIZE(vpu_clkc_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_clkc_p1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VPU_CLKC_CTRL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_clkc_p1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vpu_clkc_p1_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vpu_clkc_p1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VPU_CLKC_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vpu_clkc_p1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vpu_clkc_p1_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static const struct clk_hw *s4_vpu_mux_parent_hws[] = {
+	&s4_vpu_clkc_p0.hw,
+	&s4_vpu_clkc_p1.hw
+};
+
+static struct clk_regmap s4_vpu_clkc_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VPU_CLKC_CTRL,
+		.mask = 0x1,
+		.shift = 31,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vpu_clkc_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_vpu_mux_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_vpu_mux_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+/* VAPB Clock */
+
+static const struct clk_hw *s4_vapb_parent_hws[] = {
+	&s4_fclk_div4.hw,
+	&s4_fclk_div3.hw,
+	&s4_fclk_div5.hw,
+	&s4_fclk_div7.hw,
+	&s4_mpll1.hw,
+	&s4_vid_pll.hw,
+	&s4_mpll2.hw,
+	&s4_fclk_div2p5.hw
+};
+
+static struct clk_regmap s4_vapb_0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VAPBCLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vapb_0_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_vapb_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_vapb_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static struct clk_regmap s4_vapb_0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VAPBCLK_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vapb_0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vapb_0_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vapb_0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VAPBCLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vapb_0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vapb_0_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vapb_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VAPBCLK_CTRL,
+		.mask = 0x7,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vapb_1_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_vapb_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_vapb_parent_hws),
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static struct clk_regmap s4_vapb_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VAPBCLK_CTRL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vapb_1_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vapb_1_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vapb_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VAPBCLK_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vapb_1",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vapb_1_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap s4_vapb = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VAPBCLK_CTRL,
+		.mask = 1,
+		.shift = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vapb_sel",
+		.ops = &clk_regmap_mux_ops,
+		/*
+		 * bit 31 selects from 2 possible parents:
+		 * vapb_0 or vapb_1
+		 */
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vapb_0.hw,
+			&s4_vapb_1.hw
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
+static struct clk_regmap s4_ge2d_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VAPBCLK_CTRL,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "ge2d_clk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) { &s4_vapb.hw },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_hw *s4_esmclk_parent_hws[] = {
+	&s4_fclk_div7.hw,
+	&s4_fclk_div4.hw,
+	&s4_fclk_div3.hw,
+	&s4_fclk_div5.hw
+};
+
+static struct clk_regmap s4_hdcp22_esmclk_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_HDCP22_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hdcp22_esmclk_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_esmclk_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_esmclk_parent_hws),
+	},
+};
+
+static struct clk_regmap s4_hdcp22_esmclk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_HDCP22_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hdcp22_esmclk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hdcp22_esmclk_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hdcp22_esmclk_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_HDCP22_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdcp22_esmclk_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hdcp22_esmclk_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_parent_data s4_skpclk_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div5.hw }
+};
+
+static struct clk_regmap s4_hdcp22_skpclk_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_HDCP22_CTRL,
+		.mask = 0x3,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hdcp22_skpclk_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_skpclk_parent_data,
+		.num_parents = ARRAY_SIZE(s4_skpclk_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hdcp22_skpclk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_HDCP22_CTRL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "hdcp22_skpclk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hdcp22_skpclk_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_hdcp22_skpclk_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_HDCP22_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hdcp22_skpclk_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_hdcp22_skpclk_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_parent_data s4_vdin_parent_data[]  = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div5.hw },
+	{ .hw = &s4_vid_pll.hw }
+};
+
+static struct clk_regmap s4_vdin_meas_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdin_meas_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_vdin_parent_data,
+		.num_parents = ARRAY_SIZE(s4_vdin_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vdin_meas_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "vdin_meas_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vdin_meas_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_vdin_meas_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VDIN_MEAS_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "vdin_meas_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vdin_meas_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* EMMC/NAND clock */
+
+static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_fclk_div2.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_hifi_pll.hw },
+	{ .hw = &s4_fclk_div2p5.hw },
+	/*
+	 * Following these parent clocks, we should also have had mpll2, mpll3
+	 * and gp0_pll but these clocks are too precious to be used here. All
+	 * the necessary rates for MMC and NAND operation can be acheived using
+	 * hifi_pll or fclk_div clocks
+	 */
+};
+
+static struct clk_regmap s4_sd_emmc_c_clk0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_NAND_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_c_clk0_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_sd_emmc_clk0_parent_data,
+		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sd_emmc_c_clk0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_NAND_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_c_clk0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sd_emmc_c_clk0_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sd_emmc_c_clk0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_NAND_CLK_CTRL,
+		.bit_idx = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_c_clk0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sd_emmc_c_clk0_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sd_emmc_a_clk0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_a_clk0_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_sd_emmc_clk0_parent_data,
+		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sd_emmc_a_clk0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_a_clk0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sd_emmc_a_clk0_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sd_emmc_a_clk0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
+		.bit_idx = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_a_clk0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sd_emmc_a_clk0_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sd_emmc_b_clk0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_b_clk0_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_sd_emmc_clk0_parent_data,
+		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sd_emmc_b_clk0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "sd_emmc_b_clk0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sd_emmc_b_clk0_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_sd_emmc_b_clk0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
+		.bit_idx = 23,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "sd_emmc_b_clk0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_sd_emmc_b_clk0_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* SPICC SCLK source clock */
+
+static const struct clk_parent_data s4_spicc_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_sys_clk.hw },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div2.hw },
+	{ .hw = &s4_fclk_div5.hw },
+	{ .hw = &s4_fclk_div7.hw },
+};
+
+static struct clk_regmap s4_spicc0_mux = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_SPICC_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "spicc0_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_spicc_parent_data,
+		.num_parents = ARRAY_SIZE(s4_spicc_parent_data),
+	},
+};
+
+static struct clk_regmap s4_spicc0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_SPICC_CLK_CTRL,
+		.shift = 0,
+		.width = 6,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "spicc0_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_spicc0_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_spicc0_gate = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_SPICC_CLK_CTRL,
+		.bit_idx = 6,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "spicc0",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_spicc0_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* PWM CLOCK */
+
+static const struct clk_parent_data s4_pwm_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_vid_pll.hw },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div3.hw }
+};
+
+static struct clk_regmap s4_pwm_a_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_a_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_a_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_a_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_a_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_a_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_a_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_a_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_b_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
+		.mask = 0x3,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_b_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_b_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
+		.shift = 16,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_b_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_b_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_b_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_b_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_b_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_c_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_c_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_c_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_c_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_c_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_c_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_c_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_c_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_d_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
+		.mask = 0x3,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_d_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_d_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
+		.shift = 16,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_d_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_d_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_d_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_d_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_d_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_e_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_e_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_e_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_e_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_e_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_e_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_e_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_e_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_f_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
+		.mask = 0x3,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_f_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_f_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
+		.shift = 16,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_f_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_f_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_f_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_f_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_f_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_g_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_g_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_g_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_g_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_g_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_g_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_g_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_g_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_h_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
+		.mask = 0x3,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_h_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_h_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
+		.shift = 16,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_h_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_h_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_h_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_h_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_h_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_i_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_i_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_i_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_i_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_i_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_i_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_i_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_i_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_j_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
+		.mask = 0x3,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_j_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_pwm_parent_data,
+		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_j_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
+		.shift = 16,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_j_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_h_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_pwm_j_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "pwm_j_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_pwm_j_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_saradc_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_SAR_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "saradc_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &s4_sys_clk.hw },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap s4_saradc_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_SAR_CLK_CTRL,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "saradc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_saradc_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_saradc_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_SAR_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "saradc_clk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_saradc_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static u32 s4_gen_clk_mux_table[] = { 0, 5, 7, 19, 21, 22,
+				      23, 24, 25, 26, 27, 28 };
+static const struct clk_parent_data s4_gen_clk_parent_data[] = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_gp0_pll.hw },
+	{ .hw = &s4_hifi_pll.hw },
+	{ .hw = &s4_fclk_div2.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div5.hw },
+	{ .hw = &s4_fclk_div7.hw },
+	{ .hw = &s4_mpll0.hw },
+	{ .hw = &s4_mpll1.hw },
+	{ .hw = &s4_mpll2.hw },
+	{ .hw = &s4_mpll3.hw }
+};
+
+static struct clk_regmap s4_gen_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_GEN_CLK_CTRL,
+		.mask = 0x1f,
+		.shift = 12,
+		.table = s4_gen_clk_mux_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gen_clk_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_gen_clk_parent_data,
+		.num_parents = ARRAY_SIZE(s4_gen_clk_parent_data),
+	},
+};
+
+static struct clk_regmap s4_gen_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = CLKCTRL_GEN_CLK_CTRL,
+		.shift = 0,
+		.width = 11,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "gen_clk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_gen_clk_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_gen_clk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_GEN_CLK_CTRL,
+		.bit_idx = 11,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "gen_clk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_gen_clk_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_parent_data s4_adc_extclk_in_parent_data[]  = {
+	{ .fw_name = "xtal", },
+	{ .hw = &s4_fclk_div4.hw },
+	{ .hw = &s4_fclk_div3.hw },
+	{ .hw = &s4_fclk_div5.hw },
+	{ .hw = &s4_fclk_div7.hw },
+	{ .hw = &s4_mpll2.hw },
+	{ .hw = &s4_gp0_pll.hw },
+	{ .hw = &s4_hifi_pll.hw }
+};
+
+static struct clk_regmap s4_adc_extclk_in_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "adc_extclk_in_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = s4_adc_extclk_in_parent_data,
+		.num_parents = ARRAY_SIZE(s4_adc_extclk_in_parent_data),
+	},
+};
+
+static struct clk_regmap s4_adc_extclk_in_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "adc_extclk_in_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_adc_extclk_in_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_adc_extclk_in_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.bit_idx = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "adc_extclk_in",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_adc_extclk_in_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_demod_core_clk_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "demod_core_clk_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .hw = &s4_fclk_div7.hw },
+			{ .hw = &s4_fclk_div4.hw },
+			{ .hw = &s4_adc_extclk_in_gate.hw }
+		},
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_demod_core_clk_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "demod_core_clk_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_demod_core_clk_mux.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_demod_core_clk_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "demod_core_clk",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_demod_core_clk_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+#define MESON_GATE(_name, _reg, _bit) \
+	MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw)
+
+static MESON_GATE(s4_ddr,		CLKCTRL_SYS_CLK_EN0_REG0, 0);
+static MESON_GATE(s4_dos,		CLKCTRL_SYS_CLK_EN0_REG0, 1);
+static MESON_GATE(s4_ethphy,		CLKCTRL_SYS_CLK_EN0_REG0, 4);
+static MESON_GATE(s4_mali,		CLKCTRL_SYS_CLK_EN0_REG0, 6);
+static MESON_GATE(s4_aocpu,		CLKCTRL_SYS_CLK_EN0_REG0, 13);
+static MESON_GATE(s4_aucpu,		CLKCTRL_SYS_CLK_EN0_REG0, 14);
+static MESON_GATE(s4_cec,		CLKCTRL_SYS_CLK_EN0_REG0, 16);
+static MESON_GATE(s4_sdemmca,		CLKCTRL_SYS_CLK_EN0_REG0, 24);
+static MESON_GATE(s4_sdemmcb,		CLKCTRL_SYS_CLK_EN0_REG0, 25);
+static MESON_GATE(s4_nand,		CLKCTRL_SYS_CLK_EN0_REG0, 26);
+static MESON_GATE(s4_smartcard,		CLKCTRL_SYS_CLK_EN0_REG0, 27);
+static MESON_GATE(s4_acodec,		CLKCTRL_SYS_CLK_EN0_REG0, 28);
+static MESON_GATE(s4_spifc,		CLKCTRL_SYS_CLK_EN0_REG0, 29);
+static MESON_GATE(s4_msr_clk,		CLKCTRL_SYS_CLK_EN0_REG0, 30);
+static MESON_GATE(s4_ir_ctrl,		CLKCTRL_SYS_CLK_EN0_REG0, 31);
+
+static MESON_GATE(s4_audio,		CLKCTRL_SYS_CLK_EN0_REG1, 0);
+static MESON_GATE(s4_eth,		CLKCTRL_SYS_CLK_EN0_REG1, 3);
+static MESON_GATE(s4_uart_a,		CLKCTRL_SYS_CLK_EN0_REG1, 5);
+static MESON_GATE(s4_uart_b,		CLKCTRL_SYS_CLK_EN0_REG1, 6);
+static MESON_GATE(s4_uart_c,		CLKCTRL_SYS_CLK_EN0_REG1, 7);
+static MESON_GATE(s4_uart_d,		CLKCTRL_SYS_CLK_EN0_REG1, 8);
+static MESON_GATE(s4_uart_e,		CLKCTRL_SYS_CLK_EN0_REG1, 9);
+static MESON_GATE(s4_aififo,		CLKCTRL_SYS_CLK_EN0_REG1, 11);
+static MESON_GATE(s4_ts_ddr,		CLKCTRL_SYS_CLK_EN0_REG1, 15);
+static MESON_GATE(s4_ts_pll,		CLKCTRL_SYS_CLK_EN0_REG1, 16);
+static MESON_GATE(s4_g2d,		CLKCTRL_SYS_CLK_EN0_REG1, 20);
+static MESON_GATE(s4_spicc0,		CLKCTRL_SYS_CLK_EN0_REG1, 21);
+static MESON_GATE(s4_usb,		CLKCTRL_SYS_CLK_EN0_REG1, 26);
+static MESON_GATE(s4_i2c_m_a,		CLKCTRL_SYS_CLK_EN0_REG1, 30);
+static MESON_GATE(s4_i2c_m_b,		CLKCTRL_SYS_CLK_EN0_REG1, 31);
+
+static MESON_GATE(s4_i2c_m_c,		CLKCTRL_SYS_CLK_EN0_REG2, 0);
+static MESON_GATE(s4_i2c_m_d,		CLKCTRL_SYS_CLK_EN0_REG2, 1);
+static MESON_GATE(s4_i2c_m_e,		CLKCTRL_SYS_CLK_EN0_REG2, 2);
+static MESON_GATE(s4_hdmitx_apb,	CLKCTRL_SYS_CLK_EN0_REG2, 4);
+static MESON_GATE(s4_i2c_s_a,		CLKCTRL_SYS_CLK_EN0_REG2, 5);
+static MESON_GATE(s4_usb1_to_ddr,	CLKCTRL_SYS_CLK_EN0_REG2, 8);
+static MESON_GATE(s4_hdcp22,		CLKCTRL_SYS_CLK_EN0_REG2, 10);
+static MESON_GATE(s4_mmc_apb,		CLKCTRL_SYS_CLK_EN0_REG2, 11);
+static MESON_GATE(s4_rsa,		CLKCTRL_SYS_CLK_EN0_REG2, 18);
+static MESON_GATE(s4_cpu_debug,		CLKCTRL_SYS_CLK_EN0_REG2, 19);
+static MESON_GATE(s4_vpu_intr,		CLKCTRL_SYS_CLK_EN0_REG2, 25);
+static MESON_GATE(s4_demod,		CLKCTRL_SYS_CLK_EN0_REG2, 27);
+static MESON_GATE(s4_sar_adc,		CLKCTRL_SYS_CLK_EN0_REG2, 28);
+static MESON_GATE(s4_gic,		CLKCTRL_SYS_CLK_EN0_REG2, 30);
+
+static MESON_GATE(s4_pwm_ab,		CLKCTRL_SYS_CLK_EN0_REG3, 7);
+static MESON_GATE(s4_pwm_cd,		CLKCTRL_SYS_CLK_EN0_REG3, 8);
+static MESON_GATE(s4_pwm_ef,		CLKCTRL_SYS_CLK_EN0_REG3, 9);
+static MESON_GATE(s4_pwm_gh,		CLKCTRL_SYS_CLK_EN0_REG3, 10);
+static MESON_GATE(s4_pwm_ij,		CLKCTRL_SYS_CLK_EN0_REG3, 11);
+
+/* Array of all clocks provided by this provider */
+static struct clk_hw_onecell_data s4_hw_onecell_data = {
+	.hws = {
+		[CLKID_FIXED_PLL_DCO]		= &s4_fixed_pll_dco.hw,
+		[CLKID_FIXED_PLL]		= &s4_fixed_pll.hw,
+		[CLKID_FCLK_DIV2_DIV]		= &s4_fclk_div2_div.hw,
+		[CLKID_FCLK_DIV2]		= &s4_fclk_div2.hw,
+		[CLKID_FCLK_DIV3_DIV]		= &s4_fclk_div3_div.hw,
+		[CLKID_FCLK_DIV3]		= &s4_fclk_div3.hw,
+		[CLKID_FCLK_DIV4_DIV]		= &s4_fclk_div4_div.hw,
+		[CLKID_FCLK_DIV4]		= &s4_fclk_div4.hw,
+		[CLKID_FCLK_DIV5_DIV]		= &s4_fclk_div5_div.hw,
+		[CLKID_FCLK_DIV5]		= &s4_fclk_div5.hw,
+		[CLKID_FCLK_DIV7_DIV]		= &s4_fclk_div7_div.hw,
+		[CLKID_FCLK_DIV7]		= &s4_fclk_div7.hw,
+		[CLKID_FCLK_DIV2P5_DIV]		= &s4_fclk_div2p5_div.hw,
+		[CLKID_FCLK_DIV2P5]		= &s4_fclk_div2p5.hw,
+
+		[CLKID_GP0_PLL_DCO]		= &s4_gp0_pll_dco.hw,
+		[CLKID_GP0_PLL]			= &s4_gp0_pll.hw,
+
+		[CLKID_HIFI_PLL_DCO]		= &s4_hifi_pll_dco.hw,
+		[CLKID_HIFI_PLL]		= &s4_hifi_pll.hw,
+		[CLKID_HDMI_PLL_DCO]		= &s4_hdmi_pll_dco.hw,
+		[CLKID_HDMI_PLL_OD]		= &s4_hdmi_pll_od.hw,
+		[CLKID_HDMI_PLL]		= &s4_hdmi_pll.hw,
+		[CLKID_MPLL_50M_DIV]		= &s4_mpll_50m_div.hw,
+		[CLKID_MPLL_50M]		= &s4_mpll_50m.hw,
+		[CLKID_MPLL_PREDIV]		= &s4_mpll_prediv.hw,
+		[CLKID_MPLL0_DIV]		= &s4_mpll0_div.hw,
+		[CLKID_MPLL0]			= &s4_mpll0.hw,
+		[CLKID_MPLL1_DIV]		= &s4_mpll1_div.hw,
+		[CLKID_MPLL1]			= &s4_mpll1.hw,
+		[CLKID_MPLL2_DIV]		= &s4_mpll2_div.hw,
+		[CLKID_MPLL2]			= &s4_mpll2.hw,
+		[CLKID_MPLL3_DIV]		= &s4_mpll3_div.hw,
+		[CLKID_MPLL3]			= &s4_mpll3.hw,
+
+		[CLKID_RTC_32K_CLKIN]		= &s4_rtc_32k_by_oscin_clkin.hw,
+		[CLKID_RTC_32K_DIV]		= &s4_rtc_32k_by_oscin_div.hw,
+		[CLKID_RTC_32K_SEL]		= &s4_rtc_32k_by_oscin_sel.hw,
+		[CLKID_RTC_32K_XATL]		= &s4_rtc_32k_by_oscin.hw,
+		[CLKID_RTC_CLK]			= &s4_rtc_clk.hw,
+
+		[CLKID_SYS_CLK_B_SEL]		= &s4_sysclk_b_sel.hw,
+		[CLKID_SYS_CLK_B_DIV]		= &s4_sysclk_b_div.hw,
+		[CLKID_SYS_CLK_B_GATE]		= &s4_sysclk_b.hw,
+		[CLKID_SYS_CLK_A_SEL]		= &s4_sysclk_a_sel.hw,
+		[CLKID_SYS_CLK_A_DIV]		= &s4_sysclk_a_div.hw,
+		[CLKID_SYS_CLK_A_GATE]		= &s4_sysclk_a.hw,
+		[CLKID_SYS_CLK]			= &s4_sys_clk.hw,
+
+		[CLKID_CECA_32K_CLKIN]		= &s4_ceca_32k_clkin.hw,
+		[CLKID_CECA_32K_DIV]		= &s4_ceca_32k_div.hw,
+		[CLKID_CECA_32K_SEL_PRE]	= &s4_ceca_32k_sel_pre.hw,
+		[CLKID_CECA_32K_SEL]		= &s4_ceca_32k_sel.hw,
+		[CLKID_CECA_32K_CLKOUT]		= &s4_ceca_32k_clkout.hw,
+
+		[CLKID_CECB_32K_CLKIN]		= &s4_cecb_32k_clkin.hw,
+		[CLKID_CECB_32K_DIV]		= &s4_cecb_32k_div.hw,
+		[CLKID_CECB_32K_SEL_PRE]	= &s4_cecb_32k_sel_pre.hw,
+		[CLKID_CECB_32K_SEL]		= &s4_cecb_32k_sel.hw,
+		[CLKID_CECB_32K_CLKOUT]		= &s4_cecb_32k_clkout.hw,
+
+		[CLKID_SC_CLK_SEL]		= &s4_sc_clk_mux.hw,
+		[CLKID_SC_CLK_DIV]		= &s4_sc_clk_div.hw,
+		[CLKID_SC_CLK_GATE]		= &s4_sc_clk_gate.hw,
+
+		[CLKID_12_24M_CLK_GATE]		= &s4_12_24M_clk_gate.hw,
+		[CLKID_12M_CLK_DIV]		= &s4_12M_clk_div.hw,
+		[CLKID_12_24M_CLK_SEL]		= &s4_12_24M_clk.hw,
+
+		[CLKID_VID_PLL]			= &s4_vid_pll_div.hw,
+		[CLKID_VID_PLL_SEL]		= &s4_vid_pll_sel.hw,
+		[CLKID_VID_PLL]			= &s4_vid_pll.hw,
+		[CLKID_VCLK_SEL]		= &s4_vclk_sel.hw,
+		[CLKID_VCLK2_SEL]		= &s4_vclk2_sel.hw,
+		[CLKID_VCLK_INPUT]		= &s4_vclk_input.hw,
+		[CLKID_VCLK2_INPUT]		= &s4_vclk2_input.hw,
+		[CLKID_VCLK_DIV]		= &s4_vclk_div.hw,
+		[CLKID_VCLK2_DIV]		= &s4_vclk2_div.hw,
+		[CLKID_VCLK]			= &s4_vclk.hw,
+		[CLKID_VCLK2]			= &s4_vclk2.hw,
+		[CLKID_VCLK_DIV1]		= &s4_vclk_div1.hw,
+		[CLKID_VCLK_DIV2_EN]		= &s4_vclk_div2_en.hw,
+		[CLKID_VCLK_DIV4_EN]		= &s4_vclk_div4_en.hw,
+		[CLKID_VCLK_DIV6_EN]		= &s4_vclk_div6_en.hw,
+		[CLKID_VCLK_DIV12_EN]		= &s4_vclk_div12_en.hw,
+		[CLKID_VCLK2_DIV1]		= &s4_vclk2_div1.hw,
+		[CLKID_VCLK2_DIV2_EN]		= &s4_vclk2_div2_en.hw,
+		[CLKID_VCLK2_DIV4_EN]		= &s4_vclk2_div4_en.hw,
+		[CLKID_VCLK2_DIV6_EN]		= &s4_vclk2_div6_en.hw,
+		[CLKID_VCLK2_DIV12_EN]		= &s4_vclk2_div12_en.hw,
+		[CLKID_VCLK_DIV2]		= &s4_vclk_div2.hw,
+		[CLKID_VCLK_DIV4]		= &s4_vclk_div4.hw,
+		[CLKID_VCLK_DIV6]		= &s4_vclk_div6.hw,
+		[CLKID_VCLK_DIV12]		= &s4_vclk_div12.hw,
+		[CLKID_VCLK2_DIV2]		= &s4_vclk2_div2.hw,
+		[CLKID_VCLK2_DIV4]		= &s4_vclk2_div4.hw,
+		[CLKID_VCLK2_DIV6]		= &s4_vclk2_div6.hw,
+		[CLKID_VCLK2_DIV12]		= &s4_vclk2_div12.hw,
+		[CLKID_CTS_ENCI_SEL]		= &s4_cts_enci_sel.hw,
+		[CLKID_CTS_ENCP_SEL]		= &s4_cts_encp_sel.hw,
+		[CLKID_CTS_VDAC_SEL]		= &s4_cts_vdac_sel.hw,
+		[CLKID_HDMI_TX_SEL]		= &s4_hdmi_tx_sel.hw,
+		[CLKID_CTS_ENCI]		= &s4_cts_enci.hw,
+		[CLKID_CTS_ENCP]		= &s4_cts_encp.hw,
+		[CLKID_CTS_VDAC]		= &s4_cts_vdac.hw,
+		[CLKID_HDMI_TX]			= &s4_hdmi_tx.hw,
+		[CLKID_HDMI_SEL]		= &s4_hdmi_sel.hw,
+		[CLKID_HDMI_DIV]		= &s4_hdmi_div.hw,
+		[CLKID_HDMI]			= &s4_hdmi.hw,
+
+		[CLKID_TS_CLK_DIV]		= &s4_ts_clk_div.hw,
+		[CLKID_TS_CLK_GATE]		= &s4_ts_clk_gate.hw,
+
+		[CLKID_MALI_0_SEL]		= &s4_mali_0_sel.hw,
+		[CLKID_MALI_0_DIV]		= &s4_mali_0_div.hw,
+		[CLKID_MALI_0]			= &s4_mali_0.hw,
+		[CLKID_MALI_1_SEL]		= &s4_mali_1_sel.hw,
+		[CLKID_MALI_1_DIV]		= &s4_mali_1_div.hw,
+		[CLKID_MALI_1]			= &s4_mali_1.hw,
+		[CLKID_MALI]			= &s4_mali_mux.hw,
+
+		[CLKID_VDEC_P0_SEL]		= &s4_vdec_p0_mux.hw,
+		[CLKID_VDEC_P0_DIV]		= &s4_vdec_p0_div.hw,
+		[CLKID_VDEC_P0]			= &s4_vdec_p0.hw,
+		[CLKID_VDEC_P1_SEL]		= &s4_vdec_p1_mux.hw,
+		[CLKID_VDEC_P1_DIV]		= &s4_vdec_p1_div.hw,
+		[CLKID_VDEC_P1]			= &s4_vdec_p1.hw,
+		[CLKID_VDEC_SEL]		= &s4_vdec_mux.hw,
+
+		[CLKID_HEVCF_P0_SEL]		= &s4_hevcf_p0_mux.hw,
+		[CLKID_HEVCF_P0_DIV]		= &s4_hevcf_p0_div.hw,
+		[CLKID_HEVCF_P0]		= &s4_hevcf_p0.hw,
+		[CLKID_HEVCF_P1_SEL]		= &s4_hevcf_p1_mux.hw,
+		[CLKID_HEVCF_P1_DIV]		= &s4_hevcf_p1_div.hw,
+		[CLKID_HEVCF_P1]		= &s4_hevcf_p1.hw,
+		[CLKID_HEVCF_SEL]		= &s4_hevcf_mux.hw,
+
+		[CLKID_VPU_0_SEL]		= &s4_vpu_0_sel.hw,
+		[CLKID_VPU_0_DIV]		= &s4_vpu_0_div.hw,
+		[CLKID_VPU_0]			= &s4_vpu_0.hw,
+		[CLKID_VPU_1_SEL]		= &s4_vpu_1_sel.hw,
+		[CLKID_VPU_1_DIV]		= &s4_vpu_1_div.hw,
+		[CLKID_VPU_1]			= &s4_vpu_1.hw,
+		[CLKID_VPU]			= &s4_vpu.hw,
+
+		[CLKID_VPU_CLKB_TMP_SEL]	= &s4_vpu_clkb_tmp_mux.hw,
+		[CLKID_VPU_CLKB_TMP_DIV]	= &s4_vpu_clkb_tmp_div.hw,
+		[CLKID_VPU_CLKB_TMP]		= &s4_vpu_clkb_tmp.hw,
+		[CLKID_VPU_CLKB_DIV]		= &s4_vpu_clkb_div.hw,
+		[CLKID_VPU_CLKB]		= &s4_vpu_clkb.hw,
+		[CLKID_VPU_CLKC_P0_SEL]		= &s4_vpu_clkc_p0_mux.hw,
+		[CLKID_VPU_CLKC_P0_DIV]		= &s4_vpu_clkc_p0_div.hw,
+		[CLKID_VPU_CLKC_P0]		= &s4_vpu_clkc_p0.hw,
+		[CLKID_VPU_CLKC_P1_SEL]		= &s4_vpu_clkc_p1_mux.hw,
+		[CLKID_VPU_CLKC_P1_DIV]		= &s4_vpu_clkc_p1_div.hw,
+		[CLKID_VPU_CLKC_P1]		= &s4_vpu_clkc_p1.hw,
+		[CLKID_VPU_CLKC_SEL]		= &s4_vpu_clkc_mux.hw,
+
+		[CLKID_VAPB_0_SEL]		= &s4_vapb_0_sel.hw,
+		[CLKID_VAPB_0_DIV]		= &s4_vapb_0_div.hw,
+		[CLKID_VAPB_0]			= &s4_vapb_0.hw,
+		[CLKID_VAPB_1_SEL]		= &s4_vapb_1_sel.hw,
+		[CLKID_VAPB_1_DIV]		= &s4_vapb_1_div.hw,
+		[CLKID_VAPB_1]			= &s4_vapb_1.hw,
+		[CLKID_VAPB]			= &s4_vapb.hw,
+
+		[CLKID_GE2D]			= &s4_ge2d_gate.hw,
+
+		[CLKID_VDIN_MEAS_SEL]		= &s4_vdin_meas_mux.hw,
+		[CLKID_VDIN_MEAS_DIV]		= &s4_vdin_meas_div.hw,
+		[CLKID_VDIN_MEAS_GATE]		= &s4_vdin_meas_gate.hw,
+
+		[CLKID_SD_EMMC_C_CLK_SEL]	= &s4_sd_emmc_c_clk0_sel.hw,
+		[CLKID_SD_EMMC_C_CLK_DIV]	= &s4_sd_emmc_c_clk0_div.hw,
+		[CLKID_SD_EMMC_C_CLK]		= &s4_sd_emmc_c_clk0.hw,
+
+		[CLKID_SD_EMMC_A_CLK_SEL]	= &s4_sd_emmc_a_clk0_sel.hw,
+		[CLKID_SD_EMMC_A_CLK_DIV]	= &s4_sd_emmc_a_clk0_div.hw,
+		[CLKID_SD_EMMC_A_CLK]		= &s4_sd_emmc_a_clk0.hw,
+		[CLKID_SD_EMMC_B_CLK_SEL]	= &s4_sd_emmc_b_clk0_sel.hw,
+		[CLKID_SD_EMMC_B_CLK_DIV]	= &s4_sd_emmc_b_clk0_div.hw,
+		[CLKID_SD_EMMC_B_CLK]		= &s4_sd_emmc_b_clk0.hw,
+
+		[CLKID_SPICC0_SEL]		= &s4_spicc0_mux.hw,
+		[CLKID_SPICC0_DIV]		= &s4_spicc0_div.hw,
+		[CLKID_SPICC0_GATE]		= &s4_spicc0_gate.hw,
+
+		[CLKID_PWM_A_SEL]		= &s4_pwm_a_mux.hw,
+		[CLKID_PWM_A_DIV]		= &s4_pwm_a_div.hw,
+		[CLKID_PWM_A_GATE]		= &s4_pwm_a_gate.hw,
+		[CLKID_PWM_B_SEL]		= &s4_pwm_b_mux.hw,
+		[CLKID_PWM_B_DIV]		= &s4_pwm_b_div.hw,
+		[CLKID_PWM_B_GATE]		= &s4_pwm_b_gate.hw,
+		[CLKID_PWM_C_SEL]		= &s4_pwm_c_mux.hw,
+		[CLKID_PWM_C_DIV]		= &s4_pwm_c_div.hw,
+		[CLKID_PWM_C_GATE]		= &s4_pwm_c_gate.hw,
+		[CLKID_PWM_D_SEL]		= &s4_pwm_d_mux.hw,
+		[CLKID_PWM_D_DIV]		= &s4_pwm_d_div.hw,
+		[CLKID_PWM_D_GATE]		= &s4_pwm_d_gate.hw,
+		[CLKID_PWM_E_SEL]		= &s4_pwm_e_mux.hw,
+		[CLKID_PWM_E_DIV]		= &s4_pwm_e_div.hw,
+		[CLKID_PWM_E_GATE]		= &s4_pwm_e_gate.hw,
+		[CLKID_PWM_F_SEL]		= &s4_pwm_f_mux.hw,
+		[CLKID_PWM_F_DIV]		= &s4_pwm_f_div.hw,
+		[CLKID_PWM_F_GATE]		= &s4_pwm_f_gate.hw,
+		[CLKID_PWM_G_SEL]		= &s4_pwm_g_mux.hw,
+		[CLKID_PWM_G_DIV]		= &s4_pwm_g_div.hw,
+		[CLKID_PWM_G_GATE]		= &s4_pwm_g_gate.hw,
+		[CLKID_PWM_H_SEL]		= &s4_pwm_h_mux.hw,
+		[CLKID_PWM_H_DIV]		= &s4_pwm_h_div.hw,
+		[CLKID_PWM_H_GATE]		= &s4_pwm_h_gate.hw,
+		[CLKID_PWM_I_SEL]		= &s4_pwm_i_mux.hw,
+		[CLKID_PWM_I_DIV]		= &s4_pwm_i_div.hw,
+		[CLKID_PWM_I_GATE]		= &s4_pwm_i_gate.hw,
+		[CLKID_PWM_J_SEL]		= &s4_pwm_j_mux.hw,
+		[CLKID_PWM_J_DIV]		= &s4_pwm_j_div.hw,
+		[CLKID_PWM_J_GATE]		= &s4_pwm_j_gate.hw,
+
+		[CLKID_SARADC_SEL]		= &s4_saradc_mux.hw,
+		[CLKID_SARADC_DIV]		= &s4_saradc_div.hw,
+		[CLKID_SARADC_GATE]		= &s4_saradc_gate.hw,
+
+		[CLKID_GEN_SEL]			= &s4_gen_clk_sel.hw,
+		[CLKID_GEN_DIV]			= &s4_gen_clk_div.hw,
+		[CLKID_GEN_GATE]		= &s4_gen_clk.hw,
+
+		[CLKID_DDR]			= &s4_ddr.hw,
+		[CLKID_DOS]			= &s4_dos.hw,
+		[CLKID_ETHPHY]			= &s4_ethphy.hw,
+		[CLKID_MALI_GATE]		= &s4_mali.hw,
+		[CLKID_AOCPU]			= &s4_aocpu.hw,
+		[CLKID_AUCPU]			= &s4_aucpu.hw,
+		[CLKID_CEC]			= &s4_cec.hw,
+		[CLKID_SD_EMMC_A]		= &s4_sdemmca.hw,
+		[CLKID_SD_EMMC_B]		= &s4_sdemmcb.hw,
+		[CLKID_NAND]			= &s4_nand.hw,
+		[CLKID_SMARTCARD]		= &s4_smartcard.hw,
+		[CLKID_ACODEC]			= &s4_acodec.hw,
+		[CLKID_SPIFC]			= &s4_spifc.hw,
+		[CLKID_MSR_CLK]			= &s4_msr_clk.hw,
+		[CLKID_IR_CTRL]			= &s4_ir_ctrl.hw,
+
+		[CLKID_AUDIO]			= &s4_audio.hw,
+		[CLKID_ETH]			= &s4_eth.hw,
+		[CLKID_UART_A]			= &s4_uart_a.hw,
+		[CLKID_UART_B]			= &s4_uart_b.hw,
+		[CLKID_UART_C]			= &s4_uart_c.hw,
+		[CLKID_UART_D]			= &s4_uart_d.hw,
+		[CLKID_UART_E]			= &s4_uart_e.hw,
+		[CLKID_AIFIFO]			= &s4_aififo.hw,
+		[CLKID_TS_DDR]			= &s4_ts_ddr.hw,
+		[CLKID_TS_PLL]			= &s4_ts_pll.hw,
+		[CLKID_G2D]			= &s4_g2d.hw,
+		[CLKID_SPICC0]			= &s4_spicc0.hw,
+		[CLKID_USB]			= &s4_usb.hw,
+		[CLKID_I2C_M_A]			= &s4_i2c_m_a.hw,
+		[CLKID_I2C_M_B]			= &s4_i2c_m_b.hw,
+		[CLKID_I2C_M_C]			= &s4_i2c_m_c.hw,
+		[CLKID_I2C_M_D]			= &s4_i2c_m_d.hw,
+		[CLKID_I2C_M_E]			= &s4_i2c_m_e.hw,
+		[CLKID_HDMITX_APB]		= &s4_hdmitx_apb.hw,
+		[CLKID_I2C_S_A]			= &s4_i2c_s_a.hw,
+		[CLKID_USB1_TO_DDR]		= &s4_usb1_to_ddr.hw,
+		[CLKID_HDCP22]			= &s4_hdcp22.hw,
+		[CLKID_MMC_APB]			= &s4_mmc_apb.hw,
+		[CLKID_RSA]			= &s4_rsa.hw,
+		[CLKID_CPU_DEBUG]		= &s4_cpu_debug.hw,
+		[CLKID_VPU_INTR]		= &s4_vpu_intr.hw,
+		[CLKID_DEMOD]			= &s4_demod.hw,
+		[CLKID_SAR_ADC]			= &s4_sar_adc.hw,
+		[CLKID_GIC]			= &s4_gic.hw,
+		[CLKID_PWM_AB]			= &s4_pwm_ab.hw,
+		[CLKID_PWM_CD]			= &s4_pwm_cd.hw,
+		[CLKID_PWM_EF]			= &s4_pwm_ef.hw,
+		[CLKID_PWM_GH]			= &s4_pwm_gh.hw,
+		[CLKID_PWM_IJ]			= &s4_pwm_ij.hw,
+
+		[CLKID_HDCP22_ESMCLK_SEL]	= &s4_hdcp22_esmclk_mux.hw,
+		[CLKID_HDCP22_ESMCLK_DIV]	= &s4_hdcp22_esmclk_div.hw,
+		[CLKID_HDCP22_ESMCLK_GATE]	= &s4_hdcp22_esmclk_gate.hw,
+		[CLKID_HDCP22_SKPCLK_SEL]	= &s4_hdcp22_skpclk_mux.hw,
+		[CLKID_HDCP22_SKPCLK_DIV]	= &s4_hdcp22_skpclk_div.hw,
+		[CLKID_HDCP22_SKPCLK_GATE]	= &s4_hdcp22_skpclk_gate.hw,
+
+		[NR_CLKS]			= NULL
+	},
+	.num = NR_CLKS,
+};
+
+/* Convenience table to populate regmap in .probe */
+static struct clk_regmap *const s4_clk_regmaps[] = {
+	&s4_rtc_32k_by_oscin_clkin,
+	&s4_rtc_32k_by_oscin_div,
+	&s4_rtc_32k_by_oscin_sel,
+	&s4_rtc_32k_by_oscin,
+	&s4_rtc_clk,
+
+	&s4_sysclk_b_sel,
+	&s4_sysclk_b_div,
+	&s4_sysclk_b,
+	&s4_sysclk_a_sel,
+	&s4_sysclk_a_div,
+	&s4_sysclk_a,
+	&s4_sys_clk,
+
+	&s4_ceca_32k_clkin,
+	&s4_ceca_32k_div,
+	&s4_ceca_32k_sel_pre,
+	&s4_ceca_32k_sel,
+	&s4_ceca_32k_clkout,
+	&s4_cecb_32k_clkin,
+	&s4_cecb_32k_div,
+	&s4_cecb_32k_sel_pre,
+	&s4_cecb_32k_sel,
+	&s4_cecb_32k_clkout,
+
+	&s4_sc_clk_mux,
+	&s4_sc_clk_div,
+	&s4_sc_clk_gate,
+
+	&s4_12_24M_clk_gate,
+	&s4_12_24M_clk,
+	&s4_vid_pll_div,
+	&s4_vid_pll_sel,
+	&s4_vid_pll,
+	&s4_vclk_sel,
+	&s4_vclk2_sel,
+	&s4_vclk_input,
+	&s4_vclk2_input,
+	&s4_vclk_div,
+	&s4_vclk2_div,
+	&s4_vclk,
+	&s4_vclk2,
+	&s4_vclk_div1,
+	&s4_vclk_div2_en,
+	&s4_vclk_div4_en,
+	&s4_vclk_div6_en,
+	&s4_vclk_div12_en,
+	&s4_vclk2_div1,
+	&s4_vclk2_div2_en,
+	&s4_vclk2_div4_en,
+	&s4_vclk2_div6_en,
+	&s4_vclk2_div12_en,
+	&s4_cts_enci_sel,
+	&s4_cts_encp_sel,
+	&s4_cts_vdac_sel,
+	&s4_hdmi_tx_sel,
+	&s4_cts_enci,
+	&s4_cts_encp,
+	&s4_cts_vdac,
+	&s4_hdmi_tx,
+
+	&s4_hdmi_sel,
+	&s4_hdmi_div,
+	&s4_hdmi,
+	&s4_ts_clk_div,
+	&s4_ts_clk_gate,
+
+	&s4_mali_0_sel,
+	&s4_mali_0_div,
+	&s4_mali_0,
+	&s4_mali_1_sel,
+	&s4_mali_1_div,
+	&s4_mali_1,
+	&s4_mali_mux,
+
+	&s4_vdec_p0_mux,
+	&s4_vdec_p0_div,
+	&s4_vdec_p0,
+	&s4_vdec_p1_mux,
+	&s4_vdec_p1_div,
+	&s4_vdec_p1,
+	&s4_vdec_mux,
+
+	&s4_hevcf_p0_mux,
+	&s4_hevcf_p0_div,
+	&s4_hevcf_p0,
+	&s4_hevcf_p1_mux,
+	&s4_hevcf_p1_div,
+	&s4_hevcf_p1,
+	&s4_hevcf_mux,
+
+	&s4_vpu_0_sel,
+	&s4_vpu_0_div,
+	&s4_vpu_0,
+	&s4_vpu_1_sel,
+	&s4_vpu_1_div,
+	&s4_vpu_1,
+	&s4_vpu,
+	&s4_vpu_clkb_tmp_mux,
+	&s4_vpu_clkb_tmp_div,
+	&s4_vpu_clkb_tmp,
+	&s4_vpu_clkb_div,
+	&s4_vpu_clkb,
+	&s4_vpu_clkc_p0_mux,
+	&s4_vpu_clkc_p0_div,
+	&s4_vpu_clkc_p0,
+	&s4_vpu_clkc_p1_mux,
+	&s4_vpu_clkc_p1_div,
+	&s4_vpu_clkc_p1,
+	&s4_vpu_clkc_mux,
+
+	&s4_vapb_0_sel,
+	&s4_vapb_0_div,
+	&s4_vapb_0,
+	&s4_vapb_1_sel,
+	&s4_vapb_1_div,
+	&s4_vapb_1,
+	&s4_vapb,
+	&s4_ge2d_gate,
+
+	&s4_hdcp22_esmclk_mux,
+	&s4_hdcp22_esmclk_div,
+	&s4_hdcp22_esmclk_gate,
+	&s4_hdcp22_skpclk_mux,
+	&s4_hdcp22_skpclk_div,
+	&s4_hdcp22_skpclk_gate,
+
+	&s4_vdin_meas_mux,
+	&s4_vdin_meas_div,
+	&s4_vdin_meas_gate,
+
+	&s4_sd_emmc_c_clk0_sel,
+	&s4_sd_emmc_c_clk0_div,
+	&s4_sd_emmc_c_clk0,
+	&s4_sd_emmc_a_clk0_sel,
+	&s4_sd_emmc_a_clk0_div,
+	&s4_sd_emmc_a_clk0,
+	&s4_sd_emmc_b_clk0_sel,
+	&s4_sd_emmc_b_clk0_div,
+	&s4_sd_emmc_b_clk0,
+
+	&s4_spicc0_mux,
+	&s4_spicc0_div,
+	&s4_spicc0_gate,
+
+	&s4_pwm_a_mux,
+	&s4_pwm_a_div,
+	&s4_pwm_a_gate,
+	&s4_pwm_b_mux,
+	&s4_pwm_b_div,
+	&s4_pwm_b_gate,
+	&s4_pwm_c_mux,
+	&s4_pwm_c_div,
+	&s4_pwm_c_gate,
+	&s4_pwm_d_mux,
+	&s4_pwm_d_div,
+	&s4_pwm_d_gate,
+	&s4_pwm_e_mux,
+	&s4_pwm_e_div,
+	&s4_pwm_e_gate,
+	&s4_pwm_f_mux,
+	&s4_pwm_f_div,
+	&s4_pwm_f_gate,
+	&s4_pwm_g_mux,
+	&s4_pwm_g_div,
+	&s4_pwm_g_gate,
+	&s4_pwm_h_mux,
+	&s4_pwm_h_div,
+	&s4_pwm_h_gate,
+	&s4_pwm_i_mux,
+	&s4_pwm_i_div,
+	&s4_pwm_i_gate,
+	&s4_pwm_j_mux,
+	&s4_pwm_j_div,
+	&s4_pwm_j_gate,
+
+	&s4_saradc_mux,
+	&s4_saradc_div,
+	&s4_saradc_gate,
+
+	&s4_gen_clk_sel,
+	&s4_gen_clk_div,
+	&s4_gen_clk,
+
+	&s4_ddr,
+	&s4_dos,
+	&s4_ethphy,
+	&s4_mali,
+	&s4_aocpu,
+	&s4_aucpu,
+	&s4_cec,
+	&s4_sdemmca,
+	&s4_sdemmcb,
+	&s4_nand,
+	&s4_smartcard,
+	&s4_acodec,
+	&s4_spifc,
+	&s4_msr_clk,
+	&s4_ir_ctrl,
+	&s4_audio,
+	&s4_eth,
+	&s4_uart_a,
+	&s4_uart_b,
+	&s4_uart_c,
+	&s4_uart_d,
+	&s4_uart_e,
+	&s4_aififo,
+	&s4_ts_ddr,
+	&s4_ts_pll,
+	&s4_g2d,
+	&s4_spicc0,
+	&s4_usb,
+	&s4_i2c_m_a,
+	&s4_i2c_m_b,
+	&s4_i2c_m_c,
+	&s4_i2c_m_d,
+	&s4_i2c_m_e,
+	&s4_hdmitx_apb,
+	&s4_i2c_s_a,
+	&s4_usb1_to_ddr,
+	&s4_hdcp22,
+	&s4_mmc_apb,
+	&s4_rsa,
+	&s4_cpu_debug,
+	&s4_vpu_intr,
+	&s4_demod,
+	&s4_sar_adc,
+	&s4_gic,
+	&s4_pwm_ab,
+	&s4_pwm_cd,
+	&s4_pwm_ef,
+	&s4_pwm_gh,
+	&s4_pwm_ij,
+	&s4_demod_core_clk_mux,
+	&s4_demod_core_clk_div,
+	&s4_demod_core_clk_gate,
+	&s4_adc_extclk_in_mux,
+	&s4_adc_extclk_in_div,
+	&s4_adc_extclk_in_gate,
+
+	&s4_fixed_pll_dco,
+	&s4_fixed_pll,
+	&s4_fclk_div2,
+	&s4_fclk_div3,
+	&s4_fclk_div4,
+	&s4_fclk_div5,
+	&s4_fclk_div7,
+	&s4_fclk_div2p5,
+	&s4_gp0_pll_dco,
+	&s4_gp0_pll,
+
+	&s4_hifi_pll_dco,
+	&s4_hifi_pll,
+	&s4_hdmi_pll_dco,
+	&s4_hdmi_pll_od,
+	&s4_hdmi_pll,
+	&s4_mpll_50m,
+	&s4_mpll0_div,
+	&s4_mpll0,
+	&s4_mpll1_div,
+	&s4_mpll1,
+	&s4_mpll2_div,
+	&s4_mpll2,
+	&s4_mpll3_div,
+	&s4_mpll3,
+};
+
+static const struct reg_sequence s4_init_regs[] = {
+	{ .reg = ANACTRL_MPLL_CTRL0,	.def = 0x00000543 },
+};
+
+static const struct meson_eeclkc_data s4_clkc_data = {
+	.regmap_clks = s4_clk_regmaps,
+	.regmap_clk_num = ARRAY_SIZE(s4_clk_regmaps),
+	.hw_onecell_data = &s4_hw_onecell_data,
+	.init_regs = s4_init_regs,
+	.init_count = ARRAY_SIZE(s4_init_regs),
+};
+
+static const struct of_device_id clkc_match_table[] = {
+	{
+		.compatible = "amlogic,s4-clkc",
+		.data = &s4_clkc_data
+	},
+	{}
+};
+
+static struct platform_driver s4_driver = {
+	.probe		= meson_eeclkc_probe,
+	.driver		= {
+		.name	= "s4-clkc",
+		.of_match_table = clkc_match_table,
+	},
+};
+
+module_platform_driver(s4_driver);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/meson/s4.h b/drivers/clk/meson/s4.h
new file mode 100644
index 000000000000..d5563dcbd52e
--- /dev/null
+++ b/drivers/clk/meson/s4.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2021 Amlogic, inc.
+ * Author: Yu Tu <yu.tu@amlogic.com>
+ */
+
+#ifndef __S4_H
+#define __S4_H
+
+/*
+ * Clock controller register offsets
+ * REG_BASE:  REGISTER_BASE_ADDR = 0xfe000000
+ */
+#define CLKCTRL_OSCIN_CTRL                         ((0x0001 << 2))
+#define CLKCTRL_RTC_BY_OSCIN_CTRL0                 ((0x0002 << 2))
+#define CLKCTRL_RTC_BY_OSCIN_CTRL1                 ((0x0003 << 2))
+#define CLKCTRL_RTC_CTRL                           ((0x0004 << 2))
+#define CLKCTRL_CHECK_CLK_RESULT                   ((0x0005 << 2))
+#define CLKCTRL_MBIST_ATSPEED_CTRL                 ((0x0006 << 2))
+#define CLKCTRL_LOCK_BIT_REG0                      ((0x0008 << 2))
+#define CLKCTRL_LOCK_BIT_REG1                      ((0x0009 << 2))
+#define CLKCTRL_LOCK_BIT_REG2                      ((0x000a << 2))
+#define CLKCTRL_LOCK_BIT_REG3                      ((0x000b << 2))
+#define CLKCTRL_PROT_BIT_REG0                      ((0x000c << 2))
+#define CLKCTRL_PROT_BIT_REG1                      ((0x000d << 2))
+#define CLKCTRL_PROT_BIT_REG2                      ((0x000e << 2))
+#define CLKCTRL_PROT_BIT_REG3                      ((0x000f << 2))
+#define CLKCTRL_SYS_CLK_CTRL0                      ((0x0010 << 2))
+#define CLKCTRL_SYS_CLK_EN0_REG0                   ((0x0011 << 2))
+#define CLKCTRL_SYS_CLK_EN0_REG1                   ((0x0012 << 2))
+#define CLKCTRL_SYS_CLK_EN0_REG2                   ((0x0013 << 2))
+#define CLKCTRL_SYS_CLK_EN0_REG3                   ((0x0014 << 2))
+#define CLKCTRL_SYS_CLK_EN1_REG0                   ((0x0015 << 2))
+#define CLKCTRL_SYS_CLK_EN1_REG1                   ((0x0016 << 2))
+#define CLKCTRL_SYS_CLK_EN1_REG2                   ((0x0017 << 2))
+#define CLKCTRL_SYS_CLK_EN1_REG3                   ((0x0018 << 2))
+#define CLKCTRL_SYS_CLK_VPU_EN0                    ((0x0019 << 2))
+#define CLKCTRL_SYS_CLK_VPU_EN1                    ((0x001a << 2))
+#define CLKCTRL_AXI_CLK_CTRL0                      ((0x001b << 2))
+#define CLKCTRL_TST_CTRL0                          ((0x0020 << 2))
+#define CLKCTRL_TST_CTRL1                          ((0x0021 << 2))
+#define CLKCTRL_CECA_CTRL0                         ((0x0022 << 2))
+#define CLKCTRL_CECA_CTRL1                         ((0x0023 << 2))
+#define CLKCTRL_CECB_CTRL0                         ((0x0024 << 2))
+#define CLKCTRL_CECB_CTRL1                         ((0x0025 << 2))
+#define CLKCTRL_SC_CLK_CTRL                        ((0x0026 << 2))
+#define CLKCTRL_DSPA_CLK_CTRL0                     ((0x0027 << 2))
+#define CLKCTRL_DSPB_CLK_CTRL0                     ((0x0028 << 2))
+#define CLKCTRL_RAMA_CLK_CTRL0                     ((0x0029 << 2))
+#define CLKCTRL_CLK12_24_CTRL                      ((0x002a << 2))
+#define CLKCTRL_VID_CLK_CTRL                       ((0x0030 << 2))
+#define CLKCTRL_VID_CLK_CTRL2                      ((0x0031 << 2))
+#define CLKCTRL_VID_CLK_DIV                        ((0x0032 << 2))
+#define CLKCTRL_VIID_CLK_DIV                       ((0x0033 << 2))
+#define CLKCTRL_VIID_CLK_CTRL                      ((0x0034 << 2))
+#define CLKCTRL_HDMI_CLK_CTRL                      ((0x0038 << 2))
+#define CLKCTRL_VID_PLL_CLK_DIV                    ((0x0039 << 2))
+#define CLKCTRL_VPU_CLK_CTRL                       ((0x003a << 2))
+#define CLKCTRL_VPU_CLKB_CTRL                      ((0x003b << 2))
+#define CLKCTRL_VPU_CLKC_CTRL                      ((0x003c << 2))
+#define CLKCTRL_VID_LOCK_CLK_CTRL                  ((0x003d << 2))
+#define CLKCTRL_VDIN_MEAS_CLK_CTRL                 ((0x003e << 2))
+#define CLKCTRL_VAPBCLK_CTRL                       ((0x003f << 2))
+#define CLKCTRL_HDCP22_CTRL                        ((0x0040 << 2))
+#define CLKCTRL_MIPIDSI_PHY_CLK_CTRL               ((0x0041 << 2))
+#define CLKCTRL_CDAC_CLK_CTRL                      ((0x0042 << 2))
+#define CLKCTRL_MIPI_CSI_PHY_CLK_CTRL              ((0x0043 << 2))
+#define CLKCTRL_CSI2_ADAPT_CLK_CTRL                ((0x0044 << 2))
+#define CLKCTRL_VDEC_CLK_CTRL                      ((0x0050 << 2))
+#define CLKCTRL_VDEC2_CLK_CTRL                     ((0x0051 << 2))
+#define CLKCTRL_VDEC3_CLK_CTRL                     ((0x0052 << 2))
+#define CLKCTRL_VDEC4_CLK_CTRL                     ((0x0053 << 2))
+#define CLKCTRL_WAVE420L_CLK_CTRL                  ((0x0054 << 2))
+#define CLKCTRL_WAVE420L_CLK_CTRL2                 ((0x0055 << 2))
+#define CLKCTRL_TS_CLK_CTRL                        ((0x0056 << 2))
+#define CLKCTRL_MALI_CLK_CTRL                      ((0x0057 << 2))
+#define CLKCTRL_VIPNANOQ_CLK_CTRL                  ((0x0058 << 2))
+#define CLKCTRL_ETH_CLK_CTRL                       ((0x0059 << 2))
+#define CLKCTRL_NAND_CLK_CTRL                      ((0x005a << 2))
+#define CLKCTRL_SD_EMMC_CLK_CTRL                   ((0x005b << 2))
+#define CLKCTRL_BT656_CLK_CTRL                     ((0x005c << 2))
+#define CLKCTRL_SPICC_CLK_CTRL                     ((0x005d << 2))
+#define CLKCTRL_GEN_CLK_CTRL                       ((0x005e << 2))
+#define CLKCTRL_SAR_CLK_CTRL                       ((0x005f << 2))
+#define CLKCTRL_PWM_CLK_AB_CTRL                    ((0x0060 << 2))
+#define CLKCTRL_PWM_CLK_CD_CTRL                    ((0x0061 << 2))
+#define CLKCTRL_PWM_CLK_EF_CTRL                    ((0x0062 << 2))
+#define CLKCTRL_PWM_CLK_GH_CTRL                    ((0x0063 << 2))
+#define CLKCTRL_PWM_CLK_IJ_CTRL                    ((0x0064 << 2))
+#define CLKCTRL_DEMOD_CLK_CTRL                     ((0x0080 << 2))
+#define CLKCTRL_DEMOD_CLK_CTRL1                    ((0x0081 << 2))
+#define CLKCTRL_DEMOD_32K_CTRL0                    ((0x0082 << 2))
+#define CLKCTRL_DEMOD_32K_CTRL1                    ((0x0083 << 2))
+#define CLKCTRL_TIMESTAMP_CTRL                     ((0x0100 << 2))
+#define CLKCTRL_TIMESTAMP_CTRL1                    ((0x0101 << 2))
+#define CLKCTRL_TIMESTAMP_CTRL2                    ((0x0103 << 2))
+#define CLKCTRL_TIMESTAMP_RD0                      ((0x0104 << 2))
+#define CLKCTRL_TIMESTAMP_RD1                      ((0x0105 << 2))
+#define CLKCTRL_TIMEBASE_CTRL0                     ((0x0106 << 2))
+#define CLKCTRL_TIMEBASE_CTRL1                     ((0x0107 << 2))
+#define CLKCTRL_EFUSE_CPU_CFG01                    ((0x0120 << 2))
+#define CLKCTRL_EFUSE_CPU_CFG2                     ((0x0121 << 2))
+#define CLKCTRL_EFUSE_ENCP_CFG0                    ((0x0122 << 2))
+#define CLKCTRL_EFUSE_MALI_CFG01                   ((0x0123 << 2))
+#define CLKCTRL_EFUSE_HEVCB_CFG01                  ((0x0124 << 2))
+#define CLKCTRL_EFUSE_HEVCB_CFG2                   ((0x0125 << 2))
+#define CLKCTRL_EFUSE_LOCK                         ((0x0126 << 2))
+
+/* ANA_CTRL - Registers
+ * REG_BASE:  REGISTER_BASE_ADDR = 0xfe008000
+ */
+#define ANACTRL_FIXPLL_CTRL0                       (0x8000 + (0x0010 << 2))
+#define ANACTRL_FIXPLL_CTRL1                       (0x8000 + (0x0011 << 2))
+#define ANACTRL_FIXPLL_CTRL2                       (0x8000 + (0x0012 << 2))
+#define ANACTRL_FIXPLL_CTRL3                       (0x8000 + (0x0013 << 2))
+#define ANACTRL_FIXPLL_CTRL4                       (0x8000 + (0x0014 << 2))
+#define ANACTRL_FIXPLL_CTRL5                       (0x8000 + (0x0015 << 2))
+#define ANACTRL_FIXPLL_CTRL6                       (0x8000 + (0x0016 << 2))
+#define ANACTRL_FIXPLL_STS                         (0x8000 + (0x0017 << 2))
+#define ANACTRL_GP0PLL_CTRL0                       (0x8000 + (0x0020 << 2))
+#define ANACTRL_GP0PLL_CTRL1                       (0x8000 + (0x0021 << 2))
+#define ANACTRL_GP0PLL_CTRL2                       (0x8000 + (0x0022 << 2))
+#define ANACTRL_GP0PLL_CTRL3                       (0x8000 + (0x0023 << 2))
+#define ANACTRL_GP0PLL_CTRL4                       (0x8000 + (0x0024 << 2))
+#define ANACTRL_GP0PLL_CTRL5                       (0x8000 + (0x0025 << 2))
+#define ANACTRL_GP0PLL_CTRL6                       (0x8000 + (0x0026 << 2))
+#define ANACTRL_GP0PLL_STS                         (0x8000 + (0x0027 << 2))
+#define ANACTRL_HIFIPLL_CTRL0                      (0x8000 + (0x0040 << 2))
+#define ANACTRL_HIFIPLL_CTRL1                      (0x8000 + (0x0041 << 2))
+#define ANACTRL_HIFIPLL_CTRL2                      (0x8000 + (0x0042 << 2))
+#define ANACTRL_HIFIPLL_CTRL3                      (0x8000 + (0x0043 << 2))
+#define ANACTRL_HIFIPLL_CTRL4                      (0x8000 + (0x0044 << 2))
+#define ANACTRL_HIFIPLL_CTRL5                      (0x8000 + (0x0045 << 2))
+#define ANACTRL_HIFIPLL_CTRL6                      (0x8000 + (0x0046 << 2))
+#define ANACTRL_HIFIPLL_STS                        (0x8000 + (0x0047 << 2))
+#define ANACTRL_MPLL_CTRL0                         (0x8000 + (0x0060 << 2))
+#define ANACTRL_MPLL_CTRL1                         (0x8000 + (0x0061 << 2))
+#define ANACTRL_MPLL_CTRL2                         (0x8000 + (0x0062 << 2))
+#define ANACTRL_MPLL_CTRL3                         (0x8000 + (0x0063 << 2))
+#define ANACTRL_MPLL_CTRL4                         (0x8000 + (0x0064 << 2))
+#define ANACTRL_MPLL_CTRL5                         (0x8000 + (0x0065 << 2))
+#define ANACTRL_MPLL_CTRL6                         (0x8000 + (0x0066 << 2))
+#define ANACTRL_MPLL_CTRL7                         (0x8000 + (0x0067 << 2))
+#define ANACTRL_MPLL_CTRL8                         (0x8000 + (0x0068 << 2))
+#define ANACTRL_MPLL_STS                           (0x8000 + (0x0069 << 2))
+#define ANACTRL_HDMIPLL_CTRL0                      (0x8000 + (0x0070 << 2))
+#define ANACTRL_HDMIPLL_CTRL1                      (0x8000 + (0x0071 << 2))
+#define ANACTRL_HDMIPLL_CTRL2                      (0x8000 + (0x0072 << 2))
+#define ANACTRL_HDMIPLL_CTRL3                      (0x8000 + (0x0073 << 2))
+#define ANACTRL_HDMIPLL_CTRL4                      (0x8000 + (0x0074 << 2))
+#define ANACTRL_HDMIPLL_CTRL5                      (0x8000 + (0x0075 << 2))
+#define ANACTRL_HDMIPLL_CTRL6                      (0x8000 + (0x0076 << 2))
+#define ANACTRL_HDMIPLL_STS                        (0x8000 + (0x0077 << 2))
+#define ANACTRL_HDMIPLL_VLOCK                      (0x8000 + (0x0079 << 2))
+
+#endif /* __S4_H */
-- 
2.33.1

