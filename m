Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635954B5426
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355584AbiBNPGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:06:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355579AbiBNPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:06:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AADB84F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KmR1+6vP0FVqfQDpbnK0oOnb37vqCIuXQisrkcgNytM=; b=jxgmpMk67pTM5hwrSwR7APewjp
        B179ciCrgaJCyunLbJ6RzLTMRuYVpPJlsiZts0rtbz3SqWWR1BcEnWBO5EGgUaewvtVD48sF1/uNy
        he2zmcwECLTSqcPreDBwLeS2gbfSANXDTbldXRWL3nj553ndWboaus1aOAovJxi89qGLgaQqJxo2d
        n4kj5csOhGA9lZIkcfmzcAWi/oh/WL46qQ+PLdeCP1VQfstnoXsbZg14MQt0Hl9P6V4o4X2kp9u8P
        r+M4AcLcUBt0zX9JvkYekQtchc+/qjCL2M9HstLwqbCCuCPG9zkIDInx+TiBYAIOv0EAo6cy9CaC0
        /Rvk35GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJcvD-00D0e8-Ca; Mon, 14 Feb 2022 15:05:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C034300470;
        Mon, 14 Feb 2022 16:05:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 033EC2B397C73; Mon, 14 Feb 2022 16:05:44 +0100 (CET)
Date:   Mon, 14 Feb 2022 16:05:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 1/2] NUMA balancing: fix NUMA topology for systems
 with CPU-less nodes
Message-ID: <YgpvyE7oV1lZDRQL@hirez.programming.kicks-ass.net>
References: <20220214121553.582248-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214121553.582248-1-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 08:15:52PM +0800, Huang Ying wrote:

> This isn't a practical problem now yet.  Because the PMEM nodes (node
> 2 and node 3 in example system) are offlined by default during system
> boot.  So init_numa_topology_type() called during system boot will
> ignore them and set sched_numa_topology_type to NUMA_DIRECT.  And
> init_numa_topology_type() is only called at runtime when a CPU of a
> never-onlined-before node gets plugged in.  And there's no CPU in the
> PMEM nodes.  But it appears better to fix this to make the code more
> robust.

IIRC there are pre-existing issues with this; namely the distance_map is
created for all nodes, online or not, therefore the levels and
max_distance include the pmem stuff.

At the same time, the numa_topolog_type() uses those values, and the
only reason it 'worked' is because the combination of arguments fails to
hit any of the existing types and exits without setting a type,
defaulting to NUMA_DIRECT by 'accident' of that being type 0 and
bss/data being 0 initialized.

Also, Power (and possibly other architectures) already have CPU-less
nodes and are similarly suffering issues.

Anyway, aside from this the patches look like they should do.

There's a few niggles, like using READ_ONCE() on sched_max_numa_distance
without using WRITE_ONCE() (see below) and having
sched_domains_numa_distance and sched_domains_numa_masks separate RCU
variables (that could go side-ways if there were a function using both,
afaict there isn't and I couldn't be bothered changing that, but it's
something to keep in mind).

I'll go queue these, thanks!

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1259,11 +1259,10 @@ static bool numa_is_active_node(int nid,
 
 /* Handle placement on systems where not all nodes are directly connected. */
 static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
-					int maxdist, bool task)
+					int lim_dist, bool task)
 {
 	unsigned long score = 0;
-	int node;
-	int sys_max_dist;
+	int node, max_dist;
 
 	/*
 	 * All nodes are directly connected, and the same distance
@@ -1273,7 +1272,7 @@ static unsigned long score_nearby_nodes(
 		return 0;
 
 	/* sched_max_numa_distance may be changed in parallel. */
-	sys_max_dist = READ_ONCE(sched_max_numa_distance);
+	max_dist = READ_ONCE(sched_max_numa_distance);
 	/*
 	 * This code is called for each node, introducing N^2 complexity,
 	 * which should be ok given the number of nodes rarely exceeds 8.
@@ -1286,7 +1285,7 @@ static unsigned long score_nearby_nodes(
 		 * The furthest away nodes in the system are not interesting
 		 * for placement; nid was already counted.
 		 */
-		if (dist >= sys_max_dist || node == nid)
+		if (dist >= max_dist || node == nid)
 			continue;
 
 		/*
@@ -1296,8 +1295,7 @@ static unsigned long score_nearby_nodes(
 		 * "hoplimit", only nodes closer by than "hoplimit" are part
 		 * of each group. Skip other nodes.
 		 */
-		if (sched_numa_topology_type == NUMA_BACKPLANE &&
-					dist >= maxdist)
+		if (sched_numa_topology_type == NUMA_BACKPLANE && dist >= lim_dist)
 			continue;
 
 		/* Add up the faults from nearby nodes. */
@@ -1315,8 +1313,8 @@ static unsigned long score_nearby_nodes(
 		 * This seems to result in good task placement.
 		 */
 		if (sched_numa_topology_type == NUMA_GLUELESS_MESH) {
-			faults *= (sys_max_dist - dist);
-			faults /= (sys_max_dist - LOCAL_DISTANCE);
+			faults *= (max_dist - dist);
+			faults /= (max_dist - LOCAL_DISTANCE);
 		}
 
 		score += faults;
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1927,7 +1927,7 @@ void sched_init_numa(int offline_node)
 	sched_domain_topology = tl;
 
 	sched_domains_numa_levels = nr_levels;
-	sched_max_numa_distance = sched_domains_numa_distance[nr_levels - 1];
+	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
 
 	init_numa_topology_type(offline_node);
 }
