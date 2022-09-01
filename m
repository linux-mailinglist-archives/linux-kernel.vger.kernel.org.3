Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF495A8EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiIAGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiIAGug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:50:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 420869E6A5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:50:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7E98D6E;
        Wed, 31 Aug 2022 23:50:39 -0700 (PDT)
Received: from [10.162.43.7] (unknown [10.162.43.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0B673F7B4;
        Wed, 31 Aug 2022 23:50:59 -0700 (PDT)
Message-ID: <feb27c46-1713-ddf0-c3fb-fdaa68b7f191@arm.com>
Date:   Thu, 1 Sep 2022 12:20:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] mm: memory-failure: kill __soft_offline_page()
Content-Language: en-US
To:     20220830071514.GA1106752@hori.linux.bs1.fc.nec.co.jp,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
References: <20220830104654.28234-1-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220830104654.28234-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 16:16, Kefeng Wang wrote:
> Squash the __soft_offline_page() into soft_offline_in_use_page() and kill
> __soft_offline_page().
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> v2: update hpage when try_to_split_thp_page() success
> 
>  mm/memory-failure.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b61f2de9f2a1..df54a6bc9bef 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2434,11 +2434,11 @@ static bool isolate_page(struct page *page, struct list_head *pagelist)
>  }
>  
>  /*
> - * __soft_offline_page handles hugetlb-pages and non-hugetlb pages.
> + * soft_offline_in_use_page handles hugetlb-pages and non-hugetlb pages.
>   * If the page is a non-dirty unmapped page-cache page, it simply invalidates.
>   * If the page is mapped, it migrates the contents over.
>   */
> -static int __soft_offline_page(struct page *page)
> +static int soft_offline_in_use_page(struct page *page)
>  {
>  	long ret = 0;
>  	unsigned long pfn = page_to_pfn(page);
> @@ -2451,6 +2451,14 @@ static int __soft_offline_page(struct page *page)
>  		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
>  	};
>  
> +	if (!huge && PageTransHuge(hpage)) {
> +		if (try_to_split_thp_page(page)) {
> +			pr_info("soft offline: %#lx: thp split failed\n", pfn);
> +			return -EBUSY;
> +		}
> +		hpage = page;
> +	}
> +
>  	lock_page(page);
>  	if (!PageHuge(page))
>  		wait_on_page_writeback(page);
> @@ -2500,19 +2508,6 @@ static int __soft_offline_page(struct page *page)
>  	return ret;
>  }
>  
> -static int soft_offline_in_use_page(struct page *page)
> -{
> -	struct page *hpage = compound_head(page);
> -
> -	if (!PageHuge(page) && PageTransHuge(hpage))
> -		if (try_to_split_thp_page(page) < 0) {
> -			pr_info("soft offline: %#lx: thp split failed\n",
> -				page_to_pfn(page));
> -			return -EBUSY;
> -		}
> -	return __soft_offline_page(page);
> -}
> -
>  static void put_ref_page(struct page *page)
>  {
>  	if (page)
