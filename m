Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B622E5343F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344289AbiEYTKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbiEYTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:07:44 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F5C12639;
        Wed, 25 May 2022 12:07:09 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 34D141C0016;
        Wed, 25 May 2022 19:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/QiLfvh1s4xFB9vprcPBdNH3uFU6GTk1g20amxIsDng=;
        b=puuHY+gYo1h5mz+tQTnLqxljHGQpPxR3J2cCWijkTdinmIgY1U1CU9rIjEkBJoF91R3api
        JokAHiy12twShkofLfw6ZOXmMmjakGB/IDu9RB1ZWkpZpjXzJP6MwhxeeYqzO6/5JKQQC1
        Hk/Z0/Z9cDHwiKFnR29j/U8NCRq4h7/xW7U4Yt2fFy8tXHQqjqDKzA5jZfgiwzzheSl3sh
        XAv4QnigBcC/6TmBHdR71wfIsB/LRZBuATQjbk6FnFtHWP2XjZsSibtsnJZh+k0Nv7b3FN
        JkSRiB7PZs7JPSCzJRE4/j/T9nrprQXyB1ZTlkuM7zBTfXjIxbMVcwiw7YIAjA==
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
Subject: [PATCH v5 35/44] media: sun6i-csi: Implement capture link validation with logic
Date:   Wed, 25 May 2022 21:06:08 +0200
Message-Id: <20220525190617.696344-36-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
References: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
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

Rework the capture link validate implementation with actual logic that
reflects the possibilities of the device instead of the combinatory
helper functions, using the match list when needed.
Remove the previous dedicated helper.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 120 ------------------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |   9 --
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 106 +++++++++-------
 3 files changed, 62 insertions(+), 173 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 47ea3d68a4b5..75d9f7edf828 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -28,126 +28,6 @@
 #include "sun6i_csi.h"
 #include "sun6i_csi_reg.h"
 
-/* Helpers */
-
-/* TODO add 10&12 bit YUV, RGB support */
-bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
-				   u32 pixformat, u32 mbus_code)
-{
-	struct v4l2_fwnode_endpoint *endpoint =
-		&csi_dev->bridge.source_parallel.endpoint;
-
-	/*
-	 * Some video receivers have the ability to be compatible with
-	 * 8bit and 16bit bus width.
-	 * Identify the media bus format from device tree.
-	 */
-	if ((endpoint->bus_type == V4L2_MBUS_PARALLEL
-	     || endpoint->bus_type == V4L2_MBUS_BT656)
-	     && endpoint->bus.parallel.bus_width == 16) {
-		switch (pixformat) {
-		case V4L2_PIX_FMT_NV12_16L16:
-		case V4L2_PIX_FMT_NV12:
-		case V4L2_PIX_FMT_NV21:
-		case V4L2_PIX_FMT_NV16:
-		case V4L2_PIX_FMT_NV61:
-		case V4L2_PIX_FMT_YUV420:
-		case V4L2_PIX_FMT_YVU420:
-		case V4L2_PIX_FMT_YUV422P:
-			switch (mbus_code) {
-			case MEDIA_BUS_FMT_UYVY8_1X16:
-			case MEDIA_BUS_FMT_VYUY8_1X16:
-			case MEDIA_BUS_FMT_YUYV8_1X16:
-			case MEDIA_BUS_FMT_YVYU8_1X16:
-				return true;
-			default:
-				dev_dbg(csi_dev->dev,
-					"Unsupported mbus code: 0x%x\n",
-					mbus_code);
-				break;
-			}
-			break;
-		default:
-			dev_dbg(csi_dev->dev, "Unsupported pixformat: 0x%x\n",
-				pixformat);
-			break;
-		}
-		return false;
-	}
-
-	switch (pixformat) {
-	case V4L2_PIX_FMT_SBGGR8:
-		return (mbus_code == MEDIA_BUS_FMT_SBGGR8_1X8);
-	case V4L2_PIX_FMT_SGBRG8:
-		return (mbus_code == MEDIA_BUS_FMT_SGBRG8_1X8);
-	case V4L2_PIX_FMT_SGRBG8:
-		return (mbus_code == MEDIA_BUS_FMT_SGRBG8_1X8);
-	case V4L2_PIX_FMT_SRGGB8:
-		return (mbus_code == MEDIA_BUS_FMT_SRGGB8_1X8);
-	case V4L2_PIX_FMT_SBGGR10:
-		return (mbus_code == MEDIA_BUS_FMT_SBGGR10_1X10);
-	case V4L2_PIX_FMT_SGBRG10:
-		return (mbus_code == MEDIA_BUS_FMT_SGBRG10_1X10);
-	case V4L2_PIX_FMT_SGRBG10:
-		return (mbus_code == MEDIA_BUS_FMT_SGRBG10_1X10);
-	case V4L2_PIX_FMT_SRGGB10:
-		return (mbus_code == MEDIA_BUS_FMT_SRGGB10_1X10);
-	case V4L2_PIX_FMT_SBGGR12:
-		return (mbus_code == MEDIA_BUS_FMT_SBGGR12_1X12);
-	case V4L2_PIX_FMT_SGBRG12:
-		return (mbus_code == MEDIA_BUS_FMT_SGBRG12_1X12);
-	case V4L2_PIX_FMT_SGRBG12:
-		return (mbus_code == MEDIA_BUS_FMT_SGRBG12_1X12);
-	case V4L2_PIX_FMT_SRGGB12:
-		return (mbus_code == MEDIA_BUS_FMT_SRGGB12_1X12);
-
-	case V4L2_PIX_FMT_YUYV:
-		return (mbus_code == MEDIA_BUS_FMT_YUYV8_2X8);
-	case V4L2_PIX_FMT_YVYU:
-		return (mbus_code == MEDIA_BUS_FMT_YVYU8_2X8);
-	case V4L2_PIX_FMT_UYVY:
-		return (mbus_code == MEDIA_BUS_FMT_UYVY8_2X8);
-	case V4L2_PIX_FMT_VYUY:
-		return (mbus_code == MEDIA_BUS_FMT_VYUY8_2X8);
-
-	case V4L2_PIX_FMT_NV12_16L16:
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_YVU420:
-	case V4L2_PIX_FMT_YUV422P:
-		switch (mbus_code) {
-		case MEDIA_BUS_FMT_UYVY8_2X8:
-		case MEDIA_BUS_FMT_VYUY8_2X8:
-		case MEDIA_BUS_FMT_YUYV8_2X8:
-		case MEDIA_BUS_FMT_YVYU8_2X8:
-			return true;
-		default:
-			dev_dbg(csi_dev->dev, "Unsupported mbus code: 0x%x\n",
-				mbus_code);
-			break;
-		}
-		break;
-
-	case V4L2_PIX_FMT_RGB565:
-		return (mbus_code == MEDIA_BUS_FMT_RGB565_2X8_LE);
-	case V4L2_PIX_FMT_RGB565X:
-		return (mbus_code == MEDIA_BUS_FMT_RGB565_2X8_BE);
-
-	case V4L2_PIX_FMT_JPEG:
-		return (mbus_code == MEDIA_BUS_FMT_JPEG_1X8);
-
-	default:
-		dev_dbg(csi_dev->dev, "Unsupported pixformat: 0x%x\n",
-			pixformat);
-		break;
-	}
-
-	return false;
-}
-
 /* Media */
 
 static const struct media_device_ops sun6i_csi_media_ops = {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index fdb36c1311ba..e3f9c49bb829 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -49,13 +49,4 @@ struct sun6i_csi_variant {
 	unsigned long	clock_mod_rate;
 };
 
-/**
- * sun6i_csi_is_format_supported() - check if the format supported by csi
- * @csi:	pointer to the csi
- * @pixformat:	v4l2 pixel format (V4L2_PIX_FMT_*)
- * @mbus_code:	media bus format code (MEDIA_BUS_FMT_*)
- */
-bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
-				   u32 pixformat, u32 mbus_code);
-
 #endif /* __SUN6I_CSI_H__ */
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index aefb506c438d..be52ff679831 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -1136,63 +1136,81 @@ static const struct v4l2_file_operations sun6i_csi_capture_fops = {
 
 /* Media Entity */
 
-static int
-sun6i_csi_capture_link_validate_get_format(struct media_pad *pad,
-					   struct v4l2_subdev_format *fmt)
+static int sun6i_csi_capture_link_validate(struct media_link *link)
 {
-	if (is_media_entity_v4l2_subdev(pad->entity)) {
-		struct v4l2_subdev *sd =
-				media_entity_to_v4l2_subdev(pad->entity);
+	struct video_device *video_dev =
+		media_entity_to_video_device(link->sink->entity);
+	struct sun6i_csi_device *csi_dev = video_get_drvdata(video_dev);
+	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	const struct sun6i_csi_capture_format *capture_format;
+	const struct sun6i_csi_bridge_format *bridge_format;
+	unsigned int capture_width, capture_height;
+	unsigned int bridge_width, bridge_height;
+	const struct v4l2_format_info *format_info;
+	u32 pixelformat, capture_field;
+	u32 mbus_code, bridge_field;
+	bool match;
 
-		fmt->which = V4L2_SUBDEV_FORMAT_ACTIVE;
-		fmt->pad = pad->index;
-		return v4l2_subdev_call(sd, pad, get_fmt, NULL, fmt);
-	}
+	sun6i_csi_capture_dimensions(csi_dev, &capture_width, &capture_height);
 
-	return -EINVAL;
-}
+	sun6i_csi_capture_format(csi_dev, &pixelformat, &capture_field);
+	capture_format = sun6i_csi_capture_format_find(pixelformat);
+	if (WARN_ON(!capture_format))
+		return -EINVAL;
 
-static int sun6i_csi_capture_link_validate(struct media_link *link)
-{
-	struct video_device *vdev = container_of(link->sink->entity,
-						 struct video_device, entity);
-	struct sun6i_csi_device *csi_dev = video_get_drvdata(vdev);
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	struct v4l2_subdev_format source_fmt;
-	int ret;
+	sun6i_csi_bridge_dimensions(csi_dev, &bridge_width, &bridge_height);
 
-	if (!media_entity_remote_pad(link->sink->entity->pads)) {
-		dev_info(csi_dev->dev, "capture node %s pad not connected\n",
-			 vdev->name);
-		return -ENOLINK;
+	sun6i_csi_bridge_format(csi_dev, &mbus_code, &bridge_field);
+	bridge_format = sun6i_csi_bridge_format_find(mbus_code);
+	if (WARN_ON(!bridge_format))
+		return -EINVAL;
+
+	/* No cropping/scaling is supported. */
+	if (capture_width != bridge_width || capture_height != bridge_height) {
+		v4l2_err(v4l2_dev,
+			 "invalid input/output dimensions: %ux%u/%ux%u\n",
+			 bridge_width, bridge_height, capture_width,
+			 capture_height);
+		return -EINVAL;
 	}
 
-	ret = sun6i_csi_capture_link_validate_get_format(link->source,
-							 &source_fmt);
-	if (ret < 0)
-		return ret;
+	format_info = v4l2_format_info(pixelformat);
+	/* Some formats are not listed. */
+	if (!format_info)
+		return 0;
+
+	if (format_info->pixel_enc == V4L2_PIXEL_ENC_BAYER &&
+	    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_RAW)
+		goto invalid;
+
+	if (format_info->pixel_enc == V4L2_PIXEL_ENC_RGB &&
+	    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_RAW)
+		goto invalid;
 
-	if (!sun6i_csi_is_format_supported(csi_dev,
-					   capture->format.fmt.pix.pixelformat,
-					   source_fmt.format.code)) {
-		dev_err(csi_dev->dev,
-			"Unsupported pixformat: 0x%x with mbus code: 0x%x!\n",
-			capture->format.fmt.pix.pixelformat,
-			source_fmt.format.code);
-		return -EPIPE;
+	if (format_info->pixel_enc == V4L2_PIXEL_ENC_YUV) {
+		if (bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV420 &&
+		    bridge_format->input_format != SUN6I_CSI_INPUT_FMT_YUV422)
+			goto invalid;
+
+		/* YUV420 input can't produce YUV422 output. */
+		if (bridge_format->input_format == SUN6I_CSI_INPUT_FMT_YUV420 &&
+		    format_info->vdiv == 1)
+			goto invalid;
 	}
 
-	if (source_fmt.format.width != capture->format.fmt.pix.width ||
-	    source_fmt.format.height != capture->format.fmt.pix.height) {
-		dev_err(csi_dev->dev,
-			"Wrong width or height %ux%u (%ux%u expected)\n",
-			capture->format.fmt.pix.width,
-			capture->format.fmt.pix.height,
-			source_fmt.format.width, source_fmt.format.height);
-		return -EPIPE;
+	/* With raw input mode, we need a 1:1 match between input and output. */
+	if (bridge_format->input_format == SUN6I_CSI_INPUT_FMT_RAW ||
+	    capture_format->input_format_raw) {
+		match = sun6i_csi_capture_format_match(pixelformat, mbus_code);
+		if (!match)
+			goto invalid;
 	}
 
 	return 0;
+
+invalid:
+	v4l2_err(v4l2_dev, "invalid input/output format combination\n");
+	return -EINVAL;
 }
 
 static const struct media_entity_operations sun6i_csi_capture_media_ops = {
-- 
2.36.1

