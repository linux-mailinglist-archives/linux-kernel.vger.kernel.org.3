Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE50755122D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiFTIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiFTIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:08:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0370511174
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655712528; x=1687248528;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=LQztEc1EBzzs8KWwqzXaMQMFrLTcUbledaOBZycBMFo=;
  b=SmIPV+XaKv++k6gohoSsiwye781zg4cMjcEWxkoo8eP6ZeUkyZoLYPC6
   +9blVW4tUDGZh4wLW9rEpw8IKL2kXKXj6XEPeV1cVZOeNcnhbFu3FhAp/
   O3oo4XdJcCNdpP9xfJ5/F8cEpTivAzvIZNvIyZGdq/xxw68Z18nwKJ9aR
   M61wsnzHm+DS7bEqTHn8HbR92zG7RnNImRAVZHRYq61tlxfj203ZbWFpy
   FUrgQwuantRpXJ7xJa6mX3Uk/hg9rubJZIQFl0ycfGXbC1KEnGYZ8cIRW
   6jCCpubslwc5U0I51fpgUtBMhdSaLFUCk3Ybo52tjfsvQjBb0Ledz/XcS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260264856"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260264856"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 01:08:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="833004001"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 01:08:46 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] mm/swap: remove swap_cache_info statistics
References: <20220608144031.829-1-linmiaohe@huawei.com>
        <20220608144031.829-4-linmiaohe@huawei.com>
Date:   Mon, 20 Jun 2022 16:08:42 +0800
In-Reply-To: <20220608144031.829-4-linmiaohe@huawei.com> (Miaohe Lin's message
        of "Wed, 8 Jun 2022 22:40:31 +0800")
Message-ID: <87a6a7rc39.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> swap_cache_info are not statistics that could be easily used to tune system
> performance because they are not easily accessile. Also they can't provide
> really useful info when OOM occurs. Remove these statistics can also help
> mitigate unneeded global swap_cache_info cacheline contention.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swap_state.c | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 0a2021fc55ad..41c6a6053d5c 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -59,24 +59,11 @@ static bool enable_vma_readahead __read_mostly = true;
>  #define GET_SWAP_RA_VAL(vma)					\
>  	(atomic_long_read(&(vma)->swap_readahead_info) ? : 4)
>  
> -#define INC_CACHE_INFO(x)	data_race(swap_cache_info.x++)
> -#define ADD_CACHE_INFO(x, nr)	data_race(swap_cache_info.x += (nr))
> -
> -static struct {
> -	unsigned long add_total;
> -	unsigned long del_total;
> -	unsigned long find_success;
> -	unsigned long find_total;
> -} swap_cache_info;
> -
>  static atomic_t swapin_readahead_hits = ATOMIC_INIT(4);
>  
>  void show_swap_cache_info(void)
>  {
>  	printk("%lu pages in swap cache\n", total_swapcache_pages());
> -	printk("Swap cache stats: add %lu, delete %lu, find %lu/%lu\n",
> -		swap_cache_info.add_total, swap_cache_info.del_total,
> -		swap_cache_info.find_success, swap_cache_info.find_total);
>  	printk("Free swap  = %ldkB\n",
>  		get_nr_swap_pages() << (PAGE_SHIFT - 10));
>  	printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
> @@ -133,7 +120,6 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
>  		address_space->nrpages += nr;
>  		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
>  		__mod_lruvec_page_state(page, NR_SWAPCACHE, nr);
> -		ADD_CACHE_INFO(add_total, nr);
>  unlock:
>  		xas_unlock_irq(&xas);
>  	} while (xas_nomem(&xas, gfp));
> @@ -172,7 +158,6 @@ void __delete_from_swap_cache(struct page *page,
>  	address_space->nrpages -= nr;
>  	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
>  	__mod_lruvec_page_state(page, NR_SWAPCACHE, -nr);
> -	ADD_CACHE_INFO(del_total, nr);
>  }
>  
>  /**
> @@ -348,12 +333,10 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
>  	page = find_get_page(swap_address_space(entry), swp_offset(entry));
>  	put_swap_device(si);
>  
> -	INC_CACHE_INFO(find_total);
>  	if (page) {
>  		bool vma_ra = swap_use_vma_readahead();
>  		bool readahead;
>  
> -		INC_CACHE_INFO(find_success);
>  		/*
>  		 * At the moment, we don't support PG_readahead for anon THP
>  		 * so let's bail out rather than confusing the readahead stat.

This looks reasonable.  And if we want to do some statistics for swap
cache in the future, we can use BPF, that is even more convenient.

Acked-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying
