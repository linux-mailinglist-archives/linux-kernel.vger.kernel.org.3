Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39EB4C30A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiBXP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbiBXP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E47E22B38
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718201; x=1677254201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4CAGEue28CSAv5dFniItlUtImlUxHadBv6bonwqT43o=;
  b=meMp58/xVrf1FjBEWfAu7Wzw8ApyavONxnLL+Q9ETOF3RrTXDaky7bco
   Crl6e8Imbd0GvOJeODsbJlGEZEZVYN30jet3PUgnqiqbieyZsFu7YuFwW
   8ez1dRUp7nrU3HpEPqbPsoXWeGv0b+AFwIBvL0gqvd35cbqAHkh5HOHiY
   N3ciX0PNsT50Lk6FbuCS3RxwdsZez3lDMyd5O8znWjAEq1yqov4fh4erQ
   yQjPDmaaEr9h3Ny7QAPGPDOQe3uJX/T8d7sZfuF/ZHtiGd75MTT84RCr3
   HC2UQO4JlHPfX6zrB0YHUe8iyLMeWZic+AhRY6HCMX8DQoNs1wtRWB/wg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="251094406"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="251094406"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639761340"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Feb 2022 07:56:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 8C257B83; Thu, 24 Feb 2022 17:56:35 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 26/30] x86/mm/cpa: Add support for TDX shared memory
Date:   Thu, 24 Feb 2022 18:56:26 +0300
Message-Id: <20220224155630.52734-27-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel TDX protects guest memory from VMM access. Any memory that is
required for communication with the VMM must be explicitly shared.

It is a two-step process: the guest sets the shared bit in the page
table entry and notifies VMM about the change. The notification happens
using MapGPA hypercall.

Conversion back to private memory requires clearing the shared bit,
notifying VMM with MapGPA hypercall following with accepting the memory
with AcceptPage hypercall.

Provide a TDX version of x86_platform.guest.* callbacks. It makes
__set_memory_enc_pgtable() work right in TDX guest.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/core.c |   1 +
 arch/x86/coco/tdx.c  | 101 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 54344122e2fe..9778cf4c6901 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -21,6 +21,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_HOTPLUG_DISABLED:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return true;
 	default:
 		return false;
diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index 6306ef19584f..da2ae399ea71 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -10,10 +10,15 @@
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/x86_init.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_ACCEPT_PAGE			6
+
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -456,6 +461,98 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 	return ret;
 }
 
+static bool tdx_tlb_flush_required(bool enc)
+{
+	/*
+	 * TDX guest is responsible for flushing caches on private->shared
+	 * transition. VMM is responsible for flushing on shared->private.
+	 */
+	return !enc;
+}
+
+static bool tdx_cache_flush_required(void)
+{
+	return true;
+}
+
+static bool accept_page(phys_addr_t gpa, enum pg_level pg_level)
+{
+	/*
+	 * Pass the page physical address to the TDX module to accept the
+	 * pending, private page.
+	 *
+	 * Bits 2:0 of GPA encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
+	 */
+	switch (pg_level) {
+	case PG_LEVEL_4K:
+		break;
+	case PG_LEVEL_2M:
+		gpa |= 1;
+		break;
+	case PG_LEVEL_1G:
+		gpa |= 2;
+		break;
+	default:
+		return false;
+	}
+
+	return !__tdx_module_call(TDX_ACCEPT_PAGE, gpa, 0, 0, 0, NULL);
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest.  The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (!enc) {
+		start |= cc_mkdec(0);
+		end |= cc_mkdec(0);
+	}
+
+	/*
+	 * Notify the VMM about page mapping conversion. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
+	 * section "TDG.VP.VMCALL<MapGPA>"
+	 */
+	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+		return false;
+
+	/* private->shared conversion  requires only MapGPA call */
+	if (!enc)
+		return true;
+
+	/*
+	 * For shared->private conversion, accept the page using
+	 * TDX_ACCEPT_PAGE TDX module call.
+	 */
+	while (start < end) {
+		/* Try if 1G page accept is possible */
+		if (!(start & ~PUD_MASK) && end - start >= PUD_SIZE &&
+		    accept_page(start, PG_LEVEL_1G)) {
+			start += PUD_SIZE;
+			continue;
+		}
+
+		/* Try if 2M page accept is possible */
+		if (!(start & ~PMD_MASK) && end - start >= PMD_SIZE &&
+		    accept_page(start, PG_LEVEL_2M)) {
+			start += PMD_SIZE;
+			continue;
+		}
+
+		if (!accept_page(start, PG_LEVEL_4K))
+			return false;
+		start += PAGE_SIZE;
+	}
+
+	return true;
+}
+
 void __init tdx_early_init(void)
 {
 	u32 eax, sig[3];
@@ -486,5 +583,9 @@ void __init tdx_early_init(void)
 	 */
 	cc_set_mask(BIT_ULL(td_info.gpa_width - 1));
 
+	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
+	x86_platform.guest.enc_tlb_flush_required = tdx_tlb_flush_required;
+	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
+
 	pr_info("Guest detected\n");
 }
-- 
2.34.1

