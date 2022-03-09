Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622ED4D3DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238289AbiCIXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiCIXwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:52:11 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D311C7D0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646869872; x=1678405872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yhMxhhr8eo4NC66e5MHzveg2UpYFRTnU3Hn0Y4C6sR0=;
  b=ZwSZvTkE6i1blUjYcaes/Wuj5G/iyr1DNBStWD4fU6Z7OlTUMpb+aLnx
   JceFkYGJomTZ+bpS8vUkrr84/oTh8Z+7WUXd07WTJAjqVZJT2oZINyWxy
   IQsNstb6103nfSyileUoPjg2vTOiTL90iKoj9rX5IRA/q2vfcf//PiYS3
   9Uo4zcDc/K37AARMOxXlh9Zws//WKHfJm6AJuBMSpN37ulYGOMt63oaFa
   FGBiGZpLYj/j5fh4dd/xd7k2z/71GZZYj8EUMs4mMUCX5q/h7EWuHGLaE
   0FdF3lt7B792mXYX22SMTEFjAff+bw/UzgyLLO7E1IBgAirqi+1C0PRUM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318341339"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="318341339"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="510685408"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Mar 2022 15:51:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 670C6211; Thu, 10 Mar 2022 01:51:23 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     dave.hansen@intel.com
Cc:     aarcange@redhat.com, ak@linux.intel.com, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: [PATCHv5.2 04/30] x86/tdx: Extend the confidential computing API to support TDX guests
Date:   Thu, 10 Mar 2022 02:51:21 +0300
Message-Id: <20220309235121.33236-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <79432a51-4d26-1fcb-81f2-6a9e7a44706f@intel.com>
References: <79432a51-4d26-1fcb-81f2-6a9e7a44706f@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Confidential Computing (CC) features (like string I/O unroll support,
memory encryption/decryption support, etc) are conditionally enabled
in the kernel using cc_platform_has() API. Since TDX guests also need
to use these CC features, extend cc_platform_has() API and add TDX
guest-specific CC attributes support.

CC API also provides an interface to deal with encryption mask. Extend
it to cover TDX.

Details about which bit in the page table entry to be used to indicate
shared/private state is determined by using the TDINFO TDCALL.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 v5.2:
  - Update comment for tdx_module_call() definition and for the
    TDX_GET_INFO call site.
---
 arch/x86/Kconfig     |  1 +
 arch/x86/coco/core.c | 12 ++++++++++++
 arch/x86/coco/tdx.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c346d66b51fc..93e67842e369 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
 	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index fc1365dd927e..6529db059938 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -87,9 +87,18 @@ EXPORT_SYMBOL_GPL(cc_platform_has);
 
 u64 cc_mkenc(u64 val)
 {
+	/*
+	 * Both AMD and Intel use a bit in page table to indicate encryption
+	 * status of the page.
+	 *
+	 * - for AMD, bit *set* means the page is encrypted
+	 * - for Intel *clear* means encrypted.
+	 */
 	switch (vendor) {
 	case CC_VENDOR_AMD:
 		return val | cc_mask;
+	case CC_VENDOR_INTEL:
+		return val & ~cc_mask;
 	default:
 		return val;
 	}
@@ -97,9 +106,12 @@ u64 cc_mkenc(u64 val)
 
 u64 cc_mkdec(u64 val)
 {
+	/* See comment in cc_mkenc() */
 	switch (vendor) {
 	case CC_VENDOR_AMD:
 		return val & ~cc_mask;
+	case CC_VENDOR_INTEL:
+		return val | cc_mask;
 	default:
 		return val;
 	}
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index d1ce35c1ac18..b74b3f70f584 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -5,8 +5,12 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <asm/coco.h>
 #include <asm/tdx.h>
 
+/* TDX module Call Leaf IDs */
+#define TDX_GET_INFO			1
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -25,8 +29,40 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 	return __tdx_hypercall(&args, 0);
 }
 
+/*
+ * Used for TDX guests to make calls directly to the TD module.  This
+ * should only be used for calls that have no legitimate reason to fail
+ * or where the kernel can not survive the call failing.
+ */
+static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+				   struct tdx_module_output *out)
+{
+	if (__tdx_module_call(fn, rcx, rdx, r8, r9, out))
+		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
+}
+
+static void get_info(unsigned int *gpa_width)
+{
+	struct tdx_module_output out;
+
+	/*
+	 * TDINFO TDX module call is used to get the TD execution environment
+	 * information like GPA width, number of available vcpus, debug mode
+	 * information, etc. More details about the ABI can be found in TDX
+	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
+	 * [TDG.VP.INFO].
+	 *
+	 * The GPA width that comes out of this call is critical. TDX guests
+	 * can not meaningfully run without it.
+	 */
+	tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
+
+	*gpa_width = out.rcx & GENMASK(5, 0);
+}
+
 void __init tdx_early_init(void)
 {
+	unsigned int gpa_width;
 	u32 eax, sig[3];
 
 	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
@@ -36,5 +72,15 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	get_info(&gpa_width);
+
+	cc_set_vendor(CC_VENDOR_INTEL);
+
+	/*
+	 * The highest bit of a guest physical address is the "sharing" bit.
+	 * Set it for shared pages and clear it for private pages.
+	 */
+	cc_set_mask(BIT_ULL(gpa_width - 1));
+
 	pr_info("Guest detected\n");
 }
-- 
2.34.1

