Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874265253EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357200AbiELRmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357183AbiELRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:41:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2E60BAB;
        Thu, 12 May 2022 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652377315; x=1683913315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJ1onh2Zr7lWF0ZhgH2Zhxb8WH3RUU0eJg8bTS9xfQg=;
  b=Z0xXA5C3z34Lv+yU8ibYWBBBRG0AKvZUAActEIVby6AXVjQ1fbToYRix
   UPNfgw3vkRHySAF/v5MEVhjz1dzEkoEvvSh3Swgrm38qoKlWRdIutnJZv
   NpKFzNd4KmK757U8k446xdtrGsGMiZPwKzos1FggpJbXPxUq4/58Trlws
   ldosR7vUB86qzD2D4FppIs3kum1fFU0P6SYkVaUVLR+6Vil8kgFi4bKw5
   tTyV+ck/8cXWJibq7gLU08MWqCGRhvux8MPRUw/sfpEGi7unifcw4s/Rb
   FSQRi8BhUt+vbaUngbqfrfo5vSDqQwDFzWmv2vLkF/oJ/BUvS12XH4Zye
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270026663"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="270026663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="712025245"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 May 2022 10:39:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4609A45; Thu, 12 May 2022 20:39:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 2/5] Documentation: gpio: Advertise irqd_to_hwirq() helper in the examples
Date:   Thu, 12 May 2022 20:39:18 +0300
Message-Id: <20220512173921.8210-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
References: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of direct dereferencing the IRQ data in order to get HW IRQ number
use the irqd_to_hwirq() helper.

Fixes: 5644b66a9c63 ("Documentation: Update the recommended pattern for GPIO irqchips")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/driver.rst | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index 964d09118d17..70ff43ac4fcc 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -430,6 +430,7 @@ call into the core gpiolib code:
   static void my_gpio_mask_irq(struct irq_data *d)
   {
       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+      irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
       /*
        * Perform any necessary action to mask the interrupt,
@@ -437,14 +438,15 @@ call into the core gpiolib code:
        * state.
        */
 
-      gpiochip_disable_irq(gc, d->hwirq);
+      gpiochip_disable_irq(gc, hwirq);
   }
 
   static void my_gpio_unmask_irq(struct irq_data *d)
   {
       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+      irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-      gpiochip_enable_irq(gc, d->hwirq);
+      gpiochip_enable_irq(gc, hwirq);
 
       /*
        * Perform any necessary action to unmask the interrupt,
@@ -502,6 +504,7 @@ the interrupt separately and go with it:
   static void my_gpio_mask_irq(struct irq_data *d)
   {
       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+      irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
       /*
        * Perform any necessary action to mask the interrupt,
@@ -509,14 +512,15 @@ the interrupt separately and go with it:
        * state.
        */
 
-      gpiochip_disable_irq(gc, d->hwirq);
+      gpiochip_disable_irq(gc, hwirq);
   }
 
   static void my_gpio_unmask_irq(struct irq_data *d)
   {
       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+      irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-      gpiochip_enable_irq(gc, d->hwirq);
+      gpiochip_enable_irq(gc, hwirq);
 
       /*
        * Perform any necessary action to unmask the interrupt,
@@ -577,6 +581,7 @@ In this case the typical set-up will look like this:
   static void my_gpio_mask_irq(struct irq_data *d)
   {
       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+      irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
       /*
        * Perform any necessary action to mask the interrupt,
@@ -584,15 +589,16 @@ In this case the typical set-up will look like this:
        * state.
        */
 
-      gpiochip_disable_irq(gc, d->hwirq);
+      gpiochip_disable_irq(gc, hwirq);
       irq_mask_mask_parent(d);
   }
 
   static void my_gpio_unmask_irq(struct irq_data *d)
   {
       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+      irq_hw_number_t hwirq = irqd_to_hwirq(d);
 
-      gpiochip_enable_irq(gc, d->hwirq);
+      gpiochip_enable_irq(gc, hwirq);
 
       /*
        * Perform any necessary action to unmask the interrupt,
-- 
2.35.1

