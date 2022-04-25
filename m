Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39850D7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240824AbiDYDo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240714AbiDYDm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:42:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78D22F02B;
        Sun, 24 Apr 2022 20:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650857990; x=1682393990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UAkTjqMUWj3U88352d4TWKeyPDjEnADBaQUiU5n9fSE=;
  b=StYn3UrmFLVazORhqRmojlemplxSDSVvWyE/3VqQsfGYzX4PQPr3RSIE
   uEMIsNrtLbAvayhVJppa7StWqZLXs6nJum80cmjG1avZHS35sGJJf0vDm
   f4Vo0MQIlBzSpGahVHTrrlRE2hDpj6Ly0jiNMsGIQua4a31/NjZi260b8
   VRgqiYM1bRAWxteHOPDGJvtACvn28dOUZQqNwL1hB+HhiItajbgv6SmP4
   bjJFbeB0sGgcXBIj+Dq1GzKf8Oa3wl3hd8rT+uJbXW99bg3wg3lbsAQVE
   V17ezgc6LoO7tdk8Ke1PnIJzvgIJTNtXnvdcJdFWRingnsFl8lYJlsMaF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="328064267"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="328064267"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 20:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="557501602"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 24 Apr 2022 20:39:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0FAE86EE; Mon, 25 Apr 2022 06:39:36 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 10/12] x86/tdx: Unaccepted memory support
Date:   Mon, 25 Apr 2022 06:39:32 +0300
Message-Id: <20220425033934.68551-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All preparations are complete. Hookup TDX-specific code to accept memory.

Accepting the memory is the same process as converting memory from
shared to private: kernel notifies VMM with MAP_GPA hypercall and then
accept pages with ACCEPT_PAGE module call.

The implementation in core kernel uses tdx_enc_status_changed(). It
already used for converting memory to shared and back for I/O
transactions.

Boot stub provides own implementation of tdx_accept_memory(). It is
similar in structure to tdx_enc_status_changed(), but only cares about
converting memory to private.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/boot/compressed/mem.c    | 24 ++++++++-
 arch/x86/boot/compressed/tdx.c    | 85 +++++++++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c           | 31 +++++++----
 arch/x86/include/asm/shared/tdx.h |  2 +
 arch/x86/mm/unaccepted_memory.c   |  9 +++-
 6 files changed, 141 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7021ec725dd3..e4c31dbea6d7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -885,6 +885,7 @@ config INTEL_TDX_GUEST
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
+	select UNACCEPTED_MEMORY
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index b5058c975d26..539fff27de49 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -5,6 +5,8 @@
 #include "error.h"
 #include "find.h"
 #include "math.h"
+#include "tdx.h"
+#include <asm/shared/tdx.h>
 
 #define PMD_SHIFT	21
 #define PMD_SIZE	(_AC(1, UL) << PMD_SHIFT)
@@ -12,10 +14,30 @@
 
 extern struct boot_params *boot_params;
 
+static bool is_tdx_guest(void)
+{
+	static bool once;
+	static bool is_tdx;
+
+	if (!once) {
+		u32 eax, sig[3];
+
+		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
+			    &sig[0], &sig[2],  &sig[1]);
+		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
+		once = true;
+	}
+
+	return is_tdx;
+}
+
 static inline void __accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	/* Platform-specific memory-acceptance call goes here */
-	error("Cannot accept memory");
+	if (is_tdx_guest())
+		tdx_accept_memory(start, end);
+	else
+		error("Cannot accept memory");
 }
 
 /*
diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 918a7606f53c..57fd2bf28484 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -3,12 +3,14 @@
 #include "../cpuflags.h"
 #include "../string.h"
 #include "../io.h"
+#include "align.h"
 #include "error.h"
 
 #include <vdso/limits.h>
 #include <uapi/asm/vmx.h>
 
 #include <asm/shared/tdx.h>
+#include <asm/page_types.h>
 
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void)
@@ -75,3 +77,86 @@ void early_tdx_detect(void)
 	pio_ops.f_outb = tdx_outb;
 	pio_ops.f_outw = tdx_outw;
 }
+
+enum pg_level {
+	PG_LEVEL_4K,
+	PG_LEVEL_2M,
+	PG_LEVEL_1G,
+};
+
+#define PTE_SHIFT 9
+
+static bool try_accept_one(phys_addr_t *start, unsigned long len,
+			  enum pg_level pg_level)
+{
+	unsigned long accept_size = PAGE_SIZE << (pg_level * PTE_SHIFT);
+	u64 tdcall_rcx;
+	u8 page_size;
+
+	if (!IS_ALIGNED(*start, accept_size))
+		return false;
+
+	if (len < accept_size)
+		return false;
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
+	tdcall_rcx = *start | page_size;
+	if (__tdx_module_call(TDX_ACCEPT_PAGE, tdcall_rcx, 0, 0, 0, NULL))
+		return false;
+
+	*start += accept_size;
+	return true;
+}
+
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	/*
+	 * Notify the VMM about page mapping conversion. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
+	 * section "TDG.VP.VMCALL<MapGPA>"
+	 */
+	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+		error("Accepting memory failed\n");
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
+		if (try_accept_one(&start, len, PG_LEVEL_1G))
+			continue;
+
+		if (try_accept_one(&start, len, PG_LEVEL_2M))
+			continue;
+
+		if (!try_accept_one(&start, len, PG_LEVEL_4K))
+			error("Accepting memory failed\n");
+	}
+}
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ddb60a87b426..ab4deb897942 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -580,16 +580,9 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
 	return true;
 }
 
-/*
- * Inform the VMM of the guest's intent for this physical page: shared with
- * the VMM or private to the guest.  The VMM is expected to change its mapping
- * of the page in response.
- */
-static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
-
 	if (!enc) {
 		/* Set the shared (decrypted) bits: */
 		start |= cc_mkdec(0);
@@ -634,6 +627,25 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	if (!tdx_enc_status_changed_phys(start, end, true))
+		panic("Accepting memory failed\n");
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
+	return tdx_enc_status_changed_phys(start, end, enc);
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
@@ -645,6 +657,7 @@ void __init tdx_early_init(void)
 		return;
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
+	setup_clear_cpu_cap(X86_FEATURE_MCE);
 
 	cc_set_vendor(CC_VENDOR_INTEL);
 	cc_mask = get_cc_mask();
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 956ced04c3be..97534c334473 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -81,5 +81,7 @@ struct tdx_module_output {
 u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		      struct tdx_module_output *out);
 
+void tdx_accept_memory(phys_addr_t start, phys_addr_t end);
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
index 1327f64d5205..de0790af1824 100644
--- a/arch/x86/mm/unaccepted_memory.c
+++ b/arch/x86/mm/unaccepted_memory.c
@@ -6,6 +6,7 @@
 
 #include <asm/io.h>
 #include <asm/setup.h>
+#include <asm/shared/tdx.h>
 #include <asm/unaccepted_memory.h>
 
 /* Protects unaccepted memory bitmap */
@@ -29,7 +30,13 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
 		unsigned long len = range_end - range_start;
 
 		/* Platform-specific memory-acceptance call goes here */
-		panic("Cannot accept memory");
+		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
+			tdx_accept_memory(range_start * PMD_SIZE,
+					  range_end * PMD_SIZE);
+		} else {
+			panic("Cannot accept memory");
+		}
+
 		bitmap_clear(unaccepted_memory, range_start, len);
 	}
 	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
-- 
2.35.1

