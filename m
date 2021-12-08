Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5068F46CA69
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243352AbhLHB6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbhLHB61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:58:27 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F648C0617A2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:54:54 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e7-20020aa798c7000000b004a254db7946so674479pfm.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/JPOrJowLBvW0HsPnMz4HEwerSMcBxYLug1/SqIZeH8=;
        b=tTUCEbCBnzqFAkTNAlO4XMrl0yZzwzWAuImHo3xXo2qnH2lfxz+u2ecQDGFNdZMWx3
         Xe6zlUlLlG+dCFaXefBJTKkFt4Ycca5wbRvyXo8aSjeTJhW7wxHf7A/C2bwUNgIEDLVD
         J4S9QMajtL+xCMVdtIRbyasJc3iQiitidbBExylfSk9+RMag8Q3Q+TNUXT6bt44HOOV8
         wIYyt5esiPl+G4OouH10Ff/Eihmdn2RVFu3lozkcjnRJHegKEyR4BZ9Zh23qxczHAX7U
         wZrEzby05H7z9NqngasRkDQ30MtoaZ9FCE+RbMCfbPtNiMOkS+HTV5ioQRNfvss1GeBU
         24Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/JPOrJowLBvW0HsPnMz4HEwerSMcBxYLug1/SqIZeH8=;
        b=homOIlyPYWjv2WGVtrN5RpzP57o12ZujWSO+yLhEB6S1BRCyvrNXLpizzEO4WSDGQO
         KehMN55tyzUon6Xkxuj8OdJK4AY6mY5XJauUZ0HNojUeAwRdjY15Aw6GDNzAN4gLWgE6
         nysMwrXvWsJHI6OJCHfb7c9WQ0jG6Ri4Qf/F1E5uZkZHGLJbnqfsO3oNumUDvtzIy5ts
         gZbJBIHjSy7n6iosLwkSxcvbb6WuHSTj/qG2lAs7s5DzxyQOwkxA3LfLTQy9/IbN8W98
         a2d1PCU7it0azbqP0MCHx7u6kqvi38FdSkFEz0Xb/pSHFQUMCsCsHXjAwTVkFFC17NsQ
         4oNw==
X-Gm-Message-State: AOAM531d+K0oT2nfEGQmuEpyBVwZRBB7VRc+YMszdvPu3DIMNqjplUU+
        6HRtCk9C2QsWy3bi0oBkj1y7zdk7tDU=
X-Google-Smtp-Source: ABdhPJyb2q0KKnFXhFmYH0/tt8g8fGrqjFBqE2JJkKX6uI0GUMeEc/p84qYOqUozYWeVDnQm/7ats/YwR/U=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:9143:0:b0:4ac:bc9a:1074 with SMTP id
 3-20020aa79143000000b004acbc9a1074mr2838173pfi.38.1638928494084; Tue, 07 Dec
 2021 17:54:54 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Dec 2021 01:52:14 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-5-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 04/26] KVM: VMX: Handle PI wakeup shenanigans during vcpu_put/load
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the posted interrupt pre/post_block logic into vcpu_put/load
respectively, using the kvm_vcpu_is_blocking() to determining whether or
not the wakeup handler needs to be set (and unset).  This avoids updating
the PI descriptor if halt-polling is successful, reduces the number of
touchpoints for updating the descriptor, and eliminates the confusing
behavior of intentionally leaving a "stale" PI.NDST when a blocking vCPU
is scheduled back in after preemption.

The downside is that KVM will do the PID update twice if the vCPU is
preempted after prepare_to_rcuwait() but before schedule(), but that's a
rare case (and non-existent on !PREEMPT kernels).

The notable wart is the need to send a self-IPI on the wakeup vector if
an outstanding notification is pending after configuring the wakeup
vector.  Ideally, KVM would just do a kvm_vcpu_wake_up() in this case,
but the scheduler doesn't support waking a task from its preemption
notifier callback, i.e. while the task is smack dab in the middle of
being scheduled out.

Note, setting the wakeup vector before halt-polling is not necessary as
the pending IRQ will be recorded in the PIR and detected as a blocking-
breaking condition by kvm_vcpu_has_events() -> vmx_sync_pir_to_irr().

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 150 ++++++++++++++-------------------
 arch/x86/kvm/vmx/posted_intr.h |   8 +-
 arch/x86/kvm/vmx/vmx.c         |   5 --
 3 files changed, 70 insertions(+), 93 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 88c53c521094..a1776d186225 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -52,6 +52,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 	struct pi_desc old, new;
+	unsigned long flags;
 	unsigned int dest;
 
 	/*
@@ -62,23 +63,34 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 	if (!enable_apicv || !lapic_in_kernel(vcpu))
 		return;
 
-	/* Nothing to do if PI.SN and PI.NDST both have the desired value. */
-	if (!pi_test_sn(pi_desc) && vcpu->cpu == cpu)
+	/*
+	 * If the vCPU wasn't on the wakeup list and wasn't migrated, then the
+	 * full update can be skipped as neither the vector nor the destination
+	 * needs to be changed.
+	 */
+	if (pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR && vcpu->cpu == cpu) {
+		/*
+		 * Clear SN if it was set due to being preempted.  Again, do
+		 * this even if there is no assigned device for simplicity.
+		 */
+		if (pi_test_and_clear_sn(pi_desc))
+			goto after_clear_sn;
 		return;
+	}
+
+	local_irq_save(flags);
 
 	/*
-	 * If the 'nv' field is POSTED_INTR_WAKEUP_VECTOR, do not change
-	 * PI.NDST: pi_post_block is the one expected to change PID.NDST and the
-	 * wakeup handler expects the vCPU to be on the blocked_vcpu_list that
-	 * matches PI.NDST. Otherwise, a vcpu may not be able to be woken up
-	 * correctly.
+	 * If the vCPU was waiting for wakeup, remove the vCPU from the wakeup
+	 * list of the _previous_ pCPU, which will not be the same as the
+	 * current pCPU if the task was migrated.
 	 */
-	if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR || vcpu->cpu == cpu) {
-		pi_clear_sn(pi_desc);
-		goto after_clear_sn;
+	if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR) {
+		spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
+		list_del(&vcpu->blocked_vcpu_list);
+		spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
 	}
 
-	/* The full case.  Set the new destination and clear SN. */
 	dest = cpu_physical_id(cpu);
 	if (!x2apic_mode)
 		dest = (dest << 8) & 0xFF00;
@@ -86,10 +98,22 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 	do {
 		old.control = new.control = READ_ONCE(pi_desc->control);
 
+		/*
+		 * Clear SN (as above) and refresh the destination APIC ID to
+		 * handle task migration (@cpu != vcpu->cpu).
+		 */
 		new.ndst = dest;
 		new.sn = 0;
+
+		/*
+		 * Restore the notification vector; in the blocking case, the
+		 * descriptor was modified on "put" to use the wakeup vector.
+		 */
+		new.nv = POSTED_INTR_VECTOR;
 	} while (pi_try_set_control(pi_desc, old.control, new.control));
 
+	local_irq_restore(flags);
+
 after_clear_sn:
 
 	/*
@@ -111,83 +135,24 @@ static bool vmx_can_use_vtd_pi(struct kvm *kvm)
 		irq_remapping_cap(IRQ_POSTING_CAP);
 }
 
-void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
-{
-	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
-
-	if (!vmx_can_use_vtd_pi(vcpu->kvm))
-		return;
-
-	/* Set SN when the vCPU is preempted */
-	if (vcpu->preempted)
-		pi_set_sn(pi_desc);
-}
-
-static void __pi_post_block(struct kvm_vcpu *vcpu)
-{
-	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
-	struct pi_desc old, new;
-	unsigned int dest;
-
-	/*
-	 * Remove the vCPU from the wakeup list of the _previous_ pCPU, which
-	 * will not be the same as the current pCPU if the task was migrated.
-	 */
-	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->pre_pcpu));
-	list_del(&vcpu->blocked_vcpu_list);
-	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->pre_pcpu));
-
-	dest = cpu_physical_id(vcpu->cpu);
-	if (!x2apic_mode)
-		dest = (dest << 8) & 0xFF00;
-
-	WARN(pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR,
-	     "Wakeup handler not enabled while the vCPU was blocking");
-
-	do {
-		old.control = new.control = READ_ONCE(pi_desc->control);
-
-		new.ndst = dest;
-
-		/* set 'NV' to 'notification vector' */
-		new.nv = POSTED_INTR_VECTOR;
-	} while (pi_try_set_control(pi_desc, old.control, new.control));
-
-	vcpu->pre_pcpu = -1;
-}
-
 /*
- * This routine does the following things for vCPU which is going
- * to be blocked if VT-d PI is enabled.
- * - Store the vCPU to the wakeup list, so when interrupts happen
- *   we can find the right vCPU to wake up.
- * - Change the Posted-interrupt descriptor as below:
- *      'NV' <-- POSTED_INTR_WAKEUP_VECTOR
- * - If 'ON' is set during this process, which means at least one
- *   interrupt is posted for this vCPU, we cannot block it, in
- *   this case, return 1, otherwise, return 0.
- *
+ * Put the vCPU on this pCPU's list of vCPUs that needs to be awakened and set
+ * WAKEUP as the notification vector in the PI descriptor.
  */
-int pi_pre_block(struct kvm_vcpu *vcpu)
+static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
 {
-	struct pi_desc old, new;
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	struct pi_desc old, new;
 	unsigned long flags;
 
-	if (!vmx_can_use_vtd_pi(vcpu->kvm) ||
-	    vmx_interrupt_blocked(vcpu))
-		return 0;
-
 	local_irq_save(flags);
 
-	vcpu->pre_pcpu = vcpu->cpu;
 	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
 	list_add_tail(&vcpu->blocked_vcpu_list,
 		      &per_cpu(blocked_vcpu_on_cpu, vcpu->cpu));
 	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
 
-	WARN(pi_desc->sn == 1,
-	     "Posted Interrupt Suppress Notification set before blocking");
+	WARN(pi_desc->sn, "PI descriptor SN field set before blocking");
 
 	do {
 		old.control = new.control = READ_ONCE(pi_desc->control);
@@ -196,24 +161,37 @@ int pi_pre_block(struct kvm_vcpu *vcpu)
 		new.nv = POSTED_INTR_WAKEUP_VECTOR;
 	} while (pi_try_set_control(pi_desc, old.control, new.control));
 
-	/* We should not block the vCPU if an interrupt is posted for it.  */
-	if (pi_test_on(pi_desc))
-		__pi_post_block(vcpu);
+	/*
+	 * Send a wakeup IPI to this CPU if an interrupt may have been posted
+	 * before the notification vector was updated, in which case the IRQ
+	 * will arrive on the non-wakeup vector.  An IPI is needed as calling
+	 * try_to_wake_up() from ->sched_out() isn't allowed (IRQs are not
+	 * enabled until it is safe to call try_to_wake_up() on the task being
+	 * scheduled out).
+	 */
+	if (pi_test_on(&new))
+		apic->send_IPI_self(POSTED_INTR_WAKEUP_VECTOR);
 
 	local_irq_restore(flags);
-	return (vcpu->pre_pcpu == -1);
 }
 
-void pi_post_block(struct kvm_vcpu *vcpu)
+void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
 {
-	unsigned long flags;
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
 
-	if (vcpu->pre_pcpu == -1)
+	if (!vmx_can_use_vtd_pi(vcpu->kvm))
 		return;
 
-	local_irq_save(flags);
-	__pi_post_block(vcpu);
-	local_irq_restore(flags);
+	if (kvm_vcpu_is_blocking(vcpu) && !vmx_interrupt_blocked(vcpu))
+		pi_enable_wakeup_handler(vcpu);
+
+	/*
+	 * Set SN when the vCPU is preempted.  Note, the vCPU can both be seen
+	 * as blocking and preempted, e.g. if it's preempted between setting
+	 * its wait state and manually scheduling out.
+	 */
+	if (vcpu->preempted)
+		pi_set_sn(pi_desc);
 }
 
 /*
@@ -254,7 +232,7 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
  * Bail out of the block loop if the VM has an assigned
  * device, but the blocking vCPU didn't reconfigure the
  * PI.NV to the wakeup vector, i.e. the assigned device
- * came along after the initial check in pi_pre_block().
+ * came along after the initial check in vmx_vcpu_pi_put().
  */
 void vmx_pi_start_assignment(struct kvm *kvm)
 {
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index 36ae035f14aa..eb14e76b84ef 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -40,6 +40,12 @@ static inline bool pi_test_and_clear_on(struct pi_desc *pi_desc)
 			(unsigned long *)&pi_desc->control);
 }
 
+static inline bool pi_test_and_clear_sn(struct pi_desc *pi_desc)
+{
+	return test_and_clear_bit(POSTED_INTR_SN,
+			(unsigned long *)&pi_desc->control);
+}
+
 static inline bool pi_test_and_set_pir(int vector, struct pi_desc *pi_desc)
 {
 	return test_and_set_bit(vector, (unsigned long *)pi_desc->pir);
@@ -88,8 +94,6 @@ static inline bool pi_test_sn(struct pi_desc *pi_desc)
 
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu);
-int pi_pre_block(struct kvm_vcpu *vcpu);
-void pi_post_block(struct kvm_vcpu *vcpu);
 void pi_wakeup_handler(void);
 void __init pi_init_cpu(int cpu);
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a94f0fb80fd4..0254d7f64698 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7442,9 +7442,6 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 
 static int vmx_pre_block(struct kvm_vcpu *vcpu)
 {
-	if (pi_pre_block(vcpu))
-		return 1;
-
 	if (kvm_lapic_hv_timer_in_use(vcpu))
 		kvm_lapic_switch_to_sw_timer(vcpu);
 
@@ -7455,8 +7452,6 @@ static void vmx_post_block(struct kvm_vcpu *vcpu)
 {
 	if (kvm_x86_ops.set_hv_timer)
 		kvm_lapic_switch_to_hv_timer(vcpu);
-
-	pi_post_block(vcpu);
 }
 
 static void vmx_setup_mce(struct kvm_vcpu *vcpu)
-- 
2.34.1.400.ga245620fadb-goog

