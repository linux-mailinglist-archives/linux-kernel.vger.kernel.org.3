Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C239484E32
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiAEGQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbiAEGPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6FC0613A5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a9-20020a251a09000000b0060b2c94d515so56597472yba.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=luwQXebbF2igIF9jSSjuVf8RLHQ4IC0BEqVD3GLmXPI=;
        b=QetdgK/gVfLu22be3BQIQlfCMuIyuNwF45ShhfLh8FYheOQr/rTjKa5x6ONI5/u35M
         WoEdqiWKmmR32Z1z0Rrbdo/N9meKqeFcOYCUOhEVmU19OnlkArmFwd8qZ1aeuegN8GLZ
         IH0YRMvQqEDAt0M6HRuuZUz7AKdE4nCac+ynBvKyRsUHxo+A0DU2G+FQWOtbGMh3LkEV
         Ls/PemePB8DcuCQ9QqPiXSZgFGSwZyxYS0gET7muGmN7DeKxHkKNMMejCCSdH2J8rQ11
         /0ctpJh9r3o9d6tS3N+/nwhnKO2PpBggJKuSr9hFqMsuL1zK3Winx7EAyWPBiV59Zy6l
         ub9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=luwQXebbF2igIF9jSSjuVf8RLHQ4IC0BEqVD3GLmXPI=;
        b=UTV3BhRdfZEK067KnYsB1CVWWLGtOGI0mYvVwYWWeD6VcuLPYGEqtgQtJTao7Q6B2N
         gtlXeVhWsSDn3U96fnqkU/pa87ELpnb9Yb9zYAr2fEgoFcuW8A8DILjySu2+zjFcOo7J
         bJb6lxo21WQp1r9NAKWyus/Kb/SqG11RVOeeNW0F0bz8BUzZ6dWEhn0Y0VYu8fBV7nZx
         kATLyhPDG44M5IfdF6dPz6YSnGUpWi5n37m3GvmWG/Swc3JiIatRu1C2I2wo2RPivLDd
         keZrO7pnG/pvXzblo3RFQKCKO8xNf+jZgTMTGgjWmt4dYa4FWf2pzOg7egypj0QO4WF2
         WvCA==
X-Gm-Message-State: AOAM533VocBQAl2RCun0UZTjjfSuEojZlLWmUAbzU5aVlutnAtjyqf+m
        00uhLsG0OkUCmoKffREiGnhXvWQppbza
X-Google-Smtp-Source: ABdhPJzaD777xe8ZffZh+OZK9hDkj1lmvmYUHwd0ci5FDrOvMELLp2e3mQA1dym206MA3fzCwA1WqieefTkN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:d7d6:: with SMTP id
 o205mr55490999ybg.291.1641363317345; Tue, 04 Jan 2022 22:15:17 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:35 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-33-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 32/48] perf script: Use for each cpu to aid readability
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

Use perf_cpu_map__for_each_cpu to help with readability.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c9b3002ec254..f40319144856 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2115,8 +2115,7 @@ static struct scripting_ops	*scripting_ops;
 static void __process_stat(struct evsel *counter, u64 tstamp)
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
-	int ncpus = evsel__nr_cpus(counter);
-	int cpu, thread;
+	int idx, cpu, thread;
 	static int header_printed;
 
 	if (counter->core.system_wide)
@@ -2129,13 +2128,13 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 	}
 
 	for (thread = 0; thread < nthreads; thread++) {
-		for (cpu = 0; cpu < ncpus; cpu++) {
+		perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
 			struct perf_counts_values *counts;
 
 			counts = perf_counts(counter->counts, cpu, thread);
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
-				counter->core.cpus->map[cpu],
+				cpu,
 				perf_thread_map__pid(counter->core.threads, thread),
 				counts->val,
 				counts->ena,
-- 
2.34.1.448.ga2b2bfdf31-goog

