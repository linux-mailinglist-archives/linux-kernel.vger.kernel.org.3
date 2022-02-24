Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0064C30A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiBXP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiBXP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAE06254
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718199; x=1677254199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xp0xgqqv4QlVaVqygotoWIoNj1oLYlEvw9zIP2LN2X0=;
  b=VKfYWpZWQJbR4wOrTSJraDvrmGUyuY7MOhzlHvv8u913fLMEjKCLhGCr
   TyjWoG4ZW+R/2Sfc0LbwejZn5eYEme9Cgca7OHL0FdTpzKkuC1XCt/b6I
   7+WeQJ1vysBzJnIvBB0i1hEdIlzMwQW+osJYjvoppHSpQxd5Tm65ms8hr
   ztIn2j8VmGI91ZeftwuHsSmrWEZ7u9HWJD5m6fkEnPMIAPbslnPijnFF4
   t2vjWgLBL0kTrqHkeanJykUhsYbP8S96Or5gTJeWoh4RosMICXH/XgaDV
   5KjfaH+V/tRU/cpj6v4nbmxShn4lB8FS9cUf+irIdsngGfBITklAMIloL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="249849321"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="249849321"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="628513011"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2022 07:56:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2A0E8ABF; Thu, 24 Feb 2022 17:56:35 +0200 (EET)
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
Subject: [PATCHv4 19/30] x86/tdx: Wire up KVM hypercalls
Date:   Thu, 24 Feb 2022 18:56:19 +0300
Message-Id: <20220224155630.52734-20-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/coco/tdx.c             | 17 +++++++++++++++++
 arch/x86/include/asm/kvm_para.h | 22 ++++++++++++++++++++++
 arch/x86/include/asm/tdx.h      | 11 +++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 0d2a4c947a6c..6306ef19584f 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -48,6 +48,23 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 	return __tdx_hypercall(&args, 0);
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
 static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 				   struct tdx_module_output *out)
 {
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
index ba0f8c2b185c..6a97d42b0de9 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,5 +67,16 @@ static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
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

