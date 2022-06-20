Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB05513B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbiFTJGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbiFTJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:06:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C56C44
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:06:03 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LRNyt0hGjzDsL9;
        Mon, 20 Jun 2022 17:05:26 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 17:05:56 +0800
Subject: Re: [PATCH v2 3/3] mm/swap: remove swap_cache_info statistics
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-4-linmiaohe@huawei.com>
 <87a6a7rc39.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <67653af6-14a7-2017-74e7-88763f223478@huawei.com>
Date:   Mon, 20 Jun 2022 17:05:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87a6a7rc39.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/20 16:08, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> swap_cache_info are not statistics that could be easily used to tune system
>> performance because they are not easily accessile. Also they can't provide
>> really useful info when OOM occurs. Remove these statistics can also help
>> mitigate unneeded global swap_cache_info cacheline contention.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/swap_state.c | 17 -----------------
>>  1 file changed, 17 deletions(-)
>>
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index 0a2021fc55ad..41c6a6053d5c 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -59,24 +59,11 @@ static bool enable_vma_readahead __read_mostly = true;
>>  #define GET_SWAP_RA_VAL(vma)					\
>>  	(atomic_long_read(&(vma)->swap_readahead_info) ? : 4)
>>  
>> -#define INC_CACHE_INFO(x)	data_race(swap_cache_info.x++)
>> -#define ADD_CACHE_INFO(x, nr)	data_race(swap_cache_info.x += (nr))
>> -
>> -static struct {
>> -	unsigned long add_total;
>> -	unsigned long del_total;
>> -	unsigned long find_success;
>> -	unsigned long find_total;
>> -} swap_cache_info;
>> -
>>  static atomic_t swapin_readahead_hits = ATOMIC_INIT(4);
>>  
>>  void show_swap_cache_info(void)
>>  {
>>  	printk("%lu pages in swap cache\n", total_swapcache_pages());
>> -	printk("Swap cache stats: add %lu, delete %lu, find %lu/%lu\n",
>> -		swap_cache_info.add_total, swap_cache_info.del_total,
>> -		swap_cache_info.find_success, swap_cache_info.find_total);
>>  	printk("Free swap  = %ldkB\n",
>>  		get_nr_swap_pages() << (PAGE_SHIFT - 10));
>>  	printk("Total swap = %lukB\n", total_swap_pages << (PAGE_SHIFT - 10));
>> @@ -133,7 +120,6 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
>>  		address_space->nrpages += nr;
>>  		__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, nr);
>>  		__mod_lruvec_page_state(page, NR_SWAPCACHE, nr);
>> -		ADD_CACHE_INFO(add_total, nr);
>>  unlock:
>>  		xas_unlock_irq(&xas);
>>  	} while (xas_nomem(&xas, gfp));
>> @@ -172,7 +158,6 @@ void __delete_from_swap_cache(struct page *page,
>>  	address_space->nrpages -= nr;
>>  	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
>>  	__mod_lruvec_page_state(page, NR_SWAPCACHE, -nr);
>> -	ADD_CACHE_INFO(del_total, nr);
>>  }
>>  
>>  /**
>> @@ -348,12 +333,10 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
>>  	page = find_get_page(swap_address_space(entry), swp_offset(entry));
>>  	put_swap_device(si);
>>  
>> -	INC_CACHE_INFO(find_total);
>>  	if (page) {
>>  		bool vma_ra = swap_use_vma_readahead();
>>  		bool readahead;
>>  
>> -		INC_CACHE_INFO(find_success);
>>  		/*
>>  		 * At the moment, we don't support PG_readahead for anon THP
>>  		 * so let's bail out rather than confusing the readahead stat.
> 
> This looks reasonable.  And if we want to do some statistics for swap
> cache in the future, we can use BPF, that is even more convenient.

BPF should be very convenient. Many thanks for reviewing!

> 
> Acked-by: "Huang, Ying" <ying.huang@intel.com>
> 
> Best Regards,
> Huang, Ying
> 
> .
> 

