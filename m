Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6CD55FEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiF2LmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiF2LmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:42:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EE13F331;
        Wed, 29 Jun 2022 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656502934; x=1688038934;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PLZy6FdtWTJaBvqj0/Wf7kuuinfelYGkxatNVzCgqcU=;
  b=lqUhrVno6mhftZZcVGHTkA3xpaA50B5UgmbOJ2SqgVeYFLD9O85sJNzE
   6E6kuC9FSNSkd7K8IPaKLaQIS71BlthIje1iyowFAYCAsDwie+Z+JeOBi
   4/RmDAFz5R1gIodN7Ru8TlPqdpUCiu0Vxz3RMYb9FWQUkPWwH4uHj3nlg
   Izbki0BgXFS9tO+QVrWFkUddFV2ofAiKikM6Z+o6eP6noZznGRd1nZMQO
   oLnoPJrb9y7z0GlOP1P7Qjd71IfJ9OiIUwGxEuOfn8R1CgWG+7ieo0RRK
   bFKzeMTsxoBvVYYizZHtvqiF4Ki8kiHvGe9N+qLic44t/1kIxSRyhj2/4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="307502280"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="307502280"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="595206522"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2022 04:41:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 50F0F109; Wed, 29 Jun 2022 14:41:59 +0300 (EEST)
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
Subject: [PATCH v2 1/1] of: unittest: Switch to use fwnode instead of of_node
Date:   Wed, 29 Jun 2022 14:41:56 +0300
Message-Id: <20220629114156.6001-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the module to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed parameter in debug message as well
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

