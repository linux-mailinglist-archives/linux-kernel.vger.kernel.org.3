Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F914B8772
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiBPMUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:20:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiBPMUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:20:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A5D7A99D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:20:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BC8E21763;
        Wed, 16 Feb 2022 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645014016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyH1MNE7egLvg30v1Q1SxaIZhjjprdO4nNoi0o4PKa8=;
        b=WWETuMwuBOenVDtlSZtdg7qqGDzPn0fgx99DAKbozjG8sdmVCsC9+nKEqF1ekBW9CXL6ck
        jVFu3tMu/ZqFbqpvDnxEG8ylT9nWE0P+eAwrpP7klP4oRv489SuoxlM0FO/MtOw9PB/Z9w
        KiyAa7ZlP0fenzWDaIk+B//Uhf2a08Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645014016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyH1MNE7egLvg30v1Q1SxaIZhjjprdO4nNoi0o4PKa8=;
        b=/MZTtvo12He7rxSHhCntTxeZs104nSh/dCL9HlXACuboZpW6uT+Mni5qcjCcgoiX/9wLEA
        e7oI0dYcTfmmwpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BFE413AF3;
        Wed, 16 Feb 2022 12:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lzTZFQDsDGIeSgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 16 Feb 2022 12:20:16 +0000
Message-ID: <fd811d55-f14b-4203-0651-daf56e329d79@suse.cz>
Date:   Wed, 16 Feb 2022 13:20:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/5] mm/page_alloc: Simplify how many pages are selected
 per pcp list during bulk free
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220215145111.27082-1-mgorman@techsingularity.net>
 <20220215145111.27082-4-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220215145111.27082-4-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 15:51, Mel Gorman wrote:
> free_pcppages_bulk() selects pages to free by round-robining between
> lists. Originally this was to evenly shrink pages by migratetype
> but uneven freeing is inevitable due to high pages. Simplify list
> selection by starting with a list that definitely has pages on it in
> free_unref_page_commit() and for drain, it does not matter where draining
> starts as all pages are removed.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Now pindex is passed instead of initialized to 0, but still incremented
first before doing anything with it, which AFAICS is wrong. But that
predates this patch, which itself seems ok, so:

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 34 +++++++++++-----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5110fdeb115..5e8c7cbe7a41 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1447,13 +1447,11 @@ static inline void prefetch_buddy(struct page *page, unsigned int order)
>   * count is the number of pages to free.
>   */
>  static void free_pcppages_bulk(struct zone *zone, int count,
> -					struct per_cpu_pages *pcp)
> +					struct per_cpu_pages *pcp,
> +					int pindex)
>  {
> -	int pindex = 0;
>  	int min_pindex = 0;
>  	int max_pindex = NR_PCP_LISTS - 1;
> -	int batch_free = 0;
> -	int nr_freed = 0;
>  	unsigned int order;
>  	int prefetch_nr = READ_ONCE(pcp->batch);
>  	bool isolated_pageblocks;
> @@ -1467,16 +1465,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	count = min(pcp->count, count);
>  	while (count > 0) {
>  		struct list_head *list;
> +		int nr_pages;
>  
> -		/*
> -		 * Remove pages from lists in a round-robin fashion. A
> -		 * batch_free count is maintained that is incremented when an
> -		 * empty list is encountered.  This is so more pages are freed
> -		 * off fuller lists instead of spinning excessively around empty
> -		 * lists
> -		 */
> +		/* Remove pages from lists in a round-robin fashion. */
>  		do {
> -			batch_free++;
>  			if (++pindex == NR_PCP_LISTS)
>  				pindex = 0;
>  			list = &pcp->lists[pindex];
> @@ -1489,18 +1481,15 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  				min_pindex++;
>  		} while (1);
>  
> -		/* This is the only non-empty list. Free them all. */
> -		if (batch_free >= max_pindex - min_pindex)
> -			batch_free = count;
> -
>  		order = pindex_to_order(pindex);
> +		nr_pages = 1 << order;
>  		BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_WIDTH));
>  		do {
>  			page = list_last_entry(list, struct page, lru);
>  			/* must delete to avoid corrupting pcp list */
>  			list_del(&page->lru);
> -			nr_freed += 1 << order;
> -			count -= 1 << order;
> +			count -= nr_pages;
> +			pcp->count -= nr_pages;
>  
>  			if (bulkfree_pcp_prepare(page))
>  				continue;
> @@ -1524,9 +1513,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  				prefetch_buddy(page, order);
>  				prefetch_nr--;
>  			}
> -		} while (count > 0 && --batch_free && !list_empty(list));
> +		} while (count > 0 && !list_empty(list));
>  	}
> -	pcp->count -= nr_freed;
>  
>  	/*
>  	 * local_lock_irq held so equivalent to spin_lock_irqsave for
> @@ -3095,7 +3083,7 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>  	batch = READ_ONCE(pcp->batch);
>  	to_drain = min(pcp->count, batch);
>  	if (to_drain > 0)
> -		free_pcppages_bulk(zone, to_drain, pcp);
> +		free_pcppages_bulk(zone, to_drain, pcp, 0);
>  	local_unlock_irqrestore(&pagesets.lock, flags);
>  }
>  #endif
> @@ -3116,7 +3104,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>  
>  	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
>  	if (pcp->count)
> -		free_pcppages_bulk(zone, pcp->count, pcp);
> +		free_pcppages_bulk(zone, pcp->count, pcp, 0);
>  
>  	local_unlock_irqrestore(&pagesets.lock, flags);
>  }
> @@ -3397,7 +3385,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
>  	if (pcp->count >= high) {
>  		int batch = READ_ONCE(pcp->batch);
>  
> -		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp);
> +		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp, pindex);
>  	}
>  }
>  

