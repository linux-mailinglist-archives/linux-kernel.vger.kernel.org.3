Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31E54E6D67
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347930AbiCYEpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358279AbiCYEpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:45:09 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C969487;
        Thu, 24 Mar 2022 21:43:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="55449200"
X-IronPort-AV: E=Sophos;i="5.90,209,1643641200"; 
   d="scan'208";a="55449200"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Mar 2022 13:43:20 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2E8F5CA247;
        Fri, 25 Mar 2022 13:43:19 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5F0AF141AB;
        Fri, 25 Mar 2022 13:43:18 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 28763403F02E6;
        Fri, 25 Mar 2022 13:43:18 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [RFC PATCH v2 4/7] libperf: Introduce perf_{evsel, evlist}__open_opt with extensible struct opts
Date:   Fri, 25 Mar 2022 13:38:26 +0900
Message-Id: <20220325043829.224045-5-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce perf_{evsel, evlist}__open_opt with extensible structure opts.
The mechanism of the extensible structure opts imitates
tools/lib/bpf/libbpf.h. This allows the user to set the open_flags
specified in perf_event_open and a signal handler to receive overflow
notifications for sampling events.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt |  14 +++
 tools/lib/perf/evlist.c                  |  20 +++++
 tools/lib/perf/evsel.c                   | 105 +++++++++++++++++++++++
 tools/lib/perf/include/perf/evlist.h     |   3 +
 tools/lib/perf/include/perf/evsel.h      |  26 ++++++
 tools/lib/perf/internal.h                |  44 ++++++++++
 tools/lib/perf/libperf.map               |   2 +
 7 files changed, 214 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index ae55e62fc4ce..700c1ce15159 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -131,6 +131,20 @@ SYNOPSIS
           };
   };
 
+  struct perf_evsel_open_opts {
+          /* size of this struct, for forward/backward compatibility */
+          size_t sz;
+
+          unsigned long open_flags;       /* perf_event_open flags */
+          int flags;                      /* fcntl flags */
+          unsigned int signal;
+          int owner_type;
+          struct sigaction *sig;
+  };
+  #define perf_evsel_open_opts__last_field sig
+
+  #define LIBPERF_OPTS(TYPE, NAME, ...)
+
   struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
   void perf_evsel__delete(struct perf_evsel *evsel);
   int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 9a770bfdc804..6f136905d249 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -666,3 +666,23 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 		__perf_evlist__set_leader(&evlist->entries, first);
 	}
 }
+
+int perf_evlist__open_opts(struct perf_evlist *evlist,
+			   struct perf_evsel_open_opts *opts)
+{
+	struct perf_evsel *evsel;
+	int err;
+
+	perf_evlist__for_each_entry(evlist, evsel) {
+		err = perf_evsel__open_opts(evsel, evsel->cpus,
+					    evsel->threads, opts);
+		if (err < 0)
+			goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	perf_evlist__close(evlist);
+	return err;
+}
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index b17842581dea..db9b7274feb5 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -16,8 +19,12 @@
 #include <internal/lib.h>
 #include <linux/string.h>
 #include <sys/ioctl.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <sys/types.h>
 #include <sys/mman.h>
 #include <asm/bug.h>
+#include "internal.h"
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
@@ -511,3 +518,101 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 	if (pscaled)
 		*pscaled = scaled;
 }
+
+static int perf_evsel__run_fcntl(struct perf_evsel *evsel,
+				 unsigned int cmd, unsigned long arg,
+				 int cpu_map_idx)
+{
+	int thread;
+
+	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+		int err;
+		int *fd = FD(evsel, cpu_map_idx, thread);
+
+		if (!fd || *fd < 0)
+			return -1;
+
+		err = fcntl(*fd, cmd, arg);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int perf_evsel__set_signal_handler(struct perf_evsel *evsel,
+					  struct perf_evsel_open_opts *opts)
+{
+	unsigned int flags;
+	unsigned int signal;
+	struct f_owner_ex owner;
+	struct sigaction *sig;
+	int cpu_map_idx;
+	int err = 0;
+
+	flags = OPTS_GET(opts, flags, (O_RDWR | O_NONBLOCK | O_ASYNC));
+	signal = OPTS_GET(opts, signal, SIGIO);
+	owner.type = OPTS_GET(opts, owner_type, F_OWNER_PID);
+	sig = OPTS_GET(opts, sig, NULL);
+
+	if (flags == 0 && signal == 0 && !owner.type == 0 && sig == 0)
+		return err;
+
+	err = sigaction(signal, sig, NULL);
+	if (err)
+		return err;
+
+	switch (owner.type) {
+	case F_OWNER_PID:
+		owner.pid = getpid();
+		break;
+	case F_OWNER_TID:
+		owner.pid = syscall(SYS_gettid);
+		break;
+	case F_OWNER_PGRP:
+	default:
+		return -1;
+	}
+
+	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->fd); cpu_map_idx++) {
+		err = perf_evsel__run_fcntl(evsel, F_SETFL, flags, cpu_map_idx);
+		if (err)
+			return err;
+
+		err = perf_evsel__run_fcntl(evsel, F_SETSIG, signal, cpu_map_idx);
+		if (err)
+			return err;
+
+		err = perf_evsel__run_fcntl(evsel, F_SETOWN_EX,
+					    (unsigned long)&owner, cpu_map_idx);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+int perf_evsel__open_opts(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
+			  struct perf_thread_map *threads,
+			  struct perf_evsel_open_opts *opts)
+{
+	int err = 0;
+
+	if (!OPTS_VALID(opts, perf_evsel_open_opts)) {
+		err = -EINVAL;
+		return err;
+	}
+
+	evsel->open_flags = OPTS_GET(opts, open_flags, 0);
+
+	err = perf_evsel__open(evsel, cpus, threads);
+	if (err)
+		return err;
+
+	err = perf_evsel__set_signal_handler(evsel, opts);
+	if (err)
+		return err;
+
+	return err;
+}
diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
index 9ca399d49bb4..6eff1e9b3481 100644
--- a/tools/lib/perf/include/perf/evlist.h
+++ b/tools/lib/perf/include/perf/evlist.h
@@ -9,6 +9,7 @@ struct perf_evlist;
 struct perf_evsel;
 struct perf_cpu_map;
 struct perf_thread_map;
+struct perf_evsel_open_opts;
 
 LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
@@ -47,4 +48,6 @@ LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
 	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
 
 LIBPERF_API void perf_evlist__set_leader(struct perf_evlist *evlist);
+LIBPERF_API int perf_evlist__open_opts(struct perf_evlist *evlist,
+				       struct perf_evsel_open_opts *opts);
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 360ced734add..ecf30bc6303f 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -5,6 +5,7 @@
 #include <stdint.h>
 #include <perf/core.h>
 #include <stdbool.h>
+#include <signal.h>
 #include <linux/types.h>
 
 struct perf_evsel;
@@ -23,6 +24,27 @@ struct perf_counts_values {
 	};
 };
 
+struct perf_evsel_open_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+
+	unsigned long open_flags;	/* perf_event_open flags */
+	int flags;			/* fcntl flags */
+	unsigned int signal;
+	int owner_type;
+	struct sigaction *sig;
+};
+#define perf_evsel_open_opts__last_field sig
+
+#define LIBPERF_OPTS(TYPE, NAME, ...)			\
+	struct TYPE NAME = ({				\
+		memset(&NAME, 0, sizeof(struct TYPE));	\
+		(struct TYPE) {				\
+			.sz = sizeof(struct TYPE),	\
+			__VA_ARGS__			\
+		};					\
+	})
+
 LIBPERF_API struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
 LIBPERF_API void perf_evsel__delete(struct perf_evsel *evsel);
 LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
@@ -48,5 +70,9 @@ LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
 LIBPERF_API void perf_counts_values__scale(struct perf_counts_values *count,
 					   bool scale, __s8 *pscaled);
+LIBPERF_API int perf_evsel__open_opts(struct perf_evsel *evsel,
+				      struct perf_cpu_map *cpus,
+				      struct perf_thread_map *threads,
+				      struct perf_evsel_open_opts *opts);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/lib/perf/internal.h b/tools/lib/perf/internal.h
index 2c27e158de6b..637bf6793c26 100644
--- a/tools/lib/perf/internal.h
+++ b/tools/lib/perf/internal.h
@@ -20,4 +20,48 @@ do {                            \
 #define pr_debug2(fmt, ...)     __pr(LIBPERF_DEBUG2, fmt, ##__VA_ARGS__)
 #define pr_debug3(fmt, ...)     __pr(LIBPERF_DEBUG3, fmt, ##__VA_ARGS__)
 
+static inline bool libperf_is_mem_zeroed(const char *p, ssize_t len)
+{
+	while (len > 0) {
+		if (*p)
+			return false;
+		p++;
+		len--;
+	}
+	return true;
+}
+
+static inline bool libperf_validate_opts(const char *opts,
+					 size_t opts_sz, size_t user_sz,
+					 const char *type_name)
+{
+	if (user_sz < sizeof(size_t)) {
+		pr_warning("%s size (%zu) is too small\n", type_name, user_sz);
+		return false;
+	}
+	if (!libperf_is_mem_zeroed(opts + opts_sz, (ssize_t)user_sz - opts_sz)) {
+		pr_warning("%s has non-zero extra bytes\n", type_name);
+		return false;
+	}
+	return true;
+}
+
+# define offsetofend(TYPE, FIELD) \
+	(offsetof(TYPE, FIELD) + sizeof(((TYPE *)0)->FIELD))
+
+#define OPTS_VALID(opts, type)							\
+	(!(opts) || libperf_validate_opts((const char *)opts,			\
+					  offsetofend(struct type,		\
+						      type##__last_field),	\
+						(opts)->sz, #type))
+#define OPTS_HAS(opts, field) \
+	((opts) && opts->sz >= offsetofend(typeof(*(opts)), field))
+#define OPTS_GET(opts, field, fallback_value) \
+	(OPTS_HAS(opts, field) ? (opts)->field : fallback_value)
+#define OPTS_SET(opts, field, value)		\
+	do {					\
+		if (OPTS_HAS(opts, field))	\
+			(opts)->field = value;	\
+	} while (0)
+
 #endif /* __LIBPERF_INTERNAL_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index ab0f44e9bb57..534614fbbb26 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -24,6 +24,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__enable;
 		perf_evsel__disable;
 		perf_evsel__open;
+		perf_evsel__open_opts;
 		perf_evsel__close;
 		perf_evsel__mmap;
 		perf_evsel__munmap;
@@ -39,6 +40,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__open;
+		perf_evlist__open_opts;
 		perf_evlist__close;
 		perf_evlist__enable;
 		perf_evlist__disable;
-- 
2.25.1

