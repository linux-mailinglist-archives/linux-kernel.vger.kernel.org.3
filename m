Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878534EA4CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiC2B6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 21:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiC2B6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:58:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD823EC53
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:56:50 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KSCLk5z94zfZyZ;
        Tue, 29 Mar 2022 09:55:10 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 29 Mar 2022 09:56:48 +0800
Subject: Re: [Patch v2 2/2] mm/vmscan: make sure wakeup_kswapd with managed
 zone
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <ying.huang@intel.com>, <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220329010901.1654-1-richard.weiyang@gmail.com>
 <20220329010901.1654-2-richard.weiyang@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <96f0f99a-18fa-a0d1-5214-bcd2f1554b17@huawei.com>
Date:   Tue, 29 Mar 2022 09:56:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220329010901.1654-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/29 9:09, Wei Yang wrote:
> wakeup_kswapd() only wake up kswapd when the zone is managed.
> 
> For two callers of wakeup_kswapd(), they are node perspective.
> 
>   * wake_all_kswapds
>   * numamigrate_isolate_page
> 
> If we picked up a !managed zone, this is not we expected.
> 
> This patch makes sure we pick up a managed zone for wakeup_kswapd(). And
> it also use managed_zone in migrate_balanced_pgdat() to get the proper
> zone.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Looks good to me. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> ---
> v2: adjust the usage in migrate_balanced_pgdat()
> 
> ---
>  mm/migrate.c    | 6 +++---
>  mm/page_alloc.c | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3d60823afd2d..5adc55b5347c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1971,7 +1971,7 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
>  #ifdef CONFIG_NUMA_BALANCING
>  /*
>   * Returns true if this is a safe migration target node for misplaced NUMA
> - * pages. Currently it only checks the watermarks which crude
> + * pages. Currently it only checks the watermarks which is crude.
>   */
>  static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>  				   unsigned long nr_migrate_pages)
> @@ -1981,7 +1981,7 @@ static bool migrate_balanced_pgdat(struct pglist_data *pgdat,
>  	for (z = pgdat->nr_zones - 1; z >= 0; z--) {
>  		struct zone *zone = pgdat->node_zones + z;
>  
> -		if (!populated_zone(zone))
> +		if (!managed_zone(zone))
>  			continue;
>  
>  		/* Avoid waking kswapd by allocating pages_to_migrate pages. */
> @@ -2046,7 +2046,7 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
>  			return 0;
>  		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
> -			if (populated_zone(pgdat->node_zones + z))
> +			if (managed_zone(pgdat->node_zones + z))
>  				break;
>  		}
>  		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4c0c4ef94ba0..6656c2d06e01 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4674,6 +4674,8 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
>  
>  	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zoneidx,
>  					ac->nodemask) {
> +		if (!managed_zone(zone))
> +			continue;
>  		if (last_pgdat != zone->zone_pgdat)
>  			wakeup_kswapd(zone, gfp_mask, order, highest_zoneidx);
>  		last_pgdat = zone->zone_pgdat;
> 

