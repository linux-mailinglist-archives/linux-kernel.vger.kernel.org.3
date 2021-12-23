Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3B47DFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 08:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346927AbhLWHqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 02:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346946AbhLWHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:46:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82888C06175C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i187-20020a2522c4000000b006093b616e65so8614607ybi.17
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 23:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jOgZ+dsJ80gHSAYy1PEpxKlsT1rqOZcGXpM1p4DxDhE=;
        b=ALf5lK2Ov9iU0BCplEQ5qzLZD7goP9VK6FnyebpGcOLPQu3jXAT/OSi3DRcgeN1fco
         jwkPOMuiD1cTWg2Ad0l2cmneh3EFHLIOv69P162DKV7OWumzO8IsF2aAr6to7l7qZnPe
         6XnF1x6GRmW2GIcUd75SIUH/pyZ0pm+Y+TFkldWmTVIJ60iz+T1Ywc4wb7nHTSYmaAad
         1zFjWy9/eBiWNX2hjiHlYE/vCmM2q3qcYrdnBD9R/En8VltJoH7wN2kjCIdAFIOxKrYp
         +bZyXBaC8R8aY3bPJWxaIuQfcRZPwz14V5P9VKxfa4jrg0CzPjtuf0cqebNdgcYHTq5H
         73wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jOgZ+dsJ80gHSAYy1PEpxKlsT1rqOZcGXpM1p4DxDhE=;
        b=VzM5hFRSq2eWMkgvfAK/HN3ua7Ge9FbgR9C96fOFEBea3zDTffFe/SPnXe/5sDpTBi
         COu01R5PFdP5UF/esVOVqtvbLdibbbOeu7/cPv0fRxYuLYNDAHwnlW52AFJgNWND130y
         7fgLyWl1UMd56A9f02unOHUjV1g77ujZtytv2zXQfK/JW19XOS1fLcN0T83FR5YzW9fk
         PUYXPgHeH2bP0HcQVFfoucVOwxXYDQUdeDjIry9IL2N//DjTK4+Ab4MMUWOCzxvBQZ3+
         vPTJe34zkJv0lzW7dF4oWFs3LS//mtq2bFV+FJWBZn3VXw17MtJxuMr053TVKUBVEmir
         h2Hw==
X-Gm-Message-State: AOAM530U4NLUIdAeCeoZVbaOhCnTL0be9zApxyJmznOb9dEdkn13wJS3
        cvtoOwUqEFOFjFPopnDK2jrm0pbagqbA
X-Google-Smtp-Source: ABdhPJxfqk1AW2t7CvhGLgWlWdGHvdajhUDHd3O9XpcDl32AG8vbZ3Z1T8RUrnMO7UiDO8j9a3C8qoAvj20/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:bfd2:: with SMTP id
 q18mr1882341ybm.542.1640245575752; Wed, 22 Dec 2021 23:46:15 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:44:56 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-4-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 03/48] perf stat: Correct aggregation CPU map
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

Switch the perf_cpu_map in aggr_update_shadow from
the evlist to the counter's cpu map, so the index is appropriate. This
addresses a problem where uncore counts, with a cpumap like:
$ cat /sys/devices/uncore_imc_0/cpumask
0,18
Don't aggregate counts in CPUs based on the index of those values in the
cpumap (0 and 1) but on the actual CPU (0 and 18). Thereby correcting
metric calculations in per-socket mode for counters without a full
cpumask.

On a SkylakeX with a tweaked DRAM_BW_Use metric, to remove unnecessary
scaling, this gives:

Before:
$ /perf stat --per-socket -M DRAM_BW_Use -I 1000
     1.001102293 S0        1              27.01 MiB  uncore_imc/cas_count_write/ #   103.00 DRAM_BW_Use
     1.001102293 S0        1              30.22 MiB  uncore_imc/cas_count_read/
     1.001102293 S0        1      1,001,102,293 ns   duration_time
     1.001102293 S1        1              20.10 MiB  uncore_imc/cas_count_write/ #     0.00 DRAM_BW_Use
     1.001102293 S1        1              32.74 MiB  uncore_imc/cas_count_read/
     1.001102293 S1        0      <not counted> ns   duration_time
     2.003517973 S0        1              83.04 MiB  uncore_imc/cas_count_write/ #   920.00 DRAM_BW_Use
     2.003517973 S0        1             145.95 MiB  uncore_imc/cas_count_read/
     2.003517973 S0        1      1,002,415,680 ns   duration_time
     2.003517973 S1        1             302.45 MiB  uncore_imc/cas_count_write/ #     0.00 DRAM_BW_Use
     2.003517973 S1        1             290.99 MiB  uncore_imc/cas_count_read/
     2.003517973 S1        0      <not counted> ns   duration_time

After:
$ perf stat --per-socket -M DRAM_BW_Use -I 1000
     1.001080840 S0        1              24.96 MiB  uncore_imc/cas_count_write/ #    54.00 DRAM_BW_Use
     1.001080840 S0        1              33.64 MiB  uncore_imc/cas_count_read/
     1.001080840 S0        1      1,001,080,840 ns   duration_time
     1.001080840 S1        1              42.43 MiB  uncore_imc/cas_count_write/ #    84.00 DRAM_BW_Use
     1.001080840 S1        1              47.05 MiB  uncore_imc/cas_count_read/
     1.001080840 S1        0      <not counted> ns   duration_time

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 588601000f3f..b0fa81ffce61 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -526,7 +526,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
 			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-				s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
+				s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
 				if (!cpu_map__compare_aggr_cpu_id(s2, id))
 					continue;
 				val += perf_counts(counter->counts, cpu, 0)->val;
-- 
2.34.1.307.g9b7440fafd-goog

