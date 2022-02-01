Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACA74A6011
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbiBAP2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:28:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:35546 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240295AbiBAP2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643729287; x=1675265287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53v0SZToCLIARppBG37WEJCY4si1DtBhWyxSdKKHSVM=;
  b=aX1AdOTr2/oQFpDR2CLL5As2J8cMsEHB8Twq2N4qTDfWjn8+vM3xy+yV
   OsUvGT8rOOAnGfhsKayhRgpGibgocStyQ7yirEjP9bbjtxruNxsYTFAIH
   yCYl0Gt/yl9YHnXIZ9hlQyo9jo5U+xlodgfSASNsCpvQphAgfqb0CuI7a
   I3+6F8k7KhK5eEvC8466e/7TviX3r/la2SLPDfpHd+LAZNUBTQ7zwl78J
   J97/Puf2eB9y/K7I55N2yDj+SGgS830M+uN1SOTZtnG5FITKwu0fJ9R/c
   1b+EMLXheiVvdtCmlmjc0w5se25P5kmHq8SDhXeAOaZtLnWhO6hs0fFEq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="311021856"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="311021856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="626763018"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2022 07:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D7C4710E; Tue,  1 Feb 2022 17:28:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Suresh Balakrishnan <suresh.balakrishnan@intel.com>
Subject: [PATCH v3 1/4] gpiolib: Never return internal error codes to user space
Date:   Tue,  1 Feb 2022 17:27:55 +0200
Message-Id: <20220201152758.40391-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
References: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it's possible that character device interface may return
the error codes which are not supposed to be seen by user space.
In this case it's EPROBE_DEFER.

Wrap it to return -ENODEV instead as sysfs does.

Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
Reported-by: Suresh Balakrishnan <suresh.balakrishnan@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c  |  6 +++---
 drivers/gpio/gpiolib-sysfs.c |  7 ++-----
 drivers/gpio/gpiolib.h       | 12 ++++++++++++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index c7b5446d01fd..ffa0256cad5a 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -330,7 +330,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 			goto out_free_lh;
 		}
 
-		ret = gpiod_request(desc, lh->label);
+		ret = gpiod_request_user(desc, lh->label);
 		if (ret)
 			goto out_free_lh;
 		lh->descs[i] = desc;
@@ -1378,7 +1378,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			goto out_free_linereq;
 		}
 
-		ret = gpiod_request(desc, lr->label);
+		ret = gpiod_request_user(desc, lr->label);
 		if (ret)
 			goto out_free_linereq;
 
@@ -1764,7 +1764,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 		}
 	}
 
-	ret = gpiod_request(desc, le->label);
+	ret = gpiod_request_user(desc, le->label);
 	if (ret)
 		goto out_free_le;
 	le->desc = desc;
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 4098bc7f88b7..44c1ad51b3fe 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -475,12 +475,9 @@ static ssize_t export_store(struct class *class,
 	 * they may be undone on its behalf too.
 	 */
 
-	status = gpiod_request(desc, "sysfs");
-	if (status) {
-		if (status == -EPROBE_DEFER)
-			status = -ENODEV;
+	status = gpiod_request_user(desc, "sysfs");
+	if (status)
 		goto done;
-	}
 
 	status = gpiod_set_transitory(desc, false);
 	if (!status) {
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 30bc3f80f83e..c31f4626915d 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -135,6 +135,18 @@ struct gpio_desc {
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
 void gpiod_free(struct gpio_desc *desc);
+
+static inline int gpiod_request_user(struct gpio_desc *desc, const char *label)
+{
+	int ret;
+
+	ret = gpiod_request(desc, label);
+	if (ret == -EPROBE_DEFER)
+		ret = -ENODEV;
+
+	return ret;
+}
+
 int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags);
 int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
-- 
2.34.1

