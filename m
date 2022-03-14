Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740EC4D7B50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiCNHLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCNHLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:11:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8736113F48
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:10:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KH7172PjtzBrlx;
        Mon, 14 Mar 2022 15:08:27 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 15:10:26 +0800
Subject: Re: [PATCH v2] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220314021337.333781-1-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <58732610-36a4-1f05-c09d-a5536013772d@huawei.com>
Date:   Mon, 14 Mar 2022 15:10:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220314021337.333781-1-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/14 10:13, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> There is a race condition between memory_failure_hugetlb() and hugetlb
> free/demotion, which causes setting PageHWPoison flag on the wrong page
> (which was a hugetlb when memory_failure() was called, but was removed
> or demoted when memory_failure_hugetlb() is called).  This results in
> killing wrong processes.  So set PageHWPoison flag with holding page lock,

It seems hold page lock could not help solve this race condition as hugetlb
page demotion is not required to hold the page lock. Could you please explain
this a bit more?

BTW:Is there some words missing or here should be 'page lock.' instead of 'page lock,' ?

> 
> The actual user-visible effect might be obscure because even if
> memory_failure() works as expected, some random process could be killed.
> Even worse, the actual error is left unhandled, so no one prevents later
> access to it, which might lead to more serious results like consuming
> corrupted data.
> 
> This patch depends on Miaohe's patch titled "mm/memory-failure.c: fix
> race with changing page compound again".
> 
> Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: <stable@vger.kernel.org>
> ---
> ChangeLog v1 -> v2:
> - pass subpage to get_hwpoison_huge_page() instead of head page.
> - call compound_head() in hugetlb_lock to avoid race with hugetlb
>   demotion/free.
> ---
>  mm/hugetlb.c        |  8 +++++---
>  mm/memory-failure.c | 33 +++++++++++++++------------------
>  2 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f294db835f4b..345fed90842e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6761,14 +6761,16 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>  
>  int get_hwpoison_huge_page(struct page *page, bool *hugetlb)
>  {
> +	struct page *head;
>  	int ret = 0;
>  
>  	*hugetlb = false;
>  	spin_lock_irq(&hugetlb_lock);
> -	if (PageHeadHuge(page)) {
> +	head = compound_head(page);
> +	if (PageHeadHuge(head)) {
>  		*hugetlb = true;
> -		if (HPageFreed(page) || HPageMigratable(page))
> -			ret = get_page_unless_zero(page);
> +		if (HPageFreed(head) || HPageMigratable(head))
> +			ret = get_page_unless_zero(head);
>  		else
>  			ret = -EBUSY;
>  	}
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a9bfd04d2a3c..c40c00c3a261 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1193,7 +1193,7 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
>  	int ret = 0;
>  	bool hugetlb = false;
>  
> -	ret = get_hwpoison_huge_page(head, &hugetlb);
> +	ret = get_hwpoison_huge_page(page, &hugetlb);
>  	if (hugetlb)
>  		return ret;
>  
> @@ -1280,11 +1280,10 @@ static int get_any_page(struct page *p, unsigned long flags)
>  
>  static int __get_unpoison_page(struct page *page)
>  {
> -	struct page *head = compound_head(page);
>  	int ret = 0;
>  	bool hugetlb = false;
>  
> -	ret = get_hwpoison_huge_page(head, &hugetlb);
> +	ret = get_hwpoison_huge_page(page, &hugetlb);
>  	if (hugetlb)
>  		return ret;
>  
> @@ -1503,24 +1502,11 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  	int res;
>  	unsigned long page_flags;
>  
> -	if (TestSetPageHWPoison(head)) {
> -		pr_err("Memory failure: %#lx: already hardware poisoned\n",
> -		       pfn);
> -		res = -EHWPOISON;
> -		if (flags & MF_ACTION_REQUIRED)
> -			res = kill_accessing_process(current, page_to_pfn(head), flags);
> -		return res;
> -	}
> -
> -	num_poisoned_pages_inc();
> -
>  	if (!(flags & MF_COUNT_INCREASED)) {
>  		res = get_hwpoison_page(p, flags);
>  		if (!res) {

In this (res == 0) case, hugetlb page could be dissolved via __page_handle_poison.
But since PageHWPoison is not set yet, we can't set the PageHWPoison to the correct
page. Think about the below code in dissolve_free_huge_page:
	/*
	 * Move PageHWPoison flag from head page to the raw
	 * error page, which makes any subpages rather than
	 * the error page reusable.
	 */
	if (PageHWPoison(head) && page != head) {
		SetPageHWPoison(page);
		ClearPageHWPoison(head);
	}

SetPageHWPoison won't be called for the error page. Or am I miss something?

>  			lock_page(head);
>  			if (hwpoison_filter(p)) {
> -				if (TestClearPageHWPoison(head))
> -					num_poisoned_pages_dec();
>  				unlock_page(head);
>  				return -EOPNOTSUPP;
>  			}
> @@ -1553,13 +1539,16 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  	page_flags = head->flags;
>  
>  	if (hwpoison_filter(p)) {
> -		if (TestClearPageHWPoison(head))
> -			num_poisoned_pages_dec();
>  		put_page(p);
>  		res = -EOPNOTSUPP;
>  		goto out;
>  	}
>  
> +	if (TestSetPageHWPoison(head))
> +		goto already_hwpoisoned;
> +
> +	num_poisoned_pages_inc();
> +
>  	/*
>  	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
>  	 * simply disable it. In order to make it work properly, we need
> @@ -1585,6 +1574,14 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>  out:
>  	unlock_page(head);
>  	return res;
> +already_hwpoisoned:
> +	put_page(p);
> +	unlock_page(head);

Generally speaking, we should do unlock_page before put_page or page might be disappeared
before we unlock the page. This should be ok when memory_failure succeeds to handle the
page previously as it holds one extra page refcnt. But it might be problematic when
memory_failure failed to handle the page last time. We might be the last user here.

> +	pr_err("Memory failure: %#lx: already hardware poisoned\n", pfn);
> +	res = -EHWPOISON;
> +	if (flags & MF_ACTION_REQUIRED)
> +		res = kill_accessing_process(current, page_to_pfn(head), flags);
> +	return res;
>  }
>  
>  static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
> 

Many thanks for your path! :)
