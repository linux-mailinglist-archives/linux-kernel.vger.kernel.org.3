Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CECE4F9C6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiDHSWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiDHSV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:21:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7181EB803;
        Fri,  8 Apr 2022 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649441992; x=1680977992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Y6argfSVq6eehwxL941eIKk6C77s5ZnPYw+jOygf3I=;
  b=m/90X6q8s6g/pLStUDqmJjvzVPr5nUNOeZYdOHHUiQtmgMXEAPKLtvro
   ipl5J2DJ3hamvwumYfKJ3PegRfXM0+L7Sapu5yTXTItKEkoCdgjOLxdAh
   P/DS+e3QQlBD1oUbSFRVd+ec7CkgE2zeIkFcruosC7qsAPCs57VWImvMr
   mmmyZVIv8y6HKXBP1ph+2w9sQ7tA3/aKNCMcU9Y3ONRAImKc58uaSMpw8
   H1XiH7yyV7GeI3ky0WjjytkUPCKFzvS8SqLFjc2Z4On4oYCHHSZfjhmML
   9ceefm0WBGpILHz+3+TCV0mIgsZYlhYmZuWAwwIuWWrVNDeZOr5vhuI+w
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="249185684"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="249185684"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="589317447"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Apr 2022 11:19:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 29620328; Fri,  8 Apr 2022 21:18:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 3/5] gpiolib: Refactor gpiolib_dbg_show() with help of for_each_gpio_desc()
Date:   Fri,  8 Apr 2022 21:18:52 +0300
Message-Id: <20220408181854.73528-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408181854.73528-1-andriy.shevchenko@linux.intel.com>
References: <20220408181854.73528-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
v2: rebased on patch 1
 drivers/gpio/gpiolib.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 58a57540b834..43b0cae69bcd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4394,34 +4394,32 @@ core_initcall(gpiolib_dev_init);
 
 static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 {
-	unsigned		i;
 	struct gpio_chip	*gc = gdev->chip;
+	struct gpio_desc	*desc;
 	unsigned		gpio = gdev->base;
-	struct gpio_desc	*gdesc = &gdev->descs[0];
+	int			value;
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
+	for_each_gpio_desc(gc, desc) {
+		if (test_bit(FLAG_REQUESTED, &desc->flags)) {
+			gpiod_get_direction(desc);
+			is_out = test_bit(FLAG_IS_OUT, &desc->flags);
+			value = gc->get ? gc->get(gc, gpio_chip_hwgpio(desc)) : -EIO;
+			is_irq = test_bit(FLAG_USED_AS_IRQ, &desc->flags);
+			active_low = test_bit(FLAG_ACTIVE_LOW, &desc->flags);
+			seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %s %s %s%s\n",
+				   gpio, desc->name ?: "", desc->label,
+				   is_out ? "out" : "in ",
+				   value >= 0 ? (value ? "hi" : "lo") : "?  ",
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

