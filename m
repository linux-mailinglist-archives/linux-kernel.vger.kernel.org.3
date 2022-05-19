Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87E352DF70
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbiESVlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245163AbiESVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:41:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0361447ADC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=uJmPFNr5Fp4mKF9rK6zqxxWonCmQ8KmmZmAyYt1PvWA=; b=K3LmTo2dbOJmxFmxEz54YIWdhu
        RnFLBHAejqDMjZW2q/K+jFOFBYU1B+zQ7jZPVgXUYLcnHbHjXPBj3CWsBCrNPT+/Qmm4LXhc1SoC6
        JAwXzu4bNANTMPVpryJ+Bbd49wfrQ1VzAvQdzvxTFuJfzZ0fvctntuf9EV0S5vQksZsqpsPuxlwGc
        nHWjCgosdBM3sb7vUXyf5mDyh3RVGTGTHpmZzapNrkAgf8tcakdcFy4ueTLcAQJk77BGg7TW72XwB
        vjf94jJAaa0u4rQrXLhmtbjYoUEUa2FZIMcZlqEBhlBVqx0OxLbXoeIEG9oeBZhjsXBTJFdt7PmQA
        t2ab9HPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrntN-0028dj-BW; Thu, 19 May 2022 21:41:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28B3D300F06;
        Thu, 19 May 2022 23:41:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0EB2E2021AF6B; Thu, 19 May 2022 23:41:07 +0200 (CEST)
Message-ID: <20220519213421.808983977@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 19 May 2022 23:27:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org
Subject: [RFC][PATCH 4/9] idle: Fix rcu_idle_*() usage
References: <20220519212750.656413111@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole disable-RCU, enable-IRQS dance is very intricate since
changing IRQ state is traced, which depends on RCU.

Add two helpers for the cpuidle case that mirror the entry code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/mach-imx/cpuidle-imx6q.c |    5 ++--
 drivers/acpi/processor_idle.c     |   18 +++++++++------
 drivers/cpuidle/cpuidle.c         |   11 +++++----
 include/linux/sched/idle.h        |   29 ++++++++++++++++++++++++
 kernel/sched/idle.c               |   45 ++++++++++----------------------------
 kernel/time/tick-broadcast.c      |    2 -
 6 files changed, 62 insertions(+), 48 deletions(-)

--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -5,6 +5,7 @@
 
 #include <linux/cpuidle.h>
 #include <linux/module.h>
+#include <linux/sched/idle.h>
 #include <asm/cpuidle.h>
 
 #include <soc/imx/cpuidle.h>
@@ -24,9 +25,9 @@ static int imx6q_enter_wait(struct cpuid
 		imx6_set_lpm(WAIT_UNCLOCKED);
 	raw_spin_unlock(&cpuidle_lock);
 
-	rcu_idle_enter();
+	cpuidle_rcu_enter();
 	cpu_do_idle();
-	rcu_idle_exit();
+	cpuidle_rcu_exit();
 
 	raw_spin_lock(&cpuidle_lock);
 	if (num_idle_cpus-- == num_online_cpus())
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -607,7 +607,7 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
  * @cx: Target state context
  * @index: index of target state
  */
-static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
+static noinstr int acpi_idle_enter_bm(struct cpuidle_driver *drv,
 			       struct acpi_processor *pr,
 			       struct acpi_processor_cx *cx,
 			       int index)
@@ -626,6 +626,8 @@ static int acpi_idle_enter_bm(struct cpu
 	 */
 	bool dis_bm = pr->flags.bm_control;
 
+	instrumentation_begin();
+
 	/* If we can skip BM, demote to a safe state. */
 	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
 		dis_bm = false;
@@ -647,11 +649,11 @@ static int acpi_idle_enter_bm(struct cpu
 		raw_spin_unlock(&c3_lock);
 	}
 
-	rcu_idle_enter();
+	cpuidle_rcu_enter();
 
 	acpi_idle_do_entry(cx);
 
-	rcu_idle_exit();
+	cpuidle_rcu_exit();
 
 	/* Re-enable bus master arbitration */
 	if (dis_bm) {
@@ -661,11 +663,13 @@ static int acpi_idle_enter_bm(struct cpu
 		raw_spin_unlock(&c3_lock);
 	}
 
+	instrumentation_end();
+
 	return index;
 }
 
-static int acpi_idle_enter(struct cpuidle_device *dev,
-			   struct cpuidle_driver *drv, int index)
+static noinstr int acpi_idle_enter(struct cpuidle_device *dev,
+				   struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
 	struct acpi_processor *pr;
@@ -693,8 +697,8 @@ static int acpi_idle_enter(struct cpuidl
 	return index;
 }
 
-static int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
-				  struct cpuidle_driver *drv, int index)
+static noinstr int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
+					  struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
 
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/idle.h>
 #include <linux/notifier.h>
 #include <linux/pm_qos.h>
 #include <linux/cpu.h>
@@ -150,12 +151,12 @@ static void enter_s2idle_proper(struct c
 	 */
 	stop_critical_timings();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
-		rcu_idle_enter();
+		cpuidle_rcu_enter();
 	target_state->enter_s2idle(dev, drv, index);
 	if (WARN_ON_ONCE(!irqs_disabled()))
-		local_irq_disable();
+		raw_local_irq_disable();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
-		rcu_idle_exit();
+		cpuidle_rcu_enter();
 	tick_unfreeze();
 	start_critical_timings();
 
@@ -233,14 +234,14 @@ int cpuidle_enter_state(struct cpuidle_d
 
 	stop_critical_timings();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
-		rcu_idle_enter();
+		cpuidle_rcu_enter();
 
 	entered_state = target_state->enter(dev, drv, index);
 	if (WARN_ON_ONCE(!irqs_disabled()))
 		raw_local_irq_disable();
 
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
-		rcu_idle_exit();
+		cpuidle_rcu_exit();
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -88,4 +88,33 @@ static inline void current_clr_polling(v
 	preempt_fold_need_resched();
 }
 
+static __always_inline void cpuidle_rcu_enter(void)
+{
+	lockdep_assert_irqs_disabled();
+	/*
+	 * Idle is allowed to (temporary) enable IRQs. It
+	 * will return with IRQs disabled.
+	 *
+	 * Trace IRQs enable here, then switch off RCU, and have
+	 * arch_cpu_idle() use raw_local_irq_enable(). Note that
+	 * rcu_idle_enter() relies on lockdep IRQ state, so switch that
+	 * last -- this is very similar to the entry code.
+	 */
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare();
+	instrumentation_end();
+	rcu_idle_enter();
+	lockdep_hardirqs_on(_THIS_IP_);
+}
+
+static __always_inline void cpuidle_rcu_exit(void)
+{
+	/*
+	 * Carefully undo the above.
+	 */
+	lockdep_hardirqs_off(_THIS_IP_);
+	rcu_idle_exit();
+	instrumentation_begin();
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -51,18 +51,22 @@ __setup("hlt", cpu_idle_nopoll_setup);
 
 static noinline int __cpuidle cpu_idle_poll(void)
 {
+	instrumentation_begin();
 	trace_cpu_idle(0, smp_processor_id());
 	stop_critical_timings();
-	rcu_idle_enter();
-	local_irq_enable();
+	cpuidle_rcu_enter();
 
+	raw_local_irq_enable();
 	while (!tif_need_resched() &&
 	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
+	raw_local_irq_disable();
 
-	rcu_idle_exit();
+	cpuidle_rcu_exit();
 	start_critical_timings();
 	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+	local_irq_enable();
+	instrumentation_end();
 
 	return 1;
 }
@@ -85,44 +87,21 @@ void __weak arch_cpu_idle(void)
  */
 void __cpuidle default_idle_call(void)
 {
-	if (current_clr_polling_and_test()) {
-		local_irq_enable();
-	} else {
-
+	instrumentation_begin();
+	if (!current_clr_polling_and_test()) {
 		trace_cpu_idle(1, smp_processor_id());
 		stop_critical_timings();
 
-		/*
-		 * arch_cpu_idle() is supposed to enable IRQs, however
-		 * we can't do that because of RCU and tracing.
-		 *
-		 * Trace IRQs enable here, then switch off RCU, and have
-		 * arch_cpu_idle() use raw_local_irq_enable(). Note that
-		 * rcu_idle_enter() relies on lockdep IRQ state, so switch that
-		 * last -- this is very similar to the entry code.
-		 */
-		trace_hardirqs_on_prepare();
-		lockdep_hardirqs_on_prepare();
-		rcu_idle_enter();
-		lockdep_hardirqs_on(_THIS_IP_);
-
+		cpuidle_rcu_enter();
 		arch_cpu_idle();
-
-		/*
-		 * OK, so IRQs are enabled here, but RCU needs them disabled to
-		 * turn itself back on.. funny thing is that disabling IRQs
-		 * will cause tracing, which needs RCU. Jump through hoops to
-		 * make it 'work'.
-		 */
 		raw_local_irq_disable();
-		lockdep_hardirqs_off(_THIS_IP_);
-		rcu_idle_exit();
-		lockdep_hardirqs_on(_THIS_IP_);
-		raw_local_irq_enable();
+		cpuidle_rcu_exit();
 
 		start_critical_timings();
 		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	}
+	local_irq_enable();
+	instrumentation_end();
 }
 
 static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -622,7 +622,7 @@ struct cpumask *tick_get_broadcast_onesh
  * to avoid a deep idle transition as we are about to get the
  * broadcast IPI right away.
  */
-int tick_check_broadcast_expired(void)
+int noinstr tick_check_broadcast_expired(void)
 {
 	return cpumask_test_cpu(smp_processor_id(), tick_broadcast_force_mask);
 }


