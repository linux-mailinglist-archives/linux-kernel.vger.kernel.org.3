Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521B552333
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244360AbiFTR4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243537AbiFTRzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:55:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209115A12;
        Mon, 20 Jun 2022 10:55:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l2-20020a05600c4f0200b0039c55c50482so8157934wmq.0;
        Mon, 20 Jun 2022 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tAdXoNtdZqSJlZ2MXfBBTjpRxVvfcVETXQY7JSHULjw=;
        b=kCil/b2YxMcI/LVYfQ4tU0txJcgYVmIuNNYvnya8s/clEL/VYeagXGh1qVkbHST8Nt
         GhFkQWXTAgWVPPOF2B9HqmAP10J8QqTJ0eY9IAzh7AuQrkrUI5huLrOOFb/8n1TpMshN
         mSGjRcLa74wXVrEscb1ZqL5jjejmsgxXAHpDJ3JWuJWHa6zNiIk/R3NmvlhK5msRgX5H
         xZ6AcErbOWWeEYrzD+JXr4PJPuH3q92sgKMu+JwVtA2O98jwupgp7K4JjFDJUwZW9IN4
         fPife9qlUSz3tKMRXiG02OUY/Do1cCmp8cspKqU77NwKCpbr/FSnSTHkcWCi6k1+SjaN
         SNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tAdXoNtdZqSJlZ2MXfBBTjpRxVvfcVETXQY7JSHULjw=;
        b=tOBxOt+nZdCzwFASoWgULdxptX1f1Nu22l3oxmrLfk7AV4k3Km/mUScHrKt/g0VCDb
         4ryhXwePp0Mioh0nQreAid4quG/7TWvqBCVRLWDGu85NdIQz4HRXSd5OiyT7RiDUTo5g
         1VEzC7U3Dcp3iAXF29R+6dpuPgGf32dck+0hw2G+KRVrZ6PyLQ+nD2WSH71E7Tjlla/C
         HBMmh2v+bAxrL1McTmYHvQ0vgV4UIR8J04njpG5fb9vXc+mT9Jyu++/Qv0jiPypBiI3z
         DsPyvVtegewzju/nk1gscp8/YCd0IWlj8dGNrtq1vsWM0n9tF65KfAYZG9VEgEvVvsUy
         3YrA==
X-Gm-Message-State: AJIora+hoLfcdnHpOy+XoMGfUvGmN3v0TCpsrN1gSZiWWpbINSze0fNc
        4dW5Se/5ez5fdY2UyJaWVZU=
X-Google-Smtp-Source: AGRyM1sTT+Qv9xeBDp8yh0jsfBs7Yt/BBq4EV52+NqOwKAeegtB6y0gszD0QF/AnQ01tSEnm0mICdA==
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id t17-20020a05600c199100b0039c88ba2869mr25262485wmq.14.1655747738659;
        Mon, 20 Jun 2022 10:55:38 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 184-20020a1c02c1000000b0039db31f6372sm19620752wmc.2.2022.06.20.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:55:38 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 7/7] media: cedrus: h265: Implement support for tiles
Date:   Mon, 20 Jun 2022 19:55:17 +0200
Message-Id: <20220620175517.648767-8-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620175517.648767-1-jernej.skrabec@gmail.com>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiles are last remaining unimplemented functionality for HEVC. Implement
it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  10 ++
 drivers/staging/media/sunxi/cedrus/cedrus.h   |   4 +
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |   4 +
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 108 +++++++++++++++++-
 4 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index b855e608885c..960a0130cd62 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -189,6 +189,16 @@ static const struct cedrus_control cedrus_controls[] = {
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
+	{
+		.cfg = {
+			.id	= V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS,
+			/* maximum 256 entry point offsets per slice */
+			.dims	= { 256 },
+			.max = 0xffffffff,
+			.step = 1,
+		},
+		.codec		= CEDRUS_CODEC_H265,
+	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_HEVC_DECODE_MODE,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 15a1bdbf6a1f..084193019350 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -81,6 +81,8 @@ struct cedrus_h265_run {
 	const struct v4l2_ctrl_hevc_slice_params	*slice_params;
 	const struct v4l2_ctrl_hevc_decode_params	*decode_params;
 	const struct v4l2_ctrl_hevc_scaling_matrix	*scaling_matrix;
+	const u32					*entry_points;
+	u32						entry_points_count;
 };
 
 struct cedrus_vp8_run {
@@ -146,6 +148,8 @@ struct cedrus_ctx {
 			ssize_t		mv_col_buf_unit_size;
 			void		*neighbor_info_buf;
 			dma_addr_t	neighbor_info_buf_addr;
+			void		*entry_points_buf;
+			dma_addr_t	entry_points_buf_addr;
 		} h265;
 		struct {
 			unsigned int	last_frame_p_type;
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index b0944abaacbd..3b6aa78a2985 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -75,6 +75,10 @@ void cedrus_device_run(void *priv)
 			V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
 		run.h265.scaling_matrix = cedrus_find_control_data(ctx,
 			V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
+		run.h265.entry_points = cedrus_find_control_data(ctx,
+			V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS);
+		run.h265.entry_points_count = cedrus_get_num_of_controls(ctx,
+			V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS);
 		break;
 
 	case V4L2_PIX_FMT_VP8_FRAME:
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 99020b9f9ff8..275fff1ab3a4 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -326,6 +326,65 @@ static int cedrus_h265_is_low_delay(struct cedrus_run *run)
 	return 0;
 }
 
+static void cedrus_h265_write_tiles(struct cedrus_ctx *ctx,
+				    struct cedrus_run *run,
+				    unsigned int ctb_addr_x,
+				    unsigned int ctb_addr_y)
+{
+	const struct v4l2_ctrl_hevc_slice_params *slice_params;
+	const struct v4l2_ctrl_hevc_pps *pps;
+	struct cedrus_dev *dev = ctx->dev;
+	const u32 *entry_points;
+	u32 *entry_points_buf;
+	int i, x, tx, y, ty;
+
+	pps = run->h265.pps;
+	slice_params = run->h265.slice_params;
+	entry_points = run->h265.entry_points;
+	entry_points_buf = ctx->codec.h265.entry_points_buf;
+
+	for (x = 0, tx = 0; tx < pps->num_tile_columns_minus1 + 1; tx++) {
+		if (x + pps->column_width_minus1[tx] + 1 > ctb_addr_x)
+			break;
+
+		x += pps->column_width_minus1[tx] + 1;
+	}
+
+	for (y = 0, ty = 0; ty < pps->num_tile_rows_minus1 + 1; ty++) {
+		if (y + pps->row_height_minus1[ty] + 1 > ctb_addr_y)
+			break;
+
+		y += pps->row_height_minus1[ty] + 1;
+	}
+
+	cedrus_write(dev, VE_DEC_H265_TILE_START_CTB, (y << 16) | (x << 0));
+	cedrus_write(dev, VE_DEC_H265_TILE_END_CTB,
+		     ((y + pps->row_height_minus1[ty]) << 16) |
+		     ((x + pps->column_width_minus1[tx]) << 0));
+
+	if (pps->flags & V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED) {
+		for (i = 0; i < slice_params->num_entry_point_offsets; i++)
+			entry_points_buf[i] = entry_points[i];
+	} else {
+		for (i = 0; i < slice_params->num_entry_point_offsets; i++) {
+			if (tx + 1 >= pps->num_tile_columns_minus1 + 1) {
+				x = 0;
+				tx = 0;
+				y += pps->row_height_minus1[ty++] + 1;
+			} else {
+				x += pps->column_width_minus1[tx++] + 1;
+			}
+
+			entry_points_buf[i * 4 + 0] = entry_points[i];
+			entry_points_buf[i * 4 + 1] = 0x0;
+			entry_points_buf[i * 4 + 2] = (y << 16) | (x << 0);
+			entry_points_buf[i * 4 + 3] =
+				((y + pps->row_height_minus1[ty]) << 16) |
+				((x + pps->column_width_minus1[tx]) << 0);
+		}
+	}
+}
+
 static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 {
 	struct cedrus_dev *dev = ctx->dev;
@@ -336,9 +395,11 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	const struct v4l2_hevc_pred_weight_table *pred_weight_table;
 	unsigned int width_in_ctb_luma, ctb_size_luma;
 	unsigned int log2_max_luma_coding_block_size;
+	unsigned int ctb_addr_x, ctb_addr_y;
 	dma_addr_t src_buf_addr;
 	dma_addr_t src_buf_end_addr;
 	u32 chroma_log2_weight_denom;
+	u32 num_entry_point_offsets;
 	u32 output_pic_list_index;
 	u32 pic_order_cnt[2];
 	u8 *padding;
@@ -350,6 +411,15 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	slice_params = run->h265.slice_params;
 	decode_params = run->h265.decode_params;
 	pred_weight_table = &slice_params->pred_weight_table;
+	num_entry_point_offsets = slice_params->num_entry_point_offsets;
+
+	/*
+	 * If entry points offsets are present, we should get them
+	 * exactly the right amount.
+	 */
+	if (num_entry_point_offsets &&
+	    num_entry_point_offsets != run->h265.entry_points_count)
+		return -ERANGE;
 
 	log2_max_luma_coding_block_size =
 		sps->log2_min_luma_coding_block_size_minus3 + 3 +
@@ -416,12 +486,19 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
 
 	/* Coding tree block address */
-	reg = VE_DEC_H265_DEC_CTB_ADDR_X(slice_params->slice_segment_addr % width_in_ctb_luma);
-	reg |= VE_DEC_H265_DEC_CTB_ADDR_Y(slice_params->slice_segment_addr / width_in_ctb_luma);
+	ctb_addr_x = slice_params->slice_segment_addr % width_in_ctb_luma;
+	ctb_addr_y = slice_params->slice_segment_addr / width_in_ctb_luma;
+	reg = VE_DEC_H265_DEC_CTB_ADDR_X(ctb_addr_x);
+	reg |= VE_DEC_H265_DEC_CTB_ADDR_Y(ctb_addr_y);
 	cedrus_write(dev, VE_DEC_H265_DEC_CTB_ADDR, reg);
 
-	cedrus_write(dev, VE_DEC_H265_TILE_START_CTB, 0);
-	cedrus_write(dev, VE_DEC_H265_TILE_END_CTB, 0);
+	if ((pps->flags & V4L2_HEVC_PPS_FLAG_TILES_ENABLED) ||
+	    (pps->flags & V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED)) {
+		cedrus_h265_write_tiles(ctx, run, ctb_addr_x, ctb_addr_y);
+	} else {
+		cedrus_write(dev, VE_DEC_H265_TILE_START_CTB, 0);
+		cedrus_write(dev, VE_DEC_H265_TILE_END_CTB, 0);
+	}
 
 	/* Clear the number of correctly-decoded coding tree blocks. */
 	if (ctx->fh.m2m_ctx->new_frame)
@@ -548,7 +625,9 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 				V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED,
 				pps->flags);
 
-	/* TODO: VE_DEC_H265_DEC_PPS_CTRL1_FLAG_TILES_ENABLED */
+	reg |= VE_DEC_H265_FLAG(VE_DEC_H265_DEC_PPS_CTRL1_FLAG_TILES_ENABLED,
+				V4L2_HEVC_PPS_FLAG_TILES_ENABLED,
+				pps->flags);
 
 	reg |= VE_DEC_H265_FLAG(VE_DEC_H265_DEC_PPS_CTRL1_FLAG_TRANSQUANT_BYPASS_ENABLED,
 				V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED,
@@ -626,12 +705,14 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 
 	chroma_log2_weight_denom = pred_weight_table->luma_log2_weight_denom +
 				   pred_weight_table->delta_chroma_log2_weight_denom;
-	reg = VE_DEC_H265_DEC_SLICE_HDR_INFO2_NUM_ENTRY_POINT_OFFSETS(0) |
+	reg = VE_DEC_H265_DEC_SLICE_HDR_INFO2_NUM_ENTRY_POINT_OFFSETS(num_entry_point_offsets) |
 	      VE_DEC_H265_DEC_SLICE_HDR_INFO2_CHROMA_LOG2_WEIGHT_DENOM(chroma_log2_weight_denom) |
 	      VE_DEC_H265_DEC_SLICE_HDR_INFO2_LUMA_LOG2_WEIGHT_DENOM(pred_weight_table->luma_log2_weight_denom);
 
 	cedrus_write(dev, VE_DEC_H265_DEC_SLICE_HDR_INFO2, reg);
 
+	cedrus_write(dev, VE_DEC_H265_ENTRY_POINT_OFFSET_ADDR, ctx->codec.h265.entry_points_buf_addr >> 8);
+
 	/* Decoded picture size. */
 
 	reg = VE_DEC_H265_DEC_PIC_SIZE_WIDTH(ctx->src_fmt.width) |
@@ -728,6 +809,18 @@ static int cedrus_h265_start(struct cedrus_ctx *ctx)
 	if (!ctx->codec.h265.neighbor_info_buf)
 		return -ENOMEM;
 
+	ctx->codec.h265.entry_points_buf =
+		dma_alloc_coherent(dev->dev, CEDRUS_H265_ENTRY_POINTS_BUF_SIZE,
+				   &ctx->codec.h265.entry_points_buf_addr,
+				   GFP_KERNEL);
+	if (!ctx->codec.h265.entry_points_buf) {
+		dma_free_attrs(dev->dev, CEDRUS_H265_NEIGHBOR_INFO_BUF_SIZE,
+			       ctx->codec.h265.neighbor_info_buf,
+			       ctx->codec.h265.neighbor_info_buf_addr,
+			       DMA_ATTR_NO_KERNEL_MAPPING);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -748,6 +841,9 @@ static void cedrus_h265_stop(struct cedrus_ctx *ctx)
 		       ctx->codec.h265.neighbor_info_buf,
 		       ctx->codec.h265.neighbor_info_buf_addr,
 		       DMA_ATTR_NO_KERNEL_MAPPING);
+	dma_free_coherent(dev->dev, CEDRUS_H265_ENTRY_POINTS_BUF_SIZE,
+			  ctx->codec.h265.entry_points_buf,
+			  ctx->codec.h265.entry_points_buf_addr);
 }
 
 static void cedrus_h265_trigger(struct cedrus_ctx *ctx)
-- 
2.36.1

