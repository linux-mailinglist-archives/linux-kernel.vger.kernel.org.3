Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974D14BBD40
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiBRQRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:17:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiBRQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A3D22B3E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201033; x=1676737033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TG22mcAEw2hRM0MdVWIDQmoYb432391sLUwhtm9rnec=;
  b=PKo0tMeoBUQnxJwY3EOF1NqZ6GZn+UDr9A1v/UHimhwCHtrRAl4UdE3t
   SwMbttVxfRm8xxn2/30/7l0xV+kl/SG4NGue87pv0jWvBjfWyNzTdiK0u
   ptcU0AA/SfQI9kRVlLITVJXP9RHzXizV1icm847nwJuaHcgBW5cOyPoxd
   IjdWw00rhAA9XTkV+cIJo/9jQWdZv/PqWlj+CFoYsNqxC/UGkYVT7xE8j
   bq2HWqdjc0TZCfpd/xyxstIt/M4YxHkdNz46HEBZ0H5KdxI8X5RIt4q1j
   8JbGFZybGFq9zOe6xvO/XsobgVxGElkLoPDGTRVV4N5inpQmi+zJqItsv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="250910876"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="250910876"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="682550825"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2022 08:17:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1F90837E; Fri, 18 Feb 2022 18:17:22 +0200 (EET)
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
Subject: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
Date:   Fri, 18 Feb 2022 19:16:48 +0300
Message-Id: <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SME/SEV uses a bit in the page table entries to indicate that the
page is encrypted and not accessible to the VMM.

TDX uses a similar approach, but the polarity of the mask is opposite to
AMD: if the bit is set the page is accessible to VMM.

Provide vendor-neutral API to deal with the mask. It will be extended to
cover TDX.

pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio).
cc_mkdec() called by pgprot_decrypted(). Export cc_mkdec().

HyperV doesn't use bits in page table entries, so the mask is 0 for both
encrypthion and decrypthion.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/coco.h        | 26 +++++++++++++
 arch/x86/include/asm/pgtable.h     | 13 ++++---
 arch/x86/kernel/cc_platform.c      | 62 ++++++++++++++++++++++++------
 arch/x86/kernel/cpu/mshyperv.c     |  3 ++
 arch/x86/mm/mem_encrypt_identity.c |  8 ++--
 arch/x86/mm/pat/set_memory.c       |  4 +-
 6 files changed, 93 insertions(+), 23 deletions(-)
 create mode 100644 arch/x86/include/asm/coco.h

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
new file mode 100644
index 000000000000..802d87d08e31
--- /dev/null
+++ b/arch/x86/include/asm/coco.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_COCO_H
+#define _ASM_X86_COCO_H
+
+#include <asm/pgtable_types.h>
+
+enum cc_vendor {
+	CC_VENDOR_NONE,
+	CC_VENDOR_AMD,
+	CC_VENDOR_HYPERV,
+	CC_VENDOR_INTEL,
+};
+
+void cc_init(enum cc_vendor, u64 mask);
+
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+u64 cc_get_mask(bool enc);
+u64 cc_mkenc(u64 val);
+u64 cc_mkdec(u64 val);
+#else
+#define cc_get_mask(enc)	0
+#define cc_mkenc(val)		(val)
+#define cc_mkdec(val)		(val)
+#endif
+
+#endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8a9432fb3802..62ab07e24aef 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -15,17 +15,12 @@
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
 #include <asm/pkru.h>
 #include <asm/fpu/api.h>
+#include <asm/coco.h>
 #include <asm-generic/pgtable_uffd.h>
 #include <linux/page_table_check.h>
 
@@ -38,6 +33,12 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
 void ptdump_walk_pgd_level_checkwx(void);
 void ptdump_walk_user_pgd_level_checkwx(void);
 
+/*
+ * Macros to add or remove encryption attribute
+ */
+#define pgprot_encrypted(prot)	__pgprot(cc_mkenc(pgprot_val(prot)))
+#define pgprot_decrypted(prot)	__pgprot(cc_mkdec(pgprot_val(prot)))
+
 #ifdef CONFIG_DEBUG_WX
 #define debug_checkwx()		ptdump_walk_pgd_level_checkwx()
 #define debug_checkwx_user()	ptdump_walk_user_pgd_level_checkwx()
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 6a6ffcd978f6..93e6be7b7eca 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -9,18 +9,16 @@
 
 #include <linux/export.h>
 #include <linux/cc_platform.h>
-#include <linux/mem_encrypt.h>
 
-#include <asm/mshyperv.h>
+#include <asm/coco.h>
 #include <asm/processor.h>
 
-static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
+static u64 cc_mask;
+static enum cc_vendor cc_vendor;
+
+static bool intel_cc_platform_has(enum cc_attr attr)
 {
-#ifdef CONFIG_INTEL_TDX_GUEST
-	return false;
-#else
 	return false;
-#endif
 }
 
 /*
@@ -74,12 +72,52 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
 
 bool cc_platform_has(enum cc_attr attr)
 {
-	if (sme_me_mask)
+	switch (cc_vendor) {
+	case CC_VENDOR_AMD:
 		return amd_cc_platform_has(attr);
-
-	if (hv_is_isolation_supported())
+	case CC_VENDOR_INTEL:
+		return intel_cc_platform_has(attr);
+	case CC_VENDOR_HYPERV:
 		return hyperv_cc_platform_has(attr);
-
-	return false;
+	default:
+		return false;
+	}
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
+
+u64 cc_get_mask(bool enc)
+{
+	switch (cc_vendor) {
+	case CC_VENDOR_AMD:
+		return enc ? cc_mask : 0;
+	default:
+		return 0;
+	}
+}
+
+u64 cc_mkenc(u64 val)
+{
+	switch (cc_vendor) {
+	case CC_VENDOR_AMD:
+		return val | cc_mask;
+	default:
+		return val;
+	}
+}
+
+u64 cc_mkdec(u64 val)
+{
+	switch (cc_vendor) {
+	case CC_VENDOR_AMD:
+		return val & ~cc_mask;
+	default:
+		return val;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_mkdec);
+
+__init void cc_init(enum cc_vendor vendor, u64 mask)
+{
+	cc_vendor = vendor;
+	cc_mask = mask;
+}
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5a99f993e639..9af6be143998 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -33,6 +33,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/coco.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -344,6 +345,8 @@ static void __init ms_hyperv_init_platform(void)
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
 #endif
+		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+			cc_init(CC_VENDOR_HYPERV, 0);
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 3f0abb403340..fa758247ab57 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -44,6 +44,7 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cmdline.h>
+#include <asm/coco.h>
 
 #include "mm_internal.h"
 
@@ -565,8 +566,7 @@ void __init sme_enable(struct boot_params *bp)
 	} else {
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
-		physical_mask &= ~sme_me_mask;
-		return;
+		goto out;
 	}
 
 	/*
@@ -600,6 +600,8 @@ void __init sme_enable(struct boot_params *bp)
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
-
+out:
 	physical_mask &= ~sme_me_mask;
+	if (sme_me_mask)
+		cc_init(CC_VENDOR_AMD, sme_me_mask);
 }
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..e79366b8a9da 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1999,8 +1999,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+	cpa.mask_set = __pgprot(cc_get_mask(enc));
+	cpa.mask_clr = __pgprot(cc_get_mask(!enc));
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
-- 
2.34.1

