Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781DD53989B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347969AbiEaVWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347940AbiEaVWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:22:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F8590B3;
        Tue, 31 May 2022 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654032140; x=1685568140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dt2CxOiyigC+mbZ0bjelkM90B9V+cSMQBl66yR98MII=;
  b=g8N/M7Gr1GfKrMBV05dw3VxvR+0LmLRdrLBNghW0ZXNdqrHmU1umv2JO
   ZPRiWWcdnCn1UaOA+Yj1eB5otWbecztVHNI9+BC/v9JUG0DZA/yplbZHf
   9TlgtuSBXQkVqbiMyOw+0pKRX/cSxITOJq7U8V7g3jt5IaYZP8ExhZZJw
   VpKEPZ9aZHzh71CYv62UJFBBl0bzUf/nASyXZcoiwzoX4axhreE2Yfgc0
   uH+7qEQfgEXEe82sCCA7SyAsuvKyOtvirwtmnDeHlypPj443d30UpfUdf
   GO1TecBfRYpWgenEup+CcnVAHavCT5eHAp+qGMrGrPs109LokgeOEIANi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="257458498"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="257458498"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 14:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="904154015"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2022 14:22:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6617018B; Wed,  1 Jun 2022 00:22:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Andr=C3=A9=20Gustavo=20Nakagomi=20Lopez?= 
        <andregnl@usp.br>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: adc: lpc18xx_adc: Switch from of headers to mod_devicetable.h
Date:   Wed,  1 Jun 2022 00:22:18 +0300
Message-Id: <20220531212218.72189-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing directly using of specific interfaces in this driver,
so lets not include the headers.

While at it, drop dependency to OF, which currently makes no sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/Kconfig       | 2 +-
 drivers/iio/adc/lpc18xx_adc.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 448ae243cd31..b9e913e25a5d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -562,7 +562,7 @@ config LP8788_ADC
 config LPC18XX_ADC
 	tristate "NXP LPC18xx ADC driver"
 	depends on ARCH_LPC18XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM
+	depends on HAS_IOMEM
 	help
 	  Say yes here to build support for NXP LPC18XX ADC.
 
diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index ae9c9384f23e..42e6cd6fa6f7 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -17,10 +17,9 @@
 #include <linux/iio/driver.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 
-- 
2.35.1

