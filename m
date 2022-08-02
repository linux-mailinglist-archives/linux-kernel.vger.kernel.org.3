Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E7F588372
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiHBVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiHBVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:25:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1402853D3F;
        Tue,  2 Aug 2022 14:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659475532; x=1691011532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OunVwjFJhL1Q/tamMZepaupTRMyzPHvHM30RUkvfBQg=;
  b=c7h/S79EDbW2vnYpLamCYCT9e7Y0zFL8xvxJydsrTdRhAgB2S1yLrYu4
   czG6zMIFDALpUY/EwZ6ws+RIVkg0M//6h+Jzmm2vNrmfOf1ybXu+hj/aF
   glPTFkh/nFWdIqxT8pYI1PddfYa5p4qQzTLkY9wCLVAX+Th9NCtcGNlEI
   /FfFl3O2F8i11nY+3RzxLu863caD7783itPNTmH+50J82g5BkA0v6d/5D
   1DJQEbXLo2G0jmGgBBqrz78TeycFAdSWR3gweN18Bjxj0K/si4MeYMxMG
   0Kci5OoxuVgVFL3jpwBCozQKZwwE2xdNpK2X7xpnjntw8ea/5lORCgawV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287082881"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="287082881"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="606163580"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2022 14:25:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A8D44F7; Wed,  3 Aug 2022 00:25:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sean Wang <sean.wang@mediatek.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v1 1/1] leds: mt6323: Get rid of custom led_init_default_state_get()
Date:   Wed,  3 Aug 2022 00:25:37 +0300
Message-Id: <20220802212537.7122-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
 drivers/leds/leds-mt6323.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index f59e0e8bda8b..17ee88043f52 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -339,23 +339,23 @@ static int mt6323_led_set_dt_default(struct led_classdev *cdev,
 				     struct device_node *np)
 {
 	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
-	const char *state;
+	enum led_default_state state;
 	int ret = 0;
 
-	state = of_get_property(np, "default-state", NULL);
-	if (state) {
-		if (!strcmp(state, "keep")) {
-			ret = mt6323_get_led_hw_brightness(cdev);
-			if (ret < 0)
-				return ret;
-			led->current_brightness = ret;
-			ret = 0;
-		} else if (!strcmp(state, "on")) {
-			ret =
-			mt6323_led_set_brightness(cdev, cdev->max_brightness);
-		} else  {
-			ret = mt6323_led_set_brightness(cdev, LED_OFF);
-		}
+	state = led_init_default_state_get(of_fwnode_handle(np));
+	switch (state) {
+	case LEDS_DEFSTATE_ON:
+		ret = mt6323_led_set_brightness(cdev, cdev->max_brightness);
+		break;
+	case LEDS_DEFSTATE_KEEP:
+		ret = mt6323_get_led_hw_brightness(cdev);
+		if (ret < 0)
+			return ret;
+		led->current_brightness = ret;
+		ret = 0;
+		break;
+	default:
+		ret = mt6323_led_set_brightness(cdev, LED_OFF);
 	}
 
 	return ret;
-- 
2.35.1

