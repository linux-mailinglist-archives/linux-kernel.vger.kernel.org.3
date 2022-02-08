Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2944ADD84
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382715AbiBHPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382256AbiBHPux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:50:53 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754ABC061578;
        Tue,  8 Feb 2022 07:50:52 -0800 (PST)
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:b99c:2ebe:5dcf:6513])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B1EA7144E;
        Tue,  8 Feb 2022 16:50:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644335439;
        bh=jxZFotQ6Gz0F0HG6RYCbfjcnc+9/17gvtmb58dxgBlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQiqe9mIWVexC19XHv+QOe1Arb4zJWupBsSy3AcX4vlYoNrPTr2TK1fl76pa1P/dl
         P/2xMwmuttv8YVfBc+t0VQ05H8Bp68eSVEPf1ZCQL2RTq4M7rk1mG9mCUPNOfNSCzn
         BiouPmRAWu0EeYmUuSfRw+AWUPPYEiNYWxoFx1kE=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: [PATCH v5 10/11] media: imx219: use a local v4l2_subdev to simplify reading
Date:   Tue,  8 Feb 2022 16:50:26 +0100
Message-Id: <20220208155027.891055-11-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to dereference the imx219 structure. Use a local
v4l2_subdev instead.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/imx219.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 35b61fad8e35..f005ad8d2124 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1509,6 +1509,7 @@ static int imx219_check_hwcfg(struct device *dev)
 static int imx219_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct v4l2_subdev *sd;
 	struct imx219 *imx219;
 	int ret;
 
@@ -1516,7 +1517,8 @@ static int imx219_probe(struct i2c_client *client)
 	if (!imx219)
 		return -ENOMEM;
 
-	v4l2_i2c_subdev_init(&imx219->sd, client, &imx219_subdev_ops);
+	sd = &imx219->sd;
+	v4l2_i2c_subdev_init(sd, client, &imx219_subdev_ops);
 
 	/* Check the hardware configuration in device tree */
 	if (imx219_check_hwcfg(dev))
@@ -1583,10 +1585,10 @@ static int imx219_probe(struct i2c_client *client)
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
@@ -1594,13 +1596,13 @@ static int imx219_probe(struct i2c_client *client)
 	/* Initialize default format */
 	imx219_set_default_format(imx219);
 
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
@@ -1614,7 +1616,7 @@ static int imx219_probe(struct i2c_client *client)
 	return 0;
 
 error_media_entity:
-	media_entity_cleanup(&imx219->sd.entity);
+	media_entity_cleanup(&sd->entity);
 
 error_handler_free:
 	imx219_free_controls(imx219);
-- 
2.32.0

