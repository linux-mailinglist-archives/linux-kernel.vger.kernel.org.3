Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CAB4FFF13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238261AbiDMTYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiDMTY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:24:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB5E483B0;
        Wed, 13 Apr 2022 12:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649877727; x=1681413727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rEe9sUcXX2q4XOWlTXNb/QZdbafBBPtBZwPWEFvOMcQ=;
  b=WDEcG06zZbvod9rjDGlIgTBSgqOiRrivB1pAVqSl7IXy3B1T43BKPw1U
   zMG5v7bzj64lR+40QmNjwdCaeGRDFqthVo+dW1tvZc6TXPb62dVr8qSGj
   QUodJr0tOOaCkLfQWjSkDt1qEGWXwa4yq1YGeYrnnEZ11BJO5sIrf27ze
   DY+fofFh9dPs3Fcd/LacbLKRR4hMFRwbNnH611tRLux7HvkJGVJbO9xKd
   L1r9bYhvnvREEOSr2T10aISQ8viZCFerwTpArLx0xFF0e77XVUjcClIXv
   n+1yAM132ekc+q9rbW3gSwNW6F9ChRq2uHn5EXcWAKYvpuw+Zb0YNjwz7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="250044159"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="250044159"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="526594626"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 13 Apr 2022 12:22:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 56EB512C; Wed, 13 Apr 2022 22:22:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: dac: ltc2632: Make use of device properties
Date:   Wed, 13 Apr 2022 22:22:03 +0300
Message-Id: <20220413192203.46704-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/dac/ltc2632.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index aed46c80757e..c0255f402056 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -10,6 +10,7 @@
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 #include <linux/iio/iio.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 #include <asm/unaligned.h>
@@ -362,8 +363,7 @@ static int ltc2632_probe(struct spi_device *spi)
 		}
 	}
 
-	indio_dev->name = dev_of_node(&spi->dev) ? dev_of_node(&spi->dev)->name
-						 : spi_get_device_id(spi)->name;
+	indio_dev->name = fwnode_get_name(dev_fwnode(&spi->dev)) ?: spi_get_device_id(spi)->name;
 	indio_dev->info = &ltc2632_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = chip_info->channels;
@@ -469,7 +469,7 @@ MODULE_DEVICE_TABLE(of, ltc2632_of_match);
 static struct spi_driver ltc2632_driver = {
 	.driver		= {
 		.name	= "ltc2632",
-		.of_match_table = of_match_ptr(ltc2632_of_match),
+		.of_match_table = ltc2632_of_match,
 	},
 	.probe		= ltc2632_probe,
 	.remove		= ltc2632_remove,
-- 
2.35.1

