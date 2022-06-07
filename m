Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B71540548
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346243AbiFGRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345908AbiFGRUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:20:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FBD1059CD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:19:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 68so5266419qkk.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B40CAOPNKx6FosKkgx8Sn1GvdpGsCwJS/mpfQYxiuiU=;
        b=50Inq7CuuEysf5xhWcqm9gAs6sI6704qwg0S1Lh6vywa6dC6vOUP8/UgVPimMwY9cr
         UAwXIMpVTM8c6DQCXPccQmZeUCOVn2meqpHOtNTduTpHpqSS7+M81b6kS7UrbsrGwL+D
         SzM29xyZ7S26aMEB/ARAbWYVNW3WTk9j8VTtdajFZZckl+8W+LfsT2GfmLA6+dSWf6IE
         X4z68tfD8MmN1b7EshT/Eiu8ON7Fnc9REcgAPE+dYANKGSIiZn7ACXrx92aE0YRmJPuG
         UHmG2rcUuKYFcHD/mrPHaJc3pN1Ttucy45QE9m9RGWMjMFwTRl87h+q3GP7nfbRtaByA
         2DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B40CAOPNKx6FosKkgx8Sn1GvdpGsCwJS/mpfQYxiuiU=;
        b=J9W/GFJV6vsPGWXSOwKhenpUUFQW9Xhjw8+UBix/6yoo0kr2LYVxC5e67zmqPugCUw
         udHWgdppyftJ0R7tE/KVY+2GRF6gdbtHOM217+hE055Zc/ofjvj1zzbJ66a7u9op+NPS
         1bHKCGbiGIuv+POi1dDrWzdWAsqE6YP4/i2FKMEv+49Ukna2dn3Oc6jUVvA4jbr4TFgc
         H9STBAfg5PnjIcXdAc5vcrJrD0pD25lPQPBbTLbEtn3Ss95W8alx/tdv+m3AFSDZ0ksr
         E1CJ6v3ozGVhlOmu0Uf40ZiGQ2hGd1G9Kw7PUuzClOUn+WqvLLnXVm5w27Jf+Hg85zCg
         929A==
X-Gm-Message-State: AOAM533Yio0RZNsKHRS83Qa13VEeTVVDB66iv1crkArSFK6klK2ZGMkc
        JQZcXdnmj3Hcj3nhdKDvAgQqxA==
X-Google-Smtp-Source: ABdhPJyky38dvmUZ07/jxhgn/xNDkKj3xPi9pMFpXIOzgllYrHv+qHp/XfeepH8R53ED+nqoV7SOqw==
X-Received: by 2002:ae9:e910:0:b0:6a6:ae7c:ef25 with SMTP id x16-20020ae9e910000000b006a6ae7cef25mr12012368qkf.343.1654622390180;
        Tue, 07 Jun 2022 10:19:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4759])
        by smtp.gmail.com with ESMTPSA id bm32-20020a05620a19a000b006a6d20386f6sm2976696qkb.42.2022.06.07.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:19:49 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Hao Wang <haowang3@fb.com>, Abhishek Dhanotia <abhishekd@fb.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Hasan Al Maruf <hasanalmaruf@fb.com>
Subject: [PATCH] mm: mempolicy: N:M interleave policy for tiered memory nodes
Date:   Tue,  7 Jun 2022 13:19:49 -0400
Message-Id: <20220607171949.85796-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hasan Al Maruf <hasanalmaruf@fb.com>

Existing interleave policy spreads out pages evenly across a set of
specified nodes, i.e. 1:1 interleave. Upcoming tiered memory systems
have CPU-less memory nodes with different peak bandwidth and
latency-bandwidth characteristics. In such systems, we will want to
use the additional bandwidth provided by lowtier memory for
bandwidth-intensive applications. However, the default 1:1 interleave
can lead to suboptimal bandwidth distribution.

Introduce an N:M interleave policy, where N pages allocated to the
top-tier nodes are followed by M pages allocated to lowtier nodes.
This provides the capability to steer the fraction of memory traffic
that goes to toptier vs. lowtier nodes. For example, 4:1 interleave
leads to an 80%/20% traffic breakdown between toptier and lowtier.

The ratios are configured through a new sysctl:

	vm.numa_tier_interleave = toptier lowtier

We have run experiments on bandwidth-intensive production services on
CXL-based tiered memory systems, where lowtier CXL memory has, when
compared to the toptier memory directly connected to the CPU:

	- ~half of the peak bandwidth
	- ~80ns higher idle latency
	- steeper latency vs. bandwidth curve

Results show that regular interleaving leads to a ~40% performance
regression over baseline; 5:1 interleaving shows an ~8% improvement
over baseline. We have found the optimal distribution changes based on
hardware characteristics: slower CXL memory will shift the optimal
breakdown from 5:1 to (e.g.) 8:1.

The sysctl only applies to processes and vmas with an "interleave"
policy and has no bearing on contexts using prefer or bind policies.

It defaults to a setting of "1 1", which represents even interleaving,
and so is backward compatible with existing setups.

Signed-off-by: Hasan Al Maruf <hasanalmaruf@fb.com>
Signed-off-by: Hao Wang <haowang3@fb.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/sysctl/vm.rst | 16 ++++++
 include/linux/mempolicy.h               |  2 +
 include/linux/sched.h                   |  1 +
 kernel/sysctl.c                         | 10 ++++
 mm/mempolicy.c                          | 67 +++++++++++++++++++++++--
 5 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 747e325ebcd0..0247a828ec50 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -55,6 +55,7 @@ files can be found in mm/swap.c.
 - nr_hugepages_mempolicy
 - nr_overcommit_hugepages
 - nr_trim_pages         (only if CONFIG_MMU=n)
+- numa_tier_interleave
 - numa_zonelist_order
 - oom_dump_tasks
 - oom_kill_allocating_task
@@ -597,6 +598,21 @@ The default value is 1.
 See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 
+numa_tier_interleave
+====================
+
+This sysctl is for tiered NUMA systems. It's a tuple that configures
+an N:M distribution between toptier and lowtier nodes for interleaving
+memory allocation policies.
+
+The first value configures the share of pages allocated on toptier
+nodes. The second value configures the share of lowtier placements.
+
+Allowed values range from 1 up to (and including) 100.
+
+The default value is 1 1, meaning even distribution.
+
+
 numa_zonelist_order
 ===================
 
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 668389b4b53d..4bd0f2a67052 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -54,6 +54,8 @@ struct mempolicy {
 	} w;
 };
 
+extern int numa_tier_interleave[2];
+
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index fc42f7213dd9..7351cf31579b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1236,6 +1236,7 @@ struct task_struct {
 	/* Protected by alloc_lock: */
 	struct mempolicy		*mempolicy;
 	short				il_prev;
+	short				il_count;
 	short				pref_node_fork;
 #endif
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 50870a1db114..cfb238c6e0da 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -21,6 +21,7 @@
 
 #include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
@@ -2139,6 +2140,15 @@ static struct ctl_table vm_table[] = {
 		.extra1			= SYSCTL_ZERO,
 		.extra2			= SYSCTL_ONE,
 	},
+	{
+		.procname	= "numa_tier_interleave",
+		.data		= &numa_tier_interleave,
+		.maxlen		= sizeof(numa_tier_interleave),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
 #endif
 	 {
 		.procname	= "hugetlb_shm_group",
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e4a409b8ac0b..3b532536cd44 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -120,6 +120,9 @@ static struct kmem_cache *sn_cache;
    policied. */
 enum zone_type policy_zone = 0;
 
+/* Toptier:lowtier interleaving ratio */
+int numa_tier_interleave[2] = { 1, 1 };
+
 /*
  * run-time system-wide default policy => local allocation
  */
@@ -871,8 +874,10 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	task_lock(current);
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && new->mode == MPOL_INTERLEAVE) {
 		current->il_prev = MAX_NUMNODES-1;
+		current->il_count = 0;
+	}
 	task_unlock(current);
 	mpol_put(old);
 	ret = 0;
@@ -1881,15 +1886,47 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 	return nd;
 }
 
+static unsigned next_node_tier(int nid, struct mempolicy *policy, bool toptier)
+{
+	unsigned next, start = nid;
+
+	do {
+		next = next_node_in(next, policy->nodes);
+		if (next == MAX_NUMNODES)
+			break;
+		if (toptier == node_is_toptier(next))
+			break;
+	} while (next != start);
+	return next;
+}
+
 /* Do dynamic interleaving for a process */
 static unsigned interleave_nodes(struct mempolicy *policy)
 {
 	unsigned next;
 	struct task_struct *me = current;
 
-	next = next_node_in(me->il_prev, policy->nodes);
+	if (numa_tier_interleave[0] > 1 || numa_tier_interleave[1] > 1) {
+		/*
+		 * When N:M interleaving is configured, allocate N
+		 * pages over toptier nodes first, then the remainder
+		 * on lowtier ones.
+		 */
+		if (me->il_count < numa_tier_interleave[0])
+			next = next_node_tier(me->il_prev, policy, true);
+		else
+			next = next_node_tier(me->il_prev, policy, false);
+		me->il_count++;
+		if (me->il_count >=
+		    numa_tier_interleave[0] + numa_tier_interleave[1])
+			me->il_count = 0;
+	} else {
+		next = next_node_in(me->il_prev, policy->nodes);
+	}
+
 	if (next < MAX_NUMNODES)
 		me->il_prev = next;
+
 	return next;
 }
 
@@ -1963,7 +2000,31 @@ static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 	nnodes = nodes_weight(nodemask);
 	if (!nnodes)
 		return numa_node_id();
-	target = (unsigned int)n % nnodes;
+
+	if (numa_tier_interleave[0] > 1 || numa_tier_interleave[1] > 1) {
+		unsigned vnnodes = 0;
+		int vtarget;
+
+		/*
+		 * When N:M interleaving is configured, calculate a
+		 * virtual target for @n in an N:M-scaled nodelist...
+		 */
+		for_each_node_mask(nid, nodemask)
+			vnnodes += numa_tier_interleave[!node_is_toptier(nid)];
+		vtarget = (int)((unsigned int)n % vnnodes);
+
+		/* ...then map it back to the physical nodelist */
+		target = 0;
+		for_each_node_mask(nid, nodemask) {
+			vtarget -= numa_tier_interleave[!node_is_toptier(nid)];
+			if (vtarget < 0)
+				break;
+			target++;
+		}
+	} else {
+		target = (unsigned int)n % nnodes;
+	}
+
 	nid = first_node(nodemask);
 	for (i = 0; i < target; i++)
 		nid = next_node(nid, nodemask);
-- 
2.36.1

