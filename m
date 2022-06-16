Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A754DC11
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359219AbiFPHmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiFPHml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:42:41 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9092AD9F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:42:36 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNvGn6nw4z1KB5p;
        Thu, 16 Jun 2022 15:40:33 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 15:42:31 +0800
Subject: Re: [PATCH 7/7] mm/khugepaged: try to free transhuge swapcache when
 possible
To:     Yang Shi <shy828301@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-8-linmiaohe@huawei.com>
 <CAHbLzkoYkN+QzdfSUkHbLMUYX=zkrgGCrqM6xRaVssFSJh9KqA@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <87617483-7945-30e2-471e-578da4f4d9c7@huawei.com>
Date:   Thu, 16 Jun 2022 15:42:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkoYkN+QzdfSUkHbLMUYX=zkrgGCrqM6xRaVssFSJh9KqA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/6/16 7:58, Yang Shi wrote:
> On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> Transhuge swapcaches won't be freed in __collapse_huge_page_copy().
>> It's because release_pte_page() is not called for these pages and
>> thus free_page_and_swap_cache can't grab the page lock. These pages
>> won't be freed from swap cache even if we are the only user until
>> next time reclaim. It shouldn't hurt indeed, but we could try to
>> free these pages to save more memory for system.
> 
> 
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
>>         return global_node_page_state(NR_SWAPCACHE);
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
>>         return 0;
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index ee0a719c8be9..52109ad13f78 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -756,6 +756,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>         list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
>>                 list_del(&src_page->lru);
>>                 release_pte_page(src_page);
>> +               free_swap_cache(src_page);
> 
> Will this really work? The free_swap_cache() will just dec refcounts
> without putting the page back to buddy. So the hugepage is not
> actually freed at all. Am I missing something?

Thanks for catching this! If page is on percpu lru_pvecs cache, page will
be released when lru_pvecs are drained. But if not, free_swap_cache() won't
free the page as it assumes the caller has a reference on the page and thus
only does page_ref_sub(). Does the below change looks sense for you?

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 52109ad13f78..b8c96e33591d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -755,8 +755,12 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,

        list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
                list_del(&src_page->lru);
-               release_pte_page(src_page);
+               mod_node_page_state(page_pgdat(src_page),
+                                   NR_ISOLATED_ANON + page_is_file_lru(src_page),
+                                   -compound_nr(src_page));
+               unlock_page(src_page);
                free_swap_cache(src_page);
+               putback_lru_page(src_page);
        }
 }

Thanks!

> 
>>         }
>>  }
>>
>> diff --git a/mm/swap.h b/mm/swap.h
>> index 0193797b0c92..863f6086c916 100644
>> --- a/mm/swap.h
>> +++ b/mm/swap.h
>> @@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct page *page,
>>  void delete_from_swap_cache(struct page *page);
>>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>>                                   unsigned long end);
>> -void free_swap_cache(struct page *page);
>>  struct page *lookup_swap_cache(swp_entry_t entry,
>>                                struct vm_area_struct *vma,
>>                                unsigned long addr);
>> @@ -81,10 +80,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
>>         return NULL;
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

