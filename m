Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397F456C506
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiGHXXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiGHXXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:23:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36025419AE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:23:10 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z5-20020a170903018500b0016a561649abso23096plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=GZ1bIqQ5uxtRbXqyYGz3rmRapEwhTBX1fk0bLa5NCD4=;
        b=PdWMG3dWy27dhMxJ4fqhuUZFohehK7E4Tp3pHRYmschBb1kzWcKfgVOr9q9uY8HpMr
         FZTDb3sBk3YA8sWIKMgqJIb7XQL2xpao3uxQH5RRErz8f0/WLFlDlmyJ531cNZsvP8cf
         cKtW279ZBgJh764HrljzXRrRKh12txodwcWkpAjvgNGnL0Y/AG0so6PxtEi8sKA0v/Nd
         LKey8WhlWjRgmFVApbD09U0wTObR3BoarmZvXRl1PTjT13+xqWUSjiFjBFhcumLLri7/
         W8/33NGK2hLPO0wFT9ux9crf6/r0Kg8EthpSsCNrcDbYNU90gDBXwUYe6r2i2dy8HcZF
         SzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=GZ1bIqQ5uxtRbXqyYGz3rmRapEwhTBX1fk0bLa5NCD4=;
        b=vXznx801myDQLOi1JoaC1vfD7ocVmhWeddrFLNINpmVn+5h94edA48JkZO4RkZ6vDO
         26VqOY3L4DTbOs5mX7qU7pgWDXhByg+xchE17feXt7gUnW52hPEF81ivLwYJf5ffAqtt
         yNG1PwlWAC+JWj/hRb8cBX9AdbymbTbtsGzi/LNLO7t9+0AscbvQJaeliJ/WAu/xw4UT
         pVsq7fZHttMRQP7/39eWU9hidzcCLLLkUr22zvl5/JoBoWFFhyjigI9vstmM92pEzRNY
         I6LSthI6ZP5M9kQIJllpgL5xpPTPFbjbiJZPMQ2jEKnUHQXYiQkQFbHMqfa8chfCENiJ
         pTwQ==
X-Gm-Message-State: AJIora+oyCTdqpcOYxE0tsfIHC3eyTg71CHtx/a45U2m0eRSxmgzjvM+
        7TR9vLcmJZ7wffqnKzydr97Johf7AoNZ
X-Google-Smtp-Source: AGRyM1ujHh+SJnjS2KWyxXlc9BTRfZQ8ci3eKldrE8Ql4k3uN5KiObZLfq6wc5hjwI48Mcooms476LvUC13T
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a05:6a00:ac7:b0:528:7acb:e445 with SMTP id
 c7-20020a056a000ac700b005287acbe445mr6314370pfl.14.1657322589790; Fri, 08 Jul
 2022 16:23:09 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Fri,  8 Jul 2022 23:23:03 +0000
In-Reply-To: <20220708232304.1001099-1-mizhang@google.com>
Message-Id: <20220708232304.1001099-2-mizhang@google.com>
Mime-Version: 1.0
References: <20220708232304.1001099-1-mizhang@google.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH 1/2] KVM: nested/x86: update trace_kvm_nested_vmrun() to
 suppot VMX
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
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

Update trace_kvm_nested_vmrun() to support VMX by adding a new field 'isa';
update the output to print out VMX/SVM related naming respectively,
eg., vmcb vs. vmcs; npt vs. ept.

In addition, print nested EPT/NPT address instead of the 1bit of nested
ept/npt on/off. This should convey more information in the trace. When
nested ept/npt is not used, simply print "0x0" so that we don't lose any
information.

Opportunistically update the call site of trace_kvm_nested_vmrun() to make
one line per parameter.

Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/svm/nested.c |  7 +++++--
 arch/x86/kvm/trace.h      | 29 ++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ba7cd26f438f..8581164b6808 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -724,11 +724,14 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa,
 	struct vcpu_svm *svm = to_svm(vcpu);
 	int ret;
 
-	trace_kvm_nested_vmrun(svm->vmcb->save.rip, vmcb12_gpa,
+	trace_kvm_nested_vmrun(svm->vmcb->save.rip,
+			       vmcb12_gpa,
 			       vmcb12->save.rip,
 			       vmcb12->control.int_ctl,
 			       vmcb12->control.event_inj,
-			       vmcb12->control.nested_ctl);
+			       vmcb12->control.nested_ctl,
+			       vmcb12->control.nested_cr3,
+			       KVM_ISA_SVM);
 
 	trace_kvm_nested_intercepts(vmcb12->control.intercepts[INTERCEPT_CR] & 0xffff,
 				    vmcb12->control.intercepts[INTERCEPT_CR] >> 16,
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index de4762517569..aac4c8bd2c3a 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -580,8 +580,10 @@ TRACE_EVENT(kvm_pv_eoi,
  */
 TRACE_EVENT(kvm_nested_vmrun,
 	    TP_PROTO(__u64 rip, __u64 vmcb, __u64 nested_rip, __u32 int_ctl,
-		     __u32 event_inj, bool npt),
-	    TP_ARGS(rip, vmcb, nested_rip, int_ctl, event_inj, npt),
+		     __u32 event_inj, bool npt_enabled, __u64 npt_addr,
+		     __u32 isa),
+	    TP_ARGS(rip, vmcb, nested_rip, int_ctl, event_inj, npt_enabled,
+		    npt_addr, isa),
 
 	TP_STRUCT__entry(
 		__field(	__u64,		rip		)
@@ -589,7 +591,9 @@ TRACE_EVENT(kvm_nested_vmrun,
 		__field(	__u64,		nested_rip	)
 		__field(	__u32,		int_ctl		)
 		__field(	__u32,		event_inj	)
-		__field(	bool,		npt		)
+		__field(	bool,		npt_enabled	)
+		__field(	__u64,		npt_addr	)
+		__field(	__u32,		isa		)
 	),
 
 	TP_fast_assign(
@@ -598,14 +602,21 @@ TRACE_EVENT(kvm_nested_vmrun,
 		__entry->nested_rip	= nested_rip;
 		__entry->int_ctl	= int_ctl;
 		__entry->event_inj	= event_inj;
-		__entry->npt		= npt;
+		__entry->npt_enabled	= npt_enabled;
+		__entry->npt_addr	= npt_addr;
+		__entry->isa		= isa;
 	),
 
-	TP_printk("rip: 0x%016llx vmcb: 0x%016llx nrip: 0x%016llx int_ctl: 0x%08x "
-		  "event_inj: 0x%08x npt: %s",
-		__entry->rip, __entry->vmcb, __entry->nested_rip,
-		__entry->int_ctl, __entry->event_inj,
-		__entry->npt ? "on" : "off")
+	TP_printk("rip: 0x%016llx %s: 0x%016llx nested rip: 0x%016llx "
+		  "int_ctl: 0x%08x event_inj: 0x%08x nested %s: 0x%016llx",
+		__entry->rip,
+		__entry->isa == KVM_ISA_VMX ? "vmcs" : "vmcb",
+		__entry->vmcb,
+		__entry->nested_rip,
+		__entry->int_ctl,
+		__entry->event_inj,
+		__entry->isa == KVM_ISA_VMX ? "ept" : "npt",
+		__entry->npt_enabled ? __entry->npt_addr : 0x0)
 );
 
 TRACE_EVENT(kvm_nested_intercepts,
-- 
2.37.0.144.g8ac04bfd2-goog

