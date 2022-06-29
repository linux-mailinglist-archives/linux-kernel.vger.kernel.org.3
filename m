Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1426A55F6C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiF2Gj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiF2GjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:39:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8720BC3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:39:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q18so13159365pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3fDtVdFXcJ1THjzBC8Y1/G61yWX9UP0wjExNA/N4V6k=;
        b=bvufUtoDfA/LfWUF82SXjQBHU2AmthBebbO+sxI0rXBGT8WtDWG95lIcL4rZGxP5Tt
         PwZGqgSPUqKXjTiv9mlS7ejYruLqcwcKOMjX9Mh5EaSbgB6IGfuZBUbSvTcBQaTKJaEt
         VeBhPLlVwum1JmdK8FMVEvvbzI7/V33dbCBFjFoWsvD0BXSXndsu+9KM3gBbgFQ6zKPk
         saN9jAkLtYiQttbVbqLKYsACpC8c+omvBbtiGBOdrZsd4FJh4xwcBrzCxJtXgTj6/J6u
         /kLln4GD5YmkOYVoyo1ax+Tzrn5FJFSlsdVCpPGfBsGUNES6COLFFOdMXZzb9PGqHg/z
         2baQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3fDtVdFXcJ1THjzBC8Y1/G61yWX9UP0wjExNA/N4V6k=;
        b=M/0VgGlWyJqAhYUv8Dr/H2I1DFJejVIami2r6c6DKXsHZR/6krsP7Yh1OeQyVM0I3o
         doB2+fDSihW/wXWO7Jd7N25oFncIJl81BPwZX/QC+MEVpNOBdzp1P5k2TZTAYnu9+Rql
         jUHUezxkjXtLPG4s1F6Unw+fIeHFnphyNG8/Dya9mHDE2ZVn7AeiwIkWJF/eeoKBlkVk
         qt71EShtuqV+4F/kva7CicquHgaDxhHN2S+Di4DzX1eDGcw1bOLo1gYlnM+mmxEnhRPb
         nps6GCLCq/I4N14MNyKSFzg0nmaFGVaCNibTzOYQ0rFBPxM4oTrdNSvtFjbediX9iE3O
         QFGw==
X-Gm-Message-State: AJIora8m4QzxLzVb59cOiU6ee2cXrymvpW7OFkXX/jbpcoSam3iycAuZ
        2JhgWeooiYkYjK3pjKj0AjntgA==
X-Google-Smtp-Source: AGRyM1vkqnd7LQ1E7AuJh2kisRaI+S1yh0QCO2tzOtAaBIZIqvJk2B/XKhQXCmkVD2Q5kBC7FeF0nw==
X-Received: by 2002:a17:902:d2c4:b0:16a:5c48:8312 with SMTP id n4-20020a170902d2c400b0016a5c488312mr7785514plc.45.1656484761389;
        Tue, 28 Jun 2022 23:39:21 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id y27-20020a634b1b000000b0040cff9def93sm10268662pga.66.2022.06.28.23.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 23:39:20 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:39:17 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/26] hugetlb: sort hstates in hugetlb_init_hstates
Message-ID: <YrvzlTU2z8/IrEuK@FVFYT0MHHV2J.usts.net>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-3-jthoughton@google.com>
 <Yrn6DfTINknKNS04@monkey>
 <CADrL8HUD14o6XybhYDdozAUkJ4Zt6nE8=dm-_osKg2CmvOFzHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrL8HUD14o6XybhYDdozAUkJ4Zt6nE8=dm-_osKg2CmvOFzHg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 08:40:27AM -0700, James Houghton wrote:
> On Mon, Jun 27, 2022 at 11:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 06/24/22 17:36, James Houghton wrote:
> > > When using HugeTLB high-granularity mapping, we need to go through the
> > > supported hugepage sizes in decreasing order so that we pick the largest
> > > size that works. Consider the case where we're faulting in a 1G hugepage
> > > for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
> > > a PUD. By going through the sizes in decreasing order, we will find that
> > > PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.
> > >
> > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > ---
> > >  mm/hugetlb.c | 40 +++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 37 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index a57e1be41401..5df838d86f32 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/migrate.h>
> > >  #include <linux/nospec.h>
> > >  #include <linux/delayacct.h>
> > > +#include <linux/sort.h>
> > >
> > >  #include <asm/page.h>
> > >  #include <asm/pgalloc.h>
> > > @@ -48,6 +49,10 @@
> > >
> > >  int hugetlb_max_hstate __read_mostly;
> > >  unsigned int default_hstate_idx;
> > > +/*
> > > + * After hugetlb_init_hstates is called, hstates will be sorted from largest
> > > + * to smallest.
> > > + */
> > >  struct hstate hstates[HUGE_MAX_HSTATE];
> > >
> > >  #ifdef CONFIG_CMA
> > > @@ -3144,14 +3149,43 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
> > >       kfree(node_alloc_noretry);
> > >  }
> > >
> > > +static int compare_hstates_decreasing(const void *a, const void *b)
> > > +{
> > > +     const int shift_a = huge_page_shift((const struct hstate *)a);
> > > +     const int shift_b = huge_page_shift((const struct hstate *)b);
> > > +
> > > +     if (shift_a < shift_b)
> > > +             return 1;
> > > +     if (shift_a > shift_b)
> > > +             return -1;
> > > +     return 0;
> > > +}
> > > +
> > > +static void sort_hstates(void)
> > > +{
> > > +     unsigned long default_hstate_sz = huge_page_size(&default_hstate);
> > > +
> > > +     /* Sort from largest to smallest. */
> > > +     sort(hstates, hugetlb_max_hstate, sizeof(*hstates),
> > > +          compare_hstates_decreasing, NULL);
> > > +
> > > +     /*
> > > +      * We may have changed the location of the default hstate, so we need to
> > > +      * update it.
> > > +      */
> > > +     default_hstate_idx = hstate_index(size_to_hstate(default_hstate_sz));
> > > +}
> > > +
> > >  static void __init hugetlb_init_hstates(void)
> > >  {
> > >       struct hstate *h, *h2;
> > >
> > > -     for_each_hstate(h) {
> > > -             if (minimum_order > huge_page_order(h))
> > > -                     minimum_order = huge_page_order(h);
> > > +     sort_hstates();
> > >
> > > +     /* The last hstate is now the smallest. */
> > > +     minimum_order = huge_page_order(&hstates[hugetlb_max_hstate - 1]);
> > > +
> > > +     for_each_hstate(h) {
> > >               /* oversize hugepages were init'ed in early boot */
> > >               if (!hstate_is_gigantic(h))
> > >                       hugetlb_hstate_alloc_pages(h);
> >
> > This may/will cause problems for gigantic hugetlb pages allocated at boot
> > time.  See alloc_bootmem_huge_page() where a pointer to the associated hstate
> > is encoded within the allocated hugetlb page.  These pages are added to
> > hugetlb pools by the routine gather_bootmem_prealloc() which uses the saved
> > hstate to add prep the gigantic page and add to the correct pool.  Currently,
> > gather_bootmem_prealloc is called after hugetlb_init_hstates.  So, changing
> > hstate order will cause errors.
> >
> > I do not see any reason why we could not call gather_bootmem_prealloc before
> > hugetlb_init_hstates to avoid this issue.
> 
> Thanks for catching this, Mike. Your suggestion certainly seems to
> work, but it also seems kind of error prone. I'll have to look at the
> code more closely, but maybe it would be better if I just maintained a
> separate `struct hstate *sorted_hstate_ptrs[]`, where the original

I don't think this is a good idea.  If you really rely on the order of
the initialization in this patch.  The easier solution is changing
huge_bootmem_page->hstate to huge_bootmem_page->hugepagesz. Then we
can use size_to_hstate(huge_bootmem_page->hugepagesz) in
gather_bootmem_prealloc().

Thanks.

> locations of the hstates remain unchanged, as to not break
> gather_bootmem_prealloc/other things.
> 
> > --
> > Mike Kravetz
> 
