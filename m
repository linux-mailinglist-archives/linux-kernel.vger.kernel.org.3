Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290644CA827
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbiCBOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243084AbiCBO3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:29:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FCA56421
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231311; x=1677767311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iBQ+LEtis0tXpyQ6lUaVrLGKia4klRfYbp2til+UWeY=;
  b=nzeGbdIhbeA3VMdINdAKTlhSOgS2iFzkm0Y8zjCrbaGm7lII3bIwG8zF
   xMdqPKJsl37wS/xn9Fjwq1axstjQklvRI42LioOr/nZZVkKJvolCCq+Rx
   UwjmRleIYXmwhCese826jL5Kh+65eLHGKtGGIKM4t7LALJCiypyWd77e7
   R9mPYomus9a+cQN7EAqCizf7/1UtTTn1KeRgPP/1bE2934TVedaJ0aNpB
   MYp/fATWlip64pQnMwRRxjBeexOf8OWb5Y8yIx4b4Npn0s2mYT3e7tZBB
   PjpKT/uiMrz+9iIaH8DsP93MPVSlMRcNpk4jUm4lPvi0MmPAQnwx4cj7C
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233376511"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="233376511"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="545512491"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Mar 2022 06:28:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1CAD1607; Wed,  2 Mar 2022 16:28:13 +0200 (EET)
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
Subject: [PATCHv5 26/30] x86/mm/cpa: Add support for TDX shared memory
Date:   Wed,  2 Mar 2022 17:28:02 +0300
Message-Id: <20220302142806.51844-27-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
 arch/x86/coco/core.c    |   1 +
 arch/x86/coco/tdx.c     | 101 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c |   2 +-
 3 files changed, 103 insertions(+), 1 deletion(-)

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
index c82e8eda8c8b..2168ee25a52c 100644
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
@@ -495,6 +500,98 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
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
 	unsigned int gpa_width;
@@ -526,5 +623,9 @@ void __init tdx_early_init(void)
 	 */
 	cc_set_mask(BIT_ULL(gpa_width - 1));
 
+	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
+	x86_platform.guest.enc_tlb_flush_required = tdx_tlb_flush_required;
+	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1c3cb952fa2a..080f21171b27 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1308,7 +1308,7 @@ static void ve_raise_fault(struct pt_regs *regs, long error_code)
  *
  * In the settings that Linux will run in, virtualization exceptions are
  * never generated on accesses to normal, TD-private memory that has been
- * accepted.
+ * accepted (by BIOS or with tdx_enc_status_changed()).
  *
  * Syscall entry code has a critical window where the kernel stack is not
  * yet set up. Any exception in this window leads to hard to debug issues
-- 
2.34.1

