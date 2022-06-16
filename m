Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34AC54DBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359465AbiFPHeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359454AbiFPHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:33:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F72831F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:33:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LNv361hD4zSh0Y;
        Thu, 16 Jun 2022 15:30:26 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 15:33:44 +0800
Subject: Re: [PATCH 7/7] mm/khugepaged: try to free transhuge swapcache when
 possible
To:     Zach O'Keefe <zokeefe@google.com>
CC:     <akpm@linux-foundation.org>, <aarcange@redhat.com>,
        <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-8-linmiaohe@huawei.com> <YqoTU7SNM7d3MlNs@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <bec17d69-1002-25c3-d0f5-cc155ca65a67@huawei.com>
Date:   Thu, 16 Jun 2022 15:33:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YqoTU7SNM7d3MlNs@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/16 1:13, Zach O'Keefe wrote:
> On 11 Jun 16:47, Miaohe Lin wrote:
>> Transhuge swapcaches won't be freed in __collapse_huge_page_copy().
>> It's because release_pte_page() is not called for these pages and
>> thus free_page_and_swap_cache can't grab the page lock. These pages
>> won't be freed from swap cache even if we are the only user until
>> next time reclaim. It shouldn't hurt indeed, but we could try to
>> free these pages to save more memory for system.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  include/linux/swap.h | 5 +++++
>>  mm/khugepaged.c      | 1 +
>>  mm/swap.h            | 5 -----
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 8672a7123ccd..ccb83b12b724 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -456,6 +456,7 @@ static inline unsigned long total_swapcache_pages(void)
>>  	return global_node_page_state(NR_SWAPCACHE);
>>  }
>>  
>> +extern void free_swap_cache(struct page *page);
>>  extern void free_page_and_swap_cache(struct page *);
>>  extern void free_pages_and_swap_cache(struct page **, int);
>>  /* linux/mm/swapfile.c */
>> @@ -540,6 +541,10 @@ static inline void put_swap_device(struct swap_info_struct *si)
>>  /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
>>  #define free_swap_and_cache(e) is_pfn_swap_entry(e)
>>  
>> +static inline void free_swap_cache(struct page *page)
>> +{
>> +}
>> +
>>  static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
>>  {
>>  	return 0;
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index ee0a719c8be9..52109ad13f78 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -756,6 +756,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>  	list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
>>  		list_del(&src_page->lru);
>>  		release_pte_page(src_page);
>> +		free_swap_cache(src_page);
>>  	}
>>  }
> 
> Aside: in __collapse_huge_page_isolate() (and also here) why can't we just check
> PageCompound(page) && page == compound_head(page) to only act on compound pages
> once? AFAIK this would alleviate this compound_pagelist business..
> 
> Anyways, as-is, free_page_and_swap_cache() won't be able to do
> try_to_free_swap(), since it can't grab page lock, put it will call put_page().
> I think (?) the last page ref might be dropped in release_pte_page(), so should
> free_swap_cache() come before it?

Thanks for catching this! If page is not in swapcache, the last page ref might be dropped.
So it's bad to call free_swap_cache() after it. Thanks!

> 
>>  
>> diff --git a/mm/swap.h b/mm/swap.h
>> index 0193797b0c92..863f6086c916 100644
>> --- a/mm/swap.h
>> +++ b/mm/swap.h
>> @@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct page *page,
>>  void delete_from_swap_cache(struct page *page);
>>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>>  				  unsigned long end);
>> -void free_swap_cache(struct page *page);
>>  struct page *lookup_swap_cache(swp_entry_t entry,
>>  			       struct vm_area_struct *vma,
>>  			       unsigned long addr);
>> @@ -81,10 +80,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
>>  	return NULL;
>>  }
>>  
>> -static inline void free_swap_cache(struct page *page)
>> -{
>> -}
>> -
>>  static inline void show_swap_cache_info(void)
>>  {
>>  }
>> -- 
>> 2.23.0
>>
>>
> .
> 

