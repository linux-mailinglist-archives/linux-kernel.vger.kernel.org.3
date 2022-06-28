Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A98B55E61A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347898AbiF1Pfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347874AbiF1Pfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:35:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AEE3389F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:35:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q140so12553677pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Xad2VrzPahx1am7D0ZL0QWhiKM+P04nXRGOHvrlZTs=;
        b=ESV4BnBikZg2lkGcaWdqk40NhArW+jR+mYCCYt3K+v6vJP69keqdbBzxxEfTLf68Cs
         Yib2eKchFlE+NP1dCZ30NPzNDUYfzIWaSe8PbFY5RdcjjHqgTEMuCey6K9G4swBTc6oH
         43m2LBDrH1ghc0qoIMZJO0iAv4f0ZAlsyIxWKxJ+qjCsTgnljlU4MZfCnn6VGcRFf4vs
         9evXz+LBdiFYR7sYI3mtH41QGLJpNK/7hX3CW9/Ktd56RIA/+n6aV5bplA+fcQW/N73y
         /f0jhbmHq3LEspQBSCfR3LMpDYsT2ZkdT1gboeoS9Tpp+jj4dS9mxKOncJPTUAApYJMD
         B97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Xad2VrzPahx1am7D0ZL0QWhiKM+P04nXRGOHvrlZTs=;
        b=3S5I47yjyi4xHgj9XnsA82i+gdpZ5e6PhTCxga3HO3T9oB9SaxksN8DY758hr/VwSw
         hIT9x/HueuVpLPjH3k0xfHKdklvxnKF0XxvMLwJSB+SPgONfsy//3jDSfTLOgTTkFfOl
         rRAP9L/AFmLFg+WmybOWA8ghVKE/7P+Ua1UI/dsInWO7LAApRSeXsmX2dDvhGJyQ3aBZ
         K6gdYrrhB9Kkl+h2BOBY+136GDlkZ+mWSxR+W/7BixGrIhdTimfBYxd8ObqdPhAYS7xW
         8AQXoXg+ug16WApG7PBPb4clpz992+VPNM+eath4St7e1YUZPyItxIWYCQLY7c0NfQ5l
         CcEw==
X-Gm-Message-State: AJIora+0dMuC2l3TI3hNI9Glg7HRSrUXxUY9tzpzdY5251GF/b/X4Kt6
        TmN7BuZUQraUh34RcEMk+NnssPyGb4Ft4C7+q9X/7g==
X-Google-Smtp-Source: AGRyM1tr/ZpJ7CYBKDkl50lshphA+SoJZVQyFmUIYyu6EGLo9+k3wvJQanXwT3aXGp3nVQCsHNE4PEWljlWoB3gA9dE=
X-Received: by 2002:a05:6a00:2402:b0:4e1:46ca:68bd with SMTP id
 z2-20020a056a00240200b004e146ca68bdmr5300320pfh.70.1656430545342; Tue, 28 Jun
 2022 08:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-3-jthoughton@google.com> <7ec9cbbe-742a-4629-8764-90213e85ac58@nutanix.com>
In-Reply-To: <7ec9cbbe-742a-4629-8764-90213e85ac58@nutanix.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 28 Jun 2022 08:35:34 -0700
Message-ID: <CADrL8HXd_NSki5GWM-KO9rLKfWwnW-wCnxK0RSgPDWB4QOj4uQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/26] hugetlb: sort hstates in hugetlb_init_hstates
To:     "manish.mishra" <manish.mishra@nutanix.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
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

On Mon, Jun 27, 2022 at 5:09 AM manish.mishra <manish.mishra@nutanix.com> wrote:
>
>
> On 24/06/22 11:06 pm, James Houghton wrote:
> > When using HugeTLB high-granularity mapping, we need to go through the
> > supported hugepage sizes in decreasing order so that we pick the largest
> > size that works. Consider the case where we're faulting in a 1G hugepage
> > for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
> > a PUD. By going through the sizes in decreasing order, we will find that
> > PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >   mm/hugetlb.c | 40 +++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index a57e1be41401..5df838d86f32 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -33,6 +33,7 @@
> >   #include <linux/migrate.h>
> >   #include <linux/nospec.h>
> >   #include <linux/delayacct.h>
> > +#include <linux/sort.h>
> >
> >   #include <asm/page.h>
> >   #include <asm/pgalloc.h>
> > @@ -48,6 +49,10 @@
> >
> >   int hugetlb_max_hstate __read_mostly;
> >   unsigned int default_hstate_idx;
> > +/*
> > + * After hugetlb_init_hstates is called, hstates will be sorted from largest
> > + * to smallest.
> > + */
> >   struct hstate hstates[HUGE_MAX_HSTATE];
> >
> >   #ifdef CONFIG_CMA
> > @@ -3144,14 +3149,43 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
> >       kfree(node_alloc_noretry);
> >   }
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
> >   static void __init hugetlb_init_hstates(void)
> >   {
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
> As now hstates are ordered can code which does calculation of demot_order
>
> can too be optimised, i mean it can be value of order of hstate at next index?
>

Indeed -- thanks for catching that. I'll make this optimization for
the next version of this series.

>
