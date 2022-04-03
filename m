Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0234F0ACA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359253AbiDCPmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359249AbiDCPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:42:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B4D82DD73
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPJ7EOqeZUrySKOLSIq4ZqIIqhcyL/M32ntmRWvplbQ=;
        b=dMQWb96ZDyJpI8IW58ibBSA3JrWpYqxslDT28NZ1mLnhsgkXQocPSWHlNdH7UljrlxEpnq
        e1yw1iM2Wynw2MKAqOjEXB18+vbxt+nX4ioDe72ihbXy4ZDmR9fgLzanFZsJ104Xk2qMOm
        1Ns+sIHiZIy++Lb7Wz0VVhopy/xOOy8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-Hrln5-3WPI-AnSeRkhAVAQ-1; Sun, 03 Apr 2022 11:40:34 -0400
X-MC-Unique: Hrln5-3WPI-AnSeRkhAVAQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC6AF82A6C2;
        Sun,  3 Apr 2022 15:40:33 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CE004538D7;
        Sun,  3 Apr 2022 15:40:27 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 09/18] KVM: arm64: Support SDEI_EVENT_GET_INFO hypercall
Date:   Sun,  3 Apr 2022 23:39:02 +0800
Message-Id: <20220403153911.12332-10-gshan@redhat.com>
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

This supports SDEI_EVENT_GET_INFO hypercall. It's used by guest
to retrieve various information about the event: type, signaled,
priority, routing mode and affinity. SDEI_INVALID_PARAMETERS is
returned for the requests about routing mode and affinity as
they are only valid for the shared event, which isn't supported.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index b847c6028b74..9e642d01e303 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -289,6 +289,57 @@ static unsigned long hypercall_status(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long hypercall_info(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_exposed_event *exposed_event;
+	struct kvm_sdei_event *event;
+	unsigned int num = smccc_get_arg(vcpu, 1);
+	unsigned long info = smccc_get_arg(vcpu, 2);
+	unsigned long ret = SDEI_SUCCESS;
+
+	if (!kvm_sdei_is_supported(num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
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
+	/*
+	 * Retrieve the requested information. The shared events aren't
+	 * supported yet. So the requests to retrieve routing mode and
+	 * affinity should fail for now.
+	 */
+	exposed_event = event->exposed_event;
+	switch (info) {
+	case SDEI_EVENT_INFO_EV_TYPE:
+		ret = exposed_event->type;
+		break;
+	case SDEI_EVENT_INFO_EV_SIGNALED:
+		ret = exposed_event->signaled;
+		break;
+	case SDEI_EVENT_INFO_EV_PRIORITY:
+		ret = exposed_event->priority;
+		break;
+	case SDEI_EVENT_INFO_EV_ROUTING_MODE:
+	case SDEI_EVENT_INFO_EV_ROUTING_AFF:
+	default:
+		ret = SDEI_INVALID_PARAMETERS;
+	}
+
+unlock:
+	spin_unlock(&vsdei->lock);
+out:
+	return ret;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -328,6 +379,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
 		ret = hypercall_status(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
+		ret = hypercall_info(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

