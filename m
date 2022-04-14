Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69099500936
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiDNJGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241516AbiDNJFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:05:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8390E6D38B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:02:20 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KfD1h4LJqz67xMh;
        Thu, 14 Apr 2022 17:00:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 14 Apr 2022 11:02:17 +0200
Received: from localhost (10.81.205.215) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 10:02:16 +0100
Date:   Thu, 14 Apr 2022 10:02:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <aneesh.kumar@linux.ibm.com>,
        <baolin.wang@linux.alibaba.com>, <dave.hansen@linux.intel.com>,
        <ying.huang@intel.com>
Subject: Re: [PATCH v2 1/5] mm: demotion: Set demotion list differently
Message-ID: <20220414100214.00005ad8@Huawei.com>
In-Reply-To: <20220413092206.73974-2-jvgediya@linux.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
        <20220413092206.73974-2-jvgediya@linux.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.215]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 14:52:02 +0530
Jagdish Gediya <jvgediya@linux.ibm.com> wrote:

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
>   0:  10  20  40  40  80
>   1:  20  10  40  40  80
>   2:  40  40  10  40  80
>   3:  40  40  40  10  80
>   4:  80  80  80  80  10
> 
> The existing implementation gives below demotion targets,
> 
> node    demotion_target
>  0              3, 2
>  1              4
>  2              X
>  3              X
>  4              X
> 
> With this patch applied, below are the demotion targets,
> 
> node    demotion_target
>  0              3, 2
>  1              3, 2

Is there an easy way to make the allocation stateful enough so
that when it sees two identical choices, it alternates between
them?  Whilst it's going to be workload dependent, my view
of 'ideal' for this would be.

   0              3
   1              2

Maybe we'll just have to make do with most systems this effects
having to have some fun userspace code that does cleverer
balancing - possibly using HMAT info rather than just SLIT
to give us visibility of interconnect bottlenecks that make
some migration paths 'unwise'.
  
I'm not sure the current HMAT presentation via sysfs gives
us enough info though so we'll probably need to extend that.

Jonathan

>  2              4
>  3              4
>  4              X
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
>   0:  10  20  20  40
>   1:  20  10  20  40
>   2:  20  20  10  40
>   3:  40  40  40  10
> 
> The existing implementation gives below demotion targets,
> 
> node    demotion_target
>  0              3
>  1              X
>  2              X
>  3              X
> 
> With this patch applied, below are the demotion targets,
> 
> node    demotion_target
>  0              3
>  1              3
>  2              3
>  3              X
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---
>  mm/migrate.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index de175e2fdba5..516f4e1348c1 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2383,7 +2383,7 @@ static void __set_migration_target_nodes(void)
>  {
>  	nodemask_t next_pass	= NODE_MASK_NONE;
>  	nodemask_t this_pass	= NODE_MASK_NONE;
> -	nodemask_t used_targets = NODE_MASK_NONE;
> +	nodemask_t source_nodes = NODE_MASK_NONE;
>  	int node, best_distance;
>  
>  	/*
> @@ -2401,20 +2401,23 @@ static void __set_migration_target_nodes(void)
>  again:
>  	this_pass = next_pass;
>  	next_pass = NODE_MASK_NONE;
> +
>  	/*
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
>  	 */
> -	nodes_or(used_targets, used_targets, this_pass);
> +	nodes_or(source_nodes, source_nodes, this_pass);
>  
>  	for_each_node_mask(node, this_pass) {
> +		/*
> +		 * To avoid cycles in the migration "graph", ensure
> +		 * that migration sources are not future targets by
> +		 * setting them in 'used_targets'. Reset used_targets
> +		 * to source nodes for each node in this pass so that
> +		 * multiple source nodes can share a target node.
> +		 */
> +		nodemask_t used_targets = source_nodes;
> +
>  		best_distance = -1;
>  
>  		/*

