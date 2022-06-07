Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF453FF6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbiFGMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbiFGMux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:50:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C420F7B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:50:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LHVYQ6QQ1zjXMJ;
        Tue,  7 Jun 2022 20:49:30 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:50:49 +0800
Subject: Re: [PATCH v1 2/5] mm,hwpoison: set PG_hwpoison for busy hugetlb
 pages
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
 <20220602050631.771414-3-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <86cdcaa8-a079-f443-2166-723af6c4c9ac@huawei.com>
Date:   Tue, 7 Jun 2022 20:50:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220602050631.771414-3-naoya.horiguchi@linux.dev>
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
> If memory_failure() fails to grab page refcount on a hugetlb page
> because it's busy, it returns without setting PG_hwpoison on it.
> This not only loses a chance of error containment, but breaks the rule
> that action_result() should be called only when memory_failure() do
> any of handling work (even if that's just setting PG_hwpoison).
> This inconsistency could harm code maintainability.

Yes, this patch will make the code more maintainable. But as discussed previously,
this page might be under the migration, this patch can't save more.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!

> 
> So set PG_hwpoison and call hugetlb_set_page_hwpoison() for such a case.
> 
> Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  include/linux/mm.h  | 1 +
>  mm/memory-failure.c | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d446e834a3e5..04de0c3e4f9f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3187,6 +3187,7 @@ enum mf_flags {
>  	MF_MUST_KILL = 1 << 2,
>  	MF_SOFT_OFFLINE = 1 << 3,
>  	MF_UNPOISON = 1 << 4,
> +	MF_NO_RETRY = 1 << 5,
>  };
>  extern int memory_failure(unsigned long pfn, int flags);
>  extern void memory_failure_queue(unsigned long pfn, int flags);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 056dbb2050f8..fe6a7961dc66 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1526,7 +1526,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  			count_increased = true;
>  	} else {
>  		ret = -EBUSY;
> -		goto out;
> +		if (!(flags & MF_NO_RETRY))
> +			goto out;
>  	}
>  
>  	if (TestSetPageHWPoison(head)) {
> @@ -1556,7 +1557,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  	struct page *p = pfn_to_page(pfn);
>  	struct page *head;
>  	unsigned long page_flags;
> -	bool retry = true;
>  
>  	*hugetlb = 1;
>  retry:
> @@ -1572,8 +1572,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  		}
>  		return res;
>  	} else if (res == -EBUSY) {
> -		if (retry) {
> -			retry = false;
> +		if (!(flags & MF_NO_RETRY)) {
> +			flags |= MF_NO_RETRY;
>  			goto retry;
>  		}
>  		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
> 

