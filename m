Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F0156C25E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbiGHVpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGHVpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:45:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA72AD5;
        Fri,  8 Jul 2022 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657316739; x=1688852739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TO3L/2mlXPf9Cl0nFuphhIinNmA5v99+jhzw984jMJI=;
  b=Tt2Bex/Mlo1oBnflgjH9QcKcd93khskZ3O06oNHA2XISN0h9e9ZGv+wj
   qeldmmTqPo7S6jOp33m4MFSBq5w+MM62GggTpRgGr0U4DW29Hd3AedIa9
   mQjJYDE+ADLXmfFAbuDKHEBVd18fQC4Xnamjhbi389R5mPs5NlBAUaRJh
   8MSUgw8kMXdSMKTRnJFNyUvYJH46otQk/IM/E+ZsLYioTCtEFgnkiDt2v
   bkx7PifBlnEqQRf6LKkye/wP9TKzojY/8bDTU4i/d1otfOIol+4X3aXPm
   9s8gokfIJs7k4urSbyAj9FQU6CDYlIU3i8sE9TSOWZDuSnC6Zm+/uiOdw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="264786054"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="264786054"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="736475816"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jul 2022 14:45:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0B27BCE; Sat,  9 Jul 2022 00:45:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 1/2] of: unittest: Switch to use fwnode instead of of_node
Date:   Sat,  9 Jul 2022 00:45:38 +0300
Message-Id: <20220708214539.7254-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF node in the GPIO library is deprecated and soon will be removed.
GPIO library now accepts fwnode as a firmware node, so switch the module
to use it instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
v2: added tag (Bart), clarify the purpose in the commit message (Rob)
 drivers/of/unittest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7f6bba18c515..5a842dfc27e8 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1602,7 +1602,7 @@ static int unittest_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, devptr);
 
-	devptr->chip.of_node = pdev->dev.of_node;
+	devptr->chip.fwnode = dev_fwnode(&pdev->dev);
 	devptr->chip.label = "of-unittest-gpio";
 	devptr->chip.base = -1; /* dynamic allocation */
 	devptr->chip.ngpio = 5;
@@ -1611,7 +1611,7 @@ static int unittest_gpio_probe(struct platform_device *pdev)
 	ret = gpiochip_add_data(&devptr->chip, NULL);
 
 	unittest(!ret,
-		 "gpiochip_add_data() for node @%pOF failed, ret = %d\n", devptr->chip.of_node, ret);
+		 "gpiochip_add_data() for node @%pfw failed, ret = %d\n", devptr->chip.fwnode, ret);
 
 	if (!ret)
 		unittest_gpio_probe_pass_count++;
-- 
2.35.1

