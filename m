Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11DD47DFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347238AbhLWHrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347038AbhLWHrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA74C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t184-20020a2546c1000000b006008b13c80bso8745971yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fTUR5VG8a/+8UOVZeCoh/rbzUAVJU6bq+SOLs+aNQRw=;
        b=ReTb6NzMIRGxqZErghagCAEupNuZMhHsxwL/jqcOJpVHr5sgzOX9q6Tc+xc1rG8bpD
         NIBlTJiUzXgVqAeWne8Zd6TrQZkt3xJ60zOuOo4hCWE3Fi4vHOR4sJ0ZVv5UNV6JH2Fa
         Ve0AAwq7qaItHE71yJznSobk0lxTdmU3gqNdQaXIUOC2dlwaOTN/5aRm5M3wmuknKZyy
         wixSYVm4BfqTkFsA+2tbaqvjYuK8sMaD/TWsrTjIvoJPf273jzuIU5Pfho5geYBAppNp
         0H8GODpsgJaFL4ebSTvCm9D3EPONZGdPItQksxC23OC48sPhrrxON7TdylLhMt1mG+Is
         a/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fTUR5VG8a/+8UOVZeCoh/rbzUAVJU6bq+SOLs+aNQRw=;
        b=zeMu8We1q5QmwvGAA2R4qXDf0weT187r6tmOqsS6PqBtqteTcSIu+AHsalCbAbghpY
         tH7pEHnxXG0LBtUQt/layGHXNuBLFdcl4GXc8Xr/KhtjtKheFgAwKksht0ZXZn0V8F8M
         wfWv35e8PwF2fLH+cSSziC+wOcmzyEIPl0fXzhQkyddB5rqvLFK4R941TS50YjcGmAEg
         ZKX1a8jxSLfVZjDuTbCwYF/6AsvPAoC+OKcrwC+gCoK2YuE6SdvKt3Xo2KNbB4IZXPLt
         53NQ8WJVtExwJQH4jI6LyneRvYfF9r8iCx9Vwl2tdwxcA3Nbku/EBEdv70hXbn9d5Y9n
         /yNQ==
X-Gm-Message-State: AOAM530WixGdTGsOP1XpBkLWZLRXAzT8LBwU5IP+qL7EtYQ+YI80yAa3
        UzzMdXyz/IwC0+RdVL5Ky1bObQc/6+v6
X-Google-Smtp-Source: ABdhPJwcdBH2/CcubIhmiZzDyEWmCcpO7mosFjotsrXWYeEg4n6tdPuWTq41wFk+BqgyWp7mP1ONEoHZhTPm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:2745:: with SMTP id
 n66mr1726032ybn.120.1640245612852; Wed, 22 Dec 2021 23:46:52 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:11 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-19-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 18/48] perf cpumap: Refactor cpu_map__build_map
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
2.34.1.307.g9b7440fafd-goog

