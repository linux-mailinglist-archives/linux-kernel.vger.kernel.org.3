Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFFC55D602
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiF0JD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiF0JD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:03:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ABB26C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:03:24 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LWhYm2R5szkWjZ;
        Mon, 27 Jun 2022 17:02:04 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 17:02:47 +0800
Subject: Re: [PATCH v2 7/9] mm, hwpoison: make __page_handle_poison returns
 int
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-8-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ecbcdd7e-b21f-315b-7eff-1eb692e320f7@huawei.com>
Date:   Mon, 27 Jun 2022 17:02:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220623235153.2623702-8-naoya.horiguchi@linux.dev>
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

On 2022/6/24 7:51, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> __page_handle_poison() returns bool that shows whether
> take_page_off_buddy() has passed or not now.  But we will want to
> distinguish another case of "dissolve has passed but taking off failed"
> by its return value. So change the type of the return value.
> No functional change.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ce045d0d6115..db85f644a1e3 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -71,7 +71,13 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>  
>  static bool hw_memory_failure __read_mostly = false;
>  
> -static bool __page_handle_poison(struct page *page)
> +/*
> + * Return values:
> + *   1:   the page is dissolved (if needed) and taken off from buddy,
> + *   0:   the page is dissolved (if needed) and not taken off from buddy,
> + *   < 0: failed to dissolve.
> + */
> +static int __page_handle_poison(struct page *page)
>  {
>  	int ret;
>  
> @@ -81,7 +87,7 @@ static bool __page_handle_poison(struct page *page)
>  		ret = take_page_off_buddy(page);
>  	zone_pcp_enable(page_zone(page));
>  
> -	return ret > 0;
> +	return ret;
>  }
>  
>  static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
> @@ -91,7 +97,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
>  		 * Doing this check for free pages is also fine since dissolve_free_huge_page
>  		 * returns 0 for non-hugetlb pages as well.
>  		 */
> -		if (!__page_handle_poison(page))
> +		if (__page_handle_poison(page) <= 0)
>  			/*
>  			 * We could fail to take off the target page from buddy
>  			 * for example due to racy page allocation, but that's
> @@ -1048,7 +1054,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  		 * subpages.
>  		 */
>  		put_page(hpage);
> -		if (__page_handle_poison(p)) {
> +		if (__page_handle_poison(p) > 0) {
>  			page_ref_inc(p);
>  			res = MF_RECOVERED;
>  		}
> @@ -1698,8 +1704,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  	 */
>  	if (res == 0) {
>  		unlock_page(head);
> -		res = MF_FAILED;

It seems the previous discussion in [1] is missed. But that doesn't matter as pointed out by [1]. :)

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.

[1]: https://lkml.org/lkml/2022/6/8/10

> -		if (__page_handle_poison(p)) {
> +		if (__page_handle_poison(p) > 0) {
>  			page_ref_inc(p);
>  			res = MF_RECOVERED;
>  		}
> 

