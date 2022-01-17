Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282AC490C28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbiAQQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbiAQQJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:09:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD879C06161C;
        Mon, 17 Jan 2022 08:09:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E338610A2;
        Mon, 17 Jan 2022 16:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B40C36AE7;
        Mon, 17 Jan 2022 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642435791;
        bh=ZSQ5ho0teCkT9pTWbslhru7s+LtfklfD3T7qG27l5r8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZV8x33dGIDyobz5SQtQamWq6q+v8HEA9zisI3K36ZHlyh6m0C7ISw/gs4h9iSlPtz
         STcHcuplBufxZTFFDXK4NTzc5Fnu/b7ZcdOPYswLKGIbLwHO7oEvd3q2rvXTGWQMD4
         GgqHU8TMX3NvjHPH6c8UZJnzAV9PgBwPB1EZBy4cs/PkEwfEmwqp5KS13g3Dt7Jr83
         ggqhD/gnwc2aYEEdkmXbizA4/WrxjnCiuvnM1XZDcKFAlCBy/72rjtbEbpIhCPiubH
         Nj8pN0H+Dsj/+fTdZFdRHvMGLtKzni2L72O5a/ch2GMg4m4La9oS4l91JuP+MVwJU8
         ebwPHD05MJf3Q==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 2/4] perf stat: No need to setup affinities when starting a workload
Date:   Mon, 17 Jan 2022 13:09:29 -0300
Message-Id: <20220117160931.1191712-3-acme@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220117160931.1191712-1-acme@kernel.org>
References: <20220117160931.1191712-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.e. the simple:

  $ perf stat sleep 1

Uses a dummy CPU map and thus there is no need to setup/cleanup
affinities to avoid IPIs, etc.

With this we're down to a sched_getaffinity() call, in the libnuma
initialization, that probably can be removed in a followup patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 973ade18b72a9479..934e992c966fb950 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -788,7 +788,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	const bool forks = (argc > 0);
 	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
 	struct evlist_cpu_iterator evlist_cpu_itr;
-	struct affinity affinity;
+	struct affinity saved_affinity, *affinity = NULL;
 	int err;
 	bool second_pass = false;
 
@@ -803,8 +803,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (group)
 		evlist__set_leader(evsel_list);
 
-	if (affinity__setup(&affinity) < 0)
-		return -1;
+	if (!cpu_map__is_dummy(evsel_list->core.cpus)) {
+		if (affinity__setup(&saved_affinity) < 0)
+			return -1;
+		affinity = &saved_affinity;
+	}
 
 	evlist__for_each_entry(evsel_list, counter) {
 		if (bpf_counter__load(counter, &target))
@@ -813,7 +816,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			all_counters_use_bpf = false;
 	}
 
-	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
 		counter = evlist_cpu_itr.evsel;
 
 		/*
@@ -869,7 +872,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		 */
 
 		/* First close errored or weak retry */
-		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
 			counter = evlist_cpu_itr.evsel;
 
 			if (!counter->reset_group && !counter->errored)
@@ -878,7 +881,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			perf_evsel__close_cpu(&counter->core, evlist_cpu_itr.cpu_map_idx);
 		}
 		/* Now reopen weak */
-		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, &affinity) {
+		evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
 			counter = evlist_cpu_itr.evsel;
 
 			if (!counter->reset_group && !counter->errored)
@@ -904,7 +907,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			counter->supported = true;
 		}
 	}
-	affinity__cleanup(&affinity);
+	affinity__cleanup(affinity);
 
 	evlist__for_each_entry(evsel_list, counter) {
 		if (!counter->supported) {
-- 
2.34.1

