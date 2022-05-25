Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40153404B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbiEYPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiEYPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:22:17 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CBAAFAF0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:22:14 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ntspm-0006gP-1A; Wed, 25 May 2022 17:22:02 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH 08/12] riscv: Fix accessing pfn bits in PTEs for non-32bit variants
Date:   Wed, 25 May 2022 17:22:00 +0200
Message-ID: <2545779.7s5MMGUR32@diego>
In-Reply-To: <CA+zEjCuckDpweE9YEep26ZcX3xqh8QszXNq8BY-hPpQkQnRdjQ@mail.gmail.com>
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-9-heiko@sntech.de> <CA+zEjCuckDpweE9YEep26ZcX3xqh8QszXNq8BY-hPpQkQnRdjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Am Montag, 23. Mai 2022, 16:03:10 CEST schrieb Alexandre Ghiti:
> Hi Heiko,
> 
> On Wed, May 11, 2022 at 9:31 PM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > On rv32 the PFN part of PTEs is defined to use bits [xlen-1:10]
> > while on rv64 it is defined to use bits [53:10], leaving [63:54]
> > as reserved.
> >
> > With upcoming optional extensions like svpbmt these previously
> > reserved bits will get used so simply right-shifting the PTE
> > to get the PFN won't be enough.
> >
> > So introduce a _PAGE_PFN_MASK constant to mask the correct bits
> > for both rv32 and rv64 before shifting.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > ---
> >  arch/riscv/include/asm/pgtable-32.h   |  8 ++++++++
> >  arch/riscv/include/asm/pgtable-64.h   | 14 +++++++++++---
> >  arch/riscv/include/asm/pgtable-bits.h |  6 ------
> >  arch/riscv/include/asm/pgtable.h      |  8 +++++---
> >  4 files changed, 24 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> > index 5b2e79e5bfa5..e266a4fe7f43 100644
> > --- a/arch/riscv/include/asm/pgtable-32.h
> > +++ b/arch/riscv/include/asm/pgtable-32.h
> > @@ -7,6 +7,7 @@
> >  #define _ASM_RISCV_PGTABLE_32_H
> >
> >  #include <asm-generic/pgtable-nopmd.h>
> > +#include <linux/bits.h>
> >  #include <linux/const.h>
> >
> >  /* Size of region mapped by a page global directory */
> > @@ -16,4 +17,11 @@
> >
> >  #define MAX_POSSIBLE_PHYSMEM_BITS 34
> >
> > +/*
> > + * rv32 PTE format:
> > + * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> > + *       PFN      reserved for SW   D   A   G   U   X   W   R   V
> > + */
> > +#define _PAGE_PFN_MASK  GENMASK(31, 10)
> > +
> >  #endif /* _ASM_RISCV_PGTABLE_32_H */
> > diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> > index 7e246e9f8d70..15f3ad5aee4f 100644
> > --- a/arch/riscv/include/asm/pgtable-64.h
> > +++ b/arch/riscv/include/asm/pgtable-64.h
> > @@ -6,6 +6,7 @@
> >  #ifndef _ASM_RISCV_PGTABLE_64_H
> >  #define _ASM_RISCV_PGTABLE_64_H
> >
> > +#include <linux/bits.h>
> >  #include <linux/const.h>
> >
> >  extern bool pgtable_l4_enabled;
> > @@ -65,6 +66,13 @@ typedef struct {
> >
> >  #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
> >
> > +/*
> > + * rv64 PTE format:
> > + * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> > + *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
> > + */
> > +#define _PAGE_PFN_MASK  GENMASK(53, 10)
> > +
> >  static inline int pud_present(pud_t pud)
> >  {
> >         return (pud_val(pud) & _PAGE_PRESENT);
> > @@ -108,12 +116,12 @@ static inline unsigned long _pud_pfn(pud_t pud)
> >
> >  static inline pmd_t *pud_pgtable(pud_t pud)
> >  {
> > -       return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> > +       return (pmd_t *)pfn_to_virt(__page_val_to_pfn(pud_val(pud)));
> >  }
> >
> >  static inline struct page *pud_page(pud_t pud)
> >  {
> > -       return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> > +       return pfn_to_page(__page_val_to_pfn(pud_val(pud)));
> >  }
> >
> >  #define mm_p4d_folded  mm_p4d_folded
> > @@ -143,7 +151,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
> >
> >  static inline unsigned long _pmd_pfn(pmd_t pmd)
> >  {
> > -       return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> > +       return __page_val_to_pfn(pmd_val(pmd));
> >  }
> >
> >  #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
> > diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> > index a6b0c89824c2..e571fa954afc 100644
> > --- a/arch/riscv/include/asm/pgtable-bits.h
> > +++ b/arch/riscv/include/asm/pgtable-bits.h
> > @@ -6,12 +6,6 @@
> >  #ifndef _ASM_RISCV_PGTABLE_BITS_H
> >  #define _ASM_RISCV_PGTABLE_BITS_H
> >
> > -/*
> > - * PTE format:
> > - * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> > - *       PFN      reserved for SW   D   A   G   U   X   W   R   V
> > - */
> > -
> >  #define _PAGE_ACCESSED_OFFSET 6
> >
> >  #define _PAGE_PRESENT   (1 << 0)
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 046b44225623..faba543e2b08 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -108,6 +108,8 @@
> >  #include <asm/tlbflush.h>
> >  #include <linux/mm_types.h>
> >
> > +#define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
> > +
> >  #ifdef CONFIG_64BIT
> >  #include <asm/pgtable-64.h>
> >  #else
> > @@ -261,12 +263,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
> >
> >  static inline struct page *pmd_page(pmd_t pmd)
> >  {
> > -       return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> > +       return pfn_to_page(__page_val_to_pfn(pmd_val(pmd)));
> >  }
> >
> >  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> >  {
> > -       return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> > +       return (unsigned long)pfn_to_virt(__page_val_to_pfn(pmd_val(pmd)));
> >  }
> >
> >  static inline pte_t pmd_pte(pmd_t pmd)
> > @@ -282,7 +284,7 @@ static inline pte_t pud_pte(pud_t pud)
> >  /* Yields the page frame number (PFN) of a page table entry */
> >  static inline unsigned long pte_pfn(pte_t pte)
> >  {
> > -       return (pte_val(pte) >> _PAGE_PFN_SHIFT);
> > +       return __page_val_to_pfn(pte_val(pte));
> >  }
> >
> >  #define pte_page(x)     pfn_to_page(pte_pfn(x))
> > --
> > 2.35.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> I had this weird bug and it took some time to figure out that _pgd_pfn
> is missing the "& _PAGE_PFN_MASK" here.
> 
> And then I grepped _PAGE_PFN_SHIFT and saw that _pud_pfn, p4d_pgtable,
> __pmd_to_phys and stage2_pte_page_vaddr are also missing this mask. I
> agree that we need something similar to your helper __page_val_to_pfn
> (even if __page prefix is a bit weird to me) but I think we should go
> further: forbid the use of _PAGE_PFN_SHIFT and contain this in a
> single function that should be used to access the pfn minus the upper
> bits, that would avoid future oversights.
> 
> I can come up with something if needs be, up to you!

as you seem to be stuck in the topic already, you might be faster
than me with that I guess?


