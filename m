Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380E7481A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbhL3HUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbhL3HUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:20:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A5C061746
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b6-20020a256706000000b0060aa7315dd9so29855047ybc.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g2nak5zfew4oiMxb3Bq8hR7F6MQXwULWW7e4c//RBpw=;
        b=OqFV3/mckgy62/iZs44KVQxyZhLCwcYZF8nrpzppko36XUHulgUi/uhYYv/sHl2qnG
         ZG+Y40M43qda/KcB2/0UOpfc3cXcm5hXwP/4TyOl2moCaXr8xwEj/IMwb4xzaF3bqOxn
         NUwOPMYwUDLVWl8okBp/tU3pL+Bx3X+lkYJA8C61wG8y6GjjhGW6J0xLYDkdCCdx3AJ2
         slM6FeI6EUp7ZwF7jok5cLS0BbQ7XYZyKnEFpf07tMrujqV4krQVl6JsFyGcCGONfz4d
         dK9jULKmyCCDuK+J148qGMk1i5C+fiUwK0kKjpkOnpgSf+tU+6phwIWovKMJNoMVM+Mi
         INZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g2nak5zfew4oiMxb3Bq8hR7F6MQXwULWW7e4c//RBpw=;
        b=fhnIPzvUf+fMVfoCOjssLV6IdTJJ9yEflerMu+KHh4uyMpi3AS7YOOq+8EY9Is4ikI
         OENzaVea4OPXEAeVgIQ+CrQ1WlZwP42YyqaknxEdFdbcZyTFwUIkT/M56RHCFQMFSmsV
         GkSb7JUGctirxhlNOn7/sOQVBgcEa5BYQFF8S6t5oM2aVu4E/uWWIiLT+FGhEodMaVS4
         1ro+o595meMq6RV7ppu1wQ6jTv7KCLkQUADre13PsEHPqJ2EauBmBIJpmH7+OhJmamB8
         Gav2nWr7BlbNtoYkwl5N1bTbGAyrhmds/EYQorcW9owmAYaLB9kIhawWLUZ4bmdTqGA1
         RTqw==
X-Gm-Message-State: AOAM532L6LxCDwfoFWSc7oD8f3sXbSy8JPi5amiWwPE9JMIVzH/dka7u
        gwb1XYyr7Zt4NsiN9CWM9gIAZtmeQBwL
X-Google-Smtp-Source: ABdhPJxziueaLUL8eg3hpXl7lnrpGzJLTDgN6CDHeK8HZeJdo3nhqD1DPeVXSp8xHYR1YehIkwuOoeQVzBRD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:6647:: with SMTP id
 z7mr14069733ybm.578.1640848848683; Wed, 29 Dec 2021 23:20:48 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:46 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-6-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 04/48] perf stat: Switch aggregation to use for_each loop
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

Tidy up the use of cpu and index to hopefully make the code less error
prone. Avoid unused warnings with (void) which will be removed in a
later patch.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 48 +++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b0fa81ffce61..efab39a759ff 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -330,8 +330,8 @@ static void print_metric_header(struct perf_stat_config *config,
 static int first_shadow_cpu(struct perf_stat_config *config,
 			    struct evsel *evsel, struct aggr_cpu_id id)
 {
-	struct evlist *evlist = evsel->evlist;
-	int i;
+	struct perf_cpu_map *cpus;
+	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
 		return id.core;
@@ -339,14 +339,11 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	if (!config->aggr_get_id)
 		return 0;
 
-	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
-		int cpu2 = evsel__cpus(evsel)->map[i];
-
-		if (cpu_map__compare_aggr_cpu_id(
-					config->aggr_get_id(config, evlist->core.cpus, cpu2),
-					id)) {
-			return cpu2;
-		}
+	cpus = evsel__cpus(evsel);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		if (cpu_map__compare_aggr_cpu_id(config->aggr_get_id(config, cpus, idx),
+						 id))
+			return cpu;
 	}
 	return 0;
 }
@@ -516,20 +513,23 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 static void aggr_update_shadow(struct perf_stat_config *config,
 			       struct evlist *evlist)
 {
-	int cpu, s;
+	int cpu, idx, s;
 	struct aggr_cpu_id s2, id;
 	u64 val;
 	struct evsel *counter;
+	struct perf_cpu_map *cpus;
 
 	for (s = 0; s < config->aggr_map->nr; s++) {
 		id = config->aggr_map->map[s];
 		evlist__for_each_entry(evlist, counter) {
+			cpus = evsel__cpus(counter);
 			val = 0;
-			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-				s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
+			perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+				(void)cpu;
+				s2 = config->aggr_get_id(config, cpus, idx);
 				if (!cpu_map__compare_aggr_cpu_id(s2, id))
 					continue;
-				val += perf_counts(counter->counts, cpu, 0)->val;
+				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
 					first_shadow_cpu(config, counter, id),
@@ -634,18 +634,21 @@ static void aggr_cb(struct perf_stat_config *config,
 		    struct evsel *counter, void *data, bool first)
 {
 	struct aggr_data *ad = data;
-	int cpu;
+	int idx, cpu;
+	struct perf_cpu_map *cpus;
 	struct aggr_cpu_id s2;
 
-	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
+	cpus = evsel__cpus(counter);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		struct perf_counts_values *counts;
 
-		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
+		(void)cpu;
+		s2 = config->aggr_get_id(config, cpus, idx);
 		if (!cpu_map__compare_aggr_cpu_id(s2, ad->id))
 			continue;
 		if (first)
 			ad->nr++;
-		counts = perf_counts(counter->counts, cpu, 0);
+		counts = perf_counts(counter->counts, idx, 0);
 		/*
 		 * When any result is bad, make them all to give
 		 * consistent output in interval mode.
@@ -1208,10 +1211,13 @@ static void print_percore_thread(struct perf_stat_config *config,
 {
 	int s;
 	struct aggr_cpu_id s2, id;
+	struct perf_cpu_map *cpus;
 	bool first = true;
+	int idx, cpu;
 
-	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
-		s2 = config->aggr_get_id(config, evsel__cpus(counter), i);
+	cpus = evsel__cpus(counter);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		s2 = config->aggr_get_id(config, cpus, idx);
 		for (s = 0; s < config->aggr_map->nr; s++) {
 			id = config->aggr_map->map[s];
 			if (cpu_map__compare_aggr_cpu_id(s2, id))
@@ -1220,7 +1226,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 
 		print_counter_aggrdata(config, counter, s,
 				       prefix, false,
-				       &first, i);
+				       &first, cpu);
 	}
 }
 
-- 
2.34.1.448.ga2b2bfdf31-goog

