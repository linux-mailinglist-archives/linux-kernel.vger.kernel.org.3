Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE047DFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347139AbhLWHrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347041AbhLWHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419D1C061799
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l145-20020a25cc97000000b005c5d04a1d52so8598506ybf.23
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R21tXxp1l1AKkDbM35zGCh/17/tAm03C0wqwQ2IqSuo=;
        b=VHhXnyDVum/RJBo4Ca9fkxRCfGhgzoktW/whBrzenk3Xdmcp6dtMnTxCt/CCcLoqOH
         VbCvTqhRAunNEERDAasbkM2xC/65rP8JYGlceGf4cshyQf2wlZdmU2/eFak7a1JjkX2s
         7xjVBsCAI8jIWoKIR1l66CUtzlskcAD686SGp+X68lBX/91XoCgaS8YamaTQadQOMoMo
         m8f1sR3Wkx4Yg7GRkGVhoY24aVgOWxra0DDCProKG6p4p6suFRW3fJSLuPFC0CO/Ge6W
         doN81u5GyBnqKO35Gr3fBETdhR/U+/ofG/WxqD3OIlJKJ82v1HqfvfauehBhfrmewZBs
         JXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R21tXxp1l1AKkDbM35zGCh/17/tAm03C0wqwQ2IqSuo=;
        b=fJv0Qy3qcwwOqLTABGwv4A9l+WG2biePyPdIupwhfa76B8zkq7YNzJMu/A/P8XyfGN
         cQO60eT4Esd4aMG6M1GhgC9rW148Yq0Q/sa2QG1fyVuAAFRW/zprdZ3v16onBIqq3ZsS
         qRyZ6brCOW2mtxDLL7CYtvBGGECiKdJ71eAtzqrnh5iavjkzxet99cdfMKSrdNDsDhq5
         rBHLDiFMuGz0Kw+8XGdgZiatTw08mYP+w1gBq/PnKXgV08+ydjebb7JcYFIZrohbkwxf
         hUNEdgj1hpoY40GMR92/lR6yupdLtp7Xb6S8F2f44Zj2ggwD5q5yoZBFq1rU2+wKf9QT
         gjYw==
X-Gm-Message-State: AOAM5307DoCNEQ05yeOAtPJ5Nqfm1qGuUUN/kzsk2Ske2aezqmRkY8dz
        zrFY//DsUgGGUkdKNfqrK9mgHbw/nS4T
X-Google-Smtp-Source: ABdhPJzaNCjESqzmvbKHasdNOlQwdpDftojOkPDGRCHos1IqTsfSMmjBuTWnBKaL6YyeNTd+uxI0u6/Hni1T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a05:6902:552:: with SMTP id
 z18mr1690671ybs.318.1640245607469; Wed, 22 Dec 2021 23:46:47 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:09 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-17-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 16/48] perf cpumap: Remove map from function names that
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
        linux-arm-kernel@lists.infradead.org
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
2.34.1.307.g9b7440fafd-goog

