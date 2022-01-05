Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF6F484E38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbiAEGQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiAEGOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8676C0617A2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 66-20020a251245000000b0060d05da9c4eso45794240ybs.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K2wBwOVyFri8+1g7YkCIisUBaXjxQi5efEY6sDY0QS0=;
        b=nVn71VGOgLwfr+GmVqVo1K35CBgy/AFV5UxEuzVlA8ZZSNL/7vpugvAw/J8MVfrgc3
         +rTa+81IyJ8PRvEnYWYqUunC6z/clp7I0YJjIkZNxY7P24sBC0KxH4oOXQx2fCvUdHbF
         LTcukjuSTrQYab2na6rucy1FBiMBXvUgVDd6GyrAy0tx8jbOwSrUuRCoQdYylUQMjRV0
         w3gooDlUSh2sgMyT1gs2+TItf5syO/8aCwP6y+76UKr8rbaLHXa6GwPcwNV64oGmDq1O
         Wqk8Bz/MPDWWvO5gOsbOtah7JCblCWGdEAvmHw0ArTM9KR9U/952O5ySv+NFY+ULG5UO
         nWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K2wBwOVyFri8+1g7YkCIisUBaXjxQi5efEY6sDY0QS0=;
        b=VvBPLUleLC3qj+ofvQQzCTXuEnfBdSnNHDL8xhAkr1J2mC+gkRU0SBfMay3QYgq4X5
         bYe0UgkUmW38drlOhzUWoKspqIL7EVbHYF+pMTKfMSjRWC8GifZ491Pf/+5rq2iR3K1e
         3joOI3QosIoPZdaS4YRBMicrSni5U4lnIGoYGQaIgA89Z9Sr2Ki8OcVldRFa8WwQ/C3R
         pTPHcO0aFMcG3F/JlbseqxOLtXu6IACrEvyvRJeb7v2/+wfn7xHhaP/A1e5pj7MtQUwV
         J8yYD1z+gZxdRbkj87HzjGdXV8F4DusOqNKIYi+MGBvmW9gZr81aJD2L44Pypw2aLEdy
         o19w==
X-Gm-Message-State: AOAM533Y3mE6Mo/7ocXDuOkLn0ZaK+EUdQp20tbExCwB/CFA/RzImUDL
        00oITuSxqv4fV5sMkVCS93RoW75Qe7vH
X-Google-Smtp-Source: ABdhPJxzM8p/CvjXb5jSkfNIAE2Koghi+sxiWFRQaRz/IQIj55KwLm3rFowpJHwwJwFmUxd2gyqSBJoYE9Fo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:868c:: with SMTP id
 z12mr47594241ybk.12.1641363262213; Tue, 04 Jan 2022 22:14:22 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:13 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-11-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 10/48] perf cpumap: Remove map+index get_node
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
 tools/perf/util/cpumap.c    | 8 --------
 tools/perf/util/cpumap.h    | 1 -
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 9a671670415a..5992b323c4f5 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -162,7 +162,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
 
 	// Test that node ID contains only node
 	for (i = 0; i < map->nr; i++) {
-		id = cpu_map__get_node(map, i, NULL);
+		id = cpu_map__get_node_aggr_by_cpu(perf_cpu_map__cpu(map, i), NULL);
 		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
 			cpu__get_node(map->map[i]) == id.node);
 		TEST_ASSERT_VAL("Node map - Socket is set", id.socket == -1);
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index e8149bcf8bfa..f67b2e7aac13 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -254,14 +254,6 @@ struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unu
 	return id;
 }
 
-struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data)
-{
-	if (idx < 0 || idx >= map->nr)
-		return cpu_map__empty_aggr_cpu_id();
-
-	return cpu_map__get_node_aggr_by_cpu(map->map[idx], data);
-}
-
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp)
 {
 	return cpu_map__build_map(cpus, sockp, cpu_map__get_socket_aggr_by_cpu, NULL);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 7e1829468bd6..f0121dd4fdcb 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -38,7 +38,6 @@ int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_node_id(int cpu);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
-struct aggr_cpu_id cpu_map__get_node(struct perf_cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
 int cpu_map__build_core_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **corep);
-- 
2.34.1.448.ga2b2bfdf31-goog

