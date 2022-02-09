Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFD4AF0BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiBIMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiBIMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:34 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D52AE016D80;
        Wed,  9 Feb 2022 03:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644406268; x=1675942268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pKV+DxBkKcBuF61qtrbuKT/b/K15VgPMWS7LUskpF7k=;
  b=ZdPj9YunJnUTSMKWyDfiWfGUdcd2safxFM5GgfHDJVUsdnhRvrPBNGBL
   bwp/pqCeL7fZwCwSYNcygd0GkpCigxuaeGraFK1dP/u17GBPytxvYGq49
   MgmloM4u7mcEdT0vltcBPXe2e5fIbvkZAiuOP3hLeBHRu7o9VeFpdfNHS
   3MOMjk91gBiPOTLjtgllCTVYG51zwVfqoAhae56St3gxdg+U3n74b1xqd
   1LBh8mHrhUDHJNlDQe0Yg1FdR95cxnKKrvwZLTsICZu8HMS8QFxNSNGs1
   d048cPRHfG3jDKFamCcVFY62rgKe9eyT+vO6NOFZCUOD06jNjepNQk9dR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249131236"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="249131236"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:31:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="678524213"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 03:31:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 43BF853E; Wed,  9 Feb 2022 13:31:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 3/3] gpiolib: sysfs: Simplify edge handling in the code
Date:   Wed,  9 Feb 2022 13:31:17 +0200
Message-Id: <20220209113117.25760-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209113117.25760-1-andriy.shevchenko@linux.intel.com>
References: <20220209113117.25760-1-andriy.shevchenko@linux.intel.com>
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

Instead of keeping specific data structure for IRQ trigger types, switch
to array of trigger names and use index as a type.

The code is in maintenance mode and that array is not going to grow.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-sysfs.c | 40 +++++++++++++-----------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index e7828d4dc7a8..d44ffea038f5 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -13,6 +13,7 @@
 #include "gpiolib.h"
 #include "gpiolib-sysfs.h"
 
+#define GPIO_IRQF_TRIGGER_NONE		0
 #define GPIO_IRQF_TRIGGER_FALLING	BIT(0)
 #define GPIO_IRQF_TRIGGER_RISING	BIT(1)
 #define GPIO_IRQF_TRIGGER_BOTH		(GPIO_IRQF_TRIGGER_FALLING | \
@@ -218,54 +219,41 @@ static void gpio_sysfs_free_irq(struct device *dev)
 	sysfs_put(data->value_kn);
 }
 
-static const struct {
-	const char *name;
-	unsigned char flags;
-} trigger_types[] = {
-	{ "none",    0 },
-	{ "falling", GPIO_IRQF_TRIGGER_FALLING },
-	{ "rising",  GPIO_IRQF_TRIGGER_RISING },
-	{ "both",    GPIO_IRQF_TRIGGER_BOTH },
+static const char * const trigger_names[] = {
+	[GPIO_IRQF_TRIGGER_NONE]	= "none",
+	[GPIO_IRQF_TRIGGER_FALLING]	= "falling",
+	[GPIO_IRQF_TRIGGER_RISING]	= "rising",
+	[GPIO_IRQF_TRIGGER_BOTH]	= "both",
 };
 
 static ssize_t edge_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct gpiod_data *data = dev_get_drvdata(dev);
-	int i;
+	int flags;
 
 	mutex_lock(&data->mutex);
 
-	for (i = 0; i < ARRAY_SIZE(trigger_types); i++) {
-		if (data->irq_flags == trigger_types[i].flags)
-			break;
-	}
+	flags = data->irq_flags;
 
 	mutex_unlock(&data->mutex);
 
-	if (i >= ARRAY_SIZE(trigger_types))
+	if (flags >= ARRAY_SIZE(trigger_names))
 		return 0;
 
-	return sysfs_emit(buf, "%s\n", trigger_types[i].name);
+	return sysfs_emit(buf, "%s\n", trigger_names[flags]);
 }
 
 static ssize_t edge_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
 	struct gpiod_data *data = dev_get_drvdata(dev);
-	unsigned char flags;
 	ssize_t	status = size;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(trigger_types); i++) {
-		if (sysfs_streq(trigger_types[i].name, buf))
-			break;
-	}
-
-	if (i == ARRAY_SIZE(trigger_types))
-		return -EINVAL;
+	int flags;
 
-	flags = trigger_types[i].flags;
+	flags = sysfs_match_string(trigger_names, buf);
+	if (flags < 0)
+		return flags;
 
 	mutex_lock(&data->mutex);
 
-- 
2.34.1

