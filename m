Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AFE493F45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350491AbiASRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:45:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbiASRpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:45:52 -0500
Date:   Wed, 19 Jan 2022 18:45:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642614351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=G2Nmpw5BUOxEQDXlzdc+atLfVWzm+oO78LJqB6GrUzI=;
        b=quZzI9v8tqH8XuP8o4U1T4YfwAKRcIOGIh2vVG+lWA7rBx2S1udtNKbSNpPV+/i3wxuDiW
        DU+f7TlsKhshCHqF3dEDSePeLsM+yJ0ydnBioMgSz943dc1yILy/ekUovp7ghXF6n6e29F
        5f0RpILyEY79hD0Um5vC5IFR+gZa84SrpBfUZWer1BIBxSK2bykNOOSiu+I0QuKRYxfaW4
        ff2jtACAV9MHqFqirE0u4cloubEGswEXaEDKynTVq8iiyWn+ffjX2WuT+/Gh7g2MhNs3yL
        2QvZrmKSmp8TIBojDWSBJzUKqsd5UJspeseqjzBZqKnh/obc7zUORVvFkZ2TBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642614351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=G2Nmpw5BUOxEQDXlzdc+atLfVWzm+oO78LJqB6GrUzI=;
        b=/CKATryXVM+n0LeKem7BDFtIDP1/fDMOR5mHGlZfqBnFrFvx8to9VcDVCWglWx1BwXKaW0
        2LemFEwlr2dXIOCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.16.1-rt17
Message-ID: <YehOTf13ehdN5pf7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.16.1-rt17 patch set. 

Changes since v5.16.1-rt16:

  - Make sure that the local_lock_*() are completely optimized away on
    !RT without debug.

  - Updates to memcg: Disable the threshold handler on RT which is a
    cgroup v1 feature (deprecated).

  - i2c:
    - Host notify on smbus seems not working on RT. Reported by Michael
      Below, waiting for feedback.

    - The rcar host driver must not disable force threading.

Known issues
     - netconsole triggers WARN.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.16.1-rt16 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/incr/patch-5.16.1-rt16-rt17.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16.1-rt17

The RT patch against v5.16.1 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16.1-rt17.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16.1-rt17.tar.xz

Sebastian

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index faac50149a222..2cc502a75ef64 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -64,6 +64,7 @@ Brief summary of control files.
 				     threads
  cgroup.procs			     show list of processes
  cgroup.event_control		     an interface for event_fd()
+				     This knob is not available on CONFIG_PREEMPT_RT systems.
  memory.usage_in_bytes		     show current usage for memory
 				     (See 5.5 for details)
  memory.memsw.usage_in_bytes	     show current usage for memory+Swap
@@ -75,6 +76,7 @@ Brief summary of control files.
  memory.max_usage_in_bytes	     show max memory usage recorded
  memory.memsw.max_usage_in_bytes     show max memory+Swap usage recorded
  memory.soft_limit_in_bytes	     set/show soft limit of memory usage
+				     This knob is not available on CONFIG_PREEMPT_RT systems.
  memory.stat			     show various statistics
  memory.use_hierarchy		     set/show hierarchical account enabled
                                      This knob is deprecated and shouldn't be
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index fc13511f4562c..37e7bf4c14cea 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1025,7 +1025,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	struct rcar_i2c_priv *priv;
 	struct i2c_adapter *adap;
 	struct device *dev = &pdev->dev;
-	unsigned long irqflags = 0;
 	irqreturn_t (*irqhandler)(int irq, void *ptr) = rcar_i2c_gen3_irq;
 	int ret;
 
@@ -1076,7 +1075,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
 
 	if (priv->devtype < I2C_RCAR_GEN3) {
-		irqflags |= IRQF_NO_THREAD;
 		irqhandler = rcar_i2c_gen2_irq;
 	}
 
@@ -1102,7 +1100,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_pm_disable;
 	priv->irq = ret;
-	ret = devm_request_irq(dev, priv->irq, irqhandler, irqflags, dev_name(dev), priv);
+	ret = devm_request_irq(dev, priv->irq, irqhandler, 0, dev_name(dev), priv);
 	if (ret < 0) {
 		dev_err(dev, "cannot get irq %d\n", priv->irq);
 		goto out_pm_disable;
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 73253e667de1d..30e93651d5b6b 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1423,7 +1423,10 @@ int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr)
 	if (irq <= 0)
 		return -ENXIO;
 
-	generic_handle_irq(irq);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		generic_handle_irq(irq);
+	else
+		handle_nested_irq(irq);
 
 	return 0;
 }
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 975e33b793a77..6d635e8306d64 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -44,9 +44,9 @@ static inline void local_lock_debug_init(local_lock_t *l)
 }
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
-static inline void local_lock_acquire(local_lock_t *l) { }
-static inline void local_lock_release(local_lock_t *l) { }
-static inline void local_lock_debug_init(local_lock_t *l) { }
+# define local_lock_acquire(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
+# define local_lock_release(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
+# define local_lock_debug_init(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
diff --git a/localversion-rt b/localversion-rt
index 1199ebade17b4..1e584b47c987e 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt16
+-rt17
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bfb99225527fe..eb6873f43ef56 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -169,7 +169,6 @@ struct mem_cgroup_event {
 	struct work_struct remove;
 };
 
-static void mem_cgroup_threshold(struct mem_cgroup *memcg);
 static void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
 
 /* Stuffs for move charges at task migration. */
@@ -523,43 +522,6 @@ static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
 	return excess;
 }
 
-static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
-{
-	unsigned long excess;
-	struct mem_cgroup_per_node *mz;
-	struct mem_cgroup_tree_per_node *mctz;
-
-	mctz = soft_limit_tree.rb_tree_per_node[nid];
-	if (!mctz)
-		return;
-	/*
-	 * Necessary to update all ancestors when hierarchy is used.
-	 * because their event counter is not touched.
-	 */
-	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		mz = memcg->nodeinfo[nid];
-		excess = soft_limit_excess(memcg);
-		/*
-		 * We have to update the tree if mz is on RB-tree or
-		 * mem is over its softlimit.
-		 */
-		if (excess || mz->on_tree) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&mctz->lock, flags);
-			/* if on-tree, remove it */
-			if (mz->on_tree)
-				__mem_cgroup_remove_exceeded(mz, mctz);
-			/*
-			 * Insert again. mz->usage_in_excess will be updated.
-			 * If excess is 0, no tree ops.
-			 */
-			__mem_cgroup_insert_exceeded(mz, mctz, excess);
-			spin_unlock_irqrestore(&mctz->lock, flags);
-		}
-	}
-}
-
 static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_tree_per_node *mctz;
@@ -673,14 +635,8 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 	if (mem_cgroup_disabled())
 		return;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
-
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 	memcg_rstat_updated(memcg);
-
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -709,7 +665,6 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_disable();
-
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 
@@ -717,7 +672,6 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 
 	memcg_rstat_updated(memcg);
-
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
 }
@@ -804,7 +758,6 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 
 	if (IS_ENABLED(PREEMPT_RT))
 		preempt_disable();
-
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
 	memcg_rstat_updated(memcg);
 	if (IS_ENABLED(PREEMPT_RT))
@@ -829,9 +782,6 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 					 int nr_pages)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
-
 	/* pagein of a big page is an event. So, ignore page size */
 	if (nr_pages > 0)
 		__count_memcg_events(memcg, PGPGIN, 1);
@@ -841,59 +791,6 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	}
 
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
-
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
-}
-
-static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
-				       enum mem_cgroup_events_target target)
-{
-	unsigned long val, next;
-	bool ret = false;
-
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_disable();
-
-	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
-	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
-	/* from time_after() in jiffies.h */
-	if ((long)(next - val) < 0) {
-		switch (target) {
-		case MEM_CGROUP_TARGET_THRESH:
-			next = val + THRESHOLDS_EVENTS_TARGET;
-			break;
-		case MEM_CGROUP_TARGET_SOFTLIMIT:
-			next = val + SOFTLIMIT_EVENTS_TARGET;
-			break;
-		default:
-			break;
-		}
-		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
-		ret = true;
-	}
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		preempt_enable();
-	return ret;
-}
-
-/*
- * Check events in order.
- *
- */
-static void memcg_check_events(struct mem_cgroup *memcg, int nid)
-{
-	/* threshold event is triggered in finer grain than soft limit */
-	if (unlikely(mem_cgroup_event_ratelimit(memcg,
-						MEM_CGROUP_TARGET_THRESH))) {
-		bool do_softlimit;
-
-		do_softlimit = mem_cgroup_event_ratelimit(memcg,
-						MEM_CGROUP_TARGET_SOFTLIMIT);
-		mem_cgroup_threshold(memcg);
-		if (unlikely(do_softlimit))
-			mem_cgroup_update_tree(memcg, nid);
-	}
 }
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
@@ -3834,8 +3731,12 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
 		}
 		break;
 	case RES_SOFT_LIMIT:
+#ifndef CONFIG_PREEMPT_RT
 		memcg->soft_limit = nr_pages;
 		ret = 0;
+#else
+		ret = -EOPNOTSUPP;
+#endif
 		break;
 	}
 	return ret ?: nbytes;
@@ -4140,82 +4041,6 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
-static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
-{
-	struct mem_cgroup_threshold_ary *t;
-	unsigned long usage;
-	int i;
-
-	rcu_read_lock();
-	if (!swap)
-		t = rcu_dereference(memcg->thresholds.primary);
-	else
-		t = rcu_dereference(memcg->memsw_thresholds.primary);
-
-	if (!t)
-		goto unlock;
-
-	usage = mem_cgroup_usage(memcg, swap);
-
-	/*
-	 * current_threshold points to threshold just below or equal to usage.
-	 * If it's not true, a threshold was crossed after last
-	 * call of __mem_cgroup_threshold().
-	 */
-	i = t->current_threshold;
-
-	/*
-	 * Iterate backward over array of thresholds starting from
-	 * current_threshold and check if a threshold is crossed.
-	 * If none of thresholds below usage is crossed, we read
-	 * only one element of the array here.
-	 */
-	for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
-		eventfd_signal(t->entries[i].eventfd, 1);
-
-	/* i = current_threshold + 1 */
-	i++;
-
-	/*
-	 * Iterate forward over array of thresholds starting from
-	 * current_threshold+1 and check if a threshold is crossed.
-	 * If none of thresholds above usage is crossed, we read
-	 * only one element of the array here.
-	 */
-	for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
-		eventfd_signal(t->entries[i].eventfd, 1);
-
-	/* Update current_threshold */
-	t->current_threshold = i - 1;
-unlock:
-	rcu_read_unlock();
-}
-
-static void mem_cgroup_threshold(struct mem_cgroup *memcg)
-{
-	while (memcg) {
-		__mem_cgroup_threshold(memcg, false);
-		if (do_memsw_account())
-			__mem_cgroup_threshold(memcg, true);
-
-		memcg = parent_mem_cgroup(memcg);
-	}
-}
-
-static int compare_thresholds(const void *a, const void *b)
-{
-	const struct mem_cgroup_threshold *_a = a;
-	const struct mem_cgroup_threshold *_b = b;
-
-	if (_a->threshold > _b->threshold)
-		return 1;
-
-	if (_a->threshold < _b->threshold)
-		return -1;
-
-	return 0;
-}
-
 static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
 {
 	struct mem_cgroup_eventfd_list *ev;
@@ -4237,234 +4062,6 @@ static void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
 		mem_cgroup_oom_notify_cb(iter);
 }
 
-static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
-{
-	struct mem_cgroup_thresholds *thresholds;
-	struct mem_cgroup_threshold_ary *new;
-	unsigned long threshold;
-	unsigned long usage;
-	int i, size, ret;
-
-	ret = page_counter_memparse(args, "-1", &threshold);
-	if (ret)
-		return ret;
-
-	mutex_lock(&memcg->thresholds_lock);
-
-	if (type == _MEM) {
-		thresholds = &memcg->thresholds;
-		usage = mem_cgroup_usage(memcg, false);
-	} else if (type == _MEMSWAP) {
-		thresholds = &memcg->memsw_thresholds;
-		usage = mem_cgroup_usage(memcg, true);
-	} else
-		BUG();
-
-	/* Check if a threshold crossed before adding a new one */
-	if (thresholds->primary)
-		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
-
-	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
-
-	/* Allocate memory for new array of thresholds */
-	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
-	if (!new) {
-		ret = -ENOMEM;
-		goto unlock;
-	}
-	new->size = size;
-
-	/* Copy thresholds (if any) to new array */
-	if (thresholds->primary)
-		memcpy(new->entries, thresholds->primary->entries,
-		       flex_array_size(new, entries, size - 1));
-
-	/* Add new threshold */
-	new->entries[size - 1].eventfd = eventfd;
-	new->entries[size - 1].threshold = threshold;
-
-	/* Sort thresholds. Registering of new threshold isn't time-critical */
-	sort(new->entries, size, sizeof(*new->entries),
-			compare_thresholds, NULL);
-
-	/* Find current threshold */
-	new->current_threshold = -1;
-	for (i = 0; i < size; i++) {
-		if (new->entries[i].threshold <= usage) {
-			/*
-			 * new->current_threshold will not be used until
-			 * rcu_assign_pointer(), so it's safe to increment
-			 * it here.
-			 */
-			++new->current_threshold;
-		} else
-			break;
-	}
-
-	/* Free old spare buffer and save old primary buffer as spare */
-	kfree(thresholds->spare);
-	thresholds->spare = thresholds->primary;
-
-	rcu_assign_pointer(thresholds->primary, new);
-
-	/* To be sure that nobody uses thresholds */
-	synchronize_rcu();
-
-unlock:
-	mutex_unlock(&memcg->thresholds_lock);
-
-	return ret;
-}
-
-static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args)
-{
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
-}
-
-static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args)
-{
-	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
-}
-
-static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, enum res_type type)
-{
-	struct mem_cgroup_thresholds *thresholds;
-	struct mem_cgroup_threshold_ary *new;
-	unsigned long usage;
-	int i, j, size, entries;
-
-	mutex_lock(&memcg->thresholds_lock);
-
-	if (type == _MEM) {
-		thresholds = &memcg->thresholds;
-		usage = mem_cgroup_usage(memcg, false);
-	} else if (type == _MEMSWAP) {
-		thresholds = &memcg->memsw_thresholds;
-		usage = mem_cgroup_usage(memcg, true);
-	} else
-		BUG();
-
-	if (!thresholds->primary)
-		goto unlock;
-
-	/* Check if a threshold crossed before removing */
-	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
-
-	/* Calculate new number of threshold */
-	size = entries = 0;
-	for (i = 0; i < thresholds->primary->size; i++) {
-		if (thresholds->primary->entries[i].eventfd != eventfd)
-			size++;
-		else
-			entries++;
-	}
-
-	new = thresholds->spare;
-
-	/* If no items related to eventfd have been cleared, nothing to do */
-	if (!entries)
-		goto unlock;
-
-	/* Set thresholds array to NULL if we don't have thresholds */
-	if (!size) {
-		kfree(new);
-		new = NULL;
-		goto swap_buffers;
-	}
-
-	new->size = size;
-
-	/* Copy thresholds and find current threshold */
-	new->current_threshold = -1;
-	for (i = 0, j = 0; i < thresholds->primary->size; i++) {
-		if (thresholds->primary->entries[i].eventfd == eventfd)
-			continue;
-
-		new->entries[j] = thresholds->primary->entries[i];
-		if (new->entries[j].threshold <= usage) {
-			/*
-			 * new->current_threshold will not be used
-			 * until rcu_assign_pointer(), so it's safe to increment
-			 * it here.
-			 */
-			++new->current_threshold;
-		}
-		j++;
-	}
-
-swap_buffers:
-	/* Swap primary and spare array */
-	thresholds->spare = thresholds->primary;
-
-	rcu_assign_pointer(thresholds->primary, new);
-
-	/* To be sure that nobody uses thresholds */
-	synchronize_rcu();
-
-	/* If all events are unregistered, free the spare array */
-	if (!new) {
-		kfree(thresholds->spare);
-		thresholds->spare = NULL;
-	}
-unlock:
-	mutex_unlock(&memcg->thresholds_lock);
-}
-
-static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd)
-{
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
-}
-
-static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd)
-{
-	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
-}
-
-static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd, const char *args)
-{
-	struct mem_cgroup_eventfd_list *event;
-
-	event = kmalloc(sizeof(*event),	GFP_KERNEL);
-	if (!event)
-		return -ENOMEM;
-
-	spin_lock(&memcg_oom_lock);
-
-	event->eventfd = eventfd;
-	list_add(&event->list, &memcg->oom_notify);
-
-	/* already in OOM ? */
-	if (memcg->under_oom)
-		eventfd_signal(eventfd, 1);
-	spin_unlock(&memcg_oom_lock);
-
-	return 0;
-}
-
-static void mem_cgroup_oom_unregister_event(struct mem_cgroup *memcg,
-	struct eventfd_ctx *eventfd)
-{
-	struct mem_cgroup_eventfd_list *ev, *tmp;
-
-	spin_lock(&memcg_oom_lock);
-
-	list_for_each_entry_safe(ev, tmp, &memcg->oom_notify, list) {
-		if (ev->eventfd == eventfd) {
-			list_del(&ev->list);
-			kfree(ev);
-		}
-	}
-
-	spin_unlock(&memcg_oom_lock);
-}
-
 static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
@@ -4705,6 +4302,7 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
+#ifndef CONFIG_PREEMPT_RT
 /*
  * DO NOT USE IN NEW FILES.
  *
@@ -4718,6 +4316,391 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
  * possible.
  */
 
+static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
+				       enum mem_cgroup_events_target target)
+{
+	unsigned long val, next;
+
+	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
+	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
+	/* from time_after() in jiffies.h */
+	if ((long)(next - val) < 0) {
+		switch (target) {
+		case MEM_CGROUP_TARGET_THRESH:
+			next = val + THRESHOLDS_EVENTS_TARGET;
+			break;
+		case MEM_CGROUP_TARGET_SOFTLIMIT:
+			next = val + SOFTLIMIT_EVENTS_TARGET;
+			break;
+		default:
+			break;
+		}
+		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
+		return true;
+	}
+	return false;
+}
+
+static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
+{
+	unsigned long excess;
+	struct mem_cgroup_per_node *mz;
+	struct mem_cgroup_tree_per_node *mctz;
+
+	mctz = soft_limit_tree.rb_tree_per_node[nid];
+	if (!mctz)
+		return;
+	/*
+	 * Necessary to update all ancestors when hierarchy is used.
+	 * because their event counter is not touched.
+	 */
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		mz = memcg->nodeinfo[nid];
+		excess = soft_limit_excess(memcg);
+		/*
+		 * We have to update the tree if mz is on RB-tree or
+		 * mem is over its softlimit.
+		 */
+		if (excess || mz->on_tree) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&mctz->lock, flags);
+			/* if on-tree, remove it */
+			if (mz->on_tree)
+				__mem_cgroup_remove_exceeded(mz, mctz);
+			/*
+			 * Insert again. mz->usage_in_excess will be updated.
+			 * If excess is 0, no tree ops.
+			 */
+			__mem_cgroup_insert_exceeded(mz, mctz, excess);
+			spin_unlock_irqrestore(&mctz->lock, flags);
+		}
+	}
+}
+
+static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
+{
+	struct mem_cgroup_threshold_ary *t;
+	unsigned long usage;
+	int i;
+
+	rcu_read_lock();
+	if (!swap)
+		t = rcu_dereference(memcg->thresholds.primary);
+	else
+		t = rcu_dereference(memcg->memsw_thresholds.primary);
+
+	if (!t)
+		goto unlock;
+
+	usage = mem_cgroup_usage(memcg, swap);
+
+	/*
+	 * current_threshold points to threshold just below or equal to usage.
+	 * If it's not true, a threshold was crossed after last
+	 * call of __mem_cgroup_threshold().
+	 */
+	i = t->current_threshold;
+
+	/*
+	 * Iterate backward over array of thresholds starting from
+	 * current_threshold and check if a threshold is crossed.
+	 * If none of thresholds below usage is crossed, we read
+	 * only one element of the array here.
+	 */
+	for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
+		eventfd_signal(t->entries[i].eventfd, 1);
+
+	/* i = current_threshold + 1 */
+	i++;
+
+	/*
+	 * Iterate forward over array of thresholds starting from
+	 * current_threshold+1 and check if a threshold is crossed.
+	 * If none of thresholds above usage is crossed, we read
+	 * only one element of the array here.
+	 */
+	for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
+		eventfd_signal(t->entries[i].eventfd, 1);
+
+	/* Update current_threshold */
+	t->current_threshold = i - 1;
+unlock:
+	rcu_read_unlock();
+}
+
+static void mem_cgroup_threshold(struct mem_cgroup *memcg)
+{
+	while (memcg) {
+		__mem_cgroup_threshold(memcg, false);
+		if (do_memsw_account())
+			__mem_cgroup_threshold(memcg, true);
+
+		memcg = parent_mem_cgroup(memcg);
+	}
+}
+
+/*
+ * Check events in order.
+ *
+ */
+static void memcg_check_events(struct mem_cgroup *memcg, int nid)
+{
+	/* threshold event is triggered in finer grain than soft limit */
+	if (unlikely(mem_cgroup_event_ratelimit(memcg,
+						MEM_CGROUP_TARGET_THRESH))) {
+		bool do_softlimit;
+
+		do_softlimit = mem_cgroup_event_ratelimit(memcg,
+						MEM_CGROUP_TARGET_SOFTLIMIT);
+		mem_cgroup_threshold(memcg);
+		if (unlikely(do_softlimit))
+			mem_cgroup_update_tree(memcg, nid);
+	}
+}
+
+static int compare_thresholds(const void *a, const void *b)
+{
+	const struct mem_cgroup_threshold *_a = a;
+	const struct mem_cgroup_threshold *_b = b;
+
+	if (_a->threshold > _b->threshold)
+		return 1;
+
+	if (_a->threshold < _b->threshold)
+		return -1;
+
+	return 0;
+}
+
+static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
+{
+	struct mem_cgroup_thresholds *thresholds;
+	struct mem_cgroup_threshold_ary *new;
+	unsigned long threshold;
+	unsigned long usage;
+	int i, size, ret;
+
+	ret = page_counter_memparse(args, "-1", &threshold);
+	if (ret)
+		return ret;
+
+	mutex_lock(&memcg->thresholds_lock);
+
+	if (type == _MEM) {
+		thresholds = &memcg->thresholds;
+		usage = mem_cgroup_usage(memcg, false);
+	} else if (type == _MEMSWAP) {
+		thresholds = &memcg->memsw_thresholds;
+		usage = mem_cgroup_usage(memcg, true);
+	} else
+		BUG();
+
+	/* Check if a threshold crossed before adding a new one */
+	if (thresholds->primary)
+		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+
+	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
+
+	/* Allocate memory for new array of thresholds */
+	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
+	if (!new) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+	new->size = size;
+
+	/* Copy thresholds (if any) to new array */
+	if (thresholds->primary)
+		memcpy(new->entries, thresholds->primary->entries,
+		       flex_array_size(new, entries, size - 1));
+
+	/* Add new threshold */
+	new->entries[size - 1].eventfd = eventfd;
+	new->entries[size - 1].threshold = threshold;
+
+	/* Sort thresholds. Registering of new threshold isn't time-critical */
+	sort(new->entries, size, sizeof(*new->entries),
+			compare_thresholds, NULL);
+
+	/* Find current threshold */
+	new->current_threshold = -1;
+	for (i = 0; i < size; i++) {
+		if (new->entries[i].threshold <= usage) {
+			/*
+			 * new->current_threshold will not be used until
+			 * rcu_assign_pointer(), so it's safe to increment
+			 * it here.
+			 */
+			++new->current_threshold;
+		} else
+			break;
+	}
+
+	/* Free old spare buffer and save old primary buffer as spare */
+	kfree(thresholds->spare);
+	thresholds->spare = thresholds->primary;
+
+	rcu_assign_pointer(thresholds->primary, new);
+
+	/* To be sure that nobody uses thresholds */
+	synchronize_rcu();
+
+unlock:
+	mutex_unlock(&memcg->thresholds_lock);
+
+	return ret;
+}
+
+static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args)
+{
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
+}
+
+static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args)
+{
+	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
+}
+
+static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, enum res_type type)
+{
+	struct mem_cgroup_thresholds *thresholds;
+	struct mem_cgroup_threshold_ary *new;
+	unsigned long usage;
+	int i, j, size, entries;
+
+	mutex_lock(&memcg->thresholds_lock);
+
+	if (type == _MEM) {
+		thresholds = &memcg->thresholds;
+		usage = mem_cgroup_usage(memcg, false);
+	} else if (type == _MEMSWAP) {
+		thresholds = &memcg->memsw_thresholds;
+		usage = mem_cgroup_usage(memcg, true);
+	} else
+		BUG();
+
+	if (!thresholds->primary)
+		goto unlock;
+
+	/* Check if a threshold crossed before removing */
+	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
+
+	/* Calculate new number of threshold */
+	size = entries = 0;
+	for (i = 0; i < thresholds->primary->size; i++) {
+		if (thresholds->primary->entries[i].eventfd != eventfd)
+			size++;
+		else
+			entries++;
+	}
+
+	new = thresholds->spare;
+
+	/* If no items related to eventfd have been cleared, nothing to do */
+	if (!entries)
+		goto unlock;
+
+	/* Set thresholds array to NULL if we don't have thresholds */
+	if (!size) {
+		kfree(new);
+		new = NULL;
+		goto swap_buffers;
+	}
+
+	new->size = size;
+
+	/* Copy thresholds and find current threshold */
+	new->current_threshold = -1;
+	for (i = 0, j = 0; i < thresholds->primary->size; i++) {
+		if (thresholds->primary->entries[i].eventfd == eventfd)
+			continue;
+
+		new->entries[j] = thresholds->primary->entries[i];
+		if (new->entries[j].threshold <= usage) {
+			/*
+			 * new->current_threshold will not be used
+			 * until rcu_assign_pointer(), so it's safe to increment
+			 * it here.
+			 */
+			++new->current_threshold;
+		}
+		j++;
+	}
+
+swap_buffers:
+	/* Swap primary and spare array */
+	thresholds->spare = thresholds->primary;
+
+	rcu_assign_pointer(thresholds->primary, new);
+
+	/* To be sure that nobody uses thresholds */
+	synchronize_rcu();
+
+	/* If all events are unregistered, free the spare array */
+	if (!new) {
+		kfree(thresholds->spare);
+		thresholds->spare = NULL;
+	}
+unlock:
+	mutex_unlock(&memcg->thresholds_lock);
+}
+
+static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd)
+{
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
+}
+
+static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd)
+{
+	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
+}
+
+static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd, const char *args)
+{
+	struct mem_cgroup_eventfd_list *event;
+
+	event = kmalloc(sizeof(*event),	GFP_KERNEL);
+	if (!event)
+		return -ENOMEM;
+
+	spin_lock(&memcg_oom_lock);
+
+	event->eventfd = eventfd;
+	list_add(&event->list, &memcg->oom_notify);
+
+	/* already in OOM ? */
+	if (memcg->under_oom)
+		eventfd_signal(eventfd, 1);
+	spin_unlock(&memcg_oom_lock);
+
+	return 0;
+}
+
+static void mem_cgroup_oom_unregister_event(struct mem_cgroup *memcg,
+	struct eventfd_ctx *eventfd)
+{
+	struct mem_cgroup_eventfd_list *ev, *tmp;
+
+	spin_lock(&memcg_oom_lock);
+
+	list_for_each_entry_safe(ev, tmp, &memcg->oom_notify, list) {
+		if (ev->eventfd == eventfd) {
+			list_del(&ev->list);
+			kfree(ev);
+		}
+	}
+
+	spin_unlock(&memcg_oom_lock);
+}
+
 /*
  * Unregister event and free resources.
  *
@@ -4928,6 +4911,18 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	return ret;
 }
 
+#else
+
+static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
+{
+	return -EOPNOTSUPP;
+}
+
+static void memcg_check_events(struct mem_cgroup *memcg, int nid) { }
+
+#endif
+
 static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
@@ -5728,14 +5723,12 @@ static int mem_cgroup_move_account(struct page *page,
 	ret = 0;
 	nid = folio_nid(folio);
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_disable();
+	local_irq_disable();
 	mem_cgroup_charge_statistics(to, nr_pages);
 	memcg_check_events(to, nid);
 	mem_cgroup_charge_statistics(from, -nr_pages);
 	memcg_check_events(from, nid);
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_enable();
+	local_irq_enable();
 out_unlock:
 	folio_unlock(folio);
 out:
@@ -6755,12 +6748,10 @@ static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 	css_get(&memcg->css);
 	commit_charge(folio, memcg);
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_disable();
+	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(folio));
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_enable();
+	local_irq_enable();
 out:
 	return ret;
 }
@@ -6872,20 +6863,11 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		memcg_oom_recover(ug->memcg);
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
-		local_irq_save(flags);
-		__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-		__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-		memcg_check_events(ug->memcg, ug->nid);
-		local_irq_restore(flags);
-	} else {
-		preempt_disable();
-		__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-		__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-		preempt_enable();
-
-		memcg_check_events(ug->memcg, ug->nid);
-	}
+	local_irq_save(flags);
+	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
+	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+	memcg_check_events(ug->memcg, ug->nid);
+	local_irq_restore(flags);
 
 	/* drop reference from uncharge_folio */
 	css_put(&ug->memcg->css);
@@ -7026,12 +7008,10 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	css_get(&memcg->css);
 	commit_charge(new, memcg);
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_save(flags);
+	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(new));
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_restore(flags);
+	local_irq_restore(flags);
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7258,8 +7238,15 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * On PREEMPT_RT interrupts are never disabled and the updates to per-CPU
 	 * variables are synchronised by keeping preemption disabled.
 	 */
-	VM_BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT) && !irqs_disabled());
-	mem_cgroup_charge_statistics(memcg, -nr_entries);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		VM_BUG_ON(!irqs_disabled());
+		mem_cgroup_charge_statistics(memcg, -nr_entries);
+	} else {
+		preempt_disable();
+		mem_cgroup_charge_statistics(memcg, -nr_entries);
+		preempt_enable();
+	}
+
 	memcg_check_events(memcg, page_to_nid(page));
 
 	css_put(&memcg->css);
