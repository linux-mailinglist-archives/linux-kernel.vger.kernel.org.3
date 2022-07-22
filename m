Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB957E9D4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiGVWgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiGVWe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:34:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8B5BE9FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:34:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m11-20020a5b040b000000b0066fcc60d1a0so4626617ybp.19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=k7WM17JdAKpRApVCOFd5eVtlGUbBVWjaA0CuxmUJdz0=;
        b=TGG6/vnyjRPhnIotIXmv7wSm6+x7LST+TqyQTdOdUWiHk8UG/jZ5C0vAERHQga7tTc
         0mg0Vbvzq/WtM2h75ws2xljIju8OJiukfhpnc7cpfV1+fWJzH5V3hEKUQwhnEUx5+78V
         n1sVkp563beSrIHcV0PstKz8OCkSI9uV/QMwYODI/ZoafyQ57Jut6ybU9W01jYyjv/HI
         KnXKfQv/EVFRp2XIkyWwOnCzKBO5OYG6KqWeLqoe16836aQBcu7oNKQm8011TZeHIGkp
         c9kS1kWCkqbejKb8hf5ZPyIkLTmPJBJTg9gp3Ioqw0inIKa+Nb1+IpH423DENzFNc20H
         aagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=k7WM17JdAKpRApVCOFd5eVtlGUbBVWjaA0CuxmUJdz0=;
        b=OSIbDuuNXGWXlYOjnHisZePGlVNSNTgGfU+jd307fw8l6e4DodoWYNI39GeulVxRyW
         olbYX1bhDk1cR6T2gIkJSol4gJy2PbtpdMIkUfJtY2e226fiyy029QxbH7Biy/vriU2C
         NkKaw1JVF2qUob3Q/PCYovj43w1sCdU3u7F2chlaNL6Ev9JaXYSnWHxpUD3qXsuQPaE8
         JmlBX3HDa8VEQQzAZ4A6nqc8OGBCi1whksxpNn7V/GNhp/CYJR+KwaYyNC7FHYvO0eUi
         T4TE2gcJuZ9n5C/2IFIyw00NdE95PR7lE1E0oRxunY69hSZN/U8qzw2OA4bNLIxcZx6M
         JgFA==
X-Gm-Message-State: AJIora8OA9qPRWvK5otgb+SC3+I8CLvHV2LamdwBbPwd5Fm4gs/QrP93
        NGHHCQI8YQyj/JT56MbWK+asdQXxsSXd
X-Google-Smtp-Source: AGRyM1t9rZ4wJncyx+9ffTFt4B/YmsqA1M0NdmtZVG5DMlsS+RL85BpuqeF/B4DW/HzTLXGEYkrkRxQnwmJY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:bfcb:0:b0:670:8107:3fc7 with SMTP id
 q11-20020a25bfcb000000b0067081073fc7mr1725720ybm.429.1658529237394; Fri, 22
 Jul 2022 15:33:57 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:34 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-26-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 25/31] perf vendor events: Update Intel skylake
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
the skylake files into perf and update mapfile.csv.

Tested on a non-skylake with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 .../arch/x86/skylake/floating-point.json      |   2 +-
 .../pmu-events/arch/x86/skylake/frontend.json |   2 +-
 .../pmu-events/arch/x86/skylake/other.json    |   2 +-
 .../arch/x86/skylake/skl-metrics.json         | 178 ++++++++----
 .../arch/x86/skylake/uncore-cache.json        | 142 ++++++++++
 .../arch/x86/skylake/uncore-other.json        |  79 ++++++
 .../pmu-events/arch/x86/skylake/uncore.json   | 254 ------------------
 .../arch/x86/skylake/virtual-memory.json      |   2 +-
 9 files changed, 345 insertions(+), 319 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-cache.jso=
n
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-other.jso=
n
 delete mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore.json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index d224d59e3c72..4a38edc7c270 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,8 +22,7 @@ GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
 GenuineIntel-6-8F,v1.04,sapphirerapids,core
 GenuineIntel-6-(37|4C|4D),v14,silvermont,core
-GenuineIntel-6-[4589]E,v24,skylake,core
-GenuineIntel-6-A[56],v24,skylake,core
+GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
diff --git a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/skylake/floating-point.json
index 73cfb2a39722..d6cee5ae4402 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/floating-point.json
@@ -70,4 +70,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1e"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/frontend.json b/tools/p=
erf/pmu-events/arch/x86/skylake/frontend.json
index ecce4273ae52..8633ee406813 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/frontend.json
@@ -527,4 +527,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/other.json b/tools/perf=
/pmu-events/arch/x86/skylake/other.json
index 4f4839024915..8f4bc8892c47 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/other.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/other.json
@@ -17,4 +17,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tool=
s/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index defbca9a6038..73fa72d3dcb1 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
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
@@ -214,42 +214,36 @@
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
@@ -334,12 +328,30 @@
         "MetricName": "IpArith_AVX256",
         "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). May undercount due=
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
@@ -353,23 +365,47 @@
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
@@ -395,11 +431,10 @@
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
@@ -407,30 +442,6 @@
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
@@ -450,13 +461,13 @@
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
@@ -480,7 +491,7 @@
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
@@ -498,6 +509,54 @@
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
@@ -514,7 +573,8 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/skylake/uncore-cache.json
new file mode 100644
index 000000000000..edb1014bee0f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/skylake/uncore-cache.json
@@ -0,0 +1,142 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/skylake/uncore-other.json
new file mode 100644
index 000000000000..bf5d4acdd6b8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/skylake/uncore-other.json
@@ -0,0 +1,79 @@
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
+        "BriefDescription": "Number of all Core entries outstanding for th=
e memory controller. The outstanding interval starts after LLC miss till re=
turn of first data chunk. Accounts for Coherent and non-coherent traffic.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
+        "PerPkg": "1",
+        "PublicDescription": "Number of all Core entries outstanding for t=
he memory controller. The outstanding interval starts after LLC miss till r=
eturn of first data chunk. Accounts for Coherent and non-coherent traffic."=
,
+        "UMask": "0x01",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Cycles with at least one request outstanding =
is waiting for data return from memory controller. Account for coherent and=
 non-coherent requests initiated by IA Cores, Processor Graphics Unit, or L=
LC.",
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
+        "BriefDescription": "Number of Core Data Read entries outstanding =
for the memory controller. The outstanding interval starts after LLC miss t=
ill return of first data chunk.",
+        "EventCode": "0x80",
+        "EventName": "UNC_ARB_TRK_OCCUPANCY.DATA_READ",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Core Data Read entries outstanding=
 for the memory controller. The outstanding interval starts after LLC miss =
till return of first data chunk.",
+        "UMask": "0x02",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Core coherent Data Read requests se=
nt to memory controller whose data is returned directly to requesting agent=
.",
+        "Counter": "0,1",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.DATA_READ",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Core coherent Data Read requests s=
ent to memory controller whose data is returned directly to requesting agen=
t.",
+        "UMask": "0x02",
+        "Unit": "ARB"
+    },
+    {
+        "BriefDescription": "Number of Core coherent Data Read requests se=
nt to memory controller whose data is returned directly to requesting agent=
.",
+        "Counter": "0,1",
+        "EventCode": "0x81",
+        "EventName": "UNC_ARB_TRK_REQUESTS.DRD_DIRECT",
+        "PerPkg": "1",
+        "PublicDescription": "Number of Core coherent Data Read requests s=
ent to memory controller whose data is returned directly to requesting agen=
t.",
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
diff --git a/tools/perf/pmu-events/arch/x86/skylake/uncore.json b/tools/per=
f/pmu-events/arch/x86/skylake/uncore.json
deleted file mode 100644
index dbc193252fb3..000000000000
--- a/tools/perf/pmu-events/arch/x86/skylake/uncore.json
+++ /dev/null
@@ -1,254 +0,0 @@
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
d entries. Such entry is defined as valid from its allocation till first of=
 IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent =
traffic.",
-    "PublicDescription": "Each cycle count number of all Core outgoing val=
id entries. Such entry is defined as valid from its allocation till first o=
f IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coherent=
 traffic.",
-    "Counter": "0",
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
-    "Counter": "0",
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
diff --git a/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json b/t=
ools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
index 792ca39f013a..dd334b416c57 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
@@ -281,4 +281,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
--=20
2.37.1.359.gd136c6c3e2-goog

