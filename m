Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E6A4B830A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiBPIbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:31:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBPIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:31:03 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC822A4A02
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:30:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4cXjyv_1645000246;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0V4cXjyv_1645000246)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Feb 2022 16:30:47 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sj@kernel.org
Cc:     xhao@linux.alibaba.com, rongwei.wang@linux.alibaba.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1 3/5] mm/damon: Add 'damon_region' NUMA access statistics core implementation
Date:   Wed, 16 Feb 2022 16:30:39 +0800
Message-Id: <de07c5a70a0a2f5aa86fe92581acd0b3ac8a8e18.1645024354.git.xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1645024354.git.xhao@linux.alibaba.com>
References: <cover.1645024354.git.xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After setting PTE none or PMD none in DAMON, NUMA access of "damon_region" will be
counted in page fault if current pid matches the pid that DAMON is monitoring.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 include/linux/damon.h | 18 ++++++++++
 mm/damon/core.c       | 80 +++++++++++++++++++++++++++++++++++++++++--
 mm/damon/dbgfs.c      | 18 +++++++---
 mm/damon/vaddr.c      | 11 ++----
 mm/huge_memory.c      |  5 +++
 mm/memory.c           |  5 +++
 6 files changed, 121 insertions(+), 16 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 77d0937dcab5..5bf1eb92584b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -12,12 +12,16 @@
 #include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/random.h>
+#include <linux/mm.h>
 
 /* Minimal region size.  Every damon_region is aligned by this. */
 #define DAMON_MIN_REGION	PAGE_SIZE
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
+extern struct damon_ctx **dbgfs_ctxs;
+extern int dbgfs_nr_ctxs;
+
 /* Get a random number in [l, r) */
 static inline unsigned long damon_rand(unsigned long l, unsigned long r)
 {
@@ -68,6 +72,7 @@ struct damon_region {
  * @nr_regions:		Number of monitoring target regions of this target.
  * @regions_list:	Head of the monitoring target regions of this target.
  * @list:		List head for siblings.
+ * @target_lock:  Use damon_region lock to avoid race.
  *
  * Each monitoring context could have multiple targets.  For example, a context
  * for virtual memory address spaces could have multiple target processes.  The
@@ -80,6 +85,7 @@ struct damon_target {
 	unsigned int nr_regions;
 	struct list_head regions_list;
 	struct list_head list;
+	spinlock_t target_lock;
 };
 
 /**
@@ -503,8 +509,20 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 #endif	/* CONFIG_DAMON */
 
 #ifdef CONFIG_DAMON_VADDR
+
+/*
+ * 't->id' should be the pointer to the relevant 'struct pid' having reference
+ * count.  Caller must put the returned task, unless it is NULL.
+ */
+static inline struct task_struct *damon_get_task_struct(struct damon_target *t)
+{
+	return get_pid_task((struct pid *)t->id, PIDTYPE_PID);
+}
 bool damon_va_target_valid(void *t);
 void damon_va_set_primitives(struct damon_ctx *ctx);
+void damon_numa_fault(int page_nid, int node_id, struct vm_fault *vmf);
+#else
+static inline void damon_numa_fault(int page_nid, int node_id, struct vm_fault *vmf) { }
 #endif	/* CONFIG_DAMON_VADDR */
 
 #ifdef CONFIG_DAMON_PADDR
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 933ef51afa71..970fc02abeba 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -157,6 +157,7 @@ struct damon_target *damon_new_target(unsigned long id)
 	t->id = id;
 	t->nr_regions = 0;
 	INIT_LIST_HEAD(&t->regions_list);
+	spin_lock_init(&t->target_lock);
 
 	return t;
 }
@@ -792,8 +793,11 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 {
 	struct damon_target *t;
 
-	damon_for_each_target(t, c)
+	damon_for_each_target(t, c) {
+		spin_lock(&t->target_lock);
 		damon_merge_regions_of(t, threshold, sz_limit);
+		spin_unlock(&t->target_lock);
+	}
 }
 
 /*
@@ -879,8 +883,11 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 			nr_regions < ctx->max_nr_regions / 3)
 		nr_subregions = 3;
 
-	damon_for_each_target(t, ctx)
+	damon_for_each_target(t, ctx) {
+		spin_lock(&t->target_lock);
 		damon_split_regions_of(ctx, t, nr_subregions);
+		spin_unlock(&t->target_lock);
+	}
 
 	last_nr_regions = nr_regions;
 }
@@ -1000,6 +1007,73 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 	return -EBUSY;
 }
 
+static struct damon_target *get_damon_target(struct task_struct *task)
+{
+	int i;
+	unsigned long id1, id2;
+	struct damon_target *t;
+
+	rcu_read_lock();
+	for (i = 0; i < READ_ONCE(dbgfs_nr_ctxs); i++) {
+		struct damon_ctx *ctx = rcu_dereference(dbgfs_ctxs[i]);
+
+		if (!ctx || !ctx->kdamond)
+			continue;
+		damon_for_each_target(t, dbgfs_ctxs[i]) {
+			struct task_struct *ts = damon_get_task_struct(t);
+
+			if (ts) {
+				id1 = (unsigned long)pid_vnr((struct pid *)t->id);
+				id2 = (unsigned long)pid_vnr(get_task_pid(task, PIDTYPE_PID));
+				put_task_struct(ts);
+				if (id1 == id2)
+					return t;
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	return NULL;
+}
+
+static struct damon_region *get_damon_region(struct damon_target *t, unsigned long addr)
+{
+	struct damon_region *r, *next;
+
+	if (!t || !addr)
+		return NULL;
+
+	spin_lock(&t->target_lock);
+	damon_for_each_region_safe(r, next, t) {
+		if (r->ar.start <= addr && r->ar.end >= addr) {
+			spin_unlock(&t->target_lock);
+			return r;
+		}
+	}
+	spin_unlock(&t->target_lock);
+
+	return NULL;
+}
+
+void damon_numa_fault(int page_nid, int node_id, struct vm_fault *vmf)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	if (nr_online_nodes > 1) {
+		t = get_damon_target(current);
+		if (!t)
+			return;
+		r = get_damon_region(t, vmf->address);
+		if (r) {
+			if (page_nid == node_id)
+				r->local++;
+			else
+				r->remote++;
+		}
+	}
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
@@ -1057,8 +1131,10 @@ static int kdamond_fn(void *data)
 		}
 	}
 	damon_for_each_target(t, ctx) {
+		spin_lock(&t->target_lock);
 		damon_for_each_region_safe(r, next, t)
 			damon_destroy_region(r, t);
+		spin_unlock(&t->target_lock);
 	}
 
 	if (ctx->callback.before_terminate)
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 5b899601e56c..c7f4e95abc14 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -15,11 +15,12 @@
 #include <linux/page_idle.h>
 #include <linux/slab.h>
 
-static struct damon_ctx **dbgfs_ctxs;
-static int dbgfs_nr_ctxs;
+struct damon_ctx **dbgfs_ctxs;
+int dbgfs_nr_ctxs;
 static struct dentry **dbgfs_dirs;
 static DEFINE_MUTEX(damon_dbgfs_lock);
 
+
 /*
  * Returns non-empty string on success, negative error code otherwise.
  */
@@ -808,10 +809,18 @@ static int dbgfs_rm_context(char *name)
 		return -ENOMEM;
 	}
 
-	for (i = 0, j = 0; i < dbgfs_nr_ctxs; i++) {
+	dbgfs_nr_ctxs--;
+	/* Prevent NUMA fault get the wrong value */
+	smp_mb();
+
+	for (i = 0, j = 0; i < dbgfs_nr_ctxs + 1; i++) {
 		if (dbgfs_dirs[i] == dir) {
+			struct damon_ctx *tmp_ctx = dbgfs_ctxs[i];
+
+			rcu_assign_pointer(dbgfs_ctxs[i], NULL);
+			synchronize_rcu();
 			debugfs_remove(dbgfs_dirs[i]);
-			dbgfs_destroy_ctx(dbgfs_ctxs[i]);
+			dbgfs_destroy_ctx(tmp_ctx);
 			continue;
 		}
 		new_dirs[j] = dbgfs_dirs[i];
@@ -823,7 +832,6 @@ static int dbgfs_rm_context(char *name)
 
 	dbgfs_dirs = new_dirs;
 	dbgfs_ctxs = new_ctxs;
-	dbgfs_nr_ctxs--;
 
 	return 0;
 }
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 732b41ed134c..78b90972d171 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -22,15 +22,6 @@
 #define DAMON_MIN_REGION 1
 #endif
 
-/*
- * 't->id' should be the pointer to the relevant 'struct pid' having reference
- * count.  Caller must put the returned task, unless it is NULL.
- */
-static inline struct task_struct *damon_get_task_struct(struct damon_target *t)
-{
-	return get_pid_task((struct pid *)t->id, PIDTYPE_PID);
-}
-
 /*
  * Get the mm_struct of the given target
  *
@@ -363,7 +354,9 @@ static void damon_va_update(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		if (damon_va_three_regions(t, three_regions))
 			continue;
+		spin_lock(&t->target_lock);
 		damon_va_apply_three_regions(t, three_regions);
+		spin_unlock(&t->target_lock);
 	}
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..9cb413a8cd4a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -34,6 +34,7 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 #include <linux/page_owner.h>
+#include <linux/damon.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -1450,6 +1451,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 		flags |= TNF_NO_GROUP;
 
 	page_nid = page_to_nid(page);
+
+	/* Get the NUMA accesses of monitored processes by DAMON */
+	damon_numa_fault(page_nid, numa_node_id(), vmf);
+
 	last_cpupid = page_cpupid_last(page);
 	target_nid = numa_migrate_prep(page, vma, haddr, page_nid,
 				       &flags);
diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..fb55264f36af 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -74,6 +74,7 @@
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/vmalloc.h>
+#include <linux/damon.h>
 
 #include <trace/events/kmem.h>
 
@@ -4392,6 +4393,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	last_cpupid = page_cpupid_last(page);
 	page_nid = page_to_nid(page);
+
+	/* Get the NUMA accesses of monitored processes by DAMON */
+	damon_numa_fault(page_nid, numa_node_id(), vmf);
+
 	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
 			&flags);
 	if (target_nid == NUMA_NO_NODE) {
-- 
2.27.0

