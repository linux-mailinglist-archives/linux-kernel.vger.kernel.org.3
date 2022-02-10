Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98AA4B0395
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiBJCxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:53:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiBJCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:53:42 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE61125DE5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:53:43 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id f13so3323441ilq.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 18:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=02AWBuLGOKzuO/3AWRL6F5OKKIT88gnKBJ88rLS3Q5c=;
        b=CAoj+qpavcGevLlpNh+qcVIfWEfwcXDkYPEAx5BOrK89vKypxjxQRLKyh/6xJvDViX
         mVN1CVcxNGTLP5YJpokCbFcaz8DpyVPe3tQHhg4TgRM6wb4yx1FDAoB6T2tgrPOXiskX
         RSIFS/nBOd5mFD8a+YLouMfTxFhXt0Qe23iMnEzms0mYz2jGD/B8uDYMudEh9KMunSj1
         eSHhHjLlp9VfnGVlWQzRUjlEIFSoT3E9/68cXa3aKOqEtKxhAX1VOCJzYkXDlCQTLVPd
         bqkLFX3s8W+0r489fx1fwwrjD5pStmOMDhBcRANMRA+eZ6cBKsaXQcwkdfYUi5k7Z7d3
         kwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=02AWBuLGOKzuO/3AWRL6F5OKKIT88gnKBJ88rLS3Q5c=;
        b=krsJhIZLqU+sXnkT+DKdfP5GipJPgodCTUznwCg9YD7KXMIaGVfxJsheab/8cWWU6I
         RmgKggzmz6MyVKwty/P7Kd8OaXhaQbR8qP6yai8tSZWJaRKMrCtRxbwvtuLquuu0QCH0
         IVzPTqDncEce0ZLdaRZHPr4Cq4s3u7PApFCPcpl0ycn0hsk6eAVO2Q9+rUZ+BVQk3Zv8
         uQcUeBnmKP/E4eicHpGQPktRlemns7Dea90KyKD2p0EFaO7JD2qt1XkfMcICfK+cIOKm
         pX/F2If/BQrZR6LNHSYto1HOztcPvIFGtX8l40FPm2gRbKd2Nm5buyxRD1tp1fUEYLrD
         sHsQ==
X-Gm-Message-State: AOAM530iyB8XJk7Ea8LfeVLsgs/xvldTWp7UerLGsQ9aRIGaUgFbdG0G
        KAmPoz1dxRBjtQdWR8kuz6NRbg==
X-Google-Smtp-Source: ABdhPJxN76sol94sGrXIwyJukfPmPPrpjKCZDatx0OHsW2ZL5QRGOM4AtA0sGQWprYjd1omddFfeFQ==
X-Received: by 2002:a05:6e02:1d90:: with SMTP id h16mr2623971ila.202.1644461622739;
        Wed, 09 Feb 2022 18:53:42 -0800 (PST)
Received: from google.com ([2620:15c:183:200:1792:6c19:6193:97c1])
        by smtp.gmail.com with ESMTPSA id v4sm7477338ilc.21.2022.02.09.18.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:53:42 -0800 (PST)
Date:   Wed, 9 Feb 2022 19:53:37 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
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
Subject: Re: [PATCH v7 05/12] mm: multigenerational LRU: minimal
 implementation
Message-ID: <YgR+MfXjpg82QyBT@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-6-yuzhao@google.com>
 <YgKfQVKcBebL7pY3@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgKfQVKcBebL7pY3@cmpxchg.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 11:50:09AM -0500, Johannes Weiner wrote:

<snipped>

> On Tue, Feb 08, 2022 at 01:18:55AM -0700, Yu Zhao wrote:
> > To avoid confusions, the terms "promotion" and "demotion" will be
> > applied to the multigenerational LRU, as a new convention; the terms
> > "activation" and "deactivation" will be applied to the active/inactive
> > LRU, as usual.
> > 
> > The aging produces young generations. Given an lruvec, it increments
> > max_seq when max_seq-min_seq+1 approaches MIN_NR_GENS. The aging
> > promotes hot pages to the youngest generation when it finds them
> > accessed through page tables; the demotion of cold pages happens
> > consequently when it increments max_seq. Since the aging is only
> > interested in hot pages, its complexity is O(nr_hot_pages). Promotion
> > in the aging path doesn't require any LRU list operations, only the
> > updates of the gen counter and lrugen->nr_pages[]; demotion, unless
> > as the result of the increment of max_seq, requires LRU list
> > operations, e.g., lru_deactivate_fn().
> 
> I'm having trouble with this changelog. It opens with a footnote and
> summarizes certain aspects of the implementation whose importance to
> the reader aren't entirely clear at this time.
> 
> It would be better to start with a high-level overview of the problem
> and how this algorithm solves it. How the reclaim algorithm needs to
> find the page that is most suitable for eviction and to signal when
> it's time to give up and OOM. Then explain how grouping pages into
> multiple generations accomplishes that - in particular compared to the
> current two use-once/use-many lists.

Hi Johannes,

Thanks for reviewing!

I suspect the information you are looking for might have been in the
patchset but is scattered in a few places. Could you please glance at
the following pieces and let me know
  1. whether they cover some of the points you asked for
  2. and if so, whether there is a better order/place to present them?

The previous patch has a quick view on the architecture:
https://lore.kernel.org/linux-mm/20220208081902.3550911-5-yuzhao@google.com/

  Evictable pages are divided into multiple generations for each lruvec.
  The youngest generation number is stored in lrugen->max_seq for both
  anon and file types as they're aged on an equal footing. The oldest
  generation numbers are stored in lrugen->min_seq[] separately for anon
  and file types as clean file pages can be evicted regardless of swap
  constraints. These three variables are monotonically increasing.
  
  Generation numbers are truncated into order_base_2(MAX_NR_GENS+1) bits
  in order to fit into the gen counter in folio->flags. Each truncated
  generation number is an index to lrugen->lists[]. The sliding window
  technique is used to track at least MIN_NR_GENS and at most
  MAX_NR_GENS generations. The gen counter stores (seq%MAX_NR_GENS)+1
  while a page is on one of lrugen->lists[]. Otherwise it stores 0.
  
  There are two conceptually independent processes (as in the
  manufacturing process): "the aging", which produces young generations,
  and "the eviction", which consumes old generations. They form a
  closed-loop system, i.e., "the page reclaim". Both processes can be
  invoked from userspace for the purposes of working set estimation and
  proactive reclaim. These features are required to optimize job
  scheduling (bin packing) in data centers. The variable size of the
  sliding window is designed for such use cases...

And the design doc contains a bit more details, and I'd be happy to
present it earlier, if you think doing so would help.
https://lore.kernel.org/linux-mm/20220208081902.3550911-13-yuzhao@google.com/

> Explain the problem of MMU vs syscall references, and how tiering
> addresses this.

The previous patch also touched on this point:
https://lore.kernel.org/linux-mm/20220208081902.3550911-5-yuzhao@google.com/

  The protection of hot pages and the selection of cold pages are based
  on page access channels and patterns. There are two access channels:
  one through page tables and the other through file descriptors. The
  protection of the former channel is by design stronger because:
  1) The uncertainty in determining the access patterns of the former
     channel is higher due to the approximation of the accessed bit.
  2) The cost of evicting the former channel is higher due to the TLB
     flushes required and the likelihood of encountering the dirty bit.
  3) The penalty of underprotecting the former channel is higher because
     applications usually don't prepare themselves for major page faults
     like they do for blocked I/O. E.g., GUI applications commonly use
     dedicated I/O threads to avoid blocking the rendering threads.
  There are also two access patterns: one with temporal locality and the
  other without. For the reasons listed above, the former channel is
  assumed to follow the former pattern unless VM_SEQ_READ or
  VM_RAND_READ is present, and the latter channel is assumed to follow
  the latter pattern unless outlying refaults have been observed.

> Explain the significance of refaults and how the algorithm responds to
> them. Not in terms of which running averages are updated, but in terms
> of user-visible behavior ("will start swapping (more)" etc.)

And this patch touched on how tiers would help:
  1) It removes the cost of activation in the buffered access path by
     inferring whether pages accessed multiple times through file
     descriptors are statistically hot and thus worth promoting in the
     eviction path.
  2) It takes pages accessed through page tables into account and avoids
     overprotecting pages accessed multiple times through file
     descriptors. (Pages accessed through page tables are in the first
     tier since N=0.)
  3) More tiers provide better protection for pages accessed more than
     twice through file descriptors, when under heavy buffered I/O
     workloads.

And the design doc:
https://lore.kernel.org/linux-mm/20220208081902.3550911-13-yuzhao@google.com/

  To select a type and a tier to evict from, it first compares min_seq[]
  to select the older type. If they are equal, it selects the type whose
  first tier has a lower refault percentage. The first tier contains
  single-use unmapped clean pages, which are the best bet.

> Express *intent*, how it's supposed to behave wrt workloads and memory
> pressure. The code itself will explain the how, its complexity etc.

Hmm... This part I'm not so sure. It seems to me this is equivalent to
describing how it works.

> Most reviewers will understand the fundamental challenges of page
> reclaim. The difficulty is matching individual aspects of the problem
> space to your individual components and design choices you have made.
> 
> Let us in on that thinking, please ;)

Agreed. I'm sure I haven't covered everything. So I'm trying to figure
out what's important but missing/insufficient.

> > @@ -892,6 +892,50 @@ config ANON_VMA_NAME
> >  	  area from being merged with adjacent virtual memory areas due to the
> >  	  difference in their name.
> >  
> > +# multigenerational LRU {
> > +config LRU_GEN
> > +	bool "Multigenerational LRU"
> > +	depends on MMU
> > +	# the following options can use up the spare bits in page flags
> > +	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
> > +	help
> > +	  A high performance LRU implementation for memory overcommit. See
> > +	  Documentation/admin-guide/mm/multigen_lru.rst and
> > +	  Documentation/vm/multigen_lru.rst for details.
> 
> These files don't exist at this time, please introduce them before or
> when referencing them. If they document things introduced later in the
> patchset, please start with a minimal version of the file and update
> it as you extend the algorithm and add optimizations etc.
> 
> It's really important to only reference previous patches, not later
> ones. This allows reviewers to read the patches linearly.  Having to
> search for missing pieces in patches you haven't looked at yet is bad.

Okay, will remove this bit from this patch.

> > +config NR_LRU_GENS
> > +	int "Max number of generations"
> > +	depends on LRU_GEN
> > +	range 4 31
> > +	default 4
> > +	help
> > +	  Do not increase this value unless you plan to use working set
> > +	  estimation and proactive reclaim to optimize job scheduling in data
> > +	  centers.
> > +
> > +	  This option uses order_base_2(N+1) bits in page flags.
> > +
> > +config TIERS_PER_GEN
> > +	int "Number of tiers per generation"
> > +	depends on LRU_GEN
> > +	range 2 4
> > +	default 4
> > +	help
> > +	  Do not decrease this value unless you run out of spare bits in page
> > +	  flags, i.e., you see the "Not enough bits in page flags" build error.
> > +
> > +	  This option uses N-2 bits in page flags.
> 
> Linus had pointed out that we shouldn't ask these questions of the
> user. How do you pick numbers here? I'm familiar with workingset
> estimation and proactive reclaim usecases but I wouldn't know.
> 
> Even if we removed the config option and hardcoded the number, this is
> a question for kernel developers: What does "4" mean? How would
> behavior differ if it were 3 or 5 instead? Presumably there is some
> sort of behavior gradient. "As you increase the number of
> generations/tiers, the user-visible behavior of the kernel will..."
> This should really be documented.
> 
> I'd also reiterate Mel's point: Distribution kernels need to support
> the full spectrum of applications and production environments. Unless
> using non-defaults it's an extremely niche usecase (like compiling out
> BUG() calls) compile-time options are not the right choice. If we do
> need a tunable, it could make more sense to have a compile time upper
> limit (to determine page flag space) combined with a runtime knob?

I agree, and I think only time can answer all theses questions :)

This effort is not in the final stage but at very its beginning. More
experiments and wilder adoption are required to see how it's going to
evolve or where it leads. For now, there is just no way to tell whether
those values make sense for the majority or we need the runtime knobs.

These are valid concerns, but TBH, I think they are minor ones because
most users need not to worry about them -- this patchset has been used
in several downstream kernels and I haven't heard any complaints about
those options/values:
https://lore.kernel.org/linux-mm/20220208081902.3550911-1-yuzhao@google.com/

1. Android ARCVM
2. Arch Linux Zen
3. Chrome OS
4. Liquorix
5. post-factum
6. XanMod

Then why do we need these options? Because there are always exceptions,
as stated in the descriptions of those options. Sometimes we just can't
decide everything for users -- the answers lie in their use cases. The
bottom line is, if this starts bothering people or gets in somebody's
way, I'd be glad to revisit. Fair enough?

Thanks!
