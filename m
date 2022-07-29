Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2575C5855EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbiG2UIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbiG2UII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:08:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3677B78C;
        Fri, 29 Jul 2022 13:08:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e16so5524589pfm.11;
        Fri, 29 Jul 2022 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=ye+dSJrlwAlKlFHrRKUpFTZfgb82jZyEHkZgl3F3p7A=;
        b=p1vVPdaUl8EMKHaYvTidHorG68HqilA2WskBsqCB/M38mX19YqS55xnyowie+eD8o5
         IvHO6C8hcQ62rhaFM8Ion+Ius+D89QMFTMSsLtxr8Yso6EWDub0KwB7rsoo9Ce8KTLxe
         HHq5PNARUu6ITHIFeDfL9O8gGN0t919wWqLnY6LoQFZG+S0oVNAJUx/dES+8afo2Hdil
         1YlLOefj/rh5CcdVfJJAD9C/X1VTPGYYS285ndxon/J5SOArUHjzg+YSF39TH7hktyaI
         a9NI6Gb2iKtEgs/aDvkyR2enTR0uARluf1amawBI8gbEmfmugSy1Ed2BO8f7oFwhG7yD
         AwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=ye+dSJrlwAlKlFHrRKUpFTZfgb82jZyEHkZgl3F3p7A=;
        b=32Xw/ui/IGYSBOf5SYMxb4F9/v8ZtND3Tj6VPbNJOiInYtYefGXvltsIF9W6M9ncer
         ZpHTS7TNVTXhRL/6z9X2tUxIaL47A8GtwOaZnx+FPX2I/eeRpZCVNVdUGS9AgW7iNHcX
         kMU+hk7VWHHE5KB1+IFxoLjvFH+/PjKafHNeIQjgNNy09lKl4OifkR0Q7hBQiStx1Zkj
         5oJEMPe+pezy07qpR3yznCzavn/aBj6i+Nf59e3Miwn97XkAkd/QrCITMduICPF1H1V8
         S6GSqBa6uP62Y4BdIHW+aE2qqyQ057w6xG6iQQyPzE/1tLc1XNeMKXjNOyXx0wSttLlB
         m+rg==
X-Gm-Message-State: AJIora/IiHoPfIWRjTo/8GtIHPXQbdgHSig/bQHHgOsTQBsms4it2d+s
        EUe3s99HEcfd9jCxFu/lKvc=
X-Google-Smtp-Source: AGRyM1vhVWpYALEjCVjxj2CextGKUtmpYslqT3p+aZjPEzdziU7MAK6Z8OOWCEnmW3H+/jfzBoqZTA==
X-Received: by 2002:a63:8bc7:0:b0:41b:84d3:408 with SMTP id j190-20020a638bc7000000b0041b84d30408mr4314157pge.255.1659125283436;
        Fri, 29 Jul 2022 13:08:03 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1010:c01e:2ed5:25ca:3acb])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b0016be14a776asm3929823ple.286.2022.07.29.13.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 13:08:03 -0700 (PDT)
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
Subject: [PATCH 3/3] perf lock: Implement cpu and task filters for BPF
Date:   Fri, 29 Jul 2022 13:07:56 -0700
Message-Id: <20220729200756.666106-4-namhyung@kernel.org>
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

Add -a/--all-cpus and -C/--cpu options for cpu filtering.  Also -p/--pid
and --tid options are added for task filtering.  The short -t option is
taken for --threads already.  Tracking the command line workload is
possible as well.

  $ sudo perf lock contention -a -b sleep 1

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt        | 17 ++++++
 tools/perf/builtin-lock.c                     | 55 ++++++++++++++++---
 tools/perf/util/bpf_lock_contention.c         | 51 ++++++++++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 41 +++++++++++++-
 tools/perf/util/lock-contention.h             | 11 +++-
 5 files changed, 162 insertions(+), 13 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index b88bb72c77d4..7949d2e6891b 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -128,6 +128,23 @@ CONTENTION OPTIONS
 	Use BPF program to collect lock contention stats instead of
 	using the input data.
 
+-a::
+--all-cpus::
+        System-wide collection from all CPUs.
+
+-C::
+--cpu::
+	Collect samples only on the list of CPUs provided. Multiple CPUs can be
+	provided as a comma-separated list with no space: 0,1. Ranges of CPUs
+	are specified with -: 0-2.  Default is to monitor all CPUs.
+
+-p::
+--pid=::
+	Record events on existing process ID (comma separated list).
+
+--tid=::
+        Record events on existing thread ID (comma separated list).
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 29fb6de7fb7d..7897a33fec1b 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -9,6 +9,7 @@
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/header.h"
+#include "util/target.h"
 #include "util/callchain.h"
 #include "util/lock-contention.h"
 
@@ -38,6 +39,7 @@
 #include <linux/stringify.h>
 
 static struct perf_session *session;
+static struct target target;
 
 /* based on kernel/lockdep.c */
 #define LOCKHASH_BITS		12
@@ -1578,7 +1580,7 @@ static void sighandler(int sig __maybe_unused)
 {
 }
 
-static int __cmd_contention(void)
+static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
 	struct perf_tool eops = {
@@ -1592,6 +1594,7 @@ static int __cmd_contention(void)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
+	struct evlist *evlist = NULL;
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
@@ -1604,14 +1607,40 @@ static int __cmd_contention(void)
 	symbol__init(&session->header.env);
 
 	if (use_bpf) {
-		if (lock_contention_prepare() < 0) {
-			pr_err("lock contention BPF setup failed\n");
-			return -1;
+		err = target__validate(&target);
+		if (err) {
+			char errbuf[512];
+
+			target__strerror(&target, err, errbuf, 512);
+			pr_err("%s\n", errbuf);
+			goto out_delete;
 		}
 
 		signal(SIGINT, sighandler);
 		signal(SIGCHLD, sighandler);
 		signal(SIGTERM, sighandler);
+
+		evlist = evlist__new();
+		if (evlist == NULL) {
+			err = -ENOMEM;
+			goto out_delete;
+		}
+
+		err = evlist__create_maps(evlist, &target);
+		if (err < 0)
+			goto out_delete;
+
+		if (argc) {
+			err = evlist__prepare_workload(evlist, &target,
+						       argv, false, NULL);
+			if (err < 0)
+				goto out_delete;
+		}
+
+		if (lock_contention_prepare(evlist, &target) < 0) {
+			pr_err("lock contention BPF setup failed\n");
+			goto out_delete;
+		}
 	} else {
 		if (!perf_session__has_traces(session, "lock record"))
 			goto out_delete;
@@ -1642,6 +1671,8 @@ static int __cmd_contention(void)
 
 	if (use_bpf) {
 		lock_contention_start();
+		if (argc)
+			evlist__start_workload(evlist);
 
 		/* wait for signal */
 		pause();
@@ -1660,6 +1691,7 @@ static int __cmd_contention(void)
 	print_contention_result();
 
 out_delete:
+	evlist__delete(evlist);
 	lock_contention_finish();
 	perf_session__delete(session);
 	return err;
@@ -1792,6 +1824,15 @@ int cmd_lock(int argc, const char **argv)
 	OPT_BOOLEAN('t', "threads", &show_thread_stats,
 		    "show per-thread lock stats"),
 	OPT_BOOLEAN('b', "use-bpf", &use_bpf, "use BPF program to collect lock contention stats"),
+	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
+		    "System-wide collection from all CPUs"),
+	OPT_STRING('C', "cpu", &target.cpu_list, "cpu",
+		    "List of cpus to monitor"),
+	OPT_STRING('p', "pid", &target.pid, "pid",
+		   "Trace on existing process id"),
+	/* TODO: Add short option -t after -t/--tracer can be removed. */
+	OPT_STRING(0, "tid", &target.tid, "tid",
+		   "Trace on existing thread id (exclusive to --pid)"),
 	OPT_PARENT(lock_options)
 	};
 
@@ -1861,12 +1902,8 @@ int cmd_lock(int argc, const char **argv)
 		if (argc) {
 			argc = parse_options(argc, argv, contention_options,
 					     contention_usage, 0);
-			if (argc) {
-				usage_with_options(contention_usage,
-						   contention_options);
-			}
 		}
-		rc = __cmd_contention();
+		rc = __cmd_contention(argc, argv);
 	} else {
 		usage_with_options(lock_usage, lock_options);
 	}
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 8eb33e6f5029..16b7451b4b09 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
+#include "util/evlist.h"
 #include "util/machine.h"
 #include "util/map.h"
 #include "util/symbol.h"
+#include "util/target.h"
+#include "util/thread_map.h"
 #include "util/lock-contention.h"
 #include <linux/zalloc.h>
 #include <bpf/bpf.h>
@@ -24,19 +27,65 @@ struct lock_contention_data {
 	u32 flags;
 };
 
-int lock_contention_prepare(void)
+int lock_contention_prepare(struct evlist *evlist, struct target *target)
 {
+	int i, fd;
+	int ncpus = 1, ntasks = 1;
+
 	skel = lock_contention_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open lock-contention BPF skeleton\n");
 		return -1;
 	}
 
+	if (target__has_cpu(target))
+		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
+	if (target__has_task(target))
+		ntasks = perf_thread_map__nr(evlist->core.threads);
+
+	bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
+	bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+
 	if (lock_contention_bpf__load(skel) < 0) {
 		pr_err("Failed to load lock-contention BPF skeleton\n");
 		return -1;
 	}
 
+	if (target__has_cpu(target)) {
+		u32 cpu;
+		u8 val = 1;
+
+		skel->bss->has_cpu = 1;
+		fd = bpf_map__fd(skel->maps.cpu_filter);
+
+		for (i = 0; i < ncpus; i++) {
+			cpu = perf_cpu_map__cpu(evlist->core.user_requested_cpus, i).cpu;
+			bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
+		}
+	}
+
+	if (target__has_task(target)) {
+		u32 pid;
+		u8 val = 1;
+
+		skel->bss->has_task = 1;
+		fd = bpf_map__fd(skel->maps.task_filter);
+
+		for (i = 0; i < ntasks; i++) {
+			pid = perf_thread_map__pid(evlist->core.threads, i);
+			bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
+		}
+	}
+
+	if (target__none(target) && evlist->workload.pid > 0) {
+		u32 pid = evlist->workload.pid;
+		u8 val = 1;
+
+		skel->bss->has_task = 1;
+		fd = bpf_map__fd(skel->maps.task_filter);
+		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
+	}
+
 	lock_contention_bpf__attach(skel);
 	return 0;
 }
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 5d1c7641223f..67d46533e518 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -54,8 +54,47 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } lock_stat SEC(".maps");
 
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
 /* control flags */
 int enabled;
+int has_cpu;
+int has_task;
+
+static inline int can_record(void)
+{
+	if (has_cpu) {
+		__u32 cpu = bpf_get_smp_processor_id();
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
+		if (!ok)
+			return 0;
+	}
+
+	if (has_task) {
+		__u8 *ok;
+		__u32 pid = bpf_get_current_pid_tgid();
+
+		ok = bpf_map_lookup_elem(&task_filter, &pid);
+		if (!ok)
+			return 0;
+	}
+
+	return 1;
+}
 
 SEC("tp_btf/contention_begin")
 int contention_begin(u64 *ctx)
@@ -63,7 +102,7 @@ int contention_begin(u64 *ctx)
 	struct task_struct *curr;
 	struct tstamp_data *pelem;
 
-	if (!enabled)
+	if (!enabled || !can_record())
 		return 0;
 
 	curr = bpf_get_current_task_btf();
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index c92db4a47d8d..092c84441f9f 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -103,11 +103,13 @@ struct thread_stat {
 #define LCB_F_PERCPU	(1U << 4)
 #define LCB_F_MUTEX	(1U << 5)
 
+struct evlist;
 struct machine;
+struct target;
 
 #ifdef HAVE_BPF_SKEL
 
-int lock_contention_prepare(void);
+int lock_contention_prepare(struct evlist *evlist, struct target *target);
 int lock_contention_start(void);
 int lock_contention_stop(void);
 int lock_contention_read(struct machine *machine, struct hlist_head *head);
@@ -115,7 +117,12 @@ int lock_contention_finish(void);
 
 #else  /* !HAVE_BPF_SKEL */
 
-static inline int lock_contention_prepare(void) { return 0; }
+static inline int lock_contention_prepare(struct evlist *evlist __maybe_unused,
+					  struct target *target __maybe_unused)
+{
+	return 0;
+}
+
 static inline int lock_contention_start(void) { return 0; }
 static inline int lock_contention_stop(void) { return 0; }
 static inline int lock_contention_finish(void) { return 0; }
-- 
2.37.1.455.g008518b4e5-goog

