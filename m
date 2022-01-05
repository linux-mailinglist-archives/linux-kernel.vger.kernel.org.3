Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF52484E20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiAEGPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbiAEGOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1161EC061792
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 66-20020a251245000000b0060d05da9c4eso45795122ybs.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AifZMWGIyf5BgdMB7L7Gxo1hfuqMZZOHTMlvW2tmWZk=;
        b=BymRZwZiT7WD2pPvU+BDWwamc9Jg5vC6DrW8d3D7mRfbkeH6qBQEfkJcSxJ37G39JO
         CzBeJyNf1CyS1lJGSibl+XLBOqZJxae7SRqoh3bPT3it9RXoyfLk/08ys6uhv/fkpstp
         BQB3CadUQodWR8yiJ6iejB+00BhPRDsgR8/3qDxMn34isG0GFwGthmwUf6YLy962K36P
         KADWz4/pE/X47VxDpBWbUdAFypzWFhUZMN9w2wV5O7zuMSWwTiYWCxpBM1pyVQKPjKgb
         h2z1WZqV8XSNneKydyOTg82xcMEhlH4zd7k8CNIFqeiRpk31lbmSuJ6oEY3SnyrnpzJt
         zRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AifZMWGIyf5BgdMB7L7Gxo1hfuqMZZOHTMlvW2tmWZk=;
        b=MvDBe8hFUfmTg5niXWiy+q9lNpwvUrUwwEHs95dEAElF3mKCQn5svObh5MilIw6aik
         LMC5avEOUsOnYV+VoXt6RptY+/X9LjgJbz2qCFTxkHvBJpdjWmaPSiCzAfZLagqrYAa1
         HYtmZsfyinz11PgDuSWjAtwtKUpRkS95Htv/byEMxA2dndkmdDSQGk++ozMC36QQRkSq
         nDo0Tq69Z2zpTepyFuy6UUzWvqSw0v4Yh4iQym0n0oeAAn6treJbem0+fdcnI7W6qi5i
         sgtvQXv1UuR5y7FVWI3ehfYbCw0wcB1LyCq5EYRrb65VlhRTXua1Os0ta7Q55LnR3Ekw
         u/YQ==
X-Gm-Message-State: AOAM530Vow44CD6+1v946CX9WATB8kW5rpJjjhiGRHLYsiWOXl6/fHH8
        DRf6IgqLsj0rqwp1JiJr3nojreuG3VeE
X-Google-Smtp-Source: ABdhPJzmT4HwzfcFMnmujcUKCBU6GddgIehKcuhOtuPXToUP1nJxa9kKuF+7JTgNLimt0jpVEbP6k1SoG0O8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:198a:: with SMTP id
 132mr15220255ybz.273.1641363277321; Tue, 04 Jan 2022 22:14:37 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:19 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-17-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 16/48] perf cpumap: Remove map from function names that
 don't use a map.
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

Move to the cpu name and document for consistency.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 12 ++++++------
 tools/perf/util/cpumap.h | 19 ++++++++++++++++---
 tools/perf/util/env.c    |  6 +++---
 tools/perf/util/stat.c   |  4 ++--
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 1626b0991408..e0d7f1da5858 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -126,7 +126,7 @@ static int cpu__get_topology_int(int cpu, const char *name, int *value)
 	return sysfs__read_int(path, value);
 }
 
-int cpu_map__get_socket_id(int cpu)
+int cpu__get_socket_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "physical_package_id", &value);
 	return ret ?: value;
@@ -136,7 +136,7 @@ struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_u
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
-	id.socket = cpu_map__get_socket_id(cpu);
+	id.socket = cpu__get_socket_id(cpu);
 	return id;
 }
 
@@ -190,7 +190,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 	return 0;
 }
 
-int cpu_map__get_die_id(int cpu)
+int cpu__get_die_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "die_id", &value);
 
@@ -202,7 +202,7 @@ struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
 	struct aggr_cpu_id id;
 	int die;
 
-	die = cpu_map__get_die_id(cpu);
+	die = cpu__get_die_id(cpu);
 	/* There is no die_id on legacy system. */
 	if (die == -1)
 		die = 0;
@@ -220,7 +220,7 @@ struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-int cpu_map__get_core_id(int cpu)
+int cpu__get_core_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
 	return ret ?: value;
@@ -229,7 +229,7 @@ int cpu_map__get_core_id(int cpu)
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 {
 	struct aggr_cpu_id id;
-	int core = cpu_map__get_core_id(cpu);
+	int core = cpu__get_core_id(cpu);
 
 	/* cpu_map__get_die returns a struct with socket and die set*/
 	id = cpu_map__get_die_aggr_by_cpu(cpu, data);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index f849f01c5860..a053bf31a3f0 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -39,11 +39,8 @@ struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
-int cpu_map__get_socket_id(int cpu);
 struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
-int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
-int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
@@ -62,6 +59,22 @@ int cpu__max_present_cpu(void);
  * /sys/devices/system/node/nodeX for the given CPU.
  */
 int cpu__get_node(int cpu);
+/**
+ * cpu__get_socket_id - Returns the socket number as read from
+ * /sys/devices/system/cpu/cpuX/topology/physical_package_id for the given CPU.
+ */
+int cpu__get_socket_id(int cpu);
+/**
+ * cpu__get_die_id - Returns the die id as read from
+ * /sys/devices/system/cpu/cpuX/topology/die_id for the given CPU.
+ */
+int cpu__get_die_id(int cpu);
+/**
+ * cpu__get_core_id - Returns the core id as read from
+ * /sys/devices/system/cpu/cpuX/topology/core_id for the given CPU.
+ */
+int cpu__get_core_id(int cpu);
+
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 		       struct aggr_cpu_id (*f)(int cpu, void *data),
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index b9904896eb97..fd12c0dcaefb 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -302,9 +302,9 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 		return -ENOMEM;
 
 	for (cpu = 0; cpu < nr_cpus; ++cpu) {
-		env->cpu[cpu].core_id	= cpu_map__get_core_id(cpu);
-		env->cpu[cpu].socket_id	= cpu_map__get_socket_id(cpu);
-		env->cpu[cpu].die_id	= cpu_map__get_die_id(cpu);
+		env->cpu[cpu].core_id	= cpu__get_core_id(cpu);
+		env->cpu[cpu].socket_id	= cpu__get_socket_id(cpu);
+		env->cpu[cpu].die_id	= cpu__get_die_id(cpu);
 	}
 
 	env->nr_cpus_avail = nr_cpus;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5ed99bcfe91e..5c24aca0968c 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -328,7 +328,7 @@ static int check_per_pkg(struct evsel *counter,
 	if (!(vals->run && vals->ena))
 		return 0;
 
-	s = cpu_map__get_socket_id(cpu);
+	s = cpu__get_socket_id(cpu);
 	if (s < 0)
 		return -1;
 
@@ -336,7 +336,7 @@ static int check_per_pkg(struct evsel *counter,
 	 * On multi-die system, die_id > 0. On no-die system, die_id = 0.
 	 * We use hashmap(socket, die) to check the used socket+die pair.
 	 */
-	d = cpu_map__get_die_id(cpu);
+	d = cpu__get_die_id(cpu);
 	if (d < 0)
 		return -1;
 
-- 
2.34.1.448.ga2b2bfdf31-goog

