Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB13149F334
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbiA1F7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:59:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:17301 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235697AbiA1F7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643349591; x=1674885591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y9j8XokzjsNGd2nOqWcvF1wdvX3sTQQLglF93VDFjPA=;
  b=V2qh4zX9+zbaDP8od/+S1uq0X1ZdKwo42IlbkJVs2v2B92YUlw57ZP3I
   tNKRw3sfYbOeQ15XbhLOjMdiToE2Xvw+H0VCMH6QOk4FWXgu+I3MHvJBG
   6xbhO3PuiqkPdE8xTi5SwQoHlJ1VPYjP8GuOPg62eLDgw/ioJ6bom0AtF
   F4/GEEdWW/c0dN1G1KZqlAQ7gPNtXZl+mAKvqwnpbfy07riX/R+Ajtkhm
   jIaawgHz82UaVaf3AgMcJ573c9KjXQ9SiP3EsOHpoSnFbX2bo5loT4gZc
   I1qQDtSrIDGMqiKELvzQadScxG68drQwiKwE1VOHnDJp3Ca3zpGv83Aic
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="245894986"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245894986"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 21:59:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="536004956"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 21:59:48 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
        Yang Shi <shy828301@gmail.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: [PATCH] mm,migrate: fix establishing demotion target
Date:   Fri, 28 Jan 2022 13:59:40 +0800
Message-Id: <20220128055940.1792614-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit ac16ec835314 ("mm: migrate: support multiple target nodes
demotion"), after the first demotion target node is found, we will
continue to check the next candidate obtained via
find_next_best_node().  This is to find all demotion target nodes with
same NUMA distance.  But one side effect of find_next_best_node() is
that the candidate node returned will be set in "used" parameter, even
if the candidate node isn't passed in the following NUMA distance
checking, the candidate node will not be used as demotion target node
for the following nodes.  For example, for system as follows,

node distances:
node   0   1   2   3
  0:  10  21  17  28
  1:  21  10  28  17
  2:  17  28  10  28
  3:  28  17  28  10

when we establish demotion target node for node 0, in the first round
node 2 is added to the demotion target node set.  Then in the second
round, node 3 is checked and failed because distance(0, 3) >
distance(0, 2).  But node 3 is set in "used" nodemask too.  When we
establish demotion target node for node 1, there is no available node.
This is wrong, node 3 should be set as the demotion target of node 1.

To fix this, if the candidate node is failed to pass the distance
checking, it will be cleared in "used" nodemask.  So that it can be
used for the following node.

The bug can be reproduced and fixed with this patch on a 2 socket
server machine with DRAM and PMEM.

Fixes: ac16ec835314 ("mm: migrate: support multiple target nodes demotion")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/migrate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..e8a6933af68d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3082,18 +3082,21 @@ static int establish_migrate_target(int node, nodemask_t *used,
 	if (best_distance != -1) {
 		val = node_distance(node, migration_target);
 		if (val > best_distance)
-			return NUMA_NO_NODE;
+			goto out_clear;
 	}
 
 	index = nd->nr;
 	if (WARN_ONCE(index >= DEMOTION_TARGET_NODES,
 		      "Exceeds maximum demotion target nodes\n"))
-		return NUMA_NO_NODE;
+		goto out_clear;
 
 	nd->nodes[index] = migration_target;
 	nd->nr++;
 
 	return migration_target;
+out_clear:
+	node_clear(migration_target, *used);
+	return NUMA_NO_NODE;
 }
 
 /*
-- 
2.30.2

