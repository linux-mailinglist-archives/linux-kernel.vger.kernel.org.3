Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944814FF77E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiDMNRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiDMNRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:17:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A1B3CA77;
        Wed, 13 Apr 2022 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649855718; x=1681391718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mi5xUNRmf+1Ozgvqotw6ofQAMA9YFxk6Tt7KpAvccm4=;
  b=NFz6gutJn3+eecymSdLQfncALj4fciZgqaD9q/KN7gPclvl61FZLE1zj
   JPZA+YbWYE12ag3Brr65u8ZNDeb+B39Tak6IxTxlICGzrkensH0PsaRVm
   zUkF7lSKxKJ9MTuGMRjMuj6JSTugvM+2jSM4kW0zw3R+EDU3j4SPQrw9C
   CQoIWuTo+J02G3h8mY7IhXAJoddiTxci9wItexmcu3So79WIj4vlka3ev
   w/tu647rwDN/vVUreh4PsGWM2DnfxBnx2Wgb9FPR1xA5lK35JhYtygqoD
   3RTntzfZ8A/5b/s2syY33DQKdcK8YbRWf2N2phA7r9TNRL6UzfVoyP0Ft
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="323102578"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="323102578"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 06:15:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="559741533"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2022 06:15:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3803191; Wed, 13 Apr 2022 16:15:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: gyro: fxas21002c: Make use of device properties
Date:   Wed, 13 Apr 2022 16:15:13 +0300
Message-Id: <20220413131513.59258-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/gyro/fxas21002c_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 410e5e9f2672..0923fd793492 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -7,9 +7,9 @@
 
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -822,7 +822,6 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct device_node *np = indio_dev->dev.of_node;
 	unsigned long irq_trig;
 	bool irq_open_drain;
 	int irq1;
@@ -831,8 +830,7 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
 	if (!data->irq)
 		return 0;
 
-	irq1 = of_irq_get_byname(np, "INT1");
-
+	irq1 = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
 	if (irq1 == data->irq) {
 		dev_info(dev, "using interrupt line INT1\n");
 		ret = regmap_field_write(data->regmap_fields[F_INT_CFG_DRDY],
@@ -843,7 +841,7 @@ static int fxas21002c_trigger_probe(struct fxas21002c_data *data)
 
 	dev_info(dev, "using interrupt line INT2\n");
 
-	irq_open_drain = of_property_read_bool(np, "drive-open-drain");
+	irq_open_drain = device_property_read_bool(dev, "drive-open-drain");
 
 	data->dready_trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 						   indio_dev->name,
-- 
2.35.1

