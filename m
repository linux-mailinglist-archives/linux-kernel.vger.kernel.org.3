Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66817559703
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiFXJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiFXJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:51:24 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FE794CA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:51:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHGqj-b_1656064279;
Received: from 30.97.49.29(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHGqj-b_1656064279)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 17:51:19 +0800
Message-ID: <cd8caffe-fe65-f489-32f6-7ad7b46d4419@linux.alibaba.com>
Date:   Fri, 24 Jun 2022 17:51:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/7] migrate_pages(): fix failure counting for THP on
 -ENOSYS
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
 <20220624025309.1033400-6-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220624025309.1033400-6-ying.huang@intel.com>
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
> If THP or hugetlbfs page migration isn't supported, unmap_and_move()
> or unmap_and_move_huge_page() will return -ENOSYS.  For THP, splitting
> will be tried, but if splitting doesn't succeed, the THP will be left
> in "from" list wrongly.  If some other pages are retried, the THP
> migration failure will counted again.  This is fixed via moving the
> failure THP from "from" to "ret_pages".
> 
> Another issue of the original code is that the unsupported failure
> processing isn't consistent between THP and hugetlbfs page.  Make them
> consistent in this patch to make the code easier to be understood too.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/migrate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 61dab3025a1d..9d1883d5927f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1191,10 +1191,8 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>   	 * tables or check whether the hugepage is pmd-based or not before
>   	 * kicking migration.
>   	 */
> -	if (!hugepage_migration_supported(page_hstate(hpage))) {
> -		list_move_tail(&hpage->lru, ret);
> +	if (!hugepage_migration_supported(page_hstate(hpage)))
>   		return -ENOSYS;
> -	}
>   
>   	if (page_count(hpage) == 1) {
>   		/* page was freed from under us. So we are done. */
> @@ -1391,6 +1389,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   			 *		 page will be put back
>   			 *	-EAGAIN: stay on the from list
>   			 *	-ENOMEM: stay on the from list
> +			 *	-ENOSYS: stay on the from list
>   			 *	Other errno: put on ret_pages list then splice to
>   			 *		     from list
>   			 */
> @@ -1420,6 +1419,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				}
>   
>   				nr_failed_pages += nr_subpages;
> +				list_move_tail(&page->lru, &ret_pages);
>   				break;
>   			case -ENOMEM:
>   				/*
