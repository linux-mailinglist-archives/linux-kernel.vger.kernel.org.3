Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851474AD66E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348645AbiBHLZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356078AbiBHKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:08:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2BF8C03FEC5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644314892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06BnTZzuO/korL6R8pKHINxYBCZYhmQu6E/SNPlqJdA=;
        b=iAX/EShPndDeYp5EHNyKy4xWd21m4kp8Yv/XqvhEEssuLgQ+cgaiMzdzlWYwghfMEiKx6s
        Jze8krcyqO1q5scDvMG37pLcEe1Bkj1iczhVD25+iY5cgVxO+XRcD2nC0A9L/teF02n7p3
        +HzygEfx0t1ZBHTh+CdNeXWWFib50lY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-PAPW0Rs0MPuzLPpuHBXqxw-1; Tue, 08 Feb 2022 05:08:09 -0500
X-MC-Unique: PAPW0Rs0MPuzLPpuHBXqxw-1
Received: by mail-wm1-f72.google.com with SMTP id h82-20020a1c2155000000b003552c13626cso844631wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06BnTZzuO/korL6R8pKHINxYBCZYhmQu6E/SNPlqJdA=;
        b=d9hUUz+9qUs16U+P7kPgGWG/tkUbrkrjyq47s3JfbQLaqItA8vcKpHo/0FvVvvSFdr
         /89TbA1Ni+i9T+DCAj1t+UI2ps3yT4klOPOdtX2G/g+1MBF+fHj3KTkQBus5SFwS27PL
         XvhSNOTpwGw3SQai91NPxRsVUWXCiiHYRllF2zeT0L6DInwVDxdtVDFnfvkW446wRceq
         /2xHFDaXb9c/GollauNxEl9BDKw3Kp7oy4emNu9+Lx+sw1yLs4Oi/RDCLzqIqFhSNsxB
         FSQsWU+GqsdQ3Hb3BvvzvHKrvxqKDbXGx6HwojQWZGg9ruPUrUUuAfkCWW1NDnjEiOzC
         Kbdg==
X-Gm-Message-State: AOAM532RAUk2HPgS8zXsdYHg83I3tRigPBCBnvX4oHmwIOEQOjiplcEv
        cuA6YjMXsh0ryVduj6r68cpKquunBNlESJXn2gmbl124ZGm1uuNIFntn7Lmnmd0O/7Z9WrF6js8
        Bb73nDDtBPkqewMCKbHMzbYEt
X-Received: by 2002:a5d:598a:: with SMTP id n10mr2855194wri.136.1644314888328;
        Tue, 08 Feb 2022 02:08:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwuwfP5ZaDGYodWgAe1/7/aVA7WVQ/n8GvAre37Zc/wm6jhpzE0k3j7exY7ATMbFHhoeCIUVw==
X-Received: by 2002:a5d:598a:: with SMTP id n10mr2855168wri.136.1644314888026;
        Tue, 08 Feb 2022 02:08:08 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1204:1500:37e7:8150:d9df:36f])
        by smtp.gmail.com with ESMTPSA id z5sm1911027wmp.10.2022.02.08.02.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 02:08:07 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, mtosatti@redhat.com,
        mgorman@suse.de, linux-rt-users@vger.kernel.org, vbabka@suse.cz,
        cl@linux.com, paulmck@kernel.org, willy@infradead.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 1/2] mm/page_alloc: Access lists in 'struct per_cpu_pages' indirectly
Date:   Tue,  8 Feb 2022 11:07:49 +0100
Message-Id: <20220208100750.1189808-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208100750.1189808-1-nsaenzju@redhat.com>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to adding remote per-cpu page list drain support, let's
bundle 'struct per_cpu_pages's' page lists and page count into a new
structure: 'struct pcplists', and have all code access it indirectly
through a pointer. It'll be used by upcoming patches in order to
maintain multiple instances of 'pcplists' and switch the pointer
atomically.

The 'struct pcplists' instance lives inside 'struct per_cpu_pages', and
shouldn't be accessed directly. It is setup as such since these
structures are used during early boot when no memory allocation is
possible and to simplify memory hotplug code paths.

free_pcppages_bulk() and __rmqueue_pcplist()'s function signatures
change a bit so as to accommodate these changes without affecting
performance.

No functional change intended.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---

Changes since RFC:
 - Add more info in commit message.
 - Removed __private attribute, in hindsight doesn't really fit what
   we're doing here.
 - Use raw_cpu_ptr() where relevant to avoid warnings.

 include/linux/mmzone.h | 10 +++--
 mm/page_alloc.c        | 87 +++++++++++++++++++++++++-----------------
 mm/vmstat.c            |  6 +--
 3 files changed, 62 insertions(+), 41 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3fff6deca2c0..b4cb85d9c6e8 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -381,7 +381,6 @@ enum zone_watermarks {
 
 /* Fields and list protected by pagesets local_lock in page_alloc.c */
 struct per_cpu_pages {
-	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
 	short free_factor;	/* batch scaling factor during free */
@@ -389,8 +388,13 @@ struct per_cpu_pages {
 	short expire;		/* When 0, remote pagesets are drained */
 #endif
 
-	/* Lists of pages, one per migrate type stored on the pcp-lists */
-	struct list_head lists[NR_PCP_LISTS];
+	struct pcplists *lp;
+	struct pcplists {
+		/* Number of pages in the pcplists */
+		int count;
+		/* Lists of pages, one per migrate type stored on the pcp-lists */
+		struct list_head lists[NR_PCP_LISTS];
+	} __pcplists; /* Do not access directly */
 };
 
 struct per_cpu_zonestat {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4f549123150c..4f37815b0e4c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1449,13 +1449,12 @@ static inline void prefetch_buddy(struct page *page)
  * count is the number of pages to free.
  */
 static void free_pcppages_bulk(struct zone *zone, int count,
-					struct per_cpu_pages *pcp)
+			       int batch, struct pcplists *lp)
 {
 	int pindex = 0;
 	int batch_free = 0;
 	int nr_freed = 0;
 	unsigned int order;
-	int prefetch_nr = READ_ONCE(pcp->batch);
 	bool isolated_pageblocks;
 	struct page *page, *tmp;
 	LIST_HEAD(head);
@@ -1464,7 +1463,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	 * Ensure proper count is passed which otherwise would stuck in the
 	 * below while (list_empty(list)) loop.
 	 */
-	count = min(pcp->count, count);
+	count = min(lp->count, count);
 	while (count > 0) {
 		struct list_head *list;
 
@@ -1479,7 +1478,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			batch_free++;
 			if (++pindex == NR_PCP_LISTS)
 				pindex = 0;
-			list = &pcp->lists[pindex];
+			list = &lp->lists[pindex];
 		} while (list_empty(list));
 
 		/* This is the only non-empty list. Free them all. */
@@ -1513,13 +1512,13 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			 * avoid excessive prefetching due to large count, only
 			 * prefetch buddy for the first pcp->batch nr of pages.
 			 */
-			if (prefetch_nr) {
+			if (batch) {
 				prefetch_buddy(page);
-				prefetch_nr--;
+				batch--;
 			}
 		} while (count > 0 && --batch_free && !list_empty(list));
 	}
-	pcp->count -= nr_freed;
+	lp->count -= nr_freed;
 
 	/*
 	 * local_lock_irq held so equivalent to spin_lock_irqsave for
@@ -3130,14 +3129,16 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
+	struct pcplists *lp;
 	unsigned long flags;
 	int to_drain, batch;
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	batch = READ_ONCE(pcp->batch);
-	to_drain = min(pcp->count, batch);
+	lp = pcp->lp;
+	to_drain = min(lp->count, batch);
 	if (to_drain > 0)
-		free_pcppages_bulk(zone, to_drain, pcp);
+		free_pcppages_bulk(zone, to_drain, batch, lp);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 #endif
@@ -3153,12 +3154,14 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	unsigned long flags;
 	struct per_cpu_pages *pcp;
+	struct pcplists *lp;
 
 	local_lock_irqsave(&pagesets.lock, flags);
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	if (pcp->count)
-		free_pcppages_bulk(zone, pcp->count, pcp);
+	lp = pcp->lp;
+	if (lp->count)
+		free_pcppages_bulk(zone, lp->count, READ_ONCE(pcp->batch), lp);
 
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
@@ -3219,7 +3222,7 @@ static void drain_local_pages_wq(struct work_struct *work)
  *
  * drain_all_pages() is optimized to only execute on cpus where pcplists are
  * not empty. The check for non-emptiness can however race with a free to
- * pcplist that has not yet increased the pcp->count from 0 to 1. Callers
+ * pcplist that has not yet increased the lp->count from 0 to 1. Callers
  * that need the guarantee that every CPU has drained can disable the
  * optimizing racy check.
  */
@@ -3258,24 +3261,24 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	 * disables preemption as part of its processing
 	 */
 	for_each_online_cpu(cpu) {
-		struct per_cpu_pages *pcp;
 		struct zone *z;
 		bool has_pcps = false;
+		struct pcplists *lp;
 
 		if (force_all_cpus) {
 			/*
-			 * The pcp.count check is racy, some callers need a
+			 * The lp->count check is racy, some callers need a
 			 * guarantee that no cpu is missed.
 			 */
 			has_pcps = true;
 		} else if (zone) {
-			pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-			if (pcp->count)
+			lp = per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp;
+			if (lp->count)
 				has_pcps = true;
 		} else {
 			for_each_populated_zone(z) {
-				pcp = per_cpu_ptr(z->per_cpu_pageset, cpu);
-				if (pcp->count) {
+				lp = per_cpu_ptr(z->per_cpu_pageset, cpu)->lp;
+				if (lp->count) {
 					has_pcps = true;
 					break;
 				}
@@ -3427,19 +3430,21 @@ static void free_unref_page_commit(struct page *page, int migratetype,
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
+	struct pcplists *lp;
 	int high;
 	int pindex;
 
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	lp = pcp->lp;
 	pindex = order_to_pindex(migratetype, order);
-	list_add(&page->lru, &pcp->lists[pindex]);
-	pcp->count += 1 << order;
+	list_add(&page->lru, &lp->lists[pindex]);
+	lp->count += 1 << order;
 	high = nr_pcp_high(pcp, zone);
-	if (pcp->count >= high) {
+	if (lp->count >= high) {
 		int batch = READ_ONCE(pcp->batch);
 
-		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp);
+		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), batch, lp);
 	}
 }
 
@@ -3660,7 +3665,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int migratetype,
 			unsigned int alloc_flags,
 			struct per_cpu_pages *pcp,
-			struct list_head *list)
+			struct list_head *list,
+			int *count)
 {
 	struct page *page;
 
@@ -3682,14 +3688,14 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 					batch, list,
 					migratetype, alloc_flags);
 
-			pcp->count += alloced << order;
+			*count += alloced << order;
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
 
 		page = list_first_entry(list, struct page, lru);
 		list_del(&page->lru);
-		pcp->count -= 1 << order;
+		*count -= 1 << order;
 	} while (check_new_pcp(page));
 
 	return page;
@@ -3703,8 +3709,10 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 {
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
+	struct pcplists *lp;
 	struct page *page;
 	unsigned long flags;
+	int *count;
 
 	local_lock_irqsave(&pagesets.lock, flags);
 
@@ -3715,8 +3723,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 */
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
-	list = &pcp->lists[order_to_pindex(migratetype, order)];
-	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	lp = pcp->lp;
+	list = &lp->lists[order_to_pindex(migratetype, order)];
+	count = &lp->count;
+	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags,
+				 pcp, list, count);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
@@ -5255,9 +5266,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
 	struct alloc_context ac;
+	struct pcplists *lp;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	int nr_populated = 0, nr_account = 0;
+	int *count;
 
 	/*
 	 * Skip populated array elements to determine if any pages need
@@ -5333,7 +5346,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	/* Attempt the batch allocation */
 	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
+	lp = pcp->lp;
+	pcp_list = &lp->lists[order_to_pindex(ac.migratetype, 0)];
+	count = &lp->count;
 
 	while (nr_populated < nr_pages) {
 
@@ -5344,7 +5359,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		}
 
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
-								pcp, pcp_list);
+					 pcp, pcp_list, count);
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
 			if (!nr_populated)
@@ -5947,7 +5962,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			continue;
 
 		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp->count;
 	}
 
 	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
@@ -6041,7 +6056,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 
 		free_pcp = 0;
 		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->lp->count;
 
 		show_node(zone);
 		printk(KERN_CONT
@@ -6084,7 +6099,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone_page_state(zone, NR_MLOCK)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
-			K(this_cpu_read(zone->per_cpu_pageset->count)),
+			K(raw_cpu_ptr(zone->per_cpu_pageset)->lp->count),
 			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
 		printk("lowmem_reserve[]:");
 		for (i = 0; i < MAX_NR_ZONES; i++)
@@ -6971,7 +6986,7 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 
 /*
  * pcp->high and pcp->batch values are related and generally batch is lower
- * than high. They are also related to pcp->count such that count is lower
+ * than high. They are also related to pcp->lp->count such that count is lower
  * than high, and as soon as it reaches high, the pcplist is flushed.
  *
  * However, guaranteeing these relations at all times would require e.g. write
@@ -6979,7 +6994,7 @@ static int zone_highsize(struct zone *zone, int batch, int cpu_online)
  * thus be prone to error and bad for performance. Thus the update only prevents
  * store tearing. Any new users of pcp->batch and pcp->high should ensure they
  * can cope with those fields changing asynchronously, and fully trust only the
- * pcp->count field on the local CPU with interrupts disabled.
+ * pcp->lp->count field on the local CPU with interrupts disabled.
  *
  * mutex_is_locked(&pcp_batch_high_lock) required when calling this function
  * outside of boot time (or some other assurance that no concurrent updaters
@@ -6999,8 +7014,10 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	memset(pcp, 0, sizeof(*pcp));
 	memset(pzstats, 0, sizeof(*pzstats));
 
+	pcp->lp = &pcp->__pcplists;
+
 	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
-		INIT_LIST_HEAD(&pcp->lists[pindex]);
+		INIT_LIST_HEAD(&pcp->lp->lists[pindex]);
 
 	/*
 	 * Set batch and high values safe for a boot pageset. A true percpu
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d5cc8d739fac..576b2b932ccd 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -856,7 +856,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			 * if not then there is nothing to expire.
 			 */
 			if (!__this_cpu_read(pcp->expire) ||
-			       !__this_cpu_read(pcp->count))
+			       !this_cpu_ptr(pcp)->lp->count)
 				continue;
 
 			/*
@@ -870,7 +870,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			if (__this_cpu_dec_return(pcp->expire))
 				continue;
 
-			if (__this_cpu_read(pcp->count)) {
+			if (this_cpu_ptr(pcp)->lp->count) {
 				drain_zone_pages(zone, this_cpu_ptr(pcp));
 				changes++;
 			}
@@ -1728,7 +1728,7 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   "\n              high:  %i"
 			   "\n              batch: %i",
 			   i,
-			   pcp->count,
+			   pcp->lp->count,
 			   pcp->high,
 			   pcp->batch);
 #ifdef CONFIG_SMP
-- 
2.34.1

