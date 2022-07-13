Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B06572CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiGMEvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGMEvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:51:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A42C747B4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:51:35 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LjQ916RC5zVffs;
        Wed, 13 Jul 2022 12:47:49 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 12:51:31 +0800
Subject: Re: [mm-unstable PATCH v6 3/8] mm, hwpoison, hugetlb: support saving
 mechanism of raw error pages
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
 <20220712032858.170414-4-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0ba226e6-c297-d87d-f74e-9036a6121072@huawei.com>
Date:   Wed, 13 Jul 2022 12:51:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220712032858.170414-4-naoya.horiguchi@linux.dev>
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

On 2022/7/12 11:28, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When handling memory error on a hugetlb page, the error handler tries to
> dissolve and turn it into 4kB pages.  If it's successfully dissolved,
> PageHWPoison flag is moved to the raw error page, so that's all right.
> However, dissolve sometimes fails, then the error page is left as
> hwpoisoned hugepage. It's useful if we can retry to dissolve it to save
> healthy pages, but that's not possible now because the information about
> where the raw error pages is lost.
> 
> Use the private field of a few tail pages to keep that information.  The
> code path of shrinking hugepage pool uses this info to try delayed dissolve.
> In order to remember multiple errors in a hugepage, a singly-linked list
> originated from SUBPAGE_INDEX_HWPOISON-th tail page is constructed.  Only
> simple operations (adding an entry or clearing all) are required and the
> list is assumed not to be very long, so this simple data structure should
> be enough.
> 
> If we failed to save raw error info, the hwpoison hugepage has errors on
> unknown subpage, then this new saving mechanism does not work any more,
> so disable saving new raw error info and freeing hwpoison hugepages.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: kernel test robot <lkp@intel.com>

This patch looks good to me with some nits below.

> ---
...
> +static int hugetlb_set_page_hwpoison(struct page *hpage, struct page *page)
> +{
> +	struct llist_head *head;
> +	struct raw_hwp_page *raw_hwp;
> +	struct llist_node *t, *tnode;
> +	int ret = TestSetPageHWPoison(hpage) ? -EHWPOISON : 0;
> +
> +	/*
> +	 * Once the hwpoison hugepage has lost reliable raw error info,
> +	 * there is little meaning to keep additional error info precisely,
> +	 * so skip to add additional raw error info.
> +	 */
> +	if (HPageRawHwpUnreliable(hpage))
> +		return -EHWPOISON;
> +	head = raw_hwp_list_head(hpage);
> +	llist_for_each_safe(tnode, t, head->first) {
> +		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
> +
> +		if (p->page == page)
> +			return -EHWPOISON;
> +	}
> +
> +	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
> +	if (raw_hwp) {
> +		raw_hwp->page = page;
> +		llist_add(&raw_hwp->node, head);
> +		/* the first error event will be counted in action_result(). */
> +		if (ret)
> +			num_poisoned_pages_inc();
> +	} else {
> +		/*
> +		 * Failed to save raw error info.  We no longer trace all
> +		 * hwpoisoned subpages, and we need refuse to free/dissolve
> +		 * this hwpoisoned hugepage.
> +		 */
> +		SetHPageRawHwpUnreliable(hpage);

IMHO, when HPageRawHwpUnreliable is set, we can simply free the raw_hwp_list here
to save some memory as they're not used anymore.

> +	}
> +	return ret;
> +}
> +
> +void hugetlb_clear_page_hwpoison(struct page *hpage)
> +{
> +	struct llist_head *head;
> +	struct llist_node *t, *tnode;
> +
> +	if (!HPageRawHwpUnreliable(hpage))
> +		ClearPageHWPoison(hpage);
> +	head = raw_hwp_list_head(hpage);
> +	llist_for_each_safe(tnode, t, head->first) {
> +		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
> +
> +		SetPageHWPoison(p->page);
> +		kfree(p);
> +	}
> +	llist_del_all(head);
> +}
> +
>  /*
>   * Called from hugetlb code with hugetlb_lock held.
>   *
> @@ -1698,7 +1771,7 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  		goto out;
>  	}
>  
> -	if (TestSetPageHWPoison(head)) {
> +	if (hugetlb_set_page_hwpoison(head, page)) {
>  		ret = -EHWPOISON;
>  		goto out;
>  	}
> @@ -1710,7 +1783,6 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_HUGETLB_PAGE
>  /*
>   * Taking refcount of hugetlb pages needs extra care about race conditions
>   * with basic operations like hugepage allocation/free/demotion.
> @@ -1751,7 +1823,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
>  	lock_page(head);
>  
>  	if (hwpoison_filter(p)) {
> -		ClearPageHWPoison(head);
> +		hugetlb_clear_page_hwpoison(head);

If the code reach here, the hugetlb page should be poisoned first time or it will return
in above "res == -EHWPOISON" case. So ClearPageHWPoison should be fine here. But this change
will do the same thing while making the code more consistent. So it should be fine. :)

>  		res = -EOPNOTSUPP;
>  		goto out;
>  	}
> 

Anyway, for what it worth,

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!
