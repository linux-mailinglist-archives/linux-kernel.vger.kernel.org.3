Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8D484E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiAEGPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237767AbiAEGOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367B9C061353
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b144-20020a253496000000b0060bddc72114so53304608yba.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MGLr353km7jwRrh8kgsO5CrOjaWyoeIyKcGcS/0sxyY=;
        b=RDgWZjAeA2plumiyUhVCsivi3WnUNt8WSRVxJphrEB9GdHBfuoxef0l7NKp9O4y3E0
         icnPBwD4oLxTsFR/UWOv15whVsy86HDg3oc406oIVk9ZxCEnMOprcBW2sLzQgkJKYj5F
         uFPaDub2FYetYdXjX15Za9QwQ0oSU4i2m7NsmXsagBRs8N10eB41baROSdrFKoTtQFun
         1+P99os1kQ/+3KVPrYkTH9hNQFeM5z2Ivw7mFjpk86+MAuEko6uZT5CICI0mAcRVuGs7
         WmhmY1Xqnrn9jEGV3AgWHlGf+ycn+anXNwY6JUJUAHwRqQ0TmzyAll6LCsjQdJV+6yW6
         brUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MGLr353km7jwRrh8kgsO5CrOjaWyoeIyKcGcS/0sxyY=;
        b=okAeUd6AZh3Ns1bxd00skzUFOf1LEccO9hyxHcjz8WOPiO+ydWYtyOSvD6+c3WBp4L
         PYnJc4jqMfc6118Irw5XQqmMfEggm1to6CI5po++jfrddEkkKxBbo76ClwLKvLh3x3R4
         GQnaB+oBQAXowcAbZl8oxiHiYxVhufZANWGBAT5mFF82ZutigAg4QrzdIFaaUPbn+w9R
         xhxnLLt1jKb6XmdFQ52160HtwPq+GSZTtsPdUOaOLLkjpGRvuxj6XsiBZ4wsYNHhRhL4
         E0BjV1IiGbxKXzhfyMjuVwIwCg1ujIiws7cSTIQ+LYN5GKwXnm6yhVss101ZgPfLaZNI
         iG+Q==
X-Gm-Message-State: AOAM532SV8xzUmZCjzt0caEuUvbBG09Y7XsLw/9lD8+qLcDZo1yqTVlA
        GXPr1HXdmsoNQdwkQbOot60oE5KHR55b
X-Google-Smtp-Source: ABdhPJzN4X/M60SGalK6dhgqsDMiC2X5YxzB3mlci6MUAxhaS2cvq2jwxvubmfwawk6yX++LVcqPhsMJoHrn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:af8b:: with SMTP id
 g11mr54850048ybh.117.1641363287485; Tue, 04 Jan 2022 22:14:47 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:23 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-21-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 20/48] perf cpumap: Move 'has' function to libperf
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the cpu map argument const for consistency with the rest of the
API. Modify cpu_map__idx accordingly.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Documentation/libperf.txt |  1 +
 tools/lib/perf/cpumap.c                  |  7 ++++++-
 tools/lib/perf/include/internal/cpumap.h |  2 +-
 tools/lib/perf/include/perf/cpumap.h     |  1 +
 tools/lib/perf/libperf.map               |  1 +
 tools/perf/arch/arm/util/cs-etm.c        | 16 ++++++++--------
 tools/perf/builtin-sched.c               |  6 +++---
 tools/perf/tests/topology.c              |  2 +-
 tools/perf/util/cpumap.c                 |  5 -----
 tools/perf/util/cpumap.h                 |  2 --
 tools/perf/util/cputopo.c                |  2 +-
 11 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 63ae5e0195ce..faef9ba3a540 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -48,6 +48,7 @@ SYNOPSIS
   int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
   bool perf_cpu_map__empty(const struct perf_cpu_map *map);
   int perf_cpu_map__max(struct perf_cpu_map *map);
+  bool perf_cpu_map__has(const struct perf_cpu_map *map, int cpu);
 
   #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)
 --
diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index adaad3dddf6e..3c36a06771af 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -268,7 +268,7 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 	return map ? map->map[0] == -1 : true;
 }
 
-int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
+int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu)
 {
 	int low = 0, high = cpus->nr;
 
@@ -288,6 +288,11 @@ int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
 	return -1;
 }
 
+bool perf_cpu_map__has(const struct perf_cpu_map *cpus, int cpu)
+{
+	return perf_cpu_map__idx(cpus, cpu) != -1;
+}
+
 int perf_cpu_map__max(struct perf_cpu_map *map)
 {
 	// cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 4054169c12c5..71a31ed738c9 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -23,6 +23,6 @@ struct perf_cpu_map {
 #define MAX_NR_CPUS	2048
 #endif
 
-int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu);
+int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu);
 
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 7c27766ea0bf..3f1c0afa3ccd 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -20,6 +20,7 @@ LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
 LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
 LIBPERF_API int perf_cpu_map__max(struct perf_cpu_map *map);
+LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, int cpu);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 5979bf92d98f..93696affda2e 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -10,6 +10,7 @@ LIBPERF_0.0.1 {
 		perf_cpu_map__cpu;
 		perf_cpu_map__empty;
 		perf_cpu_map__max;
+		perf_cpu_map__has;
 		perf_thread_map__new_dummy;
 		perf_thread_map__set_pid;
 		perf_thread_map__comm;
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 8a3d54a86c9c..129c0272d65b 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -204,8 +204,8 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 
 	/* Set option of each CPU we have */
 	for (i = 0; i < cpu__max_cpu(); i++) {
-		if (!cpu_map__has(event_cpus, i) ||
-		    !cpu_map__has(online_cpus, i))
+		if (!perf_cpu_map__has(event_cpus, i) ||
+		    !perf_cpu_map__has(online_cpus, i))
 			continue;
 
 		if (option & BIT(ETM_OPT_CTXTID)) {
@@ -523,8 +523,8 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	/* cpu map is not empty, we have specific CPUs to work with */
 	if (!perf_cpu_map__empty(event_cpus)) {
 		for (i = 0; i < cpu__max_cpu(); i++) {
-			if (!cpu_map__has(event_cpus, i) ||
-			    !cpu_map__has(online_cpus, i))
+			if (!perf_cpu_map__has(event_cpus, i) ||
+			    !perf_cpu_map__has(online_cpus, i))
 				continue;
 
 			if (cs_etm_is_ete(itr, i))
@@ -537,7 +537,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	} else {
 		/* get configuration for all CPUs in the system */
 		for (i = 0; i < cpu__max_cpu(); i++) {
-			if (!cpu_map__has(online_cpus, i))
+			if (!perf_cpu_map__has(online_cpus, i))
 				continue;
 
 			if (cs_etm_is_ete(itr, i))
@@ -722,8 +722,8 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	} else {
 		/* Make sure all specified CPUs are online */
 		for (i = 0; i < perf_cpu_map__nr(event_cpus); i++) {
-			if (cpu_map__has(event_cpus, i) &&
-			    !cpu_map__has(online_cpus, i))
+			if (perf_cpu_map__has(event_cpus, i) &&
+			    !perf_cpu_map__has(online_cpus, i))
 				return -EINVAL;
 		}
 
@@ -744,7 +744,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	offset = CS_ETM_SNAPSHOT + 1;
 
 	for (i = 0; i < cpu__max_cpu() && offset < priv_size; i++)
-		if (cpu_map__has(cpu_map, i))
+		if (perf_cpu_map__has(cpu_map, i))
 			cs_etm_get_metadata(i, &offset, itr, info);
 
 	perf_cpu_map__put(online_cpus);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 4527f632ebe4..9da1da4749c9 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1617,10 +1617,10 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 		if (curr_thread && thread__has_color(curr_thread))
 			pid_color = COLOR_PIDS;
 
-		if (sched->map.cpus && !cpu_map__has(sched->map.cpus, cpu))
+		if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, cpu))
 			continue;
 
-		if (sched->map.color_cpus && cpu_map__has(sched->map.color_cpus, cpu))
+		if (sched->map.color_cpus && perf_cpu_map__has(sched->map.color_cpus, cpu))
 			cpu_color = COLOR_CPUS;
 
 		if (cpu != this_cpu)
@@ -1639,7 +1639,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 			color_fprintf(stdout, color, "   ");
 	}
 
-	if (sched->map.cpus && !cpu_map__has(sched->map.cpus, this_cpu))
+	if (sched->map.cpus && !perf_cpu_map__has(sched->map.cpus, this_cpu))
 		goto out;
 
 	timestamp__scnprintf_usec(timestamp, stimestamp, sizeof(stimestamp));
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 0cb7b015b4b9..cb29ea7ec409 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -112,7 +112,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 	TEST_ASSERT_VAL("Session header CPU map not set", session->header.env.cpu);
 
 	for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
-		if (!cpu_map__has(map, i))
+		if (!perf_cpu_map__has(map, i))
 			continue;
 		pr_debug("CPU %d, core %d, socket %d\n", i,
 			 session->header.env.cpu[i].core_id,
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 19e502cc65e7..f1d76a8e92e8 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -463,11 +463,6 @@ int cpu__setup_cpunode_map(void)
 	return 0;
 }
 
-bool cpu_map__has(struct perf_cpu_map *cpus, int cpu)
-{
-	return perf_cpu_map__idx(cpus, cpu) != -1;
-}
-
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 {
 	int i, cpu, start = -1;
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index ecd658293a2d..32b8b5178f01 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -78,8 +78,6 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 				       aggr_cpu_id_get_t get_id,
 				       void *data);
 
-bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
-
 bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
 bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a);
 struct aggr_cpu_id aggr_cpu_id__empty(void);
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 51b429c86f98..8affb37d90e7 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -218,7 +218,7 @@ struct cpu_topology *cpu_topology__new(void)
 	tp->core_cpus_list = addr;
 
 	for (i = 0; i < nr; i++) {
-		if (!cpu_map__has(map, i))
+		if (!perf_cpu_map__has(map, i))
 			continue;
 
 		ret = build_cpu_topology(tp, i);
-- 
2.34.1.448.ga2b2bfdf31-goog

