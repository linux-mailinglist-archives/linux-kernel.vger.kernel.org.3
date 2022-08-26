Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941405A2EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbiHZSen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbiHZSdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:42 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B9AE3C21;
        Fri, 26 Aug 2022 11:33:26 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 52696FF802;
        Fri, 26 Aug 2022 18:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nimesFwyzMekfHF4EkDY/hTvsLBuQj3j/ek9fQvhl8Q=;
        b=bBHzoXqBrADA4NC9A4n0nQ5gypgXRNDP1tY7SzMV8drucSNfB2TfFiOGtyzNuL1wDdtlHi
        uQunLIbjeDJ/cOCTSrlPY7o9gjiip9zk0/9MMNqfD/knyFJmmgu93JDXz639swIRr4zaE7
        A/RyeSZCFdUTohBG1NW+uC0KgKFVgcvnmHZMyYYnO0UFett6rz/7SeYmc864SsnvR0AfAR
        sXGtkS+jZlvJWBPZXH2An8SoQFIs3jXyyP9Bc9my1312IUDI+59dYWZ1Moh+cb4TyKlKwq
        ILuMWl2mKV+WddHcZEDZbB9gDk7SiuoVFLULmsNiP2wDfPSZMaTj3y6qx1t3tA==
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
Subject: [PATCH v6 16/43] media: sun6i-csi: Add bridge v4l2 subdev with port management
Date:   Fri, 26 Aug 2022 20:32:13 +0200
Message-Id: <20220826183240.604834-17-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a bridge v4l2 subdev to prepare for separation between the
processing part (bridge) and the dma engine, which is required to
properly support ths isp workflow later on.

Currently the bridge just manages fwnode mapping to media pads,
using an async notifier (which was previously in the main code).
The s_stream video op just forwards to the connected v4l2 subdev
(sensor or MIPI CSI-2 bridge).

The video capture device is now registered after the bridge and
attaches to it with a media link.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../media/platform/sunxi/sun6i-csi/Makefile   |   2 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 157 +-----
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  10 +-
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 450 ++++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  49 ++
 .../platform/sunxi/sun6i-csi/sun6i_video.c    |  19 +
 6 files changed, 548 insertions(+), 139 deletions(-)
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h

diff --git a/drivers/media/platform/sunxi/sun6i-csi/Makefile b/drivers/media/platform/sunxi/sun6i-csi/Makefile
index e7e315347804..7a699580a641 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/Makefile
+++ b/drivers/media/platform/sunxi/sun6i-csi/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-sun6i-csi-y += sun6i_video.o sun6i_csi.o
+sun6i-csi-y += sun6i_video.o sun6i_csi.o sun6i_csi_bridge.o
 
 obj-$(CONFIG_VIDEO_SUN6I_CSI) += sun6i-csi.o
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 8b99c17e8403..49f1218b0b28 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -34,16 +34,17 @@
 bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 				   u32 pixformat, u32 mbus_code)
 {
-	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
+	struct v4l2_fwnode_endpoint *endpoint =
+		&csi_dev->bridge.source_parallel.endpoint;
 
 	/*
 	 * Some video receivers have the ability to be compatible with
 	 * 8bit and 16bit bus width.
 	 * Identify the media bus format from device tree.
 	 */
-	if ((v4l2->v4l2_ep.bus_type == V4L2_MBUS_PARALLEL
-	     || v4l2->v4l2_ep.bus_type == V4L2_MBUS_BT656)
-	     && v4l2->v4l2_ep.bus.parallel.bus_width == 16) {
+	if ((endpoint->bus_type == V4L2_MBUS_PARALLEL
+	     || endpoint->bus_type == V4L2_MBUS_BT656)
+	     && endpoint->bus.parallel.bus_width == 16) {
 		switch (pixformat) {
 		case V4L2_PIX_FMT_NV12_16L16:
 		case V4L2_PIX_FMT_NV12:
@@ -328,7 +329,8 @@ static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_device *csi_dev,
 
 static void sun6i_csi_setup_bus(struct sun6i_csi_device *csi_dev)
 {
-	struct v4l2_fwnode_endpoint *endpoint = &csi_dev->v4l2.v4l2_ep;
+	struct v4l2_fwnode_endpoint *endpoint =
+		&csi_dev->bridge.source_parallel.endpoint;
 	struct sun6i_csi_config *config = &csi_dev->config;
 	unsigned char bus_width;
 	u32 flags;
@@ -583,103 +585,11 @@ static const struct media_device_ops sun6i_csi_media_ops = {
 
 /* V4L2 */
 
-static int sun6i_csi_link_entity(struct sun6i_csi_device *csi_dev,
-				 struct media_entity *entity,
-				 struct fwnode_handle *fwnode)
-{
-	struct media_entity *sink;
-	struct media_pad *sink_pad;
-	int src_pad_index;
-	int ret;
-
-	ret = media_entity_get_fwnode_pad(entity, fwnode, MEDIA_PAD_FL_SOURCE);
-	if (ret < 0) {
-		dev_err(csi_dev->dev,
-			"%s: no source pad in external entity %s\n", __func__,
-			entity->name);
-		return -EINVAL;
-	}
-
-	src_pad_index = ret;
-
-	sink = &csi_dev->video.video_dev.entity;
-	sink_pad = &csi_dev->video.pad;
-
-	dev_dbg(csi_dev->dev, "creating %s:%u -> %s:%u link\n",
-		entity->name, src_pad_index, sink->name, sink_pad->index);
-	ret = media_create_pad_link(entity, src_pad_index, sink,
-				    sink_pad->index,
-				    MEDIA_LNK_FL_ENABLED |
-				    MEDIA_LNK_FL_IMMUTABLE);
-	if (ret < 0) {
-		dev_err(csi_dev->dev, "failed to create %s:%u -> %s:%u link\n",
-			entity->name, src_pad_index,
-			sink->name, sink_pad->index);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int sun6i_subdev_notify_complete(struct v4l2_async_notifier *notifier)
-{
-	struct sun6i_csi_device *csi_dev =
-		container_of(notifier, struct sun6i_csi_device,
-			     v4l2.notifier);
-	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
-	struct v4l2_device *v4l2_dev = &v4l2->v4l2_dev;
-	struct v4l2_subdev *sd;
-	int ret;
-
-	dev_dbg(csi_dev->dev, "notify complete, all subdevs registered\n");
-
-	sd = list_first_entry(&v4l2_dev->subdevs, struct v4l2_subdev, list);
-	if (!sd)
-		return -EINVAL;
-
-	ret = sun6i_csi_link_entity(csi_dev, &sd->entity, sd->fwnode);
-	if (ret < 0)
-		return ret;
-
-	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static const struct v4l2_async_notifier_operations sun6i_csi_async_ops = {
-	.complete = sun6i_subdev_notify_complete,
-};
-
-static int sun6i_csi_fwnode_parse(struct device *dev,
-				  struct v4l2_fwnode_endpoint *vep,
-				  struct v4l2_async_subdev *asd)
-{
-	struct sun6i_csi_device *csi_dev = dev_get_drvdata(dev);
-
-	if (vep->base.port || vep->base.id) {
-		dev_warn(dev, "Only support a single port with one endpoint\n");
-		return -ENOTCONN;
-	}
-
-	switch (vep->bus_type) {
-	case V4L2_MBUS_PARALLEL:
-	case V4L2_MBUS_BT656:
-		csi_dev->v4l2.v4l2_ep = *vep;
-		return 0;
-	default:
-		dev_err(dev, "Unsupported media bus type\n");
-		return -ENOTCONN;
-	}
-}
-
 static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 {
 	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
 	struct media_device *media_dev = &v4l2->media_dev;
 	struct v4l2_device *v4l2_dev = &v4l2->v4l2_dev;
-	struct v4l2_async_notifier *notifier = &v4l2->notifier;
 	struct device *dev = csi_dev->dev;
 	int ret;
 
@@ -709,42 +619,8 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 		goto error_media;
 	}
 
-	/* Video */
-
-	ret = sun6i_video_setup(csi_dev);
-	if (ret)
-		goto error_v4l2_device;
-
-	/* V4L2 Async */
-
-	v4l2_async_nf_init(notifier);
-	notifier->ops = &sun6i_csi_async_ops;
-
-	ret = v4l2_async_nf_parse_fwnode_endpoints(dev, notifier,
-						   sizeof(struct
-							  v4l2_async_subdev),
-						   sun6i_csi_fwnode_parse);
-	if (ret)
-		goto error_video;
-
-	ret = v4l2_async_nf_register(v4l2_dev, notifier);
-	if (ret) {
-		dev_err(dev, "failed to register v4l2 async notifier: %d\n",
-			ret);
-		goto error_v4l2_async_notifier;
-	}
-
 	return 0;
 
-error_v4l2_async_notifier:
-	v4l2_async_nf_cleanup(notifier);
-
-error_video:
-	sun6i_video_cleanup(csi_dev);
-
-error_v4l2_device:
-	v4l2_device_unregister(&v4l2->v4l2_dev);
-
 error_media:
 	media_device_unregister(media_dev);
 	media_device_cleanup(media_dev);
@@ -757,9 +633,6 @@ static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
 	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
 
 	media_device_unregister(&v4l2->media_dev);
-	v4l2_async_nf_unregister(&v4l2->notifier);
-	v4l2_async_nf_cleanup(&v4l2->notifier);
-	sun6i_video_cleanup(csi_dev);
 	v4l2_device_unregister(&v4l2->v4l2_dev);
 	media_device_cleanup(&v4l2->media_dev);
 }
@@ -964,8 +837,22 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
 	if (ret)
 		goto error_resources;
 
+	ret = sun6i_csi_bridge_setup(csi_dev);
+	if (ret)
+		goto error_v4l2;
+
+	ret = sun6i_video_setup(csi_dev);
+	if (ret)
+		goto error_bridge;
+
 	return 0;
 
+error_bridge:
+	sun6i_csi_bridge_cleanup(csi_dev);
+
+error_v4l2:
+	sun6i_csi_v4l2_cleanup(csi_dev);
+
 error_resources:
 	sun6i_csi_resources_cleanup(csi_dev);
 
@@ -976,6 +863,8 @@ static int sun6i_csi_remove(struct platform_device *pdev)
 {
 	struct sun6i_csi_device *csi_dev = platform_get_drvdata(pdev);
 
+	sun6i_video_cleanup(csi_dev);
+	sun6i_csi_bridge_cleanup(csi_dev);
 	sun6i_csi_v4l2_cleanup(csi_dev);
 	sun6i_csi_resources_cleanup(csi_dev);
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 3c72d865a01a..af3f48a32d5b 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -12,11 +12,16 @@
 #include <media/v4l2-fwnode.h>
 #include <media/videobuf2-v4l2.h>
 
+#include "sun6i_csi_bridge.h"
 #include "sun6i_video.h"
 
 #define SUN6I_CSI_NAME		"sun6i-csi"
 #define SUN6I_CSI_DESCRIPTION	"Allwinner A31 CSI Device"
 
+enum sun6i_csi_port {
+	SUN6I_CSI_PORT_PARALLEL		= 0,
+};
+
 struct sun6i_csi_buffer {
 	struct vb2_v4l2_buffer		v4l2_buffer;
 	struct list_head		list;
@@ -44,10 +49,6 @@ struct sun6i_csi_config {
 struct sun6i_csi_v4l2 {
 	struct v4l2_device		v4l2_dev;
 	struct media_device		media_dev;
-
-	struct v4l2_async_notifier	notifier;
-	/* video port settings */
-	struct v4l2_fwnode_endpoint	v4l2_ep;
 };
 
 struct sun6i_csi_device {
@@ -55,6 +56,7 @@ struct sun6i_csi_device {
 
 	struct sun6i_csi_config		config;
 	struct sun6i_csi_v4l2		v4l2;
+	struct sun6i_csi_bridge		bridge;
 	struct sun6i_video		video;
 
 	struct regmap			*regmap;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
new file mode 100644
index 000000000000..cac1b150e544
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
+
+#include "sun6i_csi.h"
+#include "sun6i_csi_bridge.h"
+
+/* Format */
+
+static const u32 sun6i_csi_bridge_mbus_codes[] = {
+	/* Bayer */
+	MEDIA_BUS_FMT_SBGGR8_1X8,
+	MEDIA_BUS_FMT_SGBRG8_1X8,
+	MEDIA_BUS_FMT_SGRBG8_1X8,
+	MEDIA_BUS_FMT_SRGGB8_1X8,
+	MEDIA_BUS_FMT_SBGGR10_1X10,
+	MEDIA_BUS_FMT_SGBRG10_1X10,
+	MEDIA_BUS_FMT_SGRBG10_1X10,
+	MEDIA_BUS_FMT_SRGGB10_1X10,
+	MEDIA_BUS_FMT_SBGGR12_1X12,
+	MEDIA_BUS_FMT_SGBRG12_1X12,
+	MEDIA_BUS_FMT_SGRBG12_1X12,
+	MEDIA_BUS_FMT_SRGGB12_1X12,
+	/* RGB */
+	MEDIA_BUS_FMT_RGB565_2X8_LE,
+	MEDIA_BUS_FMT_RGB565_2X8_BE,
+	/* YUV422 */
+	MEDIA_BUS_FMT_YUYV8_2X8,
+	MEDIA_BUS_FMT_UYVY8_2X8,
+	MEDIA_BUS_FMT_YVYU8_2X8,
+	MEDIA_BUS_FMT_UYVY8_2X8,
+	MEDIA_BUS_FMT_VYUY8_2X8,
+	MEDIA_BUS_FMT_YUYV8_1X16,
+	MEDIA_BUS_FMT_UYVY8_1X16,
+	MEDIA_BUS_FMT_YVYU8_1X16,
+	MEDIA_BUS_FMT_UYVY8_1X16,
+	MEDIA_BUS_FMT_VYUY8_1X16,
+	/* Compressed */
+	MEDIA_BUS_FMT_JPEG_1X8,
+};
+
+static bool sun6i_csi_bridge_mbus_code_check(u32 mbus_code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun6i_csi_bridge_mbus_codes); i++)
+		if (sun6i_csi_bridge_mbus_codes[i] == mbus_code)
+			return true;
+
+	return false;
+}
+
+/* V4L2 Subdev */
+
+static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
+{
+	struct sun6i_csi_device *csi_dev = v4l2_get_subdevdata(subdev);
+	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
+	struct media_pad *local_pad = &bridge->pads[SUN6I_CSI_BRIDGE_PAD_SINK];
+	struct device *dev = csi_dev->dev;
+	struct v4l2_subdev *source_subdev;
+	struct media_pad *remote_pad;
+	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
+	int ret = 0;
+
+	/* Source */
+
+	remote_pad = media_pad_remote_pad_unique(local_pad);
+	if (IS_ERR(remote_pad)) {
+		dev_err(dev,
+			"zero or more than a single source connected to the bridge\n");
+		return PTR_ERR(remote_pad);
+	}
+
+	source_subdev = media_entity_to_v4l2_subdev(remote_pad->entity);
+
+	if (!on) {
+		v4l2_subdev_call(source_subdev, video, s_stream, 0);
+		goto disable;
+	}
+
+	ret = v4l2_subdev_call(source_subdev, video, s_stream, 1);
+	if (ret && ret != -ENOIOCTLCMD)
+		goto disable;
+
+	return 0;
+
+disable:
+
+	return ret;
+}
+
+static const struct v4l2_subdev_video_ops sun6i_csi_bridge_video_ops = {
+	.s_stream	= sun6i_csi_bridge_s_stream,
+};
+
+static void
+sun6i_csi_bridge_mbus_format_prepare(struct v4l2_mbus_framefmt *mbus_format)
+{
+	if (!sun6i_csi_bridge_mbus_code_check(mbus_format->code))
+		mbus_format->code = sun6i_csi_bridge_mbus_codes[0];
+
+	mbus_format->field = V4L2_FIELD_NONE;
+	mbus_format->colorspace = V4L2_COLORSPACE_RAW;
+	mbus_format->quantization = V4L2_QUANTIZATION_DEFAULT;
+	mbus_format->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+}
+
+static int sun6i_csi_bridge_init_cfg(struct v4l2_subdev *subdev,
+				     struct v4l2_subdev_state *state)
+{
+	struct sun6i_csi_device *csi_dev = v4l2_get_subdevdata(subdev);
+	unsigned int pad = SUN6I_CSI_BRIDGE_PAD_SINK;
+	struct v4l2_mbus_framefmt *mbus_format =
+		v4l2_subdev_get_try_format(subdev, state, pad);
+	struct mutex *lock = &csi_dev->bridge.lock;
+
+	mutex_lock(lock);
+
+	mbus_format->code = sun6i_csi_bridge_mbus_codes[0];
+	mbus_format->width = 1280;
+	mbus_format->height = 720;
+
+	sun6i_csi_bridge_mbus_format_prepare(mbus_format);
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static int
+sun6i_csi_bridge_enum_mbus_code(struct v4l2_subdev *subdev,
+				struct v4l2_subdev_state *state,
+				struct v4l2_subdev_mbus_code_enum *code_enum)
+{
+	if (code_enum->index >= ARRAY_SIZE(sun6i_csi_bridge_mbus_codes))
+		return -EINVAL;
+
+	code_enum->code = sun6i_csi_bridge_mbus_codes[code_enum->index];
+
+	return 0;
+}
+
+static int sun6i_csi_bridge_get_fmt(struct v4l2_subdev *subdev,
+				    struct v4l2_subdev_state *state,
+				    struct v4l2_subdev_format *format)
+{
+	struct sun6i_csi_device *csi_dev = v4l2_get_subdevdata(subdev);
+	struct v4l2_mbus_framefmt *mbus_format = &format->format;
+	struct mutex *lock = &csi_dev->bridge.lock;
+
+	mutex_lock(lock);
+
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
+		*mbus_format = *v4l2_subdev_get_try_format(subdev, state,
+							   format->pad);
+	else
+		*mbus_format = csi_dev->bridge.mbus_format;
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static int sun6i_csi_bridge_set_fmt(struct v4l2_subdev *subdev,
+				    struct v4l2_subdev_state *state,
+				    struct v4l2_subdev_format *format)
+{
+	struct sun6i_csi_device *csi_dev = v4l2_get_subdevdata(subdev);
+	struct v4l2_mbus_framefmt *mbus_format = &format->format;
+	struct mutex *lock = &csi_dev->bridge.lock;
+
+	mutex_lock(lock);
+
+	sun6i_csi_bridge_mbus_format_prepare(mbus_format);
+
+	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
+		*v4l2_subdev_get_try_format(subdev, state, format->pad) =
+			*mbus_format;
+	else
+		csi_dev->bridge.mbus_format = *mbus_format;
+
+	mutex_unlock(lock);
+
+	return 0;
+}
+
+static const struct v4l2_subdev_pad_ops sun6i_csi_bridge_pad_ops = {
+	.init_cfg	= sun6i_csi_bridge_init_cfg,
+	.enum_mbus_code	= sun6i_csi_bridge_enum_mbus_code,
+	.get_fmt	= sun6i_csi_bridge_get_fmt,
+	.set_fmt	= sun6i_csi_bridge_set_fmt,
+};
+
+const struct v4l2_subdev_ops sun6i_csi_bridge_subdev_ops = {
+	.video	= &sun6i_csi_bridge_video_ops,
+	.pad	= &sun6i_csi_bridge_pad_ops,
+};
+
+/* Media Entity */
+
+static const struct media_entity_operations sun6i_csi_bridge_entity_ops = {
+	.link_validate	= v4l2_subdev_link_validate,
+};
+
+/* V4L2 Async */
+
+static int sun6i_csi_bridge_link(struct sun6i_csi_device *csi_dev,
+				 int sink_pad_index,
+				 struct v4l2_subdev *remote_subdev,
+				 bool enabled)
+{
+	struct device *dev = csi_dev->dev;
+	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
+	struct media_entity *sink_entity = &subdev->entity;
+	struct media_entity *source_entity = &remote_subdev->entity;
+	int source_pad_index;
+	int ret;
+
+	/* Get the first remote source pad. */
+	ret = media_entity_get_fwnode_pad(source_entity, remote_subdev->fwnode,
+					  MEDIA_PAD_FL_SOURCE);
+	if (ret < 0) {
+		dev_err(dev, "missing source pad in external entity %s\n",
+			source_entity->name);
+		return -EINVAL;
+	}
+
+	source_pad_index = ret;
+
+	dev_dbg(dev, "creating %s:%u -> %s:%u link\n", source_entity->name,
+		source_pad_index, sink_entity->name, sink_pad_index);
+
+	ret = media_create_pad_link(source_entity, source_pad_index,
+				    sink_entity, sink_pad_index,
+				    enabled ? MEDIA_LNK_FL_ENABLED : 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to create %s:%u -> %s:%u link\n",
+			source_entity->name, source_pad_index,
+			sink_entity->name, sink_pad_index);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
+				struct v4l2_subdev *remote_subdev,
+				struct v4l2_async_subdev *async_subdev)
+{
+	struct sun6i_csi_device *csi_dev =
+		container_of(notifier, struct sun6i_csi_device,
+			     bridge.notifier);
+	struct sun6i_csi_bridge_async_subdev *bridge_async_subdev =
+		container_of(async_subdev, struct sun6i_csi_bridge_async_subdev,
+			     async_subdev);
+	struct sun6i_csi_bridge_source *source = bridge_async_subdev->source;
+	bool enabled;
+
+	switch (source->endpoint.base.port) {
+	case SUN6I_CSI_PORT_PARALLEL:
+		enabled = true;
+		break;
+	default:
+		break;
+	}
+
+	source->subdev = remote_subdev;
+
+	return sun6i_csi_bridge_link(csi_dev, SUN6I_CSI_BRIDGE_PAD_SINK,
+				     remote_subdev, enabled);
+}
+
+static int
+sun6i_csi_bridge_notifier_complete(struct v4l2_async_notifier *notifier)
+{
+	struct sun6i_csi_device *csi_dev =
+		container_of(notifier, struct sun6i_csi_device,
+			     bridge.notifier);
+	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+
+	return v4l2_device_register_subdev_nodes(v4l2_dev);
+}
+
+static const struct v4l2_async_notifier_operations
+sun6i_csi_bridge_notifier_ops = {
+	.bound		= sun6i_csi_bridge_notifier_bound,
+	.complete	= sun6i_csi_bridge_notifier_complete,
+};
+
+/* Bridge */
+
+static int sun6i_csi_bridge_source_setup(struct sun6i_csi_device *csi_dev,
+					 struct sun6i_csi_bridge_source *source,
+					 u32 port,
+					 enum v4l2_mbus_type *bus_types)
+{
+	struct device *dev = csi_dev->dev;
+	struct v4l2_async_notifier *notifier = &csi_dev->bridge.notifier;
+	struct v4l2_fwnode_endpoint *endpoint = &source->endpoint;
+	struct sun6i_csi_bridge_async_subdev *bridge_async_subdev;
+	struct fwnode_handle *handle;
+	int ret;
+
+	handle = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), port, 0, 0);
+	if (!handle)
+		return -ENODEV;
+
+	ret = v4l2_fwnode_endpoint_parse(handle, endpoint);
+	if (ret)
+		goto complete;
+
+	if (bus_types) {
+		bool valid = false;
+		unsigned int i;
+
+		for (i = 0; bus_types[i] != V4L2_MBUS_INVALID; i++) {
+			if (endpoint->bus_type == bus_types[i]) {
+				valid = true;
+				break;
+			}
+		}
+
+		if (!valid) {
+			dev_err(dev, "unsupported bus type for port %d\n",
+				port);
+			ret = -EINVAL;
+			goto complete;
+		}
+	}
+
+	bridge_async_subdev =
+		v4l2_async_nf_add_fwnode_remote(notifier, handle,
+						struct
+						sun6i_csi_bridge_async_subdev);
+	if (IS_ERR(bridge_async_subdev)) {
+		ret = PTR_ERR(bridge_async_subdev);
+		goto complete;
+	}
+
+	bridge_async_subdev->source = source;
+
+	source->expected = true;
+
+complete:
+	fwnode_handle_put(handle);
+
+	return ret;
+}
+
+int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
+{
+	struct device *dev = csi_dev->dev;
+	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
+	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	struct v4l2_subdev *subdev = &bridge->subdev;
+	struct v4l2_async_notifier *notifier = &bridge->notifier;
+	struct media_pad *pads = bridge->pads;
+	enum v4l2_mbus_type parallel_mbus_types[] = {
+		V4L2_MBUS_PARALLEL,
+		V4L2_MBUS_BT656,
+		V4L2_MBUS_INVALID
+	};
+	int ret;
+
+	mutex_init(&bridge->lock);
+
+	/* V4L2 Subdev */
+
+	v4l2_subdev_init(subdev, &sun6i_csi_bridge_subdev_ops);
+	strscpy(subdev->name, SUN6I_CSI_BRIDGE_NAME, sizeof(subdev->name));
+	subdev->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	subdev->owner = THIS_MODULE;
+	subdev->dev = dev;
+
+	v4l2_set_subdevdata(subdev, csi_dev);
+
+	/* Media Entity */
+
+	subdev->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	subdev->entity.ops = &sun6i_csi_bridge_entity_ops;
+
+	/* Media Pads */
+
+	pads[SUN6I_CSI_BRIDGE_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[SUN6I_CSI_BRIDGE_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE |
+						  MEDIA_PAD_FL_MUST_CONNECT;
+
+	ret = media_entity_pads_init(&subdev->entity,
+				     SUN6I_CSI_BRIDGE_PAD_COUNT, pads);
+	if (ret < 0)
+		return ret;
+
+	/* V4L2 Subdev */
+
+	ret = v4l2_device_register_subdev(v4l2_dev, subdev);
+	if (ret) {
+		dev_err(dev, "failed to register v4l2 subdev: %d\n", ret);
+		goto error_media_entity;
+	}
+
+	/* V4L2 Async */
+
+	v4l2_async_nf_init(notifier);
+	notifier->ops = &sun6i_csi_bridge_notifier_ops;
+
+	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_parallel,
+				      SUN6I_CSI_PORT_PARALLEL,
+				      parallel_mbus_types);
+
+	ret = v4l2_async_nf_register(v4l2_dev, notifier);
+	if (ret) {
+		dev_err(dev, "failed to register v4l2 async notifier: %d\n",
+			ret);
+		goto error_v4l2_async_notifier;
+	}
+
+	return 0;
+
+error_v4l2_async_notifier:
+	v4l2_async_nf_cleanup(notifier);
+
+	v4l2_device_unregister_subdev(subdev);
+
+error_media_entity:
+	media_entity_cleanup(&subdev->entity);
+
+	return ret;
+}
+
+void sun6i_csi_bridge_cleanup(struct sun6i_csi_device *csi_dev)
+{
+	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
+	struct v4l2_async_notifier *notifier = &csi_dev->bridge.notifier;
+
+	v4l2_async_nf_unregister(notifier);
+	v4l2_async_nf_cleanup(notifier);
+
+	v4l2_device_unregister_subdev(subdev);
+
+	media_entity_cleanup(&subdev->entity);
+}
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
new file mode 100644
index 000000000000..f9bf87bf3667
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021-2022 Bootlin
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+#ifndef _SUN6I_CSI_BRIDGE_H_
+#define _SUN6I_CSI_BRIDGE_H_
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
+
+#define SUN6I_CSI_BRIDGE_NAME	"sun6i-csi-bridge"
+
+enum sun6i_csi_bridge_pad {
+	SUN6I_CSI_BRIDGE_PAD_SINK	= 0,
+	SUN6I_CSI_BRIDGE_PAD_SOURCE	= 1,
+	SUN6I_CSI_BRIDGE_PAD_COUNT	= 2,
+};
+
+struct sun6i_csi_device;
+
+struct sun6i_csi_bridge_source {
+	struct v4l2_subdev		*subdev;
+	struct v4l2_fwnode_endpoint	endpoint;
+	bool				expected;
+};
+
+struct sun6i_csi_bridge_async_subdev {
+	struct v4l2_async_subdev	async_subdev;
+	struct sun6i_csi_bridge_source	*source;
+};
+
+struct sun6i_csi_bridge {
+	struct v4l2_subdev		subdev;
+	struct v4l2_async_notifier	notifier;
+	struct media_pad		pads[2];
+	struct v4l2_mbus_framefmt	mbus_format;
+	struct mutex			lock; /* Mbus format lock. */
+
+	struct sun6i_csi_bridge_source	source_parallel;
+};
+
+/* Bridge */
+
+int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev);
+void sun6i_csi_bridge_cleanup(struct sun6i_csi_device *csi_dev);
+
+#endif
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 42b10c61b60d..7254565cbbcf 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -632,6 +632,7 @@ int sun6i_video_setup(struct sun6i_csi_device *csi_dev)
 {
 	struct sun6i_video *video = &csi_dev->video;
 	struct v4l2_device *v4l2_dev = &csi_dev->v4l2.v4l2_dev;
+	struct v4l2_subdev *bridge_subdev = &csi_dev->bridge.subdev;
 	struct video_device *video_dev = &video->video_dev;
 	struct vb2_queue *queue = &video->queue;
 	struct media_pad *pad = &video->pad;
@@ -712,8 +713,26 @@ int sun6i_video_setup(struct sun6i_csi_device *csi_dev)
 		goto error_media_entity;
 	}
 
+	/* Media Pad Link */
+
+	ret = media_create_pad_link(&bridge_subdev->entity,
+				    SUN6I_CSI_BRIDGE_PAD_SOURCE,
+				    &video_dev->entity, 0,
+				    MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+	if (ret < 0) {
+		v4l2_err(v4l2_dev, "failed to create %s:%u -> %s:%u link\n",
+			 bridge_subdev->entity.name,
+			 SUN6I_CSI_BRIDGE_PAD_SOURCE,
+			 video_dev->entity.name, 0);
+		goto error_video_device;
+	}
+
 	return 0;
 
+error_video_device:
+	vb2_video_unregister_device(video_dev);
+
 error_media_entity:
 	media_entity_cleanup(&video_dev->entity);
 
-- 
2.37.1

