Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3368589CA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiHDN3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbiHDN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:29:03 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF19C15737
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:29:01 -0700 (PDT)
Date:   Thu, 4 Aug 2022 22:28:53 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659619739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xjwOLlJa1sx9Z5qqE71h/yHwNx7CZZOcwExLPX1L2fw=;
        b=XatL7kTfZcJaQM0vZ/NPE4IJSBkw0hZAAfLgphyqowgRySLJ5FUpD+MLs4WPRu5VNNUJve
        Pxqb+zyAHMkbV7aNI/qiZdB7OTQMcKwyljv4P2fV+j5yL6uS4Ks7/9f/vD4V12QQvsvrZu
        +UFSrTMOkLtoWjFcXEM8nQQ97NO7BOQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     luofei <luofei@unicloud.com>
Cc:     akpm@linux-foundation.org, linmiaohe@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v1] mm, hwpoison, hugetlb: Check hugetlb head page
 hwpoison flag when unpoison page
Message-ID: <20220804131639.GA39205@hori.linux.bs1.fc.nec.co.jp>
References: <20220804122819.2917249-1-luofei@unicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220804122819.2917249-1-luofei@unicloud.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 08:28:19AM -0400, luofei wrote:
> When software-poison a huge page, if dissolve_free_huge_page() failed,
> the huge page will be added to hugepage_freelists. In this case, the
> head page will hold the hwpoison flag, but the real poisoned tail page
> hwpoison flag is not set, this will cause unpoison_memory() fail to
> unpoison the previously poisoned page.

Hi luofei,

When you try to unpoison a hwpoisoned hugepage, you just have to pass the
pfn of the head page, not the pfn of raw poisoned subpage.  Note that the
position of raw error page is not exposed to userspace (dmesg shows it, but
saving and parsing it for unpoison is not that useful) and the related
utilities like page-types only checks PageHWpoison flag to find error pages,
so it seems to me that you're introducing an inconsistent assumption.

Thanks,
Naoya Horiguchi

> 
> So add a check on hugetlb head page, and also need to ensure the
> previously poisoned tail page in huge page raw_hwp_list.
> 
> Signed-off-by: luofei <luofei@unicloud.com>
> ---
>  mm/memory-failure.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 14439806b5ef..92dbeaa24afb 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2293,6 +2293,28 @@ core_initcall(memory_failure_init);
>  		pr_info(fmt, pfn);			\
>  })
>  
> +static bool hugetlb_page_head_poison(struct page *hpage, struct page *page)
> +{
> +	struct llist_head *head;
> +	struct llist_node *t, *tnode;
> +	struct raw_hwp_page *p;
> +
> +	if (!PageHuge(page) || !PageHWPoison(hpage) || !HPageFreed(hpage))
> +		return false;
> +
> +	if (HPageRawHwpUnreliable(hpage))
> +		return false;
> +
> +	head = raw_hwp_list_head(hpage);
> +	llist_for_each_safe(tnode, t, head->first) {
> +		p = container_of(tnode, struct raw_hwp_page, node);
> +		if (p->page == page)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /**
>   * unpoison_memory - Unpoison a previously poisoned page
>   * @pfn: Page number of the to be unpoisoned page
> @@ -2330,7 +2352,7 @@ int unpoison_memory(unsigned long pfn)
>  		goto unlock_mutex;
>  	}
>  
> -	if (!PageHWPoison(p)) {
> +	if (!PageHWPoison(p) && !hugetlb_page_head_poison(page, p)) {
>  		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
>  				 pfn, &unpoison_rs);
>  		goto unlock_mutex;
> -- 
> 2.27.0
