Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A9E4A8AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353352AbiBCRw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:52:26 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59002 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353223AbiBCRus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:48 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:5173:4d3f:4ddc:2012])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 028BC1C2D;
        Thu,  3 Feb 2022 18:50:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643910629;
        bh=7P8zmIp04YDN3+i1i3KJjkUj+aOMuxjdMxXla3XMhQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7d3caETf3q3BXpEZVIjyX2QawZFOXLJmfKZX9cVNd57ldURRI51kt4EsvXPyZPfI
         GPGLhN3RYKiPaAy/dMLq/tQR++ZvJ9EbA+wmbsAoV/rN6P47MKrOiw8P9PXcOqZj05
         Fk27/I1GxiKKSs62ZCVBVPSGZkag+itmEJRKSyq4=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [RFC PATCH v4 10/12] media: imx219: use a local v4l2_subdev to simplify reading
Date:   Thu,  3 Feb 2022 18:50:07 +0100
Message-Id: <20220203175009.558868-11-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to dereference the imx219 structure. Use a local
v4l2_subdev instead.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 drivers/media/i2c/imx219.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 7d29cf2b06f8..7c224d007f3e 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1492,6 +1492,7 @@ static int imx219_check_hwcfg(struct device *dev)
 static int imx219_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct v4l2_subdev *sd;
 	struct imx219 *imx219;
 	int ret;
 
@@ -1499,7 +1500,8 @@ static int imx219_probe(struct i2c_client *client)
 	if (!imx219)
 		return -ENOMEM;
 
-	v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
+	sd = &imx219->sd;
+	v4l2_i2c_subdev_init(sd, client, &imx219_subdev_ops);
 
 	/* Check the hardware configuration in device tree */
 	if (imx219_check_hwcfg(dev))
@@ -1566,21 +1568,21 @@ static int imx219_probe(struct i2c_client *client)
 		goto error_power_off;
 
 	/* Initialize subdev */
-	imx219->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
-			    V4L2_SUBDEV_FL_HAS_EVENTS |
-			    V4L2_SUBDEV_FL_MULTIPLEXED;
-	imx219->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
+		     V4L2_SUBDEV_FL_HAS_EVENTS |
+		     V4L2_SUBDEV_FL_MULTIPLEXED;
+	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
 
 	/* Initialize source pad */
 	imx219->pad.flags = MEDIA_PAD_FL_SOURCE;
 
-	ret = media_entity_pads_init(&imx219->sd.entity, 1, &imx219->pad);
+	ret = media_entity_pads_init(&sd->entity, 1, &imx219->pad);
 	if (ret) {
 		dev_err(dev, "failed to init entity pads: %d\n", ret);
 		goto error_handler_free;
 	}
 
-	ret = v4l2_async_register_subdev_sensor(&imx219->sd);
+	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret < 0) {
 		dev_err(dev, "failed to register sensor sub-device: %d\n", ret);
 		goto error_media_entity;
@@ -1594,7 +1596,7 @@ static int imx219_probe(struct i2c_client *client)
 	return 0;
 
 error_media_entity:
-	media_entity_cleanup(&imx219->sd.entity);
+	media_entity_cleanup(&sd->entity);
 
 error_handler_free:
 	imx219_free_controls(imx219);
-- 
2.32.0

