Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACFF53FBB0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbiFGKo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbiFGKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:44:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAA331525;
        Tue,  7 Jun 2022 03:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41E2DB81EF1;
        Tue,  7 Jun 2022 10:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CED0C34119;
        Tue,  7 Jun 2022 10:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598649;
        bh=nfhDJ6GngF8XvKMVRBe5yZml/Bij47qErsn7ksIcrqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KoHdDKkyuckDx5pSqItebxhU46zBZqhQHomsHausLkCsqN6+q54WWdJzH3Cm0flO0
         F9fV0/66aX7znXvR0NEsQjgAfYG+p5crwv/6kA1mJrwFkUmkVjBW5oH/mpIo7EJNRz
         HUHWRYUCrhF4yi5MWePnMKrO9WnCAZIaWWzZnIF3jVx3ORZ8ZIq0vu5aKuUjmPr8gt
         EQ2Elys6X55LuWU1ea/ad2e7G0HwJo815xuuNNL2iUjvCOHnWohMG2Y/Ndv6fJMv3M
         kEgV+yKqmvfiAHExjbwt2ItT6EIkCZEHLJ+yj6SDpPtp8PAr/YzqtciRTJ4OuGeg3N
         D4MmMCUIZg31w==
Date:   Tue, 7 Jun 2022 11:43:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>, huzhanyuan@oppo.com
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
Message-ID: <20220607104358.GA32583@willie-the-truck>
References: <20220518014632.922072-1-yuzhao@google.com>
 <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
 <20220607102135.GA32448@willie-the-truck>
 <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 10:37:46AM +1200, Barry Song wrote:
> On Tue, Jun 7, 2022 at 10:21 PM Will Deacon <will@kernel.org> wrote:
> > On Tue, Jun 07, 2022 at 07:37:10PM +1200, Barry Song wrote:
> > > I can't really explain why we are getting a random app/java vm crash in monkey
> > > test by using ptep_test_and_clear_young() only in lru_gen_look_around() on an
> > > armv8-a machine without hardware PTE young support.
> > >
> > > Moving to  ptep_clear_flush_young() in look_around can make the random
> > > hang disappear according to zhanyuan(Cc-ed).
> > >
> > > On x86, ptep_clear_flush_young() is exactly ptep_test_and_clear_young()
> > > after
> > >  'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> > > the accessed bit instead of flushing the TLB")'
> > >
> > > But on arm64, they are different. according to Will's comments in this
> > > thread which
> > > tried to make arm64 same with x86,
> > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793881.html
> > >
> > > "
> > > This is blindly copied from x86 and isn't true for us: we don't invalidate
> > > the TLB on context switch. That means our window for keeping the stale
> > > entries around is potentially much bigger and might not be a great idea.
> > >
> > > If we roll a TLB invalidation routine without the trailing DSB, what sort of
> > > performance does that get you?
> > > "
> > > We shouldn't think ptep_clear_flush_young() is safe enough in LRU to
> > > clear PTE young? Any comments from Will?
> >
> > Given that this issue is specific to the multi-gen LRU work, I think Yu is
> > the best person to comment. However, looking quickly at your analysis above,
> > I wonder if the code is relying on this sequence:
> >
> >
> >         ptep_test_and_clear_young(vma, address, ptep);
> >         ptep_clear_flush_young(vma, address, ptep);
> >
> >
> > to invalidate the TLB. On arm64, that won't be the case, as the invalidation
> > in ptep_clear_flush_young() is predicated on the pte being young (and this
> > patches the generic implementation in mm/pgtable-generic.c. In fact, that
> > second function call is always going to be a no-op unless the pte became
> > young again in the middle.
> 
> thanks for your reply, sorry for failing to let you understand my question.
> my question is actually as below,
> right now  lru_gen_look_around() is using ptep_test_and_clear_young()
> only without flush to clear pte for a couple of pages including the specific
> address:
> void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
> {
>        ...
> 
>        for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
>                ...
> 
>                if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
>                        continue;
> 
>                ...
> }
> 
> I wonder if it is safe to arm64. Do we need to move to ptep_clear_flush_young()
> in the loop?

I don't know what this code is doing, so Yu is the best person to answer
that. There's nothing inherently dangerous about eliding the TLB
maintenance; it really depends on the guarantees needed by the caller.

However, the snippet you posted from folio_referenced_one():

 |                  if (pvmw.pte) {
 |  +                       if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
 |  +                           !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
 |  +                               lru_gen_look_around(&pvmw);
 |  +                               referenced++;
 |  +                       }
 |  +
 |                          if (ptep_clear_flush_young_notify(vma, address,


Does seem to call lru_gen_look_around() *and*
ptep_clear_flush_young_notify(), which is what prompted my question as it
looks pretty suspicious to me.

Will
