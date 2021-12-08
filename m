Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8000446CB27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbhLHCuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbhLHCuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4621C061A32
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:46:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so2059743ybt.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6bfD8x34jOu5STn3NXUaEPwFcmbhjjhBehQ2X1HJoSA=;
        b=rQtaP4gi3e6Dv+wHxnW8Hgdduk/1xXb7TlZkEDWLQU6EAUYl08n++hRg89Ovq63ONT
         mYqRtJRMavmHhnx3zlA1cDy164MkoDmSSixfW3EeA5ScfXYWikRwN8iKFBU3Z5AsGFni
         hK8dlWt5KIzzNzpQPJs9KNVKhRyybHDZuooM+o3rFpRuaoT9dpJ3emvpSzd9Og4BBfKT
         PEJnQhK/yL6c/cycO49EP/CkE6HlxFUv7eH1gsCGcup9K6Yfks0uhP9LPM3BYz/USEfx
         jCQQMwaQZtvBgoTxIO5PjL5lKwPufkah1sto6YzBIpnA3SIQIDospFLJPI5vqt3JrwFs
         OkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6bfD8x34jOu5STn3NXUaEPwFcmbhjjhBehQ2X1HJoSA=;
        b=khfsQi8Q/97DgIArsrwD/IcOaGbXT9ShyITCXr3VJ/9AmGUH2aVx4zL8l6dkrv7BMa
         PbuF85nI9UwCwce87w+R0cZuFbVb9BmoK8AgqRUqQtDlDAssiC9s6nJu/47qJOGGo0KX
         ri6wSrSvahR92yxhl9ye7I9WEe/stbFTzhAhJi4IhLVIfI8qTfpHsAn7uQFT+rfcWyYu
         NMWBzsoxg3UsyjRjqzuSqFq64CLBXojet+es+ljC6W88V8Z0ZW2XP49m2MncrwiNLawp
         QpcDV9vM0VJKKWlojs7cS21SkPZXnzv6G2naDE8p15XjufZL9Uq9AN9BzEWIrEv6pbbd
         9l1w==
X-Gm-Message-State: AOAM533A7jcXpHsVG0POC4JIu4T4oq4DSlrzZ7sbOy0WPu1mgukS5fle
        e4JihEocfygjkUg76OVzGsJWfDPmhaXj
X-Google-Smtp-Source: ABdhPJyMeejuWR0xQam+GCeLps0asjGdcIzjS1hCgvwzi902/LzP/O0V2yVxVPtp2jnDcuFovXeB/7xTRFRV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:d9c9:: with SMTP id
 q192mr56088806ybg.550.1638931600938; Tue, 07 Dec 2021 18:46:40 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:57 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-13-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 12/22] perf cpumap: Simplify equal function name.
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

Rename cpu_map__compare_aggr_cpu_id to aggr_cpu_id__equal, the cpu_map
part of the name is misleading. Equal better describes the function than
compare.
Switch to const pointer rather than value as struct given the number of
variables in aggr_cpu_id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c       | 14 +++++++-------
 tools/perf/util/cpumap.h       |  2 +-
 tools/perf/util/stat-display.c | 18 ++++++++++--------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index f67b2e7aac13..8fa00a6221c8 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -171,7 +171,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 	for (cpu = 0; cpu < nr; cpu++) {
 		s1 = f(cpu, data);
 		for (s2 = 0; s2 < c->nr; s2++) {
-			if (cpu_map__compare_aggr_cpu_id(s1, c->map[s2]))
+			if (aggr_cpu_id__equal(&s1, &c->map[s2]))
 				break;
 		}
 		if (s2 == c->nr) {
@@ -593,13 +593,13 @@ const struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 	return online;
 }
 
-bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b)
+bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b)
 {
-	return a.thread == b.thread &&
-		a.node == b.node &&
-		a.socket == b.socket &&
-		a.die == b.die &&
-		a.core == b.core;
+	return a->thread == b->thread &&
+		a->node == b->node &&
+		a->socket == b->socket &&
+		a->die == b->die &&
+		a->core == b->core;
 }
 
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a)
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 22e53fd54657..652b76c69376 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -67,7 +67,7 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
 
-bool cpu_map__compare_aggr_cpu_id(struct aggr_cpu_id a, struct aggr_cpu_id b);
+bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
 bool cpu_map__aggr_cpu_id_is_empty(struct aggr_cpu_id a);
 struct aggr_cpu_id cpu_map__empty_aggr_cpu_id(void);
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6c40b91d5e32..0241436bb1fb 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -328,20 +328,22 @@ static void print_metric_header(struct perf_stat_config *config,
 }
 
 static int first_shadow_cpu(struct perf_stat_config *config,
-			    struct evsel *evsel, struct aggr_cpu_id id)
+			    struct evsel *evsel, const struct aggr_cpu_id *id)
 {
 	struct perf_cpu_map *cpus;
 	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
-		return id.core;
+		return id->core;
 
 	if (!config->aggr_get_id)
 		return 0;
 
 	cpus = evsel__cpus(evsel);
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpu), id))
+		struct aggr_cpu_id cpu_id = config->aggr_get_id(config, cpu);
+
+		if (aggr_cpu_id__equal(&cpu_id, id))
 			return cpu;
 	}
 	return 0;
@@ -501,7 +503,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
-				first_shadow_cpu(config, counter, id),
+				first_shadow_cpu(config, counter, &id),
 				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
@@ -525,12 +527,12 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 			val = 0;
 			perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 				s2 = config->aggr_get_id(config, cpu);
-				if (!cpu_map__compare_aggr_cpu_id(s2, id))
+				if (!aggr_cpu_id__equal(&s2, &id))
 					continue;
 				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
-					first_shadow_cpu(config, counter, id),
+					first_shadow_cpu(config, counter, &id),
 					&rt_stat);
 		}
 	}
@@ -641,7 +643,7 @@ static void aggr_cb(struct perf_stat_config *config,
 		struct perf_counts_values *counts;
 
 		s2 = config->aggr_get_id(config, cpu);
-		if (!cpu_map__compare_aggr_cpu_id(s2, ad->id))
+		if (!aggr_cpu_id__equal(&s2, &ad->id))
 			continue;
 		if (first)
 			ad->nr++;
@@ -1217,7 +1219,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 		s2 = config->aggr_get_id(config, cpu);
 		for (s = 0; s < config->aggr_map->nr; s++) {
 			id = config->aggr_map->map[s];
-			if (cpu_map__compare_aggr_cpu_id(s2, id))
+			if (aggr_cpu_id__equal(&s2, &id))
 				break;
 		}
 
-- 
2.34.1.400.ga245620fadb-goog

