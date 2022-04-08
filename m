Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657554F9C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiDHSWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiDHSWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:22:13 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18ADF210446;
        Fri,  8 Apr 2022 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649442009; x=1680978009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKUjsNblrBgidDnwVRh1KChbR0yIH3x6mp920Ncsy3I=;
  b=CnWYHYKpTVuwLP74ukfttN5HLBdUyeO6EwGl8d8/uNo9fpkV75laAwia
   8jUdyc1d8oBkuzYmiaOOFieJugBxxyJTXk7KcCFYrVOV+SN3Ovb4R1DgN
   0bf5rfOs8BWVL8MTYdS6LiA3GQ17zKrvG4ulG7iIugYtIuaY7iMVVN39a
   XAixaHKZSlVi+NBcvKfWhWBgx/+Xb0cp0Vh3UO7u4PKNnmOYQB7wCzqIi
   wejuNdBuNQpYLcrN4PWPxs0GIbaESjlmLaYPC1RXQZDNvL+yj87GJhKLz
   m7biIBa1BfjOZNZ4B0cixIJL9rnivpXB3KhLeGwjfW+BysHKvHO65J4b1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="322350058"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322350058"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="642993515"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2022 11:19:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 19BFB120; Fri,  8 Apr 2022 21:18:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 2/5] gpiolib: Split out for_each_gpio_desc() macro
Date:   Fri,  8 Apr 2022 21:18:51 +0300
Message-Id: <20220408181854.73528-2-andriy.shevchenko@linux.intel.com>
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

In some cases we want to traverse all GPIO descriptors for given
chip, let's split out for_each_gpio_desc() macro for such cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on patch 1
 drivers/gpio/gpiolib.c | 11 +++--------
 drivers/gpio/gpiolib.h |  5 ++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 96b5da6a8c3b..58a57540b834 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -309,15 +309,10 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
-		int i;
-
-		for (i = 0; i != gdev->ngpio; ++i) {
-			struct gpio_desc *desc = &gdev->descs[i];
-
-			if (!desc->name)
-				continue;
+		struct gpio_desc *desc;
 
-			if (!strcmp(desc->name, name)) {
+		for_each_gpio_desc(gdev->chip, desc) {
+			if (desc->name && !strcmp(desc->name, name)) {
 				spin_unlock_irqrestore(&gpio_lock, flags);
 				return desc;
 			}
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 7bac62d36f0c..eef3ec073d9e 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -100,10 +100,13 @@ struct gpio_array {
 
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 
-#define for_each_gpio_desc_with_flag(gc, desc, flag)			\
+#define for_each_gpio_desc(gc, desc)					\
 	for (unsigned int __i = 0;					\
 	     __i < gc->ngpio && (desc = gpiochip_get_desc(gc, __i));	\
 	     __i++)							\
+
+#define for_each_gpio_desc_with_flag(gc, desc, flag)			\
+	for_each_gpio_desc(gc, desc)					\
 		if (!test_bit(flag, &desc->flags)) {} else
 
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
-- 
2.35.1

