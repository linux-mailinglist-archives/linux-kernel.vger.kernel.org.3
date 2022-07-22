Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B632E57E9B0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiGVWdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiGVWdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:33:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBAFA8773
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:32:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l6-20020a25bf86000000b00668c915a3f2so4584333ybk.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=1iuDOW5y2MNicIoW18zc7/6u4Lq9VG+6woOeCQO7q9I=;
        b=Yvl06UMLuWAntJRkL6AKm7FxSuBDalWofTu21gqvmQe0uPjgSUa9V0sb6GHi7joiG0
         VDPJlMHq7Gr0tvNZ6Nv30oMOiwxhMI2AU+TPTr1wQhLr3TfYvaFe4lJWMrHK+R/+3XHJ
         OCNh3gT8HdJHtfZL6dsdEYSNPqq/0+Wett3NtJRNMps8ZXC2B7E9cSgzywcXKM+BzGCF
         GzLDkdQ8/NISfDAgBYAHBUGU1i1j/XVHvAWBG8H18t16vT+DbUTcF3gXQ9PlgkHpuWnk
         rzTMPgRC7NCe80pK2Vk7A+9w4zSxHo29wpq85B5BoxLemrXalPj5xxWdLsHQBeVjbMJR
         tpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=1iuDOW5y2MNicIoW18zc7/6u4Lq9VG+6woOeCQO7q9I=;
        b=C1Tp3VMDhVQiBWTZXpIc1SbxO2+Hvd8u3zd8ovx7jIx9EAkmBSz/IsPOqtyNtTgGbC
         EQGMpDYVdxajsJ/3MkY4gkgw1lpEaO0EJWVEzzFElqozfZWMnrTWNUE7WOouo2DXXnPy
         zAldP3sV42hSaS78/FPgIuNYhns81KCfdhjr55AvthQ9mNPTZv4H/hvcF/Bfds9JriI+
         xb1UuTOycBm9mlVGUW6z9zhz9wGT1h1ZhsAgz5sF3HfPUCp3TmdZZGx3NLuqtMFGGz1f
         7nVchUkCAZBOHlVXb6wasMYm6VO7zJbIzdmyD7bUHJogRSs+1K7M43S+SW67pES23FLi
         oL4g==
X-Gm-Message-State: AJIora9mRSjetM83aHNNFzPQWyVOENzw9ZV5f5+kxrjAiiHzqXge4OHZ
        YRgeVO9sL3PQ+Jug0+UtKnmyfvDtq3A/
X-Google-Smtp-Source: AGRyM1ucwM01zUw8SPxVevY/YOT0nOTtFjR15HfV8ieJz+INO1mscoISZFKNUeLJU1JleyOBKS8Kh142eBGD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:2f4a:0:b0:670:ea89:72b2 with SMTP id
 v71-20020a252f4a000000b00670ea8972b2mr1757220ybv.427.1658529178901; Fri, 22
 Jul 2022 15:32:58 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:12 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-4-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 03/31] perf vendor events: Update Intel broadwell
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

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the broadwell files into perf and update mapfile.csv.

Tested on a non-broadwell with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwell/bdw-metrics.json       |  130 +-
 .../pmu-events/arch/x86/broadwell/cache.json  |    2 +-
 .../arch/x86/broadwell/floating-point.json    |    2 +-
 .../arch/x86/broadwell/frontend.json          |    2 +-
 .../pmu-events/arch/x86/broadwell/memory.json |    2 +-
 .../pmu-events/arch/x86/broadwell/other.json  |    2 +-
 .../arch/x86/broadwell/pipeline.json          |    2 +-
 .../arch/x86/broadwell/uncore-cache.json      |  152 ++
 .../arch/x86/broadwell/uncore-other.json      |   82 ++
 .../pmu-events/arch/x86/broadwell/uncore.json |  278 ----
 .../arch/x86/broadwell/virtual-memory.json    |    2 +-
 .../arch/x86/broadwellde/uncore-other.json    | 1246 +++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    3 +-
 13 files changed, 1571 insertions(+), 334 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-other.j=
son
 delete mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/uncore-other=
.json

diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/to=
ols/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
index 91d23341eabd..d65afe3d0b06 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
@@ -130,43 +130,25 @@
         "MetricName": "FLOPc_SMT"
     },
     {
-        "BriefDescription": "Actual per-core usage of the Floating Point e=
xecution units (regardless of the vector width)",
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
         "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_I=
NST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP=
_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_=
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) ) / ( 2 * CPU_CLK_UNHALT=
ED.THREAD )",
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
-        "BriefDescription": "Actual per-core usage of the Floating Point e=
xecution units (regardless of the vector width). SMT version; use when SMT =
is enabled and measuring per logical CPU.",
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width). SMT versi=
on; use when SMT is enabled and measuring per logical CPU.",
         "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_I=
NST_RETIRED.SCALAR_DOUBLE) + (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP=
_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_=
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) ) / ( 2 * ( ( CPU_CLK_UN=
HALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UN=
HALTED.REF_XCLK ) ) )",
         "MetricGroup": "Cor;Flops;HPC_SMT",
         "MetricName": "FP_Arith_Utilization_SMT",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
execution units (regardless of the vector width). Values > 1 are possible d=
ue to Fused-Multiply Add (FMA) counting. SMT version; use when SMT is enabl=
ed and measuring per logical CPU."
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n). SMT version; use when SMT is enabled and measuring per logical CPU."
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
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIR=
ED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.TH=
READ))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_C=
LK_UNHALTED.THREAD)) * (BR_MISP_RETIRED.ALL_BRANCHES * (12 * ( BR_MISP_RETI=
RED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / CPU_CLK_UNHALTED=
.THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS=
.ANY )) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_=
CLK_UNHALTED.THREAD)) ) * (4 * CPU_CLK_UNHALTED.THREAD) / BR_MISP_RETIRED.A=
LL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "Branch_Misprediction_Cost"
-    },
-    {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIR=
ED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU=
_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU=
_CLK_UNHALTED.REF_XCLK ) )))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_D=
ELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED=
.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * (BR_MISP_RETIRED.ALL=
_BRANCHES * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + B=
ACLEARS.ANY ) / CPU_CLK_UNHALTED.THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES +=
 MACHINE_CLEARS.COUNT + BACLEARS.ANY )) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCL=
ES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_C=
LK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) ) * (4 * ( =
( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE =
/ CPU_CLK_UNHALTED.REF_XCLK ) )) / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts_SMT",
-        "MetricName": "Branch_Misprediction_Cost_SMT"
-    },
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
@@ -256,6 +238,18 @@
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
@@ -263,35 +257,34 @@
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load instructions (in core cycles)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_=
MISS + mem_load_uops_retired.hit_lfb )",
-        "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "Load_Miss_Real_Latency",
-        "PublicDescription": "Actual Average Latency for L1 data-cache mis=
s demand load instructions (in core cycles). Latency may be overestimated f=
or multi-load instructions - e.g. repeat strings."
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "IpMispredict"
     },
     {
-        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
-        "MetricGroup": "Mem;MemoryBound;MemoryBW",
-        "MetricName": "MLP"
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIR=
ED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.TH=
READ))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_C=
LK_UNHALTED.THREAD)) * (BR_MISP_RETIRED.ALL_BRANCHES * (12 * ( BR_MISP_RETI=
RED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / CPU_CLK_UNHALTED=
.THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS=
.ANY )) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_=
CLK_UNHALTED.THREAD)) ) * (4 * CPU_CLK_UNHALTED.THREAD) / BR_MISP_RETIRED.A=
LL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "Branch_Misprediction_Cost"
     },
     {
-        "BriefDescription": "Average data fill bandwidth to the L1 data ca=
che [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW"
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIR=
ED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU=
_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU=
_CLK_UNHALTED.REF_XCLK ) )))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_D=
ELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED=
.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * (BR_MISP_RETIRED.ALL=
_BRANCHES * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + B=
ACLEARS.ANY ) / CPU_CLK_UNHALTED.THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES +=
 MACHINE_CLEARS.COUNT + BACLEARS.ANY )) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCL=
ES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_C=
LK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) ) * (4 * ( =
( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE =
/ CPU_CLK_UNHALTED.REF_XCLK ) )) / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts_SMT",
+        "MetricName": "Branch_Misprediction_Cost_SMT"
     },
     {
-        "BriefDescription": "Average data fill bandwidth to the L2 cache [=
GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW"
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_=
MISS + mem_load_uops_retired.hit_lfb )",
+        "MetricGroup": "Mem;MemoryBound;MemoryLat",
+        "MetricName": "Load_Miss_Real_Latency"
     },
     {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW"
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLE=
S",
+        "MetricGroup": "Mem;MemoryBound;MemoryBW",
+        "MetricName": "MLP"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
@@ -306,13 +299,13 @@
         "MetricName": "L2MPKI"
     },
     {
-        "BriefDescription": "L2 cache misses per kilo instruction for all =
request types (including speculative)",
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
         "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
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
@@ -348,6 +341,48 @@
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
@@ -364,7 +399,8 @@
         "BriefDescription": "Giga Floating Point Operations Per Second",
         "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_=
ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_=
DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED.256B_PACKED_DOUBLE ) + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE ) =
/ 1000000000 ) / duration_time",
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/cache.json b/tools/pe=
rf/pmu-events/arch/x86/broadwell/cache.json
index 890412f02e06..f3d7fced28b6 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/cache.json
@@ -3407,4 +3407,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json b=
/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
index 9ad37dddb354..6322116d0d46 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
@@ -190,4 +190,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json b/tools=
/perf/pmu-events/arch/x86/broadwell/frontend.json
index f0bcb945ff76..37ce8034b2ed 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/frontend.json
@@ -292,4 +292,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/memory.json b/tools/p=
erf/pmu-events/arch/x86/broadwell/memory.json
index f4eebecf371f..2a7797738159 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/memory.json
@@ -3050,4 +3050,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/other.json b/tools/pe=
rf/pmu-events/arch/x86/broadwell/other.json
index 4b360fe96698..917d145d5227 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/other.json
@@ -41,4 +41,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/tools=
/perf/pmu-events/arch/x86/broadwell/pipeline.json
index 18d21b94a4b9..e9a604e2d67c 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
@@ -1377,4 +1377,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json b/t=
ools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
new file mode 100644
index 000000000000..d1805b3a5e3d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/broadwell/uncore-cache.json
@@ -0,0 +1,152 @@
+[
+    {
+        "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in E or S-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_ES",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup any request that access cache and =
found line in E or S-state.",
+        "UMask": "0x86",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in I-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_I",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup any request that access cache and =
found line in I-state.",
+        "UMask": "0x88",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in M-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_M",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup any request that access cache and =
found line in M-state.",
+        "UMask": "0x81",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup any request that access cache and f=
ound line in MESI-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_MESI",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup any request that access cache and =
found line in MESI-state.",
+        "UMask": "0x8f",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup read request that access cache and =
found line in E or S-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.READ_ES",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup read request that access cache and=
 found line in E or S-state.",
+        "UMask": "0x16",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup read request that access cache and =
found line in I-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.READ_I",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup read request that access cache and=
 found line in I-state.",
+        "UMask": "0x18",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup read request that access cache and =
found line in M-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.READ_M",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup read request that access cache and=
 found line in M-state.",
+        "UMask": "0x11",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup read request that access cache and =
found line in any MESI-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.READ_MESI",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup read request that access cache and=
 found line in any MESI-state.",
+        "UMask": "0x1f",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup write request that access cache and=
 found line in E or S-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_ES",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup write request that access cache an=
d found line in E or S-state.",
+        "UMask": "0x26",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup write request that access cache and=
 found line in M-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_M",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup write request that access cache an=
d found line in M-state.",
+        "UMask": "0x21",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "L3 Lookup write request that access cache and=
 found line in MESI-state",
+        "Counter": "0,1",
+        "EventCode": "0x34",
+        "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_MESI",
+        "PerPkg": "1",
+        "PublicDescription": "L3 Lookup write request that access cache an=
d found line in MESI-state.",
+        "UMask": "0x2f",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a modified line in some proces=
sor core.",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
+        "PerPkg": "1",
+        "PublicDescription": "A cross-core snoop initiated by this Cbox du=
e to processor core memory request which hits a modified line in some proce=
ssor core.",
+        "UMask": "0x48",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which hits a non-modified line in some pr=
ocessor core.",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
+        "PerPkg": "1",
+        "PublicDescription": "A cross-core snoop initiated by this Cbox du=
e to processor core memory request which hits a non-modified line in some p=
rocessor core.",
+        "UMask": "0x44",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "A cross-core snoop resulted from L3 Eviction =
which misses in some processor core.",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
+        "PerPkg": "1",
+        "PublicDescription": "A cross-core snoop resulted from L3 Eviction=
 which misses in some processor core.",
+        "UMask": "0x81",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "A cross-core snoop initiated by this Cbox due=
 to processor core memory request which misses in some processor core.",
+        "Counter": "0,1",
+        "EventCode": "0x22",
+        "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
+        "PerPkg": "1",
+        "PublicDescription": "A cross-core snoop initiated by this Cbox du=
e to processor core memory request which misses in some processor core.",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
new file mode 100644
index 000000000000..73c2261e1e94
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
@@ -0,0 +1,82 @@
+[
+    {
+        "BriefDescription": "Number of entries allocated. Account for Any =
type: e.g. Snoop, Core aperture, etc.",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of entries allocated. Account for Any=
 type: e.g. Snoop, Core aperture, etc.",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of all Core outgoing =
valid entries. Such entry is defined as valid from it's allocation till fir=
st of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-cohe=
rent traffic.",
+        "Counter": "0,",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Each cycle count number of all Core outgoing=
 valid entries. Such entry is defined as valid from it's allocation till fi=
rst of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coh=
erent traffic.",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Cycles with at least one request outstanding =
is waiting for data return from memory controller. Account for coherent and=
 non-coherent requests initiated by IA Cores, Processor Graphics Unit, or L=
LC.;",
+        "Counter": "0,",
+        "CounterMask": "1",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
+        "PerPkg": "1",
+        "PublicDescription": "Cycles with at least one request outstanding=
 is waiting for data return from memory controller. Account for coherent an=
d non-coherent requests initiated by IA Cores, Processor Graphics Unit, or =
LLC.",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries that are in DirectData mode. Such entry is defined as vali=
d when it is allocated till data sent to Core (first chunk, IDI0). Applicab=
le for IA Cores' requests in normal case.",
+        "Counter": "0,",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.DRD_DIRECT",
+        "PerPkg": "1",
+        "PublicDescription": "Each cycle count number of valid coherent Da=
ta Read entries that are in DirectData mode. Such entry is defined as valid=
 when it is allocated till data sent to Core (first chunk, IDI0). Applicabl=
e for IA Cores' requests in normal case.",
+        "UMask": "0x02",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Total number of Core outgoing entries allocat=
ed. Accounts for Coherent and non-coherent traffic.",
+        "Counter": "0,1",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Total number of Core outgoing entries alloca=
ted. Accounts for Coherent and non-coherent traffic.",
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Core coherent Data Read entries all=
ocated in DirectData mode",
+        "Counter": "0,1",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.DRD_DIRECT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Core coherent Data Read entries al=
located in DirectData mode.",
+        "UMask": "0x02",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Writes allocated - any write transa=
ctions: full/partials writes and evictions.",
+        "Counter": "0,1",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Writes allocated - any write trans=
actions: full/partials writes and evictions.",
+        "UMask": "0x20",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
+        "Counter": "FIXED",
+        "EventCode": "0xff",
+        "EventName": "UNC_CLOCK.SOCKET",
+        "PerPkg": "1",
+        "PublicDescription": "This 48-bit fixed counter counts the UCLK cy=
cles.",
+        "Unit": "CLOCK"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/uncore.json b/tools/p=
erf/pmu-events/arch/x86/broadwell/uncore.json
deleted file mode 100644
index 28e1e159a3cb..000000000000
--- a/tools/perf/pmu-events/arch/x86/broadwell/uncore.json
+++ /dev/null
@@ -1,278 +0,0 @@
-[
-  {
-    "Unit": "CBO",
-    "EventCode": "0x22",
-    "UMask": "0x41",
-    "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_XCORE",
-    "BriefDescription": "A cross-core snoop initiated by this Cbox due to =
processor core memory request which misses in some processor core.",
-    "PublicDescription": "A cross-core snoop initiated by this Cbox due to=
 processor core memory request which misses in some processor core.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x22",
-    "UMask": "0x81",
-    "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
-    "BriefDescription": "A cross-core snoop resulted from L3 Eviction whic=
h misses in some processor core.",
-    "PublicDescription": "A cross-core snoop resulted from L3 Eviction whi=
ch misses in some processor core.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x22",
-    "UMask": "0x44",
-    "EventName": "UNC_CBO_XSNP_RESPONSE.HIT_XCORE",
-    "BriefDescription": "A cross-core snoop initiated by this Cbox due to =
processor core memory request which hits a non-modified line in some proces=
sor core.",
-    "PublicDescription": "A cross-core snoop initiated by this Cbox due to=
 processor core memory request which hits a non-modified line in some proce=
ssor core.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x22",
-    "UMask": "0x48",
-    "EventName": "UNC_CBO_XSNP_RESPONSE.HITM_XCORE",
-    "BriefDescription": "A cross-core snoop initiated by this Cbox due to =
processor core memory request which hits a modified line in some processor =
core.",
-    "PublicDescription": "A cross-core snoop initiated by this Cbox due to=
 processor core memory request which hits a modified line in some processor=
 core.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x11",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.READ_M",
-    "BriefDescription": "L3 Lookup read request that access cache and foun=
d line in M-state",
-    "PublicDescription": "L3 Lookup read request that access cache and fou=
nd line in M-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x21",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_M",
-    "BriefDescription": "L3 Lookup write request that access cache and fou=
nd line in M-state",
-    "PublicDescription": "L3 Lookup write request that access cache and fo=
und line in M-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x81",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_M",
-    "BriefDescription": "L3 Lookup any request that access cache and found=
 line in M-state",
-    "PublicDescription": "L3 Lookup any request that access cache and foun=
d line in M-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x18",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.READ_I",
-    "BriefDescription": "L3 Lookup read request that access cache and foun=
d line in I-state",
-    "PublicDescription": "L3 Lookup read request that access cache and fou=
nd line in I-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x88",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_I",
-    "BriefDescription": "L3 Lookup any request that access cache and found=
 line in I-state",
-    "PublicDescription": "L3 Lookup any request that access cache and foun=
d line in I-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x1f",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.READ_MESI",
-    "BriefDescription": "L3 Lookup read request that access cache and foun=
d line in any MESI-state",
-    "PublicDescription": "L3 Lookup read request that access cache and fou=
nd line in any MESI-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x2f",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_MESI",
-    "BriefDescription": "L3 Lookup write request that access cache and fou=
nd line in MESI-state",
-    "PublicDescription": "L3 Lookup write request that access cache and fo=
und line in MESI-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x8f",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_MESI",
-    "BriefDescription": "L3 Lookup any request that access cache and found=
 line in MESI-state",
-    "PublicDescription": "L3 Lookup any request that access cache and foun=
d line in MESI-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x86",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.ANY_ES",
-    "BriefDescription": "L3 Lookup any request that access cache and found=
 line in E or S-state",
-    "PublicDescription": "L3 Lookup any request that access cache and foun=
d line in E or S-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x16",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.READ_ES",
-    "BriefDescription": "L3 Lookup read request that access cache and foun=
d line in E or S-state",
-    "PublicDescription": "L3 Lookup read request that access cache and fou=
nd line in E or S-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "CBO",
-    "EventCode": "0x34",
-    "UMask": "0x26",
-    "EventName": "UNC_CBO_CACHE_LOOKUP.WRITE_ES",
-    "BriefDescription": "L3 Lookup write request that access cache and fou=
nd line in E or S-state",
-    "PublicDescription": "L3 Lookup write request that access cache and fo=
und line in E or S-state.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "iMPH-U",
-    "EventCode": "0x80",
-    "UMask": "0x01",
-    "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
-    "BriefDescription": "Each cycle count number of all Core outgoing vali=
d entries. Such entry is defined as valid from it's allocation till first o=
f IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent=
 traffic.",
-    "PublicDescription": "Each cycle count number of all Core outgoing val=
id entries. Such entry is defined as valid from it's allocation till first =
of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coheren=
t traffic.",
-    "Counter": "0,",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "iMPH-U",
-    "EventCode": "0x80",
-    "UMask": "0x02",
-    "EventName": "UNC_ARB_TRK_OCCUPANCY.DRD_DIRECT",
-    "BriefDescription": "Each cycle count number of 'valid' coherent Data =
Read entries that are in DirectData mode. Such entry is defined as valid wh=
en it is allocated till data sent to Core (first chunk, IDI0). Applicable f=
or IA Cores' requests in normal case.",
-    "PublicDescription": "Each cycle count number of 'valid' coherent Data=
 Read entries that are in DirectData mode. Such entry is defined as valid w=
hen it is allocated till data sent to Core (first chunk, IDI0). Applicable =
for IA Cores' requests in normal case.",
-    "Counter": "0,",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "iMPH-U",
-    "EventCode": "0x81",
-    "UMask": "0x01",
-    "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
-    "BriefDescription": "Total number of Core outgoing entries allocated. =
Accounts for Coherent and non-coherent traffic.",
-    "PublicDescription": "Total number of Core outgoing entries allocated.=
 Accounts for Coherent and non-coherent traffic.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "iMPH-U",
-    "EventCode": "0x81",
-    "UMask": "0x02",
-    "EventName": "UNC_ARB_TRK_REQUESTS.DRD_DIRECT",
-    "BriefDescription": "Number of Core coherent Data Read entries allocat=
ed in DirectData mode",
-    "PublicDescription": "Number of Core coherent Data Read entries alloca=
ted in DirectData mode.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "iMPH-U",
-    "EventCode": "0x81",
-    "UMask": "0x20",
-    "EventName": "UNC_ARB_TRK_REQUESTS.WRITES",
-    "BriefDescription": "Number of Writes allocated - any write transactio=
ns: full/partials writes and evictions.",
-    "PublicDescription": "Number of Writes allocated - any write transacti=
ons: full/partials writes and evictions.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "iMPH-U",
-    "EventCode": "0x84",
-    "UMask": "0x01",
-    "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
-    "BriefDescription": "Number of entries allocated. Account for Any type=
: e.g. Snoop, Core aperture, etc.",
-    "PublicDescription": "Number of entries allocated. Account for Any typ=
e: e.g. Snoop, Core aperture, etc.",
-    "Counter": "0,1",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "iMPH-U",
-    "EventCode": "0x80",
-    "UMask": "0x01",
-    "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
-    "BriefDescription": "Cycles with at least one request outstanding is w=
aiting for data return from memory controller. Account for coherent and non=
-coherent requests initiated by IA Cores, Processor Graphics Unit, or LLC.;=
",
-    "PublicDescription": "Cycles with at least one request outstanding is =
waiting for data return from memory controller. Account for coherent and no=
n-coherent requests initiated by IA Cores, Processor Graphics Unit, or LLC.=
",
-    "Counter": "0,",
-    "CounterMask": "1",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  },
-  {
-    "Unit": "NCU",
-    "EventCode": "0x0",
-    "UMask": "0x01",
-    "EventName": "UNC_CLOCK.SOCKET",
-    "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles"=
,
-    "PublicDescription": "This 48-bit fixed counter counts the UCLK cycles=
.",
-    "Counter": "FIXED",
-    "CounterMask": "0",
-    "Invert": "0",
-    "EdgeDetect": "0"
-  }
-]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
index 818a8b132c08..6a6de8790f25 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
@@ -385,4 +385,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
new file mode 100644
index 000000000000..71bdf75d8016
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
@@ -0,0 +1,1246 @@
+[
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
+        "BriefDescription": "Clocks in the IRP",
+        "Counter": "0,1",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of clocks in the IRP.",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; CLFlush",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; CRd",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.CRD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; DRd",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.DRD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIDCAHin5t",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIRdCur",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; PCIItoM",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.PCITOM",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; RFO",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.RFO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Coherent Ops; WbMtoI",
+        "Counter": "0,1",
+        "EventCode": "0x13",
+        "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Atomic =
Transactions as Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_ATOMIC_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Read Tr=
ansactions as Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_RD_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Cache Inserts of Write T=
ransactions as Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Rejects",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Requests",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Fastpath Transfers From =
Primary to Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.FAST_XFER",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Prefetch Ack Hints From =
Primary to Secondary",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.PF_ACK_HINT",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 0; Prefetch TimeOut",
+        "Counter": "0,1",
+        "EventCode": "0x14",
+        "EventName": "UNC_I_MISC0.PF_TIMEOUT",
+        "PerPkg": "1",
+        "PublicDescription": "Indicates the fetch for a previous prefetch =
wasn't accepted by the prefetch.   This happens in the case of a prefetch T=
imeOut",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Data Throttled",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.DATA_THROTTLE",
+        "PerPkg": "1",
+        "PublicDescription": "IRP throttled switch data",
+        "UMask": "0x80",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Received Invalid",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
+        "PerPkg": "1",
+        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Received Valid",
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_VLD",
+        "PerPkg": "1",
+        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of E Line"=
,
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_E",
+        "PerPkg": "1",
+        "PublicDescription": "Secondary received a transfer that did have =
sufficient MESI state",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of I Line"=
,
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_I",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of M Line"=
,
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_M",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop took cacheline ownership before write =
from data was committed.",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1; Slow Transfer of S Line"=
,
+        "Counter": "0,1",
+        "EventCode": "0x15",
+        "EventName": "UNC_I_MISC1.SLOW_S",
+        "PerPkg": "1",
+        "PublicDescription": "Secondary received a transfer that did not h=
ave sufficient MESI state",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "AK Ingress Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xA",
+        "EventName": "UNC_I_RxR_AK_INSERTS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of allocations into the AK=
 Ingress.  This queue is where the IRP receives responses from R2PCIe (the =
ring).",
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
+        "BriefDescription": "Snoop Responses; Hit E or S",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_ES",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit I",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_I",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Hit M",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.HIT_M",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; Miss",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.MISS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpCode",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPCODE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpData",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPDATA",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Responses; SnpInv",
+        "Counter": "0,1",
+        "EventCode": "0x17",
+        "EventName": "UNC_I_SNOOP_RESP.SNPINV",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Atomic",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.ATOMIC",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of atomic =
transactions",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Select Source",
+        "Counter": "0,1",
+        "EventCode": "0x16",
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
+        "UMask": "0x40",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Other",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.OTHER",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of 'other'=
 kinds of transactions.",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Read Prefetches",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.RD_PREF",
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
+        "EventCode": "0x16",
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
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only write requests. =
 Each write request should have a prefetch, so there is no need to explicit=
ly track these requests.",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound Transaction Count; Write Prefetches",
+        "Counter": "0,1",
+        "EventCode": "0x16",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks the number of write p=
refetches.",
+        "UMask": "0x8",
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
+        "EventCode": "0xE",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCB",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Read Requests",
+        "Counter": "0,1",
+        "EventCode": "0xF",
+        "EventName": "UNC_I_TxR_DATA_INSERTS_NCS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of requests issued to the =
switch (towards the devices).",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Outbound Request Queue Occupancy",
+        "Counter": "0,1",
+        "EventCode": "0xD",
+        "EventName": "UNC_I_TxR_REQUEST_OCCUPANCY",
+        "PerPkg": "1",
+        "PublicDescription": "Accumultes the number of outstanding outboun=
d requests from the IRP to the switch (towards the devices).  This can be u=
sed in conjuection with the allocations event in order to calculate average=
 latency of outbound requests.",
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
+        "BriefDescription": "R2 AD Ring in Use; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xF",
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
+        "UMask": "0xC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
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
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AD Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_R2_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Dn",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RING_AK_BOUNCES.DN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "AK Ingress Bounced; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_R2_RING_AK_BOUNCES.UP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a request de=
stined for the AK ingress bounced.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xF",
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
+        "UMask": "0xC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
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
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 AK Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_R2_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xF",
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
+        "UMask": "0xC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
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
+        "UMask": "0x3",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 BL Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_R2_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
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
ing sunk into the ring stop.",
+        "UMask": "0xF",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Counterclockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.CCW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0xC",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "R2 IV Ring in Use; Clockwise",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_R2_RING_IV_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sent, but does not include when packets are be=
ing sunk into the ring stop.",
+        "UMask": "0x3",
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
+        "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x28",
+        "EventName": "UNC_R2_SBO0_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R2_SBO0_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
+        "EventCode": "0x2A",
+        "EventName": "UNC_R2_SBO0_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO0_BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
+        "Counter": "0,1",
+        "EventCode": "0x2C",
+        "EventName": "UNC_R2_STALL_NO_SBO_CREDIT.SBO1_BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
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
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.DN_AD",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x1",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.DN_AK",
+        "PerPkg": "1",
+        "PublicDescription": "AK CounterClockwise Egress Queue",
+        "UMask": "0x4",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.DN_BL",
+        "PerPkg": "1",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
+        "UMask": "0x2",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; AK CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.UP_AD",
+        "PerPkg": "1",
+        "PublicDescription": "BL CounterClockwise Egress Queue",
+        "UMask": "0x8",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.UP_AK",
+        "PerPkg": "1",
+        "PublicDescription": "AD Clockwise Egress Queue",
+        "UMask": "0x20",
+        "Unit": "R2PCIe"
+    },
+    {
+        "BriefDescription": "Egress CCW NACK; BL CCW",
+        "Counter": "0,1",
+        "EventCode": "0x26",
+        "EventName": "UNC_R2_TxR_NACK_CW.UP_BL",
+        "PerPkg": "1",
+        "PublicDescription": "AD CounterClockwise Egress Queue",
+        "UMask": "0x10",
+        "Unit": "R2PCIe"
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
+        "PublicDescription": "Number outstanding register requests within =
message channel tracker",
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 02d3434aecf3..2cddfedf6abe 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-56,v5,broadwellde,core
-GenuineIntel-6-3D,v17,broadwell,core
-GenuineIntel-6-47,v17,broadwell,core
+GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-1C,v4,bonnell,core
 GenuineIntel-6-26,v4,bonnell,core
--=20
2.37.1.359.gd136c6c3e2-goog

