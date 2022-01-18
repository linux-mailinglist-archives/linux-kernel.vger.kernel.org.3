Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2D492963
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242661AbiARPH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiARPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:07:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FEEC061574;
        Tue, 18 Jan 2022 07:07:26 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:5aac:9ca0:e459:1f09])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 094531F43FCF;
        Tue, 18 Jan 2022 15:07:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642518445;
        bh=kcrKD5Lb4gNWfTjfNnB/gFNCNh+zasxQp0W3HPwbaz0=;
        h=From:To:Cc:Subject:Date:From;
        b=DGAF/BR7fGDn8mG6BppEiTu3g4eO7nd/N7901D40JmjlHXP8s2AU804QYHmPXOSkc
         JsTU06IBE5hKL0L9Eb8T02BULIzirVylDOGndQg/H6/ZUWVfQFZk9GLBd8w3H1+wot
         fFRP1xDFK1R5ehrgfPeBS+W837CnWvlsjvWt9S/c2ZMyuxYCiDFpOPcrVYQzln2Tk7
         LIb2oH15UTwNTbTK4kulQOQMAToRMqrfiePaxEhwhMcNZcM7HbjYkMHE/IvJahSa08
         Cl37Z6HWc6kvWvt07UiMnZY+5Z//dShe02vWHyUKYpzIM1ow1DiPHp01gBjC/HNRO9
         +i25L23fssfMg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: platform: mtk-vcodec: Do not force /dev/videoX node number
Date:   Tue, 18 Jan 2022 16:07:17 +0100
Message-Id: <20220118150717.706074-1-benjamin.gaignard@collabora.com>
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

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
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

