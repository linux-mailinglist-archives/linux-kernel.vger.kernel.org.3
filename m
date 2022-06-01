Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E15C539DA5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350101AbiFAG7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350068AbiFAG64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:58:56 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08F2BB1F;
        Tue, 31 May 2022 23:58:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so3212767pjb.1;
        Tue, 31 May 2022 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1KjHGRCb/gwEYrdUgbK9V5JpdX1zhq09kZ/uUwYFWDo=;
        b=e4rZEv+qVKlgVHLRHoVI0W2nN2xwzY9sq++plrmNvKGX2bzSmIrY2RFs5hJmIyummw
         xDb6XjGhYkphZdO7VfbR1hlfRVQgcjrUSLJbiRrmFgwv2JdVZFfGhkSAMMFVcl6K7NVy
         UngelsP1WPInrx/Jt1iQo7oGupnWOawqo48UFw7A0wkHbQ+IqVP7Y3KPPw0bX/p1Fbu1
         IJmXRuUWrukog8E6+EU5HnoNsUlRJELl7NPVqRQ9qGwegkWSB3Pk9Yk4HsmLNfTf0nXb
         /11iTDoypwMGZOIGsOBI2x+hP1SF2817mZv8Sdf0f7o3nlbqwRw3j+LpdzPdHh+cjXzz
         7ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1KjHGRCb/gwEYrdUgbK9V5JpdX1zhq09kZ/uUwYFWDo=;
        b=t+oTbu0KSGFDKIRHER6CdJ0Tt8z0F0BRR5MgApgNOHScNbiBCtMhwrHZ6T3w0YHR/x
         rqNW+0aEzZUP59BIbeUZpZDE45UoFF+7i/wcnfPZYQX9/IEQ82kRPq+jtLrvOYCH4z+N
         8zqwd4gbkAtApSx2NaDmOaj8u4colZ+6Oodw8HU7o8omhPrKaw5JtGBxpXwS5Iu/mYYH
         wlXTIl0mL0Is0bYW5ujx/UVwtQoQfJLOwLOodJKpQ/lnBlDo9BYRaZmJ//SH53pDgx/o
         zNh+f4PQCU03rdjW3nXue4LtQsvVqMo/geD2cV37bdWrv2vQVNrekRuI5nxaguJsqYY6
         WE6g==
X-Gm-Message-State: AOAM5307PM5Yt1Kdk8+PExqj8Bu2xelXLrhejQ2AXmK4/ST971U0hDxg
        MLTc0NDhRX+ZeE9FLTenrEA=
X-Google-Smtp-Source: ABdhPJwUHW0GMofOL8QRaZlHc/siRsCjjL62ZNz/Lq0p2eVYBEJUuoU9AFwGGDOWnIddMD55XMGSgQ==
X-Received: by 2002:a17:902:7c0c:b0:161:ef0f:9da8 with SMTP id x12-20020a1709027c0c00b00161ef0f9da8mr28156048pll.147.1654066735036;
        Tue, 31 May 2022 23:58:55 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:82d7:adf7:b62d:6020])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a5a0a00b001cd4989febcsm3207271pjd.8.2022.05.31.23.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 23:58:54 -0700 (PDT)
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
Subject: [PATCH 5/5] perf lock: Look up callchain for the contended locks
Date:   Tue, 31 May 2022 23:58:46 -0700
Message-Id: <20220601065846.456965-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601065846.456965-1-namhyung@kernel.org>
References: <20220601065846.456965-1-namhyung@kernel.org>
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

  $ perf lock report -F acquired,contended,avg_wait

                  Name   acquired  contended   avg wait (ns)

   update_blocked_a...         40         40            3611
   kernfs_fop_open+...          5          5            3636
    _nohz_idle_balance          3          3            2650
   tick_do_update_j...          1          1            6041
    ep_scan_ready_list          1          1            3930
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 165 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 82cbf0f2e4cd..46a5b3b50f0b 100644
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
 
@@ -120,6 +123,17 @@ static struct rb_root		thread_stats;
 static bool combine_locks;
 static bool show_thread_stats;
 
+/*
+ * CONTENTION_STACK_DEPTH
+ * Number of stack trace entries to find callers
+ */
+#define CONTENTION_STACK_DEPTH  8
+
+static u64 sched_text_start;
+static u64 sched_text_end;
+static u64 lock_text_start;
+static u64 lock_text_end;
+
 static struct thread_stat *thread_stat_find(u32 tid)
 {
 	struct rb_node *node;
@@ -451,6 +465,18 @@ static struct lock_stat *pop_from_result(void)
 	return container_of(node, struct lock_stat, rb);
 }
 
+static struct lock_stat *lock_stat_find(u64 addr)
+{
+	struct hlist_head *entry = lockhashentry(addr);
+	struct lock_stat *ret;
+
+	hlist_for_each_entry(ret, entry, hash_entry) {
+		if (ret->addr == addr)
+			return ret;
+	}
+	return NULL;
+}
+
 static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
 {
 	struct hlist_head *entry = lockhashentry(addr);
@@ -789,6 +815,116 @@ static int report_lock_release_event(struct evsel *evsel,
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
+		/* skip first 3 entries - for lock functions */
+		if (++skip <= 3)
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
@@ -800,9 +936,18 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
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
@@ -1176,6 +1321,7 @@ static int __cmd_report(bool display_info)
 	struct perf_tool eops = {
 		.sample		 = process_sample_event,
 		.comm		 = perf_event__process_comm,
+		.mmap		 = perf_event__process_mmap,
 		.namespaces	 = perf_event__process_namespaces,
 		.ordered_events	 = true,
 	};
@@ -1191,6 +1337,8 @@ static int __cmd_report(bool display_info)
 		return PTR_ERR(session);
 	}
 
+	/* for lock function check */
+	symbol_conf.sort_by_name = true;
 	symbol__init(&session->header.env);
 
 	if (!perf_session__has_traces(session, "lock record"))
@@ -1235,8 +1383,12 @@ static int __cmd_record(int argc, const char **argv)
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
 
@@ -1261,8 +1413,10 @@ static int __cmd_record(int argc, const char **argv)
 		}
 	}
 
+	nr_callgraph_args = ARRAY_SIZE(callgraph_args);
+
 setup_args:
-	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
+	rec_argc = ARRAY_SIZE(record_args) + nr_callgraph_args + argc - 1;
 
 	if (has_lock_stat)
 		nr_tracepoints = ARRAY_SIZE(lock_tracepoints);
@@ -1294,6 +1448,9 @@ static int __cmd_record(int argc, const char **argv)
 		rec_argv[i++] = ev_name;
 	}
 
+	for (j = 0; j < nr_callgraph_args; j++, i++)
+		rec_argv[i] = callgraph_args[j];
+
 	for (j = 1; j < (unsigned int)argc; j++, i++)
 		rec_argv[i] = argv[j];
 
-- 
2.36.1.255.ge46751e96f-goog

