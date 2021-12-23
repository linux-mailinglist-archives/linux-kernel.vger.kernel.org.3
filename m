Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A6447DFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347004AbhLWHqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346996AbhLWHq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6186C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso8702368ybi.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XMhxFWBeVRuEETnE+BwPikcCWy5mLHkNqyV9tFQoVss=;
        b=I57ah+5DPDWKDOY7/eycjwMW6xNYhZ1jfVuGS5ncB/vx1ZlIhbOrR6FKrSwZbpthZA
         M/uTasVvE1VQ4VE9MNUUvSHO4jkNkXbmVru1Sh4UWOOvtkZtkufI4/tvyaLb2lK/mUeg
         2mAhf0L3+g41Szw2v4rir6kWaq43e2nyBMf+/58Ryq2dCkbXXXSoXY68gOw1MGkjyTFR
         rBPMAerBqWq3oycoeTioSQBDHmhV1mgkwE6DFKKkOZen+xYLPgGGS3y4jdfSgADc8Dgx
         kFSwUO4tcWu2NCVc2iZ10Vpxa/d3/p0MzP+QvgLhLuj/qA3uqpwfacpViSJnNQ3dnpKq
         eYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XMhxFWBeVRuEETnE+BwPikcCWy5mLHkNqyV9tFQoVss=;
        b=L7d/o1FulOdsF1yIZ+lrFoziAi1XNteCEgFRTJ3D8+f1yDA0HLotrFFIlfzIbBTPLf
         whl9VzqfTyg/ygBHVetCsrwETizRy62SozNhjr40JWK4Wl37hs7evOI/Nfg2fGoFOR5E
         GZHZG/MErFiCv7k9W3kcnPjx/8jw9HkgUm/joWLQGQi7cM05LeznyVQ+fIFvWTt7bp0P
         9D2MxgC6zt98hIJgURkdhTDRUD2qj+lBjZ1yb6N1xDAIaaWITJTl+Mha9IhjoW14L6IE
         cW6yYNn+cUe1xkXCoe4rY9OP/yXCqQD5TMb897HOjFAxA678VgXd7oAUJxO9k2LXyuZP
         gpoQ==
X-Gm-Message-State: AOAM5311XmWPL4NQP5qeBHrr8PxaySt/TE0/xyo7JQXuEY/1uvQIyHeT
        f8gjuVrBUdWC9rhBbhlfQyTPY9zqtQnS
X-Google-Smtp-Source: ABdhPJyGDKLEdbH97OTrkXsESmtagS+ejAQGDy2zvluksa3GsQzoOmQS9wGFqpCbULRTZC+qoTrzr/mJEm84
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:1fc1:: with SMTP id
 f184mr1663842ybf.687.1640245587870; Wed, 22 Dec 2021 23:46:27 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:01 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-9-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 08/48] perf cpumap: Remove map+index get_die
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

Migrate final users to appropriate cpu variant.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/topology.c | 2 +-
 tools/perf/util/cpumap.c    | 9 ---------
 tools/perf/util/cpumap.h    | 1 -
 tools/perf/util/stat.c      | 2 +-
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 69a64074b897..ce085b6f379b 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -136,7 +136,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that die ID contains socket and die
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_die(map, i, NULL);
+		id = cpu_map__get_die_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 342a5eaee9d3..ff91c32da688 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -216,15 +216,6 @@ struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data)
 	return id;
 }
 
-struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx,
-				    void *data)
-{
-	if (idx < 0 || idx > map->nr)
-		return cpu_map__empty_aggr_cpu_id();
-
-	return cpu_map__get_die_aggr_by_cpu(map->map[idx], data);
-}
-
 int cpu_map__get_core_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index a53af24301d2..365ed69699e1 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -34,7 +34,6 @@ int cpu_map__get_socket_id(int cpu);
 struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_core(struct perf_cpu_map *map, int idx, void *data);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 9eca1111fa52..5ed99bcfe91e 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -336,7 +336,7 @@ static int check_per_pkg(struct evsel *counter,
 	 * On multi-die system, die_id > 0. On no-die system, die_id = 0.
 	 * We use hashmap(socket, die) to check the used socket+die pair.
 	 */
-	d = cpu_map__get_die(cpus, cpu, NULL).die;
+	d = cpu_map__get_die_id(cpu);
 	if (d < 0)
 		return -1;
 
-- 
2.34.1.307.g9b7440fafd-goog

