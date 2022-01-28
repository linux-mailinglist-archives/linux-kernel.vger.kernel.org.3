Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626C649F121
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiA1CjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:39:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:37426 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345465AbiA1Ci7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:38:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643337539; x=1674873539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jGWDNLJApBDpiyrpidTF3rhrrIpgPU+GfMIe4Z30oQ0=;
  b=CToOSCJoA3nN7cECAlJ332SzdFjgczbZTb80wo068LzQuGZcAl8zf75F
   xCjgNRcTWC79Ib0ydo5LaGGWJOX52R8zCw2vAA0NyhwZDkuoLorzeJzoH
   jlg3ErX1ufI/3nFLNuXp7Qsr3sNaUkxrgimX79d9QwWKm91GWeJDusNah
   sU4mF9TR+OVzsVSu6yHLThYp1dxktqs180m4PYnzkVLfZ6BEDzF3RSNYq
   pA1Hx1w0BgS3t2aCbu5asqkt9GVO0REHZa2N4Dyn5nRRPhsFuMnt/zF+w
   XxWTQXBMqdmxF7vJgYGVTyAdyR/b5YySg1MpUvYShJSMGPMLiF6mExpdf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227696935"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="227696935"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:38:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="535948906"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:38:57 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/2] NUMA balancing: avoid to migrate task to CPU-less node
Date:   Fri, 28 Jan 2022 10:38:42 +0800
Message-Id: <20220128023842.1946583-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128023842.1946583-1-ying.huang@intel.com>
References: <20220128023842.1946583-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a typical memory tiering system, there's no CPU in slow (PMEM) NUMA
nodes.  But if the number of the hint page faults on a PMEM node is
the max for a task, The current NUMA balancing policy may try to place
the task on the PMEM node instead of DRAM node.  This is unreasonable,
because there's no CPU in PMEM NUMA nodes.  To fix this, CPU-less
nodes are ignored when searching the migration target node for a task
in this patch.

To test the patch, we run a workload that accesses more memory in PMEM
node than memory in DRAM node.  Without the patch, the PMEM node will
be chosen as preferred node in task_numa_placement().  While the DRAM
node will be chosen instead with the patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54e1aad1c5d7..e462ac5c1e48 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2393,6 +2393,10 @@ static void task_numa_placement(struct task_struct *p)
 			}
 		}
 
+		/* Cannot migrate task to CPU-less node */
+		if (!node_state(nid, N_CPU))
+			continue;
+
 		if (!ng) {
 			if (faults > max_faults) {
 				max_faults = faults;
-- 
2.30.2

