Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E963B5A9DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiIARLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiIARLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845E7B1D2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ED6261FEF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382D6C433D6;
        Thu,  1 Sep 2022 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662052292;
        bh=b9Znao3Ngu2YMwkEUpp3GJX4ksZuXWWbdBffPdufccI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7Uyf+VmRWnmQBJtYR67sCGwjrR1dwNGdqL55lOF4HBojydg4VkW8pYiApd+zyorX
         CrdH9+DaJig4K+yi9dxtqtjeU5BPXqQ3yNR1b3xPNUvZKoTjsBqkJHoof4HD9joUCC
         TDgY5paqp90CJLq/KdqW6iTkhDwsqym+/eWNNXU2YY1U3MaaIWtIgDQfSpOJdPjQzt
         AOd6c8anOfz0DqhiO1Gq4zdPtAjuYHFFnysZWXCFWbnc0+Vady+YNA8gtmjEl/LF6K
         9kJxN7irPtUJV5WWs5eDFCBJBlCcFPedks4Shb2+skKoYaHjNB7zQMrNMEUj7sbjqt
         2Qb0RuC+LV60g==
From:   SeongJae Park <sj@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH 7/8] mm/damon: introduce DAMON-based LRU-lists Sorting
Date:   Thu,  1 Sep 2022 17:11:30 +0000
Message-Id: <20220901171130.96616-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAGsJ_4xOo1shEYRw714uta0mNRASJrQhNFT0u=aSbygjuYU-ZQ@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,


On Thu, 1 Sep 2022 14:21:21 +1200 Barry Song <21cnbao@gmail.com> wrote:

> On Thu, Sep 1, 2022 at 2:03 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Tue, Jun 14, 2022 at 10:01 AM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Users can do data access-aware LRU-lists sorting using 'LRU_PRIO' and
> > > 'LRU_DEPRIO' DAMOS actions.  However, finding best parameters including
> > > the hotness/coldness thresholds, CPU quota, and watermarks could be
> > > challenging for some users.  To make the scheme easy to be used without
> > > complex tuning for common situations, this commit implements a static
> > > kernel module called 'DAMON_LRU_SORT' using the 'LRU_PRIO' and
> > > 'LRU_DEPRIO' DAMOS actions.
> > >
> > > It proactively sorts LRU-lists using DAMON with conservatively chosen
> > > default values of the parameters.  That is, the module under its default
> > > parameters will make no harm for common situations but provide some
> > > level of efficiency improvements for systems having clear hot/cold
> > > access pattern under a level of memory pressure while consuming only a
> > > limited small portion of CPU time.
> >
> 
> Hi SeongJae,
> While I believe DAMON pro-active reclamation and LRU-SORT can benefit the system
> by either swapping out cold pages earlier and sorting LRU lists before
> system has high
> memory pressure, I am still not convinced the improvement really comes from the
> identification of cold and hot pages by DAMON.
> 
> My guess is that even if we randomly pick some regions in memory and do the same
> thing in the kernel, we can also see the improvement.
> 
> As we actually depend on two facts to benefit from DAMON
> 1. locality
> while virtual address might have some locality, physical address seems
> not. for example,
> address A might be mapped by facebook, address A + 4096 could be
> mapped by youtube.
> There is nothing which can stop contiguous physical addresses from
> being mapped by
> completely irrelevant applications. so regions based on paddr seems pointless.
> 
> 2. accuration
> As I have reported it is very hard for damon to accurately track
> virtual address since
> virtual space is so huge:
> https://lore.kernel.org/lkml/CAGsJ_4x_k9009HwpTswEq1ut_co8XYdpZ9k0BVW=0=HRiifxkA@mail.gmail.com/
> I believe it is also true for paddr since paddr has much worse
> locality than vaddr.
> so we probably need a lot of regions, ideally, one region for each page.
> 
> To me, it seems neither of these two facts are true.  So I am more
> willing to believe
> that the benefits come from areas  picked randomly.
> 
> Am I missing something?

Thank you for the questions.

As you mentioned, DAMON assumes spatial and temporal locality, to trade
accuracy for lower overhead[1].  That is, DAMON believes some memory regions
would have pages that accessed in similar frequency for similar time duration.
Therefore if the access pattern of the system is really chaotic, that is, if
every adjacent page have very different access frequency or the access
frequency changes very frequently, DAMON's accuracy would be bad.  But, would
such access pattern really common in the real world?  Given the Pareto
principle[2], I think that's not always true.  After all, many of kernel
mechanisms including the pseudo-LRU-based reclamation and the readahead assumes
some locality and makes good effect.

If your system has too low locality and therefore DAMON doesn't provide good
enough accuracy, you could increase the accuracy by setting the upperbound of
the monitoring overhead higher.  For DAMOS schemes like DAMON_RECLAIM or
DAMON_LRU_SORT, you could also increase the minimum age of the target access
pattern.  If the access pattern is really chaotic, DAMON wouldn't show the
regions having the specific access pattern for long time.  Actually, definition
of the age and use of it means you believe the system's access pattern is not
that chaotic but has at least temporal locality.

It's true that DAMON doesn't monitor access pattern in page granularity, and
therefore it could report some cold pages as hot, and vice versa.  However, I'd
say the benefit of making right decision for huge number of pages outweighs the
risk of making wrong decision for few pages in many cases.

After all, it shows some benefit on my test environments and some production
systems.  I haven't compared that against random pageout or random lru sorting,
though.

Nevertheless, DAMON has so many rooms for improvement, including the accuracy.
I want to improve the accuracy while keeping the overhead low.  Also, I know
that there are people who willing to do page-granularity monitoring though it
could incur high monitoring overhead.  As a part of the DAMON accuracy
improvement plan, to use that as a comparison target, and to convince such
people, I added the page granularity monitoring feature of DAMON to my todo
list.  I haven't had a time for prioritizing that yet, though, as I haven't
heard some clear voice of users for that.  I hope the DAMON Beer/Coffee/Tea
Chat Series to be a place to hear such voices.

[1] https://docs.kernel.org/mm/damon/design.html#address-space-independent-core-mechanisms
[2] https://en.wikipedia.org/wiki/Pareto_principle


Thanks,
SJ
