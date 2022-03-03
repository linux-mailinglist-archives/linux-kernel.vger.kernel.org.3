Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002CE4CC18D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiCCPis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiCCPio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:38:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AC7145E0B;
        Thu,  3 Mar 2022 07:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646321872; x=1677857872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vHPx+R86hB2T/pWfa0B0yH7edytPtcnsp/cLyFyum0=;
  b=oHS92V7LBFz0awxofSwgY6cAlZN9iYzrTgfhfBC9Scbp2vCRvF6h4xCG
   maGXem4xn8FIFk4mj0UkLSXKQmymI4THvBZZrrkqtCAzYHRAl/KpVG+OJ
   WyGSv7HsM+PEQTeJGPO7DSSLYWnwSEIGkE3yqAz5j7C9LlLbFnjBROQcO
   +xFgHukLgwOElAIcHCmsdvbd9gvMzb2n8+n8buRiGt7wytw9dEcQ/jNFr
   3qe0DzgCwZp+vMYJe0KANkeOhE1UVXX5cav5NloeVs2Ei9hYtJ29H5iI+
   tP3T78EdJ+mSTK1qddILi/UXmrRzFNB2PuVqx+W5k+MpPzgevJZh5SZte
   A==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643698800"; 
   d="scan'208";a="150738066"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 08:37:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 08:37:47 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 08:37:37 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v6 08/13] media: atmel: atmel-isc: change format propagation to subdev into only verification
Date:   Thu, 3 Mar 2022 17:36:13 +0200
Message-ID: <20220303153618.2084156-9-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303153618.2084156-1-eugen.hristev@microchip.com>
References: <20220303153618.2084156-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Otherwise, the enumfmt will report all the formats that the ISC could output.
With this rework, the dynamic list of user formats is removed. It makes no
more sense to identify at complete time which formats the sensor could emit,
and add those into a separate dynamic list.
The ISC will start with a simple preconfigured default format, and at
link validate time, decide whether it can use the format that is configured
on the sink or not.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v6:
- reworked a bit enum_fmt as suggested by Jacopo

Changes in v5:
- removed user_formats dynamic list as it is now pointless
- greatly simplified the enum_fmt function
- removed some init code that was useless now

Changes in v4:
- moved validation code into link_validate and used media_pipeline_start
- merged this patch with the enum_fmt patch which was previously in v3 of
the series

Changes in v3:
- clamp to maximum resolution once the frame size from the subdev is found

 drivers/media/platform/atmel/atmel-isc-base.c | 418 ++++++++----------
 .../media/platform/atmel/atmel-isc-scaler.c   |   5 +
 drivers/media/platform/atmel/atmel-isc.h      |  13 +-
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  20 +
 .../media/platform/atmel/atmel-sama7g5-isc.c  |  20 +
 5 files changed, 238 insertions(+), 238 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index ee1dda6707a0..8682b0591cd0 100644
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
@@ -385,6 +384,9 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 	v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
 
 err_start_stream:
+	media_pipeline_stop(&isc->video_dev.entity);
+
+err_pipeline_start:
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	list_for_each_entry(buf, &isc->dma_queue, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
@@ -423,6 +425,9 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	if (ret && ret != -ENOIOCTLCMD)
 		v4l2_err(&isc->v4l2_dev, "stream off failed in subdev\n");
 
+	/* Stop media pipeline */
+	media_pipeline_stop(&isc->video_dev.entity);
+
 	/* Release all active buffers */
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	if (unlikely(isc->cur_frm)) {
@@ -453,22 +458,6 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
 	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
 }
 
-static struct isc_format *find_format_by_fourcc(struct isc_device *isc,
-						 unsigned int fourcc)
-{
-	unsigned int num_formats = isc->num_user_formats;
-	struct isc_format *fmt;
-	unsigned int i;
-
-	for (i = 0; i < num_formats; i++) {
-		fmt = isc->user_formats[i];
-		if (fmt->fourcc == fourcc)
-			return fmt;
-	}
-
-	return NULL;
-}
-
 static const struct vb2_ops isc_vb2_ops = {
 	.queue_setup		= isc_queue_setup,
 	.wait_prepare		= vb2_ops_wait_prepare,
@@ -497,27 +486,59 @@ static int isc_enum_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct isc_device *isc = video_drvdata(file);
 	u32 index = f->index;
-	u32 i, supported_index;
+	u32 i, supported_index = 0;
+	struct isc_format *fmt;
+
+	/*
+	 * If we are not asked a specific mbus_code, we have to report all
+	 * the formats that we can output to.
+	 */
+	if (!f->mbus_code) {
+		if (index >= isc->controller_formats_size)
+			return -EINVAL;
 
-	if (index < isc->controller_formats_size) {
 		f->pixelformat = isc->controller_formats[index].fourcc;
+
 		return 0;
 	}
 
-	index -= isc->controller_formats_size;
+	/*
+	 * If a specific mbus_code is requested, check if we support
+	 * this mbus_code as input for the ISC.
+	 * If it's supported, then we report the corresponding pixelformat
+	 * as first possible option for the ISC.
+	 * E.g. mbus MEDIA_BUS_FMT_YUYV8_2X8 and report
+	 * 'YUYV' (YUYV 4:2:2)
+	 */
+	fmt = isc_find_format_by_code(isc, f->mbus_code, &i);
+	if (!fmt)
+		return -EINVAL;
+
+	if (index == supported_index) {
+		f->pixelformat = fmt->fourcc;
 
-	supported_index = 0;
+		return 0;
+	}
 
-	for (i = 0; i < isc->formats_list_size; i++) {
-		if (!ISC_IS_FORMAT_RAW(isc->formats_list[i].mbus_code) ||
-		    !isc->formats_list[i].sd_support)
-			continue;
-		if (supported_index == index) {
-			f->pixelformat = isc->formats_list[i].fourcc;
-			return 0;
+	supported_index++;
+
+	/* If the index is not raw, we don't have anymore formats to report */
+	if (!ISC_IS_FORMAT_RAW(f->mbus_code))
+		return -EINVAL;
+	/*
+	 * We are asked for a specific mbus code, which is raw.
+	 * We have to search through the formats we can convert to.
+	 * We have to skip the raw formats, we cannot convert to raw.
+	 * E.g. 'AR12' (16-bit ARGB 4-4-4-4), 'AR15' (16-bit ARGB 1-5-5-5), etc.
+	 */
+	for (i = 0; i < isc->controller_formats_size; i++)
+		if (!isc->controller_formats[i].raw) {
+			if (index == supported_index) {
+				f->pixelformat = isc->controller_formats[i].fourcc;
+				return 0;
+			}
+			supported_index++;
 		}
-		supported_index++;
-	}
 
 	return -EINVAL;
 }
@@ -584,20 +605,30 @@ static int isc_try_validate_formats(struct isc_device *isc)
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
+	if (bayer &&
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
@@ -825,7 +856,7 @@ static void isc_try_fse(struct isc_device *isc,
 	 * If we do not know yet which format the subdev is using, we cannot
 	 * do anything.
 	 */
-	if (!isc->try_config.sd_format)
+	if (!isc->config.sd_format)
 		return;
 
 	fse.code = isc->try_config.sd_format->mbus_code;
@@ -846,180 +877,140 @@ static void isc_try_fse(struct isc_device *isc,
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
+	isc->try_config.fourcc = isc->controller_formats[0].fourcc;
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
 
-	/* Step 8: at this moment we decided which format the subdev will use */
-	isc->try_config.sd_format = sd_fmt;
+	isc_try_configure_rlp_dma(isc, false);
 
 	/* Limit to Atmel ISC hardware capabilities */
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
-
-	/* Obtain frame sizes if possible to have crop requirements ready */
-	isc_try_fse(isc, &pad_state);
-
-	v4l2_fill_mbus_format(&format.format, pixfmt, mbus_code);
-	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, set_fmt,
-			       &pad_state, &format);
-	if (ret < 0)
-		goto isc_try_fmt_subdev_err;
-
-	v4l2_fill_pix_format(pixfmt, &format.format);
+	v4l_bound_align_image(&pixfmt->width, 16, isc->max_width, 0,
+			      &pixfmt->height, 16, isc->max_height, 0, 0);
+	/* If we did not find the requested format, we will fallback here */
+	pixfmt->pixelformat = isc->try_config.fourcc;
+	pixfmt->colorspace = V4L2_COLORSPACE_SRGB;
+	pixfmt->field = V4L2_FIELD_NONE;
 
-	/* Limit to Atmel ISC hardware capabilities */
-	if (pixfmt->width > isc->max_width)
-		pixfmt->width = isc->max_width;
-	if (pixfmt->height > isc->max_height)
-		pixfmt->height = isc->max_height;
 
-	pixfmt->field = V4L2_FIELD_NONE;
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
+	for (i = 0; i < isc->formats_list_size; i++)
+		if (isc->formats_list[i].mbus_code == format.format.code) {
+			sd_fmt = &isc->formats_list[i];
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
 
-	isc->fmt = *f;
+	/* Check if the frame size is the same. Otherwise we may overflow */
+	if (pixfmt->height != format.format.height ||
+	    pixfmt->width != format.format.width) {
+		v4l2_err(&isc->v4l2_dev,
+			 "ISC not configured with the proper frame size: %dx%d\n",
+			 format.format.width, format.format.height);
+		return -EPIPE;
+	}
+
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
@@ -1043,7 +1034,7 @@ static int isc_try_fmt_vid_cap(struct file *file, void *priv,
 {
 	struct isc_device *isc = video_drvdata(file);
 
-	return isc_try_fmt(isc, f, NULL);
+	return isc_try_fmt(isc, f);
 }
 
 static int isc_enum_input(struct file *file, void *priv,
@@ -1098,10 +1089,6 @@ static int isc_enum_framesizes(struct file *file, void *fh,
 	if (fsize->index)
 		return -EINVAL;
 
-	for (i = 0; i < isc->num_user_formats; i++)
-		if (isc->user_formats[i]->fourcc == fsize->pixel_format)
-			ret = 0;
-
 	for (i = 0; i < isc->controller_formats_size; i++)
 		if (isc->controller_formats[i].fourcc == fsize->pixel_format)
 			ret = 0;
@@ -1782,52 +1769,6 @@ struct isc_format *isc_find_format_by_code(struct isc_device *isc,
 }
 EXPORT_SYMBOL_GPL(isc_find_format_by_code);
 
-static int isc_formats_init(struct isc_device *isc)
-{
-	struct isc_format *fmt;
-	struct v4l2_subdev *subdev = isc->current_subdev->sd;
-	unsigned int num_fmts, i, j;
-	u32 list_size = isc->formats_list_size;
-	struct v4l2_subdev_mbus_code_enum mbus_code = {
-		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
-	};
-
-	num_fmts = 0;
-	while (!v4l2_subdev_call(subdev, pad, enum_mbus_code,
-	       NULL, &mbus_code)) {
-		mbus_code.index++;
-
-		fmt = isc_find_format_by_code(isc, mbus_code.code, &i);
-		if (!fmt) {
-			v4l2_warn(&isc->v4l2_dev, "Mbus code %x not supported\n",
-				  mbus_code.code);
-			continue;
-		}
-
-		fmt->sd_support = true;
-		num_fmts++;
-	}
-
-	if (!num_fmts)
-		return -ENXIO;
-
-	isc->num_user_formats = num_fmts;
-	isc->user_formats = devm_kcalloc(isc->dev,
-					 num_fmts, sizeof(*isc->user_formats),
-					 GFP_KERNEL);
-	if (!isc->user_formats)
-		return -ENOMEM;
-
-	fmt = &isc->formats_list[0];
-	for (i = 0, j = 0; i < list_size; i++) {
-		if (fmt->sd_support)
-			isc->user_formats[j++] = fmt;
-		fmt++;
-	}
-
-	return 0;
-}
-
 static int isc_set_default_fmt(struct isc_device *isc)
 {
 	struct v4l2_format f = {
@@ -1836,12 +1777,12 @@ static int isc_set_default_fmt(struct isc_device *isc)
 			.width		= VGA_WIDTH,
 			.height		= VGA_HEIGHT,
 			.field		= V4L2_FIELD_NONE,
-			.pixelformat	= isc->user_formats[0]->fourcc,
+			.pixelformat	= isc->controller_formats[0].fourcc,
 		},
 	};
 	int ret;
 
-	ret = isc_try_fmt(isc, &f, NULL);
+	ret = isc_try_fmt(isc, &f);
 	if (ret)
 		return ret;
 
@@ -1896,13 +1837,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	spin_lock_init(&isc->dma_queue_lock);
 	spin_lock_init(&isc->awb_lock);
 
-	ret = isc_formats_init(isc);
-	if (ret < 0) {
-		v4l2_err(&isc->v4l2_dev,
-			 "Init format failed: %d\n", ret);
-		goto isc_async_complete_err;
-	}
-
 	ret = isc_set_default_fmt(isc);
 	if (ret) {
 		v4l2_err(&isc->v4l2_dev, "Could not set default format\n");
@@ -2016,6 +1950,24 @@ int isc_pipeline_init(struct isc_device *isc)
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
@@ -2023,6 +1975,8 @@ int isc_mc_init(struct isc_device *isc, u32 ver)
 
 	isc->video_dev.entity.function = MEDIA_ENT_F_IO_V4L;
 	isc->video_dev.entity.flags = MEDIA_ENT_FL_DEFAULT;
+	isc->video_dev.entity.ops = &isc_entity_operations;
+
 	isc->pads[ISC_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 
 	ret = media_entity_pads_init(&isc->video_dev.entity, ISC_PADS_NUM,
diff --git a/drivers/media/platform/atmel/atmel-isc-scaler.c b/drivers/media/platform/atmel/atmel-isc-scaler.c
index 305524c1123e..b8d2696c571c 100644
--- a/drivers/media/platform/atmel/atmel-isc-scaler.c
+++ b/drivers/media/platform/atmel/atmel-isc-scaler.c
@@ -182,6 +182,10 @@ static const struct v4l2_subdev_pad_ops isc_scaler_pad_ops = {
 	.init_cfg = isc_scaler_init_cfg,
 };
 
+static const struct media_entity_operations isc_scaler_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static const struct v4l2_subdev_ops xisc_scaler_subdev_ops = {
 	.pad = &isc_scaler_pad_ops,
 };
@@ -199,6 +203,7 @@ int isc_scaler_init(struct isc_device *isc)
 
 	isc->scaler_sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	isc->scaler_sd.entity.function = MEDIA_ENT_F_PROC_VIDEO_SCALER;
+	isc->scaler_sd.entity.ops = &isc_scaler_entity_ops;
 	isc->scaler_pads[ISC_SCALER_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	isc->scaler_pads[ISC_SCALER_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE;
 
diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index f98f25a55e73..5b0100c8c245 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -63,15 +63,16 @@ struct isc_subdev_entity {
  * @cfa_baycfg:		If this format is RAW BAYER, indicate the type of bayer.
 			this is either BGBG, RGRG, etc.
  * @pfe_cfg0_bps:	Number of hardware data lines connected to the ISC
+ * @raw:		If the format is raw bayer.
  */
 
 struct isc_format {
 	u32	fourcc;
 	u32	mbus_code;
 	u32	cfa_baycfg;
-
-	bool	sd_support;
 	u32	pfe_cfg0_bps;
+
+	bool	raw;
 };
 
 /* Pipeline bitmap */
@@ -216,8 +217,7 @@ enum isc_scaler_pads {
  * @comp:		completion reference that signals frame completion
  *
  * @fmt:		current v42l format
- * @user_formats:	list of formats that are supported and agreed with sd
- * @num_user_formats:	how many formats are in user_formats
+ * @try_fmt:		current v4l2 try format
  *
  * @config:		current ISC format configuration
  * @try_config:		the current ISC try format , not yet activated
@@ -272,6 +272,7 @@ enum isc_scaler_pads {
  * @formats_list_size:	size of formats_list array
  * @pads:		media controller pads for isc video entity
  * @mdev:		media device that is registered by the isc
+ * @mpipe:		media device pipeline used by the isc
  * @remote_pad:		remote pad on the connected subdevice
  * @scaler_sd:		subdevice for the scaler that isc registers
  * @scaler_pads:	media controller pads for the scaler subdevice
@@ -298,8 +299,7 @@ struct isc_device {
 	struct completion	comp;
 
 	struct v4l2_format	fmt;
-	struct isc_format	**user_formats;
-	unsigned int		num_user_formats;
+	struct v4l2_format	try_fmt;
 
 	struct fmt_config	config;
 	struct fmt_config	try_config;
@@ -369,6 +369,7 @@ struct isc_device {
 	struct {
 		struct media_pad		pads[ISC_PADS_NUM];
 		struct media_device		mdev;
+		struct media_pipeline		mpipe;
 
 		u32				remote_pad;
 	};
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index d96ee3373889..2a651e237193 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -80,20 +80,40 @@ static const struct isc_format sama5d2_controller_formats[] = {
 		.fourcc		= V4L2_PIX_FMT_Y10,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB12,
+		.raw		= true,
 	},
 };
 
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index e07ae188c15f..a0d60cfdba7b 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -89,20 +89,40 @@ static const struct isc_format sama7g5_controller_formats[] = {
 		.fourcc		= V4L2_PIX_FMT_Y16,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB8,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SGRBG10,
+		.raw		= true,
 	}, {
 		.fourcc		= V4L2_PIX_FMT_SRGGB10,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SBGGR12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGBRG12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SGRBG12,
+		.raw		= true,
+	}, {
+		.fourcc		= V4L2_PIX_FMT_SRGGB12,
+		.raw		= true,
 	},
 };
 
-- 
2.25.1

