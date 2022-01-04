Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329C3484958
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiADUg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:36:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:21446 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231175AbiADUg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641328587; x=1672864587;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to;
  bh=0YwvshV7bST0XS9o1Eec+wzkvwv3XFaskv0ZpRL4us0=;
  b=fZBTlL+t1VOaOYLG3amn5DPz11p7/ah8TClMcCSeDWtSo8kHh8RE+mwi
   X0O0XA73YTCbi2NOPN0mU5gyLxijHdt//W5sLsuP+e0Y9Pb/3RebciIP/
   YujMklnB1O0OqQLSI5f8trNDISKptJsyKPnCg4lCFurPB8vPExgJl0YEG
   noaUUHXsOeF1FmB49+CNsjOu+G9SMrg1Gt4RV6Eh4/RNm35Vkm1k1mKND
   abYLsXEw9X+UiYj5JtN6FZbQf2bh2Inr3dBUEGBiQd2j67P0dTJoRbM2J
   AGpbVdUPghg4z8SvmMKvTek6boxPbTTdGOMkbK/XDR3feEyFN5WE881ze
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242253020"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242253020"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 12:36:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="556286709"
Received: from mncallah-mobl.amr.corp.intel.com (HELO [10.209.35.108]) ([10.209.35.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 12:36:08 -0800
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
 <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
Date:   Tue, 4 Jan 2022 12:36:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
Content-Type: multipart/mixed;
 boundary="------------55385EAD2CB070F6D485B09D"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------55385EAD2CB070F6D485B09D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 1/4/22 11:14 AM, Kirill A. Shutemov wrote:
> I see two possible options (I hate both): leave it defined in per-arch
> <asm/pgtable.h> or move it to <linux/mm.h> next to user in
> io_remap_pfn_range().

Could we do an asm-generic/pgprot.h that was basically just:

	typedef struct { unsigned long pgprot; } pgprot_t;

That would cover probably 80% of the of the architectures.  The rest of
them could define an actual asm/pgprot.h.

It doesn't seem to be *that* much work, although it is a bit of a shame
that pgtable-types.h doesn't fix this already.  I've attached something
that compiles on s390 (representing a random non-x86 architecture) and x86.


--------------55385EAD2CB070F6D485B09D
Content-Type: text/x-patch; charset=UTF-8;
 name="pgprot-generic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pgprot-generic.patch"



---

 b/arch/alpha/include/asm/page.h               |    3 +--
 b/arch/arc/include/asm/page.h                 |    5 +----
 b/arch/csky/include/asm/page.h                |    2 +-
 b/arch/hexagon/include/asm/page.h             |    2 +-
 b/arch/ia64/include/asm/page.h                |    3 +--
 b/arch/m68k/include/asm/page.h                |    2 +-
 b/arch/microblaze/include/asm/page.h          |    2 +-
 b/arch/mips/include/asm/page.h                |    2 +-
 b/arch/nios2/include/asm/page.h               |    2 +-
 b/arch/openrisc/include/asm/page.h            |    4 +---
 b/arch/parisc/include/asm/page.h              |    3 +--
 b/arch/powerpc/include/asm/pgtable-be-types.h |    2 +-
 b/arch/powerpc/include/asm/pgtable-types.h    |    3 ++-
 b/arch/riscv/include/asm/page.h               |    5 +----
 b/arch/s390/include/asm/page.h                |    2 +-
 b/arch/sh/include/asm/page.h                  |    3 +--
 b/arch/sparc/include/asm/page_32.h            |    3 +--
 b/arch/sparc/include/asm/page_64.h            |    3 +--
 b/arch/um/include/asm/page.h                  |    3 +--
 b/arch/xtensa/include/asm/page.h              |    2 +-
 b/include/asm-generic/page.h                  |    4 +---
 b/include/asm-generic/pgprot.h                |   11 +++++++++++
 b/include/linux/pgprot.h                      |   11 +++++++++++
 b/mm/Kconfig                                  |    3 +++
 24 files changed, 47 insertions(+), 38 deletions(-)

diff -puN /dev/null include/asm-generic/pgprot.h
--- /dev/null	2021-12-18 19:45:56.730362955 -0800
+++ b/include/asm-generic/pgprot.h	2022-01-04 12:01:29.406531997 -0800
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_PGPROT_H
+#define _ASM_GENERIC_PGPROT_H
+
+#ifndef __ASSEMBLY__
+
+typedef struct { unsigned long pgprot; } pgprot_t;
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _ASM_GENERIC_PGPROT_H */
diff -puN arch/alpha/include/asm/page.h~pgprot-generic arch/alpha/include/asm/page.h
--- a/arch/alpha/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.627180808 -0800
+++ b/arch/alpha/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -3,6 +3,7 @@
 #define _ALPHA_PAGE_H
 
 #include <linux/const.h>
+#include <asm-generic/pgprot.h>
 #include <asm/pal.h>
 
 /* PAGE_SHIFT determines the page size */
@@ -31,7 +32,6 @@ extern void copy_page(void * _to, void *
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 
 #define pte_val(x)	((x).pte)
 #define pmd_val(x)	((x).pmd)
@@ -50,7 +50,6 @@ typedef struct { unsigned long pgprot; }
 typedef unsigned long pte_t;
 typedef unsigned long pmd_t;
 typedef unsigned long pgd_t;
-typedef unsigned long pgprot_t;
 
 #define pte_val(x)	(x)
 #define pmd_val(x)	(x)
diff -puN arch/arc/include/asm/page.h~pgprot-generic arch/arc/include/asm/page.h
--- a/arch/arc/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.631180762 -0800
+++ b/arch/arc/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -5,6 +5,7 @@
 #ifndef __ASM_ARC_PAGE_H
 #define __ASM_ARC_PAGE_H
 
+#include <asm-generic/pgprot.h>
 #include <uapi/asm/page.h>
 
 #ifdef CONFIG_ARC_HAS_PAE40
@@ -74,10 +75,6 @@ typedef struct {
 #define pte_val(x)	((x).pte)
 #define __pte(x)	((pte_t) { (x) })
 
-typedef struct {
-	unsigned long pgprot;
-} pgprot_t;
-
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) })
 #define pte_pgprot(x)	__pgprot(pte_val(x))
diff -puN arch/csky/include/asm/page.h~pgprot-generic arch/csky/include/asm/page.h
--- a/arch/csky/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.635180717 -0800
+++ b/arch/csky/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -5,6 +5,7 @@
 
 #include <asm/setup.h>
 #include <asm/cache.h>
+#include <asm-generic/pgprot.h>
 #include <linux/const.h>
 
 /*
@@ -60,7 +61,6 @@ typedef struct { unsigned long pte_low;
 #define pte_val(x)	((x).pte_low)
 
 typedef struct { unsigned long pgd; } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 typedef struct page *pgtable_t;
 
 #define pgd_val(x)	((x).pgd)
diff -puN arch/hexagon/include/asm/page.h~pgprot-generic arch/hexagon/include/asm/page.h
--- a/arch/hexagon/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.635180717 -0800
+++ b/arch/hexagon/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -9,6 +9,7 @@
 #define _ASM_PAGE_H
 
 #include <linux/const.h>
+#include <asm-generic/pgprot.h>
 
 /*  This is probably not the most graceful way to handle this.  */
 
@@ -68,7 +69,6 @@
  */
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 typedef struct page *pgtable_t;
 
 #define pte_val(x)     ((x).pte)
diff -puN arch/ia64/include/asm/page.h~pgprot-generic arch/ia64/include/asm/page.h
--- a/arch/ia64/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.635180717 -0800
+++ b/arch/ia64/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -10,6 +10,7 @@
 
 #include <asm/intrinsics.h>
 #include <asm/types.h>
+#include <asm-generic/pgprot.h>
 
 /*
  * The top three bits of an IA64 address are its Region Number.
@@ -158,7 +159,6 @@ get_order (unsigned long size)
   typedef struct { unsigned long pud; } pud_t;
 #endif
   typedef struct { unsigned long pgd; } pgd_t;
-  typedef struct { unsigned long pgprot; } pgprot_t;
   typedef struct page *pgtable_t;
 
 # define pte_val(x)	((x).pte)
@@ -181,7 +181,6 @@ get_order (unsigned long size)
     typedef unsigned long pte_t;
     typedef unsigned long pmd_t;
     typedef unsigned long pgd_t;
-    typedef unsigned long pgprot_t;
     typedef struct page *pgtable_t;
 # endif
 
diff -puN arch/m68k/include/asm/page.h~pgprot-generic arch/m68k/include/asm/page.h
--- a/arch/m68k/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.635180717 -0800
+++ b/arch/m68k/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -5,6 +5,7 @@
 #include <linux/const.h>
 #include <asm/setup.h>
 #include <asm/page_offset.h>
+#include <asm-generic/pgprot.h>
 
 /* PAGE_SHIFT determines the page size */
 #if defined(CONFIG_SUN3) || defined(CONFIG_COLDFIRE)
@@ -29,7 +30,6 @@ typedef struct { unsigned long pmd; } pm
 
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 
 #if defined(CONFIG_SUN3)
 /*
diff -puN arch/microblaze/include/asm/page.h~pgprot-generic arch/microblaze/include/asm/page.h
--- a/arch/microblaze/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.639180672 -0800
+++ b/arch/microblaze/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -15,6 +15,7 @@
 #include <linux/pfn.h>
 #include <asm/setup.h>
 #include <asm/asm-compat.h>
+#include <asm-generic/pgprot.h>
 #include <linux/const.h>
 
 #ifdef __KERNEL__
@@ -62,7 +63,6 @@ typedef unsigned long pte_basic_t;
  */
 typedef struct page *pgtable_t;
 typedef struct { unsigned long	pte; }		pte_t;
-typedef struct { unsigned long	pgprot; }	pgprot_t;
 /* FIXME this can depend on linux kernel version */
 typedef struct { unsigned long pgd; } pgd_t;
 
diff -puN arch/mips/include/asm/page.h~pgprot-generic arch/mips/include/asm/page.h
--- a/arch/mips/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.639180672 -0800
+++ b/arch/mips/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -13,6 +13,7 @@
 #include <linux/const.h>
 #include <linux/kernel.h>
 #include <asm/mipsregs.h>
+#include <asm-generic/pgprot.h>
 
 /*
  * PAGE_SHIFT determines the page size
@@ -151,7 +152,6 @@ typedef struct { unsigned long pgd; } pg
 /*
  * Manipulate page protection bits
  */
-typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) } )
 #define pte_pgprot(x)	__pgprot(pte_val(x) & ~_PFN_MASK)
diff -puN arch/nios2/include/asm/page.h~pgprot-generic arch/nios2/include/asm/page.h
--- a/arch/nios2/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.639180672 -0800
+++ b/arch/nios2/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -17,6 +17,7 @@
 
 #include <linux/pfn.h>
 #include <linux/const.h>
+#include <asm-generic/pgprot.h>
 
 /*
  * PAGE_SHIFT determines the page size
@@ -60,7 +61,6 @@ extern void copy_user_page(void *vto, vo
 typedef struct page *pgtable_t;
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 
 #define pte_val(x)	((x).pte)
 #define pgd_val(x)	((x).pgd)
diff -puN arch/openrisc/include/asm/page.h~pgprot-generic arch/openrisc/include/asm/page.h
--- a/arch/openrisc/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.643180627 -0800
+++ b/arch/openrisc/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -15,6 +15,7 @@
 #ifndef __ASM_OPENRISC_PAGE_H
 #define __ASM_OPENRISC_PAGE_H
 
+#include <asm-generic/pgprot.h>
 
 /* PAGE_SHIFT determines the page size */
 
@@ -51,9 +52,6 @@ typedef struct {
 typedef struct {
 	unsigned long pgd;
 } pgd_t;
-typedef struct {
-	unsigned long pgprot;
-} pgprot_t;
 typedef struct page *pgtable_t;
 
 #define pte_val(x)	((x).pte)
diff -puN arch/parisc/include/asm/page.h~pgprot-generic arch/parisc/include/asm/page.h
--- a/arch/parisc/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.643180627 -0800
+++ b/arch/parisc/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -3,6 +3,7 @@
 #define _PARISC_PAGE_H
 
 #include <linux/const.h>
+#include <asm-generic/pgprot.h>
 
 #if defined(CONFIG_PARISC_PAGE_SIZE_4KB)
 # define PAGE_SHIFT	12
@@ -43,7 +44,6 @@ typedef struct { unsigned long pte; } pt
 /* NOTE: even on 64 bits, these entries are __u32 because we allocate
  * the pmd and pgd in ZONE_DMA (i.e. under 4GB) */
 typedef struct { __u32 pgd; } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 
 #if CONFIG_PGTABLE_LEVELS == 3
 typedef struct { __u32 pmd; } pmd_t;
@@ -73,7 +73,6 @@ typedef         __u32 pmd_t;
 #endif
 
 typedef         __u32 pgd_t;
-typedef unsigned long pgprot_t;
 
 #define pte_val(x)      (x)
 #define pgd_val(x)      (x)
diff -puN arch/powerpc/include/asm/pgtable-be-types.h~pgprot-generic arch/powerpc/include/asm/pgtable-be-types.h
--- a/arch/powerpc/include/asm/pgtable-be-types.h~pgprot-generic	2022-01-04 12:00:31.643180627 -0800
+++ b/arch/powerpc/include/asm/pgtable-be-types.h	2022-01-04 12:00:31.659180446 -0800
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_PGTABLE_BE_TYPES_H
 
 #include <asm/cmpxchg.h>
+#include <asm-generic/pgprot.h>
 
 /* PTE level */
 typedef struct { __be64 pte; } pte_t;
@@ -64,7 +65,6 @@ static inline __be64 pgd_raw(pgd_t x)
 }
 
 /* Page protection bits */
-typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) })
 
diff -puN arch/powerpc/include/asm/pgtable-types.h~pgprot-generic arch/powerpc/include/asm/pgtable-types.h
--- a/arch/powerpc/include/asm/pgtable-types.h~pgprot-generic	2022-01-04 12:00:31.647180582 -0800
+++ b/arch/powerpc/include/asm/pgtable-types.h	2022-01-04 12:00:42.743055453 -0800
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_PGTABLE_TYPES_H
 #define _ASM_POWERPC_PGTABLE_TYPES_H
 
+#include <asm-generic/pgprot.h>
+
 /* PTE level */
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
 typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
@@ -41,7 +43,6 @@ static inline unsigned long pgd_val(pgd_
 }
 
 /* Page protection bits */
-typedef struct { unsigned long pgprot; } pgprot_t;
 #define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) })
 
diff -puN arch/riscv/include/asm/page.h~pgprot-generic arch/riscv/include/asm/page.h
--- a/arch/riscv/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.647180582 -0800
+++ b/arch/riscv/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -11,6 +11,7 @@
 
 #include <linux/pfn.h>
 #include <linux/const.h>
+#include <asm-generic/pgprot.h>
 
 #define PAGE_SHIFT	(12)
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
@@ -58,10 +59,6 @@ typedef struct {
 	unsigned long pte;
 } pte_t;
 
-typedef struct {
-	unsigned long pgprot;
-} pgprot_t;
-
 typedef struct page *pgtable_t;
 
 #define pte_val(x)	((x).pte)
diff -puN arch/s390/include/asm/page.h~pgprot-generic arch/s390/include/asm/page.h
--- a/arch/s390/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.647180582 -0800
+++ b/arch/s390/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -10,6 +10,7 @@
 
 #include <linux/const.h>
 #include <asm/types.h>
+#include <asm-generic/pgprot.h>
 
 #define _PAGE_SHIFT	12
 #define _PAGE_SIZE	(_AC(1, UL) << _PAGE_SHIFT)
@@ -79,7 +80,6 @@ static inline void copy_page(void *to, v
  * These are used to make use of C type-checking..
  */
 
-typedef struct { unsigned long pgprot; } pgprot_t;
 typedef struct { unsigned long pgste; } pgste_t;
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
diff -puN arch/sh/include/asm/page.h~pgprot-generic arch/sh/include/asm/page.h
--- a/arch/sh/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.647180582 -0800
+++ b/arch/sh/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -7,6 +7,7 @@
  */
 
 #include <linux/const.h>
+#include <asm-generic/pgprot.h>
 
 /* PAGE_SHIFT determines the page size */
 #if defined(CONFIG_PAGE_SIZE_4KB)
@@ -74,7 +75,6 @@ extern void clear_user_highpage(struct p
  */
 #ifdef CONFIG_X2TLB
 typedef struct { unsigned long pte_low, pte_high; } pte_t;
-typedef struct { unsigned long long pgprot; } pgprot_t;
 typedef struct { unsigned long long pgd; } pgd_t;
 #define pte_val(x) \
 	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
@@ -82,7 +82,6 @@ typedef struct { unsigned long long pgd;
 	({ pte_t __pte = {(x), ((unsigned long long)(x)) >> 32}; __pte; })
 #else
 typedef struct { unsigned long pte_low; } pte_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 typedef struct { unsigned long pgd; } pgd_t;
 #define pte_val(x)	((x).pte_low)
 #define __pte(x)	((pte_t) { (x) } )
diff -puN arch/sparc/include/asm/page_32.h~pgprot-generic arch/sparc/include/asm/page_32.h
--- a/arch/sparc/include/asm/page_32.h~pgprot-generic	2022-01-04 12:00:31.651180536 -0800
+++ b/arch/sparc/include/asm/page_32.h	2022-01-04 12:00:31.659180446 -0800
@@ -10,6 +10,7 @@
 #define _SPARC_PAGE_H
 
 #include <linux/const.h>
+#include <asm-generic/pgprot.h>
 
 #define PAGE_SHIFT   12
 #define PAGE_SIZE    (_AC(1, UL) << PAGE_SHIFT)
@@ -57,7 +58,6 @@ typedef struct { unsigned long iopte; }
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long ctxd; } ctxd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 typedef struct { unsigned long iopgprot; } iopgprot_t;
 
 #define pte_val(x)	((x).pte)
@@ -85,7 +85,6 @@ typedef unsigned long iopte_t;
 typedef unsigned long pmd_t;
 typedef unsigned long pgd_t;
 typedef unsigned long ctxd_t;
-typedef unsigned long pgprot_t;
 typedef unsigned long iopgprot_t;
 
 #define pte_val(x)	(x)
diff -puN arch/sparc/include/asm/page_64.h~pgprot-generic arch/sparc/include/asm/page_64.h
--- a/arch/sparc/include/asm/page_64.h~pgprot-generic	2022-01-04 12:00:31.651180536 -0800
+++ b/arch/sparc/include/asm/page_64.h	2022-01-04 12:00:31.659180446 -0800
@@ -3,6 +3,7 @@
 #define _SPARC64_PAGE_H
 
 #include <linux/const.h>
+#include <asm-generic/pgprot.h>
 
 #define PAGE_SHIFT   13
 
@@ -71,7 +72,6 @@ typedef struct { unsigned long iopte; }
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pud; } pud_t;
 typedef struct { unsigned long pgd; } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 
 #define pte_val(x)	((x).pte)
 #define iopte_val(x)	((x).iopte)
@@ -94,7 +94,6 @@ typedef unsigned long iopte_t;
 typedef unsigned long pmd_t;
 typedef unsigned long pud_t;
 typedef unsigned long pgd_t;
-typedef unsigned long pgprot_t;
 
 #define pte_val(x)	(x)
 #define iopte_val(x)	(x)
diff -puN arch/um/include/asm/page.h~pgprot-generic arch/um/include/asm/page.h
--- a/arch/um/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.651180536 -0800
+++ b/arch/um/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -8,6 +8,7 @@
 #define __UM_PAGE_H
 
 #include <linux/const.h>
+#include <asm-generic/pgprot.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
@@ -77,8 +78,6 @@ typedef unsigned long phys_t;
 
 #endif
 
-typedef struct { unsigned long pgprot; } pgprot_t;
-
 typedef struct page *pgtable_t;
 
 #define pgd_val(x)	((x).pgd)
diff -puN arch/xtensa/include/asm/page.h~pgprot-generic arch/xtensa/include/asm/page.h
--- a/arch/xtensa/include/asm/page.h~pgprot-generic	2022-01-04 12:00:31.655180491 -0800
+++ b/arch/xtensa/include/asm/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -15,6 +15,7 @@
 #include <asm/types.h>
 #include <asm/cache.h>
 #include <asm/kmem_layout.h>
+#include <asm-generic/pgprot.h>
 
 /*
  * PAGE_SHIFT determines the page size
@@ -96,7 +97,6 @@
 
 typedef struct { unsigned long pte; } pte_t;		/* page table entry */
 typedef struct { unsigned long pgd; } pgd_t;		/* PGD table entry */
-typedef struct { unsigned long pgprot; } pgprot_t;
 typedef struct page *pgtable_t;
 
 #define pte_val(x)	((x).pte)
diff -puN include/asm-generic/page.h~pgprot-generic include/asm-generic/page.h
--- a/include/asm-generic/page.h~pgprot-generic	2022-01-04 12:00:31.655180491 -0800
+++ b/include/asm-generic/page.h	2022-01-04 12:00:31.659180446 -0800
@@ -22,6 +22,7 @@
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
 #include <asm/setup.h>
+#include <asm-generic/pgprot.h>
 
 #ifndef __ASSEMBLY__
 
@@ -43,9 +44,6 @@ typedef struct {
 typedef struct {
 	unsigned long pgd;
 } pgd_t;
-typedef struct {
-	unsigned long pgprot;
-} pgprot_t;
 typedef struct page *pgtable_t;
 
 #define pte_val(x)	((x).pte)
diff -puN mm/Kconfig~pgprot-generic mm/Kconfig
--- a/mm/Kconfig~pgprot-generic	2022-01-04 12:19:11.630471295 -0800
+++ b/mm/Kconfig	2022-01-04 12:20:53.662193722 -0800
@@ -871,6 +871,9 @@ config READ_ONLY_THP_FOR_FS
 config ARCH_HAS_PTE_SPECIAL
 	bool
 
+config ARCH_SPECIFIC_PGPROT
+	bool
+
 #
 # Some architectures require a special hugepage directory format that is
 # required to support multiple hugepage sizes. For example a4fe3ce76
diff -puN /dev/null include/linux/pgprot.h
--- /dev/null	2021-12-18 19:45:56.730362955 -0800
+++ b/include/linux/pgprot.h	2022-01-04 12:22:45.369778316 -0800
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGPROT_H
+#define _LINUX_PGPROT_H
+
+#ifdef CONFIG_ARCH_SPECIFIC_PGPROT
+#include <asm/pgprot.h>
+#endif
+#include <asm-generic/pgprot.h>
+#endif /* !__ASSEMBLY__ */
+
+#endif /* _LINUX_PGPROT_H */
_

--------------55385EAD2CB070F6D485B09D
Content-Type: text/x-patch; charset=UTF-8;
 name="pgprot-x86.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pgprot-x86.patch"



---

 b/arch/x86/Kconfig                     |    1 +
 b/arch/x86/include/asm/pgprot.h        |   17 +++++++++++++++++
 b/arch/x86/include/asm/pgtable_types.h |    3 +--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff -puN arch/x86/include/asm/pgtable_types.h~pgprot-x86 arch/x86/include/asm/pgtable_types.h
--- a/arch/x86/include/asm/pgtable_types.h~pgprot-x86	2022-01-04 12:25:16.081071937 -0800
+++ b/arch/x86/include/asm/pgtable_types.h	2022-01-04 12:27:21.628384053 -0800
@@ -6,6 +6,7 @@
 #include <linux/mem_encrypt.h>
 
 #include <asm/page_types.h>
+#include <asm/pgprot.h>
 
 #define _PAGE_BIT_PRESENT	0	/* is present */
 #define _PAGE_BIT_RW		1	/* writeable */
@@ -277,8 +278,6 @@ enum page_cache_mode {
  */
 #define PTE_FLAGS_MASK		(~PTE_PFN_MASK)
 
-typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
-
 typedef struct { pgdval_t pgd; } pgd_t;
 
 static inline pgprot_t pgprot_nx(pgprot_t prot)
diff -puN /dev/null arch/x86/include/asm/pgprot.h
--- /dev/null	2021-12-18 19:45:56.730362955 -0800
+++ b/arch/x86/include/asm/pgprot.h	2022-01-04 12:28:11.148092692 -0800
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_PGPROT_H
+#define _ASM_GENERIC_PGPROT_H
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_X86_PAE
+typedef u64     pgprotval_t;
+#else
+typedef unsigned long pgprotval_t;
+#endif
+
+typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
+
+#endif
+
+#endif /* _ASM_GENERIC_PGPROT_H */
diff -puN arch/x86/Kconfig~pgprot-x86 arch/x86/Kconfig
--- a/arch/x86/Kconfig~pgprot-x86	2022-01-04 12:25:54.272871099 -0800
+++ b/arch/x86/Kconfig	2022-01-04 12:26:29.220680655 -0800
@@ -267,6 +267,7 @@ config X86
 	select HAVE_ARCH_KCSAN			if X86_64
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	select ARCH_SPECIFIC_PGPROT
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 
 config INSTRUCTION_DECODER
_

--------------55385EAD2CB070F6D485B09D--
