Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF6F4F0ABF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358621AbiDCPmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359225AbiDCPmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B18322496C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lEo1vYagHbuDvOHHz7jGfQGWnUXmF26JqdCfdJr4Xk=;
        b=WyEptZain2/z3XgWHGcj4amjgghiLW5411oVgmp+KotzJnEmbbtl9dJvT580db2TnJTgNl
        yjIpL6N6FAMWtV5UfpyTeTHgNX4GWXwZTSD4z5b0FMr/vuvmiJV44Ofw/ZsRk8FuvN7R8n
        03mfap+9tv5pVcxSc2dF4cDaaoyIwvQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-iVS-vYIFO2CGM-WfXn9xhw-1; Sun, 03 Apr 2022 11:40:00 -0400
X-MC-Unique: iVS-vYIFO2CGM-WfXn9xhw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC5CB2999B23;
        Sun,  3 Apr 2022 15:39:59 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B66F9403172;
        Sun,  3 Apr 2022 15:39:53 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 04/18] KVM: arm64: Support SDEI_EVENT_REGISTER hypercall
Date:   Sun,  3 Apr 2022 23:38:57 +0800
Message-Id: <20220403153911.12332-5-gshan@redhat.com>
In-Reply-To: <20220403153911.12332-1-gshan@redhat.com>
References: <20220403153911.12332-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_REGISTER hypercall, which is used by guest
to register event. The event won't be raised until it's registered
and enabled. For those KVM owned events, they can't be registered
if they aren't exposed.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 78 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 3507e33ec00e..89c1b231cb60 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -25,6 +25,81 @@ static struct kvm_sdei_exposed_event exposed_events[] = {
 	for (idx = 0, event = &exposed_events[0];	\
 	     idx < ARRAY_SIZE(exposed_events);		\
 	     idx++, event++)
+#define kvm_sdei_for_each_event(vsdei, event, idx)	\
+	for (idx = 0, event = &vsdei->events[0];	\
+	     idx < ARRAY_SIZE(exposed_events);		\
+	     idx++, event++)
+
+static struct kvm_sdei_event *find_event(struct kvm_vcpu *vcpu,
+					 unsigned int num)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *event;
+	int i;
+
+	kvm_sdei_for_each_event(vsdei, event, i) {
+		if (event->exposed_event->num == num)
+			return event;
+	}
+
+	return NULL;
+}
+
+static unsigned long hypercall_register(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *event;
+	unsigned int num = smccc_get_arg(vcpu, 1);
+	unsigned long ep_address = smccc_get_arg(vcpu, 2);
+	unsigned long ep_arg = smccc_get_arg(vcpu, 3);
+	unsigned long route_mode = smccc_get_arg(vcpu, 4);
+	unsigned long route_affinity = smccc_get_arg(vcpu, 5);
+	unsigned long ret = SDEI_SUCCESS;
+
+	if (!kvm_sdei_is_supported(num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	if (route_mode != SDEI_EVENT_REGISTER_RM_ANY &&
+	    route_mode != SDEI_EVENT_REGISTER_RM_PE) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	spin_lock(&vsdei->lock);
+
+	/*
+	 * The event should have been existing. Otherwise, the event
+	 * isn't exposed yet.
+	 */
+	event = find_event(vcpu, num);
+	if (!event) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/*
+	 * Check if the event has been registered or pending for
+	 * unregistration.
+	 */
+	if (kvm_sdei_is_registered(event) ||
+	    kvm_sdei_is_unregister_pending(event)) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	event->route_mode     = route_mode;
+	event->route_affinity = route_affinity;
+	event->ep_address     = ep_address;
+	event->ep_arg         = ep_arg;
+	kvm_sdei_set_registered(event);
+
+unlock:
+	spin_unlock(&vsdei->lock);
+out:
+	return ret;
+}
 
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
@@ -47,6 +122,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	}
 
 	switch (func) {
+	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
+		ret = hypercall_register(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

