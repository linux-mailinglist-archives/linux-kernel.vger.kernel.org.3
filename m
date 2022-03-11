Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD24D63B5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349507AbiCKOiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347893AbiCKOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:37 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877891C8DAF;
        Fri, 11 Mar 2022 06:36:29 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CB64F240018;
        Fri, 11 Mar 2022 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQus7XQbf+fPVF49Vs3xuZQt/goLCAbN0lflmcEfzP4=;
        b=bvZPTuX4+xw6VMy+lfNLNtI/DflUxLisl4Zkx127lYoYqOny+RP+V9HGrEQK0L57618Qr8
        zAANHLWi4sLD5EQZ+4RiT/puhM/6JW2eSsOLkvhn3kt9HupdvRUm+ogHH1iUdBjuDx05Tf
        5A/TjSZcnKm9fIpHmMRt57RPrr1fzS7BXVrDfu03p38PT4sAQ4q09H+8ZMedaZ26kJ0jKs
        0/H3qbA6E3rLagxKUnvCTXgmM3o0Qxp4cRRIqBKxYsXlUC375+n7++383SngPG2f8EGRA4
        srvHUrFp6Zu9XePD1BE7dL5J//L+qY/GGgZK4D6o2RN/AsQ0zOVSzrAfM4B/GA==
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
Subject: [PATCH v3 25/46] media: sun6i-csi: Rework capture format management with helper
Date:   Fri, 11 Mar 2022 15:35:11 +0100
Message-Id: <20220311143532.265091-26-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the need for local copies of the v4l2 format and add a common
helper to prepare a format compatible with the driver, using the
relevant v4l2 helper.

Also cleanup the size bound defines while at it.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 109 +++++++++---------
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   5 +
 2 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 23b13b26b580..9c8b33c7e59c 100644
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
@@ -833,6 +827,46 @@ static const struct vb2_ops sun6i_csi_capture_queue_ops = {
 
 /* V4L2 Device */
 
+static void sun6i_csi_capture_format_prepare(struct v4l2_format *format)
+{
+	struct v4l2_pix_format *pix_format = &format->fmt.pix;
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
+	pix_format->colorspace = V4L2_COLORSPACE_RAW;
+	pix_format->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	pix_format->quantization = V4L2_QUANTIZATION_DEFAULT;
+	pix_format->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+}
+
 static int sun6i_csi_capture_querycap(struct file *file, void *private,
 				      struct v4l2_capability *capability)
 {
@@ -864,50 +898,8 @@ static int sun6i_csi_capture_g_fmt(struct file *file, void *private,
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
-	pix_format->colorspace = V4L2_COLORSPACE_RAW;
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
@@ -921,16 +913,19 @@ static int sun6i_csi_capture_s_fmt(struct file *file, void *private,
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
@@ -1125,8 +1120,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	struct video_device *video_dev = &capture->video_dev;
 	struct vb2_queue *queue = &capture->queue;
 	struct media_pad *pad = &capture->pad;
-	struct v4l2_format format = { 0 };
-	struct v4l2_pix_format *pix_format = &format.fmt.pix;
+	struct v4l2_format *format = &csi_dev->capture.format;
+	struct v4l2_pix_format *pix_format = &format->fmt.pix;
 	int ret;
 
 	/* State */
@@ -1169,13 +1164,13 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 
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
2.35.1

