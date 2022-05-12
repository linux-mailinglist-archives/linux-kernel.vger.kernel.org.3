Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DCE5253DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357141AbiELRjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355439AbiELRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:39:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C6267096;
        Thu, 12 May 2022 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652377177; x=1683913177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=57zZUQo2XpYyqv/Fq0Q307fjDwWri2ChI3FAS8rHfMs=;
  b=BIk7ms8iFTjQbBOZm40PjyGlMEmeSHzMZcEWwi2mGIjOhoTXxBeTeNGH
   LBNJ45zWVBOU1kFs9zE2yNnwDe9sON8/Sg4hFBmfKprcWIHjo0Uq4BFTc
   X4cCv6xonVfvjvkvOYOKBm2Q7Mlr0T2ea+qgc1LO7KX2MXWU404zGMOyt
   yEECKrUH6lDbGjoLiGWy4t/S9eu3vWA7ZVoGhTmJBF6BPRirXDqGtI/4+
   KONCCoN5EJMz0yM7hPdufBgalhNoAb9j6/9UjLxaDHx00GxOJqleZAsou
   UiGMZiMaz6ubMC0yq8mfgRptTVEaqBhA6Mn1EXuWBpY0KCdnWhxZUffJa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="330691118"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="330691118"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:39:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="594787760"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 12 May 2022 10:39:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 378A9CE; Thu, 12 May 2022 20:39:32 +0300 (EEST)
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
Subject: [PATCH v1 1/5] Documentation: gpio: Fix IRQ mask and unmask examples
Date:   Thu, 12 May 2022 20:39:17 +0300
Message-Id: <20220512173921.8210-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After switching to immutable IRQ chips for GPIO drivers the examples become
uncompilable due to wrong IRQ API, i.e. irq_desc_get_handler_data() in use.
Replace it with proper irq_data_get_irq_chip_data() call where it applies.

Fixes: 5644b66a9c63 ("Documentation: Update the recommended pattern for GPIO irqchips")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/driver-api/gpio/driver.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index a1ddefa1f55f..964d09118d17 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -429,7 +429,7 @@ call into the core gpiolib code:
 
   static void my_gpio_mask_irq(struct irq_data *d)
   {
-      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+      struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 
       /*
        * Perform any necessary action to mask the interrupt,
@@ -442,7 +442,7 @@ call into the core gpiolib code:
 
   static void my_gpio_unmask_irq(struct irq_data *d)
   {
-      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+      struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 
       gpiochip_enable_irq(gc, d->hwirq);
 
@@ -501,7 +501,7 @@ the interrupt separately and go with it:
 
   static void my_gpio_mask_irq(struct irq_data *d)
   {
-      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+      struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 
       /*
        * Perform any necessary action to mask the interrupt,
@@ -514,7 +514,7 @@ the interrupt separately and go with it:
 
   static void my_gpio_unmask_irq(struct irq_data *d)
   {
-      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+      struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 
       gpiochip_enable_irq(gc, d->hwirq);
 
@@ -576,7 +576,7 @@ In this case the typical set-up will look like this:
 
   static void my_gpio_mask_irq(struct irq_data *d)
   {
-      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+      struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 
       /*
        * Perform any necessary action to mask the interrupt,
@@ -590,7 +590,7 @@ In this case the typical set-up will look like this:
 
   static void my_gpio_unmask_irq(struct irq_data *d)
   {
-      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+      struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 
       gpiochip_enable_irq(gc, d->hwirq);
 
-- 
2.35.1

