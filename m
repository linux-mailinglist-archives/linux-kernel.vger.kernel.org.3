Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB17C555262
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359765AbiFVR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377431AbiFVR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:28:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABBB6257;
        Wed, 22 Jun 2022 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655918921; x=1687454921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mMzbNFYrVsEjYMboVVdaTRJ6WGulZhS+fbjcnLtblGY=;
  b=krWqYvmCPI1RoIOq1jM2emJf54O/FMEuxpBWt0yWjLZztd2tcORG90Ti
   RV2dWIrXp5fEMRV8j+FLiIFBzIjsjt5RBe2GpdiuTr8UReCdoRu7uY8r1
   UcbQaXqR3bgdiYjPELWHPlLnOibb1wGB0ExRsziG6SzlgS4T3x5pcwMEA
   JsCTONcJGwIUp89jn/XtII7U9ID8mGYn4Q5n6DrBizTuQyfexuA/iP29y
   hFpD5JaXreETf0WmDM9nuajyfikg0mmHPhsfkGOyF6FkiDEGuUKplA818
   idXmavr/zGwKkY/lVjzArwaa8DglesfWvFJK8bkg3gpzcdwNbOu8C0Hga
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344473675"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="344473675"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="834223597"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 10:28:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 469FB136; Wed, 22 Jun 2022 20:28:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpiolib: devres: Get rid of unused devm_gpio_free()
Date:   Wed, 22 Jun 2022 20:28:42 +0300
Message-Id: <20220622172842.86713-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last user, which in fact was a dead code, has gone a year ago,
previous one 3 years ago. On top of that we want to drop away the
legacy GPIO APIs in the kernel, so take a chance to get rid of
unused devm_gpio_free() and accompanying stuff.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/gpio/gpiolib-devres.c                 | 32 -------------------
 include/linux/gpio.h                          |  6 ----
 3 files changed, 39 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 2d39967bafcc..55272942e721 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -277,7 +277,6 @@ GPIO
   devm_gpiochip_add_data()
   devm_gpio_request()
   devm_gpio_request_one()
-  devm_gpio_free()
 
 I2C
   devm_i2c_new_dummy_device()
diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 79da85d17b71..16a696249229 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -375,9 +375,6 @@ void devm_gpiod_put_array(struct device *dev, struct gpio_descs *descs)
 }
 EXPORT_SYMBOL_GPL(devm_gpiod_put_array);
 
-
-
-
 static void devm_gpio_release(struct device *dev, void *res)
 {
 	unsigned *gpio = res;
@@ -385,13 +382,6 @@ static void devm_gpio_release(struct device *dev, void *res)
 	gpio_free(*gpio);
 }
 
-static int devm_gpio_match(struct device *dev, void *res, void *data)
-{
-	unsigned *this = res, *gpio = data;
-
-	return *this == *gpio;
-}
-
 /**
  *      devm_gpio_request - request a GPIO for a managed device
  *      @dev: device to request the GPIO for
@@ -402,11 +392,7 @@ static int devm_gpio_match(struct device *dev, void *res, void *data)
  *      same arguments and performs the same function as
  *      gpio_request().  GPIOs requested with this function will be
  *      automatically freed on driver detach.
- *
- *      If an GPIO allocated with this function needs to be freed
- *      separately, devm_gpio_free() must be used.
  */
-
 int devm_gpio_request(struct device *dev, unsigned gpio, const char *label)
 {
 	unsigned *dr;
@@ -459,24 +445,6 @@ int devm_gpio_request_one(struct device *dev, unsigned gpio,
 }
 EXPORT_SYMBOL_GPL(devm_gpio_request_one);
 
-/**
- *      devm_gpio_free - free a GPIO
- *      @dev: device to free GPIO for
- *      @gpio: GPIO to free
- *
- *      Except for the extra @dev argument, this function takes the
- *      same arguments and performs the same function as gpio_free().
- *      This function instead of gpio_free() should be used to manually
- *      free GPIOs allocated with devm_gpio_request().
- */
-void devm_gpio_free(struct device *dev, unsigned int gpio)
-{
-
-	WARN_ON(devres_release(dev, devm_gpio_release, devm_gpio_match,
-		&gpio));
-}
-EXPORT_SYMBOL_GPL(devm_gpio_free);
-
 static void devm_gpio_chip_release(void *data)
 {
 	struct gpio_chip *gc = data;
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 008ad3ee56b7..a370387fa406 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -95,7 +95,6 @@ struct device;
 int devm_gpio_request(struct device *dev, unsigned gpio, const char *label);
 int devm_gpio_request_one(struct device *dev, unsigned gpio,
 			  unsigned long flags, const char *label);
-void devm_gpio_free(struct device *dev, unsigned int gpio);
 
 #else /* ! CONFIG_GPIOLIB */
 
@@ -240,11 +239,6 @@ static inline int devm_gpio_request_one(struct device *dev, unsigned gpio,
 	return -EINVAL;
 }
 
-static inline void devm_gpio_free(struct device *dev, unsigned int gpio)
-{
-	WARN_ON(1);
-}
-
 #endif /* ! CONFIG_GPIOLIB */
 
 #endif /* __LINUX_GPIO_H */
-- 
2.35.1

