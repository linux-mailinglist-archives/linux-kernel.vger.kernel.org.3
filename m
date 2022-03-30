Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE54EC79D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347709AbiC3PAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347675AbiC3PAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:00:41 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B5642B;
        Wed, 30 Mar 2022 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648652336; x=1680188336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Irn+8n9bwYh+Vsri4PV7vkus1LhwWNhu6OCx59Rx7lQ=;
  b=PqwAxbFzlw2Q5vmKUkvJa4z/tQV85DHitfmO+IDITfTHQ4DvGbpvQx7f
   WL+EHkXv9QJlS0B5NEEKzgGmhiIv4ti8MHJ4UQPeYI/H80+OY2/DvCrny
   hNyOJoNK7785LLr7/gliQfu66qnRX4AbyqkaZe2HDThLkEFNmba2ap1ib
   Fsqvy/g+ut4gID8JWf3oKZnX0jPMyDBf13CVM7fp6o7mTSFBDaBaz23yb
   51YFqxkjyF9X4xGO8vWxpNpna8tlbvq8aGh6Xgs5EwSbi83yUK+KxmWNi
   6fVlc160xRZmjjKOxt9lQOBr7Ronn9JnAe/g0QhRfGeQF4rxsF7B082Cd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="320261630"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="320261630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="695125848"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2022 07:58:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B1CBE9B; Wed, 30 Mar 2022 17:59:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/3] gpiolib: Refactor gpiolib_dbg_show() with help of for_each_gpio_desc()
Date:   Wed, 30 Mar 2022 17:59:09 +0300
Message-Id: <20220330145910.1946-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330145910.1946-1-andriy.shevchenko@linux.intel.com>
References: <20220330145910.1946-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use for_each_gpio_desc() and since we would need to touch the entire
conditionals, do the following:
- rename last occurrence of gdesc to desc
- use short ternary operator ?:
- join two seq_printf() calls into single one
- fix indentation of the seq_printf() parameters

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 723411c13f1c..f956c533f218 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4381,32 +4381,29 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 {
 	unsigned		i;
 	struct gpio_chip	*gc = gdev->chip;
+	struct gpio_desc	*desc;
 	unsigned		gpio = gdev->base;
-	struct gpio_desc	*gdesc = &gdev->descs[0];
 	bool			is_out;
 	bool			is_irq;
 	bool			active_low;
 
-	for (i = 0; i < gdev->ngpio; i++, gpio++, gdesc++) {
-		if (!test_bit(FLAG_REQUESTED, &gdesc->flags)) {
-			if (gdesc->name) {
-				seq_printf(s, " gpio-%-3d (%-20.20s)\n",
-					   gpio, gdesc->name);
-			}
-			continue;
+	for_each_gpio_desc(i, gc, desc) {
+		if (test_bit(FLAG_REQUESTED, &desc->flags)) {
+			gpiod_get_direction(desc);
+			is_out = test_bit(FLAG_IS_OUT, &desc->flags);
+			is_irq = test_bit(FLAG_USED_AS_IRQ, &desc->flags);
+			active_low = test_bit(FLAG_ACTIVE_LOW, &desc->flags);
+			seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %s %s %s%s\n",
+				   gpio, desc->name ?: "", desc->label,
+				   is_out ? "out" : "in ",
+				   gc->get ? (gc->get(gc, i) ? "hi" : "lo") : "?  ",
+				   is_irq ? "IRQ " : "",
+				   active_low ? "ACTIVE LOW" : "");
+		} else if (desc->name) {
+			seq_printf(s, " gpio-%-3d (%-20.20s)\n", gpio, desc->name);
 		}
 
-		gpiod_get_direction(gdesc);
-		is_out = test_bit(FLAG_IS_OUT, &gdesc->flags);
-		is_irq = test_bit(FLAG_USED_AS_IRQ, &gdesc->flags);
-		active_low = test_bit(FLAG_ACTIVE_LOW, &gdesc->flags);
-		seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %s %s %s%s",
-			gpio, gdesc->name ? gdesc->name : "", gdesc->label,
-			is_out ? "out" : "in ",
-			gc->get ? (gc->get(gc, i) ? "hi" : "lo") : "?  ",
-			is_irq ? "IRQ " : "",
-			active_low ? "ACTIVE LOW" : "");
-		seq_printf(s, "\n");
+		gpio++;
 	}
 }
 
-- 
2.35.1

