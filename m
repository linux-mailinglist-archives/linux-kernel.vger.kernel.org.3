Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEDE5AF3F0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiIFSv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIFSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:51:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B0832E8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:51:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so5646137pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PozCUjqVEYrMkKg2TEpFnrcXEcbx8gC39jpWnO6vFt8=;
        b=K/iSeTf+kUVWLgrV7Js2WEN++g9B19yTvy+QYcvzImFxgXnddMQKETNPDfSPOsFVIw
         9n5/T/7nR1gfXGz9PCVmS1fV1dGQZBSbs3+soihzqxo3C5O/pqUJya4uOPVNqLezeSYt
         4nm9KbTW4Kx379Kg0JAEAfLXUSef9Pa+Jy/V5vNG4k9EvKcZTXgZUbsdRLXNjx+n9Hiq
         qE3oWPqFdOl7uiCWnYR3QRjAKVfcF4JgneGkyFRScHziva+zV0N3tdgU1tPbOA/6zonx
         2rsGfnl0BQUmnH+N+IpUZ2scI30zjOj5IJMLXqVl66b4k+jsdTFY8E6S49nL05i6tmiU
         xcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PozCUjqVEYrMkKg2TEpFnrcXEcbx8gC39jpWnO6vFt8=;
        b=fwndDxO8mI4woBr9huxTsr4Qa0FbGQc+lq/2ihF19Sg9Uwuwrjhb4bgPLNavP+xRUv
         S7UhWhGhDeStxLjCdgGDKOQRk+FgC3o5D/+Kf4QH/TZ/brjnVJiucIl9awsHzqH7VPG4
         h7ctFPNqM4f8MU79uHrYj5dQQJTT2wj2YDCLZxx7pf5wUXmRcUYxW1jLIjv5YLjXUzsI
         lGIN3peCFbjjK8bZLKWqbLGzBAnx32gzux5/mivHYQhTLMzcYrcSki5yFr+TmgNgycM9
         XsdSujj77CY5M8ULsltKiYtxd0gxjZg+QmTxtQuSmEUa4C0qWf8CYUspf4aJquxhIB4j
         zCDA==
X-Gm-Message-State: ACgBeo0oTH+U2/XENMak/q9bgY8Ep6IsvCSLsP4VAyt2ZHH/+QNCrzx4
        qLOQxD5s/+Onv95XrFNXm80GUFoEdwi7BARumug=
X-Google-Smtp-Source: AA6agR4N+rDi9hZIvOar9ELL3SCweXS1ADwDaaxKVc/DIY7HPa4ho2ZixLrLHWjpB8lPPtMKvOGSACCaESjRatQ7SUU=
X-Received: by 2002:a17:902:be03:b0:175:6397:9425 with SMTP id
 r3-20020a170902be0300b0017563979425mr25599259pls.26.1662490268580; Tue, 06
 Sep 2022 11:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222707.477402-1-shy828301@gmail.com> <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
In-Reply-To: <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 6 Sep 2022 11:50:56 -0700
Message-ID: <CAHbLzkp2CKG5CQA25=HHzKde-8OFTPU2kMWD8remXMNNyF+_tA@mail.gmail.com>
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     david@redhat.com, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022 at 3:29 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/1/22 15:27, Yang Shi wrote:
> > Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> > introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> > sufficient to handle concurrent GUP-fast in all cases, it only handles
> > traditional IPI-based GUP-fast correctly.  On architectures that send
> > an IPI broadcast on TLB flush, it works as expected.  But on the
> > architectures that do not use IPI to broadcast TLB flush, it may have
> > the below race:
> >
> >    CPU A                                          CPU B
> > THP collapse                                     fast GUP
> >                                               gup_pmd_range() <-- see valid pmd
> >                                                   gup_pte_range() <-- work on pte
> > pmdp_collapse_flush() <-- clear pmd and flush
> > __collapse_huge_page_isolate()
> >     check page pinned <-- before GUP bump refcount
> >                                                       pin the page
> >                                                       check PTE <-- no change
> > __collapse_huge_page_copy()
> >     copy data to huge page
> >     ptep_clear()
> > install huge pmd for the huge page
> >                                                       return the stale page
> > discard the stale page
>
> Hi Yang,
>
> Thanks for taking the trouble to write down these notes. I always
> forget which race we are dealing with, and this is a great help. :)

My pleasure, I'm glad it is helpful.

>
> More...
>
> >
> > The race could be fixed by checking whether PMD is changed or not after
> > taking the page pin in fast GUP, just like what it does for PTE.  If the
> > PMD is changed it means there may be parallel THP collapse, so GUP
> > should back off.
> >
> > Also update the stale comment about serializing against fast GUP in
> > khugepaged.
> >
> > Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  mm/gup.c        | 30 ++++++++++++++++++++++++------
> >  mm/khugepaged.c | 10 ++++++----
> >  2 files changed, 30 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index f3fc1f08d90c..4365b2811269 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
> >  }
> >
> >  #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> > -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> > -                      unsigned int flags, struct page **pages, int *nr)
> > +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> > +                      unsigned long end, unsigned int flags,
> > +                      struct page **pages, int *nr)
> >  {
> >       struct dev_pagemap *pgmap = NULL;
> >       int nr_start = *nr, ret = 0;
> > @@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >                       goto pte_unmap;
> >               }
> >
> > -             if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> > +             /*
> > +              * THP collapse conceptually does:
> > +              *   1. Clear and flush PMD
> > +              *   2. Check the base page refcount
> > +              *   3. Copy data to huge page
> > +              *   4. Clear PTE
> > +              *   5. Discard the base page
> > +              *
> > +              * So fast GUP may race with THP collapse then pin and
> > +              * return an old page since TLB flush is no longer sufficient
> > +              * to serialize against fast GUP.
> > +              *
> > +              * Check PMD, if it is changed just back off since it
> > +              * means there may be parallel THP collapse.
> > +              */
>
> As I mentioned in the other thread, it would be a nice touch to move
> such discussion into the comment header.

Sure, you mean the comment before gup_pte_range() so that the real
code stays succinct, right?

>
> > +             if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> > +                 unlikely(pte_val(pte) != pte_val(*ptep))) {
>
>
> That should be READ_ONCE() for the *pmdp and *ptep reads. Because this
> whole lockless house of cards may fall apart if we try reading the
> page table values without READ_ONCE().
>
> That's a rather vague statement, and in fact, the READ_ONCE() should
> be paired with a page table write somewhere else, to make that claim
> more precise.

Thanks for the suggestion. Per the discussion later (mainly from David
and Jason), I think we are going to have a separate patch to clean up
all the page table access for GUP.

>
>
> >                       gup_put_folio(folio, 1, flags);
> >                       goto pte_unmap;
> >               }
> > @@ -2470,8 +2487,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >   * get_user_pages_fast_only implementation that can pin pages. Thus it's still
> >   * useful to have gup_huge_pmd even if we can't operate on ptes.
> >   */
> > -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> > -                      unsigned int flags, struct page **pages, int *nr)
> > +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> > +                      unsigned long end, unsigned int flags,
> > +                      struct page **pages, int *nr)
> >  {
> >       return 0;
> >  }
> > @@ -2791,7 +2809,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
> >                       if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
> >                                        PMD_SHIFT, next, flags, pages, nr))
> >                               return 0;
> > -             } else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
> > +             } else if (!gup_pte_range(pmd, pmdp, addr, next, flags, pages, nr))
> >                       return 0;
> >       } while (pmdp++, addr = next, addr != end);
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2d74cf01f694..518b49095db3 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1049,10 +1049,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
> >
> >       pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
> >       /*
> > -      * After this gup_fast can't run anymore. This also removes
> > -      * any huge TLB entry from the CPU so we won't allow
> > -      * huge and small TLB entries for the same virtual address
> > -      * to avoid the risk of CPU bugs in that area.
> > +      * This removes any huge TLB entry from the CPU so we won't allow
> > +      * huge and small TLB entries for the same virtual address to
> > +      * avoid the risk of CPU bugs in that area.
> > +      *
> > +      * Parallel fast GUP is fine since fast GUP will back off when
> > +      * it detects PMD is changed.
> >        */
> >       _pmd = pmdp_collapse_flush(vma, address, pmd);
>
> To follow up on David Hildenbrand's note about this in the nearby thread...
> I'm also not sure if pmdp_collapse_flush() implies a memory barrier on
> all arches. It definitely does do an atomic op with a return value on x86,
> but that's just one arch.

Will reply in detail to David's thread.

>
>
> thanks,
>
> --
> John Hubbard
> NVIDIA
>
> >       spin_unlock(pmd_ptl);
>
