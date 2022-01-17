Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1149082F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbiAQMGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:06:34 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48172 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239553AbiAQMGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:06:31 -0500
X-UUID: eb5967ebca764f93bd260b5c256daf8e-20220117
X-UUID: eb5967ebca764f93bd260b5c256daf8e-20220117
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1679302506; Mon, 17 Jan 2022 20:06:28 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Jan 2022 20:06:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 Jan
 2022 20:06:26 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 20:06:25 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>
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
Subject: [PATCH v2, 01/10] media: mtk-vcodec: Use core type to indicate h264 and vp8 enc
Date:   Mon, 17 Jan 2022 20:06:06 +0800
Message-ID: <20220117120615.21687-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117120615.21687-1-irui.wang@mediatek.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
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
index cd2939b47790..f78463ff4551 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -419,7 +419,7 @@ struct mtk_vcodec_dec_pdata {
  * @num_capture_formats: number of entries in capture_formats
  * @output_formats: array of supported output formats
  * @num_output_formats: number of entries in output_formats
- * @core_id: stand for h264 or vp8 encode index
+ * @core_type: stand for h264 or vp8 encode
  */
 struct mtk_vcodec_enc_pdata {
 	bool uses_ext;
@@ -429,7 +429,7 @@ struct mtk_vcodec_enc_pdata {
 	size_t num_capture_formats;
 	const struct mtk_video_fmt *output_formats;
 	size_t num_output_formats;
-	int core_id;
+	int core_type;
 };
 
 #define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata->uses_ext)
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 3ac6969c54c0..1f950310a3fb 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -95,11 +95,13 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
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
@@ -266,10 +268,10 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
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
 
@@ -287,8 +289,8 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
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
@@ -357,7 +359,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	}
 
 	mtk_v4l2_debug(0, "encoder %d registered as /dev/video%d",
-		       dev->venc_pdata->core_id, vfd_enc->num);
+		       dev->venc_pdata->core_type, vfd_enc->num);
 
 	return 0;
 
@@ -384,7 +386,7 @@ static const struct mtk_vcodec_enc_pdata mt8173_avc_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 60000000,
-	.core_id = VENC_SYS,
+	.core_type = VENC_SYS,
 };
 
 static const struct mtk_vcodec_enc_pdata mt8173_vp8_pdata = {
@@ -394,7 +396,7 @@ static const struct mtk_vcodec_enc_pdata mt8173_vp8_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 9000000,
-	.core_id = VENC_LT_SYS,
+	.core_type = VENC_LT_SYS,
 };
 
 static const struct mtk_vcodec_enc_pdata mt8183_pdata = {
@@ -405,7 +407,7 @@ static const struct mtk_vcodec_enc_pdata mt8183_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 40000000,
-	.core_id = VENC_SYS,
+	.core_type = VENC_SYS,
 };
 
 static const struct mtk_vcodec_enc_pdata mt8192_pdata = {
@@ -416,7 +418,7 @@ static const struct mtk_vcodec_enc_pdata mt8192_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 100000000,
-	.core_id = VENC_SYS,
+	.core_type = VENC_SYS,
 };
 
 static const struct mtk_vcodec_enc_pdata mt8195_pdata = {
@@ -427,7 +429,7 @@ static const struct mtk_vcodec_enc_pdata mt8195_pdata = {
 	.num_output_formats = ARRAY_SIZE(mtk_video_formats_output),
 	.min_bitrate = 64,
 	.max_bitrate = 100000000,
-	.core_id = VENC_SYS,
+	.core_type = VENC_SYS,
 };
 
 static const struct of_device_id mtk_vcodec_enc_match[] = {
-- 
2.18.0

