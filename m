Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E33481A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhL3HVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237105AbhL3HVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0118C061751
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q81-20020a252a54000000b0060af1d7e063so28808227ybq.17
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I+B8qrA2cd/SP8Q+1EIjfviQAYs+Z/hoSScOqv9Gel0=;
        b=lCkRWKAn7Fa+jfz0d4hgkdKJv2mjjGswz+NBQBUOuRSoCdOBKJbyl3sEvCZH9S50rw
         PS4AVhK6dZ8fNZf57BsBrrGwEHk5IejbHwTK9PDcvy3qbM59VWWBOlAyxBkEbBUKzLwa
         JjQDd3iq9sNkIsH9g5Umm4CJ8rbSoehVuzGnUJIKTvNjp2GOCjWXCD91TgzHAIjaF5vc
         EuRtkvY2PYQ9GkbyJya3wkcWUDL0iLHN/fbnenkRx8SME6nB7Ga7R3Hu0eZPb1CFRiUU
         muh9+6RsbFN3cziMaL4lHVrztq3YFrdODhj7VSBN0UZ8Ufjj7wLpanYnbAtheK9k7dfM
         65Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I+B8qrA2cd/SP8Q+1EIjfviQAYs+Z/hoSScOqv9Gel0=;
        b=YtGOxYJIjpvmGaTp+WvLTre2p6wAQ/qhTK7bnRl/WYl1e9sRke6Yh660frOE3o71FV
         J/6sDtdKj39CoVULN7RosnnBsR792C21/wb3H4L8q0prcfWXQbCjR1wR31bnTttiRQev
         m5FyB09zk+IGtC4FeEaFiXOMFSdP9L1grKrjLWKZGUjZ3PzCcVM0jLNamMK+L9VEsE5U
         T62180k9JNlnndCrLki2Bv+8EJKx6odAP2LWWjZEiDMVZbmf35KegfbdMXnGX1dmwzHP
         vXt5DZ3MyUJtDw44IPlbE4ryemwUvIZooSQ9G8BzNATNUPwgbVCzOtSuLA+87xsmaAbs
         gzjA==
X-Gm-Message-State: AOAM533M5UKwQdnyPe33Ght5K2bMEOlv6ogpi60V1Fizrn9WCcgkN3n/
        qTnS7A9QcOFWfWDYkaZDO/1zBFFEzF/b
X-Google-Smtp-Source: ABdhPJwyOytQjn1OiPL02zTtOTw3G5TCU33Bkd3QWN2ohtlxmVv02HGZDXzkKLx1KZIDhEkQYV0+4Ot4P8+n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:2d6:: with SMTP id 205mr28389439ybc.425.1640848858996;
 Wed, 29 Dec 2021 23:20:58 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:50 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-10-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 08/48] perf cpumap: Remove map+index get_die
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
2.34.1.448.ga2b2bfdf31-goog

