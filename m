Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD457BF61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiGTU6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGTU6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:58:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826785247E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:58:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bp17so32280024lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9K+b21nsVD0iIafTdhhey9+rdLrDC0j6+lROpOC8dU=;
        b=iF/zzHxsHZq4RK7nVcQ8w/7uTDq+Bc545ccz6AHB6ro67LPjDmKJC04ocWy27p4zC1
         Upeo0KVa3gU07eHedBoDLcyoItlaJMZDcGmOBq4buS1Eh1IiS/1X+ChBumtmACXIVlqH
         xZ/NPX00rKO2Xcz38TR+GpMeTStVJvjx9dfhH0lNuS6m3TKW2b8Le7lk4Io/g6IzFzAP
         qDr0e/W9HrUrVlPaWi4SKnwaHYV849rXK3p+km08JiFADsWBUL23m+6IM4Yuxkl74Pbd
         6T5lz8IOiUDE3vm+AGZYcSGpjMRmTSy2DapQ+C6qpCLFfhFvd0D6pvGizZo2Z67ziXy+
         4xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9K+b21nsVD0iIafTdhhey9+rdLrDC0j6+lROpOC8dU=;
        b=w9GWSVNX0+hhSF9/+48HQNPFngWcsgLiyp6xdZ4EWSfQ+p1t7pJijJO68qDXk8b6Nc
         sfxTnK0pQoFdGlQrN4mCXcShxXyQ54qFf1n0xgHpKhN93TMMTAfGxe9e7mPRyyChZgSe
         5VFWVkCEtX6F3bbbEhEE4VG8StIGApn7M/zhmuM8JkxtzxKxaYKXZMoItjF2OprUDSgo
         aV+i965a+17x6Z8Fyh2rapDMzftsQ0YBqPAU3BR2tch9nqcdm8c1dSFkNEfv+FWJhlfS
         wLfVbkBojdOsy93Jl2qFzWz2V1vUeP9LsFkB65DTLfR/V/fnICaZx4nXLoytvuFI8s7o
         /d0Q==
X-Gm-Message-State: AJIora9dMGIyHYf+ENtXbO+Idk+YvCyr1KBksURDhJgpOV31GGhC+EQj
        P+WpMPuf1qXatKoTUR3V0KTbvbBhGj4aE6ZVdLdH3g==
X-Google-Smtp-Source: AGRyM1sKt/3cQ2pBHQuQLFuzpoS1zPyNNo8gcVM36a9a2V4uS+dppxJoeaLyCuOmvmQSpoN+vxJYQuKGTGfEnagiq8Y=
X-Received: by 2002:a05:6512:2216:b0:489:48b6:f8cd with SMTP id
 h22-20020a056512221600b0048948b6f8cdmr19110063lfu.267.1658350697753; Wed, 20
 Jul 2022 13:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-21-jthoughton@google.com> <YtGUARcBHxLU0axU@xz-m1.local>
 <CADrL8HXYab_VJS=Y0h2OSiCrj2pYbDJME2P=Tsn9jcDRbcqR1g@mail.gmail.com> <YtGh46Jr0EGpqW7s@xz-m1.local>
In-Reply-To: <YtGh46Jr0EGpqW7s@xz-m1.local>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 20 Jul 2022 13:58:06 -0700
Message-ID: <CADrL8HX1YbDArmPsGUH+7b6dNxDa3Xo+fd5npGgz=RFehSw6iA@mail.gmail.com>
Subject: Re: [RFC PATCH 20/26] hugetlb: add support for high-granularity UFFDIO_CONTINUE
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:20 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jul 15, 2022 at 09:58:10AM -0700, James Houghton wrote:
> > On Fri, Jul 15, 2022 at 9:21 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Fri, Jun 24, 2022 at 05:36:50PM +0000, James Houghton wrote:
> > > > The changes here are very similar to the changes made to
> > > > hugetlb_no_page, where we do a high-granularity page table walk and
> > > > do accounting slightly differently because we are mapping only a piece
> > > > of a page.
> > > >
> > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > > ---
> > > >  fs/userfaultfd.c        |  3 +++
> > > >  include/linux/hugetlb.h |  6 +++--
> > > >  mm/hugetlb.c            | 54 +++++++++++++++++++++-----------------
> > > >  mm/userfaultfd.c        | 57 +++++++++++++++++++++++++++++++----------
> > > >  4 files changed, 82 insertions(+), 38 deletions(-)
> > > >
> > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > index e943370107d0..77c1b8a7d0b9 100644
> > > > --- a/fs/userfaultfd.c
> > > > +++ b/fs/userfaultfd.c
> > > > @@ -245,6 +245,9 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> > > >       if (!ptep)
> > > >               goto out;
> > > >
> > > > +     if (hugetlb_hgm_enabled(vma))
> > > > +             goto out;
> > > > +
> > >
> > > This is weird.  It means we'll never wait for sub-page mapping enabled
> > > vmas.  Why?
> > >
> >
> > `ret` is true in this case, so we're actually *always* waiting.
>
> Aha!  Then I think that's another problem, sorry. :) See Below.
>
> >
> > > Not to mention hugetlb_hgm_enabled() currently is simply VM_SHARED, so it
> > > means we'll stop waiting for all shared hugetlbfs uffd page faults..
> > >
> > > I'd expect in the in-house postcopy tests you should see vcpu threads
> > > spinning on the page faults until it's serviced.
> > >
> > > IMO we still need to properly wait when the pgtable doesn't have the
> > > faulted address covered.  For sub-page mapping it'll probably need to walk
> > > into sub-page levels.
> >
> > Ok, SGTM. I'll do that for the next version. I'm not sure of the
> > consequences of returning `true` here when we should be returning
> > `false`.
>
> We've put ourselves onto the wait queue, if another concurrent
> UFFDIO_CONTINUE happened and pte is already installed, I think this thread
> could be waiting forever on the next schedule().
>
> The solution should be the same - walking the sub-page pgtable would work,
> afaict.
>
> [...]
>
> > > > @@ -6239,14 +6241,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > > >        * registered, we firstly wr-protect a none pte which has no page cache
> > > >        * page backing it, then access the page.
> > > >        */
> > > > -     if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
> > > > +     if (!hugetlb_pte_none_mostly(dst_hpte))
> > > >               goto out_release_unlock;
> > > >
> > > > -     if (vm_shared) {
> > > > -             page_dup_file_rmap(page, true);
> > > > -     } else {
> > > > -             ClearHPageRestoreReserve(page);
> > > > -             hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
> > > > +     if (new_mapping) {
> > >
> > > IIUC you wanted to avoid the mapcount accountings when it's the sub-page
> > > that was going to be mapped.
> > >
> > > Is it a must we get this only from the caller?  Can we know we're doing
> > > sub-page mapping already here and make a decision with e.g. dst_hpte?
> > >
> > > It looks weird to me to pass this explicitly from the caller, especially
> > > that's when we don't really have the pgtable lock so I'm wondering about
> > > possible race conditions too on having stale new_mapping values.
> >
> > The only way to know what the correct value for `new_mapping` should
> > be is to know if we had to change the hstate-level P*D to non-none to
> > service this UFFDIO_CONTINUE request. I'll see if there is a nice way
> > to do that check in `hugetlb_mcopy_atomic_pte`.
> > Right now there is no
>
> Would "new_mapping = dest_hpte->shift != huge_page_shift(hstate)" work (or
> something alike)?

This works in the hugetlb_fault case, because in the hugetlb_fault
case, we install the largest PTE possible. If we are mapping a page
for the first time, we will use an hstate-sized PTE. But for
UFFDIO_CONTINUE, we may be installing a 4K PTE as the first PTE for
the whole hpage.

>
> > race, because we synchronize on the per-hpage mutex.
>
> Yeah not familiar with that mutex enough to tell, as long as that mutex
> guarantees no pgtable update (hmm, then why we need the pgtable lock
> here???) then it looks fine.

Let me take a closer look at this. I'll have a more detailed
explanation for the next version of the RFC.

>
> [...]
>
> > > > @@ -335,12 +337,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> > > >       copied = 0;
> > > >       page = NULL;
> > > >       vma_hpagesize = vma_kernel_pagesize(dst_vma);
> > > > +     if (use_hgm)
> > > > +             vma_altpagesize = PAGE_SIZE;
> > >
> > > Do we need to check the "len" to know whether we should use sub-page
> > > mapping or original hpage size?  E.g. any old UFFDIO_CONTINUE code will
> > > still want the old behavior I think.
> >
> > I think that's a fair point; however, if we enable HGM and the address
> > and len happen to be hstate-aligned
>
> The address can, but len (note! not "end" here) cannot?

They both (dst_start and len) need to be hpage-aligned, otherwise we
won't be able to install hstate-sized PTEs. Like if we're installing
4K at the beginning of a 1G hpage, we can't install a PUD, because we
only want to install that 4K.

>
> > , we basically do the same thing as
> > if HGM wasn't enabled. It could be a minor performance optimization to
> > do `vma_altpagesize=vma_hpagesize` in that case, but in terms of how
> > the page tables are set up, the end result would be the same.
>
> Thanks,

Thanks!

>
> --
> Peter Xu
>
