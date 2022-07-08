Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10A56C430
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbiGHVpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbiGHVpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:45:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAEE23153;
        Fri,  8 Jul 2022 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657316739; x=1688852739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=scaxfi9b+Fo210pb1G9BZje6ENg5BFTq+IGw3i8M+wA=;
  b=PwzEZkGfsh1SmLyzQm388P1bDpRy8j8yQHyJZ6QlnVrpfXJJZQUQ2NFy
   cHBus/O3/eT33gqJvFAx1dahkXZTbWF1yOvYMvdMWNirAuH0bafeyrYnj
   PgEdfqi+q2/5LO5/J//k52Jp7dLaCaXcAWTXSaZzKJbdCfZGSucX4Ve6P
   56+JP8k3N+W6IvwmilnE/jeGQb1BZwCzOsKPwd/g3bgtJ7RSalPsTnmY8
   XjdM+hMB6lWAXtSFwvyvSmdkySAY52Ypv0y1p2LO/ppxXbLMekW614YGu
   yHtXXqBKAeDpEfQP5miK0QAl744+h2tcqqR6xZihlKsPx6j9ul1/zWWbE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="264151935"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="264151935"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="569089890"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2022 14:45:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 16091AD; Sat,  9 Jul 2022 00:45:43 +0300 (EEST)
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
Subject: [PATCH v4 2/2] of: unittest: make unittest_gpio_remove() consistent with unittest_gpio_probe()
Date:   Sat,  9 Jul 2022 00:45:39 +0300
Message-Id: <20220708214539.7254-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220708214539.7254-1-andriy.shevchenko@linux.intel.com>
References: <20220708214539.7254-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the ->remove() stage the callback uses physical device node instead of one
from GPIO chip and the variable name which is different to one used in
unittest_gpio_probe(). Make these consistent with unittest_gpio_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/of/unittest.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 5a842dfc27e8..eafa8ffefbd0 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1620,20 +1620,19 @@ static int unittest_gpio_probe(struct platform_device *pdev)
 
 static int unittest_gpio_remove(struct platform_device *pdev)
 {
-	struct unittest_gpio_dev *gdev = platform_get_drvdata(pdev);
+	struct unittest_gpio_dev *devptr = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
 
-	dev_dbg(dev, "%s for node @%pOF\n", __func__, np);
+	dev_dbg(dev, "%s for node @%pfw\n", __func__, devptr->chip.fwnode);
 
-	if (!gdev)
+	if (!devptr)
 		return -EINVAL;
 
-	if (gdev->chip.base != -1)
-		gpiochip_remove(&gdev->chip);
+	if (devptr->chip.base != -1)
+		gpiochip_remove(&devptr->chip);
 
 	platform_set_drvdata(pdev, NULL);
-	kfree(gdev);
+	kfree(devptr);
 
 	return 0;
 }
-- 
2.35.1

