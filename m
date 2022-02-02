Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACB84A79A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347248AbiBBUlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:41:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:64552 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236025AbiBBUlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643834463; x=1675370463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fwqpD2EU+5lo59KNZLuxS0tYAkWcxiSqD82vE7PYk2o=;
  b=OFdlf4pasySv2U1N7wOdZqrpFC2+r8mDoyjwsHfiACkiG8pxa9PXD5Ce
   hT9cSLv+25aYCIzahX37i6F3ZjAJlHXc7yfAR7tb4bCR/ZKhPJYmx/U1X
   OGL+sxFxircn/MBLd3LUIYZiab9AnMkSUPNmrzVfDZXi6RLvSbvbjIYtw
   3lbSb2yOZyCLN9Yf0niLQWM7nZioOpSkb2D5D9PYK3RSIIGYXZKo9yooE
   HntdBSopLnplpI1jsxWqusQkmIg4QL4S4QZecdpspjwZIsnfboUVSMT7r
   GCxs0NzNMFXEM8bwQkon+f/Fzfs3cUpnRw7X2gju9rQAwEixojwals6Ib
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="245612904"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="245612904"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="676567335"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2022 12:41:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 629033B7; Wed,  2 Feb 2022 22:41:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v2 1/1] iio: trigger: stm32-timer: Make use of device properties
Date:   Wed,  2 Feb 2022 22:41:12 +0200
Message-Id: <20220202204112.57095-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped depends on OF
 drivers/iio/trigger/Kconfig               |  2 +-
 drivers/iio/trigger/stm32-timer-trigger.c | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index 8cef2f7452e8..7ecb69725b1d 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -38,7 +38,7 @@ config IIO_STM32_LPTIMER_TRIGGER
 
 config IIO_STM32_TIMER_TRIGGER
 	tristate "STM32 Timer Trigger"
-	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST
+	depends on (ARCH_STM32 && MFD_STM32_TIMERS) || COMPILE_TEST
 	help
 	  Select this option to enable STM32 Timer Trigger
 
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 4f9461e1412c..5049d9ecfc1a 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -11,9 +11,10 @@
 #include <linux/iio/timer/stm32-timer-trigger.h>
 #include <linux/iio/trigger.h>
 #include <linux/mfd/stm32-timers.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 
 #define MAX_TRIGGERS 7
 #define MAX_VALIDS 5
@@ -771,11 +772,11 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
 	unsigned int index;
 	int ret;
 
-	if (of_property_read_u32(dev->of_node, "reg", &index))
-		return -EINVAL;
+	ret = device_property_read_u32(dev, "reg", &index);
+	if (ret)
+		return ret;
 
-	cfg = (const struct stm32_timer_trigger_cfg *)
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	cfg = device_get_match_data(dev);
 
 	if (index >= ARRAY_SIZE(triggers_table) ||
 	    index >= cfg->num_valids_table)
-- 
2.34.1

