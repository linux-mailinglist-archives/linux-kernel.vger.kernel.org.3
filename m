Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF4F4ED6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiCaJVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiCaJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:21:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD80211C1B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:19:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bx5so23473918pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEtBuQMfA8FwFYowFJek6SiJSS2Ba4i87djesSoQlLI=;
        b=Jq7Kg+D24f92UakuJsPWv3qmBcxrbpJrzPfifmbHO24FuxsUkpuFB+fhPg3MQdVf3h
         Omo7xmZqepLNvf8iScixSS3ThMqnVnk2EvwXxwUA6jms8yTWCDUR1iwA2XUXoQaBVJvY
         DRhlKwGBOmYU2jaiVG0mb26IUqPV8df7FFQzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qEtBuQMfA8FwFYowFJek6SiJSS2Ba4i87djesSoQlLI=;
        b=R5QTvzERfCuTG/U35FIp4Dr16100c7sWiTkPpDYDTclurJSTOBo7i8Uk9Mg0cz3cuL
         UdkX386T6XmqtsF6Z2MqMC46MtkXPI2T5xniRY8s7/fsrFIK3owHheBsj383V2d42dLU
         Msc7lXMvJCVBi+xRsFrnCTTnYE2yz8y8yGDChc9bD8HZRzrFeKMV9+n5cq4VMmmSuBPb
         rcK++889hRP6TuQV+jAX6GP2ZFYDUl6YLZf1Mtmoxi63lB5rbG9rOa88rQQ/cKWF3rDw
         JWYR6/uAShBH+bOodVteCGEtYo0YbNhx7rFxDjT8g/xlc7d9I/C2TrVadMOXclnJYDYd
         PMgw==
X-Gm-Message-State: AOAM531UhzZhYzWtDa2zI6TsMBj7H0mVXpc5vxVZZ4VgBg7PSq+415iz
        Efc6Vmn35PF1I2V/P7lFbb9Q5Q==
X-Google-Smtp-Source: ABdhPJxZaMDtDNOVsjPVDNd4PnF5gsbyPisvnVDKHLAYGNOgfDKQx144tzefNTa9mvjNJwGOKgIhGA==
X-Received: by 2002:a17:902:a60f:b0:155:efbf:1291 with SMTP id u15-20020a170902a60f00b00155efbf1291mr25707200plq.152.1648718369279;
        Thu, 31 Mar 2022 02:19:29 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:deb3:b2d3:c33d:e877])
        by smtp.gmail.com with ESMTPSA id w63-20020a638242000000b0038631169c02sm20616846pgd.57.2022.03.31.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:19:28 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4] media: hantro: Implement support for encoder commands
Date:   Thu, 31 Mar 2022 17:16:28 +0800
Message-Id: <20220331091628.641915-1-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
---

This version was tested on RK3399 on mainline with fluster and gstreamer.
Fluster test scores for VP8 decoding remain the same. Gstreamer jpeg
encoding works without stalling or outputing extra frames.

For stress testing, fluster by itself already runs six jobs concurrently.
At the same time, I also spawn a half-dozen gstreamer encoding jobs:

    gst-launch-1.0 videotestsrc num-buffers=2000 ! v4l2jpegenc ! fakesink

It was also backported onto ChromeOS 5.10, and tested on kevin.

Everything seems to work ok, without anything stalling.

Changes since v3:
- Split out unrelated change into separate patch [1]
- Dropped invalid .has_stopped check after v4l2_m2m_ioctl_encoder_cmd()
  was called. Issue raised by Ezequiel.
- Dropped reviewed-by from Benjamin due to code changes

[1] https://lore.kernel.org/linux-media/20220331084907.628349-1-wenst@chromium.org/

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

 drivers/staging/media/hantro/hantro_drv.c  | 17 ++++++-
 drivers/staging/media/hantro/hantro_v4l2.c | 59 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index dc768884cb79..bd7d11032c94 100644
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
@@ -809,10 +819,13 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
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
index 261beb0c40f6..71a6279750bf 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -628,6 +628,38 @@ static int vidioc_s_selection(struct file *file, void *priv,
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
+	if (ec->cmd == V4L2_ENC_CMD_START)
+		vb2_clear_last_buffer_dequeued(&ctx->fh.m2m_ctx->cap_q_ctx.q);
+
+	return 0;
+}
+
 const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 	.vidioc_querycap = vidioc_querycap,
 	.vidioc_enum_framesizes = vidioc_enum_framesizes,
@@ -657,6 +689,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 
 	.vidioc_g_selection = vidioc_g_selection,
 	.vidioc_s_selection = vidioc_s_selection,
+
+	.vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
+	.vidioc_encoder_cmd = vidioc_encoder_cmd,
 };
 
 static int
@@ -748,6 +783,22 @@ static void hantro_buf_queue(struct vb2_buffer *vb)
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
 
@@ -763,6 +814,8 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
 	struct hantro_ctx *ctx = vb2_get_drv_priv(q);
 	int ret = 0;
 
+	v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
+
 	if (V4L2_TYPE_IS_OUTPUT(q->type))
 		ctx->sequence_out = 0;
 	else
@@ -835,6 +888,12 @@ static void hantro_stop_streaming(struct vb2_queue *q)
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
2.35.1.1021.g381101b075-goog

