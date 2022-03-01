Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1F14C8244
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiCAEXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiCAEXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:23:12 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8BF39158
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:22:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e13so12494027plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 20:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YiuwsItVgiHnp3P3VJMKFvdvhrCE1xpf4s9ZlXl+PbQ=;
        b=QQ4fluqz5WXBpkKtSYvLRxOIATkBOH8/cAQlea9sUiUA+b/dzUbaYk9wcXvdaWC5Ox
         I20Gu+F0tCq6FgMw0FNnUvvTsZGSAIKzkeMZXstAnZYuzdnq/w8cLjrj9r/cs9MdHhx6
         SA2KrVrSS32/uw05IsQeD9jN2PRul5TZjZt0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YiuwsItVgiHnp3P3VJMKFvdvhrCE1xpf4s9ZlXl+PbQ=;
        b=PneSJiLQxv4aH1JR1bPZEqYL7L+hYrlLEmjDXAqOSCp1I9lYOrJ7lbd2Kw6sbmCD+0
         AvX1O6o/vQ/1J/cubdlN+l2fKilckFM8yePjf0tE3uEbs1dojmKKYk+M5em8nWE7rSXo
         5mTzf+YvwaqWOj4nD0ZKDUFObEe890nw6lPwuSLyJ/OTCVvAmNagX8GcxlHbbbupnWv5
         QM4Vc4dwL6UOXyhwjodoq6zXHGfHB6ifYeLBmEHLp24LwDmvbS3whVFj7af3Fqmd/M8p
         ily9ZjLbODxQy6fM4N1J/B1Fonk0lGnfyRLFsx4tdrdAnoilY+hn/kuWOZRr4bm8550b
         DTkw==
X-Gm-Message-State: AOAM531gZSzCU8WM0t29emw3wZmxP52jHjrbCnot7SLOXxArGRwDUizo
        3MC91hKzzhwOOQqKpNyl41kxQg==
X-Google-Smtp-Source: ABdhPJwrUuR4xfw3ppxF+k8PiK8Tz/m8iuVhac/5vgw9ak5tNvg4B5bN1rFj/6nxyJRX+YJTHAGSwA==
X-Received: by 2002:a17:90b:228a:b0:1bc:7ca4:efaf with SMTP id kx10-20020a17090b228a00b001bc7ca4efafmr20262946pjb.245.1646108551356;
        Mon, 28 Feb 2022 20:22:31 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:786d:ffd4:ee63:5b33])
        by smtp.gmail.com with ESMTPSA id v189-20020a6389c6000000b00372e3b6fe90sm11877807pgd.55.2022.02.28.20.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 20:22:31 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3] media: hantro: Implement support for encoder commands
Date:   Tue,  1 Mar 2022 12:22:25 +0800
Message-Id: <20220301042225.1540019-1-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V4L2 stateful encoder uAPI specification requires that drivers
support the ENCODER_CMD ioctl to allow draining of buffers. This
however was not implemented, and causes issues for some userspace
applications.

Implement support for the ENCODER_CMD ioctl using v4l2-mem2mem helpers.
This is entirely based on existing code found in the vicodec test
driver.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---

Changes since v2:
- Dropped RFC tag
- Added Reviewed-by from Benjamin
- Replace direct access to vb->planes[i].bytesused with
  vb2_set_plane_payload()

Changes since v1:
- Correctly handle last buffers that are empty
- Correctly handle last buffers that just got queued
- Disable (TRY_)ENCODER_CMD ioctls for hantro decoder

This is based on linux-next-20220208, and was tested on RK3399 with
Gstreamer running the JPEG encoder. It was also tested on ChromeOS
5.10 on Kevin with the video encoder used in ChromeOS ARC, which
requires this. For ChromeOS, both encoder and decoder tests were run
to check for regressions.

Everything really works OK now, but since I'm not very familiar with
the mem2mem framework, I might be missing something, causing resource
leaks. Hence this patch is labeled RFC.

Last, I suppose we could also add support for (TRY_)DECODER_CMD now?

 drivers/staging/media/hantro/hantro_drv.c  | 17 +++++-
 drivers/staging/media/hantro/hantro_v4l2.c | 68 +++++++++++++++++++++-
 2 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index bc9bcb4eaf46..99bc650a5a93 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -56,6 +56,10 @@ dma_addr_t hantro_get_ref(struct hantro_ctx *ctx, u64 ts)
 	return hantro_get_dec_buf_addr(ctx, buf);
 }
 
+static const struct v4l2_event hantro_eos_event = {
+	.type = V4L2_EVENT_EOS
+};
+
 static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
 				    struct hantro_ctx *ctx,
 				    enum vb2_buffer_state result)
@@ -73,6 +77,12 @@ static void hantro_job_finish_no_pm(struct hantro_dev *vpu,
 	src->sequence = ctx->sequence_out++;
 	dst->sequence = ctx->sequence_cap++;
 
+	if (v4l2_m2m_is_last_draining_src_buf(ctx->fh.m2m_ctx, src)) {
+		dst->flags |= V4L2_BUF_FLAG_LAST;
+		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
+		v4l2_m2m_mark_stopped(ctx->fh.m2m_ctx);
+	}
+
 	v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev, ctx->fh.m2m_ctx,
 					 result);
 }
@@ -807,10 +817,13 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
 	snprintf(vfd->name, sizeof(vfd->name), "%s-%s", match->compatible,
 		 funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ? "enc" : "dec");
 
-	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER)
+	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
 		vpu->encoder = func;
-	else
+	} else {
 		vpu->decoder = func;
+		v4l2_disable_ioctl(vfd, VIDIOC_TRY_ENCODER_CMD);
+		v4l2_disable_ioctl(vfd, VIDIOC_ENCODER_CMD);
+	}
 
 	video_set_drvdata(vfd, vpu);
 
diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index 67148ba346f5..aa10ecd04c9c 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -628,6 +628,39 @@ static int vidioc_s_selection(struct file *file, void *priv,
 	return 0;
 }
 
+static const struct v4l2_event hantro_eos_event = {
+	.type = V4L2_EVENT_EOS
+};
+
+static int vidioc_encoder_cmd(struct file *file, void *priv,
+			      struct v4l2_encoder_cmd *ec)
+{
+	struct hantro_ctx *ctx = fh_to_ctx(priv);
+	int ret;
+
+	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, priv, ec);
+	if (ret < 0)
+		return ret;
+
+	if (!vb2_is_streaming(v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx)) ||
+	    !vb2_is_streaming(v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx)))
+		return 0;
+
+	ret = v4l2_m2m_ioctl_encoder_cmd(file, priv, ec);
+	if (ret < 0)
+		return ret;
+
+	if (ec->cmd == V4L2_ENC_CMD_STOP &&
+	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
+		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
+
+	if (ec->cmd == V4L2_ENC_CMD_START &&
+	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
+		vb2_clear_last_buffer_dequeued(&ctx->fh.m2m_ctx->cap_q_ctx.q);
+
+	return 0;
+}
+
 const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 	.vidioc_querycap = vidioc_querycap,
 	.vidioc_enum_framesizes = vidioc_enum_framesizes,
@@ -657,6 +690,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 
 	.vidioc_g_selection = vidioc_g_selection,
 	.vidioc_s_selection = vidioc_s_selection,
+
+	.vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
+	.vidioc_encoder_cmd = vidioc_encoder_cmd,
 };
 
 static int
@@ -733,8 +769,12 @@ static int hantro_buf_prepare(struct vb2_buffer *vb)
 	 * (for OUTPUT buffers, if userspace passes 0 bytesused, v4l2-core sets
 	 * it to buffer length).
 	 */
-	if (V4L2_TYPE_IS_CAPTURE(vq->type))
-		vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
+	if (V4L2_TYPE_IS_CAPTURE(vq->type)) {
+		if (ctx->is_encoder)
+			vb2_set_plane_payload(vb, 0, 0);
+		else
+			vb2_set_plane_payload(vb, 0, pix_fmt->plane_fmt[0].sizeimage);
+	}
 
 	return 0;
 }
@@ -744,6 +784,22 @@ static void hantro_buf_queue(struct vb2_buffer *vb)
 	struct hantro_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 
+	if (V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type) &&
+	    vb2_is_streaming(vb->vb2_queue) &&
+	    v4l2_m2m_dst_buf_is_last(ctx->fh.m2m_ctx)) {
+		unsigned int i;
+
+		for (i = 0; i < vb->num_planes; i++)
+			vb2_set_plane_payload(vb, i, 0);
+
+		vbuf->field = V4L2_FIELD_NONE;
+		vbuf->sequence = ctx->sequence_cap++;
+
+		v4l2_m2m_last_buffer_done(ctx->fh.m2m_ctx, vbuf);
+		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
+		return;
+	}
+
 	v4l2_m2m_buf_queue(ctx->fh.m2m_ctx, vbuf);
 }
 
@@ -759,6 +815,8 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
 	struct hantro_ctx *ctx = vb2_get_drv_priv(q);
 	int ret = 0;
 
+	v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
+
 	if (V4L2_TYPE_IS_OUTPUT(q->type))
 		ctx->sequence_out = 0;
 	else
@@ -831,6 +889,12 @@ static void hantro_stop_streaming(struct vb2_queue *q)
 		hantro_return_bufs(q, v4l2_m2m_src_buf_remove);
 	else
 		hantro_return_bufs(q, v4l2_m2m_dst_buf_remove);
+
+	v4l2_m2m_update_stop_streaming_state(ctx->fh.m2m_ctx, q);
+
+	if (V4L2_TYPE_IS_OUTPUT(q->type) &&
+	    v4l2_m2m_has_stopped(ctx->fh.m2m_ctx))
+		v4l2_event_queue_fh(&ctx->fh, &hantro_eos_event);
 }
 
 static void hantro_buf_request_complete(struct vb2_buffer *vb)
-- 
2.35.1.574.g5d30c73bfb-goog

