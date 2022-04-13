Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431AD4FFE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiDMSxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiDMSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:53:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75E63C493;
        Wed, 13 Apr 2022 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649875848; x=1681411848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zdtONmqIqmSMsfwO/eB1LqVWS1rhibGbtCCHL03ZQU4=;
  b=YxGfz+PnzsiUFIg/u7tpVJxA1J0iD6X2wXjuTNHgzucfPGbxzf9R34lT
   5PRvqrjXXrLTv2kvQO09BAUV4HkcdCfSycGg42sPP5CcQGl5aU4Fd0Ixr
   TzeNdI4vZ/u3cgRuZ7y/qLF+DfncjhFVMpiCfjJZFMxrLFavgh73rYBdk
   0SPsIwVb7bNBEF0Fa6fpQzuty6Ixo30IatJvezUMBk2bWqCD3skEA8rVY
   nrjaC4hAQ0mh/x4gK/7iYwWvi1DveolmMSkO+9xvJoMfQRM2aXwBzgfzF
   8VFT7Ru0P4BLK5FPbFQm8C7dVk640RO414WhLPi7co6TzyffK2JeDN/00
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262499994"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262499994"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:50:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="623794046"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2022 11:50:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B7C012C; Wed, 13 Apr 2022 21:50:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: temperature: max31856: Make use of device properties
Date:   Wed, 13 Apr 2022 21:50:44 +0300
Message-Id: <20220413185044.21588-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/temperature/max31856.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
index 54840881259a..8307aae2cb45 100644
--- a/drivers/iio/temperature/max31856.c
+++ b/drivers/iio/temperature/max31856.c
@@ -7,9 +7,11 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -422,9 +424,7 @@ static int max31856_probe(struct spi_device *spi)
 	indio_dev->channels = max31856_channels;
 	indio_dev->num_channels = ARRAY_SIZE(max31856_channels);
 
-	ret = of_property_read_u32(spi->dev.of_node, "thermocouple-type",
-				   &data->thermocouple_type);
-
+	ret = device_property_read_u32(&spi->dev, "thermocouple-type", &data->thermocouple_type);
 	if (ret) {
 		dev_info(&spi->dev,
 			 "Could not read thermocouple type DT property, configuring as a K-Type\n");
-- 
2.35.1

