Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F69484E2D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbiAEGP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiAEGOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13485C061397
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s127-20020a252c85000000b0060be2b7b8e9so53246131ybs.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s2CIczuM8teFDrPnQG9a+NBNIXG/EojqlmU2x3Abtwk=;
        b=iQIZP6v+aQzjsT+5N9yl+8VS+kP6IxJ2BXJmJAzub0bF7IeOeuU7wpoypLHRvvE45g
         GSaRw8X3Y0A90fQUhksSvAjePe5Zngijp3bk1+2ATCPhZ2gWYhwiep91Y/BX6/nFlqXR
         30Jjpui33ZCipogp0BV2hT5XhnjhXi1z+Lug+4tzC2wtshmzaGUWK3UAK6+m8/M9feR6
         j+Hn/BahVyZXzVQ+PwZNOYnVw8MguTX+cV8+mUKu3PBvHwHyplaRXioz4W8Bi7ei4g9l
         U/qIol0P4d5CfKIx8LOBaNH5yeN5lS3uj8vyniPf9tYX0zpe2hG1ED81s5UHmhLXfVPh
         ToOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s2CIczuM8teFDrPnQG9a+NBNIXG/EojqlmU2x3Abtwk=;
        b=f7gvq6A3vXBGicC9Ah2FXmvSe234AdW9ruKGdlX26x2UfLMfiftXJhM2g7qYO/yKoX
         HasWqZtJKyr0ZKunG1BLlXmLkG8A8ereUoBIMtgnjknanXdjFT80R/cgcHep2Djh8cU1
         /fu8WRuJ3Z1bqwdIHAA/lcfTNgzWiHJgmMMUBKa/K9NTc3q7G/2jSVg3bSN7hgP8iGHj
         nEGI9hJybtT5NGdVTIm/oFNmFL4VkiMrxZzX6kjc1qhiDdJswB4cMSVdq5WLeEWBW47i
         M7xfF1pfCSukU4ypuv40hHKDMwKb4f2L+nDbVz6DM2fEEpQ6onNNr3IXFKfIKMl1Rotb
         Ub1Q==
X-Gm-Message-State: AOAM5321qKz0olZW6/9HMgeBXO1il5wHk/DpZ7yAun/bKFO+VCix8TkD
        eDorMwaoLzRegkoz0my/6muNbBdl7Kan
X-Google-Smtp-Source: ABdhPJwhi3sud4t5iO6w6NBX4cfopeOHeN4mFoamBz1INVVY+4KehX3qmXCk55EYnJNSBhZQ2PieSk8uqis8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:3b10:: with SMTP id
 i16mr48115251yba.292.1641363274287; Tue, 04 Jan 2022 22:14:34 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:18 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-16-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 15/48] perf cpumap: Document cpu__get_node and remove
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

