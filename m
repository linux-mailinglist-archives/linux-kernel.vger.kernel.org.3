Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19624DDD03
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiCRPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbiCRPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:32:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C1F1B7624
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617467; x=1679153467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uNm+fl5+SRYSH6fmORtBED/Ic8hO0OtQFRhFzfeJrJo=;
  b=ltSfFEd0WwAzXhHTJUZrLCazfg7ATbd6RKzQHSfVcMfIeDoPyzppDLqB
   FrUlVsy0JunKbl4Yho6LWbr0pWJKZGksSX5TFRdQk5qo7FsfC9AhpyBf9
   QR8gv27rmcBVHFE/OxklsGK256lmRzycHJdhut9qhmISFmyhly2AMcJ3H
   uN2H6qDRBGxesvJ7N0ANddGMgZTI0tYSjJYcCt+Oh4e/DHBLYAiViFLD4
   FnYTHtOKagrKLclm8lb0kCbeNXDoAAhFn6xUvvtuy2j2ZvMN2uRCX6cj6
   9qfToubOOAl28NDQm4rGJBIfr+2XLrhHG058qM/7yWffqSEj2o3x9Sp+D
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="257344046"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257344046"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="784269859"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 18 Mar 2022 08:30:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 03224B02; Fri, 18 Mar 2022 17:30:50 +0200 (EET)
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
Subject: [PATCHv7 26/30] x86/mm/cpa: Add support for TDX shared memory
Date:   Fri, 18 Mar 2022 18:30:44 +0300
Message-Id: <20220318153048.51177-27-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/coco/core.c    |   1 +
 arch/x86/coco/tdx/tdx.c | 151 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/traps.c |   2 +-
 3 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 70956f9d7c7e..9f74125c582d 100644
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
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f50f530aff5f..1a8ac2f08bd4 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
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
@@ -531,6 +536,148 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve)
 	return ret;
 }
 
+static bool tdx_tlb_flush_required(bool private)
+{
+	/*
+	 * TDX guest is responsible for flushing TLB on private->shared
+	 * transition. VMM is responsible for flushing on shared->private.
+	 *
+	 * The VMM _can't_ flush private addresses as it can't generate PAs
+	 * with the guest's HKID.  Shared memory isn't subject to integrity
+	 * checking, i.e. the VMM doesn't need to flush for its own protection.
+	 *
+	 * There's no need to flush when converting from shared to private,
+	 * as flushing is the VMM's responsibility in this case, e.g. it must
+	 * flush to avoid integrity failures in the face of a buggy or
+	 * malicious guest.
+	 */
+	return !private;
+}
+
+static bool tdx_cache_flush_required(void)
+{
+	/*
+	 * AMD SME/SEV can avoid cache flushing if HW enforces cache coherence.
+	 * TDX doesn't have such capability.
+	 *
+	 * Flush cache unconditionally.
+	 */
+	return true;
+}
+
+static bool accept_page(phys_addr_t gpa, enum pg_level pg_level)
+{
+	u8 page_size;
+	u64 tdcall_rcx;
+
+	/*
+	 * Pass the page physical address to the TDX module to accept the
+	 * pending, private page.
+	 *
+	 * Bits 2:0 of RCX encode page size: 0 - 4K, 1 - 2M, 2 - 1G.
+	 */
+	switch (pg_level) {
+	case PG_LEVEL_4K:
+		page_size = 0;
+		break;
+	case PG_LEVEL_2M:
+		page_size = 1;
+		break;
+	case PG_LEVEL_1G:
+		page_size = 2;
+		break;
+	default:
+		return false;
+	}
+
+	tdcall_rcx = gpa | page_size;
+	return !__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL);
+}
+
+static inline enum pg_level size_to_level(unsigned long size)
+{
+	switch (size) {
+	case PUD_SIZE:
+		return PG_LEVEL_1G;
+	case PMD_SIZE:
+		return PG_LEVEL_2M;
+	case PAGE_SIZE:
+		return PG_LEVEL_4K;
+	default:
+		BUILD_BUG();
+	}
+}
+
+static bool try_accept_one(phys_addr_t *start, unsigned long len,
+			  unsigned long accept_size)
+{
+	if (!IS_ALIGNED(*start, accept_size))
+		return false;
+
+	if (len < accept_size)
+		return false;
+
+	if (!accept_page(*start, size_to_level(accept_size)))
+		return false;
+
+	*start += accept_size;
+	return true;
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
+	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (!enc) {
+		/* Set the shared (decrypted) bits: */
+		start |= cc_mkdec(0);
+		end   |= cc_mkdec(0);
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
+		unsigned long len = end - start;
+
+		/*
+		 * Try larger accepts first. It gives chance to VMM to keep
+		 * 1G/2M SEPT entries where possible and speeds up process by
+		 * cutting number of hypercalls (if successful).
+		 */
+
+		if (try_accept_one(&start, len, PUD_SIZE))
+			continue;
+
+		if (try_accept_one(&start, len, PMD_SIZE))
+			continue;
+
+		if (!try_accept_one(&start, len, PAGE_SIZE))
+			return false;
+	}
+
+	return true;
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -555,5 +702,9 @@ void __init tdx_early_init(void)
 	 */
 	physical_mask &= cc_mask - 1;
 
+	x86_platform.guest.enc_cache_flush_required = tdx_cache_flush_required;
+	x86_platform.guest.enc_tlb_flush_required   = tdx_tlb_flush_required;
+	x86_platform.guest.enc_status_change_finish = tdx_enc_status_changed;
+
 	pr_info("Guest detected\n");
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a77103e541bf..962c7f531bf9 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1302,7 +1302,7 @@ static void ve_raise_fault(struct pt_regs *regs, long error_code)
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

