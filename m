Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0B1503399
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356569AbiDOXer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356578AbiDOXem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:34:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA07246D;
        Fri, 15 Apr 2022 16:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Maymh2MrV1jISeToWbYmaZRo07zKhpb63QtPmZTv7xg=; b=e6NCa/1p/FL935pR/uKS7VVL9i
        NxQnlxKWSJ+Ta17K4gYFWJzNJxaihd8RTbIG62Xl/cDePuFPsB30gWB0IcujU2gd2gfIoljv8kQWO
        a4vkc0OuVSydPevgNNt6rL2VgEbG29LDZ1FfJZ57cwqVmS5EKHamBYm8UIT3i5D8R9KlKtcVG+ble
        STvluOBWwYBbjHwrFiqkAnABEhloL7s/LtsDqOchuG+G1mM7EccYDiMhrFJe8oDuHSMfsmaQ8X2ZO
        ulDAhPZJC0uuEEiyM3RkXZI1CV+mIrNhruJHvBcWrbnL/74JsnfYmPNwQUGQEobNYpz1o7MRUgG+O
        UT4DzE+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfVP8-00Gbuq-8e; Fri, 15 Apr 2022 23:31:06 +0000
Date:   Sat, 16 Apr 2022 00:31:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Justin Forbes <jforbes@fedoraproject.org>,
        Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Mel Gorman <mgorman@suse.de>,
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
        the arch/x86 maintainers <x86@kernel.org>,
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
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [page-reclaim] Re: [PATCH v10 08/14] mm: multi-gen LRU: support
 page table walks
Message-ID: <YloAOrA6+8Yov57h@casper.infradead.org>
References: <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
 <20220414185654.e7150bcbe859e0dd4b9c61af@linux-foundation.org>
 <CAOUHufYy6yQS9ARN9C5+ODkopR+ez4TH3hZNZo4HtNHBExS1mA@mail.gmail.com>
 <20220415121521.764a88dda55ae8c676ad26b0@linux-foundation.org>
 <CAOUHufYsjwMGMFCfYoh79rFZqwqS1jDihcBS9sHd-gBxEAD3Ug@mail.gmail.com>
 <20220415143220.cc37b0b0a368ed2bf2a821f8@linux-foundation.org>
 <CAHk-=whvkRTVBhAamt0kYyp925jk_+g7T0CyPke_FbCWGQ1VvA@mail.gmail.com>
 <CAOUHufZ4KrjFTYH8wtwMGd9AriZfZtO4GhbiK1SuNbY31VTT9w@mail.gmail.com>
 <CAHk-=whneDk3Jde3J+O-fD32VjaK+fDf9+P6jgDtr2qyo0iu2w@mail.gmail.com>
 <CAJmaN=mJKAhRjDHbsLrqyK_uvuysx596jEcTwV2fwx4UOe4oow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmaN=mJKAhRjDHbsLrqyK_uvuysx596jEcTwV2fwx4UOe4oow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 04:24:14PM -0700, Jesse Barnes wrote:
> On Fri, Apr 15, 2022 at 4:04 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > And for ordinary users, a WARN_ON_ONCE() is about a million times
> > better, becasue:
> >
> >  - the machine will hopefully continue working, so they can report the warning
> >
> >  - even when they don't notice them, distros tend to have automated
> > reporting infrastructure
> >
> > That's why I absolutely *DETEST* those stupid BUG_ON() cases - they
> > will often kill the machine with nasty locks held, resulting in a
> > completely undebuggable thing that never gets reported.
> >
> > Yes, you can be careful and only put BUG_ON() in places where recovery
> > is possible. But even then, they have no actual _advantages_ over just
> > a WARN_ON_ONCE.
> 
> Generally agreed, and not to belabor this relatively small issue, but in some
> environments like cloud or managed client deployments, a crash can actually
> be preferable so we can get a dump, reboot the machine, and get things going
> again for the application or user, then debug offline.  So having the
> flexibility to
> do that in those situations is helpful.  And there, a full crash dump is better
> than just a log report with the WARN info, since debugging may be easier with
> all the kernel memory.

But for those situations, don't you set panic_on_warn anyway?
