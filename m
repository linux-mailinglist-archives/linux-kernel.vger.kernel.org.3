Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9EB51FFCD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiEIOhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237342AbiEIOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:36:47 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A273B57C;
        Mon,  9 May 2022 07:32:52 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 8828B24000D;
        Mon,  9 May 2022 14:32:48 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v3 4/4] media: i2c: ov5675: add .get_selection support
Date:   Mon,  9 May 2022 16:32:26 +0200
Message-Id: <20220509143226.531117-4-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220509143226.531117-1-foss+kernel@0leil.net>
References: <20220509143226.531117-1-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The sensor has 2592*1944 active pixels, surrounded by 16 active dummy
pixels and there are an additional 24 black rows "at the bottom".

As recommended in the SELECTION API documentation, let's put the first
useful active pixel at the top/left corner (0,0).

This window is the default and maximal crop allowed by the sensor.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---

added in v3

 drivers/media/i2c/ov5675.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 5544e1ae444e..8e3a5bc6c027 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -78,6 +78,9 @@
 #define OV5675_REG_FORMAT1		0x3820
 #define OV5675_REG_FORMAT2		0x373d
 
+#define OV5675_PIXEL_ARRAY_WIDTH	2592U
+#define OV5675_PIXEL_ARRAY_HEIGHT	1944U
+
 #define to_ov5675(_sd)			container_of(_sd, struct ov5675, sd)
 
 static const char * const ov5675_supply_names[] = {
@@ -1115,6 +1118,27 @@ static int ov5675_get_format(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int ov5675_get_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *state,
+				struct v4l2_subdev_selection *sel)
+{
+	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
+		return -EINVAL;
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP:
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
+		/* In HW, top/left corner is actually at (16,16) */
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = OV5675_PIXEL_ARRAY_WIDTH;
+		sel->r.height = OV5675_PIXEL_ARRAY_HEIGHT;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static int ov5675_enum_mbus_code(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_state *sd_state,
 				 struct v4l2_subdev_mbus_code_enum *code)
@@ -1164,6 +1188,7 @@ static const struct v4l2_subdev_video_ops ov5675_video_ops = {
 static const struct v4l2_subdev_pad_ops ov5675_pad_ops = {
 	.set_fmt = ov5675_set_format,
 	.get_fmt = ov5675_get_format,
+	.get_selection = ov5675_get_selection,
 	.enum_mbus_code = ov5675_enum_mbus_code,
 	.enum_frame_size = ov5675_enum_frame_size,
 };
-- 
2.35.3

