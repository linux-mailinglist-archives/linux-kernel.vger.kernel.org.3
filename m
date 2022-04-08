Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F74F9C6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiDHSV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiDHSVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:21:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45F11A545;
        Fri,  8 Apr 2022 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649441991; x=1680977991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EphYyiMevZDlJs+2824J9QD6Peqsq22Jz9uC9UNYWl0=;
  b=fT6ifnCRh5tUethjQaRABMDlhA2QNDB3wGST7CY+yupuFAkHjcM6GNos
   AIDoqGt0csOAUIKOk9HTmU/o45c/NtwIX7KgSK7J3i4KlOvFEznwBsQ8z
   /D2LE2HM9pnhquWrTdvf+SkhKCw8M43VI8nE2UmQKP5EKggxWTUurJIni
   qkkeMZfPqdtNKOh+8m+LLmR+Oh1BkkfZ0yWKrWZdnX7fCDu1C2JJMMF1E
   obw9tpub5zaawS2QLzwcQ8bD9y9ALE1+EDM6eBW9GgoGKvsKR3PGNMQsM
   bLdWiKvBgEzIyPLVav2TFUEneW63Y+zMd5Gu8YW3c0nPuYZonipzAu38w
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="242253245"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="242253245"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="557874351"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2022 11:19:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0D5FE144; Fri,  8 Apr 2022 21:18:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/5] gpiolib: Embed iterator variable into for_each_gpio_desc_with_flag()
Date:   Fri,  8 Apr 2022 21:18:50 +0300
Message-Id: <20220408181854.73528-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iterator loop is used exclusively to get a descriptor, which in its
turn is what is being used by the caller. Embed the iterator variable
into the loop in the for_each_gpio_desc_with_flag() macro helper.

Suggested-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/gpio/gpiolib-of.c    | 3 +--
 drivers/gpio/gpiolib-sysfs.c | 3 +--
 drivers/gpio/gpiolib.c       | 3 +--
 drivers/gpio/gpiolib.h       | 8 ++++----
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ae1ce319cd78..47c0e07802d6 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -712,9 +712,8 @@ static void of_gpiochip_remove_hog(struct gpio_chip *chip,
 				   struct device_node *hog)
 {
 	struct gpio_desc *desc;
-	unsigned int i;
 
-	for_each_gpio_desc_with_flag(i, chip, desc, FLAG_IS_HOGGED)
+	for_each_gpio_desc_with_flag(chip, desc, FLAG_IS_HOGGED)
 		if (desc->hog == hog)
 			gpiochip_free_own_desc(desc);
 }
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index d44ffea038f5..cd27bf173dec 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -760,7 +760,6 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 {
 	struct gpio_desc *desc;
 	struct gpio_chip *chip = gdev->chip;
-	unsigned int i;
 
 	if (!gdev->mockdev)
 		return;
@@ -773,7 +772,7 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	mutex_unlock(&sysfs_lock);
 
 	/* unregister gpiod class devices owned by sysfs */
-	for_each_gpio_desc_with_flag(i, chip, desc, FLAG_SYSFS)
+	for_each_gpio_desc_with_flag(chip, desc, FLAG_SYSFS)
 		gpiod_free(desc);
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a199d2ff7689..96b5da6a8c3b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4138,9 +4138,8 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 static void gpiochip_free_hogs(struct gpio_chip *gc)
 {
 	struct gpio_desc *desc;
-	int id;
 
-	for_each_gpio_desc_with_flag(id, gc, desc, FLAG_IS_HOGGED)
+	for_each_gpio_desc_with_flag(gc, desc, FLAG_IS_HOGGED)
 		gpiochip_free_own_desc(desc);
 }
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 06f3faa9fbef..7bac62d36f0c 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -100,10 +100,10 @@ struct gpio_array {
 
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 
-#define for_each_gpio_desc_with_flag(i, gc, desc, flag)		\
-	for (i = 0, desc = gpiochip_get_desc(gc, i);		\
-	     i < gc->ngpio;					\
-	     i++, desc = gpiochip_get_desc(gc, i))		\
+#define for_each_gpio_desc_with_flag(gc, desc, flag)			\
+	for (unsigned int __i = 0;					\
+	     __i < gc->ngpio && (desc = gpiochip_get_desc(gc, __i));	\
+	     __i++)							\
 		if (!test_bit(flag, &desc->flags)) {} else
 
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
-- 
2.35.1

