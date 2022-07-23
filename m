Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296FF57EACA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiGWAwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiGWAwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:52:19 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401988752
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:52:00 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id c14-20020a17090abf0e00b001f2096d876bso2604081pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=IeaBQrfkdXNfKz+ipR/TDgY2PaD5JQz8z1t6X3mNpdI=;
        b=OnedRgo9/k6ckD+QBBSuuhgCzNxJLoP5EtLNRdxStOWiMj5OlJrWzfs2fOl1o//lHM
         wutgW3D11vyctiBleHtCDNvwHK2s1L7HtHe3BqIYveMJ3efwr+yxx4dKkkxX45H/tOUG
         bbA4UMUok6QCu9DRYZC8JRF9negZCfrQ9LcdHHDkmOk/9UoojUqs3mcKkWYeTRyM1K3p
         /SrFd7AHMXfhRA+8a6XdLJ0rNJKckx1IwcgaH1vJpYwqa1AUZ2Trc4Y66pvjopN7+CTm
         IUMPPYSsFWfUnFc/9gC0b723CvKkszZoHwpO6nSVIEyocdjsPt+YKzKky6dFwLUR8mmr
         W1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=IeaBQrfkdXNfKz+ipR/TDgY2PaD5JQz8z1t6X3mNpdI=;
        b=Zmth9MJa+ysVavJH90gGTHKtNv9psZ6hIAR+tdqDnf3NbIGYoJcan38WAFq0/Uhos0
         A0jtld7h54GdqXlrrQ1cQ1evnJ9ukqNlC2pVFE06jK1LVSYNW/Cc/PeSU0o0AAY3JVse
         fZDLms4LPwIX7r+fDZ0J1fU1DI8Tc/JRgzCp7tqR0R0t+lZBWLfbxpbOgAi+LYFfKrEq
         Sa1Umx6/Nb5PGpefD75w/8/KZ0R0rnqppy92YLj9kJJXNtCQJhDfLs4Hc8upUwIxYxqe
         1EfKG9k8Sg6Gv54dJrKUquOP1hAgL21DmmMy4l0LxZGKk/oSCy2RV3abR8ju5rLh4j1n
         14XQ==
X-Gm-Message-State: AJIora/wdzSMmLS8H/B0Rd6aKHhspu9XI1GFWVPRArNznhnkrYClOzSa
        TlonZQDIqr+WG4an7G+4G4ESYOhr7UM=
X-Google-Smtp-Source: AGRyM1sG3XsoD2E2Jp4QnSTv1DYXjewMRUeZEiULOQdZCOLYS5+iK56m4hOZ1Jg7tUUVgRFpbMq/qU4xtMI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:8a41:0:b0:41a:4abd:5c98 with SMTP id
 y62-20020a638a41000000b0041a4abd5c98mr2049833pgd.292.1658537519981; Fri, 22
 Jul 2022 17:51:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Jul 2022 00:51:24 +0000
In-Reply-To: <20220723005137.1649592-1-seanjc@google.com>
Message-Id: <20220723005137.1649592-12-seanjc@google.com>
Mime-Version: 1.0
References: <20220723005137.1649592-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v4 11/24] KVM: x86: Rename kvm_x86_ops.queue_exception to inject_exception
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
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

Rename the kvm_x86_ops hook for exception injection to better reflect
reality, and to align with pretty much every other related function name
in KVM.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 2 +-
 arch/x86/include/asm/kvm_host.h    | 2 +-
 arch/x86/kvm/svm/svm.c             | 4 ++--
 arch/x86/kvm/vmx/vmx.c             | 4 ++--
 arch/x86/kvm/x86.c                 | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 51f777071584..82ba4a564e58 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -67,7 +67,7 @@ KVM_X86_OP(get_interrupt_shadow)
 KVM_X86_OP(patch_hypercall)
 KVM_X86_OP(inject_irq)
 KVM_X86_OP(inject_nmi)
-KVM_X86_OP(queue_exception)
+KVM_X86_OP(inject_exception)
 KVM_X86_OP(cancel_injection)
 KVM_X86_OP(interrupt_allowed)
 KVM_X86_OP(nmi_allowed)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e8281d64a431..dbb9eab979d4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1523,7 +1523,7 @@ struct kvm_x86_ops {
 				unsigned char *hypercall_addr);
 	void (*inject_irq)(struct kvm_vcpu *vcpu, bool reinjected);
 	void (*inject_nmi)(struct kvm_vcpu *vcpu);
-	void (*queue_exception)(struct kvm_vcpu *vcpu);
+	void (*inject_exception)(struct kvm_vcpu *vcpu);
 	void (*cancel_injection)(struct kvm_vcpu *vcpu);
 	int (*interrupt_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
 	int (*nmi_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index aef63aae922d..e73d79ae0e45 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -454,7 +454,7 @@ static int svm_update_soft_interrupt_rip(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static void svm_queue_exception(struct kvm_vcpu *vcpu)
+static void svm_inject_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned nr = vcpu->arch.exception.nr;
@@ -4798,7 +4798,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.patch_hypercall = svm_patch_hypercall,
 	.inject_irq = svm_inject_irq,
 	.inject_nmi = svm_inject_nmi,
-	.queue_exception = svm_queue_exception,
+	.inject_exception = svm_inject_exception,
 	.cancel_injection = svm_cancel_injection,
 	.interrupt_allowed = svm_interrupt_allowed,
 	.nmi_allowed = svm_nmi_allowed,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1c72cde600d0..14f75e4003d3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1610,7 +1610,7 @@ static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
 		vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
 }
 
-static void vmx_queue_exception(struct kvm_vcpu *vcpu)
+static void vmx_inject_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned nr = vcpu->arch.exception.nr;
@@ -7995,7 +7995,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.patch_hypercall = vmx_patch_hypercall,
 	.inject_irq = vmx_inject_irq,
 	.inject_nmi = vmx_inject_nmi,
-	.queue_exception = vmx_queue_exception,
+	.inject_exception = vmx_inject_exception,
 	.cancel_injection = vmx_cancel_injection,
 	.interrupt_allowed = vmx_interrupt_allowed,
 	.nmi_allowed = vmx_nmi_allowed,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 68fb6393c96f..a61b6cbd7194 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9672,7 +9672,7 @@ static void kvm_inject_exception(struct kvm_vcpu *vcpu)
 
 	if (vcpu->arch.exception.error_code && !is_protmode(vcpu))
 		vcpu->arch.exception.error_code = false;
-	static_call(kvm_x86_queue_exception)(vcpu);
+	static_call(kvm_x86_inject_exception)(vcpu);
 }
 
 static int inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit)
-- 
2.37.1.359.gd136c6c3e2-goog

