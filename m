Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B9D525A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376964AbiEMEGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376957AbiEMEFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:05:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C30629B803
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4e758e54bso62906937b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 21:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TnD0korMG/FM5gYCmH1Njrgw72EedmnJt8tATKJ2XT4=;
        b=NhFU70+jUkH6Xs/DRPBKYk9SVj37j5JgUr130xJph6Oa1nXGnY+pynQZFbB0x2QgEW
         fnk2bRDjMyTOlj+U3SUp5DsZLmTNEub+i2TPKpAryG/EDEb/i/PChYsy162VJhIwvXSc
         U/gmbEZAukjnN6aPe/Avp90oYhDHLv6eQ/LVH09HwGVCoq5ibEnllVdNBvc0U8RsT6/r
         GG76E4xz+V3aN2CiWUbSrkl4RWg4fZY5QLLHiQu+3ntYS/83jTlXSpEWh+Kz97jtjm9f
         2ahcG8qg0IDv1SlkDMOJ+X1J1GrebysNfYdZFuxAK4oS3xilSpRomu0K1iAvW5OwXtzm
         zdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TnD0korMG/FM5gYCmH1Njrgw72EedmnJt8tATKJ2XT4=;
        b=JRxCGUL404du7INHPVD62eWXWxcmlZKyMPTVoLJqGNxiECRP5U70aUww2MqICciqds
         2wnkWDgfA9iEAJvLBgJ39JxUX/BoCMcMJJTj/z/QXXTYsVRAE3AF6glNrdtwjDGKRObf
         1zquNcBRHMp3ew60hYhmuSCIWdVgzqtcJxN+bI6ShXTazLggKcAvHhh4lSKm++poRHWc
         uXtIRyhQvJjRegoOAIx3uqNmwHrXNplI5n6krwGVnp+edRoDPhuQR7p+D7/YCaTJyBMN
         a5uxzIz1Y30zSkyN1vxGfFVztDFHgrZet4h1Ui21+0aAVXwZyx8dz+5iU7G/lvFCA9md
         6QlA==
X-Gm-Message-State: AOAM533vVGgtLSx3wV3/W6cdkNuuQ8a2NgNknNTruXFCmatXxILfgvrh
        Vfmgxym3vF7/v/1r+tjt0mcPPQYj9Sfq
X-Google-Smtp-Source: ABdhPJyRJClZHRVNKvXMKYU+qn0EeLQUmE1vcwd2mzKgluCGehzMIzNkGEA7RShVt6x+XCyx9gEATmJiXyN/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a81:2dc5:0:b0:2f5:c6c8:9ee5 with SMTP id
 t188-20020a812dc5000000b002f5c6c89ee5mr3611346ywt.518.1652414738368; Thu, 12
 May 2022 21:05:38 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:18 -0700
In-Reply-To: <20220513040519.1499333-1-irogers@google.com>
Message-Id: <20220513040519.1499333-7-irogers@google.com>
Mime-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 6/7] perf test: Parse events tidy evlist_test
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

