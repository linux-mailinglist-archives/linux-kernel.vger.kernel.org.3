Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100E546282A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhK2XWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhK2XWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:22:01 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E923DC061714
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:42 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q17so13402346plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXuDnqaE26saSYKzB4MR1Nb8R6meYT6kIX8i4sJ2AM4=;
        b=JMU5kxg6mgXw56wYjlB3v3MknzDUzGc7SGHhRdAQklXqHrQYFc5MEzLQ372NtNcTSw
         cpSvv25Hf2wNpfMgO7Nrq4wO+zT/SQQXuiYpTW/uG4nTXQ2mNC2utFUfobDsz3YvqHxY
         UY7EFV6y1e/4mGTC5cAcj5TfPVsHnlhxRO/207f0YVMRlTOVP9TAvJ94xWEsqZYrBZHH
         oGbC3zuth7oNILpXu2YQSYVTUqrow/WYnxoL/lzShBoHOSaQ+4uOwIVyPKFIc2TvTbnh
         CYORZ16T4O2mt9QdgMA/VSS0yxVyJUXj2twl+AHgRjk1XuIv9Bbt78kg8/rAyEXdWEXA
         4vVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zXuDnqaE26saSYKzB4MR1Nb8R6meYT6kIX8i4sJ2AM4=;
        b=6IbmzavakjJSKeQATIkXQuRKU0zPNoKOoaMWMFhAtcvs3DWJFn+0KQ7N4BJ8k4stuI
         i2rhC9zDGqts/AYQNpO0FxLEkB3kiG2WM8oeCB3SXwKexas45mgNrbznpRt1Lu6V3IOV
         JcpTUroORDcxCPQKr1TtoRwr6jn/NNhFif5RaxBxUW5aQ0mepVj+4jyY4nqkWZ4BiM6H
         xfehiJYyiK2d4Og6P2qVIsSmn9CMoZjDmRYSd88uogwK2UXZVOV2Um5z/k/7yNSHW8K4
         6TsSQHcqQMlut/OzOsj7SHcT7lrGHNvUz+AK8U32nUIw/V5nZofCxNjQVE8uowUQmRXY
         NoGw==
X-Gm-Message-State: AOAM530fyK4OIkdGQ+9CdrZ5lQr6iNEpGDHGVQ7XV1fPaX1HLA+eRXpF
        53qygz89PZjjzFjihljlmwc=
X-Google-Smtp-Source: ABdhPJx+KPBOj0Rp2LSFnVb6CWw8vjUTNeGsBNuAhRvq7eFU1ry8UisD+lXL3C5sIF3QHK2fFaX3/A==
X-Received: by 2002:a17:903:18d:b0:142:8ab:d11f with SMTP id z13-20020a170903018d00b0014208abd11fmr63596367plg.47.1638227922383;
        Mon, 29 Nov 2021 15:18:42 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:7f54:1f52:ae81:8c78])
        by smtp.gmail.com with ESMTPSA id j7sm18334762pfu.164.2021.11.29.15.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:18:41 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 4/5] perf ftrace: Add -b/--use-bpf option for latency subcommand
Date:   Mon, 29 Nov 2021 15:18:29 -0800
Message-Id: <20211129231830.1117781-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211129231830.1117781-1-namhyung@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -b/--use-bpf option is to use BPF to get latency info of kernel
functions.  It'd have better performance impact and I observed that
latency of same function is smaller than before when using BPF.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.perf                    |   2 +-
 tools/perf/builtin-ftrace.c                 | 156 +++++++++++---------
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_ftrace.c                | 113 ++++++++++++++
 tools/perf/util/bpf_skel/func_latency.bpf.c |  92 ++++++++++++
 tools/perf/util/ftrace.h                    |  81 ++++++++++
 6 files changed, 378 insertions(+), 67 deletions(-)
 create mode 100644 tools/perf/util/bpf_ftrace.c
 create mode 100644 tools/perf/util/bpf_skel/func_latency.bpf.c
 create mode 100644 tools/perf/util/ftrace.h

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 80522bcfafe0..a861b92ac6f9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1041,7 +1041,7 @@ SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
 SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
 SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
 SKELETONS += $(SKEL_OUT)/bperf_leader.skel.h $(SKEL_OUT)/bperf_follower.skel.h
-SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h
+SKELETONS += $(SKEL_OUT)/bperf_cgroup.skel.h $(SKEL_OUT)/func_latency.skel.h
 
 $(SKEL_TMP_OUT) $(LIBBPF_OUTPUT):
 	$(Q)$(MKDIR) -p $@
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 8fd3c9c44c69..cde1e87032a1 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -30,36 +30,12 @@
 #include "strfilter.h"
 #include "util/cap.h"
 #include "util/config.h"
+#include "util/ftrace.h"
 #include "util/units.h"
 #include "util/parse-sublevel-options.h"
 
 #define DEFAULT_TRACER  "function_graph"
 
-struct perf_ftrace {
-	struct evlist		*evlist;
-	struct target		target;
-	const char		*tracer;
-	struct list_head	filters;
-	struct list_head	notrace;
-	struct list_head	graph_funcs;
-	struct list_head	nograph_funcs;
-	int			graph_depth;
-	unsigned long		percpu_buffer_size;
-	bool			inherit;
-	int			func_stack_trace;
-	int			func_irq_info;
-	int			graph_nosleep_time;
-	int			graph_noirqs;
-	int			graph_verbose;
-	int			graph_thresh;
-	unsigned int		initial_delay;
-};
-
-struct filter_entry {
-	struct list_head	list;
-	char			name[];
-};
-
 static volatile int workload_exec_errno;
 static bool done;
 
@@ -704,8 +680,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
-#define NUM_BUCKET  22  /* 20 + 2 (for outliers in both direction) */
-
 static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf)
 {
 	char *p, *q;
@@ -816,69 +790,116 @@ static void display_histogram(int buckets[])
 
 }
 
-static int __cmd_latency(struct perf_ftrace *ftrace)
+static int prepare_func_latency(struct perf_ftrace *ftrace)
 {
 	char *trace_file;
-	int trace_fd;
-	char buf[4096];
-	char line[256];
-	struct pollfd pollfd = {
-		.events = POLLIN,
-	};
-	int buckets[NUM_BUCKET] = { };
+	int fd;
 
-	if (!(perf_cap__capable(CAP_PERFMON) ||
-	      perf_cap__capable(CAP_SYS_ADMIN))) {
-		pr_err("ftrace only works for %s!\n",
-#ifdef HAVE_LIBCAP_SUPPORT
-		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
-#else
-		"root"
-#endif
-		);
-		return -1;
-	}
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_prepare_bpf(ftrace);
 
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
-		goto out;
+		return -1;
 	}
 
 	/* reset ftrace buffer */
 	if (write_tracing_file("trace", "0") < 0)
-		goto out;
+		return -1;
 
 	if (set_tracing_options(ftrace) < 0)
-		goto out_reset;
+		return -1;
 
 	/* force to use the function_graph tracer to track duration */
 	if (write_tracing_file("current_tracer", "function_graph") < 0) {
 		pr_err("failed to set current_tracer to function_graph\n");
-		goto out_reset;
+		return -1;
 	}
 
 	trace_file = get_tracing_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+		return -1;
 	}
 
-	trace_fd = open(trace_file, O_RDONLY);
+	fd = open(trace_file, O_RDONLY);
+	if (fd < 0)
+		pr_err("failed to open trace_pipe\n");
 
 	put_tracing_file(trace_file);
+	return fd;
+}
 
-	if (trace_fd < 0) {
-		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+static int start_func_latency(struct perf_ftrace *ftrace)
+{
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_start_bpf(ftrace);
+
+	if (write_tracing_file("tracing_on", "1") < 0) {
+		pr_err("can't enable tracing\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int stop_func_latency(struct perf_ftrace *ftrace)
+{
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_stop_bpf(ftrace);
+
+	write_tracing_file("tracing_on", "0");
+	return 0;
+}
+
+static int read_func_latency(struct perf_ftrace *ftrace, int buckets[])
+{
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_read_bpf(ftrace, buckets);
+
+	return 0;
+}
+
+static int cleanup_func_latency(struct perf_ftrace *ftrace)
+{
+	if (ftrace->target.use_bpf)
+		return perf_ftrace__latency_cleanup_bpf(ftrace);
+
+	reset_tracing_files(ftrace);
+	return 0;
+}
+
+static int __cmd_latency(struct perf_ftrace *ftrace)
+{
+	int trace_fd;
+	char buf[4096];
+	char line[256];
+	struct pollfd pollfd = {
+		.events = POLLIN,
+	};
+	int buckets[NUM_BUCKET] = { };
+
+	if (!(perf_cap__capable(CAP_PERFMON) ||
+	      perf_cap__capable(CAP_SYS_ADMIN))) {
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
+#else
+		"root"
+#endif
+		);
+		return -1;
 	}
 
+	trace_fd = prepare_func_latency(ftrace);
+	if (trace_fd < 0)
+		goto out;
+
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
 	pollfd.fd = trace_fd;
 
-	if (write_tracing_file("tracing_on", "1") < 0) {
-		pr_err("can't enable tracing\n");
-		goto out_close_fd;
-	}
+	if (start_func_latency(ftrace) < 0)
+		goto out;
 
 	evlist__start_workload(ftrace->evlist);
 
@@ -896,29 +917,30 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 		}
 	}
 
-	write_tracing_file("tracing_on", "0");
+	stop_func_latency(ftrace);
 
 	if (workload_exec_errno) {
 		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
 		pr_err("workload failed: %s\n", emsg);
-		goto out_close_fd;
+		goto out;
 	}
 
 	/* read remaining buffer contents */
-	while (true) {
+	while (!ftrace->target.use_bpf) {
 		int n = read(trace_fd, buf, sizeof(buf) - 1);
 		if (n <= 0)
 			break;
 		make_histogram(buckets, buf, n, line);
 	}
 
+	read_func_latency(ftrace, buckets);
+
 	display_histogram(buckets);
 
-out_close_fd:
-	close(trace_fd);
-out_reset:
-	reset_tracing_files(ftrace);
 out:
+	close(trace_fd);
+	cleanup_func_latency(ftrace);
+
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
@@ -1144,6 +1166,8 @@ int cmd_ftrace(int argc, const char **argv)
 	const struct option latency_options[] = {
 	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
 		     "Show latency of given function", parse_filter_func),
+	OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
+		    "Use BPF to measure function latency"),
 	OPT_PARENT(common_options),
 	};
 	const struct option *options = ftrace_options;
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2e5bfbb69960..294b12430d73 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -144,6 +144,7 @@ perf-$(CONFIG_LIBBPF) += bpf-loader.o
 perf-$(CONFIG_LIBBPF) += bpf_map.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
+perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
 perf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
 perf-$(CONFIG_LIBELF) += symbol-elf.o
 perf-$(CONFIG_LIBELF) += probe-file.o
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
new file mode 100644
index 000000000000..1975a6fe73c9
--- /dev/null
+++ b/tools/perf/util/bpf_ftrace.c
@@ -0,0 +1,113 @@
+#include <stdio.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+#include <linux/err.h>
+
+#include "util/ftrace.h"
+#include "util/debug.h"
+#include "util/bpf_counter.h"
+
+#include "util/bpf_skel/func_latency.skel.h"
+
+static struct func_latency_bpf *skel;
+
+int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
+{
+	int fd, err;
+	struct filter_entry *func;
+	struct bpf_link *begin_link, *end_link;
+
+	if (!list_is_singular(&ftrace->filters)) {
+		pr_err("ERROR: %s target function(s).\n",
+		       list_empty(&ftrace->filters) ? "No" : "Too many");
+		return -1;
+	}
+
+	func = list_first_entry(&ftrace->filters, struct filter_entry, list);
+
+	skel = func_latency_bpf__open();
+	if (!skel) {
+		pr_err("Failed to open func latency skeleton\n");
+		return -1;
+	}
+
+	set_max_rlimit();
+
+	err = func_latency_bpf__load(skel);
+	if (err) {
+		pr_err("Failed to load func latency skeleton\n");
+		goto out;
+	}
+
+	begin_link = bpf_program__attach_kprobe(skel->progs.func_begin,
+						 false, func->name);
+	if (IS_ERR(begin_link)) {
+		pr_err("Failed to attach fentry program\n");
+		err = PTR_ERR(begin_link);
+		goto out;
+	}
+
+	end_link = bpf_program__attach_kprobe(skel->progs.func_end,
+					      true, func->name);
+	if (IS_ERR(end_link)) {
+		pr_err("Failed to attach fexit program\n");
+		err = PTR_ERR(end_link);
+		bpf_link__destroy(begin_link);
+		goto out;
+	}
+
+	/* XXX: we don't actually use this fd - just for poll() */
+	return open("/dev/null", O_RDONLY);
+
+out:
+	return err;
+}
+
+int perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	skel->bss->enabled = 1;
+	return 0;
+}
+
+int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	skel->bss->enabled = 0;
+	return 0;
+}
+
+int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
+				  int buckets[])
+{
+	int i, fd, err;
+	u32 idx;
+	u64 *hist;
+	int ncpus = cpu__max_cpu();
+
+	fd = bpf_map__fd(skel->maps.latency);
+
+	hist = calloc(ncpus, sizeof(*hist));
+	if (hist == NULL)
+		return -ENOMEM;
+
+	for (idx = 0; idx < NUM_BUCKET; idx++) {
+		err = bpf_map_lookup_elem(fd, &idx, hist);
+		if (err) {
+			buckets[idx] = 0;
+			continue;
+		}
+
+		for (i = 0; i < ncpus; i++)
+			buckets[idx] += hist[i];
+	}
+
+	free(hist);
+	return 0;
+}
+
+int perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	func_latency_bpf__destroy(skel);
+	return 0;
+}
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
new file mode 100644
index 000000000000..d7d31cfeabf8
--- /dev/null
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2021 Google
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define NUM_BUCKET  22
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, 10000);
+} functime SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} cpu_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} task_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u64));
+	__uint(max_entries, NUM_BUCKET);
+} latency SEC(".maps");
+
+
+int enabled = 0;
+
+SEC("kprobe/func")
+int BPF_PROG(func_begin)
+{
+	__u64 key, now;
+
+	if (!enabled)
+		return 0;
+
+	key = bpf_get_current_pid_tgid();
+	now = bpf_ktime_get_ns();
+
+	// overwrite timestamp for nested functions
+	bpf_map_update_elem(&functime, &key, &now, BPF_ANY);
+	return 0;
+}
+
+SEC("kretprobe/func")
+int BPF_PROG(func_end)
+{
+	__u64 tid;
+	__u64 *start;
+
+	if (!enabled)
+		return 0;
+
+	tid = bpf_get_current_pid_tgid();
+
+	start = bpf_map_lookup_elem(&functime, &tid);
+	if (start) {
+		__s64 delta = bpf_ktime_get_ns() - *start;
+		__u32 key;
+		__u64 *hist;
+
+		bpf_map_delete_elem(&functime, &tid);
+
+		if (delta < 0)
+			return 0;
+
+		// calculate index using delta in usec
+		for (key = 0; key < (NUM_BUCKET - 1); key++) {
+			if (delta < ((1000UL) << key))
+				break;
+		}
+
+		hist = bpf_map_lookup_elem(&latency, &key);
+		if (!hist)
+			return 0;
+
+		*hist += 1;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
new file mode 100644
index 000000000000..887f68a185f7
--- /dev/null
+++ b/tools/perf/util/ftrace.h
@@ -0,0 +1,81 @@
+#ifndef __PERF_FTRACE_H__
+#define __PERF_FTRACE_H__
+
+#include <linux/list.h>
+
+#include "target.h"
+
+struct evlist;
+
+struct perf_ftrace {
+	struct evlist		*evlist;
+	struct target		target;
+	const char		*tracer;
+	struct list_head	filters;
+	struct list_head	notrace;
+	struct list_head	graph_funcs;
+	struct list_head	nograph_funcs;
+	unsigned long		percpu_buffer_size;
+	bool			inherit;
+	int			graph_depth;
+	int			func_stack_trace;
+	int			func_irq_info;
+	int			graph_nosleep_time;
+	int			graph_noirqs;
+	int			graph_verbose;
+	int			graph_thresh;
+	unsigned int		initial_delay;
+};
+
+struct filter_entry {
+	struct list_head	list;
+	char			name[];
+};
+
+#define NUM_BUCKET  22  /* 20 + 2 (for outliers in both direction) */
+
+#ifdef HAVE_BPF_SKEL
+
+int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace);
+int perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace);
+int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace);
+int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
+				  int buckets[]);
+int perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace);
+
+#else  /* !HAVE_BPF_SKEL */
+
+static inline int
+perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	return -1;
+}
+
+static inline int
+perf_ftrace__latency_start_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	return -1;
+}
+
+static inline int
+perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	return -1;
+}
+
+static inline int
+perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
+			      int buckets[] __maybe_unused)
+{
+	return -1;
+}
+
+static inline int
+perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
+{
+	return -1;
+}
+
+#endif  /* HAVE_BPF_SKEL */
+
+#endif  /* __PERF_FTRACE_H__ */
-- 
2.34.0.rc2.393.gf8c9666880-goog

