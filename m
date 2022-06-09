Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94D15451C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343545AbiFIQWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiFIQWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:22:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE64E3AA;
        Thu,  9 Jun 2022 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654791756; x=1686327756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YWfsZPP8YET9e13ubK9QXgx+cvFXScE1tK7NBcbgUwg=;
  b=gLIGGLh8oMBZHR0zMpCsqcWqmFVdVOE9SyGfz2ad1Hz2y1+J/L+fVuvn
   gsAcT1PqPt+q3oKHjgFM+HPUiKGeNae2e9gJ585aOaXTLVhgENB0r7pYY
   4FIkeW+rdiNDsh+ij/4uK2B28uLtPxXIoP1QD36+BIa6q+BMUydM37mK7
   iq3wy9nthffRSlMeaJrg2KkoYjvnM9TIfMqP3dRVSTulnT5CSs5+WOmOX
   vRf+6X/qBKxny28Zn4xRLW/g+Ksd/N1Vnmnl1Dw4t7uxa5M7MqmrmIBIj
   cW/DeZ4+x7r6coYGi9oUmEVZaV7+0D7zxTZ1IVHHMQzGUt5AMPH+Gutbq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="277364147"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277364147"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 09:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585661841"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2022 09:22:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 73BA1F8; Thu,  9 Jun 2022 19:22:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Denis Osterland-Heim <Denis.Osterland@diehl.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 1/1] leds: core: Refactor led_update_brightness() to use standard pattern
Date:   Thu,  9 Jun 2022 19:22:33 +0300
Message-Id: <20220609162233.80498-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard conditional pattern is to check for errors first and
bail out if any. Refactor led_update_brightness() accordingly.

While at it, drop unneeded assignment and return 0 unconditionally
on success.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/led-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 4a97cb745788..96a2817712e5 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -304,17 +304,17 @@ EXPORT_SYMBOL_GPL(led_set_brightness_sync);
 
 int led_update_brightness(struct led_classdev *led_cdev)
 {
-	int ret = 0;
+	int ret;
 
 	if (led_cdev->brightness_get) {
 		ret = led_cdev->brightness_get(led_cdev);
-		if (ret >= 0) {
-			led_cdev->brightness = ret;
-			return 0;
-		}
+		if (ret < 0)
+			return ret;
+
+		led_cdev->brightness = ret;
 	}
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(led_update_brightness);
 
-- 
2.35.1

