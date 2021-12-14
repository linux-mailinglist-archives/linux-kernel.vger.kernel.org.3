Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1AC4745EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhLNPFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:05:06 -0500
Received: from mga05.intel.com ([192.55.52.43]:40274 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235209AbhLNPDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325270516"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="325270516"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="609896989"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2021 07:03:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1CD42DAB; Tue, 14 Dec 2021 17:03:10 +0200 (EET)
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
Subject: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Date:   Tue, 14 Dec 2021 18:02:57 +0300
Message-Id: <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
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
reuse the infrastructure from AMD SEV code. Introduce CC_ATTR_GUEST_TDX
to add TDX-specific changes to the AMD SEV/SME memory encryption code.

Add tdx_shared_mask() interface to get the TDX guest shared bitmask.

pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio). Export
both pgprot_encrypted() and pgprot_decrypted().

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig               |  2 +-
 arch/x86/include/asm/pgtable.h | 19 +++++++++++++------
 arch/x86/include/asm/tdx.h     |  3 +++
 arch/x86/kernel/cc_platform.c  |  1 +
 arch/x86/kernel/tdx.c          |  9 +++++++++
 arch/x86/mm/ioremap.c          |  5 +++++
 arch/x86/mm/mem_encrypt.c      | 27 +++++++++++++++++++++++++++
 include/linux/cc_platform.h    |  9 +++++++++
 8 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fe0382f20445..f5df53b6c80d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -879,7 +879,7 @@ config INTEL_TDX_GUEST
 	depends on X86_X2APIC
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MCE
-	select DYNAMIC_PHYSICAL_MASK
+	select X86_MEM_ENCRYPT
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 448cd01eb3ec..019cb2f97c20 100644
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
 #include <asm/x86_init.h>
 #include <asm/pkru.h>
@@ -36,6 +30,19 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
 void ptdump_walk_pgd_level_checkwx(void);
 void ptdump_walk_user_pgd_level_checkwx(void);
 
+/*
+ * Macros to add or remove encryption attribute
+ */
+#ifdef CONFIG_X86_MEM_ENCRYPT
+pgprot_t pgprot_cc_encrypted(pgprot_t prot);
+pgprot_t pgprot_cc_decrypted(pgprot_t prot);
+#define pgprot_encrypted(prot)	pgprot_cc_encrypted(prot)
+#define pgprot_decrypted(prot)	pgprot_cc_decrypted(prot)
+#else
+#define pgprot_encrypted(prot) (prot)
+#define pgprot_decrypted(prot) (prot)
+#endif
+
 #ifdef CONFIG_DEBUG_WX
 #define debug_checkwx()		ptdump_walk_pgd_level_checkwx()
 #define debug_checkwx_user()	ptdump_walk_user_pgd_level_checkwx()
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index d2ffc9a6ba53..286adda40fb7 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -76,6 +76,8 @@ void tdx_guest_idle(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+phys_addr_t tdx_shared_mask(void);
+
 #else
 
 static inline void tdx_early_init(void) { };
@@ -83,6 +85,7 @@ static inline bool is_tdx_guest(void) { return false; }
 static inline void tdx_guest_idle(void) { };
 
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
+static inline phys_addr_t tdx_shared_mask(void) { return 0; }
 
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 2ed8652ab042..a0fc329edc35 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -19,6 +19,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_HOTPLUG_DISABLED:
+	case CC_ATTR_GUEST_TDX:
 		return true;
 	default:
 		return false;
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index cbfacc2af8bb..d4aae2f139a8 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -52,6 +52,15 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14,
 	return out->r10;
 }
 
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
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d209939c66..8b9de7e478c6 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -14,6 +14,33 @@
 #include <linux/mem_encrypt.h>
 #include <linux/virtio_config.h>
 
+#include <asm/tdx.h>
+
+/*
+ * Set or unset encryption attribute in vendor agnostic way.
+ */
+pgprot_t pgprot_cc_encrypted(pgprot_t prot)
+{
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		return __pgprot(__sme_set(pgprot_val(prot)));
+	else if (cc_platform_has(CC_ATTR_GUEST_TDX))
+		return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
+
+	return prot;
+}
+EXPORT_SYMBOL_GPL(pgprot_cc_encrypted);
+
+pgprot_t pgprot_cc_decrypted(pgprot_t prot)
+{
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		return __pgprot(__sme_clr(pgprot_val(prot)));
+	else if (cc_platform_has(CC_ATTR_GUEST_TDX))
+		return __pgprot(pgprot_val(prot) | tdx_shared_mask());
+
+	return prot;
+}
+EXPORT_SYMBOL_GPL(pgprot_cc_decrypted);
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 63b15108bc85..5fed077cc5f4 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -82,6 +82,15 @@ enum cc_attr {
 	 * Examples include TDX Guest.
 	 */
 	CC_ATTR_HOTPLUG_DISABLED,
+
+	/**
+	 * @CC_ATTR_GUEST_TDX: Trust Domain Extension Support
+	 *
+	 * The platform/OS is running as a TDX guest/virtual machine.
+	 *
+	 * Examples include Intel TDX.
+	 */
+	CC_ATTR_GUEST_TDX = 0x100,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.32.0

