Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EC847DFE5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbhLWHtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347201AbhLWHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:48:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057F8C0698C3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:48:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so8659582ybe.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZhtwMx5XmOUxargn0OJvoWgG4zJ20RlnI8nSzXmFBiA=;
        b=cF/W+j1wUQlcKvSQ/5mNaIKiUE9tza12393fzA6WaZLhsDYM1r7PIYKxYMlEcDRnSs
         03+Wgtma4aC7HAWdsPHD9UZA1990+E9LTOO2L6HKoi8iPBYr72A3zQTZSnogBntc5r/1
         HI77yATkA+EOu4Zru5R2FbaeTqKbDCf+GNrPuIh5H74KbOVOlS/MYCbQurlMekaL89qM
         YE3ftGgjvTdWKy/GbuXk5VyaTMq6QUq3SiBkSSFQWS7povraNIfsioyV8NxLMZ/ujR/1
         l9ktc/vehndZvQPzDmnWRjKo43H0k4NQ0qAYbRxr6i1Sm7S/VvOx7RkMT/Z3HXCVkXwi
         DiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZhtwMx5XmOUxargn0OJvoWgG4zJ20RlnI8nSzXmFBiA=;
        b=ZDRO+IB7mWdFHIPsUKqrCR+81kA6QRyeRWrR/QFnWF/FoD9KyKLiSMkL3LGtUfke+a
         VlEEJndQw5I9XsGYJ1yfgnPzvPYNzakbC/bwX7pQS8C8NDxhSoo6f84AapNld5Cf7BlC
         +hcTGh3BIhmVuf4XJ9G2Bw/rlyVGVSir9kfSXWFCy8PgoGKYcfMqrxjoSf0JvK0I0luV
         Qps4mtmiUi15cnzUa595xhl//vypIgxcFWxD5/TK1Hem7lgxPWIju5u7rZpACQuqPkqM
         VF6HblFulrG1Z+RY4KxpXNUfZU/DESWHLzPDbYD1kuChXLIq4+gPHIm/cJ9vdM5bQakK
         RCog==
X-Gm-Message-State: AOAM531QnfwLELcyESAIUjO7/jhxXV6k+xJZkaluMw5HUbogojaS4uYg
        dYfBqvMum0I4pVXqCnu11j9XS5OoPFII
X-Google-Smtp-Source: ABdhPJzUOFTBp8xme2THzFqg1XjnHXFKMcITvfTbSeai3tZhHOQotzeL83lYSQ4TOw+DRzlH02104Y+uqKDN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:37cb:: with SMTP id
 e194mr1730367yba.449.1640245680254; Wed, 22 Dec 2021 23:48:00 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:37 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-45-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 44/48] perf bpf: Rename cpu to cpu_map_idx
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

Synchronize the caller in evsel with the called function.
Shorten 3 lines of code in bperf_read by using
perf_cpu_map__for_each_cpu.
This code is frequently using variables named cpu as cpu map indices,
which doesn't matter as all CPUs are in the CPU map. It is strange in
some cases the cpumap is used at all.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter.c | 16 +++++++---------
 tools/perf/util/bpf_counter.h |  4 ++--
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index c17d4a43ce06..ae5bd87ff020 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -265,7 +265,7 @@ static int bpf_program_profiler__read(struct evsel *evsel)
 	return 0;
 }
 
-static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
+static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu_map_idx,
 					    int fd)
 {
 	struct bpf_prog_profiler_bpf *skel;
@@ -277,7 +277,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
 		assert(skel != NULL);
 
 		ret = bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-					  &cpu, &fd, BPF_ANY);
+					  &cpu_map_idx, &fd, BPF_ANY);
 		if (ret)
 			return ret;
 	}
@@ -566,12 +566,12 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 	return err;
 }
 
-static int bperf__install_pe(struct evsel *evsel, int cpu, int fd)
+static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
 {
 	struct bperf_leader_bpf *skel = evsel->leader_skel;
 
 	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
-				   &cpu, &fd, BPF_ANY);
+				   &cpu_map_idx, &fd, BPF_ANY);
 }
 
 /*
@@ -623,9 +623,7 @@ static int bperf__read(struct evsel *evsel)
 		case BPERF_FILTER_GLOBAL:
 			assert(i == 0);
 
-			num_cpu = all_cpu_map->nr;
-			for (j = 0; j < num_cpu; j++) {
-				cpu = all_cpu_map->map[j];
+			perf_cpu_map__for_each_cpu(cpu, j, all_cpu_map) {
 				perf_counts(evsel->counts, cpu, 0)->val = values[cpu].counter;
 				perf_counts(evsel->counts, cpu, 0)->ena = values[cpu].enabled;
 				perf_counts(evsel->counts, cpu, 0)->run = values[cpu].running;
@@ -757,11 +755,11 @@ static inline bool bpf_counter_skip(struct evsel *evsel)
 		evsel->follower_skel == NULL;
 }
 
-int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd)
+int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
 {
 	if (bpf_counter_skip(evsel))
 		return 0;
-	return evsel->bpf_counter_ops->install_pe(evsel, cpu, fd);
+	return evsel->bpf_counter_ops->install_pe(evsel, cpu_map_idx, fd);
 }
 
 int bpf_counter__load(struct evsel *evsel, struct target *target)
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index 65ebaa6694fb..4dbf26408b69 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -16,7 +16,7 @@ typedef int (*bpf_counter_evsel_op)(struct evsel *evsel);
 typedef int (*bpf_counter_evsel_target_op)(struct evsel *evsel,
 					   struct target *target);
 typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
-					       int cpu,
+					       int cpu_map_idx,
 					       int fd);
 
 struct bpf_counter_ops {
@@ -40,7 +40,7 @@ int bpf_counter__enable(struct evsel *evsel);
 int bpf_counter__disable(struct evsel *evsel);
 int bpf_counter__read(struct evsel *evsel);
 void bpf_counter__destroy(struct evsel *evsel);
-int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
+int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
 
 #else /* HAVE_BPF_SKEL */
 
-- 
2.34.1.307.g9b7440fafd-goog

