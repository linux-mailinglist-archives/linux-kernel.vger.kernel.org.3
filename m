Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8E453931B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbiEaOX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbiEaOX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:23:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A3B8020A;
        Tue, 31 May 2022 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654007036; x=1685543036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rpF3VW7+9wXB4kzDnn1TnjadNGs2Y37n9bSd1jF1TNE=;
  b=Dsj9+W0ylzTcGVXOT33GQviQkc7fjTezEj7uVpuTbxvBZGS/gEgly2pk
   K02HZJYMgWXxU7lXf5IcoV0FrRRP/rr/b88jILvj0kZcHlKP3Ms6yAtVJ
   nOy+lZEIO+jpyk06POw/MshcwJMMMr3lbPzg5ebuTSep06EPkQfI6wZZM
   F6r+0UDZf9ZlK+QTqUAOZTRJ4na0HNKPB1lOzXcKWz960x8QfLJpWc4FQ
   VSunqlgtbC8WGy8QgNqcrnOj6efr5bkqsbEIOLAg3hOl4z4znpNeB/XN6
   YKt0snyGJh5xMiZXhEUacFlj3u0SPU4fvLg7yD/B5yDoT1bVXr7sdA9UP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="272835147"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="272835147"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 07:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="823293222"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 31 May 2022 07:23:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 820F814F; Tue, 31 May 2022 17:23:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v1 1/1] iio: adc: vf610_adc: Make use of device properties
Date:   Tue, 31 May 2022 17:23:53 +0300
Message-Id: <20220531142353.64925-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Add mod_devicetable.h include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/Kconfig     |  1 -
 drivers/iio/adc/vf610_adc.c | 15 ++++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3b6a80786b51..448ae243cd31 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1257,7 +1257,6 @@ config TWL6030_GPADC
 
 config VF610_ADC
 	tristate "Freescale vf610 ADC driver"
-	depends on OF
 	depends on HAS_IOMEM
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index c84293efc129..c6b16cf6e367 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -5,7 +5,9 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -14,10 +16,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/regulator/consumer.h>
-#include <linux/of_platform.h>
 #include <linux/err.h>
 
 #include <linux/iio/iio.h>
@@ -799,6 +798,7 @@ MODULE_DEVICE_TABLE(of, vf610_adc_match);
 
 static int vf610_adc_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct vf610_adc *info;
 	struct iio_dev *indio_dev;
 	int irq;
@@ -846,13 +846,10 @@ static int vf610_adc_probe(struct platform_device *pdev)
 
 	info->vref_uv = regulator_get_voltage(info->vref);
 
-	of_property_read_u32_array(pdev->dev.of_node, "fsl,adck-max-frequency",
-			info->max_adck_rate, 3);
+	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
 
-	ret = of_property_read_u32(pdev->dev.of_node, "min-sample-time",
-			&info->adc_feature.default_sample_time);
-	if (ret)
-		info->adc_feature.default_sample_time = DEFAULT_SAMPLE_TIME;
+	info->adc_feature.default_sample_time = DEFAULT_SAMPLE_TIME;
+	device_property_read_u32(dev, "min-sample-time", &info->adc_feature.default_sample_time);
 
 	platform_set_drvdata(pdev, indio_dev);
 
-- 
2.35.1

