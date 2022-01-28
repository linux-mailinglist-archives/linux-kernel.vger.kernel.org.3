Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB72349FC6B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349231AbiA1PGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbiA1PGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:06:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A16C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w0bbA2wx4VLIy7p5KNHMCRGCljhsQ9ND3jOuThJZUKU=; b=ZrnYrLOu+882dYBAZoJyPAbF9g
        lPCb3s9wVPJoPXy9LA4dD/m/DZzKhD7/aI+khha2YTytW8dSj5UYHL+5WCdm5MgfLSXmz6j73E6GZ
        Z+2AzhaDRJ0PtSoB44Dt961ZhJC5qrr9MQlR/1NjuyHUhdeDqvIOz1hdbW+N8z+LHgxkFy4RXCdjl
        WALw4h6KIMhEN0kukuiLOGlfpjXg7J3mIjJEjrT63Nt5BW1UFX/7aQSefRLX9EGU3TMvo+kIASLW3
        dJNpaPSRqjfoheNg1DeSNMoUqfvuirJrd4P/zbmUkD8Z42V9xAsuQiYBkEsDhWXk0mIDPpqgtcgRT
        5+ktbyeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDSpb-004aN0-Qo; Fri, 28 Jan 2022 15:06:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 009BC30002E;
        Fri, 28 Jan 2022 16:06:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3C112142D5EA; Fri, 28 Jan 2022 16:06:30 +0100 (CET)
Date:   Fri, 28 Jan 2022 16:06:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/2] NUMA balancing: fix NUMA topology type for
 memory tiering system
Message-ID: <YfQGdqQy/VrEU32N@hirez.programming.kicks-ass.net>
References: <20220128023842.1946583-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128023842.1946583-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:38:41AM +0800, Huang Ying wrote:
>  kernel/sched/topology.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 9f26e6b651fe..ba975a29d444 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1738,7 +1738,13 @@ void init_numa_topology_type(void)
>  	}
>  
>  	for_each_online_node(a) {
> +		if (!node_state(a, N_CPU))
> +			continue;
> +
>  		for_each_online_node(b) {
> +			if (!node_state(b, N_CPU))
> +				continue;
> +
>  			/* Find two nodes furthest removed from each other. */
>  			if (node_distance(a, b) < n)
>  				continue;

I think you forgot some.. by not skipping CPU-less nodes in
sched_init_numa() the whole premise of init_numa_topology_type() goes
out the window as well, by virtue of getting sched_domains_numa_levels
and sched_max_numa_distance wrong.

Did I get them all?

Do we want something like:

#define for_each_possible_cpu_node(n)	for (n = 0; n < nr_node_ids; n++) if (!node_state(n, N_CPU)) continue; else
#define for_each_online_cpu_node(n)	for_each_online_node(n) if (!node_state(n, N_CPU)) continue; else

To clean that up?

---
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1684,8 +1684,12 @@ static void sched_numa_warn(const char *
 
 	for (i = 0; i < nr_node_ids; i++) {
 		printk(KERN_WARNING "  ");
-		for (j = 0; j < nr_node_ids; j++)
-			printk(KERN_CONT "%02d ", node_distance(i,j));
+		for (j = 0; j < nr_node_ids; j++) {
+			if (!node_state(i, N_CPU) || !node_state(j, N_CPU))
+				printk(KERN_CONT "(%02d) ", node_distance(i,j));
+			else
+				printk(KERN_CONT " %02d  ", node_distance(i,j));
+		}
 		printk(KERN_CONT "\n");
 	}
 	printk(KERN_WARNING "\n");
@@ -1737,7 +1741,13 @@ static void init_numa_topology_type(void
 	}
 
 	for_each_online_node(a) {
+		if (!node_state(a, N_CPU))
+			continue;
+
 		for_each_online_node(b) {
+			if (!node_state(b, N_CPU))
+				continue;
+
 			/* Find two nodes furthest removed from each other. */
 			if (node_distance(a, b) < n)
 				continue;
@@ -1756,6 +1766,9 @@ static void init_numa_topology_type(void
 			return;
 		}
 	}
+
+	pr_err("Failed to find a NUMA topology type, defaulting to DIRECT\n");
+	sched_numa_topology_type = NUMA_DIRECT;
 }
 
 
@@ -1778,9 +1791,15 @@ void sched_init_numa(void)
 
 	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
 	for (i = 0; i < nr_node_ids; i++) {
+		if (!node_state(i, N_CPU))
+			continue;
+
 		for (j = 0; j < nr_node_ids; j++) {
 			int distance = node_distance(i, j);
 
+			if (!node_state(j, N_CPU))
+				continue;
+
 			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
 				sched_numa_warn("Invalid distance value range");
 				return;
@@ -1863,6 +1882,12 @@ void sched_init_numa(void)
 				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
 					sched_numa_warn("Node-distance not symmetric");
 
+				if (!node_state(j, N_CPU))
+					continue;
+
+				if (!node_state(j, N_CPU))
+					continue;
+
 				if (node_distance(j, k) > sched_domains_numa_distance[i])
 					continue;
 
@@ -1943,6 +1968,9 @@ static void __sched_domains_numa_masks_s
 			if (!node_online(j) || node == j)
 				continue;
 
+			if (!node_state(j, N_CPU))
+				continue;
+
 			if (node_distance(j, node) > sched_domains_numa_distance[i])
 				continue;
 
@@ -1974,6 +2002,9 @@ void sched_domains_numa_masks_set(unsign
 			if (!node_online(j))
 				continue;
 
+			if (!node_state(j, N_CPU))
+				continue;
+
 			/* Set ourselves in the remote node's masks */
 			if (node_distance(j, node) <= sched_domains_numa_distance[i])
 				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
