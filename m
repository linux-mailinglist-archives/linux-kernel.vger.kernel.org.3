Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA34B6D44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiBONUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:20:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiBONUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:20:33 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC5F4601
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:20:18 -0800 (PST)
X-UUID: cbe934cbd5294286b62d56f847ee7c8f-20220215
X-UUID: cbe934cbd5294286b62d56f847ee7c8f-20220215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 584839303; Tue, 15 Feb 2022 21:20:15 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 15 Feb 2022 21:20:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 21:20:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 21:20:14 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <matthias.bgg@gmail.com>
CC:     <chunkuang.hu@kernel.org>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>, <enric.balletbo@collabora.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [1/2] soc: mediatek: mmsys: add sw0_rst_offset in mmsys driver data
Date:   Tue, 15 Feb 2022 21:19:51 +0800
Message-ID: <20220215131952.27861-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220215131952.27861-1-rex-bc.chen@mediatek.com>
References: <20220215131952.27861-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are different software reset registers for difference MTK SoCs.
Therefore, we add a new variable "sw0_rst_offset" to control it.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/soc/mediatek/mt8183-mmsys.h | 2 ++
 drivers/soc/mediatek/mtk-mmsys.c    | 6 ++++--
 drivers/soc/mediatek/mtk-mmsys.h    | 3 +--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mt8183-mmsys.h b/drivers/soc/mediatek/mt8183-mmsys.h
index 9dee485807c9..0c021f4b76d2 100644
--- a/drivers/soc/mediatek/mt8183-mmsys.h
+++ b/drivers/soc/mediatek/mt8183-mmsys.h
@@ -25,6 +25,8 @@
 #define MT8183_RDMA0_SOUT_COLOR0		0x1
 #define MT8183_RDMA1_SOUT_DSI0			0x1
 
+#define MT8183_MMSYS_SW0_RST_B			0x140
+
 static const struct mtk_mmsys_routes mmsys_mt8183_routing_table[] = {
 	{
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_OVL_2L0,
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 0da25069ffb3..cab62c3eac05 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -49,12 +49,14 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.clk_driver = "clk-mt8173-mm",
 	.routes = mmsys_default_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_default_routing_table),
+	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
 };
 
 static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.clk_driver = "clk-mt8183-mm",
 	.routes = mmsys_mt8183_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
+	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
 };
 
 static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
@@ -128,14 +130,14 @@ static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned l
 
 	spin_lock_irqsave(&mmsys->lock, flags);
 
-	reg = readl_relaxed(mmsys->regs + MMSYS_SW0_RST_B);
+	reg = readl_relaxed(mmsys->regs + mmsys->data->sw0_rst_offset);
 
 	if (assert)
 		reg &= ~BIT(id);
 	else
 		reg |= BIT(id);
 
-	writel_relaxed(reg, mmsys->regs + MMSYS_SW0_RST_B);
+	writel_relaxed(reg, mmsys->regs + mmsys->data->sw0_rst_offset);
 
 	spin_unlock_irqrestore(&mmsys->lock, flags);
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index 8b0ed05117ea..83320019b4cf 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -78,8 +78,6 @@
 #define DSI_SEL_IN_RDMA				0x1
 #define DSI_SEL_IN_MASK				0x1
 
-#define MMSYS_SW0_RST_B				0x140
-
 struct mtk_mmsys_routes {
 	u32 from_comp;
 	u32 to_comp;
@@ -92,6 +90,7 @@ struct mtk_mmsys_driver_data {
 	const char *clk_driver;
 	const struct mtk_mmsys_routes *routes;
 	const unsigned int num_routes;
+	const unsigned int sw0_rst_offset;
 };
 
 /*
-- 
2.18.0

