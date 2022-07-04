Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15C565957
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiGDPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiGDPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:06:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BBC1181F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:06:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31c89c753b3so25864307b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V6/7gBssT9f8qylfI12t9/BYdohkMdKIWfeQweBYfic=;
        b=JoVGDf6yQ8hGirou83feMsM4fL6UwLihSOqkkLWWVbbLtWhghXfhWuyGi7Gb7aA4KC
         HT6QhfDG1/w3eMQbfxFGGy0lV0o65w9EQxD/Zup+jg6IzZx0IB6ouZLD0PgjF8tUc9p5
         JYwZTgOkQ+VR3vTmGIGyuk6MDYpfVw8MWyDx256153/zJCXt6uETyGdn43Tn3YoeVDqc
         terWTuZUxZKccqKMfObUL1ySacZIWbCEizjsXbCXgIRgsrIXLZRiaddpXxsVs8zsCiVs
         fVrPnCz03zW3qC+vf6NAp0pen31JzqIP3Dlf1koXr99dwWadbrUjqQ6JWirJ30JZvM/4
         k4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V6/7gBssT9f8qylfI12t9/BYdohkMdKIWfeQweBYfic=;
        b=4Qy9jFOW4HYh3n0N1Q6knJt0wASvgAXz5AQjf+Bf8ZccLZhUSUywtCFsr8r7kS0v3r
         rhYlfrXp6r6sdTJu2cr/JI/y2suHXoxFo7DMcjeJGZj+ija0bQ1weBUO2dXaxkHhiakn
         Zvl79zfTP3Fng+AEtbvvvML8gxMlU7FuyUSS0QA2gtdL2C7Ng34+hOVXZaw9E92CIu/t
         3fQW+v1RoL+iWhLcrRh6v6tYBMd70Cj1a4UOENu/QK4PY2Oz1QTxU8sp/HcINRvR2Iwc
         ZOmACvM7idReE/fkO1XeUxAsq4/8hvIyzSg2QTU9K3B/DpUonLPL+SW0yUZtJ0NAb0DT
         V8Hg==
X-Gm-Message-State: AJIora+VqA784g8ornfLm3vq+qEaLa90j2AMZJVY84twacX7ox0j7nZ+
        otP6BQypKOF0roZR+DFjQZwOSijc5Q==
X-Google-Smtp-Source: AGRyM1tBjV0pVOkHHvxY5ShCb3zsNgcpQYjMGcRVbXSuG4UWDvuTzPmMgrbvjsm2+aO9XSs5DSKPcBWbQA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:6edf:e1bc:9a92:4ad0])
 (user=elver job=sendgmr) by 2002:a81:11c7:0:b0:31c:8c85:c4be with SMTP id
 190-20020a8111c7000000b0031c8c85c4bemr8356031ywr.235.1656947177651; Mon, 04
 Jul 2022 08:06:17 -0700 (PDT)
Date:   Mon,  4 Jul 2022 17:05:08 +0200
In-Reply-To: <20220704150514.48816-1-elver@google.com>
Message-Id: <20220704150514.48816-9-elver@google.com>
Mime-Version: 1.0
References: <20220704150514.48816-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 08/14] perf/hw_breakpoint: Remove useless code related to
 flexible breakpoints
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flexible breakpoints have never been implemented, with
bp_cpuinfo::flexible always being 0. Unfortunately, they still occupy 4
bytes in each bp_cpuinfo and bp_busy_slots, as well as computing the max
flexible count in fetch_bp_busy_slots().

This again causes suboptimal code generation, when we always know that
`!!slots.flexible` will be 0.

Just get rid of the flexible "placeholder" and remove all real code
related to it. Make a note in the comment related to the constraints
algorithm but don't remove them from the algorithm, so that if in future
flexible breakpoints need supporting, it should be trivial to revive
them (along with reverting this change).

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
---
v2:
* Also remove struct bp_busy_slots, and simplify functions.
---
 kernel/events/hw_breakpoint.c | 57 +++++++++++------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 9c9bf17666a5..8b40fca1a063 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -45,8 +45,6 @@ struct bp_cpuinfo {
 #else
 	unsigned int	*tsk_pinned;
 #endif
-	/* Number of non-pinned cpu/task breakpoints in a cpu */
-	unsigned int	flexible; /* XXX: placeholder, see fetch_this_slot() */
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
@@ -67,12 +65,6 @@ static const struct rhashtable_params task_bps_ht_params = {
 
 static bool constraints_initialized __ro_after_init;
 
-/* Gather the number of total pinned and un-pinned bp in a cpuset */
-struct bp_busy_slots {
-	unsigned int pinned;
-	unsigned int flexible;
-};
-
 /* Serialize accesses to the above constraints */
 static DEFINE_MUTEX(nr_bp_mutex);
 
@@ -190,14 +182,14 @@ static const struct cpumask *cpumask_of_bp(struct perf_event *bp)
 }
 
 /*
- * Report the number of pinned/un-pinned breakpoints we have in
- * a given cpu (cpu > -1) or in all of them (cpu = -1).
+ * Returns the max pinned breakpoint slots in a given
+ * CPU (cpu > -1) or across all of them (cpu = -1).
  */
-static void
-fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
-		    enum bp_type_idx type)
+static int
+max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
 {
 	const struct cpumask *cpumask = cpumask_of_bp(bp);
+	int pinned_slots = 0;
 	int cpu;
 
 	for_each_cpu(cpu, cpumask) {
@@ -210,24 +202,10 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
 		else
 			nr += task_bp_pinned(cpu, bp, type);
 
-		if (nr > slots->pinned)
-			slots->pinned = nr;
-
-		nr = info->flexible;
-		if (nr > slots->flexible)
-			slots->flexible = nr;
+		pinned_slots = max(nr, pinned_slots);
 	}
-}
 
-/*
- * For now, continue to consider flexible as pinned, until we can
- * ensure no flexible event can ever be scheduled before a pinned event
- * in a same cpu.
- */
-static void
-fetch_this_slot(struct bp_busy_slots *slots, int weight)
-{
-	slots->pinned += weight;
+	return pinned_slots;
 }
 
 /*
@@ -298,7 +276,12 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
 }
 
 /*
- * Constraints to check before allowing this new breakpoint counter:
+ * Constraints to check before allowing this new breakpoint counter.
+ *
+ * Note: Flexible breakpoints are currently unimplemented, but outlined in the
+ * below algorithm for completeness.  The implementation treats flexible as
+ * pinned due to no guarantee that we currently always schedule flexible events
+ * before a pinned event in a same CPU.
  *
  *  == Non-pinned counter == (Considered as pinned for now)
  *
@@ -340,8 +323,8 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
  */
 static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 {
-	struct bp_busy_slots slots = {0};
 	enum bp_type_idx type;
+	int max_pinned_slots;
 	int weight;
 	int ret;
 
@@ -357,15 +340,9 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	type = find_slot_idx(bp_type);
 	weight = hw_breakpoint_weight(bp);
 
-	fetch_bp_busy_slots(&slots, bp, type);
-	/*
-	 * Simulate the addition of this breakpoint to the constraints
-	 * and see the result.
-	 */
-	fetch_this_slot(&slots, weight);
-
-	/* Flexible counters need to keep at least one slot */
-	if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
+	/* Check if this new breakpoint can be satisfied across all CPUs. */
+	max_pinned_slots = max_bp_pinned_slots(bp, type) + weight;
+	if (max_pinned_slots > hw_breakpoint_slots_cached(type))
 		return -ENOSPC;
 
 	ret = arch_reserve_bp_slot(bp);
-- 
2.37.0.rc0.161.g10f37bed90-goog

