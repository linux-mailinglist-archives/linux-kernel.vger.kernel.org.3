Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71FD4AABE4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381360AbiBES6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381326AbiBES4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:45 -0500
X-Greylist: delayed 68 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 10:55:56 PST
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553DBC0401F5;
        Sat,  5 Feb 2022 10:55:56 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 631C3240018;
        Sat,  5 Feb 2022 18:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bmTxzvTu5IUiX+CK1RyRY9aBm5pWpgoWqh+V+7gT8I=;
        b=kkN7KMWoj9J2P+xEQT1grm/Vgyb8b8/2W5JnyLPfgm7fL/ZzxxnRGEDf9k+nRK2iQ55JUP
        d8K9k9oXDEd9CN0VLA8yGQ3trZFJx9GXvSQ+r+VHm0t+VT8rxfxvUcoTSoBwLBmJeCmOFp
        tjBLDpx29BMatT13sdeISNqzuzQs16H36F3XJtzEbh+xMIzUer3B5x01nvbdGPZ4wKGGO5
        RnmOjJgsdeH+UQn3arEIUMkLIcsMwb83P3Ef0EjKitX0e06eWmxE+f8eR7YlYPeYTBHlVp
        85XmRugLguT14cKztabI/WaH7neqYS29YybFUUkdGNSQ5CmD0AiMHFD1mpzQmg==
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
Subject: [PATCH v2 44/66] media: sun6i-csi: Introduce bridge format structure, list and helper
Date:   Sat,  5 Feb 2022 19:54:07 +0100
Message-Id: <20220205185429.2278860-45-paul.kocialkowski@bootlin.com>
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

Introduce a more informative format list for the bridge, with
information about how to configure the input. This separation will
later be useful when using the bridge standalone (without capture)
for the isp workflow.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 169 ++++++++++++++----
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  12 ++
 2 files changed, 145 insertions(+), 36 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index 5e2d4ffd9932..bb6260f28c45 100644
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
@@ -117,8 +214,8 @@ static const struct v4l2_subdev_video_ops sun6i_csi_bridge_video_ops = {
 static void
 sun6i_csi_bridge_mbus_format_prepare(struct v4l2_mbus_framefmt *mbus_format)
 {
-	if (!sun6i_csi_bridge_mbus_code_check(mbus_format->code))
-		mbus_format->code = sun6i_csi_bridge_mbus_codes[0];
+	if (!sun6i_csi_bridge_format_find(mbus_format->code))
+		mbus_format->code = sun6i_csi_bridge_formats[0].mbus_code;
 
 	mbus_format->field = V4L2_FIELD_NONE;
 	mbus_format->colorspace = V4L2_COLORSPACE_RAW;
@@ -133,7 +230,7 @@ static int sun6i_csi_bridge_init_cfg(struct v4l2_subdev *subdev,
 	struct v4l2_mbus_framefmt *mbus_format =
 		v4l2_subdev_get_try_format(subdev, state, pad);
 
-	mbus_format->code = sun6i_csi_bridge_mbus_codes[0];
+	mbus_format->code = sun6i_csi_bridge_formats[0].mbus_code;
 	mbus_format->width = 1280;
 	mbus_format->height = 720;
 
@@ -147,10 +244,10 @@ sun6i_csi_bridge_enum_mbus_code(struct v4l2_subdev *subdev,
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
index afef17b5a788..079227c02482 100644
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
@@ -43,6 +50,11 @@ void sun6i_csi_bridge_dimensions(struct sun6i_csi_device *csi_dev,
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
2.34.1

