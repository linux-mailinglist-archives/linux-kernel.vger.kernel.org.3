Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CBA4B834B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiBPIs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:48:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiBPIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:48:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890B25A95F;
        Wed, 16 Feb 2022 00:48:39 -0800 (PST)
X-UUID: f82b581349f241df9fc2c27222efefd9-20220216
X-UUID: f82b581349f241df9fc2c27222efefd9-20220216
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 654807711; Wed, 16 Feb 2022 16:48:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 16 Feb 2022 16:48:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 16:48:33 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>
CC:     <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jassisinghbrar@gmail.com>, <fparent@baylibre.com>,
        <yongqiang.niu@mediatek.com>, <hsinyi@chromium.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v3,3/5] soc: mediatek: mmsys: add mt8186 mmsys routing table
Date:   Wed, 16 Feb 2022 16:48:29 +0800
Message-ID: <20220216084831.14883-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220216084831.14883-1-rex-bc.chen@mediatek.com>
References: <20220216084831.14883-1-rex-bc.chen@mediatek.com>
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

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Add new routing table for MT8186.
In MT8186, there are two routing pipelines for internal and
external display.

Internal display: OVL0->RDMA0->COLOR0->CCORR0->AAL0->GAMMA->POSTMASK0
		  ->DITHER->DSI0
External display: OVL_2L0->RDMA1->DPI0

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/soc/mediatek/mt8186-mmsys.h | 113 ++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.c    |  11 +++
 2 files changed, 124 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8186-mmsys.h

diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
new file mode 100644
index 000000000000..7de329f2d729
--- /dev/null
+++ b/drivers/soc/mediatek/mt8186-mmsys.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_MEDIATEK_MT8186_MMSYS_H
+#define __SOC_MEDIATEK_MT8186_MMSYS_H
+
+#define MT8186_MMSYS_OVL_CON			0xF04
+#define MT8186_MMSYS_OVL0_CON_MASK			0x3
+#define MT8186_MMSYS_OVL0_2L_CON_MASK			0xC
+#define MT8186_OVL0_GO_BLEND				BIT(0)
+#define MT8186_OVL0_GO_BG				BIT(1)
+#define MT8186_OVL0_2L_GO_BLEND				BIT(2)
+#define MT8186_OVL0_2L_GO_BG				BIT(3)
+#define MT8186_DISP_RDMA0_SOUT_SEL		0xF0C
+#define MT8186_RDMA0_SOUT_SEL_MASK			0xF
+#define MT8186_RDMA0_SOUT_TO_DSI0			(0)
+#define MT8186_RDMA0_SOUT_TO_COLOR0			(1)
+#define MT8186_RDMA0_SOUT_TO_DPI0			(2)
+#define MT8186_DISP_OVL0_2L_MOUT_EN		0xF14
+#define MT8186_OVL0_2L_MOUT_EN_MASK			0xF
+#define MT8186_OVL0_2L_MOUT_TO_RDMA0			BIT(0)
+#define MT8186_OVL0_2L_MOUT_TO_RDMA1			BIT(3)
+#define MT8186_DISP_OVL0_MOUT_EN		0xF18
+#define MT8186_OVL0_MOUT_EN_MASK			0xF
+#define MT8186_OVL0_MOUT_TO_RDMA0			BIT(0)
+#define MT8186_OVL0_MOUT_TO_RDMA1			BIT(3)
+#define MT8186_DISP_DITHER0_MOUT_EN		0xF20
+#define MT8186_DITHER0_MOUT_EN_MASK			0xF
+#define MT8186_DITHER0_MOUT_TO_DSI0			BIT(0)
+#define MT8186_DITHER0_MOUT_TO_RDMA1			BIT(2)
+#define MT8186_DITHER0_MOUT_TO_DPI0			BIT(3)
+#define MT8186_DISP_RDMA0_SEL_IN		0xF28
+#define MT8186_RDMA0_SEL_IN_MASK			0xF
+#define MT8186_RDMA0_FROM_OVL0				0
+#define MT8186_RDMA0_FROM_OVL0_2L			2
+#define MT8186_DISP_DSI0_SEL_IN			0xF30
+#define MT8186_DSI0_SEL_IN_MASK				0xF
+#define MT8186_DSI0_FROM_RDMA0				0
+#define MT8186_DSI0_FROM_DITHER0			1
+#define MT8186_DSI0_FROM_RDMA1				2
+#define MT8186_DISP_RDMA1_MOUT_EN		0xF3C
+#define MT8186_RDMA1_MOUT_EN_MASK			0xF
+#define MT8186_RDMA1_MOUT_TO_DPI0_SEL			BIT(0)
+#define MT8186_RDMA1_MOUT_TO_DSI0_SEL			BIT(2)
+#define MT8186_DISP_RDMA1_SEL_IN		0xF40
+#define MT8186_RDMA1_SEL_IN_MASK			0xF
+#define MT8186_RDMA1_FROM_OVL0				0
+#define MT8186_RDMA1_FROM_OVL0_2L			2
+#define MT8186_RDMA1_FROM_DITHER0			3
+#define MT8186_DISP_DPI0_SEL_IN			0xF44
+#define MT8186_DPI0_SEL_IN_MASK				0xF
+#define MT8186_DPI0_FROM_RDMA1				0
+#define MT8186_DPI0_FROM_DITHER0			1
+#define MT8186_DPI0_FROM_RDMA0				2
+
+static const struct mtk_mmsys_routes mmsys_mt8186_routing_table[] = {
+	{
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
+		MT8186_DISP_OVL0_MOUT_EN, MT8186_OVL0_MOUT_EN_MASK,
+		MT8186_OVL0_MOUT_TO_RDMA0
+	},
+	{
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
+		MT8186_DISP_RDMA0_SEL_IN, MT8186_RDMA0_SEL_IN_MASK,
+		MT8186_RDMA0_FROM_OVL0
+	},
+	{
+		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
+		MT8186_MMSYS_OVL_CON, MT8186_MMSYS_OVL0_CON_MASK,
+		MT8186_OVL0_GO_BLEND
+	},
+	{
+		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
+		MT8186_DISP_RDMA0_SOUT_SEL, MT8186_RDMA0_SOUT_SEL_MASK,
+		MT8186_RDMA0_SOUT_TO_COLOR0
+	},
+	{
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
+		MT8186_DISP_DITHER0_MOUT_EN, MT8186_DITHER0_MOUT_EN_MASK,
+		MT8186_DITHER0_MOUT_TO_DSI0,
+	},
+	{
+		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
+		MT8186_DISP_DSI0_SEL_IN, MT8186_DSI0_SEL_IN_MASK,
+		MT8186_DSI0_FROM_DITHER0
+	},
+	{
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA1,
+		MT8186_DISP_OVL0_2L_MOUT_EN, MT8186_OVL0_2L_MOUT_EN_MASK,
+		MT8186_OVL0_2L_MOUT_TO_RDMA1
+	},
+	{
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA1,
+		MT8186_DISP_RDMA1_SEL_IN, MT8186_RDMA1_SEL_IN_MASK,
+		MT8186_RDMA1_FROM_OVL0_2L
+	},
+	{
+		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA1,
+		MT8186_MMSYS_OVL_CON, MT8186_MMSYS_OVL0_2L_CON_MASK,
+		MT8186_OVL0_2L_GO_BLEND
+	},
+	{
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
+		MT8186_DISP_RDMA1_MOUT_EN, MT8186_RDMA1_MOUT_EN_MASK,
+		MT8186_RDMA1_MOUT_TO_DPI0_SEL
+	},
+	{
+		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
+		MT8186_DISP_DPI0_SEL_IN, MT8186_DPI0_SEL_IN_MASK,
+		MT8186_DPI0_FROM_RDMA1
+	},
+};
+
+#endif /* __SOC_MEDIATEK_MT8186_MMSYS_H */
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 1e448f1ffefb..0da25069ffb3 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -15,6 +15,7 @@
 #include "mtk-mmsys.h"
 #include "mt8167-mmsys.h"
 #include "mt8183-mmsys.h"
+#include "mt8186-mmsys.h"
 #include "mt8192-mmsys.h"
 #include "mt8365-mmsys.h"
 
@@ -56,6 +57,12 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
 };
 
+static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
+	.clk_driver = "clk-mt8186-mm",
+	.routes = mmsys_mt8186_routing_table,
+	.num_routes = ARRAY_SIZE(mmsys_mt8186_routing_table),
+};
+
 static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
 	.clk_driver = "clk-mt8192-mm",
 	.routes = mmsys_mt8192_routing_table,
@@ -242,6 +249,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
 		.compatible = "mediatek,mt8183-mmsys",
 		.data = &mt8183_mmsys_driver_data,
 	},
+	{
+		.compatible = "mediatek,mt8186-mmsys",
+		.data = &mt8186_mmsys_driver_data,
+	},
 	{
 		.compatible = "mediatek,mt8192-mmsys",
 		.data = &mt8192_mmsys_driver_data,
-- 
2.18.0

