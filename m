Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C935A4CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiH2M5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiH2M43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:29 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E5E7F110
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:16 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id w18-20020ac25d52000000b0048af13b6ef6so2019393lfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=NAgg+axkJ/HbuBi/N/cfy43ZzHoR1EkHXaJqULg0eJ8=;
        b=d6tp/6qX5TL3XVtPCbJz2/1vuIAcUvKthwO40GKuZhgzsTTDRuiOkz3BZcixKBbi2n
         UQYkdthiBMcKQ9ZXpIqi/To5OOYxKb/S4Z/1EGZsN0+gq/poq9hq9KqthbUQVCglAJX8
         xlmoGDW15PsCUmXFgve7TsBen3OR8air0io8XYZ1XE6ulaap/zwXhenfCdVxUVBbmA2d
         AvKHvHaeNzWbyizTuyopXBWL0dm+dKBB/SYfST65x9lohRyv8I2PmWRhey6EebuOhlT7
         K7hjRncGEscd9yk4szPmUVZk0eVLuEF72owL1CGws1KtJ8MO0hkKYiib6fb6Z7IKwn/6
         JMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=NAgg+axkJ/HbuBi/N/cfy43ZzHoR1EkHXaJqULg0eJ8=;
        b=i7Ylt/F4A4mk3FqWkWyO09IqVEkSWIjA3UaUScrbXbC+zyYr4hGV9hCGLSR4Uw75Da
         POnMyIhlRBF/Ppy2ENXNgrXwKw4E5ODTJNW6jeZNgTzxkpde9zcFkgQmjfg5Qx8d1C3Z
         +fulbpf8pRtAAOs2tUW0qZR84zVwNg363GznvDnMtKMCkq9Hf2ENmY6+KwG9eky2m+qE
         rfl+VvdXFakfQauBqtYv51M5gkV0XFJ1J949cF1+z5ENpB/IKnsyS4/V/guJEbtO/ITv
         djY99Z7GQXtFcUTaPJanc+LbZ7/ODC1BZPCBjbUwnaHXtp89nI91O0hjNW7T/TqO7wZH
         +gfQ==
X-Gm-Message-State: ACgBeo3bzvyhEqVWDjHicllvAlIxR6hsqZnn12729ikO2UApycjrbPaL
        opamfGNd1+4pUJlvuhgemsACeJzF+w==
X-Google-Smtp-Source: AA6agR7ShzfoSB2vjBsmBIrxfMh2D8H7+VTFm9wSqU5SVOMol70ihnkQBQYE6o2VylcaG46rPGK6/VRekQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a05:6512:3b10:b0:494:6105:1f62 with SMTP id
 f16-20020a0565123b1000b0049461051f62mr3032181lfv.172.1661777294789; Mon, 29
 Aug 2022 05:48:14 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:11 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-7-elver@google.com>
Subject: [PATCH v4 06/14] perf/hw_breakpoint: Optimize constant number of
 breakpoint slots
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

Optimize internal hw_breakpoint state if the architecture's number of
breakpoint slots is constant. This avoids several kmalloc() calls and
potentially unnecessary failures if the allocations fail, as well as
subtly improves code generation and cache locality.

The protocol is that if an architecture defines hw_breakpoint_slots via
the preprocessor, it must be constant and the same for all types.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 arch/sh/include/asm/hw_breakpoint.h  |  5 +-
 arch/x86/include/asm/hw_breakpoint.h |  5 +-
 kernel/events/hw_breakpoint.c        | 94 ++++++++++++++++++----------
 3 files changed, 63 insertions(+), 41 deletions(-)

diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index 199d17b765f2..361a0f57bdeb 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -48,10 +48,7 @@ struct pmu;
 /* Maximum number of UBC channels */
 #define HBP_NUM		2
 
-static inline int hw_breakpoint_slots(int type)
-{
-	return HBP_NUM;
-}
+#define hw_breakpoint_slots(type) (HBP_NUM)
 
 /* arch/sh/kernel/hw_breakpoint.c */
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index a1f0e90d0818..0bc931cd0698 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -44,10 +44,7 @@ struct arch_hw_breakpoint {
 /* Total number of available HW breakpoint registers */
 #define HBP_NUM 4
 
-static inline int hw_breakpoint_slots(int type)
-{
-	return HBP_NUM;
-}
+#define hw_breakpoint_slots(type) (HBP_NUM)
 
 struct perf_event_attr;
 struct perf_event;
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 7df46b276452..9fb66d358d81 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -40,13 +40,16 @@ struct bp_cpuinfo {
 	/* Number of pinned cpu breakpoints in a cpu */
 	unsigned int	cpu_pinned;
 	/* tsk_pinned[n] is the number of tasks having n+1 breakpoints */
+#ifdef hw_breakpoint_slots
+	unsigned int	tsk_pinned[hw_breakpoint_slots(0)];
+#else
 	unsigned int	*tsk_pinned;
+#endif
 	/* Number of non-pinned cpu/task breakpoints in a cpu */
 	unsigned int	flexible; /* XXX: placeholder, see fetch_this_slot() */
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
-static int nr_slots[TYPE_MAX] __ro_after_init;
 
 static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
 {
@@ -73,6 +76,54 @@ struct bp_busy_slots {
 /* Serialize accesses to the above constraints */
 static DEFINE_MUTEX(nr_bp_mutex);
 
+#ifdef hw_breakpoint_slots
+/*
+ * Number of breakpoint slots is constant, and the same for all types.
+ */
+static_assert(hw_breakpoint_slots(TYPE_INST) == hw_breakpoint_slots(TYPE_DATA));
+static inline int hw_breakpoint_slots_cached(int type)	{ return hw_breakpoint_slots(type); }
+static inline int init_breakpoint_slots(void)		{ return 0; }
+#else
+/*
+ * Dynamic number of breakpoint slots.
+ */
+static int __nr_bp_slots[TYPE_MAX] __ro_after_init;
+
+static inline int hw_breakpoint_slots_cached(int type)
+{
+	return __nr_bp_slots[type];
+}
+
+static __init int init_breakpoint_slots(void)
+{
+	int i, cpu, err_cpu;
+
+	for (i = 0; i < TYPE_MAX; i++)
+		__nr_bp_slots[i] = hw_breakpoint_slots(i);
+
+	for_each_possible_cpu(cpu) {
+		for (i = 0; i < TYPE_MAX; i++) {
+			struct bp_cpuinfo *info = get_bp_info(cpu, i);
+
+			info->tsk_pinned = kcalloc(__nr_bp_slots[i], sizeof(int), GFP_KERNEL);
+			if (!info->tsk_pinned)
+				goto err;
+		}
+	}
+
+	return 0;
+err:
+	for_each_possible_cpu(err_cpu) {
+		for (i = 0; i < TYPE_MAX; i++)
+			kfree(get_bp_info(err_cpu, i)->tsk_pinned);
+		if (err_cpu == cpu)
+			break;
+	}
+
+	return -ENOMEM;
+}
+#endif
+
 __weak int hw_breakpoint_weight(struct perf_event *bp)
 {
 	return 1;
@@ -95,7 +146,7 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
 	unsigned int *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
 	int i;
 
-	for (i = nr_slots[type] - 1; i >= 0; i--) {
+	for (i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
 		if (tsk_pinned[i] > 0)
 			return i + 1;
 	}
@@ -312,7 +363,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	fetch_this_slot(&slots, weight);
 
 	/* Flexible counters need to keep at least one slot */
-	if (slots.pinned + (!!slots.flexible) > nr_slots[type])
+	if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
 		return -ENOSPC;
 
 	ret = arch_reserve_bp_slot(bp);
@@ -632,7 +683,7 @@ bool hw_breakpoint_is_used(void)
 			if (info->cpu_pinned)
 				return true;
 
-			for (int slot = 0; slot < nr_slots[type]; ++slot) {
+			for (int slot = 0; slot < hw_breakpoint_slots_cached(type); ++slot) {
 				if (info->tsk_pinned[slot])
 					return true;
 			}
@@ -716,42 +767,19 @@ static struct pmu perf_breakpoint = {
 
 int __init init_hw_breakpoint(void)
 {
-	int cpu, err_cpu;
-	int i, ret;
-
-	for (i = 0; i < TYPE_MAX; i++)
-		nr_slots[i] = hw_breakpoint_slots(i);
-
-	for_each_possible_cpu(cpu) {
-		for (i = 0; i < TYPE_MAX; i++) {
-			struct bp_cpuinfo *info = get_bp_info(cpu, i);
-
-			info->tsk_pinned = kcalloc(nr_slots[i], sizeof(int),
-							GFP_KERNEL);
-			if (!info->tsk_pinned) {
-				ret = -ENOMEM;
-				goto err;
-			}
-		}
-	}
+	int ret;
 
 	ret = rhltable_init(&task_bps_ht, &task_bps_ht_params);
 	if (ret)
-		goto err;
+		return ret;
+
+	ret = init_breakpoint_slots();
+	if (ret)
+		return ret;
 
 	constraints_initialized = true;
 
 	perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
 
 	return register_die_notifier(&hw_breakpoint_exceptions_nb);
-
-err:
-	for_each_possible_cpu(err_cpu) {
-		for (i = 0; i < TYPE_MAX; i++)
-			kfree(get_bp_info(err_cpu, i)->tsk_pinned);
-		if (err_cpu == cpu)
-			break;
-	}
-
-	return ret;
 }
-- 
2.37.2.672.g94769d06f0-goog

