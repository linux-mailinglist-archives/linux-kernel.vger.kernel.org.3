Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678AE4E3A43
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiCVILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiCVILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E995722532
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647936620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LIZ4+UZDR/rmIDcVGPelhK/TR916yFa76+4h/+44F4=;
        b=D1aKnyDwyWcPU/Gh0MI2X4BRF3jzmQnaBs4Tqlbnhz5QEid5We+9xd0gXpsQ0fYU+lYFDZ
        N4GcUcGgDBLS5vkS7LRjkqEtOX8aLHrly4zYI7uLh9JAoXkMxr9BBfWvFQ31ImS25IL/up
        tq10QtRLXkIIp08FCX01RYSH5PaewJc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-izDC0cl_MU2_BVqHHkgCZw-1; Tue, 22 Mar 2022 04:10:16 -0400
X-MC-Unique: izDC0cl_MU2_BVqHHkgCZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 454D3801E67;
        Tue, 22 Mar 2022 08:10:16 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 604F41121324;
        Tue, 22 Mar 2022 08:10:10 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com,
        shannon.zhaosl@gmail.com, maz@kernel.org,
        Jonathan.Cameron@huawei.com, will@kernel.org, pbonzini@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, drjones@redhat.com,
        vkuznets@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 16/22] KVM: arm64: Support SDEI_EVENT_{COMPLETE,COMPLETE_AND_RESUME} hypercall
Date:   Tue, 22 Mar 2022 16:07:04 +0800
Message-Id: <20220322080710.51727-17-gshan@redhat.com>
In-Reply-To: <20220322080710.51727-1-gshan@redhat.com>
References: <20220322080710.51727-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
They are used by the guest to notify the completion of the SDEI
event in the handler. The executing context or registers are modified
according to the SDEI specification like below:

   * x0 - x17, PC and PState are restored to what values we had in
     the interrupted or preempted context.

   * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
     is injected.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/include/asm/kvm_host.h    |  1 +
 arch/arm64/kvm/inject_fault.c        | 29 +++++++++++
 arch/arm64/kvm/sdei.c                | 76 +++++++++++++++++++++++++++-
 4 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index d62405ce3e6d..ca9de9f24923 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -37,6 +37,7 @@ bool kvm_condition_valid32(const struct kvm_vcpu *vcpu);
 void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
+void kvm_inject_irq(struct kvm_vcpu *vcpu);
 void kvm_inject_vabt(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e2762d08ab1c..282913e1afb0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -428,6 +428,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_EXCEPT_AA32_UND	(0 << 9)
 #define KVM_ARM64_EXCEPT_AA32_IABT	(1 << 9)
 #define KVM_ARM64_EXCEPT_AA32_DABT	(2 << 9)
+#define KVM_ARM64_EXCEPT_AA32_IRQ	(3 << 9)
 /* For AArch64: */
 #define KVM_ARM64_EXCEPT_AA64_ELx_SYNC	(0 << 9)
 #define KVM_ARM64_EXCEPT_AA64_ELx_IRQ	(1 << 9)
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index b47df73e98d7..c8a8791bdf28 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -66,6 +66,13 @@ static void inject_undef64(struct kvm_vcpu *vcpu)
 	vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
 }
 
+static void inject_irq64(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA64_EL1     |
+			     KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
+			     KVM_ARM64_PENDING_EXCEPTION);
+}
+
 #define DFSR_FSC_EXTABT_LPAE	0x10
 #define DFSR_FSC_EXTABT_nLPAE	0x08
 #define DFSR_LPAE		BIT(9)
@@ -77,6 +84,12 @@ static void inject_undef32(struct kvm_vcpu *vcpu)
 			     KVM_ARM64_PENDING_EXCEPTION);
 }
 
+static void inject_irq32(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.flags |= (KVM_ARM64_EXCEPT_AA32_IRQ |
+			     KVM_ARM64_PENDING_EXCEPTION);
+}
+
 /*
  * Modelled after TakeDataAbortException() and TakePrefetchAbortException
  * pseudocode.
@@ -160,6 +173,22 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu)
 		inject_undef64(vcpu);
 }
 
+/**
+ * kvm_inject_irq - inject an IRQ into the guest
+ * @vcpu: The vCPU in which to inject IRQ
+ *
+ * Inject IRQs to the target vCPU. It is assumed that this code is
+ * called from the VCPU thread and that the VCPU therefore is not
+ * currently executing guest code.
+ */
+void kvm_inject_irq(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_el1_is_32bit(vcpu))
+		inject_irq32(vcpu);
+	else
+		inject_irq64(vcpu);
+}
+
 void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 esr)
 {
 	vcpu_set_vsesr(vcpu, esr & ESR_ELx_ISS_MASK);
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index ba2ca65c871b..3019ac196e76 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -344,6 +344,78 @@ static unsigned long hypercall_context(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long hypercall_complete(struct kvm_vcpu *vcpu, bool resume)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_registered_event *registered_event;
+	struct kvm_sdei_vcpu_event *vcpu_event;
+	struct kvm_sdei_vcpu_regs_state *regs;
+	unsigned long ret = SDEI_SUCCESS;
+	int index;
+
+	spin_lock(&ksdei->lock);
+	spin_lock(&vsdei->lock);
+
+	if (vsdei->critical_event) {
+		vcpu_event = vsdei->critical_event;
+		regs = &vsdei->state.critical_regs;
+		vsdei->critical_event = NULL;
+		vsdei->state.critical_num = KVM_SDEI_INVALID_EVENT;
+	} else if (vsdei->normal_event) {
+		vcpu_event = vsdei->normal_event;
+		regs = &vsdei->state.normal_regs;
+		vsdei->normal_event = NULL;
+		vsdei->state.normal_num = KVM_SDEI_INVALID_EVENT;
+	} else {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Restore registers: x0 -> x17, PC, PState */
+	for (index = 0; index < ARRAY_SIZE(regs->regs); index++)
+		vcpu_set_reg(vcpu, index, regs->regs[index]);
+
+	*vcpu_cpsr(vcpu) = regs->pstate;
+	*vcpu_pc(vcpu) = regs->pc;
+
+	/* Inject interrupt if needed */
+	if (resume)
+		kvm_inject_irq(vcpu);
+
+	/* Dereference the vcpu event and destroy it if needed */
+	vcpu_event->state.event_count--;
+	if (!vcpu_event->state.event_count)
+		remove_one_vcpu_event(vcpu, vcpu_event);
+
+	/*
+	 * We need to check if the registered event is pending for
+	 * unregistration. In that case, the registered event should
+	 * be unregistered and destroyed if needed.
+	 */
+	registered_event = vcpu_event->registered_event;
+	exposed_event = registered_event->exposed_event;
+	index = kvm_sdei_vcpu_index(vcpu, exposed_event);
+	if (kvm_sdei_is_unregister_pending(registered_event, index)) {
+		kvm_sdei_clear_enabled(registered_event, index);
+		kvm_sdei_clear_registered(registered_event, index);
+		if (kvm_sdei_none_registered(registered_event))
+			remove_one_registered_event(kvm, registered_event);
+	}
+
+	/* Make another request if we have any pending events */
+	if ((vsdei->critical_event_count + vsdei->normal_event_count) > 0)
+		kvm_make_request(KVM_REQ_SDEI, vcpu);
+
+unlock:
+	spin_unlock(&vsdei->lock);
+	spin_unlock(&ksdei->lock);
+
+	return ret;
+}
+
 static unsigned long
 unregister_one_event(struct kvm *kvm, struct kvm_vcpu *vcpu,
 		     struct kvm_sdei_registered_event *registered_event)
@@ -864,8 +936,10 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = hypercall_context(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
+		ret = hypercall_complete(vcpu, false);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
-		ret = SDEI_NOT_SUPPORTED;
+		ret = hypercall_complete(vcpu, true);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
 		ret = hypercall_unregister(vcpu);
-- 
2.23.0

