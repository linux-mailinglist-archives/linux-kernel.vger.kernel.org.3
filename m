Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A22481A39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhL3HVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbhL3HVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C647C06175B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s83-20020a255e56000000b0060c46cc1890so21973750ybb.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=reTidcldqC4oZu1iw2E8DOw3f09A4KICYcKP4xYiH4s=;
        b=qi/yL4YKwYAhgGO98IDPHAErh8pDNWejnw0TaI/CcyyTkpxtLTHJIsUg3TFpGjlj6k
         rnOAroU9YSskwGCQQsY0+yxt7l93xX10rzArxvdmAxxRsjg0nVaOKsajRftEeW4fCSnb
         iQCU6cZs62pJlIZotXFkKy5qGTj+wkpNdp2IGtxz6TQgXhbWAXvoX14GzMaZ9js1STWN
         EAiLNR1YuelmmQaLwZUmCj2EAeiIc0OycL8CCm+L90AKYt5gXUN3KB5unJDbQol7UG3B
         pLNR0NBJHR3S/uNebWvG4TSDZ+mrTeAIyn3QV+iKu0Fpsh7vl6V0CDBAZiwEnCyuLTy+
         1VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=reTidcldqC4oZu1iw2E8DOw3f09A4KICYcKP4xYiH4s=;
        b=Zntz36n6hWqsXEJiGdLG2nhC9z2Dtpkyy8NJZN/5rpN8+958pPrjrBLqqeOLYwzYX/
         74kR+pcAZnDrFuyD+kT960DDrqk9n46weN6YqyEZ/l6IS3j4p11/zivHIgTNtbNwQ++L
         trbOedjQZxKjJd4r2XViLBMlx5bIcjGFcm+n+A1mxClKr4+Y57nYaoiKS8zMSiZhGWqk
         YFU+Fl5vCEnS06ZtoDS5oVgjgLsNUka1FPm3l2wNH7VUfCFL3FRtTGBQVoVCQjx8jgbH
         2JTqwD1L94sJ+iZRLEg4/VBe0cuj5Iit7+91zgqQ9sMWEQUlTS70insmOrYBZhugREnd
         CG+g==
X-Gm-Message-State: AOAM533/fwsEdjdQkDJSr38L7p39p01tElU05DlptxswC+id+4pvdn26
        OrMbAw2tK5fVWkZDj74hS7BV4Yl5ECyp
X-Google-Smtp-Source: ABdhPJyJo8mpb/6k+cA/uVv5GF25Z8+31pz7XL2EidKpB5eOJ2F9XxDfyYCAa8vnqz4tMLH/wIiJVtTMdw+Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:4197:: with SMTP id
 o145mr19894151yba.80.1640848883532; Wed, 29 Dec 2021 23:21:23 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:00 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-20-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 18/48] perf cpumap: Refactor cpu_map__build_map
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

Turn it into a cpu_aggr_map__new. Pass helper functions. Refactor
builtin-stat calls to manually pass function pointers. Try to reduce
some copy-paste code.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 187 ++++++++++++++++++++------------------
 tools/perf/util/cpumap.c  |  59 +++++-------
 tools/perf/util/cpumap.h  |  16 ++--
 3 files changed, 130 insertions(+), 132 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d229fb71b577..2b04a948cf37 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1322,6 +1322,17 @@ static struct option stat_options[] = {
 	OPT_END()
 };
 
+static const char *const aggr_mode__string[] = {
+	[AGGR_CORE] = "core",
+	[AGGR_DIE] = "die",
+	[AGGR_GLOBAL] = "global",
+	[AGGR_NODE] = "node",
+	[AGGR_NONE] = "none",
+	[AGGR_SOCKET] = "socket",
+	[AGGR_THREAD] = "thread",
+	[AGGR_UNSET] = "unset",
+};
+
 static struct aggr_cpu_id perf_stat__get_socket(struct perf_stat_config *config __maybe_unused,
 						int cpu)
 {
@@ -1394,54 +1405,67 @@ static bool term_percore_set(void)
 	return false;
 }
 
-static int perf_stat_init_aggr_mode(void)
+static aggr_cpu_id_get_t aggr_mode__get_aggr(enum aggr_mode aggr_mode)
 {
-	int nr;
+	switch (aggr_mode) {
+	case AGGR_SOCKET:
+		return cpu_map__get_socket_aggr_by_cpu;
+	case AGGR_DIE:
+		return cpu_map__get_die_aggr_by_cpu;
+	case AGGR_CORE:
+		return cpu_map__get_core_aggr_by_cpu;
+	case AGGR_NODE:
+		return cpu_map__get_node_aggr_by_cpu;
+	case AGGR_NONE:
+		if (term_percore_set())
+			return cpu_map__get_core_aggr_by_cpu;
+
+		return NULL;
+	case AGGR_GLOBAL:
+	case AGGR_THREAD:
+	case AGGR_UNSET:
+	default:
+		return NULL;
+	}
+}
 
-	switch (stat_config.aggr_mode) {
+static aggr_get_id_t aggr_mode__get_id(enum aggr_mode aggr_mode)
+{
+	switch (aggr_mode) {
 	case AGGR_SOCKET:
-		if (cpu_map__build_socket_map(evsel_list->core.cpus, &stat_config.aggr_map)) {
-			perror("cannot build socket map");
-			return -1;
-		}
-		stat_config.aggr_get_id = perf_stat__get_socket_cached;
-		break;
+		return perf_stat__get_socket_cached;
 	case AGGR_DIE:
-		if (cpu_map__build_die_map(evsel_list->core.cpus, &stat_config.aggr_map)) {
-			perror("cannot build die map");
-			return -1;
-		}
-		stat_config.aggr_get_id = perf_stat__get_die_cached;
-		break;
+		return perf_stat__get_die_cached;
 	case AGGR_CORE:
-		if (cpu_map__build_core_map(evsel_list->core.cpus, &stat_config.aggr_map)) {
-			perror("cannot build core map");
-			return -1;
-		}
-		stat_config.aggr_get_id = perf_stat__get_core_cached;
-		break;
+		return perf_stat__get_core_cached;
 	case AGGR_NODE:
-		if (cpu_map__build_node_map(evsel_list->core.cpus, &stat_config.aggr_map)) {
-			perror("cannot build core map");
-			return -1;
-		}
-		stat_config.aggr_get_id = perf_stat__get_node_cached;
-		break;
+		return perf_stat__get_node_cached;
 	case AGGR_NONE:
 		if (term_percore_set()) {
-			if (cpu_map__build_core_map(evsel_list->core.cpus,
-						    &stat_config.aggr_map)) {
-				perror("cannot build core map");
-				return -1;
-			}
-			stat_config.aggr_get_id = perf_stat__get_core_cached;
+			return perf_stat__get_core_cached;
 		}
-		break;
+		return NULL;
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	default:
-		break;
+		return NULL;
+	}
+}
+
+static int perf_stat_init_aggr_mode(void)
+{
+	int nr;
+	aggr_cpu_id_get_t get_id = aggr_mode__get_aggr(stat_config.aggr_mode);
+
+	if (get_id) {
+		stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.cpus,
+							 get_id, /*data=*/NULL);
+		if (!stat_config.aggr_map) {
+			pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
+			return -1;
+		}
+		stat_config.aggr_get_id = aggr_mode__get_id(stat_config.aggr_mode);
 	}
 
 	/*
@@ -1549,30 +1573,6 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static int perf_env__build_socket_map(struct perf_env *env, struct perf_cpu_map *cpus,
-				      struct cpu_aggr_map **sockp)
-{
-	return cpu_map__build_map(cpus, sockp, perf_env__get_socket_aggr_by_cpu, env);
-}
-
-static int perf_env__build_die_map(struct perf_env *env, struct perf_cpu_map *cpus,
-				   struct cpu_aggr_map **diep)
-{
-	return cpu_map__build_map(cpus, diep, perf_env__get_die_aggr_by_cpu, env);
-}
-
-static int perf_env__build_core_map(struct perf_env *env, struct perf_cpu_map *cpus,
-				    struct cpu_aggr_map **corep)
-{
-	return cpu_map__build_map(cpus, corep, perf_env__get_core_aggr_by_cpu, env);
-}
-
-static int perf_env__build_node_map(struct perf_env *env, struct perf_cpu_map *cpus,
-				    struct cpu_aggr_map **nodep)
-{
-	return cpu_map__build_map(cpus, nodep, perf_env__get_node_aggr_by_cpu, env);
-}
-
 static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
 						     int cpu)
 {
@@ -1596,47 +1596,60 @@ static struct aggr_cpu_id perf_stat__get_node_file(struct perf_stat_config *conf
 	return perf_env__get_node_aggr_by_cpu(cpu, &perf_stat.session->header.env);
 }
 
-static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
+static aggr_cpu_id_get_t aggr_mode__get_aggr_file(enum aggr_mode aggr_mode)
 {
-	struct perf_env *env = &st->session->header.env;
+	switch (aggr_mode) {
+	case AGGR_SOCKET:
+		return perf_env__get_socket_aggr_by_cpu;
+	case AGGR_DIE:
+		return perf_env__get_die_aggr_by_cpu;
+	case AGGR_CORE:
+		return perf_env__get_core_aggr_by_cpu;
+	case AGGR_NODE:
+		return perf_env__get_node_aggr_by_cpu;
+	case AGGR_NONE:
+	case AGGR_GLOBAL:
+	case AGGR_THREAD:
+	case AGGR_UNSET:
+	default:
+		return NULL;
+	}
+}
 
-	switch (stat_config.aggr_mode) {
+static aggr_get_id_t aggr_mode__get_id_file(enum aggr_mode aggr_mode)
+{
+	switch (aggr_mode) {
 	case AGGR_SOCKET:
-		if (perf_env__build_socket_map(env, evsel_list->core.cpus, &stat_config.aggr_map)) {
-			perror("cannot build socket map");
-			return -1;
-		}
-		stat_config.aggr_get_id = perf_stat__get_socket_file;
-		break;
+		return perf_stat__get_socket_file;
 	case AGGR_DIE:
-		if (perf_env__build_die_map(env, evsel_list->core.cpus, &stat_config.aggr_map)) {
-			perror("cannot build die map");
-			return -1;
-		}
-		stat_config.aggr_get_id = perf_stat__get_die_file;
-		break;
+		return perf_stat__get_die_file;
 	case AGGR_CORE:
-		if (perf_env__build_core_map(env, evsel_list->core.cpus, &stat_config.aggr_map)) {
-			perror("cannot build core map");
-			return -1;
-		}
-		stat_config.aggr_get_id = perf_stat__get_core_file;
-		break;
+		return perf_stat__get_core_file;
 	case AGGR_NODE:
-		if (perf_env__build_node_map(env, evsel_list->core.cpus, &stat_config.aggr_map)) {
-			perror("cannot build core map");
-			return -1;
-		}
-		stat_config.aggr_get_id = perf_stat__get_node_file;
-		break;
+		return perf_stat__get_node_file;
 	case AGGR_NONE:
 	case AGGR_GLOBAL:
 	case AGGR_THREAD:
 	case AGGR_UNSET:
 	default:
-		break;
+		return NULL;
 	}
+}
+
+static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
+{
+	struct perf_env *env = &st->session->header.env;
+	aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
 
+	if (!get_id)
+		return 0;
+
+	stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.cpus, get_id, env);
+	if (!stat_config.aggr_map) {
+		pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
+		return -1;
+	}
+	stat_config.aggr_get_id = aggr_mode__get_id_file(stat_config.aggr_mode);
 	return 0;
 }
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 32f9fc2dd389..ba4468f691c8 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -140,7 +140,7 @@ struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_u
 	return id;
 }
 
-static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
+static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
 {
 	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
 	struct aggr_cpu_id *b = (struct aggr_cpu_id *)b_pointer;
@@ -157,37 +157,40 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 		return a->thread - b->thread;
 }
 
-int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-		       struct aggr_cpu_id (*f)(int cpu, void *data),
-		       void *data)
+struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
+				       aggr_cpu_id_get_t f,
+				       void *data)
 {
-	int nr = cpus->nr;
-	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(nr);
-	int cpu, s2;
-	struct aggr_cpu_id s1;
+	int cpu, idx;
+	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);
 
 	if (!c)
-		return -1;
+		return NULL;
 
 	/* Reset size as it may only be partially filled */
 	c->nr = 0;
 
-	for (cpu = 0; cpu < nr; cpu++) {
-		s1 = f(cpu, data);
-		for (s2 = 0; s2 < c->nr; s2++) {
-			if (aggr_cpu_id__equal(&s1, &c->map[s2]))
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		bool duplicate = false;
+		struct aggr_cpu_id cpu_id = f(cpu, data);
+
+		for (int j = 0; j < c->nr; j++) {
+			if (aggr_cpu_id__equal(&cpu_id, &c->map[j])) {
+				duplicate = true;
 				break;
+			}
 		}
-		if (s2 == c->nr) {
-			c->map[c->nr] = s1;
+		if (!duplicate) {
+			c->map[c->nr] = cpu_id;
 			c->nr++;
 		}
 	}
+
 	/* ensure we process id in increasing order */
-	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), cmp_aggr_cpu_id);
+	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
+
+	return c;
 
-	*res = c;
-	return 0;
 }
 
 int cpu__get_die_id(int cpu)
@@ -253,26 +256,6 @@ struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unu
 	return id;
 }
 
-int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
-{
-	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket_aggr_by_cpu, NULL);
-}
-
-int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep)
-{
-	return cpu_map__build_map(cpus, diep, cpu_map__get_die_aggr_by_cpu, NULL);
-}
-
-int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep)
-{
-	return cpu_map__build_map(cpus, corep, cpu_map__get_core_aggr_by_cpu, NULL);
-}
-
-int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **numap)
-{
-	return cpu_map__build_map(cpus, numap, cpu_map__get_node_aggr_by_cpu, NULL);
-}
-
 /* setup simple routines to easily access node numbers given a cpu number */
 static int get_max_num(char *path, int *max)
 {
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 87545bcd461d..02e8c80fea0a 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -43,10 +43,6 @@ struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
-int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
-int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
-int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep);
-int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **nodep);
 const struct perf_cpu_map *cpu_map__online(void); /* thread unsafe */
 
 int cpu__setup_cpunode_map(void);
@@ -75,10 +71,16 @@ int cpu__get_die_id(int cpu);
  */
 int cpu__get_core_id(int cpu);
 
+typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(int cpu, void *data);
 
-int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-		       struct aggr_cpu_id (*f)(int cpu, void *data),
-		       void *data);
+/**
+ * cpu_aggr_map__new - Create a cpu_aggr_map with an aggr_cpu_id for each cpu in
+ * cpus. The aggr_cpu_id is created with 'f' that may have a data value passed
+ * to it. The cpu_aggr_map is sorted with duplicate values removed.
+ */
+struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
+				       aggr_cpu_id_get_t f,
+				       void *data);
 
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
 
-- 
2.34.1.448.ga2b2bfdf31-goog

