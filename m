Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8784E3A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiCVILD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiCVIKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5958D60EB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647936554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MDMpbl/XXWJVxRKGa6DuNkU1Ki68AS56WQu7ISeC4wY=;
        b=AKjro7zkW2wRqr0kC++yEuKv8/0VDv/0yi24Gqwfu/6rVDtYMo7DCmZBaop+TuDX1x/1AM
        WSINxP3Juh/cXPqJ4FeS1K8u+0cleShAfM/GIuZkVCMNHZgrbNixV8sGI+BEWrvi28YFWC
        OzfMKLRWlo57RmdXOeNlygIeTX08hMs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-dnfIR7HYP1mBixtvi6tvFA-1; Tue, 22 Mar 2022 04:09:11 -0400
X-MC-Unique: dnfIR7HYP1mBixtvi6tvFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A093D1044566;
        Tue, 22 Mar 2022 08:09:10 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 244501121324;
        Tue, 22 Mar 2022 08:09:04 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com,
        shannon.zhaosl@gmail.com, maz@kernel.org,
        Jonathan.Cameron@huawei.com, will@kernel.org, pbonzini@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, drjones@redhat.com,
        vkuznets@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 10/22] KVM: arm64: Support SDEI_EVENT_ROUTING_SET hypercall
Date:   Tue, 22 Mar 2022 16:06:58 +0800
Message-Id: <20220322080710.51727-11-gshan@redhat.com>
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

This supports SDEI_EVENT_ROUTING_SET hypercall. It's used by the
guest to set route mode and affinity for the shared and registered
events. The request to configure the routing mode and affinity for
the private events are disallowed. Besides, It's not allowed to do
when the corresponding vCPU events are existing.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 4f26e5f70bff..db82ea441eae 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -565,6 +565,66 @@ static unsigned long hypercall_info(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long hypercall_route(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_registered_event *registered_event;
+	unsigned long event_num = smccc_get_arg1(vcpu);
+	unsigned long route_mode = smccc_get_arg2(vcpu);
+	unsigned long route_affinity = smccc_get_arg3(vcpu);
+	int index = 0;
+	unsigned long ret = SDEI_SUCCESS;
+
+	if (!kvm_sdei_is_supported(event_num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	/*
+	 * FIXME: The affinity should be verified when it's supported. We
+	 * accept anything for now.
+	 */
+	if (route_mode != SDEI_EVENT_REGISTER_RM_ANY &&
+	    route_mode != SDEI_EVENT_REGISTER_RM_PE) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+
+	/* Check if the registered event exists */
+	registered_event = find_registered_event(kvm, event_num);
+	if (!registered_event) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Check the registered event is a shared one */
+	exposed_event = registered_event->exposed_event;
+	if (!kvm_sdei_is_shared(exposed_event->state.type)) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	if (!kvm_sdei_is_registered(registered_event, index) ||
+	    kvm_sdei_is_enabled(registered_event, index)     ||
+	    registered_event->vcpu_event_count > 0) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Update the registered event state */
+	registered_event->state.route_mode     = route_mode;
+	registered_event->state.route_affinity = route_affinity;
+
+unlock:
+	spin_unlock(&ksdei->lock);
+out:
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -617,6 +677,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = hypercall_info(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
+		ret = hypercall_route(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_PE_MASK:
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
 	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
-- 
2.23.0

