Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664B346CB2A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbhLHCu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbhLHCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:20 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17682C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:46:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so2108888ybd.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yWryFkBaKXItOT5wxb/1aCUszQT6KV+MELNMY7hNYmc=;
        b=ILUex7IwpHqD+AEwW4x62kPZzTA/CYgl3v8ZeKIw5S5376KNkCGxNvK2BMIjMVp/2t
         zGIn5V6218+1vQyi0Q4CHN3XdJ22vF4sT6xiBb+4f9AbGbuvJjYFcTgEJGHlg9W225+B
         6vqhj/Df4CXIgWum465LuzDL1uKzKtSqQ6c2ouGIXKQgj5U966Spgj8jNQU+ltTM7CLJ
         SiiWhkxaHvzM8Unqjdps0juK+Hmh12tU4OI2NSrqTblxFM03Z4eq0aYfO1PvFRSJUPlQ
         o2fahWl9Z1HY9JG9udjWwBnzvDL2UNgUn3KDxyLjoZThS8nygz3qjUv5kjL0oUzQIqsI
         3LFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yWryFkBaKXItOT5wxb/1aCUszQT6KV+MELNMY7hNYmc=;
        b=XNrpNQ4isa3nStUEROBl06HKzQU8SbW2JRZWtmjVdnufzpfeZDi33+bqZxAoG7BDTF
         +KWZyBEBr9w4UwXL+WFLAd9KvHNnWurVgUF/hOx0HBK/6r2h6DCyLLmnawKvPPF9slrG
         6uYYo3wmgQtg9fe46qwhpm2koiljDdgQ9g/4qKO1E1tdiSOfsJZH5r93hZM2uTo3lip8
         xJzP6pY9vI/nz1anozs6v+4VcDU4C5DWt5ww0CF/waOHiTVz6ZPamVAquLhWTQBtf2Um
         Ld7jxbgKINX7Vlt/9GC/3b6qAoqk5ZY85XrauivL4hqVIlYQWkd+JA+n4HkqvXaiY62d
         pXUA==
X-Gm-Message-State: AOAM532Xt3b40LjvyMHTDWUgx5296EW9NJYz1BpiKnoRQMIXNQUjMdxI
        gfPYYIQpFdgUUguo80B4dVZ7pHL89Gtn
X-Google-Smtp-Source: ABdhPJzcWlyZtK65/NHhHK/C1FLwYsSX6nS61xY+d7BKu78BPseVS/q/WrEfXbGFZi+Q88zgPDcEj8Fhtjv/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a5b:112:: with SMTP id 18mr55869675ybx.489.1638931608180;
 Tue, 07 Dec 2021 18:46:48 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:46:00 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-16-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 15/22] perf cpumap: Remove map from function names that don't
 use a map.
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

Move to the cpu name and document for consistency.

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
2.34.1.400.ga245620fadb-goog

