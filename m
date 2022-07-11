Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6324B56D621
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiGKHLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiGKHKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:10:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F0F1C924
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 00:09:04 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LhFKy0c51zhZ3Q;
        Mon, 11 Jul 2022 15:06:30 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 15:09:01 +0800
Subject: Re: [mm-unstable PATCH v5 4/8] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220708053653.964464-1-naoya.horiguchi@linux.dev>
 <20220708053653.964464-5-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3c66e7f6-e499-9802-409a-a32404fc87cc@huawei.com>
Date:   Mon, 11 Jul 2022 15:09:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220708053653.964464-5-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
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

On 2022/7/8 13:36, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Raw error info list needs to be removed when hwpoisoned hugetlb is
> unpoisoned.  And unpoison handler needs to know how many errors there
> are in the target hugepage. So add them.
> 
> HPageVmemmapOptimized(hpage) and HPageRawHwpUnreliable(hpage)) can't be
> unpoisoned, so let's skip them.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> v4 -> v5:
> - fix type of return value of free_raw_hwp_pages()
>   (found by kernel test robot),
> - prevent unpoison for HPageVmemmapOptimized and HPageRawHwpUnreliable.
> ---
>  include/linux/swapops.h |  9 ++++++++
>  mm/memory-failure.c     | 50 ++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index a01aeb3fcc0b..ddc98f96ad2c 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -498,6 +498,11 @@ static inline void num_poisoned_pages_dec(void)
>  	atomic_long_dec(&num_poisoned_pages);
>  }
>  
> +static inline void num_poisoned_pages_sub(long i)
> +{
> +	atomic_long_sub(i, &num_poisoned_pages);
> +}
> +
>  #else
>  
>  static inline swp_entry_t make_hwpoison_entry(struct page *page)
> @@ -518,6 +523,10 @@ static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
>  static inline void num_poisoned_pages_inc(void)
>  {
>  }
> +
> +static inline void num_poisoned_pages_sub(long i)
> +{
> +}
>  #endif
>  
>  static inline int non_swap_entry(swp_entry_t entry)
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 6833c5e4b410..89e74ec8a95f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1720,22 +1720,41 @@ static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
>  	return ret;
>  }
>  
> -int hugetlb_clear_page_hwpoison(struct page *hpage)
> +static long free_raw_hwp_pages(struct page *hpage, bool move_flag)

NO strong opinion: Maybe the return type should be "unsigned" as it always >= 0 ?

>  {
>  	struct llist_head *head;
>  	struct llist_node *t, *tnode;
> +	long count = 0;
>  
> -	if (!HPageRawHwpUnreliable(hpage))
> -		ClearPageHWPoison(hpage);
> +	/*
> +	 * HPageVmemmapOptimized hugepages can't be unpoisoned because
> +	 * struct pages for tail pages are required to free hwpoisoned
> +	 * hugepages.  HPageRawHwpUnreliable hugepages shouldn't be
> +	 * unpoisoned by definition.
> +	 */
> +	if (HPageVmemmapOptimized(hpage) || HPageRawHwpUnreliable(hpage))
> +		return 0;
>  	head = raw_hwp_list_head(hpage);
>  	llist_for_each_safe(tnode, t, head->first) {
>  		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
>  
> -		SetPageHWPoison(p->page);
> +		if (move_flag)
> +			SetPageHWPoison(p->page);
>  		kfree(p);
> +		count++;
>  	}
>  	llist_del_all(head);
> -	return 0;
> +	return count;
> +}
> +
> +int hugetlb_clear_page_hwpoison(struct page *hpage)

It seems the return value is unused?

> +{
> +	int ret = -EBUSY;
> +
> +	if (!HPageRawHwpUnreliable(hpage))
> +		ret = !TestClearPageHWPoison(hpage);
> +	free_raw_hwp_pages(hpage, true);
> +	return ret;
>  }
>  
>  /*
> @@ -1879,6 +1898,10 @@ static inline int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *
>  	return 0;
>  }
>  
> +static inline long free_raw_hwp_pages(struct page *hpage, bool move_flag)

If return type is changed, remember to change here too.

> +{
> +	return 0;
> +}
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  
>  static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
> @@ -2284,6 +2307,7 @@ int unpoison_memory(unsigned long pfn)
>  	struct page *p;
>  	int ret = -EBUSY;
>  	int freeit = 0;
> +	long count = 1;
>  	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
>  					DEFAULT_RATELIMIT_BURST);
>  
> @@ -2331,6 +2355,13 @@ int unpoison_memory(unsigned long pfn)
>  
>  	ret = get_hwpoison_page(p, MF_UNPOISON);
>  	if (!ret) {
> +		if (PageHuge(p)) {
> +			count = free_raw_hwp_pages(page, false);

It seems the current behavior is: if any subpage of a hugetlb page is unpoisoned, then all of the
hwpoisoned subpages will be unpoisoned. I'm not sure whether this is what we want.

Thanks.

> +			if (count == 0) {
> +				ret = -EBUSY;
> +				goto unlock_mutex;
> +			}
> +		}
>  		ret = TestClearPageHWPoison(page) ? 0 : -EBUSY;
>  	} else if (ret < 0) {
>  		if (ret == -EHWPOISON) {
> @@ -2339,6 +2370,13 @@ int unpoison_memory(unsigned long pfn)
>  			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
>  					 pfn, &unpoison_rs);
>  	} else {
> +		if (PageHuge(p)) {
> +			count = free_raw_hwp_pages(page, false);
> +			if (count == 0) {
> +				ret = -EBUSY;
> +				goto unlock_mutex;
> +			}
> +		}
>  		freeit = !!TestClearPageHWPoison(p);
>  
>  		put_page(page);
> @@ -2351,7 +2389,7 @@ int unpoison_memory(unsigned long pfn)
>  unlock_mutex:
>  	mutex_unlock(&mf_mutex);
>  	if (!ret || freeit) {
> -		num_poisoned_pages_dec();
> +		num_poisoned_pages_sub(count);
>  		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
>  				 page_to_pfn(p), &unpoison_rs);
>  	}
> 

