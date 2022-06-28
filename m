Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE155E66B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347759AbiF1Pkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiF1Pkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:40:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC3D0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:40:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so7051811pjj.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/O/fAu/z5wIR2Tt1wRNpx7oM/8IQ7c97KuaGl+RDxRY=;
        b=Ndrf/nwkzP0xlXdJtQEGsYom6o6YovaBRoZs6vYCFyq3Ac+qNpargywQRgKpKFGxFu
         fIBmevJ8iBzkjswx3ZxH34Thn8KeQ8JFz1xiXFDw3a0XKjiSuJ+RX5ihlKiR1QWFXlBP
         yQIUUA+W/ITcCAwPLE6G9sO00m4z/AZh+IPTEW9JRPHmHjofioriP8BSGBVwfZKtf+e+
         LJYVNzzlEm9/wqstxgDVKZDJGWGHFVX1tNJOOgrcla5vCOoA8gOAqr7S1RfRyBa1eUZ1
         D7kXIRU0+FSxhpVjDqmrf92neQt6NJ8CXjMBHWBdrai7RC7fQgGK5sN8V3QUFyrqJBt7
         2bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/O/fAu/z5wIR2Tt1wRNpx7oM/8IQ7c97KuaGl+RDxRY=;
        b=11ze3e/C3VdwBk+F/w1R1FmTgUB9ieJl+VqHKtg3uKW+X/EIYAM85r4zr8FlOdY/xp
         kMDo8F/GADE0hvy/GgbM+Knt8B2RfFKky+pn1zm++Laal9iU9ffO/KDp/7lvswXcZhHH
         VnRBSVgKXdNXC93zPomQIwNtWXcsfLivv/z9lEg0hrkkr+6+yF6Bug49ih3zlt0aZdcd
         huEKEEH9tJ60nXnkK2PdPtzSl7r5vliwjemV+V3Iq8CJXk+ObxIVf657BpwFhcHwt8MY
         cID10mbAPCwargqrVJNM7pulDNduXjPJ94BQbxcx6hTBmdFmw9IDl8F2rBOsulqbaD0g
         fcXg==
X-Gm-Message-State: AJIora9AZ2MC1fHxAsdKCI/3QrDpQDyj+4/zjpt/ooUsowZQs9h7BZd8
        xAeXmQePmczI62OR0sieW/zZz9eZwaBNfn9um2traawl1It9ww==
X-Google-Smtp-Source: AGRyM1semGJYll4lUVae+1xmL2gICM7y3fVFTLJibtYnVeZ/R+FRel/MPkikBBdLknAzVCIGhZeDMT7n134aR5jp+24=
X-Received: by 2002:a17:902:e94f:b0:16a:214e:46c1 with SMTP id
 b15-20020a170902e94f00b0016a214e46c1mr4278522pll.89.1656430838615; Tue, 28
 Jun 2022 08:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-3-jthoughton@google.com> <Yrn6DfTINknKNS04@monkey>
In-Reply-To: <Yrn6DfTINknKNS04@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 28 Jun 2022 08:40:27 -0700
Message-ID: <CADrL8HUD14o6XybhYDdozAUkJ4Zt6nE8=dm-_osKg2CmvOFzHg@mail.gmail.com>
Subject: Re: [RFC PATCH 02/26] hugetlb: sort hstates in hugetlb_init_hstates
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 11:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 06/24/22 17:36, James Houghton wrote:
> > When using HugeTLB high-granularity mapping, we need to go through the
> > supported hugepage sizes in decreasing order so that we pick the largest
> > size that works. Consider the case where we're faulting in a 1G hugepage
> > for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
> > a PUD. By going through the sizes in decreasing order, we will find that
> > PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  mm/hugetlb.c | 40 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index a57e1be41401..5df838d86f32 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/migrate.h>
> >  #include <linux/nospec.h>
> >  #include <linux/delayacct.h>
> > +#include <linux/sort.h>
> >
> >  #include <asm/page.h>
> >  #include <asm/pgalloc.h>
> > @@ -48,6 +49,10 @@
> >
> >  int hugetlb_max_hstate __read_mostly;
> >  unsigned int default_hstate_idx;
> > +/*
> > + * After hugetlb_init_hstates is called, hstates will be sorted from largest
> > + * to smallest.
> > + */
> >  struct hstate hstates[HUGE_MAX_HSTATE];
> >
> >  #ifdef CONFIG_CMA
> > @@ -3144,14 +3149,43 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
> >       kfree(node_alloc_noretry);
> >  }
> >
> > +static int compare_hstates_decreasing(const void *a, const void *b)
> > +{
> > +     const int shift_a = huge_page_shift((const struct hstate *)a);
> > +     const int shift_b = huge_page_shift((const struct hstate *)b);
> > +
> > +     if (shift_a < shift_b)
> > +             return 1;
> > +     if (shift_a > shift_b)
> > +             return -1;
> > +     return 0;
> > +}
> > +
> > +static void sort_hstates(void)
> > +{
> > +     unsigned long default_hstate_sz = huge_page_size(&default_hstate);
> > +
> > +     /* Sort from largest to smallest. */
> > +     sort(hstates, hugetlb_max_hstate, sizeof(*hstates),
> > +          compare_hstates_decreasing, NULL);
> > +
> > +     /*
> > +      * We may have changed the location of the default hstate, so we need to
> > +      * update it.
> > +      */
> > +     default_hstate_idx = hstate_index(size_to_hstate(default_hstate_sz));
> > +}
> > +
> >  static void __init hugetlb_init_hstates(void)
> >  {
> >       struct hstate *h, *h2;
> >
> > -     for_each_hstate(h) {
> > -             if (minimum_order > huge_page_order(h))
> > -                     minimum_order = huge_page_order(h);
> > +     sort_hstates();
> >
> > +     /* The last hstate is now the smallest. */
> > +     minimum_order = huge_page_order(&hstates[hugetlb_max_hstate - 1]);
> > +
> > +     for_each_hstate(h) {
> >               /* oversize hugepages were init'ed in early boot */
> >               if (!hstate_is_gigantic(h))
> >                       hugetlb_hstate_alloc_pages(h);
>
> This may/will cause problems for gigantic hugetlb pages allocated at boot
> time.  See alloc_bootmem_huge_page() where a pointer to the associated hstate
> is encoded within the allocated hugetlb page.  These pages are added to
> hugetlb pools by the routine gather_bootmem_prealloc() which uses the saved
> hstate to add prep the gigantic page and add to the correct pool.  Currently,
> gather_bootmem_prealloc is called after hugetlb_init_hstates.  So, changing
> hstate order will cause errors.
>
> I do not see any reason why we could not call gather_bootmem_prealloc before
> hugetlb_init_hstates to avoid this issue.

Thanks for catching this, Mike. Your suggestion certainly seems to
work, but it also seems kind of error prone. I'll have to look at the
code more closely, but maybe it would be better if I just maintained a
separate `struct hstate *sorted_hstate_ptrs[]`, where the original
locations of the hstates remain unchanged, as to not break
gather_bootmem_prealloc/other things.

> --
> Mike Kravetz
