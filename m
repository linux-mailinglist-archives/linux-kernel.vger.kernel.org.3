Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B234F0AC1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359219AbiDCPmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiDCPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4355127CE2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hOAckF7XE+z1BmKgQieJWiGjz7ieZRtxUaQvoClm23s=;
        b=BKC8XrUIQ/zNur+IL8Awk0tTmDZ07xtP/M5lvictopVbQnSHJqosh0ImvUHZIaSKgZZR0O
        AS/gdd76bw/uIuRchraMR1/PNNe1Pp7521cECaS4/Qki1hZZA2EoOyQK4WCVdm14u8NAMg
        kxP+gT0d8w/2QL43UhxBOL3IrN2WySw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-XbBqwpsSMZazJ7r2LOKjjg-1; Sun, 03 Apr 2022 11:40:14 -0400
X-MC-Unique: XbBqwpsSMZazJ7r2LOKjjg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67501811E7A;
        Sun,  3 Apr 2022 15:40:13 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CA54403172;
        Sun,  3 Apr 2022 15:40:06 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 06/18] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
Date:   Sun,  3 Apr 2022 23:38:59 +0800
Message-Id: <20220403153911.12332-7-gshan@redhat.com>
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

This supports SDEI_EVENT_CONTEXT hypercall. It's used by the guest
to retrieve the registers (x0 - x17) from the interrupted or preempted
context in the event handler. The interrupted or preempted context
is saved prior to handling the event by executing its handler and
restored after that.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 941263578b30..af5d11b8eb2f 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -140,6 +140,37 @@ static unsigned long hypercall_enable(struct kvm_vcpu *vcpu, bool enable)
 	return ret;
 }
 
+static unsigned long hypercall_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_context *context;
+	unsigned long param_id = smccc_get_arg(vcpu, 1);
+	unsigned long ret = SDEI_SUCCESS;
+
+	spin_lock(&vsdei->lock);
+
+	/* Check if we have events are being handled */
+	context = &vsdei->context[SDEI_EVENT_PRIORITY_CRITICAL];
+	context = context->event ? context : NULL;
+	context = context ? : &vsdei->context[SDEI_EVENT_PRIORITY_NORMAL];
+	context = context->event ? context : NULL;
+	if (!context) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Fetch the requested register */
+	if (param_id < ARRAY_SIZE(context->regs))
+		ret = context->regs[param_id];
+	else
+		ret = SDEI_INVALID_PARAMETERS;
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
@@ -170,6 +201,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
 		ret = hypercall_enable(vcpu, false);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
+		ret = hypercall_context(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

