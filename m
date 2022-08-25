Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF3B5A1CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbiHYW60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244312AbiHYW6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:58:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A54C6EA6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:58:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33daeaa6b8eso73393467b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=FD82s3MMzYB8GBAJIpK/z/0Hk3ArgyOBmCxF7AYV4Cw=;
        b=ZQhMXb9SCtgugfP2YGQ8gvz7CKQhTwhyoZC4VMPZHBCSmXHYO030MCNd3v3RgyMOy4
         HfDu3XCP8ZLM9/2iaQzIjq5h+5WyVcqAwWVJvpexrPuhKzO0J2bPEkA4KX9BFrB3nVaR
         V6bSWzS2bJLU+9zwJnsoiMt4Gg+2ir4kh+SrvFOi0qXsEEE1K6Wx+fuhqR7yDUi3S8nU
         U+XVhuhk+RBX9NvremewdIM8xAWrJ3z5VPJmfxSq7zMRw+0Mi9naHNo/3vSjaZY1iWaX
         rytGD8qTy74x7wqSEiwqKZabtnX+/+Z+qTq6gD4dUtMwsixPxlnfASYlV46FmTV2D6cb
         T6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=FD82s3MMzYB8GBAJIpK/z/0Hk3ArgyOBmCxF7AYV4Cw=;
        b=rSXmQuo4//ttQN4aGjZ4sY5TcvQqWqHsmPsgFPkrJH5G2L7jcgEM5xpIsabessQLtS
         ubBT+ikjpSYlGkzMTfc2+G2bfcHRhLQeHMtcrF786FiuOaCnZCyKL7ma8B0JoCRDPfRS
         fdG5SBiKfWJQsN7pr4o+sFQBg9d8UuVxEAL+n4TH7VwPfzBf9G75E8Dp3shFBr+Te847
         zOxsmBCiJzIecxciB6oQ8deu3noNHBH1u0fhwYRXbrLHL2XAZiG/xuN7qdc8Sip4t88G
         QkMYPZSdvbH58PGQ9WDe9AHB35BJ2quBuZ4A9yGpaIT1RVzhU/JThRwGVit0/jFrfUmx
         E7+Q==
X-Gm-Message-State: ACgBeo2jrHjyGbcexfKBFyVnC7ta+HJgqXT/zN2vuKBBxsBECRdu9arP
        jWFggh9tMsbd8figrqfiNdLU25OSFHWj
X-Google-Smtp-Source: AA6agR6aWBJdKui7yBrmJ2lo0BpaVF02BfZ3BGPvA+/LtdtBaRS2qe9gMialtqsarsKsgczy3mWWisqFHQXQ
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a25:bb44:0:b0:677:24c:308f with SMTP id
 b4-20020a25bb44000000b00677024c308fmr5394791ybk.433.1661468290101; Thu, 25
 Aug 2022 15:58:10 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Thu, 25 Aug 2022 22:57:55 +0000
In-Reply-To: <20220825225755.907001-1-mizhang@google.com>
Mime-Version: 1.0
References: <20220825225755.907001-1-mizhang@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220825225755.907001-4-mizhang@google.com>
Subject: [PATCH v4 3/3] KVM: x86: Print guest pgd in kvm_nested_vmenter()
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>
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

Print guest pgd in kvm_nested_vmenter() to enrich the information for
tracing. When tdp is enabled, print the value of tdp page table (EPT/NPT);
when tdp is disabled, print the value of non-nested CR3.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/nested.c |  2 ++
 arch/x86/kvm/trace.h      | 13 +++++++++----
 arch/x86/kvm/vmx/nested.c |  2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 835c508eed8e..05b7994244c5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -787,6 +787,8 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 			       vmcb12->control.int_ctl,
 			       vmcb12->control.event_inj,
 			       vmcb12->control.nested_ctl,
+			       vmcb12->control.nested_cr3,
+			       vmcb12->save.cr3,
 			       KVM_ISA_SVM);
 
 	trace_kvm_nested_intercepts(vmcb12->control.intercepts[INTERCEPT_CR] & 0xffff,
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index e7f0da9474f0..b2be0348bb14 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -591,9 +591,10 @@ TRACE_EVENT(kvm_pv_eoi,
  */
 TRACE_EVENT(kvm_nested_vmenter,
 	    TP_PROTO(__u64 rip, __u64 vmcb, __u64 nested_rip, __u32 int_ctl,
-		     __u32 event_inj, bool tdp_enabled, __u32 isa),
+		     __u32 event_inj, bool tdp_enabled, __u64 guest_tdp,
+		     __u64 guest_cr3, __u32 isa),
 	    TP_ARGS(rip, vmcb, nested_rip, int_ctl, event_inj, tdp_enabled,
-		    isa),
+		    guest_tdp, guest_cr3, isa),
 
 	TP_STRUCT__entry(
 		__field(	__u64,		rip		)
@@ -602,6 +603,7 @@ TRACE_EVENT(kvm_nested_vmenter,
 		__field(	__u32,		int_ctl		)
 		__field(	__u32,		event_inj	)
 		__field(	bool,		tdp_enabled	)
+		__field(	__u64,		guest_pgd	)
 		__field(	__u32,		isa		)
 	),
 
@@ -612,11 +614,13 @@ TRACE_EVENT(kvm_nested_vmenter,
 		__entry->int_ctl	= int_ctl;
 		__entry->event_inj	= event_inj;
 		__entry->tdp_enabled	= tdp_enabled;
+		__entry->guest_pgd	= tdp_enabled ? guest_tdp : guest_cr3;
 		__entry->isa		= isa;
 	),
 
 	TP_printk("rip: 0x%016llx %s: 0x%016llx nested_rip: 0x%016llx "
-		  "int_ctl: 0x%08x event_inj: 0x%08x nested_%s: %s",
+		  "int_ctl: 0x%08x event_inj: 0x%08x nested_%s: %s, "
+		  "guest_pgd: 0x%016llx",
 		__entry->rip,
 		__entry->isa == KVM_ISA_VMX ? "vmcs" : "vmcb",
 		__entry->vmcb,
@@ -624,7 +628,8 @@ TRACE_EVENT(kvm_nested_vmenter,
 		__entry->int_ctl,
 		__entry->event_inj,
 		__entry->isa == KVM_ISA_VMX ? "ept" : "npt",
-		__entry->tdp_enabled ? "on" : "off")
+		__entry->tdp_enabled ? "on" : "off",
+		__entry->guest_pgd)
 );
 
 TRACE_EVENT(kvm_nested_intercepts,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f72fe9452391..f963e5ce0a28 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3370,6 +3370,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 				 vmcs12->guest_intr_status,
 				 vmcs12->vm_entry_intr_info_field,
 				 vmcs12->secondary_vm_exec_control & SECONDARY_EXEC_ENABLE_EPT,
+				 vmcs12->ept_pointer,
+				 vmcs12->guest_cr3,
 				 KVM_ISA_VMX);
 
 	kvm_service_local_tlb_flush_requests(vcpu);
-- 
2.37.2.672.g94769d06f0-goog

