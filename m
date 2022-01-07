Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4DD4874C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbiAGJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346479AbiAGJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:35:13 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32199C061201
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:35:13 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v11so4759877pfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 01:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fe9aQW7jz0VGEONUJ5z1DrjWxT1OIztb1XWdXZDSPNg=;
        b=NwwyeKVtKzoMNHmg/1q0PNzxkyI5g1gyfsTHuh2+toRPeLWfE4WZ31zxRivtN2C93g
         0dU8ep5k/ailksHSXXCTTeuNiND0yhpl2moXXAoEGOH5kIX2FbTKP04eE39GEfm0nMRw
         hLEw2OzksH+FlNAZiXCgXrcEnyxxSxbH+CiSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fe9aQW7jz0VGEONUJ5z1DrjWxT1OIztb1XWdXZDSPNg=;
        b=K2QwsKET9/OUW3dC+Uiyez/omQBs8fcxfvdIUTRY+60dS2axTnLssSl16a1OGaPQuy
         jFjEUObCojggDGXxatTXnXK/Hv6jADrJoZousq+I5OjA6+TTTjOGmN3AUOUUDGcrAPrC
         es7u3Elgazi35P9GlGOkFvPznt+SocbMHHXvG3LVRHCwnzv5y6EgKcI02NiULEADcc30
         21XGZwvOH3fLb6WkjWjDen4yNevHRdgAIjcXxrs/lNcZgEoSaiX4zDM9JO+4u2nlEYlO
         BsqFWNeYjhLx5wpS8veD5Ujez557TbrG+19qsITtEV7ZLt0O3tBiJCX1UKhxIzF4KFYg
         iemw==
X-Gm-Message-State: AOAM530fCGjL7d9Vmu9W4PnjGD3/6A0Mx5aEEi4l5AnFe0vvI+zcq3NV
        90fFoxKCTib5FOpf9mAj5U0WrA==
X-Google-Smtp-Source: ABdhPJwdIDA+rs2APgRrqRGJnKojeh8QR+AmENi1o9ERFrKAtjPteIY9Kslt41WoY6K9W1WXw0LGfA==
X-Received: by 2002:a62:150f:0:b0:4ba:bac8:e8c5 with SMTP id 15-20020a62150f000000b004babac8e8c5mr63576510pfv.22.1641548112623;
        Fri, 07 Jan 2022 01:35:12 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8f6b:ee:64d8:ae81])
        by smtp.gmail.com with ESMTPSA id j17sm5269192pfu.77.2022.01.07.01.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 01:35:12 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT v2 3/8] media: hantro: Support cropping visible area for encoders
Date:   Fri,  7 Jan 2022 17:34:50 +0800
Message-Id: <20220107093455.73766-4-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107093455.73766-1-wenst@chromium.org>
References: <20220107093455.73766-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encoders typically operate on macroblocks. Thus their output or coded
resolution is constrained to multiples of macroblocks. For frame sizes
not aligned to macroblocks, cropping is needed to limit the visible
area of the frame.

Add support for cropping on the output (source) side for encoders,
using the selection API.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/staging/media/hantro/TODO             |  3 -
 .../staging/media/hantro/hantro_h1_jpeg_enc.c | 17 +++-
 drivers/staging/media/hantro/hantro_v4l2.c    | 77 +++++++++++++++++++
 .../media/hantro/rockchip_vpu2_hw_jpeg_enc.c  | 17 ++--
 4 files changed, 101 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/media/hantro/TODO b/drivers/staging/media/hantro/TODO
index fa0c94057007..da181dc93069 100644
--- a/drivers/staging/media/hantro/TODO
+++ b/drivers/staging/media/hantro/TODO
@@ -5,9 +5,6 @@
 
   For this reason, we are keeping this driver in staging for now.
 
-* Add support for the S_SELECTION API.
-  See the comment for VEPU_REG_ENC_OVER_FILL_STRM_OFFSET.
-
 * Instead of having a DMA bounce buffer, it could be possible to use a
   normal buffer and memmove() the payload to make space for the header.
   This might need to use extra JPEG markers for padding reasons.
diff --git a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
index 96153c755fb8..9104973af8df 100644
--- a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
+++ b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
@@ -18,12 +18,21 @@
 static void hantro_h1_set_src_img_ctrl(struct hantro_dev *vpu,
 				       struct hantro_ctx *ctx)
 {
-	struct v4l2_pix_format_mplane *pix_fmt = &ctx->src_fmt;
+	u32 overfill_r, overfill_b;
 	u32 reg;
 
-	reg = H1_REG_IN_IMG_CTRL_ROW_LEN(pix_fmt->width)
-		| H1_REG_IN_IMG_CTRL_OVRFLR_D4(0)
-		| H1_REG_IN_IMG_CTRL_OVRFLB(0)
+	/*
+	 * The format width and height are already macroblock aligned
+	 * by .vidioc_s_fmt_vid_cap_mplane() callback. Destination
+	 * format width and height can be further modified by
+	 * .vidioc_s_selection(), and the width is 4-aligned.
+	 */
+	overfill_r = ctx->src_fmt.width - ctx->dst_fmt.width;
+	overfill_b = ctx->src_fmt.height - ctx->dst_fmt.height;
+
+	reg = H1_REG_IN_IMG_CTRL_ROW_LEN(ctx->src_fmt.width)
+		| H1_REG_IN_IMG_CTRL_OVRFLR_D4(overfill_r / 4)
+		| H1_REG_IN_IMG_CTRL_OVRFLB(overfill_b)
 		| H1_REG_IN_IMG_CTRL_FMT(ctx->vpu_src_fmt->enc_fmt);
 	vepu_write_relaxed(vpu, reg, H1_REG_IN_IMG_CTRL);
 }
diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index e595905b3bd7..67148ba346f5 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -554,6 +554,80 @@ vidioc_s_fmt_cap_mplane(struct file *file, void *priv, struct v4l2_format *f)
 	return hantro_set_fmt_cap(fh_to_ctx(priv), &f->fmt.pix_mp);
 }
 
+static int vidioc_g_selection(struct file *file, void *priv,
+			      struct v4l2_selection *sel)
+{
+	struct hantro_ctx *ctx = fh_to_ctx(priv);
+
+	/* Crop only supported on source. */
+	if (!ctx->is_encoder ||
+	    sel->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
+		return -EINVAL;
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = ctx->src_fmt.width;
+		sel->r.height = ctx->src_fmt.height;
+		break;
+	case V4L2_SEL_TGT_CROP:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = ctx->dst_fmt.width;
+		sel->r.height = ctx->dst_fmt.height;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vidioc_s_selection(struct file *file, void *priv,
+			      struct v4l2_selection *sel)
+{
+	struct hantro_ctx *ctx = fh_to_ctx(priv);
+	struct v4l2_rect *rect = &sel->r;
+	struct vb2_queue *vq;
+
+	/* Crop only supported on source. */
+	if (!ctx->is_encoder ||
+	    sel->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
+		return -EINVAL;
+
+	/* Change not allowed if the queue is streaming. */
+	vq = v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx);
+	if (vb2_is_streaming(vq))
+		return -EBUSY;
+
+	if (sel->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	/*
+	 * We do not support offsets, and we can crop only inside
+	 * right-most or bottom-most macroblocks.
+	 */
+	if (rect->left != 0 || rect->top != 0 ||
+	    round_up(rect->width, MB_DIM) != ctx->src_fmt.width ||
+	    round_up(rect->height, MB_DIM) != ctx->src_fmt.height) {
+		/* Default to full frame for incorrect settings. */
+		rect->left = 0;
+		rect->top = 0;
+		rect->width = ctx->src_fmt.width;
+		rect->height = ctx->src_fmt.height;
+	} else {
+		/* We support widths aligned to 4 pixels and arbitrary heights. */
+		rect->width = round_up(rect->width, 4);
+	}
+
+	ctx->dst_fmt.width = rect->width;
+	ctx->dst_fmt.height = rect->height;
+
+	return 0;
+}
+
 const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 	.vidioc_querycap = vidioc_querycap,
 	.vidioc_enum_framesizes = vidioc_enum_framesizes,
@@ -580,6 +654,9 @@ const struct v4l2_ioctl_ops hantro_ioctl_ops = {
 
 	.vidioc_streamon = v4l2_m2m_ioctl_streamon,
 	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
+
+	.vidioc_g_selection = vidioc_g_selection,
+	.vidioc_s_selection = vidioc_s_selection,
 };
 
 static int
diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
index b931fc5fa1a9..da275568874a 100644
--- a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
+++ b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
@@ -35,18 +35,23 @@
 static void rockchip_vpu2_set_src_img_ctrl(struct hantro_dev *vpu,
 					   struct hantro_ctx *ctx)
 {
-	struct v4l2_pix_format_mplane *pix_fmt = &ctx->src_fmt;
+	u32 overfill_r, overfill_b;
 	u32 reg;
 
 	/*
-	 * The pix fmt width/height are already macroblock aligned
-	 * by .vidioc_s_fmt_vid_cap_mplane() callback
+	 * The format width and height are already macroblock aligned
+	 * by .vidioc_s_fmt_vid_cap_mplane() callback. Destination
+	 * format width and height can be further modified by
+	 * .vidioc_s_selection(), and the width is 4-aligned.
 	 */
-	reg = VEPU_REG_IN_IMG_CTRL_ROW_LEN(pix_fmt->width);
+	overfill_r = ctx->src_fmt.width - ctx->dst_fmt.width;
+	overfill_b = ctx->src_fmt.height - ctx->dst_fmt.height;
+
+	reg = VEPU_REG_IN_IMG_CTRL_ROW_LEN(ctx->src_fmt.width);
 	vepu_write_relaxed(vpu, reg, VEPU_REG_INPUT_LUMA_INFO);
 
-	reg = VEPU_REG_IN_IMG_CTRL_OVRFLR_D4(0) |
-	      VEPU_REG_IN_IMG_CTRL_OVRFLB(0);
+	reg = VEPU_REG_IN_IMG_CTRL_OVRFLR_D4(overfill_r / 4) |
+	      VEPU_REG_IN_IMG_CTRL_OVRFLB(overfill_b);
 	/*
 	 * This register controls the input crop, as the offset
 	 * from the right/bottom within the last macroblock. The offset from the
-- 
2.34.1.575.g55b058a8bb-goog

