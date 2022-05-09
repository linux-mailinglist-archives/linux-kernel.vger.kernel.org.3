Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC0051FF16
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiEIOIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiEIOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:08:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E928FE95;
        Mon,  9 May 2022 07:04:12 -0700 (PDT)
Date:   Mon, 9 May 2022 16:04:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652105050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=vkv8HBPFx6WlkqEMz3LJTFoSbV8VQ/L5ryA8fWqm968=;
        b=o1wwuTeMmQcpAkUaprbcn6XoOJLnhk3S7uyIcDPBnmQujDQvjSyvsBKPpX4EbaYg0SyJrw
        vSMOHPbHeLikKMh159ZagB123pAShjR1ygxRWG9c7Aw61FhjrC4JmHj4aRjOrrdFUxlFhg
        erAyTX844QfySyeSrndxJ+G7YJ0Fbn1Pi1Nwd52nMtnWyuC0ZwNKiIdUGMwiXofZp4j3AX
        sV2PU7069wepTKSDl3SmAtIEwdFx/LPj3ZwLUQg8JRvbL2+pdgwXB2Ufpa79HfNSL//xa4
        Ys+PlnQq+oBJgoh/YGuY9VFK5oB6lHinvHgzImDZXBMosqr9SC9jrL0aiS71lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652105050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=vkv8HBPFx6WlkqEMz3LJTFoSbV8VQ/L5ryA8fWqm968=;
        b=XfcHOKM5w4lYvL6EVj0TvlvjvHYtjNUSkVl9sSi6CIhYTPicntmECZOlwNwzENXBZuHSFZ
        hkSbF/vYa3C02FCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Gross <markgross@kernel.org>, Michael Buesch <m@bues.ch>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [RFC PATCH] genirq: Provide generic_handle_domain_irq_safe().
Message-ID: <YnkfWFzvusFFktSt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide generic_handle_domain_irq_safe() which can used from any context.
This similar to commit
   509853f9e1e7b ("genirq: Provide generic_handle_irq_safe()")

but this time for the irq-domains interface. It has been reported for
the amd-pinctrl driver via bugzilla
   https://bugzilla.kernel.org/show_bug.cgi?id=215954

I looked around and added a few users so it is not just one user API :)
Instead of generic_handle_irq(irq_find_mapping)) one can use
generic_handle_domain_irq().

The problem with generic_handle_domain_irq() is that with `threadirqs'
it will trigger "WARN_ON_ONCE(!in_hardirq())". That interrupt handler
can't be marked non-threaded because it is a shared handler (it is
marked as such and I can't tell the interrupt can be really shared on
the system).
Ignoring the just mentioned warning, on PREEMPT_RT the threaded handler
is invoked with enabled interrupts leading other problems.

Do we do this?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/bcma/driver_gpio.c                 |  2 +-
 drivers/gpio/gpio-mlxbf2.c                 |  6 ++----
 drivers/pinctrl/pinctrl-amd.c              |  2 +-
 drivers/platform/x86/intel/int0002_vgpio.c |  3 +--
 drivers/ssb/driver_gpio.c                  |  6 ++++--
 include/linux/irqdesc.h                    |  1 +
 kernel/irq/irqdesc.c                       | 24 ++++++++++++++++++++++
 7 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 1e74ec1c7f231..ed2730a21e7c4 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -113,7 +113,7 @@ static irqreturn_t bcma_gpio_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	for_each_set_bit(gpio, &irqs, gc->ngpio)
-		generic_handle_irq(irq_find_mapping(gc->irq.domain, gpio));
+		generic_handle_domain_irq_safe(gc->irq.domain, gpio);
 	bcma_chipco_gpio_polarity(cc, irqs, val & irqs);
 
 	return IRQ_HANDLED;
diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 3d89912a05b87..d4916f32fee73 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -273,10 +273,8 @@ static irqreturn_t mlxbf2_gpio_irq_handler(int irq, void *ptr)
 	pending = readl(gs->gpio_io + YU_GPIO_CAUSE_OR_CAUSE_EVTEN0);
 	writel(pending, gs->gpio_io + YU_GPIO_CAUSE_OR_CLRCAUSE);
 
-	for_each_set_bit(level, &pending, gc->ngpio) {
-		int gpio_irq = irq_find_mapping(gc->irq.domain, level);
-		generic_handle_irq(gpio_irq);
-	}
+	for_each_set_bit(level, &pending, gc->ngpio)
+		generic_handle_domain_irq_safe(gc->irq.domain, level);
 
 	return IRQ_RETVAL(pending);
 }
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 1a7d686494ffb..ce6fa6a76d1f6 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -638,7 +638,7 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
 			if (!(regval & PIN_IRQ_PENDING) ||
 			    !(regval & BIT(INTERRUPT_MASK_OFF)))
 				continue;
-			generic_handle_domain_irq(gc->irq.domain, irqnr + i);
+			generic_handle_domain_irq_safe(gc->irq.domain, irqnr + i);
 
 			/* Clear interrupt.
 			 * We must read the pin register again, in case the
diff --git a/drivers/platform/x86/intel/int0002_vgpio.c b/drivers/platform/x86/intel/int0002_vgpio.c
index 617dbf98980ec..97cfbc520a02c 100644
--- a/drivers/platform/x86/intel/int0002_vgpio.c
+++ b/drivers/platform/x86/intel/int0002_vgpio.c
@@ -125,8 +125,7 @@ static irqreturn_t int0002_irq(int irq, void *data)
 	if (!(gpe_sts_reg & GPE0A_PME_B0_STS_BIT))
 		return IRQ_NONE;
 
-	generic_handle_irq(irq_find_mapping(chip->irq.domain,
-					    GPE0A_PME_B0_VIRT_GPIO_PIN));
+	generic_handle_domain_irq_safe(chip->irq.domain, GPE0A_PME_B0_VIRT_GPIO_PIN);
 
 	pm_wakeup_hard_event(chip->parent);
 
diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 2de3896489c84..897cb8db5084f 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -132,7 +132,8 @@ static irqreturn_t ssb_gpio_irq_chipco_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	for_each_set_bit(gpio, &irqs, bus->gpio.ngpio)
-		generic_handle_irq(ssb_gpio_to_irq(&bus->gpio, gpio));
+		generic_handle_domain_irq_safe(bus->irq_domain, gpio);
+
 	ssb_chipco_gpio_polarity(chipco, irqs, val & irqs);
 
 	return IRQ_HANDLED;
@@ -330,7 +331,8 @@ static irqreturn_t ssb_gpio_irq_extif_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	for_each_set_bit(gpio, &irqs, bus->gpio.ngpio)
-		generic_handle_irq(ssb_gpio_to_irq(&bus->gpio, gpio));
+		generic_handle_domain_irq_safe(bus->irq_domain, gpio);
+
 	ssb_extif_gpio_polarity(extif, irqs, val & irqs);
 
 	return IRQ_HANDLED;
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index a77584593f7d1..98253955e2ae7 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -169,6 +169,7 @@ int generic_handle_irq_safe(unsigned int irq);
  * conversion failed.
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq);
+int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int hwirq);
 int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq);
 #endif
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 0099b87dd8530..48c34d47255cc 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -706,6 +706,30 @@ int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
 
+ /**
+ * generic_handle_irq_safe - Invoke the handler for a HW irq belonging
+ *			     to a domain from any context.
+ * @domain:	The domain where to perform the lookup
+ * @hwirq:	The HW irq number to convert to a logical one
+ *
+ * Returns:	0 on success, a negative value on error.
+ *
+ * This function can be called from any context (IRQ or process context). It
+ * will report an error if not invoked from IRQ context and the irq has been
+ * marked to enforce IRQ-context only.
+ */
+int generic_handle_domain_irq_safe(struct irq_domain *domain, unsigned int hwirq)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	ret = handle_irq_desc(irq_resolve_mapping(domain, hwirq));
+	local_irq_restore(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(generic_handle_domain_irq_safe);
+
 /**
  * generic_handle_domain_nmi - Invoke the handler for a HW nmi belonging
  *                             to a domain.
-- 
2.36.0

