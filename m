Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C078484E15
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbiAEGOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbiAEGON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66A8C061792
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:12 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b6-20020a256706000000b0060aa7315dd9so58376038ybc.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0PQ2wkiHIZCukUmO6iPoQYJEB6vBau09xCeEdVn1F2A=;
        b=ao3/JOq0jt6cEOE95TP70/lXKLkwkkl9MexNgro7Z7OHcG7bJnHPaXM/0zv0lyMps9
         Hf7eglRxfwKfSjq26FtiDP6fwUz2AqNgAFF/xh3zzM4E6ALkKGIpxizVAuy1VRfMMJPh
         OAWMaKT7MctWoQkNdmPQpZbTjFrawyuvDPpU5Hu1tAWPO1hRSEygEtEDOahtUgqR86wO
         cwD46lHgQdbdQoRzJCChL5/bPi0BobXPBpDj0evcMkVB6c60p93hdCI0YEFQ9PRVdHKq
         THKMNb9CM91449BxNC8FXH1UG09pZyl5Vs4cnzACh9lHN3JcNWedISlh36tTjr2OW3u0
         Tcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0PQ2wkiHIZCukUmO6iPoQYJEB6vBau09xCeEdVn1F2A=;
        b=QktP2I7fKgH4Illk5oYZITa7PmlTms5IEQu1BSekL5E9+7+3egAjrpo0SbNmJeGXyn
         v1yewsSolitz5SMMbZkRKzFJNc7fjMiAez76+yp3oNCvhNkhYCDBDzMe8UzbLnrybdg3
         5xhncjO6OWa+fZ23zfGZWXMXS/Hj6H/oPFMeESgMUxwbmUTlQvJ88TuhB1Q3FnE9LMjN
         jW2h2j9GJ3gyWg/qdJ5PA/jc87T8XsXUu9C9+a7H/0wt7A5sx/NaodRnu/FivJuiIlTs
         koP6Gp2nFjD8Vgdi3No9sn47g8mJJswDSeFN4pBGCuKXcmFxLH3V9A0tJmMmIIF+ndsE
         64AQ==
X-Gm-Message-State: AOAM533pwvUSw4BDcsrJ7kgEDqzfhix4a3eRDT9g2WqbpBGuKLayy6WL
        l/rdr6OaKxj5CANqgdO3cAs+F8YMCxGk
X-Google-Smtp-Source: ABdhPJyhMr13RmNR7cBkonENDbEAwyprsj3NYbShlAT07r+Rg0Ce82UprdmAOMsi5yqpnje9X/Pjtxe6y2qS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:b315:: with SMTP id
 l21mr48071813ybj.207.1641363252171; Tue, 04 Jan 2022 22:14:12 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:09 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-7-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 06/48] perf cpumap: Switch cpu_map__build_map to cpu function
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

Avoid error prone cpu_map + idx variant. Remove now unused functions.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 28 ++++------------------------
 tools/perf/util/cpumap.c  | 12 ++++++------
 tools/perf/util/cpumap.h  |  2 +-
 3 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 9791ae9b1a53..6b985abaa2d2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1504,11 +1504,6 @@ static struct aggr_cpu_id perf_env__get_socket_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_socket(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_socket_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1527,11 +1522,6 @@ static struct aggr_cpu_id perf_env__get_die_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_die(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_die_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
 {
 	struct perf_env *env = data;
@@ -1551,11 +1541,6 @@ static struct aggr_cpu_id perf_env__get_core_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_core(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_core_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 {
 	struct aggr_cpu_id id = cpu_map__empty_aggr_cpu_id();
@@ -1564,33 +1549,28 @@ static struct aggr_cpu_id perf_env__get_node_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-static struct aggr_cpu_id perf_env__get_node(struct perf_cpu_map *map, int idx, void *data)
-{
-	return perf_env__get_node_aggr_by_cpu(perf_env__get_cpu(data, map, idx), data);
-}
-
 static int perf_env__build_socket_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				      struct cpu_aggr_map **sockp)
 {
-	return cpu_map__build_map(cpus, sockp, perf_env__get_socket, env);
+	return cpu_map__build_map(cpus, sockp, perf_env__get_socket_aggr_by_cpu, env);
 }
 
 static int perf_env__build_die_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				   struct cpu_aggr_map **diep)
 {
-	return cpu_map__build_map(cpus, diep, perf_env__get_die, env);
+	return cpu_map__build_map(cpus, diep, perf_env__get_die_aggr_by_cpu, env);
 }
 
 static int perf_env__build_core_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				    struct cpu_aggr_map **corep)
 {
-	return cpu_map__build_map(cpus, corep, perf_env__get_core, env);
+	return cpu_map__build_map(cpus, corep, perf_env__get_core_aggr_by_cpu, env);
 }
 
 static int perf_env__build_node_map(struct perf_env *env, struct perf_cpu_map *cpus,
 				    struct cpu_aggr_map **nodep)
 {
-	return cpu_map__build_map(cpus, nodep, perf_env__get_node, env);
+	return cpu_map__build_map(cpus, nodep, perf_env__get_node_aggr_by_cpu, env);
 }
 
 static struct aggr_cpu_id perf_stat__get_socket_file(struct perf_stat_config *config __maybe_unused,
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 49fba2c53822..feaf34b25efc 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -163,7 +163,7 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 }
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
+		       struct aggr_cpu_id (*f)(int cpu, void *data),
 		       void *data)
 {
 	int nr = cpus->nr;
@@ -178,7 +178,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 	c->nr = 0;
 
 	for (cpu = 0; cpu < nr; cpu++) {
-		s1 = f(cpus, cpu, data);
+		s1 = f(cpu, data);
 		for (s2 = 0; s2 < c->nr; s2++) {
 			if (cpu_map__compare_aggr_cpu_id(s1, c->map[s2]))
 				break;
@@ -290,22 +290,22 @@ struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *da
 
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
 {
-	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket, NULL);
+	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket_aggr_by_cpu, NULL);
 }
 
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep)
 {
-	return cpu_map__build_map(cpus, diep, cpu_map__get_die, NULL);
+	return cpu_map__build_map(cpus, diep, cpu_map__get_die_aggr_by_cpu, NULL);
 }
 
 int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep)
 {
-	return cpu_map__build_map(cpus, corep, cpu_map__get_core, NULL);
+	return cpu_map__build_map(cpus, corep, cpu_map__get_core_aggr_by_cpu, NULL);
 }
 
 int cpu_map__build_node_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **numap)
 {
-	return cpu_map__build_map(cpus, numap, cpu_map__get_node, NULL);
+	return cpu_map__build_map(cpus, numap, cpu_map__get_node_aggr_by_cpu, NULL);
 }
 
 /* setup simple routines to easily access node numbers given a cpu number */
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index c62d67704425..9648816c4255 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -63,7 +63,7 @@ int cpu__max_present_cpu(void);
 int cpu__get_node(int cpu);
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-		       struct aggr_cpu_id (*f)(struct perf_cpu_map *map, int cpu, void *data),
+		       struct aggr_cpu_id (*f)(int cpu, void *data),
 		       void *data);
 
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
-- 
2.34.1.448.ga2b2bfdf31-goog

