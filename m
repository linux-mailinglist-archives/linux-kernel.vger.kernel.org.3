Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9118B5A2ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiHZSeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344897AbiHZSdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:32 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8535BE3C32;
        Fri, 26 Aug 2022 11:33:19 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A46DEFF814;
        Fri, 26 Aug 2022 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWybpHG2eMzfl69KAc9juqAXV4vT+pnBEsZpWcZWVbc=;
        b=in8U83emneDSjlk5jz/G/EPFCrEIkvyuAU7jLDoU4xTQi/pGbNIQM2FmP1Mhp2HW9OE4/D
        he8TOYFld0UVu1rUy6qxi+4yYe0Jcek+Htgah9yAKlqJiHdC4GHq2byiV9yS/jGtlAlrrF
        uOWqwj0z+sSr2T69aelr6ZsTDTSmoP4WskPDDLesZLd0GbbP2SoeCpuIfwlG2EsMkrgH6X
        4nF7UuLCtu+ps10Fg6umF3yVnUsHYNLGON8vf/b7rh1X/Wf1JTssL37J1lqy9OraYCzHOj
        vjV7N2FzSjtRlpk65675NZdNLUBHTpN6zkDCeIM0Ie1IRApTPk1ObBBDIeBHGA==
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
Subject: [PATCH v6 09/43] media: sun6i-csi: Tidy up video code
Date:   Fri, 26 Aug 2022 20:32:06 +0200
Message-Id: <20220826183240.604834-10-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some code cleanups, renames, variable lowerings and moving things around for
better organization. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |   4 +-
 .../platform/sunxi/sun6i-csi/sun6i_video.c    | 509 ++++++++++--------
 .../platform/sunxi/sun6i-csi/sun6i_video.h    |  18 +-
 3 files changed, 285 insertions(+), 246 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 98c9c887c543..b4f90b065a0c 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -595,7 +595,7 @@ static int sun6i_csi_link_entity(struct sun6i_csi_device *csi_dev,
 
 	src_pad_index = ret;
 
-	sink = &csi_dev->video.vdev.entity;
+	sink = &csi_dev->video.video_dev.entity;
 	sink_pad = &csi_dev->video.pad;
 
 	dev_dbg(csi_dev->dev, "creating %s:%u -> %s:%u link\n",
@@ -706,7 +706,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 
 	/* Video */
 
-	ret = sun6i_video_init(&csi_dev->video, csi_dev, SUN6I_CSI_NAME);
+	ret = sun6i_video_setup(&csi_dev->video, csi_dev);
 	if (ret)
 		goto error_v4l2_device;
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index fdcfb3c8ba8f..f668902581a5 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -24,14 +24,34 @@
 #define MAX_HEIGHT	(4800)
 
 struct sun6i_csi_buffer {
-	struct vb2_v4l2_buffer		vb;
+	struct vb2_v4l2_buffer		v4l2_buffer;
 	struct list_head		list;
 
 	dma_addr_t			dma_addr;
 	bool				queued_to_csi;
 };
 
-static const u32 supported_pixformats[] = {
+/* Helpers */
+
+static struct v4l2_subdev *
+sun6i_video_remote_subdev(struct sun6i_video *video, u32 *pad)
+{
+	struct media_pad *remote;
+
+	remote = media_pad_remote_pad_first(&video->pad);
+
+	if (!remote || !is_media_entity_v4l2_subdev(remote->entity))
+		return NULL;
+
+	if (pad)
+		*pad = remote->index;
+
+	return media_entity_to_v4l2_subdev(remote->entity);
+}
+
+/* Format */
+
+static const u32 sun6i_video_formats[] = {
 	V4L2_PIX_FMT_SBGGR8,
 	V4L2_PIX_FMT_SGBRG8,
 	V4L2_PIX_FMT_SGRBG8,
@@ -61,77 +81,80 @@ static const u32 supported_pixformats[] = {
 	V4L2_PIX_FMT_JPEG,
 };
 
-static bool is_pixformat_valid(unsigned int pixformat)
+static bool sun6i_video_format_check(u32 format)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(supported_pixformats); i++)
-		if (supported_pixformats[i] == pixformat)
+	for (i = 0; i < ARRAY_SIZE(sun6i_video_formats); i++)
+		if (sun6i_video_formats[i] == format)
 			return true;
 
 	return false;
 }
 
-static struct v4l2_subdev *
-sun6i_video_remote_subdev(struct sun6i_video *video, u32 *pad)
-{
-	struct media_pad *remote;
-
-	remote = media_pad_remote_pad_first(&video->pad);
+/* Queue */
 
-	if (!remote || !is_media_entity_v4l2_subdev(remote->entity))
-		return NULL;
-
-	if (pad)
-		*pad = remote->index;
-
-	return media_entity_to_v4l2_subdev(remote->entity);
-}
-
-static int sun6i_video_queue_setup(struct vb2_queue *vq,
-				   unsigned int *nbuffers,
-				   unsigned int *nplanes,
+static int sun6i_video_queue_setup(struct vb2_queue *queue,
+				   unsigned int *buffers_count,
+				   unsigned int *planes_count,
 				   unsigned int sizes[],
 				   struct device *alloc_devs[])
 {
-	struct sun6i_video *video = vb2_get_drv_priv(vq);
-	unsigned int size = video->fmt.fmt.pix.sizeimage;
+	struct sun6i_video *video = vb2_get_drv_priv(queue);
+	unsigned int size = video->format.fmt.pix.sizeimage;
 
-	if (*nplanes)
+	if (*planes_count)
 		return sizes[0] < size ? -EINVAL : 0;
 
-	*nplanes = 1;
+	*planes_count = 1;
 	sizes[0] = size;
 
 	return 0;
 }
 
-static int sun6i_video_buffer_prepare(struct vb2_buffer *vb)
+static int sun6i_video_buffer_prepare(struct vb2_buffer *buffer)
 {
-	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
-	struct sun6i_csi_buffer *buf =
-			container_of(vbuf, struct sun6i_csi_buffer, vb);
-	struct sun6i_video *video = vb2_get_drv_priv(vb->vb2_queue);
-	unsigned long size = video->fmt.fmt.pix.sizeimage;
-
-	if (vb2_plane_size(vb, 0) < size) {
-		v4l2_err(video->vdev.v4l2_dev, "buffer too small (%lu < %lu)\n",
-			 vb2_plane_size(vb, 0), size);
+	struct sun6i_video *video = vb2_get_drv_priv(buffer->vb2_queue);
+	struct sun6i_csi_device *csi_dev = video->csi_dev;
+	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
+	struct sun6i_csi_buffer *csi_buffer =
+		container_of(v4l2_buffer, struct sun6i_csi_buffer, v4l2_buffer);
+	unsigned long size = video->format.fmt.pix.sizeimage;
+
+	if (vb2_plane_size(buffer, 0) < size) {
+		v4l2_err(v4l2_dev, "buffer too small (%lu < %lu)\n",
+			 vb2_plane_size(buffer, 0), size);
 		return -EINVAL;
 	}
 
-	vb2_set_plane_payload(vb, 0, size);
-
-	buf->dma_addr = vb2_dma_contig_plane_dma_addr(vb, 0);
+	vb2_set_plane_payload(buffer, 0, size);
 
-	vbuf->field = video->fmt.fmt.pix.field;
+	csi_buffer->dma_addr = vb2_dma_contig_plane_dma_addr(buffer, 0);
+	v4l2_buffer->field = video->format.fmt.pix.field;
 
 	return 0;
 }
 
-static int sun6i_video_start_streaming(struct vb2_queue *vq, unsigned int count)
+static void sun6i_video_buffer_queue(struct vb2_buffer *buffer)
+{
+	struct sun6i_video *video = vb2_get_drv_priv(buffer->vb2_queue);
+	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
+	struct sun6i_csi_buffer *csi_buffer =
+		container_of(v4l2_buffer, struct sun6i_csi_buffer, v4l2_buffer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&video->dma_queue_lock, flags);
+	csi_buffer->queued_to_csi = false;
+	list_add_tail(&csi_buffer->list, &video->dma_queue);
+	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
+}
+
+static int sun6i_video_start_streaming(struct vb2_queue *queue,
+				       unsigned int count)
 {
-	struct sun6i_video *video = vb2_get_drv_priv(vq);
+	struct sun6i_video *video = vb2_get_drv_priv(queue);
+	struct video_device *video_dev = &video->video_dev;
 	struct sun6i_csi_buffer *buf;
 	struct sun6i_csi_buffer *next_buf;
 	struct sun6i_csi_config config;
@@ -141,30 +164,30 @@ static int sun6i_video_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	video->sequence = 0;
 
-	ret = media_pipeline_start(&video->vdev.entity, &video->vdev.pipe);
+	ret = media_pipeline_start(&video_dev->entity, &video_dev->pipe);
 	if (ret < 0)
-		goto clear_dma_queue;
+		goto error_dma_queue_flush;
 
 	if (video->mbus_code == 0) {
 		ret = -EINVAL;
-		goto stop_media_pipeline;
+		goto error_media_pipeline;
 	}
 
 	subdev = sun6i_video_remote_subdev(video, NULL);
 	if (!subdev) {
 		ret = -EINVAL;
-		goto stop_media_pipeline;
+		goto error_media_pipeline;
 	}
 
-	config.pixelformat = video->fmt.fmt.pix.pixelformat;
+	config.pixelformat = video->format.fmt.pix.pixelformat;
 	config.code = video->mbus_code;
-	config.field = video->fmt.fmt.pix.field;
-	config.width = video->fmt.fmt.pix.width;
-	config.height = video->fmt.fmt.pix.height;
+	config.field = video->format.fmt.pix.field;
+	config.width = video->format.fmt.pix.width;
+	config.height = video->format.fmt.pix.height;
 
 	ret = sun6i_csi_update_config(video->csi_dev, &config);
 	if (ret < 0)
-		goto stop_media_pipeline;
+		goto error_media_pipeline;
 
 	spin_lock_irqsave(&video->dma_queue_lock, flags);
 
@@ -200,27 +223,30 @@ static int sun6i_video_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	ret = v4l2_subdev_call(subdev, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD)
-		goto stop_csi_stream;
+		goto error_stream;
 
 	return 0;
 
-stop_csi_stream:
+error_stream:
 	sun6i_csi_set_stream(video->csi_dev, false);
-stop_media_pipeline:
-	media_pipeline_stop(&video->vdev.entity);
-clear_dma_queue:
+
+error_media_pipeline:
+	media_pipeline_stop(&video_dev->entity);
+
+error_dma_queue_flush:
 	spin_lock_irqsave(&video->dma_queue_lock, flags);
 	list_for_each_entry(buf, &video->dma_queue, list)
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
+		vb2_buffer_done(&buf->v4l2_buffer.vb2_buf,
+				VB2_BUF_STATE_QUEUED);
 	INIT_LIST_HEAD(&video->dma_queue);
 	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
 
 	return ret;
 }
 
-static void sun6i_video_stop_streaming(struct vb2_queue *vq)
+static void sun6i_video_stop_streaming(struct vb2_queue *queue)
 {
-	struct sun6i_video *video = vb2_get_drv_priv(vq);
+	struct sun6i_video *video = vb2_get_drv_priv(queue);
 	struct v4l2_subdev *subdev;
 	unsigned long flags;
 	struct sun6i_csi_buffer *buf;
@@ -231,35 +257,21 @@ static void sun6i_video_stop_streaming(struct vb2_queue *vq)
 
 	sun6i_csi_set_stream(video->csi_dev, false);
 
-	media_pipeline_stop(&video->vdev.entity);
+	media_pipeline_stop(&video->video_dev.entity);
 
 	/* Release all active buffers */
 	spin_lock_irqsave(&video->dma_queue_lock, flags);
 	list_for_each_entry(buf, &video->dma_queue, list)
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		vb2_buffer_done(&buf->v4l2_buffer.vb2_buf, VB2_BUF_STATE_ERROR);
 	INIT_LIST_HEAD(&video->dma_queue);
 	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
 }
 
-static void sun6i_video_buffer_queue(struct vb2_buffer *vb)
-{
-	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
-	struct sun6i_csi_buffer *buf =
-			container_of(vbuf, struct sun6i_csi_buffer, vb);
-	struct sun6i_video *video = vb2_get_drv_priv(vb->vb2_queue);
-	unsigned long flags;
-
-	spin_lock_irqsave(&video->dma_queue_lock, flags);
-	buf->queued_to_csi = false;
-	list_add_tail(&buf->list, &video->dma_queue);
-	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
-}
-
 void sun6i_video_frame_done(struct sun6i_video *video)
 {
 	struct sun6i_csi_buffer *buf;
 	struct sun6i_csi_buffer *next_buf;
-	struct vb2_v4l2_buffer *vbuf;
+	struct vb2_v4l2_buffer *v4l2_buffer;
 
 	spin_lock(&video->dma_queue_lock);
 
@@ -267,7 +279,7 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 			       struct sun6i_csi_buffer, list);
 	if (list_is_last(&buf->list, &video->dma_queue)) {
 		dev_dbg(video->csi_dev->dev, "Frame dropped!\n");
-		goto unlock;
+		goto complete;
 	}
 
 	next_buf = list_next_entry(buf, list);
@@ -280,14 +292,14 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 		next_buf->queued_to_csi = true;
 		sun6i_csi_update_buf_addr(video->csi_dev, next_buf->dma_addr);
 		dev_dbg(video->csi_dev->dev, "Frame dropped!\n");
-		goto unlock;
+		goto complete;
 	}
 
 	list_del(&buf->list);
-	vbuf = &buf->vb;
-	vbuf->vb2_buf.timestamp = ktime_get_ns();
-	vbuf->sequence = video->sequence;
-	vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
+	v4l2_buffer = &buf->v4l2_buffer;
+	v4l2_buffer->vb2_buf.timestamp = ktime_get_ns();
+	v4l2_buffer->sequence = video->sequence;
+	vb2_buffer_done(&v4l2_buffer->vb2_buf, VB2_BUF_STATE_DONE);
 
 	/* Prepare buffer for next frame but one.  */
 	if (!list_is_last(&next_buf->list, &video->dma_queue)) {
@@ -298,165 +310,173 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 		dev_dbg(video->csi_dev->dev, "Next frame will be dropped!\n");
 	}
 
-unlock:
+complete:
 	video->sequence++;
 	spin_unlock(&video->dma_queue_lock);
 }
 
-static const struct vb2_ops sun6i_csi_vb2_ops = {
+static const struct vb2_ops sun6i_video_queue_ops = {
 	.queue_setup		= sun6i_video_queue_setup,
-	.wait_prepare		= vb2_ops_wait_prepare,
-	.wait_finish		= vb2_ops_wait_finish,
 	.buf_prepare		= sun6i_video_buffer_prepare,
+	.buf_queue		= sun6i_video_buffer_queue,
 	.start_streaming	= sun6i_video_start_streaming,
 	.stop_streaming		= sun6i_video_stop_streaming,
-	.buf_queue		= sun6i_video_buffer_queue,
+	.wait_prepare		= vb2_ops_wait_prepare,
+	.wait_finish		= vb2_ops_wait_finish,
 };
 
-static int vidioc_querycap(struct file *file, void *priv,
-			   struct v4l2_capability *cap)
+/* V4L2 Device */
+
+static int sun6i_video_querycap(struct file *file, void *private,
+			   struct v4l2_capability *capability)
 {
 	struct sun6i_video *video = video_drvdata(file);
+	struct sun6i_csi_device *csi_dev = video->csi_dev;
+	struct video_device *video_dev = &video->video_dev;
 
-	strscpy(cap->driver, "sun6i-video", sizeof(cap->driver));
-	strscpy(cap->card, video->vdev.name, sizeof(cap->card));
-	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
-		 video->csi_dev->dev->of_node->name);
+	strscpy(capability->driver, SUN6I_CSI_NAME, sizeof(capability->driver));
+	strscpy(capability->card, video_dev->name, sizeof(capability->card));
+	snprintf(capability->bus_info, sizeof(capability->bus_info),
+		 "platform:%s", dev_name(csi_dev->dev));
 
 	return 0;
 }
 
-static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
-				   struct v4l2_fmtdesc *f)
+static int sun6i_video_enum_fmt(struct file *file, void *private,
+				struct v4l2_fmtdesc *fmtdesc)
 {
-	u32 index = f->index;
+	u32 index = fmtdesc->index;
 
-	if (index >= ARRAY_SIZE(supported_pixformats))
+	if (index >= ARRAY_SIZE(sun6i_video_formats))
 		return -EINVAL;
 
-	f->pixelformat = supported_pixformats[index];
+	fmtdesc->pixelformat = sun6i_video_formats[index];
 
 	return 0;
 }
 
-static int vidioc_g_fmt_vid_cap(struct file *file, void *priv,
-				struct v4l2_format *fmt)
+static int sun6i_video_g_fmt(struct file *file, void *private,
+			     struct v4l2_format *format)
 {
 	struct sun6i_video *video = video_drvdata(file);
 
-	*fmt = video->fmt;
+	*format = video->format;
 
 	return 0;
 }
 
-static int sun6i_video_try_fmt(struct sun6i_video *video,
-			       struct v4l2_format *f)
+static int sun6i_video_format_try(struct sun6i_video *video,
+				  struct v4l2_format *format)
 {
-	struct v4l2_pix_format *pixfmt = &f->fmt.pix;
+	struct v4l2_pix_format *pix_format = &format->fmt.pix;
 	int bpp;
 
-	if (!is_pixformat_valid(pixfmt->pixelformat))
-		pixfmt->pixelformat = supported_pixformats[0];
+	if (!sun6i_video_format_check(pix_format->pixelformat))
+		pix_format->pixelformat = sun6i_video_formats[0];
 
-	v4l_bound_align_image(&pixfmt->width, MIN_WIDTH, MAX_WIDTH, 1,
-			      &pixfmt->height, MIN_HEIGHT, MAX_WIDTH, 1, 1);
+	v4l_bound_align_image(&pix_format->width, MIN_WIDTH, MAX_WIDTH, 1,
+			      &pix_format->height, MIN_HEIGHT, MAX_WIDTH, 1, 1);
 
-	bpp = sun6i_csi_get_bpp(pixfmt->pixelformat);
-	pixfmt->bytesperline = (pixfmt->width * bpp) >> 3;
-	pixfmt->sizeimage = pixfmt->bytesperline * pixfmt->height;
+	bpp = sun6i_csi_get_bpp(pix_format->pixelformat);
+	pix_format->bytesperline = (pix_format->width * bpp) >> 3;
+	pix_format->sizeimage = pix_format->bytesperline * pix_format->height;
 
-	if (pixfmt->field == V4L2_FIELD_ANY)
-		pixfmt->field = V4L2_FIELD_NONE;
+	if (pix_format->field == V4L2_FIELD_ANY)
+		pix_format->field = V4L2_FIELD_NONE;
 
-	if (pixfmt->pixelformat == V4L2_PIX_FMT_JPEG)
-		pixfmt->colorspace = V4L2_COLORSPACE_JPEG;
+	if (pix_format->pixelformat == V4L2_PIX_FMT_JPEG)
+		pix_format->colorspace = V4L2_COLORSPACE_JPEG;
 	else
-		pixfmt->colorspace = V4L2_COLORSPACE_SRGB;
+		pix_format->colorspace = V4L2_COLORSPACE_SRGB;
 
-	pixfmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
-	pixfmt->quantization = V4L2_QUANTIZATION_DEFAULT;
-	pixfmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+	pix_format->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	pix_format->quantization = V4L2_QUANTIZATION_DEFAULT;
+	pix_format->xfer_func = V4L2_XFER_FUNC_DEFAULT;
 
 	return 0;
 }
 
-static int sun6i_video_set_fmt(struct sun6i_video *video, struct v4l2_format *f)
+static int sun6i_video_format_set(struct sun6i_video *video,
+				  struct v4l2_format *format)
 {
 	int ret;
 
-	ret = sun6i_video_try_fmt(video, f);
+	ret = sun6i_video_format_try(video, format);
 	if (ret)
 		return ret;
 
-	video->fmt = *f;
+	video->format = *format;
 
 	return 0;
 }
 
-static int vidioc_s_fmt_vid_cap(struct file *file, void *priv,
-				struct v4l2_format *f)
+static int sun6i_video_s_fmt(struct file *file, void *private,
+			     struct v4l2_format *format)
 {
 	struct sun6i_video *video = video_drvdata(file);
 
-	if (vb2_is_busy(&video->vb2_vidq))
+	if (vb2_is_busy(&video->queue))
 		return -EBUSY;
 
-	return sun6i_video_set_fmt(video, f);
+	return sun6i_video_format_set(video, format);
 }
 
-static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
-				  struct v4l2_format *f)
+static int sun6i_video_try_fmt(struct file *file, void *private,
+			       struct v4l2_format *format)
 {
 	struct sun6i_video *video = video_drvdata(file);
 
-	return sun6i_video_try_fmt(video, f);
+	return sun6i_video_format_try(video, format);
 }
 
-static int vidioc_enum_input(struct file *file, void *fh,
-			     struct v4l2_input *inp)
+static int sun6i_video_enum_input(struct file *file, void *private,
+			     struct v4l2_input *input)
 {
-	if (inp->index != 0)
+	if (input->index != 0)
 		return -EINVAL;
 
-	strscpy(inp->name, "camera", sizeof(inp->name));
-	inp->type = V4L2_INPUT_TYPE_CAMERA;
+	input->type = V4L2_INPUT_TYPE_CAMERA;
+	strscpy(input->name, "Camera", sizeof(input->name));
 
 	return 0;
 }
 
-static int vidioc_g_input(struct file *file, void *fh, unsigned int *i)
+static int sun6i_video_g_input(struct file *file, void *private,
+			       unsigned int *index)
 {
-	*i = 0;
+	*index = 0;
 
 	return 0;
 }
 
-static int vidioc_s_input(struct file *file, void *fh, unsigned int i)
+static int sun6i_video_s_input(struct file *file, void *private,
+			       unsigned int index)
 {
-	if (i != 0)
+	if (index != 0)
 		return -EINVAL;
 
 	return 0;
 }
 
 static const struct v4l2_ioctl_ops sun6i_video_ioctl_ops = {
-	.vidioc_querycap		= vidioc_querycap,
-	.vidioc_enum_fmt_vid_cap	= vidioc_enum_fmt_vid_cap,
-	.vidioc_g_fmt_vid_cap		= vidioc_g_fmt_vid_cap,
-	.vidioc_s_fmt_vid_cap		= vidioc_s_fmt_vid_cap,
-	.vidioc_try_fmt_vid_cap		= vidioc_try_fmt_vid_cap,
+	.vidioc_querycap		= sun6i_video_querycap,
+
+	.vidioc_enum_fmt_vid_cap	= sun6i_video_enum_fmt,
+	.vidioc_g_fmt_vid_cap		= sun6i_video_g_fmt,
+	.vidioc_s_fmt_vid_cap		= sun6i_video_s_fmt,
+	.vidioc_try_fmt_vid_cap		= sun6i_video_try_fmt,
 
-	.vidioc_enum_input		= vidioc_enum_input,
-	.vidioc_s_input			= vidioc_s_input,
-	.vidioc_g_input			= vidioc_g_input,
+	.vidioc_enum_input		= sun6i_video_enum_input,
+	.vidioc_g_input			= sun6i_video_g_input,
+	.vidioc_s_input			= sun6i_video_s_input,
 
+	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
+	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
 	.vidioc_reqbufs			= vb2_ioctl_reqbufs,
 	.vidioc_querybuf		= vb2_ioctl_querybuf,
-	.vidioc_qbuf			= vb2_ioctl_qbuf,
 	.vidioc_expbuf			= vb2_ioctl_expbuf,
+	.vidioc_qbuf			= vb2_ioctl_qbuf,
 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
-	.vidioc_create_bufs		= vb2_ioctl_create_bufs,
-	.vidioc_prepare_buf		= vb2_ioctl_prepare_buf,
 	.vidioc_streamon		= vb2_ioctl_streamon,
 	.vidioc_streamoff		= vb2_ioctl_streamoff,
 
@@ -465,9 +485,8 @@ static const struct v4l2_ioctl_ops sun6i_video_ioctl_ops = {
 	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
 };
 
-/* -----------------------------------------------------------------------------
- * V4L2 file operations
- */
+/* V4L2 File */
+
 static int sun6i_video_open(struct file *file)
 {
 	struct sun6i_video *video = video_drvdata(file);
@@ -478,44 +497,46 @@ static int sun6i_video_open(struct file *file)
 
 	ret = v4l2_fh_open(file);
 	if (ret < 0)
-		goto unlock;
+		goto error_lock;
 
-	ret = v4l2_pipeline_pm_get(&video->vdev.entity);
+	ret = v4l2_pipeline_pm_get(&video->video_dev.entity);
 	if (ret < 0)
-		goto fh_release;
-
-	/* check if already powered */
-	if (!v4l2_fh_is_singular_file(file))
-		goto unlock;
+		goto error_v4l2_fh;
 
-	ret = sun6i_csi_set_power(video->csi_dev, true);
-	if (ret < 0)
-		goto fh_release;
+	/* Power on at first open. */
+	if (v4l2_fh_is_singular_file(file)) {
+		ret = sun6i_csi_set_power(video->csi_dev, true);
+		if (ret < 0)
+			goto error_v4l2_fh;
+	}
 
 	mutex_unlock(&video->lock);
+
 	return 0;
 
-fh_release:
+error_v4l2_fh:
 	v4l2_fh_release(file);
-unlock:
+
+error_lock:
 	mutex_unlock(&video->lock);
+
 	return ret;
 }
 
 static int sun6i_video_close(struct file *file)
 {
 	struct sun6i_video *video = video_drvdata(file);
-	bool last_fh;
+	bool last_close;
 
 	mutex_lock(&video->lock);
 
-	last_fh = v4l2_fh_is_singular_file(file);
+	last_close = v4l2_fh_is_singular_file(file);
 
 	_vb2_fop_release(file, NULL);
+	v4l2_pipeline_pm_put(&video->video_dev.entity);
 
-	v4l2_pipeline_pm_put(&video->vdev.entity);
-
-	if (last_fh)
+	/* Power off at last close. */
+	if (last_close)
 		sun6i_csi_set_power(video->csi_dev, false);
 
 	mutex_unlock(&video->lock);
@@ -532,9 +553,8 @@ static const struct v4l2_file_operations sun6i_video_fops = {
 	.poll		= vb2_fop_poll
 };
 
-/* -----------------------------------------------------------------------------
- * Media Operations
- */
+/* Media Entity */
+
 static int sun6i_video_link_validate_get_format(struct media_pad *pad,
 						struct v4l2_subdev_format *fmt)
 {
@@ -571,20 +591,20 @@ static int sun6i_video_link_validate(struct media_link *link)
 		return ret;
 
 	if (!sun6i_csi_is_format_supported(video->csi_dev,
-					   video->fmt.fmt.pix.pixelformat,
+					   video->format.fmt.pix.pixelformat,
 					   source_fmt.format.code)) {
 		dev_err(video->csi_dev->dev,
 			"Unsupported pixformat: 0x%x with mbus code: 0x%x!\n",
-			video->fmt.fmt.pix.pixelformat,
+			video->format.fmt.pix.pixelformat,
 			source_fmt.format.code);
 		return -EPIPE;
 	}
 
-	if (source_fmt.format.width != video->fmt.fmt.pix.width ||
-	    source_fmt.format.height != video->fmt.fmt.pix.height) {
+	if (source_fmt.format.width != video->format.fmt.pix.width ||
+	    source_fmt.format.height != video->format.fmt.pix.height) {
 		dev_err(video->csi_dev->dev,
 			"Wrong width or height %ux%u (%ux%u expected)\n",
-			video->fmt.fmt.pix.width, video->fmt.fmt.pix.height,
+			video->format.fmt.pix.width, video->format.fmt.pix.height,
 			source_fmt.format.width, source_fmt.format.height);
 		return -EPIPE;
 	}
@@ -598,90 +618,109 @@ static const struct media_entity_operations sun6i_video_media_ops = {
 	.link_validate = sun6i_video_link_validate
 };
 
-int sun6i_video_init(struct sun6i_video *video,
-		     struct sun6i_csi_device *csi_dev, const char *name)
+/* Video */
+
+int sun6i_video_setup(struct sun6i_video *video,
+		      struct sun6i_csi_device *csi_dev)
 {
-	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
-	struct video_device *vdev = &video->vdev;
-	struct vb2_queue *vidq = &video->vb2_vidq;
-	struct v4l2_format fmt = { 0 };
+	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	struct video_device *video_dev = &video->video_dev;
+	struct vb2_queue *queue = &video->queue;
+	struct media_pad *pad = &video->pad;
+	struct v4l2_format format = { 0 };
+	struct v4l2_pix_format *pix_format = &format.fmt.pix;
 	int ret;
 
 	video->csi_dev = csi_dev;
 
-	/* Initialize the media entity... */
-	video->pad.flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
-	vdev->entity.ops = &sun6i_video_media_ops;
-	ret = media_entity_pads_init(&vdev->entity, 1, &video->pad);
+	/* Media Entity */
+
+	video_dev->entity.ops = &sun6i_video_media_ops;
+
+	/* Media Pad */
+
+	pad->flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
+
+	ret = media_entity_pads_init(&video_dev->entity, 1, pad);
 	if (ret < 0)
 		return ret;
 
-	mutex_init(&video->lock);
+	/* DMA queue */
 
 	INIT_LIST_HEAD(&video->dma_queue);
 	spin_lock_init(&video->dma_queue_lock);
 
 	video->sequence = 0;
 
-	/* Setup default format */
-	fmt.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
-	fmt.fmt.pix.pixelformat = supported_pixformats[0];
-	fmt.fmt.pix.width = 1280;
-	fmt.fmt.pix.height = 720;
-	fmt.fmt.pix.field = V4L2_FIELD_NONE;
-	sun6i_video_set_fmt(video, &fmt);
-
-	/* Initialize videobuf2 queue */
-	vidq->type			= V4L2_BUF_TYPE_VIDEO_CAPTURE;
-	vidq->io_modes			= VB2_MMAP | VB2_DMABUF;
-	vidq->drv_priv			= video;
-	vidq->buf_struct_size		= sizeof(struct sun6i_csi_buffer);
-	vidq->ops			= &sun6i_csi_vb2_ops;
-	vidq->mem_ops			= &vb2_dma_contig_memops;
-	vidq->timestamp_flags		= V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	vidq->lock			= &video->lock;
-	/* Make sure non-dropped frame */
-	vidq->min_buffers_needed	= 3;
-	vidq->dev			= csi_dev->dev;
-
-	ret = vb2_queue_init(vidq);
+	/* Queue */
+
+	mutex_init(&video->lock);
+
+	queue->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
+	queue->io_modes = VB2_MMAP | VB2_DMABUF;
+	queue->buf_struct_size = sizeof(struct sun6i_csi_buffer);
+	queue->ops = &sun6i_video_queue_ops;
+	queue->mem_ops = &vb2_dma_contig_memops;
+	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
+	queue->lock = &video->lock;
+	queue->dev = csi_dev->dev;
+	queue->drv_priv = video;
+
+	/* Make sure non-dropped frame. */
+	queue->min_buffers_needed = 3;
+
+	ret = vb2_queue_init(queue);
 	if (ret) {
-		v4l2_err(&v4l2->v4l2_dev, "vb2_queue_init failed: %d\n",
-			 ret);
-		goto clean_entity;
+		v4l2_err(v4l2_dev, "failed to initialize vb2 queue: %d\n", ret);
+		goto error_media_entity;
 	}
 
-	/* Register video device */
-	strscpy(vdev->name, name, sizeof(vdev->name));
-	vdev->release		= video_device_release_empty;
-	vdev->fops		= &sun6i_video_fops;
-	vdev->ioctl_ops		= &sun6i_video_ioctl_ops;
-	vdev->vfl_type		= VFL_TYPE_VIDEO;
-	vdev->vfl_dir		= VFL_DIR_RX;
-	vdev->v4l2_dev		= &v4l2->v4l2_dev;
-	vdev->queue		= vidq;
-	vdev->lock		= &video->lock;
-	vdev->device_caps	= V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE;
-	video_set_drvdata(vdev, video);
-
-	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	/* V4L2 Format */
+
+	format.type = queue->type;
+	pix_format->pixelformat = sun6i_video_formats[0];
+	pix_format->width = 1280;
+	pix_format->height = 720;
+	pix_format->field = V4L2_FIELD_NONE;
+
+	sun6i_video_format_set(video, &format);
+
+	/* Video Device */
+
+	strscpy(video_dev->name, SUN6I_CSI_NAME, sizeof(video_dev->name));
+	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	video_dev->vfl_dir = VFL_DIR_RX;
+	video_dev->release = video_device_release_empty;
+	video_dev->fops = &sun6i_video_fops;
+	video_dev->ioctl_ops = &sun6i_video_ioctl_ops;
+	video_dev->v4l2_dev = v4l2_dev;
+	video_dev->queue = queue;
+	video_dev->lock = &video->lock;
+
+	video_set_drvdata(video_dev, video);
+
+	ret = video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
 	if (ret < 0) {
-		v4l2_err(&v4l2->v4l2_dev,
-			 "video_register_device failed: %d\n", ret);
-		goto clean_entity;
+		v4l2_err(v4l2_dev, "failed to register video device: %d\n",
+			 ret);
+		goto error_media_entity;
 	}
 
 	return 0;
 
-clean_entity:
-	media_entity_cleanup(&video->vdev.entity);
+error_media_entity:
+	media_entity_cleanup(&video_dev->entity);
+
 	mutex_destroy(&video->lock);
+
 	return ret;
 }
 
 void sun6i_video_cleanup(struct sun6i_video *video)
 {
-	vb2_video_unregister_device(&video->vdev);
-	media_entity_cleanup(&video->vdev.entity);
+	struct video_device *video_dev = &video->video_dev;
+
+	vb2_video_unregister_device(video_dev);
+	media_entity_cleanup(&video_dev->entity);
 	mutex_destroy(&video->lock);
 }
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
index 30e37ee0d07f..7864f062d05b 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
@@ -15,22 +15,22 @@ struct sun6i_csi_device;
 
 struct sun6i_video {
 	struct sun6i_csi_device		*csi_dev;
-	struct video_device		vdev;
-	struct media_pad		pad;
 
-	struct mutex			lock;
+	struct video_device		video_dev;
+	struct vb2_queue		queue;
+	struct mutex			lock; /* Queue lock. */
+	struct media_pad		pad;
 
-	struct vb2_queue		vb2_vidq;
-	spinlock_t			dma_queue_lock;
 	struct list_head		dma_queue;
+	spinlock_t			dma_queue_lock; /* DMA queue lock. */
 
-	unsigned int			sequence;
-	struct v4l2_format		fmt;
+	struct v4l2_format		format;
 	u32				mbus_code;
+	unsigned int			sequence;
 };
 
-int sun6i_video_init(struct sun6i_video *video,
-		     struct sun6i_csi_device *csi_dev, const char *name);
+int sun6i_video_setup(struct sun6i_video *video,
+		      struct sun6i_csi_device *csi_dev);
 void sun6i_video_cleanup(struct sun6i_video *video);
 
 void sun6i_video_frame_done(struct sun6i_video *video);
-- 
2.37.1

