Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E524D60F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348449AbiCKLpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348393AbiCKLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:44:31 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568BBF8BAD;
        Fri, 11 Mar 2022 03:43:21 -0800 (PST)
X-UUID: 4b4479ecac6040dda7013271c8540454-20220311
X-UUID: 4b4479ecac6040dda7013271c8540454-20220311
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2093930389; Fri, 11 Mar 2022 19:43:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 11 Mar 2022 19:43:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Mar 2022 19:43:15 +0800
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
Subject: [PATCH v3 10/15] clk: mediatek: Add MT8186 imgsys clock support
Date:   Fri, 11 Mar 2022 19:42:24 +0800
Message-ID: <20220311114229.32504-11-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220311114229.32504-1-chun-jie.chen@mediatek.com>
References: <20220311114229.32504-1-chun-jie.chen@mediatek.com>
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

Add MT8186 imgsys clock controllers which provide clock gate
control for image IP blocks.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Makefile         |  3 +-
 drivers/clk/mediatek/clk-mt8186-img.c | 68 +++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-img.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index cb1087737007..09ede533bb4e 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -73,7 +73,8 @@ obj-$(CONFIG_COMMON_CLK_MT8183_VDECSYS) += clk-mt8183-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt8186-infra_ao.o \
 				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o \
-				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o
+				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o \
+				   clk-mt8186-img.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-img.c b/drivers/clk/mediatek/clk-mt8186-img.c
new file mode 100644
index 000000000000..6f15ce66a918
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-img.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mt8186-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+static const struct mtk_gate_regs img_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate img1_clks[] = {
+	GATE_IMG(CLK_IMG1_LARB9_IMG1, "img1_larb9_img1", "top_img1", 0),
+	GATE_IMG(CLK_IMG1_LARB10_IMG1, "img1_larb10_img1", "top_img1", 1),
+	GATE_IMG(CLK_IMG1_DIP, "img1_dip", "top_img1", 2),
+	GATE_IMG(CLK_IMG1_GALS_IMG1, "img1_gals_img1", "top_img1", 12),
+};
+
+static const struct mtk_gate img2_clks[] = {
+	GATE_IMG(CLK_IMG2_LARB9_IMG2, "img2_larb9_img2", "top_img1", 0),
+	GATE_IMG(CLK_IMG2_LARB10_IMG2, "img2_larb10_img2", "top_img1", 1),
+	GATE_IMG(CLK_IMG2_MFB, "img2_mfb", "top_img1", 6),
+	GATE_IMG(CLK_IMG2_WPE, "img2_wpe", "top_img1", 7),
+	GATE_IMG(CLK_IMG2_MSS, "img2_mss", "top_img1", 8),
+	GATE_IMG(CLK_IMG2_GALS_IMG2, "img2_gals_img2", "top_img1", 12),
+};
+
+static const struct mtk_clk_desc img1_desc = {
+	.clks = img1_clks,
+	.num_clks = ARRAY_SIZE(img1_clks),
+};
+
+static const struct mtk_clk_desc img2_desc = {
+	.clks = img2_clks,
+	.num_clks = ARRAY_SIZE(img2_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8186_img[] = {
+	{
+		.compatible = "mediatek,mt8186-imgsys1",
+		.data = &img1_desc,
+	}, {
+		.compatible = "mediatek,mt8186-imgsys2",
+		.data = &img2_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8186_img_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8186-img",
+		.of_match_table = of_match_clk_mt8186_img,
+	},
+};
+builtin_platform_driver(clk_mt8186_img_drv);
-- 
2.18.0

