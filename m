Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2640B583517
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiG0WJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiG0WJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:09:12 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356D753D20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:00 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r13-20020a17090a454d00b001f04dfc6195so140160pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=R3jutOdfC9ntB4rsnlwmvBYAcQ/4u+LC0h5kuCuzs7g=;
        b=BmUp8rkOtUHHyl2ULF7ydP0JuW2szbdogMiHc7TEqaO4RhmtWpQRx8KU2A4b3PgG0x
         XXBTWH1mbDLG5P+8g2d3ONrMb6uHbUJrVCP2hceV0IFOksv+RFVle2OMDy4Jq5FMi14U
         xWqfTbnKJ/XNDWLCWMPc0TTgpzQrS/axVH9KE2FBG2sIEI80iDsORpXs0wiPwA7HlCMY
         ggt7zUJ6dR/pTwX8W7+dEsh9M9iFmMrFcfvliD/wmu6WkZ/EY1flJIyh1MlFZN03YBAl
         hA/S53XpdqtnvO+af6k4PPdiV7z+wvxvGAegiWQiyJMxL5caktI+TGbveZ7Z68j8F02v
         WR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=R3jutOdfC9ntB4rsnlwmvBYAcQ/4u+LC0h5kuCuzs7g=;
        b=u0UzfLZVe7LrChELtwZWW+9IqBpTlHgrlABFjDIQVxsN/DQQmkotj7RM2aWNMSDkKJ
         TeMIoI2z0uoV6GGiP9oVp0T7oMbGVfFaQykiiwLJaHvYN2qrC7wFDXS80kY1JwKpB13F
         n8ByaeyNKmxTVn4BEqpqEMpWjiL/4YhchVPLP/vfLd6PhfLoaNq2f+fvEbCkIEgq3rh3
         fhc6EE9qkcA+feENmdc9hGpxX7n51VE7C/hDB1jcd5sF4WpCTk7w+9BlGZ7CsGxxvDgb
         mCx4hkZUfBBrXazB7LSeBUwckY3QnP0FxiBFeN7nj91Tnd8ISnofSeDA2OdFcjvk+KjY
         EmjA==
X-Gm-Message-State: AJIora+C9UiG+P4q8Bts6tXLeRYYYjH0CPxFQAIoxAW/fY+k9S7YtigB
        gYC3k0MrZpyl2WG9GoYjiaHJmqlwaqjL
X-Google-Smtp-Source: AGRyM1tQSn04C4Xix4Q9Zp0reEUCV7MYob4VsHdgLgAeHqdcDP3FCjMdCwP0i2/4/VSYSBEHwEaTVwl5mI+s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a17:90b:1b4f:b0:1f0:e99:ecb0 with SMTP id
 nv15-20020a17090b1b4f00b001f00e99ecb0mr7031825pjb.204.1658959739673; Wed, 27
 Jul 2022 15:08:59 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:08 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-7-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 06/30] perf vendor events: Update Intel cascadelakex
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

Update to v1.16, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the cascadelakex files into perf and update mapfile.csv.

Tested with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
 90: perf all metricgroups test                                      : Ok
 91: perf all metrics test                                           : Skip
 93: perf all PMU test                                               : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/cascadelakex/cache.json          |   8 +-
 .../arch/x86/cascadelakex/clx-metrics.json    | 724 ++++++++++++++++--
 .../arch/x86/cascadelakex/floating-point.json |   2 +-
 .../arch/x86/cascadelakex/frontend.json       |   2 +-
 .../arch/x86/cascadelakex/other.json          |  63 ++
 .../arch/x86/cascadelakex/pipeline.json       |  11 +
 .../arch/x86/cascadelakex/uncore-memory.json  |   9 +
 .../arch/x86/cascadelakex/uncore-other.json   | 697 ++++++++++++++++-
 .../arch/x86/cascadelakex/virtual-memory.json |   2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 10 files changed, 1439 insertions(+), 81 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json b/tools=
/perf/pmu-events/arch/x86/cascadelakex/cache.json
index fcaa487b8737..716c1b507496 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
@@ -482,7 +482,7 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Retired load instructions with remote Intel O=
ptane DC persistent memory as the data source where the data request missed=
 all caches. Precise event.",
+        "BriefDescription": "Retired load instructions with remote Intel(R=
) Optane(TM) DC persistent memory as the data source where the data request=
 missed all caches. Precise event.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
@@ -490,7 +490,7 @@
         "EventCode": "0xD3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM",
         "PEBS": "1",
-        "PublicDescription": "Counts retired load instructions with remote=
 Intel Optane DC persistent memory as the data source and the data request =
missed L3 (AppDirect or Memory Mode) and DRAM cache(Memory Mode). Precise e=
vent",
+        "PublicDescription": "Counts retired load instructions with remote=
 Intel(R) Optane(TM) DC persistent memory as the data source and the data r=
equest missed L3 (AppDirect or Memory Mode) and DRAM cache(Memory Mode). Pr=
ecise event",
         "SampleAfterValue": "100007",
         "UMask": "0x10"
     },
@@ -590,7 +590,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Retired load instructions with local Intel Op=
tane DC persistent memory as the data source where the data request missed =
all caches. Precise event.",
+        "BriefDescription": "Retired load instructions with local Intel(R)=
 Optane(TM) DC persistent memory as the data source where the data request =
missed all caches. Precise event.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
@@ -598,7 +598,7 @@
         "EventCode": "0xD1",
         "EventName": "MEM_LOAD_RETIRED.LOCAL_PMM",
         "PEBS": "1",
-        "PublicDescription": "Counts retired load instructions with local =
Intel Optane DC persistent memory as the data source and the data request m=
issed L3 (AppDirect or Memory Mode) and DRAM cache(Memory Mode). Precise ev=
ent",
+        "PublicDescription": "Counts retired load instructions with local =
Intel(R) Optane(TM) DC persistent memory as the data source and the data re=
quest missed L3 (AppDirect or Memory Mode) and DRAM cache(Memory Mode). Pre=
cise event",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b=
/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 5a1631448b46..ba5863a80d43 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -95,13 +95,13 @@
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
         "MetricExpr": "100 * ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_=
ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NO=
T_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 *=
 INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) * ( ( (max( (=
 CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK=
_UNHALTED.THREAD , 0 )) / ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.=
BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UT=
IL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTI=
VITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DE=
LIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT=
_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) ) * ( (min( 9 * c=
pu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1@ + DTLB_LOAD_MISSES.WALK_ACTIVE =
, max( CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE_ACTIVITY.CYCLES_L1D_MISS , 0 )=
 ) / CPU_CLK_UNHALTED.THREAD) / (max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CYC=
LE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK_UNHALTED.THREAD , 0 )) ) + ( (EXE_A=
CTIVITY.BOUND_ON_STORES / CPU_CLK_UNHALTED.THREAD) / #((( CYCLE_ACTIVITY.ST=
ALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTA=
L + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_=
UNHALTED.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STOR=
ES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) -=
 ( UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED=
.THREAD))) ) * ( (( 9 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ + DTL=
B_STORE_MISSES.WALK_ACTIVE ) / CPU_CLK_UNHALTED.THREAD) / #(EXE_ACTIVITY.BO=
UND_ON_STORES / CPU_CLK_UNHALTED.THREAD) ) ) ",
-        "MetricGroup": "Mem;MemoryTLB",
+        "MetricGroup": "Mem;MemoryTLB;Offcore",
         "MetricName": "Memory_Data_TLBs"
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
         "MetricExpr": "100 * ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 =
) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) =
))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (I=
DQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +=
 CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( U=
OPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) )))) * ( ( (max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - =
CYCLE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK_UNHALTED.THREAD , 0 )) / ((( CYC=
LE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVI=
TY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS /=
 (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD=
_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EX=
E_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( (=
 CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /=
 CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOV=
ERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU=
_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * ( (m=
in( 9 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1@ + DTLB_LOAD_MISSES.WAL=
K_ACTIVE , max( CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE_ACTIVITY.CYCLES_L1D_M=
ISS , 0 ) ) / CPU_CLK_UNHALTED.THREAD) / (max( ( CYCLE_ACTIVITY.STALLS_MEM_=
ANY - CYCLE_ACTIVITY.STALLS_L1D_MISS ) / CPU_CLK_UNHALTED.THREAD , 0 )) ) +=
 ( (EXE_ACTIVITY.BOUND_ON_STORES / CPU_CLK_UNHALTED.THREAD) / #((( CYCLE_AC=
TIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.ST=
ALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 *=
 ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTI=
VE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACT=
IVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_C=
YCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_=
UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) ) * ( (( 9 * =
cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ + DTLB_STORE_MISSES.WALK_ACTI=
VE ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREA=
D_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) / #(EXE_ACTIVITY.BOUND_ON_STORES =
/ CPU_CLK_UNHALTED.THREAD) ) ) ",
-        "MetricGroup": "Mem;MemoryTLB;_SMT",
+        "MetricGroup": "Mem;MemoryTLB;Offcore_SMT",
         "MetricName": "Memory_Data_TLBs_SMT"
     },
     {
@@ -158,12 +158,6 @@
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "UpTB"
     },
-    {
-        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
-        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
-        "MetricGroup": "Pipeline;Mem",
-        "MetricName": "CPI"
-    },
     {
         "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
@@ -214,42 +208,36 @@
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
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.5=
12B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) ) / ( 2 * CPU=
_CLK_UNHALTED.THREAD )",
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
DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.5=
12B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) ) / ( 2 * ( (=
 CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /=
 CPU_CLK_UNHALTED.REF_XCLK ) ) )",
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
         "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCLES=
_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIR=
ED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.TH=
READ))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_C=
LK_UNHALTED.THREAD)) * ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.A=
LL_BRANCHES + MACHINE_CLEARS.COUNT )) * INT_MISC.CLEAR_RESTEER_CYCLES / CPU=
_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CO=
RE / (4 * CPU_CLK_UNHALTED.THREAD)) ) * (4 * CPU_CLK_UNHALTED.THREAD) / BR_=
MISP_RETIRED.ALL_BRANCHES",
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
.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * ((BR_MISP_RETIRED.AL=
L_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * INT=
_MISC.CLEAR_RESTEER_CYCLES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_=
DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 )=
 * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )=
)) ) * (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_=
THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) / BR_MISP_RETIRED.ALL_BRANCH=
ES",
-        "MetricGroup": "Bad;BrMispredicts_SMT",
-        "MetricName": "Branch_Misprediction_Cost_SMT"
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricExpr": "( 1 - ((1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU=
_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES )=
 / (4 * CPU_CLK_UNHALTED.THREAD)) - ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE=
_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.=
1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) =
* EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_U=
OPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY=
 + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD)))) / ((EX=
E_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.R=
ETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL)) =
/ CPU_CLK_UNHALTED.THREAD if ( ARITH.DIVIDER_ACTIVE < ( CYCLE_ACTIVITY.STAL=
LS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY ) ) else (EXE_ACTIVITY.1_PORTS_UTI=
L + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTIV=
ITY.2_PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD) if ((1 - (IDQ_UOPS_NOT_DELIVER=
ED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - ( UOPS_ISSUED.ANY + 4 * INT_MISC=
.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD)) - ((( CYCLE_ACTIVITY.ST=
ALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTA=
L + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_=
UNHALTED.THREAD)) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STOR=
ES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) -=
 ( UOPS_ISSUED.ANY + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED=
.THREAD)))) < ((EXE_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_PORTS_UTIL=
 + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.THREAD)) * EXE_ACTIVI=
TY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD if ( ARITH.DIVIDER_ACTIVE < ( C=
YCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY ) ) else (EXE_AC=
TIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * CPU_CLK_UNHALTED.TH=
READ)) * EXE_ACTIVITY.2_PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD) else 1 ) if =
0 > 0.5 else 0",
+        "MetricGroup": "Cor;SMT",
+        "MetricName": "Core_Bound_Likely"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "IpMispredict"
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricExpr": "( 1 - ((1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( (=
 CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /=
 CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOV=
ERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU=
_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ((( CYC=
LE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES ) / (CYCLE_ACTIVI=
TY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS /=
 (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD=
_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) + EX=
E_ACTIVITY.BOUND_ON_STORES)) * (1 - (IDQ_UOPS_NOT_DELIVERED.CORE / (4 * ( (=
 CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE /=
 CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( UOPS_ISSUED.ANY + 4 * ( INT_MISC.RECOV=
ERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU=
_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))) / ((EXE=
_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RE=
TIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORT=
S_UTIL)) / CPU_CLK_UNHALTED.THREAD if ( ARITH.DIVIDER_ACTIVE < ( CYCLE_ACTI=
VITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_MEM_ANY ) ) else (EXE_ACTIVITY.1_=
PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD =
/ 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCL=
K ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) / CPU_CLK_UNHALTED.THREAD) if ((1 - (I=
DQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +=
 CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( U=
OPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) ))) - ((( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIV=
ITY.BOUND_ON_STORES ) / (CYCLE_ACTIVITY.STALLS_TOTAL + (EXE_ACTIVITY.1_PORT=
S_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 =
) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) =
))) * EXE_ACTIVITY.2_PORTS_UTIL) + EXE_ACTIVITY.BOUND_ON_STORES)) * (1 - (I=
DQ_UOPS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +=
 CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - ( U=
OPS_ISSUED.ANY + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU_=
CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_=
CLK_UNHALTED.REF_XCLK ) ))))) < ((EXE_ACTIVITY.EXE_BOUND_0_PORTS + (EXE_ACT=
IVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOTS / (4 * ( ( CPU_CLK_UNHALTED=
.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED=
.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL)) / CPU_CLK_UNHALTED.THREAD if =
( ARITH.DIVIDER_ACTIVE < ( CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STA=
LLS_MEM_ANY ) ) else (EXE_ACTIVITY.1_PORTS_UTIL + (UOPS_RETIRED.RETIRE_SLOT=
S / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THR=
EAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * EXE_ACTIVITY.2_PORTS_UTIL) /=
 CPU_CLK_UNHALTED.THREAD) else 1 ) if (1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTI=
VE / ( CPU_CLK_UNHALTED.REF_XCLK_ANY / 2 )) > 0.5 else 0",
+        "MetricGroup": "Cor;SMT_SMT",
+        "MetricName": "Core_Bound_Likely_SMT"
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
@@ -341,48 +329,84 @@
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
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
         "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "Fetch_UpC"
     },
-    {
-        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
-        "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS=
 + IDQ.MS_UOPS)",
-        "MetricGroup": "Fed;LSD",
-        "MetricName": "LSD_Coverage"
-    },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
-        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_=
UOPS + IDQ.MS_UOPS)",
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + IDQ.MITE_UOPS + IDQ.=
MS_UOPS)",
         "MetricGroup": "DSB;Fed;FetchBW",
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset/see of/the Instruction_Fetch_BW Bottleneck.",
-        "MetricExpr": "(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.COR=
E / (4 * CPU_CLK_UNHALTED.THREAD)) * (DSB2MITE_SWITCHES.PENALTY_CYCLES / CP=
U_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.C=
ORE / (4 * CPU_CLK_UNHALTED.THREAD)) + ((IDQ_UOPS_NOT_DELIVERED.CORE / (4 *=
 CPU_CLK_UNHALTED.THREAD)) - (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELI=
V.CORE / (4 * CPU_CLK_UNHALTED.THREAD))) * (( IDQ.ALL_MITE_CYCLES_ANY_UOPS =
- IDQ.ALL_MITE_CYCLES_4_UOPS ) / CPU_CLK_UNHALTED.THREAD / 2) / #((IDQ_UOPS=
_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - (4 * IDQ_UOPS_NOT_DE=
LIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD)))",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / DSB2MITE_SWITCHE=
S.COUNT",
+        "MetricGroup": "DSBmiss",
+        "MetricName": "DSB_Switch_Cost"
+    },
+    {
+        "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck.",
+        "MetricExpr": "100 * ( (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_D=
ELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) * (DSB2MITE_SWITCHES.PENALTY_CYC=
LES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS=
_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) + ((IDQ_UOPS_NOT_DELIVERED.COR=
E / (4 * CPU_CLK_UNHALTED.THREAD)) - (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_U=
OPS_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD))) * (( IDQ.ALL_MITE_CYCLES_A=
NY_UOPS - IDQ.ALL_MITE_CYCLES_4_UOPS ) / CPU_CLK_UNHALTED.THREAD / 2) / #((=
IDQ_UOPS_NOT_DELIVERED.CORE / (4 * CPU_CLK_UNHALTED.THREAD)) - (4 * IDQ_UOP=
S_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_CLK_UNHALTED.THREAD))) =
)",
         "MetricGroup": "DSBmiss;Fed",
-        "MetricName": "DSB_Misses_Cost"
+        "MetricName": "DSB_Misses"
     },
     {
-        "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset/see of/the Instruction_Fetch_BW Bottleneck.",
-        "MetricExpr": "(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.COR=
E / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THR=
EAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * (DSB2MITE_SWITCHES.PENALTY_C=
YCLES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UO=
PS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHA=
LTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) + ((IDQ_UOPS_NOT_D=
ELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHA=
LTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - (4 * IDQ_UOPS_NO=
T_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2=
 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK )=
 )))) * (( IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES_4_UOPS ) / ( =
( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE =
/ CPU_CLK_UNHALTED.REF_XCLK ) ) / 2) / #((IDQ_UOPS_NOT_DELIVERED.CORE / (4 =
* ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACT=
IVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_=
0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_=
UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))))",
+        "BriefDescription": "Total penalty related to DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck.",
+        "MetricExpr": "100 * ( (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_D=
ELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED=
.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * (DSB2MITE_SWITCHES.P=
ENALTY_CYCLES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYC=
LES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_=
CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) + ((IDQ_UO=
PS_NOT_DELIVERED.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_=
CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - (4 * IDQ=
_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.TH=
READ / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.RE=
F_XCLK ) )))) * (( IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MITE_CYCLES_4_UOP=
S ) / ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD=
_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ) / 2) / #((IDQ_UOPS_NOT_DELIVERED.CO=
RE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_TH=
READ_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) - (4 * IDQ_UOPS_NOT_DELIVERED=
.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + =
CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))) )",
         "MetricGroup": "DSBmiss;Fed_SMT",
-        "MetricName": "DSB_Misses_Cost_SMT"
+        "MetricName": "DSB_Misses_SMT"
     },
     {
-        "BriefDescription": "Number of Instructions per non-speculative DS=
B miss",
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
+    {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIR=
ED.RETIRE_SLOTS + 4 * INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.TH=
READ))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * CPU_C=
LK_UNHALTED.THREAD)) * ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED.A=
LL_BRANCHES + MACHINE_CLEARS.COUNT )) * INT_MISC.CLEAR_RESTEER_CYCLES / CPU=
_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CO=
RE / (4 * CPU_CLK_UNHALTED.THREAD)) ) * (4 * CPU_CLK_UNHALTED.THREAD) / BR_=
MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BrMispredicts",
+        "MetricName": "Branch_Misprediction_Cost"
+    },
+    {
+        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIR=
ED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * (( UOPS_ISSUED.ANY - UOPS_RETIR=
ED.RETIRE_SLOTS + 4 * ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( ( CPU=
_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU=
_CLK_UNHALTED.REF_XCLK ) )))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_D=
ELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED=
.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))) * ((BR_MISP_RETIRED.AL=
L_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * INT=
_MISC.CLEAR_RESTEER_CYCLES / CPU_CLK_UNHALTED.THREAD) / #(4 * IDQ_UOPS_NOT_=
DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 )=
 * ( 1 + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )=
)) ) * (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_UNHALTED.ONE_=
THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )) / BR_MISP_RETIRED.ALL_BRANCH=
ES",
+        "MetricGroup": "Bad;BrMispredicts_SMT",
+        "MetricName": "Branch_Misprediction_Cost_SMT"
+    },
     {
         "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
         "MetricExpr": "BR_INST_RETIRED.NOT_TAKEN / BR_INST_RETIRED.ALL_BRA=
NCHES",
@@ -408,11 +432,10 @@
         "MetricName": "Jump"
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
@@ -420,30 +443,6 @@
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
@@ -463,13 +462,13 @@
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
@@ -493,7 +492,7 @@
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
@@ -511,6 +510,30 @@
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
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / d=
uration_time",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW"
+    },
     {
         "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
         "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
@@ -523,6 +546,30 @@
         "MetricGroup": "L2Evicts;Mem;Server",
         "MetricName": "L2_Evictions_NonSilent_PKI"
     },
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
@@ -539,7 +586,8 @@
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
@@ -714,5 +762,537 @@
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
+        "MetricExpr": "100 * CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricGroup": "",
+        "MetricName": "cpu_utilization_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "CPU operating frequency (in GHz)",
+        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TS=
C * #SYSTEM_TSC_FREQ ) / 1000000000",
+        "MetricGroup": "",
+        "MetricName": "cpu_operating_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "cpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "The ratio of number of completed memory load =
instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "loads_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "The ratio of number of completed memory store=
 instructions to the total number completed instructions",
+        "MetricExpr": "MEM_INST_RETIRED.ALL_STORES / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "stores_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L1 data c=
ache (includes data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "l1d_mpi_includes_data_plus_rfo_with_prefetches",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions ",
+        "MetricExpr": "MEM_LOAD_RETIRED.L1_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "l1d_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
+        "MetricExpr": "L2_RQSTS.ALL_CODE_RD / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions ",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "l2_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "l2_mpi_includes_code_plus_data_plus_rfo_with_prefet=
ches",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "l2_demand_data_read_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read request missing =
L2 cache to the total number of completed instructions",
+        "MetricExpr": "L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "l2_demand_code_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x12D=
4043300000000@ / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x12C=
C023300000000@ / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) in nano seconds",
+        "MetricExpr": "( ( 1000000000 * ( cha@unc_cha_tor_occupancy.ia_mis=
s\\,config1\\=3D0x4043300000000@ / cha@unc_cha_tor_inserts.ia_miss\\,config=
1\\=3D0x4043300000000@ ) / ( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CL=
OCKTICKS) * #num_packages ) ) ) * duration_time )",
+        "MetricGroup": "",
+        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to local m=
emory in nano seconds",
+        "MetricExpr": "( ( 1000000000 * ( cha@unc_cha_tor_occupancy.ia_mis=
s\\,config1\\=3D0x4043200000000@ / cha@unc_cha_tor_inserts.ia_miss\\,config=
1\\=3D0x4043200000000@ ) / ( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CL=
OCKTICKS) * #num_packages ) ) ) * duration_time )",
+        "MetricGroup": "",
+        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_local_requests",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand and prefetch data read miss (read memory access) addressed to remote =
memory in nano seconds",
+        "MetricExpr": "( ( 1000000000 * ( cha@unc_cha_tor_occupancy.ia_mis=
s\\,config1\\=3D0x4043100000000@ / cha@unc_cha_tor_inserts.ia_miss\\,config=
1\\=3D0x4043100000000@ ) / ( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CL=
OCKTICKS) * #num_packages ) ) ) * duration_time )",
+        "MetricGroup": "",
+        "MetricName": "llc_data_read_demand_plus_prefetch_miss_latency_for=
_remote_requests",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions. This implies it missed in the ITLB (Instruction TLB) and further=
 levels of TLB.",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "itlb_2nd_level_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions. This implies it missed in the Instruction =
Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
+        "MetricGroup": "",
+        "MetricName": "itlb_2nd_level_large_page_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions. This implies it missed in the DTLB and further levels of TL=
B.",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
+        "MetricGroup": "",
+        "MetricName": "dtlb_2nd_level_load_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions. This implies it missed in the Data Translation Looka=
side Buffer (DTLB) and further levels of TLB.",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
+        "MetricGroup": "",
+        "MetricName": "dtlb_2nd_level_2mb_large_page_load_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricGroup": "",
+        "MetricName": "dtlb_2nd_level_store_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
+        "MetricExpr": "100 * cha@unc_cha_tor_inserts.ia_miss\\,config1\\=
=3D0x4043200000000@ / ( cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x404=
3200000000@ + cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x4043100000000=
@ )",
+        "MetricGroup": "",
+        "MetricName": "numa_percent_reads_addressed_to_local_dram",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
+        "MetricExpr": "100 * cha@unc_cha_tor_inserts.ia_miss\\,config1\\=
=3D0x4043100000000@ / ( cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x404=
3200000000@ + cha@unc_cha_tor_inserts.ia_miss\\,config1\\=3D0x4043100000000=
@ )",
+        "MetricGroup": "",
+        "MetricName": "numa_percent_reads_addressed_to_remote_dram",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Uncore operating frequency in GHz",
+        "MetricExpr": "UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CLOCKTI=
CKS) * #num_packages ) / 1000000000",
+        "MetricGroup": "",
+        "MetricName": "uncore_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data t=
ransmit bandwidth (MB/sec)",
+        "MetricExpr": "( UNC_UPI_TxL_FLITS.ALL_DATA * (64 / 9.0) / 1000000=
) / duration_time",
+        "MetricGroup": "",
+        "MetricName": "upi_data_transmit_bw_only_data",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
+        "MetricExpr": "( UNC_M_CAS_COUNT.RD * 64 / 1000000) / duration_tim=
e",
+        "MetricGroup": "",
+        "MetricName": "memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
+        "MetricExpr": "( UNC_M_CAS_COUNT.WR * 64 / 1000000) / duration_tim=
e",
+        "MetricGroup": "",
+        "MetricName": "memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory bandwidth (MB/sec)",
+        "MetricExpr": "(( UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR ) * 64 /=
 1000000) / duration_time",
+        "MetricGroup": "",
+        "MetricName": "memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory read bandwidth (MB/sec)",
+        "MetricExpr": "( UNC_M_PMM_RPQ_INSERTS * 64 / 1000000) / duration_=
time",
+        "MetricGroup": "",
+        "MetricName": "pmem_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory write bandwidth (MB/sec)",
+        "MetricExpr": "( UNC_M_PMM_WPQ_INSERTS * 64 / 1000000) / duration_=
time",
+        "MetricGroup": "",
+        "MetricName": "pmem_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Intel(R) Optane(TM) Persistent Memory(PMEM) m=
emory bandwidth (MB/sec)",
+        "MetricExpr": "(( UNC_M_PMM_RPQ_INSERTS + UNC_M_PMM_WPQ_INSERTS ) =
* 64 / 1000000) / duration_time",
+        "MetricGroup": "",
+        "MetricName": "pmem_memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
+        "MetricExpr": "(( UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO=
_DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3 ) * 4 / 1000000) / duration_time",
+        "MetricGroup": "",
+        "MetricName": "io_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "MetricExpr": "(( UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART0 + UNC_I=
IO_PAYLOAD_BYTES_IN.MEM_WRITE.PART1 + UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PA=
RT2 + UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART3 ) * 4 / 1000000) / duration_=
time",
+        "MetricGroup": "",
+        "MetricName": "io_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Uops delivered from decoded instruction cache=
 (decoded stream buffer or DSB) as a percent of total uops delivered to Ins=
truction Decode Queue",
+        "MetricExpr": "100 * ( IDQ.DSB_UOPS / ( IDQ.DSB_UOPS + IDQ.MITE_UO=
PS + IDQ.MS_UOPS + LSD.UOPS ) )",
+        "MetricGroup": "",
+        "MetricName": "percent_uops_delivered_from_decoded_icache_dsb",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Uops delivered from legacy decode pipeline (M=
icro-instruction Translation Engine or MITE) as a percent of total uops del=
ivered to Instruction Decode Queue",
+        "MetricExpr": "100 * ( IDQ.MITE_UOPS / ( IDQ.DSB_UOPS + IDQ.MITE_U=
OPS + IDQ.MS_UOPS + LSD.UOPS ) )",
+        "MetricGroup": "",
+        "MetricName": "percent_uops_delivered_from_legacy_decode_pipeline_=
mite",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Uops delivered from microcode sequencer (MS) =
as a percent of total uops delivered to Instruction Decode Queue",
+        "MetricExpr": "100 * ( IDQ.MS_UOPS / ( IDQ.DSB_UOPS + IDQ.MITE_UOP=
S + IDQ.MS_UOPS + LSD.UOPS ) )",
+        "MetricGroup": "",
+        "MetricName": "percent_uops_delivered_from_microcode_sequencer_ms"=
,
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory.",
+        "MetricExpr": "( UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1000000) / du=
ration_time",
+        "MetricGroup": "",
+        "MetricName": "llc_miss_local_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory.",
+        "MetricExpr": "( UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1000000) / d=
uration_time",
+        "MetricGroup": "",
+        "MetricName": "llc_miss_local_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory.",
+        "MetricExpr": "( UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1000000) / d=
uration_time",
+        "MetricGroup": "",
+        "MetricName": "llc_miss_remote_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend. Frontend denotes th=
e first part of the processor core responsible to fetch operations that are=
 executed later on by the Backend part. Within the Frontend; a branch predi=
ctor predicts the next address to fetch; cache-lines are fetched from the m=
emory subsystem; parsed into instructions; and lastly decoded into micro-op=
erations (uops). Ideally the Frontend can issue Machine_Width uops every cy=
cle to the Backend. Frontend Bound denotes unutilized issue-slots when ther=
e is no Backend stall; i.e. bubbles where Frontend delivered no uops while =
Backend could have accepted them. For example; stalls due to instruction-ca=
che misses would be categorized under Frontend Bound.",
+        "MetricExpr": "100 * ( IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 ) * ( (=
 CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREA=
D ) ) ) )",
+        "MetricGroup": "TmaL1;PGO",
+        "MetricName": "tma_frontend_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues.  For example; instruction-c=
ache misses; iTLB misses or fetch stalls after a branch misprediction are c=
ategorized under Frontend Latency. In such cases; the Frontend eventually d=
elivers no uops for some period.",
+        "MetricExpr": "100 * ( ( 4 ) * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOP=
S_DELIV.CORE / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on e=
lse ( CPU_CLK_UNHALTED.THREAD ) ) ) )",
+        "MetricGroup": "Frontend;TmaL2;m_tma_frontend_bound_percent",
+        "MetricName": "tma_fetch_latency_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
+        "MetricExpr": "100 * ( ( ICACHE_16B.IFDATA_STALL + 2 * cpu@ICACHE_=
16B.IFDATA_STALL\\,cmask\\=3D0x1\\,edge\\=3D0x1@ ) / ( CPU_CLK_UNHALTED.THR=
EAD ) )",
+        "MetricGroup": "BigFoot;FetchLat;IcMiss;TmaL3;m_tma_fetch_latency_=
percent",
+        "MetricName": "tma_icache_misses_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses.",
+        "MetricExpr": "100 * ( ICACHE_64B.IFTAG_STALL / ( CPU_CLK_UNHALTED=
.THREAD ) )",
+        "MetricGroup": "BigFoot;FetchLat;MemoryTLB;TmaL3;m_tma_fetch_laten=
cy_percent",
+        "MetricName": "tma_itlb_misses_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fron=
tend delay in fetching operations from corrected path; following all sorts =
of miss-predicted branches. For example; branchy code with lots of miss-pre=
dictions might get categorized under Branch Resteers. Note the value of thi=
s node may overlap with its siblings.",
+        "MetricExpr": "100 * ( INT_MISC.CLEAR_RESTEER_CYCLES / ( CPU_CLK_U=
NHALTED.THREAD ) + ( ( 9 ) * BACLEARS.ANY / ( CPU_CLK_UNHALTED.THREAD ) ) )=
",
+        "MetricGroup": "FetchLat;TmaL3;m_tma_fetch_latency_percent",
+        "MetricName": "tma_branch_resteers_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines. The DSB (decod=
ed i-cache) is a Uop Cache where the front-end directly delivers Uops (micr=
o operations) avoiding heavy x86 decoding. The DSB pipeline has shorter lat=
ency and delivered higher bandwidth than the MITE (legacy instruction decod=
e pipeline). Switching between the two pipelines can cause penalties hence =
this metric measures the exposed penalty.",
+        "MetricExpr": "100 * ( DSB2MITE_SWITCHES.PENALTY_CYCLES / ( CPU_CL=
K_UNHALTED.THREAD ) )",
+        "MetricGroup": "DSBmiss;FetchLat;TmaL3;m_tma_fetch_latency_percent=
",
+        "MetricName": "tma_dsb_switches_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs). Using proper compiler =
flags or Intel Compiler by default will certainly avoid this. #Link: Optimi=
zation Guide about LCP BKMs.",
+        "MetricExpr": "100 * ( ILD_STALL.LCP / ( CPU_CLK_UNHALTED.THREAD )=
 )",
+        "MetricGroup": "FetchLat;TmaL3;m_tma_fetch_latency_percent",
+        "MetricName": "tma_lcp_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS). Commonly used instructions are optimized for delivery by the=
 DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Certa=
in operations cannot be handled natively by the execution pipeline; and mus=
t be performed by microcode (small programs injected into the execution str=
eam). Switching to the MS too often can negatively impact performance. The =
MS is designated to deliver long uop flows required by CISC instructions li=
ke CPUID; or uncommon conditions like Floating Point Assists when dealing w=
ith Denormals.",
+        "MetricExpr": "100 * ( ( 2 ) * IDQ.MS_SWITCHES / ( CPU_CLK_UNHALTE=
D.THREAD ) )",
+        "MetricGroup": "FetchLat;MicroSeq;TmaL3;m_tma_fetch_latency_percen=
t",
+        "MetricName": "tma_ms_switches_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues.  For example; inefficienc=
ies at the instruction decoders; or restrictions for caching in the DSB (de=
coded uops cache) are categorized under Fetch Bandwidth. In such cases; the=
 Frontend typically delivers suboptimal amount of uops to the Backend.",
+        "MetricExpr": "100 * ( ( IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 ) * (=
 ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THR=
EAD ) ) ) ) - ( ( 4 ) * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (=
 ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UN=
HALTED.THREAD ) ) ) ) )",
+        "MetricGroup": "FetchBW;Frontend;TmaL2;m_tma_frontend_bound_percen=
t",
+        "MetricName": "tma_fetch_bandwidth_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline). This pipeline is used for code that was not pre-cached in the=
 DSB or LSD. For example; inefficiencies due to asymmetric decoders; use of=
 long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
+        "MetricExpr": "100 * ( ( IDQ.ALL_MITE_CYCLES_ANY_UOPS - IDQ.ALL_MI=
TE_CYCLES_4_UOPS ) / ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else =
( CPU_CLK_UNHALTED.THREAD ) ) / 2 )",
+        "MetricGroup": "DSBmiss;FetchBW;TmaL3;m_tma_fetch_bandwidth_percen=
t",
+        "MetricName": "tma_mite_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line.  For example; inefficient utilization of the DSB cache structure or b=
ank conflict when reading from it; are categorized here.",
+        "MetricExpr": "100 * ( ( IDQ.ALL_DSB_CYCLES_ANY_UOPS - IDQ.ALL_DSB=
_CYCLES_4_UOPS ) / ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( =
CPU_CLK_UNHALTED.THREAD ) ) / 2 )",
+        "MetricGroup": "DSB;FetchBW;TmaL3;m_tma_fetch_bandwidth_percent",
+        "MetricName": "tma_dsb_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations. This include slots used to issue uops t=
hat do not eventually get retired and slots for which the issue-pipeline wa=
s blocked due to recovery from earlier incorrect speculation. For example; =
wasted work due to miss-predicted branches are categorized under Bad Specul=
ation category. Incorrect data speculation followed by Memory Ordering Nuke=
s is another example.",
+        "MetricExpr": "100 * ( ( UOPS_ISSUED.ANY - ( UOPS_RETIRED.RETIRE_S=
LOTS ) + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else INT=
_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 )=
 if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) )",
+        "MetricGroup": "TmaL1",
+        "MetricName": "tma_bad_speculation_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction.  These slots are either wasted =
by uops fetched from an incorrectly speculated program path; or stalls when=
 the out-of-order part of the machine needs to recover its state from a spe=
culative path.",
+        "MetricExpr": "100 * ( ( BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_=
RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT ) ) * ( ( UOPS_ISSUED.ANY - ( U=
OPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLES_ANY / 2 )=
 if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CPU_CLK_UNHAL=
TED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) )",
+        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;m_tma_bad_speculation_=
percent",
+        "MetricName": "tma_branch_mispredicts_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears.  These slots are either wasted by uop=
s fetched prior to the clear; or stalls the out-of-order portion of the mac=
hine needs to recover its state after the clear. For example; this can happ=
en due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modify=
ing-Code (SMC) nukes.",
+        "MetricExpr": "100 * ( ( ( UOPS_ISSUED.ANY - ( UOPS_RETIRED.RETIRE=
_SLOTS ) + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else I=
NT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2=
 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( BR_MISP_RETIRED.=
ALL_BRANCHES / ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT ) ) * =
( ( UOPS_ISSUED.ANY - ( UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( ( INT_MISC.=
RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( =
( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNH=
ALTED.THREAD ) ) ) ) ) )",
+        "MetricGroup": "BadSpec;MachineClears;TmaL2;m_tma_bad_speculation_=
percent",
+        "MetricName": "tma_machine_clears_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend. Backend is the portion of the processor cor=
e where the out-of-order scheduler dispatches ready uops into their respect=
ive execution units; and once completed these uops get retired according to=
 program order. For example; stalls due to data-cache misses or stalls due =
to the divider unit being overloaded are both categorized under Backend Bou=
nd. Backend Bound is further divided into two main categories: Memory Bound=
 and Core Bound.",
+        "MetricExpr": "100 * ( 1 - ( IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( UOPS_ISSUED.ANY + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLES_=
ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CPU_=
CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) )=
 ) )",
+        "MetricGroup": "TmaL1",
+        "MetricName": "tma_backend_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck.  Memory Bound estimat=
es fraction of slots where pipeline is likely stalled due to demand load or=
 store instructions. This accounts mainly for (1) non-completed in-flight m=
emory demand loads which coincides with execution units starvation; in addi=
tion to (2) cases where stores could impose backpressure on the pipeline wh=
en many of them get buffered at the same time (less common out of the two).=
",
+        "MetricExpr": "100 * ( ( ( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACT=
IVITY.BOUND_ON_STORES ) / ( CYCLE_ACTIVITY.STALLS_TOTAL + ( EXE_ACTIVITY.1_=
PORTS_UTIL + ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALT=
ED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) * EXE=
_ACTIVITY.2_PORTS_UTIL ) + EXE_ACTIVITY.BOUND_ON_STORES ) ) * ( 1 - ( IDQ_U=
OPS_NOT_DELIVERED.CORE / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if=
 #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( UOPS_ISSUED.ANY + ( 4 )=
 * ( ( INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY=
_CYCLES ) ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on el=
se ( CPU_CLK_UNHALTED.THREAD ) ) ) ) )",
+        "MetricGroup": "Backend;TmaL2;m_tma_backend_bound_percent",
+        "MetricName": "tma_memory_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache.  The L1 data cache typicall=
y has the shortest latency.  However; in certain cases like loads blocked o=
n older stores; a load might suffer due to high latency even though it is b=
eing satisfied by the L1. Another example is loads who miss in the TLB. The=
se cases are characterized by execution unit stalls; while some non-complet=
ed demand load lives in the machine without having that demand load missing=
 the L1 cache.",
+        "MetricExpr": "100 * ( max( ( CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCL=
E_ACTIVITY.STALLS_L1D_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) , 0 ) )",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memor=
y_bound_percent",
+        "MetricName": "tma_l1_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 m=
isses/L2 hits) can improve the latency and increase performance.",
+        "MetricExpr": "100 * ( ( ( MEM_LOAD_RETIRED.L2_HIT * ( 1 + ( MEM_L=
OAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) / ( ( MEM_LOAD_RETI=
RED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS )=
 ) ) ) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D0x1@ ) ) * ( ( CYCLE_ACTIVIT=
Y.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.TH=
READ ) ) )",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memor=
y_bound_percent",
+        "MetricName": "tma_l2_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core. =
 Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency and=
 increase performance.",
+        "MetricExpr": "100 * ( ( CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACT=
IVITY.STALLS_L3_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) )",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memor=
y_bound_percent",
+        "MetricName": "tma_l3_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads. Better caching can i=
mprove the latency and increase performance.",
+        "MetricExpr": "100 * ( min( ( ( ( CYCLE_ACTIVITY.STALLS_L3_MISS / =
( CPU_CLK_UNHALTED.THREAD ) + ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_AC=
TIVITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) ) - ( ( ( MEM_LOAD_RE=
TIRED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS=
 ) ) ) ) / ( ( MEM_LOAD_RETIRED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / =
( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D=
0x1@ ) ) * ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MI=
SS ) / ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( min( ( ( ( ( 1 - ( ( ( 19 * ( =
MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( =
MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MISS_RETIRED.LOCAL_=
DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) )=
 + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT =
/ ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_HI=
TM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) )=
 ) / ( ( 19 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RET=
IRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MIS=
S_RETIRED.LOCAL_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED=
.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD=
_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_HITM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L=
1_MISS ) ) ) ) ) ) + ( 25 * ( ( MEM_LOAD_RETIRED.LOCAL_PMM * ( 1 + ( MEM_LO=
AD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) ) + 33 * ( ( MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_PMM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD=
_RETIRED.L1_MISS ) ) ) ) ) ) ) ) ) ) * ( CYCLE_ACTIVITY.STALLS_L3_MISS / ( =
CPU_CLK_UNHALTED.THREAD ) + ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTI=
VITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) ) - ( ( ( MEM_LOAD_RETI=
RED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS )=
 ) ) ) / ( ( MEM_LOAD_RETIRED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( =
MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D0x=
1@ ) ) * ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS=
 ) / ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) if ( ( 1000000 ) * ( MEM_LOAD_L3_M=
ISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1=
_MISS ) else 0 ) ) , ( 1 ) ) ) ) ) , ( 1 ) ) )",
+        "MetricGroup": "MemoryBound;TmaL3mem;TmaL3;m_tma_memory_bound_perc=
ent",
+        "MetricName": "tma_dram_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a. IXP) memory by loads, PMM stands for Persistent Memo=
ry Module. ",
+        "MetricExpr": "100 * ( min( ( ( ( ( 1 - ( ( ( 19 * ( MEM_LOAD_L3_M=
ISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETI=
RED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1 + =
( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD=
_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_=
RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 + ( =
MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) ) ) / ( ( 19 *=
 ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT /=
 ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MISS_RETIRED.LOC=
AL_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) =
) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD_RETIRED.FB_H=
IT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE=
_HITM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) =
) ) ) + ( 25 * ( ( MEM_LOAD_RETIRED.LOCAL_PMM * ( 1 + ( MEM_LOAD_RETIRED.FB=
_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) ) + 33 * ( ( MEM_LOAD_L3_MISS_RET=
IRED.REMOTE_PMM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_M=
ISS ) ) ) ) ) ) ) ) ) ) * ( CYCLE_ACTIVITY.STALLS_L3_MISS / ( CPU_CLK_UNHAL=
TED.THREAD ) + ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L=
2_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) ) - ( ( ( MEM_LOAD_RETIRED.L2_HIT * =
( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) / ( ( =
MEM_LOAD_RETIRED.L2_HIT * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETI=
RED.L1_MISS ) ) ) ) + cpu@L1D_PEND_MISS.FB_FULL\\,cmask\\=3D0x1@ ) ) * ( ( =
CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / ( CPU_CL=
K_UNHALTED.THREAD ) ) ) ) ) if ( ( 1000000 ) * ( MEM_LOAD_L3_MISS_RETIRED.R=
EMOTE_PMM + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else =
0 ) ) , ( 1 ) ) )",
+        "MetricGroup": "MemoryBound;Server;TmaL3mem;TmaL3;m_tma_memory_bou=
nd_percent",
+        "MetricName": "tma_pmm_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write. Even though store accesses do not typically stall=
 out-of-order CPUs; there are few cases where stores can lead to actual sta=
lls. This metric will be flagged should RFO stores be a bottleneck.",
+        "MetricExpr": "100 * ( EXE_ACTIVITY.BOUND_ON_STORES / ( CPU_CLK_UN=
HALTED.THREAD ) )",
+        "MetricGroup": "MemoryBound;TmaL3mem;TmaL3;m_tma_memory_bound_perc=
ent",
+        "MetricName": "tma_store_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck.  Shortage in hardware comput=
e resources; or dependencies in software's instructions are both categorize=
d under Core Bound. Hence it may indicate the machine ran out of an out-of-=
order resource; certain execution units are overloaded or dependencies in p=
rogram's data- or instruction-flow are limiting the performance (e.g. FP-ch=
ained long-latency arithmetic operations).",
+        "MetricExpr": "100 * ( ( 1 - ( IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4=
 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALT=
ED.THREAD ) ) ) ) - ( UOPS_ISSUED.ANY + ( 4 ) * ( ( INT_MISC.RECOVERY_CYCLE=
S_ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( ( CP=
U_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD )=
 ) ) ) - ( ( ( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVITY.BOUND_ON_STORES=
 ) / ( CYCLE_ACTIVITY.STALLS_TOTAL + ( EXE_ACTIVITY.1_PORTS_UTIL + ( ( UOPS=
_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) i=
f #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) * EXE_ACTIVITY.2_PORTS_UTI=
L ) + EXE_ACTIVITY.BOUND_ON_STORES ) ) * ( 1 - ( IDQ_UOPS_NOT_DELIVERED.COR=
E / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_C=
LK_UNHALTED.THREAD ) ) ) ) - ( UOPS_ISSUED.ANY + ( 4 ) * ( ( INT_MISC.RECOV=
ERY_CYCLES_ANY / 2 ) if #SMT_on else INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) ) )",
+        "MetricGroup": "Backend;TmaL2;Compute;m_tma_backend_bound_percent"=
,
+        "MetricName": "tma_core_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active. Divide and square root instructions are per=
formed by the Divider unit and can take considerably longer latency than in=
teger or Floating Point addition; subtraction; or multiplication.",
+        "MetricExpr": "100 * ( ARITH.DIVIDER_ACTIVE / ( CPU_CLK_UNHALTED.T=
HREAD ) )",
+        "MetricGroup": "TmaL3;m_tma_core_bound_percent",
+        "MetricName": "tma_divider_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related).  Two distinct categories can be attributed into this met=
ric: (1) heavy data-dependency among contiguous instructions would manifest=
 in this metric - such cases are often referred to as low Instruction Level=
 Parallelism (ILP). (2) Contention on some hardware execution unit other th=
an Divider. For example; when there are too many multiply operations.",
+        "MetricExpr": "100 * ( ( EXE_ACTIVITY.EXE_BOUND_0_PORTS + ( EXE_AC=
TIVITY.1_PORTS_UTIL + ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_C=
LK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) =
) ) * EXE_ACTIVITY.2_PORTS_UTIL ) ) / ( CPU_CLK_UNHALTED.THREAD ) if ( ARIT=
H.DIVIDER_ACTIVE < ( CYCLE_ACTIVITY.STALLS_TOTAL - CYCLE_ACTIVITY.STALLS_ME=
M_ANY ) ) else ( EXE_ACTIVITY.1_PORTS_UTIL + ( ( UOPS_RETIRED.RETIRE_SLOTS =
) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_C=
LK_UNHALTED.THREAD ) ) ) ) * EXE_ACTIVITY.2_PORTS_UTIL ) / ( CPU_CLK_UNHALT=
ED.THREAD ) )",
+        "MetricGroup": "PortsUtil;TmaL3;m_tma_core_bound_percent",
+        "MetricName": "tma_ports_utilization_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired. Ideally=
; all pipeline slots would be attributed to the Retiring category.  Retirin=
g of 100% would indicate the maximum Pipeline_Width throughput was achieved=
.  Maximizing Retiring typically increases the Instructions-per-cycle (see =
IPC metric). Note that a high Retiring value does not necessary mean there =
is no room for more performance.  For example; Heavy-operations or Microcod=
e Assists are categorized under Retiring. They often indicate suboptimal pe=
rformance and can often be optimized or avoided. ",
+        "MetricExpr": "100 * ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * (=
 ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THR=
EAD ) ) ) )",
+        "MetricGroup": "TmaL1",
+        "MetricName": "tma_retiring_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UPI metric=
) ratio of 1 or less should be expected for decently optimized software run=
ning on Intel Core/Xeon products. While this often indicates efficient X86 =
instructions were executed; high value does not necessarily mean better per=
formance cannot be achieved.",
+        "MetricExpr": "100 * ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) *=
 ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.T=
HREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FUSE=
D - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if=
 #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) )",
+        "MetricGroup": "Retire;TmaL2;m_tma_retiring_percent",
+        "MetricName": "tma_light_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired). Note t=
his metric's value may exceed its parent due to use of \"Uops\" CountDomain=
 and FMA double-counting.",
+        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) * UOPS_EXECUTED.X87 / UOPS_EXECUTED.THREAD ) + ( ( FP_ARITH=
_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) / ( UOP=
S_RETIRED.RETIRE_SLOTS ) ) + ( min( ( ( FP_ARITH_INST_RETIRED.128B_PACKED_D=
OUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.25=
6B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST=
_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / =
( UOPS_RETIRED.RETIRE_SLOTS ) ) , ( 1 ) ) ) )",
+        "MetricGroup": "HPC;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_fp_arith_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FU=
SED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) =
if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) * MEM_INST_RETIRED.ANY =
/ INST_RETIRED.ANY )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_memory_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JCC=
 are commonly used examples.",
+        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FU=
SED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) =
if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) * UOPS_RETIRED.MACRO_FU=
SED / ( UOPS_RETIRED.RETIRE_SLOTS ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_fused_instructions_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused. Non-conditi=
onal branches like direct JMP or CALL would count here. Can be used to exam=
ine fusible conditional jumps that were not fused.",
+        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FU=
SED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) =
if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) * ( BR_INST_RETIRED.ALL=
_BRANCHES - UOPS_RETIRED.MACRO_FUSED ) / ( UOPS_RETIRED.RETIRE_SLOTS ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_non_fused_branches_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions. Compilers often use NOPs f=
or certain address alignments - e.g. start address of a function or loop bo=
dy.",
+        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 )=
 * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED=
.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FU=
SED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) =
if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) * INST_RETIRED.NOP / ( =
UOPS_RETIRED.RETIRE_SLOTS ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_nop_instructions_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes. May undercount due to FMA double counting",
+        "MetricExpr": "100 * ( max( 0 , ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) =
/ ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK=
_UNHALTED.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED=
.MACRO_FUSED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_A=
NY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) ) - ( ( ( ( ( UO=
PS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 )=
 if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) * UOPS_EXECUTED.X87 / UO=
PS_EXECUTED.THREAD ) + ( ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_I=
NST_RETIRED.SCALAR_DOUBLE ) / ( UOPS_RETIRED.RETIRE_SLOTS ) ) + ( min( ( ( =
FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKE=
D_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED=
.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_I=
NST_RETIRED.512B_PACKED_SINGLE ) / ( UOPS_RETIRED.RETIRE_SLOTS ) ) , ( 1 ) =
) ) ) + ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTE=
D.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( =
( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FUSED - INST_RETIRED.ANY=
 ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_=
CLK_UNHALTED.THREAD ) ) ) ) ) * MEM_INST_RETIRED.ANY / INST_RETIRED.ANY ) +=
 ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREA=
D_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( ( UOPS_=
RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FUSED - INST_RETIRED.ANY ) / ( =
( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNH=
ALTED.THREAD ) ) ) ) ) * UOPS_RETIRED.MACRO_FUSED / ( UOPS_RETIRED.RETIRE_S=
LOTS ) ) + ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHA=
LTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - (=
 ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETIRED.MACRO_FUSED - INST_RETIRED.=
ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( C=
PU_CLK_UNHALTED.THREAD ) ) ) ) ) * ( BR_INST_RETIRED.ALL_BRANCHES - UOPS_RE=
TIRED.MACRO_FUSED ) / ( UOPS_RETIRED.RETIRE_SLOTS ) ) + ( ( ( ( UOPS_RETIRE=
D.RETIRE_SLOTS ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_=
on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( ( UOPS_RETIRED.RETIRE_SLOTS=
 ) + UOPS_RETIRED.MACRO_FUSED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_=
UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) )=
 ) * INST_RETIRED.NOP / ( UOPS_RETIRED.RETIRE_SLOTS ) ) ) ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_other_light_ops_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences. This highly-correlates with the =
uop length of these instructions/sequences.",
+        "MetricExpr": "100 * ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RETI=
RED.MACRO_FUSED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREA=
D_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) )",
+        "MetricGroup": "Retire;TmaL2;m_tma_retiring_percent",
+        "MetricName": "tma_heavy_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number of=
 uops in such instructions.",
+        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) + UOPS_RE=
TIRED.MACRO_FUSED - INST_RETIRED.ANY ) / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THR=
EAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( ( UOP=
S_RETIRED.RETIRE_SLOTS ) / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( ( 4 ) * ( ( =
CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else ( CPU_CLK_UNHALTED.THREAD=
 ) ) ) ) )",
+        "MetricGroup": "TmaL3;m_tma_heavy_operations_percent",
+        "MetricName": "tma_few_uops_instructions_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The MS=
 is used for CISC instructions not supported by the default decoders (like =
repeat move strings; or CPUID); or by microcode assists used to address som=
e operation modes (like in Floating Point assists). These cases can often b=
e avoided.",
+        "MetricExpr": "100 * ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) / UOPS_ISSU=
ED.ANY ) * IDQ.MS_UOPS / ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if=
 #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) ) )",
+        "MetricGroup": "MicroSeq;TmaL3;m_tma_heavy_operations_percent",
+        "MetricName": "tma_microcode_sequencer_percent",
+        "ScaleUnit": "1%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
index 41a3d13fc4b2..48bb1b38dde6 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
@@ -120,4 +120,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1e"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json b/to=
ols/perf/pmu-events/arch/x86/cascadelakex/frontend.json
index ecce4273ae52..8633ee406813 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
@@ -527,4 +527,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json b/tools=
/perf/pmu-events/arch/x86/cascadelakex/other.json
index 60d8a99813b9..6baa338e72f1 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/other.json
@@ -39,6 +39,69 @@
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
+    {
+        "BriefDescription": "CORE_SNOOP_RESPONSE.RSP_IFWDFE",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xEF",
+        "EventName": "CORE_SNOOP_RESPONSE.RSP_IFWDFE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "CORE_SNOOP_RESPONSE.RSP_IFWDM",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xEF",
+        "EventName": "CORE_SNOOP_RESPONSE.RSP_IFWDM",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "CORE_SNOOP_RESPONSE.RSP_IHITFSE",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xEF",
+        "EventName": "CORE_SNOOP_RESPONSE.RSP_IHITFSE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "CORE_SNOOP_RESPONSE.RSP_IHITI",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xEF",
+        "EventName": "CORE_SNOOP_RESPONSE.RSP_IHITI",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "CORE_SNOOP_RESPONSE.RSP_SFWDFE",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xEF",
+        "EventName": "CORE_SNOOP_RESPONSE.RSP_SFWDFE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "CORE_SNOOP_RESPONSE.RSP_SFWDM",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xEF",
+        "EventName": "CORE_SNOOP_RESPONSE.RSP_SFWDM",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "CORE_SNOOP_RESPONSE.RSP_SHITFSE",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xEF",
+        "EventName": "CORE_SNOOP_RESPONSE.RSP_SHITFSE",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Number of hardware interrupts received by the=
 processor.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
index 79fda10ec4bb..f085b9145952 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
@@ -165,6 +165,17 @@
         "SampleAfterValue": "400009",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xC5",
+        "EventName": "BR_MISP_RETIRED.RET",
+        "PEBS": "1",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Core crystal clock cycles when this thread is=
 unhalted and the other thread is halted.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
index a416515d41da..e82c6fa053a1 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
@@ -84,6 +84,15 @@
         "UMask": "0x4",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Pre-charge for writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_M_PRE_COUNT.WR",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Write requests allocated in the PMM Write Pen=
ding Queue for Intel Optane DC persistent memory",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json =
b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index aa460d0c4851..f301385845a4 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
@@ -155,6 +155,15 @@
         "UMask": "0x04",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "write requests from remote home agent",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x08",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "UPI interconnect send bandwidth for payload. =
Derived from unc_upi_txl_flits.all_data",
         "Counter": "0,1,2,3",
@@ -620,6 +629,83 @@
         "UMask": "0x10",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "TOR Inserts : CRds issued by iA Cores that Hi=
t the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
+        "Filter": "config1=3D0x40233",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : DRds issued by iA Cores that Hi=
t the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD",
+        "Filter": "config1=3D0x40433",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRds issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
+        "Filter": "config1=3D0x4b233",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefCRD",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
+        "Filter": "config1=3D0x4b433",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefDRD",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores t=
hat hit the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LlcPrefRFO",
+        "Filter": "config1=3D0x4b033",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that hit the LLC : Counts the number of entries successfully inserted into =
the TOR that match qualifications specified by the subevent.   Does not inc=
lude addressless requests such as locks and interrupts.",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Hi=
t the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
+        "Filter": "config1=3D0x40033",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that H=
it the LLC : Counts the number of entries successfully inserted into the TO=
R that match qualifications specified by the subevent.   Does not include a=
ddressless requests such as locks and interrupts.",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : CRds issued by iA Cores that Mi=
ssed the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
+        "Filter": "config1=3D0x40233",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Inserts : DRds issued by iA Cores that Mi=
ssed the LLC",
         "Counter": "0,1,2,3",
@@ -631,6 +717,132 @@
         "UMask": "0x21",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
+        "Filter": "config1=3D0x4b233",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefCRD",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
+        "Filter": "config1=3D0x4b433",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefDRD",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores t=
hat missed the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LlcPrefRFO",
+        "Filter": "config1=3D0x4b033",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that missed the LLC : Counts the number of entries successfully inserted in=
to the TOR that match qualifications specified by the subevent.   Does not =
include addressless requests such as locks and interrupts.",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts : RFOs issued by iA Cores that Mi=
ssed the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
+        "Filter": "config1=3D0x40033",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC : Counts the number of entries successfully inserted into the=
 TOR that match qualifications specified by the subevent.   Does not includ=
e addressless requests such as locks and interrupts.",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_ALL",
+        "Filter": "CHAfilter1",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. ",
+        "UMask": "0x30",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "Filter": "config1=3D0x40233",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "Filter": "config1=3D0x40433",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
+        "Filter": "config1=3D0x4b233",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefCRD",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
+        "Filter": "config1=3D0x4b433",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefDRD",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
+        "Filter": "config1=3D0x4b033",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LlcPrefRFO",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "Filter": "config1=3D0x40033",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
+        "Filter": "config1=3D0x40233",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "TOR Occupancy : DRds issued by iA Cores that =
Missed the LLC",
         "EventCode": "0x36",
@@ -641,13 +853,359 @@
         "UMask": "0x21",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
+        "Filter": "config1=3D0x4b233",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefCRD",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
+        "Filter": "config1=3D0x4b433",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefDRD",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
+        "Filter": "config1=3D0x4b033",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LlcPrefRFO",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "Filter": "config1=3D0x40033",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CLOCKTICKS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventName": "UNC_C_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_CLOCKTICKS",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_FAST_ASSERTED.HORZ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0xA5",
+        "EventName": "UNC_C_FAST_ASSERTED",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_FAST_ASSERTED.HORZ",
+        "UMask": "0x02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.E_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_F",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.F_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_LLC_VICTIMS.TOTAL_F",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.M_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x37",
+        "EventName": "UNC_C_LLC_VICTIMS.S_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.REM_ALL",
+        "Filter": "CHAfilter1",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. ",
+        "UMask": "0x30",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CORE_SNP.CORE_GTONE",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_CORE_SNP.CORE_GTONE",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_CORE_SNP.CORE_GTONE",
+        "UMask": "0x42",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_CORE_SNP.EVICT_GTONE",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x33",
+        "EventName": "UNC_H_CORE_SNP.EVICT_GTONE",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_CORE_SNP.EVICT_GTONE",
+        "UMask": "0x82",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_LOOKUP.NO_SNP",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_DIR_LOOKUP.NO_SNP",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_LOOKUP.NO_SNP",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_LOOKUP.SNP",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x53",
+        "EventName": "UNC_H_DIR_LOOKUP.SNP",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_LOOKUP.SNP",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_UPDATE.HA",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_DIR_UPDATE.HA",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_UPDATE.HA",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_DIR_UPDATE.TOR",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x54",
+        "EventName": "UNC_H_DIR_UPDATE.TOR",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_DIR_UPDATE.TOR",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_HITME_HIT.EX_RDS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5F",
+        "EventName": "UNC_H_HITME_HIT.EX_RDS",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_HITME_HIT.EX_RDS",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_MISC.RFO_HIT_S",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x39",
+        "EventName": "UNC_H_MISC.RFO_HIT_S",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_MISC.RFO_HIT_S",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.INVITOE_LOCAL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.INVITOE_LOCAL",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.INVITOE_REMOTE",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.INVITOE_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.INVITOE_REMOTE",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.READS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.READS",
+        "UMask": "0x3",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.READS_LOCAL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.READS_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.READS_LOCAL",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.WRITES",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.WRITES",
+        "UMask": "0xC",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_REQUESTS.WRITES_LOCAL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x50",
+        "EventName": "UNC_H_REQUESTS.WRITES_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_REQUESTS.WRITES_LOCAL",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_INSERTS.IRQ",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x13",
+        "EventName": "UNC_H_RxC_INSERTS.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_RxC_INSERTS.IRQ",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x19",
+        "EventName": "UNC_H_RxC_IRQ1_REJECT.PA_MATCH",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "Deprecated": "1",
+        "EventCode": "0x11",
+        "EventName": "UNC_H_RxC_OCCUPANCY.IRQ",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5C",
+        "EventName": "UNC_H_SNOOP_RESP.RSPCNFLCT",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSPCNFLCTS",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSPIFWD",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5C",
+        "EventName": "UNC_H_SNOOP_RESP.RSPIFWD",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSPIFWD",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSPSFWD",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5C",
+        "EventName": "UNC_H_SNOOP_RESP.RSPSFWD",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSPSFWD",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x5C",
+        "EventName": "UNC_H_SNOOP_RESP.RSP_FWD_WB",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_CHA_SNOOP_RESP.RSP_FWD_WB",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Clockticks of the IIO Traffic Controller",
         "Counter": "0,1,2,3",
         "EventCode": "0x1",
         "EventName": "UNC_IIO_CLOCKTICKS",
         "PerPkg": "1",
-        "PublicDescription": "Counts clockticks of the 1GHz trafiic contro=
ller clock in the IIO unit.",
+        "PublicDescription": "Counts clockticks of the 1GHz traffic contro=
ller clock in the IIO unit.",
         "Unit": "IIO"
     },
     {
@@ -1053,6 +1611,110 @@
         "UMask": "0x02",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_READ.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART0",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART1",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x2",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART2",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x4",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "Counter": "0,1",
+        "Deprecated": "1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_PAYLOAD_BYTES_IN.MEM_WRITE.PART3",
+        "FCMask": "0x7",
+        "PerPkg": "1",
+        "PortMask": "0x8",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Read request for up to a 64 byte transaction =
is made by the CPU to IIO Part0",
         "Counter": "0,1,2,3",
@@ -1898,6 +2560,17 @@
         "UMask": "0x1",
         "Unit": "UPI LL"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_DIRECT_ATTEMPTS.D2U",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x12",
+        "EventName": "UNC_UPI_DIRECT_ATTEMPTS.D2K",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_UPI_DIRECT_ATTEMPTS.D2U",
+        "UMask": "0x2",
+        "Unit": "UPI LL"
+    },
     {
         "BriefDescription": "Data Response packets that go direct to Intel=
 UPI",
         "Counter": "0,1,2,3",
@@ -1986,6 +2659,17 @@
         "UMask": "0x97",
         "Unit": "UPI LL"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_RxL_FLITS.ALL_NULL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x3",
+        "EventName": "UNC_UPI_RxL_FLITS.NULL",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_UPI_RxL_FLITS.ALL_NULL",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
+    },
     {
         "BriefDescription": "Cycles in which the Tx of the Intel Ultra Pat=
h Interconnect (UPI) is in L0p power mode",
         "Counter": "0,1,2,3",
@@ -2043,5 +2727,16 @@
         "PublicDescription": "Counts protocol header and credit FLITs (80 =
bit FLow control unITs) transmitted across any of the 3 UPI (Ultra Path Int=
erconnect) slots on this UPI unit.",
         "UMask": "0x97",
         "Unit": "UPI LL"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_UPI_TxL_FLITS.ALL_NULL",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.NULL",
+        "PerPkg": "1",
+        "PublicDescription": "This event is deprecated. Refer to new event=
 UNC_UPI_TxL_FLITS.ALL_NULL",
+        "UMask": "0x20",
+        "Unit": "UPI LL"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
index 792ca39f013a..dd334b416c57 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
@@ -281,4 +281,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index dbd6bcbbca8b..dcaa68b09717 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -4,6 +4,7 @@ GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v23,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
+GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
 GenuineIntel-6-5C,v8,goldmont,core
 GenuineIntel-6-7A,v1,goldmontplus,core
 GenuineIntel-6-3C,v24,haswell,core
@@ -29,7 +30,6 @@ GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55-[01234],v1,skylakex,core
-GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
 GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-8[CD],v1,tigerlake,core
--=20
2.37.1.359.gd136c6c3e2-goog

