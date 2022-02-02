Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E744A7738
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiBBR6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:58:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:58969 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346442AbiBBR6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643824689; x=1675360689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=txTKV4GqxfW43WOJ6xN1Pg09D3EcGyQs318zawtFlSE=;
  b=JfLAiPNblRJu3Kmu1EjL5Klsxi1tqAYpNEcdX6jua77HAhQYgZYAVAZP
   NQMnzJrfCGD3iKk9tjO/KJur3J2BMbmWqCMlp8iNtXgbCYNXmLsV4/sOT
   LnG2qmgED2TjAPPanSC57Axn7EVXu8tRoePJLseuvV4mQziC9pUE9pIvO
   3Yf5QxnVpUjJLn8CA0YUB5LZHhTTsuD/GByd1bVG9bdk8ShHhREcpmR13
   gcvEWYaYlR3yycoW7iyYpaT4CRCdDrTBvxHnMhLYA4LQ6dZweXYFc7Wel
   tjlNbx9zPifLllcNZBhjousZMv2HxGZ+1NDfBfNbijKOHQjX8YQvPxHX4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="246818355"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="246818355"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 09:58:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="599643976"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2022 09:58:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6443F3B7; Wed,  2 Feb 2022 19:58:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: trigger: stm32-timer: Make use of device properties
Date:   Wed,  2 Feb 2022 19:58:15 +0200
Message-Id: <20220202175815.54100-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/trigger/stm32-timer-trigger.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

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

