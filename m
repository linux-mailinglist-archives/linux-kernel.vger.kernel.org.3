Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1155B635
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiF0EY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiF0EYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:24:55 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D379389F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 21:24:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHRTyK._1656303885;
Received: from 30.32.122.103(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHRTyK._1656303885)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 12:24:46 +0800
Message-ID: <4e1d1501-f979-77fa-532e-a107bcb8a950@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 12:24:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 6/7] migrate_pages(): fix failure counting for THP
 splitting
To:     Huang Ying <ying.huang@intel.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shy828301@gmail.com, ziy@nvidia.com
References: <20220624025309.1033400-1-ying.huang@intel.com>
 <20220627022450.1067783-1-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220627022450.1067783-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2022 10:24 AM, Huang Ying wrote:
> If THP is failed to be migrated, it may be split and retry.  But after
> splitting, the head page will be left in "from" list, although THP
> migration failure has been counted already.  If the head page is
> failed to be migrated too, the failure will be counted twice
> incorrectly.  So this is fixed in this patch via moving the head page
> of THP after splitting to "thp_split_pages" too.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---

Good catch. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/migrate.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 9d1883d5927f..70a0e1f34c03 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1305,6 +1305,8 @@ static inline int try_split_thp(struct page *page, struct list_head *split_pages
>   	lock_page(page);
>   	rc = split_huge_page_to_list(page, split_pages);
>   	unlock_page(page);
> +	if (!rc)
> +		list_move_tail(&page->lru, split_pages);
>   
>   	return rc;
>   }
> @@ -1364,7 +1366,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   		thp_retry = 0;
>   
>   		list_for_each_entry_safe(page, page2, from, lru) {
> -retry:
>   			/*
>   			 * THP statistics is based on the source huge page.
>   			 * Capture required information that might get lost
> @@ -1411,7 +1412,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   					nr_thp_failed++;
>   					if (!try_split_thp(page, &thp_split_pages)) {
>   						nr_thp_split++;
> -						goto retry;
> +						break;
>   					}
>   				/* Hugetlb migration is unsupported */
>   				} else if (!no_subpage_counting) {
> @@ -1431,7 +1432,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   					/* THP NUMA faulting doesn't split THP to retry. */
>   					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
>   						nr_thp_split++;
> -						goto retry;
> +						break;
>   					}
>   				} else if (!no_subpage_counting) {
>   					nr_failed++;
