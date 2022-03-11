Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686CF4D58F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbiCKDaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbiCKD3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:29:48 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD6FF1E8F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:24 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id y27-20020aa7943b000000b004f6decccdb5so4464804pfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=QjfA+ulPE/1p5AtnpClL8XNu0TVV5mTw0QyNigIW+zY=;
        b=DBjZAxpiVD/MGi+UdS5XMlndiShw1xIi6lAeK0wpz2NOy+pYg66MrD0gi6Bn9AMOac
         inZpdFh0KUdu8zjuU6eYxbESFlakwceZlRvZ6ok8sCJpdidSR3upO+TeefijCKsduVl9
         wuORJuUZnKl165HZNmEDPPUw5q0qTGK0abrjv+1OvV7aeFOd8qA4Ekm38e3nfz8DEyFx
         FLR/1404Tbzi7TA7KaFe6U41TaPV0NEBdA+0oNAj4QozbfqU7XO8qLDJHS3gnwCGzvB0
         G+4fv2NbXJK2Hqnjw0tNErD1BRZvxHz+AUamgFYeH2OBI4jd4DSaV593nf6VTDOKx4f9
         2V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=QjfA+ulPE/1p5AtnpClL8XNu0TVV5mTw0QyNigIW+zY=;
        b=KDhVJH08GZvtVSMoPc39HMkAO8e4L9cseJIhQ5DpEO7yKylPw8Mxm5NQO3LtDOSSb0
         NUOx5Oitmg8xGShgfG4rvPAAGnnXYdZZ/eM+2acwKnpY2PMC1q3YI19lzJs9Q8K2cN2W
         HzkuH3K7KIffpFgqkTm3LltRTWXuRXGTUgol+ED6ZVsCmAS8VIADawpgQ8Hc1jScYvt1
         gofl5NSO7woX1yyvMfPBkUKln72dIOQH8aSl98mhn2yQ9oC29d8Yb1IPw50ybtUz7mqT
         QOta6ZkqESjVA8EPWB80Ka2oV73LpmbyDNiRa0AhQPvn9fpBSErl285zLSHHiHxDBvzl
         RmLQ==
X-Gm-Message-State: AOAM530NV4KgOddmU6NP7W8BHj1hVLhszGSVpeAn0Ic/dkFgg1hEmiQE
        /j9hGp7wEKS0le2z/fuj4S12ZLRnPHQ=
X-Google-Smtp-Source: ABdhPJzk89S+w6AUCCuGJZTBPwv8i95IrqOrmBsTCIORPlf2weHYqAJJxK4v6b0w4b/UcGaQnLfdgoOidFU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e10:b0:1bf:6c78:54a9 with SMTP id
 pg16-20020a17090b1e1000b001bf6c7854a9mr403350pjb.1.1646969303953; Thu, 10 Mar
 2022 19:28:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 03:27:52 +0000
In-Reply-To: <20220311032801.3467418-1-seanjc@google.com>
Message-Id: <20220311032801.3467418-13-seanjc@google.com>
Mime-Version: 1.0
References: <20220311032801.3467418-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 12/21] KVM: x86: Rename kvm_x86_ops.queue_exception to inject_exception
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the kvm_x86_ops hook for exception injection to better reflect
reality, and to align with pretty much every other related function name
in KVM.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 2 +-
 arch/x86/include/asm/kvm_host.h    | 2 +-
 arch/x86/kvm/svm/svm.c             | 4 ++--
 arch/x86/kvm/vmx/vmx.c             | 4 ++--
 arch/x86/kvm/x86.c                 | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 29affccb353c..656fa1626dc1 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -66,7 +66,7 @@ KVM_X86_OP(get_interrupt_shadow)
 KVM_X86_OP(patch_hypercall)
 KVM_X86_OP(inject_irq)
 KVM_X86_OP(inject_nmi)
-KVM_X86_OP(queue_exception)
+KVM_X86_OP(inject_exception)
 KVM_X86_OP(cancel_injection)
 KVM_X86_OP(interrupt_allowed)
 KVM_X86_OP(nmi_allowed)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3a2c855f04e3..4f891fe00767 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1391,7 +1391,7 @@ struct kvm_x86_ops {
 				unsigned char *hypercall_addr);
 	void (*inject_irq)(struct kvm_vcpu *vcpu);
 	void (*inject_nmi)(struct kvm_vcpu *vcpu);
-	void (*queue_exception)(struct kvm_vcpu *vcpu);
+	void (*inject_exception)(struct kvm_vcpu *vcpu);
 	void (*cancel_injection)(struct kvm_vcpu *vcpu);
 	int (*interrupt_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
 	int (*nmi_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fc5222a0f506..8b7f3c4e383f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -382,7 +382,7 @@ static int svm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static void svm_queue_exception(struct kvm_vcpu *vcpu)
+static void svm_inject_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned nr = vcpu->arch.exception.nr;
@@ -4580,7 +4580,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.patch_hypercall = svm_patch_hypercall,
 	.inject_irq = svm_inject_irq,
 	.inject_nmi = svm_inject_nmi,
-	.queue_exception = svm_queue_exception,
+	.inject_exception = svm_inject_exception,
 	.cancel_injection = svm_cancel_injection,
 	.interrupt_allowed = svm_interrupt_allowed,
 	.nmi_allowed = svm_nmi_allowed,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a8ebe91fe9a5..f3f16271fa2c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1602,7 +1602,7 @@ static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
 		vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
 }
 
-static void vmx_queue_exception(struct kvm_vcpu *vcpu)
+static void vmx_inject_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned nr = vcpu->arch.exception.nr;
@@ -7783,7 +7783,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.patch_hypercall = vmx_patch_hypercall,
 	.inject_irq = vmx_inject_irq,
 	.inject_nmi = vmx_inject_nmi,
-	.queue_exception = vmx_queue_exception,
+	.inject_exception = vmx_inject_exception,
 	.cancel_injection = vmx_cancel_injection,
 	.interrupt_allowed = vmx_interrupt_allowed,
 	.nmi_allowed = vmx_nmi_allowed,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 507e5f26ebbf..452fbb55d9d2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9312,7 +9312,7 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.exception.error_code && !is_protmode(vcpu))
 		vcpu->arch.exception.error_code = false;
-	static_call(kvm_x86_queue_exception)(vcpu);
+	static_call(kvm_x86_inject_exception)(vcpu);
 }
 
 static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
-- 
2.35.1.723.g4982287a31-goog

