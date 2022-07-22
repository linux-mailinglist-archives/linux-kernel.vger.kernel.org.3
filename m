Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1657E9BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiGVWea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbiGVWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:33:46 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9844DBA4F8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e9b1be83eso30965667b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=/z04qVowzmKKQ6pvgxE9UKuwnO9s6E2xCn/nFIuFicI=;
        b=TqxjsG8ybF/oM4ZMmju7+/Y32T06w/JL9DsW5cyoHhN2WLi3jUHdMbiv3B9IUKAtSJ
         m6Kj4VXpUQgXfRMGAtdoaaQu/Lz2uMqbLRty63IpgIYF3oLx+gMr59HGIQ81ozVuskWD
         JIDxcg1Umgmb2uKrq/lHZZlZpiWCWojYWnxQI+YrEJ9y4hDUaqcGkv+grGLeJYcJXJgh
         wZlvMR2G8t8qERkFdEREBoWdxEKYnM+77fUMqjSzQfOZpYP8/nFU9Y3++deoc+81Glho
         uq+RuDvWOc7DFGoOpsBLXdjEsl1bhtm/YGQ2qeS6Zi3d/sF9rWCV5TbJNuCePavcdPto
         K+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=/z04qVowzmKKQ6pvgxE9UKuwnO9s6E2xCn/nFIuFicI=;
        b=swHGBCB2H6JDRvmGnyWlLNQgz2jLwsTaXbuYhfun1hvPmM49KklVBbTnXm9XcccAaS
         dqSHnrJB1bMNvBDMa3vQigmF5bWW9PJopcejuKuz/OWmgDi6L6uZ4rCUJ0M+5z70AGlt
         hJwkPl1GPFnRKI98Y8113JUr+k+4zhTIRoZp5vChy6sOx3IYahShhC+tgB+e48rRDGu0
         JtAwz4s1hh3X8JdcELXbrbIxciPcnHVDTG7JEsZEWTOGvNe1vHQl1JGUTAQwzF5WakXO
         PIhAOufLqYkxf3p/w4l45mI0VgaOPyvcBkt7PePq4RhPgAFZlDlc50eeJAsVG2s9C3iu
         R5iA==
X-Gm-Message-State: AJIora/p5W6OIRVBFGcFZNEgZc6+YttHVK8GoUqflwPyArVlAe90voM9
        Z0ANwKREqZzcFkq/JAhS8JM88QMolovS
X-Google-Smtp-Source: AGRyM1uNCXkI98p4/f42LungkAqSEo4cK2mO8AuZptiOWjcHKvhiZXieThKIz3dJAoNtO28hTdPXoqFRYriT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:d248:0:b0:670:f123:db3c with SMTP id
 j69-20020a25d248000000b00670f123db3cmr1811133ybg.124.1658529213367; Fri, 22
 Jul 2022 15:33:33 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:25 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-17-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 16/31] perf vendor events: Update Intel ivytown
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the ivytown files into perf and update mapfile.csv.

Tested on a non-ivytown with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/ivytown/cache.json    |    2 +-
 .../arch/x86/ivytown/floating-point.json      |    2 +-
 .../pmu-events/arch/x86/ivytown/frontend.json |    2 +-
 .../arch/x86/ivytown/ivt-metrics.json         |   94 +-
 .../pmu-events/arch/x86/ivytown/memory.json   |    2 +-
 .../pmu-events/arch/x86/ivytown/other.json    |    2 +-
 .../arch/x86/ivytown/uncore-cache.json        | 3495 ++++++++++++++++-
 .../arch/x86/ivytown/uncore-interconnect.json | 1750 ++++++++-
 .../arch/x86/ivytown/uncore-memory.json       | 1775 ++++++++-
 .../arch/x86/ivytown/uncore-other.json        | 2411 ++++++++++++
 .../arch/x86/ivytown/uncore-power.json        |  696 +++-
 .../arch/x86/ivytown/virtual-memory.json      |    2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 13 files changed, 9864 insertions(+), 371 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/uncore-other.jso=
n

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/cache.json b/tools/perf=
/pmu-events/arch/x86/ivytown/cache.json
index 9bbf2bc59859..27576d53b347 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/cache.json
@@ -1257,4 +1257,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/floating-point.json
index db8b1c4fceb0..4c2ac010cf55 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
@@ -166,4 +166,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json b/tools/p=
erf/pmu-events/arch/x86/ivytown/frontend.json
index c956a0a51312..2b1a82dd86ab 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/frontend.json
@@ -312,4 +312,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json b/tool=
s/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
index 8d0ddcbd6c7c..782d68e1cd0d 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
@@ -130,17 +130,11 @@
         "MetricName": "FLOPc_SMT"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is at least 1 uop executed)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (( cpu@UOPS_EXECUTED.CORE\\,=
cmask\\=3D1@ / 2 ) if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
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
@@ -196,6 +190,18 @@
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
+    {
+        "BriefDescription": "",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "Execute"
+    },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MIT=
E_UOPS + IDQ.MS_UOPS ) )",
@@ -203,11 +209,16 @@
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
@@ -215,24 +226,6 @@
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
@@ -264,6 +257,48 @@
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
@@ -280,7 +315,8 @@
         "BriefDescription": "Giga Floating Point Operations Per Second",
         "MetricExpr": "( ( 1 * ( FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_CO=
MP_OPS_EXE.SSE_SCALAR_DOUBLE ) + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 =
* ( FP_COMP_OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE ) + 8 * S=
IMD_FP_256.PACKED_SINGLE ) / 1000000000 ) / duration_time",
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
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/memory.json b/tools/per=
f/pmu-events/arch/x86/ivytown/memory.json
index f904140203fe..99b71e43acad 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/memory.json
@@ -500,4 +500,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/other.json b/tools/perf=
/pmu-events/arch/x86/ivytown/other.json
index 83fe8f79adc6..2d62521791d8 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/other.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/other.json
@@ -41,4 +41,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
index 267410594833..1e53bee8af5c 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
@@ -1,321 +1,3480 @@
 [
     {
-        "BriefDescription": "Uncore cache clock ticks",
+        "BriefDescription": "Uncore Clocks",
         "Counter": "0,1,2,3",
         "EventName": "UNC_C_CLOCKTICKS",
         "PerPkg": "1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "All LLC Misses (code+ data rd + data wr - inc=
luding demand and prefetch)",
+        "BriefDescription": "Counter 0 Occupancy",
+        "Counter": "1,2,3",
+        "EventCode": "0x1f",
+        "EventName": "UNC_C_COUNTER0_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Since occupancy counts can only be captured =
in the Cbo's 0 counter, this event allows a user to capture occupancy relat=
ed information by filtering the Cb0 occupancy count captured in Counter 0. =
  The filtering available is found in the control register - threshold, inv=
ert and edge detect.   E.g. setting threshold to 1 can effectively monitor =
how many cycles the monitored queue has an entry.",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Any Request",
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
-        "Filter": "filter_state=3D0x1",
+        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Filters for any transaction o=
riginating from the IPQ or IRQ.  This does not include lookups originating =
from the ISMQ.",
         "UMask": "0x11",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "M line evictions from LLC (writebacks to memo=
ry)",
+        "BriefDescription": "Cache Lookups; Data Read Request",
         "Counter": "0,1",
-        "EventCode": "0x37",
-        "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
+        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Read transactions",
+        "UMask": "0x3",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches. Derived from unc_c_tor_inserts.miss_opcode.demand=
",
+        "BriefDescription": "Cache Lookups; Lookups that Match NID",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.DATA_READ",
-        "Filter": "filter_opc=3D0x182",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.NID",
+        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Qualify one of the other sube=
vents by the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.n=
id.   In conjunction with STATE =3D I, it is possible to monitor misses to =
specific NIDs in the system.",
+        "UMask": "0x41",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses - Uncacheable reads. Derived from =
unc_c_tor_inserts.miss_opcode.uncacheable",
+        "BriefDescription": "Cache Lookups; External Snoop Request",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.UNCACHEABLE",
-        "Filter": "filter_opc=3D0x187",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
+        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Filters for only snoop reques=
ts coming from the remote socket(s) through the IPQ.",
+        "UMask": "0x9",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC prefetch misses for RFO. Derived from unc=
_c_tor_inserts.miss_opcode.rfo_prefetch",
+        "BriefDescription": "Cache Lookups; Write Requests",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x190",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
+        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Writeback transactions from L=
2 to the LLC  This includes all write transactions -- both Cachable and UC.=
",
+        "UMask": "0x5",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC prefetch misses for code reads. Derived f=
rom unc_c_tor_inserts.miss_opcode.code",
+        "BriefDescription": "Lines Victimized; Lines in E state",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x191",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC prefetch misses for data reads. Derived f=
rom unc_c_tor_inserts.miss_opcode.data_read",
+        "BriefDescription": "Lines Victimized",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x192",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.MISS",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x8",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe allocating writes that miss LLC - DDIO m=
isses. Derived from unc_c_tor_inserts.miss_opcode.ddio_miss",
+        "BriefDescription": "Lines Victimized; Lines in M state",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_WRITE",
-        "Filter": "filter_opc=3D0x19c",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses for PCIe read current. Derived fro=
m unc_c_tor_inserts.miss_opcode.pcie_read",
+        "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_READ",
-        "Filter": "filter_opc=3D0x19e",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.NID",
+        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.; Qu=
alify one of the other subevents by the Target NID.  The NID is programmed =
in Cn_MSR_PMON_BOX_FILTER.nid.   In conjunction with STATE =3D I, it is pos=
sible to monitor misses to specific NIDs in the system.",
+        "UMask": "0x40",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses for ItoM writes (as part of fast s=
tring memcpy stores). Derived from unc_c_tor_inserts.miss_opcode.itom_write=
",
+        "BriefDescription": "Lines Victimized; Lines in S State",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.ITOM_WRITE",
-        "Filter": "filter_opc=3D0x1c8",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.S_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses for PCIe non-snoop reads. Derived =
from unc_c_tor_inserts.miss_opcode.pcie_read",
+        "BriefDescription": "Cbo Misc; RFO HitS",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_NON_SNOOP_READ",
-        "Filter": "filter_opc=3D0x1e4",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.RFO_HIT_S",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Miscellaneous events in the Cbo.; Number of =
times that an RFO hit in S state.  This is useful for determining if it mig=
ht be good for a workload to use RspIWB instead of RspSWB.",
+        "UMask": "0x8",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses for PCIe non-snoop writes (full li=
ne). Derived from unc_c_tor_inserts.miss_opcode.pcie_write",
+        "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
-        "Filter": "filter_opc=3D0x1e6",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.RSPI_WAS_FSE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Miscellaneous events in the Cbo.; Counts the=
 number of times when a Snoop hit in FSE states and triggered a silent evic=
tion.  This is useful because this information is lost in the PRE encodings=
.",
+        "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_c_tor_inserts.opcode.streaming_full",
+        "BriefDescription": "Cbo Misc",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_FULL",
-        "Filter": "filter_opc=3D0x18c",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.STARTED",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "Miscellaneous events in the Cbo.",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_c_tor_inserts.opcode.streaming_partial",
+        "BriefDescription": "Cbo Misc; Write Combining Aliasing",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
-        "Filter": "filter_opc=3D0x18d",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.WC_ALIASING",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "Miscellaneous events in the Cbo.; Counts the=
 number of times that a USWC write (WCIL(F)) transaction hit in the LLC in =
M state, triggering a WBMtoI followed by the USWC write.  This occurs when =
there is WC aliasing.",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Partial PCIe reads. Derived from unc_c_tor_in=
serts.opcode.pcie_partial",
+        "BriefDescription": "LRU Queue; LRU Age 0",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_PARTIAL_READ",
-        "Filter": "filter_opc=3D0x195",
+        "EventCode": "0x3c",
+        "EventName": "UNC_C_QLRU.AGE0",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "How often age was set to 0",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe allocating writes that hit in LLC (DDIO =
hits). Derived from unc_c_tor_inserts.opcode.ddio_hit",
+        "BriefDescription": "LRU Queue; LRU Age 1",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_WRITE",
-        "Filter": "filter_opc=3D0x19c",
+        "EventCode": "0x3c",
+        "EventName": "UNC_C_QLRU.AGE1",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "How often age was set to 1",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe read current. Derived from unc_c_tor_ins=
erts.opcode.pcie_read_current",
+        "BriefDescription": "LRU Queue; LRU Age 2",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_READ",
-        "Filter": "filter_opc=3D0x19e",
+        "EventCode": "0x3c",
+        "EventName": "UNC_C_QLRU.AGE2",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "How often age was set to 2",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "ItoM write hits (as part of fast string memcp=
y stores). Derived from unc_c_tor_inserts.opcode.itom_write_hit",
+        "BriefDescription": "LRU Queue; LRU Age 3",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.ITOM_WRITE",
-        "Filter": "filter_opc=3D0x1c8",
+        "EventCode": "0x3c",
+        "EventName": "UNC_C_QLRU.AGE3",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "How often age was set to 3",
+        "UMask": "0x8",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe non-snoop reads. Derived from unc_c_tor_=
inserts.opcode.pcie_read",
+        "BriefDescription": "LRU Queue; LRU Bits Decremented",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_READ",
-        "Filter": "filter_opc=3D0x1e4",
+        "EventCode": "0x3c",
+        "EventName": "UNC_C_QLRU.LRU_DECREMENT",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "How often all LRU bits were decremented by 1=
",
+        "UMask": "0x10",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe non-snoop writes (partial). Derived from=
 unc_c_tor_inserts.opcode.pcie_partial_write",
+        "BriefDescription": "LRU Queue; Non-0 Aged Victim",
         "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
-        "Filter": "filter_opc=3D0x1e5",
+        "EventCode": "0x3c",
+        "EventName": "UNC_C_QLRU.VICTIM_NON_ZERO",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "How often we picked a victim that had a non-=
zero age",
+        "UMask": "0x20",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe non-snoop writes (full line). Derived fr=
om unc_c_tor_inserts.opcode.pcie_full_write",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_WRITE",
-        "Filter": "filter_opc=3D0x1e6",
+        "BriefDescription": "AD Ring In Use; Counterclockwise",
+        "Counter": "2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
+        "UMask": "0xC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Clockwise",
+        "Counter": "2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down",
+        "Counter": "2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.DOWN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
+        "UMask": "0xCC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Even on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Even ring polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Odd on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Odd ring polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Even on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Even ring polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down and Odd on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Odd ring polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Up",
+        "Counter": "2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.UP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
+        "UMask": "0x33",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Up and Even on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.UP_VR0_EVEN",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Even ring polarity on Virtual Ring 0.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Occupancy for all LLC misses that are address=
ed to local memory",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL",
+        "BriefDescription": "AD Ring In Use; Up and Odd on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.UP_VR0_ODD",
         "PerPkg": "1",
-        "UMask": "0x2A",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Odd ring polarity on Virtual Ring 0.",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Occupancy counter for LLC data reads (demand =
and L2 prefetch). Derived from unc_c_tor_occupancy.miss_opcode.llc_data_rea=
d",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
-        "Filter": "filter_opc=3D0x182",
+        "BriefDescription": "AD Ring In Use; Up and Even on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.UP_VR1_EVEN",
         "PerPkg": "1",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Even ring polarity on Virtual Ring 1.",
+        "UMask": "0x10",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Occupancy for all LLC misses that are address=
ed to remote memory",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE",
+        "BriefDescription": "AD Ring In Use; Up and Odd on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_C_RING_AD_USED.UP_VR1_ODD",
         "PerPkg": "1",
-        "UMask": "0x8A",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in JKT -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Odd ring polarity on Virtual Ring 1.",
+        "UMask": "0x20",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Read requests to home agent",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.READS",
+        "BriefDescription": "AK Ring In Use; Counterclockwise",
+        "Counter": "2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
+        "UMask": "0xC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Clockwise",
+        "Counter": "2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.CW",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0x3",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "Write requests to home agent",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.WRITES",
+        "BriefDescription": "AK Ring In Use; Down",
+        "Counter": "2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.DOWN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
+        "UMask": "0xCC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down and Even on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down and Odd on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down and Even on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Down and Odd on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up",
+        "Counter": "2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.UP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
+        "UMask": "0x33",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Even on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.UP_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Odd on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.UP_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Even on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.UP_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Odd on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_C_RING_AK_USED.UP_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Counterclockwise",
+        "Counter": "2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.CCW",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0xC",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "M line forwarded from remote cache along with=
 writeback to memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
+        "BriefDescription": "BL Ring in Use; Clockwise",
+        "Counter": "2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down",
+        "Counter": "2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.DOWN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
+        "UMask": "0xCC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down and Even on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down and Odd on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down and Even on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down and Odd on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up",
+        "Counter": "2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.UP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
+        "UMask": "0x33",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Even on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.UP_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Odd on Vring 0",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.UP_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Even on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.UP_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Up and Odd on VRing 1",
+        "Counter": "2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_C_RING_BL_USED.UP_VR1_ODD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in JKT -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity on Virtual Ring 1.",
         "UMask": "0x20",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "M line forwarded from remote cache with no wr=
iteback to memory",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.AD_IRQ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Acknowledgements to core",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.AK",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x4",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "Shared line response from remote cache",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPS",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.: Acknowledgements to core",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.AK_CORE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x2",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "Shared line forwarded from remote cache",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Data Responses to core",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.BL",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.: Data Responses to core",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.BL_CORE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.IV",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.: Snoops of processor's cache.",
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.IV_CORE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "IV Ring in Use; Any",
+        "Counter": "2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_C_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters any polarity",
+        "UMask": "0xF",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "IV Ring in Use; Down",
+        "Counter": "2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_C_RING_IV_USED.DOWN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for Down polarity",
+        "UMask": "0xCC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "IV Ring in Use; Up",
+        "Counter": "2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_C_RING_IV_USED.UP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for Up polarity",
+        "UMask": "0x33",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; IRQ",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.IPQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IPQ is externally startved and therefore we are blocking the IRQ.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; IPQ",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IRQ is externally starved and therefore we are blocking the IPQ.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; ISMQ_BID",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.ISMQ_BIDS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; Number of times that the ISMQ Bid.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.PRQ",
+        "PerPkg": "1",
+        "PublicDescription": "IRQ is blocking the ingress queue and causin=
g the starvation.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IPQ",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IPQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IRQ",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IRQ Rejected",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IRQ_REJ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations: IRQ Rejected",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IRQ_REJECTED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; VFIFO",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.VFIFO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.; Counts the number of allocations into the IRQ=
 Ordering FIFO.  In JKT, it is necessary to keep IO requests in order.  The=
refore, they are allocated into an ordering FIFO that sits next to the IRQ,=
 and must be satisfied from the FIFO in order (with respect to each other).=
  This event, in conjunction with the Occupancy Accumulator event, can be u=
sed to calculate average lifetime in the FIFO.  Transactions are allocated =
into the FIFO as soon as they enter the Cachebo (and the IRQ) and are deall=
ocated from the FIFO as soon as they are deallocated from the IRQ.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.IPQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.; Cycles with the IPQ in Internal S=
tarvation.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; IRQ",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.; Cycles with the IRQ in Internal S=
tarvation.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; ISMQ",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.ISMQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.; Cycles with the ISMQ in Internal =
Starvation.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; Address Conflict",
+        "Counter": "0,1",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.ADDR_CONFLICT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request form the IPQ was retried because of a T=
OR reject from an address conflicts.  Address conflicts out of the IPQ shou=
ld be rare.  They will generally only occur if two different sockets are se=
nding requests to the same address at the same time.  This is a true confli=
ct case, unlike the IPQ Address Conflict which is commonly caused by prefet=
ching characteristics.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; Any Reject",
+        "Counter": "0,1",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request form the IPQ was retried because of a T=
OR reject.  TOR rejects from the IPQ can be caused by the Egress being full=
 or Address Conflicts.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; No Egress Credits",
+        "Counter": "0,1",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request form the IPQ was retried because of a T=
OR reject from the Egress being full.  IPQ requests make use of the AD Egre=
ss for regular responses, the BL egress to forward data, and the AK egress =
to return credits.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; No QPI Credits",
+        "Counter": "0,1",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.QPI_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.ADDR_CONFLICT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request fr=
om the IRQ was retried because of an address match in the TOR.  In order to=
 maintain coherency, requests to the same address are not allowed to pass e=
ach other up in the Cbo.  Therefore, if there is an outstanding request to =
a given address, one cannot issue another request to that address until it =
is complete.  This comes up most commonly with prefetches.  Outstanding pre=
fetches occasionally will not complete their memory fetch and a demand requ=
est to the same address will then sit in the IRQ and get retried until the =
prefetch fills the data into the LLC.  Therefore, it will not be uncommon t=
o see this case in high bandwidth streaming workloads when the LLC Prefetch=
er in the core is enabled.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; Any Reject",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of IRQ retries that occur.=
  Requests from the IRQ are retried if they are rejected from the TOR pipel=
ine for a variety of reasons.  Some of the most common reasons include if t=
he Egress is full, there are no RTIDs, or there is a Physical Address match=
 to another outstanding request.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No Egress Cred=
its",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request fr=
om the IRQ was retried because it failed to acquire an entry in the Egress.=
  The egress is the buffer that queues up for allocating onto the ring.  IR=
Q requests can make use of all four rings and all four Egresses.  If any of=
 the queues that a given request needs to make use of are full, the request=
 will be retried.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No IIO Credits=
",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.IIO_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request attempted to acqui=
re the NCS/NCB credit for sending messages on BL to the IIO.  There is a si=
ngle credit in each CBo that is shared between the NCS and NCB message clas=
ses for sending transactions on the BL ring (such as read data) to the IIO.=
",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.QPI_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of requests rejects because of lack o=
f QPI Ingress credits.  These credits are required in order to send transac=
tions to the QPI agent.  Please see the QPI_IGR_CREDITS events for more inf=
ormation.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No RTIDs",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.RTID",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that requests fro=
m the IRQ were retried because there were no RTIDs available.  RTIDs are re=
quired after a request misses the LLC and needs to send snoops and/or reque=
sts to memory.  If there are no RTIDs available, requests will queue up in =
the IRQ and retry until one becomes available.  Note that there are multipl=
e RTID pools for the different sockets.  There may be cases where the local=
 RTIDs are all used, but requests destined for remote memory can still acqu=
ire an RTID because there are remote RTIDs available.  This event does not =
provide any filtering for this case.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; Any Reject",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Counts the =
total number of times that a request from the ISMQ retried because of a TOR=
 reject.  ISMQ requests generally will not need to retry (or at least ISMQ =
retries are less common than IRQ retries).  ISMQ requests will retry if the=
y are not able to acquire a needed Egress credit to get onto the ring, or f=
or cache evictions that need to acquire an RTID.  Most ISMQ requests alread=
y have an RTID, so eviction retries will be less common here.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No Egress Credits",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Counts the =
number of times that a request from the ISMQ retried because of a TOR rejec=
t caused by a lack of Egress credits. The egress is the buffer that queues =
up for allocating onto the ring.  If any of the Egress queues that a given =
request needs to make use of are full, the request will be retried.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No IIO Credits",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.IIO_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Number of t=
imes a request attempted to acquire the NCS/NCB credit for sending messages=
 on BL to the IIO.  There is a single credit in each CBo that is shared bet=
ween the NCS and NCB message classes for sending transactions on the BL rin=
g (such as read data) to the IIO.",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No QPI Credits",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.QPI_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No RTIDs",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.RTID",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Counts the =
number of times that a request from the ISMQ retried because of a TOR rejec=
t caused by no RTIDs.  M-state cache evictions are serviced through the ISM=
Q, and must acquire an RTID in order to write back to memory.  If no RTIDs =
are available, they will be retried.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No WB Credits",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.WB_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Retries of =
writes to local memory due to lack of HT WB credits",
+        "UMask": "0x80",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; IPQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IPQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; IRQ",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; IRQ Rejected",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IRQ_REJ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "IRQ Rejected",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.IRQ_REJECTED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy; VFIFO",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.VFIFO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.; Accumulates the number of used entries in the I=
RQ Ordering FIFO in each cycle.  In JKT, it is necessary to keep IO request=
s in order.  Therefore, they are allocated into an ordering FIFO that sits =
next to the IRQ, and must be satisfied from the FIFO in order (with respect=
 to each other).  This event, in conjunction with the Allocations event, ca=
n be used to calculate average lifetime in the FIFO.  This event can be use=
d in conjunction with the Not Empty event to calculate average queue occupa=
ncy. Transactions are allocated into the FIFO as soon as they enter the Cac=
hebo (and the IRQ) and are deallocated from the FIFO as soon as they are de=
allocated from the IRQ.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; All",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR.    This includes requests that reside in the TOR for a short=
 time, such as LLC Hits that do not need to snoop cores or requests that ge=
t rejected and have to be retried through one of the ingress queues.  The T=
OR is more commonly a bottleneck in skews with smaller core counts, where t=
he ratio of RTIDs to TOR entries is larger.  Note that there are reserved T=
OR entries for various request types, so it is possible that a given reques=
t type be blocked with an occupancy that is less than 20.  Also note that g=
enerally requests will not be able to arbitrate into the TOR pipeline if th=
ere are no available TOR slots.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Evictions",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.EVICTION",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Eviction transactions ins=
erted into the TOR.  Evictions can be quick, such as when the line is in th=
e F, S, or E states and no core valid bits are set.  They can also be longe=
r if either CV bits are set (so the cores need to be snooped) and/or if the=
re is a HitM (in which case it is necessary to write the request out to mem=
ory).",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Local Memory",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by locally HOMed memory.",
+        "UMask": "0x28",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "UMask": "0x21",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Misses to Local Memory",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by locally HOMed memory.",
+        "UMask": "0x2A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcode =
Matched",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode, inserted into the TOR that are satisifed by locally HOMed=
 memory.",
+        "UMask": "0x23",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Miss Opcode Match",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Misses to Remote Memory",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that are satisifed by remote caches or remote memory.",
+        "UMask": "0x8A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opcode=
 Matched",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
+        "UMask": "0x83",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches =
an RTID destination) transactions inserted into the TOR.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it is=
 possible to monitor misses to specific NIDs in the system.",
+        "UMask": "0x48",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched Evictions",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tran=
sactions inserted into the TOR.",
+        "UMask": "0x44",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched Miss All",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss requ=
ests that were inserted into the TOR.",
+        "UMask": "0x4A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
+        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match a NID and an opcode.",
+        "UMask": "0x43",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID and Opcode Matched",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
+        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match a NID and an opcode.",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; NID Matched Writebacks",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.NID_WB",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transac=
tions inserted into the TOR.",
+        "UMask": "0x50",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Opcode Match",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Remote Memory",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions inserted=
 into the TOR that are satisifed by remote caches or remote memory.",
+        "UMask": "0x88",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by remote caches=
 or remote memory.",
+        "UMask": "0x81",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; Writebacks",
+        "Counter": "0,1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.WB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Write transactions insert=
ed into the TOR.   This does not include RFO, but actual operations that co=
ntain data being sent from the core.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Any",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); All valid TO=
R entries.  This includes requests that reside in the TOR for a short time,=
 such as LLC Hits that do not need to snoop cores or requests that get reje=
cted and have to be retried through one of the ingress queues.  The TOR is =
more commonly a bottleneck in skews with smaller core counts, where the rat=
io of RTIDs to TOR entries is larger.  Note that there are reserved TOR ent=
ries for various request types, so it is possible that a given request type=
 be blocked with an occupancy that is less than 20.  Also note that general=
ly requests will not be able to arbitrate into the TOR pipeline if there ar=
e no available TOR slots.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Evictions",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.EVICTION",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding eviction transactions in the TOR.  Evictions can be quick, such a=
s when the line is in the F, S, or E states and no core valid bits are set.=
  They can also be longer if either CV bits are set (so the cores need to b=
e snooped) and/or if there is a HitM (in which case it is necessary to writ=
e the request out to memory).",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x28",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Local Memory - Opcode Matched"=
,
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by locally HOMed memory.",
+        "UMask": "0x21",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Miss All",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding miss requests in the TOR.  'Miss' means the allocation requires a=
n RTID.  This generally means that the request was sent to memory or MMIO."=
,
+        "UMask": "0xA",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x2A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Misses to Local Memory - Opcod=
e Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by locally HOMed memory.",
+        "UMask": "0x23",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Miss Opcode Match",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
for miss transactions that match an opcode. This generally means that the r=
equest was sent to memory or MMIO.",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x8A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Misses to Remote Memory - Opco=
de Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by remote caches or remote memory.",
+        "UMask": "0x83",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_ALL",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of NI=
D matched outstanding requests in the TOR.  The NID is programmed in Cn_MSR=
_PMON_BOX_FILTER.nid.In conjunction with STATE =3D I, it is possible to mon=
itor misses to specific NIDs in the system.",
+        "UMask": "0x48",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched Evictions",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_EVICTION",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding NID matched eviction transactions in the TOR .",
+        "UMask": "0x44",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID.",
+        "UMask": "0x4A",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE",
+        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID and an opcode.",
+        "UMask": "0x43",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_OPCODE",
+        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match a NID and an opcode.",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; NID Matched Writebacks",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.NID_WB",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); NID matched =
write transactions int the TOR.",
+        "UMask": "0x50",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Opcode Match",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc).",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
+        "UMask": "0x88",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Remote Memory - Opcode Matched=
",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
+        "Filter": "CBoFilter1[28:20]",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by remote caches or remote memory.",
+        "UMask": "0x81",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Occupancy; Writebacks",
+        "EventCode": "0x36",
+        "EventName": "UNC_C_TOR_OCCUPANCY.WB",
+        "PerPkg": "1",
+        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Write transa=
ctions in the TOR.   This does not include RFO, but actual operations that =
contain data being sent from the core.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Onto AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Onto AK Ring",
+        "Counter": "0,1",
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Onto BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AD - Cachebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AD_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the AD ring.  Some example include out=
bound requests, snoop requests, and snoop responses.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AD - Corebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AD_CORE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the AD ring.  This is commonly used for=
 outbound requests.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AK - Cachebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AK_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the AK ring.  This is commonly used fo=
r credit returns and GO responses.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AK - Corebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.AK_CORE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the AK ring.  This is commonly used for=
 snoop responses coming from the core and destined for a Cachebo.",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; BL - Cacheno",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.BL_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the BL ring.  This is commonly used to=
 send data from the cache to various destinations.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; BL - Corebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.BL_CORE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Corebo destined for the BL ring.  This is commonly used for=
 transfering writeback data to the cache.",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; IV - Cachebo",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_C_TxR_INSERTS.IV_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the Cbo Egress.  =
The Egress is used to queue up requests destined for the ring.; Ring transa=
ctions from the Cachebo destined for the IV ring.  This is commonly used fo=
r snoops to the cores.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto AD Ring (to core)"=
,
+        "Counter": "0,1",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.AD_CORE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that the core AD egress spent in starvation"=
,
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto AK Ring",
+        "Counter": "0,1",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.AK_BOTH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that both AK egresses spent in starvation",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto IV Ring",
+        "Counter": "0,1",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.IV",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that the cachebo IV egress spent in starvati=
on",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; AD Opcodes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.AD",
+        "Filter": "HA_OpcodeMatch[5:0]",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; Address",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.ADDR",
+        "Filter": "HA_AddrMatch0[31:6], HA_AddrMatch1[13:0]",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; AK Opcodes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.AK",
+        "Filter": "HA_OpcodeMatch[5:0]",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; BL Opcodes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.BL",
+        "Filter": "HA_OpcodeMatch[5:0]",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; Address & Opcode Ma=
tch",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.FILT",
+        "Filter": "HA_AddrMatch0[31:6], HA_AddrMatch1[13:0], HA_OpcodeMatc=
h[5:0]",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "QPI Address/Opcode Match; Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_H_ADDR_OPC_MATCH.OPC",
+        "Filter": "HA_OpcodeMatch[5:0]",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x52",
+        "EventName": "UNC_H_BT_BYPASS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of transactions that bypass the BT (f=
ifo) to HT",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_H_BT_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Cycles the Backup Tracker (BT) is not empty.=
 The BT is the actual HOM tracker in IVT.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Cycles Not Empty: Local",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_H_BT_CYCLES_NE.LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Cycles the Backup Tracker (BT) is not empty.=
 The BT is the actual HOM tracker in IVT.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Cycles Not Empty: Remote",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_H_BT_CYCLES_NE.REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Cycles the Backup Tracker (BT) is not empty.=
 The BT is the actual HOM tracker in IVT.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Occupancy; Local",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_H_BT_OCCUPANCY.LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the HA BT pool =
in every cycle.  This can be used with the not empty stat to calculate aver=
age queue occupancy or the allocations stat in order to calculate average q=
ueue latency.  HA BTs are allocated as soon as a request enters the HA and =
is released after the snoop response and data return (or post in the case o=
f a write) and the response is returned on the ring.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Occupancy; Reads Local",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_H_BT_OCCUPANCY.READS_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the HA BT pool =
in every cycle.  This can be used with the not empty stat to calculate aver=
age queue occupancy or the allocations stat in order to calculate average q=
ueue latency.  HA BTs are allocated as soon as a request enters the HA and =
is released after the snoop response and data return (or post in the case o=
f a write) and the response is returned on the ring.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Occupancy; Reads Remote",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_H_BT_OCCUPANCY.READS_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the HA BT pool =
in every cycle.  This can be used with the not empty stat to calculate aver=
age queue occupancy or the allocations stat in order to calculate average q=
ueue latency.  HA BTs are allocated as soon as a request enters the HA and =
is released after the snoop response and data return (or post in the case o=
f a write) and the response is returned on the ring.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Occupancy; Remote",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_H_BT_OCCUPANCY.REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the HA BT pool =
in every cycle.  This can be used with the not empty stat to calculate aver=
age queue occupancy or the allocations stat in order to calculate average q=
ueue latency.  HA BTs are allocated as soon as a request enters the HA and =
is released after the snoop response and data return (or post in the case o=
f a write) and the response is returned on the ring.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Occupancy; Writes Local",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_H_BT_OCCUPANCY.WRITES_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the HA BT pool =
in every cycle.  This can be used with the not empty stat to calculate aver=
age queue occupancy or the allocations stat in order to calculate average q=
ueue latency.  HA BTs are allocated as soon as a request enters the HA and =
is released after the snoop response and data return (or post in the case o=
f a write) and the response is returned on the ring.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT Occupancy; Writes Remote",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_H_BT_OCCUPANCY.WRITES_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the HA BT pool =
in every cycle.  This can be used with the not empty stat to calculate aver=
age queue occupancy or the allocations stat in order to calculate average q=
ueue latency.  HA BTs are allocated as soon as a request enters the HA and =
is released after the snoop response and data return (or post in the case o=
f a write) and the response is returned on the ring.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.INCOMING_BL_HAZARD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not issue transaction from BT to HT.; Cycles unable to issue from BT due t=
o incoming BL data hazard",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT to HT Not Issued; Incoming Snoop Hazard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.INCOMING_SNP_HAZARD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not issue transaction from BT to HT.; Cycles unable to issue from BT due t=
o incoming snoop hazard",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.RSPACKCFLT_HAZARD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not issue transaction from BT to HT.; Cycles unable to issue from BT due t=
o incoming BL data hazard",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BT to HT Not Issued; Incoming Data Hazard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "UNC_H_BT_TO_HT_NOT_ISSUED.WBMDATA_HAZARD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not issue transaction from BT to HT.; Cycles unable to issue from BT due t=
o incoming BL data hazard",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Bypass; Not Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_BYPASS_IMC.NOT_TAKEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filted =
by when the bypass was taken and when it was not.; Filter for transactions =
that could not take the bypass.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Bypass; Taken",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_H_BYPASS_IMC.TAKEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filted =
by when the bypass was taken and when it was not.; Filter for transactions =
that succeeded in taking the bypass.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "uclks",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_H_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the HA.  This =
will be slightly different than the count in the Ubox because of enable/fre=
eze delays.  The HA is on the other side of the die from the fixed Ubox ucl=
k counter, so the drift could be somewhat larger than in units that are clo=
ser like the QPI Agent.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Conflict Checks; Acknowledge Conflicts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_H_CONFLICT_CYCLES.ACKCNFLTS",
+        "PerPkg": "1",
+        "PublicDescription": "Count the number of Ackcnflts",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Conflict Checks; Cmp Fwds",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_H_CONFLICT_CYCLES.CMP_FWDS",
+        "PerPkg": "1",
+        "PublicDescription": "Count the number of Cmp_Fwd. This will give =
the number of late conflicts.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Conflict Checks; Conflict Detected",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_H_CONFLICT_CYCLES.CONFLICT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that we are hand=
ling conflicts.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Conflict Checks; Last in conflict chain",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_H_CONFLICT_CYCLES.LAST",
+        "PerPkg": "1",
+        "PublicDescription": "Count every last conflictor in conflict chai=
n. Can be used to compute the average conflict chain length as (#Ackcnflts/=
#LastConflictor)+1. This can be used to give a feel for the conflict chain =
lenghts while analyzing lock kernels.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Direct2Core Messages Sent",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_DIRECT2CORE_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Direct2Core messages sent",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles when Direct2Core was Disabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_H_DIRECT2CORE_CYCLES_DISABLED",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles in which Direct2Core was di=
sabled",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Number of Reads that had Direct2Core Overridd=
en",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_DIRECT2CORE_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Reads where Direct2Core overridden=
",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lat Opt Return",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_H_DIRECTORY_LAT_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "Directory Latency Optimization Data Return P=
ath Taken. When directory mode is enabled and the directory retuned for a r=
ead is Dir=3DI, then data can be returned using a faster path if certain co=
nditions are met (credits, free pipeline, etc).",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups: Any state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups; Snoop Not Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.NO_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.; Filters for transactions that did not have to send=
 any snoops because the directory bit was clear.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups: Snoop A",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.SNOOP_A",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups: Snoop S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.SNOOP_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups; Snoop Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.; Filters for transactions that had to send one or m=
ore snoops because the directory bit was set.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups: A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.STATE_A",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups: I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.STATE_I",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Lookups: S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_H_DIRECTORY_LOOKUP.STATE_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that looke=
d up the directory.  Can be filtered by requests that had to snoop and thos=
e that did not have to.",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates: A2I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.A2I",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates: A2S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.A2S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates; Any Directory Update",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates; Directory Clear",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.CLEAR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.; Filter for directory c=
lears.  This occurs when snoops were sent and all returned with RspI.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates: I2A",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.I2A",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates: I2S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.I2S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates: S2A",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.S2A",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates: S2I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.S2I",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Directory Updates; Directory Set",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_H_DIRECTORY_UPDATE.SET",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of directory updates that =
were required.  These result in writes to the memory controller.  This can =
be filtered by directory sets and directory clears.; Filter for directory s=
ets.  This occurs when a remote read transaction requests memory, bringing =
it to a remote cache.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD QPI Link 2 Credit Accumulator",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_H_IGR_AD_QPI2_ACCUMULATOR",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of credits available =
to the QPI Link 2 AD Ingress buffer.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL QPI Link 2 Credit Accumulator",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5a",
+        "EventName": "UNC_H_IGR_BL_QPI2_ACCUMULATOR",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of credits available =
to the QPI Link 2 BL Ingress buffer.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD QPI Link 2 Credit Accumulator",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_H_IGR_CREDITS_AD_QPI2",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of credits available =
to the QPI Link 2 AD Ingress buffer.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL QPI Link 2 Credit Accumulator",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5A",
+        "EventName": "UNC_H_IGR_CREDITS_BL_QPI2",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of credits available =
to the QPI Link 2 BL Ingress buffer.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; AD to QPI=
 Link 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Normal Priority Reads Issued; Norma=
l Priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_H_IMC_READS.NORMAL",
+        "PerPkg": "1",
+        "PublicDescription": "Count of the number of reads issued to any o=
f the memory controller channels.  This can be filtered by the priority of =
the reads.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Retry Events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_H_IMC_RETRY",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; All Writes=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0xF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; Full Line =
Non-ISOCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Full=
 Line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.FULL_ISOCH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; Partial No=
n-ISOCH",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.PARTIAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; ISOCH Part=
ial",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_H_IMC_WRITES.PARTIAL_ISOCH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IODC Conflicts; Any Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x57",
+        "EventName": "UNC_H_IODC_CONFLICTS.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IODC Conflicts; Last Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x57",
+        "EventName": "UNC_H_IODC_CONFLICTS.LAST",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IODC Conflicts: Remote InvItoE - Same RTID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x57",
+        "EventName": "UNC_H_IODC_CONFLICTS.REMOTE_INVI2E_SAME_RTID",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IODC Conflicts: Remote (Other) - Same Addr",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x57",
+        "EventName": "UNC_H_IODC_CONFLICTS.REMOTE_OTHER_SAME_ADDR",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IODC Inserts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_H_IODC_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "IODC Allocations",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Num IODC 0 Length Writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x58",
+        "EventName": "UNC_H_IODC_OLEN_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "Num IODC 0 Length Writebacks M to I - All of=
 which are dropped.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Local InvItoE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Count of OSB snoop broadcasts. Counts by 1 p=
er request causing OSB snoops to be broadcast. Does not count all the snoop=
s generated by OSB.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Local Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.READS_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Count of OSB snoop broadcasts. Counts by 1 p=
er request causing OSB snoops to be broadcast. Does not count all the snoop=
s generated by OSB.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Remote",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Count of OSB snoop broadcasts. Counts by 1 p=
er request causing OSB snoops to be broadcast. Does not count all the snoop=
s generated by OSB.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that broad=
cast snoop due to OSB, but found clean data in memory and was able to do ea=
rly data return",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; Reads to Local  I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.READS_LOCAL_I",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that broad=
cast snoop due to OSB, but found clean data in memory and was able to do ea=
rly data return",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; Reads to Local S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.READS_LOCAL_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that broad=
cast snoop due to OSB, but found clean data in memory and was able to do ea=
rly data return",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; Reads to Remote I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.READS_REMOTE_I",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that broad=
cast snoop due to OSB, but found clean data in memory and was able to do ea=
rly data return",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Early Data Return; Reads to Remote S",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_OSB_EDR.READS_REMOTE_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of transactions that broad=
cast snoop due to OSB, but found clean data in memory and was able to do ea=
rly data return",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Local InvItoEs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; This filter incl=
udes only InvItoEs coming from the local socket.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Remote InvItoEs",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.INVITOE_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; This filter incl=
udes only InvItoEs coming from remote sockets.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; Incoming ead req=
uests.  This is a good proxy for LLC Read Misses (including RFOs).",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Local Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.READS_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; This filter incl=
udes only read requests coming from the local socket.  This is a good proxy=
 for LLC Read Misses (including RFOs) from the local socket.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Remote Reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.READS_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; This filter incl=
udes only read requests coming from the remote socket.  This is a good prox=
y for LLC Read Misses (including RFOs) from the remote socket.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; Incoming write r=
equests.",
+        "UMask": "0xC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Local Writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; This filter incl=
udes only writes coming from the local socket.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Read and Write Requests; Remote Writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_H_REQUESTS.WRITES_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of read requests mad=
e into the Home Agent. Reads include all read opcodes (including RFO).  Wri=
tes include all writes (streaming, evictions, HitM, etc).; This filter incl=
udes only writes coming from remote sockets.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xCC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Even =
on VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CCW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Odd o=
n VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CCW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Even on VRin=
g 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Odd on VRing=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Even on VRin=
g 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Odd on VRing=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3e",
+        "EventName": "UNC_H_RING_AD_USED.CW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xCC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Even =
on VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CCW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Odd o=
n VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CCW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Even on VRin=
g 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Odd on VRing=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Even on VRin=
g 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Odd on VRing=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3f",
+        "EventName": "UNC_H_RING_AK_USED.CW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xCC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise and Even =
on VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise and Odd o=
n VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Even on VRin=
g 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Odd on VRing=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Even on VRin=
g 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Odd on VRing=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 0 only.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 1 only.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 2 only.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Regular; Channel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 3 only.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o special credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the special credits.  This =
statistic is generally not interesting for general IA workloads, but may be=
 of interest for understanding the characteristics of systems using ISOCH. =
 One can filter based on the memory controller channel.  One or more channe=
ls can be tracked at a given time.; Filter for memory controller channel 0 =
only.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o special credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the special credits.  This =
statistic is generally not interesting for general IA workloads, but may be=
 of interest for understanding the characteristics of systems using ISOCH. =
 One can filter based on the memory controller channel.  One or more channe=
ls can be tracked at a given time.; Filter for memory controller channel 1 =
only.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o special credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the special credits.  This =
statistic is generally not interesting for general IA workloads, but may be=
 of interest for understanding the characteristics of systems using ISOCH. =
 One can filter based on the memory controller channel.  One or more channe=
ls can be tracked at a given time.; Filter for memory controller channel 2 =
only.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "iMC RPQ Credits Empty - Special; Channel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_H_RPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o special credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the special credits.  This =
statistic is generally not interesting for general IA workloads, but may be=
 of interest for understanding the characteristics of systems using ISOCH. =
 One can filter based on the memory controller channel.  One or more channe=
ls can be tracked at a given time.; Filter for memory controller channel 3 =
only.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; RSPCNFLCT*",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for snoops responses of RspConflict.  This is returned when a snoop f=
inds an existing outstanding transaction in a remote caching agent when it =
CAMs that caching agent.  This triggers conflict resolution hardware.  This=
 covers both RspCnflct and RspCnflctWbI.",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; RspI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPI",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for snoops responses of RspI.  RspI is returned when the remote cache=
 does not have the data, or when the remote cache silently evicts data (suc=
h as when an RFO hits non-modified data).",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; RspIFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for snoop responses of RspIFwd.  This is returned when a remote cachi=
ng agent forwards data and the requesting agent is able to acquire the data=
 in E or M states.  This is commonly returned with RFO transactions.  It ca=
n be either a HitM or a HitFE.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; RspS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for snoop responses of RspS.  RspS is returned when a remote cache ha=
s data but is not forwarding it.  It is a way to let the requesting socket =
know that it cannot allocate the data in E state.  No data is sent with S R=
spS.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; RspSFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for a snoop response of RspSFwd.  This is returned when a remote cach=
ing agent forwards data but holds on to its currentl copy.  This is common =
for data and code reads that hit in a remote socket in E or F state.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; Rsp*Fwd*WB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for a snoop response of Rsp*Fwd*WB.  This snoop response is only used=
 in 4s systems.  It is used when a snoop HITM's in a remote caching agent a=
nd it directly forwards data to a requestor, and simultaneously returns dat=
a to the home to be written back to memory.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received; Rsp*WB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_H_SNOOP_RESP.RSP_WB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of RspI snoop respon=
ses received.  Whenever a snoops are issued, one or more snoop responses wi=
ll be returned depending on the topology of the system.   In systems larger=
 than 2s, when multiple snoops are returned this will count all the snoops =
that are received.  For example, if 3 snoops were issued and returned RspI,=
 RspS, and RspSFwd; then each of these sub-events would increment by 1.; Fi=
lters for a snoop response of RspIWB or RspSWB.  This is returned when a no=
n-RFO request hits in M state.  Data and Code Reads can return either RspIW=
B or RspSWB depending on how the system has been configured.  InvItoE trans=
actions will also return RspIWB because they must acquire ownership.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; Other",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.OTHER",
+        "PerPkg": "1",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for all other snoop responses.",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspCnflct",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPCNFLCT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for snoops responses of RspConflict.  This is returned=
 when a snoop finds an existing outstanding transaction in a remote caching=
 agent when it CAMs that caching agent.  This triggers conflict resolution =
hardware.  This covers both RspCnflct and RspCnflctWbI.",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPI",
+        "PerPkg": "1",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for snoops responses of RspI.  RspI is returned when t=
he remote cache does not have the data, or when the remote cache silently e=
victs data (such as when an RFO hits non-modified data).",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspIFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPIFWD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for snoop responses of RspIFwd.  This is returned when=
 a remote caching agent forwards data and the requesting agent is able to a=
cquire the data in E or M states.  This is commonly returned with RFO trans=
actions.  It can be either a HitM or a HitFE.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for snoop responses of RspS.  RspS is returned when a =
remote cache has data but is not forwarding it.  It is a way to let the req=
uesting socket know that it cannot allocate the data in E state.  No data i=
s sent with S RspS.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; RspSFwd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPSFWD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for a snoop response of RspSFwd.  This is returned whe=
n a remote caching agent forwards data but holds on to its currentl copy.  =
This is common for data and code reads that hit in a remote socket in E or =
F state.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; Rsp*FWD*WB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPxFWDxWB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for a snoop response of Rsp*Fwd*WB.  This snoop respon=
se is only used in 4s systems.  It is used when a snoop HITM's in a remote =
caching agent and it directly forwards data to a requestor, and simultaneou=
sly returns data to the home to be written back to memory.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Snoop Responses Received Local; Rsp*WB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x60",
+        "EventName": "UNC_H_SNP_RESP_RECV_LOCAL.RSPxWB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of snoop responses received for a Loc=
al  request; Filters for a snoop response of RspIWB or RspSWB.  This is ret=
urned when a non-RFO request hits in M state.  Data and Code Reads can retu=
rn either RspIWB or RspSWB depending on how the system has been configured.=
  InvItoE transactions will also return RspIWB because they must acquire ow=
nership.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for Monroe s=
ystems that use the TAD to enable individual channels to enter self-refresh=
 to save power.; Filters request made to TAD Region 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for Monroe s=
ystems that use the TAD to enable individual channels to enter self-refresh=
 to save power.; Filters request made to TAD Region 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for Monroe s=
ystems that use the TAD to enable individual channels to enter self-refresh=
 to save power.; Filters request made to TAD Region 2",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for Monroe s=
ystems that use the TAD to enable individual channels to enter self-refresh=
 to save power.; Filters request made to TAD Region 3",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION4",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for Monroe s=
ystems that use the TAD to enable individual channels to enter self-refresh=
 to save power.; Filters request made to TAD Region 4",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION5",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for Monroe s=
ystems that use the TAD to enable individual channels to enter self-refresh=
 to save power.; Filters request made to TAD Region 5",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION6",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for Monroe s=
ystems that use the TAD to enable individual channels to enter self-refresh=
 to save power.; Filters request made to TAD Region 6",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_H_TAD_REQUESTS_G0.REGION7",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 0 to 7.  This event is usef=
ul for understanding how applications are using the memory that is spread a=
cross the different memory regions.  It is particularly useful for Monroe s=
ystems that use the TAD to enable individual channels to enter self-refresh=
 to save power.; Filters request made to TAD Region 7",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION10",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 8 to 10.  This event is use=
ful for understanding how applications are using the memory that is spread =
across the different memory regions.  It is particularly useful for Monroe =
systems that use the TAD to enable individual channels to enter self-refres=
h to save power.; Filters request made to TAD Region 10",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION11",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 8 to 10.  This event is use=
ful for understanding how applications are using the memory that is spread =
across the different memory regions.  It is particularly useful for Monroe =
systems that use the TAD to enable individual channels to enter self-refres=
h to save power.; Filters request made to TAD Region 11",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION8",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 8 to 10.  This event is use=
ful for understanding how applications are using the memory that is spread =
across the different memory regions.  It is particularly useful for Monroe =
systems that use the TAD to enable individual channels to enter self-refres=
h to save power.; Filters request made to TAD Region 8",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 1; TAD Re=
gion 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_H_TAD_REQUESTS_G1.REGION9",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of HA requests to a given =
TAD region.  There are up to 11 TAD (target address decode) regions in each=
 home agent.  All requests destined for the memory controller must first be=
 decoded to determine which TAD region they are in.  This event is filtered=
 based on the TAD region ID, and covers regions 8 to 10.  This event is use=
ful for understanding how applications are using the memory that is spread =
across the different memory regions.  It is particularly useful for Monroe =
systems that use the TAD to enable individual channels to enter self-refres=
h to save power.; Filters request made to TAD Region 9",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_H_TRACKER_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occpancy.  HA tra=
ckers are allocated as soon as a request enters the HA if an HT (Home Track=
er) entry is available and is released after the snoop response and data re=
turn (or post in the case of a write) and the response is returned on the r=
ing.",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound NDR Ring Transactions; Non-data Resp=
onses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF",
+        "EventName": "UNC_H_TxR_AD.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of outbound transactions o=
n the AD ring.  This can be filtered by the NDR and SNP message classes.  S=
ee the filter descriptions for more details.; Filter for outbound NDR trans=
actions sent on the AD ring.  NDR stands for non-data response and is gener=
ally used for completions that do not include data.  AD NDR is used for tra=
nsactions to remote sockets.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2a",
+        "EventName": "UNC_H_TxR_AD_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Full; Cycles full from both schedu=
lers",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Full; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2a",
+        "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Full; Filter for cycles full  from=
 scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Full; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2a",
+        "EventName": "UNC_H_TxR_AD_CYCLES_FULL.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Full; Filter for cycles full  from=
 scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_TxR_AD_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Not Empty; Cycles full from both s=
chedulers",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Not Empty; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Not Empty; Filter for cycles not e=
mpty  from scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Not Empty; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_H_TxR_AD_CYCLES_NE.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Not Empty; Filter for cycles not e=
mpty from scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_TxR_AD_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Allocations; Allocations from both=
 schedulers",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Allocations; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_TxR_AD_INSERTS.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Allocations; Filter for allocation=
s from scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Allocations; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_H_TxR_AD_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Allocations; Filter for allocation=
s from scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Occupancy; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_H_TxR_AD_OCCUPANCY.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Occupancy; Filter for occupancy fr=
om scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AD Egress Occupancy; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_H_TxR_AD_OCCUPANCY.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AD Egress Occupancy; Filter for occupancy fr=
om scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound Ring Transactions on AK: CRD Transac=
tions to Cbo",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xe",
+        "EventName": "UNC_H_TxR_AK.CRD_CBO",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_H_TxR_AK_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Full; Cycles full from both schedu=
lers",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Full; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Full; Filter for cycles full  from=
 scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Full; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_H_TxR_AK_CYCLES_FULL.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Full; Filter for cycles full  from=
 scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_H_TxR_AK_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Not Empty; Cycles full from both s=
chedulers",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Not Empty; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Not Empty; Filter for cycles not e=
mpty  from scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Not Empty; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_H_TxR_AK_CYCLES_NE.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Not Empty; Filter for cycles not e=
mpty from scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2f",
+        "EventName": "UNC_H_TxR_AK_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Allocations; Allocations from both=
 schedulers",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2f",
+        "EventName": "UNC_H_TxR_AK_INSERTS.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Allocations; Filter for allocation=
s from scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Allocations; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2f",
+        "EventName": "UNC_H_TxR_AK_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Allocations; Filter for allocation=
s from scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Occupancy; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_H_TxR_AK_OCCUPANCY.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Occupancy; Filter for occupancy fr=
om scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "AK Egress Occupancy; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_H_TxR_AK_OCCUPANCY.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Occupancy; Filter for occupancy fr=
om scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_H_TxR_BL.DRS_CACHE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS messages sent out o=
n the BL ring.   This can be filtered by the destination.; Filter for data =
being sent to the cache.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to Core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_H_TxR_BL.DRS_CORE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS messages sent out o=
n the BL ring.   This can be filtered by the destination.; Filter for data =
being sent directly to the requesting core.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Outbound DRS Ring Transactions to Cache; Data=
 to QPI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_H_TxR_BL.DRS_QPI",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS messages sent out o=
n the BL ring.   This can be filtered by the destination.; Filter for data =
being sent to a remote socket over QPI.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Full; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TxR_BL_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Full; Cycles full from both schedu=
lers",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Full; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Full; Filter for cycles full  from=
 scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Full; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TxR_BL_CYCLES_FULL.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Full; Filter for cycles full  from=
 scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Not Empty; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TxR_BL_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Not Empty; Cycles full from both s=
chedulers",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Not Empty; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Not Empty; Filter for cycles not e=
mpty  from scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Not Empty; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TxR_BL_CYCLES_NE.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Not Empty; Filter for cycles not e=
mpty from scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Allocations; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_TxR_BL_INSERTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Allocations; Allocations from both=
 schedulers",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Allocations; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_TxR_BL_INSERTS.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Allocations; Filter for allocation=
s from scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Allocations; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_TxR_BL_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Allocations; Filter for allocation=
s from scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Occupancy: All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_TxR_BL_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Occupancy",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Occupancy; Scheduler 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_TxR_BL_OCCUPANCY.SCHED0",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Occupancy; Filter for occupancy fr=
om scheduler bank 0",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "BL Egress Occupancy; Scheduler 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_H_TxR_BL_OCCUPANCY.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "BL Egress Occupancy; Filter for occupancy fr=
om scheduler bank 1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 0 only.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 1 only.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 2 only.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Regular; Chan=
nel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 3 only.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o special credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the special credits.  =
This statistic is generally not interesting for general IA workloads, but m=
ay be of interest for understanding the characteristics of systems using IS=
OCH.  One can filter based on the memory controller channel.  One or more c=
hannels can be tracked at a given time.; Filter for memory controller chann=
el 0 only.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o special credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the special credits.  =
This statistic is generally not interesting for general IA workloads, but m=
ay be of interest for understanding the characteristics of systems using IS=
OCH.  One can filter based on the memory controller channel.  One or more c=
hannels can be tracked at a given time.; Filter for memory controller chann=
el 1 only.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are n=
o special credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the special credits.  =
This statistic is generally not interesting for general IA workloads, but m=
ay be of interest for understanding the characteristics of systems using IS=
OCH.  One can filter based on the memory controller channel.  One or more c=
hannels can be tracked at a given time.; Filter for memory controller chann=
el 2 only.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA iMC CHN0 WPQ Credits Empty - Special; Chan=
nel 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_WPQ_CYCLES_NO_SPEC_CREDITS.CHN3",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts the number of cycles when there are n=
o special credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the special credits.  =
This statistic is generally not interesting for general IA workloads, but m=
ay be of interest for understanding the characteristics of systems using IS=
OCH.  One can filter based on the memory controller channel.  One or more c=
hannels can be tracked at a given time.; Filter for memory controller chann=
el 3 only.",
         "UMask": "0x8",
         "Unit": "HA"
     }
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
index b798a860bc81..b50685fbde12 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
@@ -1,48 +1,1768 @@
 [
     {
-        "BriefDescription": "QPI clock ticks. Use to get percentages for Q=
PI cycles events",
+        "BriefDescription": "Number of qfclks",
         "Counter": "0,1,2,3",
         "EventCode": "0x14",
         "EventName": "UNC_Q_CLOCKTICKS",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of clocks in the QPI LL.  =
This clock runs at 1/8th the GT/s speed of the QPI link.  For example, a 8G=
T/s link will have qfclk or 1GHz.  JKT does not support dynamic link speeds=
, so this frequency is fixed.",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Cycles where receiving QPI link is in half-wi=
dth mode",
+        "BriefDescription": "Count of CTO Events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_Q_CTO_COUNT",
+        "ExtSel": "1",
+        "Filter": "QPIMask0[17:0],QPIMatch0[17:0],QPIMask1[19:16],QPIMatch=
1[19:16]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of CTO (cluster trigger ou=
ts) events that were asserted across the two slots.  If both slots trigger =
in a given cycle, the event will increment by 2.  You can use edge detect t=
o count the number of cases when both events triggered.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because there were not enough Egress =
credits.  Had there been enough credits, the spawn would have worked as the=
 RBT bit was set and the RBT tag matched.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match and=
 there weren't enough Egress credits.   The valid bit was set.",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because there were not enough Egress =
credits AND the RBT bit was not set, but the RBT tag matched.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s and RBT Miss, Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_CREDITS_RBT_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match, th=
e valid bit was not set and there weren't enough Egress credits.",
+        "UMask": "0x80",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match alt=
hough the valid bit was set and there were enough Egress credits.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT I=
nvalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the route-back table (RBT) sp=
ecified that the transaction should not trigger a direct2core tranaction.  =
This is common for IO transactions.  There were enough Egress credits and t=
he RBT tag matched but the valid bit was not set.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - RBT M=
iss and Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.FAILURE_RBT_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn failed because the RBT tag did not match and=
 the valid bit was not set although there were enough Egress credits.",
+        "UMask": "0x40",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Direct 2 Core Spawning; Spawn Success",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_DIRECT2CORE.SUCCESS_RBT_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRS packets that we att=
empted to do direct2core on.  There are 4 mutually exlusive filters.  Filte=
r [0] can be used to get successful spawns, while [1:3] provide the differe=
nt failure cases.  Note that this does not count packets that are not candi=
dates for Direct2Core.  The only candidates for Direct2Core are DRS packets=
 destined for Cbos.; The spawn was successful.  There were sufficient credi=
ts, the RBT valid bit was set and there was an RBT tag match.  The message =
was marked to spawn direct2core.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_L1_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L1 power=
 mode.  L1 is a mode that totally shuts down a QPI link.  Use edge detect t=
o count the number of instances when the QPI link entered L1.  Link power s=
tates are per link and per direction, so for example the Tx direction could=
 be in one state while Rx was in another. Because L1 totally shuts down the=
 link, it takes a good amount of time to exit this mode.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0p",
         "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_Q_RxL0P_POWER_CYCLES",
-        "MetricExpr": "(UNC_Q_RxL0P_POWER_CYCLES / UNC_Q_CLOCKTICKS) * 100=
.",
-        "MetricName": "rxl0p_power_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Cycles where transmitting QPI link is in half=
-width mode",
+        "BriefDescription": "Cycles in L0",
         "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
-        "MetricExpr": "(UNC_Q_TxL0P_POWER_CYCLES / UNC_Q_CLOCKTICKS) * 100=
.",
-        "MetricName": "txl0p_power_cycles %",
+        "EventCode": "0xf",
+        "EventName": "UNC_Q_RxL0_POWER_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Number of data flits transmitted ",
+        "BriefDescription": "Rx Flit Buffer Bypassed",
         "Counter": "0,1,2,3",
-        "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_BYPASSED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the flit buffer and pass directly across the BGF an=
d into the Egress.  This is a latency optimization, and should generally be=
 the common case.  If this value is less than the number of flits transfere=
d, it implies that there was queueing getting onto the ring, and thus the t=
ransactions saw higher latency.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "CRC Errors Detected; LinkInit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_CRC_ERRORS.LINK_INIT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
; CRC errors detected during link initialization.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "CRC Errors Detected; Normal Operations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_CRC_ERRORS.NORMAL_OP",
         "PerPkg": "1",
-        "ScaleUnit": "8Bytes",
+        "PublicDescription": "Number of CRC errors detected in the QPI Age=
nt.  Each QPI flit incorporates 8 bits of CRC for error detection.  This co=
unts the number of flits where the CRC was able to detect an error.  After =
an error has been detected, the QPI agent will send a request to the transm=
itting socket to resend the flit (as well as any flits that came after it).=
; CRC errors detected during normal operation.",
         "UMask": "0x2",
         "Unit": "QPI LL"
     },
     {
-        "BriefDescription": "Number of non data (control) flits transmitte=
d ",
+        "BriefDescription": "VN0 Credit Consumed; DRS",
         "Counter": "0,1,2,3",
-        "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the DRS message class.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the HOM message class.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NCB message class.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NCS message class.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the NDR message class.",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN0 Credit Consumed; SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN0.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN0 c=
redit was consumed (i.e. message uses a VN0 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN0 credit for the SNP message class.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; DRS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the DRS message class.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the HOM message class.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCB message class.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NCS message class.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the NDR message class.",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VN1 Credit Consumed; SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VN1.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VN1 c=
redit was consumed (i.e. message uses a VN1 credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
; VN1 credit for the SNP message class.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credit Consumed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_Q_RxL_CREDITS_CONSUMED_VNA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an RxQ VNA c=
redit was consumed (i.e. message uses a VNA credit for the Rx Buffer).  Thi=
s includes packets that went through the RxQ and those that were bypasssed.=
",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa",
+        "EventName": "UNC_Q_RxL_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - DRS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xF",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_DRS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors DRS flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - HOM; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_HOM.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors HOM flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCB; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCB.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCB flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NCS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NCS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NCS flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - NDR; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_NDR.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors NDR flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Cycles Not Empty - SNP; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_Q_RxL_CYCLES_NE_SNP.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the QPI RxQ=
 was not empty.  Generally, when data is transmitted across QPI, it will by=
pass the RxQ and pass directly to the ring interface.  If things back up ge=
tting transmitted onto the ring, however, it may need to allocate into this=
 buffer, thus increasing the latency.  This event can be used in conjunctio=
n with the Flit Buffer Occupancy Accumulator event to calculate the average=
 occupancy.  This monitors SNP flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 0; Data Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_RxL_FLITS_G0.DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transfering a 64B cach=
eline across QPI, we will break it into 9 flits -- 1 with header informatio=
n and 8 with 64 bits of actual data and an additional 16 bits of other info=
rmation.  To calculate data bandwidth, one should therefore do: data flits =
* 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flitsrece=
ived over QPI.  Each flit contains 64b of data.  This includes both DRS and=
 NCB data flits (coherent and non-coherent).  This can be used to calculate=
 the data bandwidth of the QPI link.  One can get a good picture of the QPI=
-link characteristics by evaluating the protocol flits, data flits, and idl=
e/null flits.  This does not include the header flits that go in data packe=
ts.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 0; Idle and Null Flits=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_RxL_FLITS_G0.IDLE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transfering a 64B cach=
eline across QPI, we will break it into 9 flits -- 1 with header informatio=
n and 8 with 64 bits of actual data and an additional 16 bits of other info=
rmation.  To calculate data bandwidth, one should therefore do: data flits =
* 8B / time (for L0) or 4B instead of 8B for L0p.; Number of flits received=
 over QPI that do not hold protocol payload.  When QPI is not in a power sa=
ving state, it continuously transmits flits across the link.  When there ar=
e no protocol flits to send, it will send IDLE and NULL flits  across.  The=
se flits sometimes do carry a payload, such as credit returns, but are gene=
rall not considered part of the QPI bandwidth.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 0; Non-Data protocol T=
x Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_RxL_FLITS_G0.NON_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  It includes filters for Idle, protocol, and Data Flits.  Each f=
lit is made up of 80 bits of information (in addition to some ECC data).  I=
n full-width (L0) mode, flits are made up of four fits, each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI speed (for example, 8.0=
 GT/s), the transfers here refer to fits.  Therefore, in L0, the system wil=
l transfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate th=
e bandwidth of the link by taking: flits*80b/time.  Note that this is not t=
he same as data bandwidth.  For example, when we are transfering a 64B cach=
eline across QPI, we will break it into 9 flits -- 1 with header informatio=
n and 8 with 64 bits of actual data and an additional 16 bits of other info=
rmation.  To calculate data bandwidth, one should therefore do: data flits =
* 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL non-d=
ata flits received across QPI.  This basically tracks the protocol overhead=
 on the QPI link.  One can get a good picture of the QPI-link characteristi=
cs by evaluating the protocol flits, data flits, and idle/null flits.  This=
 includes the header flits for data packets.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Flits (both Hea=
der and Data)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over QPI on the DRS (Data Respon=
se) channel.  DRS flits are used to transmit data with coherency.  This doe=
s not count data flits received over the NCB channel which transmits non-co=
herent data.",
+        "UMask": "0x18",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Data Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of data flits received over QPI on the DRS (Data R=
esponse) channel.  DRS flits are used to transmit data with coherency.  Thi=
s does not count data flits received over the NCB channel which transmits n=
on-coherent data.  This includes only the data flits (not the header).",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; DRS Header Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.DRS_NONDATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of protocol flits received over QPI on the DRS (Da=
ta Response) channel.  DRS flits are used to transmit data with coherency. =
 This does not count data flits received over the NCB channel which transmi=
ts non-coherent data.  This includes only the header flits (not the data). =
 This includes extended headers.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of flits received over QPI on the home channel.",
+        "UMask": "0x6",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Non-Request Fli=
ts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM_NONREQ",
+        "ExtSel": "1",
         "PerPkg": "1",
-        "ScaleUnit": "8Bytes",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of non-request flits received over QPI on the home chann=
el.  These are most commonly snoop responses, and this event can be used as=
 a proxy for that.",
         "UMask": "0x4",
         "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; HOM Request Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.HOM_REQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of data request received over QPI on the home channel.  =
This basically counts the number of remote memory requests received over QP=
I.  In conjunction with the local read count in the Home Agent, one can cal=
culate the number of LLC Misses.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 1; SNP Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_RxL_FLITS_G1.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for SNP, HOM, and DRS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the number of snoop request flits received over QPI.  These request=
s are contained in the snoop channel.  This does not include snoop response=
s, which are received on the home channel.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent Rx Fli=
ts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass flits.  These packets are generally used to =
transmit non-coherent data across QPI.",
+        "UMask": "0xC",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent data R=
x Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCB_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass data flits.  These flits are generally used =
to transmit non-coherent data across QPI.  This does not include a count of=
 the DRS (coherent) data flits.  This only counts the data flits, not the N=
CB headers.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent non-da=
ta Rx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCB_NONDATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of Non-Coherent Bypass non-data flits.  These packets are generally=
 used to transmit non-coherent data across QPI, and the flits counted here =
are for headers and other non-data flits.  This includes extended headers."=
,
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Coherent standa=
rd Rx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Number of NCS (non-coherent standard) flits received over QPI.    This inc=
ludes extended headers.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AD",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over the NDR (Non-Data Response)=
 channel.  This channel is used to send a variety of protocol flits includi=
ng grants and completions.  This is only for NDR packets to the local socke=
t which use the AK ring.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Received - Group 2; Non-Data Response R=
x Flits - AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_Q_RxL_FLITS_G2.NDR_AK",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits received from the=
 QPI Link.  This is one of three groups that allow us to track flits.  It i=
ncludes filters for NDR, NCB, and NCS message classes.  Each flit is made u=
p of 80 bits of information (in addition to some ECC data).  In full-width =
(L0) mode, flits are made up of four fits, each of which contains 20 bits o=
f data (along with some additional ECC data).   In half-width (L0p) mode, t=
he fits are only 10 bits, and therefore it takes twice as many fits to tran=
smit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), the t=
ransfers here refer to fits.  Therefore, in L0, the system will transfer 1 =
flit at the rate of 1/4th the QPI speed.  One can calculate the bandwidth o=
f the link by taking: flits*80b/time.  Note that this is not the same as da=
ta bandwidth.  For example, when we are transfering a 64B cacheline across =
QPI, we will break it into 9 flits -- 1 with header information and 8 with =
64 bits of actual data and an additional 16 bits of other information.  To =
calculate data bandwidth, one should therefore do: data flits * 8B / time.;=
 Counts the total number of flits received over the NDR (Non-Data Response)=
 channel.  This channel is used to send a variety of protocol flits includi=
ng grants and completions.  This is only for NDR packets destined for Route=
-thru to a remote socket.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_Q_RxL_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - DRS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_INSERTS_DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_INSERTS_DRS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - DRS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_Q_RxL_INSERTS_DRS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only DRS flits.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_Q_RxL_INSERTS_HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
+        "EventName": "UNC_Q_RxL_INSERTS_HOM.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - HOM; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
+        "EventName": "UNC_Q_RxL_INSERTS_HOM.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only HOM flits.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa",
+        "EventName": "UNC_Q_RxL_INSERTS_NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_Q_RxL_INSERTS_NCB.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCB; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_Q_RxL_INSERTS_NCB.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCB flits.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_Q_RxL_INSERTS_NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "UNC_Q_RxL_INSERTS_NCS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NCS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB",
+        "EventName": "UNC_Q_RxL_INSERTS_NCS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NCS flits.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xe",
+        "EventName": "UNC_Q_RxL_INSERTS_NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE",
+        "EventName": "UNC_Q_RxL_INSERTS_NDR.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - NDR; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE",
+        "EventName": "UNC_Q_RxL_INSERTS_NDR.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only NDR flits.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_Q_RxL_INSERTS_SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_Q_RxL_INSERTS_SNP.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Rx Flit Buffer Allocations - SNP; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
+        "EventName": "UNC_Q_RxL_INSERTS_SNP.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Rx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
RxQ and pass directly to the ring interface.  If things back up getting tra=
nsmitted onto the ring, however, it may need to allocate into this buffer, =
thus increasing the latency.  This event can be used in conjunction with th=
e Flit Buffer Occupancy event in order to calculate the average flit buffer=
 lifetime.  This monitors only SNP flits.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_Q_RxL_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - DRS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - DRS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - DRS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x15",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_DRS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors DRS flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - HOM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - HOM; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - HOM; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_HOM.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors HOM flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCB; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCB; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCB.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCB flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCS; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NCS; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NCS.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NCS flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NDR; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - NDR; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_NDR.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors NDR flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - SNP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - SNP; for VN0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - SNP; for VN1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_Q_RxL_OCCUPANCY_SNP.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of elements in the QP=
I RxQ in each cycle.  Generally, when data is transmitted across QPI, it wi=
ll bypass the RxQ and pass directly to the ring interface.  If things back =
up getting transmitted onto the ring, however, it may need to allocate into=
 this buffer, thus increasing the latency.  This event can be used in conju=
nction with the Flit Buffer Not Empty event to calculate average occupancy,=
 or with the Flit Buffer Allocations event to track average lifetime.  This=
 monitors SNP flits only.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - H=
OM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the HOM message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - D=
RS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the DRS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - S=
NP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the SNP message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
DR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NDR message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCS message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; BGF Stall - N=
CB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.BGF_SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet from the NCB message class because ther=
e were not enough BGF credits.  In bypass mode, we will stall on the packet=
 boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; Egress Credit=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.EGRESS_CREDITS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled a packet because there were insufficient BGF cre=
dits.  For details on a message class granularity, use the Egress Credit Oc=
cupancy events.",
+        "UMask": "0x40",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN0; GV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_Q_RxL_STALLS_VN0.GV",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 0; Stalled because a GV transition (frequency transition) w=
as taking place.",
+        "UMask": "0x80",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - H=
OM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3a",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the HOM message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - D=
RS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3a",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the DRS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - S=
NP",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3a",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the SNP message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
DR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3a",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NDR message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3a",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_NDR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCS message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x20",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Stalls Sending to R3QPI on VN1; BGF Stall - N=
CB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3a",
+        "EventName": "UNC_Q_RxL_STALLS_VN1.BGF_SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of stalls trying to send to R3QPI on =
Virtual Network 1.; Stalled a packet from the NCB message class because the=
re were not enough BGF credits.  In bypass mode, we will stall on the packe=
t boundary, while in RxQ mode we will stall on the flit boundary.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0p",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_Q_TxL0P_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0p powe=
r mode.  L0p is a mode where we disable 1/2 of the QPI lanes, decreasing ou=
r bandwidth in order to save power.  It increases snoop and data transfer l=
atencies and decreases overall bandwidth.  This mode can be very useful in =
NUMA optimized workloads that largely only utilize QPI for snoops and their=
 responses.  Use edge detect to count the number of instances when the QPI =
link entered L0p.  Link power states are per link and per direction, so for=
 example the Tx direction could be in one state while Rx was in another.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles in L0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_Q_TxL0_POWER_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI qfclk cycles spent in L0 power=
 mode in the Link Layer.  L0 is the default mode which provides the highest=
 performance with the most power.  Use edge detect to count the number of i=
nstances that the link entered L0.  Link power states are per link and per =
direction, so for example the Tx direction could be in one state while Rx w=
as in another.  The phy layer  sometimes leaves L0 for training, which will=
 not be captured by this event.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Bypassed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_Q_TxL_BYPASSED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that an incoming =
flit was able to bypass the Tx flit buffer and pass directly out the QPI Li=
nk. Generally, when data is transmitted across QPI, it will bypass the TxQ =
and pass directly to the link.  However, the TxQ will be used with L0p and =
when LLR occurs, increasing latency to transfer out to the link.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is al=
most full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.ALMOST_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.; When LLR is almost ful=
l, we block some but not all packets.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Cycles Stalled with no LLR Credits; LLR is fu=
ll",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_Q_TxL_CRC_NO_CREDITS.FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles when the Tx side ran out of=
 Link Layer Retry credits, causing the Tx to stall.; When LLR is totally fu=
ll, we are not allowed to send any packets.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Cycles not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_Q_TxL_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the TxQ is =
not empty. Generally, when data is transmitted across QPI, it will bypass t=
he TxQ and pass directly to the link.  However, the TxQ will be used with L=
0p and when LLR occurs, increasing latency to transfer out to the link.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data flit=
s transmitted over QPI.  Each flit contains 64b of data.  This includes bot=
h DRS and NCB data flits (coherent and non-coherent).  This can be used to =
calculate the data bandwidth of the QPI link.  One can get a good picture o=
f the QPI-link characteristics by evaluating the protocol flits, data flits=
, and idle/null flits.  This does not include the header flits that go in d=
ata packets.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 0; Non-Data protoco=
l Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transfering a 64B=
 cacheline across QPI, we will break it into 9 flits -- 1 with header infor=
mation and 8 with 64 bits of actual data and an additional 16 bits of other=
 information.  To calculate data bandwidth, one should therefore do: data f=
lits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL =
non-data flits transmitted across QPI.  This basically tracks the protocol =
overhead on the QPI link.  One can get a good picture of the QPI-link chara=
cteristics by evaluating the protocol flits, data flits, and idle/null flit=
s.  This includes the header flits for data packets.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Flits (both =
Header and Data)",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over QPI on the DRS (Data=
 Response) channel.  DRS flits are used to transmit data with coherency.",
+        "UMask": "0x18",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of data flits transmitted over QPI on the DRS =
(Data Response) channel.  DRS flits are used to transmit data with coherenc=
y.  This does not count data flits transmitted over the NCB channel which t=
ransmits non-coherent data.  This includes only the data flits (not the hea=
der).",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; DRS Header Flits=
",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of protocol flits transmitted over QPI on the =
DRS (Data Response) channel.  DRS flits are used to transmit data with cohe=
rency.  This does not count data flits transmitted over the NCB channel whi=
ch transmits non-coherent data.  This includes only the header flits (not t=
he data).  This includes extended headers.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of flits transmitted over QPI on the home channel.",
+        "UMask": "0x6",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Non-Request =
Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of non-request flits transmitted over QPI on the hom=
e channel.  These are most commonly snoop responses, and this event can be =
used as a proxy for that.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; HOM Request Flit=
s",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of data request transmitted over QPI on the home cha=
nnel.  This basically counts the number of remote memory requests transmitt=
ed over QPI.  In conjunction with the local read count in the Home Agent, o=
ne can calculate the number of LLC Misses.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for SNP, HOM, and DRS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the number of snoop request flits transmitted over QPI.  These =
requests are contained in the snoop channel.  This does not include snoop r=
esponses, which are transmitted on the home channel.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent Byp=
ass Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCB",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass flits.  These packets are generally used=
 to transmit non-coherent data across QPI.",
+        "UMask": "0xC",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent dat=
a Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCB_DATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass data flits.  These flits are generally u=
sed to transmit non-coherent data across QPI.  This does not include a coun=
t of the DRS (coherent) data flits.  This only counts the data flits, not t=
e NCB headers.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent non=
-data Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCB_NONDATA",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of Non-Coherent Bypass non-data flits.  These packets are gener=
ally used to transmit non-coherent data across QPI, and the flits counted h=
ere are for headers and other non-data flits.  This includes extended heade=
rs.",
+        "UMask": "0x8",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Coherent sta=
ndard Tx Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NCS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Number of NCS (non-coherent standard) flits transmitted over QPI.    T=
his includes extended headers.",
+        "UMask": "0x10",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AD",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over the NDR (Non-Data Re=
sponse) channel.  This channel is used to send a variety of protocol flits =
including grants and completions.  This is only for NDR packets to the loca=
l socket which use the AK ring.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Flits Transferred - Group 2; Non-Data Respons=
e Tx Flits - AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_Q_TxL_FLITS_G2.NDR_AK",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of flits trasmitted across=
 the QPI Link.  This is one of three groups that allow us to track flits.  =
It includes filters for NDR, NCB, and NCS message classes.  Each flit is ma=
de up of 80 bits of information (in addition to some ECC data).  In full-wi=
dth (L0) mode, flits are made up of four fits, each of which contains 20 bi=
ts of data (along with some additional ECC data).   In half-width (L0p) mod=
e, the fits are only 10 bits, and therefore it takes twice as many fits to =
transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s), t=
he transfers here refer to fits.  Therefore, in L0, the system will transfe=
r 1 flit at the rate of 1/4th the QPI speed.  One can calculate the bandwid=
th of the link by taking: flits*80b/time.  Note that this is not the same a=
s data bandwidth.  For example, when we are transfering a 64B cacheline acr=
oss QPI, we will break it into 9 flits -- 1 with header information and 8 w=
ith 64 bits of actual data and an additional 16 bits of other information. =
 To calculate data bandwidth, one should therefore do: data flits * 8B / ti=
me.; Counts the total number of flits transmitted over the NDR (Non-Data Re=
sponse) channel.  This channel is used to send a variety of protocol flits =
including grants and completions.  This is only for NDR packets destined fo=
r Route-thru to a remote socket.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_Q_TxL_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of allocations into the QPI Tx Flit B=
uffer.  Generally, when data is transmitted across QPI, it will bypass the =
TxQ and pass directly to the link.  However, the TxQ will be used with L0p =
and when LLR occurs, increasing latency to transfer out to the link.  This =
event can be used in conjunction with the Flit Buffer Occupancy event in or=
der to calculate the average flit buffer lifetime.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "Tx Flit Buffer Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_Q_TxL_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of flits in the TxQ. =
 Generally, when data is transmitted across QPI, it will bypass the TxQ and=
 pass directly to the link.  However, the TxQ will be used with L0p and whe=
n LLR occurs, increasing latency to transfer out to the link. This can be u=
sed with the cycles not empty event to track average occupancy, or the allo=
cations event to track average lifetime in the TxQ.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - HOM; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle. Flow Control FIFO for H=
ome messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD HOM; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_Q_TxR_AD_HOM_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO for HOM messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
NDR messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD NDR; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_Q_TxR_AD_NDR_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle. Flow Control FIFO  for NDR messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - SNP; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of link layer credits into the R3 (fo=
r transactions across the BGF) acquired each cycle.  Flow Control FIFO for =
Snoop messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO fro Snoop messages on AD.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AD SNP; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_Q_TxR_AD_SNP_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of li=
nk layer credits into the R3 (for transactions across the BGF) available in=
 each cycle.  Flow Control FIFO fro Snoop messages on AD.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. Local NDR message class to AK Egre=
ss.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - AK NDR: for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_Q_TxR_AK_NDR_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  Local NDR message class to AK Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2a",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2a",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - DRS; for Shar=
ed VN",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2a",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_ACQUIRED.VN_SHR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. DRS message class to BL Egress.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1f",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1f",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL DRS; for S=
hared VN",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1f",
+        "EventName": "UNC_Q_TxR_BL_DRS_CREDIT_OCCUPANCY.VN_SHR",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  DRS message class to BL Egress.",
+        "UMask": "0x4",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2b",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCB; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2b",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCB message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCB; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_Q_TxR_BL_NCB_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCB message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN0"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2c",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - NCS; for VN1"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2c",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_ACQUIRED.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of credits into the R3 (for transacti=
ons across the BGF) acquired each cycle. NCS message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
+        "UMask": "0x1",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "R3QPI Egress Credit Occupancy - BL NCS; for V=
N1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_Q_TxR_BL_NCS_CREDIT_OCCUPANCY.VN1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Occupancy event that tracks the number of cr=
edits into the R3 (for transactions across the BGF) available in each cycle=
.  NCS message class to BL Egress.",
+        "UMask": "0x2",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credits Returned",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_Q_VNA_CREDIT_RETURNS",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of VNA credits returned.",
+        "Unit": "QPI LL"
+    },
+    {
+        "BriefDescription": "VNA Credits Pending Return - Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_Q_VNA_CREDIT_RETURN_OCCUPANCY",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of VNA credits in the Rx side that ar=
e waitng to be returned back across the link.",
+        "Unit": "QPI LL"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json b/to=
ols/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
index e8917cb59566..63b49b712c62 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
@@ -1,77 +1,1812 @@
 [
     {
-        "BriefDescription": "Memory page activates for reads and writes",
+        "BriefDescription": "DRAM Activate Count; Activate due to Write",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M_ACT_COUNT.BYP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Activate commands =
sent on this channel.  Activate commands are issued to open up a page on th=
e DRAM devices so that it can be read or written to with a CAS.  One can ca=
lculate the number of Page Misses by subtracting the number of Page Miss pr=
echarges from the number of Activates.",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count; Activate due to Read",
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_M_ACT_COUNT.RD",
         "PerPkg": "1",
-        "UMask": "0x3",
+        "PublicDescription": "Counts the number of DRAM Activate commands =
sent on this channel.  Activate commands are issued to open up a page on th=
e DRAM devices so that it can be read or written to with a CAS.  One can ca=
lculate the number of Page Misses by subtracting the number of Page Miss pr=
echarges from the number of Activates.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count; Activate due to Write",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M_ACT_COUNT.WR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Activate commands =
sent on this channel.  Activate commands are issued to open up a page on th=
e DRAM devices so that it can be read or written to with a CAS.  One can ca=
lculate the number of Page Misses by subtracting the number of Page Miss pr=
echarges from the number of Activates.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M_BYP_CMDS.ACT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CAS command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M_BYP_CMDS.CAS",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa1",
+        "EventName": "UNC_M_BYP_CMDS.PRE",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (w/ and w/out auto-pre)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number of DRAM CAS commands issued on this channel.",
+        "UMask": "0xF",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM Re=
ads (RD_CAS + Underfills)",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "LLC_MISSES.MEM_READ",
+        "EventName": "UNC_M_CAS_COUNT.RD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number of DRAM Read CAS commands issued on this channel (including un=
derfills).",
         "UMask": "0x3",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write requests to memory controller. Derived =
from unc_m_cas_count.wr",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM RD=
_CAS (w/ and w/out auto-pre)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_REG",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number or DRAM Read CAS commands issued on this channel.  This includ=
es both regular RD CAS commands as well as those with implicit Precharge.  =
AutoPre is only used in systems that are using closed page policy.  We do n=
ot filter based on major mode, as RD_CAS is not issued during WMM (with the=
 exception of underfills).",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Read CAS is=
sued in RMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_RMM",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Underfill R=
ead Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_UNDERFILL",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
number of underfill reads that are issued by the memory controller.  This w=
ill generally be about the same as the number of partial writes, but may be=
 slightly less because of partials hitting in the WPQ.  While it is possibl=
e for underfills to be issed in both WMM and RMM, this event counts both.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; Read CAS is=
sued in WMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD_WMM",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; All DRAM WR=
_CAS (both Modes)",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
-        "EventName": "LLC_MISSES.MEM_WRITE",
+        "EventName": "UNC_M_CAS_COUNT.WR",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number of DRAM Write CAS commands issued on this channel.",
         "UMask": "0xC",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Memory controller clock ticks. Use to generat=
e percentages for memory controller CYCLES events",
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Read Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR_RMM",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number of Opportunistic DRAM Write CAS commands issued on this channe=
l while in Read-Major-Mode.",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM RD_CAS and WR_CAS Commands.; DRAM WR_CAS=
 (w/ and w/out auto-pre) in Write Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR_WMM",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM RD_CAS and WR_CAS Commands; Counts the =
total number or DRAM Write CAS commands issued on this channel while in Wri=
te-Major-Mode.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Clockticks",
+        "Counter": "0,1,2,3",
+        "EventName": "UNC_M_DCLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge All Commands",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_M_DRAM_PRE_ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that the precharg=
e all command was sent.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M_DRAM_REFRESH.HIGH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of refreshes issued.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM Refreshes Issued",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_M_DRAM_REFRESH.PANIC",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of refreshes issued.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ECC Correctable Errors",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_M_ECC_CORRECTABLE_ERRORS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of ECC errors detected and=
 corrected by the iMC on this channel.  This counter is only useful with EC=
C DRAM devices.  This count will increment one time for each correction reg=
ardless of the number of bits corrected.  The iMC can correct up to 4 bit e=
rrors in independent channel mode and 8 bit erros in lockstep mode.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Isoch Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.ISOCH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of cycles spent in a=
 major mode (selected by a filter) on the given channel.   Major modea are =
channel-wide, and not a per-rank (or dimm or bank) mode.; We group these tw=
o modes together so that we can use four counters to track each of the majo=
r modes at one time.  These major modes are used whenever there is an ISOCH=
 txn in the memory controller.  In these mode, only ISOCH transactions are =
processed.",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Partial Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.PARTIAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of cycles spent in a=
 major mode (selected by a filter) on the given channel.   Major modea are =
channel-wide, and not a per-rank (or dimm or bank) mode.; This major mode i=
s used to drain starved underfill reads.  Regular reads and writes are bloc=
ked and only underfill reads will be processed.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Read Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.READ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of cycles spent in a=
 major mode (selected by a filter) on the given channel.   Major modea are =
channel-wide, and not a per-rank (or dimm or bank) mode.; Read Major Mode i=
s the default mode for the iMC, as reads are generally more critical to for=
ward progress than writes.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Cycles in a Major Mode; Write Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_M_MAJOR_MODES.WRITE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of cycles spent in a=
 major mode (selected by a filter) on the given channel.   Major modea are =
channel-wide, and not a per-rank (or dimm or bank) mode.; This mode is trig=
gered when the WPQ hits high occupancy and causes writes to be higher prior=
ity than reads.  This can cause blips in the available read bandwidth in th=
e system and temporarily increase read latencies in order to achieve better=
 bus utilizations and higher bandwidth.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Channel DLLOFF Cycles",
         "Counter": "0,1,2,3",
-        "EventName": "UNC_M_CLOCKTICKS",
+        "EventCode": "0x84",
+        "EventName": "UNC_M_POWER_CHANNEL_DLLOFF",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles when all the ranks in the c=
hannel are in CKE Slow (DLLOFF) mode.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles where DRAM ranks are in power down (CK=
E) mode",
+        "BriefDescription": "Channel PPD Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
-        "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_CLOCKTICKS) * 100.=
",
-        "MetricName": "power_channel_ppd %",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles when all the ranks in the c=
hannel are in PPD mode.  If IBT=3Doff is enabled, then this can be used to =
count those cycles.  If it is not enabled, then this can count the number o=
f cycles when that could have been taken advantage of.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK2",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK3",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK4",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK5",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK6",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE_ON_CYCLES by Rank; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_POWER_CKE_CYCLES.RANK7",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent in CKE ON mode.  The =
filter allows you to select a rank to monitor.  If multiple ranks are in CK=
E ON mode at one time, the counter will ONLY increment by one rather than d=
oing accumulation.  Multiple counters will need to be used to track multipl=
e ranks simultaneously.  There is no distinction between the different CKE =
modes (APD, PPDS, PPDF).  This can be determined based on the system progra=
mming.  These events should commonly be used with Invert to get the number =
of cycles in power saving mode.  Edge Detect is also useful here.  Make sur=
e that you do NOT use Invert with Edge Detect (this just confuses the syste=
m and is not necessary).",
+        "UMask": "0x80",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles all ranks are in critical thermal thro=
ttle",
+        "BriefDescription": "Critical Throttle Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
-        "MetricExpr": "(UNC_M_POWER_CRITICAL_THROTTLE_CYCLES / UNC_M_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_critical_throttle_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the iMC is =
in critical thermal throttling.  When this happens, all traffic is blocked.=
  This should be rare unless something bad is going on in the platform.  Th=
ere is no filtering by rank for this event.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles Memory is in self refresh power mode",
+        "BriefDescription": "Clock-Enabled Self-Refresh",
         "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_M_POWER_SELF_REFRESH",
-        "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_CLOCKTICKS) * 100=
.",
-        "MetricName": "power_self_refresh %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the iMC is =
in self-refresh and the iMC still has a clock.  This happens in some packag=
e C-states.  For example, the PCU may ask the iMC to enter self-refresh eve=
n though some of the cores are still processing.  One use of this is for Mo=
nroe technology.  Self-refresh is required during package C3 and C6, but th=
ere is no clock in the iMC at this time, so it is not possible to count the=
se cases.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.; Thermal throttling is performed=
 per DIMM.  We support 3 DIMMs per channel.  This ID allows us to filter by=
 ID.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK4",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK5",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK6",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Throttle Cycles for Rank 0; DIMM ID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RANK7",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles while the iMC is=
 being throttled by either thermal constraints or by the PCU throttling.  I=
t is not possible to distinguish between the two.  This can be filtered by =
rank.  If multiple ranks are selected and are being throttled at the same t=
ime, the counter will only increment by 1.",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Preemption Count; Read over Read Preempt=
ion",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_RD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times a read in the iMC=
 preempts another read or write.  Generally reads to an open page are issue=
d ahead of requests to closed pages.  This improves the page hit rate of th=
e system.  However, high priority requests can cause pages of active reques=
ts to be closed in order to get them out.  This will reduce the latency of =
the high-priority request at the expense of lower bandwidth and increased o=
verall average latency.; Filter for when a read preempts another read.",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Preemption Count; Read over Write Preemp=
tion",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_M_PREEMPTION.RD_PREEMPT_WR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times a read in the iMC=
 preempts another read or write.  Generally reads to an open page are issue=
d ahead of requests to closed pages.  This improves the page hit rate of th=
e system.  However, high priority requests can cause pages of active reques=
ts to be closed in order to get them out.  This will reduce the latency of =
the high-priority request at the expense of lower bandwidth and increased o=
verall average latency.; Filter for when a read preempts a write.",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to by=
pass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.BYP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Precharge commands=
 sent on this channel.",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to ti=
mer expiration",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.PAGE_CLOSE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Precharge commands=
 sent on this channel.; Counts the number of DRAM Precharge commands sent o=
n this channel as a result of the page close counter expiring.  This does n=
ot include implicit precharge commands sent in auto-precharge mode.",
+        "UMask": "0x2",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Memory page conflicts",
+        "BriefDescription": "DRAM Precharge commands.; Precharges due to p=
age miss",
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.PAGE_MISS",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Precharge commands=
 sent on this channel.; Counts the number of DRAM Precharge commands sent o=
n this channel as a result of page misses.  This does not include explicit =
precharge commands sent with CAS commands in Auto-Precharge mode.  This doe=
s not include PRE commands sent as a result of the page close counter expir=
ation.",
         "UMask": "0x1",
         "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to re=
ad",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.RD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Precharge commands=
 sent on this channel.",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to wr=
ite",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.WR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Precharge commands=
 sent on this channel.",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with HIGH priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M_RD_CAS_PRIO.HIGH",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with LOW priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M_RD_CAS_PRIO.LOW",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with MEDIUM priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M_RD_CAS_PRIO.MED",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with PANIC NON ISOCH priority=
 (starved)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa0",
+        "EventName": "UNC_M_RD_CAS_PRIO.PANIC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 3; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB3",
+        "EventName": "UNC_M_RD_CAS_RANK3.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_M_RPQ_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the Read Pe=
nding Queue is not empty.  This can then be used to calculate the average o=
ccupancy (in conjunction with the Read Pending Queue Occupancy count).  The=
 RPQ is used to schedule reads out to the memory controller and to track th=
e requests.  Requests allocate into the RPQ soon after they enter the memor=
y controller, and need credits for an entry in this buffer before being sen=
t from the HA to the iMC.  They deallocate after the CAS command has been i=
ssued to memory.  This filter is to be used in conjunction with the occupan=
cy filter so that one can correctly track the average occupancies for sched=
ulable entries and scheduled requests.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the Re=
ad Pending Queue.  This queue is used to schedule reads out to the memory c=
ontroller and to track the requests.  Requests allocate into the RPQ soon a=
fter they enter the memory controller, and need credits for an entry in thi=
s buffer before being sent from the HA to the iMC.  They deallocate after t=
he CAS command has been issued to memory.  This includes both ISOCH and non=
-ISOCH requests.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "VMSE MXB write buffer occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x91",
+        "EventName": "UNC_M_VMSE_MXB_WR_OCCUPANCY",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "VMSE WR PUSH issued; VMSE write PUSH issued i=
n RMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M_VMSE_WR_PUSH.RMM",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "VMSE WR PUSH issued; VMSE write PUSH issued i=
n WMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x90",
+        "EventName": "UNC_M_VMSE_WR_PUSH.WMM",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold; Transition from WMM to RMM because of starve counter",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc0",
+        "EventName": "UNC_M_WMM_TO_RMM.LOW_THRESH",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc0",
+        "EventName": "UNC_M_WMM_TO_RMM.STARVE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc0",
+        "EventName": "UNC_M_WMM_TO_RMM.VMSE_RETRY",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Full Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the Write P=
ending Queue is full.  When the WPQ is full, the HA will not be able to iss=
ue any additional read requests into the iMC.  This count should be similar=
 count in the HA which tracks the number of cycles that the HA has no WPQ c=
redits, just somewhat smaller to account for the credit return overhead.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Not Empty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_WPQ_CYCLES_NE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the Write P=
ending Queue is not empty.  This can then be used to calculate the average =
queue occupancy (in conjunction with the WPQ Occupancy Accumulation count).=
  The WPQ is used to schedule write out to the memory controller and to tra=
ck the writes.  Requests allocate into the WPQ soon after they enter the me=
mory controller, and need credits for an entry in this buffer before being =
sent from the HA to the iMC.  They deallocate after being issued to DRAM.  =
Write requests themselves are able to complete (from the perspective of the=
 rest of the system) as soon they have posted to the iMC.  This is not to b=
e confused with actually performing the write to DRAM.  Therefore, the aver=
age latency for this queue is actually not useful for deconstruction interm=
ediate write latencies.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_WPQ_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the Wr=
ite Pending Queue.  This can then be used to calculate the average queuing =
latency (in conjunction with the WPQ occupancy count).  The WPQ is used to =
schedule write out to the memory controller and to track the writes.  Reque=
sts allocate into the WPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after being issued to DRAM.  Write requests themse=
lves are able to complete (from the perspective of the rest of the system) =
as soon they have posted to the iMC.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_M_WPQ_READ_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times a request hits in=
 the WPQ (write-pending queue).  The iMC allows writes and reads to pass up=
 other writes to different addresses.  Before a read or a write is issued, =
it will first CAM the WPQ to see if there is a write pending to that addres=
s.  When reads hit, they are able to directly pull their data from the WPQ =
instead of going to memory.  Writes that hit will overwrite the existing da=
ta.  Partial writes that hit will not need to do underfill reads and will s=
imply update their relevant sections.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue CAM Match",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_WPQ_WRITE_HIT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times a request hits in=
 the WPQ (write-pending queue).  The iMC allows writes and reads to pass up=
 other writes to different addresses.  Before a read or a write is issued, =
it will first CAM the WPQ to see if there is a write pending to that addres=
s.  When reads hit, they are able to directly pull their data from the WPQ =
instead of going to memory.  Writes that hit will overwrite the existing da=
ta.  Partial writes that hit will not need to do underfill reads and will s=
imply update their relevant sections.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Not getting the requested Major Mode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc1",
+        "EventName": "UNC_M_WRONG_MM",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 2; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBA",
+        "EventName": "UNC_M_WR_CAS_RANK2.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 3; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBB",
+        "EventName": "UNC_M_WR_CAS_RANK3.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-other.json
new file mode 100644
index 000000000000..aa7a5059d79f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
@@ -0,0 +1,2411 @@
+[
+    {
+        "BriefDescription": "Address Match (Conflict) Count; Conflict Merg=
es",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_ADDRESS_MATCH.MERGE_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.; When two requests to the same address =
from the same source are received back to back, it is possible to merge the=
 two of them together.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Address Match (Conflict) Count; Conflict Stal=
ls",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_ADDRESS_MATCH.STALL_COUNT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when an inbound w=
rite (from a device to memory or another device) had an address match with =
another request in the write cache.; When it is not possible to merge two c=
onflicting requests, a stall event occurs.  This is bad for performance.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Write Ack Pending Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes that have a=
cquired ownership but have not yet returned their data to the uncore.  Thes=
e writes are generally queued up in the switch trying to get to the head of=
 their queues so that they can post their data.  The queue occuapancy incre=
ments when the ACK is received, and decrements when either the data is retu=
rned OR a tickle is received and ownership is released.  Note that a single=
 tickle can result in multiple decrements.; Tracks only those requests that=
 come from the port specified in the IRP_PmonFilter.OrderingQ register.  Th=
is register allows one to select one specific queue.  It is not possible to=
 monitor multiple queues at a time.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Write Ack Pending Occupancy; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_CACHE_ACK_PENDING_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes that have a=
cquired ownership but have not yet returned their data to the uncore.  Thes=
e writes are generally queued up in the switch trying to get to the head of=
 their queues so that they can post their data.  The queue occuapancy incre=
ments when the ACK is received, and decrements when either the data is retu=
rned OR a tickle is received and ownership is released.  Note that a single=
 tickle can result in multiple decrements.; Tracks all requests from any so=
urce port.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Ownership Occupancy; Any So=
urce",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches) that are outstanding in the uncore trying to acquire ownership =
in each cycle.  This can be used with the write transaction count to calcul=
ate the average write latency in the uncore.  The occupancy increments when=
 a write request is issued, and decrements when the data is returned.; Trac=
ks all requests from any source port.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Ownership Occupancy; Select=
 Source",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_CACHE_OWN_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches) that are outstanding in the uncore trying to acquire ownership =
in each cycle.  This can be used with the write transaction count to calcul=
ate the average write latency in the uncore.  The occupancy increments when=
 a write request is issued, and decrements when the data is returned.; Trac=
ks only those requests that come from the port specified in the IRP_PmonFil=
ter.OrderingQ register.  This register allows one to select one specific qu=
eue.  It is not possible to monitor multiple queues at a time.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Read Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_CACHE_READ_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads that are out=
standing in the uncore in each cycle.  This can be used with the read trans=
action count to calculate the average read latency in the uncore.  The occu=
pancy increments when a read request is issued, and decrements when the dat=
a is returned.; Tracks all requests from any source port.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Read Occupancy; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_I_CACHE_READ_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads that are out=
standing in the uncore in each cycle.  This can be used with the read trans=
action count to calculate the average read latency in the uncore.  The occu=
pancy increments when a read request is issued, and decrements when the dat=
a is returned.; Tracks only those requests that come from the port specifie=
d in the IRP_PmonFilter.OrderingQ register.  This register allows one to se=
lect one specific queue.  It is not possible to monitor multiple queues at =
a time.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks all requests f=
rom any source port.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of reads and writes t=
hat are outstanding in the uncore in each cycle.  This is effectively the s=
um of the READ_OCCUPANCY and WRITE_OCCUPANCY events.; Tracks only those req=
uests that come from the port specified in the IRP_PmonFilter.OrderingQ reg=
ister.  This register allows one to select one specific queue.  It is not p=
ossible to monitor multiple queues at a time.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Occupancy; Any Source",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches)  that are outstanding in the uncore in each cycle.  This can be=
 used with the transaction count event to calculate the average latency in =
the uncore.  The occupancy increments when the ownership fetch/prefetch is =
issued, and decrements the data is returned to the uncore.; Tracks all requ=
ests from any source port.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outstanding Write Occupancy; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_CACHE_WRITE_OCCUPANCY.SOURCE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of writes (and write =
prefetches)  that are outstanding in the uncore in each cycle.  This can be=
 used with the transaction count event to calculate the average latency in =
the uncore.  The occupancy increments when the ownership fetch/prefetch is =
issued, and decrements the data is returned to the uncore.; Tracks only tho=
se requests that come from the port specified in the IRP_PmonFilter.Orderin=
gQ register.  This register allows one to select one specific queue.  It is=
 not possible to monitor multiple queues at a time.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Clocks in the IRP",
+        "Counter": "0,1",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of clocks in the IRP.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0xb",
+        "EventName": "UNC_I_RxR_AK_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the AK Ingr=
ess is full.  This queue is where the IRP receives responses from R2PCIe (t=
he ring).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "AK Ingress Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xa",
+        "EventName": "UNC_I_RxR_AK_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the AK=
 Ingress.  This queue is where the IRP receives responses from R2PCIe (the =
ring).",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0xc",
+        "EventName": "UNC_I_RxR_AK_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the AK Ingress =
in each cycles.  This queue is where the IRP receives responses from R2PCIe=
 (the ring).",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x4",
+        "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - DRS",
+        "Counter": "0,1",
+        "EventCode": "0x1",
+        "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x7",
+        "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x5",
+        "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - NCB",
+        "Counter": "0,1",
+        "EventCode": "0x2",
+        "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x8",
+        "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x6",
+        "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the BL Ingr=
ess is full.  This queue is where the IRP receives data from R2PCIe (the ri=
ng).  It is used for data returns from read requets as well as outbound MMI=
O writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "BL Ingress Occupancy - NCS",
+        "Counter": "0,1",
+        "EventCode": "0x3",
+        "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the BL=
 Ingress.  This queue is where the IRP receives data from R2PCIe (the ring)=
.  It is used for data returns from read requets as well as outbound MMIO w=
rites.",
+        "Unit": "IRP"
+    },
+    {
+        "Counter": "0,1",
+        "EventCode": "0x9",
+        "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the BL Ingress =
in each cycles.  This queue is where the IRP receives data from R2PCIe (the=
 ring).  It is used for data returns from read requets as well as outbound =
MMIO writes.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Tickle Count; Ownership Lost",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TICKLES.LOST_OWNERSHIP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of tickles that are receiv=
ed.  This is for both explicit (from Cbo) and implicit (internal conflict) =
tickles.; Tracks the number of requests that lost ownership as a result of =
a tickle.  When a tickle comes in, if the request is not at the head of the=
 queue in the switch, then that request as well as any requests behind it i=
n the switch queue will lose ownership and have to re-acquire it later when=
 they get to the head of the queue.  This will therefore track the number o=
f requests that lost ownership and not just the number of tickles.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Tickle Count; Data Returned",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TICKLES.TOP_OF_QUEUE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of tickles that are receiv=
ed.  This is for both explicit (from Cbo) and implicit (internal conflict) =
tickles.; Tracks the number of cases when a tickle was received but the req=
uests was at the head of the queue in the switch.  In this case, data is re=
turned rather than releasing ownership.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.ORDERINGQ",
+        "Filter": "IRPFilter[4:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only those requests t=
hat come from the port specified in the IRP_PmonFilter.OrderingQ register. =
 This register allows one to select one specific queue.  It is not possible=
 to monitor multiple queues at a time.  If this bit is not set, then reques=
ts from all sources will be counted.",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count: Read Prefetches",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.RD_PREFETCHES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of read pr=
efetches.",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Reads",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only read requests (n=
ot including read prefetches).",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Writes",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Trackes only write requests.=
  Each write request should have a prefetch, so there is no need to explici=
tly track these requests.  For writes that are tickled and have to retry, t=
he counter will be incremented for each retry.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No AD Egress Credit Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_TxR_AD_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number times when it is not possi=
ble to issue a request to the R2PCIe because there are no AD Egress Credits=
 available.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "No BL Egress Credit Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_TxR_BL_STALL_CREDIT_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number times when it is not possi=
ble to issue data to the R2PCIe because there are no BL Egress Credits avai=
lable.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "EventCode": "0xe",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "EventCode": "0xf",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Request Queue Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xd",
+        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumultes the number of outstanding outboun=
d requests from the IRP to the switch (towards the devices).  This can be u=
sed in conjuection with the allocations event in order to calculate average=
 latency of outbound requests.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Write Ordering Stalls",
+        "Counter": "0,1",
+        "EventCode": "0x1a",
+        "EventName": "UNC_I_WRITE_ORDERING_STALL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when there are p=
ending write ACK's in the switch but the switch->IRP pipeline is not utiliz=
ed.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_R2_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the R2PCIe ucl=
k domain.  This could be slightly different than the count in the Ubox beca=
use of enable/freeze delays.  However, because the R2PCIe is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the DRS message class.=
",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCB message class.=
",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credit Acquired; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R2_IIO_CREDITS_ACQUIRED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of credits that are acquir=
ed in the R2PCIe agent for sending transactions into the IIO on either NCB =
or NCS are in use.  Transactions from the BL ring going into the IIO Agent =
must first acquire a credit.  These credits are for either the NCB or NCS m=
essage classes.  NCB, or non-coherent bypass messages are used to transmit =
data without coherency (and are common).  NCS is used for reads to PCIe (an=
d should be used sparingly).; Credits to the IIO for the NCS message class.=
",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Failed to Acquire a Credit; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R2_IIO_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request pe=
nding in the BL Ingress attempted to acquire either a NCB or NCS credit to =
transmit into the IIO, but was rejected because no credits were available. =
 NCB, or non-coherent bypass messages are used to transmit data without coh=
erency (and are common).  NCS is used for reads to PCIe (and should be used=
 sparingly).; Credits to the IIO for the DRS message class.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the DRS message =
class.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCB message =
class.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2PCIe IIO Credits in Use; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R2_IIO_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when one or more=
 credits in the R2PCIe agent for sending transactions into the IIO on eithe=
r NCB or NCS are in use.  Transactions from the BL ring going into the IIO =
Agent must first acquire a credit.  These credits are for either the NCB or=
 NCS message classes.  NCB, or non-coherent bypass messages are used to tra=
nsmit data without coherency (and are common).  NCS is used for reads to PC=
Ie (and should be used sparingly).; Credits to the IIO for the NCS message =
class.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xCC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even =
on VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd o=
n VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even on VRin=
g 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd on VRing=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even on VRin=
g 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd on VRing=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xCC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even =
on VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd o=
n VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even on VRin=
g 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd on VRing=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even on VRin=
g 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd on VRing=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xCC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even =
on VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 1.",
+        "UMask": "0x40",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd o=
n VRing 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 1.",
+        "UMask": "0x80",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even on VRin=
g 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd on VRing=
 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even on VRin=
g 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_VR1_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 1.",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd on VRing=
 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_VR1_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 1.",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters any polarity",
+        "UMask": "0xFF",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa",
+        "EventName": "UNC_R2_RING_IV_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Counterclockwise polarity",
+        "UMask": "0xCC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa",
+        "EventName": "UNC_R2_RING_IV_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Clockwise polarity",
+        "UMask": "0x33",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RxR_AK_BOUNCES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Counterclockwise",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RxR_AK_BOUNCES.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Clockwise",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RxR_AK_BOUNCES.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCB Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R2_RxR_CYCLES_NE.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Ingress is not empty.  This tracks one of the three rings that are used by =
the R2PCIe agent.  This can be used in conjunction with the R2PCIe Ingress =
Occupancy Accumulator event in order to calculate average queue occupancy. =
 Multiple ingress buffers can be tracked at a given time using multiple cou=
nters.; NCS Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R2_RxR_INSERTS.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
B Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R2_RxR_INSERTS.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the R2=
PCIe Ingress.  This tracks one of the three rings that are used by the R2PC=
Ie agent.  This can be used in conjunction with the R2PCIe Ingress Occupanc=
y Accumulator event in order to calculate average queue latency.  Multiple =
ingress buffers can be tracked at a given time using multiple counters.; NC=
S Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R2_RxR_OCCUPANCY.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given R2PCIe =
Ingress queue in each cycles.  This tracks one of the three ring Ingress bu=
ffers.  This can be used with the R2PCIe Ingress Not Empty event to calcula=
te average occupancy or the R2PCIe Ingress Allocations event in order to ca=
lculate average queuing latency.; DRS Ingress Queue",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AD",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AD Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; AK",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; AK Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Full; BL",
+        "EventCode": "0x25",
+        "EventName": "UNC_R2_TxR_CYCLES_FULL.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress buffer is full.; BL Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AD",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AD Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; AK",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; AK Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress Cycles Not Empty; BL",
+        "EventCode": "0x23",
+        "EventName": "UNC_R2_TxR_CYCLES_NE.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the R2PCIe =
Egress is not empty.  This tracks one of the three rings that are used by t=
he R2PCIe agent.  This can be used in conjunction with the R2PCIe Egress Oc=
cupancy Accumulator event in order to calculate average queue occupancy.  O=
nly a single Egress queue can be tracked at any given time.  It is not poss=
ible to filter based on direction or polarity.; BL Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AD CCW",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_TxR_NACK_CCW.AD",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_TxR_NACK_CCW.AK",
+        "PerPkg": "1",
+        "PublicDescription": "AK CounterClockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_TxR_NACK_CCW.BL",
+        "PerPkg": "1",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CW NACK; AD CW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.AD",
+        "PerPkg": "1",
+        "PublicDescription": "AD Clockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CW NACK; AK CW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.AK",
+        "PerPkg": "1",
+        "PublicDescription": "AK Clockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CW NACK; BL CW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.BL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Clockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "Counter": "0,1,2",
+        "EventCode": "0x1",
+        "EventName": "UNC_R3_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of uclks in the QPI uclk d=
omain.  This could be slightly different than the count in the Ubox because=
 of enable/freeze delays.  However, because the QPI Agent is close to the U=
box, they generally should not diverge by more than a handful of cycles.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO10",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 10",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO11",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 11",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO12",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 12",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO13",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 13",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO14",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 14&16",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO8",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 8",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2c",
+        "EventName": "UNC_R3_C_HI_AD_CREDITS_EMPTY.CBO9",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers higher CBoxes); Cbox 9",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO0",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 0",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO1",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO2",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 2",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO3",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 3",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO4",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 4",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO5",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 5",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO6",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 6",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "CBox AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2b",
+        "EventName": "UNC_R3_C_LO_AD_CREDITS_EMPTY.CBO7",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to Cbox on the =
AD Ring (covers lower CBoxes); Cbox 7",
+        "UMask": "0x80",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2f",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA0",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA0",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2f",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.HA1",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; HA1",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2f",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCB Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "HA/R2 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2f",
+        "EventName": "UNC_R3_HA_R2_BL_CREDITS_EMPTY.R2_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to either HA or=
 R2 on the BL Ring; R2 NCS Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x29",
+        "EventName": "UNC_R3_QPI0_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
AD Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI0 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2d",
+        "EventName": "UNC_R3_QPI0_BL_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI0 on the =
BL Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 AD Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2a",
+        "EventName": "UNC_R3_QPI1_AD_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
AD Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 HOM Messages",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 NDR Messages",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN0_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN0 SNP Messages",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_HOM",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 HOM Messages",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_NDR",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 NDR Messages",
+        "UMask": "0x40",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VN1_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VN1 SNP Messages",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "QPI1 BL Credits Empty",
+        "Counter": "0,1",
+        "EventCode": "0x2e",
+        "EventName": "UNC_R3_QPI1_BL_CREDITS_EMPTY.VNA",
+        "PerPkg": "1",
+        "PublicDescription": "No credits available to send to QPI1 on the =
BL Ring; VNA",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xCC",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Even on VRin=
g 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AD Ring in Use; Clockwise and Odd on VRing=
 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x7",
+        "EventName": "UNC_R3_RING_AD_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xCC",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Even on VRin=
g 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 AK Ring in Use; Clockwise and Odd on VRing=
 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x8",
+        "EventName": "UNC_R3_RING_AK_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xCC",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Even =
on VRing 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity on Virtual Ring 0.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Counterclockwise and Odd o=
n VRing 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CCW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity on Virtual Ring 0.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0x33",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Even on VRin=
g 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_VR0_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity on Virtual Ring 0.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R3 BL Ring in Use; Clockwise and Odd on VRing=
 0",
+        "Counter": "0,1,2",
+        "EventCode": "0x9",
+        "EventName": "UNC_R3_RING_BL_USED.CW_VR0_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty on Virtual Ring 0.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Any",
+        "Counter": "0,1,2",
+        "EventCode": "0xA",
+        "EventName": "UNC_R3_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters any polarity",
+        "UMask": "0xFF",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0xa",
+        "EventName": "UNC_R3_RING_IV_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Counterclockwise polarity",
+        "UMask": "0xCC",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Clockwise",
+        "Counter": "0,1,2",
+        "EventCode": "0xa",
+        "EventName": "UNC_R3_RING_IV_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.  The IV ring is unidirectional.  Whether UP or=
 DN is used is dependent on the system programming.  Thereofore, one should=
 generally set both the UP and DN bits for a given polarity (or both) at a =
given time.; Filters for Clockwise polarity",
+        "UMask": "0x33",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "AD Ingress Bypassed",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_R3_RxR_AD_BYPASSED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when the AD Ingre=
ss was bypassed and an incoming transaction was bypassed directly across th=
e BGF and into the qfclk domain.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Bypassed",
+        "Counter": "0,1",
+        "EventCode": "0x12",
+        "EventName": "UNC_R3_RxR_BYPASSED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when the Ingress =
was bypassed and an incoming transaction was bypassed directly across the B=
GF and into the qfclk domain.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; HOM",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; H=
OM Ingress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; NDR",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; N=
DR Ingress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Cycles Not Empty; SNP",
+        "Counter": "0,1",
+        "EventCode": "0x10",
+        "EventName": "UNC_R3_RxR_CYCLES_NE.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the QPI Ing=
ress is not empty.  This tracks one of the three rings that are used by the=
 QPI agent.  This can be used in conjunction with the QPI Ingress Occupancy=
 Accumulator event in order to calculate average queue occupancy.  Multiple=
 ingress buffers can be tracked at a given time using multiple counters.; S=
NP Ingress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; DRS",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; DRS Ingress=
 Queue",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; HOM",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; HOM Ingress=
 Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCB",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCB Ingress=
 Queue",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NCS",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NCS Ingress=
 Queue",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; NDR",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; NDR Ingress=
 Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; SNP",
+        "Counter": "0,1",
+        "EventCode": "0x11",
+        "EventName": "UNC_R3_RxR_INSERTS.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the QP=
I Ingress.  This tracks one of the three rings that are used by the QPI age=
nt.  This can be used in conjunction with the QPI Ingress Occupancy Accumul=
ator event in order to calculate average queue latency.  Multiple ingress b=
uffers can be tracked at a given time using multiple counters.; SNP Ingress=
 Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; DRS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; DRS Ingress Queue",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; HOM",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; HOM Ingress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; NCB",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; NCB Ingress Queue",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; NCS",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; NCS Ingress Queue",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; NDR",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; NDR Ingress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Ingress Occupancy Accumulator; SNP",
+        "EventCode": "0x13",
+        "EventName": "UNC_R3_RxR_OCCUPANCY.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of a given QPI Ing=
ress queue in each cycles.  This tracks one of the three ring Ingress buffe=
rs.  This can be used with the QPI Ingress Not Empty event to calculate ave=
rage occupancy or the QPI Ingress Allocations event in order to calculate a=
verage queuing latency.; SNP Ingress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; AK CCW",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_TxR_NACK_CCW.AD",
+        "PerPkg": "1",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; BL CW",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_TxR_NACK_CCW.AK",
+        "PerPkg": "1",
+        "PublicDescription": "AD Clockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; BL CCW",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R3_TxR_NACK_CCW.BL",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; AD CW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK_CW.AD",
+        "PerPkg": "1",
+        "PublicDescription": "AD Clockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; AD CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK_CW.AK",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Egress NACK; AK CW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R3_TxR_NACK_CW.BL",
+        "PerPkg": "1",
+        "PublicDescription": "BL Clockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Data Response (DRS).  DRS is generally used to transmit data with coher=
ency.  For example, remote reads and writes, or cache to cache transfers wi=
ll transmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for the Home (HOM) message class.  HOM is generally used to send requests, =
request responses, and snoop responses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data w=
ithout coherency.  For example, non-coherent read data returns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Non-Coherent Standard (NCS).  NCS is commonly used for ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; NDR pac=
kets are used to transmit a variety of protocol flits including grants and =
completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x37",
+        "EventName": "UNC_R3_VN0_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a DRS VN0 credit.  In order for a request to be transferred across QPI, it =
must be guaranteed to have a flit buffer on the remote socket to sink into.=
  There are two credit pools, VNA and VN0.  VNA is a shared pool used to ac=
hieve high performance.  The VN0 pool has reserved entries for each message=
 class and is used to prevent deadlock.  Requests first attempt to acquire =
a VNA credit, and then fall back to VN0 if they fail.  This therefore count=
s the number of times when a request failed to acquire either a VNA or VN0 =
credit and is delayed.  This should generally be a rare situation.; Filter =
for Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that=
 snoop responses flow on the HOM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; DRS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCB Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NCS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; NDR Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN0 Credit Used; SNP Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x36",
+        "EventName": "UNC_R3_VN0_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN0 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN0.  VNA is a shared pool used t=
o achieve high performance.  The VN0 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN0 if they fail.  This counts the =
number of times a VN0 credit was used.  Note that a single VN0 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN0 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; DRS Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Data Response (DRS).  DRS is generally used to transmit data with coherency=
.  For example, remote reads and writes, or cache to cache transfers will t=
ransmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; HOM Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
the Home (HOM) message class.  HOM is generally used to send requests, requ=
est responses, and snoop responses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCB Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Broadcast (NCB).  NCB is generally used to transmit data witho=
ut coherency.  For example, non-coherent read data returns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NCS Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Non-Coherent Standard (NCS).  NCS is commonly used for ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; NDR Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; NDR packets=
 are used to transmit a variety of protocol flits including grants and comp=
letions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Acquisition Failed on DRS; SNP Mes=
sage Class",
+        "Counter": "0,1",
+        "EventCode": "0x39",
+        "EventName": "UNC_R3_VN1_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a request failed to acquire =
a VN1 credit.  In order for a request to be transferred across QPI, it must=
 be guaranteed to have a flit buffer on the remote socket to sink into.  Th=
ere are two credit pools, VNA and VN1.  VNA is a shared pool used to achiev=
e high performance.  The VN1 pool has reserved entries for each message cla=
ss and is used to prevent deadlock.  Requests first attempt to acquire a VN=
A credit, and then fall back to VN1 if they fail.  This therefore counts th=
e number of times when a request failed to acquire either a VNA or VN1 cred=
it and is delayed.  This should generally be a rare situation.; Filter for =
Snoop (SNP) message class.  SNP is used for outgoing snoops.  Note that sno=
op responses flow on the HOM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; DRS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Data Response (DRS).  DRS is generally used to transm=
it data with coherency.  For example, remote reads and writes, or cache to =
cache transfers will transmit their data using DRS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for the Home (HOM) message class.  HOM is generally used =
to send requests, request responses, and snoop responses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NCB Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Broadcast (NCB).  NCB is generally used =
to transmit data without coherency.  For example, non-coherent read data re=
turns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NCS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Non-Coherent Standard (NCS).  NCS is commonly used fo=
r ?",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; NDR Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; NDR packets are used to transmit a variety of protocol flits inc=
luding grants and completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VN1 Credit Used; SNP Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x38",
+        "EventName": "UNC_R3_VN1_CREDITS_USED.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a VN1 credit was used on the=
 DRS message channel.  In order for a request to be transferred across QPI,=
 it must be guaranteed to have a flit buffer on the remote socket to sink i=
nto.  There are two credit pools, VNA and VN1.  VNA is a shared pool used t=
o achieve high performance.  The VN1 pool has reserved entries for each mes=
sage class and is used to prevent deadlock.  Requests first attempt to acqu=
ire a VNA credit, and then fall back to VN1 if they fail.  This counts the =
number of times a VN1 credit was used.  Note that a single VN1 credit holds=
 access to potentially multiple flit buffers.  For example, a transfer that=
 uses VNA could use 9 flit buffers and in that case uses 9 credits.  A tran=
sfer on VN1 will only count a single credit even though it may use multiple=
 buffers.; Filter for Snoop (SNP) message class.  SNP is used for outgoing =
snoops.  Note that snoop responses flow on the HOM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA credit Acquisitions",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.; Filter for the Home (HOM) message class.  HO=
M is generally used to send requests, request responses, and snoop response=
s.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA credit Acquisitions; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x33",
+        "EventName": "UNC_R3_VNA_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI VNA Credit acquisitions.  This=
 event can be used in conjunction with the VNA In-Use Accumulator to calcul=
ate the average lifetime of a credit holder.  VNA credits are used by all m=
essage classes in order to communicate across QPI.  If a packet is unable t=
o acquire credits, it will then attempt to use credts from the VN0 pool.  N=
ote that a single packet may require multiple flit buffers (i.e. when data =
is being transfered).  Therefore, this event will increment by the number o=
f credits acquired in each cycle.  Filtering based on message class is not =
provided.  One can count the number of packets transfered in a given messag=
e class using an qfclk event.; Filter for the Home (HOM) message class.  HO=
M is generally used to send requests, request responses, and snoop response=
s.",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; DRS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.DRS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Data Response (DRS).  DRS =
is generally used to transmit data with coherency.  For example, remote rea=
ds and writes, or cache to cache transfers will transmit their data using D=
RS.",
+        "UMask": "0x8",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; HOM Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.HOM",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for the Home (HOM) message cla=
ss.  HOM is generally used to send requests, request responses, and snoop r=
esponses.",
+        "UMask": "0x1",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCB Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Broadcast (NC=
B).  NCB is generally used to transmit data without coherency.  For example=
, non-coherent read data returns.",
+        "UMask": "0x10",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NCS Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Non-Coherent Standard (NCS=
).",
+        "UMask": "0x20",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; NDR Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.NDR",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; NDR packets are used to transmit a va=
riety of protocol flits including grants and completions (CMP).",
+        "UMask": "0x4",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VNA Credit Reject; SNP Message Class",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_R3_VNA_CREDITS_REJECT.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "Number of attempted VNA credit acquisitions =
that were rejected because the VNA credit pool was full (or almost full).  =
It is possible to filter this event by message class.  Some packets use mor=
e than one flit buffer, and therefore must acquire multiple credits.  There=
fore, one could get a reject even if the VNA credits were not fully used up=
.  The VNA pool is generally used to provide the bulk of the QPI bandwidth =
(as opposed to the VN0 pool which is used to guarantee forward progress).  =
VNA credits can run out if the flit buffer on the receiving side starts to =
queue up substantially.  This can happen if the rest of the uncore is unabl=
e to drain the requests fast enough.; Filter for Snoop (SNP) message class.=
  SNP is used for outgoing snoops.  Note that snoop responses flow on the H=
OM message class.",
+        "UMask": "0x2",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Cycles with no VNA credits available",
+        "Counter": "0,1",
+        "EventCode": "0x31",
+        "EventName": "UNC_R3_VNA_CREDIT_CYCLES_OUT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI uclk cycles when the transmitt=
ed has no VNA credits available and therefore cannot send any requests on t=
his channel.  Note that this does not mean that no flits can be transmitted=
, as those holding VN0 credits will still (potentially) be able to transmit=
.  Generally it is the goal of the uncore that VNA credits should not run o=
ut, as this can substantially throttle back useful QPI bandwidth.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "Cycles with 1 or more VNA credits in use",
+        "Counter": "0,1",
+        "EventCode": "0x32",
+        "EventName": "UNC_R3_VNA_CREDIT_CYCLES_USED",
+        "PerPkg": "1",
+        "PublicDescription": "Number of QPI uclk cycles with one or more V=
NA credits in use.  This event can be used in conjunction with the VNA In-U=
se Accumulator to calculate the average number of used VNA credits.",
+        "Unit": "R3QPI"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x10",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "VLW Received",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Virtual Logical Wire (legacy) message were r=
eceived from Uncore.   Specify the thread to filter on using NCUPMONCTRLGLC=
TR.ThreadID.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.DISABLE",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
+        "Filter": "UBoxFilter[3:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_DISABLE",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Filter Match",
+        "Counter": "0,1",
+        "EventCode": "0x41",
+        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
+        "Filter": "UBoxFilter[3:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "IDI Lock/SplitLock Cycles",
+        "Counter": "0,1",
+        "EventCode": "0x44",
+        "EventName": "UNC_U_LOCK_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times an IDI Lock/SplitLock sequen=
ce was started",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
+        "Counter": "0,1",
+        "EventCode": "0x45",
+        "EventName": "UNC_U_PHOLD_CYCLES.ASSERT_TO_ACK",
+        "PerPkg": "1",
+        "PublicDescription": "PHOLD cycles.  Filter from source CoreID.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "RACU Request",
+        "Counter": "0,1",
+        "EventCode": "0x46",
+        "EventName": "UNC_U_RACU_REQUESTS",
+        "PerPkg": "1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Correctable Machine Check=
",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.CMC",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x10",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Livelock",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LIVELOCK",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; LTError",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.LTERROR",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T0",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T0",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Monitor T1",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.MONITOR_T1",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; Filter by core",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Other",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.OTHER",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores; PREQ, PSMI, P2U, Thermal, PCUSMI, PMI",
+        "UMask": "0x80",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Trap",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.TRAP",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x40",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Monitor Sent to T0; Uncorrectable Machine Che=
ck",
+        "Counter": "0,1",
+        "EventCode": "0x43",
+        "EventName": "UNC_U_U2C_EVENTS.UMC",
+        "PerPkg": "1",
+        "PublicDescription": "Events coming from Uncore can be sent to one=
 or all cores",
+        "UMask": "0x20",
+        "Unit": "UBOX"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index 635c09fda1d9..304d861c368f 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -1,176 +1,539 @@
 [
     {
-        "BriefDescription": "PCU clock ticks. Use to get percentages of PC=
U cycles events",
+        "BriefDescription": "pclk Cycles",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
+        "PublicDescription": "The PCU runs off a fixed 800 MHz clock.  Thi=
s event counts the number of pclk cycles measured while the counter was ena=
bled.  The pclk, like the Memory Controller's dclk, counts at a constant ra=
te making it a good measure of actual wall time.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to the frequency that is co=
nfigured in the filter.  (filter_band0=3DXXX, with XXX in 100Mhz units). On=
e can also use inversion (filter_inv=3D1) to track cycles when we were less=
 than the configured frequency",
+        "BriefDescription": "Core 0 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xb",
-        "EventName": "UNC_P_FREQ_BAND0_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_BAND0_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band0_cycles %",
+        "EventCode": "0x70",
+        "EventName": "UNC_P_CORE0_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to the frequency that is co=
nfigured in the filter.  (filter_band1=3DXXX, with XXX in 100Mhz units). On=
e can also use inversion (filter_inv=3D1) to track cycles when we were less=
 than the configured frequency",
+        "BriefDescription": "Core 10 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xc",
-        "EventName": "UNC_P_FREQ_BAND1_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_BAND1_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band1_cycles %",
+        "EventCode": "0x7a",
+        "EventName": "UNC_P_CORE10_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to the frequency that is co=
nfigured in the filter.  (filter_band2=3DXXX, with XXX in 100Mhz units). On=
e can also use inversion (filter_inv=3D1) to track cycles when we were less=
 than the configured frequency",
+        "BriefDescription": "Core 11 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_P_FREQ_BAND2_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_BAND2_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band2_cycles %",
+        "EventCode": "0x7b",
+        "EventName": "UNC_P_CORE11_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to the frequency that is co=
nfigured in the filter.  (filter_band3=3DXXX, with XXX in 100Mhz units). On=
e can also use inversion (filter_inv=3D1) to track cycles when we were less=
 than the configured frequency",
+        "BriefDescription": "Core 12 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xe",
-        "EventName": "UNC_P_FREQ_BAND3_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_BAND3_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band3_cycles %",
+        "EventCode": "0x7c",
+        "EventName": "UNC_P_CORE12_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of times that the uncore tr=
ansitioned a frequency greater than or equal to the frequency that is confi=
gured in the filter.  (filter_band0=3DXXX, with XXX in 100Mhz units). One c=
an also use inversion (filter_inv=3D1) to track cycles when we were less th=
an the configured frequency. Derived from unc_p_freq_band0_cycles",
+        "BriefDescription": "Core 13 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xb",
-        "EventName": "UNC_P_FREQ_BAND0_TRANSITIONS",
-        "Filter": "edge=3D1",
-        "MetricExpr": "(UNC_P_FREQ_BAND0_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band0_cycles %",
+        "EventCode": "0x7d",
+        "EventName": "UNC_P_CORE13_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of times that the uncore tr=
ansitioned to a frequency greater than or equal to the frequency that is co=
nfigured in the filter.  (filter_band1=3DXXX, with XXX in 100Mhz units). On=
e can also use inversion (filter_inv=3D1) to track cycles when we were less=
 than the configured frequency. Derived from unc_p_freq_band1_cycles",
+        "BriefDescription": "Core 14 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xc",
-        "EventName": "UNC_P_FREQ_BAND1_TRANSITIONS",
-        "Filter": "edge=3D1",
-        "MetricExpr": "(UNC_P_FREQ_BAND1_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band1_cycles %",
+        "EventCode": "0x7e",
+        "EventName": "UNC_P_CORE14_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore t=
ransitioned to a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  (filter_band2=3DXXX, with XXX in 100Mhz units). O=
ne can also use inversion (filter_inv=3D1) to track cycles when we were les=
s than the configured frequency. Derived from unc_p_freq_band2_cycles",
+        "BriefDescription": "Core 1 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_P_FREQ_BAND2_TRANSITIONS",
-        "Filter": "edge=3D1",
-        "MetricExpr": "(UNC_P_FREQ_BAND2_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band2_cycles %",
+        "EventCode": "0x71",
+        "EventName": "UNC_P_CORE1_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore t=
ransitioned to a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  (filter_band3=3DXXX, with XXX in 100Mhz units). O=
ne can also use inversion (filter_inv=3D1) to track cycles when we were les=
s than the configured frequency. Derived from unc_p_freq_band3_cycles",
+        "BriefDescription": "Core 2 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xe",
-        "EventName": "UNC_P_FREQ_BAND3_TRANSITIONS",
-        "Filter": "edge=3D1",
-        "MetricExpr": "(UNC_P_FREQ_BAND3_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_band3_cycles %",
+        "EventCode": "0x72",
+        "EventName": "UNC_P_CORE2_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C0.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details",
+        "BriefDescription": "Core 3 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
-        "Filter": "occ_sel=3D1",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c0 %",
+        "EventCode": "0x73",
+        "EventName": "UNC_P_CORE3_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C3.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details",
+        "BriefDescription": "Core 4 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
-        "Filter": "occ_sel=3D2",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C3 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c3 %",
+        "EventCode": "0x74",
+        "EventName": "UNC_P_CORE4_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C6.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events ",
+        "BriefDescription": "Core 5 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
-        "Filter": "occ_sel=3D3",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C6 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c6 %",
+        "EventCode": "0x75",
+        "EventName": "UNC_P_CORE5_TRANSITION_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that we are in ex=
ternal PROCHOT mode.  This mode is triggered when a sensor off the die dete=
rmines that something off-die (like DRAM) is too hot and must throttle to a=
void damaging the chip",
+        "BriefDescription": "Core 6 C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xa",
-        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
-        "MetricExpr": "(UNC_P_PROCHOT_EXTERNAL_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
-        "MetricName": "prochot_external_cycles %",
+        "EventCode": "0x76",
+        "EventName": "UNC_P_CORE6_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 7 C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x77",
+        "EventName": "UNC_P_CORE7_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 8 C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x78",
+        "EventName": "UNC_P_CORE8_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 9 C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "UNC_P_CORE9_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE0",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE1",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE10",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE11",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE12",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE13",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE14",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE2",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE3",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE4",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1c",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE5",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1d",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE6",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE7",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1f",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE8",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Deep C State Rejection - Core 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_P_DELAYED_C_STATE_ABORT_CORE9",
+        "ExtSel": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 0 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1e",
+        "EventName": "UNC_P_DEMOTIONS_CORE0",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 1 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1f",
+        "EventName": "UNC_P_DEMOTIONS_CORE1",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 10 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_P_DEMOTIONS_CORE10",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 11 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_P_DEMOTIONS_CORE11",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 12 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x44",
+        "EventName": "UNC_P_DEMOTIONS_CORE12",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 13 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x45",
+        "EventName": "UNC_P_DEMOTIONS_CORE13",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 14 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_P_DEMOTIONS_CORE14",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 2 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_P_DEMOTIONS_CORE2",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 3 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_P_DEMOTIONS_CORE3",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 4 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_P_DEMOTIONS_CORE4",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 5 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "UNC_P_DEMOTIONS_CORE5",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 6 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_P_DEMOTIONS_CORE6",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 7 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_P_DEMOTIONS_CORE7",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 8 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_P_DEMOTIONS_CORE8",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core 9 C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_P_DEMOTIONS_CORE9",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xb",
+        "EventName": "UNC_P_FREQ_BAND0_CYCLES",
+        "Filter": "PCUFilter[7:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc",
+        "EventName": "UNC_P_FREQ_BAND1_CYCLES",
+        "Filter": "PCUFilter[15:8]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd",
+        "EventName": "UNC_P_FREQ_BAND2_CYCLES",
+        "Filter": "PCUFilter[23:16]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Frequency Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xe",
+        "EventName": "UNC_P_FREQ_BAND3_CYCLES",
+        "Filter": "PCUFilter[31:24]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Current Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_P_FREQ_MAX_CURRENT_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when current is =
the upper limit on frequency.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when temperature =
is the upper limit on frequency",
+        "BriefDescription": "Thermal Strongest Upper Limit Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x4",
         "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES / UNC_P_CLOCKT=
ICKS) * 100.",
-        "MetricName": "freq_max_limit_thermal_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when thermal con=
ditions are the upper limit on frequency.  This is related to the THERMAL_T=
HROTTLE CYCLES_ABOVE_TEMP event, which always counts cycles when we are abo=
ve the thermal temperature.  This event (STRONGEST_UPPER_LIMIT) is sampled =
at the output of the algorithm that determines the actual frequency, while =
THERMAL_THROTTLE looks at the input.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when the OS is th=
e upper limit on frequency",
+        "BriefDescription": "OS Strongest Upper Limit Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x6",
         "EventName": "UNC_P_FREQ_MAX_OS_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_MAX_OS_CYCLES / UNC_P_CLOCKTICKS) * 100=
.",
-        "MetricName": "freq_max_os_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the OS is t=
he upper limit on frequency.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when power is the=
 upper limit on frequency",
+        "BriefDescription": "Power Strongest Upper Limit Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x5",
         "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_MAX_POWER_CYCLES / UNC_P_CLOCKTICKS) * =
100.",
-        "MetricName": "freq_max_power_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when power is th=
e upper limit on frequency.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when current is t=
he upper limit on frequency",
+        "BriefDescription": "IO P Limit Strongest Lower Limit Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x7",
-        "EventName": "UNC_P_FREQ_MAX_CURRENT_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_MAX_CURRENT_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
-        "MetricName": "freq_max_current_cycles %",
+        "EventCode": "0x61",
+        "EventName": "UNC_P_FREQ_MIN_IO_P_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when IO P Limit =
is preventing us from dropping the frequency lower.  This algorithm monitor=
s the needs to the IO subsystem on both local and remote sockets and will m=
aintain a frequency high enough to maintain good IO BW.  This is necessary =
for when all the IA cores on a socket are idle but a user still would like =
to maintain high IO Bandwidth.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Perf P Limit Strongest Lower Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x62",
+        "EventName": "UNC_P_FREQ_MIN_PERF_P_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when Perf P Limi=
t is preventing us from dropping the frequency lower.  Perf P Limit is an a=
lgorithm that takes input from remote sockets when determining if a socket =
should drop it's frequency down.  This is largely to minimize increases in =
snoop and remote read latencies.",
         "Unit": "PCU"
     },
     {
@@ -178,96 +541,165 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_TRANS_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_trans_cycles %",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the system =
is changing frequency.  This can not be filtered by thread ID.  One can als=
o use it with the occupancy counter that monitors number of threads in C0 t=
o estimate the performance impact that frequency transitions had on the sys=
tem.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to 1.2Ghz. Derived from unc=
_p_freq_band0_cycles",
+        "BriefDescription": "Memory Phase Shedding Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xb",
-        "EventName": "UNC_P_FREQ_GE_1200MHZ_CYCLES",
-        "Filter": "filter_band0=3D12",
-        "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_1200mhz_cycles %",
+        "EventCode": "0x2f",
+        "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the PCU has=
 triggered memory phase shedding.  This is a mode that can be run in the iM=
C physicals that saves power at the expense of additional latency.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to 2Ghz. Derived from unc_p=
_freq_band1_cycles",
+        "BriefDescription": "Package C State Exit Latency",
         "Counter": "0,1,2,3",
-        "EventCode": "0xc",
-        "EventName": "UNC_P_FREQ_GE_2000MHZ_CYCLES",
-        "Filter": "filter_band1=3D20",
-        "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_2000mhz_cycles %",
+        "EventCode": "0x26",
+        "EventName": "UNC_P_PKG_C_EXIT_LATENCY",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the package=
 is transitioning from package C2 to C3.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to 3Ghz. Derived from unc_p=
_freq_band2_cycles",
+        "BriefDescription": "Package C State Exit Latency",
         "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_P_FREQ_GE_3000MHZ_CYCLES",
-        "Filter": "filter_band2=3D30",
-        "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_3000mhz_cycles %",
+        "EventCode": "0x26",
+        "EventName": "UNC_P_PKG_C_EXIT_LATENCY_SEL",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the package=
 is transitioning from package C2 to C3.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore w=
as running at a frequency greater than or equal to 4Ghz. Derived from unc_p=
_freq_band3_cycles",
+        "BriefDescription": "Package C State Residency - C0",
         "Counter": "0,1,2,3",
-        "EventCode": "0xe",
-        "EventName": "UNC_P_FREQ_GE_4000MHZ_CYCLES",
-        "Filter": "filter_band3=3D40",
-        "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_4000mhz_cycles %",
+        "EventCode": "0x2a",
+        "EventName": "UNC_P_PKG_C_STATE_RESIDENCY_C0_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the package=
 is in C0",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of times that the uncore tr=
ansitioned to a frequency greater than or equal to 1.2Ghz. Derived from unc=
_p_freq_band0_cycles",
+        "BriefDescription": "Package C State Residency - C2",
         "Counter": "0,1,2,3",
-        "EventCode": "0xb",
-        "EventName": "UNC_P_FREQ_GE_1200MHZ_TRANSITIONS",
-        "Filter": "edge=3D1,filter_band0=3D12",
-        "MetricExpr": "(UNC_P_FREQ_GE_1200MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_1200mhz_cycles %",
+        "EventCode": "0x2b",
+        "EventName": "UNC_P_PKG_C_STATE_RESIDENCY_C2_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the package=
 is in C2",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of times that the uncore tr=
ansitioned to a frequency greater than or equal to 2Ghz. Derived from unc_p=
_freq_band1_cycles",
+        "BriefDescription": "Package C State Residency - C3",
         "Counter": "0,1,2,3",
-        "EventCode": "0xc",
-        "EventName": "UNC_P_FREQ_GE_2000MHZ_TRANSITIONS",
-        "Filter": "edge=3D1,filter_band1=3D20",
-        "MetricExpr": "(UNC_P_FREQ_GE_2000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_2000mhz_cycles %",
+        "EventCode": "0x2c",
+        "EventName": "UNC_P_PKG_C_STATE_RESIDENCY_C3_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the package=
 is in C3",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore t=
ransitioned to a frequency greater than or equal to 3Ghz. Derived from unc_=
p_freq_band2_cycles",
+        "BriefDescription": "Package C State Residency - C6",
         "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_P_FREQ_GE_3000MHZ_TRANSITIONS",
-        "Filter": "edge=3D1,filter_band2=3D30",
-        "MetricExpr": "(UNC_P_FREQ_GE_3000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_3000mhz_cycles %",
+        "EventCode": "0x2d",
+        "EventName": "UNC_P_PKG_C_STATE_RESIDENCY_C6_CYCLES",
+        "ExtSel": "1",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the package=
 is in C6",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the uncore t=
ransitioned to a frequency greater than or equal to 4Ghz. Derived from unc_=
p_freq_band3_cycles",
+        "BriefDescription": "Number of cores in C-State; C0 and C1",
         "Counter": "0,1,2,3",
-        "EventCode": "0xe",
-        "EventName": "UNC_P_FREQ_GE_4000MHZ_TRANSITIONS",
-        "Filter": "edge=3D1,filter_band3=3D40",
-        "MetricExpr": "(UNC_P_FREQ_GE_4000MHZ_CYCLES / UNC_P_CLOCKTICKS) *=
 100.",
-        "MetricName": "freq_ge_4000mhz_cycles %",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
+        "PerPkg": "1",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State; C3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
+        "PerPkg": "1",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State; C6 and C7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
+        "PerPkg": "1",
+        "PublicDescription": "This is an occupancy event that tracks the n=
umber of cores that are in the chosen C-State.  It can be used by itself to=
 get the average number of cores in that C-state with threshholding to gene=
rate histograms, or with other PCU events and occupancy triggering to captu=
re other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "External Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xa",
+        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that we are in e=
xternal PROCHOT mode.  This mode is triggered when a sensor off the die det=
ermines that something off-die (like DRAM) is too hot and must throttle to =
avoid damaging the chip.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Internal Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that we are in I=
nteral PROCHOT mode.  This mode is triggered when a sensor on the die deter=
mines that we are too hot and must throttle to avoid damaging the chip.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Total Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x63",
+        "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions across all cores.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles Changing Voltage",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_P_VOLT_TRANS_CYCLES_CHANGE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the system =
is changing voltage.  There is no filtering supported with this event.  One=
 can use it as a simple event, or use it conjunction with the occupancy eve=
nts to monitor the number of cores or threads that were impacted by the tra=
nsition.  This event is calculated by or'ing together the increasing and de=
creasing events.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles Decreasing Voltage",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_P_VOLT_TRANS_CYCLES_DECREASE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the system =
is decreasing voltage.  There is no filtering supported with this event.  O=
ne can use it as a simple event, or use it conjunction with the occupancy e=
vents to monitor the number of cores or threads that were impacted by the t=
ransition.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles Increasing Voltage",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_P_VOLT_TRANS_CYCLES_INCREASE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the system =
is increasing voltage.  There is no filtering supported with this event.  O=
ne can use it as a simple event, or use it conjunction with the occupancy e=
vents to monitor the number of cores or threads that were impacted by the t=
ransition.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "VR Hot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_P_VR_HOT_CYCLES",
         "PerPkg": "1",
         "Unit": "PCU"
     }
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
index da6a3e09a782..6624d02ad715 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
@@ -195,4 +195,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index cc34f6378d89..b023c1ac2224 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-3F,v25,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.14,icelake,core
 GenuineIntel-6-6[AC],v1.15,icelakex,core
 GenuineIntel-6-3A,v22,ivybridge,core
-GenuineIntel-6-3E,v19,ivytown,core
+GenuineIntel-6-3E,v21,ivytown,core
 GenuineIntel-6-2D,v20,jaketown,core
 GenuineIntel-6-57,v9,knightslanding,core
 GenuineIntel-6-85,v9,knightslanding,core
--=20
2.37.1.359.gd136c6c3e2-goog

