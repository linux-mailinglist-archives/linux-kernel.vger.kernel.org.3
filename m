Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359B2558D37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 04:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiFXC0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 22:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFXC01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 22:26:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C04562C5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:26:25 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LTgtc3q82zkWW8;
        Fri, 24 Jun 2022 10:24:40 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 10:25:49 +0800
Subject: Re: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
Date:   Fri, 24 Jun 2022 10:25:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
> I found a weird state of 1GB hugepage pool, caused by the following
> procedure:
> 
>   - run a process reserving all free 1GB hugepages,
>   - shrink free 1GB hugepage pool to zero (i.e. writing 0 to
>     /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages), then
>   - kill the reserving process.
> 
> , then all the hugepages are free *and* surplus at the same time.
> 
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>   3
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
>   3
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/resv_hugepages
>   0
>   $ cat /sys/kernel/mm/hugepages/hugepages-1048576kB/surplus_hugepages
>   3
> 
> This state is resolved by reserving and allocating the pages then
> freeing them again, so this seems not to result in serious problem.
> But it's a little surprizing (shrinking pool suddenly fails).
> 
> This behavior is caused by hstate_is_gigantic() check in
> return_unused_surplus_pages(). This was introduced so long ago in 2008
> by commit aa888a74977a ("hugetlb: support larger than MAX_ORDER"), and
> it seems to me that this check is no longer unnecessary. Let's remove it.

s/unnecessary/necessary/

> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/hugetlb.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a57e1be41401..c538278170a2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2432,10 +2432,6 @@ static void return_unused_surplus_pages(struct hstate *h,
>  	/* Uncommit the reservation */
>  	h->resv_huge_pages -= unused_resv_pages;
>  
> -	/* Cannot return gigantic pages currently */
> -	if (hstate_is_gigantic(h))
> -		goto out;
> -

IIUC it might be better to do the below check:
	/*
	 * Cannot return gigantic pages currently if runtime gigantic page
	 * allocation is not supported.
	 */
	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
		goto out;

But I might be miss something.

Thanks.

>  	/*
>  	 * Part (or even all) of the reservation could have been backed
>  	 * by pre-allocated pages. Only free surplus pages.
> 

