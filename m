Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA43F510CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356181AbiDZXp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351361AbiDZXpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:45:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8918D7E59A;
        Tue, 26 Apr 2022 16:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E26EB823FE;
        Tue, 26 Apr 2022 23:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33F6C385A0;
        Tue, 26 Apr 2022 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651016564;
        bh=rkWOOpymajYPINPF/6OKmwxFHU7UQnqmc3SblTgW3GI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dh/nLmQngZ0x60vGJBUI8w3qIcq8X5L3WO8oRG8EFdQ8xQS4HuEiC+0LmW+KdbPuS
         DAdi1MD0ubzM0Cd93Pc5pxiRX/9JMruLVwwOGe4+clWiHvKERN/AO93Lt08ZIKpY0E
         rtXOwE7HdtS4x9VHAAKpSVHkmmMAV0mO16pJ2Lb0=
Date:   Tue, 26 Apr 2022 16:42:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?ISO-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 05/14] mm: multi-gen LRU: groundwork
Message-Id: <20220426164241.99e6a283c371ed75fa5c12a0@linux-foundation.org>
In-Reply-To: <CAOUHufaeNzDJnDqatHe0MwsN-D6M_tw6JX2UBJFc+JpZNP86hQ@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-6-yuzhao@google.com>
        <20220411191615.a34959bdcc25ef3f9c16a7ce@linux-foundation.org>
        <CAOUHufaeNzDJnDqatHe0MwsN-D6M_tw6JX2UBJFc+JpZNP86hQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 16:39:07 -0600 Yu Zhao <yuzhao@google.com> wrote:

> On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed,  6 Apr 2022 21:15:17 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > Evictable pages are divided into multiple generations for each lruvec.
> > > The youngest generation number is stored in lrugen->max_seq for both
> > > anon and file types as they are aged on an equal footing. The oldest
> > > generation numbers are stored in lrugen->min_seq[] separately for anon
> > > and file types as clean file pages can be evicted regardless of swap
> > > constraints. These three variables are monotonically increasing.
> > >
> > > ...
> > >
> > > +static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> >
> > There's a lot of function inlining here.  Fortunately the compiler will
> > ignore it all, because some of it looks wrong.  Please review (and
> > remeasure!).  If inlining is reqlly justified, use __always_inline, and
> > document the reasons for doing so.
> 
> I totally expect modern compilers to make better decisions than I do.
> And personally, I'd never use __always_inline; instead, I'd strongly
> recommend FDO/LTO.

My (badly expressed) point is that there's a lot of inlining of large
functions here.

For example, lru_gen_add_folio() is huge and has 4(?) call sites.  This
may well produce slower code due to the icache footprint.

Experiment: moving lru_gen_del_folio() into mm/vmscan.c shrinks that
file's .text from 80612 bytes to 78956.

I tend to think that out-of-line regular old C functions should be the
default and that the code should be inlined only when a clear benefit
is demonstrable, or has at least been seriously thought about.

> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -909,6 +909,14 @@ config ANON_VMA_NAME
> > >         area from being merged with adjacent virtual memory areas due to the
> > >         difference in their name.
> > >
> > > +config LRU_GEN
> > > +     bool "Multi-Gen LRU"
> > > +     depends on MMU
> > > +     # the following options can use up the spare bits in page flags
> > > +     depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
> > > +     help
> > > +       A high performance LRU implementation to overcommit memory.
> > > +
> > >  source "mm/damon/Kconfig"
> >
> > This is a problem.  I had to jump through hoops just to be able to
> > compile-test this.  Turns out I had to figure out how to disable
> > MAXSMP.
> >
> > Can we please figure out a way to ensure that more testers are at least
> > compile testing this?  Allnoconfig, defconfig, allyesconfig, allmodconfig.
> >
> > Also, I suggest that we actually make MGLRU the default while in linux-next.
> 
> The !MAXSMP is to work around [1], which I haven't had the time to
> fix. That BUILD_BUG_ON() shouldn't assert sizeof(struct page) == 64
> since the true size depends on WANT_PAGE_VIRTUAL as well as
> LAST_CPUPID_NOT_IN_PAGE_FLAGS. My plan is here [2].
> 
> [1] https://lore.kernel.org/r/20190905154603.10349-4-aneesh.kumar@linux.ibm.com/
> [2] https://lore.kernel.org/r/Ygl1Gf+ATBuI%2Fm2q@google.com/

OK, thanks.  This is fairly urgent for -next and -rc inclusion.  If
practically nobody is compiling the feature then practically nobody is
testing it.  Let's come up with a way to improves the expected coverage
by a lot.
