Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434FE4745D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhLNPDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:03:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:25428 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235175AbhLNPDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263135026"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="263135026"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="754837231"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2021 07:03:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 386FEE35; Tue, 14 Dec 2021 17:03:10 +0200 (EET)
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
Subject: [PATCH 21/26] x86/mm/cpa: Add support for TDX shared memory
Date:   Tue, 14 Dec 2021 18:02:59 +0300
Message-Id: <20211214150304.62613-22-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/kernel/cc_platform.c |  1 +
 arch/x86/mm/pat/set_memory.c  | 39 +++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index a0fc329edc35..4a3064bf1eb5 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -20,6 +20,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 	case CC_ATTR_HOTPLUG_DISABLED:
 	case CC_ATTR_GUEST_TDX:
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return true;
 	default:
 		return false;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..3a89966c30a9 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -32,6 +32,7 @@
 #include <asm/set_memory.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
+#include <asm/tdx.h>
 
 #include "../mm_internal.h"
 
@@ -1983,12 +1984,21 @@ int set_memory_global(unsigned long addr, int numpages)
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
 /*
  * __set_memory_enc_pgtable() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
  */
 static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 {
+	enum tdx_map_type map_type;
 	struct cpa_data cpa;
 	int ret;
 
@@ -1999,8 +2009,11 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+
+	cpa.mask_set = pgprot_cc_mask(enc);
+	cpa.mask_clr = pgprot_cc_mask(!enc);
+	map_type = enc ? TDX_MAP_PRIVATE : TDX_MAP_SHARED;
+
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
@@ -2008,9 +2021,17 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
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
+		if (map_type == TDX_MAP_SHARED)
+			cpa_flush(&cpa, 1);
+	} else {
+		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
+	}
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
@@ -2023,6 +2044,16 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	 */
 	cpa_flush(&cpa, 0);
 
+	/*
+	 * For TDX Guest, raise hypercall to request memory mapping
+	 * change with the VMM.
+	 */
+	if (!ret && cc_platform_has(CC_ATTR_GUEST_TDX)) {
+		ret = tdx_hcall_request_gpa_type(__pa(addr),
+						 __pa(addr) + numpages * PAGE_SIZE,
+						 map_type);
+	}
+
 	/*
 	 * Notify hypervisor that a given memory range is mapped encrypted
 	 * or decrypted.
-- 
2.32.0

