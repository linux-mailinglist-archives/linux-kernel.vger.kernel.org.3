Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4BD47DFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347074AbhLWHq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347081AbhLWHqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0727BC061763
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d205-20020a251dd6000000b0060977416ad4so8515074ybd.16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oK4z5E5fiyzkgFCJbjPVTXl+1a3iQ4V/763qtnP+njI=;
        b=FJ470XTGu1n28V1ATGzFkx+a6y6IY7sA8YqbHakatI88rGF0HcROWHQ7c+agHMxVGQ
         ipZRdI2SLwQ6Q4zx0go2BxMm9pWQrnTq1w1xsgCZPWvIL0oT8/09FwThJFmBKh9kwQw1
         eaLr3iKbvTNJtLGZN44476RGQaz+qCAvrAFRn5kvTi9hrWPVGJD6OnjmaGaar2/g2vit
         C2kYNb42EjdduHlZMy1cRWyL0DeNfakffPV2owzKsQWI34nNvfESCEwnKvRxQOgb1I32
         Q67p2LBNN46xiesFBCBufpIcfId3DLncPFbxrhDFoJv0lniPufGKQYSTo+gY4a30MDwM
         p/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oK4z5E5fiyzkgFCJbjPVTXl+1a3iQ4V/763qtnP+njI=;
        b=HH9uXjXy/eRNdENIGAwKV6hl9KERoE2Xvb3O4vg0fhF/y2DbN0/l6I3EpjpkVXl+JZ
         ENkTTvKVm3JrWK9xE3lNBOHiFoLJkOJS+zklUZw9beUSrc4jZEdSumqLjzaszZS/slXV
         1UZdnEW3hK4IOdcT/B6VznXuFKb6PyEsFx46eBz5ZaA8xZz4d30tDWNsV/PKYs0XXoBj
         BbfDxzplMjz7jS3GI/LVedYuJ7fbFa54fGxO5EIiFGiabStTOc7gZhdyTE89yzMSkPzp
         tr8IrNkBkhcajuQ7ltsCrFLHvafriQRcL2p3xajN5N+FQFFZbEzNu84SKviyBsxOhdF4
         FGkw==
X-Gm-Message-State: AOAM530JcZ1KBDSech9In4b9IG0XOq2Z7XIqGH6Fd24w/mC869puAcfO
        xpFryTrjfyHVfF1KivqJrE3Wdpk9z0lm
X-Google-Smtp-Source: ABdhPJymUOB7LGtIX2a9eR7ad1c348HlWb3l8JGGmoCGMzqjqRvlco6jPwBosbOtjOlDzUZa4aiCJXzdmfAn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:abe3:: with SMTP id
 v90mr1636040ybi.315.1640245605233; Wed, 22 Dec 2021 23:46:45 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:08 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-16-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 15/48] perf cpumap: Document cpu__get_node and remove
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
        linux-arm-kernel@lists.infradead.org
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
2.34.1.307.g9b7440fafd-goog

