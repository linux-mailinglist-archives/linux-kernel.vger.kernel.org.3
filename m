Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2167352364E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbiEKOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245193AbiEKOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:55:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF9209542;
        Wed, 11 May 2022 07:55:20 -0700 (PDT)
Date:   Wed, 11 May 2022 16:55:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652280918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hYeyGvfOKoOlLwg0xBvDzrn+xOFV2zqrKC4RINOZPIU=;
        b=Hhvsl6XerDQJqg4e5eTMOJmhjEmLKMpBv0VL2zW+E3gYNkLi5YO7Mocc1Kg+ed1CKb1jP/
        +6XyGmxqmgAtZjAoIG0BZRJC9O0ly75utiLXDWKow8NrkWwOdxXlukXIVMYx372lnZqy/X
        K38svrMABqaJdlYodUIVe/2lyRVasrLtey6Dqa7Ipaqu0dZON3f9B3Ltbl+29eX0FPF7NB
        u97EJeGIy0P/0QAok/0EodOmwQvMHDF7wHrkEKETBO5i5BI59vjqeWd8O8iWPDKoiWzAJX
        VukvVDDbCmTWVPgPLG/u1Sww2wcrf2wsz3O8NWPszwoigltQFiKZ2DnHgYHFYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652280918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=hYeyGvfOKoOlLwg0xBvDzrn+xOFV2zqrKC4RINOZPIU=;
        b=AzSafweYuyOvuLhgE9ppxB/l5LL12WdWk+HZK0WXaG9srkbTzJ343plQIAMT2cb+1RoZux
        YxelNtDqHGA0Y6DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.18-rc6-rt7
Message-ID: <YnvOVA2GbFncWG3K@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.18-rc6-rt7 patch set. 

Changes since v5.18-rc6-rt6:

  - The irq simulator did not invoke the interrupts in hardirq context,
    as it should.

  - Provide generic_handle_domain_irq_safe(). It has been reported via
    the kernel bugzilla that the amd-pincrl driver reports interrupts in
    the wrong context.

  - rcutorture could miss pending timers because ktimers runs at the
    same priority as the rcutorture thread. Patch by Frederic
    Weisbecker.

  - Since the introduction of timersd in v5.16-rc3-rt7 there can be a in
    the NO_HZ mode. Patch by Frederic Weisbecker.

  - A small optimisation in iio's stm32-adc driver.

  - An unused macro in lockdep has been removed.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.18-rc6-rt6 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/incr/patch-5.18-rc6-rt6-rt7.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.18-rc6-rt7

The RT patch against v5.18-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patch-5.18-rc6-rt7.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.18/older/patches-5.18-rc6-rt7.tar.xz

Sebastian

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
diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 1426562321575..c8fc97e52fef4 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -356,7 +356,7 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
 		if ((status & priv->cfg->regs->eoc_msk[i] &&
 		     stm32_adc_eoc_enabled(priv, i)) ||
 		     (status & priv->cfg->regs->ovr_msk[i]))
-			generic_handle_irq(irq_find_mapping(priv->domain, i));
+			generic_handle_domain_irq(priv->domain, i);
 	}
 
 	chained_irq_exit(chip, desc);
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
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index b19a3d00ba787..68cf87ed6177a 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -624,9 +624,17 @@ extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 
 #ifdef CONFIG_PREEMPT_RT
+DECLARE_PER_CPU(struct task_struct *, timersd);
+DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
+
 extern void raise_timer_softirq(void);
 extern void raise_hrtimer_softirq(void);
 
+static inline unsigned int local_pending_timers(void)
+{
+        return __this_cpu_read(pending_timer_softirq);
+}
+
 #else
 static inline void raise_timer_softirq(void)
 {
@@ -637,6 +645,11 @@ static inline void raise_hrtimer_softirq(void)
 {
 	raise_softirq_irqoff(HRTIMER_SOFTIRQ);
 }
+
+static inline unsigned int local_pending_timers(void)
+{
+        return local_softirq_pending();
+}
 #endif
 
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
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
 
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 467b94257105e..3d948f001f182 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -431,7 +431,6 @@ enum xhlock_context_t {
 	XHLOCK_CTX_NR,
 };
 
-#define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
 /*
  * To initialize a lockdep_map statically use this macro.
  * Note that _name must not be NULL.
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 0cd02efa3a742..dd76323ea3fd7 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -181,7 +181,7 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 		goto err_free_bitmap;
 
 	work_ctx->irq_count = num_irqs;
-	init_irq_work(&work_ctx->work, irq_sim_handle_irq);
+	work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
 
 	return work_ctx->domain;
 
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
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 55d049c39608f..de306d1406e98 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3294,6 +3294,12 @@ rcu_torture_init(void)
 				WARN_ON_ONCE(!t);
 				sp.sched_priority = 2;
 				sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+#ifdef CONFIG_PREEMPT_RT
+				t = per_cpu(timersd, cpu);
+				WARN_ON_ONCE(!t);
+				sp.sched_priority = 2;
+				sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+#endif
 			}
 		}
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 5b36ebe5e20de..9bf626ebbee65 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -637,13 +637,8 @@ static inline void tick_irq_exit(void)
 #endif
 }
 
-static DEFINE_PER_CPU(struct task_struct *, timersd);
-static DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
-
-static unsigned int local_pending_timers(void)
-{
-        return __this_cpu_read(pending_timer_softirq);
-}
+DEFINE_PER_CPU(struct task_struct *, timersd);
+DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
 
 static void wake_timersd(void)
 {
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d257721c68b8f..8ac337201dd90 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -780,7 +780,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 
 static inline bool local_timer_softirq_pending(void)
 {
-	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
+	return local_pending_timers() & BIT(TIMER_SOFTIRQ);
 }
 
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
diff --git a/localversion-rt b/localversion-rt
index 8fc605d806670..045478966e9f1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt6
+-rt7
