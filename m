Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104F4580792
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiGYWjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbiGYWiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:38:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C46C25E81
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u6-20020a25b7c6000000b00670862c5b16so9572519ybj.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=s8Z1gg4MNC16/7wnDLjf7TdnVErPxCFuOqtOUGpUljs=;
        b=EnCohWP96Wp3EAbJf8OypeAFxLCQhMshE4k6owzHluPfu7RquOoPVm4X/ioebAvWOH
         wJ/PUpDKjfTgD0A4cfiH61jc5S0netxnF3jmYt/ZJ6XxmEyHAt0BGqnfrgn3VpR53coc
         w+Nd4TmpXZ43pVLWxeTMQE6i3QxTLb6Qspu4nIbDcRufIhArpDKyc2Jcg0bSmuPdaFRs
         yMzwRpfDm3O/81lEAv5oIcuTjW38o2iogP/x7LGf66RkSVTHbcDzR5D0hWDtKOwZdIKu
         Uqj8VltxHNbo70Lp8+Ji3fPgYw5nwIQK5czf2kwA+TzYRlN31ssIaR8Et8DA+6rvTbjP
         nm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=s8Z1gg4MNC16/7wnDLjf7TdnVErPxCFuOqtOUGpUljs=;
        b=VumXIbRYLmN1TJXsOm1Rq8zF8uQVT+BDbI4CaO+eCgzYjF7EDrqtf7gUzgvn2GyqAd
         W1+jtTEHwWA2JQnDfYmtGpUgTUVNSm+Rtr09hGPRDIAGAUwYMzggyi6owpSTthmG4lw2
         bT/yVKWI1Oti/0tGBzzoAFmL+TtFkZXuOBNs92RDQnOMX34XzamKFx66sR5uGJpfEVvv
         v/v5YbfGxCPycAK+/sJZIh5R4bX7mFfsFOptuwWwFuoCKOUtIoWRsJLq67Di84ft3YLo
         IaGTMNcTM3CCHa4MqPb6/1aOsc6ojUWt1qrjeCowdXFRMFySodRsldPis55h5cDahH2z
         WIvQ==
X-Gm-Message-State: AJIora9uHgwxaxzxDVAsmBEXycxDSKC3x8XgGx/AtDC3dcSekrCkZ4cx
        Yr8smd0AYHQ5m93nu4rT2hCG/LCOqWG8
X-Google-Smtp-Source: AGRyM1uz+sfuWQRoy6AefP4ue7rPKvUZ4ZAYqvCGx8SHAi6AmHYi1byLBIWf850n/QxK5parjzL6fp8B4JK/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:bcc6:0:b0:670:c602:ade5 with SMTP id
 l6-20020a25bcc6000000b00670c602ade5mr10859739ybm.209.1658788644681; Mon, 25
 Jul 2022 15:37:24 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:16 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-16-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 15/32] perf vendor events: Update Intel ivybridge
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

Update to v22, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the ivybridge files into perf and update mapfile.csv.

Tested on a non-ivybridge with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/ivybridge/cache.json  |  2 +-
 .../arch/x86/ivybridge/floating-point.json    |  2 +-
 .../arch/x86/ivybridge/frontend.json          |  2 +-
 .../arch/x86/ivybridge/ivb-metrics.json       | 94 +++++++++++++------
 .../pmu-events/arch/x86/ivybridge/memory.json |  2 +-
 .../pmu-events/arch/x86/ivybridge/other.json  |  2 +-
 .../arch/x86/ivybridge/pipeline.json          |  4 +-
 .../arch/x86/ivybridge/uncore-other.json      |  2 +-
 .../arch/x86/ivybridge/virtual-memory.json    |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 10 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json b/tools/pe=
rf/pmu-events/arch/x86/ivybridge/cache.json
index 62e9705daa19..8adb2e45e23d 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/cache.json
@@ -1099,4 +1099,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json b=
/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
index db8b1c4fceb0..4c2ac010cf55 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
@@ -166,4 +166,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json b/tools=
/perf/pmu-events/arch/x86/ivybridge/frontend.json
index c956a0a51312..2b1a82dd86ab 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
@@ -312,4 +312,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/to=
ols/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index 87670226f52d..3f48e75f8a86 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
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
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/memory.json b/tools/p=
erf/pmu-events/arch/x86/ivybridge/memory.json
index 5f98f7746cf7..30fc0af61eb3 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/memory.json
@@ -233,4 +233,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/other.json b/tools/pe=
rf/pmu-events/arch/x86/ivybridge/other.json
index 83fe8f79adc6..2d62521791d8 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/other.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/other.json
@@ -41,4 +41,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/tools=
/perf/pmu-events/arch/x86/ivybridge/pipeline.json
index 2de31c56c2a5..d89d3f8db190 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
@@ -676,7 +676,7 @@
         "UMask": "0x3"
     },
     {
-        "BriefDescription": "Number of occurences waiting for the checkpoi=
nts in Resource Allocation Table (RAT) to be recovered after Nuke due to al=
l other cases except JEClear (e.g. whenever a ucode assist is needed like S=
SE exception, memory disambiguation, etc.)",
+        "BriefDescription": "Number of occurrences waiting for the checkpo=
ints in Resource Allocation Table (RAT) to be recovered after Nuke due to a=
ll other cases except JEClear (e.g. whenever a ucode assist is needed like =
SSE exception, memory disambiguation, etc.)",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
@@ -1269,4 +1269,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json
index 6278068908cf..88f1e326205f 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/uncore-other.json
@@ -82,10 +82,10 @@
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
         "Counter": "Fixed",
+        "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
         "PublicDescription": "This 48-bit fixed counter counts the UCLK cy=
cles.",
-        "UMask": "0x01",
         "Unit": "ARB"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
index 8cf1549797b0..a5e387bbb134 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
@@ -177,4 +177,4 @@
         "SampleAfterValue": "100007",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 727631ce1a57..cc34f6378d89 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -12,7 +12,7 @@ GenuineIntel-6-(3C|45|46),v31,haswell,core
 GenuineIntel-6-3F,v25,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.14,icelake,core
 GenuineIntel-6-6[AC],v1.15,icelakex,core
-GenuineIntel-6-3A,v18,ivybridge,core
+GenuineIntel-6-3A,v22,ivybridge,core
 GenuineIntel-6-3E,v19,ivytown,core
 GenuineIntel-6-2D,v20,jaketown,core
 GenuineIntel-6-57,v9,knightslanding,core
--=20
2.37.1.359.gd136c6c3e2-goog

