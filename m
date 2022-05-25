Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44935339B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbiEYJN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiEYJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:13:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315A47E1F6;
        Wed, 25 May 2022 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653469806; x=1685005806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JD8bFyaDHcYk/W64dsvRRE5s0H9OnHGSW5uKyjA1CCU=;
  b=RRaiAJKfDf0CD7EeDbhye4i9Xdeb4eep/MBbT6mP1DiY7eq+JzLBRo6c
   qUiy+K9jk1qY/b6dI+czMTpYaoujFBEohx11cv84c9tfeGcXWf41AtvZS
   IeKMG7goFuniDb9xTHN7JIZfFFOOs+zFQSAE1CdOG+qFmIQQqK0y641X+
   fIKFfdDeggNy+YDUmfLu04OkaBgSB1qyaxKfzQF/6P3XdAyK/CByQy+N/
   WZZjOIKe8PUnPA4yXMU6+BO1hZTuXW1Qgd6uu+1UV6/9YhkYCbOtqxj9z
   EpFCyeGYAn/BPh/P4G65inmSA99+sBGEo5AunmCFbo0WIUnobgAu2+YEj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273873514"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273873514"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 02:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="717554983"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga001.fm.intel.com with ESMTP; 25 May 2022 02:10:03 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 2/2] perf vendor events intel: Update metrics for Alderlake
Date:   Wed, 25 May 2022 17:10:13 +0800
Message-Id: <20220525091013.1704887-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525091013.1704887-1-zhengjun.xing@linux.intel.com>
References: <20220525091013.1704887-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update JSON metrics for Alderlake to perf.

It included both P-core and E-core metrics.

P-core metrics based on TMA 4.4 (TMA_Metrics-full.csv)
E-core metrics based on E-core TMA 2.0 (E-core_TMA_Metrics.csv)

https://download.01.org/perfmon/

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 161 ++++++++++++------
 1 file changed, 112 insertions(+), 49 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 6b24958737b5..56f86b362c4b 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -37,7 +37,7 @@
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilized by this Logical Processor",
         "MetricExpr": "TOPDOWN.SLOTS / ( TOPDOWN.SLOTS / 2 ) if #SMT_on else 1",
-        "MetricGroup": "SMT",
+        "MetricGroup": "SMT;TmaL1",
         "MetricName": "Slots_Utilization",
         "Unit": "cpu_core"
     },
@@ -64,27 +64,20 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Actual per-core usage of the Floating Point execution units (regardless of the vector width)",
-        "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) ) / ( 2 * CPU_CLK_UNHALTED.DISTRIBUTED )",
+        "BriefDescription": "Actual per-core usage of the Floating Point non-X87 execution units (regardless of precision or vector-width)",
+        "MetricExpr": "( FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.PORT_1 + FP_ARITH_DISPATCHED.PORT_5 ) / ( 2 * CPU_CLK_UNHALTED.DISTRIBUTED )",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "FP_Arith_Utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point execution units (regardless of the vector width). Values > 1 are possible due to Fused-Multiply Add (FMA) counting.",
+        "PublicDescription": "Actual per-core usage of the Floating Point non-X87 execution units (regardless of precision or vector-width). Values > 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; [ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less common).",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is execution) per-core",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "IpMispredict",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
         "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
@@ -181,6 +174,13 @@
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit instruction (lower number means higher occurrence rate). May undercount due to FMA double counting.",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Instructions per Software prefetch instruction (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / cpu_core@SW_PREFETCH_ACCESS.T0\\,umask\\=0xF@",
+        "MetricGroup": "Prefetches",
+        "MetricName": "IpSWPF",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Total number of retired Instructions, Sample with: INST_RETIRED.PREC_DIST",
         "MetricExpr": "INST_RETIRED.ANY",
@@ -188,6 +188,27 @@
         "MetricName": "Instructions",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Estimated fraction of retirement-cycles dealing with repeat instructions",
+        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu_core@UOPS_RETIRED.SLOTS\\,cmask\\=1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "Strings_Cycles",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Instructions per a microcode Assist invocation. See Assists tree node for details (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / cpu_core@ASSISTS.ANY\\,umask\\=0x1B@",
+        "MetricGroup": "Pipeline;Ret;Retire",
+        "MetricName": "IpAssist",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu_core@UOPS_EXECUTED.THREAD\\,cmask\\=1@",
+        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
+        "MetricName": "Execute",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Average number of Uops issued by front-end when it issued something",
         "MetricExpr": "UOPS_ISSUED.ANY / cpu_core@UOPS_ISSUED.ANY\\,cmask\\=1@",
@@ -210,12 +231,26 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative DSB miss",
+        "BriefDescription": "Average number of cycles of a switch from the DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details.",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=1\\,edge\\=1@",
+        "MetricGroup": "DSBmiss",
+        "MetricName": "DSB_Switch_Cost",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative DSB miss (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
         "MetricGroup": "DSBmiss;Fed",
         "MetricName": "IpDSB_Miss_Ret",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "IpMispredict",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Fraction of branches that are non-taken conditionals",
         "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL_BRANCHES",
@@ -252,11 +287,10 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand load instructions (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MISS_ANY",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
         "MetricName": "Load_Miss_Real_Latency",
-        "PublicDescription": "Actual Average Latency for L1 data-cache miss demand load instructions (in core cycles). Latency may be overestimated for multi-load instructions - e.g. repeat strings.",
         "Unit": "cpu_core"
     },
     {
@@ -266,34 +300,6 @@
         "MetricName": "MLP",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Average per-core data access bandwidth to the L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW;Offcore",
-        "MetricName": "L3_Cache_Access_BW",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
@@ -316,14 +322,14 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instruction for all request types (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
         "MetricGroup": "Mem;CacheMisses;Offcore",
         "MetricName": "L2MPKI_All",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "L2 cache misses per kilo instruction for all demand loads  (including speculative)",
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instruction for all demand loads  (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED.ANY",
         "MetricGroup": "Mem;CacheMisses",
         "MetricName": "L2MPKI_Load",
@@ -351,7 +357,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fill Buffer (FB) true hits per kilo instructions for retired demand loads",
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions for retired demand loads (L1D misses that merge into ongoing miss-handling entries)",
         "MetricExpr": "1000 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
         "MetricGroup": "Mem;CacheMisses",
         "MetricName": "FB_HPKI",
@@ -365,6 +371,62 @@
         "MetricName": "Page_Walks_Utilization",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-core data access bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 / duration_time)",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW_1T",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 / duration_time)",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW_1T",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "(64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time)",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW_1T",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to the L3 cache [GB / sec]",
+        "MetricExpr": "(64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time)",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW_1T",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
@@ -384,6 +446,7 @@
         "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "GFLOPs",
+        "PublicDescription": "Giga Floating Point Operations Per Second. Aggregate across all supported options of: FP precisions, scalar and vector instructions, vector-width and AMX engine.",
         "Unit": "cpu_core"
     },
     {
@@ -461,7 +524,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)",
+        "MetricExpr": "(TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE))",
         "MetricGroup": "TopdownL1",
         "MetricName": "Backend_Bound_Aux",
         "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that UOPS must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.  All of these subevents count backend stalls, in slots, due to a resource limitation.   These are not cycle based events and therefore can not be precisely added or subtracted from the Backend_Bound subevents which are cycle based.  These subevents are supplementary to Backend_Bound and can be used to analyze results from a resource perspective at allocation.  ",
@@ -620,7 +683,7 @@
     },
     {
         "BriefDescription": "Estimated Pause cost. In percent",
-        "MetricExpr": "100 * SERIALIZATION.NON_C01_MS_SCB / ( 5 * CPU_CLK_UNHALTED.CORE )",
+        "MetricExpr": "100 * SERIALIZATION.NON_C01_MS_SCB / (5 * CPU_CLK_UNHALTED.CORE)",
         "MetricName": "Estimated_Pause_Cost",
         "Unit": "cpu_atom"
     },
-- 
2.25.1

