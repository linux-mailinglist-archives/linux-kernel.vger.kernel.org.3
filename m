Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE48507025
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353222AbiDSOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353248AbiDSOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B1528C;
        Tue, 19 Apr 2022 07:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CE376173A;
        Tue, 19 Apr 2022 14:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6936AC385A5;
        Tue, 19 Apr 2022 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650377988;
        bh=+QxZ0AFfHO0HPnu0vUZbULv9A+ukUAPH3zMA4OFW3BU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAyWB7fToPW7vYD3Wpd0WR1jcVzHuZgapeMremUKnleZ3bqSXFfSPdHuBCmjbv3YW
         CZQUfnUUmv5kLA5XmXUnAcaAZeVLVUIHYO6bUMRJ5DDUAc1mbiN4dx4W2FYVyzaufc
         AXVzZlU/HThM/8lp9/SMw7HyPOgUU7XSXaJhlCI8BCjnes4HDCsr3Hsn47ScYFymTT
         R4lE47KPSWjN3CvY3YqaOvpuEzggskq613AzTqP88IrywGD0kMUJmzghBTryQAsMd3
         nKkf/33hm7ooPnqjPAh7KCjoVRtxQnv9s1RcFSAyM4yGvoHFakriAize8bhkjLnBAz
         HYHQ0BPb1ccQw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ngoh3-005MFS-E1; Tue, 19 Apr 2022 15:19:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v3 10/10] Documentation: Update the recommended pattern for GPIO irqchips
Date:   Tue, 19 Apr 2022 15:18:46 +0100
Message-Id: <20220419141846.598305-11-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419141846.598305-1-maz@kernel.org>
References: <20220419141846.598305-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, jeffrey.l.hugo@gmail.com, tglx@linutronix.de, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to get rid of the per-gpio_irq_chip
irq_chip structure, and give examples of the new pattern.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/driver-api/gpio/driver.rst | 175 ++++++++++++++++++-----
 1 file changed, 142 insertions(+), 33 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index bbc53920d4dd..a1ddefa1f55f 100644
--- a/Documentation/driver-api/gpio/driver.rst
+++ b/Documentation/driver-api/gpio/driver.rst
@@ -417,30 +417,66 @@ struct gpio_irq_chip inside struct gpio_chip before adding the gpio_chip.
 If you do this, the additional irq_chip will be set up by gpiolib at the
 same time as setting up the rest of the GPIO functionality. The following
 is a typical example of a chained cascaded interrupt handler using
-the gpio_irq_chip:
+the gpio_irq_chip. Note how the mask/unmask (or disable/enable) functions
+call into the core gpiolib code:
 
 .. code-block:: c
 
-  /* Typical state container with dynamic irqchip */
+  /* Typical state container */
   struct my_gpio {
       struct gpio_chip gc;
-      struct irq_chip irq;
+  };
+
+  static void my_gpio_mask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+
+      /*
+       * Perform any necessary action to mask the interrupt,
+       * and then call into the core code to synchronise the
+       * state.
+       */
+
+      gpiochip_disable_irq(gc, d->hwirq);
+  }
+
+  static void my_gpio_unmask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+
+      gpiochip_enable_irq(gc, d->hwirq);
+
+      /*
+       * Perform any necessary action to unmask the interrupt,
+       * after having called into the core code to synchronise
+       * the state.
+       */
+  }
+
+  /*
+   * Statically populate the irqchip. Note that it is made const
+   * (further indicated by the IRQCHIP_IMMUTABLE flag), and that
+   * the GPIOCHIP_IRQ_RESOURCE_HELPER macro adds some extra
+   * callbacks to the structure.
+   */
+  static const struct irq_chip my_gpio_irq_chip = {
+      .name		= "my_gpio_irq",
+      .irq_ack		= my_gpio_ack_irq,
+      .irq_mask		= my_gpio_mask_irq,
+      .irq_unmask	= my_gpio_unmask_irq,
+      .irq_set_type	= my_gpio_set_irq_type,
+      .flags		= IRQCHIP_IMMUTABLE,
+      /* Provide the gpio resource callbacks */
+      GPIOCHIP_IRQ_RESOURCE_HELPERS,
   };
 
   int irq; /* from platform etc */
   struct my_gpio *g;
   struct gpio_irq_chip *girq;
 
-  /* Set up the irqchip dynamically */
-  g->irq.name = "my_gpio_irq";
-  g->irq.irq_ack = my_gpio_ack_irq;
-  g->irq.irq_mask = my_gpio_mask_irq;
-  g->irq.irq_unmask = my_gpio_unmask_irq;
-  g->irq.irq_set_type = my_gpio_set_irq_type;
-
   /* Get a pointer to the gpio_irq_chip */
   girq = &g->gc.irq;
-  girq->chip = &g->irq;
+  gpio_irq_chip_set_chip(girq, &my_gpio_irq_chip);
   girq->parent_handler = ftgpio_gpio_irq_handler;
   girq->num_parents = 1;
   girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
@@ -458,23 +494,58 @@ the interrupt separately and go with it:
 
 .. code-block:: c
 
-  /* Typical state container with dynamic irqchip */
+  /* Typical state container */
   struct my_gpio {
       struct gpio_chip gc;
-      struct irq_chip irq;
+  };
+
+  static void my_gpio_mask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+
+      /*
+       * Perform any necessary action to mask the interrupt,
+       * and then call into the core code to synchronise the
+       * state.
+       */
+
+      gpiochip_disable_irq(gc, d->hwirq);
+  }
+
+  static void my_gpio_unmask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+
+      gpiochip_enable_irq(gc, d->hwirq);
+
+      /*
+       * Perform any necessary action to unmask the interrupt,
+       * after having called into the core code to synchronise
+       * the state.
+       */
+  }
+
+  /*
+   * Statically populate the irqchip. Note that it is made const
+   * (further indicated by the IRQCHIP_IMMUTABLE flag), and that
+   * the GPIOCHIP_IRQ_RESOURCE_HELPER macro adds some extra
+   * callbacks to the structure.
+   */
+  static const struct irq_chip my_gpio_irq_chip = {
+      .name		= "my_gpio_irq",
+      .irq_ack		= my_gpio_ack_irq,
+      .irq_mask		= my_gpio_mask_irq,
+      .irq_unmask	= my_gpio_unmask_irq,
+      .irq_set_type	= my_gpio_set_irq_type,
+      .flags		= IRQCHIP_IMMUTABLE,
+      /* Provide the gpio resource callbacks */
+      GPIOCHIP_IRQ_RESOURCE_HELPERS,
   };
 
   int irq; /* from platform etc */
   struct my_gpio *g;
   struct gpio_irq_chip *girq;
 
-  /* Set up the irqchip dynamically */
-  g->irq.name = "my_gpio_irq";
-  g->irq.irq_ack = my_gpio_ack_irq;
-  g->irq.irq_mask = my_gpio_mask_irq;
-  g->irq.irq_unmask = my_gpio_unmask_irq;
-  g->irq.irq_set_type = my_gpio_set_irq_type;
-
   ret = devm_request_threaded_irq(dev, irq, NULL,
 		irq_thread_fn, IRQF_ONESHOT, "my-chip", g);
   if (ret < 0)
@@ -482,7 +553,7 @@ the interrupt separately and go with it:
 
   /* Get a pointer to the gpio_irq_chip */
   girq = &g->gc.irq;
-  girq->chip = &g->irq;
+  gpio_irq_chip_set_chip(girq, &my_gpio_irq_chip);
   /* This will let us handle the parent IRQ in the driver */
   girq->parent_handler = NULL;
   girq->num_parents = 0;
@@ -500,24 +571,61 @@ In this case the typical set-up will look like this:
   /* Typical state container with dynamic irqchip */
   struct my_gpio {
       struct gpio_chip gc;
-      struct irq_chip irq;
       struct fwnode_handle *fwnode;
   };
 
-  int irq; /* from platform etc */
+  static void my_gpio_mask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+
+      /*
+       * Perform any necessary action to mask the interrupt,
+       * and then call into the core code to synchronise the
+       * state.
+       */
+
+      gpiochip_disable_irq(gc, d->hwirq);
+      irq_mask_mask_parent(d);
+  }
+
+  static void my_gpio_unmask_irq(struct irq_data *d)
+  {
+      struct gpio_chip *gc = irq_desc_get_handler_data(d);
+
+      gpiochip_enable_irq(gc, d->hwirq);
+
+      /*
+       * Perform any necessary action to unmask the interrupt,
+       * after having called into the core code to synchronise
+       * the state.
+       */
+
+      irq_mask_unmask_parent(d);
+  }
+
+  /*
+   * Statically populate the irqchip. Note that it is made const
+   * (further indicated by the IRQCHIP_IMMUTABLE flag), and that
+   * the GPIOCHIP_IRQ_RESOURCE_HELPER macro adds some extra
+   * callbacks to the structure.
+   */
+  static const struct irq_chip my_gpio_irq_chip = {
+      .name		= "my_gpio_irq",
+      .irq_ack		= my_gpio_ack_irq,
+      .irq_mask		= my_gpio_mask_irq,
+      .irq_unmask	= my_gpio_unmask_irq,
+      .irq_set_type	= my_gpio_set_irq_type,
+      .flags		= IRQCHIP_IMMUTABLE,
+      /* Provide the gpio resource callbacks */
+      GPIOCHIP_IRQ_RESOURCE_HELPERS,
+  };
+
   struct my_gpio *g;
   struct gpio_irq_chip *girq;
 
-  /* Set up the irqchip dynamically */
-  g->irq.name = "my_gpio_irq";
-  g->irq.irq_ack = my_gpio_ack_irq;
-  g->irq.irq_mask = my_gpio_mask_irq;
-  g->irq.irq_unmask = my_gpio_unmask_irq;
-  g->irq.irq_set_type = my_gpio_set_irq_type;
-
   /* Get a pointer to the gpio_irq_chip */
   girq = &g->gc.irq;
-  girq->chip = &g->irq;
+  gpio_irq_chip_set_chip(girq, &my_gpio_irq_chip);
   girq->default_type = IRQ_TYPE_NONE;
   girq->handler = handle_bad_irq;
   girq->fwnode = g->fwnode;
@@ -605,8 +713,9 @@ When implementing an irqchip inside a GPIO driver, these two functions should
 typically be called in the .irq_disable() and .irq_enable() callbacks from the
 irqchip.
 
-When using the gpiolib irqchip helpers, these callbacks are automatically
-assigned.
+When IRQCHIP_IMMUTABLE is not advertised by the irqchip, these callbacks
+are automatically assigned. This behaviour is deprecated and on its way
+to be removed from the kernel.
 
 
 Real-Time compliance for GPIO IRQ chips
-- 
2.34.1

