Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8749C47DFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346939AbhLWHqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346921AbhLWHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663FC061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so8721748ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mePtsrhLWgWXoq3H5FC5G2u7jgVyGfpWaebHRXPv2DI=;
        b=FTYkNk9HVNHs1xEfbvYqkPX6xssmZpi3cZ0WHqSWKB21s3HVQfmvlF8heOT/6l4HD2
         1LehHyj97rZLyFKPm96XoRMMAmWwMNgcSLFdBuMqrvl1Cj2jf2hmxGpxlWvZu7glKfVK
         x5JWt7g/SMGtjCc0NykMn/8x0N/0clU0xYjq58Fk26msBz2LuNf09o36ONzA9zymoWeL
         Ms9UJpMR5WG++zl76QppjyHOrWf9yTG0OHSktumzzGEyZlbyM5ZJx7WPj3Mxjk1xEvUF
         W+BGkgtnmyNdS6S+b6XsfbUFluJHlIzIc6okQXXts8VCRrx6NluvqTDuXbb5te087+sv
         Hwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mePtsrhLWgWXoq3H5FC5G2u7jgVyGfpWaebHRXPv2DI=;
        b=F6ncACRygoSIHkK5VtBQKCX2EG+RrFQIQtwWTt33dNjwLPyhcCjsFSoKylP+6eNHkJ
         1Yk3o7ZN2aUPlrgA/MAX4xIY3+vo5fy9dt9KUkeiDLB5HybbixjPNtEVLyfKmVH6Fhsr
         ac8ZZaoUmrKtRIx6Rl4L69txW4FE+YTgOS+0oegRQCQI5lv0A4wCZRb6Wy6G4s30T50j
         TzXuDzf3hx8QzPJCcakdOQ2cNAswE7JujqkYRTH2S7mnhAM4kxteCX0rxOHVBCQdxAcT
         UMd2tKW7KnUPm8pDBjsx25S0KIO09bMDnYobstR++n10EQWiLwgRcmWGY5iOxcCki63U
         qlsA==
X-Gm-Message-State: AOAM531hgkNHlibwFJNY7bW3lYiJIs7UW51nwR0cx2kz+npOiupy4DD6
        QTrIgxFrm/yLYsPTTehPE44qmtHoBIs9
X-Google-Smtp-Source: ABdhPJyfXm/WEmuaV+oEkW/4vjSdbjwpUre/bVaKHM2F5bhP4/pnZUgv6GW4xgNxO27nqPXoGMHyY37FQnAD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:e7c3:: with SMTP id
 e186mr1656956ybh.97.1640245573221; Wed, 22 Dec 2021 23:46:13 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:44:55 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-3-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 02/48] perf stat: Add aggr creators that are passed a cpu.
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

The cpu_map and index can get confused. Add variants of the cpu_map__get
routines that are passed a cpu. Make the existing cpu_map__get routines
use the new functions with a view to remove them when no longer used.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 79 +++++++++++++++++++++++-----------------
 tools/perf/util/cpumap.h |  6 ++-
 2 files changed, 51 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 87d3eca9b872..49fba2c53822 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -128,21 +128,23 @@ int cpu_map__get_socket_id(int cpu)
 	return ret ?: value;
 }
 
-struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
-					void *data __maybe_unused)
+struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_unused)
 {
-	int cpu;
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
-	if (idx > map->nr)
-		return id;
-
-	cpu = map->map[idx];
-
 	id.socket = cpu_map__get_socket_id(cpu);
 	return id;
 }
 
+struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
+				       void *data)
+{
+	if (idx < 0 || idx > map->nr)
+		return cpu_map__empty_aggr_cpu_id();
+
+	return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
+}
+
 static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 {
 	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
@@ -200,15 +202,10 @@ int cpu_map__get_die_id(int cpu)
 	return ret ?: value;
 }
 
-struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
+struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
 {
-	int cpu, die;
-	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
-
-	if (idx > map->nr)
-		return id;
-
-	cpu = map->map[idx];
+	struct aggr_cpu_id id;
+	int die;
 
 	die = cpu_map__get_die_id(cpu);
 	/* There is no die_id on legacy system. */
@@ -220,7 +217,7 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
 	 * with the socket ID and then add die to
 	 * make a unique ID.
 	 */
-	id = cpu_map__get_socket(map, idx, data);
+	id = cpu_map__get_socket_aggr_by_cpu(cpu, data);
 	if (cpu_map__aggr_cpu_id_is_empty(id))
 		return id;
 
@@ -228,6 +225,15 @@ struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *dat
 	return id;
 }
 
+struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx,
+				    void *data)
+{
+	if (idx < 0 || idx > map->nr)
+		return cpu_map__empty_aggr_cpu_id();
+
+	return cpu_map__get_die_aggr_by_cpu(map->map[idx], data);
+}
+
 int cpu_map__get_core_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
@@ -239,20 +245,13 @@ int cpu_map__get_node_id(int cpu)
 	return cpu__get_node(cpu);
 }
 
-struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
+struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 {
-	int cpu;
-	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
-
-	if (idx > map->nr)
-		return id;
-
-	cpu = map->map[idx];
-
-	cpu = cpu_map__get_core_id(cpu);
+	struct aggr_cpu_id id;
+	int core = cpu_map__get_core_id(cpu);
 
 	/* cpu_map__get_die returns a struct with socket and die set*/
-	id = cpu_map__get_die(map, idx, data);
+	id = cpu_map__get_die_aggr_by_cpu(cpu, data);
 	if (cpu_map__aggr_cpu_id_is_empty(id))
 		return id;
 
@@ -260,19 +259,33 @@ struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *da
 	 * core_id is relative to socket and die, we need a global id.
 	 * So we combine the result from cpu_map__get_die with the core id
 	 */
-	id.core = cpu;
+	id.core = core;
 	return id;
+
 }
 
-struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data __maybe_unused)
+struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data)
+{
+	if (idx < 0 || idx > map->nr)
+		return cpu_map__empty_aggr_cpu_id();
+
+	return cpu_map__get_core_aggr_by_cpu(map->map[idx], data);
+}
+
+struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unused)
 {
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
+	id.node = cpu_map__get_node_id(cpu);
+	return id;
+}
+
+struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data)
+{
 	if (idx < 0 || idx >= map->nr)
-		return id;
+		return cpu_map__empty_aggr_cpu_id();
 
-	id.node = cpu_map__get_node_id(map->map[idx]);
-	return id;
+	return cpu_map__get_node_aggr_by_cpu(map->map[idx], data);
 }
 
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index a27eeaf086e8..c62d67704425 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -31,13 +31,17 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
 int cpu_map__get_socket_id(int cpu);
+struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_die_id(int cpu);
+struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_core_id(int cpu);
+struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_node_id(int cpu);
-struct aggr_cpu_id  cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
+struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
+struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
 int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep);
-- 
2.34.1.307.g9b7440fafd-goog

