Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA114874D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346559AbiAGJfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346540AbiAGJfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:35:23 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A30C034004
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:35:22 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i30so5047477pgl.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 01:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMIgs6JV3qr3mO9HXJgs5H5mxHze2FFqWn2TBOXwrrE=;
        b=fTtqxVOBMqmnaQlz1V4JE09u5aL+IQphLZ4c2+1LsMT+GivwwxXN1DeOCWMA1ZITEs
         Ex3IiEv6TOcBFh+38J5dqeXUOcSsASPV2FWZj2j5wHpa3oWqG0luecpiPN7GSt/pKKtm
         0scw3uAMFxBKtvCoU6pHTtWWLRqkHLpVpyUpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMIgs6JV3qr3mO9HXJgs5H5mxHze2FFqWn2TBOXwrrE=;
        b=1KFFln17ZLOE0cjZBZ2NYGadXhVvv6u+PeQJ587wMIwnQbiHrCsIQhbNUcOFOj9hUp
         K2OZ1KZiHraaxa3voty4T/RY0I3JZZLictzoMa13OL7T6avzoKZnPUUGAlBUmlnPZsb8
         u3ARiWIR6aUSJ9/kGF0lDR7TsXJaH4sQb7YB63y8rTdABSrr2AfmAVYGSoLCwhJmknFT
         j+OO1ztfRdbZFKWROg+XeyC3sF8+A5uC8rzLaeKLFPf7D/qmQCQXm7C4gfqfo/AHZizJ
         zgUoxlcJj//ve7dPN6hZO+0C1ZTY7sTYCjSdmHLcCGUo5uWHfhdPwHR0uy7lUIaeB45o
         0zAg==
X-Gm-Message-State: AOAM532Z5n+owA4yxi25a86AeXZRRFkc0T5KTXERQlaUHURqIcMz3KZD
        kpWhbqcgfJwBxCZnAycfH1XuAA==
X-Google-Smtp-Source: ABdhPJzEWFAy9PZ8q8sfbf4R3+dIbdNTfJQGlQCKHmWDmuapid1M6NXZ1CX89TlsHmr046bon70/kQ==
X-Received: by 2002:a62:1642:0:b0:4bb:b3b6:c037 with SMTP id 63-20020a621642000000b004bbb3b6c037mr58631309pfw.50.1641548121657;
        Fri, 07 Jan 2022 01:35:21 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8f6b:ee:64d8:ae81])
        by smtp.gmail.com with ESMTPSA id j17sm5269192pfu.77.2022.01.07.01.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 01:35:21 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT v2 7/8] media: hantro: output encoded JPEG content directly to capture buffers
Date:   Fri,  7 Jan 2022 17:34:54 +0800
Message-Id: <20220107093455.73766-8-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107093455.73766-1-wenst@chromium.org>
References: <20220107093455.73766-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the JPEG header length is aligned with bus access boundaries,
the JPEG encoder can output to the capture buffers directly without
going through a bounce buffer.

Do just that, and get rid of all the bounce buffer related code.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/staging/media/hantro/TODO             |  4 ---
 drivers/staging/media/hantro/hantro.h         |  1 -
 drivers/staging/media/hantro/hantro_drv.c     | 20 +++++--------
 .../staging/media/hantro/hantro_h1_jpeg_enc.c | 24 ++++++++--------
 drivers/staging/media/hantro/hantro_hw.h      | 11 --------
 drivers/staging/media/hantro/hantro_jpeg.c    | 28 -------------------
 .../media/hantro/rockchip_vpu2_hw_jpeg_enc.c  | 27 ++++++++++--------
 .../staging/media/hantro/rockchip_vpu_hw.c    |  6 ----
 8 files changed, 34 insertions(+), 87 deletions(-)

diff --git a/drivers/staging/media/hantro/TODO b/drivers/staging/media/hantro/TODO
index da181dc93069..1d7fed936019 100644
--- a/drivers/staging/media/hantro/TODO
+++ b/drivers/staging/media/hantro/TODO
@@ -4,7 +4,3 @@
   the uABI, it will be required to have the driver in staging.
 
   For this reason, we are keeping this driver in staging for now.
-
-* Instead of having a DMA bounce buffer, it could be possible to use a
-  normal buffer and memmove() the payload to make space for the header.
-  This might need to use extra JPEG markers for padding reasons.
diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
index 06d0f3597694..357f83b86809 100644
--- a/drivers/staging/media/hantro/hantro.h
+++ b/drivers/staging/media/hantro/hantro.h
@@ -259,7 +259,6 @@ struct hantro_ctx {
 	/* Specific for particular codec modes. */
 	union {
 		struct hantro_h264_dec_hw_ctx h264_dec;
-		struct hantro_jpeg_enc_hw_ctx jpeg_enc;
 		struct hantro_mpeg2_dec_hw_ctx mpeg2_dec;
 		struct hantro_vp8_dec_hw_ctx vp8_dec;
 		struct hantro_hevc_dec_hw_ctx hevc_dec;
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index b376b9d94b01..bc9bcb4eaf46 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -219,21 +219,15 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 	if (ret)
 		return ret;
 
+	dst_vq->bidirectional = true;
+	dst_vq->mem_ops = &vb2_dma_contig_memops;
+	dst_vq->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES;
 	/*
-	 * When encoding, the CAPTURE queue doesn't need dma memory,
-	 * as the CPU needs to create the JPEG frames, from the
-	 * hardware-produced JPEG payload.
-	 *
-	 * For the DMA destination buffer, we use a bounce buffer.
+	 * The Kernel needs access to the JPEG destination buffer for the
+	 * JPEG encoder to fill in the JPEG headers.
 	 */
-	if (ctx->is_encoder) {
-		dst_vq->mem_ops = &vb2_vmalloc_memops;
-	} else {
-		dst_vq->bidirectional = true;
-		dst_vq->mem_ops = &vb2_dma_contig_memops;
-		dst_vq->dma_attrs = DMA_ATTR_ALLOC_SINGLE_PAGES |
-				    DMA_ATTR_NO_KERNEL_MAPPING;
-	}
+	if (!ctx->is_encoder)
+		dst_vq->dma_attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
diff --git a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
index 9104973af8df..54d2ffbb2637 100644
--- a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
+++ b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
@@ -39,17 +39,23 @@ static void hantro_h1_set_src_img_ctrl(struct hantro_dev *vpu,
 
 static void hantro_h1_jpeg_enc_set_buffers(struct hantro_dev *vpu,
 					   struct hantro_ctx *ctx,
-					   struct vb2_buffer *src_buf)
+					   struct vb2_buffer *src_buf,
+					   struct vb2_buffer *dst_buf)
 {
 	struct v4l2_pix_format_mplane *pix_fmt = &ctx->src_fmt;
 	dma_addr_t src[3];
+	u32 size_left;
+
+	size_left = vb2_plane_size(dst_buf, 0) - ctx->vpu_dst_fmt->header_size;
+	if (WARN_ON(vb2_plane_size(dst_buf, 0) < ctx->vpu_dst_fmt->header_size))
+		size_left = 0;
 
 	WARN_ON(pix_fmt->num_planes > 3);
 
-	vepu_write_relaxed(vpu, ctx->jpeg_enc.bounce_buffer.dma,
+	vepu_write_relaxed(vpu, vb2_dma_contig_plane_dma_addr(dst_buf, 0) +
+				ctx->vpu_dst_fmt->header_size,
 			   H1_REG_ADDR_OUTPUT_STREAM);
-	vepu_write_relaxed(vpu, ctx->jpeg_enc.bounce_buffer.size,
-			   H1_REG_STR_BUF_LIMIT);
+	vepu_write_relaxed(vpu, size_left, H1_REG_STR_BUF_LIMIT);
 
 	if (pix_fmt->num_planes == 1) {
 		src[0] = vb2_dma_contig_plane_dma_addr(src_buf, 0);
@@ -121,7 +127,8 @@ int hantro_h1_jpeg_enc_run(struct hantro_ctx *ctx)
 			   H1_REG_ENC_CTRL);
 
 	hantro_h1_set_src_img_ctrl(vpu, ctx);
-	hantro_h1_jpeg_enc_set_buffers(vpu, ctx, &src_buf->vb2_buf);
+	hantro_h1_jpeg_enc_set_buffers(vpu, ctx, &src_buf->vb2_buf,
+				       &dst_buf->vb2_buf);
 	hantro_h1_jpeg_enc_set_qtable(vpu, jpeg_ctx.hw_luma_qtable,
 				      jpeg_ctx.hw_chroma_qtable);
 
@@ -153,13 +160,6 @@ void hantro_h1_jpeg_enc_done(struct hantro_ctx *ctx)
 	u32 bytesused = vepu_read(vpu, H1_REG_STR_BUF_LIMIT) / 8;
 	struct vb2_v4l2_buffer *dst_buf = hantro_get_dst_buf(ctx);
 
-	/*
-	 * TODO: Rework the JPEG encoder to eliminate the need
-	 * for a bounce buffer.
-	 */
-	memcpy(vb2_plane_vaddr(&dst_buf->vb2_buf, 0) +
-	       ctx->vpu_dst_fmt->header_size,
-	       ctx->jpeg_enc.bounce_buffer.cpu, bytesused);
 	vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
 			      ctx->vpu_dst_fmt->header_size + bytesused);
 }
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index 4a19ae8940b9..c1fd807bc090 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -43,15 +43,6 @@ struct hantro_aux_buf {
 	unsigned long attrs;
 };
 
-/**
- * struct hantro_jpeg_enc_hw_ctx
- *
- * @bounce_buffer:	Bounce buffer
- */
-struct hantro_jpeg_enc_hw_ctx {
-	struct hantro_aux_buf bounce_buffer;
-};
-
 /* Max. number of entries in the DPB (HW limitation). */
 #define HANTRO_H264_DPB_SIZE		16
 
@@ -327,8 +318,6 @@ void hantro_g1_reset(struct hantro_ctx *ctx);
 
 int hantro_h1_jpeg_enc_run(struct hantro_ctx *ctx);
 int rockchip_vpu2_jpeg_enc_run(struct hantro_ctx *ctx);
-int hantro_jpeg_enc_init(struct hantro_ctx *ctx);
-void hantro_jpeg_enc_exit(struct hantro_ctx *ctx);
 void hantro_h1_jpeg_enc_done(struct hantro_ctx *ctx);
 void rockchip_vpu2_jpeg_enc_done(struct hantro_ctx *ctx);
 
diff --git a/drivers/staging/media/hantro/hantro_jpeg.c b/drivers/staging/media/hantro/hantro_jpeg.c
index e63eeef3952d..84d3f0bfff00 100644
--- a/drivers/staging/media/hantro/hantro_jpeg.c
+++ b/drivers/staging/media/hantro/hantro_jpeg.c
@@ -9,7 +9,6 @@
 
 #include <linux/align.h>
 #include <linux/build_bug.h>
-#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include "hantro_jpeg.h"
@@ -339,30 +338,3 @@ void hantro_jpeg_header_assemble(struct hantro_jpeg_ctx *ctx)
 
 	jpeg_set_quality(ctx);
 }
-
-int hantro_jpeg_enc_init(struct hantro_ctx *ctx)
-{
-	ctx->jpeg_enc.bounce_buffer.size =
-		ctx->dst_fmt.plane_fmt[0].sizeimage -
-		ctx->vpu_dst_fmt->header_size;
-
-	ctx->jpeg_enc.bounce_buffer.cpu =
-		dma_alloc_attrs(ctx->dev->dev,
-				ctx->jpeg_enc.bounce_buffer.size,
-				&ctx->jpeg_enc.bounce_buffer.dma,
-				GFP_KERNEL,
-				DMA_ATTR_ALLOC_SINGLE_PAGES);
-	if (!ctx->jpeg_enc.bounce_buffer.cpu)
-		return -ENOMEM;
-
-	return 0;
-}
-
-void hantro_jpeg_enc_exit(struct hantro_ctx *ctx)
-{
-	dma_free_attrs(ctx->dev->dev,
-		       ctx->jpeg_enc.bounce_buffer.size,
-		       ctx->jpeg_enc.bounce_buffer.cpu,
-		       ctx->jpeg_enc.bounce_buffer.dma,
-		       DMA_ATTR_ALLOC_SINGLE_PAGES);
-}
diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
index da275568874a..d0ae0f14b61e 100644
--- a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
+++ b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
@@ -66,17 +66,23 @@ static void rockchip_vpu2_set_src_img_ctrl(struct hantro_dev *vpu,
 
 static void rockchip_vpu2_jpeg_enc_set_buffers(struct hantro_dev *vpu,
 					       struct hantro_ctx *ctx,
-					       struct vb2_buffer *src_buf)
+					       struct vb2_buffer *src_buf,
+					       struct vb2_buffer *dst_buf)
 {
 	struct v4l2_pix_format_mplane *pix_fmt = &ctx->src_fmt;
 	dma_addr_t src[3];
+	u32 size_left;
+
+	size_left = vb2_plane_size(dst_buf, 0) - ctx->vpu_dst_fmt->header_size;
+	if (WARN_ON(vb2_plane_size(dst_buf, 0) < ctx->vpu_dst_fmt->header_size))
+		size_left = 0;
 
 	WARN_ON(pix_fmt->num_planes > 3);
 
-	vepu_write_relaxed(vpu, ctx->jpeg_enc.bounce_buffer.dma,
+	vepu_write_relaxed(vpu, vb2_dma_contig_plane_dma_addr(dst_buf, 0) +
+				ctx->vpu_dst_fmt->header_size,
 			   VEPU_REG_ADDR_OUTPUT_STREAM);
-	vepu_write_relaxed(vpu, ctx->jpeg_enc.bounce_buffer.size,
-			   VEPU_REG_STR_BUF_LIMIT);
+	vepu_write_relaxed(vpu, size_left, VEPU_REG_STR_BUF_LIMIT);
 
 	if (pix_fmt->num_planes == 1) {
 		src[0] = vb2_dma_contig_plane_dma_addr(src_buf, 0);
@@ -137,6 +143,9 @@ int rockchip_vpu2_jpeg_enc_run(struct hantro_ctx *ctx)
 
 	memset(&jpeg_ctx, 0, sizeof(jpeg_ctx));
 	jpeg_ctx.buffer = vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
+	if (!jpeg_ctx.buffer)
+		return -ENOMEM;
+
 	jpeg_ctx.width = ctx->dst_fmt.width;
 	jpeg_ctx.height = ctx->dst_fmt.height;
 	jpeg_ctx.quality = ctx->jpeg_quality;
@@ -147,7 +156,8 @@ int rockchip_vpu2_jpeg_enc_run(struct hantro_ctx *ctx)
 			   VEPU_REG_ENCODE_START);
 
 	rockchip_vpu2_set_src_img_ctrl(vpu, ctx);
-	rockchip_vpu2_jpeg_enc_set_buffers(vpu, ctx, &src_buf->vb2_buf);
+	rockchip_vpu2_jpeg_enc_set_buffers(vpu, ctx, &src_buf->vb2_buf,
+					   &dst_buf->vb2_buf);
 	rockchip_vpu2_jpeg_enc_set_qtable(vpu, jpeg_ctx.hw_luma_qtable,
 					  jpeg_ctx.hw_chroma_qtable);
 
@@ -181,13 +191,6 @@ void rockchip_vpu2_jpeg_enc_done(struct hantro_ctx *ctx)
 	u32 bytesused = vepu_read(vpu, VEPU_REG_STR_BUF_LIMIT) / 8;
 	struct vb2_v4l2_buffer *dst_buf = hantro_get_dst_buf(ctx);
 
-	/*
-	 * TODO: Rework the JPEG encoder to eliminate the need
-	 * for a bounce buffer.
-	 */
-	memcpy(vb2_plane_vaddr(&dst_buf->vb2_buf, 0) +
-	       ctx->vpu_dst_fmt->header_size,
-	       ctx->jpeg_enc.bounce_buffer.cpu, bytesused);
 	vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
 			      ctx->vpu_dst_fmt->header_size + bytesused);
 }
diff --git a/drivers/staging/media/hantro/rockchip_vpu_hw.c b/drivers/staging/media/hantro/rockchip_vpu_hw.c
index c203b606e6e7..163cf92eafca 100644
--- a/drivers/staging/media/hantro/rockchip_vpu_hw.c
+++ b/drivers/staging/media/hantro/rockchip_vpu_hw.c
@@ -343,9 +343,7 @@ static const struct hantro_codec_ops rk3066_vpu_codec_ops[] = {
 	[HANTRO_MODE_JPEG_ENC] = {
 		.run = hantro_h1_jpeg_enc_run,
 		.reset = rockchip_vpu1_enc_reset,
-		.init = hantro_jpeg_enc_init,
 		.done = hantro_h1_jpeg_enc_done,
-		.exit = hantro_jpeg_enc_exit,
 	},
 	[HANTRO_MODE_H264_DEC] = {
 		.run = hantro_g1_h264_dec_run,
@@ -371,9 +369,7 @@ static const struct hantro_codec_ops rk3288_vpu_codec_ops[] = {
 	[HANTRO_MODE_JPEG_ENC] = {
 		.run = hantro_h1_jpeg_enc_run,
 		.reset = rockchip_vpu1_enc_reset,
-		.init = hantro_jpeg_enc_init,
 		.done = hantro_h1_jpeg_enc_done,
-		.exit = hantro_jpeg_enc_exit,
 	},
 	[HANTRO_MODE_H264_DEC] = {
 		.run = hantro_g1_h264_dec_run,
@@ -399,9 +395,7 @@ static const struct hantro_codec_ops rk3399_vpu_codec_ops[] = {
 	[HANTRO_MODE_JPEG_ENC] = {
 		.run = rockchip_vpu2_jpeg_enc_run,
 		.reset = rockchip_vpu2_enc_reset,
-		.init = hantro_jpeg_enc_init,
 		.done = rockchip_vpu2_jpeg_enc_done,
-		.exit = hantro_jpeg_enc_exit,
 	},
 	[HANTRO_MODE_H264_DEC] = {
 		.run = rockchip_vpu2_h264_dec_run,
-- 
2.34.1.575.g55b058a8bb-goog

