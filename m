Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BBE493919
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353948AbiASK72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:59:28 -0500
Received: from foss.arm.com ([217.140.110.172]:53524 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353931AbiASK71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:59:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50D92101E;
        Wed, 19 Jan 2022 02:59:27 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF22B3F73D;
        Wed, 19 Jan 2022 02:59:22 -0800 (PST)
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
Subject: [PATCH v2 3/7] kvm/arm64: rework guest entry logic
Date:   Wed, 19 Jan 2022 10:58:50 +0000
Message-Id: <20220119105854.3160683-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119105854.3160683-1-mark.rutland@arm.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kvm_arch_vcpu_ioctl_run() we enter an RCU extended quiescent state
(EQS) by calling guest_enter_irqoff(), and unmasked IRQs prior to
exiting the EQS by calling guest_exit(). As the IRQ entry code will not
wake RCU in this case, we may run the core IRQ code and IRQ handler
without RCU watching, leading to various potential problems.

Additionally, we do not inform lockdep or tracing that interrupts will
be enabled during guest execution, which caan lead to misleading traces
and warnings that interrupts have been enabled for overly-long periods.

This patch fixes these issues by using the new timing and context
entry/exit helpers to ensure that interrupts are handled during guest
vtime but with RCU watching, with a sequence:

	guest_timing_enter_irqoff();

	guest_state_enter_irqoff();
	< run the vcpu >
	guest_state_exit_irqoff();

	< take any pending IRQs >

	guest_timing_exit_irqoff();

Since instrumentation may make use of RCU, we must also ensure that no
instrumented code is run during the EQS. I've split out the critical
section into a new kvm_arm_enter_exit_vcpu() helper which is marked
noinstr.

Fixes: 1b3d546daf85ed2b ("arm/arm64: KVM: Properly account for guest CPU time")
Reported-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/arm.c | 51 ++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e4727dc771bf3..b2222d8eb0b55 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -764,6 +764,24 @@ static bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu, int *ret)
 			xfer_to_guest_mode_work_pending();
 }
 
+/*
+ * Actually run the vCPU, entering an RCU extended quiescent state (EQS) while
+ * the vCPU is running.
+ *
+ * This must be noinstr as instrumentation may make use of RCU, and this is not
+ * safe during the EQS.
+ */
+static int noinstr kvm_arm_vcpu_enter_exit(struct kvm_vcpu *vcpu)
+{
+	int ret;
+
+	guest_state_enter_irqoff();
+	ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
+	guest_state_exit_irqoff();
+
+	return ret;
+}
+
 /**
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
@@ -854,9 +872,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 * Enter the guest
 		 */
 		trace_kvm_entry(*vcpu_pc(vcpu));
-		guest_enter_irqoff();
+		guest_timing_enter_irqoff();
 
-		ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
+		ret = kvm_arm_vcpu_enter_exit(vcpu);
 
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->stat.exits++;
@@ -891,26 +909,23 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		kvm_arch_vcpu_ctxsync_fp(vcpu);
 
 		/*
-		 * We may have taken a host interrupt in HYP mode (ie
-		 * while executing the guest). This interrupt is still
-		 * pending, as we haven't serviced it yet!
+		 * We must ensure that any pending interrupts are taken before
+		 * we exit guest timing so that timer ticks are accounted as
+		 * guest time. Transiently unmask interrupts so that any
+		 * pending interrupts are taken.
 		 *
-		 * We're now back in SVC mode, with interrupts
-		 * disabled.  Enabling the interrupts now will have
-		 * the effect of taking the interrupt again, in SVC
-		 * mode this time.
+		 * Per ARM DDI 0487G.b section D1.13.4, an ISB (or other
+		 * context synchronization event) is necessary to ensure that
+		 * pending interrupts are taken.
 		 */
 		local_irq_enable();
+		isb();
+		local_irq_disable();
+
+		guest_timing_exit_irqoff();
+
+		local_irq_enable();
 
-		/*
-		 * We do local_irq_enable() before calling guest_exit() so
-		 * that if a timer interrupt hits while running the guest we
-		 * account that tick as being spent in the guest.  We enable
-		 * preemption after calling guest_exit() so that if we get
-		 * preempted we make sure ticks after that is not counted as
-		 * guest time.
-		 */
-		guest_exit();
 		trace_kvm_exit(ret, kvm_vcpu_trap_get_class(vcpu), *vcpu_pc(vcpu));
 
 		/* Exit types that need handling before we can be preempted */
-- 
2.30.2

