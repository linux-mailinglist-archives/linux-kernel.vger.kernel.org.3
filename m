Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE24A772F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346531AbiBBR5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:57:36 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:58272 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbiBBR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:57:22 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:7139:eada:2ff6:73dd])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 879EB1544;
        Wed,  2 Feb 2022 18:56:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643824612;
        bh=7P8zmIp04YDN3+i1i3KJjkUj+aOMuxjdMxXla3XMhQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5nMt03E8apAlzwBMdK1cl5enBgQsOqWsGtEsVstIJiP41jzWbK+5Mi3LEk2arAkm
         OOFDvY9Y6R2KWw6iSIkAkMcejD0JI3aa56icqKnzdz1QgKbawfn1wC4PBwpegos//F
         m+LnC8ocLxrOvEOR7KE7WXawufNtjtp7NF7zG4AU=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v3 09/11] media: imx219: use a local v4l2_subdev to simplify reading
Date:   Wed,  2 Feb 2022 18:56:37 +0100
Message-Id: <20220202175639.149681-10-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220202175639.149681-1-jeanmichel.hautbois@ideasonboard.com>
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

