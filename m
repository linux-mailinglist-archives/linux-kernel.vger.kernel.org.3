Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1287519BA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347230AbiEDJ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347229AbiEDJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:29:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6887425C6E;
        Wed,  4 May 2022 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651656338; x=1683192338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=98FMhtqkWE2Gw7W9NUjtO6+ea68PEyBVJedwM2qsaNM=;
  b=SuLOroBE5UpB0euLUQXYProLd0l1xZflRr6OAacfHtI5yVFJgc0lqDTH
   OttKCOGDnoVRSTU3dqgRoVl1wAgHwMBaHCDDmUUPMOv6y6lQD35AcsS8M
   wBKwg7hWWkUTjoC6jiodW58Th6JqZGxE+AB7ctAxRtZis5tXRqFOOoLpg
   rQatnVHU0xZRBAp8ofIr7xWc7IvJg6H+n8sl4tXxyVwu0YGs92QUq/6vX
   g9NKIQRJkvcJnu991O3W5BSS9pPzNdgb5KrKNsY49krBotnYWSLgnfCBo
   eqrz2Km7mXeRGZmttIOh+2Ic7Po2Hpz0rt0ebjFN5sMe0+bUjm6igO0ev
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="247621531"
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="247621531"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 02:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,197,1647327600"; 
   d="scan'208";a="890293046"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2022 02:25:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2EF9A1A5; Wed,  4 May 2022 12:25:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH v2 1/1] bcma: gpio: Switch to use fwnode instead of of_node
Date:   Wed,  4 May 2022 12:25:26 +0300
Message-Id: <20220504092525.71668-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node,
so switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo (LKP)
 drivers/bcma/driver_gpio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 1e74ec1c7f23..fac8ff983aec 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -11,6 +11,8 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/export.h>
+#include <linux/property.h>
+
 #include <linux/bcma/bcma.h>
 
 #include "bcma_private.h"
@@ -182,9 +184,8 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 	chip->direction_input	= bcma_gpio_direction_input;
 	chip->direction_output	= bcma_gpio_direction_output;
 	chip->parent		= bus->dev;
-#if IS_BUILTIN(CONFIG_OF)
-	chip->of_node		= cc->core->dev.of_node;
-#endif
+	chip->fwnode		= dev_fwnode(&cc->core->dev);
+
 	switch (bus->chipinfo.id) {
 	case BCMA_CHIP_ID_BCM4707:
 	case BCMA_CHIP_ID_BCM5357:
-- 
2.35.1

