Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BA14F1DE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbiDDVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378956AbiDDQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:08:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4CC13F42;
        Mon,  4 Apr 2022 09:06:48 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:52e1:bbc1:ca8:7fa9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 28DBD1F44781;
        Mon,  4 Apr 2022 17:06:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649088407;
        bh=UE2FWmObC+jA7OoH60RI24ebXQ1nf3RF8d8e13WDrks=;
        h=From:To:Cc:Subject:Date:From;
        b=jWmszvhaHQAYM/IlcPK923x9NevQ578xElCfl3u0nirgg+Gyfnsn5TrjfdL/Y6yJk
         dyCjZAHdglYFMCtCaJWNI3gKqCFa8qZ7WJMXcMUiwHDojnF++weMDYDFZt2YpmMeVP
         TPsoDU1hIlf9MDdx5u0mdoEfILcSJJ6LmJ3Qt0jZwLrMue9Ftp/nIM0LHlAoODTV1d
         es04sGjtFkXAXfNyZtbKUF1uMSrimCugawCBZGtoHlezaLDEwTPMq/1URawSzHkx91
         zTA659TUEVkEnF9TkQoFvHGyeyeXgc1FJB5VN9NM+VeLKwcj+N4wSRWtjgXgFu9IUY
         q9fcH6tf9uFQg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@collabora.com, sebastian.fricke@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2] media: hantro: Use post processor scaling capacities
Date:   Mon,  4 Apr 2022 18:06:40 +0200
Message-Id: <20220404160640.887784-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hantro G2 post processor is able to down scale decoded frames
by a factor of 2, 4 or 8.
Add enum_framesizes() ops to postproc_ops structure to enumerate the
possible output sizes for a given input resolution.
For G2 post-processor use fsize->index (from 0 to 3) as power of 2
divisor. As described in v4l2 documentation return -EINVAL when scaling
down isn't possible.

fluster scores:
77/147 for HEVC
143/303 for VP9

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 2:
- fix commit message
- add fluster scores for HEVC and VP9

 drivers/staging/media/hantro/hantro.h         |  2 +
 drivers/staging/media/hantro/hantro_g2_regs.h |  6 +++
 drivers/staging/media/hantro/hantro_hw.h      |  8 ++-
 .../staging/media/hantro/hantro_postproc.c    | 53 ++++++++++++++++++-
 drivers/staging/media/hantro/hantro_v4l2.c    | 15 +++---
 5 files changed, 72 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
index 357f83b86809..26308bb29adc 100644
--- a/drivers/staging/media/hantro/hantro.h
+++ b/drivers/staging/media/hantro/hantro.h
@@ -475,5 +475,7 @@ void hantro_postproc_disable(struct hantro_ctx *ctx);
 void hantro_postproc_enable(struct hantro_ctx *ctx);
 void hantro_postproc_free(struct hantro_ctx *ctx);
 int hantro_postproc_alloc(struct hantro_ctx *ctx);
+int hanto_postproc_enum_framesizes(struct hantro_ctx *ctx,
+				   struct v4l2_frmsizeenum *fsize);
 
 #endif /* HANTRO_H_ */
diff --git a/drivers/staging/media/hantro/hantro_g2_regs.h b/drivers/staging/media/hantro/hantro_g2_regs.h
index b7c6f9877b9d..877d663a8181 100644
--- a/drivers/staging/media/hantro/hantro_g2_regs.h
+++ b/drivers/staging/media/hantro/hantro_g2_regs.h
@@ -290,6 +290,10 @@
 #define g2_buswidth		G2_DEC_REG(58, 8,  0x7)
 #define g2_max_burst		G2_DEC_REG(58, 0,  0xff)
 
+#define g2_down_scale_e		G2_DEC_REG(184, 7, 0x1)
+#define g2_down_scale_y		G2_DEC_REG(184, 2, 0x3)
+#define g2_down_scale_x		G2_DEC_REG(184, 0, 0x3)
+
 #define G2_REG_CONFIG				G2_SWREG(58)
 #define G2_REG_CONFIG_DEC_CLK_GATE_E		BIT(16)
 #define G2_REG_CONFIG_DEC_CLK_GATE_IDLE_E	BIT(17)
@@ -312,6 +316,8 @@
 #define G2_TILE_FILTER_ADDR		(G2_SWREG(179))
 #define G2_TILE_SAO_ADDR		(G2_SWREG(181))
 #define G2_TILE_BSD_ADDR		(G2_SWREG(183))
+#define G2_DS_DST			(G2_SWREG(186))
+#define G2_DS_DST_CHR			(G2_SWREG(188))
 
 #define g2_strm_buffer_len	G2_DEC_REG(258, 0, 0xffffffff)
 #define g2_strm_start_offset	G2_DEC_REG(259, 0, 0xffffffff)
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index ed018e293ba0..09f17a3ceb95 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -245,12 +245,16 @@ struct hantro_postproc_ctx {
 /**
  * struct hantro_postproc_ops - post-processor operations
  *
- * @enable:	Enable the post-processor block. Optional.
- * @disable:	Disable the post-processor block. Optional.
+ * @enable:		Enable the post-processor block. Optional.
+ * @disable:		Disable the post-processor block. Optional.
+ * @enum_framesizes:	Enumerate possible scaled output formats.
+ *			Returns zero if OK, a negative value in error cases.
+ *			Optional.
  */
 struct hantro_postproc_ops {
 	void (*enable)(struct hantro_ctx *ctx);
 	void (*disable)(struct hantro_ctx *ctx);
+	int (*enum_framesizes)(struct hantro_ctx *ctx, struct v4l2_frmsizeenum *fsize);
 };
 
 /**
diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/staging/media/hantro/hantro_postproc.c
index 248abe5423f0..ab168c1c0d28 100644
--- a/drivers/staging/media/hantro/hantro_postproc.c
+++ b/drivers/staging/media/hantro/hantro_postproc.c
@@ -100,21 +100,58 @@ static void hantro_postproc_g1_enable(struct hantro_ctx *ctx)
 	HANTRO_PP_REG_WRITE(vpu, display_width, ctx->dst_fmt.width);
 }
 
+static int down_scale_factor(struct hantro_ctx *ctx)
+{
+	if (ctx->src_fmt.width == ctx->dst_fmt.width)
+		return 0;
+
+	return DIV_ROUND_CLOSEST(ctx->src_fmt.width, ctx->dst_fmt.width);
+}
+
 static void hantro_postproc_g2_enable(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
 	struct vb2_v4l2_buffer *dst_buf;
 	size_t chroma_offset = ctx->dst_fmt.width * ctx->dst_fmt.height;
+	int down_scale = down_scale_factor(ctx);
 	dma_addr_t dst_dma;
 
 	dst_buf = hantro_get_dst_buf(ctx);
 	dst_dma = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 
-	hantro_write_addr(vpu, G2_RS_OUT_LUMA_ADDR, dst_dma);
-	hantro_write_addr(vpu, G2_RS_OUT_CHROMA_ADDR, dst_dma + chroma_offset);
+	if (down_scale) {
+		hantro_reg_write(vpu, &g2_down_scale_e, 1);
+		hantro_reg_write(vpu, &g2_down_scale_y, down_scale >> 2);
+		hantro_reg_write(vpu, &g2_down_scale_x, down_scale >> 2);
+		hantro_write_addr(vpu, G2_DS_DST, dst_dma);
+		hantro_write_addr(vpu, G2_DS_DST_CHR, dst_dma + (chroma_offset >> down_scale));
+	} else {
+		hantro_write_addr(vpu, G2_RS_OUT_LUMA_ADDR, dst_dma);
+		hantro_write_addr(vpu, G2_RS_OUT_CHROMA_ADDR, dst_dma + chroma_offset);
+	}
 	hantro_reg_write(vpu, &g2_out_rs_e, 1);
 }
 
+static int hantro_postproc_g2_enum_framesizes(struct hantro_ctx *ctx,
+					      struct v4l2_frmsizeenum *fsize)
+{
+	/**
+	 * G2 scaler can scale down by 0, 2, 4 or 8
+	 * use fsize->index has power of 2 diviser
+	 **/
+	if (fsize->index > 3)
+		return -EINVAL;
+
+	if (!ctx->src_fmt.width || !ctx->src_fmt.height)
+		return -EINVAL;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
+	fsize->discrete.width = ctx->src_fmt.width >> fsize->index;
+	fsize->discrete.height = ctx->src_fmt.height >> fsize->index;
+
+	return 0;
+}
+
 void hantro_postproc_free(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
@@ -197,6 +234,17 @@ void hantro_postproc_enable(struct hantro_ctx *ctx)
 		vpu->variant->postproc_ops->enable(ctx);
 }
 
+int hanto_postproc_enum_framesizes(struct hantro_ctx *ctx,
+				   struct v4l2_frmsizeenum *fsize)
+{
+	struct hantro_dev *vpu = ctx->dev;
+
+	if (vpu->variant->postproc_ops && vpu->variant->postproc_ops->enum_framesizes)
+		return vpu->variant->postproc_ops->enum_framesizes(ctx, fsize);
+
+	return -EINVAL;
+}
+
 const struct hantro_postproc_ops hantro_g1_postproc_ops = {
 	.enable = hantro_postproc_g1_enable,
 	.disable = hantro_postproc_g1_disable,
@@ -205,4 +253,5 @@ const struct hantro_postproc_ops hantro_g1_postproc_ops = {
 const struct hantro_postproc_ops hantro_g2_postproc_ops = {
 	.enable = hantro_postproc_g2_enable,
 	.disable = hantro_postproc_g2_disable,
+	.enum_framesizes = hantro_postproc_g2_enum_framesizes,
 };
diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index 67148ba346f5..8314a2efd4c8 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -116,12 +116,6 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 	struct hantro_ctx *ctx = fh_to_ctx(priv);
 	const struct hantro_fmt *fmt;
 
-	if (fsize->index != 0) {
-		vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
-			  fsize->index);
-		return -EINVAL;
-	}
-
 	fmt = hantro_find_format(ctx, fsize->pixel_format);
 	if (!fmt) {
 		vpu_debug(0, "unsupported bitstream format (%08x)\n",
@@ -129,9 +123,14 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
-	/* This only makes sense for coded formats */
-	if (fmt->codec_mode == HANTRO_MODE_NONE)
+	/* For non-coded formats check if postprocessing scaling is possible */
+	if (fmt->codec_mode == HANTRO_MODE_NONE && hantro_needs_postproc(ctx, fmt)) {
+		return hanto_postproc_enum_framesizes(ctx, fsize);
+	} else if (fsize->index != 0) {
+		vpu_debug(0, "invalid frame size index (expected 0, got %d)\n",
+			  fsize->index);
 		return -EINVAL;
+	}
 
 	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
 	fsize->stepwise = fmt->frmsize;
-- 
2.32.0

