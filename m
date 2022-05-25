Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AA7533C72
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiEYMNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiEYMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:13:07 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E93931938;
        Wed, 25 May 2022 05:13:06 -0700 (PDT)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 797D824000B;
        Wed, 25 May 2022 12:13:02 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
Cc:     shawnx.tu@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss+kernel@0leil.net,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v4 3/4] media: i2c: ov5675: parse and register V4L2 device tree properties
Date:   Wed, 25 May 2022 14:12:39 +0200
Message-Id: <20220525121240.1094792-3-foss+kernel@0leil.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525121240.1094792-1-foss+kernel@0leil.net>
References: <20220525121240.1094792-1-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Parse V4L2 device tree properties and register controls for them.

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---

v3:
 - reverse-xmas-tree-ordered in ov5675_init_controls,

 drivers/media/i2c/ov5675.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5675.c b/drivers/media/i2c/ov5675.c
index 194ec20a3070e..86f7a308c0844 100644
--- a/drivers/media/i2c/ov5675.c
+++ b/drivers/media/i2c/ov5675.c
@@ -779,12 +779,14 @@ static const struct v4l2_ctrl_ops ov5675_ctrl_ops = {
 
 static int ov5675_init_controls(struct ov5675 *ov5675)
 {
+	struct i2c_client *client = v4l2_get_subdevdata(&ov5675->sd);
+	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *ctrl_hdlr;
 	s64 exposure_max, h_blank;
 	int ret;
 
 	ctrl_hdlr = &ov5675->ctrl_handler;
-	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 8);
+	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 10);
 	if (ret)
 		return ret;
 
@@ -838,9 +840,23 @@ static int ov5675_init_controls(struct ov5675 *ov5675)
 	if (ctrl_hdlr->error)
 		return ctrl_hdlr->error;
 
+	ret = v4l2_fwnode_device_parse(&client->dev, &props);
+	if (ret)
+		goto error;
+
+	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &ov5675_ctrl_ops,
+					      &props);
+	if (ret)
+		goto error;
+
 	ov5675->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
+
+error:
+	v4l2_ctrl_handler_free(ctrl_hdlr);
+
+	return ret;
 }
 
 static void ov5675_update_pad_format(const struct ov5675_mode *mode,
-- 
2.36.1

