Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EF2535B23
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiE0IG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349538AbiE0IFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38C5E104CB3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CfhejkXuPa7WByuloODhCqAxTblZ1S6BbTJI/JlxSk=;
        b=H4TxWfSTloVWg5uz34FyZyE4oq/Xei6kkoW0QEGnOW5bSLUrkbAIZsv8GWjcmQjjWQa1Ac
        GG9LoUogh2grYaYKFPJzr4K7tAkJf/yzMNDsQGE3nhxs0mKk6hkdvEY0deIlVO2TdvppyX
        VbcQcSzfaGug5LVCUjXkHqIB1i7XcDo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-9XtA_8I5PWyJEkWbwAHphQ-1; Fri, 27 May 2022 04:05:41 -0400
X-MC-Unique: 9XtA_8I5PWyJEkWbwAHphQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B34B1C161B3;
        Fri, 27 May 2022 08:05:41 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7D442026D64;
        Fri, 27 May 2022 08:05:30 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 14/22] KVM: arm64: Support EVENT_SIGNAL hypercall
Date:   Fri, 27 May 2022 16:02:45 +0800
Message-Id: <20220527080253.1562538-15-gshan@redhat.com>
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

This supports EVENT_SIGNAL hypercall. It's used to inject the
software signaled event, whose number is zero. The KVM_REQ_SDEI
request is raised if the PE is unmasked and the event has been
enabled.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c         | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/arm_sdei.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 0bea1b2f9452..a55797fce06a 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -232,6 +232,31 @@ static unsigned long pe_mask(struct kvm_vcpu *vcpu, bool mask)
 	return SDEI_SUCCESS;
 }
 
+static unsigned long event_signal(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned int num = smccc_get_arg(vcpu, 1);
+
+	if (num >= KVM_NR_SDEI_EVENTS)
+		return SDEI_INVALID_PARAMETERS;
+
+	/*
+	 * The event must be software signaled event, whose
+	 * number is zero.
+	 */
+	if (num != SDEI_SW_SIGNALED_EVENT ||
+	    !test_bit(num, &vsdei->registered))
+		return SDEI_INVALID_PARAMETERS;
+
+	if (!test_and_set_bit(num, &vsdei->pending)) {
+		if (!(vcpu->arch.flags & KVM_ARM64_SDEI_MASKED) &&
+		    test_bit(num, &vsdei->enabled))
+			kvm_make_request(KVM_REQ_SDEI, vcpu);
+	}
+
+	return SDEI_SUCCESS;
+}
+
 static unsigned long event_reset(struct kvm_vcpu *vcpu, bool private)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -303,6 +328,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
 		ret = pe_mask(vcpu, false);
 		break;
+	case SDEI_1_1_FN_SDEI_EVENT_SIGNAL:
+		ret = event_signal(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
 		ret = event_reset(vcpu, true);
 		break;
diff --git a/include/uapi/linux/arm_sdei.h b/include/uapi/linux/arm_sdei.h
index af0630ba5437..72b07114bbfa 100644
--- a/include/uapi/linux/arm_sdei.h
+++ b/include/uapi/linux/arm_sdei.h
@@ -22,9 +22,12 @@
 #define SDEI_1_0_FN_SDEI_PE_UNMASK			SDEI_1_0_FN(0x0C)
 #define SDEI_1_0_FN_SDEI_INTERRUPT_BIND			SDEI_1_0_FN(0x0D)
 #define SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE		SDEI_1_0_FN(0x0E)
+#define SDEI_1_1_FN_SDEI_EVENT_SIGNAL			SDEI_1_0_FN(0x0F)
 #define SDEI_1_0_FN_SDEI_PRIVATE_RESET			SDEI_1_0_FN(0x11)
 #define SDEI_1_0_FN_SDEI_SHARED_RESET			SDEI_1_0_FN(0x12)
 
+#define SDEI_SW_SIGNALED_EVENT		0
+
 #define SDEI_VERSION_MAJOR_SHIFT			48
 #define SDEI_VERSION_MAJOR_MASK				0x7fff
 #define SDEI_VERSION_MINOR_SHIFT			32
-- 
2.23.0

