Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3013A489A45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiAJNon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:44:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38904 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233157AbiAJNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:44:38 -0500
X-UUID: 15166e8ecad44f60b606b0bae75fe91f-20220110
X-UUID: 15166e8ecad44f60b606b0bae75fe91f-20220110
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1939896879; Mon, 10 Jan 2022 21:44:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 10 Jan 2022 21:44:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 21:44:31 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v1 03/16] clk: mediatek: Add MT8186 mcusys clock support
Date:   Mon, 10 Jan 2022 21:44:03 +0800
Message-ID: <20220110134416.5191-4-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8186 mcusys clock controller which provides muxes
to select the clock source of APMCU.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |  8 +++
 drivers/clk/mediatek/Makefile         |  1 +
 drivers/clk/mediatek/clk-mt8186-mcu.c | 86 +++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mcu.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 3ce6fb04d8ff..7218165b6a44 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -495,6 +495,14 @@ config COMMON_CLK_MT8183_VENCSYS
 	help
 	  This driver supports MediaTek MT8183 vencsys clocks.
 
+config COMMON_CLK_MT8186
+	bool "Clock driver for MediaTek MT8186"
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK
+	help
+	  This driver supports MediaTek MT8186 clocks.
+
 config COMMON_CLK_MT8192
 	bool "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index dc96038a0155..0ae3828f69fb 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_COMMON_CLK_MT8183_MFGCFG) += clk-mt8183-mfgcfg.o
 obj-$(CONFIG_COMMON_CLK_MT8183_MMSYS) += clk-mt8183-mm.o
 obj-$(CONFIG_COMMON_CLK_MT8183_VDECSYS) += clk-mt8183-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
+obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek/clk-mt8186-mcu.c
new file mode 100644
index 000000000000..293176633f65
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mt8186-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+static DEFINE_SPINLOCK(mt8186_clk_lock);
+
+static const char * const mcu_armpll_ll_parents[] = {
+	"clk26m",
+	"armpll_ll",
+	"mainpll",
+	"univpll_d2"
+};
+
+static const char * const mcu_armpll_bl_parents[] = {
+	"clk26m",
+	"armpll_bl",
+	"mainpll",
+	"univpll_d2"
+};
+
+static const char * const mcu_armpll_bus_parents[] = {
+	"clk26m",
+	"ccipll",
+	"mainpll",
+	"univpll_d2"
+};
+
+static struct mtk_composite mcu_muxes[] = {
+	/* CPU_PLLDIV_CFG0 */
+	MUX(CLK_MCU_ARMPLL_LL_SEL, "mcu_armpll_ll_sel", mcu_armpll_ll_parents, 0x2A0, 9, 2),
+	/* CPU_PLLDIV_CFG1 */
+	MUX(CLK_MCU_ARMPLL_BL_SEL, "mcu_armpll_bl_sel", mcu_armpll_bl_parents, 0x2A4, 9, 2),
+	/* BUS_PLLDIV_CFG */
+	MUX(CLK_MCU_ARMPLL_BUS_SEL, "mcu_armpll_bus_sel", mcu_armpll_bus_parents, 0x2E0, 9, 2),
+};
+
+static const struct of_device_id of_match_clk_mt8186_mcu[] = {
+	{ .compatible = "mediatek,mt8186-mcusys", },
+	{}
+};
+
+static int clk_mt8186_mcu_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
+				    &mt8186_clk_lock, clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto unregister_clk;
+
+	return r;
+
+unregister_clk:
+	mtk_clk_unregister(clk_data);
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static struct platform_driver clk_mt8186_mcu_drv = {
+	.probe = clk_mt8186_mcu_probe,
+	.driver = {
+		.name = "clk-mt8186-mcu",
+		.of_match_table = of_match_clk_mt8186_mcu,
+	},
+};
+builtin_platform_driver(clk_mt8186_mcu_drv);
-- 
2.18.0

