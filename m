Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314C8535B00
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348673AbiE0IEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348803AbiE0IEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDFA1FD37A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSmHChhkeGhveeNkT0xXj48o/ZM3uoGgnCvlBhi+Jhs=;
        b=d1qOsHqUhIPPTLPRx02nn35nb+HaeqBhC0XSRGZ5xCgsG15tWQO2pRCzyZpC3DQgjepPG4
        WVvuK7NL0H+mSYrflKNdVN1NXKFtJoqMKpBuUUMJBKovn6Ulz+zpOLLoooodFF3/08Gr8N
        GPwNaH/tFx7c97oM1VwnMg+QWHCbBQg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-0jWaW6A2OoOHPARON6hnyQ-1; Fri, 27 May 2022 04:04:25 -0400
X-MC-Unique: 0jWaW6A2OoOHPARON6hnyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1E26858F0C;
        Fri, 27 May 2022 08:04:24 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3DA62026D64;
        Fri, 27 May 2022 08:04:14 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 05/22] KVM: arm64: Support EVENT_{ENABLE, DISABLE} hypercall
Date:   Fri, 27 May 2022 16:02:36 +0800
Message-Id: <20220527080253.1562538-6-gshan@redhat.com>
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

This supports EVENT_{ENABLE, DISABLE} hypercall. The event can be
pending, but never be delivered to guest until it's enabled.

  * The request is rejected if the event isn't registered or pending
    for unregistration.

  * When the event is enabled, KVM_REQ_SDEI is set to so that the
    event can be delivered to guest, if it has been pending. The
    delivery logic will be implemented in subsequent patches. For
    now, it's nothing other than a flag.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/sdei.c             | 33 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index c9d053c2569e..79a0043a908c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -47,6 +47,7 @@
 #define KVM_REQ_RELOAD_GICv4	KVM_ARCH_REQ(4)
 #define KVM_REQ_RELOAD_PMU	KVM_ARCH_REQ(5)
 #define KVM_REQ_SUSPEND		KVM_ARCH_REQ(6)
+#define KVM_REQ_SDEI		KVM_ARCH_REQ(7)
 
 #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 				     KVM_DIRTY_LOG_INITIALLY_SET)
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 40c2d585470d..a4046e7b21d8 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -41,6 +41,33 @@ static unsigned long event_register(struct kvm_vcpu *vcpu)
 	return SDEI_SUCCESS;
 }
 
+static unsigned long event_enable(struct kvm_vcpu *vcpu, bool enable)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned int num = smccc_get_arg(vcpu, 1);
+
+	if (num >= KVM_NR_SDEI_EVENTS)
+		return SDEI_INVALID_PARAMETERS;
+
+	/*
+	 * Reject if the event hasn't been registered or pending
+	 * for unregistration.
+	 */
+	if (!test_bit(num, &vsdei->registered))
+		return SDEI_DENIED;
+
+	if (enable) {
+		set_bit(num, &vsdei->enabled);
+		if (!(vcpu->arch.flags & KVM_ARM64_SDEI_MASKED) &&
+		    test_bit(num, &vsdei->pending))
+			kvm_make_request(KVM_REQ_SDEI, vcpu);
+	} else {
+		clear_bit(num, &vsdei->enabled);
+	}
+
+	return SDEI_SUCCESS;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -62,6 +89,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
 		ret = event_register(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
+		ret = event_enable(vcpu, true);
+		break;
+	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
+		ret = event_enable(vcpu, false);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

