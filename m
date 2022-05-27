Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72938535B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347076AbiE0IF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349063AbiE0IFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C239B10277F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/sMtf3ycYV6mAOWnm/6XSJenHeTbOjDcLvp1nt3Cvw=;
        b=gHHgcFtpvEyvPvj5/apjxDawphog82G1q+Uv2pgAcTcUlrHx7Ziau/ZQs4ZiFHBUXitWCM
        TOsZU25LljKM352TZGxeBrIEdHCBUwzTm2tnJzE8Y6eLKU8ZpeYEU7rCahrmJOv1/5nPsX
        s6Y4FgD9DOelvxVY1oo7p+S7HsmXapU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-LBUecK2GMdK7gJWsKVcz4A-1; Fri, 27 May 2022 04:05:30 -0400
X-MC-Unique: LBUecK2GMdK7gJWsKVcz4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFBC71C161AE;
        Fri, 27 May 2022 08:05:29 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1D972026D64;
        Fri, 27 May 2022 08:05:19 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 13/22] KVM: arm64: Support EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall
Date:   Fri, 27 May 2022 16:02:44 +0800
Message-Id: <20220527080253.1562538-14-gshan@redhat.com>
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

This supports EVENT_{COMPLETE, COMPLETE_AND_RESUME} hypercall. The
execution resumes from previously interrupted context when
EVENT_COMPLETE hypercall is received.

However, the execution resumes from the specified address when
EVENT_COMPLETE_AND_RESUME is received. In this case, context
switches like below.

  * x0 to x17 are restored from the interrupted context.

  * SPSR_EL1 is set to PSTATE of the interrupted context.

  * ELR_EL1 is set to PC of the interrupted context.

  * PSTATE has nRW cleared, but D/A/I/F set.

  * PC is set to the resume address, specified in the first argument
    of EVENT_COMPLETE_AND_RESUME hypercall.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 36a72c1750fc..0bea1b2f9452 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -85,6 +85,54 @@ static unsigned long event_context(struct kvm_vcpu *vcpu)
 	return ctxt->regs[param_id];
 }
 
+static void event_complete(struct kvm_vcpu *vcpu, bool resume)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event_context *ctxt = &vsdei->ctxt;
+	unsigned long pstate, resume_addr = smccc_get_arg(vcpu, 1);
+	unsigned int num, i;
+
+	num = find_next_bit(&vsdei->running, KVM_NR_SDEI_EVENTS, 0);
+	if (num >= KVM_NR_SDEI_EVENTS)
+		return;
+
+	/* Restore registers: x0 -> x17 */
+	for (i = 0; i < ARRAY_SIZE(ctxt->regs); i++)
+		vcpu_set_reg(vcpu, i, ctxt->regs[i]);
+
+	/*
+	 * The registers are modified accordingly if the execution resumes
+	 * from the specified address.
+	 *
+	 * SPSR_EL1: PSTATE of the interrupted context
+	 * ELR_EL1:  PC of the interrupted context
+	 * PSTATE:   cleared nRW bit, but D/A/I/F bits are set
+	 * PC:       the resume address
+	 */
+	if (resume) {
+		if (has_vhe()) {
+			write_sysreg_el1(ctxt->pstate, SYS_SPSR);
+			write_sysreg_s(ctxt->pc, SYS_ELR_EL12);
+		} else {
+			__vcpu_sys_reg(vcpu, SPSR_EL1) = ctxt->pstate;
+			__vcpu_sys_reg(vcpu, ELR_EL1) = ctxt->pc;
+		}
+
+		pstate = ctxt->pstate;
+		pstate &= ~(PSR_MODE32_BIT | PSR_MODE_MASK);
+		pstate |= (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT |
+			   PSR_F_BIT | PSR_MODE_EL1h);
+		*vcpu_cpsr(vcpu) = pstate;
+		*vcpu_pc(vcpu) = resume_addr;
+	} else {
+		*vcpu_cpsr(vcpu) = ctxt->pstate;
+		*vcpu_pc(vcpu) = ctxt->pc;
+	}
+
+	/* Update event state */
+	clear_bit(num, &vsdei->running);
+}
+
 static unsigned long event_unregister(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -234,6 +282,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
 		ret = event_context(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
+		event_complete(vcpu, false);
+		break;
+	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
+		event_complete(vcpu, true);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
 		ret = event_unregister(vcpu);
 		break;
-- 
2.23.0

