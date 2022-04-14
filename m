Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8DF5003CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiDNBtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiDNBtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:49:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAD43152F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:46:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so3173473ybp.19
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=svBa47SCqOZsaBkSx/RaCXXT8aRdrkb49VLR42JsfKg=;
        b=RjyVmcucvv+RPNdGyQSIeqatnyoLhilK18zNRdhBrqQunYMlWg0uKknHB8LMoU3ZYX
         rIlzRYXcTDBsU5FBUJ9zfD6u8Fp03UDFeTJEXkGHQWURlCOR1+ovSmTcehRxyimzKK77
         AhVwC5v94IGXEl+Vn3ZnLrp79WXBG/5nSg0bJnumseY1emP/cvFdgJ7oJIL8mM8RHNev
         hMn97CFgjgqa0TOATjsOi7FsrYJKBv4zwDe7VPiHBAcird5D70XjuR0i3E3lMscIpspD
         G+Bw0/IPONwGGSp0dxM86yEoZTFG9vKKf0SG8+dvuXy5wOBzmTxM8JzVilkbuPrso813
         yV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=svBa47SCqOZsaBkSx/RaCXXT8aRdrkb49VLR42JsfKg=;
        b=zzO9Ui8ldFsPWX2YxvPGPD7ocsIAxlxs/cvNl9pcgeR4J6QdgUVkDeywyGM+o7/ZSz
         gmYvJTJybU7W9q9zgD6ZEcqvDuwuRjecrdvAmzLWQzdyyqcW3T1Ilsnb7Ve1JQT6tvHE
         +z+TNx6lGWRL4tSFJ8P4knsHTnu8Ze4CzLbkxu3hSmV0XDwBf4nQWb1dIW4FuXTksMb3
         CcT/ETrHt29uG8Jrk0SaFstnQTvRigqtCUWBOTr2gFtcM6tXAO+ecYYlOWDnGuJqguPu
         QsDdUpb2fIHbG7XAAjZ2w86unaMMARFFKtL0H6RTHWSSsugGq2i5BlGCWFEY/DtsiDqN
         Haag==
X-Gm-Message-State: AOAM532uRsyjHdJ+WwtPRrWCItZU31XH8JYdKTaVfH4YOfS1rakfbHvF
        rN9kyQuIGLBki7B0wZntzrM3WmAx16z3
X-Google-Smtp-Source: ABdhPJy67QEnhP5EmA7dZ0CzpFrpfl8XtiKWOUrT7nUZMf2arDrHqPN9W9bQZqnzLZYNlxGXzddQtnd9IfCs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a0d:f603:0:b0:2d1:57e5:234 with SMTP id
 g3-20020a0df603000000b002d157e50234mr309876ywf.469.1649900808695; Wed, 13 Apr
 2022 18:46:48 -0700 (PDT)
Date:   Wed, 13 Apr 2022 18:46:41 -0700
In-Reply-To: <20220414014642.3308206-1-irogers@google.com>
Message-Id: <20220414014642.3308206-2-irogers@google.com>
Mime-Version: 1.0
References: <20220414014642.3308206-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 2/3] perf cpumap: Switch to using perf_cpu_map API
From:   Ian Rogers <irogers@google.com>
To:     Alexey Bayduraev <alexey.bayduraev@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
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
2.36.0.rc0.470.gd361397f0d-goog

