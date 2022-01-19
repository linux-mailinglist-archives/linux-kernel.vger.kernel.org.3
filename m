Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68141493916
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353364AbiASK7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:59:12 -0500
Received: from foss.arm.com ([217.140.110.172]:53438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353857AbiASK7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:59:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3C44101E;
        Wed, 19 Jan 2022 02:59:10 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E038F3F73D;
        Wed, 19 Jan 2022 02:59:05 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, mark.rutland@arm.com, maz@kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, nsaenzju@redhat.com,
        palmer@dabbelt.com, paulmck@kernel.org, paul.walmsley@sifive.com,
        pbonzini@redhat.com, seanjc@google.com, suzuki.poulose@arm.com,
        svens@linux.ibm.com, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wanpengli@tencent.com, will@kernel.org
Subject: [PATCH v2 1/7] entry: add arch_in_rcu_eqs()
Date:   Wed, 19 Jan 2022 10:58:48 +0000
Message-Id: <20220119105854.3160683-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119105854.3160683-1-mark.rutland@arm.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All architectures have an interruptible RCU extended quiescent state
(EQS) as part of their idle sequences, where interrupts can occur
without RCU watching. Entry code must account for this and wake RCU as
necessary; the common entry code deals with this in irqentry_enter() by
treating any interrupt from an idle thread as potentially having
occurred with an EQS and waking RCU for the duration of the interrupt
via rcu_irq_enter() .. rcu_irq_exit().

Some architectures may have other interruptible EQSs which require
similar treatment. For example, on s390 is it necessary to enable
interrupts around guest entry in the middle of a period where core KVM
code has entered an EQS.

So that architectueres can wake RCU in these cases, this patch adds a
new arch_in_rcu_eqs() hook to the common entry code which is checked in
addition to the existing is_idle_thread() check, with RCU woken if
either returns true. A default implementation is provided which always
returns false, which suffices for most architectures.

As no architectures currently implement arch_in_rcu_eqs(), there should
be no functional change as a result of this patch alone. A subsequent
patch will add an s390 implementation to fix a latent bug with missing
RCU wakeups.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/entry-common.h | 16 ++++++++++++++++
 kernel/entry/common.c        |  3 ++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed4..f1b91a13a15a6 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -99,6 +99,22 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
 }
 #endif
 
+/**
+ * arch_in_rcu_eqs - Architecture specific check for RCU extended quiescent
+ * states.
+ *
+ * Returns: true if the CPU is potentially in an RCU EQS, false otherwise.
+ *
+ * Architectures only need to define this if threads other than the idle thread
+ * may have an interruptible EQS. This does not need to handle idle threads. It
+ * is safe to over-estimate at the cost of redundant RCU management work.
+ *
+ * Invoked from irqentry_enter()
+ */
+#ifndef arch_in_rcu_eqs
+static __always_inline bool arch_in_rcu_eqs(void) { return false; }
+#endif
+
 /**
  * enter_from_user_mode - Establish state when coming from user mode
  *
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d5a61d565ad5d..b13d4e0b0b643 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -349,7 +349,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * TINY_RCU does not support EQS, so let the compiler eliminate
 	 * this part when enabled.
 	 */
-	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
+	if (!IS_ENABLED(CONFIG_TINY_RCU) &&
+	    (is_idle_task(current) || arch_in_rcu_eqs())) {
 		/*
 		 * If RCU is not watching then the same careful
 		 * sequence vs. lockdep and tracing is required
-- 
2.30.2

