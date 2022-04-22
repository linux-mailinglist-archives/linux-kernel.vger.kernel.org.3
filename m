Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328CF50B44B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446164AbiDVJrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445933AbiDVJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:47:01 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2B53B56;
        Fri, 22 Apr 2022 02:44:07 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="70383055"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="70383055"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 22 Apr 2022 18:44:05 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CE94E07EA;
        Fri, 22 Apr 2022 18:44:04 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 842A7110AC6;
        Fri, 22 Apr 2022 18:44:03 +0900 (JST)
Received: from localhost.localdomain (bakeccha.fct.css.fujitsu.com [10.126.195.136])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 4414B40487FBC;
        Fri, 22 Apr 2022 18:44:03 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 2/7] libperf: Introduce perf_{evsel, evlist}__open_opt with extensible struct opts
Date:   Fri, 22 Apr 2022 18:38:28 +0900
Message-Id: <20220422093833.340873-3-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422093833.340873-1-nakamura.shun@fujitsu.com>
References: <20220422093833.340873-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce perf_{evsel, evlist}__open_opt with extensible structure opts.
The mechanism of the extensible structure opts imitates
tools/lib/bpf/libbpf.h. Currently, only open_flags is supported for the
opts structure.

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
---
 tools/lib/perf/Documentation/libperf.txt | 10 ++++++
 tools/lib/perf/evlist.c                  | 20 +++++++++++
 tools/lib/perf/evsel.c                   | 25 +++++++++++++-
 tools/lib/perf/include/perf/evlist.h     |  3 ++
 tools/lib/perf/include/perf/evsel.h      | 22 ++++++++++++
 tools/lib/perf/internal.h                | 44 ++++++++++++++++++++++++
 tools/lib/perf/libperf.map               |  2 ++
 7 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index a8f1a237931b..6ca91ca94e01 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -132,6 +132,16 @@ SYNOPSIS
           };
   };
 
+  struct perf_evsel_open_opts {
+          /* size of this struct, for forward/backward compatibility */
+          size_t sz;
+
+          unsigned long open_flags;       /* perf_event_open flags */
+  };
+  #define perf_evsel_open_opts__last_field open_flags
+
+  #define LIBPERF_OPTS(TYPE, NAME, ...)
+
   struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr);
   void perf_evsel__delete(struct perf_evsel *evsel);
   int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index a09315538a30..bf9343acb799 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -665,3 +665,23 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
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
index 210ea7c06ce8..00c0cea43b52 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -16,8 +16,12 @@
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
@@ -26,6 +30,7 @@ void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 	evsel->attr = *attr;
 	evsel->idx  = idx;
 	evsel->leader = evsel;
+	evsel->open_flags = 0;
 }
 
 struct perf_evsel *perf_evsel__new(struct perf_event_attr *attr)
@@ -158,7 +163,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
-						 cpu, group_fd, 0);
+						 cpu, group_fd, evsel->open_flags);
 
 			if (fd < 0)
 				return -errno;
@@ -454,3 +459,21 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 	if (pscaled)
 		*pscaled = scaled;
 }
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
index 2a9516b42d15..1140df4d2578 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -5,6 +5,7 @@
 #include <stdint.h>
 #include <perf/core.h>
 #include <stdbool.h>
+#include <signal.h>
 #include <linux/types.h>
 
 struct perf_evsel;
@@ -23,6 +24,23 @@ struct perf_counts_values {
 	};
 };
 
+struct perf_evsel_open_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+
+	unsigned long open_flags;	/* perf_event_open flags */
+};
+#define perf_evsel_open_opts__last_field open_flags
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
@@ -43,5 +61,9 @@ LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel
 LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
 LIBPERF_API void perf_counts_values__scale(struct perf_counts_values *count,
 					   bool scale, __s8 *pscaled);
+LIBPERF_API int perf_evsel__open_opts(struct perf_evsel *evsel,
+				      struct perf_cpu_map *cpus,
+				      struct perf_thread_map *threads,
+				      struct perf_evsel_open_opts *opts);
 
 #endif /* __LIBPERF_EVSEL_H */
diff --git a/tools/lib/perf/internal.h b/tools/lib/perf/internal.h
index 2c27e158de6b..4b91a087ed62 100644
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
+#define offsetofend(TYPE, FIELD) \
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
index 190b56ae923a..eeeb3075e092 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -25,6 +25,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__enable;
 		perf_evsel__disable;
 		perf_evsel__open;
+		perf_evsel__open_opts;
 		perf_evsel__close;
 		perf_evsel__mmap;
 		perf_evsel__munmap;
@@ -36,6 +37,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__new;
 		perf_evlist__delete;
 		perf_evlist__open;
+		perf_evlist__open_opts;
 		perf_evlist__close;
 		perf_evlist__enable;
 		perf_evlist__disable;
-- 
2.25.1

