Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5002051880B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbiECPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiECPQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:16:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DED3A71D;
        Tue,  3 May 2022 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651590786; x=1683126786;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pxcn3QJBUNks4ffm+uyiFdpr26X1nH2L0L6i4V0iIcc=;
  b=g001NLS1Kd4RJNQUSHszLFqaBeouCq2+p9EVYpsWx5Fe7gPUAyIoED5g
   cbZB/74Oq6lnkJgdl7ZwXUk8AyEmDATjAFU32qRUpog4knhWzj3My8N3Q
   c1THzOSegFYIzHbwUeQaXQ1d9LuvuMEwyIiHAMb+uJJ1VMnlHpPowQ2tQ
   ZKu6PJwaEE9VS+Yec623mB/JeH3ZPmV5VZl7RlR2DwVNRJego7dhFuwpC
   QPUNrBg7QvdWyl+2Ob+KjEmjab73040330G/oD5hLfGjFMVAvXLH+Ab9N
   rkR+Q31f6qbUHJ+3iNxv6nh/y2KKClHqrV5YNLygVOCsECtDeEGVBUrjU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="353939438"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="353939438"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:13:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="620372749"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 03 May 2022 08:13:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ABB6C179; Tue,  3 May 2022 18:13:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH v1 1/1] bcma: gpio: Switch to use fwnode instead of of_node
Date:   Tue,  3 May 2022 18:12:46 +0300
Message-Id: <20220503151246.58725-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
 drivers/bcma/driver_gpio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 1e74ec1c7f23..2ee9804e9d51 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -11,6 +11,8 @@
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/export.h>
+#include <linux/poperty.h>
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

