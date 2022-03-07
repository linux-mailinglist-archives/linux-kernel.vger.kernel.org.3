Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3E54CFCAF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbiCGLZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242032AbiCGLYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:24:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1E511A3B;
        Mon,  7 Mar 2022 02:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646650439; x=1678186439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sC24XqI4cOq5tDpnDicRMvYX6LRyMmRMKHu+c0x7JLA=;
  b=MPH29m6Xf64l/grs+6PMbsD2lVExu9faC9VV0WTr3TBubB+NkPZTbGXP
   SUrHuhbLpU8XRBxV4hURWVKWGpJRJLyhq4SniJZI6HYsq9Oe6nEIry2nB
   CYgAbuWvvV7z8Wyrz9S0FHEjUPNSnqS2FfLG3vCbYG/pOcDlDVyy6S2hn
   k1saiKMnVLyWwxFwtdpDk4IGi5C1I93TIM29774GrR7IFxiu5oKxytiwp
   Q44JgKBCV0NBb70S1AE0+HXEG1WRbD0cbGPYh6g7lNGwylYQPDEZnkCwA
   Dm/B87YlraAH+BgbzgdEvA+I0h88HT1SqRwCCV4Gy/9z5FdDxYQIVS043
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="234318873"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="234318873"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:53:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="537068602"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 07 Mar 2022 02:53:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CA50810E; Mon,  7 Mar 2022 12:54:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] gpiolib: Use list_first_entry()/list_last_entry()
Date:   Mon,  7 Mar 2022 12:54:14 +0200
Message-Id: <20220307105414.17706-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use list_first_entry()/list_last_entry() instead of open coded variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 002bf4b1616b..f5e7443208d4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -262,14 +262,14 @@ static int gpiodev_add_to_list(struct gpio_device *gdev)
 		return 0;
 	}
 
-	next = list_entry(gpio_devices.next, struct gpio_device, list);
+	next = list_first_entry(&gpio_devices, struct gpio_device, list);
 	if (gdev->base + gdev->ngpio <= next->base) {
 		/* add before first entry */
 		list_add(&gdev->list, &gpio_devices);
 		return 0;
 	}
 
-	prev = list_entry(gpio_devices.prev, struct gpio_device, list);
+	prev = list_last_entry(&gpio_devices, struct gpio_device, list);
 	if (prev->base + prev->ngpio <= gdev->base) {
 		/* add behind last entry */
 		list_add_tail(&gdev->list, &gpio_devices);
@@ -4426,7 +4426,7 @@ static void *gpiolib_seq_next(struct seq_file *s, void *v, loff_t *pos)
 	if (list_is_last(&gdev->list, &gpio_devices))
 		ret = NULL;
 	else
-		ret = list_entry(gdev->list.next, struct gpio_device, list);
+		ret = list_first_entry(&gdev->list, struct gpio_device, list);
 	spin_unlock_irqrestore(&gpio_lock, flags);
 
 	s->private = "\n";
-- 
2.34.1

