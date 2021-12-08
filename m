Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A2946CB30
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243543AbhLHCux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbhLHCud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FA4C061D76
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 18:47:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x5-20020a2584c5000000b005f89a35e57eso2011891ybm.19
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 18:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1Q+fR+dwg/H4WwN6K7F+f4dnQV1rO5+y5/1HnCJA9YI=;
        b=Tq57yUqxqzsTnfHy69cRgj7WPbRWbhORq01ib3E/8l4haWXRw4XJ0O7hPSnZh0ebpF
         wwB2yvEWiRKuz7MyjyUHRx8fss5D3A43ci4tZngK7bDGZAqU+jFqLH0nVYfn3o52zWSb
         FqvBqb8mQAjsbN2VenfengCFFpg9jSLGzzO3Jcy5As0zQtPg/fls1dbN3iEYG7OKmu0D
         e7cjYG2AuW8BMSrvDB0B6Qf9UlBLSkk9tWfIqECzGLliyZQ5o7FA74JDl/SE/R7Sn5MD
         ERqaC9pqphDdtTzZgli01HDQZ8/PpSBrurYC9ytIV2h067jiLZucT+4jts2Ee/vXTyC3
         l/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1Q+fR+dwg/H4WwN6K7F+f4dnQV1rO5+y5/1HnCJA9YI=;
        b=kaZTTkK4qWt23iPv7azsd1QCr33pR3dAeeSnwTjQDGXd9rCkftXX7XrQtHfwrkdVul
         3UYb0jcqSLRUtWRLQZG1ef2pTWnzxN6umniekgJbNPDgbe6PmWoq6MeRMOzOqj7pnY3c
         bpLzh5ozgV26gW9797fOD6WBgBwVFRhqJYsWOVBJvrnmnkpEu+kHe5bOQX1A4Xbd4ed4
         fYHjKVrfZZdmrMJ0NtD9gmxT4mMUWp8WVToFHpqLLX289sNlUtYC7t+3Zm8AajkMxPSs
         jBF0SARd6yIleUHOvkp4OCkyPyKUSYO+1J+ggRe2FicFlqyeTEteQkIHMEheuvkSQoaI
         AWsQ==
X-Gm-Message-State: AOAM532XL99ynCMaGVJceyldEzbgBBr01Fp/zvfYjNatevBVEc1Rukpd
        diaduCoHk8dsWGaQTCCeR+katpRu8tb+
X-Google-Smtp-Source: ABdhPJwmCpy85KFCAgIHdaCfJeQTKmUW7WcGyj3my5IAiR51pn6j2dVANCI+U57vpj/0konDph5UdaC8B/U2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:ada5:: with SMTP id
 z37mr54331518ybi.93.1638931620488; Tue, 07 Dec 2021 18:47:00 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:46:05 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-21-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 20/22] perf cpumap: Add some comments to cpu_aggr_map
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

Move cpu_aggr_map__empty_new to be with other cpu_aggr_map function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 832fc53f3c11..8acef8ff8753 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -24,16 +24,18 @@ struct aggr_cpu_id {
 	int core;
 };
 
+/** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
 struct cpu_aggr_map {
 	refcount_t refcnt;
+	/** Number of valid entries. */
 	int nr;
+	/** The entries. */
 	struct aggr_cpu_id map[];
 };
 
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
-struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
 
 struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
@@ -67,6 +69,12 @@ int cpu__get_die_id(int cpu);
  */
 int cpu__get_core_id(int cpu);
 
+/**
+ * cpu_aggr_map__empty_new - Create a cpu_aggr_map of size nr with every entry
+ * being empty.
+ */
+struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
+
 typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(int cpu, void *data);
 
 /**
-- 
2.34.1.400.ga245620fadb-goog

