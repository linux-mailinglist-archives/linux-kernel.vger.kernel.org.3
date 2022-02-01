Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803E94A6010
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbiBAP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:28:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:22946 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240292AbiBAP2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643729286; x=1675265286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CwGMEFXpkbxu+zKpe5/jEY5E4cN6695jvssvr02AQcA=;
  b=lZ1PiSXX4WdxOa2mrWkQFJsnH9u3iq34w+2BEwM33NUYLnSl51PB/65I
   8Psao8OTTXwTZswK3ppZwwQYahuxnEUc28Xew8ia/sYHDEoKaY+HwR0yV
   mNhTnqUw5yD/Ha9xv0jSwV+IDrnBbfvsL3RWxUO3ar8bydLXtCSh/dVH6
   oduu/ggqEvJ6JxFAYn28aGnB0Gybaslh5ux/1HAIgqixE/qT/gcukufWa
   0raY11ejtNIQpS2WdMIO2ZQ6jZbkUS3S8xcnUhGlFU9SYsJEHJn2s34LK
   wJGsNxxpt1NXHtERdQliFauxfejru49fjExbobAuGK/6GJKvL4HlVsFV8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="228372283"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="228372283"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="698436658"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2022 07:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E022A40C; Tue,  1 Feb 2022 17:28:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 2/4] gpiolib: Introduce for_each_gpio_desc_with_flag() macro
Date:   Tue,  1 Feb 2022 17:27:56 +0200
Message-Id: <20220201152758.40391-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
References: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a few places we are using a loop against all GPIO descriptors
with a given flag for a given device. Replace it with a consolidated
for_each type of macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-of.c    | 10 ++++------
 drivers/gpio/gpiolib-sysfs.c |  7 ++-----
 drivers/gpio/gpiolib.c       |  7 +++----
 drivers/gpio/gpiolib.h       |  7 +++++++
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 91dcf2c6cdd8..ae1ce319cd78 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -711,14 +711,12 @@ static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
 static void of_gpiochip_remove_hog(struct gpio_chip *chip,
 				   struct device_node *hog)
 {
-	struct gpio_desc *descs = chip->gpiodev->descs;
+	struct gpio_desc *desc;
 	unsigned int i;
 
-	for (i = 0; i < chip->ngpio; i++) {
-		if (test_bit(FLAG_IS_HOGGED, &descs[i].flags) &&
-		    descs[i].hog == hog)
-			gpiochip_free_own_desc(&descs[i]);
-	}
+	for_each_gpio_desc_with_flag(i, chip, desc, FLAG_IS_HOGGED)
+		if (desc->hog == hog)
+			gpiochip_free_own_desc(desc);
 }
 
 static int of_gpiochip_match_node(struct gpio_chip *chip, void *data)
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 44c1ad51b3fe..78ca7dee8b64 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -790,11 +790,8 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	mutex_unlock(&sysfs_lock);
 
 	/* unregister gpiod class devices owned by sysfs */
-	for (i = 0; i < chip->ngpio; i++) {
-		desc = &gdev->descs[i];
-		if (test_and_clear_bit(FLAG_SYSFS, &desc->flags))
-			gpiod_free(desc);
-	}
+	for_each_gpio_desc_with_flag(i, chip, desc, FLAG_SYSFS)
+		gpiod_free(desc);
 }
 
 static int __init gpiolib_sysfs_init(void)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3859911b61e9..e3702bc1b533 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4102,12 +4102,11 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
  */
 static void gpiochip_free_hogs(struct gpio_chip *gc)
 {
+	struct gpio_desc *desc;
 	int id;
 
-	for (id = 0; id < gc->ngpio; id++) {
-		if (test_bit(FLAG_IS_HOGGED, &gc->gpiodev->descs[id].flags))
-			gpiochip_free_own_desc(&gc->gpiodev->descs[id]);
-	}
+	for_each_gpio_desc_with_flag(id, gc, desc, FLAG_IS_HOGGED)
+		gpiochip_free_own_desc(desc);
 }
 
 /**
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index c31f4626915d..dbbad15607e3 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -82,6 +82,13 @@ struct gpio_array {
 };
 
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
+
+#define for_each_gpio_desc_with_flag(i, gc, desc, flag)		\
+	for (i = 0, desc = gpiochip_get_desc(gc, i);		\
+	     i < gc->ngpio;					\
+	     i++, desc = gpiochip_get_desc(gc, i))		\
+		if (!test_bit(flag, &desc->flags)) {} else
+
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
 				  unsigned int array_size,
 				  struct gpio_desc **desc_array,
-- 
2.34.1

