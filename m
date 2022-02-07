Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486374AC1C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383480AbiBGOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392204AbiBGOYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:24:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25BC0401C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:24:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E073B80B44
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFD2C340F0;
        Mon,  7 Feb 2022 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644243856;
        bh=nuxygkBprsNkn9ipH0fMeqRTMCJPy/JXzipwoI0EJmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OKbaj8RaJVkghMY72xBj+itCltHONqRtW+1habiZhzIacDf1TCUpbOmSVtPQlRmdj
         lCBSdsNBUoZqF99pv70CjRCQ8Z+ooiJqWZYX2+4U6RdyM17VCkJUjwVWMJsGjPgfur
         ZhCqVqxuRI35H2gFaOioGRhTMgGz9jW0Ve9nCpZJwSudFetIeNNKqJrLGK91Jf8yzk
         3hLAyzTvgOvPakou1oWxCKNEYZ2Jae4lgbswlaEtMuN8Tjy9JSWDFO6SLLzdMJkEcP
         KSj/AmPL//4/nf1uMCzYvtwbfVjQixWWwmT/N8xxzMWaeRt9mNkF6FXHz04hgJRJAS
         Po37Ybbc6c4ig==
Date:   Mon, 7 Feb 2022 16:24:09 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41/75] hexagon: Add pmd_pfn()
Message-ID: <YgEriTI5iGNTiYwZ@kernel.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-42-willy@infradead.org>
 <YgAPtxN7WW222SFI@kernel.org>
 <YgAztSuYrKXZBgJx@casper.infradead.org>
 <YgA+tGqw70ZBTu/1@kernel.org>
 <YgBGLyl4SKWikon0@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgBGLyl4SKWikon0@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2022 at 10:05:35PM +0000, Matthew Wilcox wrote:
> On Sun, Feb 06, 2022 at 11:33:40PM +0200, Mike Rapoport wrote:
> > On Sun, Feb 06, 2022 at 08:46:45PM +0000, Matthew Wilcox wrote:
> > > On Sun, Feb 06, 2022 at 08:13:11PM +0200, Mike Rapoport wrote:
> > > > On Fri, Feb 04, 2022 at 07:58:18PM +0000, Matthew Wilcox (Oracle) wrote:
> > > > > I need to use this function in common code, so define it for hexagon.
> > > > > 
> > > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > > ---
> > > > >  arch/hexagon/include/asm/pgtable.h | 3 ++-
> > > > 
> > > > Why hexagon out of all architectures?
> > > > What about m68k, nios2, nds32 etc?
> > 
> > > Presumably they don't support CONFIG_TRANSPARENT_HUGEPAGE.
> > > This code isn't compiled when THP are disabled; at least I haven't
> > > had a buildbot complaint for any other architectures.
> > 
> > m68k defconfig fails:
> > 
> >   CC      mm/page_vma_mapped.o
> > mm/page_vma_mapped.c: In function 'page_vma_mapped_walk':
> > mm/page_vma_mapped.c:219:20: error: implicit declaration of function 'pmd_pfn'; did you mean 'pmd_off'? [-Werror=implicit-function-declaration]
> >   219 |     if (!check_pmd(pmd_pfn(pmde), pvmw))
> >       |                    ^~~~~~~
> >       |                    pmd_off
> 
> Ok, so this whole thing is protected by "if (pmd_trans_huge(pmd))"
> which is defined to be 0 if !THP.  But obviously, gcc is trying to parse
> it.  So I think we need something like:
> 
> #ifndef CONFIG_TRANSPARENT_HUGEPAGE
> static inline unsigned long pmd_pfn(pmd_t pmd)
> {
>         BUG();
>         return 0UL;
> }
> #endif
> 
> but that can have its own problem if architectures define pmd_pfn()
> when they don't have CONFIG_TRANSPARENT_HUGEPAGE.  Which of course, they
> can do.

I think the safest would be to define pmd_pfn where it's missing. Then
the whole pmd_pfn(), pmd_page() and pmd_page_vaddr() can be cleaned up on
top, but this won't block folio work.

I've baked a patch that defines pmd_pfn() based on pmd_page_vaddr() or pmd_page()
definition. With pmd_pfn() defined we won't need special care for THP or
!THP cases and PMD is always there even if it's called PGD sometimes.

From e0befabdfb5a4aaeab38a998fa58fe3218e80ad8 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Fri, 4 Feb 2022 13:49:20 -0500
Subject: [PATCH] arch: Add pmd_pfn() where it is missing

Willy needs to use this function in common code, so define it for
architectures and/or configrations that miss it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/include/asm/pgtable.h         | 1 +
 arch/arc/include/asm/hugepage.h          | 1 -
 arch/arc/include/asm/pgtable-levels.h    | 1 +
 arch/arm/include/asm/pgtable-2level.h    | 2 ++
 arch/csky/include/asm/pgtable.h          | 1 +
 arch/hexagon/include/asm/pgtable.h       | 5 +++++
 arch/ia64/include/asm/pgtable.h          | 1 +
 arch/m68k/include/asm/mcf_pgtable.h      | 1 +
 arch/m68k/include/asm/motorola_pgtable.h | 1 +
 arch/m68k/include/asm/sun3_pgtable.h     | 1 +
 arch/microblaze/include/asm/pgtable.h    | 3 +++
 arch/nds32/include/asm/pgtable.h         | 1 +
 arch/nios2/include/asm/pgtable.h         | 1 +
 arch/openrisc/include/asm/pgtable.h      | 1 +
 arch/parisc/include/asm/pgtable.h        | 1 +
 arch/sh/include/asm/pgtable_32.h         | 1 +
 arch/um/include/asm/pgtable.h            | 1 +
 arch/xtensa/include/asm/pgtable.h        | 1 +
 18 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 02f0429f1068..170451fde043 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -233,6 +233,7 @@ pmd_page_vaddr(pmd_t pmd)
 	return ((pmd_val(pmd) & _PFN_MASK) >> (32-PAGE_SHIFT)) + PAGE_OFFSET;
 }
 
+#define pmd_pfn(pmd)	(pmd_val(pmd) >> 32)
 #define pmd_page(pmd)	(pfn_to_page(pmd_val(pmd) >> 32))
 #define pud_page(pud)	(pfn_to_page(pud_val(pud) >> 32))
 
diff --git a/arch/arc/include/asm/hugepage.h b/arch/arc/include/asm/hugepage.h
index 11b0ff26b97b..5001b796fb8d 100644
--- a/arch/arc/include/asm/hugepage.h
+++ b/arch/arc/include/asm/hugepage.h
@@ -31,7 +31,6 @@ static inline pmd_t pte_pmd(pte_t pte)
 
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
 #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
-#define pmd_pfn(pmd)		pte_pfn(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
 
 #define mk_pmd(page, prot)	pte_pmd(mk_pte(page, prot))
diff --git a/arch/arc/include/asm/pgtable-levels.h b/arch/arc/include/asm/pgtable-levels.h
index 8084ef2f6491..7848348719b2 100644
--- a/arch/arc/include/asm/pgtable-levels.h
+++ b/arch/arc/include/asm/pgtable-levels.h
@@ -161,6 +161,7 @@
 #define pmd_present(x)		(pmd_val(x))
 #define pmd_clear(xp)		do { pmd_val(*(xp)) = 0; } while (0)
 #define pmd_page_vaddr(pmd)	(pmd_val(pmd) & PAGE_MASK)
+#define pmd_pfn(pmd)		((pmd_val(pmd) & PAGE_MASK) >> PAGE_SHIFT)
 #define pmd_page(pmd)		virt_to_page(pmd_page_vaddr(pmd))
 #define set_pmd(pmdp, pmd)	(*(pmdp) = pmd)
 #define pmd_pgtable(pmd)	((pgtable_t) pmd_page_vaddr(pmd))
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 70fe69bdcce2..92abd4cd8ca2 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -208,6 +208,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 }
 #define pmd_offset pmd_offset
 
+#define pmd_pfn(pmd)		(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
+
 #define pmd_large(pmd)		(pmd_val(pmd) & 2)
 #define pmd_leaf(pmd)		(pmd_val(pmd) & 2)
 #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 151607ed5158..bbe245117777 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -30,6 +30,7 @@
 #define pgd_ERROR(e) \
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
+#define pmd_pfn(pmd)	(pmd_phys(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd)	(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pte_clear(mm, addr, ptep)	set_pte((ptep), \
 	(((unsigned int) addr >= PAGE_OFFSET) ? __pte(_PAGE_GLOBAL) : __pte(0)))
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 18cd6ea9ab23..0610724d6a28 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -235,6 +235,11 @@ static inline int pmd_bad(pmd_t pmd)
 	return 0;
 }
 
+/*
+ * pmd_pfn - converts a PMD entry to a page frame number
+ */
+#define pmd_pfn(pmd)  (pmd_val(pmd) >> PAGE_SHIFT)
+
 /*
  * pmd_page - converts a PMD entry to a page pointer
  */
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 9584b2c5f394..7aa8f2330fb1 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -267,6 +267,7 @@ ia64_phys_addr_valid (unsigned long addr)
 #define pmd_present(pmd)		(pmd_val(pmd) != 0UL)
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pmd_page_vaddr(pmd)		((unsigned long) __va(pmd_val(pmd) & _PFN_MASK))
+#define pmd_pfn(pmd)			((pmd_val(pmd) & _PFN_MASK) >> PAGE_SHIFT)
 #define pmd_page(pmd)			virt_to_page((pmd_val(pmd) + PAGE_OFFSET))
 
 #define pud_none(pud)			(!pud_val(pud))
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 6f2b87d7a50d..94f38d76e278 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -322,6 +322,7 @@ extern pgd_t kernel_pg_dir[PTRS_PER_PGD];
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	(__pte((x).val))
 
+#define pmd_pfn(pmd)		(pmd_val(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 022c3abc280d..7c9b56e2a750 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -147,6 +147,7 @@ static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
 #define pmd_present(pmd)	(pmd_val(pmd) & _PAGE_TABLE)
 #define pmd_clear(pmdp)		({ pmd_val(*pmdp) = 0; })
 
+#define pmd_pfn(pmd)		((pmd_val(pmd) & _TABLE_MASK) >> PAGE_SHIFT)
 /*
  * m68k does not have huge pages (020/030 actually could), but generic code
  * expects pmd_page() to exists, only to then DCE it all. Provide a dummy to
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index 5b24283a0a42..5e4e753f0d24 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -130,6 +130,7 @@ static inline void pte_clear (struct mm_struct *mm, unsigned long addr, pte_t *p
 ({ pte_t __pte; pte_val(__pte) = pfn | pgprot_val(pgprot); __pte; })
 
 #define pte_page(pte)		virt_to_page(__pte_page(pte))
+#define pmd_pfn(pmd)		(pmd_val(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd)		virt_to_page(pmd_page_vaddr(pmd))
 
 
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index c136a01e467e..0c72646370e1 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -399,6 +399,9 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return ((unsigned long) (pmd_val(pmd) & PAGE_MASK));
 }
 
+/* returns pfn of the pmd entry*/
+#define pmd_pfn(pmd)	(__pa(pmd_val(pmd)) >> PAGE_SHIFT)
+
 /* returns struct *page of the pmd entry*/
 #define pmd_page(pmd)	(pfn_to_page(__pa(pmd_val(pmd)) >> PAGE_SHIFT))
 
diff --git a/arch/nds32/include/asm/pgtable.h b/arch/nds32/include/asm/pgtable.h
index 419f984eef70..7ff144467b29 100644
--- a/arch/nds32/include/asm/pgtable.h
+++ b/arch/nds32/include/asm/pgtable.h
@@ -308,6 +308,7 @@ static inline pmd_t __mk_pmd(pte_t * ptep, unsigned long prot)
 	return pmd;
 }
 
+#define pmd_pfn(pmd)	     (pmd_val(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd)        virt_to_page(__va(pmd_val(pmd)))
 
 /*
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index 4a995fa628ee..262d0609268c 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -235,6 +235,7 @@ static inline void pte_clear(struct mm_struct *mm,
  * and a page entry and page directory to the page they refer to.
  */
 #define pmd_phys(pmd)		virt_to_phys((void *)pmd_val(pmd))
+#define pmd_pfn(pmd)		(pmd_phys(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 
 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index cdd657f80bfa..c3abbf71e09f 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -361,6 +361,7 @@ static inline void pmd_set(pmd_t *pmdp, pte_t *ptep)
 	pmd_val(*pmdp) = _KERNPG_TABLE | (unsigned long) ptep;
 }
 
+#define pmd_pfn(pmd)		(pmd_val(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
 
 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 3e7cf882639f..48d49f207f84 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -405,6 +405,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return ((unsigned long) __va(pmd_address(pmd)));
 }
 
+#define pmd_pfn(pmd)	(pmd_address(pmd) >> PAGE_SHIFT)
 #define __pmd_page(pmd) ((unsigned long) __va(pmd_address(pmd)))
 #define pmd_page(pmd)	virt_to_page((void *)__pmd_page(pmd))
 
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 41be43e99cff..d0240decacca 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -406,6 +406,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return (unsigned long)pmd_val(pmd);
 }
 
+#define pmd_pfn(pmd)		(__pa(pmd_val(pmd)) >> PAGE_SHIFT)
 #define pmd_page(pmd)		(virt_to_page(pmd_val(pmd)))
 
 #ifdef CONFIG_X2TLB
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index b9e20bbe2f75..167e236d9bb8 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -109,6 +109,7 @@ extern unsigned long end_iomem;
 #define p4d_newpage(x)  (p4d_val(x) & _PAGE_NEWPAGE)
 #define p4d_mkuptodate(x) (p4d_val(x) &= ~_PAGE_NEWPAGE)
 
+#define pmd_pfn(pmd) (pmd_val(pmd) >> PAGE_SHIFT)
 #define pmd_page(pmd) phys_to_page(pmd_val(pmd) & PAGE_MASK)
 
 #define pte_page(x) pfn_to_page(pte_pfn(x))
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index bd5aeb795567..8da562f5da73 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -241,6 +241,7 @@ static inline void paging_init(void) { }
  * The pmd contains the kernel virtual address of the pte page.
  */
 #define pmd_page_vaddr(pmd) ((unsigned long)(pmd_val(pmd) & PAGE_MASK))
+#define pmd_pfn(pmd) (__pa(pmd_val(pmd)) >> PAGE_SHIFT)
 #define pmd_page(pmd) virt_to_page(pmd_val(pmd))
 
 /*
-- 
2.25.1


-- 
Sincerely yours,
Mike.
