Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2970495F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380636AbiAUNQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:16:41 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:6424 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350614AbiAUNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642771000; x=1674307000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O1obUL8aufDYFn3rPESxcsnEKfvz/zshCbIKr8/MH98=;
  b=THgDdY0sGItgU5HlIyBvxOmYOJuj1naR/0p0EPyfmQyN8Gp/mBnbRVuB
   BjOFoJ2qUIUz0CzgtUCDnZwsrMVWHfiYLfAC872daSkhkUnZIFhflLiSS
   WdiyN9/i5NhGV/h3xnQK31sTpeuNgP4K23k/Qk5i6yWdufXyQcFwujxsY
   XL3TTtrIWl9cCHPbd4kRCGOCM7jl4RPe7qER4QGfYOK4kFnrE52V8Kvuv
   nIMum6Q+B5b/c581xS8u6fRvuxf1JpMpyUPVurEQSlNlRANJBp6ZPjV6J
   V91hDOEzFSgd9cs8Dn1V3iiY3UNYJ5RvBM8TqNg8swJeifoDysJpDxktK
   w==;
IronPort-SDR: KyqqXMaiyH8Ps9WVFJYXffwrn8GmMLTPXqqYKCNMqnNTtSOYwirGFp1PawgeykkssK/pvzBMV2
 trsn37sx34zuXyKOBRbz09FqigrF9lsdicIi57k6ZrAIUWR/bncb7hGbxU4sRnr63P7XrfX12x
 J3zLUj0BJ8U//kctDPs3kRYxyh6nP966qlVNvz6Pi47EdcPa5VMX0KbLWYLcbF4hwaPIV/W/GH
 T9sy9zKTnvUEkkrW4YmuBD4yQPuR9fXDM/GzbXa3KH4BNkNxZcDmDieHzmPSgDGIdBI6ccjc93
 VSe7JutmsxIJNQc1eh+EEW1U
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="83256376"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:16:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:16:39 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:16:24 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 07/11] media: atmel: atmel-isc: change format propagation to subdev into only verification
Date:   Fri, 21 Jan 2022 15:14:12 +0200
Message-ID: <20220121131416.603972-8-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121131416.603972-1-eugen.hristev@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a top MC video driver, the atmel-isc should not propagate the format to the
subdevice.
It should rather check at start_streaming() time if the subdev is properly
configured with a compatible format.
Removed the whole format finding logic, and reworked the format verification
at start_streaming time, such that the ISC will return an error if the subdevice
is not properly configured. To achieve this, media_pipeline_start
is called and a link_validate callback is created to check the formats.
With this being done, the module parameter 'sensor_preferred' makes no sense
anymore. The ISC should not decide which format the sensor is using. The
ISC should only cope with the situation and inform userspace if the streaming
is possible in the current configuration.
The redesign of the format propagation has also risen the question of the
enumfmt callback. If enumfmt is called with an mbus_code, the enumfmt handler
should only return the formats that are supported for this mbus_code.
To make it more easy to understand the formats, changed the report order
to report first the native formats, and after that the formats that the ISC
can convert to.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v4:
- moved validation code into link_validate and used media_pipeline_start
- merged this patch with the enum_fmt patch which was previously in v3 of
the series

Changes in v3:
- clamp to maximum resolution once the frame size from the subdev is found

 drivers/media/platform/atmel/atmel-isc-base.c | 335 ++++++++++--------
 .../media/platform/atmel/atmel-isc-scaler.c   |   5 +
 drivers/media/platform/atmel/atmel-isc.h      |   3 +
 3 files changed, 191 insertions(+), 152 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index f7a88399bd54..31c79313aadc 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -36,11 +36,6 @@ static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "debug level (0-2)");
 
-static unsigned int sensor_preferred = 1;
-module_param(sensor_preferred, uint, 0644);
-MODULE_PARM_DESC(sensor_preferred,
-		 "Sensor is preferred to output the specified format (1-on 0-off), default 1");
-
 #define ISC_IS_FORMAT_RAW(mbus_code) \
 	(((mbus_code) & 0xf000) == 0x3000)
 
@@ -337,6 +332,10 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	unsigned long flags;
 	int ret;
 
+	ret = media_pipeline_start(&isc->video_dev.entity, &isc->mpipe);
+	if (ret)
+		goto err_pipeline_start;
+
 	/* Enable stream on the sub device */
 	ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD) {
@@ -384,6 +383,9 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
 
 err_start_stream:
+	media_pipeline_stop(&isc->video_dev.entity);
+
+err_pipeline_start:
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	list_for_each_entry(buf, &isc->dma_queue, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
@@ -420,6 +422,9 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	if (ret && ret != -ENOIOCTLCMD)
 		v4l2_err(&isc->v4l2_dev, "stream off failed in subdev\n");
 
+	/* Stop media pipeline */
+	media_pipeline_stop(&isc->video_dev.entity);
+
 	/* Release all active buffers */
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	if (unlikely(isc->cur_frm)) {
@@ -496,21 +501,56 @@ static int isc_enum_fmt_vid_cap(struct file *file, void *priv,
 	u32 index = f->index;
 	u32 i, supported_index;
 
-	if (index < isc->controller_formats_size) {
-		f->pixelformat = isc->controller_formats[index].fourcc;
-		return 0;
+	supported_index = 0;
+
+	for (i = 0; i < isc->formats_list_size; i++) {
+		if (!isc->formats_list[i].sd_support)
+			continue;
+		/*
+		 * If specific mbus_code is requested, provide only
+		 * supported formats with this mbus code
+		 */
+		if (f->mbus_code && f->mbus_code !=
+		    isc->formats_list[i].mbus_code)
+			continue;
+		if (supported_index == index) {
+			f->pixelformat = isc->formats_list[i].fourcc;
+			return 0;
+		}
+		supported_index++;
 	}
 
-	index -= isc->controller_formats_size;
+	/*
+	 * If the sensor does not support this mbus_code whatsoever,
+	 * there is no reason to advertise any of our output formats
+	 */
+	if (supported_index == 0)
+		return -EINVAL;
 
+	/*
+	 * If the sensor uses a format that is not raw, then we cannot
+	 * convert it to any of the formats that we usually can with a
+	 * RAW sensor. Thus, do not advertise them.
+	 */
+	if (isc->config.sd_format &&
+	    !ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code))
+		return -EINVAL;
+
+	/*
+	 * Iterate again through the formats that we can convert to.
+	 * However, to avoid duplicates, skip the formats that
+	 * the sensor already supports directly
+	 */
+	index -= supported_index;
 	supported_index = 0;
 
-	for (i = 0; i < isc->formats_list_size; i++) {
-		if (!ISC_IS_FORMAT_RAW(isc->formats_list[i].mbus_code) ||
-		    !isc->formats_list[i].sd_support)
+	for (i = 0; i < isc->controller_formats_size; i++) {
+		/* if this format is already supported by sensor, skip it */
+		if (find_format_by_fourcc(isc, isc->controller_formats[i].fourcc))
 			continue;
 		if (supported_index == index) {
-			f->pixelformat = isc->formats_list[i].fourcc;
+			f->pixelformat =
+				isc->controller_formats[i].fourcc;
 			return 0;
 		}
 		supported_index++;
@@ -581,20 +621,30 @@ static int isc_try_validate_formats(struct isc_device *isc)
 		break;
 	default:
 	/* any other different formats are not supported */
+		v4l2_err(&isc->v4l2_dev, "Requested unsupported format.\n");
 		ret = -EINVAL;
 	}
 	v4l2_dbg(1, debug, &isc->v4l2_dev,
 		 "Format validation, requested rgb=%u, yuv=%u, grey=%u, bayer=%u\n",
 		 rgb, yuv, grey, bayer);
 
-	/* we cannot output RAW if we do not receive RAW */
-	if ((bayer) && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
+	if ((bayer) &&
+	    !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code)) {
+		v4l2_err(&isc->v4l2_dev, "Cannot output RAW if we do not receive RAW.\n");
 		return -EINVAL;
+	}
 
-	/* we cannot output GREY if we do not receive RAW/GREY */
 	if (grey && !ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code) &&
-	    !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code))
+	    !ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
+		v4l2_err(&isc->v4l2_dev, "Cannot output GREY if we do not receive RAW/GREY.\n");
+		return -EINVAL;
+	}
+
+	if ((rgb || bayer || yuv) &&
+	    ISC_IS_FORMAT_GREY(isc->try_config.sd_format->mbus_code)) {
+		v4l2_err(&isc->v4l2_dev, "Cannot convert GREY to another format.\n");
 		return -EINVAL;
+	}
 
 	return ret;
 }
@@ -822,7 +872,7 @@ static void isc_try_fse(struct isc_device *isc,
 	 * If we do not know yet which format the subdev is using, we cannot
 	 * do anything.
 	 */
-	if (!isc->try_config.sd_format)
+	if (!isc->config.sd_format)
 		return;
 
 	fse.code = isc->try_config.sd_format->mbus_code;
@@ -843,180 +893,141 @@ static void isc_try_fse(struct isc_device *isc,
 	}
 }
 
-static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
-			u32 *code)
+static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f)
 {
-	int i;
-	struct isc_format *sd_fmt = NULL, *direct_fmt = NULL;
 	struct v4l2_pix_format *pixfmt = &f->fmt.pix;
-	struct v4l2_subdev_pad_config pad_cfg = {};
-	struct v4l2_subdev_state pad_state = {
-		.pads = &pad_cfg
-		};
-	struct v4l2_subdev_format format = {
-		.which = V4L2_SUBDEV_FORMAT_TRY,
-	};
-	u32 mbus_code;
-	int ret;
-	bool rlp_dma_direct_dump = false;
+	unsigned int i;
 
 	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
 		return -EINVAL;
 
-	/* Step 1: find a RAW format that is supported */
-	for (i = 0; i < isc->num_user_formats; i++) {
-		if (ISC_IS_FORMAT_RAW(isc->user_formats[i]->mbus_code)) {
-			sd_fmt = isc->user_formats[i];
+	isc->try_config.fourcc = isc->user_formats[0]->fourcc;
+
+	/* find if the format requested is supported */
+	for (i = 0; i < isc->controller_formats_size; i++)
+		if (isc->controller_formats[i].fourcc == pixfmt->pixelformat) {
+			isc->try_config.fourcc = pixfmt->pixelformat;
 			break;
 		}
-	}
-	/* Step 2: We can continue with this RAW format, or we can look
-	 * for better: maybe sensor supports directly what we need.
-	 */
-	direct_fmt = find_format_by_fourcc(isc, pixfmt->pixelformat);
-
-	/* Step 3: We have both. We decide given the module parameter which
-	 * one to use.
-	 */
-	if (direct_fmt && sd_fmt && sensor_preferred)
-		sd_fmt = direct_fmt;
-
-	/* Step 4: we do not have RAW but we have a direct format. Use it. */
-	if (direct_fmt && !sd_fmt)
-		sd_fmt = direct_fmt;
-
-	/* Step 5: if we are using a direct format, we need to package
-	 * everything as 8 bit data and just dump it
-	 */
-	if (sd_fmt == direct_fmt)
-		rlp_dma_direct_dump = true;
-
-	/* Step 6: We have no format. This can happen if the userspace
-	 * requests some weird/invalid format.
-	 * In this case, default to whatever we have
-	 */
-	if (!sd_fmt && !direct_fmt) {
-		sd_fmt = isc->user_formats[isc->num_user_formats - 1];
-		v4l2_dbg(1, debug, &isc->v4l2_dev,
-			 "Sensor not supporting %.4s, using %.4s\n",
-			 (char *)&pixfmt->pixelformat, (char *)&sd_fmt->fourcc);
-	}
-
-	if (!sd_fmt) {
-		ret = -EINVAL;
-		goto isc_try_fmt_err;
-	}
-
-	/* Step 7: Print out what we decided for debugging */
-	v4l2_dbg(1, debug, &isc->v4l2_dev,
-		 "Preferring to have sensor using format %.4s\n",
-		 (char *)&sd_fmt->fourcc);
-
-	/* Step 8: at this moment we decided which format the subdev will use */
-	isc->try_config.sd_format = sd_fmt;
-
-	/* Limit to Atmel ISC hardware capabilities */
-	if (pixfmt->width > isc->max_width)
-		pixfmt->width = isc->max_width;
-	if (pixfmt->height > isc->max_height)
-		pixfmt->height = isc->max_height;
-
-	/*
-	 * The mbus format is the one the subdev outputs.
-	 * The pixels will be transferred in this format Sensor -> ISC
-	 */
-	mbus_code = sd_fmt->mbus_code;
-
-	/*
-	 * Validate formats. If the required format is not OK, default to raw.
-	 */
-
-	isc->try_config.fourcc = pixfmt->pixelformat;
-
-	if (isc_try_validate_formats(isc)) {
-		pixfmt->pixelformat = isc->try_config.fourcc = sd_fmt->fourcc;
-		/* Re-try to validate the new format */
-		ret = isc_try_validate_formats(isc);
-		if (ret)
-			goto isc_try_fmt_err;
-	}
-
-	ret = isc_try_configure_rlp_dma(isc, rlp_dma_direct_dump);
-	if (ret)
-		goto isc_try_fmt_err;
-
-	ret = isc_try_configure_pipeline(isc);
-	if (ret)
-		goto isc_try_fmt_err;
 
-	/* Obtain frame sizes if possible to have crop requirements ready */
-	isc_try_fse(isc, &pad_state);
-
-	v4l2_fill_mbus_format(&format.format, pixfmt, mbus_code);
-	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, set_fmt,
-			       &pad_state, &format);
-	if (ret < 0)
-		goto isc_try_fmt_subdev_err;
+	/* If we did not find the requested format, we will fallback here */
+	pixfmt->pixelformat = isc->try_config.fourcc;
+	pixfmt->colorspace = V4L2_COLORSPACE_SRGB;
+	pixfmt->field = V4L2_FIELD_NONE;
 
-	v4l2_fill_pix_format(pixfmt, &format.format);
+	isc_try_configure_rlp_dma(isc, false);
 
 	/* Limit to Atmel ISC hardware capabilities */
-	if (pixfmt->width > isc->max_width)
-		pixfmt->width = isc->max_width;
-	if (pixfmt->height > isc->max_height)
-		pixfmt->height = isc->max_height;
+	v4l_bound_align_image(&pixfmt->width, 16, isc->max_width, 0,
+			      &pixfmt->height, 16, isc->max_height, 0, 0);
 
 	pixfmt->field = V4L2_FIELD_NONE;
 	pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp_v4l2) >> 3;
 	pixfmt->sizeimage = ((pixfmt->width * isc->try_config.bpp) >> 3) *
 			     pixfmt->height;
 
-	if (code)
-		*code = mbus_code;
+	isc->try_fmt = *f;
 
 	return 0;
+}
 
-isc_try_fmt_err:
-	v4l2_err(&isc->v4l2_dev, "Could not find any possible format for a working pipeline\n");
-isc_try_fmt_subdev_err:
-	memset(&isc->try_config, 0, sizeof(isc->try_config));
+static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
+{
+	isc_try_fmt(isc, f);
 
-	return ret;
+	/* make the try configuration active */
+	isc->config = isc->try_config;
+	isc->fmt = isc->try_fmt;
+
+	v4l2_dbg(1, debug, &isc->v4l2_dev, "ISC set_fmt to %.4s @%dx%d\n",
+		 (char *)&f->fmt.pix.pixelformat,
+		 f->fmt.pix.width, f->fmt.pix.height);
+
+	return 0;
 }
 
-static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
+static int isc_validate(struct isc_device *isc)
 {
+	int ret;
+	int i;
+	struct isc_format *sd_fmt = NULL;
+	struct v4l2_pix_format *pixfmt = &isc->fmt.fmt.pix;
 	struct v4l2_subdev_format format = {
 		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = isc->remote_pad,
+	};
+	struct v4l2_subdev_pad_config pad_cfg = {};
+	struct v4l2_subdev_state pad_state = {
+		.pads = &pad_cfg,
 	};
-	u32 mbus_code = 0;
-	int ret;
 
-	ret = isc_try_fmt(isc, f, &mbus_code);
+	/* Get current format from subdev */
+	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, get_fmt, NULL,
+			       &format);
 	if (ret)
 		return ret;
 
-	v4l2_fill_mbus_format(&format.format, &f->fmt.pix, mbus_code);
-	ret = v4l2_subdev_call(isc->current_subdev->sd, pad,
-			       set_fmt, NULL, &format);
-	if (ret < 0)
-		return ret;
+	/* Identify the subdev's format configuration */
+	for (i = 0; i < isc->num_user_formats; i++)
+		if (isc->user_formats[i]->mbus_code == format.format.code) {
+			sd_fmt = isc->user_formats[i];
+			break;
+		}
+
+	/* Check if the format is not supported */
+	if (!sd_fmt) {
+		v4l2_err(&isc->v4l2_dev,
+			 "Current subdevice is streaming a media bus code that is not supported 0x%x\n",
+			 format.format.code);
+		return -EPIPE;
+	}
+
+	/* At this moment we know which format the subdev will use */
+	isc->try_config.sd_format = sd_fmt;
+
+	/* If the sensor is not RAW, we can only do a direct dump */
+	if (!ISC_IS_FORMAT_RAW(isc->try_config.sd_format->mbus_code))
+		isc_try_configure_rlp_dma(isc, true);
 
 	/* Limit to Atmel ISC hardware capabilities */
-	if (f->fmt.pix.width > isc->max_width)
-		f->fmt.pix.width = isc->max_width;
-	if (f->fmt.pix.height > isc->max_height)
-		f->fmt.pix.height = isc->max_height;
+	v4l_bound_align_image(&format.format.width, 16, isc->max_width, 0,
+			      &format.format.height, 16, isc->max_height, 0, 0);
+
+	/* Check if the frame size is the same. Otherwise we may overflow */
+	if (pixfmt->height != format.format.height ||
+	    pixfmt->width != format.format.width) {
+		v4l2_err(&isc->v4l2_dev,
+			 "ISC not configured with the proper frame size: %dx%d\n",
+			 format.format.width, format.format.height);
+		return -EPIPE;
+	}
 
-	isc->fmt = *f;
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "Identified subdev using format %.4s with %dx%d %d bpp\n",
+		 (char *)&sd_fmt->fourcc, pixfmt->width, pixfmt->height,
+		 isc->try_config.bpp);
 
+	/* Reset and restart AWB if the subdevice changed the format */
 	if (isc->try_config.sd_format && isc->config.sd_format &&
 	    isc->try_config.sd_format != isc->config.sd_format) {
 		isc->ctrls.hist_stat = HIST_INIT;
 		isc_reset_awb_ctrls(isc);
 		isc_update_v4l2_ctrls(isc);
 	}
-	/* make the try configuration active */
+
+	/* Validate formats */
+	ret = isc_try_validate_formats(isc);
+	if (ret)
+		return ret;
+
+	/* Obtain frame sizes if possible to have crop requirements ready */
+	isc_try_fse(isc, &pad_state);
+
+	/* Configure ISC pipeline for the config */
+	ret = isc_try_configure_pipeline(isc);
+	if (ret)
+		return ret;
+
 	isc->config = isc->try_config;
 
 	v4l2_dbg(1, debug, &isc->v4l2_dev, "New ISC configuration in place\n");
@@ -1040,7 +1051,7 @@ static int isc_try_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct isc_device *isc = video_drvdata(file);
 
-	return isc_try_fmt(isc, f, NULL);
+	return isc_try_fmt(isc, f);
 }
 
 static int isc_enum_input(struct file *file, void *priv,
@@ -1841,7 +1852,7 @@ static int isc_set_default_fmt(struct isc_device *isc)
 	};
 	int ret;
 
-	ret = isc_try_fmt(isc, &f, NULL);
+	ret = isc_try_fmt(isc, &f);
 	if (ret)
 		return ret;
 
@@ -2015,6 +2026,24 @@ int isc_pipeline_init(struct isc_device *isc)
 }
 EXPORT_SYMBOL_GPL(isc_pipeline_init);
 
+int isc_link_validate(struct media_link *link)
+{
+	struct video_device *vdev =
+		media_entity_to_video_device(link->sink->entity);
+	struct isc_device *isc = video_get_drvdata(vdev);
+	int ret;
+
+	ret = v4l2_subdev_link_validate(link);
+	if (ret)
+		return ret;
+
+	return isc_validate(isc);
+}
+
+static const struct media_entity_operations isc_entity_operations = {
+	.link_validate = isc_link_validate,
+};
+
 int isc_mc_init(struct isc_device *isc, u32 ver)
 {
 	const struct of_device_id *match;
@@ -2022,6 +2051,8 @@ int isc_mc_init(struct isc_device *isc, u32 ver)
 
 	isc->video_dev.entity.function = MEDIA_ENT_F_IO_V4L;
 	isc->video_dev.entity.flags = MEDIA_ENT_FL_DEFAULT;
+	isc->video_dev.entity.ops = &isc_entity_operations;
+
 	isc->pads[ISC_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 
 	ret = media_entity_pads_init(&isc->video_dev.entity, ISC_PADS_NUM,
diff --git a/drivers/media/platform/atmel/atmel-isc-scaler.c b/drivers/media/platform/atmel/atmel-isc-scaler.c
index ec95c9665883..93375a61aea6 100644
--- a/drivers/media/platform/atmel/atmel-isc-scaler.c
+++ b/drivers/media/platform/atmel/atmel-isc-scaler.c
@@ -155,6 +155,10 @@ static const struct v4l2_subdev_pad_ops isc_scaler_pad_ops = {
 	.init_cfg = isc_scaler_init_cfg,
 };
 
+static const struct media_entity_operations isc_scaler_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static const struct v4l2_subdev_ops xisc_scaler_subdev_ops = {
 	.pad = &isc_scaler_pad_ops,
 };
@@ -172,6 +176,7 @@ int isc_scaler_init(struct isc_device *isc)
 
 	isc->scaler_sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	isc->scaler_sd.entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
+	isc->scaler_sd.entity.ops = &isc_scaler_entity_ops;
 	isc->scaler_pads[ISC_SCALER_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	isc->scaler_pads[ISC_SCALER_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
 
diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index 04ea5e340808..e36cf9d3942a 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -270,6 +270,7 @@ enum isc_scaler_pads {
  * @formats_list_size:	size of formats_list array
  * @pads:		media controller pads for isc video entity
  * @mdev:		media device that is registered by the isc
+ * @mpipe:		media device pipeline used by the isc
  * @remote_pad:		remote pad on the connected subdevice
  * @scaler_sd:		subdevice for the scaler that isc registers
  * @scaler_pads:	media controller pads for the scaler subdevice
@@ -295,6 +296,7 @@ struct isc_device {
 	struct completion	comp;
 
 	struct v4l2_format	fmt;
+	struct v4l2_format	try_fmt;
 	struct isc_format	**user_formats;
 	unsigned int		num_user_formats;
 
@@ -366,6 +368,7 @@ struct isc_device {
 	struct {
 		struct media_pad		pads[ISC_PADS_NUM];
 		struct media_device		mdev;
+		struct media_pipeline		mpipe;
 
 		u32				remote_pad;
 	};
-- 
2.25.1

