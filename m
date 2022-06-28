Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B7755C52C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242767AbiF1J7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbiF1J7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:59:25 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8072E2F03B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:59:19 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id g8-20020a056402090800b00433940d207eso9213775edz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/0VhMmtwvDisaf1/VFeOhEr7O2fqwRDhX2jxpYNVTBM=;
        b=A0dgUThUsxPUPonRuJ44vJy//juG7PWAxTRrAzXc+IibEPgCLMqm1ff+TIXJBEZ4np
         urC1WuFUcZd3YkbyJmudQfO5F/PQRUiveUt4UNIP8Khq54xdHp/Y51ymcnAwQah0iSnL
         4gjDKUi5LDExHQwQ1kV6g+MXeoLaXkjz9ZIeNSPE0jMkI0CnECpGUS+SZ2rCZxsPQlvG
         CNqasN6Q9R1G2i73lTKeBDXyTFojyY2SfCeyEBazvTR7ehqVzJTf9PjergX/M/J/RQla
         xFtnhK8Rg1MDjdK7+eJSMNx78aoMhZTqLZ/u+soOR1ylLyZPRjgsQg5Xhdx8XG5W/gdl
         5UMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/0VhMmtwvDisaf1/VFeOhEr7O2fqwRDhX2jxpYNVTBM=;
        b=kO6+6oX2Zuf7oPChB2eambTDwfMkR1AuvqNyGq4yuWdMot9zjyGMM+M97JZfE/14Xs
         jiw8gtd4an/jxOetvZW/E3elob4/6uOSrcrLm9D4Y7PVgNmhjnG1KZDPhfzwJdI+s5FF
         eRySr7ge+19SCqFZJmavd6wPJbJ9X/g0mPCzX4XRhL355//g2zrnd0IV2CLd+SdIlU9k
         tjWbjLZpiDH8TAIXgJTElRuClchbKg9UbpraQM37t5XrCCTiVGtX2NIL38KaHxVq1DjV
         E7tba5M4QwDOhLpgqLnACQLvS1dZJek5Sgu0LQjSoeEtI/cpRcH4Tj8TEbbrYl1FzTfY
         6S9w==
X-Gm-Message-State: AJIora9HlCg8Hwvafiqg5F3MAo2xcKycxjsPozhM51+A7/OBlRku3aYJ
        j/AHpj7wh26O6xiRymm5jE2j2qL6uQ==
X-Google-Smtp-Source: AGRyM1s3wSZD386YJd1I3q4SwD0OlcR9IoNthKEblJrheRGJiJSpbwnIbtVCz4d8AphovvEqixF3HDIPKg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a17:906:e4c:b0:726:94a0:2701 with SMTP id
 q12-20020a1709060e4c00b0072694a02701mr12840911eji.360.1656410357809; Tue, 28
 Jun 2022 02:59:17 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:27 +0200
In-Reply-To: <20220628095833.2579903-1-elver@google.com>
Message-Id: <20220628095833.2579903-8-elver@google.com>
Mime-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 07/13] perf/hw_breakpoint: Remove useless code related to
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
---
v2:
* Also remove struct bp_busy_slots, and simplify functions.
---
 kernel/events/hw_breakpoint.c | 57 +++++++++++------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index a124786e3ade..63e39dc836bd 100644
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

