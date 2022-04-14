Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B05008EE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbiDNI5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiDNI5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:57:11 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE12C116
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:54:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VA1gCSM_1649926482;
Received: from 30.39.165.7(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VA1gCSM_1649926482)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Apr 2022 16:54:43 +0800
Message-ID: <c1383114-494b-e8ff-6bfe-73baf2786a0f@linux.alibaba.com>
Date:   Thu, 14 Apr 2022 16:55:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/5] mm: demotion: Set demotion list differently
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
 <20220413092206.73974-2-jvgediya@linux.ibm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220413092206.73974-2-jvgediya@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 5:22 PM, Jagdish Gediya wrote:
> Sharing used_targets between multiple nodes in a single
> pass limits some of the opportunities for demotion target
> sharing.
> 
> Don't share the used targets between multiple nodes in a
> single pass, instead accumulate all the used targets in
> source nodes shared by all pass, and reset 'used_targets'
> to source nodes while finding demotion targets for any new
> node.
> 
> This results into some more opportunities to share demotion
> targets between multiple source nodes, e.g. with below NUMA
> topology, where node 0 & 1 are cpu + dram nodes, node 2 & 3
> are equally slower memory only nodes, and node 4 is slowest
> memory only node,
> 
> available: 5 nodes (0-4)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus: 2 3
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus:
> node 2 size: n MB
> node 2 free: n MB
> node 3 cpus:
> node 3 size: n MB
> node 3 free: n MB
> node 4 cpus:
> node 4 size: n MB
> node 4 free: n MB
> node distances:
> node   0   1   2   3   4
>    0:  10  20  40  40  80
>    1:  20  10  40  40  80
>    2:  40  40  10  40  80
>    3:  40  40  40  10  80
>    4:  80  80  80  80  10
> 
> The existing implementation gives below demotion targets,
> 
> node    demotion_target
>   0              3, 2
>   1              4
>   2              X
>   3              X
>   4              X
> 
> With this patch applied, below are the demotion targets,
> 
> node    demotion_target
>   0              3, 2
>   1              3, 2
>   2              4
>   3              4
>   4              X
> 
> e.g. with below NUMA topology, where node 0, 1 & 2 are
> cpu + dram nodes and node 3 is slow memory node,
> 
> available: 4 nodes (0-3)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus: 2 3
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 4 5
> node 2 size: n MB
> node 2 free: n MB
> node 3 cpus:
> node 3 size: n MB
> node 3 free: n MB
> node distances:
> node   0   1   2   3
>    0:  10  20  20  40
>    1:  20  10  20  40
>    2:  20  20  10  40
>    3:  40  40  40  10
> 
> The existing implementation gives below demotion targets,
> 
> node    demotion_target
>   0              3
>   1              X
>   2              X
>   3              X
> 
> With this patch applied, below are the demotion targets,
> 
> node    demotion_target
>   0              3
>   1              3
>   2              3
>   3              X
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---

Looks reasonable to me. Please feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/migrate.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index de175e2fdba5..516f4e1348c1 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2383,7 +2383,7 @@ static void __set_migration_target_nodes(void)
>   {
>   	nodemask_t next_pass	= NODE_MASK_NONE;
>   	nodemask_t this_pass	= NODE_MASK_NONE;
> -	nodemask_t used_targets = NODE_MASK_NONE;
> +	nodemask_t source_nodes = NODE_MASK_NONE;
>   	int node, best_distance;
>   
>   	/*
> @@ -2401,20 +2401,23 @@ static void __set_migration_target_nodes(void)
>   again:
>   	this_pass = next_pass;
>   	next_pass = NODE_MASK_NONE;
> +
>   	/*
> -	 * To avoid cycles in the migration "graph", ensure
> -	 * that migration sources are not future targets by
> -	 * setting them in 'used_targets'.  Do this only
> -	 * once per pass so that multiple source nodes can
> -	 * share a target node.
> -	 *
> -	 * 'used_targets' will become unavailable in future
> -	 * passes.  This limits some opportunities for
> -	 * multiple source nodes to share a destination.
> +	 * Accumulate source nodes to avoid the cycle in migration
> +	 * list.
>   	 */
> -	nodes_or(used_targets, used_targets, this_pass);
> +	nodes_or(source_nodes, source_nodes, this_pass);
>   
>   	for_each_node_mask(node, this_pass) {
> +		/*
> +		 * To avoid cycles in the migration "graph", ensure
> +		 * that migration sources are not future targets by
> +		 * setting them in 'used_targets'. Reset used_targets
> +		 * to source nodes for each node in this pass so that
> +		 * multiple source nodes can share a target node.
> +		 */
> +		nodemask_t used_targets = source_nodes;
> +
>   		best_distance = -1;
>   
>   		/*
