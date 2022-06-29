Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC2355FF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiF2LuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiF2LuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:50:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053A36B66;
        Wed, 29 Jun 2022 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656503408; x=1688039408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U1TxebG8ojat2OTnFTUhfRC0os6Prlnrnawal3DhOKU=;
  b=kdiYYIrtTJKOD3GPRHEaaJT3Vzccmg001Vol7LJ3RIXHd9W2YUZN42Qh
   u7iZvBTlWTMr4X1H3NXJHpmoeFT9qWSLkDe2BHpWaxj1lfdEuUKiDT9nX
   ML+YfbeYh9atBkCc/uffjfUoVFW0datzPJzb6uQ9J6Kj/0AbeltUism/T
   AXHqz79QIoZeu33rrS6k4NYuFHkgbc+EFfYkN12yD6mEpD3Ff3O+6kLT4
   ehj0PMJcaJ/SeP8DVueuNYQ5mE7652b8PBtvIYGuDeTv3C/v4fZpamUdP
   U2izJ7yhK68SHKtImnUsDSLKNcj7VqMndjgbK7ABYNC/Cas3y+NOV4eMO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343698695"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="343698695"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="717792732"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2022 04:50:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2507A109; Wed, 29 Jun 2022 14:50:11 +0300 (EEST)
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
Subject: [PATCH v3 1/2] of: unittest: Switch to use fwnode instead of of_node
Date:   Wed, 29 Jun 2022 14:50:09 +0300
Message-Id: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the module to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no changes
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

