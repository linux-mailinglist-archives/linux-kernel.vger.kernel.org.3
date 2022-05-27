Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F264535B1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbiE0IGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349397AbiE0IG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5314106544
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twZ0Ps5QlQoExjMaYnRuFi/0acFN9mberGquMbJnVlw=;
        b=VV8mrSTQ/ux+kZcJ9Irozp2D8/P4skWVDK/cdaFpc1VH989VNvNTic5DdPKmhqY/oe5klz
        MyfZlCapAuoAwGjIyMG6NbLrTYSgTvUgdghgp1Ln0lMi3FlIJCZbGY0RVVlJsqNRHfjZvA
        FAL7IQ3z1g7peB7CEPl1rcd7xOvWML8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-dHQJq2LSP2WXZWUR_i_Jmw-1; Fri, 27 May 2022 04:06:05 -0400
X-MC-Unique: dHQJq2LSP2WXZWUR_i_Jmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACF59858EEE;
        Fri, 27 May 2022 08:06:04 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 279CC2026D64;
        Fri, 27 May 2022 08:05:57 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 17/22] KVM: arm64: Expose SDEI capbility and service
Date:   Fri, 27 May 2022 16:02:48 +0800
Message-Id: <20220527080253.1562538-18-gshan@redhat.com>
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

The SDEI functionality is ready and lets exposes the capability
and service.

  * KVM_CAP_ARM_SDEI

  * KVM_REG_ARM_STD_BIT_SDEI in pseudo-firmware bitmap register
    KVM_REG_ARM_STD_BMAP

  * The events for software signaled one (0x0) and Async PF (0x1)
    are exposed.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 Documentation/virt/kvm/api.rst            | 11 +++++++++++
 Documentation/virt/kvm/arm/hypercalls.rst |  4 ++++
 arch/arm64/include/asm/kvm_sdei.h         |  2 ++
 arch/arm64/include/uapi/asm/kvm.h         |  1 +
 arch/arm64/kvm/arm.c                      |  1 +
 arch/arm64/kvm/hypercalls.c               |  4 ++++
 include/uapi/linux/kvm.h                  |  1 +
 7 files changed, 24 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 11e00a46c610..011ec0987d71 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7956,6 +7956,17 @@ should adjust CPUID leaf 0xA to reflect that the PMU is disabled.
 When enabled, KVM will exit to userspace with KVM_EXIT_SYSTEM_EVENT of
 type KVM_SYSTEM_EVENT_SUSPEND to process the guest suspend request.
 
+8.37 KVM_CAP_ARM_SDEI
+---------------------
+
+:Capability: KVM_CAP_ARM_SDEI
+:Architectures: arm64
+:Type: vm
+
+This capability indicates that the SDEI virtual service is supported
+in the host. A VMM can check whether the service is available to enable
+it.
+
 9. Known KVM API problems
 =========================
 
diff --git a/Documentation/virt/kvm/arm/hypercalls.rst b/Documentation/virt/kvm/arm/hypercalls.rst
index 3e23084644ba..8b8159988934 100644
--- a/Documentation/virt/kvm/arm/hypercalls.rst
+++ b/Documentation/virt/kvm/arm/hypercalls.rst
@@ -106,6 +106,10 @@ The pseudo-firmware bitmap register are as follows:
       The bit represents the services offered under v1.0 of ARM True Random
       Number Generator (TRNG) specification, ARM DEN0098.
 
+    Bit-1: KVM_REG_ARM_STD_BIT_SDEI:
+      The bit represents the services offered under v1.1 of ARM Software
+      Delegated Exception Interface (SDEI) specification, ARM DEN0054C.
+
 * KVM_REG_ARM_STD_HYP_BMAP:
     Controls the bitmap of the ARM Standard Hypervisor Service Calls.
 
diff --git a/arch/arm64/include/asm/kvm_sdei.h b/arch/arm64/include/asm/kvm_sdei.h
index a1e960943515..a68d40137a88 100644
--- a/arch/arm64/include/asm/kvm_sdei.h
+++ b/arch/arm64/include/asm/kvm_sdei.h
@@ -15,6 +15,8 @@
 #include <linux/bits.h>
 
 enum {
+	KVM_SDEI_EVENT_SW_SIGNALED = 0,
+	KVM_SDEI_EVENT_ASYNC_PF,
 	KVM_NR_SDEI_EVENTS,
 };
 
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 3bb134355874..cc3251381960 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -344,6 +344,7 @@ struct kvm_arm_copy_mte_tags {
 
 enum {
 	KVM_REG_ARM_STD_BIT_TRNG_V1_0	= 0,
+	KVM_REG_ARM_STD_BIT_SDEI,
 #ifdef __KERNEL__
 	KVM_REG_ARM_STD_BMAP_BIT_COUNT,
 #endif
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 06cb5e38634e..15ead92ad26d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -217,6 +217,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VCPU_ATTRIBUTES:
 	case KVM_CAP_PTP_KVM:
 	case KVM_CAP_ARM_SYSTEM_SUSPEND:
+	case KVM_CAP_ARM_SDEI:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 88561ac47301..aaa5197ffe83 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -99,6 +99,10 @@ static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func)
 	struct kvm_smccc_features *smccc_feat = &vcpu->kvm->arch.smccc_feat;
 
 	switch (func) {
+	case SDEI_1_0_FN(ARM_SMCCC_STANDARD_SDEI_START - 0x20) ...
+	     SDEI_1_0_FN(ARM_SMCCC_STANDARD_SDEI_END - 0x20):
+		return test_bit(KVM_REG_ARM_STD_BIT_SDEI,
+				&smccc_feat->std_bmap);
 	case ARM_SMCCC_TRNG_VERSION:
 	case ARM_SMCCC_TRNG_FEATURES:
 	case ARM_SMCCC_TRNG_GET_UUID:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 5088bd9f1922..65622bcaeec3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1157,6 +1157,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_VM_TSC_CONTROL 214
 #define KVM_CAP_SYSTEM_EVENT_DATA 215
 #define KVM_CAP_ARM_SYSTEM_SUSPEND 216
+#define KVM_CAP_ARM_SDEI 217
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.23.0

