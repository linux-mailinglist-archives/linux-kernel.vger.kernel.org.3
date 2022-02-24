Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2902E4C2B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiBXL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiBXL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:59:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9D488A3;
        Thu, 24 Feb 2022 03:59:27 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:59:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645703965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Un/NH0FpeYtHbG3p/fyCPWObkycsAIo47PeAtxUHTb0=;
        b=CGOce7O32vXi6vI8Uha67YhRidGdg+a4HjEMkKUd2T1AMIlm3YyxhljnhIoaEiHwmi+eYl
        ZjwfB5G/pA7///DqLfpCXVH1yxgQ4rCW99z0ziiPXNU2XKUZGJgsmfeF8Wh+Ys98BHrT7a
        TrcE2PaK1j7AW1+ls5VUMCsKyUe+3H104Sd7MB/YQX2LMXpwzDXIdXfyqiLkjtCl/tb47y
        +ZD/pd0hp82KMJ0y0PHFJvtLQFUinHvBT8yo/GGiwd55TJi5eTOibM1/TkR/Jz7QWpK6bv
        qyua01F8dPoGpEuTN1z9N12RW4JrVH6uo2B34Nxl5wfo7v9DYHx9tGBriuTS4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645703965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Un/NH0FpeYtHbG3p/fyCPWObkycsAIo47PeAtxUHTb0=;
        b=holsPH304lb5Vigr0Sz+PGQJcTp4iLr4qMVcK2ql1OlDPXlcThiP7RuAVkQGjB8iIPmhaO
        blkYlW9b6S91yBAw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/coco: Add API to handle encryption mask
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220222185740.26228-5-kirill.shutemov@linux.intel.com>
References: <20220222185740.26228-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164570396398.16921.6051735447275836024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     b577f542f93cbba57f8d6185ef1fb13a41ddf162
Gitweb:        https://git.kernel.org/tip/b577f542f93cbba57f8d6185ef1fb13a41ddf162
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 22 Feb 2022 21:57:40 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Feb 2022 19:14:29 +01:00

x86/coco: Add API to handle encryption mask

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
index 476dcd1..fc1365d 100644
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
index e49f9dd..3d98c3a 100644
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
index 8a9432f..62ab07e 100644
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
index 06314ae..b43bc24 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -604,5 +604,6 @@ out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
 		cc_set_vendor(CC_VENDOR_AMD);
+		cc_set_mask(sme_me_mask);
 	}
 }
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b407211..1441db6 100644
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
