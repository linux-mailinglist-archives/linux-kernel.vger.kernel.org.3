Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0744C1BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244337AbiBWTSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242537AbiBWTRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:17:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D681C43AD3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:17:19 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CB671EC0554;
        Wed, 23 Feb 2022 20:17:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645643838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3rJ3VG2wV5kg36qtm+P6CdEhAINcR8qYYq/7MUvNrpg=;
        b=l0TwF5rm9ua6uE59r7eIP7X1J0COk+P5GEbDNIAM/EkIg14i32yfsJPYhUr/48lgbdRVAX
        1/JNGiQU5wqyiSdhdZ+7GWJvX7cJ85I4ddK4PuGSlc+vaB1B26M6v3sgZ/Mv/dQDnfqamP
        0tNcqQt7G/iBDFnQW2M5lOaR4Hulbm8=
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com
Subject: [PATCH 3/4] x86/coco: Add API to handle encryption mask
Date:   Wed, 23 Feb 2022 20:17:22 +0100
Message-Id: <20220223191723.22937-3-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <YhaGuEgG9+UlGwIU@zn.tnic>
References: <YhaGuEgG9+UlGwIU@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

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
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20220222185740.26228-5-kirill.shutemov@linux.intel.com
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
index b4072115c8ef..1441db69cea5 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1989,6 +1989,7 @@ int set_memory_global(unsigned long addr, int numpages)
  */
 static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 {
+	pgprot_t empty = __pgprot(0);
 	struct cpa_data cpa;
 	int ret;
 
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
2.29.2

