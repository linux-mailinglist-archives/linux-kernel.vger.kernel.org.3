Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83536481A53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbhL3HXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbhL3HWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:30 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D568AC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g130-20020a255288000000b0060ba07af29eso25855197ybb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 23:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Uc3y2XubM268HoD+IkmNJwiXqvYvgqQuPR9NEiJZLmc=;
        b=UU9Pps5USbCJB4bMY54SQPTOXdYoggeqA3PNH6FHoGJpEWCJcemclzPo3evy9MM9Tw
         PFOiwuSZsYroPQcFSKpYwzB5ZfSSv7dGEOOoc0quUBwg0uPmdY/GztO9m31OIDCEizc5
         hmU2hv7EmRANtiTJbTXr1O6zp+YQKyUFq1Bp/1PWYZsvlNdDknRqgzMZDggwdNMcknXP
         B25Dix/qD0wblGheSYh68qCPU2AIrUHzja2sf/xFx5v79YZKDINeE/Whrz2w7VYK29k2
         ZPf1nH4RVbBAyH4aci0WckZMl/RZDFVZ/ryooqZ7YSTBO4Vajwx0CbhtYW9Jw+0WKqfl
         BI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Uc3y2XubM268HoD+IkmNJwiXqvYvgqQuPR9NEiJZLmc=;
        b=vgb33Ns8eWNkv5rlJ2uFpOWII6mP8pgx8qaXUQCjRXB1V5nD58sY+ZCe/Oa01Tdxy5
         g/h0jrDqF1ROHRVVrb5BmHFWnEmkXFrQImZHOxaQrWrYN8+X8r9uIOsVbnKwRlfqymyA
         ut2ioRYXzW87/89mbb41Yl1f3Z94Y6a39kJYP95U7k/l/R1T3g/lghCELQsCZy9jcBsc
         Vl0xyQEIp4rwV4XrycVG5J/sHfKuY3jfJE4+KfclOiU0vK4AqrR6U0+gw2cX7VHcdoXs
         gF3vWiI7LrBh9dLaLxN7vPNaiSpWKRedb+vMzLY+KIEwxQtwz0ST0EQXQTqMGppx14Px
         TseQ==
X-Gm-Message-State: AOAM532UhgXXTcLdA61NFWrkOqIkSzfJiDhfrXa/vxCeO5duGpIuNW/Z
        tW4jokjttBS4LRzDydn6crFh5jZ1pNLQ
X-Google-Smtp-Source: ABdhPJzmwD+JdTmKcnf+ab8su0Q2JjY8n7yE3uUXboDJEjQ387d40mnduQF8z1OV90YmVB5fjNjmBzrjrFrO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:cc55:: with SMTP id
 l82mr29556005ybf.433.1640848949072; Wed, 29 Dec 2021 23:22:29 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:26 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-46-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 44/48] perf bpf: Rename cpu to cpu_map_idx
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
2.34.1.448.ga2b2bfdf31-goog

