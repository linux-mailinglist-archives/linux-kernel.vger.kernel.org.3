Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3337349F45A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346809AbiA1Hay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:30:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:11836 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242692AbiA1Hax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643355053; x=1674891053;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=4s/YY4fDv/OF06n6oNWa+SaeSxVS4e1wXdQ0vMdNYqs=;
  b=V2Fd9IMvg12PDfqdPTZ0QdiXxybTuTab85JS53byMnpdQ0w75UD7wnaQ
   /MS6loi/4q39j+D/SsA10Ow5mm0w+C46ppXobHMAuTHiPu2I2w5f0T5fT
   jzOPdWbToosJUFjuuu/hJhPCdJM7OGnjbcEMa9GLh/Qtkq67MunAzarDa
   M0DG/P+sGbmGgwIGGIz5g6IHCkYRSd/JriO4CT0e5g4b8egl9VPi4+Iy/
   d1YBCszh+nHklwPxltiE9u3hl96F3702EGPw9d6pEozeESrKNGehT50t5
   xZQsEhuXqEB2fa1OAVzyLX7MQrrzw2U6ZX5pNn/Hb0r6DcAiEMKq4eLCa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="245908944"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="245908944"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:30:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="618639528"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:30:51 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 1/2] NUMA balancing: fix NUMA topology type for
 memory tiering system
References: <20220128023842.1946583-1-ying.huang@intel.com>
        <20220128052345.GA618915@linux.vnet.ibm.com>
Date:   Fri, 28 Jan 2022 15:30:50 +0800
In-Reply-To: <20220128052345.GA618915@linux.vnet.ibm.com> (Srikar Dronamraju's
        message of "Fri, 28 Jan 2022 10:53:45 +0530")
Message-ID: <87czkctiz9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:

> * Huang Ying <ying.huang@intel.com> [2022-01-28 10:38:41]:
>
>> 
>> One possible fix is to ignore CPU-less nodes when detecting NUMA
>> topology type in init_numa_topology_type().  That works well for the
>> example system.  Is it good in general for any system with CPU-less
>> nodes?
>> 
>
> A CPUless node at the time online doesn't necessarily mean a CPUless node
> for the entire boot. For example: On PowerVM Lpars, aka powerpc systems,
> some of the nodes may start as CPUless nodes and then CPUS may get
> populated/hotplugged on them.

Got it!

> Hence I am not sure if adding a check for CPUless nodes at node online may
> work for such systems.

How about something as below?

Best Regards,
Huang, Ying

-----------------------8<-----------------------------

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..733e8bd930b4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1737,7 +1737,13 @@ static void init_numa_topology_type(void)
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
@@ -1849,6 +1855,13 @@ void sched_init_numa(void)
 
 			sched_domains_numa_masks[i][j] = mask;
 
+			/*
+			 * The mask will be initialized when the first CPU of
+			 * the node is onlined.
+			 */
+			if (!node_state(j, N_CPU))
+				continue;
+
 			for_each_node(k) {
 				/*
 				 * Distance information can be unreliable for
@@ -1919,8 +1932,10 @@ void sched_init_numa(void)
 		return;
 
 	bitmap_zero(sched_numa_onlined_nodes, nr_node_ids);
-	for_each_online_node(i)
-		bitmap_set(sched_numa_onlined_nodes, i, 1);
+	for_each_online_node(i) {
+		if (node_state(i, N_CPU))
+			bitmap_set(sched_numa_onlined_nodes, i, 1);
+	}
 }
 
 static void __sched_domains_numa_masks_set(unsigned int node)
@@ -1928,7 +1943,7 @@ static void __sched_domains_numa_masks_set(unsigned int node)
 	int i, j;
 
 	/*
-	 * NUMA masks are not built for offline nodes in sched_init_numa().
+	 * NUMA masks are not built for offline/CPU-less nodes in sched_init_numa().
 	 * Thus, when a CPU of a never-onlined-before node gets plugged in,
 	 * adding that new CPU to the right NUMA masks is not sufficient: the
 	 * masks of that CPU's node must also be updated.
