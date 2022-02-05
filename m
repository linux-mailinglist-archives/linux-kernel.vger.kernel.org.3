Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80004AABB0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381831AbiBES5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:57:35 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:42319 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381439AbiBESzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:46 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B576824000C;
        Sat,  5 Feb 2022 18:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1scdHc6tq5fphoNpmwGzAjfF/vxtSqOqbNge2zy7mc=;
        b=V3eSA5pgLZt5N1g6tJXTrawdx1vbSQhmic8LSYxe/ba0chaRWcXtg0JtORefnuKLZkMgyG
        90SRNnC7EmBbJ1vJAmN0ddcLZwuGNaK1ktoZtMxAmpITufhMCdzNdiz9m5p4nazMk4QjVC
        wfuh9oy+G21ck8tHEGwCJlYko755ngxF5rnkPYG2sSR3pKFDnJyO9tG/Ln9EF6n71htWJ0
        oTzeMOWYlW1mavwIR643xTlY4tdlCCUHkO5NJwQ0qbX8RXv1zCjMpg+PjTfyqOKw2bVUte
        l8pRK1AGud+PsX5h0//zKpkmwNcCh1ks+6HhkT9mt4+9yONjQ1ZLwh+0qvoAsA==
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
Subject: [PATCH v2 37/66] media: sun6i-csi: Move power management to runtime pm in capture
Date:   Sat,  5 Feb 2022 19:54:00 +0100
Message-Id: <20220205185429.2278860-38-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's just enable the module when we start using it (at stream on)
and benefit from runtime pm instead of enabling it at first open.

Also reorder the call to v4l2_pipeline_pm_get.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 24 -----------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  7 ----
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 41 ++++++++++---------
 3 files changed, 22 insertions(+), 50 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 22779baf8c09..7e3727c86e7a 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -148,30 +148,6 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 	return false;
 }
 
-int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
-{
-	struct device *dev = csi_dev->dev;
-	struct regmap *regmap = csi_dev->regmap;
-	int ret;
-
-	if (!enable) {
-		regmap_update_bits(regmap, SUN6I_CSI_EN_REG,
-				   SUN6I_CSI_EN_CSI_EN, 0);
-		pm_runtime_put(dev);
-
-		return 0;
-	}
-
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
-		return ret;
-
-	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN,
-			   SUN6I_CSI_EN_CSI_EN);
-
-	return 0;
-}
-
 static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device *csi_dev,
 					       u32 mbus_code, u32 pixformat)
 {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 1f235b8e240c..0271587e8520 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -74,13 +74,6 @@ struct sun6i_csi_device {
 bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 				   u32 pixformat, u32 mbus_code);
 
-/**
- * sun6i_csi_set_power() - power on/off the csi
- * @csi:	pointer to the csi
- * @enable:	on/off
- */
-int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable);
-
 /**
  * sun6i_csi_update_config() - update the csi register settings
  * @csi:	pointer to the csi
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index ab6e298864ed..05eb9aae2975 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <media/v4l2-device.h>
@@ -141,6 +142,9 @@ static void sun6i_csi_capture_enable(struct sun6i_csi_device *csi_dev)
 {
 	struct regmap *regmap = csi_dev->regmap;
 
+	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN,
+			   SUN6I_CSI_EN_CSI_EN);
+
 	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON,
 			   SUN6I_CSI_CAP_VCAP_ON);
 }
@@ -150,6 +154,7 @@ static void sun6i_csi_capture_disable(struct sun6i_csi_device *csi_dev)
 	struct regmap *regmap = csi_dev->regmap;
 
 	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON, 0);
+	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN, 0);
 }
 
 static void
@@ -382,6 +387,7 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct sun6i_csi_capture_state *state = &capture->state;
 	struct video_device *video_dev = &capture->video_dev;
+	struct device *dev = csi_dev->dev;
 	struct v4l2_subdev *subdev;
 	int ret;
 
@@ -402,6 +408,12 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 		goto error_media_pipeline;
 	}
 
+	/* PM */
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		goto error_media_pipeline;
+
 	/* Clear */
 
 	sun6i_csi_capture_irq_clear(csi_dev);
@@ -429,6 +441,8 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	sun6i_csi_capture_disable(csi_dev);
 	sun6i_csi_capture_irq_disable(csi_dev);
 
+	pm_runtime_put(dev);
+
 error_media_pipeline:
 	media_pipeline_stop(&video_dev->entity);
 
@@ -442,6 +456,7 @@ static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	struct device *dev = csi_dev->dev;
 	struct v4l2_subdev *subdev;
 
 	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
@@ -451,6 +466,8 @@ static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 	sun6i_csi_capture_disable(csi_dev);
 	sun6i_csi_capture_irq_disable(csi_dev);
 
+	pm_runtime_put(dev);
+
 	media_pipeline_stop(&capture->video_dev.entity);
 
 	sun6i_csi_capture_state_cleanup(csi_dev, true);
@@ -635,27 +652,20 @@ static int sun6i_csi_capture_open(struct file *file)
 	if (mutex_lock_interruptible(&capture->lock))
 		return -ERESTARTSYS;
 
-	ret = v4l2_fh_open(file);
+	ret = v4l2_pipeline_pm_get(&capture->video_dev.entity);
 	if (ret < 0)
 		goto error_lock;
 
-	ret = v4l2_pipeline_pm_get(&capture->video_dev.entity);
+	ret = v4l2_fh_open(file);
 	if (ret < 0)
-		goto error_v4l2_fh;
-
-	/* Power on at first open. */
-	if (v4l2_fh_is_singular_file(file)) {
-		ret = sun6i_csi_set_power(csi_dev, true);
-		if (ret < 0)
-			goto error_v4l2_fh;
-	}
+		goto error_pipeline;
 
 	mutex_unlock(&capture->lock);
 
 	return 0;
 
-error_v4l2_fh:
-	v4l2_fh_release(file);
+error_pipeline:
+	v4l2_pipeline_pm_put(&capture->video_dev.entity);
 
 error_lock:
 	mutex_unlock(&capture->lock);
@@ -667,19 +677,12 @@ static int sun6i_csi_capture_close(struct file *file)
 {
 	struct sun6i_csi_device *csi_dev = video_drvdata(file);
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	bool last_close;
 
 	mutex_lock(&capture->lock);
 
-	last_close = v4l2_fh_is_singular_file(file);
-
 	_vb2_fop_release(file, NULL);
 	v4l2_pipeline_pm_put(&capture->video_dev.entity);
 
-	/* Power off at last close. */
-	if (last_close)
-		sun6i_csi_set_power(csi_dev, false);
-
 	mutex_unlock(&capture->lock);
 
 	return 0;
-- 
2.34.1

