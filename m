Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AB58AEE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbiHER37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbiHER3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:29:52 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655F11D32B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:29:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k13-20020a170902c40d00b0016f90eba744so1393393plk.22
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:from:to:cc;
        bh=5SQiUIrWt63c1yz0h4edznhSSgW9XtnGLriTtZ5Csqo=;
        b=n32VlX2tmwaL/M2M1vAwIeDcHUhkTAE9fpPjlCC2hL61Cds4Is/0wC6zPMSmtu8gcu
         q6pQuhh+uAGmG59R6+bHEGMzEYYmvuCgKI7bQ2+2TL72PGLLpMPr4a/7XVCfY52IQx/q
         SjfYFN5op45rkIz55GCdVNOQ/f5Dzej7x/IcxveEhA8ms/6BaB13+OMv7Lb2HGhHkwP4
         OxV+kEQuln6z3/hLSs+w2fRPxK01Xtk1u7PNKo4sHpt0z2XXas/iASCb57lhuJ1Cj3ey
         0/MSMToZua2Kn5D2Lw/Ok5TNumtMU8h+GEfLbveC/nSM5qloOL1khuSCFC7hkUxrxd/N
         c6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=5SQiUIrWt63c1yz0h4edznhSSgW9XtnGLriTtZ5Csqo=;
        b=YgqxsDvHXNQJ43PUI7/ckgDhXAKIYFJi35nVoYlZq8X4CHu14KJVLstvCPKdOYSP7w
         aIHHoI8dKlKYfszaV1Q6fSoidGLkOYIHmBYJGF8MwIrQD1IB2r0LgMvx5brfkO1GHLuN
         Ll6hVHZeXPXDKMwLaIdrcg6Pq7pZ+AVLq2HILv45dDSXWVyR+Iy0uTRwSPnIATX5goZY
         vinKR+rc+SuXrJOvGg0zAOjRFhRRJ8eQl7SAAh+6xUxL+nOMyR2Vcx2pJsA22EjuJG8K
         yTOki2VRE4IRRvYSfOurc+XgdtcD1swhgGmwR73MvDZ+ADV9cmq/H3mVfxnHk43PqrmK
         tZ2g==
X-Gm-Message-State: ACgBeo3UDhbrwRjNMzwh2wG9RThovOsChYBKkeGk2Ftrx9Kx0EuOynXJ
        LBl99i+04R25Sc+B+D+RQ6KBAGRarow=
X-Google-Smtp-Source: AA6agR4gh1rKeuU4lPLj/Zw073/tYxXNOnQqj7U7/YCyzslYDJTzrrsxk8GO0jaJzSWY1qRGqXTgEqJYbw8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr1035409pje.0.1659720590319; Fri, 05 Aug
 2022 10:29:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  5 Aug 2022 17:29:43 +0000
In-Reply-To: <20220805172945.35412-1-seanjc@google.com>
Message-Id: <20220805172945.35412-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220805172945.35412-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [RFC PATCH 1/3] KVM: x86: Add macros to track first...last VMX
 feature MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros to track the range of VMX feature MSRs that are emulated by
KVM to reduce the maintenance cost of extending the set of emulated MSRs.

Note, KVM doesn't necessarily emulate all known/consumed VMX MSRs, e.g.
PROCBASED_CTLS3 is consumed by KVM to enable IPI virtualization, but is
not emulated as KVM doesn't emulate/virtualize IPI virtualization for
nested guests.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/vmx/vmx.c | 8 ++++----
 arch/x86/kvm/x86.h     | 8 ++++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 38f873cb6f2c..0d7ad9a55a33 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4147,7 +4147,7 @@ static bool svm_has_emulated_msr(struct kvm *kvm, u32 index)
 {
 	switch (index) {
 	case MSR_IA32_MCG_EXT_CTL:
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		return false;
 	case MSR_IA32_SMBASE:
 		/* SEV-ES guests do not support SMM, so report false */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d7f8331d6f7e..36732339c5f7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1830,7 +1830,7 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!nested)
 			return 1;
 		return vmx_get_vmx_msr(&vmcs_config.nested, msr->index, &msr->data);
@@ -1918,7 +1918,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = to_vmx(vcpu)->msr_ia32_sgxlepubkeyhash
 			[msr_info->index - MSR_IA32_SGXLEPUBKEYHASH0];
 		break;
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!nested_vmx_allowed(vcpu))
 			return 1;
 		if (vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
@@ -2254,7 +2254,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vmx->msr_ia32_sgxlepubkeyhash
 			[msr_index - MSR_IA32_SGXLEPUBKEYHASH0] = data;
 		break;
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		if (!msr_info->host_initiated)
 			return 1; /* they are read-only */
 		if (!nested_vmx_allowed(vcpu))
@@ -6854,7 +6854,7 @@ static bool vmx_has_emulated_msr(struct kvm *kvm, u32 index)
 		 * real mode.
 		 */
 		return enable_unrestricted_guest || emulate_invalid_guest_state;
-	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+	case KVM_FIRST_EMULATED_VMX_MSR ... KVM_LAST_EMULATED_VMX_MSR:
 		return nested;
 	case MSR_AMD64_VIRT_SPEC_CTRL:
 	case MSR_AMD64_TSC_RATIO:
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 1926d2cb8e79..ae151aea17c5 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -39,6 +39,14 @@ void kvm_spurious_fault(void);
 	failed;								\
 })
 
+/*
+ * The first...last VMX feature MSRs that are emulated by KVM.  This may or may
+ * not cover all known VMX MSRs, as KVM doesn't emulate an MSR until there's an
+ * associated feature that KVM supports for nested virtualization.
+ */
+#define KVM_FIRST_EMULATED_VMX_MSR	MSR_IA32_VMX_BASIC
+#define KVM_LAST_EMULATED_VMX_MSR	MSR_IA32_VMX_VMFUNC
+
 #define KVM_DEFAULT_PLE_GAP		128
 #define KVM_VMX_DEFAULT_PLE_WINDOW	4096
 #define KVM_DEFAULT_PLE_WINDOW_GROW	2
-- 
2.37.1.559.g78731f0fdb-goog

