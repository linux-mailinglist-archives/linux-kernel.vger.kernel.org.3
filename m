Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662974F0AD7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350680AbiDCPnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359323AbiDCPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66E672DD61
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDyhK0N42QTYxzvptLYmEfOmEf+1ls/8SVfr1kkXkvg=;
        b=ClvF1UGIXbEaQKukyfRjcG1RpT1lfV4ZKhkPv8YuVOPLKI9wjEG4nfmiA+bS/66yArK1Z4
        cMJHVaXqhYgA9/Cm+ggnnvgMwISTg8PjFHDDuGd9VSB8Ea14A2ahNXCh8rGhyqMNapbgmX
        MWBfRNFOk2nBX4gwMw/Cgz4I8fhJliA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-vXCcNdQtNb2K6-e3mqzp7Q-1; Sun, 03 Apr 2022 11:41:01 -0400
X-MC-Unique: vXCcNdQtNb2K6-e3mqzp7Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F05FE85A5BC;
        Sun,  3 Apr 2022 15:41:00 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F071D403172;
        Sun,  3 Apr 2022 15:40:54 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 13/18] KVM: arm64: Support SDEI_EVENT_{COMPLETE,COMPLETE_AND_RESUME} hypercall
Date:   Sun,  3 Apr 2022 23:39:06 +0800
Message-Id: <20220403153911.12332-14-gshan@redhat.com>
In-Reply-To: <20220403153911.12332-1-gshan@redhat.com>
References: <20220403153911.12332-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall.
They are used by guest to notify the completion of event in its
handler. The previously interrupted or preempted context is restored
like below.

   * x0 - x17, PC and PState are restored to what values we had in
     the interrupted or preempted context.

   * If it's SDEI_EVENT_COMPLETE_AND_RESUME hypercall, IRQ exception
     is injected.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/include/asm/kvm_host.h    |  1 +
 arch/arm64/kvm/hyp/exception.c       |  7 +++
 arch/arm64/kvm/inject_fault.c        | 29 ++++++++++
 arch/arm64/kvm/sdei.c                | 79 ++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+)

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
index 951264d4b64d..ac475d3b9151 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -431,6 +431,7 @@ struct kvm_vcpu_arch {
 #define KVM_ARM64_EXCEPT_AA32_UND	(0 << 9)
 #define KVM_ARM64_EXCEPT_AA32_IABT	(1 << 9)
 #define KVM_ARM64_EXCEPT_AA32_DABT	(2 << 9)
+#define KVM_ARM64_EXCEPT_AA32_IRQ	(3 << 9)
 /* For AArch64: */
 #define KVM_ARM64_EXCEPT_AA64_ELx_SYNC	(0 << 9)
 #define KVM_ARM64_EXCEPT_AA64_ELx_IRQ	(1 << 9)
diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
index c5d009715402..f425ea11e4f6 100644
--- a/arch/arm64/kvm/hyp/exception.c
+++ b/arch/arm64/kvm/hyp/exception.c
@@ -313,6 +313,9 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 		case KVM_ARM64_EXCEPT_AA32_DABT:
 			enter_exception32(vcpu, PSR_AA32_MODE_ABT, 16);
 			break;
+		case KVM_ARM64_EXCEPT_AA32_IRQ:
+			enter_exception32(vcpu, PSR_AA32_MODE_IRQ, 24);
+			break;
 		default:
 			/* Err... */
 			break;
@@ -323,6 +326,10 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 		      KVM_ARM64_EXCEPT_AA64_EL1):
 			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_sync);
 			break;
+		case (KVM_ARM64_EXCEPT_AA64_ELx_IRQ |
+		      KVM_ARM64_EXCEPT_AA64_EL1):
+			enter_exception64(vcpu, PSR_MODE_EL1h, except_type_irq);
+			break;
 		default:
 			/*
 			 * Only EL1_SYNC makes sense so far, EL2_{SYNC,IRQ}
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
index 9d18fee59751..ebdbe7810cf0 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -243,6 +243,79 @@ static unsigned long hypercall_context(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long hypercall_complete(struct kvm_vcpu *vcpu, bool resume)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_event *event;
+	struct kvm_sdei_vcpu_context *context;
+	unsigned int i;
+	unsigned long ret = SDEI_SUCCESS;
+
+	spin_lock(&vsdei->lock);
+
+	/* Check if there is any event being handled */
+	context = &vsdei->context[SDEI_EVENT_PRIORITY_CRITICAL];
+	context = context->event ? context : NULL;
+	context = context ? : &vsdei->context[SDEI_EVENT_PRIORITY_NORMAL];
+	context = context->event ? context : NULL;
+	if (!context) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Restore registers: x0 -> x17, PC, PState */
+	for (i = 0; i < ARRAY_SIZE(context->regs); i++)
+		vcpu_set_reg(vcpu, i, context->regs[i]);
+
+	*vcpu_cpsr(vcpu) = context->pstate;
+	*vcpu_pc(vcpu) = context->pc;
+
+	/* Inject interrupt if needed */
+	if (resume)
+		kvm_inject_irq(vcpu);
+
+	/*
+	 * Decrease the event count and invalidate the event in the
+	 * vcpu context.
+	 */
+	event = context->event;
+	exposed_event = event->exposed_event;
+	context->event = NULL;
+	event->event_count--;
+	if (kvm_sdei_is_critical(exposed_event->priority))
+		vsdei->critical_event_count--;
+	else
+		vsdei->normal_event_count--;
+
+	/*
+	 * We need to check if the event is pending for unregistration.
+	 * In that case, the event should be disabled and unregistered.
+	 * All the pending events are cancelled either.
+	 */
+	if (kvm_sdei_is_unregister_pending(event)) {
+		if (kvm_sdei_is_critical(exposed_event->priority))
+			vsdei->critical_event_count -= event->event_count;
+		else
+			vsdei->normal_event_count -= event->event_count;
+
+		event->event_count = 0;
+		kvm_sdei_clear_enabled(event);
+		kvm_sdei_clear_registered(event);
+		kvm_sdei_clear_unregister_pending(event);
+	}
+
+	/* Another request if we have more events to be handled */
+	if (vsdei->critical_event_count > 0 ||
+	    vsdei->normal_event_count > 0)
+		kvm_make_request(KVM_REQ_SDEI, vcpu);
+
+unlock:
+	spin_unlock(&vsdei->lock);
+
+	return ret;
+}
+
 static unsigned long hypercall_unregister(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -445,6 +518,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
 		ret = hypercall_context(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
+		ret = hypercall_complete(vcpu, false);
+		break;
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
+		ret = hypercall_complete(vcpu, true);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
 		ret = hypercall_unregister(vcpu);
 		break;
-- 
2.23.0

