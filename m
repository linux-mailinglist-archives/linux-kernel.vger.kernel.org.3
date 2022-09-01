Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6AC5AA3EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiIAXvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiIAXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:50:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9D94DB39
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:50:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 199so340173pfz.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rgfh2ddi8n0E0NRuyd4hmH9/qJacY3Iem5NMVyw+DzY=;
        b=F6m5E4BZTfNRuTo02s1snzGsFaJw2Au+1CHu6ImumiapshQiYnkVbAuEooOafgPMkF
         miIZPjYe1LUhkfPf6IuTdUDpRGmuGwBevKrexovn439U5OzXIL60qj+V40VHt9BhKer9
         B1ui3yqdeEelOVltF11FjrnnzGCzl6ZxDGmCHXCF9WGY5ihIm4CpGfT3IDOvs3OqIpF8
         2hHDqrwheGlq2FDDv6LOOGL32T3DWNb/gdaZnrKx7AFnHtBWvaJy8NN2WOq1Akcv+NAj
         +lJ6ukbtqgf+XeB1L1H2JubBJ/eAU/UxALqdtHHwBKqAJRVq0dSgfKDcG+tFNebulqVi
         7skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rgfh2ddi8n0E0NRuyd4hmH9/qJacY3Iem5NMVyw+DzY=;
        b=vMpDxmMbr/0jlG0Wjw50VveRFHhcozeC9PNmrTjIQew7nyG9KqaQb+ITAkGH1nZxTZ
         pA+KMaLAwxSLLUl6usCq25OKnNuka4is9/rvyL909eOEtCf5HVOJk2zAoz3no8FjSzW6
         sm0U9AofuT+0gfndTw3NKQMT5PK4vcUIZOyQbZ/KzSHcYtCmYTMocjWvChKsuQtDPmJg
         64bqwab6PCJWIJAIeZ6omXz4dlzBK7h6Cb7z0slLkUGdLiEecJnU+yMp5jNrn7lpwtM2
         ZUoBZhFThj1TBqHU+Xor1G4DHJVPOPWhZghEC8hayso/zHV1PP8lJkBBGheeH0PPI/88
         Fs2A==
X-Gm-Message-State: ACgBeo0AfERHALQiZZ94hjvy23yI0l1jnzDU57D7rV9dqT4RgdIHPvGe
        Qv+l2L3VbjReAWxn2DxY6PtVALYiJtYhoz2GvTmdeoIJ
X-Google-Smtp-Source: AA6agR5eLHrYTjwWmVpkp/WauU991H/b0j9j6TTL8fxRaKMNhd3ZO/oRArhpKmBdAGABuHvBKeO/bbFBz9D/FdS07cw=
X-Received: by 2002:a63:de01:0:b0:42b:31f7:b6ea with SMTP id
 f1-20020a63de01000000b0042b31f7b6eamr27634226pgg.587.1662076257912; Thu, 01
 Sep 2022 16:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222707.477402-1-shy828301@gmail.com> <YxE/vuQlWJCJMuG2@xz-m1.local>
In-Reply-To: <YxE/vuQlWJCJMuG2@xz-m1.local>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Sep 2022 16:50:45 -0700
Message-ID: <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
To:     Peter Xu <peterx@redhat.com>
Cc:     david@redhat.com, kirill.shutemov@linux.intel.com,
        jhubbard@nvidia.com, jgg@nvidia.com, hughd@google.com,
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

On Thu, Sep 1, 2022 at 4:26 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Yang,
>
> On Thu, Sep 01, 2022 at 03:27:07PM -0700, Yang Shi wrote:
> > Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> > introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> > sufficient to handle concurrent GUP-fast in all cases, it only handles
> > traditional IPI-based GUP-fast correctly.
>
> If TLB flush (or, IPI broadcasts) used to work to protect against gup-fast,
> I'm kind of confused why it's not sufficient even if with RCU gup?  Isn't
> that'll keep working as long as interrupt disabled (which current fast-gup
> will still do)?

Actually the wording was copied from David's commit log for his
PageAnonExclusive fix. My understanding is the IPI broadcast still
works, but it may not be supported by all architectures and not
preferred anymore. So we should avoid depending on IPI broadcast IIUC.

>
> IIUC the issue is you suspect not all archs correctly implemented
> pmdp_collapse_flush(), or am I wrong?

This is a possible fix, please see below for details.

>
> > On architectures that send
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
> >
> > The race could be fixed by checking whether PMD is changed or not after
> > taking the page pin in fast GUP, just like what it does for PTE.  If the
> > PMD is changed it means there may be parallel THP collapse, so GUP
> > should back off.
>
> Could the race also be fixed by impl pmdp_collapse_flush() correctly for
> the archs that are missing? Do you know which arch(s) is broken with it?

Yes, and this was suggested by me in the first place, but per the
suggestion from John and David, this is not the preferred way. I think
it is because:

Firstly, using IPI to serialize against fast GUP is not recommended
anymore since fast GUP does check PTE then back off so we should avoid
it.
Secondly, if checking PMD then backing off could solve the problem,
why do we still need broadcast IPI? It doesn't sound performant.

>
> It's just not clear to me whether this patch is an optimization or a fix,
> if it's a fix whether the IPI broadcast in ppc pmdp_collapse_flush() would
> still be needed.

It is a fix and the fix will make IPI broadcast not useful anymore.

>
> Thanks,
>
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
> > +             if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> > +                 unlikely(pte_val(pte) != pte_val(*ptep))) {
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
> >       spin_unlock(pmd_ptl);
> > --
> > 2.26.3
> >
>
> --
> Peter Xu
>
