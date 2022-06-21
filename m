Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6A3552FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346805AbiFUKiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348291AbiFUKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:37:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B002635;
        Tue, 21 Jun 2022 03:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655807875; x=1687343875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fYz8uuFvylv6Ky43GZqcEtTMOEBoOJOUtkMSELIJ7lU=;
  b=jJ1VWXUeCuA9IiWKLkpGSJLrFmMfcuC5VB9UXddBMDyh+Z4uqrDJpMSh
   IyWBQrbQq8lfI2E4LxKRfkR/ld44UQ7bxvcCdqsjLAnTh7PvZCwDIcTuW
   ZU3CohJrSB1tOMSW91SLUxTmIC5D+ntUKOscZCmzAszxA/+xxafxI6nlI
   w/YYSAzuVH93asTUNSL76FeUmuy/gF/hhQ+cYTTJyhIvoKaS9kskpKNBR
   yxiplQihwrgUsKs9XuftewWS3RqWPGE5JIkT2HWZGqHtAqoc6rYusy1kx
   NfCvfaMJNm0HosyYkdTOcreTsG3smfqb/12WM8UEf2RQF18k3jEcrYcpx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263120621"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="263120621"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 03:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="689882530"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2022 03:37:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5743A13C; Tue, 21 Jun 2022 13:37:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Date:   Tue, 21 Jun 2022 13:37:54 +0300
Message-Id: <20220621103754.12771-1-andriy.shevchenko@linux.intel.com>
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

First of all, the additional conversion from vIRQ, and this is exactly
what is returned by platform_get_irq_byname(), to vIRQ is not needed.
Hence, drop no-op call to irq_of_parse_and_map().

Second, assign the firmware node instead of of_node.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Fabio Estevam <festevam@gmail.com>
---
v2: added property.h (Fabio), added tag (Fabio)
 drivers/iio/adc/mxs-lradc-adc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index bca79a93cbe4..02d2ffafe34d 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -17,8 +17,8 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/mxs-lradc.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/sysfs.h>
 
 #include <linux/iio/buffer.h>
@@ -692,7 +692,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	struct mxs_lradc_adc *adc;
 	struct iio_dev *iio;
 	struct resource *iores;
-	int ret, irq, virq, i, s, n;
+	int ret, irq, i, s, n;
 	u64 scale_uv;
 	const char **irq_name;
 
@@ -721,7 +721,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, iio);
 
 	iio->name = pdev->name;
-	iio->dev.of_node = dev->parent->of_node;
+	device_set_node(&iio->dev, dev_fwnode(dev->parent));
 	iio->info = &mxs_lradc_adc_iio_info;
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->masklength = LRADC_MAX_TOTAL_CHANS;
@@ -747,9 +747,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 		if (irq < 0)
 			return irq;
 
-		virq = irq_of_parse_and_map(dev->parent->of_node, irq);
-
-		ret = devm_request_irq(dev, virq, mxs_lradc_adc_handle_irq,
+		ret = devm_request_irq(dev, irq, mxs_lradc_adc_handle_irq,
 				       0, irq_name[i], iio);
 		if (ret)
 			return ret;
-- 
2.35.1

