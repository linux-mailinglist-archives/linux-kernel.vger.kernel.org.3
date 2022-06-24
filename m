Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA45596DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiFXJgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiFXJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:36:18 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED05794DD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:36:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHGmXek_1656063365;
Received: from 30.97.49.29(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHGmXek_1656063365)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 17:36:06 +0800
Message-ID: <f484d209-10de-c68b-ceb6-6d6d2b261c3a@linux.alibaba.com>
Date:   Fri, 24 Jun 2022 17:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/7] migrate_pages(): fix THP failure counting for -ENOMEM
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
 <20220624025309.1033400-4-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220624025309.1033400-4-ying.huang@intel.com>
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
> In unmap_and_move(), if the new THP cannot be allocated, -ENOMEM will
> be returned, and migrate_pages() will try to split the THP unless
> "reason" is MR_NUMA_MISPLACED (that is, nosplit == true).  But when
> nosplit == true, the THP migration failure will not be counted.  This
> is incorrect.  So in this patch, the THP migration failure will be
> counted for -ENOMEM regardless of nosplit is true or false.  The
> nr_failed counting is fixed too, although that is not used actually.

No strong opinion about the 'nr_failed' updating, like you said, we did 
not use it in this case. Maybe just add some comments instead of adding 
some unused code? Otherwise looks good to me.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> --- >   mm/migrate.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 82444e7df9f1..542533e4e3cf 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1425,11 +1425,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				/*
>   				 * When memory is low, don't bother to try to migrate
>   				 * other pages, just exit.
> -				 * THP NUMA faulting doesn't split THP to retry.
>   				 */
> -				if (is_thp && !nosplit) {
> +				if (is_thp) {
>   					nr_thp_failed++;
> -					if (!try_split_thp(page, &thp_split_pages)) {
> +					/* THP NUMA faulting doesn't split THP to retry. */
> +					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
>   						nr_thp_split++;
>   						goto retry;
>   					}
> @@ -1446,6 +1446,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				 */
>   				list_splice_init(&thp_split_pages, from);
>   				nr_thp_failed += thp_retry;
> +				if (!no_subpage_counting)
> +					nr_failed += retry;
>   				goto out;
>   			case -EAGAIN:
>   				if (is_thp)
