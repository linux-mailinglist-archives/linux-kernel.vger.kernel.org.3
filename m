Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9052A57E9C1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbiGVWe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:34:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5768BBDA1B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u6-20020a25b7c6000000b00670862c5b16so4623560ybj.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=EsMjZGt6ullFvMBASceG2Dr30qlEKSZkZvlcbvF9vN4=;
        b=imLnRpDimkwvXfFkVMqh/jvO01NzUkIgsnuLCRuGyRlhCtuMRNE5xRKKEBosGmrTtb
         bQKh0qMCrltZ4sVl41SUQWlaCDeAehx9Kg9iZdGd1+cktoxU46xZRJP3ktVBPsNKEYLk
         CN283TIZPZZA1UjHInYHq2XR736KFXmY3aSIn4LkNHvuwnsIucsC2ucMk5z6QU50Uc44
         GNZILyE/T4z95ZS1M4ciMKW3yY4dyMcjBlFvrltKxzHT7MKaUITITyhcKaoSripqL5O8
         S2bWVFbRyes+rYKbAci2wok78/joGu18Gyh1uMjWxZsV27Sww40gTfUS4yFLIlhzrxJt
         G+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=EsMjZGt6ullFvMBASceG2Dr30qlEKSZkZvlcbvF9vN4=;
        b=MdqoQCNbc1hKb0U2y3tFjNBZuZqZf7I+kgvOW+/SbMXKre35jgNQCJE0k/KzFrt5lK
         EVSXI3peMgF+Jg+fO9ZUrdDLm7aOsVTY2TPn7I2x/vutrfcqJDt61772KjgFBWceiM9W
         1oqhu47ItGCDF/7Jt0spK5p2WtDSVxfRF2qX6ZtAquRDbYKPYB4OQCUfLwdPu7QY8OaV
         QsF/QXNJeQVGJZ1fOn4PGb/LBB+qcsClf2kvVQx0O451URwlcWqG0+xRhkwZouQcofPy
         IkA2rQPVx2gQy2RizBMPGs8jNEOfsCVFNQyv8d4fSL3LOvN/3h69mkN6Au716QIs2m4K
         Mvyg==
X-Gm-Message-State: AJIora8Rwp7Dt5z9SoVpOgToHkG1iZUbHV7va+bpYHE9PkvK1Vj3cH3a
        wXRU2ECa2Ihra4Z8xSQVBDyMxO45nTnd
X-Google-Smtp-Source: AGRyM1uhGdCOcBKx2T92yam97mGyxxDL5L1TI4RqO+eDJkm+YZf0UgryL0wVEsQimR+bUOXSATfhCMiwC5ZQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a05:6902:4f:b0:670:96d9:72c1 with SMTP id
 m15-20020a056902004f00b0067096d972c1mr1908645ybh.555.1658529205608; Fri, 22
 Jul 2022 15:33:25 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:22 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-14-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 13/31] perf vendor events: Update Intel icelake
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the icelake files into perf and update mapfile.csv.

Tested on a non-icelake with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/icelake/cache.json    |   8 +-
 .../arch/x86/icelake/floating-point.json      |   2 +-
 .../pmu-events/arch/x86/icelake/frontend.json |   2 +-
 .../arch/x86/icelake/icl-metrics.json         | 126 ++++++++++++------
 .../arch/x86/icelake/uncore-other.json        |  31 +++++
 .../arch/x86/icelake/virtual-memory.json      |   2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   4 +-
 7 files changed, 123 insertions(+), 52 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/uncore-other.jso=
n

diff --git a/tools/perf/pmu-events/arch/x86/icelake/cache.json b/tools/perf=
/pmu-events/arch/x86/icelake/cache.json
index 9989f3338f0a..b4f28f24ee63 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/cache.json
@@ -303,7 +303,7 @@
         "UMask": "0x41"
     },
     {
-        "BriefDescription": "All retired load instructions.",
+        "BriefDescription": "Retired load instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -311,12 +311,12 @@
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions for loads.",
+        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
         "SampleAfterValue": "1000003",
         "UMask": "0x81"
     },
     {
-        "BriefDescription": "All retired store instructions.",
+        "BriefDescription": "Retired store instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -325,7 +325,7 @@
         "L1_Hit_Indication": "1",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts all retired store instructions. This =
event account for SW prefetch instructions and PREFETCHW instruction for st=
ores.",
+        "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelake/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/icelake/floating-point.json
index 4347e2d0d090..1925388969bb 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/floating-point.json
@@ -99,4 +99,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/frontend.json b/tools/p=
erf/pmu-events/arch/x86/icelake/frontend.json
index b510dd5d80da..739361d3f52f 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/frontend.json
@@ -494,4 +494,4 @@
         "Speculative": "1",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index 622c392f59be..f0356d66a927 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -38,7 +38,7 @@
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
         "MetricExpr": "TOPDOWN.SLOTS / ( TOPDOWN.SLOTS / 2 ) if #SMT_on el=
se 1",
-        "MetricGroup": "SMT",
+        "MetricGroup": "SMT;TmaL1",
         "MetricName": "Slots_Utilization"
     },
     {
@@ -61,24 +61,18 @@
         "MetricName": "FLOPc"
     },
     {
-        "BriefDescription": "Actual per-core usage of the Floating Point e=
xecution units (regardless of the vector width)",
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
         "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_I=
NST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP=
_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_=
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.5=
12B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) ) / ( 2 * CPU=
_CLK_UNHALTED.DISTRIBUTED )",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "FP_Arith_Utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
execution units (regardless of the vector width). Values > 1 are possible d=
ue to Fused-Multiply Add (FMA) counting."
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is at least 1 uop executed)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES=
_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
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
         "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
@@ -169,12 +163,24 @@
         "MetricName": "IpArith_AVX512",
         "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). May undercount due =
to FMA double counting."
     },
+    {
+        "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
+        "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
+        "MetricGroup": "Prefetches",
+        "MetricName": "IpSWPF"
+    },
     {
         "BriefDescription": "Total number of retired Instructions, Sample =
with: INST_RETIRED.PREC_DIST",
         "MetricExpr": "INST_RETIRED.ANY",
         "MetricGroup": "Summary;TmaL1",
         "MetricName": "Instructions"
     },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "Execute"
+    },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
         "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
@@ -194,11 +200,23 @@
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative DS=
B miss",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
+        "MetricGroup": "DSBmiss",
+        "MetricName": "DSB_Switch_Cost"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative DS=
B miss (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
         "MetricGroup": "DSBmiss;Fed",
         "MetricName": "IpDSB_Miss_Ret"
     },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "IpMispredict"
+    },
     {
         "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
         "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_B=
RANCHES",
@@ -230,11 +248,10 @@
         "MetricName": "Other_Branches"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load instructions (in core cycles)",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS =
+ MEM_LOAD_RETIRED.FB_HIT )",
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
@@ -242,30 +259,6 @@
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
-    {
-        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / d=
uration_time",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "L3_Cache_Access_BW"
-    },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY"=
,
@@ -285,13 +278,13 @@
         "MetricName": "L2MPKI"
     },
     {
-        "BriefDescription": "L2 cache misses per kilo instruction for all =
request types (including speculative)",
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
         "MetricExpr": "1000 * ( ( OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_R=
EQUESTS.DEMAND_DATA_RD ) + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS ) =
/ INST_RETIRED.ANY",
         "MetricGroup": "Mem;CacheMisses;Offcore",
         "MetricName": "L2MPKI_All"
     },
     {
-        "BriefDescription": "L2 cache misses per kilo instruction for all =
demand loads  (including speculative)",
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.=
ANY",
         "MetricGroup": "Mem;CacheMisses",
         "MetricName": "L2MPKI_Load"
@@ -309,7 +302,7 @@
         "MetricName": "L3MPKI"
     },
     {
-        "BriefDescription": "Fill Buffer (FB) true hits per kilo instructi=
ons for retired demand loads",
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
         "MetricGroup": "Mem;CacheMisses",
         "MetricName": "FB_HPKI"
@@ -321,6 +314,54 @@
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "Page_Walks_Utilization"
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
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / d=
uration_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW"
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
+        "MetricExpr": "(64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / =
duration_time)",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW_1T"
+    },
     {
         "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
@@ -337,7 +378,8 @@
         "BriefDescription": "Giga Floating Point Operations Per Second",
         "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_=
ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_=
DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE =
+ FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.5=
12B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
-        "MetricName": "GFLOPs"
+        "MetricName": "GFLOPs",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width and AMX engine."
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
diff --git a/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/icelake/uncore-other.json
new file mode 100644
index 000000000000..e007b976547d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/uncore-other.json
@@ -0,0 +1,31 @@
+[
+    {
+        "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop,  etc.",
+        "Counter": "1",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of entries allocated. Account for Any=
 type: e.g. Snoop,  etc.",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Total number of all outgoing entries allocate=
d. Accounts for Coherent and non-coherent traffic.",
+        "Counter": "1",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Total number of all outgoing entries allocat=
ed. Accounts for Coherent and non-coherent traffic.",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "UNC_CLOCK.SOCKET",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CLOCK.SOCKET",
+        "Unit": "CLOCK"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json b/t=
ools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
index a006fd7f7b18..58809e16bf98 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
@@ -242,4 +242,4 @@
         "Speculative": "1",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 41c0c694211a..aae90ece2013 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -10,6 +10,7 @@ GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-(3C|45|46),v31,haswell,core
 GenuineIntel-6-3F,v25,haswellx,core
+GenuineIntel-6-(7D|7E|A7),v1.14,icelake,core
 GenuineIntel-6-3A,v18,ivybridge,core
 GenuineIntel-6-3E,v19,ivytown,core
 GenuineIntel-6-2D,v20,jaketown,core
@@ -29,10 +30,7 @@ GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55-[01234],v1,skylakex,core
-GenuineIntel-6-7D,v1,icelake,core
-GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-8[CD],v1,tigerlake,core
-GenuineIntel-6-A7,v1,icelake,core
 GenuineIntel-6-6A,v1,icelakex,core
 GenuineIntel-6-6C,v1,icelakex,core
 GenuineIntel-6-86,v1,tremontx,core
--=20
2.37.1.359.gd136c6c3e2-goog

