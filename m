Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85B85855E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbiG2UIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbiG2UIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:08:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B397968E;
        Fri, 29 Jul 2022 13:08:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id y1so5531320pja.4;
        Fri, 29 Jul 2022 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=uheR008sA/fPjTwDB5DT1bXOxyIZdFvVc3Lgo5GRou8=;
        b=HUSPBzVjmbh+59rbVJ99llkksrMqKgjkNkrEC8FaJ//V2iGqbWhnEz+bF59Lsenagx
         gCtwQtXeN5n5A7c7J5d760a/ZWupHNm9iTzhqQd2FSim0ukXzOlBif+TmL3ZaEiR2D55
         2rmSZT/Z+sDy++weCJPCFJHS52Ga26VdRra6enbQZ7sPDg1/+pyOLFyAN+E1rTzVE5pr
         W6YbQyn0DC9HN2/mnERTryW38KGD4tnGnje6VvSi0/EmhVv4yjz+XzJhszxca2rPhcGK
         q0Wzdexekba853gh/osa7kvYoFJxjySMl/NFW2x8GWvPNRlHI/PW7qG9+hw/J58M5jJV
         7GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=uheR008sA/fPjTwDB5DT1bXOxyIZdFvVc3Lgo5GRou8=;
        b=FCHKDGlGTYJcQHLboEFvAArRQho1EOq95LMTQ6v+reIXK3yMshjN48uHSvydpvwObB
         h8DZrPy5XPJX3yayTVJfIGXshywYvGTg/BfKqwbHMDbkafoKJ++yFV2hIeFh5SXMeogN
         F/gtgytIzGMLKcK/nUQVBRVbeFZyKewPshTF1SlzenPkDw81nLrifLO1ydUejQninEFc
         gyjZ9AodLBCH1FI2rcuIeQJG+s/0i4IAuWzJhQ9cb83vV5EbdX0yiaqva7ZYAY+3p9SD
         b9lPJaJIuIaFjiZY1S9VdGWWslarp5Mkrqykfq4iS58mWiLrQ53iX6TPuym68uKLjVcm
         ezpg==
X-Gm-Message-State: ACgBeo3XZMP3hqLVmbTPOwc6bWspRpC4vXBeI5/sB8QL4yQ+te9CqxEg
        lWPwFKVB3k4GI+QpH/ffoVE=
X-Google-Smtp-Source: AA6agR6PJBCe2nRGNg6fscS13vaDJ6vXc8QnrX5TBOxr8UutM2XJ7RGE8Ae10D60OondmJb/B+qkUw==
X-Received: by 2002:a17:903:41cf:b0:16d:68b4:fcc1 with SMTP id u15-20020a17090341cf00b0016d68b4fcc1mr5406378ple.21.1659125281889;
        Fri, 29 Jul 2022 13:08:01 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1010:c01e:2ed5:25ca:3acb])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b0016be14a776asm3929823ple.286.2022.07.29.13.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 13:08:01 -0700 (PDT)
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
        Davidlohr Bueso <dave@stgolabs.net>,
        Stephane Eranian <eranian@google.com>,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 2/3] perf lock: Use BPF for lock contention analysis
Date:   Fri, 29 Jul 2022 13:07:55 -0700
Message-Id: <20220729200756.666106-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220729200756.666106-1-namhyung@kernel.org>
References: <20220729200756.666106-1-namhyung@kernel.org>
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

Add -b/--use-bpf option to use BPF to collect lock contention stats.
For simplicity it now runs system-wide and requires C-c to stop.
Upcoming changes will add the usual filtering.

  $ sudo perf lock con -b
  ^C
   contended   total wait     max wait     avg wait         type   caller

          42    192.67 us     13.64 us      4.59 us     spinlock   queue_work_on+0x20
          23     85.54 us     10.28 us      3.72 us     spinlock   worker_thread+0x14a
           6     13.92 us      6.51 us      2.32 us        mutex   kernfs_iop_permission+0x30
           3     11.59 us     10.04 us      3.86 us        mutex   kernfs_dop_revalidate+0x3c
           1      7.52 us      7.52 us      7.52 us     spinlock   kthread+0x115
           1      7.24 us      7.24 us      7.24 us     rwlock:W   sys_epoll_wait+0x148
           2      7.08 us      3.99 us      3.54 us     spinlock   delayed_work_timer_fn+0x1b
           1      6.41 us      6.41 us      6.41 us     spinlock   idle_balance+0xa06
           2      2.50 us      1.83 us      1.25 us        mutex   kernfs_iop_lookup+0x2f
           1      1.71 us      1.71 us      1.71 us        mutex   kernfs_iop_getattr+0x2c

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt        |   5 +
 tools/perf/Makefile.perf                      |   2 +-
 tools/perf/builtin-lock.c                     | 164 ++++++------------
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf_lock_contention.c         | 132 ++++++++++++++
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 131 ++++++++++++++
 tools/perf/util/lock-contention.h             | 133 ++++++++++++++
 7 files changed, 453 insertions(+), 115 deletions(-)
 create mode 100644 tools/perf/util/bpf_lock_contention.c
 create mode 100644 tools/perf/util/bpf_skel/lock_contention.bpf.c
 create mode 100644 tools/perf/util/lock-contention.h

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 8f4e34f924d5..b88bb72c77d4 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -123,6 +123,11 @@ CONTENTION OPTIONS
 --threads::
 	Show per-thread lock contention stat
 
+-b::
+--use-bpf::
+	Use BPF program to collect lock contention stats instead of
+	using the input data.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d2083a247f73..5053b563bf9c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1028,7 +1028,7 @@ SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
 SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
-SKELETONS += $(SKEL_OUT)/off_cpu.skel.h
+SKELETONS += $(SKEL_OUT)/off_cpu.skel.h $(SKEL_OUT)/lock_contention.skel.h
 SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
 
 $(SKEL_TMP_OUT) $(LIBBPF_OUTPUT):
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 10b854315b7a..29fb6de7fb7d 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -10,6 +10,7 @@
 #include "util/thread.h"
 #include "util/header.h"
 #include "util/callchain.h"
+#include "util/lock-contention.h"
 
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
@@ -47,84 +48,11 @@ static struct hlist_head lockhash_table[LOCKHASH_SIZE];
 #define __lockhashfn(key)	hash_long((unsigned long)key, LOCKHASH_BITS)
 #define lockhashentry(key)	(lockhash_table + __lockhashfn((key)))
 
-struct lock_stat {
-	struct hlist_node	hash_entry;
-	struct rb_node		rb;		/* used for sorting */
-
-	u64			addr;		/* address of lockdep_map, used as ID */
-	char			*name;		/* for strcpy(), we cannot use const */
-
-	unsigned int		nr_acquire;
-	unsigned int		nr_acquired;
-	unsigned int		nr_contended;
-	unsigned int		nr_release;
-
-	union {
-		unsigned int	nr_readlock;
-		unsigned int	flags;
-	};
-	unsigned int		nr_trylock;
-
-	/* these times are in nano sec. */
-	u64                     avg_wait_time;
-	u64			wait_time_total;
-	u64			wait_time_min;
-	u64			wait_time_max;
-
-	int			broken; /* flag of blacklist */
-	int			combined;
-};
-
-/*
- * States of lock_seq_stat
- *
- * UNINITIALIZED is required for detecting first event of acquire.
- * As the nature of lock events, there is no guarantee
- * that the first event for the locks are acquire,
- * it can be acquired, contended or release.
- */
-#define SEQ_STATE_UNINITIALIZED      0	       /* initial state */
-#define SEQ_STATE_RELEASED	1
-#define SEQ_STATE_ACQUIRING	2
-#define SEQ_STATE_ACQUIRED	3
-#define SEQ_STATE_READ_ACQUIRED	4
-#define SEQ_STATE_CONTENDED	5
-
-/*
- * MAX_LOCK_DEPTH
- * Imported from include/linux/sched.h.
- * Should this be synchronized?
- */
-#define MAX_LOCK_DEPTH 48
-
-/*
- * struct lock_seq_stat:
- * Place to put on state of one lock sequence
- * 1) acquire -> acquired -> release
- * 2) acquire -> contended -> acquired -> release
- * 3) acquire (with read or try) -> release
- * 4) Are there other patterns?
- */
-struct lock_seq_stat {
-	struct list_head        list;
-	int			state;
-	u64			prev_event_time;
-	u64                     addr;
-
-	int                     read_count;
-};
-
-struct thread_stat {
-	struct rb_node		rb;
-
-	u32                     tid;
-	struct list_head        seq_list;
-};
-
 static struct rb_root		thread_stats;
 
 static bool combine_locks;
 static bool show_thread_stats;
+static bool use_bpf;
 
 static enum {
 	LOCK_AGGR_ADDR,
@@ -132,31 +60,6 @@ static enum {
 	LOCK_AGGR_CALLER,
 } aggr_mode = LOCK_AGGR_ADDR;
 
-/*
- * CONTENTION_STACK_DEPTH
- * Number of stack trace entries to find callers
- */
-#define CONTENTION_STACK_DEPTH  8
-
-/*
- * CONTENTION_STACK_SKIP
- * Number of stack trace entries to skip when finding callers.
- * The first few entries belong to the locking implementation itself.
- */
-#define CONTENTION_STACK_SKIP  3
-
-/*
- * flags for lock:contention_begin
- * Imported from include/trace/events/lock.h.
- */
-#define LCB_F_SPIN	(1U << 0)
-#define LCB_F_READ	(1U << 1)
-#define LCB_F_WRITE	(1U << 2)
-#define LCB_F_RT	(1U << 3)
-#define LCB_F_PERCPU	(1U << 4)
-#define LCB_F_MUTEX	(1U << 5)
-
-
 static u64 sched_text_start;
 static u64 sched_text_end;
 static u64 lock_text_start;
@@ -947,7 +850,7 @@ static int report_lock_release_event(struct evsel *evsel,
 	return 0;
 }
 
-static bool is_lock_function(struct machine *machine, u64 addr)
+bool is_lock_function(struct machine *machine, u64 addr)
 {
 	if (!sched_text_start) {
 		struct map *kmap;
@@ -1671,6 +1574,10 @@ static int __cmd_report(bool display_info)
 	return err;
 }
 
+static void sighandler(int sig __maybe_unused)
+{
+}
+
 static int __cmd_contention(void)
 {
 	int err = -EINVAL;
@@ -1686,7 +1593,7 @@ static int __cmd_contention(void)
 		.force = force,
 	};
 
-	session = perf_session__new(&data, &eops);
+	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
 		return PTR_ERR(session);
@@ -1696,17 +1603,30 @@ static int __cmd_contention(void)
 	symbol_conf.sort_by_name = true;
 	symbol__init(&session->header.env);
 
-	if (!perf_session__has_traces(session, "lock record"))
-		goto out_delete;
+	if (use_bpf) {
+		if (lock_contention_prepare() < 0) {
+			pr_err("lock contention BPF setup failed\n");
+			return -1;
+		}
 
-	if (!evlist__find_evsel_by_str(session->evlist, "lock:contention_begin")) {
-		pr_err("lock contention evsel not found\n");
-		goto out_delete;
-	}
+		signal(SIGINT, sighandler);
+		signal(SIGCHLD, sighandler);
+		signal(SIGTERM, sighandler);
+	} else {
+		if (!perf_session__has_traces(session, "lock record"))
+			goto out_delete;
 
-	if (perf_session__set_tracepoints_handlers(session, contention_tracepoints)) {
-		pr_err("Initializing perf session tracepoint handlers failed\n");
-		goto out_delete;
+		if (!evlist__find_evsel_by_str(session->evlist,
+					       "lock:contention_begin")) {
+			pr_err("lock contention evsel not found\n");
+			goto out_delete;
+		}
+
+		if (perf_session__set_tracepoints_handlers(session,
+						contention_tracepoints)) {
+			pr_err("Initializing perf session tracepoint handlers failed\n");
+			goto out_delete;
+		}
 	}
 
 	if (setup_output_field(true, output_fields))
@@ -1720,9 +1640,19 @@ static int __cmd_contention(void)
 	else
 		aggr_mode = LOCK_AGGR_CALLER;
 
-	err = perf_session__process_events(session);
-	if (err)
-		goto out_delete;
+	if (use_bpf) {
+		lock_contention_start();
+
+		/* wait for signal */
+		pause();
+
+		lock_contention_stop();
+		lock_contention_read(&session->machines.host, &lockhash_table[0]);
+	} else {
+		err = perf_session__process_events(session);
+		if (err)
+			goto out_delete;
+	}
 
 	setup_pager();
 
@@ -1730,6 +1660,7 @@ static int __cmd_contention(void)
 	print_contention_result();
 
 out_delete:
+	lock_contention_finish();
 	perf_session__delete(session);
 	return err;
 }
@@ -1853,13 +1784,14 @@ int cmd_lock(int argc, const char **argv)
 	OPT_PARENT(lock_options)
 	};
 
-	const struct option contention_options[] = {
+	struct option contention_options[] = {
 	OPT_STRING('k', "key", &sort_key, "wait_total",
 		    "key for sorting (contended / wait_total / wait_max / wait_min / avg_wait)"),
 	OPT_STRING('F', "field", &output_fields, "contended,wait_total,wait_max,avg_wait",
 		    "output fields (contended / wait_total / wait_max / wait_min / avg_wait)"),
 	OPT_BOOLEAN('t', "threads", &show_thread_stats,
 		    "show per-thread lock stats"),
+	OPT_BOOLEAN('b', "use-bpf", &use_bpf, "use BPF program to collect lock contention stats"),
 	OPT_PARENT(lock_options)
 	};
 
@@ -1922,6 +1854,10 @@ int cmd_lock(int argc, const char **argv)
 		sort_key = "wait_total";
 		output_fields = "contended,wait_total,wait_max,avg_wait";
 
+#ifndef HAVE_BPF_SKEL
+		set_option_nobuild(contention_options, 'b', "use-bpf",
+				   "no BUILD_BPF_SKEL=1", false);
+#endif
 		if (argc) {
 			argc = parse_options(argc, argv, contention_options,
 					     contention_usage, 0);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 66ad30cf65ec..86fcd0a614fe 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -149,6 +149,7 @@ perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork.o
+perf-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o
 perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
 perf-$(CONFIG_LIBELF) += symbol-elf.o
 perf-$(CONFIG_LIBELF) += probe-file.o
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
new file mode 100644
index 000000000000..8eb33e6f5029
--- /dev/null
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/debug.h"
+#include "util/machine.h"
+#include "util/map.h"
+#include "util/symbol.h"
+#include "util/lock-contention.h"
+#include <linux/zalloc.h>
+#include <bpf/bpf.h>
+
+#include "bpf_skel/lock_contention.skel.h"
+
+static struct lock_contention_bpf *skel;
+
+/* should be same as bpf_skel/lock_contention.bpf.c */
+struct lock_contention_key {
+	u32 stack_id;
+};
+
+struct lock_contention_data {
+	u64 total_time;
+	u64 min_time;
+	u64 max_time;
+	u32 count;
+	u32 flags;
+};
+
+int lock_contention_prepare(void)
+{
+	skel = lock_contention_bpf__open();
+	if (!skel) {
+		pr_err("Failed to open lock-contention BPF skeleton\n");
+		return -1;
+	}
+
+	if (lock_contention_bpf__load(skel) < 0) {
+		pr_err("Failed to load lock-contention BPF skeleton\n");
+		return -1;
+	}
+
+	lock_contention_bpf__attach(skel);
+	return 0;
+}
+
+int lock_contention_start(void)
+{
+	skel->bss->enabled = 1;
+	return 0;
+}
+
+int lock_contention_stop(void)
+{
+	skel->bss->enabled = 0;
+	return 0;
+}
+
+int lock_contention_read(struct machine *machine, struct hlist_head *head)
+{
+	int fd, stack;
+	u32 prev_key, key;
+	struct lock_contention_data data;
+	struct lock_stat *st;
+	u64 stack_trace[CONTENTION_STACK_DEPTH];
+
+	fd = bpf_map__fd(skel->maps.lock_stat);
+	stack = bpf_map__fd(skel->maps.stacks);
+
+	prev_key = 0;
+	while (!bpf_map_get_next_key(fd, &prev_key, &key)) {
+		struct map *kmap;
+		struct symbol *sym;
+		int idx;
+
+		bpf_map_lookup_elem(fd, &key, &data);
+		st = zalloc(sizeof(*st));
+		if (st == NULL)
+			return -1;
+
+		st->nr_contended = data.count;
+		st->wait_time_total = data.total_time;
+		st->wait_time_max = data.max_time;
+		st->wait_time_min = data.min_time;
+
+		if (data.count)
+			st->avg_wait_time = data.total_time / data.count;
+
+		st->flags = data.flags;
+
+		bpf_map_lookup_elem(stack, &key, stack_trace);
+
+		/* skip BPF + lock internal functions */
+		idx = CONTENTION_STACK_SKIP;
+		while (is_lock_function(machine, stack_trace[idx]) &&
+		       idx < CONTENTION_STACK_DEPTH - 1)
+			idx++;
+
+		st->addr = stack_trace[idx];
+		sym = machine__find_kernel_symbol(machine, st->addr, &kmap);
+
+		if (sym) {
+			unsigned long offset;
+			int ret = 0;
+
+			offset = kmap->map_ip(kmap, st->addr) - sym->start;
+
+			if (offset)
+				ret = asprintf(&st->name, "%s+%#lx", sym->name, offset);
+			else
+				st->name = strdup(sym->name);
+
+			if (ret < 0 || st->name == NULL)
+				return -1;
+		} else if (asprintf(&st->name, "%#lx", (unsigned long)st->addr) < 0) {
+			free(st);
+			return -1;
+		}
+
+		hlist_add_head(&st->hash_entry, head);
+		prev_key = key;
+	}
+
+	return 0;
+}
+
+int lock_contention_finish(void)
+{
+	if (skel) {
+		skel->bss->enabled = 0;
+		lock_contention_bpf__destroy(skel);
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
new file mode 100644
index 000000000000..5d1c7641223f
--- /dev/null
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2022 Google
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+/* maximum stack trace depth */
+#define MAX_STACKS   8
+
+/* default buffer size */
+#define MAX_ENTRIES  10240
+
+struct contention_key {
+	__u32 stack_id;
+};
+
+struct contention_data {
+	__u64 total_time;
+	__u64 min_time;
+	__u64 max_time;
+	__u32 count;
+	__u32 flags;
+};
+
+struct tstamp_data {
+	__u64 timestamp;
+	__u64 lock;
+	__u32 flags;
+	__u32 stack_id;
+};
+
+/* callstack storage  */
+struct {
+	__uint(type, BPF_MAP_TYPE_STACK_TRACE);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, MAX_STACKS * sizeof(__u64));
+	__uint(max_entries, MAX_ENTRIES);
+} stacks SEC(".maps");
+
+/* maintain timestamp at the beginning of contention */
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, struct tstamp_data);
+} tstamp SEC(".maps");
+
+/* actual lock contention statistics */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(struct contention_key));
+	__uint(value_size, sizeof(struct contention_data));
+	__uint(max_entries, MAX_ENTRIES);
+} lock_stat SEC(".maps");
+
+/* control flags */
+int enabled;
+
+SEC("tp_btf/contention_begin")
+int contention_begin(u64 *ctx)
+{
+	struct task_struct *curr;
+	struct tstamp_data *pelem;
+
+	if (!enabled)
+		return 0;
+
+	curr = bpf_get_current_task_btf();
+	pelem = bpf_task_storage_get(&tstamp, curr, NULL,
+				     BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!pelem || pelem->lock)
+		return 0;
+
+	pelem->timestamp = bpf_ktime_get_ns();
+	pelem->lock = (__u64)ctx[0];
+	pelem->flags = (__u32)ctx[1];
+	pelem->stack_id = bpf_get_stackid(ctx, &stacks, BPF_F_FAST_STACK_CMP);
+
+	return 0;
+}
+
+SEC("tp_btf/contention_end")
+int contention_end(u64 *ctx)
+{
+	struct task_struct *curr;
+	struct tstamp_data *pelem;
+	struct contention_key key;
+	struct contention_data *data;
+	__u64 duration;
+
+	if (!enabled)
+		return 0;
+
+	curr = bpf_get_current_task_btf();
+	pelem = bpf_task_storage_get(&tstamp, curr, NULL, 0);
+	if (!pelem || pelem->lock != ctx[0])
+		return 0;
+
+	duration = bpf_ktime_get_ns() - pelem->timestamp;
+
+	key.stack_id = pelem->stack_id;
+	data = bpf_map_lookup_elem(&lock_stat, &key);
+	if (!data) {
+		struct contention_data first = {
+			.total_time = duration,
+			.max_time = duration,
+			.min_time = duration,
+			.count = 1,
+			.flags = pelem->flags,
+		};
+
+		bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
+		pelem->lock = 0;
+		return 0;
+	}
+
+	__sync_fetch_and_add(&data->total_time, duration);
+	__sync_fetch_and_add(&data->count, 1);
+
+	/* FIXME: need atomic operations */
+	if (data->max_time < duration)
+		data->max_time = duration;
+	if (data->min_time > duration)
+		data->min_time = duration;
+
+	pelem->lock = 0;
+	return 0;
+}
+
+char LICENSE[] SEC("license") = "Dual BSD/GPL";
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
new file mode 100644
index 000000000000..c92db4a47d8d
--- /dev/null
+++ b/tools/perf/util/lock-contention.h
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef PERF_LOCK_CONTENTION_H
+#define PERF_LOCK_CONTENTION_H
+
+#include <linux/list.h>
+#include <linux/rbtree.h>
+
+struct lock_stat {
+	struct hlist_node	hash_entry;
+	struct rb_node		rb;		/* used for sorting */
+
+	u64			addr;		/* address of lockdep_map, used as ID */
+	char			*name;		/* for strcpy(), we cannot use const */
+
+	unsigned int		nr_acquire;
+	unsigned int		nr_acquired;
+	unsigned int		nr_contended;
+	unsigned int		nr_release;
+
+	union {
+		unsigned int	nr_readlock;
+		unsigned int	flags;
+	};
+	unsigned int		nr_trylock;
+
+	/* these times are in nano sec. */
+	u64                     avg_wait_time;
+	u64			wait_time_total;
+	u64			wait_time_min;
+	u64			wait_time_max;
+
+	int			broken; /* flag of blacklist */
+	int			combined;
+};
+
+/*
+ * States of lock_seq_stat
+ *
+ * UNINITIALIZED is required for detecting first event of acquire.
+ * As the nature of lock events, there is no guarantee
+ * that the first event for the locks are acquire,
+ * it can be acquired, contended or release.
+ */
+#define SEQ_STATE_UNINITIALIZED      0	       /* initial state */
+#define SEQ_STATE_RELEASED	1
+#define SEQ_STATE_ACQUIRING	2
+#define SEQ_STATE_ACQUIRED	3
+#define SEQ_STATE_READ_ACQUIRED	4
+#define SEQ_STATE_CONTENDED	5
+
+/*
+ * MAX_LOCK_DEPTH
+ * Imported from include/linux/sched.h.
+ * Should this be synchronized?
+ */
+#define MAX_LOCK_DEPTH 48
+
+/*
+ * struct lock_seq_stat:
+ * Place to put on state of one lock sequence
+ * 1) acquire -> acquired -> release
+ * 2) acquire -> contended -> acquired -> release
+ * 3) acquire (with read or try) -> release
+ * 4) Are there other patterns?
+ */
+struct lock_seq_stat {
+	struct list_head        list;
+	int			state;
+	u64			prev_event_time;
+	u64                     addr;
+
+	int                     read_count;
+};
+
+struct thread_stat {
+	struct rb_node		rb;
+
+	u32                     tid;
+	struct list_head        seq_list;
+};
+
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
+struct machine;
+
+#ifdef HAVE_BPF_SKEL
+
+int lock_contention_prepare(void);
+int lock_contention_start(void);
+int lock_contention_stop(void);
+int lock_contention_read(struct machine *machine, struct hlist_head *head);
+int lock_contention_finish(void);
+
+#else  /* !HAVE_BPF_SKEL */
+
+static inline int lock_contention_prepare(void) { return 0; }
+static inline int lock_contention_start(void) { return 0; }
+static inline int lock_contention_stop(void) { return 0; }
+static inline int lock_contention_finish(void) { return 0; }
+
+static inline int lock_contention_read(struct machine *machine __maybe_unused,
+				       struct hlist_head *head __maybe_unused)
+{
+	return 0;
+}
+
+#endif  /* HAVE_BPF_SKEL */
+
+bool is_lock_function(struct machine *machine, u64 addr);
+
+#endif  /* PERF_LOCK_CONTENTION_H */
-- 
2.37.1.455.g008518b4e5-goog

