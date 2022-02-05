Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18F4AABF8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382018AbiBES6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381688AbiBES4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:44 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F9C043184;
        Sat,  5 Feb 2022 10:55:58 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 05E17240019;
        Sat,  5 Feb 2022 18:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pZo7CxGMUTpS8CVYK3FcpDVneJImTFLbxbcBcVuMPM=;
        b=D9kN4GUEwLQkqHmYTTIIvVyzpKMYn+Ak44xrbBmd3hhGqxgHHAp4uIYFGvv+5GsSyrjGSw
        KGw8aywE6tFOQb39PfSMcbdudsBuL1OmArqytd2qZ16T1mLpX6W3yJGTu6pnAu17okbeIv
        HUMk0iVu31aMbdR5QtTy3h+/iAs27DYKWiZyZHhO2MsN+oZM0AD3pDhEhOXzjjW33iR3BR
        Vy2JI6bqUyQ5LwYisSnxkLC9e0G2I0Vqqx9yzAFsBrdA/MFQLZr+PabOo7staxf+x5cOlq
        Sgqbz9IBSEqDBQs9XwACsLwPMlfKyIgbEjV8y199hulb5xBarLv+9gVORcNaGA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 45/66] media: sun6i-csi: Introduce capture format structure, list and helper
Date:   Sat,  5 Feb 2022 19:54:08 +0100
Message-Id: <20220205185429.2278860-46-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 726416d98c46..8e71c81cd54f 100644
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
@@ -820,8 +946,9 @@ static void sun6i_csi_capture_format_prepare(struct v4l2_format *format)
 			      &pix_format->height, SUN6I_CSI_CAPTURE_HEIGHT_MIN,
 			      SUN6I_CSI_CAPTURE_HEIGHT_MAX, 1, 0);
 
-	if (!sun6i_csi_capture_format_check(pix_format->pixelformat))
-		pix_format->pixelformat = sun6i_csi_capture_formats[0];
+	if (!sun6i_csi_capture_format_find(pix_format->pixelformat))
+		pix_format->pixelformat =
+			sun6i_csi_capture_formats[0].pixelformat;
 
 	width = pix_format->width;
 	height = pix_format->height;
@@ -872,7 +999,7 @@ static int sun6i_csi_capture_enum_fmt(struct file *file, void *private,
 	if (index >= ARRAY_SIZE(sun6i_csi_capture_formats))
 		return -EINVAL;
 
-	fmtdesc->pixelformat = sun6i_csi_capture_formats[index];
+	fmtdesc->pixelformat = sun6i_csi_capture_formats[index].pixelformat;
 
 	return 0;
 }
@@ -1144,7 +1271,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
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
2.34.1

