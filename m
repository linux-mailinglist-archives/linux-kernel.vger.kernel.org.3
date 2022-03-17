Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4514DC0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiCQIY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiCQIYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:24:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213A91C64BB;
        Thu, 17 Mar 2022 01:23:07 -0700 (PDT)
X-UUID: db66793bf4a848ed995a6cef5470f9c6-20220317
X-UUID: db66793bf4a848ed995a6cef5470f9c6-20220317
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1947316613; Thu, 17 Mar 2022 16:23:01 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Mar 2022 16:23:00 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Mar
 2022 16:22:59 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 16:22:57 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3, 01/10] media: mtk-vcodec: Use core type to indicate h264 and vp8 enc
Date:   Thu, 17 Mar 2022 16:22:21 +0800
Message-ID: <20220317082230.23622-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317082230.23622-1-irui.wang@mediatek.com>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use core type variables to indicate h264 and vp8 encoder

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  4 +--
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  | 30 ++++++++++---------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index ea58f11e7659..3affb2d4a4ec 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -416,7 +416,7 @@ struct mtk_vcodec_dec_pdata {
  * @num_capture_formats: number of entries in capture_formats
  * @output_formats: array of supported output formats
  * @num_output_formats: number of entries in output_formats
- * @core_id: stand for h264 or vp8 encode index
+ * @core_type: stand for h264 or vp8 encode
  */
 struct mtk_vcodec_enc_pdata {
 	bool uses_ext;
@@ -426,7 +426,7 @@ struct mtk_vcodec_enc_pdata {
 	size_t num_capture_formats;
 	const struct mtk_video_fmt *output_formats;
 	size_t num_output_formats;
-	int core_id;
+	int core_type;
 };
 
 #define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata->uses_ext)
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 95e8c29ccc65..f12f887e4bdc 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -94,11 +94,13 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 	ctx = dev->curr_ctx;
 	spin_unlock_irqrestore(&dev->irqlock, flags);
 
-	mtk_v4l2_debug(1, "id=%d coreid:%d", ctx->id, dev->venc_pdata->core_id);
-	addr = dev->reg_base[dev->venc_pdata->core_id] +
+	mtk_v4l2_debug(1, "id: %d core type: %d",
+		       ctx->id, dev->venc_pdata->core_type);
+
+	addr = dev->reg_base[dev->venc_pdata->core_type] +
 				MTK_VENC_IRQ_ACK_OFFSET;
 
-	ctx->irq_status = readl(dev->reg_base[dev->venc_pdata->core_id] +
+	ctx->irq_status = readl(dev->reg_base[dev->venc_pdata->core_type] +
 				(MTK_VENC_IRQ_STATUS_OFFSET));
 
 	clean_irq_status(ctx->irq_status, addr);
@@ -265,10 +267,10 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	dev->reg_base[dev->venc_pdata->core_id] =
+	dev->reg_base[dev->venc_pdata->core_type] =
 		devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(dev->reg_base[dev->venc_pdata->core_id])) {
-		ret = PTR_ERR(dev->reg_base[dev->venc_pdata->core_id]);
+	if (IS_ERR(dev->reg_base[dev->venc_pdata->core_type])) {
+		ret = PTR_ERR(dev->reg_base[dev->venc_pdata->core_type]);
 		goto err_res;
 	}
 
@@ -286,8 +288,8 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 			       0, pdev->name, dev);
 	if (ret) {
 		dev_err(&pdev->dev,
-			"Failed to install dev->enc_irq %d (%d) core_id (%d)",
-			dev->enc_irq, ret, dev->venc_pdata->core_id);
+			"Failed to install dev->enc_irq %d (%d) core_type (%d)",
+			dev->enc_irq, ret, dev->venc_pdata->core_type);
 		ret = -EINVAL;
 		goto err_res;
 	}
@@ -356,7 +358,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	}
 
 	mtk_v4l2_debug(0, "encoder %d registered as /dev/video%d",
-		       dev->venc_pdata->core_id, vfd_enc->num);
+		       dev->venc_pdata->core_type, vfd_enc->num);
 
 	return 0;
 
@@ -382,7 +384,7 @@ static const struct mtk_vcodec_enc_pdata mt8173_avc_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 60000000,
-	.core_id = VENC_SYS,
+	.core_type = VENC_SYS,
 };
 
 static const struct mtk_vcodec_enc_pdata mt8173_vp8_pdata = {
@@ -392,7 +394,7 @@ static const struct mtk_vcodec_enc_pdata mt8173_vp8_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 9000000,
-	.core_id = VENC_LT_SYS,
+	.core_type = VENC_LT_SYS,
 };
 
 static const struct mtk_vcodec_enc_pdata mt8183_pdata = {
@@ -403,7 +405,7 @@ static const struct mtk_vcodec_enc_pdata mt8183_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 40000000,
-	.core_id = VENC_SYS,
+	.core_type = VENC_SYS,
 };
 
 static const struct mtk_vcodec_enc_pdata mt8192_pdata = {
@@ -414,7 +416,7 @@ static const struct mtk_vcodec_enc_pdata mt8192_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 100000000,
-	.core_id = VENC_SYS,
+	.core_type = VENC_SYS,
 };
 
 static const struct mtk_vcodec_enc_pdata mt8195_pdata = {
@@ -425,7 +427,7 @@ static const struct mtk_vcodec_enc_pdata mt8195_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 100000000,
-	.core_id = VENC_SYS,
+	.core_type = VENC_SYS,
 };
 
 static const struct of_device_id mtk_vcodec_enc_match[] = {
-- 
2.18.0

