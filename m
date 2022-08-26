Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246165A2EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbiHZSfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbiHZSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:57 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E68E3C2C;
        Fri, 26 Aug 2022 11:33:36 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 210A8FF80C;
        Fri, 26 Aug 2022 18:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXmMB/NR+crFvCXeXyfmXcD25Z3llcjxt9in8I21Soo=;
        b=Otb9fLG8J72X7CM+YZYN0HV9fh4tBY44uxFEG6Yj7WtI8aA+Mmz0BE265Q1Kdhio5dvNmf
        x2kVeQCNqIy42g3lcHSrIiSH0UggbD9otPwQ/5pgpmaEQFAT00yad4l/aiAQ7mEaX9x02x
        Jqy+dZBFawV+GpQPoniAzsRC//maDpeeemru0uZQWlXFqCnNBmsNMYbBrySnkBDXJK2m46
        3gRN0p/wN8a2vLGhwLCuUdg6Tjq8qbnSSveqhsOR2Kffe0Ofg1AnBLiuvLpW52ah3/U5AT
        /onO4frspUmL5txDisgVh+1DwyHRvi754nyq5d1XfeXS3wlUUf6AMvFOu0eTMQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 25/43] media: sun6i-csi: Rework capture format management with helper
Date:   Fri, 26 Aug 2022 20:32:22 +0200
Message-Id: <20220826183240.604834-26-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the need for local copies of the v4l2 format and add a common
helper to prepare a format compatible with the driver, using the
relevant v4l2 helpers.

Report a raw colorspace for bayer-encoded pixel formats instead of SRGB.
Also cleanup the size bound defines while at it.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 122 +++++++++---------
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   5 +
 2 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 04bcd9621455..d8bcdbd3c9dc 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -20,12 +20,6 @@
 #include "sun6i_csi_capture.h"
 #include "sun6i_csi_reg.h"
 
-/* This is got from BSP sources. */
-#define MIN_WIDTH	(32)
-#define MIN_HEIGHT	(32)
-#define MAX_WIDTH	(4800)
-#define MAX_HEIGHT	(4800)
-
 /* Helpers */
 
 void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
@@ -833,6 +827,55 @@ static const struct vb2_ops sun6i_csi_capture_queue_ops = {
 
 /* V4L2 Device */
 
+static void sun6i_csi_capture_format_prepare(struct v4l2_format *format)
+{
+	struct v4l2_pix_format *pix_format = &format->fmt.pix;
+	const struct v4l2_format_info *info;
+	unsigned int width, height;
+
+	v4l_bound_align_image(&pix_format->width, SUN6I_CSI_CAPTURE_WIDTH_MIN,
+			      SUN6I_CSI_CAPTURE_WIDTH_MAX, 1,
+			      &pix_format->height, SUN6I_CSI_CAPTURE_HEIGHT_MIN,
+			      SUN6I_CSI_CAPTURE_HEIGHT_MAX, 1, 0);
+
+	if (!sun6i_csi_capture_format_check(pix_format->pixelformat))
+		pix_format->pixelformat = sun6i_csi_capture_formats[0];
+
+	width = pix_format->width;
+	height = pix_format->height;
+
+	info = v4l2_format_info(pix_format->pixelformat);
+
+	switch (pix_format->pixelformat) {
+	case V4L2_PIX_FMT_NV12_16L16:
+		pix_format->bytesperline = width * 12 / 8;
+		pix_format->sizeimage = pix_format->bytesperline * height;
+		break;
+	case V4L2_PIX_FMT_JPEG:
+		pix_format->bytesperline = width;
+		pix_format->sizeimage = pix_format->bytesperline * height;
+		break;
+	default:
+		v4l2_fill_pixfmt(pix_format, pix_format->pixelformat,
+				 width, height);
+		break;
+	}
+
+	if (pix_format->field == V4L2_FIELD_ANY)
+		pix_format->field = V4L2_FIELD_NONE;
+
+	if (pix_format->pixelformat == V4L2_PIX_FMT_JPEG)
+		pix_format->colorspace = V4L2_COLORSPACE_JPEG;
+	else if (info && info->pixel_enc == V4L2_PIXEL_ENC_BAYER)
+		pix_format->colorspace = V4L2_COLORSPACE_RAW;
+	else
+		pix_format->colorspace = V4L2_COLORSPACE_SRGB;
+
+	pix_format->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	pix_format->quantization = V4L2_QUANTIZATION_DEFAULT;
+	pix_format->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+}
+
 static int sun6i_csi_capture_querycap(struct file *file, void *private,
 				      struct v4l2_capability *capability)
 {
@@ -864,54 +907,8 @@ static int sun6i_csi_capture_g_fmt(struct file *file, void *private,
 				   struct v4l2_format *format)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
 
-	*format = capture->format;
-
-	return 0;
-}
-
-static int sun6i_csi_capture_format_try(struct sun6i_csi_capture *capture,
-					struct v4l2_format *format)
-{
-	struct v4l2_pix_format *pix_format = &format->fmt.pix;
-	int bpp;
-
-	if (!sun6i_csi_capture_format_check(pix_format->pixelformat))
-		pix_format->pixelformat = sun6i_csi_capture_formats[0];
-
-	v4l_bound_align_image(&pix_format->width, MIN_WIDTH, MAX_WIDTH, 1,
-			      &pix_format->height, MIN_HEIGHT, MAX_WIDTH, 1, 1);
-
-	bpp = sun6i_csi_get_bpp(pix_format->pixelformat);
-	pix_format->bytesperline = (pix_format->width * bpp) >> 3;
-	pix_format->sizeimage = pix_format->bytesperline * pix_format->height;
-
-	if (pix_format->field == V4L2_FIELD_ANY)
-		pix_format->field = V4L2_FIELD_NONE;
-
-	if (pix_format->pixelformat == V4L2_PIX_FMT_JPEG)
-		pix_format->colorspace = V4L2_COLORSPACE_JPEG;
-	else
-		pix_format->colorspace = V4L2_COLORSPACE_SRGB;
-
-	pix_format->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
-	pix_format->quantization = V4L2_QUANTIZATION_DEFAULT;
-	pix_format->xfer_func = V4L2_XFER_FUNC_DEFAULT;
-
-	return 0;
-}
-
-static int sun6i_csi_capture_format_set(struct sun6i_csi_capture *capture,
-					struct v4l2_format *format)
-{
-	int ret;
-
-	ret = sun6i_csi_capture_format_try(capture, format);
-	if (ret)
-		return ret;
-
-	capture->format = *format;
+	*format = csi_dev->capture.format;
 
 	return 0;
 }
@@ -925,16 +922,19 @@ static int sun6i_csi_capture_s_fmt(struct file *file, void *private,
 	if (vb2_is_busy(&capture->queue))
 		return -EBUSY;
 
-	return sun6i_csi_capture_format_set(capture, format);
+	sun6i_csi_capture_format_prepare(format);
+
+	csi_dev->capture.format = *format;
+
+	return 0;
 }
 
 static int sun6i_csi_capture_try_fmt(struct file *file, void *private,
 				     struct v4l2_format *format)
 {
-	struct sun6i_csi_device *csi_dev = video_drvdata(file);
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	sun6i_csi_capture_format_prepare(format);
 
-	return sun6i_csi_capture_format_try(capture, format);
+	return 0;
 }
 
 static int sun6i_csi_capture_enum_input(struct file *file, void *private,
@@ -1125,8 +1125,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	struct video_device *video_dev = &capture->video_dev;
 	struct vb2_queue *queue = &capture->queue;
 	struct media_pad *pad = &capture->pad;
-	struct v4l2_format format = { 0 };
-	struct v4l2_pix_format *pix_format = &format.fmt.pix;
+	struct v4l2_format *format = &csi_dev->capture.format;
+	struct v4l2_pix_format *pix_format = &format->fmt.pix;
 	int ret;
 
 	/* State */
@@ -1169,13 +1169,13 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 
 	/* V4L2 Format */
 
-	format.type = queue->type;
+	format->type = queue->type;
 	pix_format->pixelformat = sun6i_csi_capture_formats[0];
 	pix_format->width = 1280;
 	pix_format->height = 720;
 	pix_format->field = V4L2_FIELD_NONE;
 
-	sun6i_csi_capture_format_set(capture, &format);
+	sun6i_csi_capture_format_prepare(format);
 
 	/* Video Device */
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 935f35b7049a..02bdf45f7ca5 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -11,6 +11,11 @@
 #include <media/v4l2-dev.h>
 #include <media/videobuf2-core.h>
 
+#define SUN6I_CSI_CAPTURE_WIDTH_MIN	32
+#define SUN6I_CSI_CAPTURE_WIDTH_MAX	4800
+#define SUN6I_CSI_CAPTURE_HEIGHT_MIN	32
+#define SUN6I_CSI_CAPTURE_HEIGHT_MAX	4800
+
 struct sun6i_csi_device;
 
 #undef current
-- 
2.37.1

