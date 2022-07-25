Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194ED58040A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiGYSbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiGYSbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:31:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8AD13F4B;
        Mon, 25 Jul 2022 11:31:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g12so11214997pfb.3;
        Mon, 25 Jul 2022 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sswaviHsJHwIPu6wABFq54k6OlpMYZVGoIdbjO5HKfc=;
        b=AW+mTe6B4JzObgYQa1hOgJmgfqETRDnwBcbgmP81GuXtdyMGeuiar81edRVvTNfWre
         QXJt3dLqY7jkP3lRr4DMcxslL9pQ8HvSsKsK37P0saU5KDMCUgAhMXyDXlQcz4ZMWAFZ
         bFP+qVHoxAN7u5iqzJrKC/JWIXT8nagPnW2JHHkOrFOwyAaJVGMJNHvRhSPnlKDxe6zm
         y3qF31c6K7vWVpVDZE/s+6BpclP4k744icsAeaGWx9v6qW42D3Q31vlwUPnBdIHz/5Gh
         Zci6W73/aHUK+8ORaUXASOSYZJMVSjyaGr1euXYcV9NGz/UQPF/vTdP/HJkoLc98O7uo
         vDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sswaviHsJHwIPu6wABFq54k6OlpMYZVGoIdbjO5HKfc=;
        b=SIH/2TAMco56O1TwmQlQ8rcR51pCOWRqSJNTnznF1/KKgFuNotSsKHO7bT0ym6BvhN
         9csqKB2zPIv0DUjs9KzFpG1kpXkmufPkaiNZ/n+XeFYiH/Iuc271+t+mFjVJTxWgWGtg
         XmIct/Zy7eMZUjiopnVYGpWuvIXrx0KHsgbYuKFUPAF5Eyxq2sQ+C9P4mxfwaSVh0OgO
         Z5lDTx3WHdcWlRdteTM8/Wfjm+54Sqh7CLeSXk9epk79yPt4uhdI7PQTR8HC0EJNEiFs
         enVVJrLC4AYaKMCA+F+33svEmrc3Qy2+0wuZSrQtZAjysEKpi3A3/hL3NRJozJdqUo9M
         lMOQ==
X-Gm-Message-State: AJIora+w0dZ2Xgk60o8yHhFeiCsqAYyVBnCbkG1hd1FF3d2rkB+XFSqS
        ERlAqyh2YK5CmMeGwZctclI=
X-Google-Smtp-Source: AGRyM1sJTV4ownLdzuVSTgPBQOZ4SS0xIEEqwwDyJGS+Kt3DFmffqg/BGcF+20F4jsQSt/X611QmOQ==
X-Received: by 2002:a05:6a00:852:b0:528:c669:ad65 with SMTP id q18-20020a056a00085200b00528c669ad65mr13762491pfk.75.1658773891502;
        Mon, 25 Jul 2022 11:31:31 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1010:2c4d:e9cd:d086:4d46])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016be9d498d0sm9740556plh.211.2022.07.25.11.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:31:31 -0700 (PDT)
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
Subject: [PATCH 3/5] perf lock: Add 'contention' subcommand
Date:   Mon, 25 Jul 2022 11:31:22 -0700
Message-Id: <20220725183124.368304-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
In-Reply-To: <20220725183124.368304-1-namhyung@kernel.org>
References: <20220725183124.368304-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'perf lock contention' processes the lock contention events and
displays the result like perf lock report.  Right now, there's not
much difference between the two but the lock contention specific
features will come soon.

  $ perf lock contention
   contended   total wait     max wait     avg wait         type   caller

         238      1.41 ms     29.20 us      5.94 us     spinlock   update_blocked_averages+0x4c
           1    902.08 us    902.08 us    902.08 us      rwsem:R   do_user_addr_fault+0x1dd
          81    330.30 us     17.24 us      4.08 us     spinlock   _nohz_idle_balance+0x172
           2     89.54 us     61.26 us     44.77 us     spinlock   do_anonymous_page+0x16d
          24     78.36 us     12.27 us      3.27 us        mutex   pipe_read+0x56
           2     71.58 us     59.56 us     35.79 us     spinlock   __handle_mm_fault+0x6aa
           6     25.68 us      6.89 us      4.28 us     spinlock   do_idle+0x28d
           1     18.46 us     18.46 us     18.46 us      rtmutex   exec_fw_cmd+0x21b
           3     15.25 us      6.26 us      5.08 us     spinlock   tick_do_update_jiffies64+0x2c

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |   4 +-
 tools/perf/builtin-lock.c              | 212 ++++++++++++++++++++++++-
 2 files changed, 214 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 4b8568f0c53b..da0bcbc676a3 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -8,7 +8,7 @@ perf-lock - Analyze lock events
 SYNOPSIS
 --------
 [verse]
-'perf lock' {record|report|script|info}
+'perf lock' {record|report|script|info|contention}
 
 DESCRIPTION
 -----------
@@ -27,6 +27,8 @@ and statistics with this 'perf lock' command.
   'perf lock info' shows metadata like threads or addresses
   of lock instances.
 
+  'perf lock contention' shows contention statistics.
+
 COMMON OPTIONS
 --------------
 
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b4e7a6e5c54e..64f635273660 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -145,6 +145,18 @@ static enum {
  */
 #define CONTENTION_STACK_SKIP  3
 
+/*
+ * flags for lock:contention_begin
+ * Imported from include/trace/events/lock.h.
+ */
+#define LCB_F_SPIN	(1U << 0)
+#define LCB_F_READ	(1U << 1)
+#define LCB_F_WRITE	(1U << 2)
+#define LCB_F_RT	(1U << 3)
+#define LCB_F_PERCPU	(1U << 4)
+#define LCB_F_MUTEX	(1U << 5)
+
+
 static u64 sched_text_start;
 static u64 sched_text_end;
 static u64 lock_text_start;
@@ -1022,6 +1034,51 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 	return -1;
 }
 
+static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
+{
+	struct callchain_cursor *cursor = &callchain_cursor;
+	struct thread *thread;
+	u64 hash = 0;
+	int skip = 0;
+	int ret;
+
+	thread = machine__findnew_thread(&session->machines.host,
+					 -1, sample->pid);
+	if (thread == NULL)
+		return -1;
+
+	/* use caller function name from the callchain */
+	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
+					NULL, NULL, CONTENTION_STACK_DEPTH);
+	thread__put(thread);
+
+	if (ret != 0)
+		return -1;
+
+	callchain_cursor_commit(cursor);
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
+		if (node->ms.sym && is_lock_function(node->ip))
+			goto next;
+
+		hash ^= hash_long((unsigned long)node->ip, 64);
+
+next:
+		callchain_cursor_advance(cursor);
+	}
+	return hash;
+}
+
 static int report_lock_contention_begin_event(struct evsel *evsel,
 					      struct perf_sample *sample)
 {
@@ -1039,6 +1096,8 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		key = sample->tid;
 		break;
 	case LOCK_AGGR_CALLER:
+		key = callchain_id(evsel, sample);
+		break;
 	default:
 		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
 		return -EINVAL;
@@ -1120,6 +1179,8 @@ static int report_lock_contention_end_event(struct evsel *evsel,
 		key = sample->tid;
 		break;
 	case LOCK_AGGR_CALLER:
+		key = callchain_id(evsel, sample);
+		break;
 	default:
 		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
 		return -EINVAL;
@@ -1183,6 +1244,12 @@ static struct trace_lock_handler report_lock_ops  = {
 	.contention_end_event	= report_lock_contention_end_event,
 };
 
+static struct trace_lock_handler contention_lock_ops  = {
+	.contention_begin_event	= report_lock_contention_begin_event,
+	.contention_end_event	= report_lock_contention_end_event,
+};
+
+
 static struct trace_lock_handler *trace_handler;
 
 static int evsel__process_lock_acquire(struct evsel *evsel, struct perf_sample *sample)
@@ -1428,6 +1495,67 @@ static void sort_result(void)
 	}
 }
 
+static const char *get_type_str(struct lock_stat *st)
+{
+	static const struct {
+		unsigned int flags;
+		const char *name;
+	} table[] = {
+		{ 0,				"semaphore" },
+		{ LCB_F_SPIN,			"spinlock" },
+		{ LCB_F_SPIN | LCB_F_READ,	"rwlock:R" },
+		{ LCB_F_SPIN | LCB_F_WRITE,	"rwlock:W"},
+		{ LCB_F_READ,			"rwsem:R" },
+		{ LCB_F_WRITE,			"rwsem:W" },
+		{ LCB_F_RT,			"rtmutex" },
+		{ LCB_F_RT | LCB_F_READ,	"rwlock-rt:R" },
+		{ LCB_F_RT | LCB_F_WRITE,	"rwlock-rt:W"},
+		{ LCB_F_PERCPU | LCB_F_READ,	"pcpu-sem:R" },
+		{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W" },
+		{ LCB_F_MUTEX,			"mutex" },
+		{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex" },
+	};
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(table); i++) {
+		if (table[i].flags == st->flags)
+			return table[i].name;
+	}
+	return "unknown";
+}
+
+static void sort_contention_result(void)
+{
+	sort_result();
+}
+
+static void print_contention_result(void)
+{
+	struct lock_stat *st;
+	struct lock_key *key;
+	int bad, total;
+
+	list_for_each_entry(key, &lock_keys, list)
+		pr_info("%*s ", key->len, key->header);
+
+	pr_info("  %10s   %s\n\n", "type", "caller");
+
+	bad = total = 0;
+	while ((st = pop_from_result())) {
+		total++;
+		if (st->broken)
+			bad++;
+
+		list_for_each_entry(key, &lock_keys, list) {
+			key->print(key, st);
+			pr_info(" ");
+		}
+
+		pr_info("  %10s   %s\n", get_type_str(st), st->name);
+	}
+
+	print_bad_events(bad, total);
+}
+
 static const struct evsel_str_handler lock_tracepoints[] = {
 	{ "lock:lock_acquire",	 evsel__process_lock_acquire,   }, /* CONFIG_LOCKDEP */
 	{ "lock:lock_acquired",	 evsel__process_lock_acquired,  }, /* CONFIG_LOCKDEP, CONFIG_LOCK_STAT */
@@ -1508,6 +1636,68 @@ static int __cmd_report(bool display_info)
 	return err;
 }
 
+static int __cmd_contention(void)
+{
+	int err = -EINVAL;
+	struct perf_tool eops = {
+		.sample		 = process_sample_event,
+		.comm		 = perf_event__process_comm,
+		.mmap		 = perf_event__process_mmap,
+		.ordered_events	 = true,
+	};
+	struct perf_data data = {
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = force,
+	};
+
+	session = perf_session__new(&data, &eops);
+	if (IS_ERR(session)) {
+		pr_err("Initializing perf session failed\n");
+		return PTR_ERR(session);
+	}
+
+	/* for lock function check */
+	symbol_conf.sort_by_name = true;
+	symbol__init(&session->header.env);
+
+	if (!perf_session__has_traces(session, "lock record"))
+		goto out_delete;
+
+	if (!evlist__find_evsel_by_str(session->evlist, "lock:contention_begin")) {
+		pr_err("lock contention evsel not found\n");
+		goto out_delete;
+	}
+
+	if (perf_session__set_tracepoints_handlers(session, contention_tracepoints)) {
+		pr_err("Initializing perf session tracepoint handlers failed\n");
+		goto out_delete;
+	}
+
+	if (setup_output_field("contended,wait_total,wait_max,avg_wait"))
+		goto out_delete;
+
+	sort_key = "wait_total";
+	if (select_key())
+		goto out_delete;
+
+	aggr_mode = LOCK_AGGR_CALLER;
+
+	err = perf_session__process_events(session);
+	if (err)
+		goto out_delete;
+
+	setup_pager();
+
+	sort_contention_result();
+	print_contention_result();
+
+out_delete:
+	perf_session__delete(session);
+	return err;
+}
+
+
 static int __cmd_record(int argc, const char **argv)
 {
 	const char *record_args[] = {
@@ -1626,12 +1816,17 @@ int cmd_lock(int argc, const char **argv)
 	OPT_PARENT(lock_options)
 	};
 
+	const struct option contention_options[] = {
+	OPT_PARENT(lock_options)
+	};
+
 	const char * const info_usage[] = {
 		"perf lock info [<options>]",
 		NULL
 	};
 	const char *const lock_subcommands[] = { "record", "report", "script",
-						 "info", NULL };
+						 "info", "contention",
+						 "contention", NULL };
 	const char *lock_usage[] = {
 		NULL,
 		NULL
@@ -1640,6 +1835,10 @@ int cmd_lock(int argc, const char **argv)
 		"perf lock report [<options>]",
 		NULL
 	};
+	const char * const contention_usage[] = {
+		"perf lock contention [<options>]",
+		NULL
+	};
 	unsigned int i;
 	int rc = 0;
 
@@ -1675,6 +1874,17 @@ int cmd_lock(int argc, const char **argv)
 		/* recycling report_lock_ops */
 		trace_handler = &report_lock_ops;
 		rc = __cmd_report(true);
+	} else if (strlen(argv[0]) > 2 && strstarts("contention", argv[0])) {
+		trace_handler = &contention_lock_ops;
+		if (argc) {
+			argc = parse_options(argc, argv, contention_options,
+					     contention_usage, 0);
+			if (argc) {
+				usage_with_options(contention_usage,
+						   contention_options);
+			}
+		}
+		rc = __cmd_contention();
 	} else {
 		usage_with_options(lock_usage, lock_options);
 	}
-- 
2.37.1.359.gd136c6c3e2-goog

