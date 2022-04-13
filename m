Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E30D4FFE56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbiDMTDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiDMTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:03:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C73A194;
        Wed, 13 Apr 2022 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649876481; x=1681412481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kJDKIrd2cNiQgQ9NWri7ZGfjzDAloFANWXt7WDfGDaA=;
  b=PukJfIPeFR+ssmCUY5I3VXr2hG+GKwNlAEbf/t/BgFHS6CLTf0aHpuNa
   3sYOXXLSIWH2EFsA3Q90WlngaYL2fWgOx65GBipQC8sj3gqRI/8S4AbYF
   XgrYVnz4AR26U1kECsRXvicNWUdr3OVC34xvMtUJyrx/+h/ow+qHzo/OB
   iJSuXUFKVMVwMqA6QHbSUKZrFoxr2H7I9dDT9Vi15M6Hr+TqANMgUrRJS
   O/5tazVPIvjbb4sZd7g7Pc3s9WJQPx56+9geHus/EIYQ0Q84nsyMY+Ivh
   4KSKuFN16x+F+YI2D7jwAZJubg2pUAPy8wRBiOhvqBvntHsLZ175b8vUa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262928584"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262928584"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 12:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="559864107"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2022 12:01:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C6C012C; Wed, 13 Apr 2022 22:01:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: afe: rescale: Make use of device properties
Date:   Wed, 13 Apr 2022 22:01:17 +0300
Message-Id: <20220413190117.29814-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/afe/Kconfig       | 1 -
 drivers/iio/afe/iio-rescale.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
index 4fa397822cff..9a1d95c1c7ed 100644
--- a/drivers/iio/afe/Kconfig
+++ b/drivers/iio/afe/Kconfig
@@ -8,7 +8,6 @@ menu "Analog Front Ends"
 
 config IIO_RESCALE
 	tristate "IIO rescale"
-	depends on OF || COMPILE_TEST
 	help
 	  Say yes here to build support for the IIO rescaling
 	  that handles voltage dividers, current sense shunts and
diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 7e511293d6d1..c6cf709f0f05 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -10,9 +10,8 @@
 
 #include <linux/err.h>
 #include <linux/gcd.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
@@ -536,7 +535,7 @@ static int rescale_probe(struct platform_device *pdev)
 
 	rescale = iio_priv(indio_dev);
 
-	rescale->cfg = of_device_get_match_data(dev);
+	rescale->cfg = device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
 	rescale->offset = 0;
-- 
2.35.1

