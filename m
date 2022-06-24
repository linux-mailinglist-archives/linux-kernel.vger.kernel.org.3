Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28734559664
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiFXJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiFXJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:22:25 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2316C699AD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:22:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHGdsVJ_1656062539;
Received: from 30.97.49.29(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHGdsVJ_1656062539)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 17:22:20 +0800
Message-ID: <8e55a741-969b-d827-9af0-d793cbc6b2a9@linux.alibaba.com>
Date:   Fri, 24 Jun 2022 17:22:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/7] migrate_pages(): remove unnecessary
 list_safe_reset_next()
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
 <20220624025309.1033400-3-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220624025309.1033400-3-ying.huang@intel.com>
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



On 6/24/2022 10:53 AM, Huang Ying wrote:
> Before commit b5bade978e9b ("mm: migrate: fix the return value of
> migrate_pages()"), the tail pages of THP will be put in the "from"
> list directly.  So one of the loop cursors (page2) needs to be reset,
> as is done in try_split_thp() via list_safe_reset_next().  But after
> the commit, the tail pages of THP will be put in a dedicated
> list (thp_split_pages).  That is, the "from" list will not be changed
> during splitting.  So, it's unnecessary to call list_safe_reset_next()
> anymore.
> 
> This is a code cleanup, no functionality changes are expected.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---

Looks good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


>   mm/migrate.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a271554be7a1..82444e7df9f1 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1300,16 +1300,13 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>   	return rc;
>   }
>   
> -static inline int try_split_thp(struct page *page, struct page **page2,
> -				struct list_head *from)
> +static inline int try_split_thp(struct page *page, struct list_head *split_pages)
>   {
> -	int rc = 0;
> +	int rc;
>   
>   	lock_page(page);
> -	rc = split_huge_page_to_list(page, from);
> +	rc = split_huge_page_to_list(page, split_pages);
>   	unlock_page(page);
> -	if (!rc)
> -		list_safe_reset_next(page, *page2, lru);
>   
>   	return rc;
>   }
> @@ -1413,7 +1410,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				/* THP migration is unsupported */
>   				if (is_thp) {
>   					nr_thp_failed++;
> -					if (!try_split_thp(page, &page2, &thp_split_pages)) {
> +					if (!try_split_thp(page, &thp_split_pages)) {
>   						nr_thp_split++;
>   						goto retry;
>   					}
> @@ -1432,7 +1429,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				 */
>   				if (is_thp && !nosplit) {
>   					nr_thp_failed++;
> -					if (!try_split_thp(page, &page2, &thp_split_pages)) {
> +					if (!try_split_thp(page, &thp_split_pages)) {
>   						nr_thp_split++;
>   						goto retry;
>   					}
