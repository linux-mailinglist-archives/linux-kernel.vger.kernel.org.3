Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76767481A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhL3HUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbhL3HUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:20:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A22C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so42325485ybp.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9wDbHdn10g/+9EQEVPDNOOFeLcUHQZE87jycF0w2kms=;
        b=Vsmc+cYoiqunEsAtIbPHJutmmlAzgbMaSayePjB9AI3yc/s5wPOIjYwkfbP5dxXXhn
         p+YPNskrY/8HFeT0pmCZow0U5aeqy93tgkxQmepYtoxQP5ifhXBmbc4Ax0itc/cqQfBx
         Hd9hLaVGM3ID9QInmpoUsUKvbtmPnFD+gQELyqvEvfKWcFezypz3qtKo7FDOEpkTAKUR
         FDZn7ZzodFPXwL2zuEYw/c1RdI1c46dDuLFbQkmG2JpicEH2t/0HqkijYVpVMiUyJW9Y
         zfYsy5DjhZpEvdOIuuUY051mtfZg7NyvHPHs5SKoQJVeUWJ96P2P0EqE7TTBmuK9bIf9
         zkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9wDbHdn10g/+9EQEVPDNOOFeLcUHQZE87jycF0w2kms=;
        b=0qJCAwsOarkeE534L7xsYxXRrKkAtVQxJt0aDNPliFLk+Nzm266Lq20zTmo+x/OhKF
         O/O+KuWOvFaLp7u8UpnXL59gQLiChk/nmIUl2tJO5JEqR2K13s2eLSIu294+6vageMLY
         063BCJe5PU3qhrzb0PRtVMe+GzEDO7minSCsTIDr+t+Hmcj8xuBcm1jRkG7rbSgRBa73
         VyBpPzCNbkrh16lcfxPPwWOAJ+zpLN+GSBwpwf78EreNPugiOBvmGZXWvhXNAEUrRYK/
         JfFa4AEu0EFVigSUECKzY09Qli6XrYl5mmh/KOHQSKNz+9XDI0jwCQkVOp7KZLYqZZij
         YrOw==
X-Gm-Message-State: AOAM531igTPKaOkZuILgbhxzjbckuXd2Oq2RGbMstdBNefaON5b//3Zx
        0/Q0xGXAYeGfbfD3eIHe9t5d1TP0kqmJ
X-Google-Smtp-Source: ABdhPJyIhv6zQvgccPus7nZaLKGmc7HJAVbNkg2UN467+wNtOi4KykqCvyIh2no7gXbYIAhgGinqkxmF8oEC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:d696:: with SMTP id
 n144mr18608615ybg.13.1640848843690; Wed, 29 Dec 2021 23:20:43 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:44 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-4-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 02/48] perf stat: Add aggr creators that are passed a cpu.
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
2.34.1.448.ga2b2bfdf31-goog

