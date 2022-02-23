Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35514C10DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiBWK7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbiBWK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:59:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C711C8BF5E;
        Wed, 23 Feb 2022 02:58:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CBCE617B9;
        Wed, 23 Feb 2022 10:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DEBC340F4;
        Wed, 23 Feb 2022 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645613924;
        bh=fycgXos7ocYwX+GsKmH5ZzLGjwvqgn7YbCBECVBjK74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ydp5TxtbLmb1PQ/ZAjFAs7FEpMXgXw6IlA4dJIZhOyfrjeOvUYUoPgnaX7Miwl3Gr
         Mg0PJNfQmpQ2USPiRhL2TBUDN8/k5VY2D2Y68PD2qIRqzJAoXG33USdGD+l2YTACK7
         /org/XusQ2P+GCSBvXjO8LL13cDQ09pcLBvvP7HXF2j/RMUcHRgB7V2A76JxDmNxLE
         zNl5n4BEamMc4F4NmyhUti1McRFVHc9TTcF12oRMCq57+iqjg4o7O67RtiMyBGr2fo
         TTMAGahBbX3GigGCiFMb1/Y13U3jn5FbgHSQBCSPWbrh9HO1k6cAM4rL3OFqGylfz4
         Sfg8Ghb1meM9g==
Date:   Wed, 23 Feb 2022 12:58:27 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 12/12] mm: multigenerational LRU: documentation
Message-ID: <YhYTU3B7cdwV+YrW@kernel.org>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-13-yuzhao@google.com>
 <Ygou6Gq79XY3mFK7@kernel.org>
 <Ygxt4iR9ZMYEbV78@google.com>
 <YhNVAUM7H7PF7j7j@kernel.org>
 <CAOUHufbZOuXtFvTULArtQjrdrzUkRw71byKQap1Cf=Mm3U7T5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufbZOuXtFvTULArtQjrdrzUkRw71byKQap1Cf=Mm3U7T5g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 06:47:25PM -0700, Yu Zhao wrote:
> On Mon, Feb 21, 2022 at 2:02 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Feb 15, 2022 at 08:22:10PM -0700, Yu Zhao wrote:
> > > > Please consider splitting "enable" and "features" attributes.
> > >
> > > How about s/Features/Components/?
> >
> > I meant to use two attributes:
> >
> > /sys/kernel/mm/lru_gen/enable for the main breaker, and
> > /sys/kernel/mm/lru_gen/features (or components) for the branch breakers
> 
> It's a bit superfluous for my taste. I generally consider multiple
> items to fall into the same category if they can be expressed by a
> type of array, and I usually pack an array into a single file.
> 
> From your last review, I gauged this would be too overloaded for your
> taste. So I'd be happy to make the change if you think two files look
> more intuitive from user's perspective.
 
I do think that two attributes are more user-friendly, but I don't feel
strongly about it.

> > > > As for the descriptions, what is the user-visible effect of these features?
> > > > How different modes of clearing the access bit are reflected in, say, GUI
> > > > responsiveness, database TPS, or probability of OOM?
> > >
> > > These remain to be seen :) I just added these switches in v7, per Mel's
> > > request from the meeting we had. These were never tested in the field.
> >
> > I see :)
> >
> > It would be nice to have a description or/and examples of user-visible
> > effects when there will be some insight on what these features do.
> 
> How does the following sound?
> 
> Clearing the accessed bit in large batches can theoretically cause
> lock contention (mmap_lock), and if it happens the 0x0002 switch can
> disable this feature. In this case the multigenerational LRU suffers a
> minor performance degradation.
> Clearing the accessed bit in non-leaf page table entries was only
> verified on Intel and AMD, and if it causes problems on other x86
> varieties the 0x0004 switch can disable this feature. In this case the
> multigenerational LRU suffers a negligible performance degradation.
 
LGTM

> > > > > +:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
> > > >
> > > > Is debugfs interface relevant only for datacenters?
> > >
> > > For the moment, yes.
> >
> > And what will happen if somebody uses these interfaces outside
> > datacenters? As soon as there is a sysfs intefrace, somebody will surely
> > play with it.
> >
> > I think the job schedulers might be the most important user of that
> > interface, but the documentation should not presume it is the only user.
> 
> Other ideas are more like brainstorming than concrete use cases, e.g.,
> for desktop users, these interface can in theory speed up hibernation
> (suspend to disk); for VM users, they can again in theory support auto
> ballooning. These niches are really minor and less explored compared
> with the data center use cases which have been dominant.
> 
> I was hoping we could focus on the essential and take one step at a
> time. Later on, if there is additional demand and resource, then we
> expand to cover more use cases.

Apparently I was not clear :)

I didn't mean that you should describe other use-cases, I rather suggested
to make the documentation more neutral, e.g. using "a user writes to this
file ..." instead of "job scheduler writes to a file ...". Or maybe add a
sentence in the beginning of the "Data centers" section, for instance:

Data centers
------------

+ A representative example of multigenerational LRU users are job
schedulers.

Data centers want to optimize job scheduling (bin packing) to improve
memory utilizations. Job schedulers need to estimate whether a server


-- 
Sincerely yours,
Mike.
