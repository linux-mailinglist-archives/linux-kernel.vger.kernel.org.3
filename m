Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED24AD66C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356539AbiBHLZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356077AbiBHKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C624C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644314892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yy9BVLqK7ivyPWdwgLpNg6ELIjXs+mnOumXxnxk8VEI=;
        b=SxhhZuMxQWef77KhR1ExXTWEO+PNGl2weiYoTurEtUKsXGusd+ce07q3OLbB0C4F0nW6zB
        ss15CziOcRBg4s27gl2cZQHnMyNdbhw58CWqWe7TkT4lH8h/k+pz1+ey3Q3b4ggDYajzDy
        bWEwusyliEq/DpBZDledGt5vgYejZgE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-PHTdY_gdOySt8x9X26b-pg-1; Tue, 08 Feb 2022 05:08:10 -0500
X-MC-Unique: PHTdY_gdOySt8x9X26b-pg-1
Received: by mail-wm1-f72.google.com with SMTP id r205-20020a1c44d6000000b0037bb51b549aso840442wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yy9BVLqK7ivyPWdwgLpNg6ELIjXs+mnOumXxnxk8VEI=;
        b=MNRYMZlZzWTGnanEfunsLefRI6KY6ahBlsXnjYS3DC5HRyW5h1VlXV9iK7TeejB3b5
         dMJbPdWivuxIVylipEgG6xnOzz5gcK4VhMHrqYcFyRYFh9zx59GU2QTJtlUfKXzESL9X
         P91ZguDdJLTEesAaHxs2wP/bRLA8rWp1ucBynwlDGVBOS19fZjDggHetv3l16ioWA/3K
         XvqJClT2JDrSnDOtrZPCSBb0XxaFtGkf0Movq75vhc+Z7eG1fjFLG4ZtO0ZxsBn0tvI4
         9nBsaowwLFRBGZUeRQrm8AQXlFgJuM/WL9P4Kw498HrO/FAAY3IOcQWtiTij+l3VOiO8
         K1dA==
X-Gm-Message-State: AOAM530CZ2sbjOYDeGReNFDSHNObD3wyDsfzOptHFuVxkFd3v3ZvW3wU
        lVmDyPK0iWhDStNbaAx1ekqrelCobGAzSvudvm7ieE4AekrV2/RoJzFjr/7D4lRpq1mb0ZYxn4/
        7DcNr6p4jDhS6CU1d1ro4vlGu
X-Received: by 2002:a5d:50cb:: with SMTP id f11mr2867091wrt.178.1644314889325;
        Tue, 08 Feb 2022 02:08:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDswpqM/YrQiS77tGfqqoRE4Qx19RaBdmm/4g/wUbnCL/hNCRaQOiEKgy4ZIGjd7pixgwdZA==
X-Received: by 2002:a5d:50cb:: with SMTP id f11mr2867044wrt.178.1644314888801;
        Tue, 08 Feb 2022 02:08:08 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id z5sm1911027wmp.10.2022.02.08.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 02:08:08 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mtosatti@redhat.com,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 2/2] mm/page_alloc: Add remote draining support to per-cpu lists
Date:   Tue,  8 Feb 2022 11:07:50 +0100
Message-Id: <20220208100750.1189808-3-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208100750.1189808-1-nsaenzju@redhat.com>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page allocator's per-cpu page lists (pcplists) are currently
protected using local_locks. While performance savvy, this doesn't allow
for remote access to these structures. CPUs requiring system-wide
changes to the per-cpu lists get around this by scheduling
workers on each CPU. That said, some setups like NOHZ_FULL CPUs,
aren't well suited to this since they can't handle interruptions
of any sort.

To mitigate this, replace the current draining mechanism with one that
allows remotely draining the lists:

 - Each CPU now has two pcplists pointers: one that points to a pcplists
   instance that is in-use, 'pcp->lp', another that points to an idle
   and empty instance, 'pcp->drain'. CPUs access their local pcplists
   through 'pcp->lp' and the pointer is dereferenced atomically.

 - When a CPU decides it needs to empty some remote pcplists, it'll
   atomically exchange the remote CPU's 'pcp->lp' and 'pcp->drain'
   pointers. A remote CPU racing with this will either have:

     - An old 'pcp->lp' reference, it'll soon be emptied by the drain
       process, we just have to wait for it to finish using it.

     - The new 'pcp->lp' reference, that is, an empty pcplists instance.
       rcu_replace_pointer()'s release semantics ensures any prior
       changes will be visible by the remote CPU, for example: changes
       to 'pcp->high' and 'pcp->batch' when disabling the pcplists.

 - The CPU that started the drain can now wait for an RCU grace period
   to make sure the remote CPU is done using the old pcplists.
   synchronize_rcu() counts as a full memory barrier, so any changes the
   local CPU makes to the soon to be drained pcplists will be visible to
   the draining CPU once it returns.

 - Then the CPU can safely free the old pcplists. Nobody else holds a
   reference to it. Note that concurrent access to the remote pcplists
   drain is protected by the 'pcpu_drain_mutex'.

From an RCU perspective, we're only protecting access to the pcplists
pointer, the drain operation is the writer and the local_lock critical
sections are the readers. RCU guarantees atomicity both while
dereferencing the pcplists pointer and replacing it. It also checks for
RCU critical section/locking correctness, as all readers have to hold
their per-cpu pagesets local_lock, which also counts as a critical
section from RCU's perspective.

From a performance perspective, on production configurations, the patch
adds an extra dereference to all hot paths (under such circumstances
rcu_dereference() will simplify to READ_ONCE()). Extensive measurements
have been performed on different architectures to ascertain the
performance impact is minimal. Most platforms don't see any difference
and the worst-case scenario shows a 1-3% degradation on a page
allocation micro-benchmark. See cover letter for in-depth results.

Accesses to the pcplists like the ones in mm/vmstat.c don't require RCU
supervision since they can handle outdated data, but they do use
rcu_access_pointer() to avoid compiler weirdness make sparse happy.

Note that special care has been taken to verify there are no races with
the memory hotplug code paths. Notably with calls to zone_pcp_reset().
As Mel Gorman explains in a previous patch[1]: "The existing hotplug
paths guarantees the pcplists cannot be used after zone_pcp_enable()
[the one in offline_pages()]. That should be the case already because
all the pages have been freed and there is no page to put on the PCP
lists."

All in all, this technique allows for remote draining on all setups with
an acceptable performance impact. It benefits all sorts of use cases:
low-latency, real-time, HPC, idle systems, KVM guests.

[1] 8ca559132a2d ("mm/memory_hotplug: remove broken locking of zone PCP
    structures during hot remove")

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

Changes since RFC:
 - Avoid unnecessary spin_lock_irqsave/restore() in free_pcppages_bulk()
 - Add more detail to commit and code comments.
 - Use synchronize_rcu() instead of synchronize_rcu_expedited(), the RCU
   documentation says to avoid it unless really justified. I don't think
   it's justified here, if we can schedule and join works, waiting for
   an RCU grace period is OK.
 - Avoid sparse warnings by using rcu_access_pointer() and
   rcu_dereference_protected().

 include/linux/mmzone.h |  22 +++++-
 mm/page_alloc.c        | 155 ++++++++++++++++++++++++++---------------
 mm/vmstat.c            |   6 +-
 3 files changed, 120 insertions(+), 63 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b4cb85d9c6e8..b0b593fd8e48 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -388,13 +388,31 @@ struct per_cpu_pages {
 	short expire;		/* When 0, remote pagesets are drained */
 #endif
 
-	struct pcplists *lp;
+	/*
+	 * As a rule of thumb, any access to struct per_cpu_pages's 'lp' has
+	 * happen with the pagesets local_lock held and using
+	 * rcu_dereference_check(). If there is a need to modify both
+	 * 'lp->count' and 'lp->lists' in the same critical section 'pcp->lp'
+	 * can only be derefrenced once. See for example:
+	 *
+	 *     local_lock_irqsave(&pagesets.lock, flags);
+	 *     lp = rcu_dereference_check(pcp->lp, ...);
+	 *     list_add(&page->lru, &lp->lists[pindex]);
+	 *     lp->count += 1 << order;
+	 *     local_unlock_irqrestore(&pagesets.lock, flags);
+	 *
+	 * vmstat code only needs to check the page count and can deal with
+	 * outdated data. In that case rcu_access_pointer() is good enough and
+	 * the locking is not needed.
+	 */
+	struct pcplists __rcu *lp;
+	struct pcplists *drain;
 	struct pcplists {
 		/* Number of pages in the pcplists */
 		int count;
 		/* Lists of pages, one per migrate type stored on the pcp-lists */
 		struct list_head lists[NR_PCP_LISTS];
-	} __pcplists; /* Do not access directly */
+	} __pcplists[2]; /* Do not access directly */
 };
 
 struct per_cpu_zonestat {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4f37815b0e4c..4680dd458184 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -150,13 +150,7 @@ DEFINE_PER_CPU(int, _numa_mem_);		/* Kernel "local memory" node */
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
@@ -3135,7 +3129,7 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	batch = READ_ONCE(pcp->batch);
-	lp = pcp->lp;
+	lp = rcu_dereference_check(pcp->lp, lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
 	to_drain = min(lp->count, batch);
 	if (to_drain > 0)
 		free_pcppages_bulk(zone, to_drain, batch, lp);
@@ -3159,7 +3153,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	local_lock_irqsave(&pagesets.lock, flags);
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	lp = pcp->lp;
+	lp = rcu_dereference_check(pcp->lp, lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
 	if (lp->count)
 		free_pcppages_bulk(zone, lp->count, READ_ONCE(pcp->batch), lp);
 
@@ -3198,36 +3192,48 @@ void drain_local_pages(struct zone *zone)
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
  *
- * drain_all_pages() is optimized to only execute on cpus where pcplists are
- * not empty. The check for non-emptiness can however race with a free to
- * pcplist that has not yet increased the lp->count from 0 to 1. Callers
- * that need the guarantee that every CPU has drained can disable the
- * optimizing racy check.
+ * drain_all_pages() is optimized to only affect cpus where pcplists are not
+ * empty. The check for non-emptiness can however race with a free to pcplist
+ * that has not yet increased the lp->count from 0 to 1. Callers that need the
+ * guarantee that every CPU has drained can disable the optimizing racy check.
+ *
+ * The drain mechanism does the following:
+ *
+ *  - Each CPU has two pcplists pointers: one that points to a pcplists
+ *    instance that is in-use, 'pcp->lp', another that points to an idle
+ *    and empty instance, 'pcp->drain'. CPUs atomically dereference their local
+ *    pcplists through 'pcp->lp' while holding the pagesets local_lock.
+ *
+ *  - When a CPU decides it needs to empty some remote pcplists, it'll
+ *    atomically exchange the remote CPU's 'pcp->lp' and 'pcp->drain' pointers.
+ *    A remote CPU racing with this will either have:
+ *
+ *      - An old 'pcp->lp' reference, it'll soon be emptied by the drain
+ *        process, we just have to wait for it to finish using it.
+ *
+ *      - The new 'pcp->lp' reference, that is, an empty pcplists instance.
+ *        rcu_replace_pointer()'s release semantics ensures any prior changes
+ *        will be visible by the remote CPU, for example changes to 'pcp->high'
+ *        and 'pcp->batch' when disabling the pcplists.
+ *
+ *  - The CPU that started the drain can now wait for an RCU grace period to
+ *    make sure the remote CPU is done using the old pcplists.
+ *    synchronize_rcu() counts as a full memory barrier, so any changes the
+ *    local CPU makes to the soon to be drained pcplists will be visible to the
+ *    draining CPU once it returns.
+ *
+ *  - Then the CPU can safely free the old pcplists. Nobody else holds a
+ *    reference to it. Note that concurrent write access to remote pcplists
+ *    pointers is protected by the 'pcpu_drain_mutex'.
  */
 static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 {
+	struct per_cpu_pages *pcp;
+	struct zone *z;
 	int cpu;
 
 	/*
@@ -3236,13 +3242,6 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
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
@@ -3261,6 +3260,7 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	 * disables preemption as part of its processing
 	 */
 	for_each_online_cpu(cpu) {
+		struct per_cpu_pages *pcp;
 		struct zone *z;
 		bool has_pcps = false;
 		struct pcplists *lp;
@@ -3272,12 +3272,16 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 			 */
 			has_pcps = true;
 		} else if (zone) {
-			lp = per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp;
+			pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+			lp = rcu_dereference_protected(pcp->lp,
+					  mutex_is_locked(&pcpu_drain_mutex));
 			if (lp->count)
 				has_pcps = true;
 		} else {
 			for_each_populated_zone(z) {
-				lp = per_cpu_ptr(z->per_cpu_pageset, cpu)->lp;
+				pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+				lp = rcu_dereference_protected(pcp->lp,
+						mutex_is_locked(&pcpu_drain_mutex));
 				if (lp->count) {
 					has_pcps = true;
 					break;
@@ -3291,16 +3295,40 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 			cpumask_clear_cpu(cpu, &cpus_with_pcps);
 	}
 
+	if (cpumask_empty(&cpus_with_pcps))
+		goto exit;
+
 	for_each_cpu(cpu, &cpus_with_pcps) {
-		struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
+		for_each_populated_zone(z) {
+			if (zone && zone != z)
+				continue;
+
+			pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
+			WARN_ON(pcp->drain->count);
+			pcp->drain = rcu_replace_pointer(pcp->lp, pcp->drain,
+					mutex_is_locked(&pcpu_drain_mutex));
+		}
+	}
+
+	synchronize_rcu();
 
-		drain->zone = zone;
-		INIT_WORK(&drain->work, drain_local_pages_wq);
-		queue_work_on(cpu, mm_percpu_wq, &drain->work);
+	for_each_cpu(cpu, &cpus_with_pcps) {
+		for_each_populated_zone(z) {
+			unsigned long flags;
+			int count;
+
+			pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
+			count = pcp->drain->count;
+			if (!count)
+			       continue;
+
+			local_irq_save(flags);
+			free_pcppages_bulk(z, count, READ_ONCE(pcp->batch), pcp->drain);
+			local_irq_restore(flags);
+		}
 	}
-	for_each_cpu(cpu, &cpus_with_pcps)
-		flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
 
+exit:
 	mutex_unlock(&pcpu_drain_mutex);
 }
 
@@ -3309,7 +3337,7 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
  *
  * When zone parameter is non-NULL, spill just the single zone's pages.
  *
- * Note that this can be extremely slow as the draining happens in a workqueue.
+ * Note that this can be extremely slow.
  */
 void drain_all_pages(struct zone *zone)
 {
@@ -3436,7 +3464,7 @@ static void free_unref_page_commit(struct page *page, int migratetype,
 
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	lp = pcp->lp;
+	lp = rcu_dereference_check(pcp->lp, lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
 	pindex = order_to_pindex(migratetype, order);
 	list_add(&page->lru, &lp->lists[pindex]);
 	lp->count += 1 << order;
@@ -3723,7 +3751,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 */
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
-	lp = pcp->lp;
+	lp = rcu_dereference_check(pcp->lp, lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
 	list = &lp->lists[order_to_pindex(migratetype, order)];
 	count = &lp->count;
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags,
@@ -5346,7 +5374,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	/* Attempt the batch allocation */
 	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	lp = pcp->lp;
+	lp = rcu_dereference_check(pcp->lp, lockdep_is_held(this_cpu_ptr(&pagesets.lock)));
 	pcp_list = &lp->lists[order_to_pindex(ac.migratetype, 0)];
 	count = &lp->count;
 
@@ -5961,8 +5989,12 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
 
-		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp->count;
+		for_each_online_cpu(cpu) {
+			struct per_cpu_pages *pcp;
+
+			pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+			free_pcp += rcu_access_pointer(pcp->lp)->count;
+		}
 	}
 
 	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
@@ -6055,8 +6087,12 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			continue;
 
 		free_pcp = 0;
-		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp->count;
+		for_each_online_cpu(cpu) {
+			struct per_cpu_pages *pcp;
+
+			pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+			free_pcp += rcu_access_pointer(pcp->lp)->count;
+		}
 
 		show_node(zone);
 		printk(KERN_CONT
@@ -6099,7 +6135,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone_page_state(zone, NR_MLOCK)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
-			K(raw_cpu_ptr(zone->per_cpu_pageset)->lp->count),
+			K(rcu_access_pointer(raw_cpu_ptr(zone->per_cpu_pageset)->lp)->count),
 			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
@@ -7014,10 +7050,13 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	memset(pcp, 0, sizeof(*pcp));
 	memset(pzstats, 0, sizeof(*pzstats));
 
-	pcp->lp = &pcp->__pcplists;
+	pcp->lp = RCU_INITIALIZER(&pcp->__pcplists[0]);
+	pcp->drain = &pcp->__pcplists[1];
 
-	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
-		INIT_LIST_HEAD(&pcp->lp->lists[pindex]);
+	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++) {
+		INIT_LIST_HEAD(&rcu_access_pointer(pcp->lp)->lists[pindex]);
+		INIT_LIST_HEAD(&pcp->drain->lists[pindex]);
+	}
 
 	/*
 	 * Set batch and high values safe for a boot pageset. A true percpu
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 576b2b932ccd..9c33ff4a580a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -856,7 +856,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			 * if not then there is nothing to expire.
 			 */
 			if (!__this_cpu_read(pcp->expire) ||
-			       !this_cpu_ptr(pcp)->lp->count)
+			    !rcu_access_pointer(this_cpu_ptr(pcp)->lp)->count)
 				continue;
 
 			/*
@@ -870,7 +870,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			if (__this_cpu_dec_return(pcp->expire))
 				continue;
 
-			if (this_cpu_ptr(pcp)->lp->count) {
+			if (rcu_access_pointer(this_cpu_ptr(pcp)->lp)->count) {
 				drain_zone_pages(zone, this_cpu_ptr(pcp));
 				changes++;
 			}
@@ -1728,7 +1728,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   "\n              high:  %i"
 			   "\n              batch: %i",
 			   i,
-			   pcp->lp->count,
+			   rcu_access_pointer(pcp->lp)->count,
 			   pcp->high,
 			   pcp->batch);
 #ifdef CONFIG_SMP
-- 
2.34.1

