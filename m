Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3964452B16B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiEREVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiEREUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:20:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6350331345
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fed8245a03so10723017b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TnD0korMG/FM5gYCmH1Njrgw72EedmnJt8tATKJ2XT4=;
        b=khfembNG8zneSKuQEEHGn0lq/InWcEWDv4RIyS1CnNSqUtEwWEPOezARmLO3MiEC/0
         ZfLiShPvRXMV4E+qOTsmH4sF4PLl3TaP9sLnJJC1wV6dchTnqi+Z8lDkwy9yB1wwzjgc
         q6VEOg0PuIaGdcE/JzO59TisF7kOMmB4lHaxvY/M+O2PA75KfU+dY8ZbZ0ISnuEQ52N8
         47gPcRg2SrNEflwnK4Mb1+RI+KqykYO+VHSDZmKOLpXyY/Jh+wm44PlTju2MtzbTRLd1
         IxePjeUr8bHPwh04yvR9g4GdKeT3p/LkbVE7apsPCKOGlX3WBHxChnl33E1fS0IcBRcx
         yjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TnD0korMG/FM5gYCmH1Njrgw72EedmnJt8tATKJ2XT4=;
        b=4x5kr+Sm3COXQSr+B1bWTBwMA9ELVmFhZyRpEq56jYvHt9Ot2UdPsG3ocCubOttpts
         X9+3o56iTfvmR7twMrSRCXjP9DsuKDxkbgv5UGvULWjhzoTJ1G0pVJVc+m85I+im/2wG
         RN8mYJj1zEcmSwaH9KEkxrxonF4uP3Oln6vZTUd/Q74bMomjh7sx+9FP7LDaX+qd7sJX
         wC/7a+/1DyLUasU86AmuJiYxhikWCwYqqXy6lF9nWaMc0B0ZaFsjPODCizB7ynMdDT2g
         DXAsOx0KZCxuhkpwu5nMVJpHog/Huhi14/aVkOx+UXllwyTJDKwSK3ZyFUp/gGv2Arnf
         /g+g==
X-Gm-Message-State: AOAM531R500drxVoYeNoGnMtGXCmDUz5HLs979dH16QDIe7hoCNXk2za
        uQ3dC0h/D4kyrAUi8jYQEHSyCPP0V4h3
X-Google-Smtp-Source: ABdhPJz22hKpEg61DXNKla1u8OL158NTgqC854yWWibewPZZGMH6VhUPRxorNGHZahavCxgarFXR3UEjpm8W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a81:1a4f:0:b0:2f8:9a6:62d6 with SMTP id
 a76-20020a811a4f000000b002f809a662d6mr29831710ywa.74.1652847646532; Tue, 17
 May 2022 21:20:46 -0700 (PDT)
Date:   Tue, 17 May 2022 21:20:25 -0700
In-Reply-To: <20220518042027.836799-1-irogers@google.com>
Message-Id: <20220518042027.836799-7-irogers@google.com>
Mime-Version: 1.0
References: <20220518042027.836799-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 6/8] perf test: Parse events tidy evlist_test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
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

Remove two unused variables. Make structs const. Also fix the array
index (aka id) for the event software/r0x1a/.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 171 ++++++++++++++++----------------
 1 file changed, 84 insertions(+), 87 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 7e802666d2d5..0d65770bd686 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1637,344 +1637,342 @@ static int test__hybrid_cache_event(struct evlist *evlist)
 
 struct evlist_test {
 	const char *name;
-	__u32 type;
-	const int id;
 	bool (*valid)(void);
 	int (*check)(struct evlist *evlist);
 };
 
-static struct evlist_test test__events[] = {
+static const struct evlist_test test__events[] = {
 	{
 		.name  = "syscalls:sys_enter_openat",
 		.check = test__checkevent_tracepoint,
-		.id    = 0,
+		/* 0 */
 	},
 	{
 		.name  = "syscalls:*",
 		.check = test__checkevent_tracepoint_multi,
-		.id    = 1,
+		/* 1 */
 	},
 	{
 		.name  = "r1a",
 		.check = test__checkevent_raw,
-		.id    = 2,
+		/* 2 */
 	},
 	{
 		.name  = "1:1",
 		.check = test__checkevent_numeric,
-		.id    = 3,
+		/* 3 */
 	},
 	{
 		.name  = "instructions",
 		.check = test__checkevent_symbolic_name,
-		.id    = 4,
+		/* 4 */
 	},
 	{
 		.name  = "cycles/period=100000,config2/",
 		.check = test__checkevent_symbolic_name_config,
-		.id    = 5,
+		/* 5 */
 	},
 	{
 		.name  = "faults",
 		.check = test__checkevent_symbolic_alias,
-		.id    = 6,
+		/* 6 */
 	},
 	{
 		.name  = "L1-dcache-load-miss",
 		.check = test__checkevent_genhw,
-		.id    = 7,
+		/* 7 */
 	},
 	{
 		.name  = "mem:0",
 		.check = test__checkevent_breakpoint,
-		.id    = 8,
+		/* 8 */
 	},
 	{
 		.name  = "mem:0:x",
 		.check = test__checkevent_breakpoint_x,
-		.id    = 9,
+		/* 9 */
 	},
 	{
 		.name  = "mem:0:r",
 		.check = test__checkevent_breakpoint_r,
-		.id    = 10,
+		/* 0 */
 	},
 	{
 		.name  = "mem:0:w",
 		.check = test__checkevent_breakpoint_w,
-		.id    = 11,
+		/* 1 */
 	},
 	{
 		.name  = "syscalls:sys_enter_openat:k",
 		.check = test__checkevent_tracepoint_modifier,
-		.id    = 12,
+		/* 2 */
 	},
 	{
 		.name  = "syscalls:*:u",
 		.check = test__checkevent_tracepoint_multi_modifier,
-		.id    = 13,
+		/* 3 */
 	},
 	{
 		.name  = "r1a:kp",
 		.check = test__checkevent_raw_modifier,
-		.id    = 14,
+		/* 4 */
 	},
 	{
 		.name  = "1:1:hp",
 		.check = test__checkevent_numeric_modifier,
-		.id    = 15,
+		/* 5 */
 	},
 	{
 		.name  = "instructions:h",
 		.check = test__checkevent_symbolic_name_modifier,
-		.id    = 16,
+		/* 6 */
 	},
 	{
 		.name  = "faults:u",
 		.check = test__checkevent_symbolic_alias_modifier,
-		.id    = 17,
+		/* 7 */
 	},
 	{
 		.name  = "L1-dcache-load-miss:kp",
 		.check = test__checkevent_genhw_modifier,
-		.id    = 18,
+		/* 8 */
 	},
 	{
 		.name  = "mem:0:u",
 		.check = test__checkevent_breakpoint_modifier,
-		.id    = 19,
+		/* 9 */
 	},
 	{
 		.name  = "mem:0:x:k",
 		.check = test__checkevent_breakpoint_x_modifier,
-		.id    = 20,
+		/* 0 */
 	},
 	{
 		.name  = "mem:0:r:hp",
 		.check = test__checkevent_breakpoint_r_modifier,
-		.id    = 21,
+		/* 1 */
 	},
 	{
 		.name  = "mem:0:w:up",
 		.check = test__checkevent_breakpoint_w_modifier,
-		.id    = 22,
+		/* 2 */
 	},
 	{
 		.name  = "r1,syscalls:sys_enter_openat:k,1:1:hp",
 		.check = test__checkevent_list,
-		.id    = 23,
+		/* 3 */
 	},
 	{
 		.name  = "instructions:G",
 		.check = test__checkevent_exclude_host_modifier,
-		.id    = 24,
+		/* 4 */
 	},
 	{
 		.name  = "instructions:H",
 		.check = test__checkevent_exclude_guest_modifier,
-		.id    = 25,
+		/* 5 */
 	},
 	{
 		.name  = "mem:0:rw",
 		.check = test__checkevent_breakpoint_rw,
-		.id    = 26,
+		/* 6 */
 	},
 	{
 		.name  = "mem:0:rw:kp",
 		.check = test__checkevent_breakpoint_rw_modifier,
-		.id    = 27,
+		/* 7 */
 	},
 	{
 		.name  = "{instructions:k,cycles:upp}",
 		.check = test__group1,
-		.id    = 28,
+		/* 8 */
 	},
 	{
 		.name  = "{faults:k,cache-references}:u,cycles:k",
 		.check = test__group2,
-		.id    = 29,
+		/* 9 */
 	},
 	{
 		.name  = "group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u",
 		.check = test__group3,
-		.id    = 30,
+		/* 0 */
 	},
 	{
 		.name  = "{cycles:u,instructions:kp}:p",
 		.check = test__group4,
-		.id    = 31,
+		/* 1 */
 	},
 	{
 		.name  = "{cycles,instructions}:G,{cycles:G,instructions:G},cycles",
 		.check = test__group5,
-		.id    = 32,
+		/* 2 */
 	},
 	{
 		.name  = "*:*",
 		.check = test__all_tracepoints,
-		.id    = 33,
+		/* 3 */
 	},
 	{
 		.name  = "{cycles,cache-misses:G}:H",
 		.check = test__group_gh1,
-		.id    = 34,
+		/* 4 */
 	},
 	{
 		.name  = "{cycles,cache-misses:H}:G",
 		.check = test__group_gh2,
-		.id    = 35,
+		/* 5 */
 	},
 	{
 		.name  = "{cycles:G,cache-misses:H}:u",
 		.check = test__group_gh3,
-		.id    = 36,
+		/* 6 */
 	},
 	{
 		.name  = "{cycles:G,cache-misses:H}:uG",
 		.check = test__group_gh4,
-		.id    = 37,
+		/* 7 */
 	},
 	{
 		.name  = "{cycles,cache-misses,branch-misses}:S",
 		.check = test__leader_sample1,
-		.id    = 38,
+		/* 8 */
 	},
 	{
 		.name  = "{instructions,branch-misses}:Su",
 		.check = test__leader_sample2,
-		.id    = 39,
+		/* 9 */
 	},
 	{
 		.name  = "instructions:uDp",
 		.check = test__checkevent_pinned_modifier,
-		.id    = 40,
+		/* 0 */
 	},
 	{
 		.name  = "{cycles,cache-misses,branch-misses}:D",
 		.check = test__pinned_group,
-		.id    = 41,
+		/* 1 */
 	},
 	{
 		.name  = "mem:0/1",
 		.check = test__checkevent_breakpoint_len,
-		.id    = 42,
+		/* 2 */
 	},
 	{
 		.name  = "mem:0/2:w",
 		.check = test__checkevent_breakpoint_len_w,
-		.id    = 43,
+		/* 3 */
 	},
 	{
 		.name  = "mem:0/4:rw:u",
 		.check = test__checkevent_breakpoint_len_rw_modifier,
-		.id    = 44
+		/* 4 */
 	},
 #if defined(__s390x__)
 	{
 		.name  = "kvm-s390:kvm_s390_create_vm",
 		.check = test__checkevent_tracepoint,
 		.valid = kvm_s390_create_vm_valid,
-		.id    = 100,
+		/* 0 */
 	},
 #endif
 	{
 		.name  = "instructions:I",
 		.check = test__checkevent_exclude_idle_modifier,
-		.id    = 45,
+		/* 5 */
 	},
 	{
 		.name  = "instructions:kIG",
 		.check = test__checkevent_exclude_idle_modifier_1,
-		.id    = 46,
+		/* 6 */
 	},
 	{
 		.name  = "task-clock:P,cycles",
 		.check = test__checkevent_precise_max_modifier,
-		.id    = 47,
+		/* 7 */
 	},
 	{
 		.name  = "instructions/name=insn/",
 		.check = test__checkevent_config_symbol,
-		.id    = 48,
+		/* 8 */
 	},
 	{
 		.name  = "r1234/name=rawpmu/",
 		.check = test__checkevent_config_raw,
-		.id    = 49,
+		/* 9 */
 	},
 	{
 		.name  = "4:0x6530160/name=numpmu/",
 		.check = test__checkevent_config_num,
-		.id    = 50,
+		/* 0 */
 	},
 	{
 		.name  = "L1-dcache-misses/name=cachepmu/",
 		.check = test__checkevent_config_cache,
-		.id    = 51,
+		/* 1 */
 	},
 	{
 		.name  = "intel_pt//u",
 		.valid = test__intel_pt_valid,
 		.check = test__intel_pt,
-		.id    = 52,
+		/* 2 */
 	},
 	{
 		.name  = "cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
 		.check = test__checkevent_complex_name,
-		.id    = 53
+		/* 3 */
 	},
 	{
 		.name  = "cycles//u",
 		.check = test__sym_event_slash,
-		.id    = 54,
+		/* 4 */
 	},
 	{
 		.name  = "cycles:k",
 		.check = test__sym_event_dc,
-		.id    = 55,
+		/* 5 */
 	},
 	{
 		.name  = "instructions:uep",
 		.check = test__checkevent_exclusive_modifier,
-		.id    = 56,
+		/* 6 */
 	},
 	{
 		.name  = "{cycles,cache-misses,branch-misses}:e",
 		.check = test__exclusive_group,
-		.id    = 57,
+		/* 7 */
 	},
 };
 
-static struct evlist_test test__events_pmu[] = {
+static const struct evlist_test test__events_pmu[] = {
 	{
 		.name  = "cpu/config=10,config1,config2=3,period=1000/u",
 		.check = test__checkevent_pmu,
-		.id    = 0,
+		/* 0 */
 	},
 	{
 		.name  = "cpu/config=1,name=krava/u,cpu/config=2/u",
 		.check = test__checkevent_pmu_name,
-		.id    = 1,
+		/* 1 */
 	},
 	{
 		.name  = "cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/",
 		.check = test__checkevent_pmu_partial_time_callgraph,
-		.id    = 2,
+		/* 2 */
 	},
 	{
 		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
 		.check = test__checkevent_complex_name,
-		.id    = 3,
+		/* 3 */
 	},
 	{
 		.name  = "software/r1a/",
 		.check = test__checkevent_raw_pmu,
-		.id    = 4,
+		/* 4 */
 	},
 	{
 		.name  = "software/r0x1a/",
 		.check = test__checkevent_raw_pmu,
-		.id    = 4,
+		/* 5 */
 	},
 };
 
@@ -1990,55 +1988,55 @@ static const struct terms_test test__terms[] = {
 	},
 };
 
-static struct evlist_test test__hybrid_events[] = {
+static const struct evlist_test test__hybrid_events[] = {
 	{
 		.name  = "cpu_core/cpu-cycles/",
 		.check = test__hybrid_hw_event_with_pmu,
-		.id    = 0,
+		/* 0 */
 	},
 	{
 		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
 		.check = test__hybrid_hw_group_event,
-		.id    = 1,
+		/* 1 */
 	},
 	{
 		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
 		.check = test__hybrid_sw_hw_group_event,
-		.id    = 2,
+		/* 2 */
 	},
 	{
 		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
 		.check = test__hybrid_hw_sw_group_event,
-		.id    = 3,
+		/* 3 */
 	},
 	{
 		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
 		.check = test__hybrid_group_modifier1,
-		.id    = 4,
+		/* 4 */
 	},
 	{
 		.name  = "r1a",
 		.check = test__hybrid_raw1,
-		.id    = 5,
+		/* 5 */
 	},
 	{
 		.name  = "cpu_core/r1a/",
 		.check = test__hybrid_raw2,
-		.id    = 6,
+		/* 6 */
 	},
 	{
 		.name  = "cpu_core/config=10,config1,config2=3,period=1000/u",
 		.check = test__checkevent_pmu,
-		.id    = 7,
+		/* 7 */
 	},
 	{
 		.name  = "cpu_core/LLC-loads/",
 		.check = test__hybrid_cache_event,
-		.id    = 8,
+		/* 8 */
 	},
 };
 
-static int test_event(struct evlist_test *e)
+static int test_event(const struct evlist_test *e)
 {
 	struct parse_events_error err;
 	struct evlist *evlist;
@@ -2093,15 +2091,14 @@ static int test_event_fake_pmu(const char *str)
 	return ret;
 }
 
-static int test_events(struct evlist_test *events, unsigned cnt)
+static int test_events(const struct evlist_test *events, int cnt)
 {
 	int ret1, ret2 = 0;
-	unsigned i;
 
-	for (i = 0; i < cnt; i++) {
-		struct evlist_test *e = &events[i];
+	for (int i = 0; i < cnt; i++) {
+		const struct evlist_test *e = &events[i];
 
-		pr_debug("running test %d '%s'", e->id, e->name);
+		pr_debug("running test %d '%s'", i, e->name);
 		ret1 = test_event(e);
 		if (ret1)
 			ret2 = ret1;
@@ -2193,7 +2190,7 @@ static int test_pmu_events(void)
 	}
 
 	while (!ret && (ent = readdir(dir))) {
-		struct evlist_test e = { .id = 0, };
+		struct evlist_test e = { .name = NULL, };
 		char name[2 * NAME_MAX + 1 + 12 + 3];
 
 		/* Names containing . are special and cannot be used directly */
@@ -2288,7 +2285,7 @@ static int test__checkevent_pmu_events_alias(struct evlist *evlist)
 
 static int test_pmu_events_alias(char *event, char *alias)
 {
-	struct evlist_test e = { .id = 0, };
+	struct evlist_test e = { .name = NULL, };
 	char name[2 * NAME_MAX + 20];
 
 	snprintf(name, sizeof(name), "%s/event=1/,%s/event=1/",
-- 
2.36.0.550.gb090851708-goog

