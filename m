Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6452F536B95
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiE1IP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiE1IPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:15:23 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB526298
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:15:21 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 156433FBF5
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 08:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653725719;
        bh=B1WwhOW3S7fKWoMTSmYVqusu6PdQETAUiRaP1h07PZ8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cy7aPj8ib8ZjFGeNli8cDzTAgCWWRmKJeqJnZV0NZcX7L9Z0xfQVlzm2Kg/cBPZRZ
         lxQvw+rB3ycCwGsRDJ2e8W7KPR0iasMZ3Q9SqZq1OxPAC65tNSDujS68gFw1kZKPN0
         VoPzW7gXYgdM3dDM0d+m4Tbbx6z6KRFe9p0zdH7+U2VGcJhNrQR+j4cjTDCIA/qMUt
         3p4LSIMAnjjoQiSTmbAvloZUodbzNJKP+AR/A99MZ3xUpJryF27VJT8zcu9nKI2wyO
         +kqNwV8WKLdd5U9MER2Jy6ewPtMtHR4v/omqqiHlbA3/bXMrMXWjNnerBPfiw2DnZu
         i49B4+wKpz6Kg==
Received: by mail-ed1-f70.google.com with SMTP id x23-20020aa7dad7000000b0042be38e5095so3452004eds.14
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B1WwhOW3S7fKWoMTSmYVqusu6PdQETAUiRaP1h07PZ8=;
        b=PWeaFzbrUz0xjKjx9tvJ1UXzkd7IKzNOs+07UWHeEKFp1S9HBiuHz2URS8Jxf/1zY7
         Vs27soGfVS/YNlJDaI2d1q2zwYLYpwZuuiMdZrMPFPTytwAdhMnC+Ps1Yf8g7zm+S933
         JxI50YZXeoH0axvCShp2DW7fKAvvIb6mq3K1JwkOFQ4i1nw4rgz5vpbZ5NRbyzgSVcn6
         hZlkFGdvGEdgAg19MFmA1ynP8lXZm5mHtc8sIbeCwpG4WTgvQlvgd1fOBJX8nbD10aGr
         cNV1Ngrp+RZptqZcn4DFCCNqzLwjbHv2TCKDy5GjFGsN8hJ+8Um1AR51gbMcz6QcdcDO
         iMbg==
X-Gm-Message-State: AOAM531iEoDXiarWL6RVgtGhLACxMkHDrl1Fdm5YDBJdIy9Y69A3K9Lr
        qA+4G+vXrmUKGpJMAXrjMKxJ9H3+SSTeRxt3HfI0QTbR61cpOAXb7UXvc+naxUyTSXTulKHY/F5
        hK4NpCxMlkhApRusKnp+wTSa8j6O4d++8OTAMZW9oWtkJfDulSIlcuZiAug==
X-Received: by 2002:aa7:c88b:0:b0:42b:aa05:8752 with SMTP id p11-20020aa7c88b000000b0042baa058752mr20210514eds.408.1653725717854;
        Sat, 28 May 2022 01:15:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCNcSTLYDz2WtkILSdKYPNZyGiLZDouOfIQJCWeKHxb19Zq4X4eCBerJWZb6shxb2qj4I4rTpagrjtg019h6U=
X-Received: by 2002:aa7:c88b:0:b0:42b:aa05:8752 with SMTP id
 p11-20020aa7c88b000000b0042baa058752mr20210492eds.408.1653725717602; Sat, 28
 May 2022 01:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-9-heiko@sntech.de>
 <CA+zEjCuckDpweE9YEep26ZcX3xqh8QszXNq8BY-hPpQkQnRdjQ@mail.gmail.com> <2545779.7s5MMGUR32@diego>
In-Reply-To: <2545779.7s5MMGUR32@diego>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Sat, 28 May 2022 10:15:06 +0200
Message-ID: <CA+zEjCuEeCRXeagYas8z6x=u+gfjMMAqKNM5+4EuM_7aaof+wQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] riscv: Fix accessing pfn bits in PTEs for non-32bit variants
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 5:22 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Alexandre,
>
> Am Montag, 23. Mai 2022, 16:03:10 CEST schrieb Alexandre Ghiti:
> > Hi Heiko,
> >
> > On Wed, May 11, 2022 at 9:31 PM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > On rv32 the PFN part of PTEs is defined to use bits [xlen-1:10]
> > > while on rv64 it is defined to use bits [53:10], leaving [63:54]
> > > as reserved.
> > >
> > > With upcoming optional extensions like svpbmt these previously
> > > reserved bits will get used so simply right-shifting the PTE
> > > to get the PFN won't be enough.
> > >
> > > So introduce a _PAGE_PFN_MASK constant to mask the correct bits
> > > for both rv32 and rv64 before shifting.
> > >
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > > ---
> > >  arch/riscv/include/asm/pgtable-32.h   |  8 ++++++++
> > >  arch/riscv/include/asm/pgtable-64.h   | 14 +++++++++++---
> > >  arch/riscv/include/asm/pgtable-bits.h |  6 ------
> > >  arch/riscv/include/asm/pgtable.h      |  8 +++++---
> > >  4 files changed, 24 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include=
/asm/pgtable-32.h
> > > index 5b2e79e5bfa5..e266a4fe7f43 100644
> > > --- a/arch/riscv/include/asm/pgtable-32.h
> > > +++ b/arch/riscv/include/asm/pgtable-32.h
> > > @@ -7,6 +7,7 @@
> > >  #define _ASM_RISCV_PGTABLE_32_H
> > >
> > >  #include <asm-generic/pgtable-nopmd.h>
> > > +#include <linux/bits.h>
> > >  #include <linux/const.h>
> > >
> > >  /* Size of region mapped by a page global directory */
> > > @@ -16,4 +17,11 @@
> > >
> > >  #define MAX_POSSIBLE_PHYSMEM_BITS 34
> > >
> > > +/*
> > > + * rv32 PTE format:
> > > + * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> > > + *       PFN      reserved for SW   D   A   G   U   X   W   R   V
> > > + */
> > > +#define _PAGE_PFN_MASK  GENMASK(31, 10)
> > > +
> > >  #endif /* _ASM_RISCV_PGTABLE_32_H */
> > > diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include=
/asm/pgtable-64.h
> > > index 7e246e9f8d70..15f3ad5aee4f 100644
> > > --- a/arch/riscv/include/asm/pgtable-64.h
> > > +++ b/arch/riscv/include/asm/pgtable-64.h
> > > @@ -6,6 +6,7 @@
> > >  #ifndef _ASM_RISCV_PGTABLE_64_H
> > >  #define _ASM_RISCV_PGTABLE_64_H
> > >
> > > +#include <linux/bits.h>
> > >  #include <linux/const.h>
> > >
> > >  extern bool pgtable_l4_enabled;
> > > @@ -65,6 +66,13 @@ typedef struct {
> > >
> > >  #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
> > >
> > > +/*
> > > + * rv64 PTE format:
> > > + * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 |=
 3 | 2 | 1 | 0
> > > + *   N      MT     RSV    PFN      reserved for SW   D   A   G   U  =
 X   W   R   V
> > > + */
> > > +#define _PAGE_PFN_MASK  GENMASK(53, 10)
> > > +
> > >  static inline int pud_present(pud_t pud)
> > >  {
> > >         return (pud_val(pud) & _PAGE_PRESENT);
> > > @@ -108,12 +116,12 @@ static inline unsigned long _pud_pfn(pud_t pud)
> > >
> > >  static inline pmd_t *pud_pgtable(pud_t pud)
> > >  {
> > > -       return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> > > +       return (pmd_t *)pfn_to_virt(__page_val_to_pfn(pud_val(pud)));
> > >  }
> > >
> > >  static inline struct page *pud_page(pud_t pud)
> > >  {
> > > -       return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
> > > +       return pfn_to_page(__page_val_to_pfn(pud_val(pud)));
> > >  }
> > >
> > >  #define mm_p4d_folded  mm_p4d_folded
> > > @@ -143,7 +151,7 @@ static inline pmd_t pfn_pmd(unsigned long pfn, pg=
prot_t prot)
> > >
> > >  static inline unsigned long _pmd_pfn(pmd_t pmd)
> > >  {
> > > -       return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> > > +       return __page_val_to_pfn(pmd_val(pmd));
> > >  }
> > >
> > >  #define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
> > > diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/inclu=
de/asm/pgtable-bits.h
> > > index a6b0c89824c2..e571fa954afc 100644
> > > --- a/arch/riscv/include/asm/pgtable-bits.h
> > > +++ b/arch/riscv/include/asm/pgtable-bits.h
> > > @@ -6,12 +6,6 @@
> > >  #ifndef _ASM_RISCV_PGTABLE_BITS_H
> > >  #define _ASM_RISCV_PGTABLE_BITS_H
> > >
> > > -/*
> > > - * PTE format:
> > > - * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> > > - *       PFN      reserved for SW   D   A   G   U   X   W   R   V
> > > - */
> > > -
> > >  #define _PAGE_ACCESSED_OFFSET 6
> > >
> > >  #define _PAGE_PRESENT   (1 << 0)
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/as=
m/pgtable.h
> > > index 046b44225623..faba543e2b08 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -108,6 +108,8 @@
> > >  #include <asm/tlbflush.h>
> > >  #include <linux/mm_types.h>
> > >
> > > +#define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE=
_PFN_SHIFT)
> > > +
> > >  #ifdef CONFIG_64BIT
> > >  #include <asm/pgtable-64.h>
> > >  #else
> > > @@ -261,12 +263,12 @@ static inline unsigned long _pgd_pfn(pgd_t pgd)
> > >
> > >  static inline struct page *pmd_page(pmd_t pmd)
> > >  {
> > > -       return pfn_to_page(pmd_val(pmd) >> _PAGE_PFN_SHIFT);
> > > +       return pfn_to_page(__page_val_to_pfn(pmd_val(pmd)));
> > >  }
> > >
> > >  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
> > >  {
> > > -       return (unsigned long)pfn_to_virt(pmd_val(pmd) >> _PAGE_PFN_S=
HIFT);
> > > +       return (unsigned long)pfn_to_virt(__page_val_to_pfn(pmd_val(p=
md)));
> > >  }
> > >
> > >  static inline pte_t pmd_pte(pmd_t pmd)
> > > @@ -282,7 +284,7 @@ static inline pte_t pud_pte(pud_t pud)
> > >  /* Yields the page frame number (PFN) of a page table entry */
> > >  static inline unsigned long pte_pfn(pte_t pte)
> > >  {
> > > -       return (pte_val(pte) >> _PAGE_PFN_SHIFT);
> > > +       return __page_val_to_pfn(pte_val(pte));
> > >  }
> > >
> > >  #define pte_page(x)     pfn_to_page(pte_pfn(x))
> > > --
> > > 2.35.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > I had this weird bug and it took some time to figure out that _pgd_pfn
> > is missing the "& _PAGE_PFN_MASK" here.
> >
> > And then I grepped _PAGE_PFN_SHIFT and saw that _pud_pfn, p4d_pgtable,
> > __pmd_to_phys and stage2_pte_page_vaddr are also missing this mask. I
> > agree that we need something similar to your helper __page_val_to_pfn
> > (even if __page prefix is a bit weird to me) but I think we should go
> > further: forbid the use of _PAGE_PFN_SHIFT and contain this in a
> > single function that should be used to access the pfn minus the upper
> > bits, that would avoid future oversights.
> >
> > I can come up with something if needs be, up to you!
>
> as you seem to be stuck in the topic already, you might be faster
> than me with that I guess?

I'll propose the quick fix next week and will think about the proper
solution later.

Thanks

>
>
