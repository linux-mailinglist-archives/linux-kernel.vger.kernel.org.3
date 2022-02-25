Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A184C3AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiBYB3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiBYB25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:28:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F1A2692F0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:28:25 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d6994a6942so16471507b3.17
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nSVgqst5mSmdhw3YJIrTrUxerdH7caMZuFeEoIooKGc=;
        b=Y8qTUzJEPu0cZM4MWSRk9NNpHXBCj85jmGCMKnxfJKJX/O5s1htQ5oBiqGttdASHEG
         6o1MwSahaNOYid11pIf3FGoNZxqCeUTCw16iMZWjBVYKkG+qjE0FQOgHx9bdNLFTQFe3
         FySYHskBj5q5ZT8r8WtaaUr+qG66yMbHOO8Tr/oU6WTs3eg7hys+rVwbS4hkdzagJUP1
         P7y+gGQnowxsQq2HrARnvJw4+AVFbOo2mvGwiSsfFFJdjNkywO3SVL2H+zweAKeF8/Kc
         E21an+mpgeuNpWKJu6Il7Z599UIBPVTDb+M5UZlao/FTqRJY4DyOvhOyNGw2Jsmj5qID
         gz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nSVgqst5mSmdhw3YJIrTrUxerdH7caMZuFeEoIooKGc=;
        b=0EXSX13RqX/Z4n7b/MZ+Ef2S9gIk6fPhBXzVZTotn3wq7RHGJcZ86FZkstXxs7MT7P
         ZcLVgk3d+B2fVBe+J4rqYQ0+r1vDHJG4Gh2tV0Xj5sy/hpdPva+gJiarCbyoGeWpTaB2
         HlQcVt31nnfEYWI5SoajdBMGLku1ENVGB02ii/uSW8NiCjLhwZHgKHsCT7hYayr9tin3
         syPeN4c5D6W+o5fC3XcawL4clnvcebNVOw3DvypkQQ78x0OWVx3c+KpOFTuUbFmX81KU
         PrVskBYiLwCCTbO3KYErGEjgJtD9aBVRyP/btTVmWunJsJqKTk5ygr6B3lEY39Jo6oH7
         kKUg==
X-Gm-Message-State: AOAM5338mLkmmGtdSWL1AcRAXZLGBO3xIY+aZoAQAz0JYOLb2Qux1svR
        IXeyl2/dNi3fKzEYXqIi4pQvgiyqgrc=
X-Google-Smtp-Source: ABdhPJwnuwg0PWcn/FSMQlK7a8GeK8/21XvvB54y76rugIMwpGJ/JTM5lGlHEsWqABycqYFI2YdyOeT7XmM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1c5c:1806:c1bc:a422])
 (user=surenb job=sendgmr) by 2002:a25:80c6:0:b0:624:4ef6:abeb with SMTP id
 c6-20020a2580c6000000b006244ef6abebmr5011585ybm.394.1645752504429; Thu, 24
 Feb 2022 17:28:24 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:28:19 -0800
Message-Id: <20220225012819.1807147-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in drain_all_pages
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@suse.com, pmladek@suse.com,
        peterz@infradead.org, guro@fb.com, shakeelb@google.com,
        minchan@kernel.org, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending as an RFC to confirm if this is the right direction and to
clarify if other tasks currently executed on mm_percpu_wq should be
also moved to kthreads. The patch seems stable in testing but I want
to collect more performance data before submitting a non-RFC version.


Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
list during direct reclaim. The tasks on a workqueue can be delayed
by other tasks in the workqueues using the same per-cpu worker pool.
This results in sizable delays in drain_all_pages when cpus are highly
contended.
Memory management operations designed to relieve memory pressure should
not be allowed to block by other tasks, especially if the task in direct
reclaim has higher priority than the blocking tasks.
Replace the usage of mm_percpu_wq with per-cpu low priority FIFO
kthreads to execute draining tasks.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/page_alloc.c | 84 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..c9ab2cf4b05b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -153,7 +153,8 @@ EXPORT_PER_CPU_SYMBOL(_numa_mem_);
 /* work_structs for global per-cpu drains */
 struct pcpu_drain {
 	struct zone *zone;
-	struct work_struct work;
+	struct kthread_work work;
+	struct kthread_worker *worker;
 };
 static DEFINE_MUTEX(pcpu_drain_mutex);
 static DEFINE_PER_CPU(struct pcpu_drain, pcpu_drain);
@@ -2209,6 +2210,58 @@ _deferred_grow_zone(struct zone *zone, unsigned int order)
 
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+static void drain_local_pages_func(struct kthread_work *work);
+
+static int alloc_drain_worker(unsigned int cpu)
+{
+	struct pcpu_drain *drain;
+
+	mutex_lock(&pcpu_drain_mutex);
+	drain = per_cpu_ptr(&pcpu_drain, cpu);
+	drain->worker = kthread_create_worker_on_cpu(cpu, 0, "pg_drain/%u", cpu);
+	if (IS_ERR(drain->worker)) {
+		drain->worker = NULL;
+		pr_err("Failed to create pg_drain/%u\n", cpu);
+		goto out;
+	}
+	/* Ensure the thread is not blocked by normal priority tasks */
+	sched_set_fifo_low(drain->worker->task);
+	kthread_init_work(&drain->work, drain_local_pages_func);
+out:
+	mutex_unlock(&pcpu_drain_mutex);
+
+	return 0;
+}
+
+static int free_drain_worker(unsigned int cpu)
+{
+	struct pcpu_drain *drain;
+
+	mutex_lock(&pcpu_drain_mutex);
+	drain = per_cpu_ptr(&pcpu_drain, cpu);
+	kthread_cancel_work_sync(&drain->work);
+	kthread_destroy_worker(drain->worker);
+	drain->worker = NULL;
+	mutex_unlock(&pcpu_drain_mutex);
+
+	return 0;
+}
+
+static void __init init_drain_workers(void)
+{
+	unsigned int cpu;
+
+	for_each_online_cpu(cpu)
+		alloc_drain_worker(cpu);
+
+	if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"page_alloc/drain:online",
+					alloc_drain_worker,
+					free_drain_worker)) {
+		pr_err("page_alloc_drain: Failed to allocate a hotplug state\n");
+	}
+}
+
 void __init page_alloc_init_late(void)
 {
 	struct zone *zone;
@@ -2245,6 +2298,8 @@ void __init page_alloc_init_late(void)
 
 	for_each_populated_zone(zone)
 		set_zone_contiguous(zone);
+
+	init_drain_workers();
 }
 
 #ifdef CONFIG_CMA
@@ -3144,7 +3199,7 @@ void drain_local_pages(struct zone *zone)
 		drain_pages(cpu);
 }
 
-static void drain_local_pages_wq(struct work_struct *work)
+static void drain_local_pages_func(struct kthread_work *work)
 {
 	struct pcpu_drain *drain;
 
@@ -3175,6 +3230,7 @@ static void drain_local_pages_wq(struct work_struct *work)
 static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 {
 	int cpu;
+	struct pcpu_drain *drain;
 
 	/*
 	 * Allocate in the BSS so we won't require allocation in
@@ -3182,13 +3238,6 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
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
@@ -3238,14 +3287,21 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	}
 
 	for_each_cpu(cpu, &cpus_with_pcps) {
-		struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
+		drain = per_cpu_ptr(&pcpu_drain, cpu);
 
 		drain->zone = zone;
-		INIT_WORK(&drain->work, drain_local_pages_wq);
-		queue_work_on(cpu, mm_percpu_wq, &drain->work);
+		if (likely(drain->worker))
+			kthread_queue_work(drain->worker, &drain->work);
+	}
+	/* Wait for kthreads to finish or drain itself */
+	for_each_cpu(cpu, &cpus_with_pcps) {
+		drain = per_cpu_ptr(&pcpu_drain, cpu);
+
+		if (likely(drain->worker))
+			kthread_flush_work(&drain->work);
+		else
+			drain_local_pages_func(&drain->work);
 	}
-	for_each_cpu(cpu, &cpus_with_pcps)
-		flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
 
 	mutex_unlock(&pcpu_drain_mutex);
 }
-- 
2.35.1.574.g5d30c73bfb-goog

