Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F54540086
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245007AbiFGN5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244991AbiFGN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:57:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67EB0A4C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:56:55 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LHX161D8Mz1K9c0;
        Tue,  7 Jun 2022 21:55:06 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 21:56:53 +0800
Subject: Re: [PATCH v1 4/5] mm, hwpoison: skip raw hwpoison page in freeing
 1GB hugepage
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
 <20220602050631.771414-5-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <19981830-a5e6-bdba-4a1c-1cdcea61b93b@huawei.com>
Date:   Tue, 7 Jun 2022 21:56:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220602050631.771414-5-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
> Currently if memory_failure() (modified to remove blocking code) is called
> on a page in some 1GB hugepage, memory error handling returns failure and
> the raw error page gets into undesirable state.  The impact is small in
> production systems (just leaked single 4kB page), but this limits the test
> efficiency because unpoison doesn't work for it.  So we can no longer

I think I get the point after I have read the above commit log several times and refered to
the discussion in [1]. The impact is small due to the 1G hugepage is dissolved while memory
error handling returns failure. So we just leak single 4KB page and unpoison doesn't work for
it due to page refcnt is 0. Do I get the point?

[1] https://lore.kernel.org/all/20220519021757.GA520829@hori.linux.bs1.fc.nec.co.jp/

Although I wonder why __page_handle_poison() fails for 1GB hugepage, the code itself looks good
to me. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> create 1GB hugepage on the 1GB physical address range with such hwpoison
> pages, that could be an issue in testing on small systems.
> 
> When a hwpoison page in a 1GB hugepage is handled, it's caught by the
> PageHWPoison check in free_pages_prepare() because the hugepage is broken
> down into raw error page and order is 0:
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
> page refcount for hwpoison is properly incremented and now unpoison works.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f149a7864c81..babeb34f7477 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1043,7 +1043,6 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
>  		unlock_page(hpage);
>  	} else {
> -		res = MF_FAILED;
>  		unlock_page(hpage);
>  		/*
>  		 * migration entry prevents later access on error anonymous
> @@ -1051,9 +1050,11 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  		 * save healthy subpages.
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
> @@ -1601,9 +1602,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
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

