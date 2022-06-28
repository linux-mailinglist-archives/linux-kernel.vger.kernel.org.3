Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E7255D2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbiF1Bb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243056AbiF1Bbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:31:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE2766D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:31:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i1so10934635wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1kij541w9Z+pa/MZJLadURpUoXi65YxPa2CRYu92jA=;
        b=cKi7cvajC+uPnxXFRitvLXro1PUT/Wjn852N+RTtDGloE02o9QdgJTYFJ60FUFMovm
         wDsovPIwtXkzKxEIX6RWu4yqHyd8RsV0AbMhT6jVO466kcqb0qJT0WYwxTGOkWv2Dzla
         CgEaWChHuOju356H0vVFjvdfq4RgLDZzZV+0k7TP+bcN18+PdnbOpAWG4q1k195uK//k
         wMv+8Y+jFg53RICi3MXHPjS3igvGyojvMC9H6/XYnjgNefFJmgeN2DqQlsqCQtGw9yGf
         fIaDBMVILyUZ2mjGMjmX4zH7caCmokzf88MKEiqlKpvYEWCiOXS4yDcjVnikX/tf2cbI
         IDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1kij541w9Z+pa/MZJLadURpUoXi65YxPa2CRYu92jA=;
        b=N5QPU/utmjeWeFxhZ6PTwpaHdGN54wg9AnVo0zKp4u1sU6+6aPkFUAXifRI58yrXQ1
         iEHSg5/haA/2R1IK5/VKfumgCbgJImg1W6Hul2khdjTMuSOfV8x74b4FfvteEzzNcqxr
         uC2TB0e2FGIXKq5nGxcZV/Jm3V/Swev6O3/XH/+75BOzH5uJJbGgh6rpRYd3ZS4o58zw
         PGFj+V45aTe1koGSCF7e2vYYMgoTTxIrkj02/6ku7cTphg460DqjixmHo8K6B2YLQyK3
         6WuW8OuVOAzfpVNtjm5YMna5SNrXcyw5V4mawWeXcnu4YbCRFbLt5Ga+ocyF4sY71ID/
         V/SA==
X-Gm-Message-State: AJIora93HbAk+4bprQLh13m3yzJkyPMsx6IE8focbtH9waCpKf4w/+Ip
        eIxHv03EXNUBbJQNw0c+nNYsEJPy/9eiTNJA+EQ6qw==
X-Google-Smtp-Source: AGRyM1t9WQkJ2cZEurotfSjnoPbzZYp5/Nfaaj9MoN5XpJDdUXwQY52sQWwNS/4aCPvBX7itJzpfPuNQwLRYKYUjF9M=
X-Received: by 2002:a5d:664d:0:b0:21a:3b82:6bb2 with SMTP id
 f13-20020a5d664d000000b0021a3b826bb2mr15177634wrw.534.1656379910608; Mon, 27
 Jun 2022 18:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220621125658.64935-1-songmuchun@bytedance.com>
 <CAJD7tkbeTtkMcVri9vzKHATjxAVZfC_vPNfApJiyRxY53c8pZQ@mail.gmail.com>
 <YrlYG0ecJyzFTVVz@FVFYT0MHHV2J.usts.net> <CAJD7tkbubDhpJV81qkXqRE5-yvvcjKrtPnZnECenafz+to=3_Q@mail.gmail.com>
 <YrmC3FbUAD74lKq/@FVFYT0MHHV2J.usts.net> <YrpYPl1K/k1W30nh@castle>
In-Reply-To: <YrpYPl1K/k1W30nh@castle>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Jun 2022 18:31:14 -0700
Message-ID: <CAJD7tkaOJoZ-8S5RaefDKtD_+aCGVa-RJ3hR23EHOZqT_wf+ew@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Use obj_cgroup APIs to charge the LRU pages
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, longman@redhat.com,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>, duanxiongchun@bytedance.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Mon, Jun 27, 2022 at 6:24 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Mon, Jun 27, 2022 at 06:13:48PM +0800, Muchun Song wrote:
> > On Mon, Jun 27, 2022 at 01:05:06AM -0700, Yosry Ahmed wrote:
> > > On Mon, Jun 27, 2022 at 12:11 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > On Sun, Jun 26, 2022 at 03:32:02AM -0700, Yosry Ahmed wrote:
> > > > > On Tue, Jun 21, 2022 at 5:57 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > > > >
> > > > > > This version is rebased on mm-unstable. Hopefully, Andrew can get this series
> > > > > > into mm-unstable which will help to determine whether there is a problem or
> > > > > > degradation. I am also doing some benchmark tests in parallel.
> > > > > >
> > > > > > Since the following patchsets applied. All the kernel memory are charged
> > > > > > with the new APIs of obj_cgroup.
> > > > > >
> > > > > >         commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects instead of pages")
> > > > > >         commit b4e0b68fbd9d ("mm: memcontrol: use obj_cgroup APIs to charge kmem pages")
> > > > > >
> > > > > > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > > > > > it exists at a larger scale and is causing recurring problems in the real
> > > > > > world: page cache doesn't get reclaimed for a long time, or is used by the
> > > > > > second, third, fourth, ... instance of the same job that was restarted into
> > > > > > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > > > > > and make page reclaim very inefficient.
> > > > > >
> > > > > > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > > > > > to fix this problem, and then the LRU pages will not pin the memcgs.
> > > > > >
> > > > > > This patchset aims to make the LRU pages to drop the reference to memory
> > > > > > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > > > > > of the dying cgroups will not increase if we run the following test script.
> > > > >
> > > > > This is amazing work!
> > > > >
> > > > > Sorry if I came late, I didn't follow the threads of previous versions
> > > > > so this might be redundant, I just have a couple of questions.
> > > > >
> > > > > a) If LRU pages keep getting parented until they reach root_mem_cgroup
> > > > > (assuming they can), aren't these pages effectively unaccounted at
> > > > > this point or leaked? Is there protection against this?
> > > > >
> > > >
> > > > In this case, those pages are accounted in root memcg level. Unfortunately,
> > > > there is no mechanism now to transfer a page's memcg from one to another.
> > > >
> > > > > b) Since moving charged pages between memcgs is now becoming easier by
> > > > > using the APIs of obj_cgroup, I wonder if this opens the door for
> > > > > future work to transfer charges to memcgs that are actually using
> > > > > reparented resources. For example, let's say cgroup A reads a few
> > > > > pages into page cache, and then they are no longer used by cgroup A.
> > > > > cgroup B, however, is using the same pages that are currently charged
> > > > > to cgroup A, so it keeps taxing cgroup A for its use. When cgroup A
> > > > > dies, and these pages are reparented to A's parent, can we possibly
> > > > > mark these reparented pages (maybe in the page tables somewhere) so
> > > > > that next time they get accessed we recharge them to B instead
> > > > > (possibly asynchronously)?
> > > > > I don't have much experience about page tables but I am pretty sure
> > > > > they are loaded so maybe there is no room in PTEs for something like
> > > > > this, but I have always wondered about what we can do for this case
> > > > > where a cgroup is consistently using memory charged to another cgroup.
> > > > > Maybe when this memory is reparented is a good point in time to decide
> > > > > to recharge appropriately. It would also fix the reparenty leak to
> > > > > root problem (if it even exists).
> > > > >
> > > >
> > > > From my point of view, this is going to be an improvement to the memcg
> > > > subsystem in the future.  IIUC, most reparented pages are page cache
> > > > pages without be mapped to users. So page tables are not a suitable
> > > > place to record this information. However, we already have this information
> > > > in struct obj_cgroup and struct mem_cgroup. If a page's obj_cgroup is not
> > > > equal to the page's obj_cgroup->memcg->objcg, it means this page have
> > > > been reparented. I am thinking if a place where a page is mapped (probably
> > > > page fault patch) or page (cache) is written (usually vfs write path)
> > > > is suitable to transfer page's memcg from one to another. But need more
> > >
> > > Very good point about unmapped pages, I missed this. Page tables will
> > > do us no good here. Such a change would indeed require careful thought
> > > because (like you mentioned) there are multiple points in time where
> > > it might be suitable to consider recharging the page (e.g. when the
> > > page is mapped). This could be an incremental change though. Right now
> > > we have no recharging at all, so maybe we can gradually add recharging
> > > to suitable paths.
> > >
> >
> > Agree.
> >
> > > > thinking, e.g. How to decide if a reparented page needs to be transferred?
> > >
> > > Maybe if (page's obj_cgroup->memcg == root_mem_cgroup) OR (memcg of
> >
> > This is a good start.
> >
> > > current is not a descendant of page's obj_cgroup->memcg) is a good
> >
> > I am not sure this one since a page could be shared between different
> > memcg.
>
> No way :)

No way in terms of charging or usage? AFAIU a page is only charged to
one memcg, but can be used by multiple memcgs if it exists in the page
cache for example. Am I missing something here?

>
> >
> >     root
> >    /   \
> >   A     B
> >  / \     \
> > C   E     D
> >
> > e.g. a page (originally, it belongs to memcg E and E is dying) is reparented
> > to memcg A, and it is shared between C and D now. Then we need to consider
> > whether it should be recharged. Yep, we need more thinging about recharging.
>
> This is why I wasn't sure that objcg-based reparenting is the best approach.
> Instead (or maybe even _with_ the reparenting) we can recharge pages on, say,
> page activation and/or rotation (inactive->inactive). Pagefaults/reads are
> probably to hot to do it there. But the reclaim path should be more accessible
> in terms of the performance overhead. Just some ideas.

Thanks for chipping in, Roman! I am honestly not sure on what paths
the recharge should occur, but I know that we will probably need a
recharge mechanism at some point. We can start adding recharging
gradually to paths that don't affect performance, reclaim is a very
good place. Maybe we sort LRUs such that reparented pages are scanned
first, and possibly recharged under memcg pressure.

>
> Thanks!
