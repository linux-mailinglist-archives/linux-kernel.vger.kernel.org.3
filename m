Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADEA47DFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347127AbhLWHr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347089AbhLWHrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:03 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E4CC061761
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:58 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i3-20020a628703000000b004ba462357d6so2934443pfe.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wzNfHRH15UqedWU0GeHamcoaHHXLikx8Lp67BsvKm/8=;
        b=DswF2V/+HCId512V6RYlFazEkdCZKdunTz5HyGerKtovNwGST7qqcC2D/TL9xmJs7S
         N97OmhgO37H6HsbsLP0PP5RLzWwWEHY9cIOwRjb5Rvx8QfLOuWAdLuee5KheCboF0lET
         YnGwiMu8ravg0kcelU9B9II23oztB6OdYp2fDOBhagT7M9fNWrMZjApCa5vsmRnnrtEi
         lwQDC6RbZNHJvgzbjg/vGG9CTK2iQ0oGOKkG7gbHjABmU62/IzNnfDKBwKTZsmJ1651/
         jNhiLzyQzPOken7ZJ+v04lBQEdCXtzVhutiwEm/4x/UtY8xI20fIxXa/asD+fdcQvtxJ
         ok+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wzNfHRH15UqedWU0GeHamcoaHHXLikx8Lp67BsvKm/8=;
        b=beIi0Y18Il3NdJC+KO1MtX9nsR5pbOFJ2TdH/VxDnfZ6k325ArTIRUJJA9V1G5UJwZ
         oBhpcgNcD3JsHeSRMce7MXqFiW8RVO6dO99PAQmm5WWq+9tfhXxTND2lSkKWJ6fMpMjz
         yaClCpz/8H2e19Su5oOmJqMhpFXZ93L5o87Lxd53offXHw0BDLbIqA0+eucibIhD9i3Q
         iqKD1Z7nQJJb+VCZBHjuoagNNoA74lX0mssAKrfSHcn3LUNwbWOj7q2nSVl8WeOgCGQF
         qAUw8GhMSUP17p249n5o/0ARvdMg4WBbFW1KdMIADOX2H8cGYfcaff9ast37miKv5Q0L
         TH6w==
X-Gm-Message-State: AOAM532LffiWb16dixl45dNJCmiIPRQ5zWUUMzDrEBTIFuZiYlrZaPeh
        ZOiqOQs2LB9A39n7rjlvOYtmNwgAo5K3
X-Google-Smtp-Source: ABdhPJxaI28ohdtPvEYm0D2zTZ62SQ2bUo280IlPmfflMrBSZ1Crt7N5E3JMsGsRQ1x2gx0b1SebIoEJBQr6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a17:90a:ba03:: with SMTP id
 s3mr1668443pjr.219.1640245618142; Wed, 22 Dec 2021 23:46:58 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:13 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-21-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 20/48] perf cpumap: Move 'has' function to libperf
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
        linux-arm-kernel@lists.infradead.org
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
 tools/lib/perf/cpumap.c                  |  7 ++++++-
 tools/lib/perf/include/internal/cpumap.h |  2 +-
 tools/lib/perf/include/perf/cpumap.h     |  1 +
 tools/perf/arch/arm/util/cs-etm.c        | 16 ++++++++--------
 tools/perf/builtin-sched.c               |  6 +++---
 tools/perf/tests/topology.c              |  2 +-
 tools/perf/util/cpumap.c                 |  5 -----
 tools/perf/util/cpumap.h                 |  2 --
 tools/perf/util/cputopo.c                |  2 +-
 9 files changed, 21 insertions(+), 22 deletions(-)

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
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 293a23bf8be3..76c66780617c 100644
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
@@ -542,8 +542,8 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	/* cpu map is not empty, we have specific CPUs to work with */
 	if (!perf_cpu_map__empty(event_cpus)) {
 		for (i = 0; i < cpu__max_cpu(); i++) {
-			if (!cpu_map__has(event_cpus, i) ||
-			    !cpu_map__has(online_cpus, i))
+			if (!perf_cpu_map__has(event_cpus, i) ||
+			    !perf_cpu_map__has(online_cpus, i))
 				continue;
 
 			if (cs_etm_is_ete(itr, i))
@@ -556,7 +556,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 	} else {
 		/* get configuration for all CPUs in the system */
 		for (i = 0; i < cpu__max_cpu(); i++) {
-			if (!cpu_map__has(online_cpus, i))
+			if (!perf_cpu_map__has(online_cpus, i))
 				continue;
 
 			if (cs_etm_is_ete(itr, i))
@@ -741,8 +741,8 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	} else {
 		/* Make sure all specified CPUs are online */
 		for (i = 0; i < perf_cpu_map__nr(event_cpus); i++) {
-			if (cpu_map__has(event_cpus, i) &&
-			    !cpu_map__has(online_cpus, i))
+			if (perf_cpu_map__has(event_cpus, i) &&
+			    !perf_cpu_map__has(online_cpus, i))
 				return -EINVAL;
 		}
 
@@ -763,7 +763,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
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
index 0e325559c33c..8a72ee996722 100644
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
index 15043e764fa6..832fc53f3c11 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -78,8 +78,6 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 				       aggr_cpu_id_get_t f,
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
2.34.1.307.g9b7440fafd-goog

