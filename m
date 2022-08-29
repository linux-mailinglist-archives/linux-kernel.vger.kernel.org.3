Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A035A4CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiH2M5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiH2M4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:35 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF49DFD5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:32 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id m15-20020a056402430f00b00448af09b674so48584edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=ALPSUyHQQrXCFAhvO3GrH4UhqRd+C7lu7ougUmdRQTc=;
        b=q/g+BEJNCUTLPiz8396cNH9olRGtWS638cpfrFVFSi612qvfENTt46zL1qFRyM+pmh
         77lwXRIbI2SG1T3iQuzznwog069UNsx7j79yKDYPfEIIE8KOoqaph+6cL7X0YRyM3h7s
         6xH/A55Fw48B8qCpLQA64b/9gVxx62EPmCUmMzOvP63xQUx6KJhIaQb9PuP16K5N6KXh
         UylovVVaoQar0XH8pDPKFHzTrwqH2WLw2bH/7oRlSvsY03DaZYAnipwBLKwKFlYBGloT
         ktV9ihc4nRfEdgpS9AyVL6azxWpeM66rwWpDKYB+yd0l6fDSNiVQsh58ByWWoTPdIfq8
         5uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ALPSUyHQQrXCFAhvO3GrH4UhqRd+C7lu7ougUmdRQTc=;
        b=7nzh8vza1UnIqOQ/x854VbpMR5HfLUUg2UU7mzwk260rDP76RO8hv8CZB/OMXzI8Tj
         z3j0ZF2DjMVH6Pc8ZOJuJcjn7nUGsQzvlbBTsXm/f38jaz6ZhgOqUprVv0d0aNR+b7FZ
         WmWAN75PAaiCH4Nic48WXKJzDWOx5rT0PrW6QvLYoy+ee3FZKJpH504v0PixNQZcjp8P
         4oV40bU5tDXsFwTUyXXLOvcsd1xj+EWuGqZM+DqdsOjcbKWkCaGfj1fOAPowut/bLDYb
         6a2DMKlyjiNU6U8WtyYnHXWVo+U3JxJ+X0CvZus8SdM7BV6j976v4pLPnaUjJqOET9jg
         y6OQ==
X-Gm-Message-State: ACgBeo0oc9OIa5v+wdD/I6gHce4uEdoZ2/hILOJnnke0VEne64WmsF2X
        2mVPE+Uc6NGgEXq+0INC3Ckn5fDegw==
X-Google-Smtp-Source: AA6agR50o74ooBgV57arMCJWxWak0fy/La9f8bONjy2t3gGS6dKZKpdmoPpW1tWOfGyh6NMettd3KBAJhg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a05:6402:e94:b0:443:e3fe:7c87 with SMTP id
 h20-20020a0564020e9400b00443e3fe7c87mr16853908eda.144.1661777311215; Mon, 29
 Aug 2022 05:48:31 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:17 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-13-elver@google.com>
Subject: [PATCH v4 12/14] perf/hw_breakpoint: Introduce bp_slots_histogram
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ian Rogers <irogers@google.com>
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

Factor out the existing `atomic_t count[N]` into its own struct called
'bp_slots_histogram', to generalize and make its intent clearer in
preparation of reusing elsewhere. The basic idea of bucketing "total
uses of N slots" resembles a histogram, so calling it such seems most
intuitive.

No functional change.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
v3:
* Also warn in bp_slots_histogram_add() if count goes below 0.

v2:
* New patch.
---
 kernel/events/hw_breakpoint.c | 96 +++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 229c6f4fae75..03ebecf048c0 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -36,19 +36,27 @@
 #include <linux/slab.h>
 
 /*
- * Constraints data
+ * Datastructure to track the total uses of N slots across tasks or CPUs;
+ * bp_slots_histogram::count[N] is the number of assigned N+1 breakpoint slots.
  */
-struct bp_cpuinfo {
-	/* Number of pinned cpu breakpoints in a cpu */
-	unsigned int	cpu_pinned;
-	/* tsk_pinned[n] is the number of tasks having n+1 breakpoints */
+struct bp_slots_histogram {
 #ifdef hw_breakpoint_slots
-	atomic_t	tsk_pinned[hw_breakpoint_slots(0)];
+	atomic_t count[hw_breakpoint_slots(0)];
 #else
-	atomic_t	*tsk_pinned;
+	atomic_t *count;
 #endif
 };
 
+/*
+ * Per-CPU constraints data.
+ */
+struct bp_cpuinfo {
+	/* Number of pinned CPU breakpoints in a CPU. */
+	unsigned int			cpu_pinned;
+	/* Histogram of pinned task breakpoints in a CPU. */
+	struct bp_slots_histogram	tsk_pinned;
+};
+
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
 
 static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
@@ -159,6 +167,18 @@ static inline int hw_breakpoint_slots_cached(int type)
 	return __nr_bp_slots[type];
 }
 
+static __init bool
+bp_slots_histogram_alloc(struct bp_slots_histogram *hist, enum bp_type_idx type)
+{
+	hist->count = kcalloc(hw_breakpoint_slots_cached(type), sizeof(*hist->count), GFP_KERNEL);
+	return hist->count;
+}
+
+static __init void bp_slots_histogram_free(struct bp_slots_histogram *hist)
+{
+	kfree(hist->count);
+}
+
 static __init int init_breakpoint_slots(void)
 {
 	int i, cpu, err_cpu;
@@ -170,8 +190,7 @@ static __init int init_breakpoint_slots(void)
 		for (i = 0; i < TYPE_MAX; i++) {
 			struct bp_cpuinfo *info = get_bp_info(cpu, i);
 
-			info->tsk_pinned = kcalloc(__nr_bp_slots[i], sizeof(atomic_t), GFP_KERNEL);
-			if (!info->tsk_pinned)
+			if (!bp_slots_histogram_alloc(&info->tsk_pinned, i))
 				goto err;
 		}
 	}
@@ -180,7 +199,7 @@ static __init int init_breakpoint_slots(void)
 err:
 	for_each_possible_cpu(err_cpu) {
 		for (i = 0; i < TYPE_MAX; i++)
-			kfree(get_bp_info(err_cpu, i)->tsk_pinned);
+			bp_slots_histogram_free(&get_bp_info(err_cpu, i)->tsk_pinned);
 		if (err_cpu == cpu)
 			break;
 	}
@@ -189,6 +208,34 @@ static __init int init_breakpoint_slots(void)
 }
 #endif
 
+static inline void
+bp_slots_histogram_add(struct bp_slots_histogram *hist, int old, int val)
+{
+	const int old_idx = old - 1;
+	const int new_idx = old_idx + val;
+
+	if (old_idx >= 0)
+		WARN_ON(atomic_dec_return_relaxed(&hist->count[old_idx]) < 0);
+	if (new_idx >= 0)
+		WARN_ON(atomic_inc_return_relaxed(&hist->count[new_idx]) < 0);
+}
+
+static int
+bp_slots_histogram_max(struct bp_slots_histogram *hist, enum bp_type_idx type)
+{
+	for (int i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
+		const int count = atomic_read(&hist->count[i]);
+
+		/* Catch unexpected writers; we want a stable snapshot. */
+		ASSERT_EXCLUSIVE_WRITER(hist->count[i]);
+		if (count > 0)
+			return i + 1;
+		WARN(count < 0, "inconsistent breakpoint slots histogram");
+	}
+
+	return 0;
+}
+
 #ifndef hw_breakpoint_weight
 static inline int hw_breakpoint_weight(struct perf_event *bp)
 {
@@ -205,13 +252,11 @@ static inline enum bp_type_idx find_slot_idx(u64 bp_type)
 }
 
 /*
- * Report the maximum number of pinned breakpoints a task
- * have in this cpu
+ * Return the maximum number of pinned breakpoints a task has in this CPU.
  */
 static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
 {
-	atomic_t *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
-	int i;
+	struct bp_slots_histogram *tsk_pinned = &get_bp_info(cpu, type)->tsk_pinned;
 
 	/*
 	 * At this point we want to have acquired the bp_cpuinfo_sem as a
@@ -219,14 +264,7 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
 	 * toggle_bp_task_slot() to tsk_pinned, and we get a stable snapshot.
 	 */
 	lockdep_assert_held_write(&bp_cpuinfo_sem);
-
-	for (i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
-		ASSERT_EXCLUSIVE_WRITER(tsk_pinned[i]); /* Catch unexpected writers. */
-		if (atomic_read(&tsk_pinned[i]) > 0)
-			return i + 1;
-	}
-
-	return 0;
+	return bp_slots_histogram_max(tsk_pinned, type);
 }
 
 /*
@@ -300,8 +338,7 @@ max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
 static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
 				enum bp_type_idx type, int weight)
 {
-	atomic_t *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
-	int old_idx, new_idx;
+	struct bp_slots_histogram *tsk_pinned = &get_bp_info(cpu, type)->tsk_pinned;
 
 	/*
 	 * If bp->hw.target, tsk_pinned is only modified, but not used
@@ -311,14 +348,7 @@ static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
 	 * bp_cpuinfo_sem as a writer to stabilize tsk_pinned's value.
 	 */
 	lockdep_assert_held_read(&bp_cpuinfo_sem);
-
-	old_idx = task_bp_pinned(cpu, bp, type) - 1;
-	new_idx = old_idx + weight;
-
-	if (old_idx >= 0)
-		atomic_dec(&tsk_pinned[old_idx]);
-	if (new_idx >= 0)
-		atomic_inc(&tsk_pinned[new_idx]);
+	bp_slots_histogram_add(tsk_pinned, task_bp_pinned(cpu, bp, type), weight);
 }
 
 /*
@@ -768,7 +798,7 @@ bool hw_breakpoint_is_used(void)
 				return true;
 
 			for (int slot = 0; slot < hw_breakpoint_slots_cached(type); ++slot) {
-				if (atomic_read(&info->tsk_pinned[slot]))
+				if (atomic_read(&info->tsk_pinned.count[slot]))
 					return true;
 			}
 		}
-- 
2.37.2.672.g94769d06f0-goog

