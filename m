Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E068498300
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiAXPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:04:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:5640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243216AbiAXPDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036591; x=1674572591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f42jF0db27DH6xwdarJr96m9QIQKkwx3aAFrMyHkc2s=;
  b=Q1IUitG/tapnBqr6cYEDbEKs/shuc+RYvFfBeXJVZe6Bo6OuDvJzUdMg
   bLxrjAo8pLnUqexCOQZVlPjTCjPVf50lJFl8yz02MIgJE6H3dm3bCvdU1
   CNsquyXxsXMI/TqnHYsXpD8RUZRbX365rmGlzBgva3KABtyJ5zjUc7hNP
   NugkJwtgwTF45m22yqogCdjGU73AlnxCGnvtn7ASP0AlE5kfwzw1KCuuK
   XsxTEEdvCKglUL/V2zlYzAc259LUROt51X899jAp+AT1D7iabvSaz8WEb
   yb64yzPPcC/AQjTqFAaTxcj52kCD/4klIQ7jZXys14Q/nPYTyvhbB9y5x
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226043250"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226043250"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="532102276"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2022 07:02:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 11AA6A8F; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 15/29] x86/tdx: Wire up KVM hypercalls
Date:   Mon, 24 Jan 2022 18:02:01 +0300
Message-Id: <20220124150215.36893-16-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

KVM hypercalls use the VMCALL or VMMCALL instructions. Although the ABI
is similar, those instructions no longer function for TDX guests.

Make vendor-specific TDVMCALLs instead of VMCALL. This enables TDX
guests to run with KVM acting as the hypervisor.

Among other things, KVM hypercall is used to send IPIs.

Since the KVM driver can be built as a kernel module, export
tdx_kvm_hypercall() to make the symbols visible to kvm.ko.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/kvm_para.h | 22 ++++++++++++++++++++++
 arch/x86/include/asm/tdx.h      | 11 +++++++++++
 arch/x86/kernel/tdx.c           | 15 +++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 56935ebb1dfe..57bc74e112f2 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -7,6 +7,8 @@
 #include <linux/interrupt.h>
 #include <uapi/asm/kvm_para.h>
 
+#include <asm/tdx.h>
+
 #ifdef CONFIG_KVM_GUEST
 bool kvm_check_and_clear_guest_paused(void);
 #else
@@ -32,6 +34,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 static inline long kvm_hypercall0(unsigned int nr)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, 0, 0, 0, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr)
@@ -42,6 +48,10 @@ static inline long kvm_hypercall0(unsigned int nr)
 static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, p1, 0, 0, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1)
@@ -53,6 +63,10 @@ static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
 				  unsigned long p2)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, p1, p2, 0, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2)
@@ -64,6 +78,10 @@ static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
 				  unsigned long p2, unsigned long p3)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, p1, p2, p3, 0);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3)
@@ -76,6 +94,10 @@ static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
 				  unsigned long p4)
 {
 	long ret;
+
+	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return tdx_kvm_hypercall(nr, p1, p2, p3, p4);
+
 	asm volatile(KVM_HYPERCALL
 		     : "=a"(ret)
 		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3), "S"(p4)
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8013686192fd..4bcaadf21dc6 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -65,4 +65,15 @@ static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
+#if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
+long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
+		       unsigned long p3, unsigned long p4);
+#else
+static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
+				     unsigned long p2, unsigned long p3,
+				     unsigned long p4)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index ebb29dfb3ad4..a4e696f12666 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -44,6 +44,21 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
 	return out->r10;
 }
 
+#ifdef CONFIG_KVM_GUEST
+long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
+		       unsigned long p3, unsigned long p4)
+{
+	struct tdx_hypercall_output out;
+
+	/* Non zero return value indicates buggy TDX module, so panic */
+	if (__tdx_hypercall(nr, p1, p2, p3, p4, 0, &out))
+		panic("KVM hypercall %u failed. Buggy TDX module?\n", nr);
+
+	return out.r10;
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
+#endif
+
 static u64 __cpuidle _tdx_halt(const bool irq_disabled, const bool do_sti)
 {
 	/*
-- 
2.34.1

