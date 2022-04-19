Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8135070A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353366AbiDSOb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353320AbiDSObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2354231342
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:01 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650378539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUcG/cHeHK2avOj5MIwspmxy4joi1MvGPD/smAa0W4k=;
        b=2i3g6CUPP//M7Ym/UglVuW7nezGcNnyoeEevSfiJsi5xcgx+LpEMM/5TKucF84gr3qgS2N
        6HY7CAWlZZP/6GrdGGhwhMM8dgdn8LJ3odyfA5BJYCXxXZFkag5kE9FkwOmuEtn4Eecg9R
        nJJRv/dAITjpqVDlThe6k7RfPe7IGBsWjE/ydXUJ/WY+h+IaslRQeXfkdoYvjN9kI/XSMV
        F0sRIkz+wJ0h61UjNWWgmu5imXRSskhG3Lezdy+RzHpFyRIPcNvl20wCxmolux3x+ngD1s
        tHs9rzg235b5aeACWiJhbdDpBX0oPl8IO8CEUP5n4EdM2LkToWO/IwPCqWCqug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650378539;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fUcG/cHeHK2avOj5MIwspmxy4joi1MvGPD/smAa0W4k=;
        b=E9rvABNyDENKXTexvv/rRzUhTiGCtG5BCg2xWtookizocz6iT1bKdRAp6RbYJFszxiMXpz
        KWAI84demRfOZTAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] Documentation: Update the recommended
 pattern for GPIO irqchips
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220419141846.598305-11-maz@kernel.org>
References: <20220419141846.598305-11-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165037853825.4207.5139833137669251964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5644b66a9c63c3cadc6ba85faf5a15604e6cf29a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5644b66a9c63c3cadc6ba85faf5a15604e6cf29a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 Apr 2022 15:18:46 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Apr 2022 15:22:27 +01:00

Documentation: Update the recommended pattern for GPIO irqchips

Update the documentation to get rid of the per-gpio_irq_chip
irq_chip structure, and give examples of the new pattern.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-11-maz@kernel.org
---
 Documentation/driver-api/gpio/driver.rst | 175 +++++++++++++++++-----
 1 file changed, 142 insertions(+), 33 deletions(-)

diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
index bbc5392..a1ddefa 100644
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
