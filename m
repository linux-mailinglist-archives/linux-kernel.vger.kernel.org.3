Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA0A495BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379532AbiAUISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:18:38 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48760 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379478AbiAUISc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:18:32 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:d916:876:fa52:7241])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 52C281B6E;
        Fri, 21 Jan 2022 09:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642753101;
        bh=7hGGMMbfxPgDUPzKSfeWZ3xPyJsiSVsUFv2mGnktmls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gW8Ifq98myaGp4FDCUb/qbKjZglQpI1+IGfY2YbNn9fj/zEMLDv8ooAglKkkfxMg5
         MzBRvWTBgprBxmYD7LPM4se87UdGa4jlP2npWDRYqEXGOu03jdsmZ9gO57u5V9vXJ9
         GDFyWrTcb9Q5yXaLsG9LYnHXJRiu81sbIOuwU7rQ=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v2 6/7] media: imx219: Add support for multiplexed streams
Date:   Fri, 21 Jan 2022 09:18:09 +0100
Message-Id: <20220121081810.155500-7-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now, imx219 was not supporting anything more than one stream. Add
support for embedded data, based on linux-rpi kernel, and make it work
with multiplexed streams. We have only one source pad with two streams:
stream 0 is the image, and stream 1 is the embedded data.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>

---
in v2: modified the get_format_pad function as it was not correctly
propagating the format in case of sensor flips.
---
 drivers/media/i2c/imx219.c | 452 ++++++++++++++++++++-----------------
 1 file changed, 241 insertions(+), 211 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index e10af3f74b38..d73fe6b8b2fb 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -118,6 +118,16 @@
 #define IMX219_PIXEL_ARRAY_WIDTH	3280U
 #define IMX219_PIXEL_ARRAY_HEIGHT	2464U
 
+/* Embedded metadata stream structure */
+#define IMX219_EMBEDDED_LINE_WIDTH 16384
+#define IMX219_NUM_EMBEDDED_LINES 1
+
+enum pad_types {
+	IMAGE_PAD,
+	METADATA_PAD,
+	NUM_PADS
+};
+
 struct imx219_reg {
 	u16 address;
 	u8 val;
@@ -429,7 +439,7 @@ static const char * const imx219_supply_name[] = {
  * - v flip
  * - h&v flips
  */
-static const u32 codes[] = {
+static const u32 imx219_mbus_formats[] = {
 	MEDIA_BUS_FMT_SRGGB10_1X10,
 	MEDIA_BUS_FMT_SGRBG10_1X10,
 	MEDIA_BUS_FMT_SGBRG10_1X10,
@@ -655,62 +665,17 @@ static u32 imx219_get_format_code(struct imx219 *imx219, u32 code)
 
 	lockdep_assert_held(&imx219->mutex);
 
-	for (i = 0; i < ARRAY_SIZE(codes); i++)
-		if (codes[i] == code)
+	for (i = 0; i < ARRAY_SIZE(imx219_mbus_formats); i++)
+		if (imx219_mbus_formats[i] == code)
 			break;
 
-	if (i >= ARRAY_SIZE(codes))
+	if (i >= ARRAY_SIZE(imx219_mbus_formats))
 		i = 0;
 
 	i = (i & ~3) | (imx219->vflip->val ? 2 : 0) |
 	    (imx219->hflip->val ? 1 : 0);
 
-	return codes[i];
-}
-
-static void imx219_set_default_format(struct imx219 *imx219)
-{
-	struct v4l2_mbus_framefmt *fmt;
-
-	fmt = &imx219->fmt;
-	fmt->code = MEDIA_BUS_FMT_SRGGB10_1X10;
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
-	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
-	fmt->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
-							  fmt->colorspace,
-							  fmt->ycbcr_enc);
-	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
-	fmt->width = supported_modes[0].width;
-	fmt->height = supported_modes[0].height;
-	fmt->field = V4L2_FIELD_NONE;
-}
-
-static int imx219_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
-{
-	struct imx219 *imx219 = to_imx219(sd);
-	struct v4l2_mbus_framefmt *try_fmt =
-		v4l2_subdev_get_try_format(sd, fh->state, 0);
-	struct v4l2_rect *try_crop;
-
-	mutex_lock(&imx219->mutex);
-
-	/* Initialize try_fmt */
-	try_fmt->width = supported_modes[0].width;
-	try_fmt->height = supported_modes[0].height;
-	try_fmt->code = imx219_get_format_code(imx219,
-					       MEDIA_BUS_FMT_SRGGB10_1X10);
-	try_fmt->field = V4L2_FIELD_NONE;
-
-	/* Initialize try_crop rectangle. */
-	try_crop = v4l2_subdev_get_try_crop(sd, fh->state, 0);
-	try_crop->top = IMX219_PIXEL_ARRAY_TOP;
-	try_crop->left = IMX219_PIXEL_ARRAY_LEFT;
-	try_crop->width = IMX219_PIXEL_ARRAY_WIDTH;
-	try_crop->height = IMX219_PIXEL_ARRAY_HEIGHT;
-
-	mutex_unlock(&imx219->mutex);
-
-	return 0;
+	return imx219_mbus_formats[i];
 }
 
 static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
@@ -802,98 +767,148 @@ static const struct v4l2_ctrl_ops imx219_ctrl_ops = {
 	.s_ctrl = imx219_set_ctrl,
 };
 
-static int imx219_enum_mbus_code(struct v4l2_subdev *sd,
-				 struct v4l2_subdev_state *sd_state,
-				 struct v4l2_subdev_mbus_code_enum *code)
+static void imx219_init_formats(struct v4l2_subdev_state *state)
 {
-	struct imx219 *imx219 = to_imx219(sd);
+	struct v4l2_mbus_framefmt *format;
+
+	format = v4l2_state_get_stream_format(state, 0, 0);
+	format->code = imx219_mbus_formats[0];
+	format->width = supported_modes[0].width;
+	format->height = supported_modes[0].height;
+	format->field = V4L2_FIELD_NONE;
+	format->colorspace = V4L2_COLORSPACE_RAW;
+
+	if (state->routing.routes[1].flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE) {
+		format = v4l2_state_get_stream_format(state, 0, 1);
+		format->code = MEDIA_BUS_FMT_METADATA_8;
+		format->width = IMX219_EMBEDDED_LINE_WIDTH;
+		format->height = 1;
+		format->field = V4L2_FIELD_NONE;
+		format->colorspace = V4L2_COLORSPACE_DEFAULT;
+	}
+}
 
-	if (code->index >= (ARRAY_SIZE(codes) / 4))
-		return -EINVAL;
+static int _imx219_set_routing(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *state)
+{
+	struct v4l2_subdev_route routes[] = {
+		{
+			.source_pad = 0,
+			.source_stream = 0,
+			.flags = V4L2_SUBDEV_ROUTE_FL_IMMUTABLE |
+				 V4L2_SUBDEV_ROUTE_FL_SOURCE |
+				 V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+		},
+		{
+			.source_pad = 0,
+			.source_stream = 1,
+			.flags = V4L2_SUBDEV_ROUTE_FL_SOURCE |
+				 V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+		}
+	};
 
-	mutex_lock(&imx219->mutex);
-	code->code = imx219_get_format_code(imx219, codes[code->index * 4]);
-	mutex_unlock(&imx219->mutex);
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = ARRAY_SIZE(routes),
+		.routes = routes,
+	};
+
+	int ret;
+
+	ret = v4l2_subdev_set_routing(sd, state, &routing);
+	if (ret)
+		return ret;
+
+	imx219_init_formats(state);
 
 	return 0;
 }
 
-static int imx219_enum_frame_size(struct v4l2_subdev *sd,
-				  struct v4l2_subdev_state *sd_state,
-				  struct v4l2_subdev_frame_size_enum *fse)
+static int imx219_set_routing(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *state,
+			      enum v4l2_subdev_format_whence which,
+			      struct v4l2_subdev_krouting *routing)
 {
-	struct imx219 *imx219 = to_imx219(sd);
-	u32 code;
+	int ret;
 
-	if (fse->index >= ARRAY_SIZE(supported_modes))
+	if (routing->num_routes == 0 || routing->num_routes > 2)
 		return -EINVAL;
 
-	mutex_lock(&imx219->mutex);
-	code = imx219_get_format_code(imx219, fse->code);
-	mutex_unlock(&imx219->mutex);
-	if (fse->code != code)
-		return -EINVAL;
+	v4l2_subdev_lock_state(state);
 
-	fse->min_width = supported_modes[fse->index].width;
-	fse->max_width = fse->min_width;
-	fse->min_height = supported_modes[fse->index].height;
-	fse->max_height = fse->min_height;
+	ret = _imx219_set_routing(sd, state);
 
-	return 0;
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
 }
 
-static void imx219_reset_colorspace(struct v4l2_mbus_framefmt *fmt)
+static int imx219_init_cfg(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_state *state)
 {
-	fmt->colorspace = V4L2_COLORSPACE_SRGB;
-	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
-	fmt->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
-							  fmt->colorspace,
-							  fmt->ycbcr_enc);
-	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
+	int ret;
+
+	v4l2_subdev_lock_state(state);
+
+	ret = _imx219_set_routing(sd, state);
+
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
 }
 
-static void imx219_update_pad_format(struct imx219 *imx219,
-				     const struct imx219_mode *mode,
-				     struct v4l2_subdev_format *fmt)
+static int imx219_enum_mbus_code(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *sd_state,
+				 struct v4l2_subdev_mbus_code_enum *code)
 {
-	fmt->format.width = mode->width;
-	fmt->format.height = mode->height;
-	fmt->format.field = V4L2_FIELD_NONE;
-	imx219_reset_colorspace(&fmt->format);
+	if (code->index >= ARRAY_SIZE(imx219_mbus_formats))
+		return -EINVAL;
+
+	code->code = imx219_mbus_formats[code->index];
+
+	return 0;
 }
 
-static int __imx219_get_pad_format(struct imx219 *imx219,
-				   struct v4l2_subdev_state *sd_state,
-				   struct v4l2_subdev_format *fmt)
+static int imx219_enum_frame_size(struct v4l2_subdev *sd,
+				  struct v4l2_subdev_state *sd_state,
+				  struct v4l2_subdev_frame_size_enum *fse)
 {
-	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
-		struct v4l2_mbus_framefmt *try_fmt =
-			v4l2_subdev_get_try_format(&imx219->sd, sd_state,
-						   fmt->pad);
-		/* update the code which could change due to vflip or hflip: */
-		try_fmt->code = imx219_get_format_code(imx219, try_fmt->code);
-		fmt->format = *try_fmt;
+	unsigned int i;
+
+	if (fse->stream == 0) {
+		for (i = 0; i < ARRAY_SIZE(imx219_mbus_formats); ++i) {
+			if (imx219_mbus_formats[i] == fse->code)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(imx219_mbus_formats))
+			return -EINVAL;
+
+		if (fse->index >= ARRAY_SIZE(supported_modes))
+			return -EINVAL;
+
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
@@ -901,82 +916,91 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_format *fmt)
 {
 	struct imx219 *imx219 = to_imx219(sd);
+	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
 	const struct imx219_mode *mode;
-	struct v4l2_mbus_framefmt *framefmt;
-	int exposure_max, exposure_def, hblank;
+	struct v4l2_mbus_framefmt *format;
 	unsigned int i;
+	int ret = 0;
+	int exposure_max, exposure_def, hblank;
 
-	mutex_lock(&imx219->mutex);
+	if (fmt->pad != 0) {
+		dev_err(&client->dev, "%s Could not get pad %d\n", __func__,
+			fmt->pad);
+		return -EINVAL;
+	}
 
-	for (i = 0; i < ARRAY_SIZE(codes); i++)
-		if (codes[i] == fmt->format.code)
+	if (fmt->stream == 1) {
+		/* Only one embedded data mode is supported */
+		imx219_update_metadata_pad_format(fmt);
+		return 0;
+	}
+
+	if (fmt->stream != 0)
+		return -EINVAL;
+
+	/*
+	 * Validate the media bus code, defaulting to the first one if the
+	 * requested code isn't supported.
+	 */
+	for (i = 0; i < ARRAY_SIZE(imx219_mbus_formats); ++i) {
+		if (imx219_mbus_formats[i] == fmt->format.code)
 			break;
-	if (i >= ARRAY_SIZE(codes))
-		i = 0;
+	}
 
-	/* Bayer order varies with flips */
-	fmt->format.code = imx219_get_format_code(imx219, codes[i]);
+	if (i >= ARRAY_SIZE(imx219_mbus_formats))
+		i = 0;
 
 	mode = v4l2_find_nearest_size(supported_modes,
 				      ARRAY_SIZE(supported_modes),
 				      width, height,
-				      fmt->format.width, fmt->format.height);
-	imx219_update_pad_format(imx219, mode, fmt);
-	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
-		framefmt = v4l2_subdev_get_try_format(sd, sd_state, fmt->pad);
-		*framefmt = fmt->format;
-	} else if (imx219->mode != mode ||
-		   imx219->fmt.code != fmt->format.code) {
-		imx219->fmt = fmt->format;
-		imx219->mode = mode;
-		/* Update limits and set FPS to default */
-		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
-					 IMX219_VTS_MAX - mode->height, 1,
-					 mode->vts_def - mode->height);
-		__v4l2_ctrl_s_ctrl(imx219->vblank,
-				   mode->vts_def - mode->height);
-		/* Update max exposure while meeting expected vblanking */
-		exposure_max = mode->vts_def - 4;
-		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
-			exposure_max : IMX219_EXPOSURE_DEFAULT;
-		__v4l2_ctrl_modify_range(imx219->exposure,
-					 imx219->exposure->minimum,
-					 exposure_max, imx219->exposure->step,
-					 exposure_def);
-		/*
-		 * Currently PPL is fixed to IMX219_PPL_DEFAULT, so hblank
-		 * depends on mode->width only, and is not changeble in any
-		 * way other than changing the mode.
-		 */
-		hblank = IMX219_PPL_DEFAULT - mode->width;
-		__v4l2_ctrl_modify_range(imx219->hblank, hblank, hblank, 1,
-					 hblank);
-	}
+				      fmt->format.width,
+				      fmt->format.height);
 
-	mutex_unlock(&imx219->mutex);
+	v4l2_subdev_lock_state(sd_state);
 
-	return 0;
-}
+	/* Update the stored format and return it. */
+	format = v4l2_state_get_stream_format(sd_state, fmt->pad, fmt->stream);
 
-static int imx219_set_framefmt(struct imx219 *imx219)
-{
-	switch (imx219->fmt.code) {
-	case MEDIA_BUS_FMT_SRGGB8_1X8:
-	case MEDIA_BUS_FMT_SGRBG8_1X8:
-	case MEDIA_BUS_FMT_SGBRG8_1X8:
-	case MEDIA_BUS_FMT_SBGGR8_1X8:
-		return imx219_write_regs(imx219, raw8_framefmt_regs,
-					ARRAY_SIZE(raw8_framefmt_regs));
-
-	case MEDIA_BUS_FMT_SRGGB10_1X10:
-	case MEDIA_BUS_FMT_SGRBG10_1X10:
-	case MEDIA_BUS_FMT_SGBRG10_1X10:
-	case MEDIA_BUS_FMT_SBGGR10_1X10:
-		return imx219_write_regs(imx219, raw10_framefmt_regs,
-					ARRAY_SIZE(raw10_framefmt_regs));
+	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE && imx219->streaming) {
+		ret = -EBUSY;
+		goto done;
 	}
 
-	return -EINVAL;
+	/* Bayer order varies with flips */
+	fmt->format.code = imx219_get_format_code(imx219, imx219_mbus_formats[i]);
+	fmt->format = *format;
+
+	/* Update limits and set FPS to default */
+	__v4l2_ctrl_modify_range(imx219->vblank,
+				 IMX219_VBLANK_MIN,
+				 IMX219_VTS_MAX - mode->height,
+				 1,
+				 mode->vts_def - mode->height);
+	__v4l2_ctrl_s_ctrl(imx219->vblank, mode->vts_def - mode->height);
+	/*
+	 * Update max exposure while meeting
+	 * expected vblanking
+	 */
+	exposure_max = mode->vts_def - 4;
+	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
+			exposure_max : IMX219_EXPOSURE_DEFAULT;
+	__v4l2_ctrl_modify_range(imx219->exposure,
+				 imx219->exposure->minimum,
+				 exposure_max,
+				 imx219->exposure->step,
+				 exposure_def);
+	/*
+	 * Currently PPL is fixed to IMX219_PPL_DEFAULT, so
+	 * hblank depends on mode->width only, and is not
+	 * changeble in any way other than changing the mode.
+	 */
+	hblank = IMX219_PPL_DEFAULT - mode->width;
+	__v4l2_ctrl_modify_range(imx219->hblank, hblank, hblank, 1, hblank);
+
+done:
+	v4l2_subdev_unlock_state(sd_state);
+
+	return ret;
 }
 
 static const struct v4l2_rect *
@@ -1037,9 +1061,11 @@ static int imx219_start_streaming(struct imx219 *imx219)
 	const struct imx219_reg_list *reg_list;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&client->dev);
-	if (ret < 0)
+	ret = pm_runtime_get_sync(&client->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&client->dev);
 		return ret;
+	}
 
 	/* Apply default values of current mode */
 	reg_list = &imx219->mode->reg_list;
@@ -1049,13 +1075,6 @@ static int imx219_start_streaming(struct imx219 *imx219)
 		goto err_rpm_put;
 	}
 
-	ret = imx219_set_framefmt(imx219);
-	if (ret) {
-		dev_err(&client->dev, "%s failed to set frame format: %d\n",
-			__func__, ret);
-		goto err_rpm_put;
-	}
-
 	/* Apply customized values from user */
 	ret =  __v4l2_ctrl_handler_setup(imx219->sd.ctrl_handler);
 	if (ret)
@@ -1133,21 +1152,22 @@ static int imx219_set_stream(struct v4l2_subdev *sd, int enable)
 /* Power/clock management functions */
 static int imx219_power_on(struct device *dev)
 {
-	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct imx219 *imx219 = to_imx219(sd);
 	int ret;
 
 	ret = regulator_bulk_enable(IMX219_NUM_SUPPLIES,
 				    imx219->supplies);
 	if (ret) {
-		dev_err(dev, "%s: failed to enable regulators\n",
+		dev_err(&client->dev, "%s: failed to enable regulators\n",
 			__func__);
 		return ret;
 	}
 
 	ret = clk_prepare_enable(imx219->xclk);
 	if (ret) {
-		dev_err(dev, "%s: failed to enable clock\n",
+		dev_err(&client->dev, "%s: failed to enable clock\n",
 			__func__);
 		goto reg_off;
 	}
@@ -1166,7 +1186,8 @@ static int imx219_power_on(struct device *dev)
 
 static int imx219_power_off(struct device *dev)
 {
-	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct imx219 *imx219 = to_imx219(sd);
 
 	gpiod_set_value_cansleep(imx219->reset_gpio, 0);
@@ -1178,7 +1199,8 @@ static int imx219_power_off(struct device *dev)
 
 static int __maybe_unused imx219_suspend(struct device *dev)
 {
-	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct imx219 *imx219 = to_imx219(sd);
 
 	if (imx219->streaming)
@@ -1189,7 +1211,8 @@ static int __maybe_unused imx219_suspend(struct device *dev)
 
 static int __maybe_unused imx219_resume(struct device *dev)
 {
-	struct v4l2_subdev *sd = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct imx219 *imx219 = to_imx219(sd);
 	int ret;
 
@@ -1255,11 +1278,13 @@ static const struct v4l2_subdev_video_ops imx219_video_ops = {
 };
 
 static const struct v4l2_subdev_pad_ops imx219_pad_ops = {
-	.enum_mbus_code = imx219_enum_mbus_code,
-	.get_fmt = imx219_get_pad_format,
-	.set_fmt = imx219_set_pad_format,
-	.get_selection = imx219_get_selection,
-	.enum_frame_size = imx219_enum_frame_size,
+	.init_cfg		= imx219_init_cfg,
+	.enum_mbus_code		= imx219_enum_mbus_code,
+	.get_fmt		= v4l2_subdev_get_fmt,
+	.set_fmt		= imx219_set_pad_format,
+	.get_selection		= imx219_get_selection,
+	.set_routing		= imx219_set_routing,
+	.enum_frame_size	= imx219_enum_frame_size,
 };
 
 static const struct v4l2_subdev_ops imx219_subdev_ops = {
@@ -1268,10 +1293,6 @@ static const struct v4l2_subdev_ops imx219_subdev_ops = {
 	.pad = &imx219_pad_ops,
 };
 
-static const struct v4l2_subdev_internal_ops imx219_internal_ops = {
-	.open = imx219_open,
-};
-
 /* Initialize control handlers */
 static int imx219_init_controls(struct imx219 *imx219)
 {
@@ -1446,6 +1467,7 @@ static int imx219_check_hwcfg(struct device *dev)
 static int imx219_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct v4l2_subdev *sd;
 	struct imx219 *imx219;
 	int ret;
 
@@ -1453,7 +1475,8 @@ static int imx219_probe(struct i2c_client *client)
 	if (!imx219)
 		return -ENOMEM;
 
-	v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
+	sd = &imx219->sd;
+	v4l2_i2c_subdev_init(sd, client, &imx219_subdev_ops);
 
 	/* Check the hardware configuration in device tree */
 	if (imx219_check_hwcfg(dev))
@@ -1520,27 +1543,29 @@ static int imx219_probe(struct i2c_client *client)
 		goto error_power_off;
 
 	/* Initialize subdev */
-	imx219->sd.internal_ops = &imx219_internal_ops;
-	imx219->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
-			    V4L2_SUBDEV_FL_HAS_EVENTS;
-	imx219->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
+		     V4L2_SUBDEV_FL_HAS_EVENTS |
+		     V4L2_SUBDEV_FL_MULTIPLEXED;
 
-	/* Initialize source pad */
+	/* Initialize the media entity. */
 	imx219->pad.flags = MEDIA_PAD_FL_SOURCE;
-
-	/* Initialize default format */
-	imx219_set_default_format(imx219);
-
-	ret = media_entity_pads_init(&imx219->sd.entity, 1, &imx219->pad);
+	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	ret = media_entity_pads_init(&sd->entity, 1, &imx219->pad);
 	if (ret) {
 		dev_err(dev, "failed to init entity pads: %d\n", ret);
 		goto error_handler_free;
 	}
 
-	ret = v4l2_async_register_subdev_sensor(&imx219->sd);
+	ret = v4l2_subdev_init_finalize(sd);
+	if (ret) {
+		dev_err(dev, "failed to finalize sensor init: %d\n", ret);
+		goto error_media_entity;
+	}
+
+	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret < 0) {
 		dev_err(dev, "failed to register sensor sub-device: %d\n", ret);
-		goto error_media_entity;
+		goto error_free_state;
 	}
 
 	/* Enable runtime PM and turn off the device */
@@ -1550,6 +1575,8 @@ static int imx219_probe(struct i2c_client *client)
 
 	return 0;
 
+error_free_state:
+	v4l2_subdev_cleanup(sd);
 error_media_entity:
 	media_entity_cleanup(&imx219->sd.entity);
 
@@ -1568,6 +1595,9 @@ static int imx219_remove(struct i2c_client *client)
 	struct imx219 *imx219 = to_imx219(sd);
 
 	v4l2_async_unregister_subdev(sd);
+
+	v4l2_subdev_cleanup(sd);
+
 	media_entity_cleanup(&sd->entity);
 	imx219_free_controls(imx219);
 
-- 
2.32.0

