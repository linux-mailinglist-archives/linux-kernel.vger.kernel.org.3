Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF54C01BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiBVS6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiBVS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:58:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A111BBE3E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645556259; x=1677092259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AuodqAdtsYft9lvEIxVYtPnZkgg8T2osK8Sb22u/TqE=;
  b=CyqtsY+KCpLwGoRvlBSDLr0pvMbhbTcryU4XxdJg9FlocgLpy9lZc/5v
   aPUH1YAaXfv8kgsS2js547URg6R5ApAwVobm3VeprqmWCJADanRs60nZ1
   cVu9oLFSBGhY0zVsWYZLWGEo+2wnR/kJPj/dBdhmRvNirTnrfKdEUwpXV
   UXN6pE6Z7Wflw/VwKfL2e6BR4LvXFHjn9tdBVkmpiB7WY4HB9IWlwgsSE
   x4x0T9w+WzQGlXkwUhirj4Uy/3YT69uWV+XKZ7rJBRSY3JdyY2mZNaaoe
   3gTg4IfnbqtEz0aEmmO017kUBFlVEqs4qfozrbaboMbYNNBvi4S5yG9JG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="232406837"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="232406837"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="591415361"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Feb 2022 10:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 69DE840D; Tue, 22 Feb 2022 20:57:51 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 4/4] x86/coco: Add API to handle encryption mask
Date:   Tue, 22 Feb 2022 21:57:40 +0300
Message-Id: <20220222185740.26228-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
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

AMD SME/SEV uses a bit in the page table entries to indicate that the
page is encrypted and not accessible to the VMM.

TDX uses a similar approach, but the polarity of the mask is opposite to
AMD: if the bit is set the page is accessible to VMM.

Provide vendor-neutral API to deal with the mask: cc_mkenc() and
cc_mkdec() modify given address to make it encrypted/decrypted. It can
be applied to phys_addr_t, pgprotval_t or page table entry value.

pgprot_encrypted() and pgprot_decrypted() reimplemented using new
helpers.

The implementation will be extended to cover TDX.

pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio).
cc_mkdec() called by pgprot_decrypted(). Export cc_mkdec().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/core.c               | 27 +++++++++++++++++++++++++++
 arch/x86/include/asm/coco.h        | 18 ++++++++++++++++++
 arch/x86/include/asm/pgtable.h     | 13 +++++++------
 arch/x86/mm/mem_encrypt_identity.c |  1 +
 arch/x86/mm/pat/set_memory.c       |  5 +++--
 5 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 476dcd198af5..fc1365dd927e 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 
 static enum cc_vendor vendor __ro_after_init;
+static u64 cc_mask __ro_after_init;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
 {
@@ -84,7 +85,33 @@ bool cc_platform_has(enum cc_attr attr)
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
 
+u64 cc_mkenc(u64 val)
+{
+	switch (vendor) {
+	case CC_VENDOR_AMD:
+		return val | cc_mask;
+	default:
+		return val;
+	}
+}
+
+u64 cc_mkdec(u64 val)
+{
+	switch (vendor) {
+	case CC_VENDOR_AMD:
+		return val & ~cc_mask;
+	default:
+		return val;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_mkdec);
+
 __init void cc_set_vendor(enum cc_vendor v)
 {
 	vendor = v;
 }
+
+__init void cc_set_mask(u64 mask)
+{
+	cc_mask = mask;
+}
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index e49f9ddb6ae6..3d98c3a60d34 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_COCO_H
 #define _ASM_X86_COCO_H
 
+#include <asm/types.h>
+
 enum cc_vendor {
 	CC_VENDOR_NONE,
 	CC_VENDOR_AMD,
@@ -10,5 +12,21 @@ enum cc_vendor {
 };
 
 void cc_set_vendor(enum cc_vendor v);
+void cc_set_mask(u64 mask);
+
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+u64 cc_mkenc(u64 val);
+u64 cc_mkdec(u64 val);
+#else
+static inline u64 cc_mkenc(u64 val)
+{
+	return val;
+}
+
+static inline u64 cc_mkdec(u64 val)
+{
+	return val;
+}
+#endif
 
 #endif /* _ASM_X86_COCO_H */
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
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 06314ae3998e..b43bc24d2bb6 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -604,5 +604,6 @@ void __init sme_enable(struct boot_params *bp)
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
 		cc_set_vendor(CC_VENDOR_AMD);
+		cc_set_mask(sme_me_mask);
 	}
 }
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..af77dbfd143c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1990,6 +1990,7 @@ int set_memory_global(unsigned long addr, int numpages)
 static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 {
 	struct cpa_data cpa;
+	pgprot_t empty = __pgprot(0);
 	int ret;
 
 	/* Should not be working on unaligned addresses */
@@ -1999,8 +2000,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
-	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
-	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
+	cpa.mask_set = enc ? pgprot_encrypted(empty) : pgprot_decrypted(empty);
+	cpa.mask_clr = enc ? pgprot_decrypted(empty) : pgprot_encrypted(empty);
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
-- 
2.34.1

