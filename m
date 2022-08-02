Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B163058837A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiHBV0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiHBVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:25:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C8AE70;
        Tue,  2 Aug 2022 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659475548; x=1691011548;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ND3rlg9rNAoggEOfoUZlZNbMtjbaIaYJ/hz9mIDW5ck=;
  b=GFoC1KaYqzMWACtAmeSZ2Ss8JjwNbGvJPbCzdU/2wq+/oDF/ubY51sbN
   bABP+NW4y8AXfsRXlE0vQORtGGtzqyT44h9DoQlZ3YoY3b4eSV9x4a+sj
   4v2BDXABAHHD6KaCJvQAFsr05MeHnYe+zxdNl9b3JRBrYWgaGB2fn0VZD
   vO9vB/W/+YbhHuC3jxrntOnM6sGlI+FDWQtcVjqBJa8Rqk/+UxpXTB0qZ
   SK0fY4rEoEBkl5ZQEpIeYFi3Ni0ZsAe70QdbX73Su+PP5JUFEC0HuG0EV
   vuXKRsybtzaDPPxPlofeKl23FZAX0kpeN60VLj9FnFhn60VbL8UynQ1z5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269292828"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="269292828"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:25:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="602585915"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2022 14:25:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A0729F7; Wed,  3 Aug 2022 00:25:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 1/1] leds: an30259a: Get rid of custom led_init_default_state_get()
Date:   Wed,  3 Aug 2022 00:25:54 +0300
Message-Id: <20220802212554.7216-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
 drivers/leds/leds-an30259a.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
index a0df1fb28774..d368df776153 100644
--- a/drivers/leds/leds-an30259a.c
+++ b/drivers/leds/leds-an30259a.c
@@ -55,10 +55,6 @@
 
 #define AN30259A_NAME "an30259a"
 
-#define STATE_OFF 0
-#define STATE_KEEP 1
-#define STATE_ON 2
-
 struct an30259a;
 
 struct an30259a_led {
@@ -66,7 +62,7 @@ struct an30259a_led {
 	struct fwnode_handle *fwnode;
 	struct led_classdev cdev;
 	u32 num;
-	u32 default_state;
+	enum led_default_state default_state;
 	bool sloping;
 };
 
@@ -228,15 +224,7 @@ static int an30259a_dt_init(struct i2c_client *client,
 		led->num = source;
 		led->chip = chip;
 		led->fwnode = of_fwnode_handle(child);
-
-		if (!of_property_read_string(child, "default-state", &str)) {
-			if (!strcmp(str, "on"))
-				led->default_state = STATE_ON;
-			else if (!strcmp(str, "keep"))
-				led->default_state = STATE_KEEP;
-			else
-				led->default_state = STATE_OFF;
-		}
+		led->default_state = led_init_default_state_get(led->fwnode);
 
 		i++;
 	}
@@ -261,10 +249,10 @@ static void an30259a_init_default_state(struct an30259a_led *led)
 	int led_on, err;
 
 	switch (led->default_state) {
-	case STATE_ON:
+	case LEDS_DEFSTATE_ON:
 		led->cdev.brightness = LED_FULL;
 		break;
-	case STATE_KEEP:
+	case LEDS_DEFSTATE_KEEP:
 		err = regmap_read(chip->regmap, AN30259A_REG_LED_ON, &led_on);
 		if (err)
 			break;
-- 
2.35.1

