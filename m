Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ADA4F3871
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376884AbiDELYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbiDEIsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F942AC41;
        Tue,  5 Apr 2022 01:36:48 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGyejd2uC+AR80/UDTUZiXsBo6lzsrAZKwPdJdf/Th0=;
        b=Q5wIv8YN9vaDUpyXI0cP1X+CFfmJkWmd62V5fi9CsgS5wvUoBkorAALIdgidRxaOnM/SAz
        TAi7Nyg5vNouSxgb3ziC28kGVIqJfmP97APWgJg9a8Wj8Jzy8MYFEVnHK2U4o9q+oaOkvs
        eCloy7OcnTZwb6ff0FWvexgo9AF2ks+gTawZNJI4dcvSbKpDT7KnWK5U2uG+V+mO7cBIPj
        rRSZufDnKx0x/tNLwuoof66QrDm9DvDI/NSQRSVkYly+uHm35ddhLTjmMZ7Lp2xoAZMnVQ
        DYnB/q7RAudQEZTswyxK0P+AhuJX3dYxFXmHOQDOsmYgxECDbjPohnJITRCHgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147784;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGyejd2uC+AR80/UDTUZiXsBo6lzsrAZKwPdJdf/Th0=;
        b=o4hqkfnQE94gUWKizN6wDBrnTLto9uMhujBtBuq4iTpFt/9bYj+/XzjGwvUFTaEoWvjI9X
        iTG2z85TRinHqzCA==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Fix -Wunused-parameter for _THIS_IP_
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220314221909.2027027-1-ndesaulniers@google.com>
References: <20220314221909.2027027-1-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <164914778309.389.3372614543425421602.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8b023accc8df70e72f7704d29fead7ca914d6837
Gitweb:        https://git.kernel.org/tip/8b023accc8df70e72f7704d29fead7ca914d6837
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Mon, 14 Mar 2022 15:19:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:34 +02:00

lockdep: Fix -Wunused-parameter for _THIS_IP_

While looking into a bug related to the compiler's handling of addresses
of labels, I noticed some uses of _THIS_IP_ seemed unused in lockdep.
Drive by cleanup.

-Wunused-parameter:
kernel/locking/lockdep.c:1383:22: warning: unused parameter 'ip'
kernel/locking/lockdep.c:4246:48: warning: unused parameter 'ip'
kernel/locking/lockdep.c:4844:19: warning: unused parameter 'ip'

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20220314221909.2027027-1-ndesaulniers@google.com
---
 arch/arm64/kernel/entry-common.c |  8 ++++----
 include/linux/irqflags.h         |  4 ++--
 include/linux/kvm_host.h         |  2 +-
 kernel/entry/common.c            |  6 +++---
 kernel/locking/lockdep.c         | 22 ++++++++--------------
 kernel/sched/idle.c              |  2 +-
 kernel/trace/trace_preemptirq.c  |  4 ++--
 7 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 878c65a..e04602e 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -75,7 +75,7 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
 	if (interrupts_enabled(regs)) {
 		if (regs->exit_rcu) {
 			trace_hardirqs_on_prepare();
-			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+			lockdep_hardirqs_on_prepare();
 			rcu_irq_exit();
 			lockdep_hardirqs_on(CALLER_ADDR0);
 			return;
@@ -121,7 +121,7 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 static __always_inline void __exit_to_user_mode(void)
 {
 	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	lockdep_hardirqs_on_prepare();
 	user_enter_irqoff();
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
@@ -179,7 +179,7 @@ static void noinstr arm64_exit_nmi(struct pt_regs *regs)
 	ftrace_nmi_exit();
 	if (restore) {
 		trace_hardirqs_on_prepare();
-		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+		lockdep_hardirqs_on_prepare();
 	}
 
 	rcu_nmi_exit();
@@ -215,7 +215,7 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 
 	if (restore) {
 		trace_hardirqs_on_prepare();
-		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+		lockdep_hardirqs_on_prepare();
 	}
 
 	rcu_nmi_exit();
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 4b14093..5ec0fa7 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -20,13 +20,13 @@
 #ifdef CONFIG_PROVE_LOCKING
   extern void lockdep_softirqs_on(unsigned long ip);
   extern void lockdep_softirqs_off(unsigned long ip);
-  extern void lockdep_hardirqs_on_prepare(unsigned long ip);
+  extern void lockdep_hardirqs_on_prepare(void);
   extern void lockdep_hardirqs_on(unsigned long ip);
   extern void lockdep_hardirqs_off(unsigned long ip);
 #else
   static inline void lockdep_softirqs_on(unsigned long ip) { }
   static inline void lockdep_softirqs_off(unsigned long ip) { }
-  static inline void lockdep_hardirqs_on_prepare(unsigned long ip) { }
+  static inline void lockdep_hardirqs_on_prepare(void) { }
   static inline void lockdep_hardirqs_on(unsigned long ip) { }
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
 #endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3f9b22c..e1b2413 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -450,7 +450,7 @@ static __always_inline void guest_state_enter_irqoff(void)
 {
 	instrumentation_begin();
 	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
 
 	guest_context_enter_irqoff();
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e57a224..2eef7b2 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -126,7 +126,7 @@ static __always_inline void __exit_to_user_mode(void)
 {
 	instrumentation_begin();
 	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	lockdep_hardirqs_on_prepare();
 	instrumentation_end();
 
 	user_enter_irqoff();
@@ -416,7 +416,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 			instrumentation_begin();
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
-			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+			lockdep_hardirqs_on_prepare();
 			instrumentation_end();
 			rcu_irq_exit();
 			lockdep_hardirqs_on(CALLER_ADDR0);
@@ -465,7 +465,7 @@ void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 	ftrace_nmi_exit();
 	if (irq_state.lockdep) {
 		trace_hardirqs_on_prepare();
-		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+		lockdep_hardirqs_on_prepare();
 	}
 	instrumentation_end();
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index c06cab6..3cbd492 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1380,7 +1380,7 @@ static struct lock_list *alloc_list_entry(void)
  */
 static int add_lock_to_list(struct lock_class *this,
 			    struct lock_class *links_to, struct list_head *head,
-			    unsigned long ip, u16 distance, u8 dep,
+			    u16 distance, u8 dep,
 			    const struct lock_trace *trace)
 {
 	struct lock_list *entry;
@@ -3133,19 +3133,15 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * to the previous lock's dependency list:
 	 */
 	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
-			       &hlock_class(prev)->locks_after,
-			       next->acquire_ip, distance,
-			       calc_dep(prev, next),
-			       *trace);
+			       &hlock_class(prev)->locks_after, distance,
+			       calc_dep(prev, next), *trace);
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance,
-			       calc_depb(prev, next),
-			       *trace);
+			       &hlock_class(next)->locks_before, distance,
+			       calc_depb(prev, next), *trace);
 	if (!ret)
 		return 0;
 
@@ -4236,14 +4232,13 @@ static void __trace_hardirqs_on_caller(void)
 
 /**
  * lockdep_hardirqs_on_prepare - Prepare for enabling interrupts
- * @ip:		Caller address
  *
  * Invoked before a possible transition to RCU idle from exit to user or
  * guest mode. This ensures that all RCU operations are done before RCU
  * stops watching. After the RCU transition lockdep_hardirqs_on() has to be
  * invoked to set the final state.
  */
-void lockdep_hardirqs_on_prepare(unsigned long ip)
+void lockdep_hardirqs_on_prepare(void)
 {
 	if (unlikely(!debug_locks))
 		return;
@@ -4840,8 +4835,7 @@ EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
 
 static void
 print_lock_nested_lock_not_held(struct task_struct *curr,
-				struct held_lock *hlock,
-				unsigned long ip)
+				struct held_lock *hlock)
 {
 	if (!debug_locks_off())
 		return;
@@ -5017,7 +5011,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
 
 	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
-		print_lock_nested_lock_not_held(curr, hlock, ip);
+		print_lock_nested_lock_not_held(curr, hlock);
 		return 0;
 	}
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8f8b502..3984dd2 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -102,7 +102,7 @@ void __cpuidle default_idle_call(void)
 		 * last -- this is very similar to the entry code.
 		 */
 		trace_hardirqs_on_prepare();
-		lockdep_hardirqs_on_prepare(_THIS_IP_);
+		lockdep_hardirqs_on_prepare();
 		rcu_idle_enter();
 		lockdep_hardirqs_on(_THIS_IP_);
 
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index f493804..95b58bd 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -46,7 +46,7 @@ void trace_hardirqs_on(void)
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
 
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	lockdep_hardirqs_on_prepare();
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on);
@@ -94,7 +94,7 @@ __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
 
-	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	lockdep_hardirqs_on_prepare();
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_caller);
