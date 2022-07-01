Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE80562A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiGAEAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiGAD7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 23:59:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83728677FC;
        Thu, 30 Jun 2022 20:58:58 -0700 (PDT)
X-UUID: 329a145a47064f5b866499363a7d31e7-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:cb9e2510-eeb1-4e98-870e-d3424c8525bd,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:30
X-CID-META: VersionHash:87442a2,CLOUDID:e8d61e63-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:5,IP:nil,URL:1,File:nil,
        QS:nil,BEC:nil,COL:0
X-UUID: 329a145a47064f5b866499363a7d31e7-20220701
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2075274232; Fri, 01 Jul 2022 11:58:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 1 Jul 2022 11:58:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 1 Jul 2022 11:58:47 +0800
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
Subject: [PATCH v15 05/16] drm/mediatek: dpi: Add support for quantization range
Date:   Fri, 1 Jul 2022 11:58:34 +0800
Message-ID: <20220701035845.16458-6-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220701035845.16458-1-rex-bc.chen@mediatek.com>
References: <20220701035845.16458-1-rex-bc.chen@mediatek.com>
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

For RGB colorimetry, CTA-861 support both limited and full range data
when receiving video with RGB color space.
We use drm_default_rgb_quant_range() to determine the correct setting.

Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 34 ++++++++++++++++++------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 3473ee18ad97..0855bbdfe4e1 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -238,16 +238,30 @@ static void mtk_dpi_config_fb_size(struct mtk_dpi *dpi, u32 width, u32 height)
 	mtk_dpi_mask(dpi, DPI_SIZE, height << VSIZE, VSIZE_MASK);
 }
 
-static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi,
-					 struct mtk_dpi_yc_limit *limit)
+static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi)
 {
-	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_bottom << Y_LIMINT_BOT,
+	struct mtk_dpi_yc_limit limit;
+
+	if (drm_default_rgb_quant_range(&dpi->mode) ==
+	    HDMI_QUANTIZATION_RANGE_LIMITED) {
+		limit.y_bottom = 0x10;
+		limit.y_top = 0xfe0;
+		limit.c_bottom = 0x10;
+		limit.c_top = 0xfe0;
+	} else {
+		limit.y_bottom = 0;
+		limit.y_top = 0xfff;
+		limit.c_bottom = 0;
+		limit.c_top = 0xfff;
+	}
+
+	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit.y_bottom << Y_LIMINT_BOT,
 		     Y_LIMINT_BOT_MASK);
-	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_top << Y_LIMINT_TOP,
+	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit.y_top << Y_LIMINT_TOP,
 		     Y_LIMINT_TOP_MASK);
-	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit->c_bottom << C_LIMIT_BOT,
+	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit.c_bottom << C_LIMIT_BOT,
 		     C_LIMIT_BOT_MASK);
-	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit->c_top << C_LIMIT_TOP,
+	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit.c_top << C_LIMIT_TOP,
 		     C_LIMIT_TOP_MASK);
 }
 
@@ -439,7 +453,6 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 				    struct drm_display_mode *mode)
 {
-	struct mtk_dpi_yc_limit limit;
 	struct mtk_dpi_polarities dpi_pol;
 	struct mtk_dpi_sync_param hsync;
 	struct mtk_dpi_sync_param vsync_lodd = { 0 };
@@ -474,11 +487,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
 		pll_rate, vm.pixelclock);
 
-	limit.c_bottom = 0x0010;
-	limit.c_top = 0x0FE0;
-	limit.y_bottom = 0x0010;
-	limit.y_top = 0x0FE0;
-
 	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
 	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
 	dpi_pol.hsync_pol = vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ?
@@ -526,7 +534,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	else
 		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive);
 
-	mtk_dpi_config_channel_limit(dpi, &limit);
+	mtk_dpi_config_channel_limit(dpi);
 	mtk_dpi_config_bit_num(dpi, dpi->bit_num);
 	mtk_dpi_config_channel_swap(dpi, dpi->channel_swap);
 	mtk_dpi_config_yc_map(dpi, dpi->yc_map);
-- 
2.18.0

