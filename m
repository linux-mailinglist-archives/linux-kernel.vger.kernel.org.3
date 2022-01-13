Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD548D4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiAMJMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiAMJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:11:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250EAC06175A;
        Thu, 13 Jan 2022 01:11:53 -0800 (PST)
Date:   Thu, 13 Jan 2022 10:11:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642065111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bkLv8g6w0TK9FD6MWRWaSV3d1ILPZF2nMQbKml4DduA=;
        b=ZMZJce93S/l7kTAfZP+cPPh6gRhZgWevdltSirzHHvWqfjbwKPMeouRC7wU5b+CY45n0x2
        vqkvMgd1FMTM33DAZrQjfH33Ld94SG+B0KjXsi+KXbywxM0uxkFF1aTsKtCkzy2xeb0ufg
        AHCu2iYvOTTUW84KaJSgCAmuunDwMq370DfjiOOsHl/7+9aSQni8RhaZi396/+w8ek1kSL
        3/DGCPi8i+197XVjOCzIdPVbTtCtlKUkfj/mUK9DJcZtPQDm+zPXl8VoW7b6EuY75k+jIz
        5iqlt66s/R90z1ibyDIfXShLdFnvmTrv+GWJcwTtzwNl/Fx5d3viklMtILyj+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642065111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bkLv8g6w0TK9FD6MWRWaSV3d1ILPZF2nMQbKml4DduA=;
        b=Rf0gIsKwbJsoGoMuryR6bpC7RABuFQlF7WqtsOJYOn0cNWUgn596/FwosO/mbLl17eDRu8
        7PmQgMQjsN7X6/AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.16-rt15
Message-ID: <Yd/s1R06cRdX+J5P@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.16-rt15 patch set. 

Changes since v5.16-rt14:

  - Backport a write_lock_nested() fix. Introduced by the zsmalloc
    patches, leading to build failure in certain configurations.

  - In memcg patch, pass a bool instead of a pointer.

Known issues
     - netconsole triggers WARN.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.16-rt14 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/incr/patch-5.16-rt14-rt15.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16-rt15

The RT patch against v5.16 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16-rt15.tar.xz

Sebastian

diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index f0c535ec4e654..dceb0a59b6927 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -47,7 +47,6 @@ _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 
 #ifdef CONFIG_INLINE_WRITE_LOCK
 #define _raw_write_lock(lock) __raw_write_lock(lock)
-#define _raw_write_lock_nested(lock, subclass) __raw_write_lock_nested(lock, subclass)
 #endif
 
 #ifdef CONFIG_INLINE_READ_LOCK_BH
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 996811efa6d6e..7f49baaa49793 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -301,6 +301,10 @@ void __lockfunc _raw_write_lock(rwlock_t *lock)
 }
 EXPORT_SYMBOL(_raw_write_lock);
 
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
+#define __raw_write_lock_nested(lock, subclass)	__raw_write_lock(((void)(subclass), (lock)))
+#endif
+
 void __lockfunc _raw_write_lock_nested(rwlock_t *lock, int subclass)
 {
 	__raw_write_lock_nested(lock, subclass);
diff --git a/localversion-rt b/localversion-rt
index 08b3e75841adc..18777ec0c27d4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 92180f1aa9edc..bfb99225527fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -264,7 +264,7 @@ bool mem_cgroup_kmem_disabled(void)
 struct memcg_stock_pcp;
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages,
-				      struct memcg_stock_pcp *stock_pcp);
+				      bool stock_lock_acquried);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -298,7 +298,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 
 	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
@@ -2147,13 +2147,13 @@ static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
 static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
-					  struct memcg_stock_pcp *stock_pcp);
+					  bool stock_lock_acquried);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
 #else
 static inline struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
-						 struct memcg_stock_pcp *stock_pcp)
+						 bool stock_lock_acquried)
 {
 	return NULL;
 }
@@ -2252,11 +2252,11 @@ static void drain_local_stock(struct work_struct *dummy)
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
  */
-static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
-			   struct memcg_stock_pcp *stock)
+static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	lockdep_assert_held(&stock->stock_lock);
+	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
 
+	lockdep_assert_held(&stock->stock_lock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		css_get(&memcg->css);
@@ -2269,16 +2269,16 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 }
 
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
-			 struct memcg_stock_pcp *stock_pcp)
+			 bool stock_lock_acquried)
 {
 	unsigned long flags;
 
-	if (stock_pcp) {
-		__refill_stock(memcg, nr_pages, stock_pcp);
+	if (stock_lock_acquried) {
+		__refill_stock(memcg, nr_pages);
 		return;
 	}
 	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-	__refill_stock(memcg, nr_pages, this_cpu_ptr(&memcg_stock));
+	__refill_stock(memcg, nr_pages);
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
@@ -2719,7 +2719,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 done_restock:
 	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages, NULL);
+		refill_stock(memcg, batch - nr_pages, false);
 
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
@@ -2833,34 +2833,35 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
  * access interrupt object stock, but not vice versa.
  */
 static inline struct obj_stock *get_obj_stock(unsigned long *pflags,
-					      struct memcg_stock_pcp **stock_pcp)
+					      bool *stock_lock_acquried)
 {
 	struct memcg_stock_pcp *stock;
 
 #ifndef CONFIG_PREEMPTION
 	if (likely(in_task())) {
 		*pflags = 0UL;
-		*stock_pcp = NULL;
+		*stock_lock_acquried = false;
 		local_lock(&memcg_stock.task_obj_lock);
 		stock = this_cpu_ptr(&memcg_stock);
 		return &stock->task_obj;
 	}
 #endif
+	*stock_lock_acquried = true;
 	local_lock_irqsave(&memcg_stock.stock_lock, *pflags);
 	stock = this_cpu_ptr(&memcg_stock);
-	*stock_pcp = stock;
 	return &stock->irq_obj;
 }
 
 static inline void put_obj_stock(unsigned long flags,
-				 struct memcg_stock_pcp *stock_pcp)
+				 bool stock_lock_acquried)
 {
 #ifndef CONFIG_PREEMPTION
-	if (likely(!stock_pcp))
+	if (likely(!stock_lock_acquried)) {
 		local_unlock(&memcg_stock.task_obj_lock);
-	else
+		return;
+	}
 #endif
-		local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
 /*
@@ -3039,7 +3040,7 @@ static void memcg_free_cache_id(int id)
  */
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages,
-				      struct memcg_stock_pcp *stock_pcp)
+				      bool stock_lock_acquried)
 {
 	struct mem_cgroup *memcg;
 
@@ -3047,7 +3048,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
-	refill_stock(memcg, nr_pages, stock_pcp);
+	refill_stock(memcg, nr_pages, stock_lock_acquried);
 
 	css_put(&memcg->css);
 }
@@ -3121,7 +3122,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 		return;
 
 	objcg = __folio_objcg(folio);
-	obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
+	obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 	folio->memcg_data = 0;
 	obj_cgroup_put(objcg);
 }
@@ -3129,20 +3130,20 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
-	struct memcg_stock_pcp *stock_pcp;
+	bool stock_lock_acquried;
 	unsigned long flags;
 	struct obj_cgroup *old = NULL;
 	struct obj_stock *stock;
 	int *bytes;
 
-	stock = get_obj_stock(&flags, &stock_pcp);
+	stock = get_obj_stock(&flags, &stock_lock_acquried);
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat or idx
 	 * changes.
 	 */
 	if (stock->cached_objcg != objcg) {
-		old = drain_obj_stock(stock, stock_pcp);
+		old = drain_obj_stock(stock, stock_lock_acquried);
 
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
@@ -3187,31 +3188,31 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	put_obj_stock(flags, stock_pcp);
+	put_obj_stock(flags, stock_lock_acquried);
 	if (old)
 		obj_cgroup_put(old);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
-	struct memcg_stock_pcp *stock_pcp;
+	bool stock_lock_acquried;
 	unsigned long flags;
 	struct obj_stock *stock;
 	bool ret = false;
 
-	stock = get_obj_stock(&flags, &stock_pcp);
+	stock = get_obj_stock(&flags, &stock_lock_acquried);
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
 	}
 
-	put_obj_stock(flags, stock_pcp);
+	put_obj_stock(flags, stock_lock_acquried);
 
 	return ret;
 }
 
 static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
-					  struct memcg_stock_pcp *stock_pcp)
+					  bool stock_lock_acquried)
 {
 	struct obj_cgroup *old = stock->cached_objcg;
 
@@ -3223,7 +3224,7 @@ static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
 		if (nr_pages)
-			obj_cgroup_uncharge_pages(old, nr_pages, stock_pcp);
+			obj_cgroup_uncharge_pages(old, nr_pages, stock_lock_acquried);
 
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3286,15 +3287,15 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
-	struct memcg_stock_pcp *stock_pcp;
+	bool stock_lock_acquried;
 	unsigned long flags;
 	struct obj_stock *stock;
 	unsigned int nr_pages = 0;
 	struct obj_cgroup *old = NULL;
 
-	stock = get_obj_stock(&flags, &stock_pcp);
+	stock = get_obj_stock(&flags, &stock_lock_acquried);
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
-		old = drain_obj_stock(stock, stock_pcp);
+		old = drain_obj_stock(stock, stock_lock_acquried);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg = objcg;
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
@@ -3308,12 +3309,12 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	put_obj_stock(flags, stock_pcp);
+	put_obj_stock(flags, stock_lock_acquried);
 	if (old)
 		obj_cgroup_put(old);
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 }
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -7114,7 +7115,7 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages, NULL);
+	refill_stock(memcg, nr_pages, false);
 }
 
 static int __init cgroup_memory(char *s)
