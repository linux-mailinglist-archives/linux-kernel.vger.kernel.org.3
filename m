Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35214484E12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiAEGOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiAEGOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:14:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D52C061785
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:14:05 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p140-20020a257492000000b0060dbb88d8abso40290192ybc.15
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HQ0F4Wkpc2hZGLs9o4VVEd71gbRETuZn+IEXms79S7Y=;
        b=e7KHiU59v84EyoMHS5p2Mg5EgcEElA1lH8I4u/X+iDw3Pg+SJIKMO7PGa6gZEyh1XI
         jcYslOJImrqtnUkMdgokHbevuybXcRdcxcF3cJqQM5xjp7JBini9Ss6qlpKVJgpcy8aK
         kcYpSIrLu8/S9UJpTlNF4Bmh8jV+zB9mOC3X/HUbKBhodtWYfOFJsMtzh/b6Jj5+kqbi
         f+PtIdaIKIaOZL+x0dA2kDiOSHXTiD5zwMkbkbjTfIfkkY5+De17jv8GXZVHiGf71IYj
         Y15Yob7D7V6e8tHxQ90O3dH72V3YP7XLiy2iuIUyC8C25WWTijmA1FBnXEEs1aOQXEe7
         fM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HQ0F4Wkpc2hZGLs9o4VVEd71gbRETuZn+IEXms79S7Y=;
        b=EvKOAh7QdbrBTnTZr/BFMm5E4je/D8Uk7l62cRMxUrQcbAxU9IvMQ0p6t53jRUE2N7
         o9NnZGQJlWiLVDNDDdCz1CYRvqeQ46GAVl1XRJXaPXe6m21LGsvxxX6f4cVg5Kpd/WKk
         c/NIAfGJVWyuYUzrl9C1rNEr+zhHabio9DW3lF4QZFFOz+eAsKKoY058PzcXnvJPMWim
         N305iPhK85qOCi4J2ACZKfHsLi0K7g/Pn8YpjpJd8+OEmr3h82byhqEed/eNbVr1c+zV
         2CFNphBuE2z3TH/s4/c1Abnm8LNvJDxbGS+yb9hfXNHQrZCGl6lyw7kT82ybrDZFgcwX
         KrQg==
X-Gm-Message-State: AOAM531Tei6JE7vwyCGOnuQhbtZYqtULYvG36aZ21IYXGPp3J7/ClG0P
        i3uHqGfPvJTbTq/e2G42xNZmIXjgUajh
X-Google-Smtp-Source: ABdhPJz9nken52ZH9X0zSHsdDA6FM1TTMIEc4BBm/a+cJg95yA6r1/pwxo5E8ciy7XOc+W2WF5GEtPb45iDP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:d2d8:: with SMTP id
 j207mr53245977ybg.699.1641363244715; Tue, 04 Jan 2022 22:14:04 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:06 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-4-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 03/48] perf stat: Correct aggregation CPU map
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
2.34.1.448.ga2b2bfdf31-goog

