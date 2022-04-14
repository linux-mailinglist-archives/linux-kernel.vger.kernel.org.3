Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84C95003CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbiDNBtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiDNBtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:49:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE63152F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:46:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb58f605aeso32075387b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4qwvYVooM7YaW2143ob33/RDOtgCck3amy1lZ/qZ43Q=;
        b=a82+8uScUFTY7UVOEcfN1mbnKXdw94mA5rNEPHiinFfjwaAc0yJbWi6EkFclTpOHst
         EQL1MiawyR2AvJ120Nz3AyPXHpD7fj6H2vkVVeiLn7CkioUhXRh44RGbM4GC87nS8NPA
         lPCfINqrWTnXWyoCGURkhfEoIgRsuARD3M+PNgy1+0IfXm2TMwdZj03N7A84wURImXGT
         fq9jiy5h/gdZuBEOBQWpNYqGp7HnNDvyhN8sKkJLPJpcVx3OcmIRXB+KfGePEC7fpI77
         DJt1T6AClZaJ5hrq6Cg0kDdHpfD+vtGtVuaOMnPtlZz7cpE0NRk5S+HzgKdy3jxIkJnO
         INzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4qwvYVooM7YaW2143ob33/RDOtgCck3amy1lZ/qZ43Q=;
        b=6KGZ3x59uPin0mMJNgrfUwNyMnUxkutvj9yh61bTBiefJWmCQNf5dwer6iAYfwxYor
         c2LK5LpsDEIsvXnjP9Pm7YwEYOwbzFtWax25SAQ5NzSwEhTD0R4gyv82kpA+qYZ8M+MM
         FBJLi5WUUdfAJonaMtnhnEsgggsr0oNUVNFA8uB9r2cAf3XLuzBLE1JdvKoJrGu6ZjkL
         XkMkxMbxnbq5nkaWR05TDcHXWoAsNsXgtzm6N2c0t48B5dFH3TnJfINkzeXGBsbbaMII
         YrLl4rLcqO25d7iGf0zw3mrG8UaDnMw9UdUxZCU4/6o8cTW2+kDesQ+2qEZtoNSn4Hs/
         /ghw==
X-Gm-Message-State: AOAM531otAGTsGZ/P54QuyAgyzZ5exGikuZ/BMdn444ancPWG8MSNKli
        GuWz3QiKXCZL/WGlSnFpX0NnBdycgp2h
X-Google-Smtp-Source: ABdhPJy6OxalAJ2viaEkc8iVPXzpVO2fRlZPiZ/UHIAzZTkwwkgrTiWyCENuCg+wbC6JtsqCplrE96jWMF3e
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a81:16cb:0:b0:2eb:f4c2:fadd with SMTP id
 194-20020a8116cb000000b002ebf4c2faddmr288000yww.475.1649900806080; Wed, 13
 Apr 2022 18:46:46 -0700 (PDT)
Date:   Wed, 13 Apr 2022 18:46:40 -0700
Message-Id: <20220414014642.3308206-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 1/3] perf record: Fix per-thread option.
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

From: Alexey Bayduraev <alexey.bayduraev@gmail.com>

Per-thread mode doesn't have specific CPUs for events, add checks for
this case.

Minor fix to a pr_debug by Ian Rogers <irogers@google.com> to avoid an
out of bound array access.

Reported-by: Ian Rogers <irogers@google.com>
Fixes: 7954f71689f9 ("perf record: Introduce thread affinity and mmap masks")
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Alexey Bayduraev <alexey.bayduraev@gmail.com>
---
 tools/perf/builtin-record.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba74fab02e62..069825c48d40 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -989,8 +989,11 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
 	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 
-	thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
-					      thread_data->mask->maps.nbits);
+	if (cpu_map__is_dummy(cpus))
+		thread_data->nr_mmaps = nr_mmaps;
+	else
+		thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
+						      thread_data->mask->maps.nbits);
 	if (mmap) {
 		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
 		if (!thread_data->maps)
@@ -1007,16 +1010,17 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
 
 	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
-		if (test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
+		if (cpu_map__is_dummy(cpus) ||
+		    test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
 			if (thread_data->maps) {
 				thread_data->maps[tm] = &mmap[m];
 				pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
-					  thread_data, cpus->map[m].cpu, tm, m);
+					  thread_data, perf_cpu_map__cpu(cpus, m).cpu, tm, m);
 			}
 			if (thread_data->overwrite_maps) {
 				thread_data->overwrite_maps[tm] = &overwrite_mmap[m];
 				pr_debug2("thread_data[%p]: cpu%d: ow_maps[%d] -> ow_mmap[%d]\n",
-					  thread_data, cpus->map[m].cpu, tm, m);
+					  thread_data, perf_cpu_map__cpu(cpus, m).cpu, tm, m);
 			}
 			tm++;
 		}
@@ -3329,6 +3333,9 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
 {
 	int c;
 
+	if (cpu_map__is_dummy(cpus))
+		return;
+
 	for (c = 0; c < cpus->nr; c++)
 		set_bit(cpus->map[c].cpu, mask->bits);
 }
@@ -3680,6 +3687,11 @@ static int record__init_thread_masks(struct record *rec)
 	if (!record__threads_enabled(rec))
 		return record__init_thread_default_masks(rec, cpus);
 
+	if (cpu_map__is_dummy(cpus)) {
+		pr_err("--per-thread option is mutually exclusive to parallel streaming mode.\n");
+		return -EINVAL;
+	}
+
 	switch (rec->opts.threads_spec) {
 	case THREAD_SPEC__CPU:
 		ret = record__init_thread_cpu_masks(rec, cpus);
-- 
2.36.0.rc0.470.gd361397f0d-goog

