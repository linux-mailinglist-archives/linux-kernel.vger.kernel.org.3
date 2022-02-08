Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254314AD3A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350237AbiBHIjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350150AbiBHIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:39:33 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1D4C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:39:32 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p63so20158403iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L8z0e4fny5EqPGw8SvPl3dRoqRtOM5UTngWFBuQgHQk=;
        b=nFkxDiGyPNqAuqHFGZrYM9OkswChGFfi/2rsTJZWPBqVhneR4FX5/aD8yQmHseZDKA
         MSr7fYcaHuYxcCUEaWw2A6ljXlmTbWevzF4CPb0uZIGt/c5MBfPEie9i+HJtPSIBhjAE
         xnGsF8RPIiz2lP+T73s9zBsTMwKdjbXi/r1+SZ60IRaicanIO1Sl3WMo53g/UJwmrUIm
         7TxPNnjspVt4j/7JwMv2INfRWhU8EGabXNVjJt8x8O6OLSg5b12B7bFAIu/1iDBZeACd
         3X1DZsd3gGVMv2EXp68yQGSX0ePk0ztUWc/3nD2oa6iyLCjFdbxvWvgsT/tJQcCp8FV3
         9Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L8z0e4fny5EqPGw8SvPl3dRoqRtOM5UTngWFBuQgHQk=;
        b=NPnhL891UvZYR28GuBmTeJzNhI/ichxKTkNdltFpkOPQDcPKYh6vOy7q1gTyUKBUdI
         ADYbpKm968yJfP+EZProWio5Tjx8xMwpv+TSy8A6o6IzxUzW0KRD0bCSP5wZgG3BnR5w
         9IcC5jyojgySwOUZ9FP2FxZU15YEU/6ElMol5vUnA2G+hY5RODe7xqTzM4YKB2r1qh08
         s3LTYqTL1NT83tqnTIBOvb8IWi1Dt4W3XrIFja2tMlei042+vm4MMrX5VnMEqrCGUwCa
         8IIt/cDecjJuuo5OE7JgD12vj72180WszXnGgL+uNZDpRoprLonAUxSHla3HlMEL8KPa
         pMbQ==
X-Gm-Message-State: AOAM530QrEkhhtsAkS5k74OECoOB7VE4com7VbXmpq88rl8X/YzoiRCk
        dK/9rqWNX1l2uL8RCeqIs1LwvA==
X-Google-Smtp-Source: ABdhPJyBbK7ehMBZdLHuV7DbnNODmVCvjijq8ijXQY33cd4K3b4anwZcNGc08jzu3lpwjAKWUaojeA==
X-Received: by 2002:a5e:da01:: with SMTP id x1mr1562524ioj.218.1644309571992;
        Tue, 08 Feb 2022 00:39:31 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
        by smtp.gmail.com with ESMTPSA id s18sm7924009iov.5.2022.02.08.00.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:39:31 -0800 (PST)
Date:   Tue, 8 Feb 2022 01:39:27 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
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
Subject: Re: [PATCH v7 07/12] mm: multigenerational LRU: support page table
 walks
Message-ID: <YgIsPyTImfaWI10k@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-8-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208081902.3550911-8-yuzhao@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 01:18:57AM -0700, Yu Zhao wrote:
> To avoid confusions, the term "iteration" specifically means the
> traversal of an entire mm_struct list; the term "walk" will be applied
> to page tables and the rmap, as usual.
> 
> To further exploit spatial locality, the aging prefers to walk page
> tables to search for young PTEs and promote hot pages. A runtime
> switch will be added in the next patch to enable or disable this
> feature. Without it, the aging relies on the rmap only.

Clarified that page table scanning is optional as requested here:
https://lore.kernel.org/linux-mm/YdxEqFPLDf+wI0xX@dhcp22.suse.cz/

> NB: this feature has nothing similar with the page table scanning in
> the 2.4 kernel [1], which searches page tables for old PTEs, adds cold
> pages to swapcache and unmap them.
> 
> An mm_struct list is maintained for each memcg, and an mm_struct
> follows its owner task to the new memcg when this task is migrated.
> Given an lruvec, the aging iterates lruvec_memcg()->mm_list and calls
> walk_page_range() with each mm_struct on this list to promote hot
> pages before it increments max_seq.
> 
> When multiple page table walkers (threads) iterate the same list, each
> of them gets a unique mm_struct; therefore they can run concurrently.
> Page table walkers ignore any misplaced pages, e.g., if an mm_struct
> was migrated, pages it left in the previous memcg won't be promoted
> when its current memcg is under reclaim. Similarly, page table walkers
> won't promote pages from nodes other than the one under reclaim.

Clarified the interaction between task migration and reclaim as requested here:
https://lore.kernel.org/linux-mm/YdxPEdsfl771Z7IX@dhcp22.suse.cz/

<snipped>

> Server benchmark results:
>   Single workload:
>     fio (buffered I/O): no change
> 
>   Single workload:
>     memcached (anon): +[5.5, 7.5]%
>                 Ops/sec      KB/sec
>       patch1-6: 1015292.83   39490.38
>       patch1-7: 1080856.82   42040.53
> 
>   Configurations:
>     no change
> 
> Client benchmark results:
>   kswapd profiles:
>     patch1-6
>       45.49%  lzo1x_1_do_compress (real work)
>        7.38%  page_vma_mapped_walk
>        7.24%  _raw_spin_unlock_irq
>        2.64%  ptep_clear_flush
>        2.31%  __zram_bvec_write
>        2.13%  do_raw_spin_lock
>        2.09%  lru_gen_look_around
>        1.89%  free_unref_page_list
>        1.85%  memmove
>        1.74%  obj_malloc
> 
>     patch1-7
>       47.73%  lzo1x_1_do_compress (real work)
>        6.84%  page_vma_mapped_walk
>        6.14%  _raw_spin_unlock_irq
>        2.86%  walk_pte_range
>        2.79%  ptep_clear_flush
>        2.24%  __zram_bvec_write
>        2.10%  do_raw_spin_lock
>        1.94%  free_unref_page_list
>        1.80%  memmove
>        1.75%  obj_malloc
> 
>   Configurations:
>     no change

Added benchmark results to show the difference between page table
scanning and no page table scanning, as requested here:
https://lore.kernel.org/linux-mm/Ye6xS6xUD1SORdHJ@dhcp22.suse.cz/

<snipped>

> +static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_mm_walk *walk)
> +{
> +	static const struct mm_walk_ops mm_walk_ops = {
> +		.test_walk = should_skip_vma,
> +		.p4d_entry = walk_pud_range,
> +	};
> +
> +	int err;
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +
> +	walk->next_addr = FIRST_USER_ADDRESS;
> +
> +	do {
> +		err = -EBUSY;
> +
> +		/* folio_update_gen() requires stable folio_memcg() */
> +		if (!mem_cgroup_trylock_pages(memcg))
> +			break;

Added a comment on the stable folio_memcg() requirement as requested
here:
https://lore.kernel.org/linux-mm/Yd6q0QdLVTS53vu4@dhcp22.suse.cz/

<snipped>

> +static struct lru_gen_mm_walk *alloc_mm_walk(void)
> +{
> +	if (current->reclaim_state && current->reclaim_state->mm_walk)
> +		return current->reclaim_state->mm_walk;
> +
> +	return kzalloc(sizeof(struct lru_gen_mm_walk),
> +		       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
> +}

Replaced kvzalloc() with kzalloc() as requested here:
https://lore.kernel.org/linux-mm/Yd6tafG3CS7BoRYn@dhcp22.suse.cz/

Replaced GFP_KERNEL with __GFP_HIGH|__GFP_NOMEMALLOC|__GFP_NOWARN as
requested here:
https://lore.kernel.org/linux-mm/YefddYm8FAfJalNa@dhcp22.suse.cz/

<snipped>
