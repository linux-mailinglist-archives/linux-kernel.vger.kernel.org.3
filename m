Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029585AA500
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiIBBWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiIBBWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:22:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E2C75CEE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:22:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so952005ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 18:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4ekojsMMqY2Pm05Rphb53MHYNyMEIvQwOJ3eVma3ANU=;
        b=DpE5ySnBVoMrzA8BE5ubvWKgQjB1eCXTMacZXixvZozSowwvy8FN2PZfmG+otQ9CV+
         OAf7gWgQnbp0SDJ8le0Tw3/xbHELKX/g6NcRgiey2LlnnGRPV8o72Hletv2uMsURQa3y
         rYwiT+BKPC/m9v1v6RZ+woAz1ofjW1p559y30t9akOy+/w6kSRD/GjPxNyEJYOavDCXm
         Ov7Rry9VHU3af8eC6+7+fZ4KGjQKLl2Lfxxs539lVqvhtCJwZ02M3joaNM9ui5UyjxH6
         VZnGPJ57zgHXiSdTX+2G4gMUAn1J8TCA2aAybDOArbH04LzR44QuRDzQNQY3k4V5rrOO
         Lcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4ekojsMMqY2Pm05Rphb53MHYNyMEIvQwOJ3eVma3ANU=;
        b=Zvsng7w1OJ5sanpziYg2J6ijWZdhGuLr9DX7HAdURQkWdzZL/EaqrQJo9eqCVQv0NG
         Cc6IgBE8ADQA/pQvNYzIxTigIJRyFWtX8YxOawum/flIoXoo/cgvJFBFpSFsZuT97AEr
         m66bdyz+y3Hmxyjw/7Fu/LD9KFzoeKTgAh96gkMo7meNloPlM9SbVdy7CLgOOen6ea9/
         VaCoY/7frda+QdtlSeZlcCmmEgOX6jVlYymKewzw7OYlOMJjR/SzTJ6Zoy68RGkpsqC6
         6FFpT4JUJDk9ySBICbr3VsJgOEpiyzkD8l2379aNuLkvBTz4x+JGQCc6tEH7QLYZb7mS
         6NGg==
X-Gm-Message-State: ACgBeo3k6s+sZw3G93b+QTkqx+S4n1k+bIjcxqTFHy0CBY5PR0hxgQkQ
        B4XjpnPhgKNyipQcWYFohIf5ZlUhaZPsJ86+AE1dpmbF0+s=
X-Google-Smtp-Source: AA6agR7W3a5Sl/Lf3q0qup8swxm27nDGIzxM98seBuNVPpdZiEoOzNDOaGns8RakN4dBbM2m+TBvcVlsmwdczcFz+XY=
X-Received: by 2002:a17:906:8462:b0:741:6003:71e4 with SMTP id
 hx2-20020a170906846200b00741600371e4mr17739965ejc.170.1662081730591; Thu, 01
 Sep 2022 18:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAGsJ_4w=NKr-NOg2TLycx=ka1OpzmzC2dpq0Z1EUXaXDMM8uVQ@mail.gmail.com>
 <20220901221114.81601-1-sj@kernel.org>
In-Reply-To: <20220901221114.81601-1-sj@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 2 Sep 2022 13:21:59 +1200
Message-ID: <CAGsJ_4zw7eiDT5WXOhxNSH5154pRYhTx00JZrnNP=cSqNStyjw@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm/damon: introduce DAMON-based LRU-lists Sorting
To:     SeongJae Park <sj@kernel.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 10:11 AM SeongJae Park <sj@kernel.org> wrote:
>
> On Fri, 2 Sep 2022 09:40:10 +1200 Barry Song <21cnbao@gmail.com> wrote:
>
> > On Fri, Sep 2, 2022 at 5:11 AM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Hi Barry,
> > >
> > >
> > > On Thu, 1 Sep 2022 14:21:21 +1200 Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > > On Thu, Sep 1, 2022 at 2:03 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jun 14, 2022 at 10:01 AM SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > Users can do data access-aware LRU-lists sorting using 'LRU_PRIO' and
> > > > > > 'LRU_DEPRIO' DAMOS actions.  However, finding best parameters including
> > > > > > the hotness/coldness thresholds, CPU quota, and watermarks could be
> > > > > > challenging for some users.  To make the scheme easy to be used without
> > > > > > complex tuning for common situations, this commit implements a static
> > > > > > kernel module called 'DAMON_LRU_SORT' using the 'LRU_PRIO' and
> > > > > > 'LRU_DEPRIO' DAMOS actions.
> > > > > >
> > > > > > It proactively sorts LRU-lists using DAMON with conservatively chosen
> > > > > > default values of the parameters.  That is, the module under its default
> > > > > > parameters will make no harm for common situations but provide some
> > > > > > level of efficiency improvements for systems having clear hot/cold
> > > > > > access pattern under a level of memory pressure while consuming only a
> > > > > > limited small portion of CPU time.
> > > > >
> > > >
> > > > Hi SeongJae,
> > > > While I believe DAMON pro-active reclamation and LRU-SORT can benefit the system
> > > > by either swapping out cold pages earlier and sorting LRU lists before
> > > > system has high
> > > > memory pressure, I am still not convinced the improvement really comes from the
> > > > identification of cold and hot pages by DAMON.
> > > >
> > > > My guess is that even if we randomly pick some regions in memory and do the same
> > > > thing in the kernel, we can also see the improvement.
> > > >
> > > > As we actually depend on two facts to benefit from DAMON
> > > > 1. locality
> > > > while virtual address might have some locality, physical address seems
> > > > not. for example,
> > > > address A might be mapped by facebook, address A + 4096 could be
> > > > mapped by youtube.
> > > > There is nothing which can stop contiguous physical addresses from
> > > > being mapped by
> > > > completely irrelevant applications. so regions based on paddr seems pointless.
> > > >
> > > > 2. accuration
> > > > As I have reported it is very hard for damon to accurately track
> > > > virtual address since
> > > > virtual space is so huge:
> > > > https://lore.kernel.org/lkml/CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com/
> > > > I believe it is also true for paddr since paddr has much worse
> > > > locality than vaddr.
> > > > so we probably need a lot of regions, ideally, one region for each page.
> > > >
> > > > To me, it seems neither of these two facts are true.  So I am more
> > > > willing to believe
> > > > that the benefits come from areas  picked randomly.
> > > >
> > > > Am I missing something?
> > >
> > > Thank you for the questions.
> > >
> > > As you mentioned, DAMON assumes spatial and temporal locality, to trade
> > > accuracy for lower overhead[1].  That is, DAMON believes some memory regions
> > > would have pages that accessed in similar frequency for similar time duration.
> > > Therefore if the access pattern of the system is really chaotic, that is, if
> > > every adjacent page have very different access frequency or the access
> > > frequency changes very frequently, DAMON's accuracy would be bad.  But, would
> > > such access pattern really common in the real world?  Given the Pareto
> > > principle[2], I think that's not always true.  After all, many of kernel
> > > mechanisms including the pseudo-LRU-based reclamation and the readahead assumes
> > > some locality and makes good effect.
> >
> > + yu zhao
> >
> > I do believe we have some locality in virtual addresses as they are in
> > the same application.
> > that is why we can "exploit locality in rmap" here:
> > https://lore.kernel.org/linux-mm/20220815071332.627393-8-yuzhao@google.com/
> >
> > But for paddr, i doubt it is true as processes use page faults to get
> > pages from buddy
> > mainly in low order like zero.
>
> Well, what I can tell for now is that it would depend on the specific system
> and workload, but I found some production systems that have such kind of
> physical address space locality.

yep. I guess for mmu-less systems, spatial locality is more likely to be true.
for mmu system, workload using 2MB or 1GB THP will show some locality in
physical address as well. but THP_SWP will swap them as a whole, so it
seems locality inside a THP doesn't help? as we are not splitting sub pages
of THP for reclamation?

>
> >
> > >
> > > If your system has too low locality and therefore DAMON doesn't provide good
> > > enough accuracy, you could increase the accuracy by setting the upperbound of
> > > the monitoring overhead higher.  For DAMOS schemes like DAMON_RECLAIM or
> > > DAMON_LRU_SORT, you could also increase the minimum age of the target access
> > > pattern.  If the access pattern is really chaotic, DAMON wouldn't show the
> > > regions having the specific access pattern for long time.  Actually, definition
> > > of the age and use of it means you believe the system's access pattern is not
> > > that chaotic but has at least temporal locality.
> > >
> > > It's true that DAMON doesn't monitor access pattern in page granularity, and
> > > therefore it could report some cold pages as hot, and vice versa.  However, I'd
> > > say the benefit of making right decision for huge number of pages outweighs the
> > > risk of making wrong decision for few pages in many cases.
> > >
> > > After all, it shows some benefit on my test environments and some production
> > > systems.  I haven't compared that against random pageout or random lru sorting,
> > > though.
> > >
> > > Nevertheless, DAMON has so many rooms for improvement, including the accuracy.
> > > I want to improve the accuracy while keeping the overhead low.  Also, I know
> > > that there are people who willing to do page-granularity monitoring though it
> > > could incur high monitoring overhead.  As a part of the DAMON accuracy
> > > improvement plan, to use that as a comparison target, and to convince such
> > > people, I added the page granularity monitoring feature of DAMON to my todo
> > > list.  I haven't had a time for prioritizing that yet, though, as I haven't
> > > heard some clear voice of users for that.  I hope the DAMON Beer/Coffee/Tea
> > > Chat Series to be a place to hear such voices.
> >
> > is it possible for us to leverage the idea from  "mm: multi-gen LRU:
> > support page table walks"
> >
> > https://lore.kernel.org/linux-mm/20220815071332.627393-9-yuzhao@google.com/
> >
> > we pro-actively scan the virtual address space of those processes
> > which have been really
> > executed then get LRU sorted earlier?
>
> I didn't read MGLRU patchset thoroughly, but, maybe?
>

Yes, please read MGLRU, SeongJae. I find some ideas in MGLRU are
really good. we might
leverage those to improve DAMON as well :-)

>
> Thanks,
> SJ
>
> >
> > >
> > > [1] https://docs.kernel.org/mm/damon/design.html#address-space-independent-core-mechanisms
> > > [2] https://en.wikipedia.org/wiki/Pareto_principle
> > >
> > >
> > > Thanks,
> > > SJ
> >

Thanks
Barry
