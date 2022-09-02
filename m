Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200B85AB7B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiIBRpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbiIBRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:45:37 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345A24D83C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 10:45:34 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x80so2600702pgx.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NZVEf3CYxjabNWlNQEHIgO6mJdkFragZ0pRgJxMNdF4=;
        b=brrrkyWwYT4Cff3dMkZ8WKYey7Gx6fhNxsb8JRUSyGGbRANjWx7UT/G8WxJFn9QZvL
         qyFpE9rOTJohJMNmpfrPfjpgIghcenQNvEXO8SrqMBhNA4GIPtKTSr/wqr5333Fk9+03
         R+Q1zwL0ipvHVRnY/u2QHLAvKs9twy2qZzKZmjkv2UCKLr0A6MXVTjRj9W7u4bhqcW16
         thr0LCo6+uPb47hmleMMCekdsX+WxrR9OvnBiYoKy/Ams49YV6B4tocen3xXdHKjWzF+
         KIGzVoeleqkEEvYBG0FJhx84PHYMO84XY0c1KRCytMM0uX6BRQkCS83IR5cuhQzEw3vP
         rRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NZVEf3CYxjabNWlNQEHIgO6mJdkFragZ0pRgJxMNdF4=;
        b=ERxrqihL07uyuYrD/MWW0ZwGJmYUfH+VkeKvvppkOX57JFg4w1Kud/Ibavd9Reek4y
         T4/zFVZ/AalBSj40/IiDaYOPOlTmkkQrMJogvynrHJ6R5tAhgNPjfPqGJ1RDRQHTUPfu
         +i+cMCSQcvPqE05OeBMZsQNFvDN0xiDELoEDjjVzY77HUMlotOxFFHPaNJ8V2jtABzrg
         C+aFw/7kY8Vyduaq/r5CjKaHE3uB/M/1NyeIrbueXfz/plnkI/H9C6QlE4ePdoYLgNPs
         4u1TvqC6vuaP+CgP4+MprqQuk9nQag2U7E2CSNp6nXwW/PmVANgYWov7blJh0UzQDElm
         zJ0A==
X-Gm-Message-State: ACgBeo05gOcvHw+UGd4j4b7A7Wk/eD4nip5dCd8PuBOlMq/kyXzNnPLA
        dtswIC1z2ViRnONxdcTU9yV79oJNG9iXKVKwFQY=
X-Google-Smtp-Source: AA6agR4kAbuXG0gLhc7tPVImzPOY+LsHuGdwCt/1ub9RWm63bpuHlBzXaQ6T8AgrD9/KaEr1gro9LP+Mbg27y68worM=
X-Received: by 2002:a05:6a00:1a14:b0:52d:3e35:5b38 with SMTP id
 g20-20020a056a001a1400b0052d3e355b38mr37597987pfv.11.1662140733655; Fri, 02
 Sep 2022 10:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222707.477402-1-shy828301@gmail.com> <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com> <YxIofPiI8jvGzcjC@xz-m1.local>
In-Reply-To: <YxIofPiI8jvGzcjC@xz-m1.local>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 2 Sep 2022 10:45:20 -0700
Message-ID: <CAHbLzkqGdnwY4P8jKQR0ojm6QV6b3dBi5pwrC1UJ4dqi3EqS4w@mail.gmail.com>
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

On Fri, Sep 2, 2022 at 9:00 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 01, 2022 at 04:50:45PM -0700, Yang Shi wrote:
> > On Thu, Sep 1, 2022 at 4:26 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Hi, Yang,
> > >
> > > On Thu, Sep 01, 2022 at 03:27:07PM -0700, Yang Shi wrote:
> > > > Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> > > > introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> > > > sufficient to handle concurrent GUP-fast in all cases, it only handles
> > > > traditional IPI-based GUP-fast correctly.
> > >
> > > If TLB flush (or, IPI broadcasts) used to work to protect against gup-fast,
> > > I'm kind of confused why it's not sufficient even if with RCU gup?  Isn't
> > > that'll keep working as long as interrupt disabled (which current fast-gup
> > > will still do)?
> >
> > Actually the wording was copied from David's commit log for his
> > PageAnonExclusive fix. My understanding is the IPI broadcast still
> > works, but it may not be supported by all architectures and not
> > preferred anymore. So we should avoid depending on IPI broadcast IIUC.
> >
> > >
> > > IIUC the issue is you suspect not all archs correctly implemented
> > > pmdp_collapse_flush(), or am I wrong?
> >
> > This is a possible fix, please see below for details.
> >
> > >
> > > > On architectures that send
> > > > an IPI broadcast on TLB flush, it works as expected.  But on the
> > > > architectures that do not use IPI to broadcast TLB flush, it may have
> > > > the below race:
> > > >
> > > >    CPU A                                          CPU B
> > > > THP collapse                                     fast GUP
> > > >                                               gup_pmd_range() <-- see valid pmd
> > > >                                                   gup_pte_range() <-- work on pte
> > > > pmdp_collapse_flush() <-- clear pmd and flush
> > > > __collapse_huge_page_isolate()
> > > >     check page pinned <-- before GUP bump refcount
> > > >                                                       pin the page
> > > >                                                       check PTE <-- no change
> > > > __collapse_huge_page_copy()
> > > >     copy data to huge page
> > > >     ptep_clear()
> > > > install huge pmd for the huge page
> > > >                                                       return the stale page
> > > > discard the stale page
> > > >
> > > > The race could be fixed by checking whether PMD is changed or not after
> > > > taking the page pin in fast GUP, just like what it does for PTE.  If the
> > > > PMD is changed it means there may be parallel THP collapse, so GUP
> > > > should back off.
> > >
> > > Could the race also be fixed by impl pmdp_collapse_flush() correctly for
> > > the archs that are missing? Do you know which arch(s) is broken with it?
> >
> > Yes, and this was suggested by me in the first place, but per the
> > suggestion from John and David, this is not the preferred way. I think
> > it is because:
> >
> > Firstly, using IPI to serialize against fast GUP is not recommended
> > anymore since fast GUP does check PTE then back off so we should avoid
> > it.
> > Secondly, if checking PMD then backing off could solve the problem,
> > why do we still need broadcast IPI? It doesn't sound performant.
> >
> > >
> > > It's just not clear to me whether this patch is an optimization or a fix,
> > > if it's a fix whether the IPI broadcast in ppc pmdp_collapse_flush() would
> > > still be needed.
> >
> > It is a fix and the fix will make IPI broadcast not useful anymore.
>
> How about another patch to remove the ppc impl too?  Then it can be a two
> patches series.

BTW, I don't think we could remove the ppc implementation since it is
different from the generic pmdp_collapse_flush(), particularly for the
hash part IIUC.

The generic version calls flush_tlb_range() -> hash__flush_tlb_range()
for hash, but the hash call is actually no-op. The ppc version calls
hash__pmdp_collapse_flush() -> flush_tlb_pmd_range(), which does
something useful.

But, as I mentioned in another thread, we should be able to remove the
IPI call, which just calls a dummy function.

>
> So that ppc developers can be copied and maybe it helps to have the ppc
> people looking at current approach too.
>
> Then the last piece of it is the s390 pmdp_collapse_flush().  I'm wondering
> whether generic pmdp_collapse_flush() would be good enough, since the only
> addition comparing to the s390 one will be flush_tlb_range() (which is a
> further __tlb_flush_mm_lazy).  David may have some thoughts.
>
> The patch itself looks good to me, one trivial nit below.
>
> >
> > >
> > > Thanks,
> > >
> > > >
> > > > Also update the stale comment about serializing against fast GUP in
> > > > khugepaged.
> > > >
> > > > Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  mm/gup.c        | 30 ++++++++++++++++++++++++------
> > > >  mm/khugepaged.c | 10 ++++++----
> > > >  2 files changed, 30 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index f3fc1f08d90c..4365b2811269 100644
> > > > --- a/mm/gup.c
> > > > +++ b/mm/gup.c
> > > > @@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
> > > >  }
> > > >
> > > >  #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> > > > -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> > > > -                      unsigned int flags, struct page **pages, int *nr)
> > > > +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> > > > +                      unsigned long end, unsigned int flags,
> > > > +                      struct page **pages, int *nr)
> > > >  {
> > > >       struct dev_pagemap *pgmap = NULL;
> > > >       int nr_start = *nr, ret = 0;
> > > > @@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> > > >                       goto pte_unmap;
> > > >               }
> > > >
> > > > -             if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> > > > +             /*
> > > > +              * THP collapse conceptually does:
> > > > +              *   1. Clear and flush PMD
> > > > +              *   2. Check the base page refcount
> > > > +              *   3. Copy data to huge page
> > > > +              *   4. Clear PTE
> > > > +              *   5. Discard the base page
> > > > +              *
> > > > +              * So fast GUP may race with THP collapse then pin and
> > > > +              * return an old page since TLB flush is no longer sufficient
> > > > +              * to serialize against fast GUP.
> > > > +              *
> > > > +              * Check PMD, if it is changed just back off since it
> > > > +              * means there may be parallel THP collapse.
>
> Would you mind rewording this comment a bit?  I feel it a bit weird to
> suddenly mention about thp collapse especially its details.
>
> Maybe some statement on the whole history of why check pte, and in what
> case pmd check is needed (where the thp collapse example can be moved to,
> imho)?
>
> One of my attempt for reference..
>
>                 /*
>                  * Fast-gup relies on pte change detection to avoid
>                  * concurrent pgtable operations.
>                  *
>                  * To pin the page, fast-gup needs to do below in order:
>                  * (1) pin the page (by prefetching pte), then (2) check
>                  * pte not changed.
>                  *
>                  * For the rest of pgtable operations where pgtable updates
>                  * can be racy with fast-gup, we need to do (1) clear pte,
>                  * then (2) check whether page is pinned.
>                  *
>                  * Above will work for all pte-level operations, including
>                  * thp split.
>                  *
>                  * For thp collapse, it's a bit more complicated because
>                  * with RCU pgtable free fast-gup can be walking a pgtable
>                  * page that is being freed (so pte is still valid but pmd
>                  * can be cleared already).  To avoid race in such
>                  * condition, we need to also check pmd here to make sure
>                  * pmd doesn't change (corresponds to pmdp_collapse_flush()
>                  * in the thp collide code path).
>                  */
>
> If you agree with the comment change, feel free to add:
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> Thanks,
>
> --
> Peter Xu
>
