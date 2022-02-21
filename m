Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04C54BE13A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353340AbiBUKYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:24:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353333AbiBUKX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:23:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21683E5F4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:43:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90CAB1F390;
        Mon, 21 Feb 2022 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645436610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6LwIJ0VytGXZuwsUswyNAc7mSxg7aR+i+fci3dv+24=;
        b=Vyo4LvhNcoc4NFfJpSdgCO5QQYUd32k5m59HD2fn2quVXOwBUjZCbOMQpePjSLUGc4aFyI
        WD6C1pjVFdQ3ia+O4ZUiMizdKWum7Gev0KgZHErQFNo6kl5/6btTHEWwm5Id3swFh/Cks3
        e0PBafErHfrigh4DKYkIh1HHduXdkzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645436610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6LwIJ0VytGXZuwsUswyNAc7mSxg7aR+i+fci3dv+24=;
        b=mtuTDiuoPCSpo0Jxcx9ykNIIeTkZQ3wXduUYp8PSo9Ta6AQhL/BUIWz9C2nSex45NrU4mz
        tojZPCT1W+WZaHDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E94E13A5C;
        Mon, 21 Feb 2022 09:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9glUGsJeE2K+DAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 21 Feb 2022 09:43:30 +0000
Message-ID: <006330a3-8df9-dcd5-8ad6-fc23765a1266@suse.cz>
Date:   Mon, 21 Feb 2022 10:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/1] mm/page_alloc: Do not prefetch buddies during bulk
 free
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20220221094119.15282-1-mgorman@techsingularity.net>
 <20220221094119.15282-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220221094119.15282-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 10:41, Mel Gorman wrote:
> free_pcppages_bulk() has taken two passes through the pcp lists since
> commit 0a5f4e5b4562 ("mm/free_pcppages_bulk: do not hold lock when picking
> pages to free") due to deferring the cost of selecting PCP lists until
> the zone lock is held.
> 
> As the list processing now takes place under the zone lock, it's less
> clear that this will always benefit for two reasons.
> 
> 1. There is a guaranteed cost to calculating the buddy which definitely
>    has to be calculated again. However, as the zone lock is held and
>    there is no deferring of buddy merging, there is no guarantee that the
>    prefetch will have completed when the second buddy calculation takes
>    place and buddies are being merged.  With or without the prefetch, there
>    may be further stalls depending on how many pages get merged. In other
>    words, a stall due to merging is inevitable and at best only one stall
>    might be avoided at the cost of calculating the buddy location twice.
> 
> 2. As the zone lock is held, prefetch_nr makes less sense as once
>    prefetch_nr expires, the cache lines of interest have already been
>    merged.
> 
> The main concern is that there is a definite cost to calculating the
> buddy location early for the prefetch and it is a "maybe win" depending
> on whether the CPU prefetch logic and memory is fast enough. Remove the
> prefetch logic on the basis that reduced instructions in a path is always
> a saving where as the prefetch might save one memory stall depending on
> the CPU and memory.
> 
> In most cases, this has marginal benefit as the calculations are a small
> part of the overall freeing of pages. However, it was detectable on at
> least one machine.
> 
>                               5.17.0-rc3             5.17.0-rc3
>                     mm-highpcplimit-v2r1     mm-noprefetch-v1r1
> Min       elapsed      630.00 (   0.00%)      610.00 (   3.17%)
> Amean     elapsed      639.00 (   0.00%)      623.00 *   2.50%*
> Max       elapsed      660.00 (   0.00%)      660.00 (   0.00%)
> 
> Suggested-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index de9f072d23bd..2d5cc098136d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1432,15 +1432,6 @@ static bool bulkfree_pcp_prepare(struct page *page)
>  }
>  #endif /* CONFIG_DEBUG_VM */
>  
> -static inline void prefetch_buddy(struct page *page, unsigned int order)
> -{
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long buddy_pfn = __find_buddy_pfn(pfn, order);
> -	struct page *buddy = page + (buddy_pfn - pfn);
> -
> -	prefetch(buddy);
> -}
> -
>  /*
>   * Frees a number of pages from the PCP lists
>   * Assumes all pages on list are in same zone.
> @@ -1453,7 +1444,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	int min_pindex = 0;
>  	int max_pindex = NR_PCP_LISTS - 1;
>  	unsigned int order;
> -	int prefetch_nr = READ_ONCE(pcp->batch);
>  	bool isolated_pageblocks;
>  	struct page *page;
>  
> @@ -1508,20 +1498,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			if (bulkfree_pcp_prepare(page))
>  				continue;
>  
> -			/*
> -			 * We are going to put the page back to the global
> -			 * pool, prefetch its buddy to speed up later access
> -			 * under zone->lock. It is believed the overhead of
> -			 * an additional test and calculating buddy_pfn here
> -			 * can be offset by reduced memory latency later. To
> -			 * avoid excessive prefetching due to large count, only
> -			 * prefetch buddy for the first pcp->batch nr of pages.
> -			 */
> -			if (prefetch_nr) {
> -				prefetch_buddy(page, order);
> -				prefetch_nr--;
> -			}
> -
>  			/* MIGRATE_ISOLATE page should not go to pcplists */
>  			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
>  			/* Pageblock could have been isolated meanwhile */

