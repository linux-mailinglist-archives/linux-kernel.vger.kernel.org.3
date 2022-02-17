Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099DA4B9853
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiBQFcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:32:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiBQFcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E99EBA1BC2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645075926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ixaC+WveNvHaDkBhw3sVXdx9/WgsexXW9FNcptE03U=;
        b=TG9h3pRAp1iLNw7rbW2i2S5prYavXzXoc98FHrAzr/KPVoXlTumNq8uTYzD/yFNqTTOR8W
        1pI58GiFhSYZG+Zov4vmQipDs6nv3UDIy9nxvcg5pxCh6Xi+t6TOrcBer5XcG158UiL3DT
        U8kbmu4Opy9QdMGUHjfN1LXsa8YTqck=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-FUzy0dpJOrG-00P97P-avg-1; Thu, 17 Feb 2022 00:31:24 -0500
X-MC-Unique: FUzy0dpJOrG-00P97P-avg-1
Received: by mail-oi1-f199.google.com with SMTP id bb20-20020a056808169400b002cd940d6247so1881660oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ixaC+WveNvHaDkBhw3sVXdx9/WgsexXW9FNcptE03U=;
        b=csiTMHu5Y/K7lm7N/dFuDxzsB6stqAcMP8d0IlK1nzhpXuiD08dFjCtC83KZN6+WDN
         osiHU4dCKzMqNgKl4natV8MvG6aZvr636azFpw2nTJbWneu9Hw7D401P/TbIWapzwKvk
         YxMmzkyOPTApV299VltwpG/KZWSmyHFp9Z5Tan0/Qf+a83mm9vsPeHzeFRrCNmXtL7v0
         2VmxEY9dfK9hVU8TrjLZGdVg0cV1KzXzQfcFc92l1+/XMDbfL/T5EJlxT7+tGLZMiYEc
         2ifyqXRcFYc1uuCwfh2iM00wCKZqekDGBP07RWGES6Tzbq41kfcQzWIX32n2X9oUzRMx
         6IZQ==
X-Gm-Message-State: AOAM533329bJflRtZC9iXsLHkkpgT1z5QVcRPgci4QWpDaBkzngLNHv0
        ixxMQQHy27K+ID//R2dmV1mXj9t+zjmTRf62X3OkN/3zC2PqgiOESsXHfpeaFUS+qnMCQwO/rMR
        t1veMc9r9SF7fs92dm73/VPYy
X-Received: by 2002:a05:6870:a894:b0:d3:cc7:ac28 with SMTP id eb20-20020a056870a89400b000d30cc7ac28mr491733oab.207.1645075883502;
        Wed, 16 Feb 2022 21:31:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgOyeDMwJ516sad84JIJ6nVrFCyP8MKFMYWt+0bMrbpBDX1hyXK+FtkMWoj/raLhQWyulXow==
X-Received: by 2002:a05:6870:a894:b0:d3:cc7:ac28 with SMTP id eb20-20020a056870a89400b000d30cc7ac28mr491718oab.207.1645075883290;
        Wed, 16 Feb 2022 21:31:23 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7f1:c12c:38a3:24a6:f679:3afd])
        by smtp.gmail.com with ESMTPSA id cm18sm8571688oab.7.2022.02.16.21.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 21:31:22 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Gilbert <dgilbert@redhat.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Leonardo Bras <leobras@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] x86/kvm/fpu: Remove kvm_vcpu_arch.guest_supported_xcr0
Date:   Thu, 17 Feb 2022 02:30:30 -0300
Message-Id: <20220217053028.96432-3-leobras@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217053028.96432-1-leobras@redhat.com>
References: <20220217053028.96432-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_vcpu_arch currently contains the guest supported features in both
guest_supported_xcr0 and guest_fpu.fpstate->user_xfeatures field.

Currently both fields are set to the same value in
kvm_vcpu_after_set_cpuid() and are not changed anywhere else after that.

Since it's not good to keep duplicated data, remove guest_supported_xcr0.

To keep the code more readable, introduce kvm_guest_supported_xcr()
and kvm_guest_supported_xfd() to replace the previous usages of
guest_supported_xcr0.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/cpuid.c            |  5 +++--
 arch/x86/kvm/x86.c              | 20 +++++++++++++++-----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6dcccb304775..ec9830d2aabf 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -703,7 +703,6 @@ struct kvm_vcpu_arch {
 	struct fpu_guest guest_fpu;
 
 	u64 xcr0;
-	u64 guest_supported_xcr0;
 
 	struct kvm_pio_request pio;
 	void *pio_data;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 71125291c578..b8f8d268d058 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -282,6 +282,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	struct kvm_cpuid_entry2 *best;
+	u64 guest_supported_xcr0;
 
 	best = kvm_find_cpuid_entry(vcpu, 1, 0);
 	if (best && apic) {
@@ -293,10 +294,10 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		kvm_apic_set_version(vcpu);
 	}
 
-	vcpu->arch.guest_supported_xcr0 =
+	guest_supported_xcr0 =
 		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
 
-	vcpu->arch.guest_fpu.fpstate->user_xfeatures = vcpu->arch.guest_supported_xcr0;
+	vcpu->arch.guest_fpu.fpstate->user_xfeatures = guest_supported_xcr0;
 
 	kvm_update_pv_runtime(vcpu);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 641044db415d..92177e2ff664 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -984,6 +984,18 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_load_host_xsave_state);
 
+static inline u64 kvm_guest_supported_xcr(struct kvm_vcpu *vcpu)
+{
+	u64 guest_supported_xcr0 = vcpu->arch.guest_fpu.fpstate->user_xfeatures;
+
+	return guest_supported_xcr0;
+}
+
+static inline u64 kvm_guest_supported_xfd(struct kvm_vcpu *vcpu)
+{
+	return kvm_guest_supported_xcr(vcpu) & XFEATURE_MASK_USER_DYNAMIC;
+}
+
 static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 {
 	u64 xcr0 = xcr;
@@ -1003,7 +1015,7 @@ static int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 	 * saving.  However, xcr0 bit 0 is always set, even if the
 	 * emulated CPU does not support XSAVE (see kvm_vcpu_reset()).
 	 */
-	valid_bits = vcpu->arch.guest_supported_xcr0 | XFEATURE_MASK_FP;
+	valid_bits = kvm_guest_supported_xcr(vcpu) | XFEATURE_MASK_FP;
 	if (xcr0 & ~valid_bits)
 		return 1;
 
@@ -3706,8 +3718,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    !guest_cpuid_has(vcpu, X86_FEATURE_XFD))
 			return 1;
 
-		if (data & ~(XFEATURE_MASK_USER_DYNAMIC &
-			     vcpu->arch.guest_supported_xcr0))
+		if (data & ~(kvm_guest_supported_xfd(vcpu)))
 			return 1;
 
 		fpu_update_guest_xfd(&vcpu->arch.guest_fpu, data);
@@ -3717,8 +3728,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    !guest_cpuid_has(vcpu, X86_FEATURE_XFD))
 			return 1;
 
-		if (data & ~(XFEATURE_MASK_USER_DYNAMIC &
-			     vcpu->arch.guest_supported_xcr0))
+		if (data & ~(kvm_guest_supported_xfd(vcpu)))
 			return 1;
 
 		vcpu->arch.guest_fpu.xfd_err = data;
-- 
2.35.1

