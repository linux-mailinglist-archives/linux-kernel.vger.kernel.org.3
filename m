Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAF4BBD3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiBRQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:17:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiBRQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6EF22BC5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201039; x=1676737039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zLqkYC/j0gcQLYGXerlmeaKorpD4g3v15vrGt/8wXZc=;
  b=JdNQDO3FMU5mQ71VnrPG7u7r3HYXnD7JEAAcBYkZgDxP/hAWVZnrqXH4
   oHtOkGf6FaJK0S+ouKViYWnm9tmDbVa0mVeLdnzXrSbqdA0MNxrYZESCV
   /8uiNv3iDx1sSX2guiySRRbfF6qCEk3uO8iCexEiPxrg718rKI+BXpBvP
   tufUolAspwxZ8QTxYwLiZbZ6NzLJRwJ/Z91C7S5RJwvuhAZUqydKKEJy1
   LMSgN7ssHZkCpElhYXsTAvawWK3rsI6RvAelYLBx9B265z2H31S+gehO3
   u9eBgjehL8OX4WOYg/cUK77aJn0fcU6bNcGRQVbmOZP3G5pfwRtI3AkzY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248752945"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="248752945"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="637782158"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2022 08:17:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5667884D; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 06/32] x86/tdx: Extend the confidential computing API to support TDX guests
Date:   Fri, 18 Feb 2022 19:16:52 +0300
Message-Id: <20220218161718.67148-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Like AMD SME/SEV, TDX uses a bit in the page table entry to indicate
encryption status of the page, but the polarity of the mask is
opposite to AMD: if the bit is set the page is accessible to VMM.

Details about which bit in the page table entry to be used to indicate
shared/private state can be determined by using the TDINFO TDCALL.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig              |  1 +
 arch/x86/coco/tdx.c           | 44 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cc_platform.c |  6 +++++
 3 files changed, 51 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ea4190c53db6..581aaff0ccee 100644
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
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 89367fa576c1..87e561c5b4e3 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -5,8 +5,17 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <asm/coco.h>
 #include <asm/tdx.h>
 
+/* TDX module Call Leaf IDs */
+#define TDX_GET_INFO			1
+
+static struct {
+	unsigned int gpa_width;
+	unsigned long attributes;
+} td_info __ro_after_init;
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -25,9 +34,34 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 	return __tdx_hypercall(&args, 0);
 }
 
+static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
+				   struct tdx_module_output *out)
+{
+	if (__tdx_module_call(fn, rcx, rdx, r8, r9, out))
+		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
+}
+
+static void get_info(void)
+{
+	struct tdx_module_output out;
+
+	/*
+	 * TDINFO TDX module call is used to get the TD execution environment
+	 * information like GPA width, number of available vcpus, debug mode
+	 * information, etc. More details about the ABI can be found in TDX
+	 * Guest-Host-Communication Interface (GHCI), section 2.4.2 TDCALL
+	 * [TDG.VP.INFO].
+	 */
+	tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
+
+	td_info.gpa_width = out.rcx & GENMASK(5, 0);
+	td_info.attributes = out.rdx;
+}
+
 void __init tdx_early_init(void)
 {
 	u32 eax, sig[3];
+	u64 mask;
 
 	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
 
@@ -36,5 +70,15 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	get_info();
+
+	/*
+	 * The highest bit of a guest physical address is the "sharing" bit.
+	 * Set it for shared pages and clear it for private pages.
+	 */
+	mask = BIT_ULL(td_info.gpa_width - 1);
+
+	cc_init(CC_VENDOR_INTEL, mask);
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 93e6be7b7eca..dba713c444ab 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -90,6 +90,8 @@ u64 cc_get_mask(bool enc)
 	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return enc ? cc_mask : 0;
+	case CC_VENDOR_INTEL:
+		return enc ? 0 : cc_mask;
 	default:
 		return 0;
 	}
@@ -100,6 +102,8 @@ u64 cc_mkenc(u64 val)
 	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val | cc_mask;
+	case CC_VENDOR_INTEL:
+		return val & ~cc_mask;
 	default:
 		return val;
 	}
@@ -110,6 +114,8 @@ u64 cc_mkdec(u64 val)
 	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
 		return val & ~cc_mask;
+	case CC_VENDOR_INTEL:
+		return val | cc_mask;
 	default:
 		return val;
 	}
-- 
2.34.1

