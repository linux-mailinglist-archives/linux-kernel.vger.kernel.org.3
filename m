Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3F74A7751
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiBBR5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:57:55 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:58272 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbiBBR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:57:27 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:7139:eada:2ff6:73dd])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F1A601849;
        Wed,  2 Feb 2022 18:56:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643824613;
        bh=5CetPsMNqlbOx/W3JD3+AaeH0cV+k4nWAztBn5qAQck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crsG/hiSB0jo42beYxyj4/suHBv+NVJa0eejMFd7+2OwZgJd6ek07n+7yRsPAPCw2
         Dg0ytG7p8XP6XnnuoHHAq4rQNUvPu+VAlFweZfzY1r4ZydOs9ABnec+3++rt962Fgg
         zZCvnFRnVK6cZZuf41FUodKAnGBuI85ur/UzqLvE=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v3 10/11] media: imx219: Add support for the V4L2 subdev active state
Date:   Wed,  2 Feb 2022 18:56:38 +0100
Message-Id: <20220202175639.149681-11-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have multiplexed streams support in the V4L2 API, add
support for the subdev active state in the sensor.

In order to use state to manage the active configuration, we need to
initialize the subdevice state with a call to
v4l2_subdev_init_finalize() before registering it. The call to
v4l2_subdev_cleanup() is also required to release the resources before
unregistering.

Accessing the configuration is then done after a call to
v4l2_subdev_lock_state() and the set_fmt operation can then call
v4l2_state_get_stream_format() directly.

The get_fmt operation does not need to be complex, and a simple call to
v4l2_subdev_get_fmt will do the trick, as it will grab the configured
format based on the state.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 drivers/media/i2c/imx219.c | 151 +++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 74 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 7c224d007f3e..88212f86ce9b 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -870,78 +870,43 @@ static int imx219_enum_frame_size(struct v4l2_subdev *sd,
 				  struct v4l2_subdev_state *sd_state,
 				  struct v4l2_subdev_frame_size_enum *fse)
 {
-	struct imx219 *imx219 = to_imx219(sd);
-	u32 code;
-
-	if (fse->index >= ARRAY_SIZE(supported_modes))
-		return -EINVAL;
-
-	mutex_lock(&imx219->mutex);
-	code = imx219_get_format_code(imx219, fse->code);
-	mutex_unlock(&imx219->mutex);
-	if (fse->code != code)
-		return -EINVAL;
+	unsigned int i;
 
-	fse->min_width = supported_modes[fse->index].width;
-	fse->max_width = fse->min_width;
-	fse->min_height = supported_modes[fse->index].height;
-	fse->max_height = fse->min_height;
+	if (fse->stream == 0) {
+		for (i = 0; i < ARRAY_SIZE(imx219_mbus_formats); ++i) {
+			if (imx219_mbus_formats[i] == fse->code)
+				break;
+		}
 
-	return 0;
-}
+		if (i == ARRAY_SIZE(imx219_mbus_formats))
+			return -EINVAL;
 
-static void imx219_reset_colorspace(struct v4l2_mbus_framefmt *fmt)
-{
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
-	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
-	fmt->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
-							  fmt->colorspace,
-							  fmt->ycbcr_enc);
-	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
-}
+		if (fse->index >= ARRAY_SIZE(supported_modes))
+			return -EINVAL;
 
-static void imx219_update_pad_format(struct imx219 *imx219,
-				     const struct imx219_mode *mode,
-				     struct v4l2_subdev_format *fmt)
-{
-	fmt->format.width = mode->width;
-	fmt->format.height = mode->height;
-	fmt->format.field = V4L2_FIELD_NONE;
-	imx219_reset_colorspace(&fmt->format);
-}
-
-static int __imx219_get_pad_format(struct imx219 *imx219,
-				   struct v4l2_subdev_state *sd_state,
-				   struct v4l2_subdev_format *fmt)
-{
-	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
-		struct v4l2_mbus_framefmt *try_fmt =
-			v4l2_subdev_get_try_format(&imx219->sd, sd_state,
-						   fmt->pad);
-		/* update the code which could change due to vflip or hflip: */
-		try_fmt->code = imx219_get_format_code(imx219, try_fmt->code);
-		fmt->format = *try_fmt;
+		fse->min_width  = supported_modes[fse->index].width;
+		fse->max_width  = fse->min_width;
+		fse->max_height = supported_modes[fse->index].height;
+		fse->min_height = fse->max_height;
 	} else {
-		imx219_update_pad_format(imx219, imx219->mode, fmt);
-		fmt->format.code = imx219_get_format_code(imx219,
-							  imx219->fmt.code);
+		if (fse->code != MEDIA_BUS_FMT_METADATA_8)
+			return -EINVAL;
+
+		fse->min_width = IMX219_EMBEDDED_LINE_WIDTH;
+		fse->max_width = fse->min_width;
+		fse->min_height = IMX219_NUM_EMBEDDED_LINES;
+		fse->max_height = fse->min_height;
 	}
 
 	return 0;
 }
 
-static int imx219_get_pad_format(struct v4l2_subdev *sd,
-				 struct v4l2_subdev_state *sd_state,
-				 struct v4l2_subdev_format *fmt)
+static void imx219_update_metadata_pad_format(struct v4l2_subdev_format *fmt)
 {
-	struct imx219 *imx219 = to_imx219(sd);
-	int ret;
-
-	mutex_lock(&imx219->mutex);
-	ret = __imx219_get_pad_format(imx219, sd_state, fmt);
-	mutex_unlock(&imx219->mutex);
-
-	return ret;
+	fmt->format.width = IMX219_EMBEDDED_LINE_WIDTH;
+	fmt->format.height = IMX219_NUM_EMBEDDED_LINES;
+	fmt->format.code = MEDIA_BUS_FMT_METADATA_8;
+	fmt->format.field = V4L2_FIELD_NONE;
 }
 
 static int imx219_set_pad_format(struct v4l2_subdev *sd,
@@ -949,32 +914,58 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_format *fmt)
 {
 	struct imx219 *imx219 = to_imx219(sd);
+	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
 	const struct imx219_mode *mode;
-	struct v4l2_mbus_framefmt *framefmt;
+	struct v4l2_mbus_framefmt *format;
 	int exposure_max, exposure_def, hblank;
 	unsigned int i;
+	int ret = 0;
 
 	mutex_lock(&imx219->mutex);
 
+	if (fmt->pad != 0) {
+		dev_err(&client->dev, "%s Could not get pad %d\n", __func__,
+			fmt->pad);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	if (fmt->stream == 1) {
+		/* Only one embedded data mode is supported */
+		imx219_update_metadata_pad_format(fmt);
+		ret = 0;
+		goto done;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(imx219_mbus_formats); i++)
 		if (imx219_mbus_formats[i] == fmt->format.code)
 			break;
 	if (i >= ARRAY_SIZE(imx219_mbus_formats))
 		i = 0;
 
-	/* Bayer order varies with flips */
-	fmt->format.code = imx219_get_format_code(imx219, imx219_mbus_formats[i]);
-
 	mode = v4l2_find_nearest_size(supported_modes,
 				      ARRAY_SIZE(supported_modes),
 				      width, height,
 				      fmt->format.width, fmt->format.height);
-	imx219_update_pad_format(imx219, mode, fmt);
-	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
-		framefmt = v4l2_subdev_get_try_format(sd, sd_state, fmt->pad);
-		*framefmt = fmt->format;
-	} else if (imx219->mode != mode ||
-		   imx219->fmt.code != fmt->format.code) {
+
+	v4l2_subdev_lock_state(sd_state);
+
+	/* Update the stored format and return it. */
+	format = v4l2_state_get_stream_format(sd_state, fmt->pad, fmt->stream);
+
+	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE && imx219->streaming) {
+		ret = -EBUSY;
+		goto err_state;
+	}
+
+	/* Bayer order varies with flips */
+	format->code = imx219_get_format_code(imx219, imx219_mbus_formats[i]);
+	format->width = mode->width;
+	format->height = mode->height;
+	/* Bayer order varies with flips */
+	fmt->format = *format;
+
+	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
 		imx219->fmt = fmt->format;
 		imx219->mode = mode;
 		/* Update limits and set FPS to default */
@@ -1001,9 +992,12 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 					 hblank);
 	}
 
+err_state:
+	v4l2_subdev_unlock_state(sd_state);
+done:
 	mutex_unlock(&imx219->mutex);
 
-	return 0;
+	return ret;
 }
 
 static int imx219_set_framefmt(struct imx219 *imx219)
@@ -1305,7 +1299,7 @@ static const struct v4l2_subdev_video_ops imx219_video_ops = {
 static const struct v4l2_subdev_pad_ops imx219_pad_ops = {
 	.init_cfg		= imx219_init_cfg,
 	.enum_mbus_code		= imx219_enum_mbus_code,
-	.get_fmt		= imx219_get_pad_format,
+	.get_fmt		= v4l2_subdev_get_fmt,
 	.set_fmt		= imx219_set_pad_format,
 	.get_selection		= imx219_get_selection,
 	.set_routing		= imx219_set_routing,
@@ -1582,10 +1576,16 @@ static int imx219_probe(struct i2c_client *client)
 		goto error_handler_free;
 	}
 
+	ret = v4l2_subdev_init_finalize(sd);
+	if (ret) {
+		dev_err(dev, "failed to finalize sensor init: %d\n", ret);
+		goto error_media_entity;
+	}
+
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret < 0) {
 		dev_err(dev, "failed to register sensor sub-device: %d\n", ret);
-		goto error_media_entity;
+		goto error_free_state;
 	}
 
 	/* Enable runtime PM and turn off the device */
@@ -1595,6 +1595,8 @@ static int imx219_probe(struct i2c_client *client)
 
 	return 0;
 
+error_free_state:
+	v4l2_subdev_cleanup(sd);
 error_media_entity:
 	media_entity_cleanup(&sd->entity);
 
@@ -1613,6 +1615,7 @@ static int imx219_remove(struct i2c_client *client)
 	struct imx219 *imx219 = to_imx219(sd);
 
 	v4l2_async_unregister_subdev(sd);
+	v4l2_subdev_cleanup(sd);
 	media_entity_cleanup(&sd->entity);
 	imx219_free_controls(imx219);
 
-- 
2.32.0

