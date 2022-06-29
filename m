Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B6A55FF0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiF2LuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiF2LuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:50:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF93EF31;
        Wed, 29 Jun 2022 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656503408; x=1688039408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+6krQVdijwrt6bSpN8vEUeyDsgnZZttj6KBYBLaI76c=;
  b=mtxix1FQ8+cQX6Gs/FOATH6U0jKIPglFayqAMHtCld+fIst0YpQpJHhb
   fM7hHTwHoJZh2cF/x2DSM2Gk8IvtJCCdW8NOAec3EnHQWFm4PnDlyLPqz
   nvOqtPk6SuEOYmf6eLZ2J0QYB++y1rYYFHpq8XxiLgbotfTpUGG8/BOn0
   lbOoyQ+WG8capIIk+xQOzR0VDGiVEPyyNLpQeZ7jIS3IGdixaR3g73k9G
   PD1q/TA2jWkETZYzvWa+ScawOnGxNqHkRAQyPpBpXlshP4QvlVQ//CdwT
   W6IWIf1oczrUAVW+lQMSjHO1frHHr/eK0+PT0yERYuSDJFoQKOXed+29b
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270773989"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="270773989"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="590723543"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 29 Jun 2022 04:50:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 33E0DF1; Wed, 29 Jun 2022 14:50:11 +0300 (EEST)
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
Subject: [PATCH v3 2/2] of: unittest: make unittest_gpio_remove() consistent with unittest_gpio_probe()
Date:   Wed, 29 Jun 2022 14:50:10 +0300
Message-Id: <20220629115010.10538-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com>
References: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v3: new patch
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

