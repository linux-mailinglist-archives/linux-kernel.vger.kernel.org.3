Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A6B54CEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356682AbiFOQdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356130AbiFOQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:32:37 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0FA6574;
        Wed, 15 Jun 2022 09:32:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i64so11910943pfc.8;
        Wed, 15 Jun 2022 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lEQiFQkN3hYWYIRpASWYdljxjRdSlfRPErOBQ95X4rY=;
        b=NSFoYeUiPpESb8t/o0bNmftJBHcM2trVMRpQwJfVOdHtBRNYZNX1D7o7tj4JENEJo0
         NqeAuDYLWicCzCwItmdFcsqE/aFFSa/3zpYIfWJ2de78A1PBdZEkVghLoM3aBRoReoMW
         BK9teIegX5jFHPqhaKZrfyBg3t1cN8r8b7eDCUAHTDXH7repUXyHFcDwc7X5q+84OO0C
         LCxK3gX3suExDviIMjOWZrIUzo8itOV3PpmlgTYKCNPdugJEkS+IX2KYj9XUyhqNge3Z
         AH2kWbQBzQW7T7J0oJjbwSpP840Ij4jFzXYfeWFYbqOfKFHMPZzLCxOtp/DaqjXOysYW
         KfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=lEQiFQkN3hYWYIRpASWYdljxjRdSlfRPErOBQ95X4rY=;
        b=oTGCnTiR+Eg0JC1FmeuviiqIg7o8pPkBJ85gmqgvT7opFRCsWkiytw0KMfj9aEvkR0
         Q0kkdEVz9pL5SLyWca7unwcFBvkl18ktcF5aKv05fSdSPQKVJbuXxD5y/vspIhtJXTNG
         IHQQ7NySAIU0d2RihT1hoBkx4SRDL8mqMIogvaZLAB+R0X5wNpwJZgjk5uEUkPq2TxHF
         QCX5CtZQ6WPIu8uKV8GyW1gcwjeztie6pDL7ov5K7YGWBympGdlPX0vAZhuA1G/bsTvO
         eJL4iruFuNraLiEkl4XsEv2U9SnUtYPReII0N2U+iTrglgZQQs1FLQNdE1Zj//TSCUMd
         5Hqw==
X-Gm-Message-State: AJIora8zNbx0N09uFVKqK262abTHAaOjRo1emeJvez0Bm1gIA5bf6lq6
        jQM6zA3/7Dil02Jj7XIWQ2M=
X-Google-Smtp-Source: AGRyM1vhiz4aVpfmIst+A4e/+gfGiZDWFm9hdMrdqTggjpl1Qecn1iX8tBSfGv267fl8hTK+3qaMAQ==
X-Received: by 2002:a63:6885:0:b0:405:1d96:b671 with SMTP id d127-20020a636885000000b004051d96b671mr510297pgc.511.1655310756067;
        Wed, 15 Jun 2022 09:32:36 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:6b99:92ca:1efa:c0fb])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b00168bffd39a1sm9583881plk.143.2022.06.15.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:32:35 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 7/7] perf lock: Look up callchain for the contended locks
Date:   Wed, 15 Jun 2022 09:32:22 -0700
Message-Id: <20220615163222.1275500-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615163222.1275500-1-namhyung@kernel.org>
References: <20220615163222.1275500-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock contention tracepoints don't provide lock names.  All we can
do is to get stack traces and show the caller instead.  To minimize
the overhead it's limited to up to 8 stack traces and display the
first non-lock function symbol name as a caller.

  $ perf lock report -F acquired,contended,avg_wait,wait_total

                  Name   acquired  contended     avg wait    total wait

   update_blocked_a...         40         40      3.61 us     144.45 us
   kernfs_fop_open+...          5          5      3.64 us      18.18 us
    _nohz_idle_balance          3          3      2.65 us       7.95 us
   tick_do_update_j...          1          1      6.04 us       6.04 us
    ep_scan_ready_list          1          1      3.93 us       3.93 us
  ...

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 160 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 546dad1963c8..c5ca34741561 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -9,6 +9,7 @@
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/header.h"
+#include "util/callchain.h"
 
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
@@ -19,6 +20,7 @@
 #include "util/tool.h"
 #include "util/data.h"
 #include "util/string2.h"
+#include "util/map.h"
 
 #include <sys/types.h>
 #include <sys/prctl.h>
@@ -32,6 +34,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <linux/err.h>
+#include <linux/stringify.h>
 
 static struct perf_session *session;
 
@@ -120,6 +123,24 @@ static struct rb_root		thread_stats;
 static bool combine_locks;
 static bool show_thread_stats;
 
+/*
+ * CONTENTION_STACK_DEPTH
+ * Number of stack trace entries to find callers
+ */
+#define CONTENTION_STACK_DEPTH  8
+
+/*
+ * CONTENTION_STACK_SKIP
+ * Number of stack trace entries to skip when finding callers.
+ * The first few entries belong to the locking implementation itself.
+ */
+#define CONTENTION_STACK_SKIP  3
+
+static u64 sched_text_start;
+static u64 sched_text_end;
+static u64 lock_text_start;
+static u64 lock_text_end;
+
 static struct thread_stat *thread_stat_find(u32 tid)
 {
 	struct rb_node *node;
@@ -839,6 +860,116 @@ static int report_lock_release_event(struct evsel *evsel,
 	return 0;
 }
 
+static bool is_lock_function(u64 addr)
+{
+	if (!sched_text_start) {
+		struct machine *machine = &session->machines.host;
+		struct map *kmap;
+		struct symbol *sym;
+
+		sym = machine__find_kernel_symbol_by_name(machine,
+							  "__sched_text_start",
+							  &kmap);
+		if (!sym) {
+			/* to avoid retry */
+			sched_text_start = 1;
+			return false;
+		}
+
+		sched_text_start = kmap->unmap_ip(kmap, sym->start);
+
+		/* should not fail from here */
+		sym = machine__find_kernel_symbol_by_name(machine,
+							  "__sched_text_end",
+							  &kmap);
+		sched_text_end = kmap->unmap_ip(kmap, sym->start);
+
+		sym = machine__find_kernel_symbol_by_name(machine,
+							  "__lock_text_start",
+							  &kmap);
+		lock_text_start = kmap->unmap_ip(kmap, sym->start);
+
+		sym = machine__find_kernel_symbol_by_name(machine,
+							  "__lock_text_end",
+							  &kmap);
+		lock_text_start = kmap->unmap_ip(kmap, sym->start);
+	}
+
+	/* failed to get kernel symbols */
+	if (sched_text_start == 1)
+		return false;
+
+	/* mutex and rwsem functions are in sched text section */
+	if (sched_text_start <= addr && addr < sched_text_end)
+		return true;
+
+	/* spinlock functions are in lock text section */
+	if (lock_text_start <= addr && addr < lock_text_end)
+		return true;
+
+	return false;
+}
+
+static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sample,
+				  char *buf, int size)
+{
+	struct thread *thread;
+	struct callchain_cursor *cursor = &callchain_cursor;
+	struct symbol *sym;
+	int skip = 0;
+	int ret;
+
+	/* lock names will be replaced to task name later */
+	if (show_thread_stats)
+		return -1;
+
+	thread = machine__findnew_thread(&session->machines.host,
+					 -1, sample->pid);
+	if (thread == NULL)
+		return -1;
+
+	/* use caller function name from the callchain */
+	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
+					NULL, NULL, CONTENTION_STACK_DEPTH);
+	if (ret != 0) {
+		thread__put(thread);
+		return -1;
+	}
+
+	callchain_cursor_commit(cursor);
+	thread__put(thread);
+
+	while (true) {
+		struct callchain_cursor_node *node;
+
+		node = callchain_cursor_current(cursor);
+		if (node == NULL)
+			break;
+
+		/* skip first few entries - for lock functions */
+		if (++skip <= CONTENTION_STACK_SKIP)
+			goto next;
+
+		sym = node->ms.sym;
+		if (sym && !is_lock_function(node->ip)) {
+			struct map *map = node->ms.map;
+			u64 offset;
+
+			offset = map->map_ip(map, node->ip) - sym->start;
+
+			if (offset)
+				scnprintf(buf, size, "%s+%#lx", sym->name, offset);
+			else
+				strlcpy(buf, sym->name, size);
+			return 0;
+		}
+
+next:
+		callchain_cursor_advance(cursor);
+	}
+	return -1;
+}
+
 static int report_lock_contention_begin_event(struct evsel *evsel,
 					      struct perf_sample *sample)
 {
@@ -850,9 +981,18 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	if (show_thread_stats)
 		addr = sample->tid;
 
-	ls = lock_stat_findnew(addr, "No name");
-	if (!ls)
-		return -ENOMEM;
+	ls = lock_stat_find(addr);
+	if (!ls) {
+		char buf[128];
+		const char *caller = buf;
+
+		if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
+			caller = "Unknown";
+
+		ls = lock_stat_findnew(addr, caller);
+		if (!ls)
+			return -ENOMEM;
+	}
 
 	ts = thread_stat_findnew(sample->tid);
 	if (!ts)
@@ -1233,6 +1373,7 @@ static int __cmd_report(bool display_info)
 	struct perf_tool eops = {
 		.sample		 = process_sample_event,
 		.comm		 = perf_event__process_comm,
+		.mmap		 = perf_event__process_mmap,
 		.namespaces	 = perf_event__process_namespaces,
 		.ordered_events	 = true,
 	};
@@ -1248,6 +1389,8 @@ static int __cmd_report(bool display_info)
 		return PTR_ERR(session);
 	}
 
+	/* for lock function check */
+	symbol_conf.sort_by_name = true;
 	symbol__init(&session->header.env);
 
 	if (!perf_session__has_traces(session, "lock record"))
@@ -1292,8 +1435,12 @@ static int __cmd_record(int argc, const char **argv)
 	const char *record_args[] = {
 		"record", "-R", "-m", "1024", "-c", "1", "--synth", "task",
 	};
+	const char *callgraph_args[] = {
+		"--call-graph", "fp," __stringify(CONTENTION_STACK_DEPTH),
+	};
 	unsigned int rec_argc, i, j, ret;
 	unsigned int nr_tracepoints;
+	unsigned int nr_callgraph_args = 0;
 	const char **rec_argv;
 	bool has_lock_stat = true;
 
@@ -1318,8 +1465,10 @@ static int __cmd_record(int argc, const char **argv)
 		}
 	}
 
+	nr_callgraph_args = ARRAY_SIZE(callgraph_args);
+
 setup_args:
-	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
+	rec_argc = ARRAY_SIZE(record_args) + nr_callgraph_args + argc - 1;
 
 	if (has_lock_stat)
 		nr_tracepoints = ARRAY_SIZE(lock_tracepoints);
@@ -1351,6 +1500,9 @@ static int __cmd_record(int argc, const char **argv)
 		rec_argv[i++] = ev_name;
 	}
 
+	for (j = 0; j < nr_callgraph_args; j++, i++)
+		rec_argv[i] = callgraph_args[j];
+
 	for (j = 1; j < (unsigned int)argc; j++, i++)
 		rec_argv[i] = argv[j];
 
-- 
2.36.1.476.g0c4daa206d-goog

