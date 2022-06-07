Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309C253FF74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbiFGMyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244279AbiFGMy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:54:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA1C7B9C2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:54:27 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LHVd15yNFz1KGJs;
        Tue,  7 Jun 2022 20:52:37 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:54:24 +0800
Subject: Re: [PATCH v1 3/5] mm, hwpoison: make __page_handle_poison returns
 int
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
 <20220602050631.771414-4-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9d423acb-b671-1cf0-0432-76eb648de95b@huawei.com>
Date:   Tue, 7 Jun 2022 20:54:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220602050631.771414-4-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
> index fe6a7961dc66..f149a7864c81 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -68,7 +68,13 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
>  
>  atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
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
> @@ -78,7 +84,7 @@ static bool __page_handle_poison(struct page *page)
>  		ret = take_page_off_buddy(page);
>  	zone_pcp_enable(page_zone(page));
>  
> -	return ret > 0;
> +	return ret;
>  }
>  
>  static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
> @@ -88,7 +94,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
>  		 * Doing this check for free pages is also fine since dissolve_free_huge_page
>  		 * returns 0 for non-hugetlb pages as well.
>  		 */
> -		if (!__page_handle_poison(page))
> +		if (__page_handle_poison(page) <= 0)
>  			/*
>  			 * We could fail to take off the target page from buddy
>  			 * for example due to racy page allocation, but that's
> @@ -1045,7 +1051,7 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  		 * save healthy subpages.
>  		 */
>  		put_page(hpage);
> -		if (__page_handle_poison(p)) {
> +		if (__page_handle_poison(p) > 0) {
>  			page_ref_inc(p);
>  			res = MF_RECOVERED;
>  		}
> @@ -1595,8 +1601,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  	 */
>  	if (res == 0) {
>  		unlock_page(head);
> -		res = MF_FAILED;

This looks like an unexpected change. res will be 0 instead of MF_FAILED if __page_handle_poison failed to
dissolve or not taken off from buddy. But this is fixed in later patch in this series. So it should be fine.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!

> -		if (__page_handle_poison(p)) {
> +		if (__page_handle_poison(p) > 0) {
>  			page_ref_inc(p);
>  			res = MF_RECOVERED;
>  		}
> 

