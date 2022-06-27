Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8055B639
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 06:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiF0E3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 00:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiF0E33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 00:29:29 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0218C48
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 21:29:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHRfB.M_1656304164;
Received: from 30.32.122.103(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHRfB.M_1656304164)
          by smtp.aliyun-inc.com;
          Mon, 27 Jun 2022 12:29:25 +0800
Message-ID: <5b40e07d-7ed3-7eba-ea71-52e5a06c1ec8@linux.alibaba.com>
Date:   Mon, 27 Jun 2022 12:29:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/7] migrate_pages(): fix failure counting for retry
To:     Huang Ying <ying.huang@intel.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        shy828301@gmail.com, ziy@nvidia.com
References: <20220624025309.1033400-1-ying.huang@intel.com>
 <20220627022515.1067946-1-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220627022515.1067946-1-ying.huang@intel.com>
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



On 6/27/2022 10:25 AM, Huang Ying wrote:
> After 10 retries, we will give up and the remaining pages will be
> counted as failure in nr_failed and nr_thp_failed.  We should count
> the failure in nr_failed_pages too.  This is done in this patch.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>   mm/migrate.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 70a0e1f34c03..e42bd409d3aa 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1344,6 +1344,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	int thp_retry = 1;
>   	int nr_failed = 0;
>   	int nr_failed_pages = 0;
> +	int nr_retry_pages = 0;
>   	int nr_succeeded = 0;
>   	int nr_thp_succeeded = 0;
>   	int nr_thp_failed = 0;
> @@ -1364,6 +1365,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>   		retry = 0;
>   		thp_retry = 0;
> +		nr_retry_pages = 0;
>   
>   		list_for_each_entry_safe(page, page2, from, lru) {
>   			/*
> @@ -1449,12 +1451,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				nr_thp_failed += thp_retry;
>   				if (!no_subpage_counting)
>   					nr_failed += retry;
> +				nr_failed_pages += nr_retry_pages;

Can you move this a little forward to update 'nr_failed_pages' in one 
place, which seems more readable?
nr_failed_pages += nr_subpages + nr_retry_pages;

Otherwise,
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   				goto out;
>   			case -EAGAIN:
>   				if (is_thp)
>   					thp_retry++;
>   				else
>   					retry++;
> +				nr_retry_pages += nr_subpages;
>   				break;
>   			case MIGRATEPAGE_SUCCESS:
>   				nr_succeeded += nr_subpages;
> @@ -1481,6 +1485,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	if (!no_subpage_counting)
>   		nr_failed += retry;
>   	nr_thp_failed += thp_retry;
> +	nr_failed_pages += nr_retry_pages;
>   	/*
>   	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
>   	 * counting in this round, since all subpages of a THP is counted
