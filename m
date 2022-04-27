Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B551121A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358622AbiD0HOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358632AbiD0HOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:14:47 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC43B00C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:11:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kp9022Tw8zhYKN;
        Wed, 27 Apr 2022 15:11:14 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 15:11:32 +0800
Subject: Re: [RFC PATCH v1 1/4] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-2-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5b956156-887b-1d91-7831-28a66db53c6a@huawei.com>
Date:   Wed, 27 Apr 2022 15:11:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220427042841.678351-2-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/27 12:28, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When handling memory error on a hugetlb page, the error handler tries to
> dissolve and turn it into 4kB pages.  If it's successfully dissolved,
> PageHWPoison flag is moved to the raw error page, so but that's all

s/so but/so/

> right.  However, dissolve sometimes fails, then the error page is left
> as hwpoisoned hugepage. It's useful if we can retry to dissolve it to
> save healthy pages, but that's not possible now because the information
> about where the raw error page is lost.
> 
> Use the private field of a tail page to keep that information.  The code

Only one raw error page is saved now. Should this be ok? I think so as memory
failure should be rare anyway?

> path of shrinking hugepage pool used this info to try delayed dissolve.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
>  mm/hugetlb.c            |  9 +++++++++
>  mm/memory-failure.c     |  2 ++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ac2a1d758a80..689e69cb556b 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -42,6 +42,9 @@ enum {
>  	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
>  	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
>  	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
> +#endif
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	SUBPAGE_INDEX_HWPOISON,
>  #endif

Do we rely on the CONFIG_CGROUP_HUGETLB to store the raw error page?

>  	__NR_USED_SUBPAGE,
>  };
> @@ -784,6 +787,27 @@ extern int dissolve_free_huge_page(struct page *page);
>  extern int dissolve_free_huge_pages(unsigned long start_pfn,
>  				    unsigned long end_pfn);
>  
> +#ifdef CONFIG_MEMORY_FAILURE
> +/*
> + * pointer to raw error page is located in hpage[SUBPAGE_INDEX_HWPOISON].private
> + */
> +static inline struct page *hugetlb_page_hwpoison(struct page *hpage)
> +{
> +	return (void *)page_private(hpage + SUBPAGE_INDEX_HWPOISON);
> +}
> +
> +static inline void hugetlb_set_page_hwpoison(struct page *hpage,
> +					struct page *page)
> +{
> +	set_page_private(hpage + SUBPAGE_INDEX_HWPOISON, (unsigned long)page);
> +}
> +#else
> +static inline struct page *hugetlb_page_hwpoison(struct page *hpage)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>  #ifndef arch_hugetlb_migration_supported
>  static inline bool arch_hugetlb_migration_supported(struct hstate *h)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f8e048b939c7..6867ea8345d1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1547,6 +1547,15 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>  		return;
>  	}
>  
> +	if (unlikely(PageHWPoison(page))) {
> +		struct page *raw_error = hugetlb_page_hwpoison(page);
> +
> +		if (raw_error && raw_error != page) {
> +			SetPageHWPoison(raw_error);
> +			ClearPageHWPoison(page);
> +		}
> +	}
> +
>  	for (i = 0; i < pages_per_huge_page(h);
>  	     i++, subpage = mem_map_next(subpage, page, i)) {
>  		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3e36fc19c4d1..73948a00ad4a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1535,6 +1535,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  		goto out;
>  	}
>  
> +	hugetlb_set_page_hwpoison(head, page);
> +
>  	return ret;
>  out:
>  	if (count_increased)
> 

This patch looks good to me. I will learn this series more when I get more time.
Many thanks for your hard work! :)
