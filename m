Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1506E5386CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 19:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiE3Rdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 13:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbiE3Rd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 13:33:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E96C68FBF;
        Mon, 30 May 2022 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653932008; x=1685468008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vGd6TceShfTiRP/LCPoV/XqvXMkXKRaaG6E4ysLsdbU=;
  b=jI7P05mz7WkxbhyuMAwqdY+NA2jCumLWTtqjFewgHD/A/y6wvOILrE8p
   FJ5/4sjGG4p2n7jdLx1bbPpF115jGP4LG+9euoPJGEa42dUwEivWd7w/e
   vPnKyeCiN1rInfuro2brtKgyOtfcwqZeTq/c5qQOF6oLC/3Li4yFLrHao
   1ET/SBi5M019EoxIeKSxQh9VE8jKxmxhC2jiPf7W4lR2bkLR4G4rp9HOg
   PuzynMxe0I3NK4Bq25s5RNAzyOYxNDbFhaXYS+5bjBUHWVvAQkYvvn7BE
   vhdMP66GZlxNh3cUtyv1J71IPPoLhbsvrTjJLfcho3yGxwePVZ6lVZ4IR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="274771055"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="274771055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 10:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="605280033"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 30 May 2022 10:33:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 10438147; Mon, 30 May 2022 20:33:26 +0300 (EEST)
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
Subject: [PATCH v1 1/1] iio: adc: mxs-lradc-adc: Get rid of OF specifics
Date:   Mon, 30 May 2022 20:33:24 +0300
Message-Id: <20220530173324.921-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
---
 drivers/iio/adc/mxs-lradc-adc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index bca79a93cbe4..25292bb8a13f 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -17,7 +17,6 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/mxs-lradc.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 
@@ -692,7 +691,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	struct mxs_lradc_adc *adc;
 	struct iio_dev *iio;
 	struct resource *iores;
-	int ret, irq, virq, i, s, n;
+	int ret, irq, i, s, n;
 	u64 scale_uv;
 	const char **irq_name;
 
@@ -721,7 +720,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, iio);
 
 	iio->name = pdev->name;
-	iio->dev.of_node = dev->parent->of_node;
+	device_set_node(&iio->dev, dev_fwnode(dev->parent));
 	iio->info = &mxs_lradc_adc_iio_info;
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->masklength = LRADC_MAX_TOTAL_CHANS;
@@ -747,9 +746,7 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
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

