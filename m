Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3F558EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiFXDKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiFXDKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:10:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52A933A1A;
        Thu, 23 Jun 2022 20:09:59 -0700 (PDT)
X-UUID: 601dd8a6ade942ad90d60828e69a8815-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:202146a0-943e-40dc-b494-6b85a4e36753,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:25
X-CID-META: VersionHash:b14ad71,CLOUDID:c5d05638-5e4b-44d7-80b2-bb618cb09d29,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:5,IP:nil,URL:1,File:nil,
        QS:nil,BEC:nil,COL:0
X-UUID: 601dd8a6ade942ad90d60828e69a8815-20220624
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1278335242; Fri, 24 Jun 2022 11:09:50 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 24 Jun 2022 11:09:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 24 Jun 2022 11:09:49 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <airlied@linux.ie>
CC:     <msp@baylibre.com>, <granquet@baylibre.com>,
        <jitao.shi@mediatek.com>, <wenst@chromium.org>,
        <angelogioacchino.delregno@collabora.com>, <ck.hu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v14 06/15] drm/mediatek: dpi: implement a swap_input toggle in SoC config
Date:   Fri, 24 Jun 2022 11:09:37 +0800
Message-ID: <20220624030946.14961-7-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220624030946.14961-1-rex-bc.chen@mediatek.com>
References: <20220624030946.14961-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Ranquet <granquet@baylibre.com>

The hardware design of dp_intf does not support input swap, so we add
a bit of flexibility to support SoCs without swap_input support.
We also add a warning message if the hardware is not supported and it
needs to swap input.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
[Bo-Chen: Add modification reason in commit message.]
Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index fc2ef10bef31..bacd6c13186f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -127,6 +127,7 @@ struct mtk_dpi_yc_limit {
  * @output_fmts: Array of supported output formats.
  * @num_output_fmts: Quantity of supported output formats.
  * @is_ck_de_pol: Support CK/DE polarity.
+ * @swap_input_support: Support input swap function.
  */
 struct mtk_dpi_conf {
 	unsigned int (*cal_factor)(int clock);
@@ -136,6 +137,7 @@ struct mtk_dpi_conf {
 	const u32 *output_fmts;
 	u32 num_output_fmts;
 	bool is_ck_de_pol;
+	bool swap_input_support;
 };
 
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
@@ -400,18 +402,24 @@ static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
 	    (format == MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
 		mtk_dpi_config_yuv422_enable(dpi, false);
 		mtk_dpi_config_csc_enable(dpi, true);
-		mtk_dpi_config_swap_input(dpi, false);
+		if (dpi->conf->swap_input_support)
+			mtk_dpi_config_swap_input(dpi, false);
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_BGR);
 	} else if ((format == MTK_DPI_COLOR_FORMAT_YCBCR_422) ||
 		   (format == MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
 		mtk_dpi_config_yuv422_enable(dpi, true);
 		mtk_dpi_config_csc_enable(dpi, true);
-		mtk_dpi_config_swap_input(dpi, true);
+		if (dpi->conf->swap_input_support)
+			mtk_dpi_config_swap_input(dpi, true);
+		else
+			dev_warn(dpi->dev,
+				 "Failed to swap input, hw is not supported.\n");
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_RGB);
 	} else {
 		mtk_dpi_config_yuv422_enable(dpi, false);
 		mtk_dpi_config_csc_enable(dpi, false);
-		mtk_dpi_config_swap_input(dpi, false);
+		if (dpi->conf->swap_input_support)
+			mtk_dpi_config_swap_input(dpi, false);
 		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_RGB);
 	}
 }
@@ -823,6 +831,7 @@ static const struct mtk_dpi_conf mt8173_conf = {
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 	.is_ck_de_pol = true,
+	.swap_input_support = true,
 };
 
 static const struct mtk_dpi_conf mt2701_conf = {
@@ -833,6 +842,7 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.output_fmts = mt8173_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
 	.is_ck_de_pol = true,
+	.swap_input_support = true,
 };
 
 static const struct mtk_dpi_conf mt8183_conf = {
@@ -842,6 +852,7 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.output_fmts = mt8183_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
 	.is_ck_de_pol = true,
+	.swap_input_support = true,
 };
 
 static const struct mtk_dpi_conf mt8192_conf = {
@@ -851,6 +862,7 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.output_fmts = mt8183_output_fmts,
 	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
 	.is_ck_de_pol = true,
+	.swap_input_support = true,
 };
 
 static int mtk_dpi_probe(struct platform_device *pdev)
-- 
2.18.0

