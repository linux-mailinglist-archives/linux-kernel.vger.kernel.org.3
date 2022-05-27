Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3B535B08
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349053AbiE0IFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244703AbiE0IEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3417FF592
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=329kwVYlUvTHO0LeA/plITFrudtBaaBxKIDFkDJlGH8=;
        b=FkVvh/Cz+klKl0bBbWL+d8VwyMJLgHG+2q8s68T6StDD4BqxjS3Eaf/NMrgsc0V3eFzhdJ
        uwjvQ83cOOJp90xZjJ7+xOPcW4BfV8+NA1x6Os9wFfe/ElrMS/0R1IxGpiRexIOOFOwrD6
        btkPEgZW2FF4d+n6uhe4odQI+UKlpV0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-dMEdTzJWOrCpZMOLi9hD9A-1; Fri, 27 May 2022 04:04:41 -0400
X-MC-Unique: dMEdTzJWOrCpZMOLi9hD9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2FAD811E76;
        Fri, 27 May 2022 08:04:40 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87E762026D64;
        Fri, 27 May 2022 08:04:34 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 07/22] KVM: arm64: Support EVENT_UNREGISTER hypercall
Date:   Fri, 27 May 2022 16:02:38 +0800
Message-Id: <20220527080253.1562538-8-gshan@redhat.com>
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

This supports EVENT_UNREGISTER hypercall. No event will be delivered
to guest after it's unregistered.

  * Reject if the event hasn't been registered.

  * Return SDEI_PENDING if the event handler is running.

  * The event is disabled automatically on unregistration.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 2fec2dcd02b0..b44ab302732d 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -85,6 +85,39 @@ static unsigned long event_context(struct kvm_vcpu *vcpu)
 	return ctxt->regs[param_id];
 }
 
+static unsigned long event_unregister(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned int num = smccc_get_arg(vcpu, 1);
+
+	if (num >= KVM_NR_SDEI_EVENTS)
+		return SDEI_INVALID_PARAMETERS;
+
+	/*
+	 * Reject if the event isn't registered. It's allowed to
+	 * unregister event which has been pending for that.
+	 */
+	if (!test_bit(num, &vsdei->registered)) {
+		if (test_bit(num, &vsdei->running))
+			return SDEI_PENDING;
+		else
+			return SDEI_DENIED;
+	}
+
+	/*
+	 * The event is disabled automatically on unregistration, even
+	 * pending for that.
+	 */
+	clear_bit(num, &vsdei->enabled);
+	clear_bit(num, &vsdei->registered);
+
+	/* Pending for unreigstration if the event handler is running */
+	if (test_bit(num, &vsdei->running))
+		return SDEI_PENDING;
+
+	return SDEI_SUCCESS;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -115,6 +148,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
 		ret = event_context(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
+		ret = event_unregister(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

