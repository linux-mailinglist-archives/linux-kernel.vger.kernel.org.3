Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0CC588369
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiHBVZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHBVZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:25:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC150078;
        Tue,  2 Aug 2022 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659475507; x=1691011507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hvI26OhQ+1E3Y1b+RrDqvUOiyVnslqAALa2RhHdwGbY=;
  b=XS1lfDCArLSGoBq3F7Aex1+DIxnV0LMMHleOf7ldjvcFPEZph2Q1zQQ+
   P6EIyx9DmcmJOBvcICkc2kZiRZTD8tJ+gETqNwESx2cxIkujuE+0ataDJ
   HW4VEKjZSIR5RoHJ8RKoY7dRutlwUfywKg3kOV+YHPrsjauZIoVXHlTzd
   KnaKlorNyEj/lEgPxmUXbU3pwYF5/U9P5Q3gBqtTAZW7n7ms+UpLVwA8G
   /hEXRFyCRt8CsGjW7wx31/YjSRguby2Qk2vpIG1OsK9WreR/95G0XX9Bz
   zAaEtw46gxFBdV4DxLiS4cDt/Zmf2fi+f67/Nigjq69CAkjiS3bB51Vmz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="276433701"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="276433701"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="778763780"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2022 14:25:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4C7CFF7; Wed,  3 Aug 2022 00:25:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 1/1] leds: pm8058: Get rid of custom led_init_default_state_get()
Date:   Wed,  3 Aug 2022 00:25:13 +0300
Message-Id: <20220802212513.7029-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LED core provides a helper to parse default state from firmware node.
Use it instead of custom implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-pm8058.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-pm8058.c b/drivers/leds/leds-pm8058.c
index fb2ab72c0c40..b9233f14b646 100644
--- a/drivers/leds/leds-pm8058.c
+++ b/drivers/leds/leds-pm8058.c
@@ -93,8 +93,8 @@ static int pm8058_led_probe(struct platform_device *pdev)
 	struct device_node *np;
 	int ret;
 	struct regmap *map;
-	const char *state;
 	enum led_brightness maxbright;
+	enum led_default_state state;
 
 	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 	if (!led)
@@ -125,25 +125,26 @@ static int pm8058_led_probe(struct platform_device *pdev)
 		maxbright = 15; /* 4 bits */
 	led->cdev.max_brightness = maxbright;
 
-	state = of_get_property(np, "default-state", NULL);
-	if (state) {
-		if (!strcmp(state, "keep")) {
-			led->cdev.brightness = pm8058_led_get(&led->cdev);
-		} else if (!strcmp(state, "on")) {
-			led->cdev.brightness = maxbright;
-			pm8058_led_set(&led->cdev, maxbright);
-		} else {
-			led->cdev.brightness = LED_OFF;
-			pm8058_led_set(&led->cdev, LED_OFF);
-		}
+	init_data.fwnode = of_fwnode_handle(np);
+
+	state = led_init_default_state_get(init_data.fwnode);
+	switch (state) {
+	case LEDS_DEFSTATE_ON:
+		led->cdev.brightness = maxbright;
+		pm8058_led_set(&led->cdev, maxbright);
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		led->cdev.brightness = pm8058_led_get(&led->cdev);
+		break;
+	default:
+		led->cdev.brightness = LED_OFF;
+		pm8058_led_set(&led->cdev, LED_OFF);
 	}
 
 	if (led->ledtype == PM8058_LED_TYPE_KEYPAD ||
 	    led->ledtype == PM8058_LED_TYPE_FLASH)
 		led->cdev.flags	= LED_CORE_SUSPENDRESUME;
 
-	init_data.fwnode = of_fwnode_handle(np);
-
 	ret = devm_led_classdev_register_ext(dev, &led->cdev, &init_data);
 	if (ret)
 		dev_err(dev, "Failed to register LED for %pOF\n", np);
-- 
2.35.1

