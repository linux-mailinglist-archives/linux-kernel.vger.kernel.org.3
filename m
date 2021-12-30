Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E07B481A41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhL3HUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbhL3HUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:20:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FDC06175B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k130-20020a255688000000b0060c3dcae580so22462504ybb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s4X02nPqi4F+1EmoUQtjO9/Qbf12X3JymSUrgtvqJrs=;
        b=l1fWCghrYAW3unWS4+M8bQMkCz6u/L9GDkkw74pkbf37n5GbApMhE6fNv8YzPbRD9C
         IijpC18jYrQ4rQNVh9rTGCLzY+UkTFsSqJuifjhlMIYtDteT4ARAburHIXZ7Qv+I9Z+A
         nNMsUhCOSXDDcYxOK/kMOw1WM2TTfsmO4vv3mhj4yH50j/eyG3ISb906QTAgyviVyhLn
         rcQ42FfoUjYJ0H1Cpzv4b3g+BsbAlJ4XXobYlryAfrUm1Gcd4oXlf92Q8i0+FFCK2g3A
         L0b4UzVr2uLGWwSgXlDl4cDBtSNlekrU2+kGt6vsdqj60+hS7bAQ/O6v3PbIPyS8w06u
         s1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s4X02nPqi4F+1EmoUQtjO9/Qbf12X3JymSUrgtvqJrs=;
        b=5lpcdtCi+/d/fTkTTy6Izag91wFIdTjkRvIXB4TgsAUMDsGCnFYyOVoZG0+J/AnFC9
         0NA4ch35lv235cO8+UgFm2R1e9796hsv1LAvAn3WGJMTuldJB7Zq77qwsncJ3Snl/IAE
         Y5VJ7jEeH4uEdN7S2/rL0CeKzHWqGoHMtms2fV9+05kv6Tn+iinoBPHTrzzyvdXEjzsV
         UQhQ4xlOsAuuSLWcyDDdK56WwLTXHx63Opa2vkg/01K+sxPWaKQyLgSXWjk/xgTgvhRj
         YM2VxKmXqT7ICaeKdD9eIhZlYIDgOnzlS92jjd1VIsQMgYpNwBvRSFDtxAS26jfrD6NI
         oiEg==
X-Gm-Message-State: AOAM531JCVbMj1xkPI9pu/flYf0TaZVOKe5GCn8Wx0LzzWYFZ/YFWonm
        eO3LfurGwizf63R1ecmWoSTDxYfyWChw
X-Google-Smtp-Source: ABdhPJxlKgxKCfzRAlpi3oA7tu7yLR4omDu403xKk0YEtb3lwmD4rLoVt0FjL83gGZneAdSK0oZU2SmNz4da
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:4197:: with SMTP id
 o145mr19892454yba.80.1640848851308; Wed, 29 Dec 2021 23:20:51 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:47 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-7-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 05/48] perf stat: Switch to cpu version of cpu_map__get
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

Avoid bugs where the wrong index is passed with the cpu_map.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c      | 93 +++++++++++++++++++---------------
 tools/perf/util/stat-display.c | 11 ++--
 tools/perf/util/stat.h         |  3 +-
 3 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f6ca2b054c5b..9791ae9b1a53 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1323,69 +1323,63 @@ static struct option stat_options[] = {
 };
 
 static struct aggr_cpu_id perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
-				 struct perf_cpu_map *map, int cpu)
+						int cpu)
 {
-	return cpu_map__get_socket(map, cpu, NULL);
+	return cpu_map__get_socket_aggr_by_cpu(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_die(struct perf_stat_config *config __maybe_unused,
-			      struct perf_cpu_map *map, int cpu)
+					     int cpu)
 {
-	return cpu_map__get_die(map, cpu, NULL);
+	return cpu_map__get_die_aggr_by_cpu(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
-			       struct perf_cpu_map *map, int cpu)
+					      int cpu)
 {
-	return cpu_map__get_core(map, cpu, NULL);
+	return cpu_map__get_core_aggr_by_cpu(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_node(struct perf_stat_config *config __maybe_unused,
-			       struct perf_cpu_map *map, int cpu)
+					      int cpu)
 {
-	return cpu_map__get_node(map, cpu, NULL);
+	return cpu_map__get_node_aggr_by_cpu(cpu, /*data=*/NULL);
 }
 
 static struct aggr_cpu_id perf_stat__get_aggr(struct perf_stat_config *config,
-			       aggr_get_id_t get_id, struct perf_cpu_map *map, int idx)
+					      aggr_get_id_t get_id, int cpu)
 {
-	int cpu;
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
-	if (idx >= map->nr)
-		return id;
-
-	cpu = map->map[idx];
-
 	if (cpu_map__aggr_cpu_id_is_empty(config->cpus_aggr_map->map[cpu]))
-		config->cpus_aggr_map->map[cpu] = get_id(config, map, idx);
+		config->cpus_aggr_map->map[cpu] = get_id(config, cpu);
 
 	id = config->cpus_aggr_map->map[cpu];
 	return id;
 }
 
 static struct aggr_cpu_id perf_stat__get_socket_cached(struct perf_stat_config *config,
-					struct perf_cpu_map *map, int idx)
+						       int cpu)
 {
-	return perf_stat__get_aggr(config, perf_stat__get_socket, map, idx);
+	return perf_stat__get_aggr(config, perf_stat__get_socket, cpu);
 }
 
 static struct aggr_cpu_id perf_stat__get_die_cached(struct perf_stat_config *config,
-					struct perf_cpu_map *map, int idx)
+						    int cpu)
 {
-	return perf_stat__get_aggr(config, perf_stat__get_die, map, idx);
+	return perf_stat__get_aggr(config, perf_stat__get_die, cpu);
 }
 
 static struct aggr_cpu_id perf_stat__get_core_cached(struct perf_stat_config *config,
-				      struct perf_cpu_map *map, int idx)
+						     int cpu)
 {
-	return perf_stat__get_aggr(config, perf_stat__get_core, map, idx);
+	return perf_stat__get_aggr(config, perf_stat__get_core, cpu);
 }
 
 static struct aggr_cpu_id perf_stat__get_node_cached(struct perf_stat_config *config,
-				      struct perf_cpu_map *map, int idx)
+						     int cpu)
 {
-	return perf_stat__get_aggr(config, perf_stat__get_node, map, idx);
+	return perf_stat__get_aggr(config, perf_stat__get_node, cpu);
 }
 
 static bool term_percore_set(void)
@@ -1483,8 +1477,9 @@ static void perf_stat__exit_aggr_mode(void)
 	stat_config.cpus_aggr_map = NULL;
 }
 
-static inline int perf_env__get_cpu(struct perf_env *env, struct perf_cpu_map *map, int idx)
+static inline int perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
 {
+	struct perf_env *env = data;
 	int cpu;
 
 	if (idx > map->nr)
@@ -1498,10 +1493,9 @@ static inline int perf_env__get_cpu(struct perf_env *env, struct perf_cpu_map *m
 	return cpu;
 }
 
-static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx, void *data)
+static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
-	int cpu = perf_env__get_cpu(env, map, idx);
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
 	if (cpu != -1)
@@ -1510,11 +1504,15 @@ static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, void *data)
+static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx, void *data)
+{
+	return perf_env__get_socket_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
+}
+
+static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
-	int cpu = perf_env__get_cpu(env, map, idx);
 
 	if (cpu != -1) {
 		/*
@@ -1529,11 +1527,15 @@ static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, v
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx, void *data)
+static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, void *data)
+{
+	return perf_env__get_die_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
+}
+
+static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
-	int cpu = perf_env__get_cpu(env, map, idx);
 
 	if (cpu != -1) {
 		/*
@@ -1549,15 +1551,24 @@ static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx,
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_node(struct perf_cpu_map *map, int idx, void *data)
+static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx, void *data)
+{
+	return perf_env__get_core_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
+}
+
+static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 {
-	int cpu = perf_env__get_cpu(data, map, idx);
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
 	id.node = perf_env__numa_node(data, cpu);
 	return id;
 }
 
+static struct aggr_cpu_id perf_env__get_node(struct perf_cpu_map *map, int idx, void *data)
+{
+	return perf_env__get_node_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
+}
+
 static int perf_env__build_socket_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				      struct cpu_aggr_map **sockp)
 {
@@ -1583,26 +1594,26 @@ static int perf_env__build_node_map(struct perf_env *env, struct perf_cpu_map *c
 }
 
 static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
-				      struct perf_cpu_map *map, int idx)
+						     int cpu)
 {
-	return perf_env__get_socket(map, idx, &perf_stat.session->header.env);
+	return perf_env__get_socket_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 static struct aggr_cpu_id perf_stat__get_die_file(struct perf_stat_config *config __maybe_unused,
-				   struct perf_cpu_map *map, int idx)
+						  int cpu)
 {
-	return perf_env__get_die(map, idx, &perf_stat.session->header.env);
+	return perf_env__get_die_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
 static struct aggr_cpu_id perf_stat__get_core_file(struct perf_stat_config *config __maybe_unused,
-				    struct perf_cpu_map *map, int idx)
+						   int cpu)
 {
-	return perf_env__get_core(map, idx, &perf_stat.session->header.env);
+	return perf_env__get_core_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
 static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *config __maybe_unused,
-				    struct perf_cpu_map *map, int idx)
+						   int cpu)
 {
-	return perf_env__get_node(map, idx, &perf_stat.session->header.env);
+	return perf_env__get_node_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
 static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index efab39a759ff..6c40b91d5e32 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -341,8 +341,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 
 	cpus = evsel__cpus(evsel);
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpus, idx),
-						 id))
+		if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpu), id))
 			return cpu;
 	}
 	return 0;
@@ -525,8 +524,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 			cpus = evsel__cpus(counter);
 			val = 0;
 			perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-				(void)cpu;
-				s2 = config->aggr_get_id(config, cpus, idx);
+				s2 = config->aggr_get_id(config, cpu);
 				if (!cpu_map__compare_aggr_cpu_id(s2, id))
 					continue;
 				val += perf_counts(counter->counts, idx, 0)->val;
@@ -642,8 +640,7 @@ static void aggr_cb(struct perf_stat_config *config,
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		struct perf_counts_values *counts;
 
-		(void)cpu;
-		s2 = config->aggr_get_id(config, cpus, idx);
+		s2 = config->aggr_get_id(config, cpu);
 		if (!cpu_map__compare_aggr_cpu_id(s2, ad->id))
 			continue;
 		if (first)
@@ -1217,7 +1214,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 
 	cpus = evsel__cpus(counter);
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		s2 = config->aggr_get_id(config, cpus, idx);
+		s2 = config->aggr_get_id(config, cpu);
 		for (s = 0; s < config->aggr_map->nr; s++) {
 			id = config->aggr_map->map[s];
 			if (cpu_map__compare_aggr_cpu_id(s2, id))
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 32c8527de347..32cf24186229 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -108,8 +108,7 @@ struct runtime_stat {
 	struct rblist value_list;
 };
 
-typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config,
-			     struct perf_cpu_map *m, int cpu);
+typedef struct aggr_cpu_id (*aggr_get_id_t)(struct perf_stat_config *config, int cpu);
 
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
-- 
2.34.1.448.ga2b2bfdf31-goog

