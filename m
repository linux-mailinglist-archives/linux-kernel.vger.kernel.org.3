Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15DE47DFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbhLWHqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347016AbhLWHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D7AC06175C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:33 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r18-20020a25ac52000000b005c9047c420bso8728492ybd.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IOVWCeh5kE6zfEvaqpsG89YizqzabGkupqLnB+tiwXE=;
        b=eA5RJ3bMTokwOYkT2TLv9AwfMr248LwqYt4ywr+nUo2pLVtxMWsfRyBU0pkMiCzDKr
         J10iB0ivit7LIduS2Ajr9DyaF/NjArZuy4PWzgoaQQI71TTS+3lfDZbCT5OYSm1D5ly5
         EyBDLyZz/63LgICPG2eWk1ohMQxeoy+almSxrYE1ocHkrDj/EhoHOc2PvPac/CwZlFm5
         PkTxXAfkoJ7s2ekjXHK1YovvR9eUq6DnVw//Lh6Kr9qfkO1rre14tDU1zlRhfGcLfXqI
         1+mCPuSz5YDhVHRYiB710X6FqbY4hpEWOFW4wgj3Me87wEhg+S6XMuD70bPJZ3BNxnab
         +kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IOVWCeh5kE6zfEvaqpsG89YizqzabGkupqLnB+tiwXE=;
        b=KlczRoda6Ew3oAHe3t4USEBpZtneHB3RI5XlV22fY1m7EPtyL0hkXRu4bScmZPnuLC
         yY6AdWvecL3hr/3L4OPCh2cW7LBi7XQ8Z998vlCcEZBr8aSu1FXWcdvY24kjCmXVO1lH
         PE1iul+8M0b8QCWfuNpen621rcH8FoXkXxaY4LLzmQ2NfGzLFvDZQ8Gbn1tuHJOojaT9
         XN4dRZ0yWVkZTVVuxplj3/NiRZ8ITEtWHWTPkpOihO38n3xaLJHUhv2eifVEAV+fjPnm
         2/0rNkraRSXa+rGrvEgwBCvUYd8edDb9JT+ZCXj04wqUPiDC5NkNmQ84Gbed3lhDXj/t
         zw1A==
X-Gm-Message-State: AOAM531si49gCguT69acAgkMdTacBI/tkx/vPY+1XYlL48RtzM3q6NNw
        Xp4biVx1/G5y9jGgwt6wiJ2a1IoKvpDI
X-Google-Smtp-Source: ABdhPJzwr9tvOH9TYl4s/7K80EibN8uAtfYvMJRBqj6dDiXHyHmsyVYFLriMbY4RrsBHU1igLraiucp9wf52
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:b3cc:: with SMTP id
 x12mr1797675ybf.243.1640245592717; Wed, 22 Dec 2021 23:46:32 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:03 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-11-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 10/48] perf cpumap: Remove map+index get_node
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
2.34.1.307.g9b7440fafd-goog

