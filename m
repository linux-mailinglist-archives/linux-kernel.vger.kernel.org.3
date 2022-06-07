Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8248B5422D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386764AbiFHB0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382676AbiFGXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:39:05 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68CA16F34A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:36:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id g3-20020a170902868300b00163cd75c014so10004148plo.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=b2y6HIM0yFuupb/Asz+ocPiupQ2BH2KLPsPF8kzjrkw=;
        b=m9SlpsGTqZNrbbB28kCBcURN1oC2as0iS1/ePdYn+z9eVKChoC0y5YYloYFRM6viLn
         MwdmyILQveyGVDpO50TdB8AnQZapzqw9WtsZ9c6tol2WHl2eOmthABe6MA9jd0KVU++E
         uPc51dyF0P2g9keIN2hwDykX7XCJI5GZg1SfKPjrscBSw/U1/4swV3Tnn8MxFbdbocYw
         ifJr35+TuoVkg2KGklLjtR3nccuVqd2rieEm7huqqv6g82byL4uL2QqnZBFjmUr2Sh/8
         pioxGoHE/ToGuY4gzekI9l/Llte/+S1BNToib5RDZOD1haOfL7gcI/jvzaqTcHFgIcog
         /iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=b2y6HIM0yFuupb/Asz+ocPiupQ2BH2KLPsPF8kzjrkw=;
        b=cDib4hvp7z9PkiST3lQAq9CSxDpWGMJy+4LiJjZiox2Fm2W4ipl//E7nOTQ/7MqbiE
         1WCMnMS4pvH44nMTNOyW9OKdHFo9ClcHI2c/N03iKoiSqjdiDa3Rj4H8C6Kb90I8D1M0
         OKs/OS+IpoVEZpmJmCIPHZ1q9DIcBczBGfoTz0EcOWIVqUhlMc/QgGSU5M1SUPwXCSfT
         avZ2SfsoZqDq8xuHjeD5yecSIRh/K1oge8vIoZpDihlJf+fd4qst7oxXRnAbuCl33vi0
         /XC/K6b/vRkucM2DJpjjTIY/v0mszDOH7YIH7uN5Gf02aM0/ISJpgkhczjbDHT9iNf3g
         TjkA==
X-Gm-Message-State: AOAM532v/D4GepJ4Fk/jZQxCqSg9WiozJqjg18EDreR8fvHktzuTYaKQ
        8/oN7Wj2dgMD/hsSoJGYyg9rQsgQGEo=
X-Google-Smtp-Source: ABdhPJwgtT75q6YVsktniY/VHzibvVaHAIcTz9UivR7D0BpOChyXwBs/01A9v7fwrZCt9bFCGn2ylPNciYw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:8890:0:b0:51c:454f:c93f with SMTP id
 z16-20020aa78890000000b0051c454fc93fmr3586124pfe.35.1654637793364; Tue, 07
 Jun 2022 14:36:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Jun 2022 21:35:58 +0000
In-Reply-To: <20220607213604.3346000-1-seanjc@google.com>
Message-Id: <20220607213604.3346000-10-seanjc@google.com>
Mime-Version: 1.0
References: <20220607213604.3346000-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v5 09/15] KVM: nVMX: Drop nested_vmx_pmu_refresh()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Li <ercli@ucdavis.edu>,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>
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

From: Oliver Upton <oupton@google.com>

nested_vmx_pmu_refresh() is now unneeded, as the call to
nested_vmx_entry_exit_ctls_update() in vmx_vcpu_after_set_cpuid()
guarantees that the VM-{Entry,Exit} control MSR changes are applied
after setting CPUID. Drop all vestiges of nested_vmx_pmu_refresh().

No functional change intended.

Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c    | 22 ----------------------
 arch/x86/kvm/vmx/nested.h    |  2 --
 arch/x86/kvm/vmx/pmu_intel.c |  3 ---
 3 files changed, 27 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index d1c21d387716..4ba0e5540908 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4847,28 +4847,6 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 	return 0;
 }
 
-void nested_vmx_pmu_refresh(struct kvm_vcpu *vcpu,
-			    bool vcpu_has_perf_global_ctrl)
-{
-	struct vcpu_vmx *vmx;
-
-	if (!nested_vmx_allowed(vcpu))
-		return;
-
-	vmx = to_vmx(vcpu);
-	if (vcpu_has_perf_global_ctrl) {
-		vmx->nested.msrs.entry_ctls_high |=
-				VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
-		vmx->nested.msrs.exit_ctls_high |=
-				VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
-	} else {
-		vmx->nested.msrs.entry_ctls_high &=
-				~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
-		vmx->nested.msrs.exit_ctls_high &=
-				~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
-	}
-}
-
 static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer,
 				int *ret)
 {
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 129ae4e01f7c..88b00a7359e4 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -32,8 +32,6 @@ int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data);
 int vmx_get_vmx_msr(struct nested_vmx_msrs *msrs, u32 msr_index, u64 *pdata);
 int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
 			u32 vmx_instruction_info, bool wr, int len, gva_t *ret);
-void nested_vmx_pmu_refresh(struct kvm_vcpu *vcpu,
-			    bool vcpu_has_perf_global_ctrl);
 void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu);
 bool nested_vmx_check_io_bitmaps(struct kvm_vcpu *vcpu, unsigned int port,
 				 int size);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 6ce3b066f7d9..515ab6594333 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -597,9 +597,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 	bitmap_set(pmu->all_valid_pmc_idx,
 		INTEL_PMC_MAX_GENERIC, pmu->nr_arch_fixed_counters);
 
-	nested_vmx_pmu_refresh(vcpu,
-			       intel_is_valid_msr(vcpu, MSR_CORE_PERF_GLOBAL_CTRL, false));
-
 	if (cpuid_model_is_consistent(vcpu))
 		x86_perf_get_lbr(&lbr_desc->records);
 	else
-- 
2.36.1.255.ge46751e96f-goog

