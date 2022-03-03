Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CF4CC144
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiCCPaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiCCPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:30:33 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36419114FEF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:29:47 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id n185so4133477qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T8thn2mB/ppQpWbyQ7im9TnM2/JxxytI355jY/Bhilk=;
        b=vb2g9+UTXGE9JVUAdFvLQFaK40Fzo/KR/Wyc1iAd70hZcpP4J7qYBRo9ziJ6pTWNpo
         GHqdNARWvNGxXTRVc4scAxB45F+vWsKAXB5VpQz2wIxiXGbLsPP2J9yuiz2Gu7Kcv9CM
         w+LLICGUrWrOW0ZXRHk6I1XCBwEUA3lMhwXPc5vcqyyk5ZL+lwLZ1eV83Qk7lFqdCDEM
         VqPvdRlUkMz1aaBHWmpuylcdNqwmn1oeaDB9IFS2Y8EmNUeT7E8xUZGHoni8kLsxj3Ul
         3xL1pSY+UOYTKRE5FcOo178orvQkcxSIQ6yB8Qo8ld4J+y66PK8LUE8lMnlRu7lji/uY
         JyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T8thn2mB/ppQpWbyQ7im9TnM2/JxxytI355jY/Bhilk=;
        b=PBV0Bswfr9z0sQXhe3Ba8mJTeEVajEa07w7FmFHPmc+5O6pGKPU4sUqjDrjKZJ8e1n
         GpPM+tr7jpl8dFM7aW5BKvG3584TOeDxXBuxsC8WrIQl0zOxXpOweGCpFQnK/Yvn4KBk
         UQzdNW/4LWmgSkoel/rSEm8oTDD6jl+pahynAo+nI+RxXjVOFV6iJ3Iz0r4Uh46jPJGh
         oHzejf6iETioXbcXCXEK4VhVLHPMJUeOgHogKzVEADx0dZjBOMHTcs8f8zI1YKws2p1H
         Csa/5osnke+1LOOO3/kay98lf7fNPslFnjS21nw71XpHTTzlIZnBlxlz5lpHd6ZzNJdu
         cVDA==
X-Gm-Message-State: AOAM5308vhmaV2b1zAXUo+YZlmckItcqM9cPt1tyyoSIk+XWM+AY/X2S
        9T3SCFdUNz62W1QM8qAKrPcwhQ==
X-Google-Smtp-Source: ABdhPJwvEGkm3dghfQ28xfPR4A725Ug3F6RrYEBmX/tBy75H3GfZgPVNvLYLSVgRGJT6mAqdfRNOew==
X-Received: by 2002:ae9:ed55:0:b0:60d:d41c:9e9c with SMTP id c82-20020ae9ed55000000b0060dd41c9e9cmr18783481qkg.276.1646321386184;
        Thu, 03 Mar 2022 07:29:46 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id i3-20020a05620a074300b006630cbe7ec0sm1291038qki.90.2022.03.03.07.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:29:45 -0800 (PST)
Date:   Thu, 3 Mar 2022 10:29:44 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
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
Subject: Re: [PATCH v7 04/12] mm: multigenerational LRU: groundwork
Message-ID: <YiDe6DcLGEfTTKD5@cmpxchg.org>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-5-yuzhao@google.com>
 <YgV4lZXc6+jhUdsR@cmpxchg.org>
 <Ygt1qaQM5YobEZK9@google.com>
 <Ygwg9NXzQ+6U3RON@cmpxchg.org>
 <YhNJ4LVWpmZgLh4I@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhNJ4LVWpmZgLh4I@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On Mon, Feb 21, 2022 at 01:14:24AM -0700, Yu Zhao wrote:
> On Tue, Feb 15, 2022 at 04:53:56PM -0500, Johannes Weiner wrote:
> > On Tue, Feb 15, 2022 at 02:43:05AM -0700, Yu Zhao wrote:
> > > On Thu, Feb 10, 2022 at 03:41:57PM -0500, Johannes Weiner wrote:
> > > > > +static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
> > > > > +{
> > > > > +	unsigned long max_seq = lruvec->lrugen.max_seq;
> > > > > +
> > > > > +	VM_BUG_ON(gen >= MAX_NR_GENS);
> > > > > +
> > > > > +	/* see the comment on MIN_NR_GENS */
> > > > > +	return gen == lru_gen_from_seq(max_seq) || gen == lru_gen_from_seq(max_seq - 1);
> > > > > +}
> > > > 
> > > > I'm still reading the series, so correct me if I'm wrong: the "active"
> > > > set is split into two generations for the sole purpose of the
> > > > second-chance policy for fresh faults, right?
> > > 
> > > To be precise, the active/inactive notion on top of generations is
> > > just for ABI compatibility, e.g., the counters in /proc/vmstat.
> > > Otherwise, this function wouldn't be needed.
> > 
> > Ah! would you mind adding this as a comment to the function?
> 
> Will do.
> 
> > But AFAICS there is the lru_gen_del_folio() callsite that maps it to
> > the PG_active flag - which in turn gets used by add_folio() to place
> > the thing back on the max_seq generation. So I suppose there is a
> > secondary purpose of the function for remembering the page's rough age
> > for non-reclaim isolation.>
> 
> Yes, e.g., migration.

Ok, thanks for clarifying. That should also be in the comment.

On scan resistance:

> > The concern isn't the scan overhead, but jankiness from the workingset
> > being flooded out by streaming IO.
> 
> Yes, MGLRU uses a different approach to solve this problem, and for
> its approach, the scan overhead is the concern.
> 
> MGLRU detects (defines) the working set by scanning the entire memory
> for each generation, and it counters the flooding by accelerating the
> creation of generations. IOW, all mapped pages have an equal chance to
> get scanned, no matter which generation they are in. This is a design
> difference compared with the active/inactive LRU, which tries to scans
> the active/inactive lists less/more frequently.
>
> > The concrete usecase at the time was a torrent client hashing a
> > downloaded file and thereby kicking out the desktop environment, which
> > caused jankiness. The hashing didn't benefit from caching - the file
> > wouldn't have fit into RAM anyway - so this was pointless to boot.
> > 
> > Essentially, the tradeoff is this:
> > 
> > 1) If you treat new pages as hot, you accelerate workingset
> > transitions, but on the flipside you risk unnecessary refaults in
> > running applications when those new pages are one-off.
> > 
> > 2) If you take new pages with a grain of salt, you protect existing
> > applications better from one-off floods, but risk refaults in NEW
> > application while they're trying to start up.
> 
> Agreed.
> 
> > There are two arguments for why 2) is preferable:
> > 
> > 1) Users are tolerant of cache misses when applications first launch,
> >    much less so after they've been running for hours.
> 
> Our CUJs (Critical User Journeys) respectfully disagree :)
> 
> They are built on the observation that once users have moved onto
> another tab/app, they are more likely to stay with the new tab/app
> rather than go back to the old ones. Speaking for myself, this is
> generally the case.

That's in line with what I said. Where is the disagreement?

> > 2) Workingset transitions (and associated jankiness) are bounded by
> >    the amount of RAM you need to repopulate. But streaming IO is
> >    bounded by storage, and datasets are routinely several times the
> >    amount of RAM. Uncacheable sets in excess of RAM can produce an
> >    infinite stream of "new" references; not protecting the workingset
> >    from that means longer or even sustained jankiness.
> 
> I'd argue the opposite -- we shouldn't risk refaulting fresh hot pages
> just to accommodate this concrete yet minor use case, especially
> considering torrent has been given the means (MADV_SEQUENTIAL) to help
> itself.
>
> I appreciate all your points here. The bottom line is we agree this is
> a trade off. For what disagree about, we could be both right -- it
> comes down to what workloads we care about *more*.

It's a straight-forward question: How does MGLRU avoid cache pollution
from scans?

Your answer above seems to be "it just does". Your answer here seems
to be "it doesn't, but it doesn't matter". Forgive me if I'm
misreading what you're saying.

But it's not a minor concern. Read the motivation behind any modern
cache algorithm - ARC, LIRS, Clock-Pro, LRU-K, 2Q - and scan
resistance is the reason for why they all exist in the first place.


    "The LRU-K algorithm surpasses conventional buffering algorithms
     in discriminating between frequently and infrequently referenced
     pages."

        - The LRU-K page replacement algorithm for database disk
          buffering, O'Neil et al, 1993

    "Although LRU replacement policy has been commonly used in the
     buffer cache management, it is well known for its inability to
     cope with access patterns with weak locality."

        - LIRS: an efficient low inter-reference recency set
         replacement policy to improve buffer cache performance,
         Jiang, Zhang, 2002

    "The self-tuning, low-overhead, scan-resistant adaptive
     replacement cache algorithm outperforms the least-recently-used
     algorithm by dynamically responding to changing access patterns
     and continually balancing between workload recency and frequency
     features."

        - Outperforming LRU with an adaptive replacement cache
          algorithm, Megiddo, Modha, 2004

    "Over the last three decades, the inability of LRU as well as
     CLOCK to handle weak locality accesses has become increasingly
     serious, and an effective fix becomes increasingly desirable.

        - CLOCK-Pro: An Effective Improvement of the CLOCK
          Replacement, Jiang et al, 2005


We can't rely on MADV_SEQUENTIAL alone. Not all accesses know in
advance that they'll be one-off; it can be a group of uncoordinated
tasks causing the pattern etc.

This is a pretty fundamental issue. It would be good to get a more
satisfying answer on this.

> > > > You can drop the memcg parameter and use lruvec_memcg().
> > > 
> > > lruvec_memcg() isn't available yet when pgdat_init_internals() calls
> > > this function because mem_cgroup_disabled() is initialized afterward.
> > 
> > Good catch. That'll container_of() into garbage. However, we have to
> > assume that somebody's going to try that simplification again, so we
> > should set up the code now to prevent issues.
> > 
> > cgroup_disable parsing is self-contained, so we can pull it ahead in
> > the init sequence. How about this?
> > 
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 9d05c3ca2d5e..b544d768edc8 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -6464,9 +6464,9 @@ static int __init cgroup_disable(char *str)
> >  			break;
> >  		}
> >  	}
> > -	return 1;
> > +	return 0;
> >  }
> > -__setup("cgroup_disable=", cgroup_disable);
> > +early_param("cgroup_disable", cgroup_disable);
> 
> I think early_param() is still after pgdat_init_internals(), no?

It's called twice for some reason, but AFAICS the first one is always
called before pgdat_init_internals():

start_kernel()
  setup_arch()
    parse_early_param()
    x86_init.paging.pagetable_init();
      paging_init()
        zone_sizes_init()
          free_area_init()
            free_area_init_node()
              free_area_init_core()
                pgdat_init_internals()
  parse_early_param()

It's the same/similar for arm, sparc and mips.
