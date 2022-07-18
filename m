Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078D5578D36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiGRWCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiGRWCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:02:20 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451630572
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:02:18 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-10c0052da61so27551279fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BvH8qPWu/oH2lroyRluLL4IzprmAqS5p7Y+lErxSuJg=;
        b=s/ld7e5PXao10IbpfBES0Ctk2FhkDAeXvq98/w/8IoaG9KTVIPRhM5QNzs97U5xwS3
         /BrwV5l0biwHetVf7vhxIKbJtBOOtRKiW4/gDgCLEskKaWuLkNgAmchjKNpuqJGxmfRZ
         2V+LWkOqVzqJnNvh7lBWjaubVtOPAdY4a6X7d7pwYXt0E9C5sv/93229TtlXOXhh8Mce
         MyuRad7yGMcvpiyzTQoKPNT70m3swGfqC33N2ozM3QTJtyzqjpZbi7RpdOZTW2ccS8bQ
         u1hE1YnCIPxgN6XTtshi69BBgaaX+/Rk5eoTs7x499zkqiedffJmR/6ac8c+yR6D+Uw+
         I/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BvH8qPWu/oH2lroyRluLL4IzprmAqS5p7Y+lErxSuJg=;
        b=nnN6cjFHV0Sah3q2U1UNWFRelDFolxrEiuXw57B4Q0p3FnaNTtvs9zA7qYROqJHH4q
         1lBOMIxyZ2q1+g4pje87SloAPvpAQucrWhX9YpS+vqs81nzrJAVAlS0IyB3P9aOHuDLS
         jzqJeSCvmW3fhnR08iHctpHQ7VbaB/+JYHu9MgKSP63X32uqCGcjVfdntReeVdnOoRAw
         fZvK4jBvN3z80Ao2AROzwZ600TUPy4nwM3JJiHAXssMW3nS7WVQsEtAhtXQX1Pua3GEU
         PEbDcTLbCuFA5dAz3nioljK0BNfat7+c0aHVbLxNq8OOUvTdGHlLS6sudyDBb+3ZEay2
         HIHw==
X-Gm-Message-State: AJIora/nfXZZXSLIwy6PhwC4F/rnsX2UAKRwfDKwkdsgj5K9dm+pKCqg
        Udd2ynSQEmH8/y7lefYB5OV6Kg==
X-Google-Smtp-Source: AGRyM1sPnxQo9Uo8y4SprC5UMl8KiSaYeUF5Z8ePn3JUSWl1jWBYrQhic4PwTeBwW68AGnJQabqAZg==
X-Received: by 2002:a54:4e83:0:b0:335:511b:a7d4 with SMTP id c3-20020a544e83000000b00335511ba7d4mr16948303oiy.266.1658181737707;
        Mon, 18 Jul 2022 15:02:17 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id x27-20020a9d459b000000b0061c68a35fdfsm3793183ote.9.2022.07.18.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:02:17 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 1/2] cedrus: Use vb2_find_buffer
Date:   Mon, 18 Jul 2022 19:02:10 -0300
Message-Id: <20220718220211.97995-1-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduced vb2_find_buffer API to get a vb2_buffer
given a buffer timestamp.

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Tomasz Figa <tfiga@chromium.org>
---
v3: Rebased on top of https://patchwork.linuxtv.org/project/linux-media/patch/20220718165649.16407-1-jernej.skrabec@gmail.com/

 drivers/staging/media/sunxi/cedrus/cedrus.h   | 24 ++++++-----
 .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++----
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 18 ++++----
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 28 ++++--------
 .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 43 ++++---------------
 5 files changed, 47 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 084193019350..2aa2961dbf64 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -237,19 +237,23 @@ static inline dma_addr_t cedrus_buf_addr(struct vb2_buffer *buf,
 }
 
 static inline dma_addr_t cedrus_dst_buf_addr(struct cedrus_ctx *ctx,
-					     int index, unsigned int plane)
+					     struct vb2_buffer *buf,
+					     unsigned int plane)
 {
-	struct vb2_buffer *buf = NULL;
-	struct vb2_queue *vq;
-
-	if (index < 0)
-		return 0;
+	return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
+}
 
-	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
-	if (vq)
-		buf = vb2_get_buffer(vq, index);
+static inline void cedrus_write_ref_buf_addr(struct cedrus_ctx *ctx,
+					     struct vb2_queue *q,
+					     u64 timestamp,
+					     u32 luma_reg,
+					     u32 chroma_reg)
+{
+       struct cedrus_dev *dev = ctx->dev;
+       struct vb2_buffer *buf = vb2_find_buffer(q, timestamp);
 
-	return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
+       cedrus_write(dev, luma_reg, cedrus_dst_buf_addr(ctx, buf, 0));
+       cedrus_write(dev, chroma_reg, cedrus_dst_buf_addr(ctx, buf, 1));
 }
 
 static inline struct cedrus_buffer *
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index c345e67ba9bc..a8b236cd3800 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -111,16 +111,16 @@ static void cedrus_write_frame_list(struct cedrus_ctx *ctx,
 	for (i = 0; i < ARRAY_SIZE(decode->dpb); i++) {
 		const struct v4l2_h264_dpb_entry *dpb = &decode->dpb[i];
 		struct cedrus_buffer *cedrus_buf;
-		int buf_idx;
+		struct vb2_buffer *buf;
 
 		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_VALID))
 			continue;
 
-		buf_idx = vb2_find_timestamp(cap_q, dpb->reference_ts, 0);
-		if (buf_idx < 0)
+		buf = vb2_find_buffer(cap_q, dpb->reference_ts);
+		if (!buf)
 			continue;
 
-		cedrus_buf = vb2_to_cedrus_buffer(cap_q->bufs[buf_idx]);
+		cedrus_buf = vb2_to_cedrus_buffer(buf);
 		position = cedrus_buf->codec.h264.position;
 		used_dpbs |= BIT(position);
 
@@ -186,7 +186,7 @@ static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
 		const struct v4l2_h264_dpb_entry *dpb;
 		const struct cedrus_buffer *cedrus_buf;
 		unsigned int position;
-		int buf_idx;
+		struct vb2_buffer *buf;
 		u8 dpb_idx;
 
 		dpb_idx = ref_list[i].index;
@@ -195,11 +195,11 @@ static void _cedrus_write_ref_list(struct cedrus_ctx *ctx,
 		if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
 			continue;
 
-		buf_idx = vb2_find_timestamp(cap_q, dpb->reference_ts, 0);
-		if (buf_idx < 0)
+		buf = vb2_find_buffer(cap_q, dpb->reference_ts);
+		if (!buf)
 			continue;
 
-		cedrus_buf = vb2_to_cedrus_buffer(cap_q->bufs[buf_idx]);
+		cedrus_buf = vb2_to_cedrus_buffer(buf);
 		position = cedrus_buf->codec.h264.position;
 
 		sram_array[i] |= position << 1;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 687f87598f78..f703c585d91c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -102,14 +102,14 @@ static void cedrus_h265_frame_info_write_single(struct cedrus_ctx *ctx,
 						unsigned int index,
 						bool field_pic,
 						u32 pic_order_cnt[],
-						int buffer_index)
+						struct vb2_buffer *buf)
 {
 	struct cedrus_dev *dev = ctx->dev;
-	dma_addr_t dst_luma_addr = cedrus_dst_buf_addr(ctx, buffer_index, 0);
-	dma_addr_t dst_chroma_addr = cedrus_dst_buf_addr(ctx, buffer_index, 1);
+	dma_addr_t dst_luma_addr = cedrus_dst_buf_addr(ctx, buf, 0);
+	dma_addr_t dst_chroma_addr = cedrus_dst_buf_addr(ctx, buf, 1);
 	dma_addr_t mv_col_buf_addr[2] = {
-		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_index, 0),
-		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buffer_index,
+		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index, 0),
+		cedrus_h265_frame_info_mv_col_buf_addr(ctx, buf->index,
 						       field_pic ? 1 : 0)
 	};
 	u32 offset = VE_DEC_H265_SRAM_OFFSET_FRAME_INFO +
@@ -141,18 +141,18 @@ static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
 	unsigned int i;
 
 	for (i = 0; i < num_active_dpb_entries; i++) {
-		int buffer_index = vb2_find_timestamp(vq, dpb[i].timestamp, 0);
+		struct vb2_buffer *buf = vb2_find_buffer(vq, dpb[i].timestamp);
 		u32 pic_order_cnt[2] = {
 			dpb[i].pic_order_cnt_val,
 			dpb[i].pic_order_cnt_val
 		};
 
-		if (buffer_index < 0)
+		if (!buf)
 			continue;
 
 		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
 						    pic_order_cnt,
-						    buffer_index);
+						    buf);
 	}
 }
 
@@ -751,7 +751,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	cedrus_h265_frame_info_write_single(ctx, output_pic_list_index,
 					    slice_params->pic_struct != 0,
 					    pic_order_cnt,
-					    run->dst->vb2_buf.index);
+					    &run->dst->vb2_buf);
 
 	cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX, output_pic_list_index);
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
index 4cfc4a3c8a7f..c1128d2cd555 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -54,13 +54,9 @@ static int cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	const struct v4l2_ctrl_mpeg2_picture *pic;
 	const struct v4l2_ctrl_mpeg2_quantisation *quantisation;
 	dma_addr_t src_buf_addr, dst_luma_addr, dst_chroma_addr;
-	dma_addr_t fwd_luma_addr, fwd_chroma_addr;
-	dma_addr_t bwd_luma_addr, bwd_chroma_addr;
 	struct cedrus_dev *dev = ctx->dev;
 	struct vb2_queue *vq;
 	const u8 *matrix;
-	int forward_idx;
-	int backward_idx;
 	unsigned int i;
 	u32 reg;
 
@@ -123,27 +119,19 @@ static int cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	cedrus_write(dev, VE_DEC_MPEG_PICBOUNDSIZE, reg);
 
 	/* Forward and backward prediction reference buffers. */
-
 	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
 
-	forward_idx = vb2_find_timestamp(vq, pic->forward_ref_ts, 0);
-	fwd_luma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 0);
-	fwd_chroma_addr = cedrus_dst_buf_addr(ctx, forward_idx, 1);
-
-	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_LUMA_ADDR, fwd_luma_addr);
-	cedrus_write(dev, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR, fwd_chroma_addr);
-
-	backward_idx = vb2_find_timestamp(vq, pic->backward_ref_ts, 0);
-	bwd_luma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 0);
-	bwd_chroma_addr = cedrus_dst_buf_addr(ctx, backward_idx, 1);
-
-	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_LUMA_ADDR, bwd_luma_addr);
-	cedrus_write(dev, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR, bwd_chroma_addr);
+	cedrus_write_ref_buf_addr(ctx, vq, pic->forward_ref_ts,
+				  VE_DEC_MPEG_FWD_REF_LUMA_ADDR,
+				  VE_DEC_MPEG_FWD_REF_CHROMA_ADDR);
+	cedrus_write_ref_buf_addr(ctx, vq, pic->backward_ref_ts,
+				  VE_DEC_MPEG_BWD_REF_LUMA_ADDR,
+				  VE_DEC_MPEG_BWD_REF_CHROMA_ADDR);
 
 	/* Destination luma and chroma buffers. */
 
-	dst_luma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0);
-	dst_chroma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1);
+	dst_luma_addr = cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0);
+	dst_chroma_addr = cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);
 
 	cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
 	cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
index 3f750d1795b6..f7714baae37d 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
@@ -660,7 +660,6 @@ static int cedrus_vp8_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	dma_addr_t luma_addr, chroma_addr;
 	dma_addr_t src_buf_addr;
 	int header_size;
-	int qindex;
 	u32 reg;
 
 	cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
@@ -804,43 +803,17 @@ static int cedrus_vp8_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	reg |= VE_VP8_LF_DELTA0(slice->lf.mb_mode_delta[0]);
 	cedrus_write(dev, VE_VP8_MODE_LF_DELTA, reg);
 
-	luma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0);
-	chroma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1);
+	luma_addr = cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0);
+	chroma_addr = cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);
 	cedrus_write(dev, VE_VP8_REC_LUMA, luma_addr);
 	cedrus_write(dev, VE_VP8_REC_CHROMA, chroma_addr);
 
-	qindex = vb2_find_timestamp(cap_q, slice->last_frame_ts, 0);
-	if (qindex >= 0) {
-		luma_addr = cedrus_dst_buf_addr(ctx, qindex, 0);
-		chroma_addr = cedrus_dst_buf_addr(ctx, qindex, 1);
-		cedrus_write(dev, VE_VP8_FWD_LUMA, luma_addr);
-		cedrus_write(dev, VE_VP8_FWD_CHROMA, chroma_addr);
-	} else {
-		cedrus_write(dev, VE_VP8_FWD_LUMA, 0);
-		cedrus_write(dev, VE_VP8_FWD_CHROMA, 0);
-	}
-
-	qindex = vb2_find_timestamp(cap_q, slice->golden_frame_ts, 0);
-	if (qindex >= 0) {
-		luma_addr = cedrus_dst_buf_addr(ctx, qindex, 0);
-		chroma_addr = cedrus_dst_buf_addr(ctx, qindex, 1);
-		cedrus_write(dev, VE_VP8_BWD_LUMA, luma_addr);
-		cedrus_write(dev, VE_VP8_BWD_CHROMA, chroma_addr);
-	} else {
-		cedrus_write(dev, VE_VP8_BWD_LUMA, 0);
-		cedrus_write(dev, VE_VP8_BWD_CHROMA, 0);
-	}
-
-	qindex = vb2_find_timestamp(cap_q, slice->alt_frame_ts, 0);
-	if (qindex >= 0) {
-		luma_addr = cedrus_dst_buf_addr(ctx, qindex, 0);
-		chroma_addr = cedrus_dst_buf_addr(ctx, qindex, 1);
-		cedrus_write(dev, VE_VP8_ALT_LUMA, luma_addr);
-		cedrus_write(dev, VE_VP8_ALT_CHROMA, chroma_addr);
-	} else {
-		cedrus_write(dev, VE_VP8_ALT_LUMA, 0);
-		cedrus_write(dev, VE_VP8_ALT_CHROMA, 0);
-	}
+	cedrus_write_ref_buf_addr(ctx, cap_q, slice->last_frame_ts,
+				  VE_VP8_FWD_LUMA, VE_VP8_FWD_CHROMA);
+	cedrus_write_ref_buf_addr(ctx, cap_q, slice->golden_frame_ts,
+				  VE_VP8_BWD_LUMA, VE_VP8_BWD_CHROMA);
+	cedrus_write_ref_buf_addr(ctx, cap_q, slice->alt_frame_ts,
+				  VE_VP8_ALT_LUMA, VE_VP8_ALT_CHROMA);
 
 	cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8 |
 		     VE_H264_CTRL_DECODE_ERR_INT |
-- 
2.34.3

