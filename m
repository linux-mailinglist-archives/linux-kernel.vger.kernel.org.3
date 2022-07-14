Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177A157477A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiGNIpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiGNIpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:45:09 -0400
Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E72E11F618
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:45:07 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id BuRhoA7r5bvrcBuS5oFplu; Thu, 14 Jul 2022 10:44:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1657788246; bh=uS+Azrz0pmFgc24xzV+6taJkOy63mYIx1D8fhtDMVmo=;
        h=From:To:Subject:Date:MIME-Version;
        b=HHm1qCikIi8vb0ly9c2XWNwJgNv/woqSpK5zOm3yac/TFEiwLvkaVm/NM11g9NGRv
         F3DdZYTbgY3D3sWd3nRghhkRhN4Y2/ec8zdQQJenMwmFISbvDIsNvlI6dRhHAnRrA0
         KvHcb7UE1oR2D7KeVE0v7w1Z395azdWpjE1/iu4d0GoewiZbRoR6W2xDqiyWFGSOn0
         9QPxG0YZxcYoz48ZKIQOVOhzmhAMWGS5IHAnpr8q9TxavTmDkyyPdXcMUN8cDoHJZ8
         BzRC2r8FBQag0kpSp7kXUGhDvNA9v9pkZ+k67MbyD5176No5EERbEs8pLYCedLWfU1
         HWzC4Jx8/uDKA==
From:   Luca Ellero <luca.ellero@brickedbrain.com>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH 2/3] ads7846: always set last command to PWRDOWN
Date:   Thu, 14 Jul 2022 10:43:18 +0200
Message-Id: <20220714084319.107334-3-luca.ellero@brickedbrain.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714084319.107334-1-luca.ellero@brickedbrain.com>
References: <20220714084319.107334-1-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP6FcPNoB8W5uAx2KKKHpq5ZIb3HtAbo6IGTIQF5A9R0MaImPy6lI2snhxuAyB7yOQj3lyOdFxVMIkZpGHF9QiJLAGou8L7t5i+zV+/p5sqz8pwl6jhg
 e5JFbJO/Y03l8nQDNmvE3xRUUZ6C2zeIcp+xXZMtqzX0tl4qRJUL428in4U4dnOEZBwspGATn04jGj7oLxQd+jDQ1UH3Uw8Jm+aBoiXYaWp53s5WspI9KiC2
 9lgFXx+QPTaK9rCoRIYouzC6espq8Gl7dSF6sWtPkah5s900J+exI40zXBiX7q6gFCtoY7aT3dTuZ18HjlV21oK+W8IlhhEzFALdCKWoc20P/W3NCaHGglCO
 /73nwOj1UD7wm4q7i42idWkGG6pCit5+vb2pDdwFegB3oyX8b+iaVCAM0sYmUFYMsqQVl9jEq8wT49n6MoHy+37qWglWGVNs20MhAaWCUlPkW08CEdmIMrJO
 FL8ZH3RNLdkipTU/uTE4hafpyx4iAM4Ud/MO6XJn5CBylvoeiuasOkv0vHMGv/DmN86GzhbNX2tWBQ2jI+FeeGL6iQ5RQ3gkB+8o1akmcOwy6jwNzSpM56bW
 aHE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ellero <l.ellero@asem.it>

This was broken on controllers with 3 commands as ads7845.
READ_Z1 was sent instead.

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
 drivers/input/touchscreen/ads7846.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 24605c40d039..9e15cdf6faa0 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1066,6 +1066,9 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
 		unsigned int max_count;
 
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
 		if (ads7846_cmd_need_settle(cmd_idx))
 			max_count = packet->count + packet->count_skip;
 		else
@@ -1102,7 +1105,12 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 
 	for (cmd_idx = 0; cmd_idx < packet->cmds; cmd_idx++) {
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
-		u8 cmd = ads7846_get_cmd(cmd_idx, vref);
+		u8 cmd;
+
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
+		cmd = ads7846_get_cmd(cmd_idx, vref);
 
 		for (b = 0; b < l->count; b++)
 			packet->tx[l->offset + b].cmd = cmd;
-- 
2.25.1

