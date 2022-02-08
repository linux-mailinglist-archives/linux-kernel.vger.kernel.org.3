Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4735E4ADD7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382609AbiBHPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382236AbiBHPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:50:51 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1734C061578;
        Tue,  8 Feb 2022 07:50:50 -0800 (PST)
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:b99c:2ebe:5dcf:6513])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 49BDA1414;
        Tue,  8 Feb 2022 16:50:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644335438;
        bh=dr1CC9pJSj6kbXwnvh9HIA2xVOx06GmezXTKRVfGH6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfgH79yJvgUPQT5hCYD4mJhpuwC9NMPf1NoUbSmq9ZR8EIy/TJ2srNTbrHUVYsNFF
         ke/m25zG/ROcFbifAK786vWQj/FkhLzaQwuotkvkkFY19+ZbxwmkBpxR9aM3kc8dZY
         nEzam2ORfPzGfpintv5MB64pj4DjHABMmcsMacFE=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: [PATCH v5 09/11] media: imx219: Introduce the set_routing operation
Date:   Tue,  8 Feb 2022 16:50:25 +0100
Message-Id: <20220208155027.891055-10-jeanmichel.hautbois@ideasonboard.com>
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

As we want to use multiplexed streams API, we need to be able to set the
pad routing. Introduce the set_routing operation.

As this operation is required for a multiplexed able sensor, add the
V4L2_SUBDEV_FL_MULTIPLEXED flag.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 drivers/media/i2c/imx219.c | 82 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index abcaee15c4a0..35b61fad8e35 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -118,6 +118,10 @@
 #define IMX219_PIXEL_ARRAY_WIDTH	3280U
 #define IMX219_PIXEL_ARRAY_HEIGHT	2464U
 
+/* Embedded metadata stream structure */
+#define IMX219_EMBEDDED_LINE_WIDTH	16384
+#define IMX219_NUM_EMBEDDED_LINES	1
+
 struct imx219_reg {
 	u16 address;
 	u8 val;
@@ -784,15 +788,85 @@ static void imx219_init_formats(struct v4l2_subdev_state *state)
 	format->height = supported_modes[0].height;
 	format->field = V4L2_FIELD_NONE;
 	format->colorspace = V4L2_COLORSPACE_RAW;
+
+	if (state->routing.routes[1].flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE) {
+		format = v4l2_state_get_stream_format(state, 0, 1);
+		format->code = MEDIA_BUS_FMT_METADATA_8;
+		format->width = IMX219_EMBEDDED_LINE_WIDTH;
+		format->height = 1;
+		format->field = V4L2_FIELD_NONE;
+		format->colorspace = V4L2_COLORSPACE_DEFAULT;
+	}
 }
 
-static int imx219_init_cfg(struct v4l2_subdev *sd,
-			   struct v4l2_subdev_state *state)
+static int __imx219_set_routing(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *state)
 {
+	struct v4l2_subdev_route routes[] = {
+		{
+			.source_pad = 0,
+			.source_stream = 0,
+			.flags = V4L2_SUBDEV_ROUTE_FL_IMMUTABLE |
+				 V4L2_SUBDEV_ROUTE_FL_SOURCE |
+				 V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+		},
+		{
+			.source_pad = 0,
+			.source_stream = 1,
+			.flags = V4L2_SUBDEV_ROUTE_FL_SOURCE |
+				 V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+		}
+	};
+
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = ARRAY_SIZE(routes),
+		.routes = routes,
+	};
+
+	int ret;
+
+	ret = v4l2_subdev_set_routing(sd, state, &routing);
+	if (ret)
+		return ret;
+
 	imx219_init_formats(state);
+
 	return 0;
 }
 
+static int imx219_set_routing(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *state,
+			      enum v4l2_subdev_format_whence which,
+			      struct v4l2_subdev_krouting *routing)
+{
+	int ret;
+
+	if (routing->num_routes == 0 || routing->num_routes > 2)
+		return -EINVAL;
+
+	v4l2_subdev_lock_state(state);
+
+	ret = __imx219_set_routing(sd, state);
+
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
+static int imx219_init_cfg(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_state *state)
+{
+	int ret;
+
+	v4l2_subdev_lock_state(state);
+
+	ret = __imx219_set_routing(sd, state);
+
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+
 static int imx219_enum_mbus_code(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_state *sd_state,
 				 struct v4l2_subdev_mbus_code_enum *code)
@@ -1251,6 +1325,7 @@ static const struct v4l2_subdev_pad_ops imx219_pad_ops = {
 	.get_fmt		= imx219_get_pad_format,
 	.set_fmt		= imx219_set_pad_format,
 	.get_selection		= imx219_get_selection,
+	.set_routing		= imx219_set_routing,
 	.enum_frame_size	= imx219_enum_frame_size,
 };
 
@@ -1509,7 +1584,8 @@ static int imx219_probe(struct i2c_client *client)
 
 	/* Initialize subdev */
 	imx219->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
-			    V4L2_SUBDEV_FL_HAS_EVENTS;
+			    V4L2_SUBDEV_FL_HAS_EVENTS |
+			    V4L2_SUBDEV_FL_MULTIPLEXED;
 	imx219->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
 
 	/* Initialize source pad */
-- 
2.32.0

