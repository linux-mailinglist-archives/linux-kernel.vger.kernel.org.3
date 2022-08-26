Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428C05A2EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345210AbiHZSf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbiHZSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:34:15 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F5CE5887;
        Fri, 26 Aug 2022 11:33:42 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 69B97FF810;
        Fri, 26 Aug 2022 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aiwmBcryyTigoMDlULjAas04AR4pY8adTeVL5en+MB8=;
        b=MMPncZI4wZj6734fcxEvPgrLJ/066FmwizwJA2FoLO4djAq/M3/5blwxagvJQiRlR7BTnl
        wNwBgVRNlcz95E17uCWxo0wrrrWkMec0LI+BUVPhcIACnBaKRdGiTqsH8krKdPfQV5x6gv
        Ni/mydOFgy34u9cvyt0nm1EEWqeg7h8yfQ9MaKS5KNCOe2YJwYpRWgXUr2t3ny5Yymf0vg
        iwYCAIZ8trDJ6hEPGEWLVHPWVIWQuN+eq7GkW025Y1IeFB6tgcJPUT+aLX7TXQa2dqpiGT
        uO+Z1iwEF5yzKF0f0M95wYFX16IRYNS2cy93AUiZ3zNwe3lRneQ2uKHQKnQgYA==
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
Subject: [PATCH v6 30/43] media: sun6i-csi: Introduce bridge format structure, list and helper
Date:   Fri, 26 Aug 2022 20:32:27 +0200
Message-Id: <20220826183240.604834-31-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a more informative format list for the bridge, with
information about how to configure the input. This separation will
later be useful when using the bridge standalone (without capture)
for the isp workflow.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 169 ++++++++++++++----
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  12 ++
 2 files changed, 145 insertions(+), 36 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index b98a1e18ddef..0b45cfbe78b4 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -11,6 +11,7 @@
 
 #include "sun6i_csi.h"
 #include "sun6i_csi_bridge.h"
+#include "sun6i_csi_reg.h"
 
 /* Helpers */
 
@@ -34,47 +35,143 @@ void sun6i_csi_bridge_format(struct sun6i_csi_device *csi_dev,
 
 /* Format */
 
-static const u32 sun6i_csi_bridge_mbus_codes[] = {
+static const struct sun6i_csi_bridge_format sun6i_csi_bridge_formats[] = {
 	/* Bayer */
-	MEDIA_BUS_FMT_SBGGR8_1X8,
-	MEDIA_BUS_FMT_SGBRG8_1X8,
-	MEDIA_BUS_FMT_SGRBG8_1X8,
-	MEDIA_BUS_FMT_SRGGB8_1X8,
-	MEDIA_BUS_FMT_SBGGR10_1X10,
-	MEDIA_BUS_FMT_SGBRG10_1X10,
-	MEDIA_BUS_FMT_SGRBG10_1X10,
-	MEDIA_BUS_FMT_SRGGB10_1X10,
-	MEDIA_BUS_FMT_SBGGR12_1X12,
-	MEDIA_BUS_FMT_SGBRG12_1X12,
-	MEDIA_BUS_FMT_SGRBG12_1X12,
-	MEDIA_BUS_FMT_SRGGB12_1X12,
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SBGGR8_1X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SGBRG8_1X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SGRBG8_1X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SRGGB8_1X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SBGGR10_1X10,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SGBRG10_1X10,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SGRBG10_1X10,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SRGGB10_1X10,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SBGGR12_1X12,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SGBRG12_1X12,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SGRBG12_1X12,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_SRGGB12_1X12,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
 	/* RGB */
-	MEDIA_BUS_FMT_RGB565_2X8_LE,
-	MEDIA_BUS_FMT_RGB565_2X8_BE,
+	{
+		.mbus_code		= MEDIA_BUS_FMT_RGB565_2X8_LE,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_RGB565_2X8_BE,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
 	/* YUV422 */
-	MEDIA_BUS_FMT_YUYV8_2X8,
-	MEDIA_BUS_FMT_UYVY8_2X8,
-	MEDIA_BUS_FMT_YVYU8_2X8,
-	MEDIA_BUS_FMT_UYVY8_2X8,
-	MEDIA_BUS_FMT_VYUY8_2X8,
-	MEDIA_BUS_FMT_YUYV8_1X16,
-	MEDIA_BUS_FMT_UYVY8_1X16,
-	MEDIA_BUS_FMT_YVYU8_1X16,
-	MEDIA_BUS_FMT_UYVY8_1X16,
-	MEDIA_BUS_FMT_VYUY8_1X16,
+	{
+		.mbus_code		= MEDIA_BUS_FMT_YUYV8_2X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_YUYV,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_YVYU,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_UYVY8_2X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_UYVY,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_VYUY,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_YVYU8_2X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_YVYU,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_YUYV,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_UYVY8_2X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_UYVY,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_VYUY,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_VYUY8_2X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_VYUY,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_UYVY,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_YUYV8_1X16,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_YUYV,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_YVYU,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_UYVY8_1X16,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_UYVY,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_VYUY,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_YVYU8_1X16,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_YVYU,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_YUYV,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_UYVY8_1X16,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_UYVY,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_VYUY,
+	},
+	{
+		.mbus_code		= MEDIA_BUS_FMT_VYUY8_1X16,
+		.input_format		= SUN6I_CSI_INPUT_FMT_YUV422,
+		.input_yuv_seq		= SUN6I_CSI_INPUT_YUV_SEQ_VYUY,
+		.input_yuv_seq_invert	= SUN6I_CSI_INPUT_YUV_SEQ_UYVY,
+	},
 	/* Compressed */
-	MEDIA_BUS_FMT_JPEG_1X8,
+	{
+		.mbus_code		= MEDIA_BUS_FMT_JPEG_1X8,
+		.input_format		= SUN6I_CSI_INPUT_FMT_RAW,
+	},
 };
 
-static bool sun6i_csi_bridge_mbus_code_check(u32 mbus_code)
+const struct sun6i_csi_bridge_format *
+sun6i_csi_bridge_format_find(u32 mbus_code)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(sun6i_csi_bridge_mbus_codes); i++)
-		if (sun6i_csi_bridge_mbus_codes[i] == mbus_code)
-			return true;
+	for (i = 0; i < ARRAY_SIZE(sun6i_csi_bridge_formats); i++)
+		if (sun6i_csi_bridge_formats[i].mbus_code == mbus_code)
+			return &sun6i_csi_bridge_formats[i];
 
-	return false;
+	return NULL;
 }
 
 /* V4L2 Subdev */
@@ -124,8 +221,8 @@ static const struct v4l2_subdev_video_ops sun6i_csi_bridge_video_ops = {
 static void
 sun6i_csi_bridge_mbus_format_prepare(struct v4l2_mbus_framefmt *mbus_format)
 {
-	if (!sun6i_csi_bridge_mbus_code_check(mbus_format->code))
-		mbus_format->code = sun6i_csi_bridge_mbus_codes[0];
+	if (!sun6i_csi_bridge_format_find(mbus_format->code))
+		mbus_format->code = sun6i_csi_bridge_formats[0].mbus_code;
 
 	mbus_format->field = V4L2_FIELD_NONE;
 	mbus_format->colorspace = V4L2_COLORSPACE_RAW;
@@ -144,7 +241,7 @@ static int sun6i_csi_bridge_init_cfg(struct v4l2_subdev *subdev,
 
 	mutex_lock(lock);
 
-	mbus_format->code = sun6i_csi_bridge_mbus_codes[0];
+	mbus_format->code = sun6i_csi_bridge_formats[0].mbus_code;
 	mbus_format->width = 1280;
 	mbus_format->height = 720;
 
@@ -160,10 +257,10 @@ sun6i_csi_bridge_enum_mbus_code(struct v4l2_subdev *subdev,
 				struct v4l2_subdev_state *state,
 				struct v4l2_subdev_mbus_code_enum *code_enum)
 {
-	if (code_enum->index >= ARRAY_SIZE(sun6i_csi_bridge_mbus_codes))
+	if (code_enum->index >= ARRAY_SIZE(sun6i_csi_bridge_formats))
 		return -EINVAL;
 
-	code_enum->code = sun6i_csi_bridge_mbus_codes[code_enum->index];
+	code_enum->code = sun6i_csi_bridge_formats[code_enum->index].mbus_code;
 
 	return 0;
 }
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
index 5e6448aa522f..cb3b27af4607 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
@@ -20,6 +20,13 @@ enum sun6i_csi_bridge_pad {
 
 struct sun6i_csi_device;
 
+struct sun6i_csi_bridge_format {
+	u32	mbus_code;
+	u8	input_format;
+	u8	input_yuv_seq;
+	u8	input_yuv_seq_invert;
+};
+
 struct sun6i_csi_bridge_source {
 	struct v4l2_subdev		*subdev;
 	struct v4l2_fwnode_endpoint	endpoint;
@@ -48,6 +55,11 @@ void sun6i_csi_bridge_dimensions(struct sun6i_csi_device *csi_dev,
 void sun6i_csi_bridge_format(struct sun6i_csi_device *csi_dev,
 			     u32 *mbus_code, u32 *field);
 
+/* Format */
+
+const struct sun6i_csi_bridge_format *
+sun6i_csi_bridge_format_find(u32 mbus_code);
+
 /* Bridge */
 
 int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev);
-- 
2.37.1

