Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9BB4F0AC3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359223AbiDCPmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359220AbiDCPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA8FD29CA2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pn4EoSXxKWdxPpq8ePbbzOyFgR8TeWIqlRshEfr0Kec=;
        b=i3UeHaeF73EdvyybK/HN6yoq4OigSLxOEWHa78Ce8GJQEI1U4Hr+YzJ5T+ubywtbl8DFHq
        jTI5ZrY+tPu6yXBvpVbraXLqoCXDhNbrgvR8rysHjPVXRhlirS7TU2pTo/C5UzQRDv5W3Z
        dkkzhCmpTqf3kq00gy5Tk65pPjMKu3o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-KkgMQLitNuywmJgU6GIQKw-1; Sun, 03 Apr 2022 11:40:20 -0400
X-MC-Unique: KkgMQLitNuywmJgU6GIQKw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CFE385A5A8;
        Sun,  3 Apr 2022 15:40:20 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E99B4538D7;
        Sun,  3 Apr 2022 15:40:13 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 07/18] KVM: arm64: Support SDEI_EVENT_UNREGISTER hypercall
Date:   Sun,  3 Apr 2022 23:39:00 +0800
Message-Id: <20220403153911.12332-8-gshan@redhat.com>
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

This supports SDEI_EVENT_UNREGISTER hypercall. It's used by the
guest to unregister event. The event is disabled automatically
and won't be delivered to guest after unregistration.

If the event is being serviced or handled, we can't unregister
it immediately. Instead, the unregistration pending state is
set for the event and it's unregistered when the event handler
is to finish by calling SDEI_EVENT_{COMPLETE, COMPLETE_AND_RESUME}
hypercall.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index af5d11b8eb2f..f774f2cf0ac7 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -45,6 +45,48 @@ static struct kvm_sdei_event *find_event(struct kvm_vcpu *vcpu,
 	return NULL;
 }
 
+static int reset_event(struct kvm_vcpu *vcpu,
+		       struct kvm_sdei_event *event)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_context *context;
+	struct kvm_sdei_exposed_event *exposed_event;
+
+	/* Check if the event has been pending for unregistration */
+	if (kvm_sdei_is_unregister_pending(event))
+		return -EAGAIN;
+
+	/*
+	 * If the event is being handled, we should set the unregistration
+	 * pending state for it. The event will be unregistered after the
+	 * event handler is to finish.
+	 */
+	exposed_event = event->exposed_event;
+	context = kvm_sdei_is_critical(exposed_event->priority) ?
+		  &vsdei->context[SDEI_EVENT_PRIORITY_CRITICAL] :
+		  &vsdei->context[SDEI_EVENT_PRIORITY_NORMAL];
+	if (context->event == event) {
+		kvm_sdei_set_unregister_pending(event);
+		return -EBUSY;
+	}
+
+	/*
+	 * The event is ready to be unregistered. The event is disabled
+	 * when it's unregistered. The pending events should be cancelled
+	 * either.
+	 */
+	if (kvm_sdei_is_critical(exposed_event->priority))
+		vsdei->critical_event_count -= event->event_count;
+	else
+		vsdei->normal_event_count -= event->event_count;
+
+	event->event_count = 0;
+	kvm_sdei_clear_enabled(event);
+	kvm_sdei_clear_registered(event);
+
+	return 0;
+}
+
 static unsigned long hypercall_register(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -171,6 +213,40 @@ static unsigned long hypercall_context(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long hypercall_unregister(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *event;
+	unsigned int num = smccc_get_arg(vcpu, 1);
+	unsigned long ret = SDEI_SUCCESS;
+
+	if (!kvm_sdei_is_supported(num))
+		return SDEI_INVALID_PARAMETERS;
+
+	spin_lock(&vsdei->lock);
+
+	/* Check if the event exists */
+	event = find_event(vcpu, num);
+	if (!event) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Check if the event has been registered */
+	if (!kvm_sdei_is_registered(event)) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	if (reset_event(vcpu, event))
+		ret = SDEI_PENDING;
+
+unlock:
+	spin_unlock(&vsdei->lock);
+
+	return ret;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -204,6 +280,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
 		ret = hypercall_context(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
+		ret = hypercall_unregister(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

