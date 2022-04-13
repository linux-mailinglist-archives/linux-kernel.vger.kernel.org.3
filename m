Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81F74FFDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbiDMSdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiDMSds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:33:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634FD53A6F;
        Wed, 13 Apr 2022 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649874687; x=1681410687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lEIFjP3OiLB0+zpreWjkV5/l1q/rwVuaOMddkFj+nOU=;
  b=OPrNAMPnoEJPh4ZlAvphFb5xE/SIPRQaaCkbnGQgKqe+KgCLSzou9Gp+
   bYc9ND7gaNhKpCsuqE8F0eUgUW6M2zSIczfklav2syyZSa+ZhBf43lEb+
   YeMBbx1vDgK5zpn2YSpC5bejBidb7FoYsAHUuva1ASbpBtwDhveIUFYA7
   18gAQGA8IBeCOKQqwuWRJnaUB6A014ysfwhOldpXCzbGBuPo6cISWftqX
   2dVfsqFRdld7MIK5pUN77DvSbZl9eQUbyvYHxiR1tI38dBQ4O8nl/ujnm
   uzHozUOr1aed19DPY+KQFpAhl6r359ePBnisJd5GFmT8pgZetA6u/5tcV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="261590328"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="261590328"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725011728"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2022 11:31:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B9AB812C; Wed, 13 Apr 2022 21:31:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: proximity: mb1232: Switch to use fwnode_irq_get()
Date:   Wed, 13 Apr 2022 21:31:23 +0300
Message-Id: <20220413183123.20292-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have OF-centric variant of fwnode_irq_get() in the driver.
Replace it with a call to an agnostic implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/mb1232.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index ad4b1fb2607a..0bca5f74de68 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -10,12 +10,14 @@
  * https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
  */
 
+#include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/of_irq.h>
 #include <linux/delay.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/bitops.h>
+#include <linux/property.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -209,7 +211,7 @@ static int mb1232_probe(struct i2c_client *client,
 
 	init_completion(&data->ranging);
 
-	data->irqnr = irq_of_parse_and_map(dev->of_node, 0);
+	data->irqnr = fwnode_irq_get(dev_fwnode(&client->dev), 0);
 	if (data->irqnr <= 0) {
 		/* usage of interrupt is optional */
 		data->irqnr = -1;
-- 
2.35.1

