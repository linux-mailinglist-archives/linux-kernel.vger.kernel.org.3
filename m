Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C314AD38C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350035AbiBHIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350016AbiBHId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:33:56 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB6CC03FEC8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:33:55 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e79so20112123iof.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TmX+1PYwkEORQCHYHznIK9wXZEnAggXFtHQ61jgwI8E=;
        b=F1DRbLZ5uxQEM/yxdQLb3t9r7nntwgqyLTuAzsF5Opj1M1u0tS8rvS3QBiOxt6abNW
         Dru3VxUXL5P8zLkJHYrLyLjTSg+jkSW87ogwBhszAB7YtQkmq7XAEqmoX3ckUxJNX4or
         3eVOT/ydg/tdlTekdgpRiloO2gHqvA7jZdtGhdTuBnqK5B+fYMXaBFeELwxbSvOBOXxj
         uFnhpX0QuViXN/MXSCHxbdlM95LVyjSkly4vM0970oOe9NpsEmsY4FSo3EtblxON7GtZ
         jnmTqIpwuNdDTCPW07q5jhMglEKQAp1bIcIXenxCimt4w4kJcqIDHmmG5kGIjuupJV5Z
         t4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TmX+1PYwkEORQCHYHznIK9wXZEnAggXFtHQ61jgwI8E=;
        b=0zIO3YxbZrMuAGsedZAVfvxzv7iP5mAPRleDqVpHmmg6xBf0fhEuEubkMmi2ASKFXq
         1JUFVIUHOHNrMMtL1SsXHWr0UNjGaKBu+RJPgMgGcxQBkJAizN2LO0wNwd7NhK3DcwDE
         ZU/nBGFyQRNWhoy6TyEj3qk01ImvUI5SKN0RlGDiLBpLXzhcnZghz+BmzGCwHowuNNzE
         EwllRkTswaQH4sseH01MiHfWT+M9oKvLx9fh5a4oRk4YKt4YhTjaFv1AKQEBuS1c1ET8
         JQZI6Yyr/ObSVoWnS0OIMHu5vyaGuXfMjiNhluEUWKhmSW3EFgMqiRYLNBelAosq8cv2
         B5fw==
X-Gm-Message-State: AOAM532NWwlok2b8SNEVkzuA7oFn2C4NWmvKin1Nc9qRezIoePJ3I5Ht
        tw0tt4fXDLhsVbHAT5CEXoMLtQ==
X-Google-Smtp-Source: ABdhPJyDrXBrTyfm6ERK0nAhlTVpEl6d4xHVrRz2ufYaoKdT+J6LuWshLihhaBirxIcGILBBOKvg7g==
X-Received: by 2002:a05:6638:d4c:: with SMTP id d12mr1560333jak.283.1644309234407;
        Tue, 08 Feb 2022 00:33:54 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
        by smtp.gmail.com with ESMTPSA id r18sm1585519iln.1.2022.02.08.00.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:33:53 -0800 (PST)
Date:   Tue, 8 Feb 2022 01:33:49 -0700
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
Subject: Re: [PATCH v7 05/12] mm: multigenerational LRU: minimal
 implementation
Message-ID: <YgIq7SKqyFKecLS1@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-6-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208081902.3550911-6-yuzhao@google.com>
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

On Tue, Feb 08, 2022 at 01:18:55AM -0700, Yu Zhao wrote:

<snipped>

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 3326ee3903f3..e899623d5df0 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
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
> +
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

Moved Kconfig to this patch as suggested by:
https://lore.kernel.org/linux-mm/Yd6uHYtjGfgqjDpw@dhcp22.suse.cz/

Added two new macros as requested here:
https://lore.kernel.org/linux-mm/87czkyzhfe.fsf@linux.ibm.com/

<snipped>

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d75a5738d1dc..5f0d92838712 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1285,9 +1285,11 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>  
>  	if (PageSwapCache(page)) {
>  		swp_entry_t swap = { .val = page_private(page) };
> -		mem_cgroup_swapout(page, swap);
> +
> +		/* get a shadow entry before mem_cgroup_swapout() clears folio_memcg() */
>  		if (reclaimed && !mapping_exiting(mapping))
>  			shadow = workingset_eviction(page, target_memcg);
> +		mem_cgroup_swapout(page, swap);
>  		__delete_from_swap_cache(page, swap, shadow);
>  		xa_unlock_irq(&mapping->i_pages);
>  		put_swap_page(page, swap);
> @@ -2721,6 +2723,9 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
>  	unsigned long file;
>  	struct lruvec *target_lruvec;
>  
> +	if (lru_gen_enabled())
> +		return;
> +
>  	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
>  
>  	/*
> @@ -3042,15 +3047,47 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
>  
>  #ifdef CONFIG_LRU_GEN
>  
> +enum {
> +	TYPE_ANON,
> +	TYPE_FILE,
> +};

Added two new macros as requested here:
https://lore.kernel.org/linux-mm/87czkyzhfe.fsf@linux.ibm.com/

<snipped>

> +static void age_lruvec(struct lruvec *lruvec, struct scan_control *sc)
> +{
> +	bool need_aging;
> +	long nr_to_scan;
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +	int swappiness = get_swappiness(memcg);
> +	DEFINE_MAX_SEQ(lruvec);
> +	DEFINE_MIN_SEQ(lruvec);
> +
> +	mem_cgroup_calculate_protection(NULL, memcg);
> +
> +	if (mem_cgroup_below_min(memcg))
> +		return;

Added mem_cgroup_calculate_protection() for readability as requested here:
https://lore.kernel.org/linux-mm/Ydf9RXPch5ddg%2FWC@dhcp22.suse.cz/

<snipped>
