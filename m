Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A823C494A36
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358903AbiATI7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:59:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59158 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiATI7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:59:18 -0500
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:3368:5e43:a228:ee75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 668331F44C70;
        Thu, 20 Jan 2022 08:59:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642669156;
        bh=70J/M3Mn2wuN/O5yaZDjpp/xB3BHC/zkHmIcZktdScY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZO8Jmz4j0cx8AicUqq06pX/TskR7JHRp/Q1GVsO9dQou6RdjZ79D8dDzmeBKhXD6R
         cRrLyTQC1rBbV2kYb61ZWuP4kxkgY39mpa+8M4zz+n24Lbz1BcvWOEoOh/JDubO7Im
         3mh765ifD5U/1ch+i/uyY7bD6drbjTz3LvACB/pgwvzvFAnUjUe20e4Uk1bDy9+VJd
         N7wXwUCFU1teeNPJeZKEvzaAaJBFE3hGh4SwKp6Uhp+krOCvWbnBpT4qkLOEyu/9+h
         57IHZCu2wK9AMTdWI++wbVJJ0c8L/Mi03LQDfP+kjA8Mzn3SmYO+lsPQd6ZcR9X3Xh
         n/N9teIDupRxA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] media: platform: mtk-vcodec: Do not force /dev/videoX node number
Date:   Thu, 20 Jan 2022 09:59:09 +0100
Message-Id: <20220120085909.103886-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's v4l2 framework use a free /dev/videoX node for decode and encoder.
For the decoder call video_register_device() before register the media
controller device so the mapping between ins correctly done.
Since the registering sequence has changed rework exiting errors case too.

Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")
Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
version 2:
 - add Fixes and Reviewed-by tags as suggested by Angelo
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  | 27 +++++++++----------
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  2 +-
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index 86b639d82be8..a4a3f9631d04 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -374,7 +374,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	if (IS_ERR((__force void *)dev->m2m_dev_dec)) {
 		mtk_v4l2_err("Failed to init mem2mem dec device");
 		ret = PTR_ERR((__force void *)dev->m2m_dev_dec);
-		goto err_dec_mem_init;
+		goto err_dec_alloc;
 	}
 
 	dev->decode_workqueue =
@@ -391,10 +391,16 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 					   &pdev->dev);
 		if (ret) {
 			mtk_v4l2_err("Main device of_platform_populate failed.");
-			goto err_event_workq;
+			goto err_reg_cont;
 		}
 	}
 
+	ret = video_register_device(vfd_dec, VFL_TYPE_VIDEO, -1);
+	if (ret) {
+		mtk_v4l2_err("Failed to register video device");
+		goto err_reg_cont;
+	}
+
 	if (dev->vdec_pdata->uses_stateless_api) {
 		dev->mdev_dec.dev = &pdev->dev;
 		strscpy(dev->mdev_dec.model, MTK_VCODEC_DEC_NAME,
@@ -408,7 +414,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 							 MEDIA_ENT_F_PROC_VIDEO_DECODER);
 		if (ret) {
 			mtk_v4l2_err("Failed to register media controller");
-			goto err_reg_cont;
+			goto err_dec_mem_init;
 		}
 
 		ret = media_device_register(&dev->mdev_dec);
@@ -419,30 +425,21 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 
 		mtk_v4l2_debug(0, "media registered as /dev/media%d", vfd_dec->minor);
 	}
-	ret = video_register_device(vfd_dec, VFL_TYPE_VIDEO, 0);
-	if (ret) {
-		mtk_v4l2_err("Failed to register video device");
-		goto err_dec_reg;
-	}
 
 	mtk_v4l2_debug(0, "decoder registered as /dev/video%d", vfd_dec->minor);
 
 	return 0;
 
-err_dec_reg:
-	if (dev->vdec_pdata->uses_stateless_api)
-		media_device_unregister(&dev->mdev_dec);
 err_media_reg:
-	if (dev->vdec_pdata->uses_stateless_api)
-		v4l2_m2m_unregister_media_controller(dev->m2m_dev_dec);
+	v4l2_m2m_unregister_media_controller(dev->m2m_dev_dec);
+err_dec_mem_init:
+	video_unregister_device(vfd_dec);
 err_reg_cont:
 	if (dev->vdec_pdata->uses_stateless_api)
 		media_device_cleanup(&dev->mdev_dec);
 	destroy_workqueue(dev->decode_workqueue);
 err_event_workq:
 	v4l2_m2m_release(dev->m2m_dev_dec);
-err_dec_mem_init:
-	video_unregister_device(vfd_dec);
 err_dec_alloc:
 	v4l2_device_unregister(&dev->v4l2_dev);
 err_core_workq:
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index 507ad1ea2104..3975613b75b3 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -350,7 +350,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL))
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
 
-	ret = video_register_device(vfd_enc, VFL_TYPE_VIDEO, 1);
+	ret = video_register_device(vfd_enc, VFL_TYPE_VIDEO, -1);
 	if (ret) {
 		mtk_v4l2_err("Failed to register video device");
 		goto err_enc_reg;
-- 
2.30.2

