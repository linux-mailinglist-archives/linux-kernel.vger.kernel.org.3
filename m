Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AED9515AC6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 08:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356068AbiD3G1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 02:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiD3G0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 02:26:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A1F67D2D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e642be1a51so92754327b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 23:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tcObfq8Nd5uZdGvF9hEbsjXFIltRilEurI4N4H1VAUs=;
        b=kZeIqQt8Ii5glk0K9RWxv0Y8+tU5rwCkZR338TAwJ+F4sK4BcmaamZUmfXk7dLwAzU
         VcAu8hPA+YnbCzBEFGaVJDaO/7EIWXW6g7yMvzlH+7J7rD0paNgo8fIyCG+rSklun8RT
         R1rwEcQ1YgSx8WpDsKQIo3fz2WpK++CLYWnER5hRDPdezR/tekx6jGwC8mCMRAVjEWL+
         HHk1XZn/2UTN29Ove66JZ2zHyO356yYI9ODkydGoFcU2vXkDAUrMvLA5HxMCx4I7q6PZ
         s4pEROX7VJeB0owJx6mYlLjmfjzG0wAxJ+rbedBvOek/OnQoWNkoFCJS4lt4j+/KFcbz
         1c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tcObfq8Nd5uZdGvF9hEbsjXFIltRilEurI4N4H1VAUs=;
        b=QX7IPnxZQiLv4YWejt9M1bvHGxrcIBf62H+itU0t9ygfi/kODgwnSGfli1r9kJw8+r
         3nqwDmuVYu7eA9Eu8olah+CJQDSGPTMuxB12Yr22OpLklo3YAKMs/d0qSDPWuYJp5iwv
         49X/+7sXxwdOezyaNe4wTXhAht/f7jbJe+GO+iq9KlIf8UtnLr+g+diF/qSeRXll2HFj
         WCXueKKETdd5C963J0ba3KEs3bn5lsKSH8y/6SRnAR5PMH+y0VYLETBUwFx9NO8J4tzf
         KanuQzZVX6HvZ0oJnpIIB9CzTJ44qLLfheAj6dN1XJ6V/exCc9ifteRWdSoxlGqtF9Pj
         4VJg==
X-Gm-Message-State: AOAM533F0NcuUAGrFUEpIOvKrMl3EuBUkLTs7jOuip+eZRn2VGL9Jyqn
        YV8jWTlxHo2k2FFDCJScFXW/I5zQVAkZ
X-Google-Smtp-Source: ABdhPJw+0iChHXMR8nCWK4gTypeBNpwhtyGhs4uDyTQg6LJo/pg2i4nMt1vywPBcNaBMLokt8QHaLwaMHsEr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a25:d20f:0:b0:648:d034:8708 with SMTP id
 j15-20020a25d20f000000b00648d0348708mr2480138ybg.509.1651299813728; Fri, 29
 Apr 2022 23:23:33 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:19 -0700
In-Reply-To: <20220430062324.1565215-1-irogers@google.com>
Message-Id: <20220430062324.1565215-2-irogers@google.com>
Mime-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 1/6] perf cpumap: Switch to using perf_cpu_map API
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch some raw accesses to the cpu map to using the library API. This
can help with reference count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c          | 13 ++++++------
 tools/perf/util/bpf_counter_cgroup.c | 31 ++++++++++++++--------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 069825c48d40..a5cf6a99d67f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1011,7 +1011,7 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 
 	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
 		if (cpu_map__is_dummy(cpus) ||
-		    test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
+		    test_bit(perf_cpu_map__cpu(cpus, m).cpu, thread_data->mask->maps.bits)) {
 			if (thread_data->maps) {
 				thread_data->maps[tm] = &mmap[m];
 				pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
@@ -3331,13 +3331,14 @@ struct option *record_options = __record_options;
 
 static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
 {
-	int c;
+	struct perf_cpu cpu;
+	int idx;
 
 	if (cpu_map__is_dummy(cpus))
 		return;
 
-	for (c = 0; c < cpus->nr; c++)
-		set_bit(cpus->map[c].cpu, mask->bits);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus)
+		set_bit(cpu.cpu, mask->bits);
 }
 
 static int record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const char *mask_spec)
@@ -3404,8 +3405,8 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
 	pr_debug("nr_threads: %d\n", rec->nr_threads);
 
 	for (t = 0; t < rec->nr_threads; t++) {
-		set_bit(cpus->map[t].cpu, rec->thread_masks[t].maps.bits);
-		set_bit(cpus->map[t].cpu, rec->thread_masks[t].affinity.bits);
+		set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].maps.bits);
+		set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].affinity.bits);
 		if (verbose) {
 			pr_debug("thread_masks[%d]: ", t);
 			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index ac60c08e8e2a..a4b676920da0 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -47,7 +47,7 @@ static int bperf_load_program(struct evlist *evlist)
 	struct evsel *evsel;
 	struct cgroup *cgrp, *leader_cgrp;
 	__u32 i, cpu;
-	__u32 nr_cpus = evlist->core.all_cpus->nr;
+	__u32 nr_cpus = perf_cpu_map__nr(evlist->core.all_cpus);
 	int total_cpus = cpu__max_cpu().cpu;
 	int map_size, map_fd;
 	int prog_fd, err;
@@ -125,7 +125,7 @@ static int bperf_load_program(struct evlist *evlist)
 			for (cpu = 0; cpu < nr_cpus; cpu++) {
 				int fd = FD(evsel, cpu);
 				__u32 idx = evsel->core.idx * total_cpus +
-					evlist->core.all_cpus->map[cpu].cpu;
+					perf_cpu_map__cpu(evlist->core.all_cpus, cpu).cpu;
 
 				err = bpf_map_update_elem(map_fd, &idx, &fd,
 							  BPF_ANY);
@@ -207,13 +207,13 @@ static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
  */
 static int bperf_cgrp__sync_counters(struct evlist *evlist)
 {
-	int i, cpu;
-	int nr_cpus = evlist->core.all_cpus->nr;
+	struct perf_cpu cpu;
+	int idx;
 	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
 
-	for (i = 0; i < nr_cpus; i++) {
-		cpu = evlist->core.all_cpus->map[i].cpu;
-		bperf_trigger_reading(prog_fd, cpu);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		cpu = perf_cpu_map__cpu(evlist->core.all_cpus, i);
+		bperf_trigger_reading(prog_fd, cpu.cpu);
 	}
 
 	return 0;
@@ -244,12 +244,10 @@ static int bperf_cgrp__disable(struct evsel *evsel)
 static int bperf_cgrp__read(struct evsel *evsel)
 {
 	struct evlist *evlist = evsel->evlist;
-	int i, cpu, nr_cpus = evlist->core.all_cpus->nr;
 	int total_cpus = cpu__max_cpu().cpu;
 	struct perf_counts_values *counts;
 	struct bpf_perf_event_value *values;
 	int reading_map_fd, err = 0;
-	__u32 idx;
 
 	if (evsel->core.idx)
 		return 0;
@@ -263,7 +261,10 @@ static int bperf_cgrp__read(struct evsel *evsel)
 	reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
 
 	evlist__for_each_entry(evlist, evsel) {
-		idx = evsel->core.idx;
+		__u32 idx = evsel->core.idx;
+		int i;
+		struct perf_cpu_map cpu;
+
 		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
 		if (err) {
 			pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
@@ -271,13 +272,11 @@ static int bperf_cgrp__read(struct evsel *evsel)
 			goto out;
 		}
 
-		for (i = 0; i < nr_cpus; i++) {
-			cpu = evlist->core.all_cpus->map[i].cpu;
-
+		perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpu) {
 			counts = perf_counts(evsel->counts, i, 0);
-			counts->val = values[cpu].counter;
-			counts->ena = values[cpu].enabled;
-			counts->run = values[cpu].running;
+			counts->val = values[cpu.cpu].counter;
+			counts->ena = values[cpu.cpu].enabled;
+			counts->run = values[cpu.cpu].running;
 		}
 	}
 
-- 
2.36.0.464.gb9c8b46e94-goog

