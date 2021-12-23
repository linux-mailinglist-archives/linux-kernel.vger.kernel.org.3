Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E86547DFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbhLWHte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347380AbhLWHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:48:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C25BC0698D7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:48:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso8676133ybj.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cDaibtPTEVy/marM7k5BRfohlw9xTdSxUKumkjr4yhw=;
        b=LR0s9gyR8FdFtVpedgrPoQl0RipPyJFh0k9uDNnNWGWyGp41FS4MhvQkerVXScw40O
         5Q3UgSXloAekM3enRkXD4/fIt1iveTUNFR0xdq3R6OFB9RC0H4mm7C5I+csb4PN4VXAD
         OM1S1z3/mX//nMtqRh1DDVuWQQLz4PaV3PkuyzaPSutZdqFk+nkgpusXJ1Vpw0h/w/Ph
         l/BwiN3gdX47cU0o3t3KRNEAahlbYreHh1/4QpHUMgyeVSF0BmDVPK37E76zHjbXRqAn
         6vXc2tDWW8hi2lqSUOqLp8z8MMmAgzWAS9djaYyCpkhDylETPN22SZ2S/Iu4bT57KrOx
         ZDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cDaibtPTEVy/marM7k5BRfohlw9xTdSxUKumkjr4yhw=;
        b=pTPOiALAdM1AFguzj/91oihtX21muGvC0fIR5AXJpVKynsMyW+ee4Xz/CHLkfm49UV
         WpqZydI9aSQZ/QZO1TTGOJV6x9XKc5mrkDXMep6gvHLK5qe4q5+XvEUG/pbvhSzeuVdz
         qODomDFRUpO6c8Fu7iVaaIwTeUE46OhGueFiZWTDu+dN5/jgaTjSeXLyi0QFlHgZJiUb
         q5zz1LYT0LfHAQn4PPwC4EoCFv1DdickyMh8WvkY8+IBFkI2ugoJHVsD6jXYrKtC2ssX
         zyMytiY0d7TLMgKurVT4xtGe28XDO1azJfTik9IlPP5Tjanj9nr7Z2loH7KI1KjsGHso
         ygSg==
X-Gm-Message-State: AOAM532fpnpWY2pNs3zSKnirGeKm+f1ceSYzbOXPblVQS1guqFjvYbQA
        NyIPRwEYnp8cfK8pQJCjowvWq1aNdICT
X-Google-Smtp-Source: ABdhPJzDnNWgSN3KpORsveY6l3QnqXRD+G9oM9zhBV0+i5/UTFDThki+ZfSFVKKlRC0auWHdTdRytkGYHEup
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:3814:: with SMTP id
 f20mr1711353yba.117.1640245687520; Wed, 22 Dec 2021 23:48:07 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:40 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-48-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 47/48] perf stat: Correct first_shadow_cpu to return index
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

perf_stat__update_shadow_stats and perf_stat__print_shadow_stats use a
cpu map index rather than a CPU, but first_shadow_cpu is returning the
wrong value for this. Change first_shadow_cpu to
first_shadow_cpu_map_idx to make things agree.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 9be74e907352..81a288a7ae46 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -327,24 +327,23 @@ static void print_metric_header(struct perf_stat_config *config,
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
-static int first_shadow_cpu(struct perf_stat_config *config,
-			    struct evsel *evsel, const struct aggr_cpu_id *id)
+static int first_shadow_cpu_map_idx(struct perf_stat_config *config,
+				struct evsel *evsel, const struct aggr_cpu_id *id)
 {
-	struct perf_cpu_map *cpus;
+	struct perf_cpu_map *cpus = evsel__cpus(evsel);
 	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
-		return id->cpu;
+		return perf_cpu_map__idx(cpus, id->cpu);
 
 	if (!config->aggr_get_id)
 		return 0;
 
-	cpus = evsel__cpus(evsel);
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
 		struct aggr_cpu_id cpu_id = config->aggr_get_id(config, cpu);
 
 		if (aggr_cpu_id__equal(&cpu_id, id))
-			return cpu;
+			return idx;
 	}
 	return 0;
 }
@@ -503,7 +502,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
-				first_shadow_cpu(config, counter, &id),
+				first_shadow_cpu_map_idx(config, counter, &id),
 				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
@@ -532,7 +531,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 				val += perf_counts(counter->counts, idx, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
-					first_shadow_cpu(config, counter, &id),
+					first_shadow_cpu_map_idx(config, counter, &id),
 					&rt_stat);
 		}
 	}
-- 
2.34.1.307.g9b7440fafd-goog

