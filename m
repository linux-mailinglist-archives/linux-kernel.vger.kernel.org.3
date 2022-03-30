Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141FB4EC7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347876AbiC3PIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347829AbiC3PIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE899ED3;
        Wed, 30 Mar 2022 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648652794; x=1680188794;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PgsgGzrSvF1z4wh9ANmYA9oN2iOOjlIiDmLw90JAtHw=;
  b=l193jesOEZJEHwuR3nY/C7u1QGN/t2bPvnCfqQahKU+Ey1tIOolf+j/p
   Q2LQoNNepRZDrz/89Hajd0+tU9emMvX6IWGkzzsYf9mIHCYo62gzdOQ3E
   3nIVviP/1704hn67N1Wir31Ci8JYMjiHygpVNpyj6II6FY63lVjX8EWeB
   gA7IrHhynb1seeZ/jFJ3fXPv8+6EB6H3nHsVMvyxwaOqRFlFVLrRFYEmO
   T6VoRbzqi+pEzYvmLaFds0t3D8opNiYLhAgJ88jOJYLCK2upE1xKsp1AU
   fEvONaWjkn4gEWEAPLT2brNNId8gFoYo/Bzs+0LD9jgi5ty4IOltntZUg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="240161581"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="240161581"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="653864413"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 30 Mar 2022 08:06:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95812144; Wed, 30 Mar 2022 18:06:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 1/1] gpiolib: Get rid of redundant 'else'
Date:   Wed, 30 Mar 2022 18:06:20 +0300
Message-Id: <20220330150620.2490-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it. In case of IOCTLs use
switch-case pattern that seems the usual in such cases.

While at it, clarify necessity of else in gpiod_direction_output()
by attaching else if to the closing curly brace on a previous line.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: unified with 'part 1' of the change
 drivers/gpio/gpiolib-cdev.c | 66 ++++++++++++++++++++-----------------
 drivers/gpio/gpiolib.c      | 12 +++----
 2 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ffa0256cad5a..c2900b1be69d 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -197,16 +197,15 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
 	DECLARE_BITMAP(vals, GPIOHANDLES_MAX);
-	int i;
+	unsigned int i;
+	int ret;
 
-	if (cmd == GPIOHANDLE_GET_LINE_VALUES_IOCTL) {
-		/* NOTE: It's ok to read values of output lines. */
-		int ret = gpiod_get_array_value_complex(false,
-							true,
-							lh->num_descs,
-							lh->descs,
-							NULL,
-							vals);
+	switch (cmd) {
+	case GPIOHANDLE_GET_LINE_VALUES_IOCTL:
+		/* NOTE: It's okay to read values of output lines */
+		ret = gpiod_get_array_value_complex(false, true,
+						    lh->num_descs, lh->descs,
+						    NULL, vals);
 		if (ret)
 			return ret;
 
@@ -218,7 +217,7 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 			return -EFAULT;
 
 		return 0;
-	} else if (cmd == GPIOHANDLE_SET_LINE_VALUES_IOCTL) {
+	case GPIOHANDLE_SET_LINE_VALUES_IOCTL:
 		/*
 		 * All line descriptors were created at once with the same
 		 * flags so just check if the first one is really output.
@@ -240,10 +239,11 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
 						     lh->descs,
 						     NULL,
 						     vals);
-	} else if (cmd == GPIOHANDLE_SET_CONFIG_IOCTL) {
+	case GPIOHANDLE_SET_CONFIG_IOCTL:
 		return linehandle_set_config(lh, ip);
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
 }
 
 #ifdef CONFIG_COMPAT
@@ -1188,14 +1188,16 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
 	struct linereq *lr = file->private_data;
 	void __user *ip = (void __user *)arg;
 
-	if (cmd == GPIO_V2_LINE_GET_VALUES_IOCTL)
+	switch (cmd) {
+	case GPIO_V2_LINE_GET_VALUES_IOCTL:
 		return linereq_get_values(lr, ip);
-	else if (cmd == GPIO_V2_LINE_SET_VALUES_IOCTL)
+	case GPIO_V2_LINE_SET_VALUES_IOCTL:
 		return linereq_set_values(lr, ip);
-	else if (cmd == GPIO_V2_LINE_SET_CONFIG_IOCTL)
+	case GPIO_V2_LINE_SET_CONFIG_IOCTL:
 		return linereq_set_config(lr, ip);
-
-	return -EINVAL;
+	default:
+		return -EINVAL;
+	}
 }
 
 #ifdef CONFIG_COMPAT
@@ -2113,28 +2115,30 @@ static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return -ENODEV;
 
 	/* Fill in the struct and pass to userspace */
-	if (cmd == GPIO_GET_CHIPINFO_IOCTL) {
+	switch (cmd) {
+	case GPIO_GET_CHIPINFO_IOCTL:
 		return chipinfo_get(cdev, ip);
 #ifdef CONFIG_GPIO_CDEV_V1
-	} else if (cmd == GPIO_GET_LINEHANDLE_IOCTL) {
+	case GPIO_GET_LINEHANDLE_IOCTL:
 		return linehandle_create(gdev, ip);
-	} else if (cmd == GPIO_GET_LINEEVENT_IOCTL) {
+	case GPIO_GET_LINEEVENT_IOCTL:
 		return lineevent_create(gdev, ip);
-	} else if (cmd == GPIO_GET_LINEINFO_IOCTL ||
-		   cmd == GPIO_GET_LINEINFO_WATCH_IOCTL) {
-		return lineinfo_get_v1(cdev, ip,
-				       cmd == GPIO_GET_LINEINFO_WATCH_IOCTL);
+	case GPIO_GET_LINEINFO_IOCTL:
+		return lineinfo_get_v1(cdev, ip, false);
+	case GPIO_GET_LINEINFO_WATCH_IOCTL:
+		return lineinfo_get_v1(cdev, ip, true);
 #endif /* CONFIG_GPIO_CDEV_V1 */
-	} else if (cmd == GPIO_V2_GET_LINEINFO_IOCTL ||
-		   cmd == GPIO_V2_GET_LINEINFO_WATCH_IOCTL) {
-		return lineinfo_get(cdev, ip,
-				    cmd == GPIO_V2_GET_LINEINFO_WATCH_IOCTL);
-	} else if (cmd == GPIO_V2_GET_LINE_IOCTL) {
+	case GPIO_V2_GET_LINEINFO_IOCTL:
+		return lineinfo_get(cdev, ip, false);
+	case GPIO_V2_GET_LINEINFO_WATCH_IOCTL:
+		return lineinfo_get(cdev, ip, true);
+	case GPIO_V2_GET_LINE_IOCTL:
 		return linereq_create(gdev, ip);
-	} else if (cmd == GPIO_GET_LINEINFO_UNWATCH_IOCTL) {
+	case GPIO_GET_LINEINFO_UNWATCH_IOCTL:
 		return lineinfo_unwatch(cdev, ip);
+	default:
+		return -EINVAL;
 	}
-	return -EINVAL;
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 062d127d9a0d..04636ebf4cd8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -189,9 +189,8 @@ static int gpiochip_find_base(int ngpio)
 		/* found a free space? */
 		if (gdev->base + gdev->ngpio <= base)
 			break;
-		else
-			/* nope, check the space right before the chip */
-			base = gdev->base - ngpio;
+		/* nope, check the space right before the chip */
+		base = gdev->base - ngpio;
 	}
 
 	if (gpio_is_valid(base)) {
@@ -2397,8 +2396,7 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 			ret = gpiod_direction_input(desc);
 			goto set_output_flag;
 		}
-	}
-	else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags)) {
+	} else if (test_bit(FLAG_OPEN_SOURCE, &desc->flags)) {
 		ret = gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_SOURCE);
 		if (!ret)
 			goto set_output_value;
@@ -2555,9 +2553,9 @@ static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 static int gpio_chip_get_multiple(struct gpio_chip *gc,
 				  unsigned long *mask, unsigned long *bits)
 {
-	if (gc->get_multiple) {
+	if (gc->get_multiple)
 		return gc->get_multiple(gc, mask, bits);
-	} else if (gc->get) {
+	if (gc->get) {
 		int i, value;
 
 		for_each_set_bit(i, mask, gc->ngpio) {
-- 
2.35.1

