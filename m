Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59644A51C3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiAaVlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:41:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49496 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381294AbiAaVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:39:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62ABCB82C34
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D513FC340E8;
        Mon, 31 Jan 2022 21:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643665182;
        bh=VYksMSxSzjbcHcVo3bU2HJeQ6tQJPtdJTlSrX35F7KY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iukrbAK78NTQn3W7vcyduYTbrMrwUogsoPhRr2py9KmisvCny2aLMYnkMXgekyPA5
         KIMHyDcBPxu/ar0JlU6Hbs5ykAqg8JUKvm7iz8b1q48/a5hMP9O8KzRsP5NTuGq7B/
         CoAhvbNenxWqIze9ey5hekSd2Y0EFDMrptUr1LqQOcD+NlnGi2QURntanQaLC0UkXN
         qV3+qUAtL8UBZ+WW79glfyMYw72/QVwqV4eFudfpIoxqVoT01VAAXv5lFRRx/lfSuY
         MpwCqCNPf27lujyWo2qRRoKrSMb2RlflJdSRyD5ufgkR0Pa6qp/g4nckCwVCFiJELP
         PRZ1GPBnTJ67A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2600440466; Mon, 31 Jan 2022 18:39:39 -0300 (-03)
Date:   Mon, 31 Jan 2022 18:39:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v13 03/16] perf record: Introduce thread specific data
 array
Message-ID: <YfhXG5yEHhrGDjvl@kernel.org>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
 <fc9f74af6f822d9c0fa0e145c3564a760dbe3d4b.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc9f74af6f822d9c0fa0e145c3564a760dbe3d4b.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 17, 2022 at 09:34:23PM +0300, Alexey Bayduraev escreveu:
> Introduce thread specific data object and array of such objects
> to store and manage thread local data. Implement functions to
> allocate, initialize, finalize and release thread specific data.
> 
> Thread local maps and overwrite_maps arrays keep pointers to
> mmap buffer objects to serve according to maps thread mask.
> Thread local pollfd array keeps event fds connected to mmaps
> buffers according to maps thread mask.
> 
> Thread control commands are delivered via thread local comm pipes
> and ctlfd_pos fd. External control commands (--control option)
> are delivered via evlist ctlfd_pos fd and handled by the main
> tool thread.
> 
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>

Some changes to reduce patch size, I have them in my local tree, will
publish later.

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1645b40540b870aa..a8c7118a95c6a3fa 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -924,7 +924,7 @@ static void record__thread_data_close_pipes(struct record_thread *thread_data)
 
 static int record__thread_data_init_maps(struct record_thread *thread_data, struct evlist *evlist)
 {
-	int m, tm, nr_mmaps = evlist->core.nr_mmaps;
+	int nr_mmaps = evlist->core.nr_mmaps;
 	struct mmap *mmap = evlist->mmap;
 	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
 	struct perf_cpu_map *cpus = evlist->core.cpus;
@@ -946,7 +946,7 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 	pr_debug2("thread_data[%p]: nr_mmaps=%d, maps=%p, ow_maps=%p\n", thread_data,
 		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
 
-	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
+	for (int m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
 		if (test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
 			if (thread_data->maps) {
 				thread_data->maps[tm] = &mmap[m];
@@ -967,21 +967,18 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 
 static int record__thread_data_init_pollfd(struct record_thread *thread_data, struct evlist *evlist)
 {
-	int f, tm, pos;
-	struct mmap *map, *overwrite_map;
-
 	fdarray__init(&thread_data->pollfd, 64);
 
-	for (tm = 0; tm < thread_data->nr_mmaps; tm++) {
-		map = thread_data->maps ? thread_data->maps[tm] : NULL;
-		overwrite_map = thread_data->overwrite_maps ?
-				thread_data->overwrite_maps[tm] : NULL;
+	for (int tm = 0; tm < thread_data->nr_mmaps; tm++) {
+		struct mmap *map = thread_data->maps ? thread_data->maps[tm] : NULL,
+			    *overwrite_map = thread_data->overwrite_maps ?
+						thread_data->overwrite_maps[tm] : NULL;
 
-		for (f = 0; f < evlist->core.pollfd.nr; f++) {
+		for (int f = 0; f < evlist->core.pollfd.nr; f++) {
 			void *ptr = evlist->core.pollfd.priv[f].ptr;
 
 			if ((map && ptr == map) || (overwrite_map && ptr == overwrite_map)) {
-				pos = fdarray__dup_entry_from(&thread_data->pollfd, f,
+				int pos = fdarray__dup_entry_from(&thread_data->pollfd, f,
 							      &evlist->core.pollfd);
 				if (pos < 0)
 					return pos;
@@ -996,13 +993,12 @@ static int record__thread_data_init_pollfd(struct record_thread *thread_data, st
 
 static void record__free_thread_data(struct record *rec)
 {
-	int t;
 	struct record_thread *thread_data = rec->thread_data;
 
 	if (thread_data == NULL)
 		return;
 
-	for (t = 0; t < rec->nr_threads; t++) {
+	for (int t = 0; t < rec->nr_threads; t++) {
 		record__thread_data_close_pipes(&thread_data[t]);
 		zfree(&thread_data[t].maps);
 		zfree(&thread_data[t].overwrite_maps);
@@ -1014,20 +1010,18 @@ static void record__free_thread_data(struct record *rec)
 
 static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
 {
-	int t, ret;
-	struct record_thread *thread_data;
+	struct record_thread *thread_data = rec->thread_data = zalloc(rec->nr_threads * sizeof(*(rec->thread_data)));
+	int ret;
 
-	rec->thread_data = zalloc(rec->nr_threads * sizeof(*(rec->thread_data)));
 	if (!rec->thread_data) {
 		pr_err("Failed to allocate thread data\n");
 		return -ENOMEM;
 	}
-	thread_data = rec->thread_data;
 
-	for (t = 0; t < rec->nr_threads; t++)
+	for (int t = 0; t < rec->nr_threads; t++)
 		record__thread_data_init_pipes(&thread_data[t]);
 
-	for (t = 0; t < rec->nr_threads; t++) {
+	for (int t = 0; t < rec->nr_threads; t++) {
 		thread_data[t].rec = rec;
 		thread_data[t].mask = &rec->thread_masks[t];
 		ret = record__thread_data_init_maps(&thread_data[t], evlist);
