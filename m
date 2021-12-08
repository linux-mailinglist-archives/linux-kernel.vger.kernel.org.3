Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2442146CB1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243454AbhLHCt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243421AbhLHCtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:49:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781DDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:46:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so1977407ybe.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+l+VOuJZ/VCl/OMUCiQtdXRt5FnGssxrmGzh4huICWg=;
        b=NJzsPaiUuUvx0f86Rqi9mcREot5w1CN6RsVaYz3ay7070jDj4hXsgr01H3/DH0CqVz
         SWgskDk8G1nHq1qdOk9KQW3QCJtxeOGrui04/N9CdCz6V1PlVfzZd0YHJDCdxnze71Ge
         GZXo4rEKZRe3fF9QGIMSxBcy30WowBqQ7IyZZHZpPldkXEBHBGGJWefkkLANa4IBhMgh
         XXCz+W1mxhF/MPcKwfbl5vkBjEMNoPTwiMnLATCVdAqk8Boufo0/cGs8weSgL7ua2yMq
         JwDIAL1Nzy1Qd6trEkgRDYpKnyq9brnGmjEh9+eQvflCYSwhXryaW9p+cfVDaa9YZtk3
         GGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+l+VOuJZ/VCl/OMUCiQtdXRt5FnGssxrmGzh4huICWg=;
        b=zyhWoF+habZiSP/vzxIijgl+ICI6R9nA4pwkB6TZVwmDM9iZZxe3Zi/s4ZUsFNDHSj
         u/ESNghS9EendRqDFlHP8RWi15zLFzBISgtLvJpbfuHvfkMNBMSOYICM6YeD6QPKq9cn
         y/5iIHTZ8dK+5HYJgOuivADioWAI028GiL03gl3Prrwu+IVaYBQoNdDTecxcATN4Bdp+
         YUJxzDjB8uSI1rUVwamKs8csV5qZwqzDZfHPCRrSw9GvQ7HwA0lK4WlmvD+Xw54ImosQ
         4bRLhU2V0SXVQqBS04dhHeAhmCw7KkTzdDzm55BI4xIGsODqaeZRNhX7HGWu5HATLyok
         7BWg==
X-Gm-Message-State: AOAM533rHTN2WCLt3at0RrnCzI0zV1jALRE66BVwZo0j/wis0BCmVklb
        N1RWNzzzYuh2HE812eijEWfeyw5gdBCz
X-Google-Smtp-Source: ABdhPJxTS16bNcO0JH6jC991GWj7oJfFqQN/9FlR/rbTs21pGKpoawqTLTq3T4OP54hPzB5o/b9lblBNd6WT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:aa51:: with SMTP id
 s75mr36046178ybi.485.1638931581660; Tue, 07 Dec 2021 18:46:21 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:49 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-5-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 04/22] perf stat: Switch to cpu version of cpu_map__get
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

Avoid bugs where the wrong index is passed with the cpu_map.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c      | 93 +++++++++++++++++++---------------
 tools/perf/util/stat-display.c | 11 ++--
 tools/perf/util/stat.h         |  3 +-
 3 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7974933dbc77..cbccd6038109 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1299,69 +1299,63 @@ static struct option stat_options[] = {
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
@@ -1459,8 +1453,9 @@ static void perf_stat__exit_aggr_mode(void)
 	stat_config.cpus_aggr_map = NULL;
 }
 
-static inline int perf_env__get_cpu(struct perf_env *env, struct perf_cpu_map *map, int idx)
+static inline int perf_env__get_cpu(void *data, struct perf_cpu_map *map, int idx)
 {
+	struct perf_env *env = data;
 	int cpu;
 
 	if (idx > map->nr)
@@ -1474,10 +1469,9 @@ static inline int perf_env__get_cpu(struct perf_env *env, struct perf_cpu_map *m
 	return cpu;
 }
 
-static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx, void *data)
+static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
-	int cpu = perf_env__get_cpu(env, map, idx);
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
 
 	if (cpu != -1)
@@ -1486,11 +1480,15 @@ static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx
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
@@ -1505,11 +1503,15 @@ static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, v
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
@@ -1525,15 +1527,24 @@ static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx,
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
@@ -1559,26 +1570,26 @@ static int perf_env__build_node_map(struct perf_env *env, struct perf_cpu_map *c
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
2.34.1.400.ga245620fadb-goog

