Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510544C41D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiBYJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiBYJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:54:41 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C677254544
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:54:09 -0800 (PST)
X-UUID: b6ddab556d1f422484d9e515e4cee17e-20220225
X-UUID: b6ddab556d1f422484d9e515e4cee17e-20220225
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2068206144; Fri, 25 Feb 2022 17:54:04 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 25 Feb 2022 17:54:03 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Feb
 2022 17:54:02 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 25 Feb 2022 17:54:01 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, <allen-kh.cheng@mediatek.com>,
        <rex-bc.chen@mediatek.com>, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v1,2/3] drm/mediatek: Add TOPCKGEN select mux control dpi_clk
Date:   Fri, 25 Feb 2022 17:53:52 +0800
Message-ID: <1645782833-27875-3-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1645782833-27875-1-git-send-email-xinlei.lee@mediatek.com>
References: <1645782833-27875-1-git-send-email-xinlei.lee@mediatek.com>
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

From: Xinlei Lee <xinlei.lee@mediatek.com>

Dpi_clk is controlled by the mux selected
by TOPCKGEN and APMIXEDSYS can support small resolution.

Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 38 ++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 4554e2de1430..bad686817e29 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -63,6 +63,14 @@ enum mtk_dpi_out_color_format {
 	MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL
 };
 
+enum TVDPLL_CLK {
+	TVDPLL_PLL = 0,
+	TVDPLL_D2 = 2,
+	TVDPLL_D4 = 4,
+	TVDPLL_D8 = 8,
+	TVDPLL_D16 = 16,
+};
+
 struct mtk_dpi {
 	struct drm_encoder encoder;
 	struct drm_bridge bridge;
@@ -73,6 +81,7 @@ struct mtk_dpi {
 	struct clk *engine_clk;
 	struct clk *pixel_clk;
 	struct clk *tvd_clk;
+	struct clk *pclk_src[5];
 	int irq;
 	struct drm_display_mode mode;
 	const struct mtk_dpi_conf *conf;
@@ -459,6 +468,7 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	struct videomode vm = { 0 };
 	unsigned long pll_rate;
 	unsigned int factor;
+	struct clk *clksrc = NULL;
 
 	/* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
 	factor = dpi->conf->cal_factor(mode->clock);
@@ -473,11 +483,26 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 
 	vm.pixelclock = pll_rate / factor;
 	if ((dpi->output_fmt == MEDIA_BUS_FMT_RGB888_2X12_LE) ||
-	    (dpi->output_fmt == MEDIA_BUS_FMT_RGB888_2X12_BE))
-		clk_set_rate(dpi->pixel_clk, vm.pixelclock * 2);
-	else
-		clk_set_rate(dpi->pixel_clk, vm.pixelclock);
+	    (dpi->output_fmt == MEDIA_BUS_FMT_RGB888_2X12_BE)) {
+		if (factor == 8)
+			clksrc = dpi->pclk_src[2];
+		else if (factor == 4)
+			clksrc = dpi->pclk_src[1];
+		else
+			clksrc = dpi->pclk_src[1];
+		}
+	else {
+		if (factor == 8)
+			clksrc = dpi->pclk_src[3];
+		else if (factor == 4)
+			clksrc = dpi->pclk_src[2];
+		else
+			clksrc = dpi->pclk_src[2];
+	}
 
+	clk_prepare_enable(dpi->pixel_clk);
+	clk_set_parent(dpi->pixel_clk, clksrc);
+	clk_disable_unprepare(dpi->pixel_clk);
 
 	vm.pixelclock = clk_get_rate(dpi->pixel_clk);
 
@@ -893,6 +918,11 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dpi->pclk_src[1] = devm_clk_get_optional(dev, "tvdpll_d2");
+	dpi->pclk_src[2] = devm_clk_get_optional(dev, "tvdpll_d4");
+	dpi->pclk_src[3] = devm_clk_get_optional(dev, "tvdpll_d8");
+	dpi->pclk_src[4] = devm_clk_get_optional(dev, "tvdpll_d16");
+
 	dpi->irq = platform_get_irq(pdev, 0);
 	if (dpi->irq <= 0)
 		return -EINVAL;
-- 
2.18.0

