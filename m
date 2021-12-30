Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76836481A31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhL3HVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbhL3HVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5FFC06175A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q81-20020a252a54000000b0060af1d7e063so28808426ybq.17
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K2wBwOVyFri8+1g7YkCIisUBaXjxQi5efEY6sDY0QS0=;
        b=CJTUF6zDYeq5qTNs4S2Bgt8Ohq8FeiKDhQOYQrrmiE+mH3/K4cAO+7RKiASdlFsx9s
         fuRSrF9pAt8UlzdMtMlK45cLLqZbXOUW2YeoVSIuP/nEC3EAvNIER8x2B7E/ZadQ2ZUc
         Yq/EKywuNW6UICj7/fynWjZ4XSvv3pe7trbZ6mU5am6Mc3jZ7dgOeAz6+nuFSrFqIB06
         PGHRFVGjsraigcYwWyRxSEnC+UPxDYqEEBxoIb9UweiFldZ7lmVK8O7rgxrq7MTolwrG
         WBENKXUoy5MBaa9W47O1tVRb+vWfo1lbRlI9H3a3akkbTikQrHRBHpb7cwviz4pjQDes
         JrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K2wBwOVyFri8+1g7YkCIisUBaXjxQi5efEY6sDY0QS0=;
        b=KmdjUNn89Wm18c7xvBJlItlGGZq0GPfNroCHSryGOt1FdyJq6yH2cLPEIbSVgnT/eo
         zD5kWcXLBcgI55PNA9DIbq6VTb+ags7Dt0mv+okml/THqsvEgsHMpU15Iv6pOZs2Yunm
         SUzfdk4pLE2SWckV37YvpomD7qXExcNNc47oj3/wOoyS/ssHQjPB7fPx77KI9L0c9W1G
         AYjTeWbcWZ2JIQIadV+RH/pQt0hwABOCHtrrkM6JOt6iCmz+Jl5f/jqrnqLwSvYwWqon
         xZ8I1waMnxS5hddPsQ8zf5l2mK0qubtl12qTDKgzwrKKhzFjbxmazAQ0RgfsjxFAFQ7X
         4k7A==
X-Gm-Message-State: AOAM532JanYS0R+98L+pqr9r2kgROIi+SEzNTvSrY+MbYjPax8rMJguO
        eLSl4l2alY/F1ECdmYDp5ZLcrKwi3rVA
X-Google-Smtp-Source: ABdhPJzx+tHof3NXGXJpep4lJN+6fWEen68eIw6VbrRqEd2V7NbwMPWJdWJcWVSyB4fa8+3BhPNr9aeISY/l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:5257:: with SMTP id
 g84mr19766158ybb.187.1640848863905; Wed, 29 Dec 2021 23:21:03 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:52 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-12-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 10/48] perf cpumap: Remove map+index get_node
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

