Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB5570C81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiGKVM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiGKVML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:12:11 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231AA33A25
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:12:06 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10bec750eedso8178549fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A792au2VT1LlwA2CxXREJLZ4s++KMx+3sQTvofamLP8=;
        b=EaYKvznWP2pwtR8wciXBs9CPufXGCXvSPk00hhV/bSB+BpQsssLr4tyOypqDekPht+
         hcxtnIRerAyAmOt/+pVy19/Q1fhpq28ALj70+Uu8RmPNkW2JOKti798WsGbVvodHuDRT
         cikpnXXayJQhsCisu1sRpxngygYXINgzv6GqgmxNWMyBgfREIB+E9qSJ2h/5gTRaYrWv
         I/+PVS7kRlOAIN8U+oQIpFqiu+UuB3ilzH9vZTLY2Q1FQJO3oSAWQQ7z22pNx7UGy+Xp
         88KmpCBwXtwu/ItZm6m7OnydNpGGz19QDzV4qJi0KwP5tQxvX0oE7rASBOrmCmvpp8gE
         +pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A792au2VT1LlwA2CxXREJLZ4s++KMx+3sQTvofamLP8=;
        b=4HBryZxJWeGvQWA96+3imqWdbqnd9Ddn0mLIb4VQ0PqzAVaLAqTTuHJBzsibBE0rqS
         4pDRf3ueQM8avDvnc+Vl4rC6YbbfhhyAMrxOMDHX1Z61qG509xBYsHlwcjSxCW9fLGPm
         sNrtqQqRY+yF6p3pYuLQ9EK5QwoFSBi2zqMpNlmZgjoAAjJ7wRlgMSC1mtMZRXTkJO/8
         fymOgvoRlmwL8j5iJTiEmm388T9w+jp2RDmbY8lbmyaMMhdbJH5nwhvp5fODmR5CSbmP
         Uqg8/htgyg2u1onydkUvRahpqmtjcGGTedBNL6mKWly39NRFcXlj+Amj4HXZOFMSFthO
         pXjA==
X-Gm-Message-State: AJIora/eub1A7yqETxY+Wl2VvWOn73gsTDIUsPIkOYM9hp/jA1yfTnaf
        viZM31kmmQGDxWR72IFPZWxUgg==
X-Google-Smtp-Source: AGRyM1usv+xY6kM8ee0QJ04Kw/9vVhimVKga1EmRQVMBw+IqDWSK1X3QoLlwFd/305yrMHQpGDQw4A==
X-Received: by 2002:a05:6870:e245:b0:de:9321:9ea3 with SMTP id d5-20020a056870e24500b000de93219ea3mr158212oac.79.1657573925467;
        Mon, 11 Jul 2022 14:12:05 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id c128-20020aca3586000000b00338869042fdsm3198817oia.32.2022.07.11.14.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:12:05 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 7/8] cedrus: Use vb2_find_buffer
Date:   Mon, 11 Jul 2022 18:11:40 -0300
Message-Id: <20220711211141.349902-8-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
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
Acked-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.h   | 24 ++++++-----
 .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++----
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++----
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 28 ++++--------
 .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 43 ++++---------------
 5 files changed, 46 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 3bc094eb497f..c054dbe3d3bc 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -233,19 +233,23 @@ static inline dma_addr_t cedrus_buf_addr(struct vb2_buffer *buf,
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
index 5dad2f296c6d..22d6cae9a710 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -54,13 +54,9 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
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
 
@@ -123,27 +119,19 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
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
index f4016684b32d..196cf692186d 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
@@ -661,7 +661,6 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
 	dma_addr_t luma_addr, chroma_addr;
 	dma_addr_t src_buf_addr;
 	int header_size;
-	int qindex;
 	u32 reg;
 
 	cedrus_engine_enable(ctx, CEDRUS_CODEC_VP8);
@@ -805,43 +804,17 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
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

