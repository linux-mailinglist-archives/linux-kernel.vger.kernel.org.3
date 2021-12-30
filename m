Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458BC481A37
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbhL3HVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbhL3HVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC765C06175A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s127-20020a252c85000000b0060be2b7b8e9so24392668ybs.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s2CIczuM8teFDrPnQG9a+NBNIXG/EojqlmU2x3Abtwk=;
        b=No5depfbeojoeyTjZ7X0jeZ5N60dgn1waIhAAPmxijSgjjvbmxpqrbNrUkAB3+Mr69
         D9/tyQ+u8+FsA37VLb8//fuHIgaidDofnkwF9plMWNjvW5eDyWJU4IYRgzqK5MzfHXbl
         DFD39l2AlagIiMWUgF6qC5WZ/PtkCs6uCh2iGeDvSlXlTIGUi+R18PzB1EGfafYHYoWl
         XD4d4tEj3reWUVc0ZK5+uwsh8k2vT9JMkHEFM23mPzxadL98HC1zIDPmSsNkUVq+Wxd3
         cnG+lqKAwTYrG2r8++ivvKdhpB5zQ1WaR8lFH1YePvjKfQFl8FQPs9YKMa0Jv0rxKFPS
         OE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s2CIczuM8teFDrPnQG9a+NBNIXG/EojqlmU2x3Abtwk=;
        b=vT9fR1iOYfYVkfADB3jatn0FschhZ5Af05oked0BLT2Na6dqi4LGrfXKpo+V/MGvYi
         B6AhyJVwt3XMQz+7JsC7sDpUCrg4PGnFxSAchYwni+Nm07LYti2Nrgh7GNtdtJpQXveE
         Fz642cB7WtzFe8P3Mtq3X08VX8gnOHraHfmZtyGLtbOtvaCbjp6ZWJQRNb7e7EcTLfhO
         /YS2PS3mnjJT7NUuww5VawrKrGV8SK7Iime4ezCYyx7MXc5atmNIAk4PEVn1aF2D4GDJ
         d/6MmO+sFjFxDht5G7wzgmsanZINn887orD3QaP6xqpVRTyaE3X5h6uDnMUy2ry6KWYd
         kQEQ==
X-Gm-Message-State: AOAM530W5Quo4jfZ5D7zAZ/fEhRwDPHf0xmKXc+vdyoN+8vKyDRTIAnB
        PIna+tQ2HV1vMsqHRa80kFWKW9SC1rad
X-Google-Smtp-Source: ABdhPJy7jq3i4MC7xvQckm3znGI61lzyO5NMel4adhTbckf7FGFpxr8wOmkVWD/Q6KjYeJJ1bXu47PO66c60
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:770f:: with SMTP id
 s15mr20081478ybc.751.1640848875983; Wed, 29 Dec 2021 23:21:15 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:57 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-17-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 15/48] perf cpumap: Document cpu__get_node and remove
 redundant function
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

cpu_map__get_node_id isn't used externally and merely delegates to
cpu__get_node.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 11 +++++------
 tools/perf/util/cpumap.h |  5 ++++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index b3e1304aca0c..1626b0991408 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -16,6 +16,10 @@
 static int max_cpu_num;
 static int max_present_cpu_num;
 static int max_node_num;
+/**
+ * The numa node X as read from /sys/devices/system/node/nodeX indexed by the
+ * CPU number.
+ */
 static int *cpunode_map;
 
 static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
@@ -222,11 +226,6 @@ int cpu_map__get_core_id(int cpu)
 	return ret ?: value;
 }
 
-int cpu_map__get_node_id(int cpu)
-{
-	return cpu__get_node(cpu);
-}
-
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 {
 	struct aggr_cpu_id id;
@@ -250,7 +249,7 @@ struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unu
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
-	id.node = cpu_map__get_node_id(cpu);
+	id.node = cpu__get_node(cpu);
 	return id;
 }
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 9589b0001a28..f849f01c5860 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -45,7 +45,6 @@ int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
-int cpu_map__get_node_id(int cpu);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
@@ -58,6 +57,10 @@ int cpu__setup_cpunode_map(void);
 int cpu__max_node(void);
 int cpu__max_cpu(void);
 int cpu__max_present_cpu(void);
+/**
+ * cpu__get_node - Returns the numa node X as read from
+ * /sys/devices/system/node/nodeX for the given CPU.
+ */
 int cpu__get_node(int cpu);
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-- 
2.34.1.448.ga2b2bfdf31-goog

