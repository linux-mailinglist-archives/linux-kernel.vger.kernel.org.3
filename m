Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5604AABE8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381979AbiBES62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:58:28 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:58575 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381579AbiBES4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:21 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 957E924001C;
        Sat,  5 Feb 2022 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5luBjbgwR8xInbAp7xEaH/avHqpBe9Vj+954q16ysFc=;
        b=edS+gwjAQrsobEVDamVq3zkxOhSV3VQ2nQgvsSLEPvKYIohO0ZYUzc+W9Jfq5Tbr/lhomG
        GWF/17rIpxAmOaWnNQ3Zy1avemgpZWdv8a4SC7NCZryBIx6qbe3CZb0Kcr6nRFEf4j60zE
        z0kCePiVG6k/Gl66Lw4d4da/aaQNSvHWdNqVP3thKt60iggZUhXZ7E4RDMMuxxR7Rf4HyZ
        51QcIncC5VwVGEU+//zx8IfEiRglQJzqjab3Y3LOt/lGnUGY1QJyRe/MjSfUYRL+3Spdo3
        4/2hKf2nsYmG9mvlttQnf1h+y0wAEVWLvGy96zjrGQJyQooQvZZXbGw1r4IPqw==
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
Subject: [PATCH v2 59/66] media: sun6i-csi: Add support for hooking to the isp devices
Date:   Sat,  5 Feb 2022 19:54:22 +0100
Message-Id: <20220205185429.2278860-60-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use the isp and csi together, both devices need to be
parented to the same v4l2 and media devices. We use the isp as
top-level device and let the csi code hook to its v4l2 and media
devices when async subdev registration takes place.

As a result v4l2/media device setup is only called when the ISP
is missing and the capture device is registered after the devices
are hooked. The bridge subdev and its notifier are registered
without any device when the ISP is available. Top-level pointers
for the devices are introduced to either redirect to the hooked ones
(isp available) or the registered ones (isp missing).

Also keep track of whether the capture node was setup or not to
avoid cleaning up resources when it wasn't.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 55 ++++++++++++++-----
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  7 +++
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 31 +++++++++--
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 19 ++++++-
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  1 +
 5 files changed, 93 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 70b2a8b95b40..0c635b446fba 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -26,6 +26,18 @@
 
 /* ISP */
 
+int sun6i_csi_isp_complete(struct sun6i_csi_device *csi_dev,
+			   struct v4l2_device *v4l2_dev)
+{
+	if (csi_dev->v4l2_dev && csi_dev->v4l2_dev != v4l2_dev)
+		return -EINVAL;
+
+	csi_dev->v4l2_dev = v4l2_dev;
+	csi_dev->media_dev = v4l2_dev->mdev;
+
+	return sun6i_csi_capture_setup(csi_dev);
+}
+
 static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_dev)
 {
 	struct device *dev = csi_dev->dev;
@@ -64,8 +76,17 @@ static const struct media_device_ops sun6i_csi_media_ops = {
 int sun6i_csi_v4l2_complete(struct sun6i_csi_device *csi_dev)
 {
 	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	int ret;
+
+	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
+	if (ret)
+		return ret;
 
-	return v4l2_device_register_subdev_nodes(v4l2_dev);
+	ret = sun6i_csi_capture_setup(csi_dev);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
@@ -113,6 +134,9 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 		goto error_v4l2_ctrl;
 	}
 
+	csi_dev->v4l2_dev = v4l2_dev;
+	csi_dev->media_dev = media_dev;
+
 	return 0;
 
 error_v4l2_ctrl:
@@ -361,25 +385,27 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
 	if (ret)
 		goto error_resources;
 
-	ret = sun6i_csi_v4l2_setup(csi_dev);
-	if (ret)
-		goto error_resources;
+	/*
+	 * Register our own v4l2 and media devices when there is no ISP around.
+	 * Otherwise the ISP will use async subdev registration with our bridge,
+	 * which will provide v4l2 and media devices that are used to register
+	 * the video interface.
+	 */
+	if (!csi_dev->isp_available) {
+		ret = sun6i_csi_v4l2_setup(csi_dev);
+		if (ret)
+			goto error_resources;
+	}
 
 	ret = sun6i_csi_bridge_setup(csi_dev);
 	if (ret)
 		goto error_v4l2;
 
-	ret = sun6i_csi_capture_setup(csi_dev);
-	if (ret)
-		goto error_bridge;
-
 	return 0;
 
-error_bridge:
-	sun6i_csi_bridge_cleanup(csi_dev);
-
 error_v4l2:
-	sun6i_csi_v4l2_cleanup(csi_dev);
+	if (!csi_dev->isp_available)
+		sun6i_csi_v4l2_cleanup(csi_dev);
 
 error_resources:
 	sun6i_csi_resources_cleanup(csi_dev);
@@ -393,7 +419,10 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 
 	sun6i_csi_capture_cleanup(csi_dev);
 	sun6i_csi_bridge_cleanup(csi_dev);
-	sun6i_csi_v4l2_cleanup(csi_dev);
+
+	if (!csi_dev->isp_available)
+		sun6i_csi_v4l2_cleanup(csi_dev);
+
 	sun6i_csi_resources_cleanup(csi_dev);
 
 	return 0;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 6cdaf98dc295..6f1ea2c55ecd 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -38,6 +38,8 @@ struct sun6i_csi_v4l2 {
 
 struct sun6i_csi_device {
 	struct device			*dev;
+	struct v4l2_device		*v4l2_dev;
+	struct media_device		*media_dev;
 
 	struct sun6i_csi_v4l2		v4l2;
 	struct sun6i_csi_bridge		bridge;
@@ -52,6 +54,11 @@ struct sun6i_csi_device {
 	bool				isp_available;
 };
 
+/* ISP */
+
+int sun6i_csi_isp_complete(struct sun6i_csi_device *csi_dev,
+			   struct v4l2_device *v4l2_dev);
+
 /* V4L2 */
 
 int sun6i_csi_v4l2_complete(struct sun6i_csi_device *csi_dev);
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index 9827486dc3cb..55a632c814b2 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -692,6 +692,16 @@ sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
 
 	source->subdev = remote_subdev;
 
+	if (csi_dev->isp_available) {
+		/*
+		 * Hook to the first available remote subdev to get v4l2 and
+		 * media devices and register the capture device then.
+		 */
+		ret = sun6i_csi_isp_complete(csi_dev, remote_subdev->v4l2_dev);
+		if (ret)
+			return ret;
+	}
+
 	return sun6i_csi_bridge_link(csi_dev, SUN6I_CSI_BRIDGE_PAD_SINK,
 				     remote_subdev, enabled);
 }
@@ -703,6 +713,9 @@ sun6i_csi_bridge_notifier_complete(struct v4l2_async_notifier *notifier)
 		container_of(notifier, struct sun6i_csi_device,
 			     bridge.notifier);
 
+	if (csi_dev->isp_available)
+		return 0;
+
 	return sun6i_csi_v4l2_complete(csi_dev);
 }
 
@@ -772,7 +785,7 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
 {
 	struct device *dev = csi_dev->dev;
 	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
-	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
 	struct v4l2_subdev *subdev = &bridge->subdev;
 	struct v4l2_async_notifier *notifier = &bridge->notifier;
 	struct media_pad *pads = bridge->pads;
@@ -811,7 +824,11 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
 
 	/* V4L2 Subdev */
 
-	ret = v4l2_device_register_subdev(v4l2_dev, subdev);
+	if (csi_dev->isp_available)
+		ret = v4l2_async_register_subdev(subdev);
+	else
+		ret = v4l2_device_register_subdev(v4l2_dev, subdev);
+
 	if (ret) {
 		dev_err(dev, "failed to register v4l2 subdev: %d\n", ret);
 		goto error_media_entity;
@@ -828,7 +845,10 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
 	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_mipi_csi2,
 				      SUN6I_CSI_PORT_MIPI_CSI2, NULL);
 
-	ret = v4l2_async_nf_register(v4l2_dev, notifier);
+	if (csi_dev->isp_available)
+		ret = v4l2_async_subdev_nf_register(subdev, notifier);
+	else
+		ret = v4l2_async_nf_register(v4l2_dev, notifier);
 	if (ret) {
 		dev_err(dev, "failed to register v4l2 async notifier: %d\n",
 			ret);
@@ -840,7 +860,10 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
 error_v4l2_async_notifier:
 	v4l2_async_nf_cleanup(notifier);
 
-	v4l2_device_unregister_subdev(subdev);
+	if (csi_dev->isp_available)
+		v4l2_async_unregister_subdev(subdev);
+	else
+		v4l2_device_unregister_subdev(subdev);
 
 error_media_entity:
 	media_entity_cleanup(&subdev->entity);
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index f6dac15af675..2ad38277633f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -570,7 +570,7 @@ static int sun6i_csi_capture_buffer_prepare(struct vb2_buffer *buffer)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(buffer->vb2_queue);
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
 	struct vb2_v4l2_buffer *v4l2_buffer = to_vb2_v4l2_buffer(buffer);
 	unsigned long size = capture->format.fmt.pix.sizeimage;
 
@@ -886,7 +886,7 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
 	struct video_device *video_dev =
 		media_entity_to_video_device(link->sink->entity);
 	struct sun6i_csi_device *csi_dev = video_get_drvdata(video_dev);
-	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
 	const struct sun6i_csi_capture_format *capture_format;
 	const struct sun6i_csi_bridge_format *bridge_format;
 	unsigned int capture_width, capture_height;
@@ -968,7 +968,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 {
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct sun6i_csi_capture_state *state = &capture->state;
-	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	struct v4l2_device *v4l2_dev = csi_dev->v4l2_dev;
 	struct v4l2_subdev *bridge_subdev = &csi_dev->bridge.subdev;
 	struct video_device *video_dev = &capture->video_dev;
 	struct vb2_queue *queue = &capture->queue;
@@ -977,6 +977,10 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	struct v4l2_pix_format *pix_format = &format->fmt.pix;
 	int ret;
 
+	/* This may happen with multiple bridge notifier bound calls. */
+	if (state->setup)
+		return 0;
+
 	/* State */
 
 	INIT_LIST_HEAD(&state->queue);
@@ -1055,6 +1059,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	ret = media_create_pad_link(&bridge_subdev->entity,
 				    SUN6I_CSI_BRIDGE_PAD_SOURCE,
 				    &video_dev->entity, 0,
+				    csi_dev->isp_available ? 0 :
 				    MEDIA_LNK_FL_ENABLED |
 				    MEDIA_LNK_FL_IMMUTABLE);
 	if (ret < 0) {
@@ -1065,6 +1070,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 		goto error_video_device;
 	}
 
+	state->setup = true;
+
 	return 0;
 
 error_video_device:
@@ -1083,7 +1090,13 @@ void sun6i_csi_capture_cleanup(struct sun6i_csi_device *csi_dev)
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct video_device *video_dev = &capture->video_dev;
 
+	/* This may happen if async registration failed to complete. */
+	if (!capture->state.setup)
+		return;
+
 	vb2_video_unregister_device(video_dev);
 	media_entity_cleanup(&video_dev->entity);
 	mutex_destroy(&capture->lock);
+
+	capture->state.setup = false;
 }
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 29893cf96f6b..3ee5ccefbd10 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -45,6 +45,7 @@ struct sun6i_csi_capture_state {
 
 	unsigned int			sequence;
 	bool				streaming;
+	bool				setup;
 };
 
 struct sun6i_csi_capture {
-- 
2.34.1

