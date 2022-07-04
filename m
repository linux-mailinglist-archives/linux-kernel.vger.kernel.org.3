Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032F056595D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiGDPHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiGDPGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:06:42 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9011C16
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:06:29 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id sd14-20020a1709076e0e00b0072a7c5a08f4so2134105ejc.21
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pxbTqlp1PMd6Kn/Ogba6QdxHSgu8OctnaZIv/qt2Oi0=;
        b=KryRGHzBTGcZBuTjEgu5v+BWReUDdQt6ANmxLR4dswf4CnBmrveZASUoWHE4jLpPa6
         dYl/Go+uQtD/ToJW8XzhRy/XRi2YFjECqYpkNhJZfKJ4VpGR91DJMGta8u5d7NpAXdxl
         F0IE4AjPbSy2RzYxLdB6avN2o1pDTafq3mqxAUR0u7p8eSwPSPICF5XG+OnbBtNqJ0x5
         T5V9DNqkqz5bOXcabZCBmSRyDxVykNx3v8JJ07Xhdu5dreScXM48AhpirCbqwLV1oVN6
         yQuTXuZpDWKU8kk+S2MXv5+3v+yKCI4jfd8X3/CQ3/OupPhUFQi6ys9XSJWws+fKL2yk
         axHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pxbTqlp1PMd6Kn/Ogba6QdxHSgu8OctnaZIv/qt2Oi0=;
        b=SUkWYC+qTFxs3pn5nAe9uSkK4e3cFYlglWORtoHO/AHg2+Y200Zk2iT5HtlhB1/UMd
         r4kY8lXssiCnK7XNtK7mOv7Ik9OlTcLdBP9lB2yyI5b7Xl0GXZq5SaoD6I0mVuz1fhcV
         L/zLdNuiVRIffU+LRPOI1FLme5XR8udJHP6rsGQM5+JbQKntF/NJMAuyL4/g5GPnLFf5
         hkfmYgeOGqJqxi+AfonOUik1kMrOfHnclEwPUD9dSvmsElsXQwDV5j6GYIOabNmZFKH1
         IBUJluxYYRe3fpEGyvUkuvGaPQM/1tH9Oy4nRPSzeXfM00M+od70uxXQe+0U69LXOnDA
         eDGA==
X-Gm-Message-State: AJIora/nhwsfObq7jIRrRmdIHDSu3ffagM/rwuadGAXHD7X/neXRFk8N
        V9rhQnV/WxXDfoCeHungTyvS+VVxZQ==
X-Google-Smtp-Source: AGRyM1vLJnOACj4/jLS5L0OuUkRQLwE8hDFdrs9VbHE91ZtKl2x0yvmEG67H5n2IWTWle3euSMFlDl174g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:6edf:e1bc:9a92:4ad0])
 (user=elver job=sendgmr) by 2002:a05:6402:34cd:b0:43a:6e91:c5ff with SMTP id
 w13-20020a05640234cd00b0043a6e91c5ffmr3092109edc.88.1656947188668; Mon, 04
 Jul 2022 08:06:28 -0700 (PDT)
Date:   Mon,  4 Jul 2022 17:05:12 +0200
In-Reply-To: <20220704150514.48816-1-elver@google.com>
Message-Id: <20220704150514.48816-13-elver@google.com>
Mime-Version: 1.0
References: <20220704150514.48816-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 12/14] perf/hw_breakpoint: Introduce bp_slots_histogram
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
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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
2.37.0.rc0.161.g10f37bed90-goog

