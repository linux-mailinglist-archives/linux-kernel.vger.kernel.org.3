Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC6F56812C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiGFIWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiGFIWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:22:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0951A24088
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:22:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j184so2802377pge.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tzsTUPer+0o5JrSvbM00/ftmdSn3qVjH8yi2nWJbM/w=;
        b=mqSndZ96uiMn4f1N/DcFpXyIdIuKuFdag/D803aO8dhJJ0Z+hvsSZr3/qyuDyIADlS
         OR2yPiQveew7sSh+e3802h+bxPReta3hMAeAQg1qGktG/IZU8HqJTaKQHNm3H9J+vBCq
         S9YtfNZnFtpk+nwoqmCOzdoa0RTnRWps5CH5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tzsTUPer+0o5JrSvbM00/ftmdSn3qVjH8yi2nWJbM/w=;
        b=1ZHJNYVSE66A3rEOxvC60rJkZudSARk3BoJA99IWkByQZypQgCRs3SlADxODPdZuWy
         CqGRV/0byXEJye4GaXIVDeCdQHgxMX8AyFhEuT2yAQAHfz/qGWc5xKzgrlY6H5oqABte
         0RC6UnOUMdtGZVjNhNm6ofb9tafz/waE9gWVl5TZ5pGcvgAXgCJB0HMUE+bkBFGCDrA9
         YmFpk8cdjceWoMosLEiB0y85WcNean/7ya51Gb7emXrXNN+N5Npzz5kl/oJx/j7hkMFS
         +X9hwgw6+6ApFOon2lGWyVYtnSpCepChHSBWv3oUkRYN1QM3zn3IzREM/WBeambjZb0k
         DnjA==
X-Gm-Message-State: AJIora9hHKsxkqO/5FUjMMfuM0nhzikTw9v3HAkz6VMtqUXOGOSj63Xd
        IFXlnat+wxepMgfoPkoa8UP6kQ==
X-Google-Smtp-Source: AGRyM1sRhzOvdaaPebWzk1B4vMT9IkVr/4sM8+UOGncrYbbYX28ekEMRt8Hkp9ZCb9eRECdSOpMZVg==
X-Received: by 2002:a65:6048:0:b0:412:73c7:cca9 with SMTP id a8-20020a656048000000b0041273c7cca9mr6240152pgp.257.1657095731316;
        Wed, 06 Jul 2022 01:22:11 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74a3:a7a4:af57:d7f])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm20767040pjb.2.2022.07.06.01.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:22:11 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v2 6/6] media: mediatek: vcodec: decoder: Embed framesize inside mtk_video_fmt
Date:   Wed,  6 Jul 2022 16:21:38 +0800
Message-Id: <20220706082138.2668163-7-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220706082138.2668163-1-wenst@chromium.org>
References: <20220706082138.2668163-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the decoder maintains two separate lists for supported pixel
formats and frame sizes. Getting the supported frame sizes for the
current set format is a bit convoluted, requiring a search through
the separate frame size list. The frame sizes are used to clamp and
align requested resolutions.

Instead, the frame size structure could be embedded inside the pixel
format structure. Getting one also gets the other. And since the
the driver already keeps pointers to the current set format, getting
the frame sizes becomes straightforward.

Do just that. Move v4l2_frmsize_stepwise inside mtk_video_fmt, and get
rid of mtk_codec_framesizes.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 36 +++++--------------
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c | 29 ++++-----------
 .../vcodec/mtk_vcodec_dec_stateless.c         | 23 ++++--------
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 16 +--------
 4 files changed, 22 insertions(+), 82 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 2d370e8041c1..bdcddeaa997c 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -261,42 +261,20 @@ static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
 	}
 }
 
-static const struct v4l2_frmsize_stepwise *mtk_vdec_get_frmsize(struct mtk_vcodec_ctx *ctx,
-								u32 pixfmt)
-{
-	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
-	int i;
-
-	for (i = 0; i < *dec_pdata->num_framesizes; ++i)
-		if (pixfmt == dec_pdata->vdec_framesizes[i].fourcc)
-			return &dec_pdata->vdec_framesizes[i].stepwise;
-
-	/*
-	 * This should never happen since vidioc_try_fmt_vid_out_mplane()
-	 * always passes through a valid format for the output side, and
-	 * for the capture side, a valid output format should already have
-	 * been set.
-	 */
-	WARN_ONCE(1, "Unsupported format requested.\n");
-	return &dec_pdata->vdec_framesizes[0].stepwise;
-}
-
 static int vidioc_try_fmt(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
 			  const struct mtk_video_fmt *fmt)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
 	const struct v4l2_frmsize_stepwise *frmsize;
-	u32 fourcc;
 
 	pix_fmt_mp->field = V4L2_FIELD_NONE;
 
 	/* Always apply frame size constraints from the coded side */
 	if (V4L2_TYPE_IS_OUTPUT(f->type))
-		fourcc = f->fmt.pix_mp.pixelformat;
+		frmsize = &fmt->frmsize;
 	else
-		fourcc = ctx->q_data[MTK_Q_DATA_SRC].fmt->fourcc;
+		frmsize = &ctx->q_data[MTK_Q_DATA_SRC].fmt->frmsize;
 
-	frmsize = mtk_vdec_get_frmsize(ctx, fourcc);
 	pix_fmt_mp->width = clamp(pix_fmt_mp->width, MTK_VDEC_MIN_W, frmsize->max_width);
 	pix_fmt_mp->height = clamp(pix_fmt_mp->height, MTK_VDEC_MIN_H, frmsize->max_height);
 
@@ -596,12 +574,16 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 	if (fsize->index != 0)
 		return -EINVAL;
 
-	for (i = 0; i < *dec_pdata->num_framesizes; ++i) {
-		if (fsize->pixel_format != dec_pdata->vdec_framesizes[i].fourcc)
+	for (i = 0; i < *dec_pdata->num_formats; i++) {
+		if (fsize->pixel_format != dec_pdata->vdec_formats[i].fourcc)
 			continue;
 
+		/* Only coded formats have frame sizes set */
+		if (!dec_pdata->vdec_formats[i].frmsize.max_width)
+			return -ENOTTY;
+
 		fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
-		fsize->stepwise = dec_pdata->vdec_framesizes[i].stepwise;
+		fsize->stepwise = dec_pdata->vdec_formats[i].frmsize;
 
 		mtk_v4l2_debug(1, "%x, %d %d %d %d %d %d",
 				ctx->dev->dec_capability,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
index 9c7e6145cebb..035c86e7809f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateful.c
@@ -17,18 +17,24 @@ static const struct mtk_video_fmt mtk_video_formats[] = {
 		.type = MTK_FMT_DEC,
 		.num_planes = 1,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
+		.frmsize = { MTK_VDEC_MIN_W, MTK_VDEC_MAX_W, 16,
+			     MTK_VDEC_MIN_H, MTK_VDEC_MAX_H, 16 },
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_VP8,
 		.type = MTK_FMT_DEC,
 		.num_planes = 1,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
+		.frmsize = { MTK_VDEC_MIN_W, MTK_VDEC_MAX_W, 16,
+			     MTK_VDEC_MIN_H, MTK_VDEC_MAX_H, 16 },
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_VP9,
 		.type = MTK_FMT_DEC,
 		.num_planes = 1,
 		.flags = V4L2_FMT_FLAG_DYN_RESOLUTION,
+		.frmsize = { MTK_VDEC_MIN_W, MTK_VDEC_MAX_W, 16,
+			     MTK_VDEC_MIN_H, MTK_VDEC_MAX_H, 16 },
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_MT21C,
@@ -43,27 +49,6 @@ static const unsigned int num_supported_formats =
 #define DEFAULT_OUT_FMT_IDX 0
 #define DEFAULT_CAP_FMT_IDX 3
 
-static const struct mtk_codec_framesizes mtk_vdec_framesizes[] = {
-	{
-		.fourcc = V4L2_PIX_FMT_H264,
-		.stepwise = { MTK_VDEC_MIN_W, MTK_VDEC_MAX_W, 16,
-			      MTK_VDEC_MIN_H, MTK_VDEC_MAX_H, 16 },
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_VP8,
-		.stepwise = { MTK_VDEC_MIN_W, MTK_VDEC_MAX_W, 16,
-			      MTK_VDEC_MIN_H, MTK_VDEC_MAX_H, 16 },
-	},
-	{
-		.fourcc = V4L2_PIX_FMT_VP9,
-		.stepwise = { MTK_VDEC_MIN_W, MTK_VDEC_MAX_W, 16,
-			      MTK_VDEC_MIN_H, MTK_VDEC_MAX_H, 16 },
-	},
-};
-
-static const unsigned int num_supported_framesize =
-	ARRAY_SIZE(mtk_vdec_framesizes);
-
 /*
  * This function tries to clean all display buffers, the buffers will return
  * in display order.
@@ -618,8 +603,6 @@ const struct mtk_vcodec_dec_pdata mtk_vdec_8173_pdata = {
 	.num_formats = &num_supported_formats,
 	.default_out_fmt = &mtk_video_formats[DEFAULT_OUT_FMT_IDX],
 	.default_cap_fmt = &mtk_video_formats[DEFAULT_CAP_FMT_IDX],
-	.vdec_framesizes = mtk_vdec_framesizes,
-	.num_framesizes = &num_supported_framesize,
 	.worker = mtk_vdec_worker,
 	.flush_decoder = mtk_vdec_flush_decoder,
 	.is_subdev_supported = false,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index 5da9901e93a3..c45bd2599bb2 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -112,12 +112,10 @@ static const struct mtk_stateless_control mtk_stateless_controls[] = {
 #define NUM_CTRLS ARRAY_SIZE(mtk_stateless_controls)
 
 static struct mtk_video_fmt mtk_video_formats[5];
-static struct mtk_codec_framesizes mtk_vdec_framesizes[3];
 
 static struct mtk_video_fmt default_out_format;
 static struct mtk_video_fmt default_cap_format;
 static unsigned int num_formats;
-static unsigned int num_framesizes;
 
 static const struct v4l2_frmsize_stepwise stepwise_fhd = {
 	.min_width = MTK_VDEC_MIN_W,
@@ -348,7 +346,6 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 	struct mtk_vcodec_dev *dev = ctx->dev;
 	const struct mtk_vcodec_dec_pdata *pdata = dev->vdec_pdata;
 	int count_formats = *pdata->num_formats;
-	int count_framesizes = *pdata->num_framesizes;
 
 	switch (fourcc) {
 	case V4L2_PIX_FMT_H264_SLICE:
@@ -357,17 +354,15 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 		mtk_video_formats[count_formats].fourcc = fourcc;
 		mtk_video_formats[count_formats].type = MTK_FMT_DEC;
 		mtk_video_formats[count_formats].num_planes = 1;
+		mtk_video_formats[count_formats].frmsize = stepwise_fhd;
 
-		mtk_vdec_framesizes[count_framesizes].fourcc = fourcc;
-		mtk_vdec_framesizes[count_framesizes].stepwise = stepwise_fhd;
 		if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED) &&
 		    fourcc != V4L2_PIX_FMT_VP8_FRAME) {
-			mtk_vdec_framesizes[count_framesizes].stepwise.max_width =
+			mtk_video_formats[count_formats].frmsize.max_width =
 				VCODEC_DEC_4K_CODED_WIDTH;
-			mtk_vdec_framesizes[count_framesizes].stepwise.max_height =
+			mtk_video_formats[count_formats].frmsize.max_height =
 				VCODEC_DEC_4K_CODED_HEIGHT;
 		}
-		num_framesizes++;
 		break;
 	case V4L2_PIX_FMT_MM21:
 	case V4L2_PIX_FMT_MT21C:
@@ -381,15 +376,15 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 	}
 
 	num_formats++;
-	mtk_v4l2_debug(3, "num_formats: %d num_frames:%d dec_capability: 0x%x",
-		       count_formats, count_framesizes, ctx->dev->dec_capability);
+	mtk_v4l2_debug(3, "num_formats: %d dec_capability: 0x%x",
+		       count_formats, ctx->dev->dec_capability);
 }
 
 static void mtk_vcodec_get_supported_formats(struct mtk_vcodec_ctx *ctx)
 {
 	int cap_format_count = 0, out_format_count = 0;
 
-	if (num_formats && num_framesizes)
+	if (num_formats)
 		return;
 
 	if (ctx->dev->dec_capability & MTK_VDEC_FORMAT_MM21) {
@@ -468,8 +463,6 @@ const struct mtk_vcodec_dec_pdata mtk_vdec_8183_pdata = {
 	.num_formats = &num_formats,
 	.default_out_fmt = &default_out_format,
 	.default_cap_fmt = &default_cap_format,
-	.vdec_framesizes = mtk_vdec_framesizes,
-	.num_framesizes = &num_framesizes,
 	.uses_stateless_api = true,
 	.worker = mtk_vdec_worker,
 	.flush_decoder = mtk_vdec_flush_decoder,
@@ -488,8 +481,6 @@ const struct mtk_vcodec_dec_pdata mtk_lat_sig_core_pdata = {
 	.num_formats = &num_formats,
 	.default_out_fmt = &default_out_format,
 	.default_cap_fmt = &default_cap_format,
-	.vdec_framesizes = mtk_vdec_framesizes,
-	.num_framesizes = &num_framesizes,
 	.uses_stateless_api = true,
 	.worker = mtk_vdec_worker,
 	.flush_decoder = mtk_vdec_flush_decoder,
@@ -507,8 +498,6 @@ const struct mtk_vcodec_dec_pdata mtk_vdec_single_core_pdata = {
 	.num_formats = &num_formats,
 	.default_out_fmt = &default_out_format,
 	.default_cap_fmt = &default_cap_format,
-	.vdec_framesizes = mtk_vdec_framesizes,
-	.num_framesizes = &num_framesizes,
 	.uses_stateless_api = true,
 	.worker = mtk_vdec_worker,
 	.flush_decoder = mtk_vdec_flush_decoder,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 4f15f5f60e40..9c6ae78c346c 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -126,15 +126,7 @@ struct mtk_video_fmt {
 	enum mtk_fmt_type	type;
 	u32	num_planes;
 	u32	flags;
-};
-
-/*
- * struct mtk_codec_framesizes - Structure used to store information about
- *							framesizes
- */
-struct mtk_codec_framesizes {
-	u32	fourcc;
-	struct	v4l2_frmsize_stepwise	stepwise;
+	struct v4l2_frmsize_stepwise frmsize;
 };
 
 /*
@@ -371,9 +363,6 @@ enum mtk_vdec_format_types {
  * @default_out_fmt: default output buffer format
  * @default_cap_fmt: default capture buffer format
  *
- * @vdec_framesizes: supported video decoder frame sizes
- * @num_framesizes: count of video decoder frame sizes
- *
  * @hw_arch: hardware arch is used to separate pure_sin_core and lat_sin_core
  *
  * @is_subdev_supported: whether support parent-node architecture(subdev)
@@ -396,9 +385,6 @@ struct mtk_vcodec_dec_pdata {
 	const struct mtk_video_fmt *default_out_fmt;
 	const struct mtk_video_fmt *default_cap_fmt;
 
-	const struct mtk_codec_framesizes *vdec_framesizes;
-	const int *num_framesizes;
-
 	enum mtk_vdec_hw_arch hw_arch;
 
 	bool is_subdev_supported;
-- 
2.37.0.rc0.161.g10f37bed90-goog

