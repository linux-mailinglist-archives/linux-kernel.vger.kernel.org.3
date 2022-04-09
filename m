Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F14FA86A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbiDIN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242023AbiDIN0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:26:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96C19D04D;
        Sat,  9 Apr 2022 06:23:50 -0700 (PDT)
X-UUID: 2d0352df1875432aa5b63814cbff1bce-20220409
X-UUID: 2d0352df1875432aa5b63814cbff1bce-20220409
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 792878858; Sat, 09 Apr 2022 21:23:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 9 Apr 2022 21:23:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Apr 2022 21:23:45 +0800
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
Subject: [PATCH v5 08/15] clk: mediatek: Add MT8186 mmsys clock support
Date:   Sat, 9 Apr 2022 21:22:44 +0800
Message-ID: <20220409132251.31725-9-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220409132251.31725-1-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8186 mmsys clock controller which provides clock gate
control in video system. This is integrated with mtk-mmsys
driver which will populate device by platform_device_register_data
to start mmsys clock driver.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile        |   2 +-
 drivers/clk/mediatek/clk-mt8186-mm.c | 111 +++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mm.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 86e4f4d61688..d0daef003b87 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -73,7 +73,7 @@ obj-$(CONFIG_COMMON_CLK_MT8183_VDECSYS) += clk-mt8183-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt8186-infra_ao.o \
 				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o \
-				   clk-mt8186-mfg.o
+				   clk-mt8186-mfg.o clk-mt8186-mm.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
new file mode 100644
index 000000000000..7c5d0b582f59
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/mt8186-clk.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x1a4,
+	.clr_ofs = 0x1a8,
+	.sta_ofs = 0x1a0,
+};
+
+#define GATE_MM0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MM1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mm_clks[] = {
+	/* MM0 */
+	GATE_MM0(CLK_MM_DISP_MUTEX0, "mm_disp_mutex0", "top_disp", 0),
+	GATE_MM0(CLK_MM_APB_MM_BUS, "mm_apb_mm_bus", "top_disp", 1),
+	GATE_MM0(CLK_MM_DISP_OVL0, "mm_disp_ovl0", "top_disp", 2),
+	GATE_MM0(CLK_MM_DISP_RDMA0, "mm_disp_rdma0", "top_disp", 3),
+	GATE_MM0(CLK_MM_DISP_OVL0_2L, "mm_disp_ovl0_2l", "top_disp", 4),
+	GATE_MM0(CLK_MM_DISP_WDMA0, "mm_disp_wdma0", "top_disp", 5),
+	GATE_MM0(CLK_MM_DISP_RSZ0, "mm_disp_rsz0", "top_disp", 7),
+	GATE_MM0(CLK_MM_DISP_AAL0, "mm_disp_aal0", "top_disp", 8),
+	GATE_MM0(CLK_MM_DISP_CCORR0, "mm_disp_ccorr0", "top_disp", 9),
+	GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0", "top_disp", 10),
+	GATE_MM0(CLK_MM_SMI_INFRA, "mm_smi_infra", "top_disp", 11),
+	GATE_MM0(CLK_MM_DISP_DSC_WRAP0, "mm_disp_dsc_wrap0", "top_disp", 12),
+	GATE_MM0(CLK_MM_DISP_GAMMA0, "mm_disp_gamma0", "top_disp", 13),
+	GATE_MM0(CLK_MM_DISP_POSTMASK0, "mm_disp_postmask0", "top_disp", 14),
+	GATE_MM0(CLK_MM_DISP_DITHER0, "mm_disp_dither0", "top_disp", 16),
+	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "top_disp", 17),
+	GATE_MM0(CLK_MM_DSI0, "mm_dsi0", "top_disp", 19),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG0, "mm_disp_fake_eng0", "top_disp", 20),
+	GATE_MM0(CLK_MM_DISP_FAKE_ENG1, "mm_disp_fake_eng1", "top_disp", 21),
+	GATE_MM0(CLK_MM_SMI_GALS, "mm_smi_gals", "top_disp", 22),
+	GATE_MM0(CLK_MM_SMI_IOMMU, "mm_smi_iommu", "top_disp", 24),
+	GATE_MM0(CLK_MM_DISP_RDMA1, "mm_disp_rdma1", "top_disp", 25),
+	GATE_MM0(CLK_MM_DISP_DPI, "mm_disp_dpi", "top_disp", 26),
+	/* MM1 */
+	GATE_MM1(CLK_MM_DSI0_DSI_CK_DOMAIN, "mm_dsi0_dsi_domain", "top_disp", 0),
+	GATE_MM1(CLK_MM_DISP_26M, "mm_disp_26m_ck", "top_disp", 10),
+};
+
+static int clk_mt8186_mm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	if (r)
+		goto free_mm_data;
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		goto unregister_gates;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return r;
+
+unregister_gates:
+	mtk_clk_unregister_gates(mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+free_mm_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static int clk_mt8186_mm_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_gates(mm_clks, ARRAY_SIZE(mm_clks), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
+static struct platform_driver clk_mt8186_mm_drv = {
+	.probe = clk_mt8186_mm_probe,
+	.remove = clk_mt8186_mm_remove,
+	.driver = {
+		.name = "clk-mt8186-mm",
+	},
+};
+builtin_platform_driver(clk_mt8186_mm_drv);
-- 
2.18.0

