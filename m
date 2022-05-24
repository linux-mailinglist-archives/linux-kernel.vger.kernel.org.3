Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95A532F16
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiEXQhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiEXQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:37:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E485CE023
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FAB4B81802
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC82C34115;
        Tue, 24 May 2022 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653410249;
        bh=vvGHSyTSQoD32553zowylQZDuq/Dd/Xycf277l12l3A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qDk7C1uGg7Rl1YLLlZmO8RkOH5lXUc49Jn912boOAKy4m1vVg8Re7zaIXrRQIIl1n
         9OHLaj0LviXw/atAy2xJ92dOPqXdlWqDyI962E6KUqHiY3uPxALcB+5pEU8bQppfiU
         OxfYuERn4TU4UudxNti08UxM6WXY5AVTrj+SJk5Jl0la30QudhpUKLiE51SKnPvt3v
         FsjTEmm9ti2JpEQjAOLVAknpIyvljmyp/g0fiqgxH7BZmucHYwCIGR5rv9n2CI9ufE
         jCmMvECHxmyYvqBtUltLDLF+mZTtbng9btGoW662/25kLVgS2eiBAb4uaVzaYTgrt4
         LR/EOQCzUjdxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F09605C0378; Tue, 24 May 2022 09:37:28 -0700 (PDT)
Date:   Tue, 24 May 2022 09:37:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Minchan Kim <minchan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <20220524163728.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220517140049.GF63055@ziepe.ca>
 <ef901bdb-6117-bad4-2f26-c80df270b86e@nvidia.com>
 <20220517192825.GM63055@ziepe.ca>
 <b6eef200-43d1-7913-21ed-176b05fcb4fe@nvidia.com>
 <You3Q/VFaCoS0mC8@google.com>
 <bcb95d6b-4507-8836-cf17-7c3cd179a3da@nvidia.com>
 <YoxqSud9fvNXqo89@google.com>
 <20220524141937.GA2661880@ziepe.ca>
 <Yoz9H95uXbjoKwdC@google.com>
 <20220524154831.GC2661880@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524154831.GC2661880@ziepe.ca>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 12:48:31PM -0300, Jason Gunthorpe wrote:
> On Tue, May 24, 2022 at 08:43:27AM -0700, Minchan Kim wrote:
> > On Tue, May 24, 2022 at 11:19:37AM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 23, 2022 at 10:16:58PM -0700, Minchan Kim wrote:
> > > > On Mon, May 23, 2022 at 07:55:25PM -0700, John Hubbard wrote:
> > > > > On 5/23/22 09:33, Minchan Kim wrote:
> > > > > ...
> > > > > > > So then:
> > > > > > > 
> > > > > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > > > > index 0e42038382c1..b404f87e2682 100644
> > > > > > > +++ b/mm/page_alloc.c
> > > > > > > @@ -482,7 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
> > > > > > >          word_bitidx = bitidx / BITS_PER_LONG;
> > > > > > >          bitidx &= (BITS_PER_LONG-1);
> > > > > > > 
> > > > > > > -       word = bitmap[word_bitidx];
> > > > > > > +       /*
> > > > > > > +        * This races, without locks, with set_pageblock_migratetype(). Ensure
> > > > > >                                               set_pfnblock_flags_mask would be better?
> > > > > > > +        * a consistent (non-tearing) read of the memory array, so that results,
> > > > > > 
> > > > > > Thanks for proceeding and suggestion, John.
> > > > > > 
> > > > > > IIUC, the load tearing wouldn't be an issue since [1] fixed the issue.
> > > > > 
> > > > > Did it? [1] fixed something, but I'm not sure we can claim that that
> > > > > code is now safe against tearing in all possible cases, especially given
> > > > > the recent discussion here. Specifically, having this code do a read,
> > > > > then follow that up with calculations, seems correct. Anything else is
> > > > 
> > > > The load tearing you are trying to explain in the comment would be
> > > > solved by [1] since the bits will always align on a word and accessing
> > > > word size based on word aligned address is always atomic so there is
> > > > no load tearing problem IIUC.
> > > 
> > > That is not technically true. It is exactly the sort of thing
> > > READ_ONCE is intended to guard against.
> > 
> > Oh, does word access based on the aligned address still happen
> > load tearing? 
> > 
> > I just referred to
> > https://elixir.bootlin.com/linux/latest/source/Documentation/memory-barriers.txt#L1759
> 
> I read that as saying load tearing is technically allowed but doesn't
> happen in gcc, and so must use the _ONCE macros.

This is in fact the intent, except...

And as that passage goes on to state, there really are compilers (such
as GCC) that tear stores of constants to machine aligned/sized locations.

In short, use of the _ONCE() macros can save you a lot of pain.

> > I didn't say it doesn't refetch the value without the READ_ONCE.
> > 
> > What I am saying is READ_ONCE(bitmap_word_bitidx] prevents "refetching"
> > issue rather than "tearing" issue in specific __get_pfnblock_flags_mask
> > context because I though there is no load-tearing issue there since
> > bitmap is word-aligned/accessed. No?
> 
> It does both. AFAIK our memory model has no guarentees on what naked C
> statements will do. Tearing, multi-load, etc - it is all technically
> permitted. Use the proper accessors.

I am with Jason on this one.

In fact, I believe that any naked C-language access to mutable shared
variables should have a comment stating why the compiler cannot mangle
that access.

							Thanx, Paul
