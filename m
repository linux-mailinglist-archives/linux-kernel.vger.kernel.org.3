Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B745C4A5D77
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiBANaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:30:11 -0500
Received: from foss.arm.com ([217.140.110.172]:40340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238790AbiBANaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:30:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E89D21476;
        Tue,  1 Feb 2022 05:30:04 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D41B93F73B;
        Tue,  1 Feb 2022 05:30:00 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        benh@kernel.crashing.org, borntraeger@linux.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frederic@kernel.org,
        hca@linux.ibm.com, james.morse@arm.com, jmattson@google.com,
        joro@8bytes.org, mark.rutland@arm.com, maz@kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, nsaenzju@redhat.com,
        palmer@dabbelt.com, paulmck@kernel.org, paulus@samba.org,
        paul.walmsley@sifive.com, pbonzini@redhat.com, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
Subject: [PATCH v3 5/5] kvm/mips: rework guest entry logic
Date:   Tue,  1 Feb 2022 13:29:26 +0000
Message-Id: <20220201132926.3301912-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201132926.3301912-1-mark.rutland@arm.com>
References: <20220201132926.3301912-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kvm_arch_vcpu_ioctl_run() we use guest_enter_irqoff() and
guest_exit_irqoff() directly, with interrupts masked between these. As
we don't handle any timer ticks during this window, we will not account
time spent within the guest as guest time, which is unfortunate.

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

In addition, as guest exits during the "run the vcpu" step are handled
by kvm_mips_handle_exit(), a wrapper function is added which ensures
that such exists are handled with a sequence:

	guest_state_exit_irqoff();
	< handle the exit >
	guest_state_enter_irqoff();

This means that exits which stop the vCPU running will have a redundant
guest_state_enter_irqoff() .. guest_state_exit_irqoff() sequence, which
can be addressed with future rework.

Since instrumentation may make use of RCU, we must also ensure that no
instrumented code is run during the EQS. I've split out the critical
section into a new kvm_mips_enter_exit_vcpu() helper which is marked
noinstr.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/kvm/mips.c | 50 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index e59cb6246f763..a25e0b73ee704 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -414,6 +414,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	return -ENOIOCTLCMD;
 }
 
+/*
+ * Actually run the vCPU, entering an RCU extended quiescent state (EQS) while
+ * the vCPU is running.
+ *
+ * This must be noinstr as instrumentation may make use of RCU, and this is not
+ * safe during the EQS.
+ */
+static int noinstr kvm_mips_vcpu_enter_exit(struct kvm_vcpu *vcpu)
+{
+	int ret;
+
+	guest_state_enter_irqoff();
+	ret = kvm_mips_callbacks->vcpu_run(vcpu);
+	guest_state_exit_irqoff();
+
+	return ret;
+}
+
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 {
 	int r = -EINTR;
@@ -434,7 +452,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	lose_fpu(1);
 
 	local_irq_disable();
-	guest_enter_irqoff();
+	guest_timing_enter_irqoff();
 	trace_kvm_enter(vcpu);
 
 	/*
@@ -445,10 +463,23 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	 */
 	smp_store_mb(vcpu->mode, IN_GUEST_MODE);
 
-	r = kvm_mips_callbacks->vcpu_run(vcpu);
+	r = kvm_mips_vcpu_enter_exit(vcpu);
+
+	/*
+	 * We must ensure that any pending interrupts are taken before
+	 * we exit guest timing so that timer ticks are accounted as
+	 * guest time. Transiently unmask interrupts so that any
+	 * pending interrupts are taken.
+	 *
+	 * TODO: is there a barrier which ensures that pending interrupts are
+	 * recognised? Currently this just hopes that the CPU takes any pending
+	 * interrupts between the enable and disable.
+	 */
+	local_irq_enable();
+	local_irq_disable();
 
 	trace_kvm_out(vcpu);
-	guest_exit_irqoff();
+	guest_timing_exit_irqoff();
 	local_irq_enable();
 
 out:
@@ -1168,7 +1199,7 @@ static void kvm_mips_set_c0_status(void)
 /*
  * Return value is in the form (errcode<<2 | RESUME_FLAG_HOST | RESUME_FLAG_NV)
  */
-int kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
+static int __kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 cause = vcpu->arch.host_cp0_cause;
@@ -1357,6 +1388,17 @@ int kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+int noinstr kvm_mips_handle_exit(struct kvm_vcpu *vcpu)
+{
+	int ret;
+
+	guest_state_exit_irqoff();
+	ret = __kvm_mips_handle_exit(vcpu);
+	guest_state_enter_irqoff();
+
+	return ret;
+}
+
 /* Enable FPU for guest and restore context */
 void kvm_own_fpu(struct kvm_vcpu *vcpu)
 {
-- 
2.30.2

