Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26BB525C51
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377817AbiEMHVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352114AbiEMHVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:21:31 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB825D64A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:21:28 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f13so2875731uax.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=levpsNNmZJAQ194UQtXw36sKWWPGKf4XBoSDPW1A4rU=;
        b=X+OzpWOlucNuJtW2aSC+sNkp1W0s/P/VScZDZkLnsl+WE2GHjzJSjggDyBi8Fo0Qsf
         1LBlrItXwa0AOyeedGWigL8fyMjbEmIQ9wC1L9Yx7OFbpH1+8Ak23zJx1ZmfUTMp9Rtn
         Mil56LuNQyzMuas70KC4xMcZnkSh1wA/0h2UStMkiRK2F+zwIAISx1jdbO+qYLMH+ysi
         Tad8tbq3z7y+xhzK9VqyYU7TUHu+HcFTqMFd6xLOoAZ3bAqPxCW5eaZoianznF+Rq7kS
         SfhRZiZvtNfKrEVkOMSQXUVcGud58XLmS6AzJ+mRbF4OnMz30qUasZHVGlv20ptbztNg
         MTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=levpsNNmZJAQ194UQtXw36sKWWPGKf4XBoSDPW1A4rU=;
        b=u+ehyqiWHN8oeVGeLW5pRWo3K+KSZWggO6eK7LC9SOYNBREP/HOxIMEm3WNqcPM6Fl
         WeyNrHhukYH3RKibQzKJImysnsePlk278XnuNxrBRAa3weHPG9302z2IyYdhhvRkXB+d
         IVGlmQwSSE+GoMv+/OHVWW1qBmELaMnmjGJZAT6HEcIfRXjZClxLqXDTZTkn0371O9QS
         39XcafVkP/YaVIni5eIMyeW7t7LY28kDE2HmC5n0OTZYFh+hjUmX1KroTSa++pBSQ2S5
         /KgchhpXX2xvE4YlhVQqszZKxE4junJE4Fa4PillBqi4ARtKLlX4wZCe6p+6J/RorQTr
         28YA==
X-Gm-Message-State: AOAM533xfw8Dcyf0cH60wvVPRr9VEd41dvA3jL9xs1sFlOgmBsNpmrbz
        +q2Pk4q4qZApcq+UfmbkG6MdFogRkz9dYJ85T/NxzA==
X-Google-Smtp-Source: ABdhPJx4lmaa+gXwCK5sj/EmTxVRnJW282wOjQX/NgYoja9RlgMjz6OGWlAllhaqg5zZgeJ0rcPVkgvzu2J84yvJuk4=
X-Received: by 2002:ab0:7643:0:b0:362:833d:5bfb with SMTP id
 s3-20020ab07643000000b00362833d5bfbmr1817401uaq.4.1652426487413; Fri, 13 May
 2022 00:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com>
 <CAAPL-u9endrWf_aOnPENDPdvT-2-YhCAeJ7ONGckGnXErTLOfQ@mail.gmail.com> <a3296507be17d99e60d4c1118699aa01268dd7b8.camel@intel.com>
In-Reply-To: <a3296507be17d99e60d4c1118699aa01268dd7b8.camel@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 13 May 2022 00:21:16 -0700
Message-ID: <CAAPL-u89gri+R-5zQRF3HLMX98TBhfdD2pH=yc6cJVX3mwmGcA@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
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

On Fri, May 13, 2022 at 12:04 AM ying.huang@intel.com
<ying.huang@intel.com> wrote:
>
> On Thu, 2022-05-12 at 23:36 -0700, Wei Xu wrote:
> > On Thu, May 12, 2022 at 8:25 PM ying.huang@intel.com
> > <ying.huang@intel.com> wrote:
> > >
> > > On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> > > >
> > > > Memory Allocation for Demotion
> > > > ==============================
> > > >
> > > > To allocate a new page as the demotion target for a page, the kernel
> > > > calls the allocation function (__alloc_pages_nodemask) with the
> > > > source page node as the preferred node and the union of all lower
> > > > tier nodes as the allowed nodemask.  The actual target node selection
> > > > then follows the allocation fallback order that the kernel has
> > > > already defined.
> > > >
> > > > The pseudo code looks like:
> > > >
> > > >     targets = NODE_MASK_NONE;
> > > >     src_nid = page_to_nid(page);
> > > >     src_tier = node_tier_map[src_nid];
> > > >     for (i = src_tier + 1; i < MAX_MEMORY_TIERS; i++)
> > > >             nodes_or(targets, targets, memory_tiers[i]);
> > > >     new_page = __alloc_pages_nodemask(gfp, order, src_nid, targets);
> > > >
> > > > The memopolicy of cpuset, vma and owner task of the source page can
> > > > be set to refine the demotion target nodemask, e.g. to prevent
> > > > demotion or select a particular allowed node as the demotion target.
> > >
> > > Consider a system with 3 tiers, if we want to demote some pages from
> > > tier 0, the desired behavior is,
> > >
> > > - Allocate pages from tier 1
> > > - If there's no enough free pages in tier 1, wakeup kswapd of tier 1 so
> > > demote some pages from tier 1 to tier 2
> > > - If there's still no enough free pages in tier 1, allocate pages from
> > > tier 2.
> > >
> > > In this way, tier 0 will have the hottest pages, while tier 1 will have
> > > the coldest pages.
> >
> > When we are already in the allocation path for the demotion of a page
> > from tier 0, I think we'd better not block this allocation to wait for
> > kswapd to demote pages from tier 1 to tier 2. Instead, we should
> > directly allocate from tier 2.  Meanwhile, this demotion can wakeup
> > kswapd to demote from tier 1 to tier 2 in the background.
>
> Yes.  That's what I want too.  My original words may be misleading.
>
> > > With your proposed method, the demoting from tier 0 behavior is,
> > >
> > > - Allocate pages from tier 1
> > > - If there's no enough free pages in tier 1, allocate pages in tier 2
> > >
> > > The kswapd of tier 1 will not be waken up until there's no enough free
> > > pages in tier 2.  In quite long time, there's no much hot/cold
> > > differentiation between tier 1 and tier 2.
> >
> > This is true with the current allocation code. But I think we can make
> > some changes for demotion allocations. For example, we can add a
> > GFP_DEMOTE flag and update the allocation function to wake up kswapd
> > when this flag is set and we need to fall back to another node.
> >
> > > This isn't hard to be fixed, just call __alloc_pages_nodemask() for each
> > > tier one by one considering page allocation fallback order.
> >
> > That would have worked, except that there is an example earlier, in
> > which it is actually preferred for some nodes to demote to their tier
> > + 2, not tier +1.
> >
> > More specifically, the example is:
> >
> >                  20
> >    Node 0 (DRAM) -- Node 1 (DRAM)
> >     |   |           |    |
> >     |   | 30    120 |    |
> >     |   v           v    | 100
> > 100 |  Node 2 (PMEM)     |
> >     |    |               |
> >     |    | 100           |
> >      \   v               v
> >       -> Node 3 (Large Mem)
> >
> > Node distances:
> > node   0    1    2    3
> >    0  10   20   30  100
> >    1  20   10  120  100
> >    2  30  120   10  100
> >    3 100  100  100   10
> >
> > 3 memory tiers are defined:
> > tier 0: 0-1
> > tier 1: 2
> > tier 2: 3
> >
> > The demotion fallback order is:
> > node 0: 2, 3
> > node 1: 3, 2
> > node 2: 3
> > node 3: empty
> >
> > Note that even though node 3 is in tier 2 and node 2 is in tier 1,
> > node 1 (tier 0) still prefers node 3 as its first demotion target, not
> > node 2.
>
> Yes.  I understand that we need to support this use case.  We can use
> the tier order in allocation fallback list instead of from small to
> large.  That is, for node 1, the tier order for demotion is tier 2, tier
> 1.

That could work, too, though I feel it might be simpler and more
efficient (no repeated calls to __alloc_pages for the same allocation)
to modify __alloc_pages() itself.

Anyway, we can discuss more on this when it comes to the
implementation of this demotion allocation function.  I believe this
should not affect the general memory tiering interfaces proposed here.

> Best Regards,
> Huang, Ying
>
>
>
