Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99E598658
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343547AbiHROre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245516AbiHROrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:47:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D73BB93F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:47:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOgnk-0008KK-0F; Thu, 18 Aug 2022 16:47:16 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOgnj-000X2q-6d; Thu, 18 Aug 2022 16:47:15 +0200
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOgni-004BVd-6w; Thu, 18 Aug 2022 16:47:14 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 4/4] media: mt9m111: remove .s_power callback
Date:   Thu, 18 Aug 2022 16:47:12 +0200
Message-Id: <20220818144712.997477-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220818144712.997477-1-m.felsch@pengutronix.de>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is in preparation of switching to the generic dev PM mechanism.
Since the .s_power callback will be removed in the near future move the
powering into the .s_stream callback. So this driver no longer depends
on the .s_power mechanism.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/media/i2c/mt9m111.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
index cd74c408e110..8e8ba5a8e6ea 100644
--- a/drivers/media/i2c/mt9m111.c
+++ b/drivers/media/i2c/mt9m111.c
@@ -1065,7 +1065,6 @@ static const struct v4l2_ctrl_ops mt9m111_ctrl_ops = {
 };
 
 static const struct v4l2_subdev_core_ops mt9m111_subdev_core_ops = {
-	.s_power	= mt9m111_s_power,
 	.log_status = v4l2_ctrl_subdev_log_status,
 	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
 	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
@@ -1136,8 +1135,14 @@ static int mt9m111_enum_mbus_code(struct v4l2_subdev *sd,
 static int mt9m111_s_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct mt9m111 *mt9m111 = container_of(sd, struct mt9m111, subdev);
+	int ret;
 
 	mt9m111->is_streaming = !!enable;
+
+	ret = mt9m111_s_power(sd, enable);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.30.2

