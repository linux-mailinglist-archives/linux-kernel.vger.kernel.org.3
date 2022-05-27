Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D4F535B09
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348233AbiE0IEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348793AbiE0IEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C621910274A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kcK/t9iW1JR5lhmsZM8idJt1ZlBlpeTLocByfzKuNnU=;
        b=VN0KBmPT1IVEUIL6fWSzIlu1do9NZL1l+Li5sOKAjhxAckcgd4QrgE38e6lprqmmoEsMnt
        85cJvAHWKg5Diwtx+3MBGoKw5GYLvXoOIjsbruAPS0Izz96RRWj4ukHcMOZ+v50pifYwg/
        2+yovn46II/LX/ltSva4Rz+3lkrU8VM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-RzrZnFTLOkWOtiHCvt0Maw-1; Fri, 27 May 2022 04:04:34 -0400
X-MC-Unique: RzrZnFTLOkWOtiHCvt0Maw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFC77187506C;
        Fri, 27 May 2022 08:04:33 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C23382024CBB;
        Fri, 27 May 2022 08:04:24 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 06/22] KVM: arm64: Support EVENT_CONTEXT hypercall
Date:   Fri, 27 May 2022 16:02:37 +0800
Message-Id: <20220527080253.1562538-7-gshan@redhat.com>
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

This supports EVENT_CONTEXT hypercall. It's called inside the event
handler to retrieve the specified register in the saved or preempted
context.

  * The request is rejected if no running event handler exists or the
    parameter ID is out of range.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index a4046e7b21d8..2fec2dcd02b0 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -44,7 +44,7 @@ static unsigned long event_register(struct kvm_vcpu *vcpu)
 static unsigned long event_enable(struct kvm_vcpu *vcpu, bool enable)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
-	unsigned int num = smccc_get_arg(vcpu, 1);
+	int num = smccc_get_arg(vcpu, 1);
 
 	if (num >= KVM_NR_SDEI_EVENTS)
 		return SDEI_INVALID_PARAMETERS;
@@ -68,6 +68,23 @@ static unsigned long event_enable(struct kvm_vcpu *vcpu, bool enable)
 	return SDEI_SUCCESS;
 }
 
+static unsigned long event_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event_context *ctxt = &vsdei->ctxt;
+	unsigned int param_id = smccc_get_arg(vcpu, 1);
+
+	/* Reject if event handler isn't running */
+	if (!vsdei->running)
+		return SDEI_DENIED;
+
+	/* Reject if the parameter ID is out of range */
+	if (param_id >= ARRAY_SIZE(ctxt->regs))
+		return SDEI_INVALID_PARAMETERS;
+
+	return ctxt->regs[param_id];
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -95,6 +112,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
 		ret = event_enable(vcpu, false);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
+		ret = event_context(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

