Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06255C227
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiF0MYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiF0MYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:24:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBA72AF6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:24:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LWn2B6f5Cz9swb;
        Mon, 27 Jun 2022 20:23:30 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 20:24:09 +0800
Subject: Re: [PATCH v2 8/9] mm, hwpoison: skip raw hwpoison page in freeing
 1GB hugepage
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
 <20220623235153.2623702-9-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <db45e4bc-f09a-771a-f90d-448d46bacce1@huawei.com>
Date:   Mon, 27 Jun 2022 20:24:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220623235153.2623702-9-naoya.horiguchi@linux.dev>
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
> Currently if memory_failure() (modified to remove blocking code with
> subsequent patch) is called on a page in some 1GB hugepage, memory error
> handling fails and the raw error page gets into leaked state.  The impact
> is small in production systems (just leaked single 4kB page), but this
> limits the testability because unpoison doesn't work for it.
> We can no longer create 1GB hugepage on the 1GB physical address range
> with such leaked pages, that's not useful when testing on small systems.
> 
> When a hwpoison page in a 1GB hugepage is handled, it's caught by the
> PageHWPoison check in free_pages_prepare() because the 1GB hugepage is
> broken down into raw error pages before coming to this point:
> 
>         if (unlikely(PageHWPoison(page)) && !order) {
>                 ...
>                 return false;
>         }
> 
> Then, the page is not sent to buddy and the page refcount is left 0.
> 
> Originally this check is supposed to work when the error page is freed from
> page_handle_poison() (that is called from soft-offline), but now we are
> opening another path to call it, so the callers of __page_handle_poison()
> need to handle the case by considering the return value 0 as success. Then
> page refcount for hwpoison is properly incremented so unpoison works.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

It seems I misunderstand the commit log in [1]. But I hope I get the point this time. :)

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!

[1]https://lore.kernel.org/linux-mm/19981830-a5e6-bdba-4a1c-1cdcea61b93b@huawei.com/

> ---
>  mm/memory-failure.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index db85f644a1e3..fc7b83cb6468 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1046,7 +1046,6 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
>  		unlock_page(hpage);
>  	} else {
> -		res = MF_FAILED;
>  		unlock_page(hpage);
>  		/*
>  		 * migration entry prevents later access on error hugepage,
> @@ -1054,9 +1053,11 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  		 * subpages.
>  		 */
>  		put_page(hpage);
> -		if (__page_handle_poison(p) > 0) {
> +		if (__page_handle_poison(p) >= 0) {
>  			page_ref_inc(p);
>  			res = MF_RECOVERED;
> +		} else {
> +			res = MF_FAILED;
>  		}
>  	}
>  
> @@ -1704,9 +1705,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  	 */
>  	if (res == 0) {
>  		unlock_page(head);
> -		if (__page_handle_poison(p) > 0) {
> +		if (__page_handle_poison(p) >= 0) {
>  			page_ref_inc(p);
>  			res = MF_RECOVERED;
> +		} else {
> +			res = MF_FAILED;
>  		}
>  		action_result(pfn, MF_MSG_FREE_HUGE, res);
>  		return res == MF_RECOVERED ? 0 : -EBUSY;
> 

