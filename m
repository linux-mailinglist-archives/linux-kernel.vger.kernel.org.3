Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9A4A83A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350446AbiBCMQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:16:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:42448 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235416AbiBCMQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643890573; x=1675426573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dmg85Kj/hJAXWcoZCi3l1lyA4lcGpseKWHgYkaNtEIs=;
  b=MK13wBud9SjeajCGXVHtMehV9uxZ98pjGyjGTpCu3YwHWgvuP1SheSQr
   pJxhfJKACeFjHZ3lHbdj1C9yQuALG0W2zo5e486CA4pC23KsCYdQf1goU
   jdsRSTCBjTVOQNHrktHUaGi/4d5EQqOhverz9akIlLvM/FElUr4fuJADN
   BApHkoDMWff2+tspeOMozcWp4fpGtWWjpLY9hPO+4eHC66KC6Vi5yZ3gf
   S7qHDG8cl97heCpLco3ewfloiToHXJnHlAM3BM6EnSIsb8tJJ/vc71JKv
   sHRaaV2ze9Od0VmqQFoetz7tCKSU+jbKp3SmagkjwF/n14rheDLR3rdf6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334491108"
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="334491108"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 04:16:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,339,1635231600"; 
   d="scan'208";a="771762930"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2022 04:16:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3697318D; Thu,  3 Feb 2022 14:16:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 1/1] iio: amplifiers: hmc425a: Make use of device properties
Date:   Thu,  3 Feb 2022 14:16:24 +0200
Message-Id: <20220203121624.75515-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/amplifiers/hmc425a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
index 16c0a77f6a1c..ce80e0c916f4 100644
--- a/drivers/iio/amplifiers/hmc425a.c
+++ b/drivers/iio/amplifiers/hmc425a.c
@@ -11,10 +11,10 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
@@ -192,7 +192,7 @@ static int hmc425a_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	st->type = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	st->type = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	st->chip_info = &hmc425a_chip_info_tbl[st->type];
 	indio_dev->num_channels = st->chip_info->num_channels;
-- 
2.34.1

