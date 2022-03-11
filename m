Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4DA4D63B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349578AbiCKOhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349475AbiCKOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:16 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7661C8DBF;
        Fri, 11 Mar 2022 06:36:08 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EE8EF240002;
        Fri, 11 Mar 2022 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsBwGN1uf0jcNWm9wWfOkpdN1on6MEqkVQujmTVNRO0=;
        b=DnYb0X0bUo+cnkpY5ntO/Rir9o9KYCgbghuJRchQLDN+UqB+Fw8T/6s++a1ZIdresI2srl
        Lmm8KobsY+nKd2QmzmaIf5KpXVrgtMCRnYeVIat7kfQA8iWnKWuAwZFU61d8av7Ykds+m3
        FEjj4FI3LzEyZurZOXiOWfmdKc66h8yf74+pC6QmTbOZ0S9quSD+twsB1puU2RzVsf6B55
        7oHYWeutOlUauurJzyc0VoZNJx7PS+qNopXChj9cKL/davOqjTCQ1H2LnLpA81/4+YBMa2
        TY947XWcUrQ7hFVYmRgwsmq8b5JvGekniwmk1IG56aCWlrWJvV9l5TWQc4oLgQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v3 11/46] media: sun6i-csi: Pass and store csi device directly in video code
Date:   Fri, 11 Mar 2022 15:34:57 +0100
Message-Id: <20220311143532.265091-12-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The video structure is part of the main csi device structure, so pass
pointers to that top-level structure directly. This makes it easier to
navigate and access other elements. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  8 +-
 .../platform/sunxi/sun6i-csi/sun6i_video.c    | 91 ++++++++++---------
 .../platform/sunxi/sun6i-csi/sun6i_video.h    |  9 +-
 3 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 6c031766a77a..99b2cf5fe184 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -708,7 +708,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 
 	/* Video */
 
-	ret = sun6i_video_setup(&csi_dev->video, csi_dev);
+	ret = sun6i_video_setup(csi_dev);
 	if (ret)
 		goto error_v4l2_device;
 
@@ -737,7 +737,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 	v4l2_async_nf_cleanup(notifier);
 
 error_video:
-	sun6i_video_cleanup(&csi_dev->video);
+	sun6i_video_cleanup(csi_dev);
 
 error_v4l2_device:
 	v4l2_device_unregister(&v4l2->v4l2_dev);
@@ -758,7 +758,7 @@ static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
 	media_device_unregister(&v4l2->media_dev);
 	v4l2_async_nf_unregister(&v4l2->notifier);
 	v4l2_async_nf_cleanup(&v4l2->notifier);
-	sun6i_video_cleanup(&csi_dev->video);
+	sun6i_video_cleanup(csi_dev);
 	v4l2_device_unregister(&v4l2->v4l2_dev);
 	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
 	media_device_cleanup(&v4l2->media_dev);
@@ -789,7 +789,7 @@ static irqreturn_t sun6i_csi_isr(int irq, void *private)
 	}
 
 	if (status & CSI_CH_INT_STA_FD_PD)
-		sun6i_video_frame_done(&csi_dev->video);
+		sun6i_video_frame_done(csi_dev);
 
 	regmap_write(regmap, CSI_CH_INT_STA_REG, status);
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 427b23184a15..178dddb0eaf1 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -100,7 +100,8 @@ static int sun6i_video_queue_setup(struct vb2_queue *queue,
 				   unsigned int sizes[],
 				   struct device *alloc_devs[])
 {
-	struct sun6i_video *video = vb2_get_drv_priv(queue);
+	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
+	struct sun6i_video *video = &csi_dev->video;
 	unsigned int size = video->format.fmt.pix.sizeimage;
 
 	if (*planes_count)
@@ -114,8 +115,8 @@ static int sun6i_video_queue_setup(struct vb2_queue *queue,
 
 static int sun6i_video_buffer_prepare(struct vb2_buffer *buffer)
 {
-	struct sun6i_video *video = vb2_get_drv_priv(buffer->vb2_queue);
-	struct sun6i_csi_device *csi_dev = video->csi_dev;
+	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(buffer->vb2_queue);
+	struct sun6i_video *video = &csi_dev->video;
 	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
 	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
 	struct sun6i_csi_buffer *csi_buffer =
@@ -138,7 +139,8 @@ static int sun6i_video_buffer_prepare(struct vb2_buffer *buffer)
 
 static void sun6i_video_buffer_queue(struct vb2_buffer *buffer)
 {
-	struct sun6i_video *video = vb2_get_drv_priv(buffer->vb2_queue);
+	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(buffer->vb2_queue);
+	struct sun6i_video *video = &csi_dev->video;
 	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
 	struct sun6i_csi_buffer *csi_buffer =
 		container_of(v4l2_buffer, struct sun6i_csi_buffer, v4l2_buffer);
@@ -153,7 +155,8 @@ static void sun6i_video_buffer_queue(struct vb2_buffer *buffer)
 static int sun6i_video_start_streaming(struct vb2_queue *queue,
 				       unsigned int count)
 {
-	struct sun6i_video *video = vb2_get_drv_priv(queue);
+	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
+	struct sun6i_video *video = &csi_dev->video;
 	struct video_device *video_dev = &video->video_dev;
 	struct sun6i_csi_buffer *buf;
 	struct sun6i_csi_buffer *next_buf;
@@ -185,7 +188,7 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 	config.width = video->format.fmt.pix.width;
 	config.height = video->format.fmt.pix.height;
 
-	ret = sun6i_csi_update_config(video->csi_dev, &config);
+	ret = sun6i_csi_update_config(csi_dev, &config);
 	if (ret < 0)
 		goto error_media_pipeline;
 
@@ -194,9 +197,9 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 	buf = list_first_entry(&video->dma_queue,
 			       struct sun6i_csi_buffer, list);
 	buf->queued_to_csi = true;
-	sun6i_csi_update_buf_addr(video->csi_dev, buf->dma_addr);
+	sun6i_csi_update_buf_addr(csi_dev, buf->dma_addr);
 
-	sun6i_csi_set_stream(video->csi_dev, true);
+	sun6i_csi_set_stream(csi_dev, true);
 
 	/*
 	 * CSI will lookup the next dma buffer for next frame before the
@@ -217,7 +220,7 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 	 */
 	next_buf = list_next_entry(buf, list);
 	next_buf->queued_to_csi = true;
-	sun6i_csi_update_buf_addr(video->csi_dev, next_buf->dma_addr);
+	sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
 
 	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
 
@@ -228,7 +231,7 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 	return 0;
 
 error_stream:
-	sun6i_csi_set_stream(video->csi_dev, false);
+	sun6i_csi_set_stream(csi_dev, false);
 
 error_media_pipeline:
 	media_pipeline_stop(&video_dev->entity);
@@ -246,7 +249,8 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 
 static void sun6i_video_stop_streaming(struct vb2_queue *queue)
 {
-	struct sun6i_video *video = vb2_get_drv_priv(queue);
+	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
+	struct sun6i_video *video = &csi_dev->video;
 	struct v4l2_subdev *subdev;
 	unsigned long flags;
 	struct sun6i_csi_buffer *buf;
@@ -255,7 +259,7 @@ static void sun6i_video_stop_streaming(struct vb2_queue *queue)
 	if (subdev)
 		v4l2_subdev_call(subdev, video, s_stream, 0);
 
-	sun6i_csi_set_stream(video->csi_dev, false);
+	sun6i_csi_set_stream(csi_dev, false);
 
 	media_pipeline_stop(&video->video_dev.entity);
 
@@ -267,8 +271,9 @@ static void sun6i_video_stop_streaming(struct vb2_queue *queue)
 	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
 }
 
-void sun6i_video_frame_done(struct sun6i_video *video)
+void sun6i_video_frame_done(struct sun6i_csi_device *csi_dev)
 {
+	struct sun6i_video *video = &csi_dev->video;
 	struct sun6i_csi_buffer *buf;
 	struct sun6i_csi_buffer *next_buf;
 	struct vb2_v4l2_buffer *v4l2_buffer;
@@ -278,7 +283,7 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 	buf = list_first_entry(&video->dma_queue,
 			       struct sun6i_csi_buffer, list);
 	if (list_is_last(&buf->list, &video->dma_queue)) {
-		dev_dbg(video->csi_dev->dev, "Frame dropped!\n");
+		dev_dbg(csi_dev->dev, "Frame dropped!\n");
 		goto complete;
 	}
 
@@ -290,8 +295,8 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 	 */
 	if (!next_buf->queued_to_csi) {
 		next_buf->queued_to_csi = true;
-		sun6i_csi_update_buf_addr(video->csi_dev, next_buf->dma_addr);
-		dev_dbg(video->csi_dev->dev, "Frame dropped!\n");
+		sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
+		dev_dbg(csi_dev->dev, "Frame dropped!\n");
 		goto complete;
 	}
 
@@ -305,9 +310,9 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 	if (!list_is_last(&next_buf->list, &video->dma_queue)) {
 		next_buf = list_next_entry(next_buf, list);
 		next_buf->queued_to_csi = true;
-		sun6i_csi_update_buf_addr(video->csi_dev, next_buf->dma_addr);
+		sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
 	} else {
-		dev_dbg(video->csi_dev->dev, "Next frame will be dropped!\n");
+		dev_dbg(csi_dev->dev, "Next frame will be dropped!\n");
 	}
 
 complete:
@@ -330,9 +335,8 @@ static const struct vb2_ops sun6i_video_queue_ops = {
 static int sun6i_video_querycap(struct file *file, void *private,
 			   struct v4l2_capability *capability)
 {
-	struct sun6i_video *video = video_drvdata(file);
-	struct sun6i_csi_device *csi_dev = video->csi_dev;
-	struct video_device *video_dev = &video->video_dev;
+	struct sun6i_csi_device *csi_dev = video_drvdata(file);
+	struct video_device *video_dev = &csi_dev->video.video_dev;
 
 	strscpy(capability->driver, SUN6I_CSI_NAME, sizeof(capability->driver));
 	strscpy(capability->card, video_dev->name, sizeof(capability->card));
@@ -358,7 +362,8 @@ static int sun6i_video_enum_fmt(struct file *file, void *private,
 static int sun6i_video_g_fmt(struct file *file, void *private,
 			     struct v4l2_format *format)
 {
-	struct sun6i_video *video = video_drvdata(file);
+	struct sun6i_csi_device *csi_dev = video_drvdata(file);
+	struct sun6i_video *video = &csi_dev->video;
 
 	*format = video->format;
 
@@ -409,7 +414,8 @@ static int sun6i_video_format_set(struct sun6i_video *video,
 static int sun6i_video_s_fmt(struct file *file, void *private,
 			     struct v4l2_format *format)
 {
-	struct sun6i_video *video = video_drvdata(file);
+	struct sun6i_csi_device *csi_dev = video_drvdata(file);
+	struct sun6i_video *video = &csi_dev->video;
 
 	if (vb2_is_busy(&video->queue))
 		return -EBUSY;
@@ -420,7 +426,8 @@ static int sun6i_video_s_fmt(struct file *file, void *private,
 static int sun6i_video_try_fmt(struct file *file, void *private,
 			       struct v4l2_format *format)
 {
-	struct sun6i_video *video = video_drvdata(file);
+	struct sun6i_csi_device *csi_dev = video_drvdata(file);
+	struct sun6i_video *video = &csi_dev->video;
 
 	return sun6i_video_format_try(video, format);
 }
@@ -485,7 +492,8 @@ static const struct v4l2_ioctl_ops sun6i_video_ioctl_ops = {
 
 static int sun6i_video_open(struct file *file)
 {
-	struct sun6i_video *video = video_drvdata(file);
+	struct sun6i_csi_device *csi_dev = video_drvdata(file);
+	struct sun6i_video *video = &csi_dev->video;
 	int ret = 0;
 
 	if (mutex_lock_interruptible(&video->lock))
@@ -501,7 +509,7 @@ static int sun6i_video_open(struct file *file)
 
 	/* Power on at first open. */
 	if (v4l2_fh_is_singular_file(file)) {
-		ret = sun6i_csi_set_power(video->csi_dev, true);
+		ret = sun6i_csi_set_power(csi_dev, true);
 		if (ret < 0)
 			goto error_v4l2_fh;
 	}
@@ -521,7 +529,8 @@ static int sun6i_video_open(struct file *file)
 
 static int sun6i_video_close(struct file *file)
 {
-	struct sun6i_video *video = video_drvdata(file);
+	struct sun6i_csi_device *csi_dev = video_drvdata(file);
+	struct sun6i_video *video = &csi_dev->video;
 	bool last_close;
 
 	mutex_lock(&video->lock);
@@ -533,7 +542,7 @@ static int sun6i_video_close(struct file *file)
 
 	/* Power off at last close. */
 	if (last_close)
-		sun6i_csi_set_power(video->csi_dev, false);
+		sun6i_csi_set_power(csi_dev, false);
 
 	mutex_unlock(&video->lock);
 
@@ -570,15 +579,16 @@ static int sun6i_video_link_validate(struct media_link *link)
 {
 	struct video_device *vdev = container_of(link->sink->entity,
 						 struct video_device, entity);
-	struct sun6i_video *video = video_get_drvdata(vdev);
+	struct sun6i_csi_device *csi_dev = video_get_drvdata(vdev);
+	struct sun6i_video *video = &csi_dev->video;
 	struct v4l2_subdev_format source_fmt;
 	int ret;
 
 	video->mbus_code = 0;
 
 	if (!media_entity_remote_pad(link->sink->entity->pads)) {
-		dev_info(video->csi_dev->dev,
-			 "video node %s pad not connected\n", vdev->name);
+		dev_info(csi_dev->dev, "video node %s pad not connected\n",
+			 vdev->name);
 		return -ENOLINK;
 	}
 
@@ -586,10 +596,10 @@ static int sun6i_video_link_validate(struct media_link *link)
 	if (ret < 0)
 		return ret;
 
-	if (!sun6i_csi_is_format_supported(video->csi_dev,
+	if (!sun6i_csi_is_format_supported(csi_dev,
 					   video->format.fmt.pix.pixelformat,
 					   source_fmt.format.code)) {
-		dev_err(video->csi_dev->dev,
+		dev_err(csi_dev->dev,
 			"Unsupported pixformat: 0x%x with mbus code: 0x%x!\n",
 			video->format.fmt.pix.pixelformat,
 			source_fmt.format.code);
@@ -598,7 +608,7 @@ static int sun6i_video_link_validate(struct media_link *link)
 
 	if (source_fmt.format.width != video->format.fmt.pix.width ||
 	    source_fmt.format.height != video->format.fmt.pix.height) {
-		dev_err(video->csi_dev->dev,
+		dev_err(csi_dev->dev,
 			"Wrong width or height %ux%u (%ux%u expected)\n",
 			video->format.fmt.pix.width, video->format.fmt.pix.height,
 			source_fmt.format.width, source_fmt.format.height);
@@ -616,9 +626,9 @@ static const struct media_entity_operations sun6i_video_media_ops = {
 
 /* Video */
 
-int sun6i_video_setup(struct sun6i_video *video,
-		      struct sun6i_csi_device *csi_dev)
+int sun6i_video_setup(struct sun6i_csi_device *csi_dev)
 {
+	struct sun6i_video *video = &csi_dev->video;
 	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
 	struct video_device *video_dev = &video->video_dev;
 	struct vb2_queue *queue = &video->queue;
@@ -627,8 +637,6 @@ int sun6i_video_setup(struct sun6i_video *video,
 	struct v4l2_pix_format *pix_format = &format.fmt.pix;
 	int ret;
 
-	video->csi_dev = csi_dev;
-
 	/* Media Entity */
 
 	video_dev->entity.ops = &sun6i_video_media_ops;
@@ -660,7 +668,7 @@ int sun6i_video_setup(struct sun6i_video *video,
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->lock = &video->lock;
 	queue->dev = csi_dev->dev;
-	queue->drv_priv = video;
+	queue->drv_priv = csi_dev;
 
 	/* Make sure non-dropped frame. */
 	queue->min_buffers_needed = 3;
@@ -693,7 +701,7 @@ int sun6i_video_setup(struct sun6i_video *video,
 	video_dev->queue = queue;
 	video_dev->lock = &video->lock;
 
-	video_set_drvdata(video_dev, video);
+	video_set_drvdata(video_dev, csi_dev);
 
 	ret = video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
 	if (ret < 0) {
@@ -715,8 +723,9 @@ int sun6i_video_setup(struct sun6i_video *video,
 	return ret;
 }
 
-void sun6i_video_cleanup(struct sun6i_video *video)
+void sun6i_video_cleanup(struct sun6i_csi_device *csi_dev)
 {
+	struct sun6i_video *video = &csi_dev->video;
 	struct video_device *video_dev = &video->video_dev;
 
 	vb2_video_unregister_device(video_dev);
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
index 7864f062d05b..a917d2da6deb 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
@@ -14,8 +14,6 @@
 struct sun6i_csi_device;
 
 struct sun6i_video {
-	struct sun6i_csi_device		*csi_dev;
-
 	struct video_device		video_dev;
 	struct vb2_queue		queue;
 	struct mutex			lock; /* Queue lock. */
@@ -29,10 +27,9 @@ struct sun6i_video {
 	unsigned int			sequence;
 };
 
-int sun6i_video_setup(struct sun6i_video *video,
-		      struct sun6i_csi_device *csi_dev);
-void sun6i_video_cleanup(struct sun6i_video *video);
+int sun6i_video_setup(struct sun6i_csi_device *csi_dev);
+void sun6i_video_cleanup(struct sun6i_csi_device *csi_dev);
 
-void sun6i_video_frame_done(struct sun6i_video *video);
+void sun6i_video_frame_done(struct sun6i_csi_device *csi_dev);
 
 #endif /* __SUN6I_VIDEO_H__ */
-- 
2.35.1

