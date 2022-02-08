Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D92F4ADEA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383547AbiBHQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383545AbiBHQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:50:13 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABD5C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:50:11 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id c14so6605363qvl.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uyO1MEQNps5iP9oCUciIE1rzkZYVSZzJb+muZcFYOk4=;
        b=7XADFpc43QE/qt3E2nOE7ZKJdXQmQHBogj8fnQWh7+4WrlwFlcR/DwHHHOuuOsKMzF
         ExPTEWDXBgZBHf+ouoy6HcCW2F1IGloyK+6wcpTxC+goATrzrxIK+324QzKWUnCSZyW8
         Ri2uC4GQ61xus0satGVJWldH+w/uS8/tp2JUDHoz8Amm6FZJ346hIPhYKIGvMs8CY1vi
         w3r2Kt7goS4sWztJwu1Qh+B1FjvqM4sFH2hMgeP1PFxsnwhqL8mu/VjtMUo7FoBWqtRm
         EcgJoePCZR5LmlW/bwoeFY65V8ujtI5jSUJop3tYEbLBYGWyTMcBvlXMlRLxQZ4zEm1T
         CJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uyO1MEQNps5iP9oCUciIE1rzkZYVSZzJb+muZcFYOk4=;
        b=CFo7at3NJYtT/jIUQ+drOZW1wHBxqRIM3Jyi68oUJaba04SCz83W30S9BBagR5/av0
         GA9RRDZ33KGktZndgY4b3W7v9l0Wlwujx5qWFnQAD/zjqkRPeouWlFxxhsPLeLg7Klpm
         g7wNbrz1AIiJD/nMSfK0OWCTMlH7U2T+oxiic0AkVdklAc+0vlZO5hqjuObLZuj87PO7
         f5aHNSO7ubP/xSdx2aIsyFx74ovjlhGeEnFUoZgSs/ZSAZzbKsHUrqT7pME4y5Pkd0FH
         LShuweXgNFxFbPZGF/1jCzcmqmJ2e/UWJCTM4v1d3nKXeg9FZNxy5wbsKlquFP8kcRjq
         rOiA==
X-Gm-Message-State: AOAM530fDCkT0Qn/xN7nKqPRTWiKPJUenrQwji3/FhXVTvJFDf7GZRyd
        zXI5boq31Q5a97b0SWxxQr9BF6mKYy3SRA==
X-Google-Smtp-Source: ABdhPJz+Mim2S0L7J3jzU/RU666khnWwq0OnAnSRMBnKl8t1dS2pUe3shi/y15pML0DetMa4dYFnKQ==
X-Received: by 2002:ad4:5ec9:: with SMTP id jm9mr3851203qvb.15.1644339010896;
        Tue, 08 Feb 2022 08:50:10 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id r7sm7196497qti.69.2022.02.08.08.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 08:50:10 -0800 (PST)
Date:   Tue, 8 Feb 2022 11:50:09 -0500
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
Subject: Re: [PATCH v7 05/12] mm: multigenerational LRU: minimal
 implementation
Message-ID: <YgKfQVKcBebL7pY3@cmpxchg.org>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-6-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208081902.3550911-6-yuzhao@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

Thanks for restructuring this from the last version. It's easier to
learn the new model when you start out with the bare bones, then let
optimizations and self-contained features follow later.

On Tue, Feb 08, 2022 at 01:18:55AM -0700, Yu Zhao wrote:
> To avoid confusions, the terms "promotion" and "demotion" will be
> applied to the multigenerational LRU, as a new convention; the terms
> "activation" and "deactivation" will be applied to the active/inactive
> LRU, as usual.
> 
> The aging produces young generations. Given an lruvec, it increments
> max_seq when max_seq-min_seq+1 approaches MIN_NR_GENS. The aging
> promotes hot pages to the youngest generation when it finds them
> accessed through page tables; the demotion of cold pages happens
> consequently when it increments max_seq. Since the aging is only
> interested in hot pages, its complexity is O(nr_hot_pages). Promotion
> in the aging path doesn't require any LRU list operations, only the
> updates of the gen counter and lrugen->nr_pages[]; demotion, unless
> as the result of the increment of max_seq, requires LRU list
> operations, e.g., lru_deactivate_fn().

I'm having trouble with this changelog. It opens with a footnote and
summarizes certain aspects of the implementation whose importance to
the reader aren't entirely clear at this time.

It would be better to start with a high-level overview of the problem
and how this algorithm solves it. How the reclaim algorithm needs to
find the page that is most suitable for eviction and to signal when
it's time to give up and OOM. Then explain how grouping pages into
multiple generations accomplishes that - in particular compared to the
current two use-once/use-many lists.

Explain the problem of MMU vs syscall references, and how tiering
addresses this.

Explain the significance of refaults and how the algorithm responds to
them. Not in terms of which running averages are updated, but in terms
of user-visible behavior ("will start swapping (more)" etc.)

Express *intent*, how it's supposed to behave wrt workloads and memory
pressure. The code itself will explain the how, its complexity etc.

Most reviewers will understand the fundamental challenges of page
reclaim. The difficulty is matching individual aspects of the problem
space to your individual components and design choices you have made.

Let us in on that thinking, please ;)

> @@ -892,6 +892,50 @@ config ANON_VMA_NAME
>  	  area from being merged with adjacent virtual memory areas due to the
>  	  difference in their name.
>  
> +# multigenerational LRU {
> +config LRU_GEN
> +	bool "Multigenerational LRU"
> +	depends on MMU
> +	# the following options can use up the spare bits in page flags
> +	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
> +	help
> +	  A high performance LRU implementation for memory overcommit. See
> +	  Documentation/admin-guide/mm/multigen_lru.rst and
> +	  Documentation/vm/multigen_lru.rst for details.

These files don't exist at this time, please introduce them before or
when referencing them. If they document things introduced later in the
patchset, please start with a minimal version of the file and update
it as you extend the algorithm and add optimizations etc.

It's really important to only reference previous patches, not later
ones. This allows reviewers to read the patches linearly.  Having to
search for missing pieces in patches you haven't looked at yet is bad.

> +config NR_LRU_GENS
> +	int "Max number of generations"
> +	depends on LRU_GEN
> +	range 4 31
> +	default 4
> +	help
> +	  Do not increase this value unless you plan to use working set
> +	  estimation and proactive reclaim to optimize job scheduling in data
> +	  centers.
> +
> +	  This option uses order_base_2(N+1) bits in page flags.
> +
> +config TIERS_PER_GEN
> +	int "Number of tiers per generation"
> +	depends on LRU_GEN
> +	range 2 4
> +	default 4
> +	help
> +	  Do not decrease this value unless you run out of spare bits in page
> +	  flags, i.e., you see the "Not enough bits in page flags" build error.
> +
> +	  This option uses N-2 bits in page flags.

Linus had pointed out that we shouldn't ask these questions of the
user. How do you pick numbers here? I'm familiar with workingset
estimation and proactive reclaim usecases but I wouldn't know.

Even if we removed the config option and hardcoded the number, this is
a question for kernel developers: What does "4" mean? How would
behavior differ if it were 3 or 5 instead? Presumably there is some
sort of behavior gradient. "As you increase the number of
generations/tiers, the user-visible behavior of the kernel will..."
This should really be documented.

I'd also reiterate Mel's point: Distribution kernels need to support
the full spectrum of applications and production environments. Unless
using non-defaults it's an extremely niche usecase (like compiling out
BUG() calls) compile-time options are not the right choice. If we do
need a tunable, it could make more sense to have a compile time upper
limit (to determine page flag space) combined with a runtime knob?

Thanks!
