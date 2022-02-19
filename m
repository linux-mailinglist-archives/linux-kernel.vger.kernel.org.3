Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE34BC337
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbiBSAMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:12:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiBSAMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:12:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776C53E0FE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:12:14 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d23so8244827lfv.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mJSMn3jpBFaoWnFhXfxzbCr5VeROd8nSpVMKZfWqpg0=;
        b=yEfun9h7AROsl8owHdqSpLcioHn74YYbfzhijoN7UX57b4G/YLG6dbabaxVyJVt/Xw
         eCZKQQPtu4j9xT/0jB0wtA5XVeHva+LvNEi0y8iumde7Xy4uXA6lMdyAjcjknCyux3FG
         i+m+r/thBVPh6KXPPhmytoe71jCpLN14u8Dp8vic++s66q0QosDUTZD98LPor/l40gef
         1uAuCei760DFK1fnSw7LHx7u5XO7FP8vcOCBFb0l3Dij6/CnxrgHgcoI2FMqnYlDmNh9
         O9knG2QS1IV6yyNbtsH0fb8elyajTMnLQ0e1OenmGaOjuc0TJwWf00DVgK4GCxzZn8eu
         4MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJSMn3jpBFaoWnFhXfxzbCr5VeROd8nSpVMKZfWqpg0=;
        b=s0IO5XWrdWiHvOmU94kWcf3drjzM1tSV3fKpEuNU9b/rt6EiZ/su8SC+sdFFT2V3wx
         Uq8PPtQ4j0huYHa8XJd1xJEY7hmxWEOwxtFoi/Y1z5cspLnGcpR+JiIZ8TWP1kr1UyH/
         0HDd5K7KqNyu+eCcZutELcFWutLmqnKY2D56wckRpUoRkZ6teI3f+c8tdgXs1q84xtqY
         0BNNXNV3pK0IR+5VzexYGP7Q298Hj03qI/1nVcCo24PxcpnW8bdWR1FeF0FcCkvblpym
         WVfjJuHdWZOx3kHODdUdwSNkTzM93VqEqDxPBLEiyfNprpZz8+QJS22GOP/70bt2LZY8
         XoNQ==
X-Gm-Message-State: AOAM533PisUtiG3YR7KpblASgRE/O5h8EDn+1+DyVdPJKxC6m3GcmN4v
        /7ZoC9emHJaMumgeqioDDzZMWA==
X-Google-Smtp-Source: ABdhPJyjRe3PaZTn4HrximByVSA39ntqukPKNkFtJ3dSsk3q4im4Xap5AJJ+lGj/ce5vHmheItyaPA==
X-Received: by 2002:a19:7605:0:b0:443:1126:3756 with SMTP id c5-20020a197605000000b0044311263756mr6874229lff.641.1645229532792;
        Fri, 18 Feb 2022 16:12:12 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p9sm484614ljm.10.2022.02.18.16.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:12:11 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 1ECF9103A56; Sat, 19 Feb 2022 03:13:07 +0300 (+03)
To:     bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: [PATCHv3.1 2.1/2] x86/coco: Add API to handle encryption mask
Date:   Sat, 19 Feb 2022 03:13:05 +0300
Message-Id: <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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

Provide vendor-neutral API to deal with the mask:

  - cc_mkenc() and cc_mkdec() modify given address to make it
    encrypted/decrypted. It can be applied to phys_addr_t, pgprotval_t
    or page table entry value.

  - cc_get_mask() returns encryption or decrypthion mask. It is useful
    for set_memory_encrypted() and set_memory_decrypted()
    implementation.

The implementation will be extended to cover TDX.

pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio).
cc_mkdec() called by pgprot_decrypted(). Export cc_mkdec().

HyperV doesn't use bits in page table entries, so the mask is 0 for both
encrypthion and decrypthion.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/coco.h        | 12 +++++++++-
 arch/x86/include/asm/pgtable.h     | 13 ++++++-----
 arch/x86/kernel/cc_platform.c      | 35 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mshyperv.c     |  2 +-
 arch/x86/mm/mem_encrypt_identity.c |  2 +-
 arch/x86/mm/pat/set_memory.c       |  4 ++--
 6 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 6e770e0dd683..802d87d08e31 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -11,6 +11,16 @@ enum cc_vendor {
 	CC_VENDOR_INTEL,
 };
 
-void cc_init(enum cc_vendor);
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
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 891d3074a16e..93e6be7b7eca 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -13,6 +13,7 @@
 #include <asm/coco.h>
 #include <asm/processor.h>
 
+static u64 cc_mask;
 static enum cc_vendor cc_vendor;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
@@ -84,7 +85,39 @@ bool cc_platform_has(enum cc_attr attr)
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
 
-__init void cc_init(enum cc_vendor vendor)
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
 {
 	cc_vendor = vendor;
+	cc_mask = mask;
 }
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index d77cf3a31f07..9af6be143998 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -346,7 +346,7 @@ static void __init ms_hyperv_init_platform(void)
 		swiotlb_force = SWIOTLB_FORCE;
 #endif
 		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
-			cc_init(CC_VENDOR_HYPERV);
+			cc_init(CC_VENDOR_HYPERV, 0);
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index eb7fbd85b77e..fa758247ab57 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -603,5 +603,5 @@ void __init sme_enable(struct boot_params *bp)
 out:
 	physical_mask &= ~sme_me_mask;
 	if (sme_me_mask)
-		cc_init(CC_VENDOR_AMD);
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

