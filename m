Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD82483B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 05:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiADExi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 23:53:38 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60404 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232875AbiADExe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 23:53:34 -0500
X-UUID: 6b66ccf948d94a85bfd9911640d05b21-20220104
X-UUID: 6b66ccf948d94a85bfd9911640d05b21-20220104
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 435642274; Tue, 04 Jan 2022 12:53:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 Jan 2022 12:53:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Jan 2022 12:53:28 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     John Crispin <john@phrozen.org>, Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v8 3/3] clk: mediatek: add mt7986 clock support
Date:   Tue, 4 Jan 2022 12:52:43 +0800
Message-ID: <20220104045243.21521-4-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220104045243.21521-1-sam.shih@mediatek.com>
References: <20220104045243.21521-1-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT7986 clock support, include topckgen, apmixedsys,
infracfg, and ethernet subsystem clocks.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@kernel.org>
---
v8: fix the description in Kconfg, and add a Reviewed-by tag
v7: exclude DTS changes in the patch series
v5: used builtin_platform_driver instead of CLK_OF_DECLARE
    follow recent clk-mt8195 clock patch series:
    https://lore.kernel.org/linux-arm-kernel/20210914021633.26377-1-chun-jie.chen@mediatek.com/

v4: separate clock part into a single patch series

Original thread:
https://lore.kernel.org/lkml/20210914085137.31761-4-sam.shih@mediatek.com/

v2: applied the comment suggested by reviewers:
    - splited basic clock driver to apmixed, topckgen, and infracfg
    - removed 1:1 factor clock
    - renamed factor clock for easier to understand
---
---
 drivers/clk/mediatek/Kconfig               |  17 +
 drivers/clk/mediatek/Makefile              |   4 +
 drivers/clk/mediatek/clk-mt7986-apmixed.c  | 100 ++++++
 drivers/clk/mediatek/clk-mt7986-eth.c      | 132 ++++++++
 drivers/clk/mediatek/clk-mt7986-infracfg.c | 224 ++++++++++++++
 drivers/clk/mediatek/clk-mt7986-topckgen.c | 342 +++++++++++++++++++++
 6 files changed, 819 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt7986-apmixed.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-eth.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt7986-topckgen.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 3ce6fb04d8ff..01ef02c54725 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -344,6 +344,23 @@ config COMMON_CLK_MT7629_HIFSYS
 	  This driver supports MediaTek MT7629 HIFSYS clocks providing
 	  to PCI-E and USB.
 
+config COMMON_CLK_MT7986
+	bool "Clock driver for MediaTek MT7986"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK
+	help
+	  This driver supports MediaTek MT7986 basic clocks and clocks
+	  required for various peripherals found on MediaTek.
+
+config COMMON_CLK_MT7986_ETHSYS
+	bool "Clock driver for MediaTek MT7986 ETHSYS"
+	depends on COMMON_CLK_MT7986
+	default COMMON_CLK_MT7986
+	help
+	  This driver adds support for clocks for Ethernet and SGMII
+	  required on MediaTek MT7986 SoC.
+
 config COMMON_CLK_MT8135
 	bool "Clock driver for MediaTek MT8135"
 	depends on (ARCH_MEDIATEK && ARM) || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index dc96038a0155..7b0c2646ce4a 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -46,6 +46,10 @@ obj-$(CONFIG_COMMON_CLK_MT7622_AUDSYS) += clk-mt7622-aud.o
 obj-$(CONFIG_COMMON_CLK_MT7629) += clk-mt7629.o
 obj-$(CONFIG_COMMON_CLK_MT7629_ETHSYS) += clk-mt7629-eth.o
 obj-$(CONFIG_COMMON_CLK_MT7629_HIFSYS) += clk-mt7629-hif.o
+obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-apmixed.o
+obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-topckgen.o
+obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-infracfg.o
+obj-$(CONFIG_COMMON_CLK_MT7986_ETHSYS) += clk-mt7986-eth.o
 obj-$(CONFIG_COMMON_CLK_MT8135) += clk-mt8135.o
 obj-$(CONFIG_COMMON_CLK_MT8167) += clk-mt8167.o
 obj-$(CONFIG_COMMON_CLK_MT8167_AUDSYS) += clk-mt8167-aud.o
diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
new file mode 100644
index 000000000000..76c8ebdeae96
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-1.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ * Author: Wenzhen Yu <wenzhen.yu@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "clk-mtk.h"
+#include "clk-gate.h"
+#include "clk-mux.h"
+
+#include <dt-bindings/clock/mt7986-clk.h>
+#include <linux/clk.h>
+
+#define MT7986_PLL_FMAX (2500UL * MHZ)
+#define CON0_MT7986_RST_BAR BIT(27)
+
+#define PLL_xtal(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,       \
+		 _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift,         \
+		 _div_table, _parent_name)                                     \
+	{                                                                      \
+		.id = _id, .name = _name, .reg = _reg, .pwr_reg = _pwr_reg,    \
+		.en_mask = _en_mask, .flags = _flags,                          \
+		.rst_bar_mask = CON0_MT7986_RST_BAR, .fmax = MT7986_PLL_FMAX,  \
+		.pcwbits = _pcwbits, .pd_reg = _pd_reg, .pd_shift = _pd_shift, \
+		.tuner_reg = _tuner_reg, .pcw_reg = _pcw_reg,                  \
+		.pcw_shift = _pcw_shift, .div_table = _div_table,              \
+		.parent_name = _parent_name,                                   \
+	}
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg,   \
+	    _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift)                       \
+	PLL_xtal(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,       \
+		 _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift, NULL,   \
+		 "clkxtal")
+
+static const struct mtk_pll_data plls[] = {
+	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000001, 0, 32,
+	    0x0200, 4, 0, 0x0204, 0),
+	PLL(CLK_APMIXED_NET2PLL, "net2pll", 0x0210, 0x021C, 0x00000001, 0, 32,
+	    0x0210, 4, 0, 0x0214, 0),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0220, 0x022C, 0x00000001, 0, 32,
+	    0x0220, 4, 0, 0x0224, 0),
+	PLL(CLK_APMIXED_SGMPLL, "sgmpll", 0x0230, 0x023c, 0x00000001, 0, 32,
+	    0x0230, 4, 0, 0x0234, 0),
+	PLL(CLK_APMIXED_WEDMCUPLL, "wedmcupll", 0x0240, 0x024c, 0x00000001, 0,
+	    32, 0x0240, 4, 0, 0x0244, 0),
+	PLL(CLK_APMIXED_NET1PLL, "net1pll", 0x0250, 0x025c, 0x00000001, 0, 32,
+	    0x0250, 4, 0, 0x0254, 0),
+	PLL(CLK_APMIXED_MPLL, "mpll", 0x0260, 0x0270, 0x00000001, 0, 32, 0x0260,
+	    4, 0, 0x0264, 0),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x0278, 0x0288, 0x00000001, 0, 32,
+	    0x0278, 4, 0, 0x027c, 0),
+};
+
+static const struct of_device_id of_match_clk_mt7986_apmixed[] = {
+	{ .compatible = "mediatek,mt7986-apmixedsys", },
+	{}
+};
+
+static int clk_mt7986_apmixed_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+
+	clk_prepare_enable(clk_data->clks[CLK_APMIXED_ARMPLL]);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r) {
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+		goto free_apmixed_data;
+	}
+	return r;
+
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static struct platform_driver clk_mt7986_apmixed_drv = {
+	.probe = clk_mt7986_apmixed_probe,
+	.driver = {
+		.name = "clk-mt7986-apmixed",
+		.of_match_table = of_match_clk_mt7986_apmixed,
+	},
+};
+builtin_platform_driver(clk_mt7986_apmixed_drv);
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
new file mode 100644
index 000000000000..495d023ccad7
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ * Author: Wenzhen Yu <wenzhen.yu@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt7986-clk.h>
+
+static const struct mtk_gate_regs sgmii0_cg_regs = {
+	.set_ofs = 0xe4,
+	.clr_ofs = 0xe4,
+	.sta_ofs = 0xe4,
+};
+
+#define GATE_SGMII0(_id, _name, _parent, _shift)                               \
+	{                                                                      \
+		.id = _id, .name = _name, .parent_name = _parent,              \
+		.regs = &sgmii0_cg_regs, .shift = _shift,                      \
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,                        \
+	}
+
+static const struct mtk_gate sgmii0_clks[] __initconst = {
+	GATE_SGMII0(CLK_SGMII0_TX250M_EN, "sgmii0_tx250m_en", "top_xtal", 2),
+	GATE_SGMII0(CLK_SGMII0_RX250M_EN, "sgmii0_rx250m_en", "top_xtal", 3),
+	GATE_SGMII0(CLK_SGMII0_CDR_REF, "sgmii0_cdr_ref", "top_xtal", 4),
+	GATE_SGMII0(CLK_SGMII0_CDR_FB, "sgmii0_cdr_fb", "top_xtal", 5),
+};
+
+static const struct mtk_gate_regs sgmii1_cg_regs = {
+	.set_ofs = 0xe4,
+	.clr_ofs = 0xe4,
+	.sta_ofs = 0xe4,
+};
+
+#define GATE_SGMII1(_id, _name, _parent, _shift)                               \
+	{                                                                      \
+		.id = _id, .name = _name, .parent_name = _parent,              \
+		.regs = &sgmii1_cg_regs, .shift = _shift,                      \
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,                        \
+	}
+
+static const struct mtk_gate sgmii1_clks[] __initconst = {
+	GATE_SGMII1(CLK_SGMII1_TX250M_EN, "sgmii1_tx250m_en", "top_xtal", 2),
+	GATE_SGMII1(CLK_SGMII1_RX250M_EN, "sgmii1_rx250m_en", "top_xtal", 3),
+	GATE_SGMII1(CLK_SGMII1_CDR_REF, "sgmii1_cdr_ref", "top_xtal", 4),
+	GATE_SGMII1(CLK_SGMII1_CDR_FB, "sgmii1_cdr_fb", "top_xtal", 5),
+};
+
+static const struct mtk_gate_regs eth_cg_regs = {
+	.set_ofs = 0x30,
+	.clr_ofs = 0x30,
+	.sta_ofs = 0x30,
+};
+
+#define GATE_ETH(_id, _name, _parent, _shift)                                  \
+	{                                                                      \
+		.id = _id, .name = _name, .parent_name = _parent,              \
+		.regs = &eth_cg_regs, .shift = _shift,                         \
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,                        \
+	}
+
+static const struct mtk_gate eth_clks[] __initconst = {
+	GATE_ETH(CLK_ETH_FE_EN, "eth_fe_en", "netsys_2x_sel", 6),
+	GATE_ETH(CLK_ETH_GP2_EN, "eth_gp2_en", "sgm_325m_sel", 7),
+	GATE_ETH(CLK_ETH_GP1_EN, "eth_gp1_en", "sgm_325m_sel", 8),
+	GATE_ETH(CLK_ETH_WOCPU1_EN, "eth_wocpu1_en", "netsys_mcu_sel", 14),
+	GATE_ETH(CLK_ETH_WOCPU0_EN, "eth_wocpu0_en", "netsys_mcu_sel", 15),
+};
+
+static void __init mtk_sgmiisys_0_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
+
+	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
+			       clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+}
+CLK_OF_DECLARE(mtk_sgmiisys_0, "mediatek,mt7986-sgmiisys_0",
+	       mtk_sgmiisys_0_init);
+
+static void __init mtk_sgmiisys_1_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
+
+	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
+			       clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+}
+CLK_OF_DECLARE(mtk_sgmiisys_1, "mediatek,mt7986-sgmiisys_1",
+	       mtk_sgmiisys_1_init);
+
+static void __init mtk_ethsys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
+
+	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+}
+CLK_OF_DECLARE(mtk_ethsys, "mediatek,mt7986-ethsys_ck", mtk_ethsys_init);
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
new file mode 100644
index 000000000000..3be168c34fc0
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-1.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ * Author: Wenzhen Yu <wenzhen.yu@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "clk-mtk.h"
+#include "clk-gate.h"
+#include "clk-mux.h"
+
+#include <dt-bindings/clock/mt7986-clk.h>
+#include <linux/clk.h>
+
+static DEFINE_SPINLOCK(mt7986_clk_lock);
+
+static const struct mtk_fixed_factor infra_divs[] = {
+	FACTOR(CLK_INFRA_SYSAXI_D2, "infra_sysaxi_d2", "sysaxi_sel", 1, 2),
+};
+
+static const char *const infra_uart_parent[] __initconst = { "csw_f26m_sel",
+							     "uart_sel" };
+
+static const char *const infra_spi_parents[] __initconst = { "i2c_sel",
+							     "spi_sel" };
+
+static const char *const infra_pwm_bsel_parents[] __initconst = {
+	"top_rtc_32p7k", "csw_f26m_sel", "infra_sysaxi_d2", "pwm_sel"
+};
+
+static const char *const infra_pcie_parents[] __initconst = {
+	"top_rtc_32p7k", "csw_f26m_sel", "top_xtal", "pextp_tl_ck_sel"
+};
+
+static const struct mtk_mux infra_muxes[] = {
+	/* MODULE_CLK_SEL_0 */
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_UART0_SEL, "infra_uart0_sel",
+			     infra_uart_parent, 0x0018, 0x0010, 0x0014, 0, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_UART1_SEL, "infra_uart1_sel",
+			     infra_uart_parent, 0x0018, 0x0010, 0x0014, 1, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_UART2_SEL, "infra_uart2_sel",
+			     infra_uart_parent, 0x0018, 0x0010, 0x0014, 2, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_SPI0_SEL, "infra_spi0_sel",
+			     infra_spi_parents, 0x0018, 0x0010, 0x0014, 4, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_SPI1_SEL, "infra_spi1_sel",
+			     infra_spi_parents, 0x0018, 0x0010, 0x0014, 5, 1,
+			     -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_PWM1_SEL, "infra_pwm1_sel",
+			     infra_pwm_bsel_parents, 0x0018, 0x0010, 0x0014, 9,
+			     2, -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_PWM2_SEL, "infra_pwm2_sel",
+			     infra_pwm_bsel_parents, 0x0018, 0x0010, 0x0014, 11,
+			     2, -1, -1, -1),
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_PWM_BSEL, "infra_pwm_bsel",
+			     infra_pwm_bsel_parents, 0x0018, 0x0010, 0x0014, 13,
+			     2, -1, -1, -1),
+	/* MODULE_CLK_SEL_1 */
+	MUX_GATE_CLR_SET_UPD(CLK_INFRA_PCIE_SEL, "infra_pcie_sel",
+			     infra_pcie_parents, 0x0028, 0x0020, 0x0024, 0, 2,
+			     -1, -1, -1),
+};
+
+static const struct mtk_gate_regs infra0_cg_regs = {
+	.set_ofs = 0x40,
+	.clr_ofs = 0x44,
+	.sta_ofs = 0x48,
+};
+
+static const struct mtk_gate_regs infra1_cg_regs = {
+	.set_ofs = 0x50,
+	.clr_ofs = 0x54,
+	.sta_ofs = 0x58,
+};
+
+static const struct mtk_gate_regs infra2_cg_regs = {
+	.set_ofs = 0x60,
+	.clr_ofs = 0x64,
+	.sta_ofs = 0x68,
+};
+
+#define GATE_INFRA0(_id, _name, _parent, _shift)                               \
+	{                                                                      \
+		.id = _id, .name = _name, .parent_name = _parent,              \
+		.regs = &infra0_cg_regs, .shift = _shift,                      \
+		.ops = &mtk_clk_gate_ops_setclr,                               \
+	}
+
+#define GATE_INFRA1(_id, _name, _parent, _shift)                               \
+	{                                                                      \
+		.id = _id, .name = _name, .parent_name = _parent,              \
+		.regs = &infra1_cg_regs, .shift = _shift,                      \
+		.ops = &mtk_clk_gate_ops_setclr,                               \
+	}
+
+#define GATE_INFRA2(_id, _name, _parent, _shift)                               \
+	{                                                                      \
+		.id = _id, .name = _name, .parent_name = _parent,              \
+		.regs = &infra2_cg_regs, .shift = _shift,                      \
+		.ops = &mtk_clk_gate_ops_setclr,                               \
+	}
+
+static const struct mtk_gate infra_clks[] = {
+	/* INFRA0 */
+	GATE_INFRA0(CLK_INFRA_GPT_STA, "infra_gpt_sta", "infra_sysaxi_d2", 0),
+	GATE_INFRA0(CLK_INFRA_PWM_HCK, "infra_pwm_hck", "infra_sysaxi_d2", 1),
+	GATE_INFRA0(CLK_INFRA_PWM_STA, "infra_pwm_sta", "infra_pwm_bsel", 2),
+	GATE_INFRA0(CLK_INFRA_PWM1_CK, "infra_pwm1", "infra_pwm1_sel", 3),
+	GATE_INFRA0(CLK_INFRA_PWM2_CK, "infra_pwm2", "infra_pwm2_sel", 4),
+	GATE_INFRA0(CLK_INFRA_CQ_DMA_CK, "infra_cq_dma", "sysaxi_sel", 6),
+	GATE_INFRA0(CLK_INFRA_EIP97_CK, "infra_eip97", "eip_b_sel", 7),
+	GATE_INFRA0(CLK_INFRA_AUD_BUS_CK, "infra_aud_bus", "sysaxi_sel", 8),
+	GATE_INFRA0(CLK_INFRA_AUD_26M_CK, "infra_aud_26m", "csw_f26m_sel", 9),
+	GATE_INFRA0(CLK_INFRA_AUD_L_CK, "infra_aud_l", "aud_l_sel", 10),
+	GATE_INFRA0(CLK_INFRA_AUD_AUD_CK, "infra_aud_aud", "a1sys_sel", 11),
+	GATE_INFRA0(CLK_INFRA_AUD_EG2_CK, "infra_aud_eg2", "a_tuner_sel", 13),
+	GATE_INFRA0(CLK_INFRA_DRAMC_26M_CK, "infra_dramc_26m", "csw_f26m_sel",
+		    14),
+	GATE_INFRA0(CLK_INFRA_DBG_CK, "infra_dbg", "infra_sysaxi_d2", 15),
+	GATE_INFRA0(CLK_INFRA_AP_DMA_CK, "infra_ap_dma", "infra_sysaxi_d2", 16),
+	GATE_INFRA0(CLK_INFRA_SEJ_CK, "infra_sej", "infra_sysaxi_d2", 24),
+	GATE_INFRA0(CLK_INFRA_SEJ_13M_CK, "infra_sej_13m", "csw_f26m_sel", 25),
+	GATE_INFRA0(CLK_INFRA_TRNG_CK, "infra_trng", "sysaxi_sel", 26),
+	/* INFRA1 */
+	GATE_INFRA1(CLK_INFRA_THERM_CK, "infra_therm", "csw_f26m_sel", 0),
+	GATE_INFRA1(CLK_INFRA_I2C0_CK, "infra_i2c0", "i2c_sel", 1),
+	GATE_INFRA1(CLK_INFRA_UART0_CK, "infra_uart0", "infra_uart0_sel", 2),
+	GATE_INFRA1(CLK_INFRA_UART1_CK, "infra_uart1", "infra_uart1_sel", 3),
+	GATE_INFRA1(CLK_INFRA_UART2_CK, "infra_uart2", "infra_uart2_sel", 4),
+	GATE_INFRA1(CLK_INFRA_NFI1_CK, "infra_nfi1", "nfi1x_sel", 8),
+	GATE_INFRA1(CLK_INFRA_SPINFI1_CK, "infra_spinfi1", "spinfi_sel", 9),
+	GATE_INFRA1(CLK_INFRA_NFI_HCK_CK, "infra_nfi_hck", "infra_sysaxi_d2",
+		    10),
+	GATE_INFRA1(CLK_INFRA_SPI0_CK, "infra_spi0", "infra_spi0_sel", 11),
+	GATE_INFRA1(CLK_INFRA_SPI1_CK, "infra_spi1", "infra_spi1_sel", 12),
+	GATE_INFRA1(CLK_INFRA_SPI0_HCK_CK, "infra_spi0_hck", "infra_sysaxi_d2",
+		    13),
+	GATE_INFRA1(CLK_INFRA_SPI1_HCK_CK, "infra_spi1_hck", "infra_sysaxi_d2",
+		    14),
+	GATE_INFRA1(CLK_INFRA_FRTC_CK, "infra_frtc", "top_rtc_32k", 15),
+	GATE_INFRA1(CLK_INFRA_MSDC_CK, "infra_msdc", "emmc_416m_sel", 16),
+	GATE_INFRA1(CLK_INFRA_MSDC_HCK_CK, "infra_msdc_hck", "emmc_250m_sel",
+		    17),
+	GATE_INFRA1(CLK_INFRA_MSDC_133M_CK, "infra_msdc_133m", "sysaxi_sel",
+		    18),
+	GATE_INFRA1(CLK_INFRA_MSDC_66M_CK, "infra_msdc_66m", "infra_sysaxi_d2",
+		    19),
+	GATE_INFRA1(CLK_INFRA_ADC_26M_CK, "infra_adc_26m", "csw_f26m_sel", 20),
+	GATE_INFRA1(CLK_INFRA_ADC_FRC_CK, "infra_adc_frc", "csw_f26m_sel", 21),
+	GATE_INFRA1(CLK_INFRA_FBIST2FPC_CK, "infra_fbist2fpc", "nfi1x_sel", 23),
+	/* INFRA2 */
+	GATE_INFRA2(CLK_INFRA_IUSB_133_CK, "infra_iusb_133", "sysaxi_sel", 0),
+	GATE_INFRA2(CLK_INFRA_IUSB_66M_CK, "infra_iusb_66m", "infra_sysaxi_d2",
+		    1),
+	GATE_INFRA2(CLK_INFRA_IUSB_SYS_CK, "infra_iusb_sys", "u2u3_sys_sel", 2),
+	GATE_INFRA2(CLK_INFRA_IUSB_CK, "infra_iusb", "u2u3_sel", 3),
+	GATE_INFRA2(CLK_INFRA_IPCIE_CK, "infra_ipcie", "pextp_tl_ck_sel", 12),
+	GATE_INFRA2(CLK_INFRA_IPCIE_PIPE_CK, "infra_ipcie_pipe", "top_xtal",
+		    13),
+	GATE_INFRA2(CLK_INFRA_IPCIER_CK, "infra_ipcier", "csw_f26m_sel", 14),
+	GATE_INFRA2(CLK_INFRA_IPCIEB_CK, "infra_ipcieb", "sysaxi_sel", 15),
+};
+
+static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+	void __iomem *base;
+	int nr = ARRAY_SIZE(infra_divs) + ARRAY_SIZE(infra_muxes) +
+		 ARRAY_SIZE(infra_clks);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s(): ioremap failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	clk_data = mtk_alloc_clk_data(nr);
+
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
+	mtk_clk_register_muxes(infra_muxes, ARRAY_SIZE(infra_muxes), node,
+			       &mt7986_clk_lock, clk_data);
+	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
+			       clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r) {
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+		goto free_infracfg_data;
+	}
+	return r;
+
+free_infracfg_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+
+}
+
+static const struct of_device_id of_match_clk_mt7986_infracfg[] = {
+	{ .compatible = "mediatek,mt7986-infracfg", },
+	{}
+};
+
+static struct platform_driver clk_mt7986_infracfg_drv = {
+	.probe = clk_mt7986_infracfg_probe,
+	.driver = {
+		.name = "clk-mt7986-infracfg",
+		.of_match_table = of_match_clk_mt7986_infracfg,
+	},
+};
+builtin_platform_driver(clk_mt7986_infracfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
new file mode 100644
index 000000000000..8550e2be7773
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-1.0
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Sam Shih <sam.shih@mediatek.com>
+ * Author: Wenzhen Yu <wenzhen.yu@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include "clk-mtk.h"
+#include "clk-gate.h"
+#include "clk-mux.h"
+
+#include <dt-bindings/clock/mt7986-clk.h>
+#include <linux/clk.h>
+
+static DEFINE_SPINLOCK(mt7986_clk_lock);
+
+static const struct mtk_fixed_clk top_fixed_clks[] = {
+	FIXED_CLK(CLK_TOP_XTAL, "top_xtal", "clkxtal", 40000000),
+	FIXED_CLK(CLK_TOP_JTAG, "top_jtag", "clkxtal", 50000000),
+};
+
+static const struct mtk_fixed_factor top_divs[] = {
+	/* XTAL */
+	FACTOR(CLK_TOP_XTAL_D2, "top_xtal_d2", "top_xtal", 1, 2),
+	FACTOR(CLK_TOP_RTC_32K, "top_rtc_32k", "top_xtal", 1, 1250),
+	FACTOR(CLK_TOP_RTC_32P7K, "top_rtc_32p7k", "top_xtal", 1, 1220),
+	/* MPLL */
+	FACTOR(CLK_TOP_MPLL_D2, "top_mpll_d2", "mpll", 1, 2),
+	FACTOR(CLK_TOP_MPLL_D4, "top_mpll_d4", "mpll", 1, 4),
+	FACTOR(CLK_TOP_MPLL_D8, "top_mpll_d8", "mpll", 1, 8),
+	FACTOR(CLK_TOP_MPLL_D8_D2, "top_mpll_d8_d2", "mpll", 1, 16),
+	FACTOR(CLK_TOP_MPLL_D3_D2, "top_mpll_d3_d2", "mpll", 1, 6),
+	/* MMPLL */
+	FACTOR(CLK_TOP_MMPLL_D2, "top_mmpll_d2", "mmpll", 1, 2),
+	FACTOR(CLK_TOP_MMPLL_D4, "top_mmpll_d4", "mmpll", 1, 4),
+	FACTOR(CLK_TOP_MMPLL_D8, "top_mmpll_d8", "mmpll", 1, 8),
+	FACTOR(CLK_TOP_MMPLL_D8_D2, "top_mmpll_d8_d2", "mmpll", 1, 16),
+	FACTOR(CLK_TOP_MMPLL_D3_D8, "top_mmpll_d3_d8", "mmpll", 1, 24),
+	FACTOR(CLK_TOP_MMPLL_U2PHY, "top_mmpll_u2phy", "mmpll", 1, 30),
+	/* APLL2 */
+	FACTOR(CLK_TOP_APLL2_D4, "top_apll2_d4", "apll2", 1, 4),
+	/* NET1PLL */
+	FACTOR(CLK_TOP_NET1PLL_D4, "top_net1pll_d4", "net1pll", 1, 4),
+	FACTOR(CLK_TOP_NET1PLL_D5, "top_net1pll_d5", "net1pll", 1, 5),
+	FACTOR(CLK_TOP_NET1PLL_D5_D2, "top_net1pll_d5_d2", "net1pll", 1, 10),
+	FACTOR(CLK_TOP_NET1PLL_D5_D4, "top_net1pll_d5_d4", "net1pll", 1, 20),
+	FACTOR(CLK_TOP_NET1PLL_D8_D2, "top_net1pll_d8_d2", "net1pll", 1, 16),
+	FACTOR(CLK_TOP_NET1PLL_D8_D4, "top_net1pll_d8_d4", "net1pll", 1, 32),
+	/* NET2PLL */
+	FACTOR(CLK_TOP_NET2PLL_D4, "top_net2pll_d4", "net2pll", 1, 4),
+	FACTOR(CLK_TOP_NET2PLL_D4_D2, "top_net2pll_d4_d2", "net2pll", 1, 8),
+	FACTOR(CLK_TOP_NET2PLL_D3_D2, "top_net2pll_d3_d2", "net2pll", 1, 2),
+	/* WEDMCUPLL */
+	FACTOR(CLK_TOP_WEDMCUPLL_D5_D2, "top_wedmcupll_d5_d2", "wedmcupll", 1,
+	       10),
+};
+
+static const char *const nfi1x_parents[] __initconst = { "top_xtal",
+							 "top_mmpll_d8",
+							 "top_net1pll_d8_d2",
+							 "top_net2pll_d3_d2",
+							 "top_mpll_d4",
+							 "top_mmpll_d8_d2",
+							 "top_wedmcupll_d5_d2",
+							 "top_mpll_d8" };
+
+static const char *const spinfi_parents[] __initconst = {
+	"top_xtal_d2",     "top_xtal",	"top_net1pll_d5_d4",
+	"top_mpll_d4",     "top_mmpll_d8_d2", "top_wedmcupll_d5_d2",
+	"top_mmpll_d3_d8", "top_mpll_d8"
+};
+
+static const char *const spi_parents[] __initconst = {
+	"top_xtal",	  "top_mpll_d2",	"top_mmpll_d8",
+	"top_net1pll_d8_d2", "top_net2pll_d3_d2",  "top_net1pll_d5_d4",
+	"top_mpll_d4",       "top_wedmcupll_d5_d2"
+};
+
+static const char *const uart_parents[] __initconst = { "top_xtal",
+							"top_mpll_d8",
+							"top_mpll_d8_d2" };
+
+static const char *const pwm_parents[] __initconst = {
+	"top_xtal", "top_net1pll_d8_d2", "top_net1pll_d5_d4", "top_mpll_d4"
+};
+
+static const char *const i2c_parents[] __initconst = {
+	"top_xtal", "top_net1pll_d5_d4", "top_mpll_d4", "top_net1pll_d8_d4"
+};
+
+static const char *const pextp_tl_ck_parents[] __initconst = {
+	"top_xtal", "top_net1pll_d5_d4", "top_net2pll_d4_d2", "top_rtc_32k"
+};
+
+static const char *const emmc_250m_parents[] __initconst = {
+	"top_xtal", "top_net1pll_d5_d2"
+};
+
+static const char *const emmc_416m_parents[] __initconst = { "top_xtal",
+							     "mpll" };
+
+static const char *const f_26m_adc_parents[] __initconst = { "top_xtal",
+							     "top_mpll_d8_d2" };
+
+static const char *const dramc_md32_parents[] __initconst = { "top_xtal",
+							      "top_mpll_d2" };
+
+static const char *const sysaxi_parents[] __initconst = { "top_xtal",
+							  "top_net1pll_d8_d2",
+							  "top_net2pll_d4" };
+
+static const char *const sysapb_parents[] __initconst = { "top_xtal",
+							  "top_mpll_d3_d2",
+							  "top_net2pll_d4_d2" };
+
+static const char *const arm_db_main_parents[] __initconst = {
+	"top_xtal", "top_net2pll_d3_d2"
+};
+
+static const char *const arm_db_jtsel_parents[] __initconst = { "top_jtag",
+								"top_xtal" };
+
+static const char *const netsys_parents[] __initconst = { "top_xtal",
+							  "top_mmpll_d4" };
+
+static const char *const netsys_500m_parents[] __initconst = {
+	"top_xtal", "top_net1pll_d5"
+};
+
+static const char *const netsys_mcu_parents[] __initconst = {
+	"top_xtal", "wedmcupll", "top_mmpll_d2", "top_net1pll_d4",
+	"top_net1pll_d5"
+};
+
+static const char *const netsys_2x_parents[] __initconst = {
+	"top_xtal", "net2pll", "wedmcupll", "top_mmpll_d2"
+};
+
+static const char *const sgm_325m_parents[] __initconst = { "top_xtal",
+							    "sgmpll" };
+
+static const char *const sgm_reg_parents[] __initconst = {
+	"top_xtal", "top_net1pll_d8_d4"
+};
+
+static const char *const a1sys_parents[] __initconst = { "top_xtal",
+							 "top_apll2_d4" };
+
+static const char *const conn_mcusys_parents[] __initconst = { "top_xtal",
+							       "top_mmpll_d2" };
+
+static const char *const eip_b_parents[] __initconst = { "top_xtal",
+							 "net2pll" };
+
+static const char *const aud_l_parents[] __initconst = { "top_xtal", "apll2",
+							 "top_mpll_d8_d2" };
+
+static const char *const a_tuner_parents[] __initconst = { "top_xtal",
+							   "top_apll2_d4",
+							   "top_mpll_d8_d2" };
+
+static const char *const u2u3_sys_parents[] __initconst = {
+	"top_xtal", "top_net1pll_d5_d4"
+};
+
+static const char *const da_u2_refsel_parents[] __initconst = {
+	"top_xtal", "top_mmpll_u2phy"
+};
+
+static const struct mtk_mux top_muxes[] = {
+	/* CLK_CFG_0 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NFI1X_SEL, "nfi1x_sel", nfi1x_parents,
+			     0x000, 0x004, 0x008, 0, 3, 7, 0x1C0, 0),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPINFI_SEL, "spinfi_sel", spinfi_parents,
+			     0x000, 0x004, 0x008, 8, 3, 15, 0x1C0, 1),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI_SEL, "spi_sel", spi_parents, 0x000,
+			     0x004, 0x008, 16, 3, 23, 0x1C0, 2),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPIM_MST_SEL, "spim_mst_sel", spi_parents,
+			     0x000, 0x004, 0x008, 24, 3, 31, 0x1C0, 3),
+	/* CLK_CFG_1 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_UART_SEL, "uart_sel", uart_parents, 0x010,
+			     0x014, 0x018, 0, 2, 7, 0x1C0, 4),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM_SEL, "pwm_sel", pwm_parents, 0x010,
+			     0x014, 0x018, 8, 2, 15, 0x1C0, 5),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C_SEL, "i2c_sel", i2c_parents, 0x010,
+			     0x014, 0x018, 16, 2, 23, 0x1C0, 6),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PEXTP_TL_SEL, "pextp_tl_ck_sel",
+			     pextp_tl_ck_parents, 0x010, 0x014, 0x018, 24, 2,
+			     31, 0x1C0, 7),
+	/* CLK_CFG_2 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_250M_SEL, "emmc_250m_sel",
+			     emmc_250m_parents, 0x020, 0x024, 0x028, 0, 1, 7,
+			     0x1C0, 8),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_416M_SEL, "emmc_416m_sel",
+			     emmc_416m_parents, 0x020, 0x024, 0x028, 8, 1, 15,
+			     0x1C0, 9),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_F_26M_ADC_SEL, "f_26m_adc_sel",
+			     f_26m_adc_parents, 0x020, 0x024, 0x028, 16, 1, 23,
+			     0x1C0, 10),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DRAMC_SEL, "dramc_sel", f_26m_adc_parents,
+			     0x020, 0x024, 0x028, 24, 1, 31, 0x1C0, 11),
+	/* CLK_CFG_3 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DRAMC_MD32_SEL, "dramc_md32_sel",
+			     dramc_md32_parents, 0x030, 0x034, 0x038, 0, 1, 7,
+			     0x1C0, 12),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SYSAXI_SEL, "sysaxi_sel", sysaxi_parents,
+			     0x030, 0x034, 0x038, 8, 2, 15, 0x1C0, 13),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SYSAPB_SEL, "sysapb_sel", sysapb_parents,
+			     0x030, 0x034, 0x038, 16, 2, 23, 0x1C0, 14),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ARM_DB_MAIN_SEL, "arm_db_main_sel",
+			     arm_db_main_parents, 0x030, 0x034, 0x038, 24, 1,
+			     31, 0x1C0, 15),
+	/* CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ARM_DB_JTSEL, "arm_db_jtsel",
+			     arm_db_jtsel_parents, 0x040, 0x044, 0x048, 0, 1, 7,
+			     0x1C0, 16),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NETSYS_SEL, "netsys_sel", netsys_parents,
+			     0x040, 0x044, 0x048, 8, 1, 15, 0x1C0, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NETSYS_500M_SEL, "netsys_500m_sel",
+			     netsys_500m_parents, 0x040, 0x044, 0x048, 16, 1,
+			     23, 0x1C0, 18),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NETSYS_MCU_SEL, "netsys_mcu_sel",
+			     netsys_mcu_parents, 0x040, 0x044, 0x048, 24, 3, 31,
+			     0x1C0, 19),
+	/* CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_NETSYS_2X_SEL, "netsys_2x_sel",
+			     netsys_2x_parents, 0x050, 0x054, 0x058, 0, 2, 7,
+			     0x1C0, 20),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_325M_SEL, "sgm_325m_sel",
+			     sgm_325m_parents, 0x050, 0x054, 0x058, 8, 1, 15,
+			     0x1C0, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_REG_SEL, "sgm_reg_sel",
+			     sgm_reg_parents, 0x050, 0x054, 0x058, 16, 1, 23,
+			     0x1C0, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_A1SYS_SEL, "a1sys_sel", a1sys_parents,
+			     0x050, 0x054, 0x058, 24, 1, 31, 0x1C0, 23),
+	/* CLK_CFG_6 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CONN_MCUSYS_SEL, "conn_mcusys_sel",
+			     conn_mcusys_parents, 0x060, 0x064, 0x068, 0, 1, 7,
+			     0x1C0, 24),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_EIP_B_SEL, "eip_b_sel", eip_b_parents,
+			     0x060, 0x064, 0x068, 8, 1, 15, 0x1C0, 25),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PCIE_PHY_SEL, "pcie_phy_sel",
+			     f_26m_adc_parents, 0x060, 0x064, 0x068, 16, 1, 23,
+			     0x1C0, 26),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB3_PHY_SEL, "usb3_phy_sel",
+			     f_26m_adc_parents, 0x060, 0x064, 0x068, 24, 1, 31,
+			     0x1C0, 27),
+	/* CLK_CFG_7 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_F26M_SEL, "csw_f26m_sel",
+			     f_26m_adc_parents, 0x070, 0x074, 0x078, 0, 1, 7,
+			     0x1C0, 28),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_L_SEL, "aud_l_sel", aud_l_parents,
+			     0x070, 0x074, 0x078, 8, 2, 15, 0x1C0, 29),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_A_TUNER_SEL, "a_tuner_sel",
+			     a_tuner_parents, 0x070, 0x074, 0x078, 16, 2, 23,
+			     0x1C0, 30),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U2U3_SEL, "u2u3_sel", f_26m_adc_parents,
+			     0x070, 0x074, 0x078, 24, 1, 31, 0x1C4, 0),
+	/* CLK_CFG_8 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U2U3_SYS_SEL, "u2u3_sys_sel",
+			     u2u3_sys_parents, 0x080, 0x084, 0x088, 0, 1, 7,
+			     0x1C4, 1),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_U2U3_XHCI_SEL, "u2u3_xhci_sel",
+			     u2u3_sys_parents, 0x080, 0x084, 0x088, 8, 1, 15,
+			     0x1C4, 2),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DA_U2_REFSEL, "da_u2_refsel",
+			     da_u2_refsel_parents, 0x080, 0x084, 0x088, 16, 1,
+			     23, 0x1C4, 3),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DA_U2_CK_1P_SEL, "da_u2_ck_1p_sel",
+			     da_u2_refsel_parents, 0x080, 0x084, 0x088, 24, 1,
+			     31, 0x1C4, 4),
+	/* CLK_CFG_9 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AP2CNN_HOST_SEL, "ap2cnn_host_sel",
+			     sgm_reg_parents, 0x090, 0x094, 0x098, 0, 1, 7,
+			     0x1C4, 5),
+};
+
+static int clk_mt7986_topckgen_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+	void __iomem *base;
+	int nr = ARRAY_SIZE(top_fixed_clks) + ARRAY_SIZE(top_divs) +
+		 ARRAY_SIZE(top_muxes);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s(): ioremap failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	clk_data = mtk_alloc_clk_data(nr);
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
+				    clk_data);
+	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+			       &mt7986_clk_lock, clk_data);
+
+	clk_prepare_enable(clk_data->clks[CLK_TOP_SYSAXI_SEL]);
+	clk_prepare_enable(clk_data->clks[CLK_TOP_SYSAPB_SEL]);
+	clk_prepare_enable(clk_data->clks[CLK_TOP_DRAMC_SEL]);
+	clk_prepare_enable(clk_data->clks[CLK_TOP_DRAMC_MD32_SEL]);
+	clk_prepare_enable(clk_data->clks[CLK_TOP_F26M_SEL]);
+	clk_prepare_enable(clk_data->clks[CLK_TOP_SGM_REG_SEL]);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+
+	if (r) {
+		pr_err("%s(): could not register clock provider: %d\n",
+		       __func__, r);
+		goto free_topckgen_data;
+	}
+	return r;
+
+free_topckgen_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static const struct of_device_id of_match_clk_mt7986_topckgen[] = {
+	{ .compatible = "mediatek,mt7986-topckgen", },
+	{}
+};
+
+static struct platform_driver clk_mt7986_topckgen_drv = {
+	.probe = clk_mt7986_topckgen_probe,
+	.driver = {
+		.name = "clk-mt7986-topckgen",
+		.of_match_table = of_match_clk_mt7986_topckgen,
+	},
+};
+builtin_platform_driver(clk_mt7986_topckgen_drv);
-- 
2.29.2

