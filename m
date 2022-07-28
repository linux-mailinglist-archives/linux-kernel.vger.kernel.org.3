Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730B8584731
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiG1Upn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiG1Upc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C1655A5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c3so2881204pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=SGkgqy0QLVnzdid2tkzB0s+fC8K9ka6NmIFVVWD2xYk=;
        b=D9EKylMTSsghnjGXBfCgCbvVNT/Rb65B+zsOKJ1byGzpWm2z65aE1EXzzx/Scfhj1j
         y2tQeGMLlyvbAhkbfJKOXECF9lyzXm3NXCnFUVCnh3x/7JHguG9iSpiwcz3RI/SShalX
         lyU1nhy4uxZWrFwXZsD9kwF3TJ53txtAi8BkMTqVc9ZDh5/ahzqsPBKF6eywhir6Gn8J
         Z9z/xMTXBCiJscT764TuHzpDskjTwlhGIQqaP+/hDN6SLFhnLb7tvulx1GNuJbjfn8Ow
         tjZmi2oPiHV7UnpjBSfZB9reP9y//41DnRFPCWIG2YA466fl411OrgzxKV+/SCNaHwHn
         55dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=SGkgqy0QLVnzdid2tkzB0s+fC8K9ka6NmIFVVWD2xYk=;
        b=jsd+JBOVXmlwf0z6ROgMZXNATsTGKbMcDnvB3HhfPm5i8TVZ06+6JCOqJvVv7hTJA7
         zYAyZncMAAWk4IgHIBrDsCw5pwK04QRb4mTbT3zV2hE8CaLmsCzPh23/TvqeouDmZ75V
         z7pkleYfv3KYwL2d2XitKuWU5ISdk5jfHSa0d7ocrIxI4O1lpWc8MzLhfNo1BlCNBbfp
         7QoCP4C/0W278SjZIdX3+KlsNgBnt93vjtyvDSDoD76f3cAtB3lYFqli+eH82U9lb2+1
         jZlJrc4xDuUkCzbQjFd0JJeEpHZ3H7tW3d13Yj84CV+KMc8aBmBjnJAEOiNgesQAnYe7
         J+bw==
X-Gm-Message-State: AJIora8i1e8ITt+HvlJx7yTOK8l4C5gC6YkT+tH32/2JksbPAnuQ58+A
        rtFGJ3RMkjtWKd61QR1prHmlUU5EKga/XG9oxrg=
X-Google-Smtp-Source: AGRyM1skRuRihGKUIV+KmimC7TjXwxVcHbd9Pp0zhfBbeZxDqTaXXoGkFBmLZFsjmEUj/eJ601FKUg==
X-Received: by 2002:a63:5f56:0:b0:412:9907:ec0d with SMTP id t83-20020a635f56000000b004129907ec0dmr443467pgb.18.1659041127458;
        Thu, 28 Jul 2022 13:45:27 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([114.254.3.190])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c40f8cb58sm1787304pli.81.2022.07.28.13.45.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 13:45:26 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 4/7] mm: introduce a generic per-CPU RSS cache
Date:   Fri, 29 Jul 2022 04:45:08 +0800
Message-Id: <20220728204511.56348-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220728204511.56348-1-ryncsn@gmail.com>
References: <20220728204511.56348-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

The RSS cache used to be a per-task cache, and it's batched into 64
events for each atomic sync. The problems is 64 events is too small for
contention reducing, and too large for an accurate RSS accounting.

This per-cpu RSS cache assumes one mm_struct tends to stay on the same CPU,
so if the mm_struct be accounted matches current active_mm, keep the RSS
accounting CPU local until the mm_struct is switched out, and do an atomic
update only upon switch out.

The fast path of CPU local RSS accounting is extremely lightweight, only
set preemption off and then do a CPU local counter increase.

One major effect is that now RSS reading is much more accurate than before,
but also slower. It needs to iterate all possible CPUs that have cached
the RSS and collect the un-committed caches. With a lockless reader design,
this never blocks the RSS accounting fast path, which ensures a good updater
performance. And considering RSS updating is much more common than reading,
this should improve the performance overall.

This CPU iteration can be avoided by using CPU mask to mark the CPUs
that cached the mm_struct and only read from these CPUs.
It can leverage the existing mm_cpumask used for TLB shootdown, this
has to be done arch by arch in later commits.

This commit provides a baseline version that works on all arch, but with
a performance drop for RSS syncing upon read/invalidation.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/mm.h            |  15 +--
 include/linux/mm_types_task.h |  38 +++++++
 kernel/fork.c                 |   2 +-
 kernel/sched/core.c           |   3 +
 mm/memory.c                   | 201 ++++++++++++++++++++++++++++++++--
 5 files changed, 236 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 81ad91621078..47b8552b1b04 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1994,15 +1994,13 @@ static inline bool get_user_page_fast_only(unsigned long addr,
 	return get_user_pages_fast_only(addr, 1, gup_flags, pagep) == 1;
 }
 
-void check_mm(struct mm_struct *mm);
+void check_discard_mm(struct mm_struct *mm);
 
 /*
  * per-process(per-mm_struct) statistics.
  */
-static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
-{
-	return atomic_long_read(&mm->rss_stat.count[member]);
-}
+unsigned long get_mm_counter(struct mm_struct *mm, int member);
+unsigned long get_mm_rss(struct mm_struct *mm);
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member, long count);
 
@@ -2042,13 +2040,6 @@ static inline int mm_counter(struct page *page)
 	return mm_counter_file(page);
 }
 
-static inline unsigned long get_mm_rss(struct mm_struct *mm)
-{
-	return get_mm_counter(mm, MM_FILEPAGES) +
-		get_mm_counter(mm, MM_ANONPAGES) +
-		get_mm_counter(mm, MM_SHMEMPAGES);
-}
-
 static inline unsigned long get_mm_hiwater_rss(struct mm_struct *mm)
 {
 	return max(mm->hiwater_rss, get_mm_rss(mm));
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 14182ded3fda..d5d3fbece174 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -12,6 +12,7 @@
 #include <linux/threads.h>
 #include <linux/atomic.h>
 #include <linux/cpumask.h>
+#include <linux/cache.h>
 
 #include <asm/page.h>
 
@@ -52,6 +53,43 @@ struct mm_rss_stat {
 	atomic_long_t count[NR_MM_COUNTERS];
 };
 
+struct mm_rss_cache {
+	/*
+	 * CPU local only variables, hot path for RSS caching. Readonly for other CPUs.
+	 */
+	unsigned long in_use;
+	long count[NR_MM_COUNTERS];
+
+	/* Avoid false sharing when other CPUs collect RSS counter */
+	struct mm_struct *mm ____cacheline_aligned;
+	/* Avoid ABA problem and RSS being accounted for wrong mm */
+	unsigned long sync_count;
+};
+
+/* lowest bit of *mm is never used, so use it as a syncing flag */
+#define RSS_CACHE_MM_SYNCING_MASK 1UL
+
+/* mark the mm as being synced on that cache */
+static __always_inline struct mm_struct *__pcp_rss_mm_mark(struct mm_struct *mm)
+{
+	unsigned long val = (unsigned long)mm;
+
+	val |= RSS_CACHE_MM_SYNCING_MASK;
+
+	return (struct mm_struct *) val;
+}
+
+static __always_inline struct mm_struct *__pcp_rss_mm_unmark(struct mm_struct *mm)
+{
+	unsigned long val = (unsigned long)mm;
+
+	val &= ~RSS_CACHE_MM_SYNCING_MASK;
+
+	return (struct mm_struct *) val;
+}
+
+void switch_pcp_rss_cache_no_irq(struct mm_struct *next_mm);
+
 struct page_frag {
 	struct page *page;
 #if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
diff --git a/kernel/fork.c b/kernel/fork.c
index 86a239772208..c2f5f6eef6a6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -755,9 +755,9 @@ void __mmdrop(struct mm_struct *mm)
 	mm_free_pgd(mm);
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
-	check_mm(mm);
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
+	check_discard_mm(mm);
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecd..11df67bb52ee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5142,6 +5142,9 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 	prepare_lock_switch(rq, next, rf);
 
+	/* Cache new active_mm */
+	switch_pcp_rss_cache_no_irq(next->active_mm);
+
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
 	barrier();
diff --git a/mm/memory.c b/mm/memory.c
index c0597214f9b3..f00f302143b6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -176,8 +176,143 @@ void mm_trace_rss_stat(struct mm_struct *mm, int member, long count)
 	trace_rss_stat(mm, member, count);
 }
 
-#define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
-#define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct mm_rss_cache, cpu_rss_cache);
+
+/*
+ * get_mm_counter and get_mm_rss try to read the RSS cache of each
+ * CPU that cached target mm. If the cache is flushed while being read,
+ * skip it. May lead to rare and little bit of accuracy loss, but flushed
+ * cache will surely be accounted in the next read.
+ */
+unsigned long get_mm_counter(struct mm_struct *mm, int member)
+{
+	int cpu;
+	long ret, update, sync_count;
+
+	ret = atomic_long_read(&mm->rss_stat.count[member]);
+	for_each_possible_cpu(cpu) {
+		if (READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu)) != mm)
+			continue;
+		sync_count = READ_ONCE(per_cpu(cpu_rss_cache.sync_count, cpu));
+		/* see smp_mb in switch_pcp_rss_cache_no_irq */
+		smp_rmb();
+
+		update = READ_ONCE(per_cpu(cpu_rss_cache.count[member], cpu));
+
+		/* same as above */
+		smp_rmb();
+		if (READ_ONCE(per_cpu(cpu_rss_cache.sync_count, cpu)) == sync_count &&
+		    READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu)) == mm)
+			ret += update;
+	}
+
+	if (ret < 0)
+		ret = 0;
+
+	return ret;
+}
+
+/* see comment for get_mm_counter */
+unsigned long get_mm_rss(struct mm_struct *mm)
+{
+	int cpu;
+	long ret, update, sync_count;
+
+	ret = atomic_long_read(&mm->rss_stat.count[MM_FILEPAGES]),
+	    + atomic_long_read(&mm->rss_stat.count[MM_ANONPAGES]),
+	    + atomic_long_read(&mm->rss_stat.count[MM_SHMEMPAGES]);
+
+	for_each_possible_cpu(cpu) {
+		if (READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu)) != mm)
+			continue;
+		sync_count = READ_ONCE(per_cpu(cpu_rss_cache.sync_count, cpu));
+		/* see smp_mb in switch_pcp_rss_cache_no_irq */
+		smp_rmb();
+
+		/* Reads MM_FILEPAGES, MM_ANONPAGES, MM_SHMEMPAGES */
+		for (int i = MM_FILEPAGES; i < MM_SWAPENTS; i++)
+			update += READ_ONCE(per_cpu(cpu_rss_cache.count[i], cpu));
+
+		/* same as above */
+		smp_rmb();
+		if (READ_ONCE(per_cpu(cpu_rss_cache.sync_count, cpu)) == sync_count &&
+		    READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu)) == mm)
+			ret += update;
+	}
+
+	if (ret < 0)
+		ret = 0;
+
+	return ret;
+}
+
+/* flush the rss cache of current CPU with IRQ disabled, and switch to new mm */
+void switch_pcp_rss_cache_no_irq(struct mm_struct *next_mm)
+{
+	long count;
+	struct mm_struct *cpu_mm;
+
+	cpu_mm = this_cpu_read(cpu_rss_cache.mm);
+	if (cpu_mm == next_mm)
+		return;
+
+	/*
+	 * `in_use` counter is hold with preempt disabled, if non-zero, this would be a
+	 * interrupt switching the mm, just ignore it.
+	 */
+	if (this_cpu_read(cpu_rss_cache.in_use))
+		return;
+
+	if (cpu_mm == NULL)
+		goto commit_done;
+
+	/* Race with check_discard_rss_cache */
+	if (cpu_mm != cmpxchg(this_cpu_ptr(&cpu_rss_cache.mm), cpu_mm,
+			      __pcp_rss_mm_mark(cpu_mm)))
+		goto commit_done;
+
+	for (int i = 0; i < NR_MM_COUNTERS; i++) {
+		count = this_cpu_read(cpu_rss_cache.count[i]);
+		if (count)
+			add_mm_counter(cpu_mm, i, count);
+	}
+
+commit_done:
+	for (int i = 0; i < NR_MM_COUNTERS; i++)
+		this_cpu_write(cpu_rss_cache.count[i], 0);
+
+	/*
+	 * For remote reading in get_mm_{rss,counter},
+	 * ensure new mm and sync counter have zero'ed counters
+	 */
+	smp_wmb();
+	this_cpu_write(cpu_rss_cache.mm, next_mm);
+	this_cpu_inc(cpu_rss_cache.sync_count);
+}
+
+static void add_mm_counter_fast(struct mm_struct *mm, int member, int val)
+{
+	/*
+	 * Disable preempt so task is pinned, and the mm is pinned on this CPU
+	 * since caller must be holding a reference.
+	 */
+	preempt_disable();
+	this_cpu_inc(cpu_rss_cache.in_use);
+
+	if (likely(mm == this_cpu_read(cpu_rss_cache.mm))) {
+		this_cpu_add(cpu_rss_cache.count[member], val);
+		this_cpu_dec(cpu_rss_cache.in_use);
+		/* Avoid the resched checking oveahead for fast path */
+		preempt_enable_no_resched();
+	} else {
+		this_cpu_dec(cpu_rss_cache.in_use);
+		preempt_enable_no_resched();
+		add_mm_counter(mm, member, val);
+	}
+}
+
+#define inc_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, 1)
+#define dec_mm_counter_fast(mm, member) add_mm_counter_fast(mm, member, -1)
 
 #define NAMED_ARRAY_INDEX(x)	[x] = __stringify(x)
 static const char * const resident_page_types[] = {
@@ -187,20 +322,64 @@ static const char * const resident_page_types[] = {
 	NAMED_ARRAY_INDEX(MM_SHMEMPAGES),
 };
 
-void check_mm(struct mm_struct *mm)
+static void check_discard_rss_cache(struct mm_struct *mm)
 {
-	int i;
+	int cpu;
+	long cached_count[NR_MM_COUNTERS] = { 0 };
+	struct mm_struct *cpu_mm;
 
-	BUILD_BUG_ON_MSG(ARRAY_SIZE(resident_page_types) != NR_MM_COUNTERS,
-			 "Please make sure 'struct resident_page_types[]' is updated as well");
+	/* Invalidate the RSS cache on every CPU */
+	for_each_possible_cpu(cpu) {
+		cpu_mm = READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu));
+		if (__pcp_rss_mm_unmark(cpu_mm) != mm)
+			continue;
+
+		/*
+		 * If not being flusehd, try read-in the counter and mark it NULL,
+		 * once cache's mm is set NULL, counter are considered invalided
+		 */
+		if (cpu_mm != __pcp_rss_mm_mark(cpu_mm)) {
+			long count[NR_MM_COUNTERS];
 
-	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		long x = atomic_long_read(&mm->rss_stat.count[i]);
+			for (int i = 0; i < NR_MM_COUNTERS; i++)
+				count[i] = READ_ONCE(per_cpu(cpu_rss_cache.count[i], cpu));
 
-		if (unlikely(x))
+			/*
+			 * If successfully set to NULL, the owner CPU is not flushing it, counters
+			 * are uncommiteed and untouched during this period, since a dying mm won't
+			 * be accouted anymore
+			 */
+			cpu_mm = cmpxchg(&per_cpu(cpu_rss_cache.mm, cpu), mm, NULL);
+			if (cpu_mm == mm) {
+				for (int i = 0; i < NR_MM_COUNTERS; i++)
+					cached_count[i] += count[i];
+				continue;
+			}
+		}
+
+		/* It's being flushed, just busy wait as the critial section is really short */
+		do {
+			cpu_relax();
+			cpu_mm = READ_ONCE(per_cpu(cpu_rss_cache.mm, cpu));
+		} while (cpu_mm == __pcp_rss_mm_mark(mm));
+	}
+
+	for (int i = 0; i < NR_MM_COUNTERS; i++) {
+		long val = atomic_long_read(&mm->rss_stat.count[i]);
+
+		val += cached_count[i];
+
+		if (unlikely(val)) {
 			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
-				 mm, resident_page_types[i], x);
+				 mm, resident_page_types[i], val);
+		}
 	}
+}
+
+void check_discard_mm(struct mm_struct *mm)
+{
+	BUILD_BUG_ON_MSG(ARRAY_SIZE(resident_page_types) != NR_MM_COUNTERS,
+			 "Please make sure 'struct resident_page_types[]' is updated as well");
 
 	if (mm_pgtables_bytes(mm))
 		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
@@ -209,6 +388,8 @@ void check_mm(struct mm_struct *mm)
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
 #endif
+
+	check_discard_rss_cache(mm);
 }
 
 /*
-- 
2.35.2

