Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293E44DA7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353195AbiCPCMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352886AbiCPCL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:11:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313935E755
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647396614; x=1678932614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVf2ACi71s3OExXIWpoefEZeQTLvuuj6c+ykWE7It30=;
  b=DGaszLwZGWRE9UA0CU+pFGKMyQEavEXovCsG2jWfMwwKEbYJHHvDj9q7
   SPng62+SnJmGitvcByEeFJEOWD1Y3o7nPE/66jRZKCb3c2IBTlSFmBfs9
   r/2MBYy7vXM8Y7bjhADN/UZlkqg3PwtufLGi4K5K36ICdKRjqSaH2M/U0
   /L/7qSJS6ziIDhqUyS2q7pauVtkMo08XOYzYQlOc54iluQ39MdYGaB4rT
   wrCLiTaSmJr4pZJHorkMzmDAu7Bs02O17ocjVaQTEJAsNzGyZ5QUeEqsh
   dzoWFAEyL/4MBS7Jb4dRGiRQebv0eqi5Sm64AA9YL5I7tw7zLspSUsFpM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238636676"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="238636676"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="598535271"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2022 19:10:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7DB7E91A; Wed, 16 Mar 2022 04:10:10 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 19/30] x86/tdx: Wire up KVM hypercalls
Date:   Wed, 16 Mar 2022 05:08:45 +0300
Message-Id: <20220316020856.24435-20-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/coco/tdx/tdx.c         | 17 +++++++++++++++++
 arch/x86/include/asm/kvm_para.h | 22 ++++++++++++++++++++++
 arch/x86/include/asm/tdx.h      | 11 +++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 9c331e291bc6..09e121619d35 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -64,6 +64,23 @@ static u64 hcall_func(u64 exit_reason)
 	return exit_reason;
 }
 
+#ifdef CONFIG_KVM_GUEST
+long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
+		       unsigned long p3, unsigned long p4)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = nr,
+		.r11 = p1,
+		.r12 = p2,
+		.r13 = p3,
+		.r14 = p4,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
+EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
+#endif
+
 /*
  * Used for TDX guests to make calls directly to the TD module.  This
  * should only be used for calls that have no legitimate reason to fail
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
index c70d9bc74b67..ea92641dd1f8 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -75,5 +75,16 @@ static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
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
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
-- 
2.34.1

