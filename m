Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89A74AB324
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 02:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347680AbiBGBhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 20:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbiBGBht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 20:37:49 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD85C043182
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 17:37:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V3inHOV_1644197863;
Received: from 30.21.164.20(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V3inHOV_1644197863)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Feb 2022 09:37:44 +0800
Message-ID: <07970c9c-9816-650b-26ab-ed9aa46d0653@linux.alibaba.com>
Date:   Mon, 7 Feb 2022 09:38:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] mm,migrate: fix establishing demotion target
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
        Yang Shi <shy828301@gmail.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
References: <20220128055940.1792614-1-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220128055940.1792614-1-ying.huang@intel.com>
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



On 1/28/2022 1:59 PM, Huang Ying wrote:
> In commit ac16ec835314 ("mm: migrate: support multiple target nodes
> demotion"), after the first demotion target node is found, we will
> continue to check the next candidate obtained via
> find_next_best_node().  This is to find all demotion target nodes with
> same NUMA distance.  But one side effect of find_next_best_node() is
> that the candidate node returned will be set in "used" parameter, even
> if the candidate node isn't passed in the following NUMA distance
> checking, the candidate node will not be used as demotion target node
> for the following nodes.  For example, for system as follows,
> 
> node distances:
> node   0   1   2   3
>    0:  10  21  17  28
>    1:  21  10  28  17
>    2:  17  28  10  28
>    3:  28  17  28  10
> 
> when we establish demotion target node for node 0, in the first round
> node 2 is added to the demotion target node set.  Then in the second
> round, node 3 is checked and failed because distance(0, 3) >
> distance(0, 2).  But node 3 is set in "used" nodemask too.  When we
> establish demotion target node for node 1, there is no available node.
> This is wrong, node 3 should be set as the demotion target of node 1.
> 
> To fix this, if the candidate node is failed to pass the distance
> checking, it will be cleared in "used" nodemask.  So that it can be
> used for the following node.
> 
> The bug can be reproduced and fixed with this patch on a 2 socket
> server machine with DRAM and PMEM.
> 
> Fixes: ac16ec835314 ("mm: migrate: support multiple target nodes demotion")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
> Cc: Xunlei Pang <xlpang@linux.alibaba.com>
> ---

Good catch. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/migrate.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c7da064b4781..e8a6933af68d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -3082,18 +3082,21 @@ static int establish_migrate_target(int node, nodemask_t *used,
>   	if (best_distance != -1) {
>   		val = node_distance(node, migration_target);
>   		if (val > best_distance)
> -			return NUMA_NO_NODE;
> +			goto out_clear;
>   	}
>   
>   	index = nd->nr;
>   	if (WARN_ONCE(index >= DEMOTION_TARGET_NODES,
>   		      "Exceeds maximum demotion target nodes\n"))
> -		return NUMA_NO_NODE;
> +		goto out_clear;
>   
>   	nd->nodes[index] = migration_target;
>   	nd->nr++;
>   
>   	return migration_target;
> +out_clear:
> +	node_clear(migration_target, *used);
> +	return NUMA_NO_NODE;
>   }
>   
>   /*
