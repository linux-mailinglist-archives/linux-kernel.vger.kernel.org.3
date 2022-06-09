Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB59D5451B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbiFIQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiFIQSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:18:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D25255BE;
        Thu,  9 Jun 2022 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654791509; x=1686327509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jDwIvrStzFCkO3+uU1hBruU1f1KWSJCEV7XxyHJuuGo=;
  b=CPpO5rdVknJu33l1nkmz1Wf3gXytJYcw80e27uq1yTAK62WEL2hKO6+c
   Go1blB9kQbsfVYGFQnu1sLix8nqMtawO6Z76iKWC6GkzO07n/+zdVEjWe
   v2GkdKFwN65Gvw/xNAWV/yVs94EOU6LTL7ZICN+REESRuT53g7NRwtuQm
   hK/cA0Zx9jiW/JXqcAH6M2RT5kfXYzyvEsDsXKCQ769MCpXD+vn39Juzb
   I7eLS5H5P+DuBJy0a11dAdWtwXPXpKP3vlHcfMra3HbnQef82jjt+vHbt
   zVlIohe56xfq9mboHsULszyPuEumlCYjQoB6TMvTQ3qw1pIStIiBG2Q+G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341410590"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="341410590"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 09:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="671386279"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2022 09:18:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CA7C8F8; Thu,  9 Jun 2022 19:18:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 1/1] leds: trigger: gpio: Convert to use kstrtox()
Date:   Thu,  9 Jun 2022 19:18:29 +0300
Message-Id: <20220609161829.80312-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sscanf() is a heavy one and moreover requires additional boundary checks.
Convert driver to use kstrtox() and replace kstrtoul() by kstrtobool()
in gpio_trig_inverted_store().

While here, check the desired brightness against maximum defined for
a certain LED.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/trigger/ledtrig-gpio.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-gpio.c b/drivers/leds/trigger/ledtrig-gpio.c
index 0120faa3dafa..19e43333457a 100644
--- a/drivers/leds/trigger/ledtrig-gpio.c
+++ b/drivers/leds/trigger/ledtrig-gpio.c
@@ -60,10 +60,10 @@ static ssize_t gpio_trig_brightness_store(struct device *dev,
 	unsigned desired_brightness;
 	int ret;
 
-	ret = sscanf(buf, "%u", &desired_brightness);
-	if (ret < 1 || desired_brightness > 255) {
+	ret = kstrtouint(buf, 10, &desired_brightness);
+	if (ret || desired_brightness > gpio_data->led->max_brightness) {
 		dev_err(dev, "invalid value\n");
-		return -EINVAL;
+		return ret ?: -EINVAL;
 	}
 
 	gpio_data->desired_brightness = desired_brightness;
@@ -86,16 +86,13 @@ static ssize_t gpio_trig_inverted_store(struct device *dev,
 {
 	struct led_classdev *led = led_trigger_get_led(dev);
 	struct gpio_trig_data *gpio_data = led_trigger_get_drvdata(dev);
-	unsigned long inverted;
+	bool inverted;
 	int ret;
 
-	ret = kstrtoul(buf, 10, &inverted);
-	if (ret < 0)
+	ret = kstrtobool(buf, &inverted);
+	if (ret)
 		return ret;
 
-	if (inverted > 1)
-		return -EINVAL;
-
 	gpio_data->inverted = inverted;
 
 	/* After inverting, we need to update the LED. */
@@ -123,10 +120,10 @@ static ssize_t gpio_trig_gpio_store(struct device *dev,
 	unsigned gpio;
 	int ret;
 
-	ret = sscanf(buf, "%u", &gpio);
-	if (ret < 1) {
+	ret = kstrtouint(buf, 10, &gpio);
+	if (ret) {
 		dev_err(dev, "couldn't read gpio number\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	if (gpio_data->gpio == gpio)
-- 
2.35.1

