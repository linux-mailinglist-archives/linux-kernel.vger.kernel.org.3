Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8733B46CB22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbhLHCuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243416AbhLHCuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63ACC0617A1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:46:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so2125493ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J1VNQ1HusnRkUXhWK22aY84XUSperCn3TfBFSq+Tv7I=;
        b=UsZViv6fydT4vGqTiP1jYbElZnktDtaHwAc1EcLtf/kdnYZzFz15rBedKP0uviHOYt
         gG5y+vhgiVXgc9c1k1no30yRmhba8SjVrvde95ZIv8FyYoGNYukxk56fWmdSpmBahd3M
         VsiPejDXVpaojDcAhmoyBa0Je0rArUlLfzdKl952RkApLExcT4fWVrwimzyPV8196Ijz
         Dj4qB03kUxJaSoJRbSvn1F0qrdwGTQbwI470iAYqFltMlaens0m66FXysQ/6qG9SItAp
         GP9JqU5fdzcDRFe6m7mI+jmaAJ+dwVUjZ5JwySeqs04z9x25xzpCSnGm/FyrWn05um7l
         zjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J1VNQ1HusnRkUXhWK22aY84XUSperCn3TfBFSq+Tv7I=;
        b=yRrF0hH8WYtzHKjCcvjsp0vR3Ase3vgSLfevSM3OfRyPq3YD9ccdnG4muMQwLT7r9U
         AhwqL2Uho2KWisb3VYy+BpMZp2vnHXf3BmcRmDA9nfmSH06dMTe6YClWNafyABZLOdkG
         QIxOBDW50P+ztJnWpZKvN9acb9pUuZe9gDac4EWmzedXyVrhNMeBaEnOlSWfeXVr+H8q
         Puufv5eKteEnA/An3/YPN1BRktRkMfo8ZSxoOvFD9MXxRLKTRKYNWaHRphfSnE7fHktr
         Z9BcMRqXEjv3OqFxrvlrLH8ImZgKur1KNzvS9k7UjjAdtN3YtiI3D04sSdRGL1pFJ+oy
         yOnA==
X-Gm-Message-State: AOAM533XV708LV+pFDdX1mgaiftCKpW4uef9gasFC4ny/0svbCmc7NnV
        yvOLHhLzqRtCXXhnZPSRVhsjwihfPV4U
X-Google-Smtp-Source: ABdhPJwxteuC9TX3q8t0UuBejaQhufDVxq+Ddoljixbo2nAcrkHufLCBkz0PVRDnxpMQn7IZMuwyFxKZBotI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:b57:: with SMTP id 84mr55389036ybl.261.1638931589032;
 Tue, 07 Dec 2021 18:46:29 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:45:52 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-8-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 07/22] perf cpumap: Remove map+index get_die
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
2.34.1.400.ga245620fadb-goog

