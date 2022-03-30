Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD414EC7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347733AbiC3PBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347703AbiC3PBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:01:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFAF6143;
        Wed, 30 Mar 2022 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648652360; x=1680188360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AiSqgbY3F6e8CsDBfyfXq406U2Lox0vVd6FYIM9rs5Q=;
  b=hVShMPkcVDG/CpDtOqHJT+uzBsogUa4FgW1Pce/AmU3Npi4iKU0DuZ6c
   ++oHj/pT8qTw7c+FpgdyFbbOIebhnJiXVm7RCIr54lAsr0ppyo83Ozv4G
   RdzXsxg6JywV5+pSEvM3fhP34W5lZi0phFHE6H1RSxdBW1he0dRHl4sB4
   skJu14tHO4ye8XbpJ3vyelluXD0e7xmL0Y5tD6RE1l8uV/6WQ4EKDq9zQ
   m+lNHZBAowTUZ9axamkBpJh0ffdCtZtjfedicCBpXDLhrDzSmF0GtJefS
   YEGEGMeJI/foxO00LbdrwArd1kvh2yxqfIlJjxkhoRsO0r70V8/pkb65c
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259535483"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259535483"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:58:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="605462521"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2022 07:58:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AA775144; Wed, 30 Mar 2022 17:59:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/3] gpiolib: Split out for_each_gpio_desc() macro
Date:   Wed, 30 Mar 2022 17:59:08 +0300
Message-Id: <20220330145910.1946-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

In some cases we want to traverse all GPIO descriptors for given
chip, let's split out for_each_gpio_desc() macro for such cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 10 +++-------
 drivers/gpio/gpiolib.h |  7 +++++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e59884cc12a7..723411c13f1c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -310,15 +310,11 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
+		struct gpio_desc *desc;
 		int i;
 
-		for (i = 0; i != gdev->ngpio; ++i) {
-			struct gpio_desc *desc = &gdev->descs[i];
-
-			if (!desc->name)
-				continue;
-
-			if (!strcmp(desc->name, name)) {
+		for_each_gpio_desc(i, gdev->chip, desc) {
+			if (desc->name && !strcmp(desc->name, name)) {
 				spin_unlock_irqrestore(&gpio_lock, flags);
 				return desc;
 			}
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 06f3faa9fbef..450fb2fabe43 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -100,10 +100,13 @@ struct gpio_array {
 
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 
-#define for_each_gpio_desc_with_flag(i, gc, desc, flag)		\
+#define for_each_gpio_desc(i, gc, desc)				\
 	for (i = 0, desc = gpiochip_get_desc(gc, i);		\
 	     i < gc->ngpio;					\
-	     i++, desc = gpiochip_get_desc(gc, i))		\
+	     i++, desc = gpiochip_get_desc(gc, i))
+
+#define for_each_gpio_desc_with_flag(i, gc, desc, flag)		\
+	for_each_gpio_desc(i, gc, desc)				\
 		if (!test_bit(flag, &desc->flags)) {} else
 
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
-- 
2.35.1

