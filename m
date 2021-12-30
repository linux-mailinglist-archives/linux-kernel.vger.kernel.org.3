Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13B1481A36
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhL3HVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbhL3HVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACFBC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:19 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c5-20020a25f305000000b0060bbdf755f7so25225390ybs.14
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AifZMWGIyf5BgdMB7L7Gxo1hfuqMZZOHTMlvW2tmWZk=;
        b=EMrauUzDbodQXwVdpajk++8ACumfHsWw5rnrHEA7W2d3tPfcEG+YABoeFwpYO6R8xD
         OAYOtmihvhRP8ucbPpYNf/Tk2uO30MPBjWuulUKEgCnNgJ9jM7b8fGpF5RaWioZlsnJU
         mjWVS+a/ICbzBZAn/PJYynTNsrKaHUAxfM/JoS1qbFl3T3KuvA7GYzN4eMfS1PKlcUU4
         PCiHpnwRx/hQe/gqNRKKOpmNjZOpkx6h5UgIGsfY9iZl+75ojkXtaNMSIX56awzBkwUl
         XzKEpYranyKk9o8NN8RevLYYDm56BjHEfS9nKt0K2NxDzQTWviiw2LGkvUAroUFcSGs9
         tXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AifZMWGIyf5BgdMB7L7Gxo1hfuqMZZOHTMlvW2tmWZk=;
        b=OvqXeD5KagEOIAmpLGAHQS1mNUzzRbGKwxe6YH/sGvwnOM5iCA9eK2LdQOHcmSD7q6
         kB8N8c8kaaevG4rSgwsbykq2xOtGZ/vugXXA5pXDh49N+pF8lo0U8BXNVkI5WNlt4cki
         d/GS0Nf/Xf+QiHvY/2j6TJ8ZRIh9nYyV+2W4GCqTyPWcVT2tTyNJL9Bf+4FfDeq7gXoN
         c983q2ZKd1tePKPMd5Azl6QoXxJ4GufRyg3TTc7CzhJdiwduoC1xR6PxADSmoK80YJA/
         WsqYQcoTH7nft66w0Nt9AnJx71/DDtJbSJgtLRIIUc4eWvZbe7aJnPkb6WCVxRoQb6hh
         u7Ow==
X-Gm-Message-State: AOAM533vFjwgp620+2lXIeKOV2b5nG5ek5ED3KEzFSIffOTr9UKHJ9ti
        URxMndEaV60XCdiMeaO63OfK8kMcKOec
X-Google-Smtp-Source: ABdhPJx5b7oGLyLSZ34IJBsIh09xOeq4tVXz+P/kHZaEMUthp6EESwZO6wRsfj1XpyJiLhMx1UViLAGDXLSS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a05:6902:4f1:: with SMTP id
 w17mr2969824ybs.647.1640848878567; Wed, 29 Dec 2021 23:21:18 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:58 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-18-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 16/48] perf cpumap: Remove map from function names that
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

