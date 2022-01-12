Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF7C48C00B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351676AbiALIgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351671AbiALIf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:35:58 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4744AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:35:58 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w9so2507367iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pHnk4u7CVnW4YX08e13GAG2PhlcG7TaAHrFaqBnUaMM=;
        b=gx2Kq4XVtiikSnxRzFDbx0NQVXHhzL0l+bHFfCMP2xlRMkr/vmevVZ8IT/q5b+WYJs
         eaFjydh5vORIST5f+Ac8TvlzBEDdCCJUbjGTHKWRBPXqpZwPPu0sKbs0A1mQ6FwYF6Q0
         +/ZxF5v+AJdoCHnGOPoTn+UHUD2WSAt3sFFWwm9bdBV6VDbMc1hbxQxjkZjNjOE4aoo0
         lDxwgeWu5w+yHW93cC4rtxq3O1Whl/ivLMO/y26cbq2zsMZaiJovijbxl/HvkB9uZwI/
         6jNnGuRao0y5e3EqpY1DMWEnJ2psHyQxJ+BVFKamfMrQHr4gftGqnD1yezMR7w1NnuDa
         Gcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pHnk4u7CVnW4YX08e13GAG2PhlcG7TaAHrFaqBnUaMM=;
        b=TEwN6t3AK/D5nh4Bgf/Wl8qDYxSNAfnMCdhr/x8zekvNrIrkJET6T+oSaD9fLXb6xC
         b0g211jUOQLP6jByt6PDscaet+JUgxa9gOqidVuj9Dpaiv3obMFD+pYImifUO8AFReZ2
         T1g4/ZkUbFMeI92OsoDykP89d+3aHV4F2qYdckCIqlzaWcacKpbFbYzHjrx2kW5ZPvEs
         fWQnGNI4qzDFtsjy4OOnqXNEH/IvpzQ1lB/MDdUBYiGJNsa+/GnDKvWtzA7I1utPBUWq
         24e9RTC2RPpJ/44iokLDVgueboEd+3TIE9a2xNG5WAw+FDeaP00TsoiqmJK3wd1iVLUs
         cw1Q==
X-Gm-Message-State: AOAM532/ho8ZsxIrwVwCuNhyGxF53aATj24XcqRshoqLIPaXYyyrmHnL
        VtVia1Mtoe+shiPG+IxoSoJjnw==
X-Google-Smtp-Source: ABdhPJxZlNJrPU030MfCBCkKKlxLKP0SEloQRCq8kLfrAAW8D7t9fRq/tmsOnP5SuyHHRUX2Od2o2g==
X-Received: by 2002:a05:6638:4192:: with SMTP id az18mr3846460jab.212.1641976557500;
        Wed, 12 Jan 2022 00:35:57 -0800 (PST)
Received: from google.com ([2620:15c:183:200:b6b6:70f4:b540:6383])
        by smtp.gmail.com with ESMTPSA id a1sm7136939iol.55.2022.01.12.00.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:35:56 -0800 (PST)
Date:   Wed, 12 Jan 2022 01:35:52 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 8/9] mm: multigenerational lru: user interface
Message-ID: <Yd6S6Js1W4AnFFmv@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-9-yuzhao@google.com>
 <YdwKB3SfF7hkB9Xv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdwKB3SfF7hkB9Xv@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:27:19PM +0200, Mike Rapoport wrote:
> Hi,
> 
> On Tue, Jan 04, 2022 at 01:22:27PM -0700, Yu Zhao wrote:
> > Add /sys/kernel/mm/lru_gen/enabled as a runtime kill switch.
> > 
> > Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention.
> > Compared with the size-based approach, e.g., [1], this time-based
> > approach has the following advantages:
> > 1) It's easier to configure because it's agnostic to applications and
> >    memory sizes.
> > 2) It's more reliable because it's directly wired to the OOM killer.
> > 
> > Add /sys/kernel/debug/lru_gen for working set estimation and proactive
> > reclaim. Compared with the page table-based approach and the PFN-based
> > approach, e.g., mm/damon/[vp]addr.c, this lruvec-based approach has
> > the following advantages:
> > 1) It offers better choices because it's aware of memcgs, NUMA nodes,
> >    shared mappings and unmapped page cache.
> > 2) It's more scalable because it's O(nr_hot_evictable_pages), whereas
> >    the PFN-based approach is O(nr_total_pages).
> > 
> > Add /sys/kernel/debug/lru_gen_full for debugging.
> > 
> > [1] https://lore.kernel.org/lkml/20211130201652.2218636d@mail.inbox.lv/
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > ---
> >  Documentation/vm/index.rst        |   1 +
> >  Documentation/vm/multigen_lru.rst |  62 +++++
> 
> The description of user visible interfaces should go to
> Documentation/admin-guide/mm
> 
> Documentation/vm/multigen_lru.rst should have contained design description
> and the implementation details and it would be great to actually have such
> document.

Will do, thanks.

> >  include/linux/nodemask.h          |   1 +
> >  mm/vmscan.c                       | 415 ++++++++++++++++++++++++++++++
> >  4 files changed, 479 insertions(+)
> >  create mode 100644 Documentation/vm/multigen_lru.rst
> > 
> > diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> > index 6f5ffef4b716..f25e755b4ff4 100644
> > --- a/Documentation/vm/index.rst
> > +++ b/Documentation/vm/index.rst
> > @@ -38,3 +38,4 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
> >     unevictable-lru
> >     z3fold
> >     zsmalloc
> > +   multigen_lru
> > diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_lru.rst
> > new file mode 100644
> > index 000000000000..6f9e0181348b
> > --- /dev/null
> > +++ b/Documentation/vm/multigen_lru.rst
> > @@ -0,0 +1,62 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=====================
> > +Multigenerational LRU
> > +=====================
> > +
> > +Quick start
> > +===========
> > +Runtime configurations
> > +----------------------
> > +:Required: Write ``1`` to ``/sys/kernel/mm/lru_gen/enable`` if the
> > + feature wasn't enabled by default.
> 
> Required for what? This sentence seem to lack context. Maybe add an
> overview what is Multigenerational LRU so that users will have an idea what
> these knobs control.

Apparently I left an important part of this quick start in the next
patch, where Kconfig options are added. I'm wonder whether I should
squash the next patch into this one.

I always separate Kconfig changes and leave them in the last patch
because it gives me peace of mind knowing it'll never give any auto
bisectors a hard time.

But I saw people not following this practice, and I'm also tempted to
do so. Can anybody remind me whether it's considered a bad practice to
have code changes and Kconfig changes in the same patch?

> > +
> > +Recipes
> > +=======
> 
> Some more context here will be also helpful.

Will do.

> > +Personal computers
> > +------------------
> > +:Thrashing prevention: Write ``N`` to
> > + ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
> > + ``N`` milliseconds from getting evicted. The OOM killer is invoked if
> > + this working set can't be kept in memory. Based on the average human
> > + detectable lag (~100ms), ``N=1000`` usually eliminates intolerable
> > + lags due to thrashing. Larger values like ``N=3000`` make lags less
> > + noticeable at the cost of more OOM kills.
> > +
> > +Data centers
> > +------------
> > +:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
> > + format:
> > + ::
> > +
> > +   memcg  memcg_id  memcg_path
> > +     node  node_id
> > +       min_gen  birth_time  anon_size  file_size
> > +       ...
> > +       max_gen  birth_time  anon_size  file_size
> > +
> > + ``min_gen`` is the oldest generation number and ``max_gen`` is the
> > + youngest generation number. ``birth_time`` is in milliseconds.
> > + ``anon_size`` and ``file_size`` are in pages.
> 
> And what does oldest and youngest generations mean from the user
> perspective?

Good question. Will add more details in the next spin.
