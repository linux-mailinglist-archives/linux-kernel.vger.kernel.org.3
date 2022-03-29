Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618A34EA4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiC2CHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiC2CHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:07:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2B42E9CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648519526; x=1680055526;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=CD43qK+AfcCULQ1+tD6UAMseC0SXJNBZ8tTh+WUghbQ=;
  b=JZEMUtzoSgzyHhypl2TpY++t+he6Mylqo5lJJZdsy/9ET04zQzXE3BbE
   HyAPzcnaAsne1of27NjJDD7FYlxCrOeczXYnOed+9RVKm6BXuqLZ99iWW
   imDE/p5EO4CPdZpBnJ3IGOfDl6dAY/MgjLBRTLxdpB9lDnFcXWnzMlyeX
   y5DDMFX3W9E4aQq7MMQG097iNmp73GiJRCGX1gsaAGzdm2+Y4GdkTpRy5
   4ZowmQR2zyCoqkf9zhc0RgsGQ4aA/BJ3hGIqgD8xPkxr4nDfL5aBy5dba
   C70lQJ2LELfPOQXONinUtO07WU3M/Pc7LhSQJJIOZJmQb3X5YZU8j7g47
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="257970485"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="257970485"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:05:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564196031"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:05:22 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net
Subject: Re: [PATCH 2/2] mm/vmscan: make sure wakeup_kswapd with managed zone
References: <20220327024101.10378-1-richard.weiyang@gmail.com>
        <20220327024101.10378-2-richard.weiyang@gmail.com>
        <8735j2opd9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20220329004146.2xdswvrm2qu7f47x@master>
        <875ynxh9lg.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20220329015230.hneciyfxoxtvfytl@master>
Date:   Tue, 29 Mar 2022 10:05:20 +0800
In-Reply-To: <20220329015230.hneciyfxoxtvfytl@master> (Wei Yang's message of
        "Tue, 29 Mar 2022 01:52:30 +0000")
Message-ID: <871qylfr8f.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yang <richard.weiyang@gmail.com> writes:

> On Tue, Mar 29, 2022 at 08:43:23AM +0800, Huang, Ying wrote:
> [...]
>>>>> --- a/mm/migrate.c
>>>>> +++ b/mm/migrate.c
>>>>> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>>>>>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>>>>>  			return 0;
>>>>>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>>>>> -			if (populated_zone(pgdat->node_zones + z))
>>>>> +			if (managed_zone(pgdat->node_zones + z))
>>>>
>>>>This looks good to me!  Thanks!  It seems that we can replace
>>>>populated_zone() in migrate_balanced_pgdat() too.  Right?
>>>>
>>>
>>> Yes, you are right. I didn't spot this.
>>>
>>> While this patch comes from the clue of wakeup_kswapd(), I am not sure it is
>>> nice to put it in this patch together.
>>>
>>> Which way you prefer to include this: merge the change into this one, or a
>>> separate one?
>>
>>Either is OK for me.
>>
>
> After reading the code, I am willing to do a little simplification. Does this
> look good to you?
>
> From 85c8a5cd708ada3e9f5b0409413407b7be1bc446 Mon Sep 17 00:00:00 2001
> From: Wei Yang <richard.weiyang@gmail.com>
> Date: Tue, 29 Mar 2022 09:24:36 +0800
> Subject: [PATCH] mm/migrate.c: return valid zone for wakeup_kswapd from
>  migrate_balanced_pgdat()
>
> To wakeup kswapd, we need to iterate pgdat->node_zones and get the
> proper zone. While this work has already been done in
> migrate_balanced_pgdat().
>
> Let's return the valid zone directly instead of do the iteration again.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/migrate.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5adc55b5347c..b086bd781956 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1973,7 +1973,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
>   * Returns true if this is a safe migration target node for misplaced NUMA
>   * pages. Currently it only checks the watermarks which is crude.
>   */
> -static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
> +static struct zone *migrate_balanced_pgdat(struct pglist_data *pgdat,
>  				   unsigned long nr_migrate_pages)
>  {
>  	int z;
> @@ -1985,14 +1985,13 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>  			continue;
>  
>  		/* Avoid waking kswapd by allocating pages_to_migrate pages. */
> -		if (!zone_watermark_ok(zone, 0,
> +		if (zone_watermark_ok(zone, 0,
>  				       high_wmark_pages(zone) +
>  				       nr_migrate_pages,
>  				       ZONE_MOVABLE, 0))
> -			continue;
> -		return true;
> +			return zone;
>  	}
> -	return false;
> +	return NULL;
>  }
>  
>  static struct page *alloc_misplaced_dst_page(struct page *page,
> @@ -2032,6 +2031,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  	int page_lru;
>  	int nr_pages = thp_nr_pages(page);
>  	int order = compound_order(page);
> +	struct zone *zone;
>  
>  	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>  
> @@ -2040,16 +2040,11 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  		return 0;
>  
>  	/* Avoid migrating to a node that is nearly full */
> -	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
> -		int z;
> -
> +	if ((zone = migrate_balanced_pgdat(pgdat, nr_pages))) {

I think that this reverses the original semantics.  Originally, we give
up and wake up kswapd if there's no enough free pages on the target
node.  But now, you give up and wake up if there's enough free pages.

Best Regards,
Huang, Ying

>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>  			return 0;
> -		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
> -			if (managed_zone(pgdat->node_zones + z))
> -				break;
> -		}
> -		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
> +
> +		wakeup_kswapd(zone, 0, order, ZONE_MOVABLE);
>  		return 0;
>  	}
>  
> -- 
>
> 2.33.1
