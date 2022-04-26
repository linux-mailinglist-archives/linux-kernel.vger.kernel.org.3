Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497AF510BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355059AbiDZWZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347064AbiDZWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:25:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0601FA60;
        Tue, 26 Apr 2022 15:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 884F5B8219D;
        Tue, 26 Apr 2022 22:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2701C385A4;
        Tue, 26 Apr 2022 22:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651011759;
        bh=lYfUppC7lZmr5zSo7kS0sPDNwx4JInbK68kqdDwnp4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2qNdPSDjZ1dr6qUYrlw2odyTjrXmCOrYFxnBkwScJqQRstVEbT4zCaOdUVfRgdo1U
         GsaUofEarLA66SHZVJNMkOgTrGoiw7n6o7oKbmiYtSCaSAg/Lnjolb6loUTPDzExsv
         XAv5D1nvf7laYuEyO2ulqHwlD07joJA861bR61CM=
Date:   Tue, 26 Apr 2022 15:22:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@rothwell.id.au>,
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
Subject: Re: [PATCH v10 10/14] mm: multi-gen LRU: kill switch
Message-Id: <20220426152237.21d3f173eded69c0f63911f0@linux-foundation.org>
In-Reply-To: <CAOUHufbtFj0Hez7wkw3DHGDwo6wudCzCvACt2GfgrFcubW_DYg@mail.gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-11-yuzhao@google.com>
        <20220411191627.629f21de83cd0a520ef4a142@linux-foundation.org>
        <CAOUHufbtFj0Hez7wkw3DHGDwo6wudCzCvACt2GfgrFcubW_DYg@mail.gmail.com>
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

On Tue, 26 Apr 2022 14:57:15 -0600 Yu Zhao <yuzhao@google.com> wrote:

> On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed,  6 Apr 2022 21:15:22 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > Add /sys/kernel/mm/lru_gen/enabled as a kill switch. Components that
> > > can be disabled include:
> > >   0x0001: the multi-gen LRU core
> > >   0x0002: walking page table, when arch_has_hw_pte_young() returns
> > >           true
> > >   0x0004: clearing the accessed bit in non-leaf PMD entries, when
> > >           CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y
> > >   [yYnN]: apply to all the components above
> > > E.g.,
> > >   echo y >/sys/kernel/mm/lru_gen/enabled
> > >   cat /sys/kernel/mm/lru_gen/enabled
> > >   0x0007
> > >   echo 5 >/sys/kernel/mm/lru_gen/enabled
> > >   cat /sys/kernel/mm/lru_gen/enabled
> > >   0x0005
> >
> > I'm shocked that this actually works.  How does it work?  Existing
> > pages & folios are drained over time or synchrnously?
> 
> Basically we have a double-throw way, and once flipped, new (isolated)
> pages can only be added to the lists of the current implementation.
> Existing pages on the lists of the previous implementation are
> synchronously drained (isolated and then re-added), with
> cond_resched() of course.
> 
> > Supporting
> > structures remain allocated, available for reenablement?
> 
> Correct.
> 
> > Why is it thought necessary to have this?  Is it expected to be
> > permanent?
> 
> This is almost a must for large scale deployments/experiments.
> 
> For deployments, we need to keep fix rollout (high priority) and
> feature enabling (low priority) separate. Rolling out multiple
> binaries works but will make the process slower and more painful. So
> generally for each release, there is only one binary to roll out, and
> unless it's impossible, new features are disabled by default. Once a
> rollout completes, i.e., reaches enough population and remains stable,
> new features are turned on gradually. If something goes wrong with a
> new feature, we turn off that feature rather than roll back the
> kernel.
> 
> Similarly, for A/B experiments, we don't want to use two binaries.

Please let's spell out this sort of high-level thinking in the
changelogging.

From what you're saying, this is a transient thing.  It sounds that
this enablement is only needed when mglru is at an early stage.  Once
it has matured more then successive rollouts will have essentially the
same mglru implementation and being able to disable mglru at runtime
will no longer be required?

I guess the capability is reasonable simple/small and is livable with,
but does it have a long-term future?

I mean, when organizations such as google start adopting the mglru
implementation which is present in Linus's tree we're, what, a year or
more into the future?  Will they still need a kill switch then?
