Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0C484E16
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiAEGOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbiAEGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE7C061792
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b6-20020a256706000000b0060aa7315dd9so58376140ybc.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+LqJvo4BVSCC4z/ulo+DXz7muzrQZZ9UxIK0VJ0+cJw=;
        b=Q57qzroT+zMRuUF1+Ie93SVaslnj2hn0BlL4Y2M0HuCkicF14c3foFy6dGtMbte37Q
         xIIQlF+pxyofeGRVqaHYwPHUgtp2YdRfCIOV6RUTetsB27sUSylI7T0rQCjRbhQZ2Nz0
         R18sgxBU/Inh7kU9Nz757hQUPL+PIIKv5ZW6m2QZ8hQyO943jM8eUgL39dF/+J7otJQb
         a2D5Eqdp9JkDKtX0MTwX7bCHEXvwU0Vq8noCdqkfNHt80CYK3bHWR7hdz/hizq8KC2Nr
         9cezxfEQqVZMIe92A4P3imB/E/I/+tyDfGije++Cc6TXDlVYfnyQnxCchWpeO1vw/lFx
         /XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+LqJvo4BVSCC4z/ulo+DXz7muzrQZZ9UxIK0VJ0+cJw=;
        b=pO8d0ImqwyZd8xpOxBZ75HIhAUhn4QsulxLiewUI4b0psjEDwoXh2Y6jrYwB7s/bsE
         21FWAVzbC31ZFKWKUBRzuSjWW12+1KDwDK0fMr5/dEas+LTsMh6iLqruI9P3vYPf1gkc
         uAq+KeKY3uonIkV/FgDSsUnYfn0xANTKtT1rZMOmG2gL74TabeiJIoy/zMxRVsMxf5ld
         5gip6XxM1nBWbqmwfwBGBYV7B+GZrN8wymF4Jh+I1H4nNfsYXJAWZ9n1zvAYbBm32RGG
         ylalSouppAVgCQ8EHGx9k1dWJ2DdezFYjHmHxf8bG8bqKep7jQYQlzPdULxGyI7glev0
         EVJg==
X-Gm-Message-State: AOAM531rseyL4nt+y/yKEH1Q1kz8xMeReFGipOXzc70aA+GGkHaO1FAR
        WWVUU4A3xZAxbg+CGyB4qRWQPV0YO4aZ
X-Google-Smtp-Source: ABdhPJyVsw4dwask+PsCk9nciRkdG6/hifEVE5oeCiYDoWWUP0Scr/PViX37+UyudXFX0RJuEjQay4UsoOWa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:84c2:: with SMTP id
 x2mr19278226ybm.51.1641363254542; Tue, 04 Jan 2022 22:14:14 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:10 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-8-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 07/48] perf cpumap: Remove map+index get_socket
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
index 869986139146..69a64074b897 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -150,7 +150,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that socket ID contains only socket
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_socket(map, i, NULL);
+		id = cpu_map__get_socket_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
 			session->header.env.cpu[map->map[i]].socket_id == id.socket);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index feaf34b25efc..342a5eaee9d3 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -136,15 +136,6 @@ struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_u
 	return id;
 }
 
-struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
-				       void *data)
-{
-	if (idx < 0 || idx > map->nr)
-		return cpu_map__empty_aggr_cpu_id();
-
-	return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
-}
-
 static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
 {
 	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 9648816c4255..a53af24301d2 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -32,7 +32,6 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
 int cpu_map__get_socket_id(int cpu);
 struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 struct aggr_cpu_id cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 09ea334586f2..9eca1111fa52 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -328,7 +328,7 @@ static int check_per_pkg(struct evsel *counter,
 	if (!(vals->run && vals->ena))
 		return 0;
 
-	s = cpu_map__get_socket(cpus, cpu, NULL).socket;
+	s = cpu_map__get_socket_id(cpu);
 	if (s < 0)
 		return -1;
 
-- 
2.34.1.448.ga2b2bfdf31-goog

