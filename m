Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BAC49391B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353961AbiASK7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:59:43 -0500
Received: from foss.arm.com ([217.140.110.172]:53604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353937AbiASK7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:59:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C8DEED1;
        Wed, 19 Jan 2022 02:59:38 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA2373F73D;
        Wed, 19 Jan 2022 02:59:33 -0800 (PST)
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
Subject: [PATCH v2 5/7] kvm/riscv: rework guest entry logic
Date:   Wed, 19 Jan 2022 10:58:52 +0000
Message-Id: <20220119105854.3160683-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119105854.3160683-1-mark.rutland@arm.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kvm_arch_vcpu_ioctl_run() we enter an RCU extended quiescent state
(EQS) by calling guest_enter_irqoff(), and unmask IRQs prior to exiting
the EQS by calling guest_exit(). As the IRQ entry code will not wake RCU
in this case, we may run the core IRQ code and IRQ handler without RCU
watching, leading to various potential problems.

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
section into a new kvm_riscv_enter_exit_vcpu() helper which is marked
noinstr.

Fixes: 99cdc6c18c2d815e ("RISC-V: Add initial skeletal KVM support")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
---
 arch/riscv/kvm/vcpu.c | 44 ++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index fb84619df0127..5033e8b8541aa 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -675,6 +675,20 @@ static void kvm_riscv_update_hvip(struct kvm_vcpu *vcpu)
 	csr_write(CSR_HVIP, csr->hvip);
 }
 
+/*
+ * Actually run the vCPU, entering an RCU extended quiescent state (EQS) while
+ * the vCPU is running.
+ *
+ * This must be noinstr as instrumentation may make use of RCU, and this is not
+ * safe during the EQS.
+ */
+static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu)
+{
+	guest_state_enter_irqoff();
+	__kvm_riscv_switch_to(&vcpu->arch);
+	guest_state_exit_irqoff();
+}
+
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 {
 	int ret;
@@ -766,9 +780,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			continue;
 		}
 
-		guest_enter_irqoff();
+		guest_timing_enter_irqoff();
 
-		__kvm_riscv_switch_to(&vcpu->arch);
+		kvm_riscv_vcpu_enter_exit(vcpu);
 
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->stat.exits++;
@@ -788,25 +802,21 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		kvm_riscv_vcpu_sync_interrupts(vcpu);
 
 		/*
-		 * We may have taken a host interrupt in VS/VU-mode (i.e.
-		 * while executing the guest). This interrupt is still
-		 * pending, as we haven't serviced it yet!
+		 * We must ensure that any pending interrupts are taken before
+		 * we exit guest timing so that timer ticks are accounted as
+		 * guest time. Transiently unmask interrupts so that any
+		 * pending interrupts are taken.
 		 *
-		 * We're now back in HS-mode with interrupts disabled
-		 * so enabling the interrupts now will have the effect
-		 * of taking the interrupt again, in HS-mode this time.
+		 * There's no barrier which ensures that pending interrupts are
+		 * recognised, so we just hope that the CPU takes any pending
+		 * interrupts between the enable and disable.
 		 */
 		local_irq_enable();
+		local_irq_disable();
 
-		/*
-		 * We do local_irq_enable() before calling guest_exit() so
-		 * that if a timer interrupt hits while running the guest
-		 * we account that tick as being spent in the guest. We
-		 * enable preemption after calling guest_exit() so that if
-		 * we get preempted we make sure ticks after that is not
-		 * counted as guest time.
-		 */
-		guest_exit();
+		guest_timing_exit_irqoff();
+
+		local_irq_enable();
 
 		preempt_enable();
 
-- 
2.30.2

