Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D30535B21
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbiE0IGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349542AbiE0IGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75BA51059CB
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1oE6zW708ThGzA9gQNSKRACZxEySOeeS7EX47PV2eQ=;
        b=NVbmhFZS7DusoOmiB19RK8U/0orpvUVjFhskHH2bvBZbB/q+ZYyDPQHiN+dXToQBHmq1vd
        zKPxQeNqvvaq90FpcNM61plAxOq9LVMEDkiHNa89uMzzpZqwpN8DE0g5IKxYCjp3v5AH8u
        /16v8NA+V8oBzXfbLcoWGNGiUEBqibc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-JYmtOss3NKWCf39IZ3uN1w-1; Fri, 27 May 2022 04:05:58 -0400
X-MC-Unique: JYmtOss3NKWCf39IZ3uN1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C53E2949BA6;
        Fri, 27 May 2022 08:05:57 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4D7C2026D07;
        Fri, 27 May 2022 08:05:50 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 16/22] KVM: arm64: Support SDEI_VERSION hypercall
Date:   Fri, 27 May 2022 16:02:47 +0800
Message-Id: <20220527080253.1562538-17-gshan@redhat.com>
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

This supports SDEI_VERSION hypercall by returning v1.1, which is
the specification version we're following. The vendor is set to
one of the values returned from ARM_SMCCC_VENDOR_HYP_CALL_UID
hypercall.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kvm_sdei.h |  3 +++
 arch/arm64/kvm/sdei.c             | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index 735d9ac1a5a2..a1e960943515 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -62,6 +62,9 @@ struct kvm_sdei_vcpu {
 	struct kvm_sdei_event_context	ctxt;
 };
 
+/* Returned as vendor through SDEI_VERSION hypercall */
+#define KVM_SDEI_VENDOR	ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2
+
 /* APIs */
 int kvm_sdei_call(struct kvm_vcpu *vcpu);
 int kvm_sdei_inject_event(struct kvm_vcpu *vcpu,
diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index d295f84f6940..f95b9bcce13c 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -13,6 +13,14 @@
 #include <kvm/arm_hypercalls.h>
 #include <asm/kvm_sdei.h>
 
+static unsigned long sdei_version(struct kvm_vcpu *vcpu)
+{
+	/* v1.1 and vendor ID */
+	return (1UL << SDEI_VERSION_MAJOR_SHIFT) |
+	       (1UL << SDEI_VERSION_MINOR_SHIFT) |
+	       KVM_SDEI_VENDOR;
+}
+
 static unsigned long event_register(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -308,6 +316,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	}
 
 	switch (func) {
+	case SDEI_1_0_FN_SDEI_VERSION:
+		ret = sdei_version(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
 		ret = event_register(vcpu);
 		break;
-- 
2.23.0

