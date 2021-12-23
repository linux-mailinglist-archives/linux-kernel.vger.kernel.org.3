Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082C147DFC4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbhLWHqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347041AbhLWHqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:40 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F9C06175A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:40 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so2852518pgo.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5u9uOvrM0MZW4hQbQrlJVSUOMIL0GMHYnyDBSXZC4ik=;
        b=qIVAAtr6ofyUe6ovBipZf/c3cfC9KP2iym9VMkWZ4IVlc+tsXbWVqXAa1VrJxlRlNG
         cGUqPpCr0XoycqNLxyVHg9yY6QxvehmlfyYLGTNPVAzLWmWtPlP3zZci+2xKNxyJdMlh
         UgZHnrsETcaQz1wXVRdwJPnfA8yH9siGL2PQq44JxrjhrSkhXqdCdyfvHZhMqzqdhBDA
         qp4Csm/vekB5JSLS3+zLgvea0ib92e9kNtnrPkN5507gWo3oAbjbvgAYuZ0oQPehKGy/
         kMIiRpvJJpgJ9EkHWxHzyJ+//Nf93g2E5qVTUnoYY6rZAkXwgti4aeCHEdH4et9cTmJo
         xw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5u9uOvrM0MZW4hQbQrlJVSUOMIL0GMHYnyDBSXZC4ik=;
        b=0w29ChAUECh6qM3x962GYW08BusCqTSHuo+93xMAaKKxRnWpL6QHCNcmC9XXwl+pZC
         TD4P5umhelTnxFQAaMnRLDb8o4lWIwomWR42AuxznquYI9l20swg/cPA+7sgh3tDmYEW
         Gpa1o4tT3fEVgBpP8YVEYnM/BDZ2BaFNqd/63rcAieyWxy0BvlyxP3ats69kmBh77HkT
         ZltCh5SCX/2lmYRaDoQOFOFh9rwXDzRN2HEbiF+vvdZMMlMcKmD2QC5CFc/4aWmUUJMH
         sGWUrPM3kjD2QkoZxfOU2bmG+ZPXGMb8W9XvNRMy+f249OkwKGOkIU15ddnZFmr0ozLT
         s51w==
X-Gm-Message-State: AOAM533GfbBW0eNwckSuB5rssGtqos0vLG/E9wVdXKdc5djK/M4aMea7
        QB2JNXbnRK3IpWU0fFsnAw748F6MLY13
X-Google-Smtp-Source: ABdhPJwlhHfxKAtk99Bk5IZEENVaNeKaQwYA2sTDg9XONvjMttn4NmO8MtIsYPprP67p/o9LkTxB5nLnKDmB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a62:8cca:0:b0:4ba:d6d4:7bac with SMTP id
 m193-20020a628cca000000b004bad6d47bacmr1310531pfd.43.1640245600048; Wed, 22
 Dec 2021 23:46:40 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:06 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-14-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 13/48] perf cpumap: Simplify equal function name.
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

Reviewed-by: James Clark <james.clark@arm.com>
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
2.34.1.307.g9b7440fafd-goog

