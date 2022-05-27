Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C5535B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349109AbiE0IFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346376AbiE0IF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56D71FF592
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M1IZs3klzI4SDOe9ylEC0ku9fFW+/8u54cvhU+BDFz0=;
        b=QWVsj9HZWrKZK8g/mLGJdYII9looSEYsOrv0W05nc9nQ8pN2N6Iijx1h2eytAZQEHWa0x3
        OLKWKeyJ+PTSPgvrjWflhNns4TWD8wZ2Zw9cmeyN4ev6UabwlX0+z7wgscekb8cU9L+JEq
        vitbzRjbBaFNq987L9UnX/A17ugh7Jw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-1QRIi7dSPv-mlP2huYbBAw-1; Fri, 27 May 2022 04:05:19 -0400
X-MC-Unique: 1QRIi7dSPv-mlP2huYbBAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 411E03804506;
        Fri, 27 May 2022 08:05:19 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90A1C2026985;
        Fri, 27 May 2022 08:05:12 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 12/22] KVM: arm64: Support event injection and delivery
Date:   Fri, 27 May 2022 16:02:43 +0800
Message-Id: <20220527080253.1562538-13-gshan@redhat.com>
In-Reply-To: <20220527080253.1562538-1-gshan@redhat.com>
References: <20220527080253.1562538-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports event injection, delivery and cancellation. The event
is injected and cancelled by kvm_sdei_{inject, cancel}_event(). For
event delivery, kvm_sdei_deliver_event() is added to accommodate
KVM_REQ_SDEI request.

The KVM_REQ_SDEI request can be raised in several situation:

   * PE is unmasked

   * Event is enabled

   * Completion of currently running event or handler on receiving
     EVENT_COMPLETE or EVENT_COMPLETE_AND_RESUME hypercall, which
     will be supported in the subsequent patch.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h |   4 +
 arch/arm64/kvm/arm.c              |   3 +
 arch/arm64/kvm/sdei.c             | 123 ++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 609338b17478..735d9ac1a5a2 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -64,6 +64,10 @@ struct kvm_sdei_vcpu {
 
 /* APIs */
 int kvm_sdei_call(struct kvm_vcpu *vcpu);
+int kvm_sdei_inject_event(struct kvm_vcpu *vcpu,
+			  unsigned int num, bool immediate);
+int kvm_sdei_cancel_event(struct kvm_vcpu *vcpu, unsigned int num);
+void kvm_sdei_deliver_event(struct kvm_vcpu *vcpu);
 void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu);
 void kvm_sdei_destroy_vcpu(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9516f951e7b..06cb5e38634e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -720,6 +720,9 @@ static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
 			kvm_reset_vcpu(vcpu);
 
+		if (kvm_check_request(KVM_REQ_SDEI, vcpu))
+			kvm_sdei_deliver_event(vcpu);
+
 		/*
 		 * Clear IRQ_PENDING requests that were made to guarantee
 		 * that a VCPU sees new virtual interrupts.
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 42ba6f97b168..36a72c1750fc 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -266,6 +266,129 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+int kvm_sdei_inject_event(struct kvm_vcpu *vcpu,
+			  unsigned int num,
+			  bool immediate)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+
+	if (!vsdei)
+		return -EPERM;
+
+	if (num >= KVM_NR_SDEI_EVENTS || !test_bit(num, &vsdei->registered))
+		return -ENOENT;
+
+	/*
+	 * The event may be expected to be delivered immediately. There
+	 * are several cases we can't do this:
+	 *
+	 * (1) The PE has been masked from any events.
+	 * (2) The event isn't enabled yet.
+	 * (3) There are any pending or running events.
+	 */
+	if (immediate &&
+	    ((vcpu->arch.flags & KVM_ARM64_SDEI_MASKED) ||
+	    !test_bit(num, &vsdei->enabled) ||
+	    vsdei->pending || vsdei->running))
+		return -EBUSY;
+
+	set_bit(num, &vsdei->pending);
+	if (!(vcpu->arch.flags & KVM_ARM64_SDEI_MASKED) &&
+	    test_bit(num, &vsdei->enabled))
+		kvm_make_request(KVM_REQ_SDEI, vcpu);
+
+	return 0;
+}
+
+int kvm_sdei_cancel_event(struct kvm_vcpu *vcpu, unsigned int num)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+
+	if (!vsdei)
+		return -EPERM;
+
+	if (num >= KVM_NR_SDEI_EVENTS || !test_bit(num, &vsdei->registered))
+		return -ENOENT;
+
+	if (test_bit(num, &vsdei->running))
+		return -EBUSY;
+
+	clear_bit(num, &vsdei->pending);
+
+	return 0;
+}
+
+void kvm_sdei_deliver_event(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event_context *ctxt = &vsdei->ctxt;
+	unsigned int num, i;
+	unsigned long pstate;
+
+	if (!vsdei || (vcpu->arch.flags & KVM_ARM64_SDEI_MASKED))
+		return;
+
+	/*
+	 * All supported events have normal priority. So the currently
+	 * running event can't be preempted by any one else.
+	 */
+	if (vsdei->running)
+		return;
+
+	/* Select next pending event to be delivered */
+	num = 0;
+	while (num < KVM_NR_SDEI_EVENTS) {
+		num = find_next_bit(&vsdei->pending, KVM_NR_SDEI_EVENTS, num);
+		if (test_bit(num, &vsdei->enabled))
+			break;
+	}
+
+	if (num >= KVM_NR_SDEI_EVENTS)
+		return;
+
+	/*
+	 * Save the interrupted context. We might have pending request
+	 * to adjust PC. Lets adjust it now so that the resume address
+	 * is correct when COMPLETE or COMPLETE_AND_RESUME hypercall
+	 * is handled.
+	 */
+	__kvm_adjust_pc(vcpu);
+	ctxt->pc = *vcpu_pc(vcpu);
+	ctxt->pstate = *vcpu_cpsr(vcpu);
+	for (i = 0; i < ARRAY_SIZE(ctxt->regs); i++)
+		ctxt->regs[i] = vcpu_get_reg(vcpu, i);
+
+	/*
+	 * Inject event. The following registers are modified according
+	 * to the specification.
+	 *
+	 * x0: event number
+	 * x1: argument specified when the event is registered
+	 * x2: PC of the interrupted context
+	 * x3: PSTATE of the interrupted context
+	 * PC: event handler
+	 * PSTATE: Cleared nRW bit, but D/A/I/F bits are set
+	 */
+	for (i = 0; i < ARRAY_SIZE(ctxt->regs); i++)
+		vcpu_set_reg(vcpu, i, 0);
+
+	vcpu_set_reg(vcpu, 0, num);
+	vcpu_set_reg(vcpu, 1, vsdei->handlers[num].ep_arg);
+	vcpu_set_reg(vcpu, 2, ctxt->pc);
+	vcpu_set_reg(vcpu, 3, ctxt->pstate);
+
+	pstate = ctxt->pstate;
+	pstate &= ~(PSR_MODE32_BIT | PSR_MODE_MASK);
+	pstate |= (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | PSR_MODE_EL1h);
+
+	*vcpu_cpsr(vcpu) = pstate;
+	*vcpu_pc(vcpu) = vsdei->handlers[num].ep_addr;
+
+	/* Update event states */
+	clear_bit(num, &vsdei->pending);
+	set_bit(num, &vsdei->running);
+}
+
 void kvm_sdei_create_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei;
-- 
2.23.0

