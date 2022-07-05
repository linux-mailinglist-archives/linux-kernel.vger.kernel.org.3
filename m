Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD85667E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiGEK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiGEKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:25:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202DA2AC3;
        Tue,  5 Jul 2022 03:25:41 -0700 (PDT)
X-UUID: 443a77fc714a46e48ff617db64538ef4-20220705
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:72fa5360-ef72-4550-8bff-0c7b1ea22e5d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:36eea7d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 443a77fc714a46e48ff617db64538ef4-20220705
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1788566286; Tue, 05 Jul 2022 18:25:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 5 Jul 2022 18:25:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 5 Jul 2022 18:25:33 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>, <ck.hu@mediatek.com>,
        <xinlei.lee@mediatek.com>, <liangxu.xu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v16 5/5] drm/mediatek: dpi: Add dp_intf support
Date:   Tue, 5 Jul 2022 18:25:30 +0800
Message-ID: <20220705102530.1344-6-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220705102530.1344-1-rex-bc.chen@mediatek.com>
References: <20220705102530.1344-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Ranquet <granquet@baylibre.com>

Dpintf is the displayport interface hardware unit. This unit is similar
to dpi and can reuse most of the code.

This patch adds support for mt8195-dpintf to this dpi driver. Main
differences are:
 - 4 pixels for one iteration for dp_intf while dpi is 1 pixel for one
   iteration. Therefore, we add a new config "pixels_per_iter" to control
   quantity of transferred pixels per iteration.
 - Input of dp_intf is two pixels per iteration, so we add a new config
   "input_2pixel" to control this.
 - Some register contents differ slightly between the two components. To
   work around this I added register bits/masks with a DPINTF_ prefix
   and use them where different.

Based on a separate driver for dpintf created by
Jitao shi <jitao.shi@mediatek.com>.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c          | 32 +++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h     | 11 +++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  4 +++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  3 ++
 5 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 5f71a68c6a0b..c176d2041eca 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -853,6 +853,16 @@ static unsigned int mt8183_calculate_factor(int clock)
 		return 2;
 }
 
+static unsigned int mt8195_dpintf_calculate_factor(int clock)
+{
+	if (clock < 70000)
+		return 4;
+	else if (clock < 200000)
+		return 2;
+	else
+		return 1;
+}
+
 static const u32 mt8173_output_fmts[] = {
 	MEDIA_BUS_FMT_RGB888_1X24,
 };
@@ -862,6 +872,11 @@ static const u32 mt8183_output_fmts[] = {
 	MEDIA_BUS_FMT_RGB888_2X12_BE,
 };
 
+static const u32 mt8195_output_fmts[] = {
+	MEDIA_BUS_FMT_RGB888_1X24,
+	MEDIA_BUS_FMT_YUYV8_1X16,
+};
+
 static const struct mtk_dpi_conf mt8173_conf = {
 	.cal_factor = mt8173_calculate_factor,
 	.reg_h_fre_con = 0xe0,
@@ -931,6 +946,20 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.csc_enable_bit = CSC_ENABLE,
 };
 
+static const struct mtk_dpi_conf mt8195_dpintf_conf = {
+	.cal_factor = mt8195_dpintf_calculate_factor,
+	.max_clock_khz = 600000,
+	.output_fmts = mt8195_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8195_output_fmts),
+	.pixels_per_iter = 4,
+	.input_2pixel = true,
+	.dimension_mask = DPINTF_HPW_MASK,
+	.hvsize_mask = DPINTF_HSIZE_MASK,
+	.channel_swap_shift = DPINTF_CH_SWAP,
+	.yuv422_en_bit = DPINTF_YUV422_EN,
+	.csc_enable_bit = DPINTF_CSC_ENABLE,
+};
+
 static int mtk_dpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1053,6 +1082,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
 	{ .compatible = "mediatek,mt8192-dpi",
 	  .data = &mt8192_conf,
 	},
+	{ .compatible = "mediatek,mt8195-dp-intf",
+	  .data = &mt8195_dpintf_conf,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
index 305066577d41..62bd4931b344 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
@@ -40,10 +40,13 @@
 #define FAKE_DE_LEVEN			BIT(21)
 #define FAKE_DE_RODD			BIT(22)
 #define FAKE_DE_REVEN			BIT(23)
+#define DPINTF_YUV422_EN		BIT(24)
+#define DPINTF_CSC_ENABLE		BIT(26)
 #define DPINTF_INPUT_2P_EN		BIT(29)
 
 #define DPI_OUTPUT_SETTING	0x14
 #define CH_SWAP				0
+#define DPINTF_CH_SWAP			1
 #define CH_SWAP_MASK			(0x7 << 0)
 #define SWAP_RGB			0x00
 #define SWAP_GBR			0x01
@@ -81,8 +84,10 @@
 #define DPI_SIZE		0x18
 #define HSIZE				0
 #define HSIZE_MASK			(0x1FFF << 0)
+#define DPINTF_HSIZE_MASK		(0xFFFF << 0)
 #define VSIZE				16
 #define VSIZE_MASK			(0x1FFF << 16)
+#define DPINTF_VSIZE_MASK		(0xFFFF << 16)
 
 #define DPI_DDR_SETTING		0x1C
 #define DDR_EN				BIT(0)
@@ -94,24 +99,30 @@
 #define DPI_TGEN_HWIDTH		0x20
 #define HPW				0
 #define HPW_MASK			(0xFFF << 0)
+#define DPINTF_HPW_MASK			(0xFFFF << 0)
 
 #define DPI_TGEN_HPORCH		0x24
 #define HBP				0
 #define HBP_MASK			(0xFFF << 0)
+#define DPINTF_HBP_MASK			(0xFFFF << 0)
 #define HFP				16
 #define HFP_MASK			(0xFFF << 16)
+#define DPINTF_HFP_MASK			(0xFFFF << 16)
 
 #define DPI_TGEN_VWIDTH		0x28
 #define DPI_TGEN_VPORCH		0x2C
 
 #define VSYNC_WIDTH_SHIFT		0
 #define VSYNC_WIDTH_MASK		(0xFFF << 0)
+#define DPINTF_VSYNC_WIDTH_MASK		(0xFFFF << 0)
 #define VSYNC_HALF_LINE_SHIFT		16
 #define VSYNC_HALF_LINE_MASK		BIT(16)
 #define VSYNC_BACK_PORCH_SHIFT		0
 #define VSYNC_BACK_PORCH_MASK		(0xFFF << 0)
+#define DPINTF_VSYNC_BACK_PORCH_MASK	(0xFFFF << 0)
 #define VSYNC_FRONT_PORCH_SHIFT		16
 #define VSYNC_FRONT_PORCH_MASK		(0xFFF << 16)
+#define DPINTF_VSYNC_FRONT_PORCH_MASK	(0xFFFF << 16)
 
 #define DPI_BG_HCNTL		0x30
 #define BG_RIGHT			(0x1FFF << 0)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 2aab1e1eda36..5bef085714a1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -427,6 +427,7 @@ static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_RDMA] = "rdma",
 	[MTK_DISP_UFOE] = "ufoe",
 	[MTK_DISP_WDMA] = "wdma",
+	[MTK_DP_INTF] = "dp-intf",
 	[MTK_DPI] = "dpi",
 	[MTK_DSI] = "dsi",
 };
@@ -450,6 +451,8 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_DRM_ID_MAX]
 	[DDP_COMPONENT_DRM_OVL_ADAPTOR]	= { MTK_DISP_OVL_ADAPTOR,	0, &ddp_ovl_adaptor },
 	[DDP_COMPONENT_DSC0]		= { MTK_DISP_DSC,		0, &ddp_dsc },
 	[DDP_COMPONENT_DSC1]		= { MTK_DISP_DSC,		1, &ddp_dsc },
+	[DDP_COMPONENT_DP_INTF0]	= { MTK_DP_INTF,		0, &ddp_dpi },
+	[DDP_COMPONENT_DP_INTF1]	= { MTK_DP_INTF,		1, &ddp_dpi },
 	[DDP_COMPONENT_DSI0]		= { MTK_DSI,			0, &ddp_dsi },
 	[DDP_COMPONENT_DSI1]		= { MTK_DSI,			1, &ddp_dsi },
 	[DDP_COMPONENT_DSI2]		= { MTK_DSI,			2, &ddp_dsi },
@@ -575,6 +578,7 @@ int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
 	    type == MTK_DISP_PWM ||
 	    type == MTK_DISP_RDMA ||
 	    type == MTK_DPI ||
+	    type == MTK_DP_INTF ||
 	    type == MTK_DSI)
 		return 0;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index af9a6671f9c4..3084cc4e2830 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -38,6 +38,7 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_UFOE,
 	MTK_DISP_WDMA,
 	MTK_DPI,
+	MTK_DP_INTF,
 	MTK_DSI,
 	MTK_DDP_COMP_TYPE_MAX,
 };
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 78e79c8449c8..a7a0dbbca823 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -788,6 +788,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8192-dpi",
 	  .data = (void *)MTK_DPI },
+	{ .compatible = "mediatek,mt8195-dp-intf",
+	  .data = (void *)MTK_DP_INTF },
 	{ .compatible = "mediatek,mt2701-dsi",
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",
@@ -931,6 +933,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 		    comp_type == MTK_DISP_OVL_2L ||
 		    comp_type == MTK_DISP_OVL_ADAPTOR ||
 		    comp_type == MTK_DISP_RDMA ||
+		    comp_type == MTK_DP_INTF ||
 		    comp_type == MTK_DPI ||
 		    comp_type == MTK_DSI) {
 			dev_info(dev, "Adding component match for %pOF\n",
-- 
2.18.0

