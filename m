Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E660B49391C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353996AbiASK7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:59:50 -0500
Received: from foss.arm.com ([217.140.110.172]:53646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353942AbiASK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:59:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE99F1063;
        Wed, 19 Jan 2022 02:59:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 22EF33F73D;
        Wed, 19 Jan 2022 02:59:39 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
        chenhuacai@kernel.org, dave.hansen@linux.intel.com,
        frankja@linux.ibm.com, frederic@kernel.org, gor@linux.ibm.com,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, luto@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        nsaenzju@redhat.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, pbonzini@redhat.com,
        peterz@infradead.org, seanjc@google.com, suzuki.poulose@arm.com,
        svens@linux.ibm.com, tglx@linutronix.de, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wanpengli@tencent.com, will@kernel.org
Subject: [PATCH v2 6/7] kvm/s390: rework guest entry logic
Date:   Wed, 19 Jan 2022 10:58:53 +0000
Message-Id: <20220119105854.3160683-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119105854.3160683-1-mark.rutland@arm.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __vcpu_run() and do_vsie_run(), we enter an RCU extended quiescent
state (EQS) by calling guest_enter_irqoff(), which lasts until
__vcpu_run() calls guest_exit_irqoff(). However, during the two we
enable interrupts and may handle interrupts during the EQS. As the IRQ
entry code will not wake RCU in this case, we may run the core IRQ code
and IRQ handler without RCU watching, leading to various potential
problems.

It is necessary to unmask (host) interrupts around entering the guest,
as entering the guest via SIE will not automatically unmask these. When
a host interrupts is taken from a guest, it is taken via its regular
host IRQ handler rather than being treated as a direct exit from SIE.
Due to this, we cannot simply mask interrupts around guest entry, and
must handle interrupts during this window, waking RCU as required.

Additionally, between guest_exit_irqoff() and guest_exit_irqoff(), we
use local_irq_enable() and local_irq_disable() to unmask interrupts,
violating the ordering requirements for RCU/lockdep/tracing around
entry/exit sequences. Further, since this occurs in an instrumentable
function, it's possible that instrumented code runs during this window,
with potential usage of RCU, etc.

To fix the RCU wakeup problem, an s390 implementation of
arch_in_rcu_eqs() is added which checks for PF_VCPU in current->flags.
PF_VCPU is set/cleared by guest_timing_{enter,exit}_irqoff(), which
surround the actual guest entry.

To fix the remaining issues, the lower-level guest entry logic is moved
into a shared noinstr helper function using the
guest_state_{enter,exit}_irqoff() helpers. These perform all the
lockdep/RCU/tracing manipulation necessary, but as sie64a() does not
enable/disable interrupts, we must do this explicitly with the
non-instrumented arch_local_irq_{enable,disable}() helpers:

	guest_state_enter_irqoff()

	arch_local_irq_enable();
	sie64a(...);
	arch_local_irq_disable();

	guest_state_exit_irqoff();

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/include/asm/entry-common.h | 10 ++++++
 arch/s390/include/asm/kvm_host.h     |  3 ++
 arch/s390/kvm/kvm-s390.c             | 49 +++++++++++++++++++++-------
 arch/s390/kvm/vsie.c                 | 17 ++++------
 4 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index 17aead80aadba..e69a2ab28b847 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -57,6 +57,16 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
+static __always_inline bool arch_in_rcu_eqs(void)
+{
+	if (IS_ENABLED(CONFIG_KVM))
+		return current->flags & PF_VCPU;
+
+	return false;
+}
+
+#define arch_in_rcu_eqs arch_in_rcu_eqs
+
 static inline bool on_thread_stack(void)
 {
 	return !(((unsigned long)(current->stack) ^ current_stack_pointer()) & ~(THREAD_SIZE - 1));
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a604d51acfc83..bf7efd990039b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -995,6 +995,9 @@ void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
 
+extern int kvm_s390_enter_exit_sie(struct kvm_s390_sie_block *scb,
+				   u64 *gprs);
+
 extern int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc);
 extern int kvm_s390_gisc_unregister(struct kvm *kvm, u32 gisc);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 14a18ba5ff2c8..d13401bf6a5a2 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4169,6 +4169,30 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	return vcpu_post_run_fault_in_sie(vcpu);
 }
 
+int noinstr kvm_s390_enter_exit_sie(struct kvm_s390_sie_block *scb,
+				    u64 *gprs)
+{
+	int ret;
+
+	guest_state_enter_irqoff();
+
+	/*
+	 * The guest_state_{enter,exit}_irqoff() functions inform lockdep and
+	 * tracing that entry to the guest will enable host IRQs, and exit from
+	 * the guest will disable host IRQs.
+	 *
+	 * We must not use lockdep/tracing/RCU in this critical section, so we
+	 * use the low-level arch_local_irq_*() helpers to enable/disable IRQs.
+	 */
+	arch_local_irq_enable();
+	ret = sie64a(scb, gprs);
+	arch_local_irq_disable();
+
+	guest_state_exit_irqoff();
+
+	return ret;
+}
+
 #define PSW_INT_MASK (PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_MCHECK)
 static int __vcpu_run(struct kvm_vcpu *vcpu)
 {
@@ -4189,12 +4213,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 		/*
 		 * As PF_VCPU will be used in fault handler, between
-		 * guest_enter and guest_exit should be no uaccess.
+		 * guest_timing_enter_irqoff and guest_timing_exit_irqoff
+		 * should be no uaccess.
 		 */
-		local_irq_disable();
-		guest_enter_irqoff();
-		__disable_cpu_timer_accounting(vcpu);
-		local_irq_enable();
 		if (kvm_s390_pv_cpu_is_protected(vcpu)) {
 			memcpy(sie_page->pv_grregs,
 			       vcpu->run->s.regs.gprs,
@@ -4202,8 +4223,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		}
 		if (test_cpu_flag(CIF_FPU))
 			load_fpu_regs();
-		exit_reason = sie64a(vcpu->arch.sie_block,
-				     vcpu->run->s.regs.gprs);
+
+		local_irq_disable();
+		guest_timing_enter_irqoff();
+		__disable_cpu_timer_accounting(vcpu);
+
+		exit_reason = kvm_s390_enter_exit_sie(vcpu->arch.sie_block,
+						      vcpu->run->s.regs.gprs);
+
+		__enable_cpu_timer_accounting(vcpu);
+		guest_timing_exit_irqoff();
+		local_irq_enable();
+
 		if (kvm_s390_pv_cpu_is_protected(vcpu)) {
 			memcpy(vcpu->run->s.regs.gprs,
 			       sie_page->pv_grregs,
@@ -4219,10 +4250,6 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 				vcpu->arch.sie_block->gpsw.mask &= ~PSW_INT_MASK;
 			}
 		}
-		local_irq_disable();
-		__enable_cpu_timer_accounting(vcpu);
-		guest_exit_irqoff();
-		local_irq_enable();
 		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 		rc = vcpu_post_run(vcpu, exit_reason);
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index acda4b6fc8518..e9b0b2d04e1e3 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1106,10 +1106,6 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	    vcpu->arch.sie_block->fpf & FPF_BPBC)
 		set_thread_flag(TIF_ISOLATE_BP_GUEST);
 
-	local_irq_disable();
-	guest_enter_irqoff();
-	local_irq_enable();
-
 	/*
 	 * Simulate a SIE entry of the VCPU (see sie64a), so VCPU blocking
 	 * and VCPU requests also hinder the vSIE from running and lead
@@ -1120,15 +1116,16 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	barrier();
 	if (test_cpu_flag(CIF_FPU))
 		load_fpu_regs();
-	if (!kvm_s390_vcpu_sie_inhibited(vcpu))
-		rc = sie64a(scb_s, vcpu->run->s.regs.gprs);
+	if (!kvm_s390_vcpu_sie_inhibited(vcpu)) {
+		local_irq_disable();
+		guest_timing_enter_irqoff();
+		rc = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs);
+		guest_timing_exit_irqoff();
+		local_irq_enable();
+	}
 	barrier();
 	vcpu->arch.sie_block->prog0c &= ~PROG_IN_SIE;
 
-	local_irq_disable();
-	guest_exit_irqoff();
-	local_irq_enable();
-
 	/* restore guest state for bp isolation override */
 	if (!guest_bp_isolation)
 		clear_thread_flag(TIF_ISOLATE_BP_GUEST);
-- 
2.30.2

