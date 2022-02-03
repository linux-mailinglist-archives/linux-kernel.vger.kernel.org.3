Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306A44A86A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiBCOfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351308AbiBCOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB657C061744;
        Thu,  3 Feb 2022 06:33:32 -0800 (PST)
Date:   Thu, 03 Feb 2022 14:33:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=76aaEtLvtb96qbgKQMJWMnfLkp3YrTCJLKcwmf6pAwU=;
        b=js++n0NRJen2XGkBHgvAIHdPTPkhRBUPWKZQ6vo3CNctLpSU4HmHjCBV3GpZs0arOaB9fS
        GYiiC1gEbtWPFRBq/AIfqc1YKJr8jzeZP2m4CKjtz7+eLjj3RYm69G+zS5T72vn91jjQq3
        yHzhXrdLsEJLtTs7KTrRnFz7pEJjETAfYeDvJn6qBOH5rIlFlYTg6t6IoifInB9N2+0Lt4
        MbNMtBmxGuBx3K97aM/BqCYAnwcuyTtKVWZz1vnj9WmneoA6p5jwO1uKyZX3yetCJuQQw3
        R5DMuprW9ZGmFIeo5axO+VFAoP3QB2xoIMF6MNjbXFrZFs/71NO/zUKPNwLZlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898811;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=76aaEtLvtb96qbgKQMJWMnfLkp3YrTCJLKcwmf6pAwU=;
        b=sNpNRFUq4K3w3ba6E1VU39MVmUf7JwZjdcBCMRpYXElFdawS8Dll0sFkaKavMR8gPYCeqp
        h4WUoZB7tdI7/iBQ==
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86: Share definition of __is_canonical_address()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220131072453.2839535-3-adrian.hunter@intel.com>
References: <20220131072453.2839535-3-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <164389881004.16921.2715409372429832557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1fb85d06ad6754796cd1b920639ca9d8840abefd
Gitweb:        https://git.kernel.org/tip/1fb85d06ad6754796cd1b920639ca9d8840abefd
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 31 Jan 2022 09:24:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:42 +01:00

x86: Share definition of __is_canonical_address()

Reduce code duplication by moving canonical address code to a common header
file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220131072453.2839535-3-adrian.hunter@intel.com
---
 arch/x86/events/intel/pt.c  | 14 ++------------
 arch/x86/include/asm/page.h | 10 ++++++++++
 arch/x86/kvm/emulate.c      |  4 ++--
 arch/x86/kvm/x86.c          |  2 +-
 arch/x86/kvm/x86.h          |  7 +------
 arch/x86/mm/maccess.c       |  7 +------
 6 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 0ebcf9a..93676a5 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1350,20 +1350,10 @@ static void pt_addr_filters_fini(struct perf_event *event)
 }
 
 #ifdef CONFIG_X86_64
-static u64 canonical_address(u64 vaddr, u8 vaddr_bits)
-{
-	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
-}
-
-static u64 is_canonical_address(u64 vaddr, u8 vaddr_bits)
-{
-	return canonical_address(vaddr, vaddr_bits) == vaddr;
-}
-
 /* Clamp to a canonical address greater-than-or-equal-to the address given */
 static u64 clamp_to_ge_canonical_addr(u64 vaddr, u8 vaddr_bits)
 {
-	return is_canonical_address(vaddr, vaddr_bits) ?
+	return __is_canonical_address(vaddr, vaddr_bits) ?
 	       vaddr :
 	       -BIT_ULL(vaddr_bits - 1);
 }
@@ -1371,7 +1361,7 @@ static u64 clamp_to_ge_canonical_addr(u64 vaddr, u8 vaddr_bits)
 /* Clamp to a canonical address less-than-or-equal-to the address given */
 static u64 clamp_to_le_canonical_addr(u64 vaddr, u8 vaddr_bits)
 {
-	return is_canonical_address(vaddr, vaddr_bits) ?
+	return __is_canonical_address(vaddr, vaddr_bits) ?
 	       vaddr :
 	       BIT_ULL(vaddr_bits - 1) - 1;
 }
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 4d5810c..9cc82f3 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -71,6 +71,16 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 extern bool __virt_addr_valid(unsigned long kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
 
+static __always_inline u64 __canonical_address(u64 vaddr, u8 vaddr_bits)
+{
+	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
+}
+
+static __always_inline u64 __is_canonical_address(u64 vaddr, u8 vaddr_bits)
+{
+	return __canonical_address(vaddr, vaddr_bits) == vaddr;
+}
+
 #endif	/* __ASSEMBLY__ */
 
 #include <asm-generic/memory_model.h>
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 5719d8c..40da8c7 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -665,7 +665,7 @@ static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
 static inline bool emul_is_noncanonical_address(u64 la,
 						struct x86_emulate_ctxt *ctxt)
 {
-	return get_canonical(la, ctxt_virt_addr_bits(ctxt)) != la;
+	return !__is_canonical_address(la, ctxt_virt_addr_bits(ctxt));
 }
 
 /*
@@ -715,7 +715,7 @@ static __always_inline int __linearize(struct x86_emulate_ctxt *ctxt,
 	case X86EMUL_MODE_PROT64:
 		*linear = la;
 		va_bits = ctxt_virt_addr_bits(ctxt);
-		if (get_canonical(la, va_bits) != la)
+		if (!__is_canonical_address(la, va_bits))
 			goto bad;
 
 		*max_size = min_t(u64, ~0u, (1ull << va_bits) - la);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 74b53a1..197209f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1735,7 +1735,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		 * value, and that something deterministic happens if the guest
 		 * invokes 64-bit SYSENTER.
 		 */
-		data = get_canonical(data, vcpu_virt_addr_bits(vcpu));
+		data = __canonical_address(data, vcpu_virt_addr_bits(vcpu));
 		break;
 	case MSR_TSC_AUX:
 		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 635b75f..fc4b68a 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -211,14 +211,9 @@ static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 	return kvm_read_cr4_bits(vcpu, X86_CR4_LA57) ? 57 : 48;
 }
 
-static inline u64 get_canonical(u64 la, u8 vaddr_bits)
-{
-	return ((int64_t)la << (64 - vaddr_bits)) >> (64 - vaddr_bits);
-}
-
 static inline bool is_noncanonical_address(u64 la, struct kvm_vcpu *vcpu)
 {
-	return get_canonical(la, vcpu_virt_addr_bits(vcpu)) != la;
+	return !__is_canonical_address(la, vcpu_virt_addr_bits(vcpu));
 }
 
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 92ec176..5a53c2c 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -4,11 +4,6 @@
 #include <linux/kernel.h>
 
 #ifdef CONFIG_X86_64
-static __always_inline u64 canonical_address(u64 vaddr, u8 vaddr_bits)
-{
-	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
-}
-
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	unsigned long vaddr = (unsigned long)unsafe_src;
@@ -19,7 +14,7 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 	 * we also need to include the userspace guard page.
 	 */
 	return vaddr >= TASK_SIZE_MAX + PAGE_SIZE &&
-	       canonical_address(vaddr, boot_cpu_data.x86_virt_bits) == vaddr;
+	       __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
 }
 #else
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
