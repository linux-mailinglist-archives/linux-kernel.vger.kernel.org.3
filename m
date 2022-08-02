Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A734E58758C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiHBCa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiHBCa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:30:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B7013DC8
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:30:55 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lxf6h1dp8zlW3Z;
        Tue,  2 Aug 2022 10:28:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 10:30:53 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 10:30:52 +0800
Message-ID: <57154871-e99c-cdb3-08b0-e8df3c8eb630@huawei.com>
Date:   Tue, 2 Aug 2022 10:30:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: memory-failure: cleanup try_to_split_thp_page()
Content-Language: en-US
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>
References: <e699cd23-3eeb-7920-accd-b30622efa551@huawei.com>
 <20220802021256.162269-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220802021256.162269-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/2 10:12, Kefeng Wang wrote:
> Since commit 5d1fd5dc877b ("mm,hwpoison: introduce MF_MSG_UNSPLIT_THP"),
> the action_result() called to show memory error event in memory_failure(),
action_result(,MF_MSG_UNSPLIT_THP,)
> so the pr_info() in try_to_split_thp_page() is only needed in
> soft_offline_in_use_page().
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/memory-failure.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f0e1961d4482..59633a617a0a 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1524,20 +1524,18 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>   	return page_action(ps, p, pfn);
>   }
>   
> -static int try_to_split_thp_page(struct page *page, const char *msg)
> +static int try_to_split_thp_page(struct page *page)
>   {
> +	int ret;
> +
>   	lock_page(page);
> -	if (unlikely(split_huge_page(page))) {
> -		unsigned long pfn = page_to_pfn(page);
> +	ret = split_huge_page(page);
> +	unlock_page(page);
>   
> -		unlock_page(page);
> -		pr_info("%s: %#lx: thp split failed\n", msg, pfn);
> +	if (unlikely(ret))
>   		put_page(page);
> -		return -EBUSY;
> -	}
> -	unlock_page(page);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
> @@ -2079,7 +2077,7 @@ int memory_failure(unsigned long pfn, int flags)
>   		 * page is a valid handlable page.
>   		 */
>   		SetPageHasHWPoisoned(hpage);
> -		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
> +		if (try_to_split_thp_page(p) < 0) {
>   			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
>   			res = -EBUSY;
>   			goto unlock_mutex;
> @@ -2503,8 +2501,11 @@ static int soft_offline_in_use_page(struct page *page)
>   	struct page *hpage = compound_head(page);
>   
>   	if (!PageHuge(page) && PageTransHuge(hpage))
> -		if (try_to_split_thp_page(page, "soft offline") < 0)
> +		if (try_to_split_thp_page(page) < 0) {
> +			pr_info("soft offline: %#lx: thp split failed\n",
> +				page_to_pfn(page));
>   			return -EBUSY;
> +		}
>   	return __soft_offline_page(page);
>   }
>   
