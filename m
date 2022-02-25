Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AEF4C3BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiBYCc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiBYCcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:32:55 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8068D18887A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 18:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645756344; x=1677292344;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Te4PHcJ/B1DO1cDp06aZcLXva0MLz3mhGNrCcZ9Dsz0=;
  b=PJBlVr7vINRFPddenXJ3mjTg0bm2YooVqP58uH5s8AOI9C6dR0I4ppBq
   xFyZRftht6tpW56/+wCaUTPGkcJNErJiRZijxyC7+aFjeurpsNPBsx5c6
   2niwDlElVtCyrDbeARXf5Y2qqygVeKH8yHC9GiHtXhsz01Au4ybyQE5LR
   9T4/R6kt/vGKbUDXy2dDvz3eZ0xBXOkZTE04day/L4zTxr+DmkUvnXmsZ
   nJc/tCuvii1Kn4U4wWckC4F4811YxDie5JsPqvbWATTg5xFdsFnQhQjyy
   +HSdFYWRTRkHiiHgYotyGYwbHGCpMs5sLemWi3Pz9VZkqbJM/u0D2xc5s
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="277035410"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="277035410"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 18:32:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="628702227"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 18:32:21 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -V11 2/9] mm/migrate: update node demotion order on
 hotplug events
References: <20210721063926.3024591-1-ying.huang@intel.com>
        <20210721063926.3024591-2-ying.huang@intel.com>
        <eb438ddd-2919-73d4-bd9f-b7eecdd9577a@linux.vnet.ibm.com>
        <f5edb9dc-8b25-47c2-9905-09e88e41861b@intel.com>
        <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
Date:   Fri, 25 Feb 2022 10:32:20 +0800
In-Reply-To: <4e8067e1-0574-c9d2-9d6c-d676d32071bd@linux.vnet.ibm.com>
        (Abhishek Goel's message of "Fri, 25 Feb 2022 05:07:15 +0530")
Message-ID: <87pmnb3ccr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Abhishek,

Abhishek Goel <huntbag@linux.vnet.ibm.com> writes:

> On 24/02/22 05:35, Dave Hansen wrote:
>> On 2/23/22 15:02, Abhishek Goel wrote:
>>> If needed, I will provide experiment results and traces that were used
>>> to conclude this.
>> It would be great if you can provide some more info.  Even just a CPU
>> time profile would be helpful.
>
> Average total time taken for SMT=8 to SMT=1 in v5.14 : 20s
>
> Average total time taken for SMT=8 to SMT=1 in v5.15 : 36s
>
> (Observed in system with 150+ CPUs )

We have run into a memory hotplug regression before.  Let's check
whether the problem is similar.  Can you try the below debug patch?

Best Regards,
Huang, Ying

----------------------------8<------------------------------------------
From 500c0b53436b7a697ed5d77241abbc0d5d3cfc07 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Wed, 29 Sep 2021 10:57:19 +0800
Subject: [PATCH] mm/migrate: Debug CPU hotplug regression

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/migrate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..c4805f15e616 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -3261,15 +3261,17 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
  * The ordering is also currently dependent on which nodes have
  * CPUs.  That means we need CPU on/offline notification too.
  */
-static int migration_online_cpu(unsigned int cpu)
+static int migration_cpu_hotplug(unsigned int cpu)
 {
-	set_migration_target_nodes();
-	return 0;
-}
+	static int nr_cpu_node_saved;
+	int nr_cpu_node;
+
+	nr_cpu_node = num_node_state(N_CPU);
+	if (nr_cpu_node != nr_cpu_node_saved) {
+		set_migration_target_nodes();
+		nr_cpu_node_saved = nr_cpu_node;
+	}
 
-static int migration_offline_cpu(unsigned int cpu)
-{
-	set_migration_target_nodes();
 	return 0;
 }
 
@@ -3283,7 +3285,7 @@ static int __init migrate_on_reclaim_init(void)
 	WARN_ON(!node_demotion);
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
-					NULL, migration_offline_cpu);
+					NULL, migration_cpu_hotplug);
 	/*
 	 * In the unlikely case that this fails, the automatic
 	 * migration targets may become suboptimal for nodes
@@ -3292,7 +3294,7 @@ static int __init migrate_on_reclaim_init(void)
 	 */
 	WARN_ON(ret < 0);
 	ret = cpuhp_setup_state(CPUHP_AP_MM_DEMOTION_ONLINE, "mm/demotion:online",
-				migration_online_cpu, NULL);
+				migration_cpu_hotplug, NULL);
 	WARN_ON(ret < 0);
 
 	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
-- 
2.30.2

