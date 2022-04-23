Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFFB50C677
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 04:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiDWCR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 22:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiDWCRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 22:17:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F82021AF56
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 19:14:18 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id t3-20020a656083000000b0039cf337edd6so5949155pgu.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Fx01//NwlDcIPy9Gd6hi0TEGXUFkV39UbcfuM1U0Pac=;
        b=RaOWoAaVoZE+trOJkineMnnNNBOLtCqhTtXswHg7iJAUost1QTYPP/CRID7dK/kfea
         kfENExlBKBkOd92k+WRP/mLUzPCTxokKeFbFbUtPCPVoMy1RqUFSQrzQkGRLo3J2aG5E
         azQgnQ29v4QH/49ZyUK0pr6hLnHIWFZsllXr6+g8bzANSe63Fy2Ca5t2Qpx3ZMAYeNZF
         7q9ue2c8E1jjCo59N+yf/7agfh0UCDbeMwSIDPG9oBRAFg13jfBFnIGUdVmVvDjXwTfN
         1ynW96+WZnulm/GTSb5L/bQg2V65orFWW5oRqJYuj74/4jXOdOAy2GDl4+x1wqdI7kr9
         RMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Fx01//NwlDcIPy9Gd6hi0TEGXUFkV39UbcfuM1U0Pac=;
        b=Qa3VHxKRvM0v7G3+T49AFQwVfVM/obHa2JQetRFqAnzD6bP3rMcbhUuxZFwvHMtmnt
         cA24D7A1y/u/1g6M7dcTwm580JocU/ME2ypF7k3iG3sm5opl6eSSkloFCHBn4J7aQwIe
         j0/qp6cfF3wCK/Zgoaz84gZ04j5ACrUpBwscz6n+a+9U45INkDp5W8sBmKY1TzGEQbey
         CkjF75LScOKUXeKbz+fJtqD3AzEOeRfr38oRRubLCH7KcAbQzEtau3yzZJNdqD/w0byt
         jIlZpcHUisEJ/2VnnvaKrtqHHnKNSJLqTGWeo/dIr6JkUwtS/E1uN+WVW9+1sypacoGN
         TFQw==
X-Gm-Message-State: AOAM533eVRSgTLDoIcBqqyOJP9J2NiN7PGDgy5BYAcf7XMNMVDkyEZ2+
        hV9H5tbB0LIE8hJ9eJ29089PN8YE81U=
X-Google-Smtp-Source: ABdhPJxHrKcNAcpzYMl3xza9zupR0/MNb4GVV4iPrHFcAIG7ie4uua4bRBngh7F9T5WF9kjaB33yBo8dZwg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:384d:b0:1d2:97de:eb8c with SMTP id
 l13-20020a17090a384d00b001d297deeb8cmr19587685pjf.208.1650680057791; Fri, 22
 Apr 2022 19:14:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Apr 2022 02:14:03 +0000
In-Reply-To: <20220423021411.784383-1-seanjc@google.com>
Message-Id: <20220423021411.784383-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220423021411.784383-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 03/11] KVM: SVM: Unwind "speculative" RIP advancement if
 INTn injection "fails"
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unwind the RIP advancement done by svm_queue_exception() when injecting
an INT3 ultimately "fails" due to the CPU encountering a VM-Exit while
vectoring the injected event, even if the exception reported by the CPU
isn't the same event that was injected.  If vectoring INT3 encounters an
exception, e.g. #NP, and vectoring the #NP encounters an intercepted
exception, e.g. #PF when KVM is using shadow paging, then the #NP will
be reported as the event that was in-progress.

Note, this is still imperfect, as it will get a false positive if the
INT3 is cleanly injected, no VM-Exit occurs before the IRET from the INT3
handler in the guest, the instruction following the INT3 generates an
exception (directly or indirectly), _and_ vectoring that exception
encounters an exception that is intercepted by KVM.  The false positives
could theoretically be solved by further analyzing the vectoring event,
e.g. by comparing the error code against the expected error code were an
exception to occur when vectoring the original injected exception, but
SVM without NRIPS is a complete disaster, trying to make it 100% correct
is a waste of time.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Fixes: 66b7138f9136 ("KVM: SVM: Emulate nRIP feature when reinjecting INT3")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 151fba0b405f..82175a13c668 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3700,6 +3700,18 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 	vector = exitintinfo & SVM_EXITINTINFO_VEC_MASK;
 	type = exitintinfo & SVM_EXITINTINFO_TYPE_MASK;
 
+	/*
+	 * If NextRIP isn't enabled, KVM must manually advance RIP prior to
+	 * injecting the soft exception/interrupt.  That advancement needs to
+	 * be unwound if vectoring didn't complete.  Note, the _new_ event may
+	 * not be the injected event, e.g. if KVM injected an INTn, the INTn
+	 * hit a #NP in the guest, and the #NP encountered a #PF, the #NP will
+	 * be the reported vectored event, but RIP still needs to be unwound.
+	 */
+	if (int3_injected && type == SVM_EXITINTINFO_TYPE_EXEPT &&
+	   kvm_is_linear_rip(vcpu, svm->int3_rip))
+		kvm_rip_write(vcpu, kvm_rip_read(vcpu) - int3_injected);
+
 	switch (type) {
 	case SVM_EXITINTINFO_TYPE_NMI:
 		vcpu->arch.nmi_injected = true;
@@ -3713,16 +3725,11 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 
 		/*
 		 * In case of software exceptions, do not reinject the vector,
-		 * but re-execute the instruction instead. Rewind RIP first
-		 * if we emulated INT3 before.
+		 * but re-execute the instruction instead.
 		 */
-		if (kvm_exception_is_soft(vector)) {
-			if (vector == BP_VECTOR && int3_injected &&
-			    kvm_is_linear_rip(vcpu, svm->int3_rip))
-				kvm_rip_write(vcpu,
-					      kvm_rip_read(vcpu) - int3_injected);
+		if (kvm_exception_is_soft(vector))
 			break;
-		}
+
 		if (exitintinfo & SVM_EXITINTINFO_VALID_ERR) {
 			u32 err = svm->vmcb->control.exit_int_info_err;
 			kvm_requeue_exception_e(vcpu, vector, err);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

