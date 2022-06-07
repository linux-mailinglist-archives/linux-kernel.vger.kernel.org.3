Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B859B53FF43
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbiFGMqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244136AbiFGMqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:46:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2303C966A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:45:59 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LHVPf1X0XzRjGq;
        Tue,  7 Jun 2022 20:42:46 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:45:57 +0800
Subject: Re: [PATCH v1 1/5] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
 <20220602050631.771414-2-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <69a451c3-8845-15cd-1767-9eccd5a5585d@huawei.com>
Date:   Tue, 7 Jun 2022 20:45:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220602050631.771414-2-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/2 13:06, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When handling memory error on a hugetlb page, the error handler tries to
> dissolve and turn it into 4kB pages.  If it's successfully dissolved,
> PageHWPoison flag is moved to the raw error page, so that's all right.
> However, dissolve sometimes fails, then the error page is left as
> hwpoisoned hugepage. It's useful if we can retry to dissolve it to save
> healthy pages, but that's not possible now because the information about
> where the raw error page is lost.
> 
> Use the private field of a tail page to keep that information.  The code
> path of shrinking hugepage pool used this info to try delayed dissolve.
> This only keeps one hwpoison page for now, which might be OK because it's
> simple and multiple hwpoison pages in a hugepage can be rare. But it can

Yeah, multiple hwpoison pages in a hugepage might indicate that there are other problems.

> be extended in the future.

Since 1GB hugepage is going to be supported, only keeping one hwpoison page might not be
enough soon. ;)

> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!

> ---
> ChangeLog since previous post on 4/27:
> - fixed typo in patch description (by Miaohe)
> - fixed config value in #ifdef statement (by Miaohe)
> - added sentences about "multiple hwpoison pages" scenario in patch
>   description
> ---
>  include/linux/hugetlb.h | 24 ++++++++++++++++++++++++
>  mm/hugetlb.c            |  9 +++++++++
>  mm/memory-failure.c     |  2 ++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ac2a1d758a80..a5341a3a0d4b 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -42,6 +42,9 @@ enum {
>  	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
>  	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
>  	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
> +#endif
> +#ifdef CONFIG_MEMORY_FAILURE
> +	SUBPAGE_INDEX_HWPOISON,
>  #endif
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
> index 66edaa7e5092..056dbb2050f8 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1534,6 +1534,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  		goto out;
>  	}
>  
> +	hugetlb_set_page_hwpoison(head, page);
> +
>  	return ret;
>  out:
>  	if (count_increased)
> 

