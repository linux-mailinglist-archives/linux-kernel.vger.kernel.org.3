Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF14622C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhK2VFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhK2VDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:03:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50AFC11FA3F;
        Mon, 29 Nov 2021 10:26:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o29so15437689wms.2;
        Mon, 29 Nov 2021 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTZTbu7/INHWojoM1sPZJtHohD+hKsTfbuMrsdEckRA=;
        b=iYlIIcTqxOmRwVsDHPC9VSC5dY57bquBvptj37xB1SFCoHyH7GN0ZXdNcVaFEaZvvI
         d2DETtVJv7a1EgtQ+fl1C/pDtXiwmS3w2zj6wBGiKocUl4fwNUyvrJtzK5pBdsSEQ/X+
         xJq2dWzhGSmhcP80l02ZqmAUMrOren5l45dGw9qWXJYdoxCe4ugM+mkej9E9UOcloxjq
         445wP6ctzUPXYPuIO6fyzFWV0OrYiMrYp4EFY3PbnQA4bAh01w6opDW7GX9ATxLcR7Nd
         Zh02Bw4rjnFS71iuy689VYi3OVwjIXxmwQpM5YUS7qv0c0lPMrmCejt0pwJg72GVRmM+
         IzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTZTbu7/INHWojoM1sPZJtHohD+hKsTfbuMrsdEckRA=;
        b=x1zzV5QhHndYYbvC4CtdOsRshXXOWtQBJmhNrRnnnbPfpU9nwSE07MBkJfPE/MFMIm
         ioA3CFyLIOOS37biRly3r+ci6cotu3aYdjZ7BXSTH1y4ku7M5UkLTz3opLDxqtY924+5
         q+1s2bE/Pv6uTk+s/DAULFP4MMpay8LQEnfEWKyBfJ70b7kp2pCBb9a+eLtz4yfnjjcP
         dzuOEv8ER4jp5F76Qvdh3q5wzxvo1hEKp1Ed9QLKJrv3m0T9voj3WXQRublZOfmaO+jY
         LnDEiYBDI7jzTWYGGjcLdZEOnNI0wFEmJn7ZX7xREBw598ijLJbpOQ+fExRhVETLorfo
         oKgQ==
X-Gm-Message-State: AOAM530G+kXejwJdvIJjbIKX8xk7rZ1PHNFq2wS6Sqf8swD7IHK/ungF
        zQJ0M6LpLzYec+u95JEYutfSwtD3BbRBuw==
X-Google-Smtp-Source: ABdhPJzRtWeLfJU/YPbCIF6pvKGCkQFqTFiIUn88/kodxqQWZh47GaxImqLVAepUPyRlJ75MoMlBow==
X-Received: by 2002:a1c:43c2:: with SMTP id q185mr77674wma.30.1638210403927;
        Mon, 29 Nov 2021 10:26:43 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm85907wmq.12.2021.11.29.10.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:26:43 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 4/9] media: hantro: vp9: add support for legacy register set
Date:   Mon, 29 Nov 2021 19:26:28 +0100
Message-Id: <20211129182633.480021-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129182633.480021-1-jernej.skrabec@gmail.com>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some older G2 cores uses slightly different register set for HEVC and
VP9. Since vast majority of registers and logic is the same, it doesn't
make sense to introduce another drivers.

Add legacy_regs quirk and implement only VP9 changes for now. HEVC
changes will be introduced later, if needed.

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro.h         |  2 +
 drivers/staging/media/hantro/hantro_g2_regs.h | 16 ++++
 .../staging/media/hantro/hantro_g2_vp9_dec.c  | 74 ++++++++++++++-----
 3 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
index d03824fa3222..83ed25d9657b 100644
--- a/drivers/staging/media/hantro/hantro.h
+++ b/drivers/staging/media/hantro/hantro.h
@@ -74,6 +74,7 @@ struct hantro_irq {
  * @reg_names:			array of register range names
  * @num_regs:			number of register range names in the array
  * @double_buffer:		core needs double buffering
+ * @legacy_regs:		core uses legacy register set
  */
 struct hantro_variant {
 	unsigned int enc_offset;
@@ -96,6 +97,7 @@ struct hantro_variant {
 	const char * const *reg_names;
 	int num_regs;
 	unsigned int double_buffer : 1;
+	unsigned int legacy_regs : 1;
 };
 
 /**
diff --git a/drivers/staging/media/hantro/hantro_g2_regs.h b/drivers/staging/media/hantro/hantro_g2_regs.h
index 15a391a4650e..b7c6f9877b9d 100644
--- a/drivers/staging/media/hantro/hantro_g2_regs.h
+++ b/drivers/staging/media/hantro/hantro_g2_regs.h
@@ -36,7 +36,13 @@
 #define BUS_WIDTH_256			3
 
 #define g2_strm_swap		G2_DEC_REG(2, 28, 0xf)
+#define g2_strm_swap_old	G2_DEC_REG(2, 27, 0x1f)
+#define g2_pic_swap		G2_DEC_REG(2, 22, 0x1f)
 #define g2_dirmv_swap		G2_DEC_REG(2, 20, 0xf)
+#define g2_dirmv_swap_old	G2_DEC_REG(2, 17, 0x1f)
+#define g2_tab0_swap_old	G2_DEC_REG(2, 12, 0x1f)
+#define g2_tab1_swap_old	G2_DEC_REG(2, 7, 0x1f)
+#define g2_tab2_swap_old	G2_DEC_REG(2, 2, 0x1f)
 
 #define g2_mode			G2_DEC_REG(3, 27, 0x1f)
 #define g2_compress_swap	G2_DEC_REG(3, 20, 0xf)
@@ -45,6 +51,8 @@
 #define g2_out_dis		G2_DEC_REG(3, 15, 0x1)
 #define g2_out_filtering_dis	G2_DEC_REG(3, 14, 0x1)
 #define g2_write_mvs_e		G2_DEC_REG(3, 12, 0x1)
+#define g2_tab3_swap_old	G2_DEC_REG(3, 7, 0x1f)
+#define g2_rscan_swap		G2_DEC_REG(3, 2, 0x1f)
 
 #define g2_pic_width_in_cbs	G2_DEC_REG(4, 19, 0x1fff)
 #define g2_pic_height_in_cbs	G2_DEC_REG(4, 6,  0x1fff)
@@ -58,6 +66,7 @@
 #define g2_tempor_mvp_e		G2_DEC_REG(5, 11, 0x1)
 #define g2_max_cu_qpd_depth	G2_DEC_REG(5, 5,  0x3f)
 #define g2_cu_qpd_e		G2_DEC_REG(5, 4,  0x1)
+#define g2_pix_shift		G2_DEC_REG(5, 0,  0xf)
 
 #define g2_stream_len		G2_DEC_REG(6, 0,  0xffffffff)
 
@@ -80,21 +89,28 @@
 
 #define g2_const_intra_e	G2_DEC_REG(8, 31, 0x1)
 #define g2_filt_ctrl_pres	G2_DEC_REG(8, 30, 0x1)
+#define g2_bit_depth_y		G2_DEC_REG(8, 21, 0xf)
+#define g2_bit_depth_c		G2_DEC_REG(8, 17, 0xf)
 #define g2_idr_pic_e		G2_DEC_REG(8, 16, 0x1)
 #define g2_bit_depth_pcm_y	G2_DEC_REG(8, 12, 0xf)
 #define g2_bit_depth_pcm_c	G2_DEC_REG(8, 8,  0xf)
 #define g2_bit_depth_y_minus8	G2_DEC_REG(8, 6,  0x3)
 #define g2_bit_depth_c_minus8	G2_DEC_REG(8, 4,  0x3)
+#define g2_rs_out_bit_depth	G2_DEC_REG(8, 4,  0xf)
 #define g2_output_8_bits	G2_DEC_REG(8, 3,  0x1)
 #define g2_output_format	G2_DEC_REG(8, 0,  0x7)
+#define g2_pp_pix_shift		G2_DEC_REG(8, 0,  0xf)
 
 #define g2_refidx1_active	G2_DEC_REG(9, 19, 0x1f)
 #define g2_refidx0_active	G2_DEC_REG(9, 14, 0x1f)
 #define g2_hdr_skip_length	G2_DEC_REG(9, 0,  0x3fff)
 
 #define g2_start_code_e		G2_DEC_REG(10, 31, 0x1)
+#define g2_init_qp_old		G2_DEC_REG(10, 25, 0x3f)
 #define g2_init_qp		G2_DEC_REG(10, 24, 0x3f)
+#define g2_num_tile_cols_old	G2_DEC_REG(10, 20, 0x1f)
 #define g2_num_tile_cols	G2_DEC_REG(10, 19, 0x1f)
+#define g2_num_tile_rows_old	G2_DEC_REG(10, 15, 0x1f)
 #define g2_num_tile_rows	G2_DEC_REG(10, 14, 0x1f)
 #define g2_tile_e		G2_DEC_REG(10, 1,  0x1)
 #define g2_entropy_sync_e	G2_DEC_REG(10, 0,  0x1)
diff --git a/drivers/staging/media/hantro/hantro_g2_vp9_dec.c b/drivers/staging/media/hantro/hantro_g2_vp9_dec.c
index d4fc649a4da1..91c21b634fab 100644
--- a/drivers/staging/media/hantro/hantro_g2_vp9_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_vp9_dec.c
@@ -150,7 +150,8 @@ static void config_output(struct hantro_ctx *ctx,
 	dma_addr_t luma_addr, chroma_addr, mv_addr;
 
 	hantro_reg_write(ctx->dev, &g2_out_dis, 0);
-	hantro_reg_write(ctx->dev, &g2_output_format, 0);
+	if (!ctx->dev->variant->legacy_regs)
+		hantro_reg_write(ctx->dev, &g2_output_format, 0);
 
 	luma_addr = hantro_get_dec_buf_addr(ctx, &dst->base.vb.vb2_buf);
 	hantro_write_addr(ctx->dev, G2_OUT_LUMA_ADDR, luma_addr);
@@ -327,6 +328,7 @@ config_tiles(struct hantro_ctx *ctx,
 	struct hantro_aux_buf *tile_edge = &vp9_ctx->tile_edge;
 	dma_addr_t addr;
 	unsigned short *tile_mem;
+	unsigned int rows, cols;
 
 	addr = misc->dma + vp9_ctx->tile_info_offset;
 	hantro_write_addr(ctx->dev, G2_TILE_SIZES_ADDR, addr);
@@ -344,17 +346,24 @@ config_tiles(struct hantro_ctx *ctx,
 
 		fill_tile_info(ctx, tile_r, tile_c, sbs_r, sbs_c, tile_mem);
 
+		cols = tile_c;
+		rows = tile_r;
 		hantro_reg_write(ctx->dev, &g2_tile_e, 1);
-		hantro_reg_write(ctx->dev, &g2_num_tile_cols, tile_c);
-		hantro_reg_write(ctx->dev, &g2_num_tile_rows, tile_r);
-
 	} else {
 		tile_mem[0] = hantro_vp9_num_sbs(dst->vp9.width);
 		tile_mem[1] = hantro_vp9_num_sbs(dst->vp9.height);
 
+		cols = 1;
+		rows = 1;
 		hantro_reg_write(ctx->dev, &g2_tile_e, 0);
-		hantro_reg_write(ctx->dev, &g2_num_tile_cols, 1);
-		hantro_reg_write(ctx->dev, &g2_num_tile_rows, 1);
+	}
+
+	if (ctx->dev->variant->legacy_regs) {
+		hantro_reg_write(ctx->dev, &g2_num_tile_cols_old, cols);
+		hantro_reg_write(ctx->dev, &g2_num_tile_rows_old, rows);
+	} else {
+		hantro_reg_write(ctx->dev, &g2_num_tile_cols, cols);
+		hantro_reg_write(ctx->dev, &g2_num_tile_rows, rows);
 	}
 
 	/* provide aux buffers even if no tiles are used */
@@ -505,8 +514,22 @@ static void config_picture_dimensions(struct hantro_ctx *ctx, struct hantro_deco
 static void
 config_bit_depth(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_frame *dec_params)
 {
-	hantro_reg_write(ctx->dev, &g2_bit_depth_y_minus8, dec_params->bit_depth - 8);
-	hantro_reg_write(ctx->dev, &g2_bit_depth_c_minus8, dec_params->bit_depth - 8);
+	if (ctx->dev->variant->legacy_regs) {
+		u8 pp_shift = 0;
+
+		hantro_reg_write(ctx->dev, &g2_bit_depth_y, dec_params->bit_depth);
+		hantro_reg_write(ctx->dev, &g2_bit_depth_c, dec_params->bit_depth);
+		hantro_reg_write(ctx->dev, &g2_rs_out_bit_depth, dec_params->bit_depth);
+
+		if (dec_params->bit_depth > 8)
+			pp_shift = 16 - dec_params->bit_depth;
+
+		hantro_reg_write(ctx->dev, &g2_pp_pix_shift, pp_shift);
+		hantro_reg_write(ctx->dev, &g2_pix_shift, 0);
+	} else {
+		hantro_reg_write(ctx->dev, &g2_bit_depth_y_minus8, dec_params->bit_depth - 8);
+		hantro_reg_write(ctx->dev, &g2_bit_depth_c_minus8, dec_params->bit_depth - 8);
+	}
 }
 
 static inline bool is_lossless(const struct v4l2_vp9_quantization *quant)
@@ -784,9 +807,13 @@ config_source(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_frame *dec_para
 		     + dec_params->compressed_header_size;
 
 	stream_base = vb2_dma_contig_plane_dma_addr(&vb2_src->vb2_buf, 0);
-	hantro_write_addr(ctx->dev, G2_STREAM_ADDR, stream_base);
 
 	tmp_addr = stream_base + headres_size;
+	if (ctx->dev->variant->legacy_regs)
+		hantro_write_addr(ctx->dev, G2_STREAM_ADDR, (tmp_addr & ~0xf));
+	else
+		hantro_write_addr(ctx->dev, G2_STREAM_ADDR, stream_base);
+
 	start_bit = (tmp_addr & 0xf) * 8;
 	hantro_reg_write(ctx->dev, &g2_start_bit, start_bit);
 
@@ -794,10 +821,12 @@ config_source(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_frame *dec_para
 	src_len += start_bit / 8 - headres_size;
 	hantro_reg_write(ctx->dev, &g2_stream_len, src_len);
 
-	tmp_addr &= ~0xf;
-	hantro_reg_write(ctx->dev, &g2_strm_start_offset, tmp_addr - stream_base);
-	src_buf_len = vb2_plane_size(&vb2_src->vb2_buf, 0);
-	hantro_reg_write(ctx->dev, &g2_strm_buffer_len, src_buf_len);
+	if (!ctx->dev->variant->legacy_regs) {
+		tmp_addr &= ~0xf;
+		hantro_reg_write(ctx->dev, &g2_strm_start_offset, tmp_addr - stream_base);
+		src_buf_len = vb2_plane_size(&vb2_src->vb2_buf, 0);
+		hantro_reg_write(ctx->dev, &g2_strm_buffer_len, src_buf_len);
+	}
 }
 
 static void
@@ -837,13 +866,24 @@ config_registers(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_frame *dec_p
 
 	/* configure basic registers */
 	hantro_reg_write(ctx->dev, &g2_mode, VP9_DEC_MODE);
-	hantro_reg_write(ctx->dev, &g2_strm_swap, 0xf);
-	hantro_reg_write(ctx->dev, &g2_dirmv_swap, 0xf);
-	hantro_reg_write(ctx->dev, &g2_compress_swap, 0xf);
+	if (!ctx->dev->variant->legacy_regs) {
+		hantro_reg_write(ctx->dev, &g2_strm_swap, 0xf);
+		hantro_reg_write(ctx->dev, &g2_dirmv_swap, 0xf);
+		hantro_reg_write(ctx->dev, &g2_compress_swap, 0xf);
+		hantro_reg_write(ctx->dev, &g2_ref_compress_bypass, 1);
+	} else {
+		hantro_reg_write(ctx->dev, &g2_strm_swap_old, 0x1f);
+		hantro_reg_write(ctx->dev, &g2_pic_swap, 0x10);
+		hantro_reg_write(ctx->dev, &g2_dirmv_swap_old, 0x10);
+		hantro_reg_write(ctx->dev, &g2_tab0_swap_old, 0x10);
+		hantro_reg_write(ctx->dev, &g2_tab1_swap_old, 0x10);
+		hantro_reg_write(ctx->dev, &g2_tab2_swap_old, 0x10);
+		hantro_reg_write(ctx->dev, &g2_tab3_swap_old, 0x10);
+		hantro_reg_write(ctx->dev, &g2_rscan_swap, 0x10);
+	}
 	hantro_reg_write(ctx->dev, &g2_buswidth, BUS_WIDTH_128);
 	hantro_reg_write(ctx->dev, &g2_max_burst, 16);
 	hantro_reg_write(ctx->dev, &g2_apf_threshold, 8);
-	hantro_reg_write(ctx->dev, &g2_ref_compress_bypass, 1);
 	hantro_reg_write(ctx->dev, &g2_clk_gate_e, 1);
 	hantro_reg_write(ctx->dev, &g2_max_cb_size, 6);
 	hantro_reg_write(ctx->dev, &g2_min_cb_size, 3);
-- 
2.34.1

