Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33FA4F0ADD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359281AbiDCPn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359332AbiDCPnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DA812DD61
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrMW1GidvsPmhW46oQQCOc/ckEuxqUmXOy5/nPzOjBY=;
        b=BRFFoZ+iMFZ+w6nl6kdHwD18hEuA56/qL52PApnu46QYLjklYCeXs8f86/0JDdXqPREiGC
        alznjde/5SWBTuRUs6+a8F5wJjjJfOZYHtoCqpd1CJAIcR8IYe/bl9oTLF1eJxsrPgCpqt
        qK9eYXFUKpcz7rUqB+KXhoZb0dViujY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-JnseUGxkPz2hLf1dmAnbPw-1; Sun, 03 Apr 2022 11:41:08 -0400
X-MC-Unique: JnseUGxkPz2hLf1dmAnbPw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B58303811A20;
        Sun,  3 Apr 2022 15:41:07 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7682403172;
        Sun,  3 Apr 2022 15:41:01 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 14/18] KVM: arm64: Support SDEI_EVENT_SIGNAL hypercall
Date:   Sun,  3 Apr 2022 23:39:07 +0800
Message-Id: <20220403153911.12332-15-gshan@redhat.com>
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

This supports SDEI_EVENT_SIGNAL hypercall. It's used by guest
to inject event, whose number must be zero to the specified
vCPU. As the shared event isn't supported, calling vCPU is
assumed to be the target.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index ebdbe7810cf0..e1f6ab9800ee 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -455,6 +455,48 @@ static unsigned long hypercall_mask(struct kvm_vcpu *vcpu, bool mask)
 	return ret;
 }
 
+static unsigned long hypercall_signal(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *event;
+	unsigned int num = smccc_get_arg(vcpu, 1);
+	unsigned long ret = SDEI_SUCCESS;
+
+	/*
+	 * The event must be the software signaled one, whose number
+	 * is zero.
+	 */
+	if (!kvm_sdei_is_sw_signaled(num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	spin_lock(&vsdei->lock);
+
+	/* Check if the vcpu has been masked */
+	if (vsdei->masked) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	/* Check if the event exists */
+	event = find_event(vcpu, num);
+	if (!event) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+	if (inject_event(vcpu, event)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto unlock;
+	}
+
+unlock:
+	spin_unlock(&vsdei->lock);
+out:
+	return ret;
+}
+
 static unsigned long hypercall_reset(struct kvm_vcpu *vcpu, bool private)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -539,6 +581,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
 		ret = hypercall_mask(vcpu, false);
 		break;
+	case SDEI_1_1_FN_SDEI_EVENT_SIGNAL:
+		ret = hypercall_signal(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
 		ret = hypercall_reset(vcpu, true);
 		break;
-- 
2.23.0

