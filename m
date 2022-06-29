Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47341560BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiF2Vjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiF2Vjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:39:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F3E1A056
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:39:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso810022pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grTYKqu3D49Tj9S+6hVywvJcuRvZPDZs+w7+lCg6y2Y=;
        b=ZGiDA7Gk6s8v6m+wxsg4aJeGN49MHkVJ6CUt8p+6pvQ7nnJuWI4A/Q7ZXMyD8yKlKq
         6GoAxnlBmld1YO5acfY1iXjl6JIIC73kAXosyHFPvtMSNfh3qFZaW4Oi4Xd7KxsLZIm0
         f9uUYHVjHRSWcs3w6tow/EYfLb3sOOeASIJoUkgvuQ2X2qM3o8tn7mvuJ5NKO3hcCTEL
         wt32ym+p5Jbk0/xB7fFBsORwM8maLBIPLd1N0mF+Y2SX+THeM0HqjkroageyInNtyBp5
         FrQJgf+N5qiYma9JZlKc7RpOX5qTo9fHkziFFi5HvFs5Va0liTNOksTdFnJ/HB2VMllt
         6tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grTYKqu3D49Tj9S+6hVywvJcuRvZPDZs+w7+lCg6y2Y=;
        b=0QBierK5fXU2Yom4GvMQ9lbI9Kt9Uy+Srk8/1tGM6t1We0eeolTPPScrvvg40//Ik8
         FSBSnUPweajZHPoeHCKx5azoXNWLkcWB/CNA0+SV4KjVYehN799qYrik5j/LtCTXOFWP
         Omwd4crOGeG6DuJEGLl1SwQ/okXN6HAsh6QQ7ezLhwpQE4mfs8KSeSsQ2+81XJcc4iLc
         EVBDviOniEm1cz9ATAPMoSL5/tq8xkjElQinsmTsgZADJctdtfnGjqteCopjw4XbNJ+X
         S/CsK6nfz55u9e5FRGKdBccjrZjOy4yRvPG4+NF9xY7RYtIx7ZiEn4zKBPrGJZiZmHwj
         r+8g==
X-Gm-Message-State: AJIora8VBM6MH5O7Th3v2Fk4mN+xvHq+CH9LfbmYEKUU/TqbEx8Pc3U2
        FZDmNogStgbrsE9ySRGpZ0IPLHJ/Z/VDIQnXYGJLqA==
X-Google-Smtp-Source: AGRyM1s1vwpEl6ikZ2qfTk1iog4Ag3ur80FKHxhmqAPsm+MrsXYjddvP90hD6D+5TEyFFkI0Qq9Fzl3gp+7KyqRZorY=
X-Received: by 2002:a17:902:e94f:b0:16a:214e:46c1 with SMTP id
 b15-20020a170902e94f00b0016a214e46c1mr11095666pll.89.1656538769735; Wed, 29
 Jun 2022 14:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com> <YroYaWVvNZJvtqsH@monkey>
 <Yrvsn66c+UI8ZQlO@FVFYT0MHHV2J.usts.net> <Yry+PPHSat2uN+aG@monkey>
In-Reply-To: <Yry+PPHSat2uN+aG@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 29 Jun 2022 14:39:19 -0700
Message-ID: <CADrL8HX9OkuWzpODBzHx-6-7_SLJ1YCCe5HxXdPa4ibqeQZu3A@mail.gmail.com>
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an explicit
 shift argument.
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

On Wed, Jun 29, 2022 at 2:04 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 06/29/22 14:09, Muchun Song wrote:
> > On Mon, Jun 27, 2022 at 01:51:53PM -0700, Mike Kravetz wrote:
> > > On 06/24/22 17:36, James Houghton wrote:
> > > > This is needed to handle PTL locking with high-granularity mapping. We
> > > > won't always be using the PMD-level PTL even if we're using the 2M
> > > > hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> > > > case, we need to lock the PTL for the 4K PTE.
> > >
> > > I'm not really sure why this would be required.
> > > Why not use the PMD level lock for 4K PTEs?  Seems that would scale better
> > > with less contention than using the more coarse mm lock.
> > >
> >
> > Your words make me thing of another question unrelated to this patch.
> > We __know__ that arm64 supports continues PTE HugeTLB. huge_pte_lockptr()
> > did not consider this case, in this case, those HugeTLB pages are contended
> > with mm lock. Seems we should optimize this case. Something like:
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 0d790fa3f297..68a1e071bfc0 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -893,7 +893,7 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
> >  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
> >                                            struct mm_struct *mm, pte_t *pte)
> >  {
> > -       if (huge_page_size(h) == PMD_SIZE)
> > +       if (huge_page_size(h) <= PMD_SIZE)
> >                 return pmd_lockptr(mm, (pmd_t *) pte);
> >         VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
> >         return &mm->page_table_lock;
> >
> > I did not check if elsewhere needs to be changed as well. Just a primary
> > thought.

I'm not sure if this works. If hugetlb_pte_size(hpte) is PAGE_SIZE,
then `hpte.ptep` will be a pte_t, not a pmd_t -- I assume that breaks
things. So I think, when doing a HugeTLB PT walk down to PAGE_SIZE, we
need to separately keep track of the location of the PMD so that we
can use it to get the PMD lock.

>
> That seems perfectly reasonable to me.
>
> Also unrelated, but using the pmd lock is REQUIRED for pmd sharing.  The
> mm lock is process specific and does not synchronize shared access.  I
> found that out the hard way. :)
>
> --
> Mike Kravetz
