Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551C7502CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355554AbiDOPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355414AbiDOPce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:32:34 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E181D64E8;
        Fri, 15 Apr 2022 08:28:57 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AC2D5E0012;
        Fri, 15 Apr 2022 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXuChdGCXB162OwmAXtTZumSjw2hTOB4SNr26U/r1Fg=;
        b=ZK7q+i/F9fppnl1MkmgROBsjhYCn+L7H4lQ+ANqXQ86pKzBNk+XsvBnQAKsqEVsrbJQOA5
        njmTTfVY69pKeJs0NcBIiuNwsRkq4NCqIwoxuyeVaq/joo/q7MJ8aHbMvF1Zh1L+mEGcwu
        Dre+MivwMj8aKwZ0q5Aa0jbhpA0cjUxfLYczgr3NwY7c+l19toSP3XgjQslfCST0n9F600
        5Sxm7SdSPRWqM0ccw27gjhmNd18CBEFVeS3GmwE8KAYRm4hvJqr6ZNu+ELea8SFKM8yjJt
        h5J1IJESt/stAzIHNeHJDLpXhAjh/WHOSl/28A/F5sZ3riTPRHfanyU3uKDpLg==
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
Subject: [PATCH v4 31/45] media: sun6i-csi: Introduce capture format structure, list and helper
Date:   Fri, 15 Apr 2022 17:27:57 +0200
Message-Id: <20220415152811.636419-32-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a table that describes each pixel format and associated output
register configuration with necessary tweaks. It will be used later on
to configure the hardware.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 199 ++++++++++++++----
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  12 ++
 2 files changed, 175 insertions(+), 36 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 9488c7c26f13..3d6d856b9213 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -60,45 +60,171 @@ sun6i_csi_capture_remote_subdev(struct sun6i_csi_capture *capture, u32 *pad)
 
 /* Format */
 
-static const u32 sun6i_csi_capture_formats[] = {
-	V4L2_PIX_FMT_SBGGR8,
-	V4L2_PIX_FMT_SGBRG8,
-	V4L2_PIX_FMT_SGRBG8,
-	V4L2_PIX_FMT_SRGGB8,
-	V4L2_PIX_FMT_SBGGR10,
-	V4L2_PIX_FMT_SGBRG10,
-	V4L2_PIX_FMT_SGRBG10,
-	V4L2_PIX_FMT_SRGGB10,
-	V4L2_PIX_FMT_SBGGR12,
-	V4L2_PIX_FMT_SGBRG12,
-	V4L2_PIX_FMT_SGRBG12,
-	V4L2_PIX_FMT_SRGGB12,
-	V4L2_PIX_FMT_YUYV,
-	V4L2_PIX_FMT_YVYU,
-	V4L2_PIX_FMT_UYVY,
-	V4L2_PIX_FMT_VYUY,
-	V4L2_PIX_FMT_NV12_16L16,
-	V4L2_PIX_FMT_NV12,
-	V4L2_PIX_FMT_NV21,
-	V4L2_PIX_FMT_YUV420,
-	V4L2_PIX_FMT_YVU420,
-	V4L2_PIX_FMT_NV16,
-	V4L2_PIX_FMT_NV61,
-	V4L2_PIX_FMT_YUV422P,
-	V4L2_PIX_FMT_RGB565,
-	V4L2_PIX_FMT_RGB565X,
-	V4L2_PIX_FMT_JPEG,
+static const struct sun6i_csi_capture_format sun6i_csi_capture_formats[] = {
+	/* Bayer */
+	{
+		.pixelformat		= V4L2_PIX_FMT_SBGGR8,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SGBRG8,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SGRBG8,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SRGGB8,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SBGGR10,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_10,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_10,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SGBRG10,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_10,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_10,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SGRBG10,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_10,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_10,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SRGGB10,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_10,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_10,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SBGGR12,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_12,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_12,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SGBRG12,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_12,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_12,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SGRBG12,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_12,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_12,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_SRGGB12,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_12,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_12,
+	},
+	/* RGB */
+	{
+		.pixelformat		= V4L2_PIX_FMT_RGB565,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RGB565,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RGB565,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_RGB565X,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RGB565,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RGB565,
+	},
+	/* YUV422 */
+	{
+		.pixelformat		= V4L2_PIX_FMT_YUYV,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8,
+		.input_format_raw	= true,
+		.hsize_len_factor	= 2,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_YVYU,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8,
+		.input_format_raw	= true,
+		.hsize_len_factor	= 2,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_UYVY,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8,
+		.input_format_raw	= true,
+		.hsize_len_factor	= 2,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_VYUY,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8,
+		.input_format_raw	= true,
+		.hsize_len_factor	= 2,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_NV16,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_YUV422SP,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_YUV422SP,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_NV61,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_YUV422SP,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_YUV422SP,
+		.input_yuv_seq_invert	= true,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_YUV422P,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_YUV422P,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_YUV422P,
+	},
+	/* YUV420 */
+	{
+		.pixelformat		= V4L2_PIX_FMT_NV12_16L16,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_YUV420MB,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_YUV420MB,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_NV12,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_YUV420SP,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_YUV420SP,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_NV21,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_YUV420SP,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_YUV420SP,
+		.input_yuv_seq_invert	= true,
+	},
+
+	{
+		.pixelformat		= V4L2_PIX_FMT_YUV420,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_YUV420P,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_YUV420P,
+	},
+	{
+		.pixelformat		= V4L2_PIX_FMT_YVU420,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_YUV420P,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_YUV420P,
+		.input_yuv_seq_invert	= true,
+	},
+	/* Compressed */
+	{
+		.pixelformat		= V4L2_PIX_FMT_JPEG,
+		.output_format_frame	= SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8,
+		.output_format_field	= SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8,
+	},
 };
 
-static bool sun6i_csi_capture_format_check(u32 format)
+const
+struct sun6i_csi_capture_format *sun6i_csi_capture_format_find(u32 pixelformat)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(sun6i_csi_capture_formats); i++)
-		if (sun6i_csi_capture_formats[i] == format)
-			return true;
+		if (sun6i_csi_capture_formats[i].pixelformat == pixelformat)
+			return &sun6i_csi_capture_formats[i];
 
-	return false;
+	return NULL;
 }
 
 /* Capture */
@@ -821,8 +947,9 @@ static void sun6i_csi_capture_format_prepare(struct v4l2_format *format)
 			      &pix_format->height, SUN6I_CSI_CAPTURE_HEIGHT_MIN,
 			      SUN6I_CSI_CAPTURE_HEIGHT_MAX, 1, 0);
 
-	if (!sun6i_csi_capture_format_check(pix_format->pixelformat))
-		pix_format->pixelformat = sun6i_csi_capture_formats[0];
+	if (!sun6i_csi_capture_format_find(pix_format->pixelformat))
+		pix_format->pixelformat =
+			sun6i_csi_capture_formats[0].pixelformat;
 
 	width = pix_format->width;
 	height = pix_format->height;
@@ -881,7 +1008,7 @@ static int sun6i_csi_capture_enum_fmt(struct file *file, void *private,
 	if (index >= ARRAY_SIZE(sun6i_csi_capture_formats))
 		return -EINVAL;
 
-	fmtdesc->pixelformat = sun6i_csi_capture_formats[index];
+	fmtdesc->pixelformat = sun6i_csi_capture_formats[index].pixelformat;
 
 	return 0;
 }
@@ -1153,7 +1280,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	/* V4L2 Format */
 
 	format->type = queue->type;
-	pix_format->pixelformat = sun6i_csi_capture_formats[0];
+	pix_format->pixelformat = sun6i_csi_capture_formats[0].pixelformat;
 	pix_format->width = 1280;
 	pix_format->height = 720;
 	pix_format->field = V4L2_FIELD_NONE;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 3b9759e1563d..4b1ff19edc2f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -18,6 +18,15 @@
 
 struct sun6i_csi_device;
 
+struct sun6i_csi_capture_format {
+	u32	pixelformat;
+	u8	output_format_field;
+	u8	output_format_frame;
+	bool	input_yuv_seq_invert;
+	bool	input_format_raw;
+	u32	hsize_len_factor;
+};
+
 #undef current
 struct sun6i_csi_capture_state {
 	struct list_head		queue;
@@ -46,6 +55,9 @@ void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
 void sun6i_csi_capture_format(struct sun6i_csi_device *csi_dev,
 			      u32 *pixelformat, u32 *field);
 
+const
+struct sun6i_csi_capture_format *sun6i_csi_capture_format_find(u32 pixelformat);
+
 void sun6i_csi_capture_sync(struct sun6i_csi_device *csi_dev);
 void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev);
 
-- 
2.35.2

