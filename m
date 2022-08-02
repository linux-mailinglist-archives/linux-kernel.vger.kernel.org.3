Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB58F588375
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiHBV0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiHBVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:25:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95EC60D2;
        Tue,  2 Aug 2022 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659475537; x=1691011537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1IsTbKM8jNHxj4ziPqVComygZINDozfOXf+AY99bFeg=;
  b=QVJVoNs7NUm3Hap9XhaiIYmziIGqj4+ypyAbeRG1rWsui29VpxgdPR/t
   RyfAI5vxiai5GqbIz4pa2R7zfwv6UrcDvGTN/cLEts03HhL6veJFXqkuG
   HH3evpdJss2lM50wAvvkHcNvsZ3Pt+trtMPsDuVFKY4EROtLSIMXXAsbe
   1pyBi55DJEgcQaKM76DvhwSaT3L0ZwvCS10zxkBwbCxYi5GSGBzdFAFle
   M47/PQLGX8yrdx32sZ/6wgZ15L9aiB49PDa1E1UZjne2V+czY9S/E3BNR
   HnNayQqxO+Y2kdgrqqzQP/bGnmQ+wtahpFfvIvWLI+LJFK7+u1B5U7qBw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269902309"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="269902309"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="599433855"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 02 Aug 2022 14:25:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D20E6F7; Wed,  3 Aug 2022 00:25:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 1/1] leds: bcm6358: Get rid of custom led_init_default_state_get()
Date:   Wed,  3 Aug 2022 00:25:42 +0300
Message-Id: <20220802212542.7153-1-andriy.shevchenko@linux.intel.com>
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
 drivers/leds/leds-bcm6358.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/leds/leds-bcm6358.c b/drivers/leds/leds-bcm6358.c
index 9d2e487fa08a..86e51d44a5a7 100644
--- a/drivers/leds/leds-bcm6358.c
+++ b/drivers/leds/leds-bcm6358.c
@@ -96,7 +96,8 @@ static int bcm6358_led(struct device *dev, struct device_node *nc, u32 reg,
 {
 	struct led_init_data init_data = {};
 	struct bcm6358_led *led;
-	const char *state;
+	enum led_default_state state;
+	unsigned long val;
 	int rc;
 
 	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
@@ -110,29 +111,28 @@ static int bcm6358_led(struct device *dev, struct device_node *nc, u32 reg,
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
+		val = bcm6358_led_read(led->mem + BCM6358_REG_MODE);
+		val &= BIT(led->pin);
+		if ((led->active_low && !val) || (!led->active_low && val))
 			led->cdev.brightness = LED_FULL;
-		} else if (!strcmp(state, "keep")) {
-			unsigned long val;
-			val = bcm6358_led_read(led->mem + BCM6358_REG_MODE);
-			val &= BIT(led->pin);
-			if ((led->active_low && !val) ||
-			    (!led->active_low && val))
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
 
 	bcm6358_led_set(&led->cdev, led->cdev.brightness);
 
 	led->cdev.brightness_set = bcm6358_led_set;
-	init_data.fwnode = of_fwnode_handle(nc);
 
 	rc = devm_led_classdev_register_ext(dev, &led->cdev, &init_data);
 	if (rc < 0)
-- 
2.35.1

