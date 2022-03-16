Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4E4DA7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiCPCL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352482AbiCPCLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:11:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5775E5C870
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647396601; x=1678932601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K9ccyoRyKpPhHnME3CS6meHqr4j9tmDsf2tq2U92VoI=;
  b=MQimyu9M4g0SSgTlVY0eUwWdTETwGmK5PAmef3Rc6MTIK0EOmyRMGCPi
   uCkG/Djo6SlV1kluJz/ycOiwN2X4lYp7wZYd9Jd+0xXUfL767HJogX+AT
   D2HLZEFajY+na7U6iHf0p0zug0+jTTrLb/MyLrUPAGArt2xdT/N6YEk9a
   BOvvtK9C4nIbVXdYMf8/iU/pTgtPLS/a/wGxuuuKlxxm8W+XsmYa03e+S
   aOOkT5X5GSS+s8z6j+cKbB7ehwk2GxH0kWJDUL0HYaqmx3KJ8O67QW/dv
   QJ04rtTQzyPDrxNWUe8klAH1el6RyhwstVVrWMkwcUo0WHKmWlVc3EaJ5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319688239"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="319688239"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="820279266"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Mar 2022 19:09:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id AA75A569; Wed, 16 Mar 2022 04:10:09 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCHv6 04/30] x86/tdx: Extend the confidential computing API to support TDX guests
Date:   Wed, 16 Mar 2022 05:08:30 +0300
Message-Id: <20220316020856.24435-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Kconfig        |  1 +
 arch/x86/coco/core.c    | 12 +++++++++++
 arch/x86/coco/tdx/tdx.c | 47 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

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
index fc1365dd927e..3f3008783e05 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -87,9 +87,18 @@ EXPORT_SYMBOL_GPL(cc_platform_has);
 
 u64 cc_mkenc(u64 val)
 {
+	/*
+	 * Both AMD and Intel use a bit in the page table to indicate
+	 * encryption status of the page.
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
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f6bd042b7bed..9ac066fb3912 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
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
@@ -30,8 +34,41 @@ void __tdx_hypercall_failed(void)
 {
 	panic("TDVMCALL failed. TDX module bug?");
 }
+
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
@@ -41,5 +78,15 @@ void __init tdx_early_init(void)
 
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

