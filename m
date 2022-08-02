Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141FD588371
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiHBVZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiHBVZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:25:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB7438B3;
        Tue,  2 Aug 2022 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659475521; x=1691011521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ymbw60lTuQcXpEjOvBsfA2/pFFWl5YB68Q0fbwk5LVE=;
  b=QBC+E8ukZm2UWI+QXZMRju+uZBa0Dn4s5LxJzbZwN+yp9QjZ4qffwl4g
   2ubFm1bhCUz1VDaAZf5ZZpPdXIsqtfFjkrv0SIiSRqkYO8eMkWTD1wJZg
   QZODMm0DapeNmYL/z7vGmRAnDmGTfOky5uWemqa9Be+Dmw23RSmjzmUjc
   +29dlCutV2xI40PEEQfxumD1vS9Avhm3O+fzc4rYa1DUC1w2Zcyii+5HU
   7mSq/AlzzLckCssDJWP9F8gjaIu6KRtoTr0w+/1UfSU4DRj2dmdv5+X/C
   DgpjnK5XqnJJPXOkkBjX/h6rtx0+mi0N4uekdP9qUYl3l5L/QL5eKwXH/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="351235853"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="351235853"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:25:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="602585802"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2022 14:25:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CE22CF7; Wed,  3 Aug 2022 00:25:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>, Eddie James <eajames@linux.ibm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] leds: pca955x: Get rid of custom led_init_default_state_get()
Date:   Wed,  3 Aug 2022 00:25:18 +0300
Message-Id: <20220802212518.7060-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LED core provides a helper to parse default state from firmware node.
Use it instead of custom implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-pca955x.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
index 81aaf21212d7..b240a3f6db3d 100644
--- a/drivers/leds/leds-pca955x.c
+++ b/drivers/leds/leds-pca955x.c
@@ -130,7 +130,7 @@ struct pca955x_led {
 	struct led_classdev	led_cdev;
 	int			led_num;	/* 0 .. 15 potentially */
 	u32			type;
-	int			default_state;
+	enum led_default_state	default_state;
 	struct fwnode_handle	*fwnode;
 };
 
@@ -454,19 +454,9 @@ pca955x_get_pdata(struct i2c_client *client, struct pca955x_chipdef *chip)
 		led = &pdata->leds[reg];
 		led->type = PCA955X_TYPE_LED;
 		led->fwnode = child;
-		fwnode_property_read_u32(child, "type", &led->type);
+		led->default_state = led_init_default_state_get(child);
 
-		if (!fwnode_property_read_string(child, "default-state",
-						 &state)) {
-			if (!strcmp(state, "keep"))
-				led->default_state = LEDS_GPIO_DEFSTATE_KEEP;
-			else if (!strcmp(state, "on"))
-				led->default_state = LEDS_GPIO_DEFSTATE_ON;
-			else
-				led->default_state = LEDS_GPIO_DEFSTATE_OFF;
-		} else {
-			led->default_state = LEDS_GPIO_DEFSTATE_OFF;
-		}
+		fwnode_property_read_u32(child, "type", &led->type);
 	}
 
 	pdata->num_leds = chip->bits;
@@ -578,13 +568,11 @@ static int pca955x_probe(struct i2c_client *client)
 			led->brightness_set_blocking = pca955x_led_set;
 			led->brightness_get = pca955x_led_get;
 
-			if (pdata->leds[i].default_state ==
-			    LEDS_GPIO_DEFSTATE_OFF) {
+			if (pdata->leds[i].default_state == LEDS_DEFSTATE_OFF) {
 				err = pca955x_led_set(led, LED_OFF);
 				if (err)
 					return err;
-			} else if (pdata->leds[i].default_state ==
-				   LEDS_GPIO_DEFSTATE_ON) {
+			} else if (pdata->leds[i].default_state == LEDS_DEFSTATE_ON) {
 				err = pca955x_led_set(led, LED_FULL);
 				if (err)
 					return err;
@@ -623,8 +611,7 @@ static int pca955x_probe(struct i2c_client *client)
 			 * brightness to see if it's using PWM1. If so, PWM1
 			 * should not be written below.
 			 */
-			if (pdata->leds[i].default_state ==
-			    LEDS_GPIO_DEFSTATE_KEEP) {
+			if (pdata->leds[i].default_state == LEDS_DEFSTATE_KEEP) {
 				if (led->brightness != LED_FULL &&
 				    led->brightness != LED_OFF &&
 				    led->brightness != LED_HALF)
-- 
2.35.1

