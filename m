Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE694FCC56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244548AbiDLCSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243942AbiDLCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996B633A1B;
        Mon, 11 Apr 2022 19:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C27F61697;
        Tue, 12 Apr 2022 02:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DBAC385A4;
        Tue, 12 Apr 2022 02:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649729777;
        bh=+vTX2+LmH++7Pu5Shh4Uo4lXVzWdHkKYI41k6YSLJJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v7M7INNLgEZQE6SBiglzE66UBjgkcXhuHBB5+i1GqjY3bnVXvwddo7ZV+t64wV8jW
         rQswAF4M1KJZDWoB+yWTRxmIa8yOkVwrjoqEzbqgpuH20d7tceiFye8aJhHv2U6dXc
         cVYYtMP4kr5qoIrc7sGwiQxWx7FrtUji3t7YTkZY=
Date:   Mon, 11 Apr 2022 19:16:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?ISO-8859-1?Q? "Holger_Hoffst=E4tte" ?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 05/14] mm: multi-gen LRU: groundwork
Message-Id: <20220411191615.a34959bdcc25ef3f9c16a7ce@linux-foundation.org>
In-Reply-To: <20220407031525.2368067-6-yuzhao@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-6-yuzhao@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Apr 2022 21:15:17 -0600 Yu Zhao <yuzhao@google.com> wrote:

> Evictable pages are divided into multiple generations for each lruvec.
> The youngest generation number is stored in lrugen->max_seq for both
> anon and file types as they are aged on an equal footing. The oldest
> generation numbers are stored in lrugen->min_seq[] separately for anon
> and file types as clean file pages can be evicted regardless of swap
> constraints. These three variables are monotonically increasing.
> 
> ...
>
> +static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)

There's a lot of function inlining here.  Fortunately the compiler will
ignore it all, because some of it looks wrong.  Please review (and
remeasure!).  If inlining is reqlly justified, use __always_inline, and
document the reasons for doing so.

> +{
> +	int gen;
> +	unsigned long old_flags, new_flags;
> +
> +	do {
> +		new_flags = old_flags = READ_ONCE(folio->flags);
> +		if (!(new_flags & LRU_GEN_MASK))
> +			return false;
> +
> +		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> +		VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> +
> +		gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> +
> +		new_flags &= ~LRU_GEN_MASK;
> +		/* for shrink_page_list() */
> +		if (reclaiming)
> +			new_flags &= ~(BIT(PG_referenced) | BIT(PG_reclaim));
> +		else if (lru_gen_is_active(lruvec, gen))
> +			new_flags |= BIT(PG_active);
> +	} while (cmpxchg(&folio->flags, old_flags, new_flags) != old_flags);

Clearly the cmpxchg loop is handling races against a concurrent
updater.  But it's unclear who that updater is, what are the dynamics
here and why the designer didn't use, say, spin_lock().  The way to
clarify such thigs is with code comments!

>  
> +#endif /* !__GENERATING_BOUNDS_H */
> +
> +/*
> + * Evictable pages are divided into multiple generations. The youngest and the
> + * oldest generation numbers, max_seq and min_seq, are monotonically increasing.
> + * They form a sliding window of a variable size [MIN_NR_GENS, MAX_NR_GENS]. An
> + * offset within MAX_NR_GENS, gen, indexes the LRU list of the corresponding

The "within MAX_NR_GENS, gen," text here is unclear?

> + * generation. The gen counter in folio->flags stores gen+1 while a page is on
> + * one of lrugen->lists[]. Otherwise it stores 0.
> + *
> + * A page is added to the youngest generation on faulting. The aging needs to
> + * check the accessed bit at least twice before handing this page over to the
> + * eviction. The first check takes care of the accessed bit set on the initial
> + * fault; the second check makes sure this page hasn't been used since then.
> + * This process, AKA second chance, requires a minimum of two generations,
> + * hence MIN_NR_GENS. And to maintain ABI compatibility with the active/inactive

Where is the ABI compatibility issue?  Is it in some way in which the
legacy LRU is presented to userspace?

> + * LRU, these two generations are considered active; the rest of generations, if
> + * they exist, are considered inactive. See lru_gen_is_active(). PG_active is
> + * always cleared while a page is on one of lrugen->lists[] so that the aging
> + * needs not to worry about it. And it's set again when a page considered active
> + * is isolated for non-reclaiming purposes, e.g., migration. See
> + * lru_gen_add_folio() and lru_gen_del_folio().
> + *
> + * MAX_NR_GENS is set to 4 so that the multi-gen LRU can support twice of the

"twice the number of"?
> + * categories of the active/inactive LRU when keeping track of accesses through
> + * page tables. It requires order_base_2(MAX_NR_GENS+1) bits in folio->flags.
> + */

Helpful comment, overall.

> 
> ...
>
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -909,6 +909,14 @@ config ANON_VMA_NAME
>  	  area from being merged with adjacent virtual memory areas due to the
>  	  difference in their name.
>  
> +config LRU_GEN
> +	bool "Multi-Gen LRU"
> +	depends on MMU
> +	# the following options can use up the spare bits in page flags
> +	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
> +	help
> +	  A high performance LRU implementation to overcommit memory.
> +
>  source "mm/damon/Kconfig"

This is a problem.  I had to jump through hoops just to be able to
compile-test this.  Turns out I had to figure out how to disable
MAXSMP.

Can we please figure out a way to ensure that more testers are at least
compile testing this?  Allnoconfig, defconfig, allyesconfig, allmodconfig.

Also, I suggest that we actually make MGLRU the default while in linux-next.

>
> ...
>
