Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB24982FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbiAXPEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:04:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:5630 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240314AbiAXPDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036590; x=1674572590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tKPEY1KQTqIVQ760tEEDgDD58NKNldq3MW2/0q9iqtM=;
  b=L89JNlrKz7B/qFGfq9NRLYNwpregWvEAJYDisCJTVURzmI31WOVYLcLR
   dysQwuB6PmiDBswhXUYeXChmHcYm+CWkCRKStEFsH8/eSXLHxLN80SuS7
   E2dD0KCN0qkw3FkpqBJgyHBw/le1NbU8oPK2rRMNFaGyJCoTn856i9fsU
   +XbUWLWfgoihbWQBKIOWV1JOgSwxTgOaWOmMINrZfaKLoTOJFmdsr9PNr
   7dh6NkMM01PBUqfxhqVkK6B/NKKWGsLGBrDbRQG9AmqBzzpZzRaBLdEMU
   LhDLVtzaBiNFCLS566C1k/cHnuqa2lrSkcsuPN0CIUjWq7uBqUkJAkH/9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226043252"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226043252"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="532102282"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2022 07:02:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 76389D08; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>
Subject: [PATCHv2 24/29] x86/mm/cpa: Add support for TDX shared memory
Date:   Mon, 24 Jan 2022 18:02:10 +0300
Message-Id: <20220124150215.36893-25-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX steals a bit from the physical address and uses it to indicate
whether the page is private to the guest (bit set 0) or unprotected
and shared with the VMM (bit set 1).

AMD SEV uses a similar scheme, repurposing a bit from the physical address
to indicate encrypted or decrypted pages.

The kernel already has the infrastructure to deal with encrypted/decrypted
pages for AMD SEV. Modify the __set_memory_enc_pgtable() and make it
aware about TDX.

After modifying page table entries, the kernel needs to notify VMM about
the change with tdx_hcall_request_gpa_type().

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Tested-by: Kai Huang <kai.huang@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                   |  2 +-
 arch/x86/include/asm/mem_encrypt.h |  8 ++++++
 arch/x86/include/asm/set_memory.h  |  1 -
 arch/x86/kernel/cc_platform.c      |  2 ++
 arch/x86/mm/mem_encrypt_amd.c      | 10 ++++---
 arch/x86/mm/pat/set_memory.c       | 44 ++++++++++++++++++++++++++----
 include/linux/cc_platform.h        |  9 ++++++
 7 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 680c3cad9422..33e6ec6fd89f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -886,7 +886,7 @@ config INTEL_TDX_GUEST
 	depends on X86_X2APIC
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MCE
-	select DYNAMIC_PHYSICAL_MASK
+	select X86_MEM_ENCRYPT
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index e2c6f433ed10..f45a9ea2dec9 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -52,6 +52,8 @@ void __init mem_encrypt_free_decrypted_mem(void);
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
 
+int amd_notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
+
 void __init sev_es_init_vc_handling(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
@@ -85,6 +87,12 @@ early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc) {}
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
+static inline int amd_notify_range_enc_status_changed(unsigned long vaddr,
+						      int npages, bool enc)
+{
+	return 0;
+}
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ff0f2d90338a..ce8dd215f5b3 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -84,7 +84,6 @@ int set_pages_rw(struct page *page, int numpages);
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 bool kernel_page_present(struct page *page);
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc);
 
 extern int kernel_set_to_readonly;
 
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index be8722ad4792..1fbcf19fa20d 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -21,6 +21,8 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_HOTPLUG_DISABLED:
+	case CC_ATTR_GUEST_TDX:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return true;
 	default:
 		return false;
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2b2d018ea345..6aa4e0c27368 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -256,7 +256,8 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 	return pfn;
 }
 
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
+int amd_notify_range_enc_status_changed(unsigned long vaddr, int npages,
+					 bool enc)
 {
 #ifdef CONFIG_PARAVIRT
 	unsigned long sz = npages << PAGE_SHIFT;
@@ -270,7 +271,7 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
 		kpte = lookup_address(vaddr, &level);
 		if (!kpte || pte_none(*kpte)) {
 			WARN_ONCE(1, "kpte lookup for vaddr\n");
-			return;
+			return 0;
 		}
 
 		pfn = pg_level_to_pfn(level, kpte, NULL);
@@ -285,6 +286,7 @@ void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
 		vaddr = (vaddr & pmask) + psize;
 	}
 #endif
+	return 0;
 }
 
 static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
@@ -392,7 +394,7 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
 
 	ret = 0;
 
-	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
+	amd_notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
 out:
 	__flush_tlb_all();
 	return ret;
@@ -410,7 +412,7 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 
 void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
 {
-	notify_range_enc_status_changed(vaddr, npages, enc);
+	amd_notify_range_enc_status_changed(vaddr, npages, enc);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..06c65689d6fb 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -32,6 +32,7 @@
 #include <asm/set_memory.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
+#include <asm/tdx.h>
 
 #include "../mm_internal.h"
 
@@ -1983,6 +1984,27 @@ int set_memory_global(unsigned long addr, int numpages)
 				    __pgprot(_PAGE_GLOBAL), 0);
 }
 
+static pgprot_t pgprot_cc_mask(bool enc)
+{
+	if (enc)
+		return pgprot_encrypted(__pgprot(0));
+	else
+		return pgprot_decrypted(__pgprot(0));
+}
+
+static int notify_range_enc_status_changed(unsigned long vaddr, int npages,
+					   bool enc)
+{
+	if (cc_platform_has(CC_ATTR_GUEST_TDX)) {
+		phys_addr_t start = __pa(vaddr);
+		phys_addr_t end = __pa(vaddr + npages * PAGE_SIZE);
+
+		return tdx_hcall_request_gpa_type(start, end, enc);
+	} else {
+		return amd_notify_range_enc_status_changed(vaddr, npages, enc);
+	}
+}
+
 /*
  * __set_memory_enc_pgtable() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
@@ -1999,8 +2021,10 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+
+	cpa.mask_set = pgprot_cc_mask(enc);
+	cpa.mask_clr = pgprot_cc_mask(!enc);
+
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
@@ -2008,9 +2032,17 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	vm_unmap_aliases();
 
 	/*
-	 * Before changing the encryption attribute, we need to flush caches.
+	 * Before changing the encryption attribute, flush caches.
+	 *
+	 * For TDX, guest is responsible for flushing caches on private->shared
+	 * transition. VMM is responsible for flushing on shared->private.
 	 */
-	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	if (cc_platform_has(CC_ATTR_GUEST_TDX)) {
+		if (!enc)
+			cpa_flush(&cpa, 1);
+	} else {
+		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	}
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2027,8 +2059,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 * Notify hypervisor that a given memory range is mapped encrypted
 	 * or decrypted.
 	 */
-	notify_range_enc_status_changed(addr, numpages, enc);
-
+	if (!ret)
+		ret =  notify_range_enc_status_changed(addr, numpages, enc);
 	return ret;
 }
 
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 691494bbaf5a..16c0ad925bf0 100644
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
2.34.1

