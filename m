Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA674982E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbiAXPDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:64684 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239088AbiAXPC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036547; x=1674572547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/1mJoSxaEj3D4K7PWjhYEhCnOZraFsCr3YgPjs2epB0=;
  b=gfWSLIBxDr08SpKcnZqny/BVLAWMbZmTJM25YCHqARYVid1E7Im5EeZz
   OQ6i3Hpa0P//F3cyDuLDzDlZZ7mmdlCvKbfTaijQZZT0dVYB4+JhmOnkQ
   /u/IHYBg5ebMl9KnsAeITb90wOXpzwy8e8Mi/FKGtcqLjHhqNh3Tbfg+/
   PzBMIEX+ar8pA62OiNPVNiy7XYc0mMA/x6bgOUbjSjA7IF1SrqdAM8eOm
   KL84qEadi3ZLcUYMBJHQKYI8oqa/dBnHyU4ooC4PDeyWIZkCxZNRXSVcB
   EwQKVOxWRCcbGaUw6wXqlYno2oYCEedssdF3cMHQ1e9soKYrOVzYa/wKA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270498616"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270498616"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="534254358"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 07:02:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5DCDACCF; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
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
Subject: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Date:   Mon, 24 Jan 2022 18:02:08 +0300
Message-Id: <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guests, guest memory is protected from host access. If a guest
performs I/O, it needs to explicitly share the I/O memory with the host.

Make all ioremap()ed pages that are not backed by normal memory
(IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.

Since TDX memory encryption support is similar to AMD SEV architecture,
reuse the infrastructure from AMD SEV code.

Add tdx_shared_mask() interface to get the TDX guest shared bitmask.

pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio). Export
both pgprot_encrypted() and pgprot_decrypted().

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable.h | 19 +++++++++++++------
 arch/x86/include/asm/tdx.h     |  4 ++++
 arch/x86/kernel/cc_platform.c  | 23 +++++++++++++++++++++++
 arch/x86/kernel/tdx.c          |  9 +++++++++
 arch/x86/mm/ioremap.c          |  5 +++++
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8a9432fb3802..40e22db48319 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -15,12 +15,6 @@
 		     cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS)))	\
 	 : (prot))
 
-/*
- * Macros to add or remove encryption attribute
- */
-#define pgprot_encrypted(prot)	__pgprot(__sme_set(pgprot_val(prot)))
-#define pgprot_decrypted(prot)	__pgprot(__sme_clr(pgprot_val(prot)))
-
 #ifndef __ASSEMBLY__
 #include <linux/spinlock.h>
 #include <asm/x86_init.h>
@@ -38,6 +32,19 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
 void ptdump_walk_pgd_level_checkwx(void);
 void ptdump_walk_user_pgd_level_checkwx(void);
 
+/*
+ * Macros to add or remove encryption attribute
+ */
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+pgprot_t pgprot_encrypted(pgprot_t prot);
+pgprot_t pgprot_decrypted(pgprot_t prot);
+#define pgprot_encrypted(prot)	pgprot_encrypted(prot)
+#define pgprot_decrypted(prot)	pgprot_decrypted(prot)
+#else
+#define pgprot_encrypted(prot) (prot)
+#define pgprot_decrypted(prot) (prot)
+#endif
+
 #ifdef CONFIG_DEBUG_WX
 #define debug_checkwx()		ptdump_walk_pgd_level_checkwx()
 #define debug_checkwx_user()	ptdump_walk_user_pgd_level_checkwx()
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 4bcaadf21dc6..c6a279e67dff 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -55,6 +55,8 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+phys_addr_t tdx_shared_mask(void);
+
 #else
 
 static inline void tdx_early_init(void) { };
@@ -63,6 +65,8 @@ static inline void tdx_safe_halt(void) { };
 
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
+static inline phys_addr_t tdx_shared_mask(void) { return 0; }
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index dcb31d6a7554..be8722ad4792 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -12,6 +12,7 @@
 #include <linux/mem_encrypt.h>
 
 #include <asm/mshyperv.h>
+#include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/tdx.h>
 
@@ -90,3 +91,25 @@ bool cc_platform_has(enum cc_attr attr)
 	return false;
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
+
+pgprot_t pgprot_encrypted(pgprot_t prot)
+{
+        if (sme_me_mask)
+                return __pgprot(__sme_set(pgprot_val(prot)));
+        else if (is_tdx_guest())
+		return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
+
+        return prot;
+}
+EXPORT_SYMBOL_GPL(pgprot_encrypted);
+
+pgprot_t pgprot_decrypted(pgprot_t prot)
+{
+	if (sme_me_mask)
+		return __pgprot(__sme_clr(pgprot_val(prot)));
+	else if (is_tdx_guest())
+		return __pgprot(pgprot_val(prot) | tdx_shared_mask());
+
+	return prot;
+}
+EXPORT_SYMBOL_GPL(pgprot_decrypted);
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index beeaf61934bc..3bf6621eae7d 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -66,6 +66,15 @@ long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
 #endif
 
+/*
+ * The highest bit of a guest physical address is the "sharing" bit.
+ * Set it for shared pages and clear it for private pages.
+ */
+phys_addr_t tdx_shared_mask(void)
+{
+	return BIT_ULL(td_info.gpa_width - 1);
+}
+
 static void tdx_get_info(void)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 026031b3b782..a5d4ec1afca2 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -242,10 +242,15 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	 * If the page being mapped is in memory and SEV is active then
 	 * make sure the memory encryption attribute is enabled in the
 	 * resulting mapping.
+	 * In TDX guests, memory is marked private by default. If encryption
+	 * is not requested (using encrypted), explicitly set decrypt
+	 * attribute in all IOREMAPPED memory.
 	 */
 	prot = PAGE_KERNEL_IO;
 	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
+	else
+		prot = pgprot_decrypted(prot);
 
 	switch (pcm) {
 	case _PAGE_CACHE_MODE_UC:
-- 
2.34.1

