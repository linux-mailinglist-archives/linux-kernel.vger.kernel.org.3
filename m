Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7924B51FDB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiEINNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbiEINNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:13:16 -0400
Received: from outbound-smtp15.blacknight.com (outbound-smtp15.blacknight.com [46.22.139.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA1A2944AD
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:09:21 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id E12A41C37E0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:09:19 +0100 (IST)
Received: (qmail 19633 invoked from network); 9 May 2022 13:09:19 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 9 May 2022 13:09:19 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 6/6] mm/page_alloc: Remotely drain per-cpu lists
Date:   Mon,  9 May 2022 14:08:05 +0100
Message-Id: <20220509130805.20335-7-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509130805.20335-1-mgorman@techsingularity.net>
References: <20220509130805.20335-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
drain work queued by __drain_all_pages(). So introduce new a mechanism
to remotely drain the per-cpu lists. It is made possible by remotely
locking 'struct per_cpu_pages' new per-cpu spinlocks. A benefit of this
new scheme is that drain operations are now migration safe.

There was no observed performance degradation vs. the previous scheme.
Both netperf and hackbench were run in parallel to triggering the
__drain_all_pages(NULL, true) code path around ~100 times per second.
The new scheme performs a bit better (~5%), although the important point
here is there are no performance regressions vs. the previous mechanism.
Per-cpu lists draining happens only in slow paths.

Link: https://lore.kernel.org/r/20211103170512.2745765-4-nsaenzju@redhat.com
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 59 +++++--------------------------------------------
 1 file changed, 5 insertions(+), 54 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7be21254087c..4ac39d30ec8f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -164,13 +164,7 @@ DEFINE_PER_CPU(int, _numa_mem_);		/* Kernel "local memory" node */
 EXPORT_PER_CPU_SYMBOL(_numa_mem_);
 #endif
 
-/* work_structs for global per-cpu drains */
-struct pcpu_drain {
-	struct zone *zone;
-	struct work_struct work;
-};
 static DEFINE_MUTEX(pcpu_drain_mutex);
-static DEFINE_PER_CPU(struct pcpu_drain, pcpu_drain);
 
 #ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 volatile unsigned long latent_entropy __latent_entropy;
@@ -3090,9 +3084,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  * Called from the vmstat counter updater to drain pagesets of this
  * currently executing processor on remote nodes after they have
  * expired.
- *
- * Note that this function must be called with the thread pinned to
- * a single processor.
  */
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
@@ -3117,10 +3108,6 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 
 /*
  * Drain pcplists of the indicated processor and zone.
- *
- * The processor must either be the current processor and the
- * thread pinned to the current processor or a processor that
- * is not online.
  */
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
@@ -3139,10 +3126,6 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 
 /*
  * Drain pcplists of all zones on the indicated processor.
- *
- * The processor must either be the current processor and the
- * thread pinned to the current processor or a processor that
- * is not online.
  */
 static void drain_pages(unsigned int cpu)
 {
@@ -3155,9 +3138,6 @@ static void drain_pages(unsigned int cpu)
 
 /*
  * Spill all of this CPU's per-cpu pages back into the buddy allocator.
- *
- * The CPU has to be pinned. When zone parameter is non-NULL, spill just
- * the single zone's pages.
  */
 void drain_local_pages(struct zone *zone)
 {
@@ -3169,24 +3149,6 @@ void drain_local_pages(struct zone *zone)
 		drain_pages(cpu);
 }
 
-static void drain_local_pages_wq(struct work_struct *work)
-{
-	struct pcpu_drain *drain;
-
-	drain = container_of(work, struct pcpu_drain, work);
-
-	/*
-	 * drain_all_pages doesn't use proper cpu hotplug protection so
-	 * we can race with cpu offline when the WQ can move this from
-	 * a cpu pinned worker to an unbound one. We can operate on a different
-	 * cpu which is alright but we also have to make sure to not move to
-	 * a different one.
-	 */
-	migrate_disable();
-	drain_local_pages(drain->zone);
-	migrate_enable();
-}
-
 /*
  * The implementation of drain_all_pages(), exposing an extra parameter to
  * drain on all cpus.
@@ -3207,13 +3169,6 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	 */
 	static cpumask_t cpus_with_pcps;
 
-	/*
-	 * Make sure nobody triggers this path before mm_percpu_wq is fully
-	 * initialized.
-	 */
-	if (WARN_ON_ONCE(!mm_percpu_wq))
-		return;
-
 	/*
 	 * Do not drain if one is already in progress unless it's specific to
 	 * a zone. Such callers are primarily CMA and memory hotplug and need
@@ -3263,14 +3218,12 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	}
 
 	for_each_cpu(cpu, &cpus_with_pcps) {
-		struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
-
-		drain->zone = zone;
-		INIT_WORK(&drain->work, drain_local_pages_wq);
-		queue_work_on(cpu, mm_percpu_wq, &drain->work);
+		if (zone) {
+			drain_pages_zone(cpu, zone);
+		} else {
+			drain_pages(cpu);
+		}
 	}
-	for_each_cpu(cpu, &cpus_with_pcps)
-		flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
 
 	mutex_unlock(&pcpu_drain_mutex);
 }
@@ -3279,8 +3232,6 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
  * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
  *
  * When zone parameter is non-NULL, spill just the single zone's pages.
- *
- * Note that this can be extremely slow as the draining happens in a workqueue.
  */
 void drain_all_pages(struct zone *zone)
 {
-- 
2.34.1

