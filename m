Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D1484945
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiADUYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiADUXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:23:34 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93CCC06179E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:23:32 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id n3-20020a056e021ba300b002b53500c8feso16130441ili.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dWFFgXz+qOEf6PXOf6vOumiLfD+c2Vw9f8EaePONC0w=;
        b=DILMkpio2SH4M1xZ0/uwX0lRdF7EzQ8Vzll5RH62msvMZ6wGZNnPHi/zE2Uj6o0RNg
         Va0mq/7sG+SulUoxkrIurLvAGaS4zqjt75/IKxn0ILP1T5f/hcktOKUZXTaRa6H6FKzi
         OIHT2AB8gJFvo4peU9NpZrUWCmEIeksXgJ1MTJzzcSUMP39jpKAzJo+VZIvOTQrknYtP
         NNubzLA0XOKiwWn2OTn6obqkXlWYbxYLgGzUjjjPaLEuqICc+Q0JNp86itqjWOCDtOGK
         rTKomctX8OAZp4Tr02khcbN99jkKZ/PTpQ9DX4Zkj0frrZ0gUoadh+SIitoRjrMr58DZ
         41NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dWFFgXz+qOEf6PXOf6vOumiLfD+c2Vw9f8EaePONC0w=;
        b=1FF0IB8WFgbPp0mX1XNa9O8YHqy8LSoBD62FKfgcBM9DRaqMEKh2/hCeWAB5OTJety
         xk+0Bej+d6C6kwgg4Xz+GmruNrTAZW/6Hl6Fhw87W6wlkNUpgMLp+RvHJW8AtmGkvzZ3
         jreSlO0VTqYxpGJs6FbsDG8M5XawrjQice79zSmmSOhz7VYSGjx/LN7F+U5n/8IT2E2I
         7DBufukiwLM1ehER9PlV0iMJd4pg6W6HgYkT+tHgd0U66WDXAfH84mnVGIC3Ljyphi5l
         dElwPVrfXVfY3Kd/6fDkxBII+X5nZxQKuHVbG0Mxcx1W21B/C1oCyxiS2CnSjSgd6Ahq
         yXYA==
X-Gm-Message-State: AOAM532aLn4L/f8itBlurA21jYXv1bqpQ949SNb9s/NhcWHYXqh1aQtK
        3kI+5lNrFbx8GZB//5nZ/uP5qqd3n/E=
X-Google-Smtp-Source: ABdhPJyHE+0lezUEqRXsGYhmWRkS0e3oEuhRn93n3+XqvHzynB0YZtp76y4Ut2gIRmaLe9regDNx2epK3Ws=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:6c8c:5506:7ca2:9dfd])
 (user=yuzhao job=sendgmr) by 2002:a05:6602:1604:: with SMTP id
 x4mr24112789iow.84.1641327812245; Tue, 04 Jan 2022 12:23:32 -0800 (PST)
Date:   Tue,  4 Jan 2022 13:22:27 -0700
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
Message-Id: <20220104202227.2903605-9-yuzhao@google.com>
Mime-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v6 8/9] mm: multigenerational lru: user interface
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /sys/kernel/mm/lru_gen/enabled as a runtime kill switch.

Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention.
Compared with the size-based approach, e.g., [1], this time-based
approach has the following advantages:
1) It's easier to configure because it's agnostic to applications and
   memory sizes.
2) It's more reliable because it's directly wired to the OOM killer.

Add /sys/kernel/debug/lru_gen for working set estimation and proactive
reclaim. Compared with the page table-based approach and the PFN-based
approach, e.g., mm/damon/[vp]addr.c, this lruvec-based approach has
the following advantages:
1) It offers better choices because it's aware of memcgs, NUMA nodes,
   shared mappings and unmapped page cache.
2) It's more scalable because it's O(nr_hot_evictable_pages), whereas
   the PFN-based approach is O(nr_total_pages).

Add /sys/kernel/debug/lru_gen_full for debugging.

[1] https://lore.kernel.org/lkml/20211130201652.2218636d@mail.inbox.lv/

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 Documentation/vm/index.rst        |   1 +
 Documentation/vm/multigen_lru.rst |  62 +++++
 include/linux/nodemask.h          |   1 +
 mm/vmscan.c                       | 415 ++++++++++++++++++++++++++++++
 4 files changed, 479 insertions(+)
 create mode 100644 Documentation/vm/multigen_lru.rst

diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index 6f5ffef4b716..f25e755b4ff4 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -38,3 +38,4 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
    unevictable-lru
    z3fold
    zsmalloc
+   multigen_lru
diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_lru.rst
new file mode 100644
index 000000000000..6f9e0181348b
--- /dev/null
+++ b/Documentation/vm/multigen_lru.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Multigenerational LRU
+=====================
+
+Quick start
+===========
+Runtime configurations
+----------------------
+:Required: Write ``1`` to ``/sys/kernel/mm/lru_gen/enable`` if the
+ feature wasn't enabled by default.
+
+Recipes
+=======
+Personal computers
+------------------
+:Thrashing prevention: Write ``N`` to
+ ``/sys/kernel/mm/lru_gen/min_ttl_ms`` to prevent the working set of
+ ``N`` milliseconds from getting evicted. The OOM killer is invoked if
+ this working set can't be kept in memory. Based on the average human
+ detectable lag (~100ms), ``N=1000`` usually eliminates intolerable
+ lags due to thrashing. Larger values like ``N=3000`` make lags less
+ noticeable at the cost of more OOM kills.
+
+Data centers
+------------
+:Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
+ format:
+ ::
+
+   memcg  memcg_id  memcg_path
+     node  node_id
+       min_gen  birth_time  anon_size  file_size
+       ...
+       max_gen  birth_time  anon_size  file_size
+
+ ``min_gen`` is the oldest generation number and ``max_gen`` is the
+ youngest generation number. ``birth_time`` is in milliseconds.
+ ``anon_size`` and ``file_size`` are in pages.
+
+ This file also accepts commands in the following subsections.
+ Multiple command lines are supported, so does concatenation with
+ delimiters ``,`` and ``;``.
+
+ ``/sys/kernel/debug/lru_gen_full`` contains additional stats for
+ debugging.
+
+:Working set estimation: Write ``+ memcg_id node_id max_gen
+ [can_swap [full_scan]]`` to ``/sys/kernel/debug/lru_gen`` to trigger
+ the aging. It scans PTEs for accessed pages and promotes them to the
+ youngest generation ``max_gen``. Then it creates a new generation
+ ``max_gen+1``. Set ``can_swap`` to 1 to scan for accessed anon pages
+ when swap is off. Set ``full_scan`` to 0 to reduce the overhead as
+ well as the coverage when scanning PTEs.
+
+:Proactive reclaim: Write ``- memcg_id node_id min_gen [swappiness
+ [nr_to_reclaim]]`` to ``/sys/kernel/debug/lru_gen`` to trigger the
+ eviction. It evicts generations less than or equal to ``min_gen``.
+ ``min_gen`` should be less than ``max_gen-1`` as ``max_gen`` and
+ ``max_gen-1`` aren't fully aged and therefore can't be evicted. Use
+ ``nr_to_reclaim`` to limit the number of pages to evict.
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 567c3ddba2c4..90840c459abc 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -486,6 +486,7 @@ static inline int num_node_state(enum node_states state)
 #define first_online_node	0
 #define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
+#define next_memory_node(nid)	(MAX_NUMNODES)
 #define nr_node_ids		1U
 #define nr_online_nodes		1U
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b232f711dbdb..20f45ff849fc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -53,6 +53,8 @@
 #include <linux/memory.h>
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -5021,6 +5023,413 @@ static void lru_gen_change_state(bool enable)
 	mem_hotplug_done();
 }
 
+/******************************************************************************
+ *                          sysfs interface
+ ******************************************************************************/
+
+static ssize_t show_min_ttl(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", jiffies_to_msecs(READ_ONCE(lru_gen_min_ttl)));
+}
+
+static ssize_t store_min_ttl(struct kobject *kobj, struct kobj_attribute *attr,
+			     const char *buf, size_t len)
+{
+	unsigned int msecs;
+
+	if (kstrtouint(buf, 10, &msecs))
+		return -EINVAL;
+
+	WRITE_ONCE(lru_gen_min_ttl, msecs_to_jiffies(msecs));
+
+	return len;
+}
+
+static struct kobj_attribute lru_gen_min_ttl_attr = __ATTR(
+	min_ttl_ms, 0644, show_min_ttl, store_min_ttl
+);
+
+static ssize_t show_enable(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", lru_gen_enabled());
+}
+
+static ssize_t store_enable(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t len)
+{
+	bool enable;
+
+	if (kstrtobool(buf, &enable))
+		return -EINVAL;
+
+	lru_gen_change_state(enable);
+
+	return len;
+}
+
+static struct kobj_attribute lru_gen_enabled_attr = __ATTR(
+	enabled, 0644, show_enable, store_enable
+);
+
+static struct attribute *lru_gen_attrs[] = {
+	&lru_gen_min_ttl_attr.attr,
+	&lru_gen_enabled_attr.attr,
+	NULL
+};
+
+static struct attribute_group lru_gen_attr_group = {
+	.name = "lru_gen",
+	.attrs = lru_gen_attrs,
+};
+
+/******************************************************************************
+ *                          debugfs interface
+ ******************************************************************************/
+
+static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct mem_cgroup *memcg;
+	loff_t nr_to_skip = *pos;
+
+	m->private = kvmalloc(PATH_MAX, GFP_KERNEL);
+	if (!m->private)
+		return ERR_PTR(-ENOMEM);
+
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		int nid;
+
+		for_each_node_state(nid, N_MEMORY) {
+			if (!nr_to_skip--)
+				return get_lruvec(memcg, nid);
+		}
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+
+	return NULL;
+}
+
+static void lru_gen_seq_stop(struct seq_file *m, void *v)
+{
+	if (!IS_ERR_OR_NULL(v))
+		mem_cgroup_iter_break(NULL, lruvec_memcg(v));
+
+	kvfree(m->private);
+	m->private = NULL;
+}
+
+static void *lru_gen_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	int nid = lruvec_pgdat(v)->node_id;
+	struct mem_cgroup *memcg = lruvec_memcg(v);
+
+	++*pos;
+
+	nid = next_memory_node(nid);
+	if (nid == MAX_NUMNODES) {
+		memcg = mem_cgroup_iter(NULL, memcg, NULL);
+		if (!memcg)
+			return NULL;
+
+		nid = first_memory_node;
+	}
+
+	return get_lruvec(memcg, nid);
+}
+
+static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
+				  unsigned long max_seq, unsigned long *min_seq,
+				  unsigned long seq)
+{
+	int i;
+	int type, tier;
+	int hist = lru_hist_from_seq(seq);
+	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+
+	for (tier = 0; tier < MAX_NR_TIERS; tier++) {
+		seq_printf(m, "            %10d", tier);
+		for (type = 0; type < ANON_AND_FILE; type++) {
+			unsigned long n[3] = {};
+
+			if (seq == max_seq) {
+				n[0] = READ_ONCE(lrugen->avg_refaulted[type][tier]);
+				n[1] = READ_ONCE(lrugen->avg_total[type][tier]);
+
+				seq_printf(m, " %10luR %10luT %10lu ", n[0], n[1], n[2]);
+			} else if (seq == min_seq[type] || NR_HIST_GENS > 1) {
+				n[0] = atomic_long_read(&lrugen->refaulted[hist][type][tier]);
+				n[1] = atomic_long_read(&lrugen->evicted[hist][type][tier]);
+				if (tier)
+					n[2] = READ_ONCE(lrugen->promoted[hist][type][tier - 1]);
+
+				seq_printf(m, " %10lur %10lue %10lup", n[0], n[1], n[2]);
+			} else
+				seq_puts(m, "          0           0           0 ");
+		}
+		seq_putc(m, '\n');
+	}
+
+	seq_puts(m, "                      ");
+	for (i = 0; i < NR_MM_STATS; i++) {
+		if (seq == max_seq && NR_HIST_GENS == 1)
+			seq_printf(m, " %10lu%c", READ_ONCE(lruvec->mm_state.stats[hist][i]),
+				   toupper(MM_STAT_CODES[i]));
+		else if (seq != max_seq && NR_HIST_GENS > 1)
+			seq_printf(m, " %10lu%c", READ_ONCE(lruvec->mm_state.stats[hist][i]),
+				   MM_STAT_CODES[i]);
+		else
+			seq_puts(m, "          0 ");
+	}
+	seq_putc(m, '\n');
+}
+
+static int lru_gen_seq_show(struct seq_file *m, void *v)
+{
+	unsigned long seq;
+	bool full = !debugfs_real_fops(m->file)->write;
+	struct lruvec *lruvec = v;
+	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	int nid = lruvec_pgdat(lruvec)->node_id;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	DEFINE_MAX_SEQ(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
+	if (nid == first_memory_node) {
+		const char *path = memcg ? m->private : "";
+
+#ifdef CONFIG_MEMCG
+		if (memcg)
+			cgroup_path(memcg->css.cgroup, m->private, PATH_MAX);
+#endif
+		seq_printf(m, "memcg %5hu %s\n", mem_cgroup_id(memcg), path);
+	}
+
+	seq_printf(m, " node %5d\n", nid);
+
+	if (!full)
+		seq = min_seq[0];
+	else if (max_seq >= MAX_NR_GENS)
+		seq = max_seq - MAX_NR_GENS + 1;
+	else
+		seq = 0;
+
+	for (; seq <= max_seq; seq++) {
+		int gen, type, zone;
+		unsigned int msecs;
+
+		gen = lru_gen_from_seq(seq);
+		msecs = jiffies_to_msecs(jiffies - READ_ONCE(lrugen->timestamps[gen]));
+
+		seq_printf(m, " %10lu %10u", seq, msecs);
+
+		for (type = 0; type < ANON_AND_FILE; type++) {
+			long size = 0;
+
+			if (seq < min_seq[type]) {
+				seq_puts(m, "         -0 ");
+				continue;
+			}
+
+			for (zone = 0; zone < MAX_NR_ZONES; zone++)
+				size += READ_ONCE(lrugen->nr_pages[gen][type][zone]);
+
+			seq_printf(m, " %10lu ", max(size, 0L));
+		}
+
+		seq_putc(m, '\n');
+
+		if (full)
+			lru_gen_seq_show_full(m, lruvec, max_seq, min_seq, seq);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations lru_gen_seq_ops = {
+	.start = lru_gen_seq_start,
+	.stop = lru_gen_seq_stop,
+	.next = lru_gen_seq_next,
+	.show = lru_gen_seq_show,
+};
+
+static int run_aging(struct lruvec *lruvec, unsigned long seq, struct scan_control *sc,
+		     bool can_swap, bool full_scan)
+{
+	DEFINE_MAX_SEQ(lruvec);
+
+	if (seq == max_seq)
+		try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, full_scan);
+
+	return seq > max_seq ? -EINVAL : 0;
+}
+
+static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_control *sc,
+			int swappiness, unsigned long nr_to_reclaim)
+{
+	struct blk_plug plug;
+	int err = -EINTR;
+	DEFINE_MAX_SEQ(lruvec);
+
+	if (max_seq < seq + MIN_NR_GENS)
+		return -EINVAL;
+
+	sc->nr_reclaimed = 0;
+
+	blk_start_plug(&plug);
+
+	while (!signal_pending(current)) {
+		DEFINE_MIN_SEQ(lruvec);
+
+		if (seq < min_seq[!swappiness] || sc->nr_reclaimed >= nr_to_reclaim ||
+		    !evict_folios(lruvec, sc, swappiness, NULL)) {
+			err = 0;
+			break;
+		}
+
+		cond_resched();
+	}
+
+	blk_finish_plug(&plug);
+
+	return err;
+}
+
+static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
+		   struct scan_control *sc, int swappiness, unsigned long opt)
+{
+	struct lruvec *lruvec;
+	int err = -EINVAL;
+	struct mem_cgroup *memcg = NULL;
+
+	if (!mem_cgroup_disabled()) {
+		rcu_read_lock();
+		memcg = mem_cgroup_from_id(memcg_id);
+#ifdef CONFIG_MEMCG
+		if (memcg && !css_tryget(&memcg->css))
+			memcg = NULL;
+#endif
+		rcu_read_unlock();
+
+		if (!memcg)
+			goto done;
+	}
+	if (memcg_id != mem_cgroup_id(memcg))
+		goto done;
+
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
+		goto done;
+
+	lruvec = get_lruvec(memcg, nid);
+
+	if (swappiness < 0)
+		swappiness = get_swappiness(memcg);
+	else if (swappiness > 200)
+		goto done;
+
+	switch (cmd) {
+	case '+':
+		err = run_aging(lruvec, seq, sc, swappiness, opt);
+		break;
+	case '-':
+		err = run_eviction(lruvec, seq, sc, swappiness, opt);
+		break;
+	}
+done:
+	mem_cgroup_put(memcg);
+
+	return err;
+}
+
+static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
+				 size_t len, loff_t *pos)
+{
+	void *buf;
+	char *cur, *next;
+	unsigned int flags;
+	int err = 0;
+	struct scan_control sc = {
+		.may_writepage = 1,
+		.may_unmap = 1,
+		.may_swap = 1,
+		.reclaim_idx = MAX_NR_ZONES - 1,
+		.gfp_mask = GFP_KERNEL,
+	};
+
+	buf = kvmalloc(len + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, src, len)) {
+		kvfree(buf);
+		return -EFAULT;
+	}
+
+	next = buf;
+	next[len] = '\0';
+
+	sc.reclaim_state.mm_walk = alloc_mm_walk();
+	if (!sc.reclaim_state.mm_walk) {
+		kvfree(buf);
+		return -ENOMEM;
+	}
+
+	flags = memalloc_noreclaim_save();
+	set_task_reclaim_state(current, &sc.reclaim_state);
+
+	while ((cur = strsep(&next, ",;\n"))) {
+		int n;
+		int end;
+		char cmd;
+		unsigned int memcg_id;
+		unsigned int nid;
+		unsigned long seq;
+		unsigned int swappiness = -1;
+		unsigned long opt = -1;
+
+		cur = skip_spaces(cur);
+		if (!*cur)
+			continue;
+
+		n = sscanf(cur, "%c %u %u %lu %n %u %n %lu %n", &cmd, &memcg_id, &nid,
+			   &seq, &end, &swappiness, &end, &opt, &end);
+		if (n < 4 || cur[end]) {
+			err = -EINVAL;
+			break;
+		}
+
+		err = run_cmd(cmd, memcg_id, nid, seq, &sc, swappiness, opt);
+		if (err)
+			break;
+	}
+
+	set_task_reclaim_state(current, NULL);
+	memalloc_noreclaim_restore(flags);
+
+	free_mm_walk(sc.reclaim_state.mm_walk);
+	kvfree(buf);
+
+	return err ? : len;
+}
+
+static int lru_gen_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &lru_gen_seq_ops);
+}
+
+static const struct file_operations lru_gen_rw_fops = {
+	.open = lru_gen_seq_open,
+	.read = seq_read,
+	.write = lru_gen_seq_write,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct file_operations lru_gen_ro_fops = {
+	.open = lru_gen_seq_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
 /******************************************************************************
  *                          initialization
  ******************************************************************************/
@@ -5087,6 +5496,12 @@ static int __init init_lru_gen(void)
 	BUILD_BUG_ON(BIT(LRU_GEN_WIDTH) <= MAX_NR_GENS);
 	BUILD_BUG_ON(sizeof(MM_STAT_CODES) != NR_MM_STATS + 1);
 
+	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
+		pr_err("lru_gen: failed to create sysfs group\n");
+
+	debugfs_create_file("lru_gen", 0644, NULL, NULL, &lru_gen_rw_fops);
+	debugfs_create_file("lru_gen_full", 0444, NULL, NULL, &lru_gen_ro_fops);
+
 	return 0;
 };
 late_initcall(init_lru_gen);
-- 
2.34.1.448.ga2b2bfdf31-goog

