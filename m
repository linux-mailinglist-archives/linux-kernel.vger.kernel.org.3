Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7331E5129E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbiD1DXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241671AbiD1DXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:23:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C090812A88
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:20:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kpgp31BNxz1JBj2;
        Thu, 28 Apr 2022 11:19:23 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 11:20:17 +0800
Subject: Re: [RFC PATCH v1 4/4] mm, memory_hotplug: fix inconsistent
 num_poisoned_pages on memory hotremove
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
 <20220427042841.678351-5-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <828cc111-40e8-88ed-bb50-fb185e5f0304@huawei.com>
Date:   Thu, 28 Apr 2022 11:20:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220427042841.678351-5-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
> When offlining memory section with hwpoisoned pages, the hwpoisons are
> canceled. But num_poisoned_pages is not updated for that event, so the
> counter becomes inconsistent.

IIUC, this work is already done via clear_hwpoisoned_pages when __remove_pages.
Or am I miss something?

Thanks!

> 
> Add num_poisoned_pages_dec() in __offline_isolated_pages(). PageHWPoison
> can be set on a tail page of some high order buddy page, so we need check
> PageHWPoison on each subpage.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/page_alloc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6e5b4488a0c5..dcd962855617 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9487,12 +9487,15 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  	zone = page_zone(pfn_to_page(pfn));
>  	spin_lock_irqsave(&zone->lock, flags);
>  	while (pfn < end_pfn) {
> +		int i;
> +
>  		page = pfn_to_page(pfn);
>  		/*
>  		 * The HWPoisoned page may be not in buddy system, and
>  		 * page_count() is not 0.
>  		 */
>  		if (unlikely(!PageBuddy(page) && PageHWPoison(page))) {
> +			num_poisoned_pages_dec();
>  			pfn++;
>  			continue;
>  		}
> @@ -9510,6 +9513,9 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
>  		BUG_ON(page_count(page));
>  		BUG_ON(!PageBuddy(page));
>  		order = buddy_order(page);
> +		for (i = 0; i < 1 << order; i++)
> +			if (PageHWPoison(page + i))
> +				num_poisoned_pages_dec();
>  		del_page_from_free_list(page, zone, order);
>  		pfn += (1 << order);
>  	}
> 

