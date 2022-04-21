Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A83509686
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384412AbiDUFS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384363AbiDUFQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A47A213D59
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650518033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TE0/IyhbX+PJJtmqWsYqEi/mVebhKn0u1Uz64oTynUA=;
        b=DPvYTjKjOQqc7bYknPx+lcT0djp2xTE4Q2pRoYENN7C+SF/Ws+JaYdDDbaiBZDc1NZEMmX
        +xBuios5lhZSx2NZO+Us8uvqh+H6pAtInmQNxnheqxzLLxKKeZUOXdhauoCCYlgZVnPdc1
        t0HfqGsK9zWMB4AyRcY1no0UtDZlMJM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-BwterifsOBidoQRuIu9gkQ-1; Thu, 21 Apr 2022 01:13:50 -0400
X-MC-Unique: BwterifsOBidoQRuIu9gkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DC1A80005D;
        Thu, 21 Apr 2022 05:13:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CEB1145BA5A;
        Thu, 21 Apr 2022 05:13:43 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [RFC PATCH v2 10/10] KVM: SVM: allow to avoid not needed updates to is_running
Date:   Thu, 21 Apr 2022 08:12:44 +0300
Message-Id: <20220421051244.187733-11-mlevitsk@redhat.com>
In-Reply-To: <20220421051244.187733-1-mlevitsk@redhat.com>
References: <20220421051244.187733-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow optionally to make KVM not update is_running unless it is
functionally needed which is only when a vCPU halts,
or is in the guest mode.

This means security wise that if a vCPU is scheduled out,
other vCPUs could still send doorbell messages to the
last physical CPU where this vCPU was last running.

If a malicious guest tries to do it can slow down
the victim CPU by about 40% in my testing, so this
should only be enabled if physical CPUs are not shared
among guests.

The option is avic_doorbell_strict and is true by
default, setting it to false allows this relaxed
non strict mode.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 19 ++++++++++++-------
 arch/x86/kvm/svm/svm.c  | 19 ++++++++++++++-----
 arch/x86/kvm/svm/svm.h  |  1 +
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 9176c35662ada..1bfe58ee961b2 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1641,7 +1641,7 @@ avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
 
 void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	u64 entry;
+	u64 old_entry, new_entry;
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -1660,14 +1660,16 @@ void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (kvm_vcpu_is_blocking(vcpu))
 		return;
 
-	entry = READ_ONCE(*(svm->avic_physical_id_cache));
-	WARN_ON(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
+	old_entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	new_entry = old_entry;
 
-	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
-	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
-	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
+	new_entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+	new_entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
+	new_entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
+
+	if (old_entry != new_entry)
+		WRITE_ONCE(*(svm->avic_physical_id_cache), new_entry);
 
-	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
 	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, true);
 }
 
@@ -1777,6 +1779,9 @@ void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 
 void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
+	if (!avic_doorbell_strict)
+		__nested_avic_put(vcpu);
+
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3d9ab1e7b2b52..7e79fefc81650 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -190,6 +190,10 @@ module_param(avic, bool, 0444);
 static bool force_avic;
 module_param_unsafe(force_avic, bool, 0444);
 
+bool avic_doorbell_strict = true;
+module_param(avic_doorbell_strict, bool, 0444);
+
+
 bool __read_mostly dump_invalid_vmcb;
 module_param(dump_invalid_vmcb, bool, 0644);
 
@@ -1395,16 +1399,21 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	if (kvm_vcpu_apicv_active(vcpu))
 		__avic_vcpu_load(vcpu, cpu);
-
 	__nested_avic_load(vcpu, cpu);
 }
 
 static void svm_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	if (kvm_vcpu_apicv_active(vcpu))
-		__avic_vcpu_put(vcpu);
-
-	__nested_avic_put(vcpu);
+	/*
+	 * Forbid AVIC's peers to send interrupts
+	 * to this CPU unless we are in non strict mode,
+	 * in which case, we will do so only when this vCPU blocks
+	 */
+	if (avic_doorbell_strict) {
+		if (kvm_vcpu_apicv_active(vcpu))
+			__avic_vcpu_put(vcpu);
+		__nested_avic_put(vcpu);
+	}
 
 	svm_prepare_host_switch(vcpu);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7d1a5028750e6..7139bbb534f9e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -36,6 +36,7 @@ extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
 extern bool npt_enabled;
 extern int vgif;
 extern bool intercept_smi;
+extern bool avic_doorbell_strict;
 
 /*
  * Clean bits in VMCB.
-- 
2.26.3

