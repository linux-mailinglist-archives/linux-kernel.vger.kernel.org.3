Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55F74E9591
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiC1LqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243688AbiC1Lgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:36:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91C61AD85;
        Mon, 28 Mar 2022 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648466928; x=1680002928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/jknjSpLX3mZ3CtFwnlyAgjjlnxVVCt9rxwjRusRsWQ=;
  b=T4hhyUOrMHsN53zmf7AmiG5RllLjCvgd+rCDJg8TUa+AKXGxiNPmjQes
   EJaaarROIKE5bAUY68Fep6TkoK7pPodYDyo6fW7Sz5fC3DFjlXu13Fsrj
   ow0LTUI11W4nKAtRxw/76Kn/5VFyPhQ/L6UDT7/9WuE8doPeOjT8JLDO+
   d+xwlFM6tk1srCW0xEsgkAGAHE1eB1qkBxQhfoWezbxk/BU+Fl3ix/wce
   N6hIzH5/AMOt93ZCzLqJcZxgoilT0do60+dAF/LycppOA0yxhKUclzTi4
   9nuQ/vxpY1nywpMokrJ9duJVCVR3By33jk8e/OPlCdMLWvIxfugDG3dPZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="238907856"
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="238907856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 04:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,217,1643702400"; 
   d="scan'208";a="649026662"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2022 04:28:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DD2BA18E; Mon, 28 Mar 2022 14:28:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpiolib: Get rid of redundant 'else' (part 2)
Date:   Mon, 28 Mar 2022 14:28:56 +0300
Message-Id: <20220328112856.404-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

the 'else' is redundant. Get rid of it by using switch-case pattern.
Note that the pattern seems more usual for IOCTL handlers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c | 66 ++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 31 deletions(-)

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
-- 
2.35.1

