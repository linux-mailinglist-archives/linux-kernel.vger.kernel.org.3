Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49EF57E9B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiGVWdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiGVWdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:33:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA31AA722A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31dfe25bd47so48857917b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=D7mqAQh8DaT+tb9mSznH4F7+JE5aLjH9UxMFQRXxGYA=;
        b=SKZvIVqBJFRw+pF8miljHEBcSK4N4dHHyITL8CICtkz2cH4hY+ayBJVWXj3ehMrrKP
         63iFoJquCGVwN+gPNQqcIcFw1gxzvCtU0KkYCRKMQDNVCMGeKuLoeLueMVc3AeGJlLWX
         BNsVuATJzBb66HbsNFTKpOnIH+UtljJz0pTuyEm9wphScgKXx1oUIy32hfsJtqGDU6vo
         ChSu4KkMIoAIfcXnBxZmwI6zGnle0wEw/p7gU3guC26RP+b/VZqTgKDvSb4uSstDHDKE
         8egxfMpyhzttnfrarCgdn7ec1DMkaeJISMXiI/fIWam2np9LyWdPipU5xgUNhl1lIStI
         fLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=D7mqAQh8DaT+tb9mSznH4F7+JE5aLjH9UxMFQRXxGYA=;
        b=YZvnPsR8R37vqBA2MrIuMLefQ9T4LniFLHFp7v4NKnCVTo9v61xWdcnKwoZOmC7VH5
         hJpL7nHrdeyi3i+JiOgfzGz2HJlmmJVJaxIl72wMjEgWykWPRPUIyAs9HshSF62Arskx
         Y8G75L0Tv7eUf4LH+/m0Gd/qpVi8KmjcT+WZ4hKlFh4Qfgn1J7Xtxw+LM8OsDGNwkXfK
         97gDt38RRKrfHcmHa1UROohzZh20ijmWX0IebhhqMvC0Hxj6CmsvRdFTAKudhOzN1mnW
         eKNFl6rmAIVi3WV4g9shrQi95yPA2bdFNemF05NDGAJak7O2dvx/wb58UBRym2vM1L4D
         lxiw==
X-Gm-Message-State: AJIora+1OE9N+phYRTdrj5gDZpyvuRfiDvPOoRW/iGDVbVu9KtXnSxXi
        rJMudiPkhCtknnImVUuMpGhtYU6GT4lZ
X-Google-Smtp-Source: AGRyM1tCcdrPVs9ArbHx5rIwt0ssKJr4fvAd38CYEy6uqQywHB0xX437GNdCckAKEx/NDKR1vcG15sMzm01L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:b21e:0:b0:66f:ca45:abbb with SMTP id
 i30-20020a25b21e000000b0066fca45abbbmr1814205ybj.344.1658529181902; Fri, 22
 Jul 2022 15:33:01 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:13 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-5-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 04/31] perf vendor events: Update Intel broadwellde
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
the broadwellde files into perf and update mapfile.csv.

Tested on a non-broadwellde with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellde/bdwde-metrics.json   |  136 +-
 .../arch/x86/broadwellde/cache.json           |    2 +-
 .../arch/x86/broadwellde/floating-point.json  |    2 +-
 .../arch/x86/broadwellde/frontend.json        |    2 +-
 .../arch/x86/broadwellde/memory.json          |    2 +-
 .../arch/x86/broadwellde/other.json           |    2 +-
 .../arch/x86/broadwellde/pipeline.json        |    2 +-
 .../arch/x86/broadwellde/uncore-cache.json    | 3818 ++++++++++++++++-
 .../arch/x86/broadwellde/uncore-memory.json   | 2867 ++++++++++++-
 .../arch/x86/broadwellde/uncore-power.json    |  492 ++-
 .../arch/x86/broadwellde/virtual-memory.json  |    2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 12 files changed, 7062 insertions(+), 267 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json =
b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 73b6865a769d..6789285555f0 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -47,7 +47,7 @@
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.T=
HREAD)",
         "MetricGroup": "TopdownL1",
         "MetricName": "Retiring",
-        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided."
+        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. "
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired. SMT ver=
sion; use when SMT is enabled and measuring per logical CPU.",
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
-        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRE=
D.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THR=
EAD))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_CL=
K_UNHALTED.THREAD)) * (BR_MISP_RETIRED.ALL_BRANCHES * (12 * ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY ) / CPU_CLK_UNHALTED.=
THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.=
ANY )) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_C=
LK_UNHALTED.THREAD)) ) * (4 * CPU_CLK_UNHALTED.THREAD) / BR_MISP_RETIRED.AL=
L_BRANCHES",
-        "MetricGroup": "Bad;BrMispredicts",
-        "MetricName": "Branch_Misprediction_Cost"
-    },
-    {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIRE=
D.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) )))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DE=
LIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.=
ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * (BR_MISP_RETIRED.ALL_=
BRANCHES * (12 * ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BA=
CLEARS.ANY ) / CPU_CLK_UNHALTED.THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES + =
MACHINE_CLEARS.COUNT + BACLEARS.ANY )) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLE=
S_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CL=
K_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) ) * (4 * ( (=
 CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /=
 CPU_CLK_UNHALTED.REF_XCLK ) )) / BR_MISP_RETIRED.ALL_BRANCHES",
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
@@ -204,7 +186,7 @@
         "MetricName": "IpTB"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
+        "BriefDescription": "Branch instructions per taken branch. ",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "BpTkBranch"
@@ -256,42 +238,53 @@
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
-        "MetricExpr": "IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE=
_UOPS + IDQ.MS_UOPS )",
+        "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MIT=
E_UOPS + IDQ.MS_UOPS ) )",
         "MetricGroup": "DSB;Fed;FetchBW",
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json b/tools/=
perf/pmu-events/arch/x86/broadwellde/cache.json
index 0f4de912d099..4b77181b2c53 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/cache.json
@@ -806,4 +806,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
index fdf5dc40b835..46cf18490140 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
@@ -190,4 +190,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json b/too=
ls/perf/pmu-events/arch/x86/broadwellde/frontend.json
index f0bcb945ff76..37ce8034b2ed 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
@@ -292,4 +292,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json b/tools=
/perf/pmu-events/arch/x86/broadwellde/memory.json
index 604059e7eb58..a3a5cc6dab42 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/memory.json
@@ -429,4 +429,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/other.json b/tools/=
perf/pmu-events/arch/x86/broadwellde/other.json
index 4b360fe96698..917d145d5227 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/other.json
@@ -41,4 +41,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index 7580b8af0d13..85654037b768 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
@@ -1378,4 +1378,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index 58ed6d33d1f4..caadbca1b15b 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -1,316 +1,3826 @@
 [
     {
-        "BriefDescription": "Uncore cache clock ticks",
+        "BriefDescription": "Bounce Control",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_C_BOUNCE_CONTROL",
+        "PerPkg": "1",
+        "Unit": "CBO"
+    },
+    {
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
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
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
+        "BriefDescription": "FaST wire asserted",
+        "Counter": "0,1",
+        "EventCode": "0x9",
+        "EventName": "UNC_C_FAST_ASSERTED",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles either the local=
 distress or incoming distress signals are asserted.  Incoming distress inc=
ludes both up and dn.",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Any Request",
         "Counter": "0,1,2,3",
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
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for any transaction originati=
ng from the IPQ or IRQ.  This does not include lookups originating from the=
 ISMQ.",
         "UMask": "0x11",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "M line evictions from LLC (writebacks to memo=
ry)",
+        "BriefDescription": "Cache Lookups; Data Read Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
+        "Filter": "CBoFilter0[23:17]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Lookups that Match NID",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.NID",
+        "Filter": "CBoFilter0[23:17]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Qualify one of the other subevents by=
 the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.nid.   In=
 conjunction with STATE =3D I, it is possible to monitor misses to specific=
 NIDs in the system.",
+        "UMask": "0x41",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Any Read Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.READ",
+        "Filter": "CBoFilter0[22:18]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
+        "UMask": "0x21",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; External Snoop Request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
+        "Filter": "CBoFilter0[23:17]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for only snoop requests comin=
g from the remote socket(s) through the IPQ.",
+        "UMask": "0x9",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Cache Lookups; Write Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
+        "Filter": "CBoFilter0[23:17]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Writeback transactions from L2 to the=
 LLC  This includes all write transactions -- both Cachable and UC.",
+        "UMask": "0x5",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in E state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Lines Victimized",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.F_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.I_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Lines Victimized",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.MISS",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Lines Victimized; Lines in M state",
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses - demand and prefetch data reads -=
 excludes LLC prefetches. Derived from unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.DATA_READ",
-        "Filter": "filter_opc=3D0x182",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.NID",
+        "Filter": "CBoFilter1[17:10]",
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
-        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) . D=
erived from unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Cbo Misc; DRd hitting non-M with raw CV=3D0",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.UNCACHEABLE",
-        "Filter": "filter_opc=3D0x187",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.CVZERO_PREFETCH_MISS",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Miscellaneous events in the Cbo.",
+        "UMask": "0x20",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "MMIO reads. Derived from unc_c_tor_inserts.mi=
ss_opcode",
+        "BriefDescription": "Cbo Misc; Clean Victim with raw CV=3D0",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_READ",
-        "Filter": "filter_opc=3D0x187,filter_nc=3D1",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.CVZERO_PREFETCH_VICTIM",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Miscellaneous events in the Cbo.",
+        "UMask": "0x10",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "MMIO writes. Derived from unc_c_tor_inserts.m=
iss_opcode",
+        "BriefDescription": "Cbo Misc; RFO HitS",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.MMIO_WRITE",
-        "Filter": "filter_opc=3D0x18f,filter_nc=3D1",
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
-        "BriefDescription": "LLC prefetch misses for RFO. Derived from unc=
_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Cbo Misc; Silent Snoop Eviction",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.RFO_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x190",
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
-        "BriefDescription": "LLC prefetch misses for code reads. Derived f=
rom unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Cbo Misc",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.CODE_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x191",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.STARTED",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Miscellaneous events in the Cbo.",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC prefetch misses for data reads. Derived f=
rom unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "Cbo Misc; Write Combining Aliasing",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.DATA_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x192",
+        "EventCode": "0x39",
+        "EventName": "UNC_C_MISC.WC_ALIASING",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "Miscellaneous events in the Cbo.; Counts the=
 number of times that a USWC write (WCIL(F)) transaction hit in the LLC in =
M state, triggering a WBMtoI followed by the USWC write.  This occurs when =
there is WC aliasing.",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "LLC misses for PCIe read current. Derived fro=
m unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "LRU Queue; LRU Age 0",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_READ",
-        "Filter": "filter_opc=3D0x19e",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.AGE0",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "How often age was set to 0",
+        "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "ItoM write misses (as part of fast string mem=
cpy stores) + PCIe full line writes. Derived from unc_c_tor_inserts.miss_op=
code",
+        "BriefDescription": "LRU Queue; LRU Age 1",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_WRITE",
-        "Filter": "filter_opc=3D0x1c8",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.AGE1",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x3",
+        "PublicDescription": "How often age was set to 1",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe write misses (full cache line). Derived =
from unc_c_tor_inserts.miss_opcode",
+        "BriefDescription": "LRU Queue; LRU Age 2",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_MISSES.PCIE_NON_SNOOP_WRITE",
-        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.AGE2",
+        "PerPkg": "1",
+        "PublicDescription": "How often age was set to 2",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LRU Queue; LRU Age 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.AGE3",
+        "PerPkg": "1",
+        "PublicDescription": "How often age was set to 3",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LRU Queue; LRU Bits Decremented",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.LRU_DECREMENT",
+        "PerPkg": "1",
+        "PublicDescription": "How often all LRU bits were decremented by 1=
",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "LRU Queue; Non-0 Aged Victim",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_C_QLRU.VICTIM_NON_ZERO",
+        "PerPkg": "1",
+        "PublicDescription": "How often we picked a victim that had a non-=
zero age",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
+        "UMask": "0xF",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD Ring In Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.CCW",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
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
+        "BriefDescription": "AD Ring In Use; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.",
         "UMask": "0x3",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe writes (partial cache line). Derived fro=
m unc_c_tor_inserts.opcode",
+        "BriefDescription": "AD Ring In Use; Down and Even",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_NS_PARTIAL_WRITE",
-        "Filter": "filter_opc=3D0x180,filter_tid=3D0x3e",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_EVEN",
         "PerPkg": "1",
-        "UMask": "0x1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Even ring polarity.",
+        "UMask": "0x4",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "L2 demand and L2 prefetch code references to =
LLC. Derived from unc_c_tor_inserts.opcode",
+        "BriefDescription": "AD Ring In Use; Down and Odd",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.CODE_LLC_PREFETCH",
-        "Filter": "filter_opc=3D0x181",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.DOWN_ODD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Down and Odd ring polarity.",
+        "UMask": "0x8",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Streaming stores (full cache line). Derived f=
rom unc_c_tor_inserts.opcode",
+        "BriefDescription": "AD Ring In Use; Up and Even",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_FULL",
-        "Filter": "filter_opc=3D0x18c",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.UP_EVEN",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Streaming stores (partial cache line). Derive=
d from unc_c_tor_inserts.opcode",
+        "BriefDescription": "AD Ring In Use; Up and Odd",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.STREAMING_PARTIAL",
-        "Filter": "filter_opc=3D0x18d",
+        "EventCode": "0x1B",
+        "EventName": "UNC_C_RING_AD_USED.UP_ODD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  We really have two rings in BDX -- a clockwis=
e ring and a counter-clockwise ring.  On the left side of the ring, the UP =
direction is on the clockwise ring and DN is on the counter-clockwise ring.=
  On the right side of the ring, this is reversed.  The first half of the C=
Bos are on the left side of the ring, and the 2nd half are on the right sid=
e of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is =
NOT the same ring as CBo 2 UP AD because they are on opposite sides of the =
ring.; Filters for the Up and Odd ring polarity.",
+        "UMask": "0x2",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe read current. Derived from unc_c_tor_ins=
erts.opcode",
+        "BriefDescription": "AK Ring In Use; All",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_READ",
-        "Filter": "filter_opc=3D0x19e",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.ALL",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
+        "UMask": "0xF",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "PCIe write references (full cache line). Deri=
ved from unc_c_tor_inserts.opcode",
+        "BriefDescription": "AK Ring In Use; Down",
         "Counter": "0,1,2,3",
-        "EventCode": "0x35",
-        "EventName": "LLC_REFERENCES.PCIE_WRITE",
-        "Filter": "filter_opc=3D0x1c8,filter_tid=3D0x3e",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.CCW",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
+        "UMask": "0xC",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "Occupancy counter for LLC data reads (demand =
and L2 prefetch). Derived from unc_c_tor_occupancy.miss_opcode",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.LLC_DATA_READ",
-        "Filter": "filter_opc=3D0x182",
+        "BriefDescription": "AK Ring In Use; Up",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.CW",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
         "UMask": "0x3",
         "Unit": "CBO"
     },
     {
-        "BriefDescription": "read requests to home agent",
+        "BriefDescription": "AK Ring In Use; Down and Even",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.READS",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_EVEN",
         "PerPkg": "1",
-        "UMask": "0x3",
-        "Unit": "HA"
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity.",
+        "UMask": "0x4",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "read requests to local home agent",
+        "BriefDescription": "AK Ring In Use; Down and Odd",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.READS_LOCAL",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.DOWN_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity.",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK Ring In Use; Up and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.UP_EVEN",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity.",
         "UMask": "0x1",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "read requests to remote home agent",
+        "BriefDescription": "AK Ring In Use; Up and Odd",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.READS_REMOTE",
+        "EventCode": "0x1C",
+        "EventName": "UNC_C_RING_AK_USED.UP_ODD",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity.",
         "UMask": "0x2",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "write requests to home agent",
+        "BriefDescription": "BL Ring in Use; Down",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.WRITES",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.",
+        "UMask": "0xF",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.CCW",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
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
-        "BriefDescription": "write requests to local home agent",
+        "BriefDescription": "BL Ring in Use; Up",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.CW",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
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
+        "BriefDescription": "BL Ring in Use; Down and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_EVEN",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Even ring polarity.",
         "UMask": "0x4",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "write requests to remote home agent",
+        "BriefDescription": "BL Ring in Use; Down and Odd",
         "Counter": "0,1,2,3",
-        "EventCode": "0x1",
-        "EventName": "UNC_H_REQUESTS.WRITES_REMOTE",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.DOWN_ODD",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Down and Odd ring polarity.",
         "UMask": "0x8",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "Conflict requests (requests for same address =
from multiple agents simultaneously)",
+        "BriefDescription": "BL Ring in Use; Up and Even",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.UP_EVEN",
         "PerPkg": "1",
-        "UMask": "0x40",
-        "Unit": "HA"
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Even ring polarity.",
+        "UMask": "0x1",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "M line forwarded from remote cache along with=
 writeback to memory",
+        "BriefDescription": "BL Ring in Use; Up and Odd",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
+        "EventCode": "0x1D",
+        "EventName": "UNC_C_RING_BL_USED.UP_ODD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x20",
-        "Unit": "HA"
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.We really have two rings in BDX -- a clockwise =
ring and a counter-clockwise ring.  On the left side of the ring, the UP di=
rection is on the clockwise ring and DN is on the counter-clockwise ring.  =
On the right side of the ring, this is reversed.  The first half of the CBo=
s are on the left side of the ring, and the 2nd half are on the right side =
of the ring.  In other words (for example), in a 4c part, Cbo 0 UP AD is NO=
T the same ring as CBo 2 UP AD because they are on opposite sides of the ri=
ng.; Filters for the Up and Odd ring polarity.",
+        "UMask": "0x2",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "M line forwarded from remote cache with no wr=
iteback to memory",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AD",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.AD",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
-        "UMask": "0x4",
-        "Unit": "HA"
+        "UMask": "0x1",
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "Shared line response from remote cache",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; AK",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPS",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.AK",
         "PerPkg": "1",
-        "ScaleUnit": "64Bytes",
         "UMask": "0x2",
-        "Unit": "HA"
+        "Unit": "CBO"
     },
     {
-        "BriefDescription": "Shared line forwarded from remote cache",
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; BL",
         "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of LLC responses that bounced on the R=
ing.; Snoops of processor's cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_C_RING_BOUNCES.IV",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_C_RING_IV_USED.ANY",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
+        "UMask": "0xF",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_C_RING_IV_USED.DN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
+        "UMask": "0xC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Down",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_C_RING_IV_USED.DOWN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters for Down polarity",
+        "UMask": "0xCC",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL Ring in Use; Any",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_C_RING_IV_USED.UP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the IV ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.  There is only 1 IV ring in BDX  Therefore, if=
 one wants to monitor the Even ring, they should select both UP_EVEN and DN=
_EVEN.  To monitor the Odd ring, they should select both UP_ODD and DN_ODD.=
; Filters any polarity",
+        "UMask": "0x3",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "AK",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "BL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "IV",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6",
+        "EventName": "UNC_C_RING_SINK_STARVED.IV",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Number of cycles the Cbo is actively throttli=
ng traffic onto the Ring in order to limit bounce traffic.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x7",
+        "EventName": "UNC_C_RING_SRC_THRTL",
+        "PerPkg": "1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; IRQ",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "BriefDescription": "Ingress Arbiter Blocking Cycles; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_C_RxR_EXT_STARVED.PRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; IPQ",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.IRQ_REJ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.PRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Allocations; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_C_RxR_INSERTS.PRQ_REJ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of allocations per cycle into =
the specified Ingress queue.",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Internal Starvation Cycles; IPQ",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "BriefDescription": "Ingress Internal Starvation Cycles; PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x14",
+        "EventName": "UNC_C_RxR_INT_STARVED.PRQ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles in internal starvation.  This =
occurs when one (or more) of the entries in the ingress queue are being sta=
rved out by other entries in that queue.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; Address Conflict",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_C_RxR_IPQ_RETRY.QPI_CREDITS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.",
+        "UMask": "0x10",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; No AD Sbo Credits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_C_RxR_IPQ_RETRY2.AD_SBO",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request from the IPQ was retried because of it =
lacked credits to send an AD packet to the Sbo.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Probe Queue Retries; Target Node Filter",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_C_RxR_IPQ_RETRY2.TARGET",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request from the IPQ was retried filtered by th=
e Target NodeID as specified in the Cbox's Filter register.",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "BriefDescription": "Ingress Request Queue Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_C_RxR_IRQ_RETRY.NID",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Qualify one of the other subevents by a give=
n RTID destination NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER1.n=
id.",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "BriefDescription": "Ingress Request Queue Rejects; No AD Sbo Cred=
its",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_C_RxR_IRQ_RETRY2.AD_SBO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried because of it lacked credits to send an AD packet to=
 the Sbo.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; No BL Sbo Cred=
its",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_C_RxR_IRQ_RETRY2.BL_SBO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried because of it lacked credits to send an BL packet to=
 the Sbo.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Ingress Request Queue Rejects; Target Node Fi=
lter",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_C_RxR_IRQ_RETRY2.TARGET",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried filtered by the Target NodeID as specified in the Cb=
ox's Filter register.",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; Any Reject",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.NID",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
+        "UMask": "0x40",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Retries; No QPI Credits",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "BriefDescription": "ISMQ Retries",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY.WB_CREDITS",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
+        "UMask": "0x80",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Request Queue Rejects; No AD Sbo Credits=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY2.AD_SBO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried because of it lacked credits to send an AD packet t=
o the Sbo.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Request Queue Rejects; No BL Sbo Credits=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY2.BL_SBO",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried because of it lacked credits to send an BL packet t=
o the Sbo.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "ISMQ Request Queue Rejects; Target Node Filte=
r",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_C_RxR_ISMQ_RETRY2.TARGET",
+        "Filter": "CBoFilter1[15:0]",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried filtered by the Target NodeID as specified in the C=
box's Filter register.",
+        "UMask": "0x40",
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
+        "BriefDescription": "Ingress Occupancy; PRQ Rejects",
+        "EventCode": "0x11",
+        "EventName": "UNC_C_RxR_OCCUPANCY.PRQ_REJ",
+        "PerPkg": "1",
+        "PublicDescription": "Counts number of entries in the specified In=
gress queue in each cycle.",
+        "UMask": "0x20",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "SBo Credits Acquired; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3D",
+        "EventName": "UNC_C_SBO_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo credits acquired in a given cy=
cle, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "SBo Credits Acquired; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3D",
+        "EventName": "UNC_C_SBO_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo credits acquired in a given cy=
cle, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "SBo Credits Occupancy; For AD Ring",
+        "EventCode": "0x3E",
+        "EventName": "UNC_C_SBO_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo credits in use in a given cycl=
e, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "SBo Credits Occupancy; For BL Ring",
+        "EventCode": "0x3E",
+        "EventName": "UNC_C_SBO_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo credits in use in a given cycl=
e, per ring.  Each Cbo is assigned an Sbo it can communicate with.",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "TOR Inserts; All",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED.AD",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Onto AK Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED.AK",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Onto BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_C_TxR_ADS_USED.BL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Egress Allocations; AD - Cachebo",
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "Counter": "0,1,2,3",
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
+        "BriefDescription": "Injection Starvation; Onto BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_C_TxR_STARVED.BL_BOTH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.; cycles that both BL egresses spent in starvation",
+        "UMask": "0x4",
+        "Unit": "CBO"
+    },
+    {
+        "BriefDescription": "Injection Starvation; Onto IV Ring",
+        "Counter": "0,1,2,3",
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
+        "BriefDescription": "Directory Lookups; Snoop Not Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
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
+        "BriefDescription": "Directory Lookups; Snoop Needed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC",
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
+        "BriefDescription": "Directory Updates; Any Directory Update",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xD",
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
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is A=
ckCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.ACKCNFLTWBI",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; All Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xFF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; Allocat=
ions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.ALLOCS",
+        "PerPkg": "1",
+        "UMask": "0x70",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; Allocat=
ions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.EVICTS",
+        "PerPkg": "1",
+        "UMask": "0x42",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; HOM Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.HOM",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; Invalid=
ations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.INVALS",
+        "PerPkg": "1",
+        "UMask": "0x26",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
dCode, RdData, RdDataMigratory, RdInvOwn, RdCur or InvItoE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.READ_OR_INVITOE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
spI, RspIWb, RspS, RspSWb, RspCnflt or RspCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.RSP",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
spIFwd or RspIFwdWb for a local request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.RSPFWDI_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
spIFwd or RspIFwdWb for a remote request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.RSPFWDI_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is R=
sSFwd or RspSFwdWb",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.RSPFWDS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is W=
bMtoE or WbMtoS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.WBMTOE_OR_S",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of Hits in HitMe Cache; op is W=
bMtoI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_H_HITME_HIT.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is AckCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.ACKCNFLTWBI",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; All Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.ALL",
+        "PerPkg": "1",
+        "UMask": "0xFF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; HOM Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.HOM",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RdCode, RdData, RdDataMigratory, RdInvOwn, RdCur or InvItoE=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.READ_OR_INVITOE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RspI, RspIWb, RspS, RspSWb, RspCnflt or RspCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSP",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RspIFwd or RspIFwdWb for a local request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RspIFwd or RspIFwdWb for a remote request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDI_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is RsSFwd or RspSFwdWb",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.RSPFWDS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is WbMtoE or WbMtoS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOE_OR_S",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Accumulates Number of PV bits set on HitMe Ca=
che Hits; op is WbMtoI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x72",
+        "EventName": "UNC_H_HITME_HIT_PV_BITS_SET.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is AckCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.ACKCNFLTWBI",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; All Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.ALL",
+        "PerPkg": "1",
+        "UMask": "0xFF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.ALLOCS",
+        "PerPkg": "1",
+        "UMask": "0x70",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; HOM Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.HOM",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; Invalidations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.INVALS",
+        "PerPkg": "1",
+        "UMask": "0x26",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RdCode, RdData, RdDataMigratory, RdInvOwn, RdCur or InvItoE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.READ_OR_INVITOE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RspI, RspIWb, RspS, RspSWb, RspCnflt or RspCnfltWbI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.RSP",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RspIFwd or RspIFwdWb for a local request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.RSPFWDI_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RspIFwd or RspIFwdWb for a remote request",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.RSPFWDI_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is RsSFwd or RspSFwdWb",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.RSPFWDS",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is WbMtoE or WbMtoS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.WBMTOE_OR_S",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Counts Number of times HitMe Cache is accesse=
d; op is WbMtoI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_H_HITME_LOOKUP.WBMTOI",
+        "PerPkg": "1",
+        "UMask": "0x2",
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
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.AD_QPI2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x10",
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
+        "BriefDescription": "Cycles without QPI Ingress Credits; BL to QPI=
 Link 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_H_IGR_NO_CREDIT_CYCLES.BL_QPI2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the HA does=
 not have credits to send messages to the QPI Agent.  This can be filtered =
by the different credit pools and the different links.",
+        "UMask": "0x20",
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
+        "EventCode": "0x1E",
+        "EventName": "UNC_H_IMC_RETRY",
+        "PerPkg": "1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA to iMC Full Line Writes Issued; All Writes=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
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
+        "EventCode": "0x1A",
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
+        "EventCode": "0x1A",
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
+        "EventCode": "0x1A",
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
+        "EventCode": "0x1A",
+        "EventName": "UNC_H_IMC_WRITES.PARTIAL_ISOCH",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the total number of full line writes =
issued from the HA into the memory controller.  This counts for all four ch=
annels.  It can be filtered by full/partial and ISOCH/non-ISOCH.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Backpressure",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_H_IOT_BACKPRESSURE.HUB",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Backpressure",
+        "Counter": "0,1,2",
+        "EventCode": "0x61",
+        "EventName": "UNC_H_IOT_BACKPRESSURE.SAT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0x64",
+        "EventName": "UNC_H_IOT_CTS_EAST_LO.CTS0",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0x64",
+        "EventName": "UNC_H_IOT_CTS_EAST_LO.CTS1",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
+        "Counter": "0,1,2",
+        "EventCode": "0x65",
+        "EventName": "UNC_H_IOT_CTS_HI.CTS2",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Hi",
+        "Counter": "0,1,2",
+        "EventCode": "0x65",
+        "EventName": "UNC_H_IOT_CTS_HI.CTS3",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0x62",
+        "EventName": "UNC_H_IOT_CTS_WEST_LO.CTS0",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "IOT Common Trigger Sequencer - Lo",
+        "Counter": "0,1,2",
+        "EventCode": "0x62",
+        "EventName": "UNC_H_IOT_CTS_WEST_LO.CTS1",
+        "PerPkg": "1",
+        "PublicDescription": "Debug Mask/Match Tie-Ins",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast; Cancelled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.CANCELLED",
+        "PerPkg": "1",
+        "PublicDescription": "Count of OSB snoop broadcasts. Counts by 1 p=
er request causing OSB snoops to be broadcast. Does not count all the snoop=
s generated by OSB.; OSB Snoop broadcast cancelled due to D2C or Other. OSB=
 cancel is counted when OSB local read is not allowed even when the transac=
tion in local InItoE. It also counts D2C OSB cancel, but also includes the =
cases were D2C was not set in the first place for the transaction coming fr=
om the ring.",
+        "UMask": "0x10",
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
+        "BriefDescription": "OSB Snoop Broadcast; Reads Local -  Useful",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.READS_LOCAL_USEFUL",
+        "PerPkg": "1",
+        "PublicDescription": "Count of OSB snoop broadcasts. Counts by 1 p=
er request causing OSB snoops to be broadcast. Does not count all the snoop=
s generated by OSB.",
+        "UMask": "0x20",
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
+        "BriefDescription": "OSB Snoop Broadcast; Remote - Useful",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_OSB.REMOTE_USEFUL",
+        "PerPkg": "1",
+        "PublicDescription": "Count of OSB snoop broadcasts. Counts by 1 p=
er request causing OSB snoops to be broadcast. Does not count all the snoop=
s generated by OSB.",
+        "UMask": "0x40",
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
+        "UMask": "0xC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
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
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AD Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_H_RING_AD_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AD ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xF",
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
+        "UMask": "0xC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
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
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA AK Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_H_RING_AK_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the AK ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; All",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.",
+        "UMask": "0xF",
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
+        "UMask": "0xC",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise and Even"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Even rin=
g polarity.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Counterclockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CCW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Counterclockwise and Odd ring=
 polarity.",
+        "UMask": "0x8",
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
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Even",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_EVEN",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Even ring polar=
ity.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA BL Ring in Use; Clockwise and Odd",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_H_RING_BL_USED.CW_ODD",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the BL ring=
 is being used at this ring stop.  This includes when packets are passing b=
y and when packets are being sunk, but does not include when packets are be=
ing sent from the ring stop.; Filters for the Clockwise and Odd ring polari=
ty.",
+        "UMask": "0x2",
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
+        "BriefDescription": "SBo0 Credits Acquired; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x68",
+        "EventName": "UNC_H_SBO0_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Acquired; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x68",
+        "EventName": "UNC_H_SBO0_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6A",
+        "EventName": "UNC_H_SBO0_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo0 Credits Occupancy; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6A",
+        "EventName": "UNC_H_SBO0_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 0 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Acquired; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_H_SBO1_CREDITS_ACQUIRED.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 1 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Acquired; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_H_SBO1_CREDITS_ACQUIRED.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 1 credits acquired in a given =
cycle, per ring.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Occupancy; For AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6B",
+        "EventName": "UNC_H_SBO1_CREDIT_OCCUPANCY.AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 1 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "SBo1 Credits Occupancy; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6B",
+        "EventName": "UNC_H_SBO1_CREDIT_OCCUPANCY.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Sbo 1 credits in use in a given cy=
cle, per ring.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Data beat the Snoop Responses; Local Requests=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_H_SNOOPS_RSP_AFTER_DATA.LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of reads when the snoop wa=
s on the critical path to the data return.; This filter includes only reque=
sts coming from the local socket.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Data beat the Snoop Responses; Remote Request=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA",
+        "EventName": "UNC_H_SNOOPS_RSP_AFTER_DATA.REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of reads when the snoop wa=
s on the critical path to the data return.; This filter includes only reque=
sts coming from remote sockets.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles with Snoops Outstanding; All Requests"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_H_SNOOP_CYCLES_NE.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles when one or more snoops are ou=
tstanding.; Tracked for snoops from both local and remote sockets.",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles with Snoops Outstanding; Local Request=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_H_SNOOP_CYCLES_NE.LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles when one or more snoops are ou=
tstanding.; This filter includes only requests coming from the local socket=
.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Cycles with Snoops Outstanding; Remote Reques=
ts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8",
+        "EventName": "UNC_H_SNOOP_CYCLES_NE.REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Counts cycles when one or more snoops are ou=
tstanding.; This filter includes only requests coming from remote sockets."=
,
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Snoops Outstanding Accumulator; Local=
 Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_H_SNOOP_OCCUPANCY.LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of either the loca=
l HA tracker pool that have snoops pending in every cycle.    This can be u=
sed in conjection with the not empty stat to calculate average queue occupa=
ncy or the allocations stat in order to calculate average queue latency.  H=
A trackers are allocated as soon as a request enters the HA if an HT (HomeT=
racker) entry is available and this occupancy is decremented when all the s=
noop responses have returned.; This filter includes only requests coming fr=
om the local socket.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Snoops Outstanding Accumulator; Remot=
e Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x9",
+        "EventName": "UNC_H_SNOOP_OCCUPANCY.REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of either the loca=
l HA tracker pool that have snoops pending in every cycle.    This can be u=
sed in conjection with the not empty stat to calculate average queue occupa=
ncy or the allocations stat in order to calculate average queue latency.  H=
A trackers are allocated as soon as a request enters the HA if an HT (HomeT=
racker) entry is available and this occupancy is decremented when all the s=
noop responses have returned.; This filter includes only requests coming fr=
om remote sockets.",
+        "UMask": "0x2",
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
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6C",
+        "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO0_AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo0, BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6C",
+        "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO0_BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, AD Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6C",
+        "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO1_AD",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Stall on No Sbo Credits; For SBo1, BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6C",
+        "EventName": "UNC_H_STALL_NO_SBO_CREDIT.SBO1_BL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles Egress is stalled waiting f=
or an Sbo credit to become available.  Per Sbo, per Ring.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "HA Requests to a TAD Region - Group 0; TAD Re=
gion 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
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
+        "EventCode": "0x1B",
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
+        "EventCode": "0x1B",
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
+        "EventCode": "0x1B",
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
+        "EventCode": "0x1B",
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
+        "EventCode": "0x1B",
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
+        "EventCode": "0x1B",
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
+        "EventCode": "0x1B",
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
+        "EventCode": "0x1C",
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
+        "EventCode": "0x1C",
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
+        "EventCode": "0x1C",
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
+        "EventCode": "0x1C",
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
+        "BriefDescription": "Tracker Cycles Full; Cycles Completely Used",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_H_TRACKER_CYCLES_FULL.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is completely used.  This can be used with edge detect to id=
entify the number of situations when the pool became fully utilized.  This =
should not be confused with RTID credit usage -- which must be tracked insi=
de each cbo individually -- but represents the actual tracker buffer struct=
ure.  In other words, the system could be starved for RTIDs but not fill up=
 the HA trackers.  HA trackers are allocated as soon as a request enters th=
e HA and is released after the snoop response and data return (or post in t=
he case of a write) and the response is returned on the ring.; Counts the n=
umber of cycles when the HA tracker pool (HT) is completely used including =
reserved HT entries.  It will not return valid count when BT is disabled.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Full; Cycles GP Completely Use=
d",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_H_TRACKER_CYCLES_FULL.GP",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is completely used.  This can be used with edge detect to id=
entify the number of situations when the pool became fully utilized.  This =
should not be confused with RTID credit usage -- which must be tracked insi=
de each cbo individually -- but represents the actual tracker buffer struct=
ure.  In other words, the system could be starved for RTIDs but not fill up=
 the HA trackers.  HA trackers are allocated as soon as a request enters th=
e HA and is released after the snoop response and data return (or post in t=
he case of a write) and the response is returned on the ring.; Counts the n=
umber of cycles when the general purpose (GP) HA tracker pool (HT) is compl=
etely used.  It will not return valid count when BT is disabled.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty; All Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_H_TRACKER_CYCLES_NE.ALL",
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
ing.; Requests coming from both local and remote sockets.",
+        "UMask": "0x3",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty; Local Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_H_TRACKER_CYCLES_NE.LOCAL",
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
ing.; This filter includes only requests coming from the local socket.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Cycles Not Empty; Remote Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3",
+        "EventName": "UNC_H_TRACKER_CYCLES_NE.REMOTE",
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
ing.; This filter includes only requests coming from remote sockets.",
+        "UMask": "0x2",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Local InvItoE R=
equests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the local HA tr=
acker pool in every cycle.  This can be used in conjection with the not emp=
ty stat to calculate average queue occupancy or the allocations stat in ord=
er to calculate average queue latency.  HA trackers are allocated as soon a=
s a request enters the HA if a HT (Home Tracker) entry is available and is =
released after the snoop response and data return (or post in the case of a=
 write) and the response is returned on the ring.",
+        "UMask": "0x40",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Remote InvItoE =
Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.INVITOE_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the local HA tr=
acker pool in every cycle.  This can be used in conjection with the not emp=
ty stat to calculate average queue occupancy or the allocations stat in ord=
er to calculate average queue latency.  HA trackers are allocated as soon a=
s a request enters the HA if a HT (Home Tracker) entry is available and is =
released after the snoop response and data return (or post in the case of a=
 write) and the response is returned on the ring.",
+        "UMask": "0x80",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Local Read Requ=
ests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the local HA tr=
acker pool in every cycle.  This can be used in conjection with the not emp=
ty stat to calculate average queue occupancy or the allocations stat in ord=
er to calculate average queue latency.  HA trackers are allocated as soon a=
s a request enters the HA if a HT (Home Tracker) entry is available and is =
released after the snoop response and data return (or post in the case of a=
 write) and the response is returned on the ring.",
+        "UMask": "0x4",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Remote Read Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.READS_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the local HA tr=
acker pool in every cycle.  This can be used in conjection with the not emp=
ty stat to calculate average queue occupancy or the allocations stat in ord=
er to calculate average queue latency.  HA trackers are allocated as soon a=
s a request enters the HA if a HT (Home Tracker) entry is available and is =
released after the snoop response and data return (or post in the case of a=
 write) and the response is returned on the ring.",
+        "UMask": "0x8",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Local Write Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the local HA tr=
acker pool in every cycle.  This can be used in conjection with the not emp=
ty stat to calculate average queue occupancy or the allocations stat in ord=
er to calculate average queue latency.  HA trackers are allocated as soon a=
s a request enters the HA if a HT (Home Tracker) entry is available and is =
released after the snoop response and data return (or post in the case of a=
 write) and the response is returned on the ring.",
+        "UMask": "0x10",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy Accumultor; Remote Write Re=
quests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_H_TRACKER_OCCUPANCY.WRITES_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the occupancy of the local HA tr=
acker pool in every cycle.  This can be used in conjection with the not emp=
ty stat to calculate average queue occupancy or the allocations stat in ord=
er to calculate average queue latency.  HA trackers are allocated as soon a=
s a request enters the HA if a HT (Home Tracker) entry is available and is =
released after the snoop response and data return (or post in the case of a=
 write) and the response is returned on the ring.",
+        "UMask": "0x20",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Data Pending Occupancy Accumultor; Local Requ=
ests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of transactions that =
have data from the memory controller until they get scheduled to the Egress=
.  This can be used to calculate the queuing latency for two things.  (1) I=
f the system is waiting for snoops, this will increase.  (2) If the system =
can't schedule to the Egress because of either (a) Egress Credits or (b) QP=
I BL IGR credits for remote requests.; This filter includes only requests c=
oming from the local socket.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Data Pending Occupancy Accumultor; Remote Req=
uests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5",
+        "EventName": "UNC_H_TRACKER_PENDING_OCCUPANCY.REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "Accumulates the number of transactions that =
have data from the memory controller until they get scheduled to the Egress=
.  This can be used to calculate the queuing latency for two things.  (1) I=
f the system is waiting for snoops, this will increase.  (2) If the system =
can't schedule to the Egress because of either (a) Egress Credits or (b) QP=
I BL IGR credits for remote requests.; This filter includes only requests c=
oming from remote sockets.",
+        "UMask": "0x2",
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
+        "EventCode": "0x2A",
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
+        "EventCode": "0x2A",
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
+        "EventCode": "0x2A",
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
+        "EventCode": "0x2F",
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
+        "EventCode": "0x2F",
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
+        "EventCode": "0x2F",
+        "EventName": "UNC_H_TxR_AK_INSERTS.SCHED1",
+        "PerPkg": "1",
+        "PublicDescription": "AK Egress Allocations; Filter for allocation=
s from scheduler bank 1",
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
+        "BriefDescription": "Injection Starvation; For AK Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6D",
+        "EventName": "UNC_H_TxR_STARVED.AK",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
+        "UMask": "0x1",
+        "Unit": "HA"
+    },
+    {
+        "BriefDescription": "Injection Starvation; For BL Ring",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6D",
+        "EventName": "UNC_H_TxR_STARVED.BL",
+        "PerPkg": "1",
+        "PublicDescription": "Counts injection starvation.  This starvatio=
n is triggered when the Egress cannot send a transaction onto the ring for =
a long period of time.",
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
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json =
b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
index f4b0745cdbbf..83ff0542dbc0 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
@@ -1,86 +1,2915 @@
 [
     {
-        "BriefDescription": "read requests to memory controller. Derived f=
rom unc_m_cas_count.rd",
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
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1",
+        "EventName": "UNC_M_ACT_COUNT.RD",
+        "PerPkg": "1",
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
+        "EventCode": "0xA1",
+        "EventName": "UNC_M_BYP_CMDS.ACT",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CAS command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
+        "EventName": "UNC_M_BYP_CMDS.CAS",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "PRE command issued by 2 cycle bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA1",
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
+        "Unit": "iMC"
+    },
+    {
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
-        "BriefDescription": "write requests to memory controller. Derived =
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
-        "BriefDescription": "Memory controller clock ticks",
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
         "Counter": "0,1,2,3",
         "EventName": "UNC_M_DCLOCKTICKS",
         "PerPkg": "1",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles where DRAM ranks are in power down (CK=
E) mode",
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
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M_POWER_CHANNEL_DLLOFF",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles when all the ranks in the c=
hannel are in CKE Slow (DLLOFF) mode.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Channel PPD Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_M_POWER_CHANNEL_PPD",
-        "MetricExpr": "(UNC_M_POWER_CHANNEL_PPD / UNC_M_DCLOCKTICKS) * 100=
.",
-        "MetricName": "power_channel_ppd %",
         "PerPkg": "1",
+        "PublicDescription": "Number of cycles when all the ranks in the c=
hannel are in PPD mode.  If IBT=3Doff is enabled, then this can be used to =
count those cycles.  If it is not enabled, then this can count the number o=
f cycles when that could have been taken advantage of.",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Cycles all ranks are in critical thermal thro=
ttle",
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
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Critical Throttle Cycles",
         "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES",
-        "MetricExpr": "(UNC_M_POWER_CRITICAL_THROTTLE_CYCLES / UNC_M_DCLOC=
KTICKS) * 100.",
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
-        "MetricExpr": "(UNC_M_POWER_SELF_REFRESH / UNC_M_DCLOCKTICKS) * 10=
0.",
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
-        "BriefDescription": "Pre-charges due to page misses",
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
     },
     {
-        "BriefDescription": "Pre-charge for reads",
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to re=
ad",
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.RD",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Precharge commands=
 sent on this channel.",
         "UMask": "0x4",
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Pre-charge for writes",
+        "BriefDescription": "DRAM Precharge commands.; Precharge due to wr=
ite",
         "Counter": "0,1,2,3",
         "EventCode": "0x2",
         "EventName": "UNC_M_PRE_COUNT.WR",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of DRAM Precharge commands=
 sent on this channel.",
         "UMask": "0x8",
         "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with HIGH priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.HIGH",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with LOW priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.LOW",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with MEDIUM priority",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.MED",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS issued with PANIC NON ISOCH priority=
 (starved)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA0",
+        "EventName": "UNC_M_RD_CAS_PRIO.PANIC",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 0; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB0",
+        "EventName": "UNC_M_RD_CAS_RANK0.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 1; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB1",
+        "EventName": "UNC_M_RD_CAS_RANK1.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 2; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB2",
+        "EventName": "UNC_M_RD_CAS_RANK2.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 4; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB4",
+        "EventName": "UNC_M_RD_CAS_RANK4.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 5; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB5",
+        "EventName": "UNC_M_RD_CAS_RANK5.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 6; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB6",
+        "EventName": "UNC_M_RD_CAS_RANK6.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "RD_CAS Access to Rank 7; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7",
+        "EventName": "UNC_M_RD_CAS_RANK7.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
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
+        "EventCode": "0xC0",
+        "EventName": "UNC_M_WMM_TO_RMM.LOW_THRESH",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_M_WMM_TO_RMM.STARVE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Transition from WMM to RMM because of low thr=
eshold",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC0",
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
+        "EventCode": "0xC1",
+        "EventName": "UNC_M_WRONG_MM",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 0; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB8",
+        "EventName": "UNC_M_WR_CAS_RANK0.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 1; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB9",
+        "EventName": "UNC_M_WR_CAS_RANK1.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 4; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBC",
+        "EventName": "UNC_M_WR_CAS_RANK4.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 5; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBD",
+        "EventName": "UNC_M_WR_CAS_RANK5.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 6; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBE",
+        "EventName": "UNC_M_WR_CAS_RANK6.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; All Banks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.ALLBANKS",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK0",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 10",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK10",
+        "PerPkg": "1",
+        "UMask": "0xA",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 11",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK11",
+        "PerPkg": "1",
+        "UMask": "0xB",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 12",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK12",
+        "PerPkg": "1",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 13",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK13",
+        "PerPkg": "1",
+        "UMask": "0xD",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 14",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK14",
+        "PerPkg": "1",
+        "UMask": "0xE",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 15",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK15",
+        "PerPkg": "1",
+        "UMask": "0xF",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK2",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK3",
+        "PerPkg": "1",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 4",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK4",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 5",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK5",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK6",
+        "PerPkg": "1",
+        "UMask": "0x6",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 7",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK7",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 8",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK8",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank 9",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANK9",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 0 (Banks =
0-3)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG0",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 1 (Banks =
4-7)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG1",
+        "PerPkg": "1",
+        "UMask": "0x12",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 2 (Banks =
8-11)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG2",
+        "PerPkg": "1",
+        "UMask": "0x13",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "WR_CAS Access to Rank 7; Bank Group 3 (Banks =
12-15)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xBF",
+        "EventName": "UNC_M_WR_CAS_RANK7.BANKG3",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
index dd1b95655d1d..c3325dd61202 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
@@ -1,91 +1,511 @@
 [
     {
-        "BriefDescription": "PCU clock ticks. Use to get percentages of PC=
U cycles events",
+        "BriefDescription": "pclk Cycles",
         "Counter": "0,1,2,3",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
+        "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  This =
event counts the number of pclk cycles measured while the counter was enabl=
ed.  The pclk, like the Memory Controller's dclk, counts at a constant rate=
 making it a good measure of actual wall time.",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "This is an occupancy event that tracks the nu=
mber of cores that are in C0.  It can be used by itself to get the average =
number of cores in C0, with threshholding to generate histograms, or with o=
ther PCU events and occupancy triggering to capture other details",
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C0",
-        "Filter": "occ_sel=3D1",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C0 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c0 %",
+        "EventCode": "0x60",
+        "EventName": "UNC_P_CORE0_TRANSITION_CYCLES",
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
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C3",
-        "Filter": "occ_sel=3D2",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C3 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c3 %",
+        "EventCode": "0x6A",
+        "EventName": "UNC_P_CORE10_TRANSITION_CYCLES",
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
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "UNC_P_POWER_STATE_OCCUPANCY.CORES_C6",
-        "Filter": "occ_sel=3D3",
-        "MetricExpr": "(UNC_P_POWER_STATE_OCCUPANCY.CORES_C6 / UNC_P_CLOCK=
TICKS) * 100.",
-        "MetricName": "power_state_occupancy.cores_c6 %",
+        "EventCode": "0x6B",
+        "EventName": "UNC_P_CORE11_TRANSITION_CYCLES",
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
+        "BriefDescription": "Core C State Transition Cycles",
         "Counter": "0,1,2,3",
-        "EventCode": "0xA",
-        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
-        "MetricExpr": "(UNC_P_PROCHOT_EXTERNAL_CYCLES / UNC_P_CLOCKTICKS) =
* 100.",
-        "MetricName": "prochot_external_cycles %",
+        "EventCode": "0x6C",
+        "EventName": "UNC_P_CORE12_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6D",
+        "EventName": "UNC_P_CORE13_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6E",
+        "EventName": "UNC_P_CORE14_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x6F",
+        "EventName": "UNC_P_CORE15_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x70",
+        "EventName": "UNC_P_CORE16_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "UNC_P_CORE17_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "UNC_P_CORE1_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x62",
+        "EventName": "UNC_P_CORE2_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x63",
+        "EventName": "UNC_P_CORE3_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x64",
+        "EventName": "UNC_P_CORE4_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x65",
+        "EventName": "UNC_P_CORE5_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x66",
+        "EventName": "UNC_P_CORE6_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x67",
+        "EventName": "UNC_P_CORE7_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x68",
+        "EventName": "UNC_P_CORE8_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Transition Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_P_CORE9_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_P_DEMOTIONS_CORE0",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "UNC_P_DEMOTIONS_CORE1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3A",
+        "EventName": "UNC_P_DEMOTIONS_CORE10",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3B",
+        "EventName": "UNC_P_DEMOTIONS_CORE11",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3C",
+        "EventName": "UNC_P_DEMOTIONS_CORE12",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3D",
+        "EventName": "UNC_P_DEMOTIONS_CORE13",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3E",
+        "EventName": "UNC_P_DEMOTIONS_CORE14",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3F",
+        "EventName": "UNC_P_DEMOTIONS_CORE15",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_P_DEMOTIONS_CORE16",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_P_DEMOTIONS_CORE17",
         "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
     },
     {
-        "BriefDescription": "Counts the number of cycles when temperature =
is the upper limit on frequency",
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_P_DEMOTIONS_CORE2",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_P_DEMOTIONS_CORE3",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_P_DEMOTIONS_CORE4",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_P_DEMOTIONS_CORE5",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_P_DEMOTIONS_CORE6",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_P_DEMOTIONS_CORE7",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x38",
+        "EventName": "UNC_P_DEMOTIONS_CORE8",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Core C State Demotions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_P_DEMOTIONS_CORE9",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
+        "Unit": "PCU"
+    },
+    {
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
+        "Counter": "0,1,2,3",
+        "EventCode": "0x73",
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
+        "BriefDescription": "Cycles spent changing Frequency",
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "UNC_P_FREQ_TRANS_CYCLES",
-        "MetricExpr": "(UNC_P_FREQ_TRANS_CYCLES / UNC_P_CLOCKTICKS) * 100.=
",
-        "MetricName": "freq_trans_cycles %",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the system =
is changing frequency.  This can not be filtered by thread ID.  One can als=
o use it with the occupancy counter that monitors number of threads in C0 t=
o estimate the performance impact that frequency transitions had on the sys=
tem.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Memory Phase Shedding Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2F",
+        "EventName": "UNC_P_MEMORY_PHASE_SHEDDING_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles that the PCU has=
 triggered memory phase shedding.  This is a mode that can be run in the iM=
C physicals that saves power at the expense of additional latency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A",
+        "EventName": "UNC_P_PKG_RESIDENCY_C0_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the package=
 was in C0.  This event can be used in conjunction with edge detect to coun=
t C0 entrances (or exits using invert).  Residency events do not include tr=
ansition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C1E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4E",
+        "EventName": "UNC_P_PKG_RESIDENCY_C1E_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the package=
 was in C1E.  This event can be used in conjunction with edge detect to cou=
nt C1E entrances (or exits using invert).  Residency events do not include =
transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C2E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2B",
+        "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the package=
 was in C2E.  This event can be used in conjunction with edge detect to cou=
nt C2E entrances (or exits using invert).  Residency events do not include =
transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2C",
+        "EventName": "UNC_P_PKG_RESIDENCY_C3_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the package=
 was in C3.  This event can be used in conjunction with edge detect to coun=
t C3 entrances (or exits using invert).  Residency events do not include tr=
ansition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2D",
+        "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the package=
 was in C6.  This event can be used in conjunction with edge detect to coun=
t C6 entrances (or exits using invert).  Residency events do not include tr=
ansition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C7 State Residency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2E",
+        "EventName": "UNC_P_PKG_RESIDENCY_C7_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of cycles when the package=
 was in C7.  This event can be used in conjunction with edge detect to coun=
t C7 entrances (or exits using invert).  Residency events do not include tr=
ansition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C-State; C0 and C1",
+        "Counter": "0,1,2,3",
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
+        "EventCode": "0xA",
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
+        "EventCode": "0x72",
+        "EventName": "UNC_P_TOTAL_TRANSITION_CYCLES",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cycles spent performing core C sta=
te transitions across all cores.",
+        "Unit": "PCU"
+    },
+    {
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "UNC_P_UFS_TRANSITIONS_RING_GV",
+        "PerPkg": "1",
+        "PublicDescription": "Ring GV with same final and initial frequenc=
y",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "VR Hot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_P_VR_HOT_CYCLES",
         "PerPkg": "1",
         "Unit": "PCU"
     }
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
index 818a8b132c08..6a6de8790f25 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
@@ -385,4 +385,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 2cddfedf6abe..ebb7fc8fc576 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-56,v5,broadwellde,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
+GenuineIntel-6-56,v23,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-1C,v4,bonnell,core
 GenuineIntel-6-26,v4,bonnell,core
--=20
2.37.1.359.gd136c6c3e2-goog

