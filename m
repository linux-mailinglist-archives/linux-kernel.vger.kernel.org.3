Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B9F4B6502
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiBOICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:02:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiBOICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:02:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216621EC67;
        Tue, 15 Feb 2022 00:01:57 -0800 (PST)
X-UUID: 6dd28071dd92425680c4156bfd306c18-20220215
X-UUID: 6dd28071dd92425680c4156bfd306c18-20220215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 943395828; Tue, 15 Feb 2022 16:01:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 16:01:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 16:01:52 +0800
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
Subject: [v2,4/6] soc: mediatek: add MTK mutex support for MT8186
Date:   Tue, 15 Feb 2022 15:59:51 +0800
Message-ID: <20220215075953.3310-5-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220215075953.3310-1-rex-bc.chen@mediatek.com>
References: <20220215075953.3310-1-rex-bc.chen@mediatek.com>
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

Add MTK mutex support for MT8186 SoC.
We need MTK mutex to control timing of display modules and there
are two display pathes for MT8186 including internal and external
display.

MTK mutex for internal display:
- Timing source: DSI
- Control modules: OVL0/RDMA0/COLOR0/CCORR/AAL0/GAMMA/POSTMASK0/DITHER

MTK mutex for external display:
- Timing source : DPI
- Control modules: OVL_2L0/RDMA1

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 2ca55bb5a8be..ebd95fd0f36e 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -26,6 +26,23 @@
 
 #define INT_MUTEX				BIT(1)
 
+#define MT8186_MUTEX_MOD_DISP_OVL0		0
+#define MT8186_MUTEX_MOD_DISP_OVL0_2L 		1
+#define MT8186_MUTEX_MOD_DISP_RDMA0		2
+#define MT8186_MUTEX_MOD_DISP_COLOR0		4
+#define MT8186_MUTEX_MOD_DISP_CCORR0		5
+#define MT8186_MUTEX_MOD_DISP_AAL0		7
+#define MT8186_MUTEX_MOD_DISP_GAMMA0		8
+#define MT8186_MUTEX_MOD_DISP_POSTMASK0		9
+#define MT8186_MUTEX_MOD_DISP_DITHER0		10
+#define MT8186_MUTEX_MOD_DISP_RDMA1		17
+
+#define MT8186_MUTEX_SOF_SINGLE_MODE 0
+#define MT8186_MUTEX_SOF_DSI0 1
+#define MT8186_MUTEX_SOF_DPI0 2
+#define MT8186_MUTEX_EOF_DSI0 (MT8186_MUTEX_SOF_DSI0 << 6)
+#define MT8186_MUTEX_EOF_DPI0 (MT8186_MUTEX_SOF_DPI0 << 6)
+
 #define MT8167_MUTEX_MOD_DISP_PWM		1
 #define MT8167_MUTEX_MOD_DISP_OVL0		6
 #define MT8167_MUTEX_MOD_DISP_OVL1		7
@@ -226,6 +243,19 @@ static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
 };
 
+static const unsigned int mt8186_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL0] = MT8186_MUTEX_MOD_DISP_AAL0,
+	[DDP_COMPONENT_CCORR] = MT8186_MUTEX_MOD_DISP_CCORR0,
+	[DDP_COMPONENT_COLOR0] = MT8186_MUTEX_MOD_DISP_COLOR0,
+	[DDP_COMPONENT_DITHER] = MT8186_MUTEX_MOD_DISP_DITHER0,
+	[DDP_COMPONENT_GAMMA] = MT8186_MUTEX_MOD_DISP_GAMMA0,
+	[DDP_COMPONENT_OVL0] = MT8186_MUTEX_MOD_DISP_OVL0,
+	[DDP_COMPONENT_OVL_2L0] = MT8186_MUTEX_MOD_DISP_OVL0_2L,
+	[DDP_COMPONENT_POSTMASK0] = MT8186_MUTEX_MOD_DISP_POSTMASK0,
+	[DDP_COMPONENT_RDMA0] = MT8186_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MT8186_MUTEX_MOD_DISP_RDMA1,
+};
+
 static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8192_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8192_MUTEX_MOD_DISP_CCORR0,
@@ -264,6 +294,12 @@ static const unsigned int mt8183_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
 	[MUTEX_SOF_DPI0] = MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF_DPI0,
 };
 
+static const unsigned int mt8186_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
+	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
+	[MUTEX_SOF_DSI0] = MT8186_MUTEX_SOF_DSI0 | MT8186_MUTEX_EOF_DSI0,
+	[MUTEX_SOF_DPI0] = MT8186_MUTEX_SOF_DPI0 | MT8186_MUTEX_EOF_DPI0,
+};
+
 static const struct mtk_mutex_data mt2701_mutex_driver_data = {
 	.mutex_mod = mt2701_mutex_mod,
 	.mutex_sof = mt2712_mutex_sof,
@@ -301,6 +337,13 @@ static const struct mtk_mutex_data mt8183_mutex_driver_data = {
 	.no_clk = true,
 };
 
+static const struct mtk_mutex_data mt8186_mutex_driver_data = {
+	.mutex_mod = mt8186_mutex_mod,
+	.mutex_sof = mt8186_mutex_sof,
+	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
+	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
+};
+
 static const struct mtk_mutex_data mt8192_mutex_driver_data = {
 	.mutex_mod = mt8192_mutex_mod,
 	.mutex_sof = mt8183_mutex_sof,
@@ -540,6 +583,8 @@ static const struct of_device_id mutex_driver_dt_match[] = {
 	  .data = &mt8173_mutex_driver_data},
 	{ .compatible = "mediatek,mt8183-disp-mutex",
 	  .data = &mt8183_mutex_driver_data},
+	{ .compatible = "mediatek,mt8186-disp-mutex",
+	.data = &mt8186_mutex_driver_data},
 	{ .compatible = "mediatek,mt8192-disp-mutex",
 	  .data = &mt8192_mutex_driver_data},
 	{},
-- 
2.18.0

