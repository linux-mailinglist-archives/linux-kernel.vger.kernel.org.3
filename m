Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D34648AB97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349315AbiAKKlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:41:01 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53328 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiAKKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:41:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 961B11F3BC;
        Tue, 11 Jan 2022 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641897656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8tXeRv7DhsV8A4kgG96JKb+ooN8FGJmMT2qjmnVJdFM=;
        b=tsmznYE2jLMTjgsWybfYPdWV6ZmysS+YpqB7RBHhLr+0hUC3/+gaxQtgZ8T4L321qBItwX
        3zD7HRNDrmMTBQNUvxbqwTw9aUe8lo6q1EjspgaMoWHdD1eBWhZqadcLnbxxvU5sfk+OI0
        10fbxsFKCF/mUkl69ntlaY83Q5G9h5s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DB8A2A3B83;
        Tue, 11 Jan 2022 10:40:55 +0000 (UTC)
Date:   Tue, 11 Jan 2022 11:40:55 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, page-reclaim@google.com,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <Yd1et2VFOX4xxgly@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <YdSuSHa/Vjl6bPkg@google.com>
 <YdgKClGAuHlkzVbQ@dhcp22.suse.cz>
 <YdiKVJlClB3h1Kmg@google.com>
 <YdxTR4+FL08XyFuO@dhcp22.suse.cz>
 <YdythmxHpSksJiXs@google.com>
 <CAJmaN=n=kn9-gC8if5wp8Gfj7uN+QVrX0ex=9JPXC7rPvGf1Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmaN=n=kn9-gC8if5wp8Gfj7uN+QVrX0ex=9JPXC7rPvGf1Qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-01-22 14:46:08, Jesse Barnes wrote:
> > > > 2. There have been none that came with the testing/benchmarking
> > > >    coverage as this one did. Please point me to some if I'm mistaken,
> > > >    and I'll gladly match them.
> > >
> > > I do appreciate your numbers but you should realize that this is an area
> > > that is really hard to get any conclusive testing for.
> >
> > Fully agreed. That's why we started a new initiative, and we hope more
> > people will following these practices:
> > 1. All results in this area should be reported with at least standard
> >    deviations, or preferably confidence intervals.
> > 2. Real applications should be benchmarked (with synthetic load
> >    generator), not just synthetic benchmarks (not real applications).
> > 3. A wide range of devices should be covered, i.e., servers, desktops,
> >    laptops and phones.
> >
> > I'm very confident to say our benchmark reports were hold to the
> > highest standards. We have worked with MariaDB (company), EnterpriseDB
> > (Postgres), Redis (company), etc. on these reports. They have copies
> > of these reports (PDF version):
> > https://linux-mm.googlesource.com/benchmarks/
> >
> > We welcome any expert in those applications to examine our reports,
> > and we'll be happy to run any other benchmarks or same benchmarks with
> > different configurations that anybody thinks it's important and we've
> > missed.
> 
> I really think this gets at the heart of the issue with mm
> development, and is one of the reasons it's been extra frustrating to
> not have an MM conf for the past couple of years; I think sorting out
> how we measure & proceed on changes would be easier done f2f.  E.g.
> concluding with a consensus that if something doesn't regress on X, Y,
> and Z, and has reasonably maintainable and readable code, we should
> merge it and try it out.

I am fully with you on that! I hope we can have LSFMM this year finally.

> But since f2f isn't an option until 2052 at the earliest...

Let's be more optimistic than that ;)

> I understand the desire for an "incremental approach that gets us from
> A->B".  In the abstract it sounds great.  However, with a change like
> this one, I think it's highly likely that such a path would be
> littered with regressions both large and small, and would probably be
> more difficult to reason about than the relatively clean design of
> MGLRU.

There are certainly things that do not make much sense to split up of
course. On the other hand the patchset is making a lot of decisions and
assumptions that are neither documented in the code nor in the
changelog. From my past experience these are really problematic from a
long term maintenance POV. We are struggling with those already because
changelog tend to be much more coarse in the past yet the code stays
with us and we have been really "great" at not touching many of those
because "something might break". This results in the complexity grow and
further maintenance burden.

> On top of that, I don't think we'll get the kind of user
> feedback we need for something like this *without* merging it.  Yu has
> done a tremendous job collecting data here (and the results are really
> incredible), but I think we can all agree that without extensive
> testing in the field with all sorts of weird codes, we're not going to
> find the problematic behaviors we're concerned about.

This is understood.

> So unless we want to eschew big mm changes entirely (we shouldn't!
> look at net or scheduling for how important big rewrites are to
> progress), I think we should be open to experimenting with new stuff.
> We can always revert if things get too unwieldy.

As long as the patchset doesn't include new user visible interfaces
which have proven to be really hard to revert.

> None of this is to say that there may not be lots more comments on the
> code or potential fixes/changes to incorporate before merging; I'm
> mainly arguing about the mindset we should have to changes like this,
> not all the stuff the community is already really good at (i.e.
> testing and reviewing code on a nuts & bolts level).

From my reading of this and previous discussions I have gathered that
there was no opposition just for the sake of it. There have been very
specific questions regarding the implementation and/or future plans to
address issues expressed in the past.

So far I have only managed to check the memcg and oom integration
finding some issues there. All of them should be fixable reasonably
easily but it also points that a deep dive into this is really
necessary.

I have also raised questions about future maintainability of the
resulting code. As you could have noticed the review power in the MM
community is lacking behind and we tend to have more code producers than
reviewers and maintainers.
Not to mention other things like page flags depletion which is something
we have been struggling for quite some time already.

All that being said there is a lot of work for such a large change to be
merged.
-- 
Michal Hocko
SUSE Labs
