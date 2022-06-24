Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86075596FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiFXJpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiFXJpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:45:50 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2C379452
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:45:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHGe-V2_1656063944;
Received: from 30.97.49.29(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHGe-V2_1656063944)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 17:45:44 +0800
Message-ID: <f2e1ea63-d0ca-7a80-fc16-90622ef2017d@linux.alibaba.com>
Date:   Fri, 24 Jun 2022 17:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/7] migrate_pages(): fix failure counting for THP
 subpages retrying
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
References: <20220624025309.1033400-1-ying.huang@intel.com>
 <20220624025309.1033400-5-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220624025309.1033400-5-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2022 10:53 AM, Huang Ying wrote:
> If THP is failed to be migrated for -ENOSYS and -ENOMEM, the THP will
> be split into thp_split_pages, and after other pages are migrated,
> pages in thp_split_pages will be migrated with no_subpage_counting ==
> true, because its failure have been counted already.  If some pages in
> thp_split_pages are retried during migration, we should not count
> their failure if no_subpage_counting == true too.  This is done this
> patch to fix the failure counting for THP subpages retrying.

Good catch. Totally agree with you. It seems we can move the condition 
into -EAGAIN case like other cases did?

diff --git a/mm/migrate.c b/mm/migrate.c
index 1ece23d80bc4..491c2d07402b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1463,7 +1463,7 @@ int migrate_pages(struct list_head *from, 
new_page_t get_new_page,
                         case -EAGAIN:
                                 if (is_thp)
                                         thp_retry++;
-                               else
+                               else if (!no_subpage_counting)
                                         retry++;
                                 break;

Anyway this patch looks good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Fixes: 5984fabb6e82 ("mm: move_pages: report the number of non-attempted pages")
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> --- >   mm/migrate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 542533e4e3cf..61dab3025a1d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1477,7 +1477,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   			}
>   		}
>   	}
> -	nr_failed += retry;
> +	if (!no_subpage_counting)
> +		nr_failed += retry;
>   	nr_thp_failed += thp_retry;
>   	/*
>   	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
