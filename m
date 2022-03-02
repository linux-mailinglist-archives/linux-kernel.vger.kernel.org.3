Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE284CA998
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiCBPu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbiCBPti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:49:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B968B369F1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:48:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 290AEB82082
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC70EC340F2;
        Wed,  2 Mar 2022 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236127;
        bh=jRx9Fwtkk7KstICJDkCl/JU8UwjeC0Xpe1Dxm4UwtqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jcXsDEgZ+46Jzh2kikfnxwVfl3OTFREPLG1+nRtXhS8Wwhjs5ITyNVB/9+v6ORbp5
         FWeWUb4ztf0xsgPyF5UG3ValcEpyx4SUMeB4DoG5AC9o5c86yyuftmrFxUxAEPI6dj
         FC2WJrBlpPMcdQCQaanLzUrbyO7AmO0ZDPsKLTIqRnAikIvOCWB3rq9cgcyptJKnuO
         AwckzEPx+LPtrCUQ4FqPIHL7EKV8JMQJzD9y7K33JIScNIY008x1zBL0EUJt6v/wPM
         mMgaXV85jMExTJlK9mWsgyWPXwGp2veWtRSGTjvl9EVNdblaEl0fmRrJSz+qZ4kgAC
         bwyUVN6mPyFgg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 08/19] context_tracking: Take NMI eqs entrypoints over RCU
Date:   Wed,  2 Mar 2022 16:47:59 +0100
Message-Id: <20220302154810.42308-9-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302154810.42308-1-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU dynticks counter is going to be merged into the context tracking
subsystem. Prepare with moving the NMI extended quiescent states
entrypoints to context tracking. For now those are dumb redirection to
existing RCU calls.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 Documentation/RCU/Design/Requirements/Requirements.rst |  2 +-
 arch/Kconfig                                           |  2 +-
 arch/arm64/kernel/entry-common.c                       |  8 ++++----
 include/linux/context_tracking_irq.h                   |  4 ++++
 include/linux/hardirq.h                                |  4 ++--
 kernel/context_tracking.c                              | 10 ++++++++++
 kernel/entry/common.c                                  |  4 ++--
 kernel/extable.c                                       |  4 ++--
 kernel/trace/trace.c                                   |  2 +-
 9 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index e3dd5d71c798..256cf260e864 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1847,7 +1847,7 @@ normal interrupts. One way that this can happen is for code that
 directly invokes ct_irq_enter() and ct_irq_exit() to be called
 from an NMI handler. This astonishing fact of life prompted the current
 code structure, which has ct_irq_enter() invoking
-rcu_nmi_enter() and ct_irq_exit() invoking rcu_nmi_exit().
+ct_nmi_enter() and ct_irq_exit() invoking ct_nmi_exit().
 And yes, I also learned of this requirement the hard way.
 
 Loadable Modules
diff --git a/arch/Kconfig b/arch/Kconfig
index 66b2b6d4717b..c22b8ca0eb01 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -785,7 +785,7 @@ config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
 
 	  - Critical entry code isn't preemptible (or better yet:
 	    not interruptible).
-	  - No use of RCU read side critical sections, unless rcu_nmi_enter()
+	  - No use of RCU read side critical sections, unless ct_nmi_enter()
 	    got called.
 	  - No use of instrumentation, unless instrumentation_begin() got
 	    called.
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 43ca8cf4e1dd..6a1ea28731c8 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -158,7 +158,7 @@ static void noinstr arm64_enter_nmi(struct pt_regs *regs)
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	lockdep_hardirq_enter();
-	rcu_nmi_enter();
+	ct_nmi_enter();
 
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
@@ -179,7 +179,7 @@ static void noinstr arm64_exit_nmi(struct pt_regs *regs)
 		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	}
 
-	rcu_nmi_exit();
+	ct_nmi_exit();
 	lockdep_hardirq_exit();
 	if (restore)
 		lockdep_hardirqs_on(CALLER_ADDR0);
@@ -196,7 +196,7 @@ static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
 	regs->lockdep_hardirqs = lockdep_hardirqs_enabled();
 
 	lockdep_hardirqs_off(CALLER_ADDR0);
-	rcu_nmi_enter();
+	ct_nmi_enter();
 
 	trace_hardirqs_off_finish();
 }
@@ -215,7 +215,7 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	}
 
-	rcu_nmi_exit();
+	ct_nmi_exit();
 	if (restore)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
index 60e3ed15a04e..11043bf724b7 100644
--- a/include/linux/context_tracking_irq.h
+++ b/include/linux/context_tracking_irq.h
@@ -7,11 +7,15 @@ void ct_irq_enter(void);
 void ct_irq_exit(void);
 void ct_irq_enter_irqson(void);
 void ct_irq_exit_irqson(void);
+void ct_nmi_enter(void);
+void ct_nmi_exit(void);
 #else
 static inline void ct_irq_enter(void) { }
 static inline void ct_irq_exit(void) { }
 static inline void ct_irq_enter_irqson(void) { }
 static inline void ct_irq_exit_irqson(void) { }
+static inline void ct_nmi_enter(void) { }
+static inline void ct_nmi_exit(void) { }
 #endif
 
 #endif
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 76878b357ffa..345cdbe9c1b7 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -124,7 +124,7 @@ extern void rcu_nmi_exit(void);
 	do {							\
 		__nmi_enter();					\
 		lockdep_hardirq_enter();			\
-		rcu_nmi_enter();				\
+		ct_nmi_enter();				\
 		instrumentation_begin();			\
 		ftrace_nmi_enter();				\
 		instrumentation_end();				\
@@ -143,7 +143,7 @@ extern void rcu_nmi_exit(void);
 		instrumentation_begin();			\
 		ftrace_nmi_exit();				\
 		instrumentation_end();				\
-		rcu_nmi_exit();					\
+		ct_nmi_exit();					\
 		lockdep_hardirq_exit();				\
 		__nmi_exit();					\
 	} while (0)
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index b63ff851472e..1686cd528966 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -267,3 +267,13 @@ void ct_irq_exit_irqson(void)
 {
 	rcu_irq_exit_irqson();
 }
+
+noinstr void ct_nmi_enter(void)
+{
+	rcu_nmi_enter();
+}
+
+noinstr void ct_nmi_exit(void)
+{
+	rcu_nmi_exit();
+}
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index cebc98b8adc6..08230507793f 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -449,7 +449,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	lockdep_hardirq_enter();
-	rcu_nmi_enter();
+	ct_nmi_enter();
 
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
@@ -469,7 +469,7 @@ void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 	}
 	instrumentation_end();
 
-	rcu_nmi_exit();
+	ct_nmi_exit();
 	lockdep_hardirq_exit();
 	if (irq_state.lockdep)
 		lockdep_hardirqs_on(CALLER_ADDR0);
diff --git a/kernel/extable.c b/kernel/extable.c
index b6f330f0fe74..88d4d739c5a1 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -113,7 +113,7 @@ int kernel_text_address(unsigned long addr)
 
 	/* Treat this like an NMI as it can happen anywhere */
 	if (no_rcu)
-		rcu_nmi_enter();
+		ct_nmi_enter();
 
 	if (is_module_text_address(addr))
 		goto out;
@@ -126,7 +126,7 @@ int kernel_text_address(unsigned long addr)
 	ret = 0;
 out:
 	if (no_rcu)
-		rcu_nmi_exit();
+		ct_nmi_exit();
 
 	return ret;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7c500c708180..9434da82af8a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3086,7 +3086,7 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 	}
 
 	/*
-	 * When an NMI triggers, RCU is enabled via rcu_nmi_enter(),
+	 * When an NMI triggers, RCU is enabled via ct_nmi_enter(),
 	 * but if the above rcu_is_watching() failed, then the NMI
 	 * triggered someplace critical, and ct_irq_enter() should
 	 * not be called from NMI.
-- 
2.25.1

