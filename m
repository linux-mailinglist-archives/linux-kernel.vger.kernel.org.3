Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB05517C63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 06:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiECEWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 00:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiECEVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 00:21:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBDD3CA76
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 21:18:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b6-20020a5b0b46000000b006457d921729so14748971ybr.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 21:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a46QziEU66/cDbtPub87VXrgG7YIg8QLWbq+SG0jhNk=;
        b=JI3XL0LVYp4aIVcMMZiF5LQC+k/3cgbjsFX6UZUIJRgGOj0ArqWK70q/CP/pRc4Pb/
         I2bc9CwhZ0RYsAlPEqXmNpu0TjCKyE9UV52oh1OnXnscL3BcWQQhetveq+XMJNQASFRF
         +v8uZCvfWZPpY5urJli9yk9S3WaVe1EYgH5CSx53MqfQPIui49iqvB9TWfXRbdYTuGQR
         IwvqwxyE5XKPA+LtPqerzVWgPJp6zZXH+X6jlOdbx2cIbr2KYyJzXtN9Z+bHlLCu6OaA
         7jdCwFxGdPX3BLI2f+vuvnUZ6fBB5qvnfND94xBN+usidqDVxbuFc/Jn58nYnf0EGj+q
         Cizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a46QziEU66/cDbtPub87VXrgG7YIg8QLWbq+SG0jhNk=;
        b=yybD24Jzm1uv3oJrQO/RkmZiE9XyYUZfaki6H7uLhanSM3rzDGhgtFQM1ozLX08VhR
         hhSefMNRDL+6RiIVeCaMs4STGMXiScrovcqbFvasG/iCJMMjPHpBcw4+MQLPjG46pLoj
         9EhpCs188LTXHlU1rnN3r1jBkamnVCanSiPJCUUBTxNLtnKy4jFIWTooiKP5SQUpftbl
         IEHIcKGgFqf0OBk/calHZsHugp8aOl28eTdwesP8wK72qtkMWSzKPUVkQvt/zXlf5Fpc
         qejcgxyTe5o40wV996fAFUuLL435GVzfxrtksj9t+a55rOhpCXf5TsUQPHua6sk6MFMG
         HthA==
X-Gm-Message-State: AOAM531iOXfkO3JuIRa6Dxylc6CTu7BI5EMkD7TwPzsdSwvnw7bOQc6i
        WW5SCt/zuhfX2bK2G84/LUHOsGzrLxW1
X-Google-Smtp-Source: ABdhPJyfalc/ICdgSYqrnMy1h3zYTiirmygQqTMEhjgiC/ZvA/YUm3m32+/MWC5pnWX2F74QpR4kP0Sw0juN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dd4b:52bb:771d:7bb4])
 (user=irogers job=sendgmr) by 2002:a25:f414:0:b0:624:33e:e486 with SMTP id
 q20-20020a25f414000000b00624033ee486mr12282880ybd.361.1651551495993; Mon, 02
 May 2022 21:18:15 -0700 (PDT)
Date:   Mon,  2 May 2022 21:17:57 -0700
In-Reply-To: <20220503041757.2365696-1-irogers@google.com>
Message-Id: <20220503041757.2365696-7-irogers@google.com>
Mime-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 6/6] perf evlist: Rename all_cpus
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to make the struct variable clearer by renaming to
merged_evsel_cpus.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c                  | 16 ++++++++--------
 tools/lib/perf/include/internal/evlist.h |  2 +-
 tools/perf/util/bpf_counter_cgroup.c     | 12 ++++++------
 tools/perf/util/evlist.c                 |  6 +++---
 tools/perf/util/evlist.h                 |  4 ++--
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 974b4585f93e..5840a9377494 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -52,16 +52,16 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 	perf_thread_map__put(evsel->threads);
 	evsel->threads = perf_thread_map__get(evlist->threads);
-	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
+	evlist->merged_evsel_cpus = perf_cpu_map__merge(evlist->merged_evsel_cpus, evsel->cpus);
 }
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
-	/* Recomputing all_cpus, so start with a blank slate. */
-	perf_cpu_map__put(evlist->all_cpus);
-	evlist->all_cpus = NULL;
+	/* Recomputing merged_evsel_cpus, so start with a blank slate. */
+	perf_cpu_map__put(evlist->merged_evsel_cpus);
+	evlist->merged_evsel_cpus = NULL;
 
 	perf_evlist__for_each_evsel(evlist, evsel)
 		__perf_evlist__propagate_maps(evlist, evsel);
@@ -128,10 +128,10 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
 void perf_evlist__exit(struct perf_evlist *evlist)
 {
 	perf_cpu_map__put(evlist->user_requested_cpus);
-	perf_cpu_map__put(evlist->all_cpus);
+	perf_cpu_map__put(evlist->merged_evsel_cpus);
 	perf_thread_map__put(evlist->threads);
 	evlist->user_requested_cpus = NULL;
-	evlist->all_cpus = NULL;
+	evlist->merged_evsel_cpus = NULL;
 	evlist->threads = NULL;
 	fdarray__exit(&evlist->pollfd);
 }
@@ -169,8 +169,8 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 		evlist->threads = perf_thread_map__get(threads);
 	}
 
-	if (!evlist->all_cpus && cpus)
-		evlist->all_cpus = perf_cpu_map__get(cpus);
+	if (!evlist->merged_evsel_cpus && cpus)
+		evlist->merged_evsel_cpus = perf_cpu_map__get(cpus);
 
 	perf_evlist__propagate_maps(evlist);
 }
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 74541bd87aa9..3a0a47ba8c57 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -26,7 +26,7 @@ struct perf_evlist {
 	 */
 	struct perf_cpu_map	*user_requested_cpus;
 	/** The union of all evsel cpu maps. */
-	struct perf_cpu_map	*all_cpus;
+	struct perf_cpu_map	*merged_evsel_cpus;
 	struct perf_thread_map	*threads;
 	int			 nr_mmaps;
 	size_t			 mmap_len;
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 63b9db657442..35e92b889c3b 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -88,12 +88,12 @@ static int bperf_load_program(struct evlist *evlist)
 	err = -1;
 
 	cgrp_switch = evsel__new(&cgrp_switch_attr);
-	if (evsel__open_per_cpu(cgrp_switch, evlist->core.all_cpus, -1) < 0) {
+	if (evsel__open_per_cpu(cgrp_switch, evlist->core.merged_evsel_cpus, -1) < 0) {
 		pr_err("Failed to open cgroup switches event\n");
 		goto out;
 	}
 
-	perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
+	perf_cpu_map__for_each_cpu(cpu, i, evlist->core.merged_evsel_cpus) {
 		link = bpf_program__attach_perf_event(skel->progs.on_cgrp_switch,
 						      FD(cgrp_switch, cpu.cpu));
 		if (IS_ERR(link)) {
@@ -115,14 +115,14 @@ static int bperf_load_program(struct evlist *evlist)
 			evsel->cgrp = NULL;
 
 			/* open single copy of the events w/o cgroup */
-			err = evsel__open_per_cpu(evsel, evlist->core.all_cpus, -1);
+			err = evsel__open_per_cpu(evsel, evlist->core.merged_evsel_cpus, -1);
 			if (err) {
 				pr_err("Failed to open first cgroup events\n");
 				goto out;
 			}
 
 			map_fd = bpf_map__fd(skel->maps.events);
-			perf_cpu_map__for_each_cpu(cpu, j, evlist->core.all_cpus) {
+			perf_cpu_map__for_each_cpu(cpu, j, evlist->core.merged_evsel_cpus) {
 				int fd = FD(evsel, cpu.cpu);
 				__u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
 
@@ -210,7 +210,7 @@ static int bperf_cgrp__sync_counters(struct evlist *evlist)
 	int idx;
 	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
 
-	perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.all_cpus)
+	perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.merged_evsel_cpus)
 		bperf_trigger_reading(prog_fd, cpu.cpu);
 
 	return 0;
@@ -269,7 +269,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
 			goto out;
 		}
 
-		perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
+		perf_cpu_map__for_each_cpu(cpu, i, evlist->core.merged_evsel_cpus) {
 			counts = perf_counts(evsel->counts, i, 0);
 			counts->val = values[cpu.cpu].counter;
 			counts->ena = values[cpu.cpu].enabled;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 52ea004ba01e..57ecd94e6f9e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -349,7 +349,7 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
 		.evsel = NULL,
 		.cpu_map_idx = 0,
 		.evlist_cpu_map_idx = 0,
-		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
+		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.merged_evsel_cpus),
 		.cpu = (struct perf_cpu){ .cpu = -1},
 		.affinity = affinity,
 	};
@@ -360,7 +360,7 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
 	} else {
 		itr.evsel = evlist__first(evlist);
 		if (itr.affinity) {
-			itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
+			itr.cpu = perf_cpu_map__cpu(evlist->core.merged_evsel_cpus, 0);
 			affinity__set(itr.affinity, itr.cpu.cpu);
 			itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
 			/*
@@ -388,7 +388,7 @@ void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
 	if (evlist_cpu_itr->evlist_cpu_map_idx < evlist_cpu_itr->evlist_cpu_map_nr) {
 		evlist_cpu_itr->evsel = evlist__first(evlist_cpu_itr->container);
 		evlist_cpu_itr->cpu =
-			perf_cpu_map__cpu(evlist_cpu_itr->container->core.all_cpus,
+			perf_cpu_map__cpu(evlist_cpu_itr->container->core.merged_evsel_cpus,
 					  evlist_cpu_itr->evlist_cpu_map_idx);
 		if (evlist_cpu_itr->affinity)
 			affinity__set(evlist_cpu_itr->affinity, evlist_cpu_itr->cpu.cpu);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index a21daaa5fc1b..e2e68f988d26 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -336,12 +336,12 @@ struct evlist_cpu_iterator {
 	/** The CPU map index corresponding to the evsel->core.cpus for the current CPU. */
 	int cpu_map_idx;
 	/**
-	 * The CPU map index corresponding to evlist->core.all_cpus for the
+	 * The CPU map index corresponding to evlist->core.merged_evsel_cpus for the
 	 * current CPU.  Distinct from cpu_map_idx as the evsel's cpu map may
 	 * contain fewer entries.
 	 */
 	int evlist_cpu_map_idx;
-	/** The number of CPU map entries in evlist->core.all_cpus. */
+	/** The number of CPU map entries in evlist->core.merged_evsel_cpus. */
 	int evlist_cpu_map_nr;
 	/** The current CPU of the iterator. */
 	struct perf_cpu cpu;
-- 
2.36.0.464.gb9c8b46e94-goog

