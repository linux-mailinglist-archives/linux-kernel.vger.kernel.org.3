Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865F45AF9E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiIGCck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIGCch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:32:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A815F923FE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:32:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMmS80dwbznWRb;
        Wed,  7 Sep 2022 10:30:00 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 10:32:33 +0800
Subject: Re: [PATCH v2 3/4] mm/hwpoison: pass pfn to num_poisoned_pages_*()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
 <20220905062137.1455537-4-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e96d2e18-ae79-a0d2-5b7a-e1d97b34a14c@huawei.com>
Date:   Wed, 7 Sep 2022 10:32:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220905062137.1455537-4-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/5 14:21, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> No functional change.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  arch/parisc/kernel/pdt.c |  2 +-
>  include/linux/mm.h       |  2 +-
>  mm/memory-failure.c      | 16 ++++++++--------
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
> index fdc880e2575a..80943a00e245 100644
> --- a/arch/parisc/kernel/pdt.c
> +++ b/arch/parisc/kernel/pdt.c
> @@ -231,7 +231,7 @@ void __init pdc_pdt_init(void)
>  
>  		/* mark memory page bad */
>  		memblock_reserve(pdt_entry[i] & PAGE_MASK, PAGE_SIZE);
> -		num_poisoned_pages_inc();
> +		num_poisoned_pages_inc(addr >> PAGE_SHIFT);
>  	}
>  }
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b81dd600e51a..6316973afd1d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3203,7 +3203,7 @@ static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  	return 0;
>  }

It seems declaration of num_poisoned_pages_inc() is still missing in this patch.

With that fixed:
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,
Miaohe Lin

>  
> -static inline void num_poisoned_pages_inc()
> +static inline void num_poisoned_pages_inc(unsigned long pfn)
>  {
>  }
>  #endif
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b6236c721f54..7dd4e403e634 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -74,17 +74,17 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
>  static bool hw_memory_failure __read_mostly = false;
>  
> -static inline void num_poisoned_pages_inc(void)
> +static inline void num_poisoned_pages_inc(unsigned long pfn)
>  {
>  	atomic_long_inc(&num_poisoned_pages);
>  }
>  
> -static inline void num_poisoned_pages_dec(void)
> +static inline void num_poisoned_pages_dec(unsigned long pfn)
>  {
>  	atomic_long_dec(&num_poisoned_pages);
>  }
>  
> -static inline void num_poisoned_pages_sub(long i)
> +static inline void num_poisoned_pages_sub(unsigned long pfn, long i)
>  {
>  	atomic_long_sub(i, &num_poisoned_pages);
>  }
> @@ -130,7 +130,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
>  	if (release)
>  		put_page(page);
>  	page_ref_inc(page);
> -	num_poisoned_pages_inc();
> +	num_poisoned_pages_inc(page_to_pfn(page));
>  
>  	return true;
>  }
> @@ -1196,7 +1196,7 @@ static void action_result(unsigned long pfn, enum mf_action_page_type type,
>  {
>  	trace_memory_failure_event(pfn, type, result);
>  
> -	num_poisoned_pages_inc();
> +	num_poisoned_pages_inc(pfn);
>  	pr_err("%#lx: recovery action for %s: %s\n",
>  		pfn, action_page_types[type], action_name[result]);
>  }
> @@ -1743,7 +1743,7 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
>  		llist_add(&raw_hwp->node, head);
>  		/* the first error event will be counted in action_result(). */
>  		if (ret)
> -			num_poisoned_pages_inc();
> +			num_poisoned_pages_inc(page_to_pfn(page));
>  	} else {
>  		/*
>  		 * Failed to save raw error info.  We no longer trace all
> @@ -2408,7 +2408,7 @@ int unpoison_memory(unsigned long pfn)
>  unlock_mutex:
>  	mutex_unlock(&mf_mutex);
>  	if (!ret || freeit) {
> -		num_poisoned_pages_sub(count);
> +		num_poisoned_pages_sub(pfn, count);
>  		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
>  				 page_to_pfn(p), &unpoison_rs);
>  	}
> @@ -2625,7 +2625,7 @@ void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  
>  	for (i = 0; i < nr_pages; i++) {
>  		if (PageHWPoison(&memmap[i])) {
> -			num_poisoned_pages_dec();
> +			num_poisoned_pages_dec(page_to_pfn(&memmap[i]));
>  			ClearPageHWPoison(&memmap[i]);
>  		}
>  	}
> 

