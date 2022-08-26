Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062F35A2ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbiHZSet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiHZSdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:46 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F48E58AE;
        Fri, 26 Aug 2022 11:33:29 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 981CAFF806;
        Fri, 26 Aug 2022 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+uVn6wXh6sdh6ZARgLjWBsyST02Yc64aoHUAviRkpY=;
        b=hncpRjWMClVihe1+SqgH/HAp3ookGP5kiFbQuRAvzSehokBWgXeLSW0d317fm4iiXnOTzp
        KMjWFlRMIrlQ0npbDULN8fP/nVSyF1LhDmUCHiuCpdjPHhO5PLkb+3iQb0qgoog3i4T7Yd
        Di0QfDmvxgTK5LxGW8DqdsXBZMT6K5oUfvWBiXkqfOvFyEgv12VadlsT4Hszsr94621vVC
        Q9TU8S0OZqKi7H5zHmgZKoJpEC715AyPX/jWVyqnZDR5HLcxXi4i6c33HRFdQvE2J2hhi0
        umD+YACzMcCgndf9+ODM8/wP+q2832nXl7S6lK0mbbL9jEXzt0ajctOqXbZmOw==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 18/43] media: sun6i-csi: Add capture state using vsync for page flip
Date:   Fri, 26 Aug 2022 20:32:15 +0200
Message-Id: <20220826183240.604834-19-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation requires up to 3 buffers to properly
implement page flipping without losing frames: one is configured
before the video stream is started, one just after that and page
flipping is synchronized to the frame done interrupt. The comment in
the code mentions that "CSI will lookup the next dma buffer for next
frame before the current frame done IRQ triggered".

Based on observations of the CSI unit behavior, it seems that the
buffer DMA address is sampled when the frame scan begins (in addition
to starting the stream), which corresponds to the vblank interrupt
that hits just before the frame-done interrupt of the previous frame.

As a result, the address configured at the frame done interrupt is not
actually used for the next frame but for the one after that.

This proposal changes the page flipping sync point to the vsync
interrupt, which allows the DMA address to be sampled for the next
frame instead and allows operating with only two buffers.

In addition to the change in the sync point, the code is refactored
to introduce a notion of state that clarifies tracking of the buffers
with tidy functions.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |   4 +
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |   3 -
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 259 ++++++++++--------
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  23 +-
 4 files changed, 165 insertions(+), 124 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index cffd664cbc0b..cc277733d7ec 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -566,6 +566,7 @@ void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
 
 	regmap_write(regmap, CSI_CH_INT_STA_REG, 0xFF);
 	regmap_write(regmap, CSI_CH_INT_EN_REG,
+		     CSI_CH_INT_EN_VS_INT_EN |
 		     CSI_CH_INT_EN_HB_OF_INT_EN |
 		     CSI_CH_INT_EN_FIFO2_OF_INT_EN |
 		     CSI_CH_INT_EN_FIFO1_OF_INT_EN |
@@ -664,6 +665,9 @@ static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
 	if (status & CSI_CH_INT_STA_FD_PD)
 		sun6i_csi_capture_frame_done(csi_dev);
 
+	if (status & CSI_CH_INT_STA_VS_PD)
+		sun6i_csi_capture_sync(csi_dev);
+
 	regmap_write(regmap, CSI_CH_INT_STA_REG, status);
 
 	return IRQ_HANDLED;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index a4e93cc2bdfe..4aa9de822d9f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -25,9 +25,6 @@ enum sun6i_csi_port {
 struct sun6i_csi_buffer {
 	struct vb2_v4l2_buffer		v4l2_buffer;
 	struct list_head		list;
-
-	dma_addr_t			dma_addr;
-	bool				queued_to_csi;
 };
 
 /**
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index de8ce116ee63..8bdc876eddc3 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -90,8 +90,13 @@ static void
 sun6i_csi_capture_buffer_configure(struct sun6i_csi_device *csi_dev,
 				   struct sun6i_csi_buffer *csi_buffer)
 {
-	csi_buffer->queued_to_csi = true;
-	sun6i_csi_update_buf_addr(csi_dev, csi_buffer->dma_addr);
+	struct vb2_buffer *vb2_buffer;
+	dma_addr_t address;
+
+	vb2_buffer = &csi_buffer->v4l2_buffer.vb2_buf;
+	address = vb2_dma_contig_plane_dma_addr(vb2_buffer, 0);
+
+	sun6i_csi_update_buf_addr(csi_dev, address);
 }
 
 static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)
@@ -108,6 +113,119 @@ static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)
 	sun6i_csi_update_config(csi_dev, &config);
 }
 
+/* State */
+
+static void sun6i_csi_capture_state_cleanup(struct sun6i_csi_device *csi_dev,
+					    bool error)
+{
+	struct sun6i_csi_capture_state *state = &csi_dev->capture.state;
+	struct sun6i_csi_buffer **csi_buffer_states[] = {
+		&state->pending, &state->current, &state->complete,
+	};
+	struct sun6i_csi_buffer *csi_buffer;
+	struct vb2_buffer *vb2_buffer;
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	for (i = 0; i < ARRAY_SIZE(csi_buffer_states); i++) {
+		csi_buffer = *csi_buffer_states[i];
+		if (!csi_buffer)
+			continue;
+
+		vb2_buffer = &csi_buffer->v4l2_buffer.vb2_buf;
+		vb2_buffer_done(vb2_buffer, error ? VB2_BUF_STATE_ERROR :
+				VB2_BUF_STATE_QUEUED);
+
+		*csi_buffer_states[i] = NULL;
+	}
+
+	list_for_each_entry(csi_buffer, &state->queue, list) {
+		vb2_buffer = &csi_buffer->v4l2_buffer.vb2_buf;
+		vb2_buffer_done(vb2_buffer, error ? VB2_BUF_STATE_ERROR :
+				VB2_BUF_STATE_QUEUED);
+	}
+
+	INIT_LIST_HEAD(&state->queue);
+
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+static void sun6i_csi_capture_state_update(struct sun6i_csi_device *csi_dev)
+{
+	struct sun6i_csi_capture_state *state = &csi_dev->capture.state;
+	struct sun6i_csi_buffer *csi_buffer;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	if (list_empty(&state->queue))
+		goto complete;
+
+	if (state->pending)
+		goto complete;
+
+	csi_buffer = list_first_entry(&state->queue, struct sun6i_csi_buffer,
+				      list);
+
+	sun6i_csi_capture_buffer_configure(csi_dev, csi_buffer);
+
+	list_del(&csi_buffer->list);
+
+	state->pending = csi_buffer;
+
+complete:
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+static void sun6i_csi_capture_state_complete(struct sun6i_csi_device *csi_dev)
+{
+	struct sun6i_csi_capture_state *state = &csi_dev->capture.state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	if (!state->pending)
+		goto complete;
+
+	state->complete = state->current;
+	state->current = state->pending;
+	state->pending = NULL;
+
+	if (state->complete) {
+		struct sun6i_csi_buffer *csi_buffer = state->complete;
+		struct vb2_buffer *vb2_buffer =
+			&csi_buffer->v4l2_buffer.vb2_buf;
+
+		vb2_buffer->timestamp = ktime_get_ns();
+		csi_buffer->v4l2_buffer.sequence = state->sequence;
+
+		vb2_buffer_done(vb2_buffer, VB2_BUF_STATE_DONE);
+
+		state->complete = NULL;
+	}
+
+complete:
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev)
+{
+	struct sun6i_csi_capture_state *state = &csi_dev->capture.state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+	state->sequence++;
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+void sun6i_csi_capture_sync(struct sun6i_csi_device *csi_dev)
+{
+	sun6i_csi_capture_state_complete(csi_dev);
+	sun6i_csi_capture_state_update(csi_dev);
+}
+
 /* Queue */
 
 static int sun6i_csi_capture_queue_setup(struct vb2_queue *queue,
@@ -117,8 +235,7 @@ static int sun6i_csi_capture_queue_setup(struct vb2_queue *queue,
 					 struct device *alloc_devs[])
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	unsigned int size = capture->format.fmt.pix.sizeimage;
+	unsigned int size = csi_dev->capture.format.fmt.pix.sizeimage;
 
 	if (*planes_count)
 		return sizes[0] < size ? -EINVAL : 0;
@@ -135,8 +252,6 @@ static int sun6i_csi_capture_buffer_prepare(struct vb2_buffer *buffer)
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
 	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
-	struct sun6i_csi_buffer *csi_buffer =
-		container_of(v4l2_buffer, struct sun6i_csi_buffer, v4l2_buffer);
 	unsigned long size = capture->format.fmt.pix.sizeimage;
 
 	if (vb2_plane_size(buffer, 0) < size) {
@@ -147,7 +262,6 @@ static int sun6i_csi_capture_buffer_prepare(struct vb2_buffer *buffer)
 
 	vb2_set_plane_payload(buffer, 0, size);
 
-	csi_buffer->dma_addr = vb2_dma_contig_plane_dma_addr(buffer, 0);
 	v4l2_buffer->field = capture->format.fmt.pix.field;
 
 	return 0;
@@ -156,16 +270,15 @@ static int sun6i_csi_capture_buffer_prepare(struct vb2_buffer *buffer)
 static void sun6i_csi_capture_buffer_queue(struct vb2_buffer *buffer)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(buffer->vb2_queue);
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	struct sun6i_csi_capture_state *state = &csi_dev->capture.state;
 	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
 	struct sun6i_csi_buffer *csi_buffer =
 		container_of(v4l2_buffer, struct sun6i_csi_buffer, v4l2_buffer);
 	unsigned long flags;
 
-	spin_lock_irqsave(&capture->dma_queue_lock, flags);
-	csi_buffer->queued_to_csi = false;
-	list_add_tail(&csi_buffer->list, &capture->dma_queue);
-	spin_unlock_irqrestore(&capture->dma_queue_lock, flags);
+	spin_lock_irqsave(&state->lock, flags);
+	list_add_tail(&csi_buffer->list, &state->queue);
+	spin_unlock_irqrestore(&state->lock, flags);
 }
 
 static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
@@ -173,18 +286,16 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	struct sun6i_csi_capture_state *state = &capture->state;
 	struct video_device *video_dev = &capture->video_dev;
-	struct sun6i_csi_buffer *buf;
-	struct sun6i_csi_buffer *next_buf;
 	struct v4l2_subdev *subdev;
-	unsigned long flags;
 	int ret;
 
-	capture->sequence = 0;
+	state->sequence = 0;
 
 	ret = media_pipeline_start(&video_dev->entity, &video_dev->pipe);
 	if (ret < 0)
-		goto error_dma_queue_flush;
+		goto error_state;
 
 	if (capture->mbus_code == 0) {
 		ret = -EINVAL;
@@ -197,37 +308,17 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 		goto error_media_pipeline;
 	}
 
+	/* Configure */
+
 	sun6i_csi_capture_configure(csi_dev);
 
-	spin_lock_irqsave(&capture->dma_queue_lock, flags);
+	/* State Update */
 
-	buf = list_first_entry(&capture->dma_queue,
-			       struct sun6i_csi_buffer, list);
-	sun6i_csi_capture_buffer_configure(csi_dev, buf);
+	sun6i_csi_capture_state_update(csi_dev);
 
-	sun6i_csi_set_stream(csi_dev, true);
+	/* Enable */
 
-	/*
-	 * CSI will lookup the next dma buffer for next frame before the
-	 * the current frame done IRQ triggered. This is not documented
-	 * but reported by Ondřej Jirman.
-	 * The BSP code has workaround for this too. It skip to mark the
-	 * first buffer as frame done for VB2 and pass the second buffer
-	 * to CSI in the first frame done ISR call. Then in second frame
-	 * done ISR call, it mark the first buffer as frame done for VB2
-	 * and pass the third buffer to CSI. And so on. The bad thing is
-	 * that the first buffer will be written twice and the first frame
-	 * is dropped even the queued buffer is sufficient.
-	 * So, I make some improvement here. Pass the next buffer to CSI
-	 * just follow starting the CSI. In this case, the first frame
-	 * will be stored in first buffer, second frame in second buffer.
-	 * This method is used to avoid dropping the first frame, it
-	 * would also drop frame when lacking of queued buffer.
-	 */
-	next_buf = list_next_entry(buf, list);
-	sun6i_csi_capture_buffer_configure(csi_dev, next_buf);
-
-	spin_unlock_irqrestore(&capture->dma_queue_lock, flags);
+	sun6i_csi_set_stream(csi_dev, true);
 
 	ret = v4l2_subdev_call(subdev, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD)
@@ -241,13 +332,8 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 error_media_pipeline:
 	media_pipeline_stop(&video_dev->entity);
 
-error_dma_queue_flush:
-	spin_lock_irqsave(&capture->dma_queue_lock, flags);
-	list_for_each_entry(buf, &capture->dma_queue, list)
-		vb2_buffer_done(&buf->v4l2_buffer.vb2_buf,
-				VB2_BUF_STATE_QUEUED);
-	INIT_LIST_HEAD(&capture->dma_queue);
-	spin_unlock_irqrestore(&capture->dma_queue_lock, flags);
+error_state:
+	sun6i_csi_capture_state_cleanup(csi_dev, false);
 
 	return ret;
 }
@@ -257,8 +343,6 @@ static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct v4l2_subdev *subdev;
-	unsigned long flags;
-	struct sun6i_csi_buffer *buf;
 
 	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
 	if (subdev)
@@ -268,59 +352,7 @@ static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 
 	media_pipeline_stop(&capture->video_dev.entity);
 
-	/* Release all active buffers */
-	spin_lock_irqsave(&capture->dma_queue_lock, flags);
-	list_for_each_entry(buf, &capture->dma_queue, list)
-		vb2_buffer_done(&buf->v4l2_buffer.vb2_buf, VB2_BUF_STATE_ERROR);
-	INIT_LIST_HEAD(&capture->dma_queue);
-	spin_unlock_irqrestore(&capture->dma_queue_lock, flags);
-}
-
-void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev)
-{
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	struct sun6i_csi_buffer *buf;
-	struct sun6i_csi_buffer *next_buf;
-	struct vb2_v4l2_buffer *v4l2_buffer;
-
-	spin_lock(&capture->dma_queue_lock);
-
-	buf = list_first_entry(&capture->dma_queue,
-			       struct sun6i_csi_buffer, list);
-	if (list_is_last(&buf->list, &capture->dma_queue)) {
-		dev_dbg(csi_dev->dev, "Frame dropped!\n");
-		goto complete;
-	}
-
-	next_buf = list_next_entry(buf, list);
-	/* If a new buffer (#next_buf) had not been queued to CSI, the old
-	 * buffer (#buf) is still holding by CSI for storing the next
-	 * frame. So, we queue a new buffer (#next_buf) to CSI then wait
-	 * for next ISR call.
-	 */
-	if (!next_buf->queued_to_csi) {
-		sun6i_csi_capture_buffer_configure(csi_dev, next_buf);
-		dev_dbg(csi_dev->dev, "Frame dropped!\n");
-		goto complete;
-	}
-
-	list_del(&buf->list);
-	v4l2_buffer = &buf->v4l2_buffer;
-	v4l2_buffer->vb2_buf.timestamp = ktime_get_ns();
-	v4l2_buffer->sequence = capture->sequence;
-	vb2_buffer_done(&v4l2_buffer->vb2_buf, VB2_BUF_STATE_DONE);
-
-	/* Prepare buffer for next frame but one.  */
-	if (!list_is_last(&next_buf->list, &capture->dma_queue)) {
-		next_buf = list_next_entry(next_buf, list);
-		sun6i_csi_capture_buffer_configure(csi_dev, next_buf);
-	} else {
-		dev_dbg(csi_dev->dev, "Next frame will be dropped!\n");
-	}
-
-complete:
-	capture->sequence++;
-	spin_unlock(&capture->dma_queue_lock);
+	sun6i_csi_capture_state_cleanup(csi_dev, true);
 }
 
 static const struct vb2_ops sun6i_csi_capture_queue_ops = {
@@ -635,6 +667,7 @@ static const struct media_entity_operations sun6i_csi_capture_media_ops = {
 int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 {
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	struct sun6i_csi_capture_state *state = &capture->state;
 	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
 	struct v4l2_subdev *bridge_subdev = &csi_dev->bridge.subdev;
 	struct video_device *video_dev = &capture->video_dev;
@@ -644,6 +677,11 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	struct v4l2_pix_format *pix_format = &format.fmt.pix;
 	int ret;
 
+	/* State */
+
+	INIT_LIST_HEAD(&state->queue);
+	spin_lock_init(&state->lock);
+
 	/* Media Entity */
 
 	video_dev->entity.ops = &sun6i_csi_capture_media_ops;
@@ -656,13 +694,6 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	if (ret < 0)
 		return ret;
 
-	/* DMA queue */
-
-	INIT_LIST_HEAD(&capture->dma_queue);
-	spin_lock_init(&capture->dma_queue_lock);
-
-	capture->sequence = 0;
-
 	/* Queue */
 
 	mutex_init(&capture->lock);
@@ -672,14 +703,12 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	queue->buf_struct_size = sizeof(struct sun6i_csi_buffer);
 	queue->ops = &sun6i_csi_capture_queue_ops;
 	queue->mem_ops = &vb2_dma_contig_memops;
+	queue->min_buffers_needed = 2;
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->lock = &capture->lock;
 	queue->dev = csi_dev->dev;
 	queue->drv_priv = csi_dev;
 
-	/* Make sure non-dropped frame. */
-	queue->min_buffers_needed = 3;
-
 	ret = vb2_queue_init(queue);
 	if (ret) {
 		v4l2_err(v4l2_dev, "failed to initialize vb2 queue: %d\n", ret);
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 36bba31fcb48..7fa66a2af5ec 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -13,23 +13,34 @@
 
 struct sun6i_csi_device;
 
+#undef current
+struct sun6i_csi_capture_state {
+	struct list_head		queue;
+	spinlock_t			lock; /* Queue and buffers lock. */
+
+	struct sun6i_csi_buffer		*pending;
+	struct sun6i_csi_buffer		*current;
+	struct sun6i_csi_buffer		*complete;
+
+	unsigned int			sequence;
+};
+
 struct sun6i_csi_capture {
+	struct sun6i_csi_capture_state	state;
+
 	struct video_device		video_dev;
 	struct vb2_queue		queue;
 	struct mutex			lock; /* Queue lock. */
 	struct media_pad		pad;
 
-	struct list_head		dma_queue;
-	spinlock_t			dma_queue_lock; /* DMA queue lock. */
-
 	struct v4l2_format		format;
 	u32				mbus_code;
-	unsigned int			sequence;
 };
 
+void sun6i_csi_capture_sync(struct sun6i_csi_device *csi_dev);
+void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev);
+
 int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev);
 void sun6i_csi_capture_cleanup(struct sun6i_csi_device *csi_dev);
 
-void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev);
-
 #endif /* __SUN6I_CAPTURE_H__ */
-- 
2.37.1

