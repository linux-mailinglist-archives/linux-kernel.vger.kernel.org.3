Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE5B4BF6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiBVLDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBVLD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:03:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436FBA9973
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645527782; x=1677063782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yUrwj5E/F7AoILmfvYw5jCWArXoiGjjQGiO38xKyypQ=;
  b=b8D1iAxh8QwUo7HZcNYTEaf6mpDyDjeS+mbO4Xn+41Zzir34up9QF4OQ
   nSCQt6P8WDtLkF/cmuLy5kof3NKBZkNmH3XERIOWvfPQm/yHgS5oOFDip
   mw/XBv7aYOa3VpsRs+GEqFzb/RjlvmQ/X02gT41l7gHicDsX5k4m35Izy
   WTrOKMCdPwRPCbAGOTfpDzNcyRc970gAMkG5PrAtwxfrhuP4EYdnF9X/V
   K31xznUsIIqYLUX0r8q+nXWYduglqAHuilx5YguEzz+wrrpCyorw0Y5jC
   LLG0XPX8p9ZpYALRNwxWp4GN5vTdZTcxOWzhRcCVo2o/OjzfBY/jbunFK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251427913"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="251427913"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 03:03:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="779066664"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 22 Feb 2022 03:02:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9B35412C; Tue, 22 Feb 2022 13:03:12 +0200 (EET)
Date:   Tue, 22 Feb 2022 14:03:12 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
Message-ID: <20220222110312.q7eaepfph2tyjq3e@black.fi.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
 <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
 <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
 <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
 <20220221222856.c6b74b3n3fwqe6vy@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221222856.c6b74b3n3fwqe6vy@black.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 01:28:56AM +0300, Kirill A. Shutemov wrote:
> On Mon, Feb 21, 2022 at 11:28:16AM -0800, Dave Hansen wrote:
> > I'm just a bit confused why *this* was chosen as the cc_whatever() hook.
> >  Just like the mask function, it has one spot where it gets used:
> > 
> > +#define pgprot_encrypted(prot)	__pgprot(cc_mkenc(pgprot_val(prot)))
> > +#define pgprot_decrypted(prot)	__pgprot(cc_mkdec(pgprot_val(prot)))
> > 
> > So, why bother having another level of abstraction?
> > 
> > Why don't we just have:
> > 
> > 	pgprot_t cc_mkenc(pgprot prot)
> > 	pgprot_t cc_mkenc(pgprot prot)
> > 
> > and *no* pgprot_{en,de}crypted()?
> 
> Okay. Let me try this.

Below it how it would look like.

I don't like it, especially, tdx_enc_status_changed() case. There are more
cases like this in attestation code.

I would rather make cc_mkenc()/cc_mkdec() to operate on u64 (or
phys_addr_t?) while pgprot_encrypted()/pgprot_decrypted() cover pgprot_t.
It also makes set_memory cleaner:

	cpa.mask_set = __pgprot(enc ? cc_mkenc(0) : cc_mkdec(0));
	cpa.mask_clr = __pgprot(enc ? cc_mkdec(0) : cc_mkenc(0));

Opinions?

diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
index fb32c271fe34..bf5ba7d5b736 100644
--- a/arch/x86/coco/tdx.c
+++ b/arch/x86/coco/tdx.c
@@ -514,8 +514,8 @@ static int tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		return -EINVAL;
 
 	if (!enc) {
-		start = cc_mkenc(start);
-		end = cc_mkenc(end);
+		start |= pgprot_val(cc_mkenc(__pgprot(0)));
+		end |= pgprot_val(cc_mkenc(__pgprot(0)));
 	}
 
 	/*
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 802d87d08e31..fba1dd2ef319 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -14,13 +14,18 @@ enum cc_vendor {
 void cc_init(enum cc_vendor, u64 mask);
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-u64 cc_get_mask(bool enc);
-u64 cc_mkenc(u64 val);
-u64 cc_mkdec(u64 val);
+pgprot_t cc_mkenc(pgprot_t prot);
+pgprot_t cc_mkdec(pgprot_t prot);
 #else
-#define cc_get_mask(enc)	0
-#define cc_mkenc(val)		(val)
-#define cc_mkdec(val)		(val)
+static inline pgprot_t cc_mkenc(pgprot_t prot)
+{
+	return prot;
+}
+
+static inline pgprot_t cc_mkdec(pgprot_t prot)
+{
+	return prot;
+}
 #endif
 
 #endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 62ab07e24aef..8cba0d258e49 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -36,8 +36,8 @@ void ptdump_walk_user_pgd_level_checkwx(void);
 /*
  * Macros to add or remove encryption attribute
  */
-#define pgprot_encrypted(prot)	__pgprot(cc_mkenc(pgprot_val(prot)))
-#define pgprot_decrypted(prot)	__pgprot(cc_mkdec(pgprot_val(prot)))
+#define pgprot_encrypted(prot)	cc_mkenc(prot)
+#define pgprot_decrypted(prot)	cc_mkdec(prot)
 
 #ifdef CONFIG_DEBUG_WX
 #define debug_checkwx()		ptdump_walk_pgd_level_checkwx()
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 12a34e80ef50..d13a034e9a21 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -12,6 +12,7 @@
 
 #include <asm/coco.h>
 #include <asm/processor.h>
+#include <asm/pgtable_types.h>
 
 static u64 cc_mask;
 static enum cc_vendor cc_vendor;
@@ -93,39 +94,27 @@ bool cc_platform_has(enum cc_attr attr)
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
 
-u64 cc_get_mask(bool enc)
+pgprot_t cc_mkenc(pgprot_t prot)
 {
 	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
-		return enc ? cc_mask : 0;
+		return __pgprot(pgprot_val(prot) | cc_mask);
 	case CC_VENDOR_INTEL:
-		return enc ? 0 : cc_mask;
+		return __pgprot(pgprot_val(prot) & ~cc_mask);
 	default:
-		return 0;
+		return prot;
 	}
 }
 
-u64 cc_mkenc(u64 val)
+pgprot_t cc_mkdec(pgprot_t prot)
 {
 	switch (cc_vendor) {
 	case CC_VENDOR_AMD:
-		return val | cc_mask;
+		return __pgprot(pgprot_val(prot) & ~cc_mask);
 	case CC_VENDOR_INTEL:
-		return val & ~cc_mask;
+		return __pgprot(pgprot_val(prot) | cc_mask);
 	default:
-		return val;
-	}
-}
-
-u64 cc_mkdec(u64 val)
-{
-	switch (cc_vendor) {
-	case CC_VENDOR_AMD:
-		return val & ~cc_mask;
-	case CC_VENDOR_INTEL:
-		return val | cc_mask;
-	default:
-		return val;
+		return prot;
 	}
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 65a27dec095f..1ef63ea377dd 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1999,8 +1999,8 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	memset(&cpa, 0, sizeof(cpa));
 	cpa.vaddr = &addr;
 	cpa.numpages = numpages;
-	cpa.mask_set = __pgprot(cc_get_mask(enc));
-	cpa.mask_clr = __pgprot(cc_get_mask(!enc));
+	cpa.mask_set = enc ? cc_mkenc(__pgprot(0)) : cc_mkdec(__pgprot(0));
+	cpa.mask_clr = enc ? cc_mkdec(__pgprot(0)) : cc_mkenc(__pgprot(0));
 	cpa.pgd = init_mm.pgd;
 
 	/* Must avoid aliasing mappings in the highmem code */
-- 
 Kirill A. Shutemov
