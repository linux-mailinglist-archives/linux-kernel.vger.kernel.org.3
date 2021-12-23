Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C21347DFC8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbhLWHrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347107AbhLWHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC808C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q198-20020a25d9cf000000b005f7a6a84f9fso8567101ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i2Vhfge4p8jg+eqgbjlb142jYxPFoaLEzdDupKyV2vE=;
        b=rcC+5g2bROePhd5WVPwNxxsovw3kJu6BWGXhGpqmLmq04IHG6wzWGxO1TaQzgD++MJ
         5pjLqme+ieWLsGnTSqhowFCo3t9sgiIDTXpMnFJrbvxFZC/HgAjkvyuWsgpnoXZQ7XVA
         JfYbc46JH6JDAQHmMIkUB3bVZkaWaU/pca4fa5WjR4F4XaI3AsYUNaG6MN8oNC1giQE8
         hMCSeNA08HwH5WMfbXahg/QDoyrOtgMLmsVn3+y6JG6yiHdm9j0E9SF7XuHbZypFV415
         sPgsFHi/HajokPYkqGM4y6KuSxPoyfn7d4/7i78W3Motn3se0/KBnQNdQlqYi/HvFIbj
         YzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i2Vhfge4p8jg+eqgbjlb142jYxPFoaLEzdDupKyV2vE=;
        b=G1GRU5P7pIky4YzrUjxcw5/4n0O9NA2ZD4TrY1xHLz2Fa0Bv1w/oII7PoJzKoeuh1V
         5BmjU9Ap01bTQv7rcPh3LGgh7x9GvN4IWbH14E7aADeMLsy29N3OsUXcFz5wwQwdzFa6
         RuuBCbVo6MuiqH+VkeRfoh4ZdSNlLjlyaxFC/pAe4Ux03a/KtgWBq6LB4nBa1IU80XSi
         FM7qpOLNszykMWzeKHUM9g3Ue17NV6q08Ph8Y1SiRze5RK2+FOxLEAF/ygIRD8kaiSZW
         xJl9tK5Se3LyJMeSubGAGByYa+86YWl0G1X46v/jqK1mVE3HE5FxNhC1Sq1EfbzhQScO
         sr8g==
X-Gm-Message-State: AOAM531EI6W/Rc9zgVpjtCGkLmTTeRIaGEI34ECd7p8xhCn6b0ZLdV0H
        yeIQJBytyD5O53M/CJqnIzd08Z7UF6Je
X-Google-Smtp-Source: ABdhPJyrF9k0EpiWni/WH5dHhqK2o2zDJaOgnPcbMN9oKEW+PwbTM3Ch2ywMcsi7eF7Dn28JvOsak5WOOswt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:50d2:: with SMTP id
 e201mr1831648ybb.99.1640245610007; Wed, 22 Dec 2021 23:46:50 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:10 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-18-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 17/48] perf cpumap: Remove cpu_map__cpu, use libperf function.
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

Switch the remaining few users of cpu_map__cpu to perf_cpu_map__cpu and
remove the function.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 tools/perf/util/cpumap.c    | 9 ++-------
 tools/perf/util/cpumap.h    | 1 -
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 87cb11a7a3ee..5a65dc7a1580 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -303,7 +303,7 @@ static int set_tracing_cpumask(struct perf_cpu_map *cpumap)
 	int ret;
 	int last_cpu;
 
-	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
+	last_cpu = perf_cpu_map__cpu(cpumap, cpumap->nr - 1);
 	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
 	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index e0d7f1da5858..32f9fc2dd389 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -485,11 +485,6 @@ bool cpu_map__has(struct perf_cpu_map *cpus, int cpu)
 	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
-int cpu_map__cpu(struct perf_cpu_map *cpus, int idx)
-{
-	return cpus->map[idx];
-}
-
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 {
 	int i, cpu, start = -1;
@@ -547,7 +542,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	int i, cpu;
 	char *ptr = buf;
 	unsigned char *bitmap;
-	int last_cpu = cpu_map__cpu(map, map->nr - 1);
+	int last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
 
 	if (buf == NULL)
 		return 0;
@@ -559,7 +554,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	}
 
 	for (i = 0; i < map->nr; i++) {
-		cpu = cpu_map__cpu(map, i);
+		cpu = perf_cpu_map__cpu(map, i);
 		bitmap[cpu / 8] |= 1 << (cpu % 8);
 	}
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index a053bf31a3f0..87545bcd461d 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -80,7 +80,6 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
 		       struct aggr_cpu_id (*f)(int cpu, void *data),
 		       void *data);
 
-int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
 bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
 
 bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
-- 
2.34.1.307.g9b7440fafd-goog

