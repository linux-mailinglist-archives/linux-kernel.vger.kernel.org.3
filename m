Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9FC481A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhL3HVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbhL3HU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:20:57 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1139EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:57 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id d31-20020a631d5f000000b0034152d47c81so6717948pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+LqJvo4BVSCC4z/ulo+DXz7muzrQZZ9UxIK0VJ0+cJw=;
        b=Zk0u1Y2XNOTQKFIxwDfroXvxum3RgRaYfZsIbytO+ukBLPO9fTAUoNU7fPjZWgJ4Yo
         lrJFeu2zX/DeksXGummcXomq/oZaGgC/c5sBvbXxLag2Ztd3IhyYTwFOz9H9xlKNMPgi
         NREQ/501fA1hGG2nELiUUdbrFESjSWkYG7kRZqxPOPiDeWvUmvAiTliMJ2HYcKjAwkmS
         74VP+tIqqGyvYLYgUgeIVGTi/CURq+mRw46wHbWpx+2/QRk9RHEr1zT/G5wYjFOklOg9
         jCdFhcQhqh241c36Fmqa7q7wLePsnCgXi64K7vLjrHer3/P/wL0+lIDo22DP5AKT50uM
         Mf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+LqJvo4BVSCC4z/ulo+DXz7muzrQZZ9UxIK0VJ0+cJw=;
        b=XrbEOnmomy57FezHWF+wVq2wtI2ydrLjy2d/j9v6L9T93Ux6XxJ4d+c5KTsrDv2Z0E
         CJUIl1r4UqKYxvdEemeE1ySYxdOA2hwvQ4Udv2eXFxvGw2Fj4r+3L/AIkN4EJhpiWzBI
         3/0kx1INhfhXN/AHRfP30avqolHz6ZlusknOzQKB64wbfpVOafoAr40meFM57QG3AWVS
         1Ov8E/z53XQq34OTxHeGPYoDjs9WaZllr76JLWbfeRBm2EN1OCTIlEAIGOSxTASNq2ey
         A0Nmt8tE7KEAdCiNL+NOwuqPDS8WO7BMdiRGWymkLU8emkEfPhlt9N+80oJxprq55mJ2
         nR7w==
X-Gm-Message-State: AOAM533cgM/NkM5as3dqMV7tkgeKOjSx4AaTQangcvjI3iiKsy+EcVZh
        533o8x5ZgRKe8jk4SYsXhv/cXedHDoSi
X-Google-Smtp-Source: ABdhPJyDsBDceOWBSNXUyP+oiQX6volW9+o6TW99zHzgGttRoX0f65hB71Y+QaqZq31SuAWqdGR3cp144g8B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a17:902:7489:b0:149:2088:8e80 with SMTP id
 h9-20020a170902748900b0014920888e80mr29859106pll.124.1640848856490; Wed, 29
 Dec 2021 23:20:56 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:49 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-9-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 07/48] perf cpumap: Remove map+index get_socket
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

