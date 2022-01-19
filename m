Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4949391A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353941AbiASK7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:59:41 -0500
Received: from foss.arm.com ([217.140.110.172]:53570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353971AbiASK7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:59:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09920113E;
        Wed, 19 Jan 2022 02:59:33 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E89D3F73D;
        Wed, 19 Jan 2022 02:59:28 -0800 (PST)
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
Subject: [PATCH v2 4/7] kvm/mips: rework guest entry logic
Date:   Wed, 19 Jan 2022 10:58:51 +0000
Message-Id: <20220119105854.3160683-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220119105854.3160683-1-mark.rutland@arm.com>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
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
 arch/mips/kvm/mips.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index aa20d074d3883..1a961c2434fee 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -438,6 +438,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
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
@@ -458,7 +476,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	lose_fpu(1);
 
 	local_irq_disable();
-	guest_enter_irqoff();
+	guest_timing_enter_irqoff();
 	trace_kvm_enter(vcpu);
 
 	/*
@@ -469,10 +487,23 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
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
-- 
2.30.2

