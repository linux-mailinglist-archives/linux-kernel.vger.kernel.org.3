Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9948572C77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiGMEZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiGMEZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:25:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25170DA5A4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:24:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LjPbT0qWhzhZDH;
        Wed, 13 Jul 2022 12:22:13 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 12:24:47 +0800
Subject: Re: [mm-unstable PATCH v6 4/8] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>
References: <20220712032858.170414-1-naoya.horiguchi@linux.dev>
 <20220712032858.170414-5-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1ebd5240-7298-5d1d-cc1d-d289d843472d@huawei.com>
Date:   Wed, 13 Jul 2022 12:24:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220712032858.170414-5-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/7/12 11:28, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Raw error info list needs to be removed when hwpoisoned hugetlb is
> unpoisoned.  And unpoison handler needs to know how many errors there
> are in the target hugepage. So add them.
> 
> HPageVmemmapOptimized(hpage) and HPageRawHwpUnreliable(hpage)) can't be
> unpoisoned, so let's skip them.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: kernel test robot <lkp@intel.com>

This patch looks good to me with some nits below.

> ---
...
>  
> -void hugetlb_clear_page_hwpoison(struct page *hpage)
> +static unsigned long free_raw_hwp_pages(struct page *hpage, bool move_flag)
>  {
>  	struct llist_head *head;
>  	struct llist_node *t, *tnode;
> +	unsigned long count = 0;
>  
> -	if (!HPageRawHwpUnreliable(hpage))
> -		ClearPageHWPoison(hpage);
> +	/*
> +	 * HPageVmemmapOptimized hugepages can't be unpoisoned because
> +	 * struct pages for tail pages are required to free hwpoisoned
> +	 * hugepages.  HPageRawHwpUnreliable hugepages shouldn't be
> +	 * unpoisoned by definition.
> +	 */
> +	if (HPageVmemmapOptimized(hpage) || HPageRawHwpUnreliable(hpage))

If move_flag == false, i.e. in unpoison case, tail pages are not touched. So HPageVmemmapOptimized
can be ignored in this case? Or leave it as above to keep the code simple?

> +		return 0;
>  	head = raw_hwp_list_head(hpage);
>  	llist_for_each_safe(tnode, t, head->first) {
>  		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
>  
> -		SetPageHWPoison(p->page);
> +		if (move_flag)
> +			SetPageHWPoison(p->page);
>  		kfree(p);
> +		count++;
>  	}
>  	llist_del_all(head);
> +	return count;
> +}
> +
> +void hugetlb_clear_page_hwpoison(struct page *hpage)
> +{
> +	if (!HPageRawHwpUnreliable(hpage))

It seems we can return here if HPageRawHwpUnreliable as there's nothing to do?

Anyway, for what it worth,

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.

> +		ClearPageHWPoison(hpage);
> +	free_raw_hwp_pages(hpage, true);
>  }
>  
>  /*
