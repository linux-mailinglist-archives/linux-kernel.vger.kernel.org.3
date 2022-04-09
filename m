Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76184FA12A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiDIBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbiDIBa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:30:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A4118661;
        Fri,  8 Apr 2022 18:27:43 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467662;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtsK9jOzHJeRr5Z6QvFU2509e8uykkDBpfaap+m00lc=;
        b=nDYEe6SmIX3nddo7JkduwZMbtJOVESsNIRE/xXFZv5CQdxjWaZq1WUqSloQFZropNTqApB
        LpLqJ3YFf2Wu+9tTL66OGSDJBltHZj9NWFP35FYy0OW5eobAOrGPSLYFV+1OcCpVSKnDq/
        DROzlCE6PBaHRmlI3u+vXPpjoo3H5CwJgptrOW1+DFgec+ysgoqm/yXo3PYIr7wnbYhzso
        RLyosBpFPE9BpPuDj99vZjlEertRDMwpGa9lGxiWmIz/hKbUGWV3pI7UOyeL2u7311OMgE
        7OQmpfAHTX5Ax3UG34xzj4MRduyjutKhfxztgPbYWLt9obfkCSiltDQk3xCLhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467662;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtsK9jOzHJeRr5Z6QvFU2509e8uykkDBpfaap+m00lc=;
        b=aL+bzKm05/H76paVTQOIADhAypuDKaWIoWYoNzMpAyoRV8159U1CwGRIpGuhykunb+GJbi
        U9H+eAnR+FvEF8Dg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Extend the confidential computing API to
 support TDX guests
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-5-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946766092.4207.2489904492168561416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     41394e33f3a0ce791caf0e086e1fca850832ddec
Gitweb:        https://git.kernel.org/tip/41394e33f3a0ce791caf0e086e1fca850832ddec
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:13 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:50 -07:00

x86/tdx: Extend the confidential computing API to support TDX guests

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-5-kirill.shutemov@linux.intel.com
---
 arch/x86/Kconfig        |  1 +-
 arch/x86/coco/core.c    | 12 ++++++++++-
 arch/x86/coco/tdx/tdx.c | 47 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4ae2732..984315c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -882,6 +882,7 @@ config INTEL_TDX_GUEST
 	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
+	select ARCH_HAS_CC_PLATFORM
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index fc1365d..3f30087 100644
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
index 4b57880..96b2611 100644
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
@@ -31,8 +35,47 @@ void __tdx_hypercall_failed(void)
 	panic("TDVMCALL failed. TDX module bug?");
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
+static u64 get_cc_mask(void)
+{
+	struct tdx_module_output out;
+	unsigned int gpa_width;
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
+	gpa_width = out.rcx & GENMASK(5, 0);
+
+	/*
+	 * The highest bit of a guest physical address is the "sharing" bit.
+	 * Set it for shared pages and clear it for private pages.
+	 */
+	return BIT_ULL(gpa_width - 1);
+}
+
 void __init tdx_early_init(void)
 {
+	u64 cc_mask;
 	u32 eax, sig[3];
 
 	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
@@ -42,5 +85,9 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	cc_set_vendor(CC_VENDOR_INTEL);
+	cc_mask = get_cc_mask();
+	cc_set_mask(cc_mask);
+
 	pr_info("Guest detected\n");
 }
