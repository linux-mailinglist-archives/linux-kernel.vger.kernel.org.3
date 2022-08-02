Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B1588378
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiHBV0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiHBVZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:25:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F016B5FB7;
        Tue,  2 Aug 2022 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659475542; x=1691011542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LCJNwKIb2JZh9SO69nCDrOY4AomaNFhl38g2hoPWX0w=;
  b=A7A8kkn2F3jBR/jKWSFl3dRnlyWc3SjmP+07VxY+qAX+MUlbwZw0j5S5
   dMrwqhfS4d/RuQh6MJmYXCc7tnk7Vqga1LyIapqkaVhJ6zaKPhFnXmnV/
   X2kkQNeyC2dt9amzaGvD0Na7ikchHN+0ZtTygZMjkla2ZdoWBTx0OyQCT
   Pf8TPTTOOazRGtQjGNxlszWURxjRW2h8Q2yeencvkoHuGm7cZBuIg12Y+
   N7tuhHIAaqtPt5uWJgSwEoKoef87ZzV0hKd62FagjZNy6p/wCCXf4h7Y5
   6sZxgmZAVJnKadpIb1UeAtfutsjxg77ZLev6WTw+ZGmKdWvSn0Ipn4mS9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="353526632"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="353526632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="744821947"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2022 14:25:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 05B85F7; Wed,  3 Aug 2022 00:25:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 1/1] leds: bcm6328: Get rid of custom led_init_default_state_get()
Date:   Wed,  3 Aug 2022 00:25:49 +0300
Message-Id: <20220802212549.7184-1-andriy.shevchenko@linux.intel.com>
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
 drivers/leds/leds-bcm6328.c | 49 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/leds/leds-bcm6328.c b/drivers/leds/leds-bcm6328.c
index 2d4d87957a30..246f1296ab09 100644
--- a/drivers/leds/leds-bcm6328.c
+++ b/drivers/leds/leds-bcm6328.c
@@ -330,7 +330,9 @@ static int bcm6328_led(struct device *dev, struct device_node *nc, u32 reg,
 {
 	struct led_init_data init_data = {};
 	struct bcm6328_led *led;
-	const char *state;
+	enum led_default_state state;
+	unsigned long val, shift;
+	void __iomem *mode;
 	int rc;
 
 	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
@@ -346,31 +348,29 @@ static int bcm6328_led(struct device *dev, struct device_node *nc, u32 reg,
 	if (of_property_read_bool(nc, "active-low"))
 		led->active_low = true;
 
-	if (!of_property_read_string(nc, "default-state", &state)) {
-		if (!strcmp(state, "on")) {
+	init_data.fwnode = of_fwnode_handle(nc);
+
+	state = led_init_default_state_get(init_data.fwnode);
+	switch (state) {
+	case LEDS_DEFSTATE_ON:
+		led->cdev.brightness = LED_FULL;
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		shift = bcm6328_pin2shift(led->pin);
+		if (shift / 16)
+			mode = mem + BCM6328_REG_MODE_HI;
+		else
+			mode = mem + BCM6328_REG_MODE_LO;
+
+		val = bcm6328_led_read(mode) >> BCM6328_LED_SHIFT(shift % 16);
+		val &= BCM6328_LED_MODE_MASK;
+		if ((led->active_low && val == BCM6328_LED_MODE_OFF) ||
+		    (!led->active_low && val == BCM6328_LED_MODE_ON))
 			led->cdev.brightness = LED_FULL;
-		} else if (!strcmp(state, "keep")) {
-			void __iomem *mode;
-			unsigned long val, shift;
-
-			shift = bcm6328_pin2shift(led->pin);
-			if (shift / 16)
-				mode = mem + BCM6328_REG_MODE_HI;
-			else
-				mode = mem + BCM6328_REG_MODE_LO;
-
-			val = bcm6328_led_read(mode) >>
-			      BCM6328_LED_SHIFT(shift % 16);
-			val &= BCM6328_LED_MODE_MASK;
-			if ((led->active_low && val == BCM6328_LED_MODE_OFF) ||
-			    (!led->active_low && val == BCM6328_LED_MODE_ON))
-				led->cdev.brightness = LED_FULL;
-			else
-				led->cdev.brightness = LED_OFF;
-		} else {
+		else
 			led->cdev.brightness = LED_OFF;
-		}
-	} else {
+		break;
+	default:
 		led->cdev.brightness = LED_OFF;
 	}
 
@@ -378,7 +378,6 @@ static int bcm6328_led(struct device *dev, struct device_node *nc, u32 reg,
 
 	led->cdev.brightness_set = bcm6328_led_set;
 	led->cdev.blink_set = bcm6328_blink_set;
-	init_data.fwnode = of_fwnode_handle(nc);
 
 	rc = devm_led_classdev_register_ext(dev, &led->cdev, &init_data);
 	if (rc < 0)
-- 
2.35.1

