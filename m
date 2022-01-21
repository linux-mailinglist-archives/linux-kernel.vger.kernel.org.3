Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A3495B17
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379204AbiAUHpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:45:34 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:15143 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379136AbiAUHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:45:28 -0500
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 21 Jan 2022
 15:45:22 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-clk@vger.kernel.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 4/4] clk: meson: add sub MMC clock controller driver
Date:   Fri, 21 Jan 2022 15:45:08 +0800
Message-ID: <20220121074508.42168-5-liang.yang@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121074508.42168-1-liang.yang@amlogic.com>
References: <20220121074508.42168-1-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.21]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch will add a MMC clock controller driver which used by MMC or NAND,
It provide a mux and divider clock, and three phase clocks - core, tx, tx.

Two clocks are provided as the parent of MMC clock controller from
upper layer clock controller - eg "amlogic,axg-clkc" in AXG platform.

To specify which clock the MMC or NAND driver may consume,
the preprocessor macros in the dt-bindings/clock/amlogic,mmc-clkc.h header
can be used in the device tree sources.

Signed-off-by: Liang Yang <liang.yang@amlogic.com>
---
 drivers/clk/meson/Kconfig    |  14 ++
 drivers/clk/meson/Makefile   |   1 +
 drivers/clk/meson/mmc-clkc.c | 302 +++++++++++++++++++++++++++++++++++
 3 files changed, 317 insertions(+)
 create mode 100644 drivers/clk/meson/mmc-clkc.c

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index bb0f59eea366..5f344a0892cb 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -39,6 +39,20 @@ config COMMON_CLK_MESON_AO_CLKC
 	select COMMON_CLK_MESON_REGMAP
 	select RESET_CONTROLLER
 
+config COMMON_CLK_MMC_MESON
+	tristate "Meson MMC Sub Clock Controller Driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	select MFD_SYSCON
+	select COMMON_CLK_AMLOGIC
+	select COMMON_CLK_MESON_PHASE
+	select COMMON_CLK_MESON_PHASE_DELAY
+	select COMMON_CLK_MESON_SCLK_DIV
+	help
+	  Support for the MMC sub clock controller on
+	  Amlogic Meson Platform, which includes S905 (GXBB, GXL),
+	  A113D/X (AXG) devices. Say Y if you want this
+	  clock enabled.
+
 config COMMON_CLK_MESON_EE_CLKC
 	tristate
 	select COMMON_CLK_MESON_REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 99fe4eeed000..7a7ffb37a726 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
 
 obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
+obj-$(CONFIG_COMMON_CLK_MMC_MESON) += mmc-clkc.o
 obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
 obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
new file mode 100644
index 000000000000..e42c4015c7a3
--- /dev/null
+++ b/drivers/clk/meson/mmc-clkc.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/amlogic,mmc-clkc.h>
+
+#include "sclk-div.h"
+#include "clk-phase-delay.h"
+#include "clk-regmap.h"
+#include "clk-phase.h"
+
+/* clock ID used by internal driver */
+
+#define SD_EMMC_CLOCK		0
+#define CLK_DELAY_STEP_PS_GX	200
+#define CLK_DELAY_STEP_PS_AXG	78
+#define MUX_CLK_NUM_PARENTS	2
+#define MMC_MAX_CLKS		4
+
+static struct clk_parent_data mmc_clkc_parent_data[MUX_CLK_NUM_PARENTS];
+
+struct mmc_clkc_data {
+	struct meson_clk_phase_delay_data tx;
+	struct meson_clk_phase_delay_data rx;
+};
+
+static struct clk_regmap_mux_data mmc_clkc_mux_data = {
+	.offset = SD_EMMC_CLOCK,
+	.mask   = 0x3,
+	.shift  = 6,
+};
+
+static const struct meson_sclk_div_data mmc_clkc_div_data = {
+	.div = {
+		.reg_off = SD_EMMC_CLOCK,
+		.width   = 6,
+	},
+	.flags = MESON_SCLK_ONE_BASED,
+};
+
+static struct meson_clk_phase_data mmc_clkc_core_phase = {
+	.ph = {
+		.reg_off = SD_EMMC_CLOCK,
+		.shift   = 8,
+		.width   = 2,
+	}
+};
+
+static const struct mmc_clkc_data mmc_clkc_gx_data = {
+	.tx = {
+		.phase = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 10,
+			.width   = 2,
+		},
+		.delay = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 16,
+			.width   = 4,
+		},
+		.delay_step_ps = CLK_DELAY_STEP_PS_GX,
+	},
+	.rx = {
+		.phase = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 12,
+			.width   = 2,
+		},
+		.delay = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 20,
+			.width   = 4,
+		},
+		.delay_step_ps   = CLK_DELAY_STEP_PS_GX,
+	},
+};
+
+static const struct mmc_clkc_data mmc_clkc_axg_data = {
+	.tx = {
+		.phase = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 10,
+			.width   = 2,
+		},
+		.delay = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 16,
+			.width   = 6,
+		},
+		.delay_step_ps   = CLK_DELAY_STEP_PS_AXG,
+	},
+	.rx = {
+		.phase = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 12,
+			.width   = 2,
+		},
+		.delay = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 22,
+			.width   = 6,
+		},
+		.delay_step_ps   = CLK_DELAY_STEP_PS_AXG,
+	},
+};
+
+static const struct of_device_id mmc_clkc_match_table[] = {
+	{
+		.compatible	= "amlogic,gx-mmc-clkc",
+		.data		= &mmc_clkc_gx_data
+	},
+	{
+		.compatible	= "amlogic,axg-mmc-clkc",
+		.data		= &mmc_clkc_axg_data
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
+
+static struct clk_regmap *
+mmc_clkc_register_clk(struct device *dev, struct regmap *map,
+		      struct clk_init_data *init,
+		      const char *suffix, void *data)
+{
+	struct clk_regmap *clk;
+	char *name;
+	int ret;
+
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	init->name = name;
+	clk->map = map;
+	clk->data = data;
+	clk->hw.init = init;
+	ret = devm_clk_hw_register(dev, &clk->hw);
+	if (ret)
+		clk = ERR_PTR(ret);
+
+	kfree(name);
+	return clk;
+}
+
+static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
+						struct regmap *map)
+{
+	struct clk_init_data init = {0};
+	struct clk_regmap *mux;
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
+		char name[8];
+
+		snprintf(name, sizeof(name), "clkin%d", i);
+		clk = devm_clk_get(dev, name);
+		if (IS_ERR(clk)) {
+			if (clk != ERR_PTR(-EPROBE_DEFER))
+				dev_err_probe(dev, PTR_ERR(clk),
+					      "Missing clock\n");
+			return ERR_CAST(clk);
+		}
+
+		mmc_clkc_parent_data[i].fw_name = __clk_get_name(clk);
+	}
+
+	init.ops = &clk_regmap_mux_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_data = mmc_clkc_parent_data;
+	init.num_parents = MUX_CLK_NUM_PARENTS;
+
+	mux = mmc_clkc_register_clk(dev, map, &init, "mux", &mmc_clkc_mux_data);
+	if (IS_ERR(mux))
+		dev_err(dev, "Mux clock registration failed\n");
+
+	return mux;
+}
+
+static struct clk_regmap *
+mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
+				  char *suffix, const struct clk_hw *hw,
+				  unsigned long flags,
+				  const struct clk_ops *ops, void *data)
+{
+	struct clk_init_data init;
+	struct clk_regmap *clk;
+	const char *parent_name = clk_hw_get_name(hw);
+
+	init.ops = ops;
+	init.flags = flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
+	if (IS_ERR(clk))
+		dev_err(dev, "%s clock registration failed\n", suffix);
+
+	return clk;
+}
+
+static int mmc_clkc_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *onecell_data;
+	struct device *dev = &pdev->dev;
+	const struct mmc_clkc_data *data;
+	struct regmap *map;
+	struct clk_regmap *clk, *core;
+	struct meson_sclk_div_data *div_data, *tx, *rx;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	/* cast to drop the const */
+	tx = (struct meson_sclk_div_data *)&data->tx;
+	rx = (struct meson_sclk_div_data *)&data->rx;
+
+	map = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(map)) {
+		dev_err(dev, "could not find mmc clock controller\n");
+		return PTR_ERR(map);
+	}
+
+	onecell_data = devm_kzalloc(dev,
+				    struct_size(onecell_data, hws,
+						MMC_MAX_CLKS),
+				    GFP_KERNEL);
+	if (!onecell_data)
+		return -ENOMEM;
+
+	clk = mmc_clkc_register_mux(dev, map);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	div_data = devm_kzalloc(dev, sizeof(*div_data), GFP_KERNEL);
+	if (!div_data)
+		return -ENOMEM;
+
+	memcpy(div_data, &mmc_clkc_div_data, sizeof(*div_data));
+	clk = mmc_clkc_register_clk_with_parent(dev, map, "div",
+						&clk->hw,
+						CLK_SET_RATE_PARENT,
+						&meson_sclk_div_ops,
+						div_data);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	onecell_data->hws[CLKID_MMC_DIV] = &clk->hw;
+	core = mmc_clkc_register_clk_with_parent(dev, map, "core",
+						 &clk->hw,
+						 CLK_SET_RATE_PARENT,
+						 &meson_clk_phase_ops,
+						 &mmc_clkc_core_phase);
+	if (IS_ERR(core))
+		return PTR_ERR(core);
+	onecell_data->hws[CLKID_MMC_PHASE_CORE] = &core->hw;
+	clk = mmc_clkc_register_clk_with_parent(dev, map, "rx",
+						&core->hw,  0,
+						&meson_clk_phase_delay_ops,
+						rx);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	onecell_data->hws[CLKID_MMC_PHASE_RX] = &clk->hw;
+	clk = mmc_clkc_register_clk_with_parent(dev, map, "tx",
+						&core->hw,  0,
+						&meson_clk_phase_delay_ops,
+						tx);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	onecell_data->hws[CLKID_MMC_PHASE_TX] = &clk->hw;
+	onecell_data->num = MMC_MAX_CLKS;
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   onecell_data);
+}
+
+static struct platform_driver mmc_clkc_driver = {
+	.probe		= mmc_clkc_probe,
+	.driver		= {
+		.name	= "meson-mmc-clkc",
+		.of_match_table = of_match_ptr(mmc_clkc_match_table),
+	},
+};
+
+module_platform_driver(mmc_clkc_driver);
+
+MODULE_DESCRIPTION("Amlogic AXG MMC clock driver");
+MODULE_AUTHOR("Jianxin Pan <jianxin.pan@amlogic.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

