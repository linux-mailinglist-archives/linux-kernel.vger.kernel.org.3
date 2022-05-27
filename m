Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA68F535B26
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbiE0IGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349535AbiE0IGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED5EA1053F4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7pKbXrqucn/sAmVex4c4gIiaSEBPmDw6Y4/7YpC/zI=;
        b=ZkIKNXEia24jGWMVGmqRv6Lnr4mDbWV6zjWlcrESE+IA982gOLHaUTx966fHImuBFQwPSx
        6S4EgLJq9Kj5X8xJJ1QQ+BmTVBaEMNiVdRDNQNHC4OzztEuQddlaUyCuEh8om5t1FjeHDr
        sRYxbbsSRBXLx1VGknLoIO/opu4YpEo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-F2akXvRUPUS7TCab-24vaQ-1; Fri, 27 May 2022 04:05:55 -0400
X-MC-Unique: F2akXvRUPUS7TCab-24vaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB6403804509;
        Fri, 27 May 2022 08:05:49 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27ABD2026D64;
        Fri, 27 May 2022 08:05:41 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 15/22] KVM: arm64: Support SDEI_FEATURES hypercall
Date:   Fri, 27 May 2022 16:02:46 +0800
Message-Id: <20220527080253.1562538-16-gshan@redhat.com>
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

This supports SDEI_FEATURES hypercall. It's used to retrieve the
supported features, including number of slots for the interrupt
binding events and relative mode for event handler. Currently,
we simply return zero, meaning none of them is supported.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c         | 16 ++++++++++++++++
 include/uapi/linux/arm_sdei.h |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index a55797fce06a..d295f84f6940 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -277,6 +277,19 @@ static unsigned long event_reset(struct kvm_vcpu *vcpu, bool private)
 	return SDEI_SUCCESS;
 }
 
+static unsigned long sdei_features(struct kvm_vcpu *vcpu)
+{
+	unsigned int feature = smccc_get_arg(vcpu, 1);
+
+	switch (feature) {
+	case SDEI_FEATURE_BIND_SLOTS:
+	case SDEI_FEATURE_RELATIVE_MODE:
+		return 0;
+	}
+
+	return SDEI_INVALID_PARAMETERS;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -337,6 +350,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_SHARED_RESET:
 		ret = event_reset(vcpu, false);
 		break;
+	case SDEI_1_1_FN_SDEI_FEATURES:
+		ret = sdei_features(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
diff --git a/include/uapi/linux/arm_sdei.h b/include/uapi/linux/arm_sdei.h
index 72b07114bbfa..5b783cc64617 100644
--- a/include/uapi/linux/arm_sdei.h
+++ b/include/uapi/linux/arm_sdei.h
@@ -23,6 +23,7 @@
 #define SDEI_1_0_FN_SDEI_INTERRUPT_BIND			SDEI_1_0_FN(0x0D)
 #define SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE		SDEI_1_0_FN(0x0E)
 #define SDEI_1_1_FN_SDEI_EVENT_SIGNAL			SDEI_1_0_FN(0x0F)
+#define SDEI_1_1_FN_SDEI_FEATURES			SDEI_1_0_FN(0x10)
 #define SDEI_1_0_FN_SDEI_PRIVATE_RESET			SDEI_1_0_FN(0x11)
 #define SDEI_1_0_FN_SDEI_SHARED_RESET			SDEI_1_0_FN(0x12)
 
@@ -73,4 +74,8 @@
 #define SDEI_EVENT_PRIORITY_NORMAL		0
 #define SDEI_EVENT_PRIORITY_CRITICAL		1
 
+/* SDEI_FEATURES */
+#define SDEI_FEATURE_BIND_SLOTS			0
+#define SDEI_FEATURE_RELATIVE_MODE		1
+
 #endif /* _UAPI_LINUX_ARM_SDEI_H */
-- 
2.23.0

