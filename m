Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF8B4AD700
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356461AbiBHLbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356700AbiBHKzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:55:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEA5C03FEC5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:55:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so1711477pja.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpFe2MD1E+2DPoXg543PglALXj4OP+/vcuv1a1idPqs=;
        b=deOHRpDN7/U/V2+1GsKT9q4cej3QCC1mv9oreCRy2yqCzqwof20GqvzEGli/OdHxZp
         XbF3QBT3Th2t6JVa2oGczJxri5/zN1rZQOLve5TxfB5GgIpK5tzEM08Ad2tDnXi2n3L1
         QkJwk/5mWQ/oqiRINLAHiGlQgQye9NmBNdHJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpFe2MD1E+2DPoXg543PglALXj4OP+/vcuv1a1idPqs=;
        b=HVKExAxQJBwESMYO9BCKVlyxwgPrNilIMxig2EtMz8AuZZwIXNEW8axSx2xm7Jp2Py
         vHGW0ppHdybmuwK0wKaAQZ+184AIFkPPOhbTvi+CywjcxL7lkk5kNNuj40+Z0QMTo2a2
         JYrD3EmQ0uEFg7qVdWWCCKKNz/Z4/3h3C+YMUg7F2pqUUwFsUH+8vBDIZnHhGNTi2xPS
         +BnMkzIDx4TFaGLbBgdstWOgGMCbm+Xnx7WcMfin1w0ZQ5ES9HY1pB6ofbGM/d00rMf7
         d+8uCF0hrCevK8JQxh5PDR1zF2BewSSw8QY1rznGjZ7uTdgzzkIhVvtn7A5EWgwm2tpA
         AG/g==
X-Gm-Message-State: AOAM531PJVucd4w5NyBSqTu/++chYm7R671Kfi/LKluVO9saG47/dFi7
        2EytcYUOEPWAMb2+cSmtSve0bA==
X-Google-Smtp-Source: ABdhPJzxCELfUQ71vOBWo/X6NxZxybbY8TJpqWcbbxZ9oEXImbmiUN5OoLbviGkL9g1oIynidlrpnw==
X-Received: by 2002:a17:902:dcca:: with SMTP id t10mr3844961pll.133.1644317702158;
        Tue, 08 Feb 2022 02:55:02 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id e17sm14907277pfv.101.2022.02.08.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 02:55:01 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] media: hantro: Implement support for encoder commands
Date:   Tue,  8 Feb 2022 18:54:56 +0800
Message-Id: <20220208105456.321294-1-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
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

This is based on linux-next-20220207, and was tested on RK3399 with
Gstreamer running the JPEG encoder. It was also tested on ChromeOS
5.10 on Kevin with the video encoder used in ChromeOS ARC, which
requires this.

Everything works OK, but since I'm not very familiar with the mem2mem
framework, I might be missing something, causing resource leaks.
Hence this patch is labeled RFC.

---
 drivers/staging/media/hantro/hantro_drv.c  | 10 +++++
 drivers/staging/media/hantro/hantro_v4l2.c | 44 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index bc9bcb4eaf46..ccd47eee5c43 100644
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
diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index 67148ba346f5..8c6746637236 100644
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
@@ -759,6 +795,8 @@ static int hantro_start_streaming(struct vb2_queue *q, unsigned int count)
 	struct hantro_ctx *ctx = vb2_get_drv_priv(q);
 	int ret = 0;
 
+	v4l2_m2m_update_start_streaming_state(ctx->fh.m2m_ctx, q);
+
 	if (V4L2_TYPE_IS_OUTPUT(q->type))
 		ctx->sequence_out = 0;
 	else
@@ -831,6 +869,12 @@ static void hantro_stop_streaming(struct vb2_queue *q)
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
2.35.0.263.gb82422642f-goog

