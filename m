Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B084F9C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiDHSWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiDHSWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:22:14 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4A72102B2;
        Fri,  8 Apr 2022 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649442010; x=1680978010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJ9p5GHDWzM6iy52ee+bzgw7OnlJv9U22b2PdWRRIVk=;
  b=UFgGC2h7IF0XQGlUnUbWXihMjx2rU/sHOJr+PM/z1UZC+0a68kyjrBE9
   ox3nkTlXsxeFzav86N48Lv8UPwC6VkuTkYw+giz1gb7xmO5TMyUPku2gs
   dAhRw6fnVxKaCz+exB0Ckx3G/MA9mCbOwW/EFUG/duKeyuZXO8J1bUJ/y
   d3fZAMonPmTIYPLu0KYxuoJMLCSLnG5jQRSRIZNVHGetty67nsx+TZzv3
   lmGob156jpvF7PdNTdNVsHkvxqMXMsRI5ZRlojmhvTU6WtinNANueqAvH
   +aAN2Ygl5XwJKdEk47GvgOQAHbP9emvduIDgPlUf2gEzX6iBZ1Ccwb3NM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322350061"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322350061"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="795772791"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 08 Apr 2022 11:19:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3478E3D5; Fri,  8 Apr 2022 21:18:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 4/5] gpiolib: Extract gpio_chip_get_value() wrapper
Date:   Fri,  8 Apr 2022 21:18:53 +0300
Message-Id: <20220408181854.73528-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408181854.73528-1-andriy.shevchenko@linux.intel.com>
References: <20220408181854.73528-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In couple of cases we are using the same code to wrap ->get() callback.
Extract that code into a helper for the sake of better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/gpio/gpiolib.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 43b0cae69bcd..f537597838bb 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2532,6 +2532,11 @@ void gpiod_toggle_active_low(struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_toggle_active_low);
 
+static int gpio_chip_get_value(struct gpio_chip *gc, const struct gpio_desc *desc)
+{
+	return gc->get ? gc->get(gc, gpio_chip_hwgpio(desc)) : -EIO;
+}
+
 /* I/O calls are only valid after configuration completed; the relevant
  * "is this a valid GPIO" error checks should already have been done.
  *
@@ -2557,12 +2562,10 @@ EXPORT_SYMBOL_GPL(gpiod_toggle_active_low);
 static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 {
 	struct gpio_chip	*gc;
-	int offset;
 	int value;
 
 	gc = desc->gdev->chip;
-	offset = gpio_chip_hwgpio(desc);
-	value = gc->get ? gc->get(gc, offset) : -EIO;
+	value = gpio_chip_get_value(gc, desc);
 	value = value < 0 ? value : !!value;
 	trace_gpio_value(desc_to_gpio(desc), 1, value);
 	return value;
@@ -4406,7 +4409,7 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 		if (test_bit(FLAG_REQUESTED, &desc->flags)) {
 			gpiod_get_direction(desc);
 			is_out = test_bit(FLAG_IS_OUT, &desc->flags);
-			value = gc->get ? gc->get(gc, gpio_chip_hwgpio(desc)) : -EIO;
+			value = gpio_chip_get_value(gc, desc);
 			is_irq = test_bit(FLAG_USED_AS_IRQ, &desc->flags);
 			active_low = test_bit(FLAG_ACTIVE_LOW, &desc->flags);
 			seq_printf(s, " gpio-%-3d (%-20.20s|%-20.20s) %s %s %s%s\n",
-- 
2.35.1

