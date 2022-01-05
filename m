Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCD484E31
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbiAEGQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiAEGPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1EBC061396
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v189-20020a2561c6000000b0060b5814a17eso55737072ybb.22
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cJxFT+Wieuw1JhmOKv6vMYAg7VBOnu+0BYOqRINi2fw=;
        b=GY4V9f2WtfCAOmHqpJBCqaE/DJ4FJtSTe+IVPCFmccXWe49Vv0FjqmefOnmUwI23+W
         jq3PcHHD6BViFF3wUo+pGethaE9NU3tyo+Rnf9lMyIhXZblYiEu5txW2DngMfAqoBPb8
         W2R2n/KYV+jkKtzaxPIPs4RLpYBE9KgOLZ/gS311i/+YCLZwZT95M4M1Ff811MZJ6exW
         ux+EflSLc6zan/QxZAJ0AZt+gcDD5ofVL+kzUjhXTaw4tPjiLx+ZYwChn0F+Bpd28eaB
         NnTbohPifYf7x7C6W6LqrboGsVyq+f2Ssm2vPiq5ZDU1OCpVRMHr+aP0iKZeE8qls+Cv
         LnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cJxFT+Wieuw1JhmOKv6vMYAg7VBOnu+0BYOqRINi2fw=;
        b=RuiFPdYk6P+WrD3llNT7ivsX1xlFeVdCjxwtlA+Ip048CLBMXRNtaqOJGthHhUBhTG
         bsVsJ6Fdb59CMa+3eJigIZQyE9IzC8zhP1iAEavNMNV58ZmPNg5zja8ExA4NuHId4RJt
         dQaB2eP3r/15LWA5SLB9ixPAZZENdGZgYfox+lfJCpnn8GAGaChDLEGDfL7Hpb/Uyz7x
         gevvZ+T43z7swYZd5R4rLsGzP+dxKMBkdZu1QoiX0LXfmJ/L8YItFmMbBhFZNqUSxLae
         mmDxW0EafFFCKi/Jc1FYo/cnWNpX08h82DSNMuMR488Kqp85SRNZFlOhdu2MtqPLwhSW
         U3Zw==
X-Gm-Message-State: AOAM531TQ4+u+XHvGCZZu1sJTJSDzDEwaEaDBSYFo33wUVjdID0WHTBg
        xrX7sEDk43sZ4xWzEOl67tVLuxikgOrl
X-Google-Smtp-Source: ABdhPJz6BllTP+8MyBqztKvpwQ5+7lh8jn7/LAXMClEP1dR7F0dfNkdd6z0dxvFXLKRs8hhzihx5lUCGaFjr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:dbc8:: with SMTP id
 g191mr22901094ybf.623.1641363314707; Tue, 04 Jan 2022 22:15:14 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:34 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-32-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 31/48] perf stat: Use perf_cpu_map__for_each_cpu
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

Correct in print_counter where an index was being used as a cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7e933a8fee68..0f192360b6c6 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -4,6 +4,7 @@
 #include <linux/string.h>
 #include <linux/time64.h>
 #include <math.h>
+#include <perf/cpumap.h>
 #include "color.h"
 #include "counts.h"
 #include "evlist.h"
@@ -732,7 +733,7 @@ static void print_aggr(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			print_counter_aggrdata(config, counter, s,
 					       prefix, metric_only,
-					       &first, -1);
+					       &first, /*cpu=*/-1);
 		}
 		if (metric_only)
 			fputc('\n', output);
@@ -893,11 +894,11 @@ static void print_counter(struct perf_stat_config *config,
 	FILE *output = config->output;
 	u64 ena, run, val;
 	double uval;
-	int cpu;
+	int idx, cpu;
 	struct aggr_cpu_id id;
 
-	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-		struct aggr_data ad = { .cpu_map_idx = cpu };
+	perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
+		struct aggr_data ad = { .cpu_map_idx = idx };
 
 		if (!collect_data(config, counter, counter_cb, &ad))
 			return;
@@ -1248,7 +1249,7 @@ static void print_percore(struct perf_stat_config *config,
 
 		print_counter_aggrdata(config, counter, s,
 				       prefix, metric_only,
-				       &first, -1);
+				       &first, /*cpu=*/-1);
 	}
 
 	if (metric_only)
-- 
2.34.1.448.ga2b2bfdf31-goog

