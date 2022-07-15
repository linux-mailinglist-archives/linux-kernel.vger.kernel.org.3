Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EAD5765F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbiGORUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiGORUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03CBB79682
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657905639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PTK4goQcbNMUtE6aJiq+7EgmXb2x5IDyZNvU93q4GVI=;
        b=WED9835j/4K4uHSalJd4jiuJSAzC0WhxBrvpxP4yyxaDn8gku9BfAoKkBDeNNAXR/T8tpR
        tOInADxIOwq5JcJSGmG7ba29j/mAIrtcUG0FEfFbJObCBXCsZCatuV+Y/5038qmvhQNflB
        rxb9XZOln11gs7PZSNLiPGBS1xmN1Cg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-8ijHpdezNc6eEvZr5NSlhg-1; Fri, 15 Jul 2022 13:20:37 -0400
X-MC-Unique: 8ijHpdezNc6eEvZr5NSlhg-1
Received: by mail-qk1-f200.google.com with SMTP id x22-20020a05620a259600b006b552a69231so3869647qko.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTK4goQcbNMUtE6aJiq+7EgmXb2x5IDyZNvU93q4GVI=;
        b=sKDUlf5gLGZzmox7/g4rPGbqu/SEBoTjDvSQoVUcVUxLaQpwr7mQgoT9+oqhnEPMJV
         ILo8xYOAIipPAIHy/rD0yBVQGUndj5Yz4saH8aIGeQIbrQgiGkztndZvqYU35ql1QWqS
         jy2ARV8YURUwsXX8VV1Elflc6tRPU18W1E9cTmPHrGb2D0uT5W+35iz6KokOo+ayah5N
         9uraXyTsj2HTyPCKFwX79yl0ZLwSx5ki9wPoX9kL64d7Zs+jvcfJxLtVSli+HVBJwIJX
         q5q30cAD8oob8iYTfVoc5mFB/VM04jw8gUBlIcCVxvW7Kqg2x0ZyvAJnKXD087cEMFZn
         CrVg==
X-Gm-Message-State: AJIora/gQwZECU9qpZ2Y4vOCYRvcTQXJU11rg9rJwOkFEwU4oxHbEW3e
        l0vR/PyGqQFovx/Mrmppp4RZg+S5uqDhDGGoZc2vZBxYADS0STneFnm2KooW2UXhsduf6FnboWx
        wztus6NYBrF+oAmNro9AT+Z9w
X-Received: by 2002:a05:622a:313:b0:31e:bb0b:4748 with SMTP id q19-20020a05622a031300b0031ebb0b4748mr13265064qtw.439.1657905637150;
        Fri, 15 Jul 2022 10:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uOHJxrwYjG93/qRUTPsx6ZXOpHvxvgIjaBzPJoHTHPeCWsXmeiQ/5HBEzj58cZRgTurllH0g==
X-Received: by 2002:a05:622a:313:b0:31e:bb0b:4748 with SMTP id q19-20020a05622a031300b0031ebb0b4748mr13265042qtw.439.1657905636896;
        Fri, 15 Jul 2022 10:20:36 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05622a1b8d00b0031e9fa40c2esm4208168qtb.27.2022.07.15.10.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:20:36 -0700 (PDT)
Date:   Fri, 15 Jul 2022 13:20:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
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
Subject: Re: [RFC PATCH 20/26] hugetlb: add support for high-granularity
 UFFDIO_CONTINUE
Message-ID: <YtGh46Jr0EGpqW7s@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-21-jthoughton@google.com>
 <YtGUARcBHxLU0axU@xz-m1.local>
 <CADrL8HXYab_VJS=Y0h2OSiCrj2pYbDJME2P=Tsn9jcDRbcqR1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HXYab_VJS=Y0h2OSiCrj2pYbDJME2P=Tsn9jcDRbcqR1g@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 09:58:10AM -0700, James Houghton wrote:
> On Fri, Jul 15, 2022 at 9:21 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Jun 24, 2022 at 05:36:50PM +0000, James Houghton wrote:
> > > The changes here are very similar to the changes made to
> > > hugetlb_no_page, where we do a high-granularity page table walk and
> > > do accounting slightly differently because we are mapping only a piece
> > > of a page.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > ---
> > >  fs/userfaultfd.c        |  3 +++
> > >  include/linux/hugetlb.h |  6 +++--
> > >  mm/hugetlb.c            | 54 +++++++++++++++++++++-----------------
> > >  mm/userfaultfd.c        | 57 +++++++++++++++++++++++++++++++----------
> > >  4 files changed, 82 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index e943370107d0..77c1b8a7d0b9 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -245,6 +245,9 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
> > >       if (!ptep)
> > >               goto out;
> > >
> > > +     if (hugetlb_hgm_enabled(vma))
> > > +             goto out;
> > > +
> >
> > This is weird.  It means we'll never wait for sub-page mapping enabled
> > vmas.  Why?
> >
> 
> `ret` is true in this case, so we're actually *always* waiting.

Aha!  Then I think that's another problem, sorry. :) See Below.

> 
> > Not to mention hugetlb_hgm_enabled() currently is simply VM_SHARED, so it
> > means we'll stop waiting for all shared hugetlbfs uffd page faults..
> >
> > I'd expect in the in-house postcopy tests you should see vcpu threads
> > spinning on the page faults until it's serviced.
> >
> > IMO we still need to properly wait when the pgtable doesn't have the
> > faulted address covered.  For sub-page mapping it'll probably need to walk
> > into sub-page levels.
> 
> Ok, SGTM. I'll do that for the next version. I'm not sure of the
> consequences of returning `true` here when we should be returning
> `false`.

We've put ourselves onto the wait queue, if another concurrent
UFFDIO_CONTINUE happened and pte is already installed, I think this thread
could be waiting forever on the next schedule().

The solution should be the same - walking the sub-page pgtable would work,
afaict.

[...]

> > > @@ -6239,14 +6241,16 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > >        * registered, we firstly wr-protect a none pte which has no page cache
> > >        * page backing it, then access the page.
> > >        */
> > > -     if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
> > > +     if (!hugetlb_pte_none_mostly(dst_hpte))
> > >               goto out_release_unlock;
> > >
> > > -     if (vm_shared) {
> > > -             page_dup_file_rmap(page, true);
> > > -     } else {
> > > -             ClearHPageRestoreReserve(page);
> > > -             hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
> > > +     if (new_mapping) {
> >
> > IIUC you wanted to avoid the mapcount accountings when it's the sub-page
> > that was going to be mapped.
> >
> > Is it a must we get this only from the caller?  Can we know we're doing
> > sub-page mapping already here and make a decision with e.g. dst_hpte?
> >
> > It looks weird to me to pass this explicitly from the caller, especially
> > that's when we don't really have the pgtable lock so I'm wondering about
> > possible race conditions too on having stale new_mapping values.
> 
> The only way to know what the correct value for `new_mapping` should
> be is to know if we had to change the hstate-level P*D to non-none to
> service this UFFDIO_CONTINUE request. I'll see if there is a nice way
> to do that check in `hugetlb_mcopy_atomic_pte`.
> Right now there is no

Would "new_mapping = dest_hpte->shift != huge_page_shift(hstate)" work (or
something alike)?

> race, because we synchronize on the per-hpage mutex.

Yeah not familiar with that mutex enough to tell, as long as that mutex
guarantees no pgtable update (hmm, then why we need the pgtable lock
here???) then it looks fine.

[...]

> > > @@ -335,12 +337,16 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> > >       copied = 0;
> > >       page = NULL;
> > >       vma_hpagesize = vma_kernel_pagesize(dst_vma);
> > > +     if (use_hgm)
> > > +             vma_altpagesize = PAGE_SIZE;
> >
> > Do we need to check the "len" to know whether we should use sub-page
> > mapping or original hpage size?  E.g. any old UFFDIO_CONTINUE code will
> > still want the old behavior I think.
> 
> I think that's a fair point; however, if we enable HGM and the address
> and len happen to be hstate-aligned

The address can, but len (note! not "end" here) cannot?

> , we basically do the same thing as
> if HGM wasn't enabled. It could be a minor performance optimization to
> do `vma_altpagesize=vma_hpagesize` in that case, but in terms of how
> the page tables are set up, the end result would be the same.

Thanks,

-- 
Peter Xu

