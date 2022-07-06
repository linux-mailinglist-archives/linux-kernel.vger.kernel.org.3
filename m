Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4BA5691C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiGFS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiGFS1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:27:48 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3398517ABB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:27:41 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id f10so754638uam.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3otKT1ZkeoSoRtH+ozMyr43VyMZOo72OStANlEPpJEI=;
        b=4rX7JkzmwMbGPpgfzxDYbbu6ZGutkVZKcv0RSmlpRPwmh3FyPMF/5ycz7p/ydzLswi
         L7hOwuT+9CzoUxSZNINlsFbIFcHwXogV7JF4u8rvYwRiChEdkv5Tlz7IvAnq8kS/C3j8
         XIlaFX178XTY65DxVhoB/mtDJM3JPyMnWjobkk3HZJqhUKPRZlMEK5eNIUBJXQtegHqB
         gXUMSZgMgMLmvQ2NRYGKdXltpysN2Sd6qmxVNGxt/1xUizgUzRrYNHv6jMcntovzhaqu
         EmjxylP0L1fDyXqLAc0lWgRWWW5VXIeFi1yS0qK6Uk1Wja1z9aKNd6QrWzDSupWnRDde
         3r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3otKT1ZkeoSoRtH+ozMyr43VyMZOo72OStANlEPpJEI=;
        b=jGEr+nFv9eF/uj6oHhKb2AsFzvEQlUKKvT236CEdt5N7FzLsvNVxtj9ZF5ShrtLTHY
         sl+UQLXX82Dmc94faOcySx0Pr6kNegENtmJUqAE9CtmJ+jHXb0mpCBiRMrPLwBHrlXxB
         W8CQ+t82yECTNCzMnI+P/m8SmHKlhXAL1+cfn7P5x2MlGMx6QWz2jRbfQNT7YyIVNbbx
         UIfXTYyvn2+0p4zG+RrB8MMfA4vB2Kmi6ZQDDS5SxVJuAGToh1bfRqE9XsrJ9oRcHAIl
         TNpLtEzSCZZPzW9SIPqgmIZ81E4QrnrW8xpAJDKa0slrxeQp/EASFxBcpHvdkuZf1zmU
         I/JQ==
X-Gm-Message-State: AJIora+hHHGJQLFQpPfEDIUpEWfpyT7VySfZ91E/k3tSI/GeZteH2eQK
        oBqIuvPRIF+C5joCU0KjD7WaKQ==
X-Google-Smtp-Source: AGRyM1vEbBKRodzxnzA1N9nmG59U9TjaxOkOJZtrIDUVL1tP0FQ44IV32SMwiCr8FYVjtdKLg95gUw==
X-Received: by 2002:ab0:7a43:0:b0:382:96f8:7457 with SMTP id a3-20020ab07a43000000b0038296f87457mr8555649uat.45.1657132060316;
        Wed, 06 Jul 2022 11:27:40 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id bl9-20020a056102508900b003563680212asm7445539vsb.27.2022.07.06.11.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:27:39 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 7/8] cedrus: Use vb2_find_buffer
Date:   Wed,  6 Jul 2022 15:26:56 -0300
Message-Id: <20220706182657.210650-8-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
References: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/staging/media/sunxi/cedrus/cedrus.h   | 13 +----
 .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++---
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++---
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 36 ++++++-------
 .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 50 ++++++-------------
 5 files changed, 49 insertions(+), 82 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 3bc094eb497f..a9908cc5c848 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -233,18 +233,9 @@ static inline dma_addr_t cedrus_buf_addr(struct vb2_buffer *buf,
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
-
-	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE);
-	if (vq)
-		buf = vb2_get_buffer(vq, index);
-
 	return buf ? cedrus_buf_addr(buf, &ctx->dst_fmt, plane) : 0;
 }
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index d8fb93035470..0559efeac125 100644
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
index 44f385be9f6c..60cc13e4d0a9 100644
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
@@ -141,7 +141,7 @@ static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
 	unsigned int i;
 
 	for (i = 0; i < num_active_dpb_entries; i++) {
-		int buffer_index = vb2_find_timestamp(vq, dpb[i].timestamp, 0);
+		struct vb2_buffer *buf = vb2_find_buffer(vq, dpb[i].timestamp);
 		u32 pic_order_cnt[2] = {
 			dpb[i].pic_order_cnt[0],
 			dpb[i].pic_order_cnt[1]
@@ -149,7 +149,7 @@ static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
 
 		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
 						    pic_order_cnt,
-						    buffer_index);
+						    buf);
 	}
 }
 
@@ -616,7 +616,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 	cedrus_h265_frame_info_write_single(ctx, output_pic_list_index,
 					    slice_params->pic_struct != 0,
 					    pic_order_cnt,
-					    run->dst->vb2_buf.index);
+					    &run->dst->vb2_buf);
 
 	cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX, output_pic_list_index);
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
index 5dad2f296c6d..ab9cfa001a49 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -13,6 +13,16 @@
 #include "cedrus_hw.h"
 #include "cedrus_regs.h"
 
+static void write_ref_buf_addr(struct cedrus_ctx *ctx, struct vb2_queue *q,
+			       u64 timestamp, u32 luma_reg, u32 chroma_reg)
+{
+	struct cedrus_dev *dev = ctx->dev;
+	struct vb2_buffer *buf = vb2_find_buffer(q, timestamp);
+
+	cedrus_write(dev, luma_reg, cedrus_dst_buf_addr(ctx, buf, 0));
+	cedrus_write(dev, chroma_reg, cedrus_dst_buf_addr(ctx, buf, 1));
+}
+
 static enum cedrus_irq_status cedrus_mpeg2_irq_status(struct cedrus_ctx *ctx)
 {
 	struct cedrus_dev *dev = ctx->dev;
@@ -54,13 +64,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
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
 
@@ -123,27 +129,17 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
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
+	write_ref_buf_addr(ctx, vq, pic->forward_ref_ts,
+			   VE_DEC_MPEG_FWD_REF_LUMA_ADDR, VE_DEC_MPEG_FWD_REF_CHROMA_ADDR);
+	write_ref_buf_addr(ctx, vq, pic->backward_ref_ts,
+			   VE_DEC_MPEG_BWD_REF_LUMA_ADDR, VE_DEC_MPEG_BWD_REF_CHROMA_ADDR);
 
 	/* Destination luma and chroma buffers. */
 
-	dst_luma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0);
-	dst_chroma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1);
+	dst_luma_addr = cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 0);
+	dst_chroma_addr = cedrus_dst_buf_addr(ctx, &run->dst->vb2_buf, 1);
 
 	cedrus_write(dev, VE_DEC_MPEG_REC_LUMA, dst_luma_addr);
 	cedrus_write(dev, VE_DEC_MPEG_REC_CHROMA, dst_chroma_addr);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
index f4016684b32d..a253f6b92135 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
@@ -516,6 +516,16 @@ static void process_ref_frame_info(struct cedrus_dev *dev)
 	read_bits(dev, 1, VP8_PROB_HALF);
 }
 
+static void write_ref_buf_addr(struct cedrus_ctx *ctx, struct vb2_queue *q,
+			       u64 timestamp, u32 luma_reg, u32 chroma_reg)
+{
+	struct cedrus_dev *dev = ctx->dev;
+	struct vb2_buffer *buf = vb2_find_buffer(q, timestamp);
+
+	cedrus_write(dev, luma_reg, cedrus_dst_buf_addr(ctx, buf, 0));
+	cedrus_write(dev, chroma_reg, cedrus_dst_buf_addr(ctx, buf, 1));
+}
+
 static void cedrus_irq_clear(struct cedrus_dev *dev)
 {
 	cedrus_write(dev, VE_H264_STATUS,
@@ -661,7 +671,6 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
 	dma_addr_t luma_addr, chroma_addr;
 	dma_addr_t src_buf_addr;
 	int header_size;
-	int qindex;
 	u32 reg;
 
 	cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
@@ -805,43 +814,14 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
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
+	write_ref_buf_addr(ctx, cap_q, slice->last_frame_ts, VE_VP8_FWD_LUMA, VE_VP8_FWD_CHROMA);
+	write_ref_buf_addr(ctx, cap_q, slice->golden_frame_ts, VE_VP8_BWD_LUMA, VE_VP8_BWD_CHROMA);
+	write_ref_buf_addr(ctx, cap_q, slice->alt_frame_ts, VE_VP8_ALT_LUMA, VE_VP8_ALT_CHROMA);
 
 	cedrus_write(dev, VE_H264_CTRL, VE_H264_CTRL_VP8 |
 		     VE_H264_CTRL_DECODE_ERR_INT |
-- 
2.34.3

