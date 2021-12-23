Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7626147E638
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349075AbhLWQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:13:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39934 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbhLWQNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:13:55 -0500
Date:   Thu, 23 Dec 2021 17:13:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640276034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+zuZeZHAhvowW11z4dsZGPUP8Pn1hgFaPia2x78EyZk=;
        b=DT1Vf1KjcE/h8XJ7rSb2fXGK5zLjGoXBXIg/r1TQ70DPqybcoakYtrQu+5aSiihB7kmQZy
        GoakfiqQ9gPFBahuisAKP5H4jjhKSPFS6wTWjnC+6df94VO7LUhvvWIV+6rxafQroN0Pff
        T4G60ixch2FwbJTVOKrjDEpMyQyEQxoJaQhal127oITIMlm8ra6VxKNEogrt+ZZHWVydZc
        313UX4HodatLmrGDSYe2vIu1z8Ier1nkeTkUBL1imOp9t41aTp+el3ADJkeAEEkhNZSOnc
        yOffBa2bFTXVmN3zYVZmpmQyIMbMDtdEvCYlhv08X7xdL0xBAVz5+25NZmwvCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640276034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=+zuZeZHAhvowW11z4dsZGPUP8Pn1hgFaPia2x78EyZk=;
        b=qIAn2i7MFSerLuJhkne32oITI8aATyiih4e2u5O6rxdywt2zgWtpvUIAQbHtY20U5npDV5
        Bw6f0KZ35VMs9xBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.16-rc6-rt12
Message-ID: <YcSgQY8lzb6MkQPx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.16-rc6-rt12 patch set. 

Changes since v5.16-rc6-rt11:

  - The timer_threads struct has been made static. Reported by kernel
    test robot.

  - The networking patches have been redone. They look different now and
    hopefully more attractive to upstream.

  - The "Memory controller" (CONFIG_MEMCG) can be enabled again.

Known issues
     - netconsole triggers WARN.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.16-rc6-rt11 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/incr/patch-5.16-rc6-rt11-rt12.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16-rc6-rt12

The RT patch against v5.16-rc6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16-rc6-rt12.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16-rc6-rt12.tar.xz

Sebastian

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index be5cb3360b944..5566dbc7eacd6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4003,8 +4003,17 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb);
 int netif_rx(struct sk_buff *skb);
-int netif_rx_ni(struct sk_buff *skb);
-int netif_rx_any_context(struct sk_buff *skb);
+
+static inline int netif_rx_ni(struct sk_buff *skb)
+{
+	return netif_rx(skb);
+}
+
+static inline int netif_rx_any_context(struct sk_buff *skb)
+{
+	return netif_rx(skb);
+}
+
 int netif_receive_skb(struct sk_buff *skb);
 int netif_receive_skb_core(struct sk_buff *skb);
 void netif_receive_skb_list(struct list_head *head);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cb011f4d0b5dc..c8cb7e697d479 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -297,7 +297,6 @@ struct sk_buff_head {
 
 	__u32		qlen;
 	spinlock_t	lock;
-	raw_spinlock_t	raw_lock;
 };
 
 struct sk_buff;
@@ -1954,12 +1953,6 @@ static inline void skb_queue_head_init(struct sk_buff_head *list)
 	__skb_queue_head_init(list);
 }
 
-static inline void skb_queue_head_init_raw(struct sk_buff_head *list)
-{
-	raw_spin_lock_init(&list->raw_lock);
-	__skb_queue_head_init(list);
-}
-
 static inline void skb_queue_head_init_class(struct sk_buff_head *list,
 		struct lock_class_key *class)
 {
diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index 78c448c6ab4c5..032b431b987b6 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -260,13 +260,6 @@ DEFINE_EVENT(net_dev_rx_verbose_template, netif_rx_entry,
 	TP_ARGS(skb)
 );
 
-DEFINE_EVENT(net_dev_rx_verbose_template, netif_rx_ni_entry,
-
-	TP_PROTO(const struct sk_buff *skb),
-
-	TP_ARGS(skb)
-);
-
 DECLARE_EVENT_CLASS(net_dev_rx_exit_template,
 
 	TP_PROTO(int ret),
@@ -312,13 +305,6 @@ DEFINE_EVENT(net_dev_rx_exit_template, netif_rx_exit,
 	TP_ARGS(ret)
 );
 
-DEFINE_EVENT(net_dev_rx_exit_template, netif_rx_ni_exit,
-
-	TP_PROTO(int ret),
-
-	TP_ARGS(ret)
-);
-
 DEFINE_EVENT(net_dev_rx_exit_template, netif_receive_skb_list_exit,
 
 	TP_PROTO(int ret),
diff --git a/init/Kconfig b/init/Kconfig
index d671799c5f377..4b7bac10c72d3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -943,7 +943,6 @@ config PAGE_COUNTER
 
 config MEMCG
 	bool "Memory controller"
-	depends on !PREEMPT_RT
 	select PAGE_COUNTER
 	select EVENTFD
 	help
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d685519962e5a..22948c2109f5b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1029,7 +1029,7 @@ void raise_timer_softirq(void)
 }
 #endif
 
-struct smp_hotplug_thread timer_threads = {
+static struct smp_hotplug_thread timer_threads = {
         .store                  = &timersd,
         .setup                  = timersd_setup,
         .thread_should_run      = timersd_should_run,
diff --git a/localversion-rt b/localversion-rt
index 05c35cb580779..6e44e540b927b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt11
+-rt12
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2ed5f2a0879d3..92180f1aa9edc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,8 +261,10 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
+struct memcg_stock_pcp;
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages);
+				      unsigned int nr_pages,
+				      struct memcg_stock_pcp *stock_pcp);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -296,7 +298,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
 
 	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
@@ -671,8 +673,14 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 	if (mem_cgroup_disabled())
 		return;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 	memcg_rstat_updated(memcg);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -699,6 +707,9 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 
@@ -706,6 +717,9 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 
 	memcg_rstat_updated(memcg);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 /**
@@ -788,8 +802,13 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
+	if (IS_ENABLED(PREEMPT_RT))
+		preempt_disable();
+
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
 	memcg_rstat_updated(memcg);
+	if (IS_ENABLED(PREEMPT_RT))
+		preempt_enable();
 }
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
@@ -810,6 +829,9 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 					 int nr_pages)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	/* pagein of a big page is an event. So, ignore page size */
 	if (nr_pages > 0)
 		__count_memcg_events(memcg, PGPGIN, 1);
@@ -819,12 +841,19 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	}
 
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				       enum mem_cgroup_events_target target)
 {
 	unsigned long val, next;
+	bool ret = false;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 
 	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
 	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
@@ -841,9 +870,11 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 			break;
 		}
 		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
-		return true;
+		ret = true;
 	}
-	return false;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	return ret;
 }
 
 /*
@@ -2091,26 +2122,40 @@ struct obj_stock {
 };
 
 struct memcg_stock_pcp {
+	/* Protects memcg_stock_pcp */
+	local_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
+#ifndef CONFIG_PREEMPTION
+	/* Protects only task_obj */
+	local_lock_t task_obj_lock;
 	struct obj_stock task_obj;
+#endif
 	struct obj_stock irq_obj;
 
 	struct work_struct work;
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
 };
-static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
+static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
+	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
+#ifndef CONFIG_PREEMPTION
+	.task_obj_lock = INIT_LOCAL_LOCK(task_obj_lock),
+#endif
+};
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
-static void drain_obj_stock(struct obj_stock *stock);
+static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+					  struct memcg_stock_pcp *stock_pcp);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
 #else
-static inline void drain_obj_stock(struct obj_stock *stock)
+static inline struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+						 struct memcg_stock_pcp *stock_pcp)
 {
+	return NULL;
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
@@ -2139,7 +2184,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
@@ -2147,7 +2192,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -2175,38 +2220,43 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 
 static void drain_local_stock(struct work_struct *dummy)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
+	struct memcg_stock_pcp *stock_pcp;
+	struct obj_cgroup *old;
 
 	/*
 	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_irq_save(flags);
+#ifndef CONFIG_PREEMPTION
+	local_lock(&memcg_stock.task_obj_lock);
+	old = drain_obj_stock(&this_cpu_ptr(&memcg_stock)->task_obj, NULL);
+	local_unlock(&memcg_stock.task_obj_lock);
+	if (old)
+		obj_cgroup_put(old);
+#endif
 
-	stock = this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(&stock->irq_obj);
-	if (in_task())
-		drain_obj_stock(&stock->task_obj);
-	drain_stock(stock);
-	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+	local_lock_irq(&memcg_stock.stock_lock);
+	stock_pcp = this_cpu_ptr(&memcg_stock);
+	old = drain_obj_stock(&stock_pcp->irq_obj, stock_pcp);
 
-	local_irq_restore(flags);
+	drain_stock(stock_pcp);
+	clear_bit(FLUSHING_CACHED_CHARGE, &stock_pcp->flags);
+
+	local_unlock_irq(&memcg_stock.stock_lock);
+	if (old)
+		obj_cgroup_put(old);
 }
 
 /*
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
  */
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
+			   struct memcg_stock_pcp *stock)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
+	lockdep_assert_held(&stock->stock_lock);
 
-	local_irq_save(flags);
-
-	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		css_get(&memcg->css);
@@ -2216,8 +2266,20 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
+}
 
-	local_irq_restore(flags);
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
+			 struct memcg_stock_pcp *stock_pcp)
+{
+	unsigned long flags;
+
+	if (stock_pcp) {
+		__refill_stock(memcg, nr_pages, stock_pcp);
+		return;
+	}
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	__refill_stock(memcg, nr_pages, this_cpu_ptr(&memcg_stock));
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
 /*
@@ -2226,7 +2288,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
-	int cpu, curcpu;
+	int cpu;
 
 	/* If someone's already draining, avoid adding running more workers. */
 	if (!mutex_trylock(&percpu_charge_mutex))
@@ -2237,7 +2299,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	curcpu = get_cpu();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2253,14 +2315,10 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		rcu_read_unlock();
 
 		if (flush &&
-		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
-			if (cpu == curcpu)
-				drain_local_stock(&stock->work);
-			else
-				schedule_work_on(cpu, &stock->work);
-		}
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
+			schedule_work_on(cpu, &stock->work);
 	}
-	put_cpu();
+	cpus_read_unlock();
 	mutex_unlock(&percpu_charge_mutex);
 }
 
@@ -2661,7 +2719,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 done_restock:
 	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
+		refill_stock(memcg, batch - nr_pages, NULL);
 
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
@@ -2774,28 +2832,35 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
  * can only be accessed after disabling interrupt. User context code can
  * access interrupt object stock, but not vice versa.
  */
-static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
+static inline struct obj_stock *get_obj_stock(unsigned long *pflags,
+					      struct memcg_stock_pcp **stock_pcp)
 {
 	struct memcg_stock_pcp *stock;
 
+#ifndef CONFIG_PREEMPTION
 	if (likely(in_task())) {
 		*pflags = 0UL;
-		preempt_disable();
+		*stock_pcp = NULL;
+		local_lock(&memcg_stock.task_obj_lock);
 		stock = this_cpu_ptr(&memcg_stock);
 		return &stock->task_obj;
 	}
-
-	local_irq_save(*pflags);
+#endif
+	local_lock_irqsave(&memcg_stock.stock_lock, *pflags);
 	stock = this_cpu_ptr(&memcg_stock);
+	*stock_pcp = stock;
 	return &stock->irq_obj;
 }
 
-static inline void put_obj_stock(unsigned long flags)
+static inline void put_obj_stock(unsigned long flags,
+				 struct memcg_stock_pcp *stock_pcp)
 {
-	if (likely(in_task()))
-		preempt_enable();
+#ifndef CONFIG_PREEMPTION
+	if (likely(!stock_pcp))
+		local_unlock(&memcg_stock.task_obj_lock);
 	else
-		local_irq_restore(flags);
+#endif
+		local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
 /*
@@ -2973,7 +3038,8 @@ static void memcg_free_cache_id(int id)
  * @nr_pages: number of pages to uncharge
  */
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages)
+				      unsigned int nr_pages,
+				      struct memcg_stock_pcp *stock_pcp)
 {
 	struct mem_cgroup *memcg;
 
@@ -2981,7 +3047,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, stock_pcp);
 
 	css_put(&memcg->css);
 }
@@ -3055,7 +3121,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 		return;
 
 	objcg = __folio_objcg(folio);
-	obj_cgroup_uncharge_pages(objcg, nr_pages);
+	obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
 	folio->memcg_data = 0;
 	obj_cgroup_put(objcg);
 }
@@ -3063,17 +3129,21 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
+	struct memcg_stock_pcp *stock_pcp;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_cgroup *old = NULL;
+	struct obj_stock *stock;
 	int *bytes;
 
+	stock = get_obj_stock(&flags, &stock_pcp);
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat or idx
 	 * changes.
 	 */
 	if (stock->cached_objcg != objcg) {
-		drain_obj_stock(stock);
+		old = drain_obj_stock(stock, stock_pcp);
+
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
@@ -3117,38 +3187,43 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_pcp);
+	if (old)
+		obj_cgroup_put(old);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
+	struct memcg_stock_pcp *stock_pcp;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_stock *stock;
 	bool ret = false;
 
+	stock = get_obj_stock(&flags, &stock_pcp);
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
 	}
 
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_pcp);
 
 	return ret;
 }
 
-static void drain_obj_stock(struct obj_stock *stock)
+static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+					  struct memcg_stock_pcp *stock_pcp)
 {
 	struct obj_cgroup *old = stock->cached_objcg;
 
 	if (!old)
-		return;
+		return NULL;
 
 	if (stock->nr_bytes) {
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
 		if (nr_pages)
-			obj_cgroup_uncharge_pages(old, nr_pages);
+			obj_cgroup_uncharge_pages(old, nr_pages, stock_pcp);
 
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3183,8 +3258,8 @@ static void drain_obj_stock(struct obj_stock *stock)
 		stock->cached_pgdat = NULL;
 	}
 
-	obj_cgroup_put(old);
 	stock->cached_objcg = NULL;
+	return old;
 }
 
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -3192,11 +3267,13 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
 
+#ifndef CONFIG_PREEMPTION
 	if (in_task() && stock->task_obj.cached_objcg) {
 		memcg = obj_cgroup_memcg(stock->task_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
+#endif
 	if (stock->irq_obj.cached_objcg) {
 		memcg = obj_cgroup_memcg(stock->irq_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
@@ -3209,12 +3286,15 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
+	struct memcg_stock_pcp *stock_pcp;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_stock *stock;
 	unsigned int nr_pages = 0;
+	struct obj_cgroup *old = NULL;
 
+	stock = get_obj_stock(&flags, &stock_pcp);
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+		old = drain_obj_stock(stock, stock_pcp);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg = objcg;
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
@@ -3228,10 +3308,12 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_pcp);
+	if (old)
+		obj_cgroup_put(old);
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
 }
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -5645,12 +5727,14 @@ static int mem_cgroup_move_account(struct page *page,
 	ret = 0;
 	nid = folio_nid(folio);
 
-	local_irq_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 	mem_cgroup_charge_statistics(to, nr_pages);
 	memcg_check_events(to, nid);
 	mem_cgroup_charge_statistics(from, -nr_pages);
 	memcg_check_events(from, nid);
-	local_irq_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
 out_unlock:
 	folio_unlock(folio);
 out:
@@ -6670,10 +6754,12 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	css_get(&memcg->css);
 	commit_charge(folio, memcg);
 
-	local_irq_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(folio));
-	local_irq_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
 out:
 	return ret;
 }
@@ -6785,11 +6871,20 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		memcg_oom_recover(ug->memcg);
 	}
 
-	local_irq_save(flags);
-	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-	memcg_check_events(ug->memcg, ug->nid);
-	local_irq_restore(flags);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		local_irq_save(flags);
+		__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
+		__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+		memcg_check_events(ug->memcg, ug->nid);
+		local_irq_restore(flags);
+	} else {
+		preempt_disable();
+		__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
+		__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+		preempt_enable();
+
+		memcg_check_events(ug->memcg, ug->nid);
+	}
 
 	/* drop reference from uncharge_folio */
 	css_put(&ug->memcg->css);
@@ -6930,10 +7025,12 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	css_get(&memcg->css);
 	commit_charge(new, memcg);
 
-	local_irq_save(flags);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(new));
-	local_irq_restore(flags);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(flags);
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7017,7 +7114,7 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, NULL);
 }
 
 static int __init cgroup_memory(char *s)
@@ -7157,8 +7254,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * i_pages lock which is taken with interrupts-off. It is
 	 * important here to have the interrupts disabled because it is the
 	 * only synchronisation we have for updating the per-CPU variables.
+	 * On PREEMPT_RT interrupts are never disabled and the updates to per-CPU
+	 * variables are synchronised by keeping preemption disabled.
 	 */
-	VM_BUG_ON(!irqs_disabled());
+	VM_BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT) && !irqs_disabled());
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
 	memcg_check_events(memcg, page_to_nid(page));
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 0179312d11c43..250e90116888e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -222,18 +222,38 @@ static inline struct hlist_head *dev_index_hash(struct net *net, int ifindex)
 	return &net->dev_index_head[ifindex & (NETDEV_HASHENTRIES - 1)];
 }
 
-static inline void rps_lock(struct softnet_data *sd)
+static inline void rps_lock_irqsave(struct softnet_data *sd,
+				    unsigned long *flags)
 {
-#ifdef CONFIG_RPS
-	raw_spin_lock(&sd->input_pkt_queue.raw_lock);
-#endif
+	if (IS_ENABLED(CONFIG_RPS))
+		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_save(*flags);
 }
 
-static inline void rps_unlock(struct softnet_data *sd)
+static inline void rps_lock_irq_disable(struct softnet_data *sd)
 {
-#ifdef CONFIG_RPS
-	raw_spin_unlock(&sd->input_pkt_queue.raw_lock);
-#endif
+	if (IS_ENABLED(CONFIG_RPS))
+		spin_lock_irq(&sd->input_pkt_queue.lock);
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
+}
+
+static inline void rps_unlock_irq_restore(struct softnet_data *sd,
+					  unsigned long *flags)
+{
+	if (IS_ENABLED(CONFIG_RPS))
+		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(*flags);
+}
+
+static inline void rps_unlock_irq_enable(struct softnet_data *sd)
+{
+	if (IS_ENABLED(CONFIG_RPS))
+		spin_unlock_irq(&sd->input_pkt_queue.lock);
+	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
 }
 
 static struct netdev_name_node *netdev_name_node_alloc(struct net_device *dev,
@@ -4646,9 +4666,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 
 	sd = &per_cpu(softnet_data, cpu);
 
-	local_irq_save(flags);
-
-	rps_lock(sd);
+	rps_lock_irqsave(sd, &flags);
 	if (!netif_running(skb->dev))
 		goto drop;
 	qlen = skb_queue_len(&sd->input_pkt_queue);
@@ -4657,27 +4675,30 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 enqueue:
 			__skb_queue_tail(&sd->input_pkt_queue, skb);
 			input_queue_tail_incr_save(sd, qtail);
-			rps_unlock(sd);
-			local_irq_restore(flags);
+			rps_unlock_irq_restore(sd, &flags);
 			return NET_RX_SUCCESS;
 		}
 
 		/* Schedule NAPI for backlog device
 		 * We can use non atomic operation since we own the queue lock
+		 * PREEMPT_RT needs to disable interrupts here for
+		 * synchronisation needed in napi_schedule.
 		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_disable();
+
 		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state)) {
 			if (!rps_ipi_queued(sd))
 				____napi_schedule(sd, &sd->backlog);
 		}
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_enable();
 		goto enqueue;
 	}
 
 drop:
 	sd->dropped++;
-	rps_unlock(sd);
-
-	local_irq_restore(flags);
-	preempt_check_resched_rt();
+	rps_unlock_irq_restore(sd, &flags);
 
 	atomic_long_inc(&skb->dev->rx_dropped);
 	kfree_skb(skb);
@@ -4918,7 +4939,6 @@ static int netif_rx_internal(struct sk_buff *skb)
 		struct rps_dev_flow voidflow, *rflow = &voidflow;
 		int cpu;
 
-		migrate_disable();
 		rcu_read_lock();
 
 		cpu = get_rps_cpu(skb->dev, skb, &rflow);
@@ -4928,14 +4948,12 @@ static int netif_rx_internal(struct sk_buff *skb)
 		ret = enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
 
 		rcu_read_unlock();
-		migrate_enable();
 	} else
 #endif
 	{
 		unsigned int qtail;
 
-		ret = enqueue_to_backlog(skb, get_cpu_light(), &qtail);
-		put_cpu_light();
+		ret = enqueue_to_backlog(skb, smp_processor_id(), &qtail);
 	}
 	return ret;
 }
@@ -4959,45 +4977,17 @@ int netif_rx(struct sk_buff *skb)
 {
 	int ret;
 
+	local_bh_disable();
 	trace_netif_rx_entry(skb);
 
 	ret = netif_rx_internal(skb);
 	trace_netif_rx_exit(ret);
+	local_bh_enable();
 
 	return ret;
 }
 EXPORT_SYMBOL(netif_rx);
 
-int netif_rx_ni(struct sk_buff *skb)
-{
-	int err;
-
-	trace_netif_rx_ni_entry(skb);
-
-	local_bh_disable();
-	err = netif_rx_internal(skb);
-	local_bh_enable();
-	trace_netif_rx_ni_exit(err);
-
-	return err;
-}
-EXPORT_SYMBOL(netif_rx_ni);
-
-int netif_rx_any_context(struct sk_buff *skb)
-{
-	/*
-	 * If invoked from contexts which do not invoke bottom half
-	 * processing either at return from interrupt or when softrqs are
-	 * reenabled, use netif_rx_ni() which invokes bottomhalf processing
-	 * directly.
-	 */
-	if (in_interrupt())
-		return netif_rx(skb);
-	else
-		return netif_rx_ni(skb);
-}
-EXPORT_SYMBOL(netif_rx_any_context);
-
 static __latent_entropy void net_tx_action(struct softirq_action *h)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
@@ -5769,8 +5759,7 @@ static void flush_backlog(struct work_struct *work)
 	local_bh_disable();
 	sd = this_cpu_ptr(&softnet_data);
 
-	local_irq_disable();
-	rps_lock(sd);
+	rps_lock_irq_disable(sd);
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
@@ -5778,8 +5767,7 @@ static void flush_backlog(struct work_struct *work)
 			input_queue_head_incr(sd);
 		}
 	}
-	rps_unlock(sd);
-	local_irq_enable();
+	rps_unlock_irq_enable(sd);
 
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
@@ -5797,16 +5785,14 @@ static bool flush_required(int cpu)
 	struct softnet_data *sd = &per_cpu(softnet_data, cpu);
 	bool do_flush;
 
-	local_irq_disable();
-	rps_lock(sd);
+	rps_lock_irq_disable(sd);
 
 	/* as insertion into process_queue happens with the rps lock held,
 	 * process_queue access may race only with dequeue
 	 */
 	do_flush = !skb_queue_empty(&sd->input_pkt_queue) ||
 		   !skb_queue_empty_lockless(&sd->process_queue);
-	rps_unlock(sd);
-	local_irq_enable();
+	rps_unlock_irq_enable(sd);
 
 	return do_flush;
 #endif
@@ -6467,8 +6453,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 
 		}
 
-		local_irq_disable();
-		rps_lock(sd);
+		rps_lock_irq_disable(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
 			/*
 			 * Inline a custom version of __napi_complete().
@@ -6484,8 +6469,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
 						   &sd->process_queue);
 		}
-		rps_unlock(sd);
-		local_irq_enable();
+		rps_unlock_irq_enable(sd);
 	}
 
 	return work;
@@ -11351,7 +11335,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
 		netif_rx_ni(skb);
 		input_queue_head_incr(oldsd);
 	}
-	while ((skb = __skb_dequeue(&oldsd->input_pkt_queue))) {
+	while ((skb = skb_dequeue(&oldsd->input_pkt_queue))) {
 		netif_rx_ni(skb);
 		input_queue_head_incr(oldsd);
 	}
@@ -11667,7 +11651,7 @@ static int __init net_dev_init(void)
 
 		INIT_WORK(flush, flush_backlog);
 
-		skb_queue_head_init_raw(&sd->input_pkt_queue);
+		skb_queue_head_init(&sd->input_pkt_queue);
 		skb_queue_head_init(&sd->process_queue);
 #ifdef CONFIG_XFRM_OFFLOAD
 		skb_queue_head_init(&sd->xfrm_backlog);
