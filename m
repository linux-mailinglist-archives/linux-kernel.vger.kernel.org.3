Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DED578D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbiGRWCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiGRWCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:02:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D230578;
        Mon, 18 Jul 2022 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658181768; x=1689717768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tk3QUUUCzjad0MTjVI5kmvuwI7cTiP26RLaWwNKMiwc=;
  b=hc8m6l8bnSSaqSFNbQEuUXHM0gv8kCOdYrbMzMgoJPHpKDeXsEMesDxS
   A5gYfgBqoyzAq5pHmtzzSYgNy0PDBK0sFS4pPb/+T987Z3MfMUpRg3GjR
   kEEfZmDiCw3ut3JF4LNswlCEuLgLxL5krHEPDG3yzJjp3dOnVbjQWltu2
   tbhz9ElilGmPIQQQRw85sGNXs9gF++DCLx7G9BIcxmGiT+FU0hOtzMU3r
   Er26ejogvv2SGf7KynuqlqHNZn72jNQNfg7LOEemHiolJRklI0xl/d7n3
   WBM3hhX9tZJn3e1sfDx6zJz32yeZ84+tRhpAOyD4AMBzDYgc9OBOk57Bu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="372636798"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="372636798"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 15:02:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="665174930"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2022 15:02:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1549E10E; Tue, 19 Jul 2022 01:02:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/3] gpio: 74xx-mmio: Make use of device properties
Date:   Tue, 19 Jul 2022 01:02:50 +0300
Message-Id: <20220718220252.16923-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Add mod_devicetable.h include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-74xx-mmio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index 173e06758e6c..5e3c948ddb73 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -6,10 +6,11 @@
  */
 
 #include <linux/err.h>
-#include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/gpio/driver.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #define MMIO_74XX_DIR_IN	(0 << 8)
 #define MMIO_74XX_DIR_OUT	(1 << 8)
@@ -112,7 +113,7 @@ static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->flags = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	priv->flags = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	dat = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dat))
-- 
2.35.1

