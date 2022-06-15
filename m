Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B5354C7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243494AbiFOLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiFOLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:47:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A12610F;
        Wed, 15 Jun 2022 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655293668; x=1686829668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ROUuMUroMsslJq/9ZSReRN0oM6mJ1TOrX9bCNwvFXL0=;
  b=NGl873l7fkf1rKR1gAWEI5pd5uONg39M11Py1NDY0TMYxu7IjL3mnsCS
   /0p5uPGyVe19NZwhRWdD8h3F9qpCdaH57NYcX9pSwdfatRytfCOoWHEOt
   Jx2CWkuw8tjy/XrZi+tBVIDRoOBhHdwl8KWv5FH8dpPyiGrPb/3bcxrVh
   YKhAsqeN/v9l6L4zglNeUyvWmFeHLugqg9Qo2Om4XIy1Uz9e4l8iebOMY
   RLAuYgdyzfCm696MmGZIA77HFImR11nIEzjtVrdRqeEz6HFqVQTljLZ2Q
   hF5JhNLrCczyKXRGE0p/6ip611H8A9BN4jxuF9Z4aGboh7dttILflZgBS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="342894651"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="342894651"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 04:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="571788930"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2022 04:47:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4B8FA103; Wed, 15 Jun 2022 14:47:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/2] iio: proximity: sx_common: Allow IIO core to take care of firmware node
Date:   Wed, 15 Jun 2022 14:47:46 +0300
Message-Id: <20220615114746.2767-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com>
References: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IIO core correctly will take care of firmware node if it's not set in
the driver. Drop ACPI and OF specifics from the driver and allow IIO
core to handle this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/iio/proximity/sx_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 9f2e47385198..d70a6b4f0bf8 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -5,7 +5,6 @@
  * Common part of most Semtech SAR sensor.
  */
 
-#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/delay.h>
@@ -519,8 +518,6 @@ int sx_common_probe(struct i2c_client *client,
 	if (ret)
 		return dev_err_probe(dev, ret, "error reading WHOAMI\n");
 
-	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
-	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels =  data->chip_info->iio_channels;
-- 
2.35.1

