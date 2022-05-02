Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C15516F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384860AbiEBMHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384852AbiEBMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:07:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500CB12AFA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651493057; x=1683029057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IjZ/C+7/ISySe9jtHQJBuhtEda5Hxd+KTWubLo1DgSU=;
  b=CdwHGOd0uGzEiOE/wLQ6zyR+90m4rHMdRlFZlj8mR0YLhYsdAphTjH7w
   UvP67t+/9ztm5kw+OcqV7qACUejNHlw+WvPatD4WU+UgTVnSatjdP8k1F
   ZgOfx+5kPqDGdeByYfOv4IlGTbBExhsWPyKQMNWcQgT2IMK6Xq8QOjuh8
   kjHw6lP3yeD7azo2FEo0pbYDKR8KgZio6bwLcSNdQ0hDnTsLLpAXdkzoL
   uGVwR3QfBb0xlGNnanEcnbe1lO+/5YBFvkvGPIsJQ8f8knvg8RUtJ+9MO
   zDmk6lwjiL0Vb47j890ZmDRvuGeWRskv4kwbMwyS3jj+EQ2/6XBFl01Zd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="353622503"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="353622503"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 05:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="516043060"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 05:04:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B901179; Mon,  2 May 2022 15:04:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gaston Gonzalez <gascoar@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: [PATCH v1 1/1] staging: vc04_services: Re-use generic struct s32_fract
Date:   Mon,  2 May 2022 15:03:55 +0300
Message-Id: <20220502120355.84334-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct s32_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../bcm2835-camera/bcm2835-camera.c           | 24 +++++++-------
 .../vc04_services/bcm2835-camera/controls.c   | 33 ++++++++++---------
 .../vchiq-mmal/mmal-msg-common.h              |  7 ++--
 .../vchiq-mmal/mmal-msg-format.h              |  6 ++--
 .../vchiq-mmal/mmal-parameters.h              | 15 ++++-----
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 10 +++---
 6 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 88b1878854e0..fd456d1f7061 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1033,9 +1033,9 @@ static int mmal_setup_video_component(struct bcm2835_mmal_dev *dev,
 	preview_port->es.video.crop.y = 0;
 	preview_port->es.video.crop.width = f->fmt.pix.width;
 	preview_port->es.video.crop.height = f->fmt.pix.height;
-	preview_port->es.video.frame_rate.num =
+	preview_port->es.video.frame_rate.numerator =
 				  dev->capture.timeperframe.denominator;
-	preview_port->es.video.frame_rate.den =
+	preview_port->es.video.frame_rate.denominator =
 				  dev->capture.timeperframe.numerator;
 	ret = vchiq_mmal_port_set_format(dev->instance, preview_port);
 
@@ -1084,9 +1084,9 @@ static int mmal_setup_encode_component(struct bcm2835_mmal_dev *dev,
 	port->es.video.crop.y = 0;
 	port->es.video.crop.width = f->fmt.pix.width;
 	port->es.video.crop.height = f->fmt.pix.height;
-	port->es.video.frame_rate.num =
+	port->es.video.frame_rate.numerator =
 		  dev->capture.timeperframe.denominator;
-	port->es.video.frame_rate.den =
+	port->es.video.frame_rate.denominator =
 		  dev->capture.timeperframe.numerator;
 
 	port->format.encoding = mfmt->mmal;
@@ -1225,8 +1225,8 @@ static int mmal_setup_components(struct bcm2835_mmal_dev *dev,
 	camera_port->es.video.crop.y = 0;
 	camera_port->es.video.crop.width = f->fmt.pix.width;
 	camera_port->es.video.crop.height = f->fmt.pix.height;
-	camera_port->es.video.frame_rate.num = 0;
-	camera_port->es.video.frame_rate.den = 1;
+	camera_port->es.video.frame_rate.numerator = 0;
+	camera_port->es.video.frame_rate.denominator = 1;
 	camera_port->es.video.color_space = MMAL_COLOR_SPACE_JPEG_JFIF;
 
 	ret = vchiq_mmal_port_set_format(dev->instance, camera_port);
@@ -1629,8 +1629,8 @@ static int mmal_init(struct bcm2835_mmal_dev *dev)
 	format->es->video.crop.y = 0;
 	format->es->video.crop.width = 1024;
 	format->es->video.crop.height = 768;
-	format->es->video.frame_rate.num = 0; /* Rely on fps_range */
-	format->es->video.frame_rate.den = 1;
+	format->es->video.frame_rate.numerator = 0; /* Rely on fps_range */
+	format->es->video.frame_rate.denominator = 1;
 
 	format = &camera->output[CAM_PORT_VIDEO].format;
 
@@ -1643,8 +1643,8 @@ static int mmal_init(struct bcm2835_mmal_dev *dev)
 	format->es->video.crop.y = 0;
 	format->es->video.crop.width = 1024;
 	format->es->video.crop.height = 768;
-	format->es->video.frame_rate.num = 0; /* Rely on fps_range */
-	format->es->video.frame_rate.den = 1;
+	format->es->video.frame_rate.numerator = 0; /* Rely on fps_range */
+	format->es->video.frame_rate.denominator = 1;
 
 	format = &camera->output[CAM_PORT_CAPTURE].format;
 
@@ -1656,8 +1656,8 @@ static int mmal_init(struct bcm2835_mmal_dev *dev)
 	format->es->video.crop.y = 0;
 	format->es->video.crop.width = 2592;
 	format->es->video.crop.height = 1944;
-	format->es->video.frame_rate.num = 0; /* Rely on fps_range */
-	format->es->video.frame_rate.den = 1;
+	format->es->video.frame_rate.numerator = 0; /* Rely on fps_range */
+	format->es->video.frame_rate.denominator = 1;
 
 	dev->capture.width = format->es->video.width;
 	dev->capture.height = format->es->video.height;
diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index eb722f16fb91..a663d34868f8 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -154,13 +154,13 @@ static int ctrl_set_rational(struct bcm2835_mmal_dev *dev,
 			     struct v4l2_ctrl *ctrl,
 			     const struct bcm2835_mmal_v4l2_ctrl *mmal_ctrl)
 {
-	struct mmal_parameter_rational rational_value;
+	struct s32_fract rational_value;
 	struct vchiq_mmal_port *control;
 
 	control = &dev->component[COMP_CAMERA]->control;
 
-	rational_value.num = ctrl->val;
-	rational_value.den = 100;
+	rational_value.numumerator = ctrl->val;
+	rational_value.denominator = 100;
 
 	return vchiq_mmal_port_parameter_set(dev->instance, control,
 					     mmal_ctrl->mmal_id,
@@ -489,9 +489,10 @@ static int ctrl_set_awb_gains(struct bcm2835_mmal_dev *dev,
 	else if (ctrl->id == V4L2_CID_BLUE_BALANCE)
 		dev->blue_gain = ctrl->val;
 
-	gains.r_gain.num = dev->red_gain;
-	gains.b_gain.num = dev->blue_gain;
-	gains.r_gain.den = gains.b_gain.den = 1000;
+	gains.r_gain.numerator = dev->red_gain;
+	gains.r_gain.denominator = 1000;
+	gains.b_gain.numerator = dev->blue_gain;
+	gains.b_gain.denominator = 1000;
 
 	return vchiq_mmal_port_parameter_set(dev->instance, control,
 					     mmal_ctrl->mmal_id,
@@ -1271,26 +1272,26 @@ int set_framerate_params(struct bcm2835_mmal_dev *dev)
 	struct mmal_parameter_fps_range fps_range;
 	int ret;
 
-	fps_range.fps_high.num = dev->capture.timeperframe.denominator;
-	fps_range.fps_high.den = dev->capture.timeperframe.numerator;
+	fps_range.fps_high.numerator = dev->capture.timeperframe.denominator;
+	fps_range.fps_high.denominator = dev->capture.timeperframe.numerator;
 
 	if ((dev->exposure_mode_active != MMAL_PARAM_EXPOSUREMODE_OFF) &&
 	    (dev->exp_auto_priority)) {
 		/* Variable FPS. Define min FPS as 1fps. */
-		fps_range.fps_low.num = 1;
-		fps_range.fps_low.den = 1;
+		fps_range.fps_low.numerator = 1;
+		fps_range.fps_low.denominator = 1;
 	} else {
 		/* Fixed FPS - set min and max to be the same */
-		fps_range.fps_low.num = fps_range.fps_high.num;
-		fps_range.fps_low.den = fps_range.fps_high.den;
+		fps_range.fps_low.numerator = fps_range.fps_high.numerator;
+		fps_range.fps_low.denominator = fps_range.fps_high.denominator;
 	}
 
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 		 "Set fps range to %d/%d to %d/%d\n",
-		 fps_range.fps_low.num,
-		 fps_range.fps_low.den,
-		 fps_range.fps_high.num,
-		 fps_range.fps_high.den);
+		 fps_range.fps_low.numerator,
+		 fps_range.fps_low.denominator,
+		 fps_range.fps_high.numerator,
+		 fps_range.fps_high.denominator);
 
 	ret = vchiq_mmal_port_parameter_set(dev->instance,
 					    &dev->component[COMP_CAMERA]->output[CAM_PORT_PREVIEW],
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h
index d77e15f25dda..492d4c5dca08 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-common.h
@@ -14,6 +14,8 @@
 #ifndef MMAL_MSG_COMMON_H
 #define MMAL_MSG_COMMON_H
 
+#include <linux/types.h>
+
 enum mmal_msg_status {
 	MMAL_MSG_STATUS_SUCCESS = 0, /**< Success */
 	MMAL_MSG_STATUS_ENOMEM,      /**< Out of memory */
@@ -40,9 +42,4 @@ struct mmal_rect {
 	s32 height; /**< height */
 };
 
-struct mmal_rational {
-	s32 num;    /**< Numerator */
-	s32 den;    /**< Denominator */
-};
-
 #endif /* MMAL_MSG_COMMON_H */
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h
index 1e996d8cd283..5569876d8c7d 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-msg-format.h
@@ -14,6 +14,8 @@
 #ifndef MMAL_MSG_FORMAT_H
 #define MMAL_MSG_FORMAT_H
 
+#include <linux/math.h>
+
 #include "mmal-msg-common.h"
 
 /* MMAL_ES_FORMAT_T */
@@ -30,8 +32,8 @@ struct mmal_video_format {
 	u32 width;		/* Width of frame in pixels */
 	u32 height;		/* Height of frame in rows of pixels */
 	struct mmal_rect crop;	/* Visible region of the frame */
-	struct mmal_rational frame_rate;	/* Frame rate */
-	struct mmal_rational par;		/* Pixel aspect ratio */
+	struct s32_fract frame_rate;	/* Frame rate */
+	struct s32_fract par;		/* Pixel aspect ratio */
 
 	/*
 	 * FourCC specifying the color space of the video stream. See the
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
index 2277e05b1e31..a0cdd28101f2 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-parameters.h
@@ -22,6 +22,8 @@
 #ifndef MMAL_PARAMETERS_H
 #define MMAL_PARAMETERS_H
 
+#include <linux/math.h>
+
 /** Common parameter ID group, used with many types of component. */
 #define MMAL_PARAMETER_GROUP_COMMON		(0 << 16)
 /** Camera-specific parameter ID group. */
@@ -223,11 +225,6 @@ enum mmal_parameter_camera_type {
 	MMAL_PARAMETER_CUSTOM_AWB_GAINS,
 };
 
-struct mmal_parameter_rational {
-	s32 num;    /**< Numerator */
-	s32 den;    /**< Denominator */
-};
-
 enum mmal_parameter_camera_config_timestamp_mode {
 	MMAL_PARAM_TIMESTAMP_MODE_ZERO = 0, /* Always timestamp frames as 0 */
 	MMAL_PARAM_TIMESTAMP_MODE_RAW_STC,  /* Use the raw STC value
@@ -243,9 +240,9 @@ enum mmal_parameter_camera_config_timestamp_mode {
 
 struct mmal_parameter_fps_range {
 	/**< Low end of the permitted framerate range */
-	struct mmal_parameter_rational	fps_low;
+	struct s32_fract	fps_low;
 	/**< High end of the permitted framerate range */
-	struct mmal_parameter_rational	fps_high;
+	struct s32_fract	fps_high;
 };
 
 /* camera configuration parameter */
@@ -350,8 +347,8 @@ enum MMAL_PARAM_FLICKERAVOID {
 };
 
 struct mmal_parameter_awbgains {
-	struct mmal_parameter_rational r_gain;	/**< Red gain */
-	struct mmal_parameter_rational b_gain;	/**< Blue gain */
+	struct s32_fract r_gain;	/**< Red gain */
+	struct s32_fract b_gain;	/**< Blue gain */
 };
 
 /** Manner of video rate control */
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 249dd3e30c2f..845b20e4d05a 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -744,9 +744,9 @@ static void dump_port_info(struct vchiq_mmal_port *port)
 			 port->es.video.crop.y,
 			 port->es.video.crop.width, port->es.video.crop.height);
 		pr_debug("		 : framerate %d/%d  aspect %d/%d\n",
-			 port->es.video.frame_rate.num,
-			 port->es.video.frame_rate.den,
-			 port->es.video.par.num, port->es.video.par.den);
+			 port->es.video.frame_rate.numerator,
+			 port->es.video.frame_rate.denominator,
+			 port->es.video.par.numerator, port->es.video.par.denominator);
 	}
 }
 
@@ -1549,8 +1549,8 @@ int vchiq_mmal_port_connect_tunnel(struct vchiq_mmal_instance *instance,
 	dst->es.video.crop.y = src->es.video.crop.y;
 	dst->es.video.crop.width = src->es.video.crop.width;
 	dst->es.video.crop.height = src->es.video.crop.height;
-	dst->es.video.frame_rate.num = src->es.video.frame_rate.num;
-	dst->es.video.frame_rate.den = src->es.video.frame_rate.den;
+	dst->es.video.frame_rate.numerator = src->es.video.frame_rate.numerator;
+	dst->es.video.frame_rate.denominator = src->es.video.frame_rate.denominator;
 
 	/* set new format */
 	ret = port_info_set(instance, dst);
-- 
2.35.1

