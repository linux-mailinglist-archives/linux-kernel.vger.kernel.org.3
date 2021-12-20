Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163D947B539
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhLTVbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhLTVbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:31:21 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62390C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:31:21 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id m25so11059105qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHGHF/771v/lWlHIpIBMgn0pJ2OF4beYEH9R0ZP6Heo=;
        b=GOztQB5WaoE24sEWGlnVpZkWx2AyyVC9XzzBKIsDrkDAWZa+49Qx8gfIezCdcqahTC
         rzEO0lK0h38kLkhlAN182np60N4wYxXZPqHdetD/9SZhLPGa4wctdhxkjOQV5za6W0Pi
         Ihj2LRv4ccblWuqYM9VkozQ9c/9JA3awsnudBreEck7RrU6snyayJ5Gu1KmB5L5xO1tp
         0yB14Ngzfpah5gEWWm20xqbfknoJrQMlAqILi8GUkuSozNla3UxQ3qKKQ1th4NJQ176X
         JAfuSfzrKOWK9nTtw/W3jh+FVK7g31sGyaTlbSyUAFbxWrw8EB2A+H8kOgwyp0QkjjBZ
         B/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHGHF/771v/lWlHIpIBMgn0pJ2OF4beYEH9R0ZP6Heo=;
        b=r11IwxTe+jV0SotRNkBP9k+xaitcqs6pPrRkzuxo+Rd4LSfBrgZhCL0iEN7enansl1
         8KLK655MK4LyWlt43P/ttldd4MYs+MBXLeYTI/xbAVHboWYstykF1jJT7/sMWjnZj15e
         j894VDt8xgbVW7A9O8PiFX+nn1OU8LmnZm0znLgDmShai4kFkaYUpnVycltU5inY9WMh
         FnwobBsvXEYSYmp6wVGmM3EcXfUCMIZp2a6i1nWPAl6m4XZGUHYEM+ubID9s0MAXx+1r
         zSXHJFlHrC/ndU9H738R/lwVSZH98QBpm1XuFK1QtnmJGUMsEUvPnD07B7aHy5nTK9Kw
         9tKg==
X-Gm-Message-State: AOAM53073gfMSQrIqRHyJFwmyhbqBBEojh+MqYozD+qtMEHcmjKF8Th0
        DbYs4W+JOXTMdJ+nBf6o3J8=
X-Google-Smtp-Source: ABdhPJzEtJ9Sg4a2vOVNIx/4lbdFVp/bxHtTeMpseOoJWPVQCChWxpxX20RMHtpkvjPjfkA+EYpI9w==
X-Received: by 2002:ac8:5dcf:: with SMTP id e15mr14402883qtx.567.1640035880556;
        Mon, 20 Dec 2021 13:31:20 -0800 (PST)
Received: from localhost.localdomain ([181.23.83.92])
        by smtp.gmail.com with ESMTPSA id s20sm16132210qtc.75.2021.12.20.13.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:31:20 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: [PATCH 2/4] staging: vc04_services: avoid the use of typedef for function pointers
Date:   Mon, 20 Dec 2021 18:29:12 -0300
Message-Id: <7f681ccee713ef8600f40c765b6a59e119c6bf2c.1639858361.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639858361.git.gascoar@gmail.com>
References: <cover.1639858361.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace typedef bm2835_mmal_v4l2_ctrl_cb with equivalent declaration to
better align with the linux kernel coding style.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/bcm2835-camera/controls.c   | 76 +++++++++----------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
index b096a12387f7..7782742396fc 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
@@ -65,13 +65,6 @@ enum bm2835_mmal_ctrl_type {
 	MMAL_CONTROL_TYPE_CLUSTER, /* special cluster entry */
 };
 
-struct bm2835_mmal_v4l2_ctrl;
-
-typedef	int(bm2835_mmal_v4l2_ctrl_cb)(
-				struct bm2835_mmal_dev *dev,
-				struct v4l2_ctrl *ctrl,
-				const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl);
-
 struct bm2835_mmal_v4l2_ctrl {
 	u32 id; /* v4l2 control identifier */
 	enum bm2835_mmal_ctrl_type type;
@@ -84,7 +77,8 @@ struct bm2835_mmal_v4l2_ctrl {
 	u64 step; /* step size of the control */
 	const s64 *imenu; /* integer menu array */
 	u32 mmal_id; /* mmal parameter id */
-	bm2835_mmal_v4l2_ctrl_cb *setter;
+	int (*bm2835_mmal_v4l2_ctrl_cb)(struct bm2835_mmal_dev *dev, struct v4l2_ctrl *ctrl,
+					const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl);
 };
 
 struct v4l2_to_mmal_effects_setting {
@@ -898,12 +892,12 @@ static int bm2835_mmal_s_ctrl(struct v4l2_ctrl *ctrl)
 	const struct bm2835_mmal_v4l2_ctrl *mmal_ctrl = ctrl->priv;
 	int ret;
 
-	if (!mmal_ctrl || mmal_ctrl->id != ctrl->id || !mmal_ctrl->setter) {
+	if (!mmal_ctrl || mmal_ctrl->id != ctrl->id || !mmal_ctrl->bm2835_mmal_v4l2_ctrl_cb) {
 		pr_warn("mmal_ctrl:%p ctrl id:%d\n", mmal_ctrl, ctrl->id);
 		return -EINVAL;
 	}
 
-	ret = mmal_ctrl->setter(dev, ctrl, mmal_ctrl);
+	ret = mmal_ctrl->bm2835_mmal_v4l2_ctrl_cb(dev, ctrl, mmal_ctrl);
 	if (ret)
 		pr_warn("ctrl id:%d/MMAL param %08X- returned ret %d\n",
 			ctrl->id, mmal_ctrl->mmal_id, ret);
@@ -924,7 +918,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_SATURATION,
-		.setter = ctrl_set_rational,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_rational,
 	},
 	{
 		.id = V4L2_CID_SHARPNESS,
@@ -935,7 +929,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_SHARPNESS,
-		.setter = ctrl_set_rational,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_rational,
 	},
 	{
 		.id = V4L2_CID_CONTRAST,
@@ -946,7 +940,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_CONTRAST,
-		.setter = ctrl_set_rational,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_rational,
 	},
 	{
 		.id = V4L2_CID_BRIGHTNESS,
@@ -957,7 +951,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_BRIGHTNESS,
-		.setter = ctrl_set_rational,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_rational,
 	},
 	{
 		.id = V4L2_CID_ISO_SENSITIVITY,
@@ -968,7 +962,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = iso_qmenu,
 		.mmal_id = MMAL_PARAMETER_ISO,
-		.setter = ctrl_set_iso,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_iso,
 	},
 	{
 		.id = V4L2_CID_ISO_SENSITIVITY_AUTO,
@@ -979,7 +973,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_ISO,
-		.setter = ctrl_set_iso,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_iso,
 	},
 	{
 		.id = V4L2_CID_IMAGE_STABILIZATION,
@@ -990,7 +984,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_VIDEO_STABILISATION,
-		.setter = ctrl_set_value,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_value,
 	},
 	{
 		.id = V4L2_CID_EXPOSURE_AUTO,
@@ -1001,7 +995,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 0,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_EXPOSURE_MODE,
-		.setter = ctrl_set_exposure,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_exposure,
 	},
 	{
 		.id = V4L2_CID_EXPOSURE_ABSOLUTE,
@@ -1013,7 +1007,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_SHUTTER_SPEED,
-		.setter = ctrl_set_exposure,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_exposure,
 	},
 	{
 		.id = V4L2_CID_AUTO_EXPOSURE_BIAS,
@@ -1024,7 +1018,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 0,
 		.imenu = ev_bias_qmenu,
 		.mmal_id = MMAL_PARAMETER_EXPOSURE_COMP,
-		.setter = ctrl_set_value_ev,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_value_ev,
 	},
 	{
 		.id = V4L2_CID_EXPOSURE_AUTO_PRIORITY,
@@ -1036,7 +1030,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.imenu = NULL,
 		/* Dummy MMAL ID as it gets mapped into FPS range */
 		.mmal_id = 0,
-		.setter = ctrl_set_exposure,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_exposure,
 	},
 	{
 		.id = V4L2_CID_EXPOSURE_METERING,
@@ -1047,7 +1041,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 0,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_EXP_METERING_MODE,
-		.setter = ctrl_set_metering_mode,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_metering_mode,
 	},
 	{
 		.id = V4L2_CID_AUTO_N_PRESET_WHITE_BALANCE,
@@ -1058,7 +1052,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 0,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_AWB_MODE,
-		.setter = ctrl_set_awb_mode,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_awb_mode,
 	},
 	{
 		.id = V4L2_CID_RED_BALANCE,
@@ -1069,7 +1063,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_CUSTOM_AWB_GAINS,
-		.setter = ctrl_set_awb_gains,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_awb_gains,
 	},
 	{
 		.id = V4L2_CID_BLUE_BALANCE,
@@ -1080,7 +1074,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_CUSTOM_AWB_GAINS,
-		.setter = ctrl_set_awb_gains,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_awb_gains,
 	},
 	{
 		.id = V4L2_CID_COLORFX,
@@ -1091,7 +1085,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 0,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_IMAGE_EFFECT,
-		.setter = ctrl_set_image_effect,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_image_effect,
 	},
 	{
 		.id = V4L2_CID_COLORFX_CBCR,
@@ -1102,7 +1096,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_COLOUR_EFFECT,
-		.setter = ctrl_set_colfx,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_colfx,
 	},
 	{
 		.id = V4L2_CID_ROTATE,
@@ -1113,7 +1107,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 90,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_ROTATION,
-		.setter = ctrl_set_rotate,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_rotate,
 	},
 	{
 		.id = V4L2_CID_HFLIP,
@@ -1124,7 +1118,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_MIRROR,
-		.setter = ctrl_set_flip,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_flip,
 	},
 	{
 		.id = V4L2_CID_VFLIP,
@@ -1135,7 +1129,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_MIRROR,
-		.setter = ctrl_set_flip,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_flip,
 	},
 	{
 		.id = V4L2_CID_MPEG_VIDEO_BITRATE_MODE,
@@ -1146,7 +1140,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 0,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_RATECONTROL,
-		.setter = ctrl_set_bitrate_mode,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_bitrate_mode,
 	},
 	{
 		.id = V4L2_CID_MPEG_VIDEO_BITRATE,
@@ -1157,7 +1151,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 25 * 1000,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_VIDEO_BIT_RATE,
-		.setter = ctrl_set_bitrate,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_bitrate,
 	},
 	{
 		.id = V4L2_CID_JPEG_COMPRESSION_QUALITY,
@@ -1168,7 +1162,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_JPEG_Q_FACTOR,
-		.setter = ctrl_set_image_encode_output,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_image_encode_output,
 	},
 	{
 		.id = V4L2_CID_POWER_LINE_FREQUENCY,
@@ -1179,7 +1173,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_FLICKER_AVOID,
-		.setter = ctrl_set_flicker_avoidance,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_flicker_avoidance,
 	},
 	{
 		.id = V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER,
@@ -1190,7 +1184,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_VIDEO_ENCODE_INLINE_HEADER,
-		.setter = ctrl_set_video_encode_param_output,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_video_encode_param_output,
 	},
 	{
 		.id = V4L2_CID_MPEG_VIDEO_H264_PROFILE,
@@ -1204,7 +1198,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_PROFILE,
-		.setter = ctrl_set_video_encode_profile_level,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_video_encode_profile_level,
 	},
 	{
 		.id = V4L2_CID_MPEG_VIDEO_H264_LEVEL,
@@ -1226,7 +1220,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_PROFILE,
-		.setter = ctrl_set_video_encode_profile_level,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_video_encode_profile_level,
 	},
 	{
 		.id = V4L2_CID_SCENE_MODE,
@@ -1238,7 +1232,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_PROFILE,
-		.setter = ctrl_set_scene_mode,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_scene_mode,
 	},
 	{
 		.id = V4L2_CID_MPEG_VIDEO_H264_I_PERIOD,
@@ -1249,7 +1243,7 @@ static const struct bm2835_mmal_v4l2_ctrl v4l2_ctrls[V4L2_CTRL_COUNT] = {
 		.step = 1,
 		.imenu = NULL,
 		.mmal_id = MMAL_PARAMETER_INTRAPERIOD,
-		.setter = ctrl_set_video_encode_param_output,
+		.bm2835_mmal_v4l2_ctrl_cb = ctrl_set_video_encode_param_output,
 	},
 };
 
@@ -1259,8 +1253,8 @@ int bm2835_mmal_set_all_camera_controls(struct bm2835_mmal_dev *dev)
 	int ret = 0;
 
 	for (c = 0; c < V4L2_CTRL_COUNT; c++) {
-		if ((dev->ctrls[c]) && (v4l2_ctrls[c].setter)) {
-			ret = v4l2_ctrls[c].setter(dev, dev->ctrls[c],
+		if ((dev->ctrls[c]) && (v4l2_ctrls[c].bm2835_mmal_v4l2_ctrl_cb)) {
+			ret = v4l2_ctrls[c].bm2835_mmal_v4l2_ctrl_cb(dev, dev->ctrls[c],
 						   &v4l2_ctrls[c]);
 			if (ret) {
 				v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
-- 
2.34.1

