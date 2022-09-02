Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263BA5AB642
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiIBQLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiIBQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:10:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4199BC2D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662134689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7lqNySzCCFKs1rBOZn2sTmct94D5vPhBMUJV2w257s=;
        b=LVZi6FHNZ7AGszCJwtdfXmXzQwTcEHfs4J7bBYpiDUOhc4M7S9Zalef2Irr2+LB2BL8Ak/
        yUjnvVA+6oKqUemMGg4akggb9HcmZDOwZn0x8lQj67IufwiIfM3qBWfRmJHOo6CemZ5E7d
        OyJ1cYiQuDyXeSLhz5Ue675HKVrQ3do=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-106-eW19C_XfMMm5BuQv0m-_yA-1; Fri, 02 Sep 2022 12:04:47 -0400
X-MC-Unique: eW19C_XfMMm5BuQv0m-_yA-1
Received: by mail-qt1-f200.google.com with SMTP id fv24-20020a05622a4a1800b003445e593889so1860698qtb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=b7lqNySzCCFKs1rBOZn2sTmct94D5vPhBMUJV2w257s=;
        b=Vm2zYaFPuYRP11dALeYPfKDjPvMqoKg0T0aUgjdu8cnie9AlzoE1Y6mZ84exW4KuHe
         87R/HeH3nYc4uHxwMOpLcH3GuWTzh96atq8cLxubjU9SlXAzi24V0WYbR5G6IYyYgp7e
         McPnz9vhi9Wyz1fwGBTUDLzkP5L2ErKUF/qoY8W844+c5GSyTttvT5rw80Mipkxw8ypu
         3HQs8ciF2po20ZKEs5UVo86LfP2KQ3EoEpdf5wmRscaoF5NIbnm3OGVrD9dtOc3yjy95
         kuj5/eoQTt/L9zSFPhmXEUPkfWTDQDd6amZxA9bIk8LuJVKOwpLukAoow4kspuCNkxqG
         G58A==
X-Gm-Message-State: ACgBeo3XFedY4dvxfJY+JeI/fMrTIamyAoOHUsnwiiYmLF7hH+UQfRO5
        WJErnSXnvuLjrtyqWTVwOuOYslxQtjU0ly4keDdSg8ZUzhoxOK6J8i7KsSEWb4LklB5tkZRx27V
        w1nSTQ45uzhYk7t0buggEhIk9
X-Received: by 2002:a05:6214:2581:b0:499:91e:2fb with SMTP id fq1-20020a056214258100b00499091e02fbmr20463484qvb.59.1662134685883;
        Fri, 02 Sep 2022 09:04:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5v7W3/V5OdsrUeqBFUBmVMFuKZdNcjdVA6NXpXEIIjPTpBr116Ubu7Y5k+BkFqD5ZivafUrQ==
X-Received: by 2002:a05:6214:2581:b0:499:91e:2fb with SMTP id fq1-20020a056214258100b00499091e02fbmr20463432qvb.59.1662134685452;
        Fri, 02 Sep 2022 09:04:45 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id q190-20020ae9dcc7000000b006a5d2eb58b2sm1612070qkf.33.2022.09.02.09.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:04:44 -0700 (PDT)
Date:   Fri, 2 Sep 2022 12:04:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     david@redhat.com, kirill.shutemov@linux.intel.com,
        jhubbard@nvidia.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Message-ID: <YxIpm6YH/q20zozZ@xz-m1.local>
References: <20220901222707.477402-1-shy828301@gmail.com>
 <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
 <YxIofPiI8jvGzcjC@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxIofPiI8jvGzcjC@xz-m1.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 11:59:56AM -0400, Peter Xu wrote:
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
> 		/*
> 		 * Fast-gup relies on pte change detection to avoid
> 		 * concurrent pgtable operations.
> 		 *
> 		 * To pin the page, fast-gup needs to do below in order:
> 		 * (1) pin the page (by prefetching pte), then (2) check
> 		 * pte not changed.
> 		 *
> 		 * For the rest of pgtable operations where pgtable updates
> 		 * can be racy with fast-gup, we need to do (1) clear pte,
> 		 * then (2) check whether page is pinned.
> 		 *
> 		 * Above will work for all pte-level operations, including
> 		 * thp split.

Here a slight amendment could be:

		 * Above will work for all pte-level operations, including
		 * thp split, which applies the same logic but only done
		 * all above in the pmd level rather than pte level.

To be clearer.

> 		 *
> 		 * For thp collapse, it's a bit more complicated because
> 		 * with RCU pgtable free fast-gup can be walking a pgtable
> 		 * page that is being freed (so pte is still valid but pmd
> 		 * can be cleared already).  To avoid race in such
> 		 * condition, we need to also check pmd here to make sure
> 		 * pmd doesn't change (corresponds to pmdp_collapse_flush()
> 		 * in the thp collide code path).
> 		 */
> 
> If you agree with the comment change, feel free to add:
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu

