Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3424E3A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiCVIKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiCVIKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA82A636E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647936546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uBmvh5ZuowzkjTYHJM1SHAN/6NzyYtxJ4RrsdQ22jlY=;
        b=dv8g+DDaiBy3m7Vm2gbOsKYC8dgxsURw7XZj32x6MDmKLlQqojC8Hb4yCoPDI14tBPwwKm
        nTfZseJJpVnNl4QH14l6xZZwmKDeHuXEd6uJ1BD9qA0FZy9iq6Hhe8XKsLU6Q7Fn0RkXrr
        PADlKKbYfYRL716VQ402/2CNdRdWtyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-KasuIbuaPbesOOtic6uUbg-1; Tue, 22 Mar 2022 04:09:05 -0400
X-MC-Unique: KasuIbuaPbesOOtic6uUbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FB1B1044562;
        Tue, 22 Mar 2022 08:09:04 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F41401121324;
        Tue, 22 Mar 2022 08:08:58 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com,
        shannon.zhaosl@gmail.com, maz@kernel.org,
        Jonathan.Cameron@huawei.com, will@kernel.org, pbonzini@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, drjones@redhat.com,
        vkuznets@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 09/22] KVM: arm64: Support SDEI_EVENT_GET_INFO hypercall
Date:   Tue, 22 Mar 2022 16:06:57 +0800
Message-Id: <20220322080710.51727-10-gshan@redhat.com>
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

This supports SDEI_EVENT_GET_INFO hypercall. It's used by the guest
to retrieve various information about the exposed or registered event,
including type, signaled, routing mode and affinity. The routing
mode and affinity information is only valid to the shared and
registered event.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 73 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 5c43c8912ea1..4f26e5f70bff 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -494,6 +494,77 @@ static unsigned long hypercall_status(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long hypercall_info(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event = NULL;
+	struct kvm_sdei_registered_event *registered_event = NULL;
+	unsigned long event_num = smccc_get_arg1(vcpu);
+	unsigned long event_info = smccc_get_arg2(vcpu);
+	int index;
+	unsigned long ret = SDEI_SUCCESS;
+
+	if (!kvm_sdei_is_supported(event_num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	spin_lock(&ksdei->lock);
+
+	/*
+	 * Retrieve the information from the registered event if it exists.
+	 * Otherwise, we turn into the exposed event if needed.
+	 */
+	registered_event = find_registered_event(kvm, event_num);
+	exposed_event = registered_event ? registered_event->exposed_event :
+					   find_exposed_event(kvm, event_num);
+	if (!exposed_event) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Retrieve the requested information */
+	switch (event_info) {
+	case SDEI_EVENT_INFO_EV_TYPE:
+		ret = exposed_event->state.type;
+		break;
+	case SDEI_EVENT_INFO_EV_SIGNALED:
+		ret = exposed_event->state.signaled;
+		break;
+	case SDEI_EVENT_INFO_EV_PRIORITY:
+		ret = exposed_event->state.priority;
+		break;
+	case SDEI_EVENT_INFO_EV_ROUTING_MODE:
+	case SDEI_EVENT_INFO_EV_ROUTING_AFF:
+		if (!kvm_sdei_is_shared(exposed_event->state.type)) {
+			ret = SDEI_INVALID_PARAMETERS;
+			break;
+		}
+
+		index = kvm_sdei_vcpu_index(vcpu, exposed_event);
+		if (!registered_event ||
+		    !kvm_sdei_is_registered(registered_event, index)) {
+			ret = SDEI_DENIED;
+			break;
+		}
+
+		if (event_info == SDEI_EVENT_INFO_EV_ROUTING_MODE)
+			ret = registered_event->state.route_mode;
+		else
+			ret = registered_event->state.route_affinity;
+
+		break;
+	default:
+		ret = SDEI_INVALID_PARAMETERS;
+	}
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
@@ -543,6 +614,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = hypercall_status(vcpu);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
+		ret = hypercall_info(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
 	case SDEI_1_0_FN_SDEI_PE_MASK:
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
-- 
2.23.0

