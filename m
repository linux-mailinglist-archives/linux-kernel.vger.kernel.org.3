Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55B46EC4A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbhLIP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbhLIP4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:56:39 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B37C0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 07:53:05 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y6-20020a17090322c600b001428ab3f888so2561891plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Sd6IF3FCdDDmmw1AgyuvS1fgt7iQ4AjDVZdX/op2tS0=;
        b=eFmfTts2vyIv3M69plKmEAvCFg3jKCBhPfY4VOiKXG+bpM/GFFC8G2qMF7mpekWtmO
         e17HFn6nLHwNn2Qe3Ec9960xU2uBP2YhVausn1rGnAQrFYKUngIsDS6px8JxIffNfm1m
         OaKvax9sxk2WO2xwNj5vYvplyUUDNkp2ESjofJIU00iKINU4ip0MIPXrV4odkVmKzDmi
         vYw+ZMzGmz2UvWFXW+aQ6CdUqRXmHKkziUprxjvSbS8vM6xRKybWct7Ngm2wQOSkpWHn
         YfV0nRspy4JTOkKRGJmuJzcf2GMBINlrARkFx7o6EY5+mFDqiN14Wb715huKfg+ewyAk
         gddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Sd6IF3FCdDDmmw1AgyuvS1fgt7iQ4AjDVZdX/op2tS0=;
        b=K/lVrDyDUsrKb8u9plx2I+jmf2mXygexBUGYnkfnv6Eec89YlEsGHZ9QdUzRUMd+dX
         cXlddLFKDxK63StxWiJAs4kMwkrg2CVOxiugJ2oyr/OKTwbJQVGQ2OCfREThArgyjP2q
         DKdqMOF4RIcPpG7Gm1uRW9RdVs+Fzk3iPoc9U55gmfzzcI0k5E3PhxcF6iPifO6YmWvb
         Jk3tC0iL4kZPC01B/S5JtZi0rZu+vyKr9BnTOgq8ee40V0iNCJqwO8efoX59wAvInrvq
         AG7Xnm/t668WfUbzxZwiGvzwuZ8R9OFSKD40o75wArzJrsO73P6SMe9a7hZ7Cij9nrtl
         tgcw==
X-Gm-Message-State: AOAM531rvg3FKPr0dpwrdg+II3Ejj7eg8Jmse3LkI5AgSR7PocACyPV1
        rmo90R75S1Gew8fSSsqeIC4NFS/gW3CI
X-Google-Smtp-Source: ABdhPJyWy6nltY/LLrdn4q80t1gjaLvFncYbxLQm4i95vGd10cdE5yZ1CxpagMOYZBUVsMHkKcmq9hOSh96N
X-Received: from marcorr-sp.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e50])
 (user=marcorr job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr881443pjf.1.1639065185015; Thu, 09 Dec 2021 07:53:05 -0800 (PST)
Date:   Thu,  9 Dec 2021 07:52:57 -0800
Message-Id: <20211209155257.128747-1-marcorr@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2] KVM: x86: Always set kvm_run->if_flag
From:   Marc Orr <marcorr@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, mlevitsk@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvm_run struct's if_flag is a part of the userspace/kernel API. The
SEV-ES patches failed to set this flag because it's no longer needed by
QEMU (according to the comment in the source code). However, other
hypervisors may make use of this flag. Therefore, set the flag for
guests with encrypted registers (i.e., with guest_state_protected set).

Fixes: f1c6366e3043 ("KVM: SVM: Add required changes to support intercepts under SEV-ES")
Signed-off-by: Marc Orr <marcorr@google.com>
---
v1 -> v2
- fix typos in commit message
- fix `svm_get_if_flag()` to work for non-SEV
- remove !! in return for both [svm|vmx]_get_if_flag()
- refactor `svm_interrupt_blocked()` to use `svm_get_if_flag()` arch/x86/include/asm/kvm-x86-ops.h |  1 +

 arch/x86/include/asm/kvm_host.h    |  1 +
 arch/x86/kvm/svm/svm.c             | 21 ++++++++++++---------
 arch/x86/kvm/vmx/vmx.c             |  6 ++++++
 arch/x86/kvm/x86.c                 |  9 +--------
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index cefe1d81e2e8..9e50da3ed01a 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -47,6 +47,7 @@ KVM_X86_OP(set_dr7)
 KVM_X86_OP(cache_reg)
 KVM_X86_OP(get_rflags)
 KVM_X86_OP(set_rflags)
+KVM_X86_OP(get_if_flag)
 KVM_X86_OP(tlb_flush_all)
 KVM_X86_OP(tlb_flush_current)
 KVM_X86_OP_NULL(tlb_remote_flush)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 860ed500580c..a7f868ff23e7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1349,6 +1349,7 @@ struct kvm_x86_ops {
 	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
 	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
 	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
+	bool (*get_if_flag)(struct kvm_vcpu *vcpu);
 
 	void (*tlb_flush_all)(struct kvm_vcpu *vcpu);
 	void (*tlb_flush_current)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d0f68d11ec70..5151efa424ac 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1585,6 +1585,15 @@ static void svm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 	to_svm(vcpu)->vmcb->save.rflags = rflags;
 }
 
+static bool svm_get_if_flag(struct kvm_vcpu *vcpu)
+{
+	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
+
+	return sev_es_guest(vcpu->kvm)
+		? vmcb->control.int_state & SVM_GUEST_INTERRUPT_MASK
+		: kvm_get_rflags(vcpu) & X86_EFLAGS_IF;
+}
+
 static void svm_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 {
 	switch (reg) {
@@ -3568,14 +3577,7 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 	if (!gif_set(svm))
 		return true;
 
-	if (sev_es_guest(vcpu->kvm)) {
-		/*
-		 * SEV-ES guests to not expose RFLAGS. Use the VMCB interrupt mask
-		 * bit to determine the state of the IF flag.
-		 */
-		if (!(vmcb->control.int_state & SVM_GUEST_INTERRUPT_MASK))
-			return true;
-	} else if (is_guest_mode(vcpu)) {
+	if (is_guest_mode(vcpu)) {
 		/* As long as interrupts are being delivered...  */
 		if ((svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
 		    ? !(svm->vmcb01.ptr->save.rflags & X86_EFLAGS_IF)
@@ -3586,7 +3588,7 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 		if (nested_exit_on_intr(svm))
 			return false;
 	} else {
-		if (!(kvm_get_rflags(vcpu) & X86_EFLAGS_IF))
+		if (!svm_get_if_flag(vcpu))
 			return true;
 	}
 
@@ -4621,6 +4623,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.cache_reg = svm_cache_reg,
 	.get_rflags = svm_get_rflags,
 	.set_rflags = svm_set_rflags,
+	.get_if_flag = svm_get_if_flag,
 
 	.tlb_flush_all = svm_flush_tlb,
 	.tlb_flush_current = svm_flush_tlb,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9453743ce0c4..269de5bb98d7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1363,6 +1363,11 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 		vmx->emulation_required = vmx_emulation_required(vcpu);
 }
 
+static bool vmx_get_if_flag(struct kvm_vcpu *vcpu)
+{
+	return vmx_get_rflags(vcpu) & X86_EFLAGS_IF;
+}
+
 u32 vmx_get_interrupt_shadow(struct kvm_vcpu *vcpu)
 {
 	u32 interruptibility = vmcs_read32(GUEST_INTERRUPTIBILITY_INFO);
@@ -7575,6 +7580,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.cache_reg = vmx_cache_reg,
 	.get_rflags = vmx_get_rflags,
 	.set_rflags = vmx_set_rflags,
+	.get_if_flag = vmx_get_if_flag,
 
 	.tlb_flush_all = vmx_flush_tlb_all,
 	.tlb_flush_current = vmx_flush_tlb_current,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e0aa4dd53c7f..45e836db5bcd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8995,14 +8995,7 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *kvm_run = vcpu->run;
 
-	/*
-	 * if_flag is obsolete and useless, so do not bother
-	 * setting it for SEV-ES guests.  Userspace can just
-	 * use kvm_run->ready_for_interrupt_injection.
-	 */
-	kvm_run->if_flag = !vcpu->arch.guest_state_protected
-		&& (kvm_get_rflags(vcpu) & X86_EFLAGS_IF) != 0;
-
+	kvm_run->if_flag = static_call(kvm_x86_get_if_flag)(vcpu);
 	kvm_run->cr8 = kvm_get_cr8(vcpu);
 	kvm_run->apic_base = kvm_get_apic_base(vcpu);
 
-- 
2.34.1.173.g76aa8bc2d0-goog

