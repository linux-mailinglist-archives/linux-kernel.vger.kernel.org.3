Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE85C58351C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiG0WKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiG0WJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:09:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A70D52FC2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id bu13-20020a056902090d00b00671743601f1so281278ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=T0bnJS27wy9tC+g6AwU4wYBQ/aygfZiM5uTYWqOBWko=;
        b=KI2fr2v2Zom/MKLICDnDLKjTEGjyEhuRceFj5+XviYzOw0edDO5nEgJZJueComA91V
         wkaAldjFL8QfATCbMqgHRlJnBjBoL5P5qYPKyCvB8UfM5aT817X6lZ1o7IC+ElsTBcA2
         8/39ndYDXaOQdSoOYCf1LaLGvkTacvBfU8T0PGVgztusKMTbz1Kf3K9dP0Y+FcZO7cet
         KDHbzgZK5x8FqC1LPn/7OzlTmPOvEG7nLZgsgMK/NSBDTXWQIg3cA9cFRsjcJ/qPl5Ek
         LrsHn0gFCGp/Z2JYa5A3za6e5Pfhzc1a4eziMW0k2Fft93vzHz7V+66Cl7tsJ0aFsgOF
         Z/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=T0bnJS27wy9tC+g6AwU4wYBQ/aygfZiM5uTYWqOBWko=;
        b=BBD/wQ7vfvYLncekbythsaMNkGIUONRuND8oiBpFulQ1Rwt8MXwpBoXaSwdju/sGHt
         oZzNcClWzMRLJQk+w8lG+tBn1ZwfnEjlXClav3TMSMwzeIHeuBe6dtmUgW6XGsjE9y4r
         zDEK644QZq4EOYJBKT9ggS2a+5cScFl4R0my+/2TBVl61uC33gVwFPhUhz8orkUOR1Oc
         znMFXClov7R8nD21JwWAfu1Qz+LfMulIyOnAZYV7G2LFjRgMUWBYRBz2ybzVqqJcqawg
         dftAYsz+JnJipNkh1L9dE8texeJbe5/i8Lj4+EIvIRDYKtUqo1Bb6uE97232TXHcKRd7
         gVqA==
X-Gm-Message-State: AJIora+aW31pH3TcbGgcDZWujNkZQHsFjHBXbwK2vZbsBwDI/gUFV22P
        rOLZwO96JmMMjLZxgDWpqutZl/EJj9eY
X-Google-Smtp-Source: AGRyM1vAOsFHkuv+UdhxGPYNBdWP3QCbVnUcSAveeKYFUpir4//ErZEk6Vwx38UaHzv7iWRpeZr1XhjfL6SH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a81:7457:0:b0:31e:798f:31bb with SMTP id
 p84-20020a817457000000b0031e798f31bbmr21323283ywc.96.1658959752876; Wed, 27
 Jul 2022 15:09:12 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:13 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-12-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 11/30] perf vendor events: Update Intel haswellx
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to v25, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the haswellx files into perf and update mapfile.csv.

Tested with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 90: perf all metricgroups test                                      : Ok
 91: perf all metrics test                                           : Fail=
ed
 93: perf all PMU test                                               : Ok

The test 91 failure is a pre-existing failure on the test system
with the metric Load_Miss_Real_Latency which is fixed by
prefixing it with --metric-no-group.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/haswellx/cache.json   |  9 +-
 .../arch/x86/haswellx/hsx-metrics.json        | 85 +++++++++++++------
 .../arch/x86/haswellx/pipeline.json           |  5 --
 .../arch/x86/haswellx/uncore-cache.json       |  8 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 5 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswellx/cache.json b/tools/per=
f/pmu-events/arch/x86/haswellx/cache.json
index 5760ffb1eaf4..7557a203a1b6 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/cache.json
@@ -20,7 +20,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "L1D miss oustandings duration in cycles",
+        "BriefDescription": "L1D miss outstanding duration in cycles",
         "Counter": "2",
         "CounterHTOff": "2",
         "EventCode": "0x48",
@@ -592,7 +592,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "All retired load uops.",
+        "BriefDescription": "Retired load uops.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
@@ -600,11 +600,12 @@
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
+        "PublicDescription": "Counts all retired load uops. This event acc=
ounts for SW prefetch uops of PREFETCHNTA or PREFETCHT0/1/2 or PREFETCHW.",
         "SampleAfterValue": "2000003",
         "UMask": "0x81"
     },
     {
-        "BriefDescription": "All retired store uops.",
+        "BriefDescription": "Retired store uops.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
@@ -613,6 +614,7 @@
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "L1_Hit_Indication": "1",
         "PEBS": "1",
+        "PublicDescription": "Counts all retired store uops.",
         "SampleAfterValue": "2000003",
         "UMask": "0x82"
     },
@@ -1071,7 +1073,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xf4",
         "EventName": "SQ_MISC.SPLIT_LOCK",
-        "PublicDescription": "SQ_MISC.SPLIT_LOCK",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index c99734fd907d..5c9e008ca995 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -111,17 +111,11 @@
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is at least 1 uop executed)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
         "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1=
@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask=
\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "IpMispredict"
-    },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_U=
NHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
@@ -170,6 +164,12 @@
         "MetricGroup": "Summary;TmaL1",
         "MetricName": "Instructions"
     },
+    {
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "Retire"
+    },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MIT=
E_UOPS + IDQ.MS_UOPS ) )",
@@ -177,11 +177,16 @@
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load instructions (in core cycles)",
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_=
MISS + mem_load_uops_retired.hit_lfb )",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "Load_Miss_Real_Latency",
-        "PublicDescription": "Actual Average Latency for L1 data-cache mis=
s demand load instructions (in core cycles). Latency may be overestimated f=
or multi-load instructions - e.g. repeat strings."
+        "MetricName": "Load_Miss_Real_Latency"
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
@@ -189,24 +194,6 @@
         "MetricGroup": "Mem;MemoryBound;MemoryBW",
         "MetricName": "MLP"
     },
-    {
-        "BriefDescription": "Average data fill bandwidth to the L1 data ca=
che [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW"
-    },
-    {
-        "BriefDescription": "Average data fill bandwidth to the L2 cache [=
GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW"
-    },
-    {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW"
-    },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED=
.ANY",
@@ -238,6 +225,48 @@
         "MetricGroup": "Mem;MemoryTLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 / duration_time)=
",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW_1T"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 / duration_time)=
",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW_1T"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "(64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duratio=
n_time)",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW_1T"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "0",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW_1T"
+    },
     {
         "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json b/tools/=
perf/pmu-events/arch/x86/haswellx/pipeline.json
index 6165933ee1a4..42f6a8100661 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
@@ -1035,7 +1035,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1056,7 +1055,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 1.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -1117,7 +1115,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 4.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -1138,7 +1135,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 5.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -1159,7 +1155,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 6.",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
index b48833d1c170..03598904d746 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
@@ -511,7 +511,7 @@
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "AD",
+        "BriefDescription": "UNC_C_RING_SINK_STARVED.AD",
         "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AD",
@@ -520,7 +520,7 @@
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "AK",
+        "BriefDescription": "UNC_C_RING_SINK_STARVED.AK",
         "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.AK",
@@ -529,7 +529,7 @@
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "IV",
+        "BriefDescription": "UNC_C_RING_SINK_STARVED.IV",
         "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.IV",
@@ -538,7 +538,7 @@
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "BL",
+        "BriefDescription": "UNC_C_RING_SINK_STARVED.BL",
         "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_C_RING_SINK_STARVED.BL",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 39741e24f733..b602d2da1b89 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -9,7 +9,7 @@ GenuineIntel-6-96,v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-(3C|45|46),v31,haswell,core
-GenuineIntel-6-3F,v17,haswellx,core
+GenuineIntel-6-3F,v25,haswellx,core
 GenuineIntel-6-3A,v18,ivybridge,core
 GenuineIntel-6-3E,v19,ivytown,core
 GenuineIntel-6-2D,v20,jaketown,core
--=20
2.37.1.359.gd136c6c3e2-goog

