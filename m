Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056F5580794
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbiGYWjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbiGYWiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:38:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554002656A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t10-20020a5b07ca000000b0066ec1bb6e2cso9529978ybq.14
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=y/ASaMNJo6FVPRi/R108TL5H8Bj4jCMY2XL1i2j2z4I=;
        b=CxYit9k9iNUPv/kLJ+ypPtXAlyVAgE+UuYNttMxhe/mYNf1AwsIYXc7j3I1kDKInhT
         c7BfmP1Jp/Lzns6O4nCJtPol0os4XO+woiujip5PFWOGcaGUOOl34CfixysAGD8aSqJA
         VAj3Vee8bC4dADFMQc5syADeXw3Rk8bv/2+FYWNDlKP3ud7qdCjw+pVfOKqz8G+ddHA5
         ScN6tFqEEJpGOhYmXa+NNgoor88Xx63o+4y0Gi0e4z9tlOpPA9TebtA9NeS/kGYxVw4R
         bafblMp3TdB/W5vsx2fVa4Ysol2RrMQguWaLUBG1hAid2f+/+KNejcMx36mHIKRiwEHn
         nXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=y/ASaMNJo6FVPRi/R108TL5H8Bj4jCMY2XL1i2j2z4I=;
        b=gthyFssjJb40Yl9PtVEX+xAsTbw02gGOrzwPY006KcJaWBns0GRD3SMQUic7yVTc2Z
         aivk4HsgLV3lOIMe0gfsfVdf/yvQmq0lPjqNlLNVjzmG2/zu1/tbaGW2DHj6hjAuquhh
         22vEeX5ulQycbexvxBvw3WsAlFmgrCJ/5Ef5oN8WGuda5oBVb+FPT5b3w+hfEy31TBEN
         cOU/yE9Qdc6CgNYF/2KuDlH943itw1Xchl8MwexVaG1vWwQQXOqDpRGTnP4cv6M50TIu
         ZbdMTiNN62e+7maKQ9FV1X9zI4kkOt29ZEOySLWWZMgmzbKuYqw6yGUPKm49bGNP2NWG
         zwGA==
X-Gm-Message-State: AJIora8l4tlMRaCFQ4t8koT7PROC6msEi3cfQ63gSwqPzwCdEZfGcJmO
        6YgQv4E0i73wQvgoXrWmuTXdja10SWmf
X-Google-Smtp-Source: AGRyM1uwPeMqf3w+KNj7AW7CMlGYfMOecNV8cFglQ86+1VfndWBzqt7A9+g90agCG4hRt2xoQdxWZa9avwmC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a05:6902:100e:b0:670:d0c4:357c with SMTP
 id w14-20020a056902100e00b00670d0c4357cmr11056713ybt.46.1658788642014; Mon,
 25 Jul 2022 15:37:22 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:15 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-15-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 14/32] perf vendor events: Update Intel icelakex
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

Update to v1.15, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the icelakex files into perf and update mapfile.csv.

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
 .../pmu-events/arch/x86/icelakex/cache.json   |  28 +-
 .../arch/x86/icelakex/floating-point.json     |   2 +-
 .../arch/x86/icelakex/frontend.json           |   2 +-
 .../arch/x86/icelakex/icx-metrics.json        | 691 ++++++++++++++++--
 .../pmu-events/arch/x86/icelakex/memory.json  |   6 +-
 .../pmu-events/arch/x86/icelakex/other.json   |  51 +-
 .../arch/x86/icelakex/pipeline.json           |  12 +
 .../arch/x86/icelakex/virtual-memory.json     |   2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 9 files changed, 689 insertions(+), 108 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/cache.json b/tools/per=
f/pmu-events/arch/x86/icelakex/cache.json
index 95fcbec188f8..775190bdd063 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/cache.json
@@ -291,7 +291,7 @@
         "UMask": "0x4f"
     },
     {
-        "BriefDescription": "All retired load instructions.",
+        "BriefDescription": "Retired load instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -299,12 +299,12 @@
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
@@ -313,7 +313,7 @@
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
@@ -409,7 +409,6 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -473,7 +472,6 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -867,7 +865,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hit=
 in the L3 or were snooped from another core's caches on the same socket.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that hit in the L3 or were snooped from another core's caches on the sa=
me socket.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.L3_HIT",
@@ -878,7 +876,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop hit a modified line in another core's caches which forward=
ed the data.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop hit a modified line in another core's caches w=
hich forwarded the data.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
@@ -889,7 +887,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop that hit in another core, which did not forward the data."=
,
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop that hit in another core, which did not forwar=
d the data.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
@@ -900,7 +898,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop hit in another core's caches which forwarded the unmodifie=
d data to the requesting core.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that resulted in a snoop hit in another core's caches which forwarded t=
he unmodified data to the requesting core.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
@@ -911,7 +909,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by a cache on a remote socket where a snoop was sent and data wa=
s returned (Modified or Not Modified).",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop was sent=
 and data was returned (Modified or Not Modified).",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_FWD",
@@ -922,7 +920,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by a cache on a remote socket where a snoop hit a modified line =
in another core's caches which forwarded the data.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop hit a mo=
dified line in another core's caches which forwarded the data.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HITM",
@@ -933,7 +931,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by a cache on a remote socket where a snoop hit in another core'=
s caches which forwarded the unmodified data to the requesting core.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop hit in a=
nother core's caches which forwarded the unmodified data to the requesting =
core.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
@@ -944,7 +942,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hit=
 a modified line in a distant L3 Cache or were snooped from a distant core'=
s L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) =
mode.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that hit a modified line in a distant L3 Cache or were snooped from a d=
istant core's L1/L2 caches on this socket when the system is in SNC (sub-NU=
MA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HITM",
@@ -955,7 +953,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that eit=
her hit a non-modified line in a distant L3 Cache or were snooped from a di=
stant core's L1/L2 caches on this socket when the system is in SNC (sub-NUM=
A cluster) mode.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that either hit a non-modified line in a distant L3 Cache or were snoop=
ed from a distant core's L1/L2 caches on this socket when the system is in =
SNC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HIT_WITH_FWD",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/floating-point.json b/=
tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
index 4347e2d0d090..1925388969bb 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
@@ -99,4 +99,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json b/tools/=
perf/pmu-events/arch/x86/icelakex/frontend.json
index f217c3211ba2..eb27d9d9c8be 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
@@ -481,4 +481,4 @@
         "Speculative": "1",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index be70672bfdb0..0abdfe433a2c 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -17,24 +17,6 @@
         "MetricGroup": "Ret;Summary",
         "MetricName": "IPC"
     },
-    {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "UOPS_RETIRED.SLOTS / INST_RETIRED.ANY",
-        "MetricGroup": "Pipeline;Ret;Retire",
-        "MetricName": "UPI"
-    },
-    {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "UOPS_RETIRED.SLOTS / BR_INST_RETIRED.NEAR_TAKEN",
-        "MetricGroup": "Branches;Fed;FetchBW",
-        "MetricName": "UpTB"
-    },
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
@@ -50,7 +32,7 @@
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
@@ -73,24 +55,18 @@
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
@@ -181,36 +157,54 @@
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
@@ -242,11 +236,10 @@
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
@@ -254,30 +247,6 @@
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
@@ -297,13 +266,13 @@
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
@@ -321,7 +290,7 @@
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
@@ -333,6 +302,30 @@
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
     {
         "BriefDescription": "Rate of silent evictions from the L2 cache pe=
r Kilo instruction where the evicted lines are dropped (no writeback to L3 =
or memory)",
         "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
@@ -345,6 +338,30 @@
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
@@ -361,7 +378,8 @@
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
@@ -497,5 +515,544 @@
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency"
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
+        "MetricExpr": "(( CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_T=
SC * #SYSTEM_TSC_FREQ ) / 1000000000) / duration_time",
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
+        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA + UNC_CHA=
_TOR_INSERTS.IA_MISS_DRD + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF ) / INST_RE=
TIRED.ANY",
+        "MetricGroup": "",
+        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IA_MISS_CRD ) / INST_RETIRED.=
ANY",
+        "MetricGroup": "",
+        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) in nano seconds",
+        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D / UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( UNC_CHA_CLOCKTICKS / ( source_cou=
nt(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD) * #num_packages ) ) ) * duration_time=
 )",
+        "MetricGroup": "",
+        "MetricName": "llc_demand_data_read_miss_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to local memory in nano=
 seconds",
+        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_LOCAL / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL ) / ( UNC_CHA_CLOCKTICKS / =
( source_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL) * #num_packages ) )=
 ) * duration_time )",
+        "MetricGroup": "",
+        "MetricName": "llc_demand_data_read_miss_latency_for_local_request=
s",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to remote memory in nan=
o seconds",
+        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_REMOTE / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE ) / ( UNC_CHA_CLOCKTICKS =
/ ( source_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_REMOTE) * #num_packages =
) ) ) * duration_time )",
+        "MetricGroup": "",
+        "MetricName": "llc_demand_data_read_miss_latency_for_remote_reques=
ts",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to Intel(R) Optane(TM) =
Persistent Memory(PMEM) in nano seconds",
+        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_PMM / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / ( UNC_CHA_CLOCKTICKS / ( so=
urce_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM) * #num_packages ) ) ) * d=
uration_time )",
+        "MetricGroup": "",
+        "MetricName": "llc_demand_data_read_miss_to_pmem_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to DRAM in nano seconds=
",
+        "MetricExpr": "( ( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_DDR / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_DDR ) / ( UNC_CHA_CLOCKTICKS / ( so=
urce_count(UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR) * #num_packages ) ) ) * d=
uration_time )",
+        "MetricGroup": "",
+        "MetricName": "llc_demand_data_read_miss_to_dram_latency",
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
+        "MetricExpr": "100 * ( UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL + UNC=
_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL ) / ( UNC_CHA_TOR_INSERTS.IA_MISS_D=
RD_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS=
.IA_MISS_DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE )",
+        "MetricGroup": "",
+        "MetricName": "numa_percent_reads_addressed_to_local_dram",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
+        "MetricExpr": "100 * ( UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE + UN=
C_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE ) / ( UNC_CHA_TOR_INSERTS.IA_MISS=
_DRD_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSER=
TS.IA_MISS_DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE )",
+        "MetricGroup": "",
+        "MetricName": "numa_percent_reads_addressed_to_remote_dram",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "Uncore operating frequency in GHz",
+        "MetricExpr": "( UNC_CHA_CLOCKTICKS / ( source_count(UNC_CHA_CLOCK=
TICKS) * #num_packages ) / 1000000000) / duration_time",
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
+        "MetricExpr": "(( UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR + UNC_CHA_TO=
R_INSERTS.IO_MISS_PCIRDCUR ) * 64 / 1000000) / duration_time",
+        "MetricGroup": "",
+        "MetricName": "io_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "MetricExpr": "(( UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_IN=
SERTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR=
_INSERTS.IO_MISS_ITOMCACHENEAR ) * 64 / 1000000) / duration_time",
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
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory.",
+        "MetricExpr": "( UNC_CHA_REQUESTS.WRITES_REMOTE * 64 / 1000000) / =
duration_time",
+        "MetricGroup": "",
+        "MetricName": "llc_miss_remote_memory_bandwidth_write",
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
+        "MetricExpr": "100 * ( topdown\\-fe\\-bound / ( topdown\\-fe\\-bou=
nd + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) - I=
NT_MISC.UOP_DROPPING / ( slots ) )",
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
+        "MetricExpr": "100 * ( ( ( 5 ) * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_U=
OPS_DELIV.CORE - INT_MISC.UOP_DROPPING ) / ( slots ) )",
+        "MetricGroup": "Frontend;TmaL2;m_tma_frontend_bound_percent",
+        "MetricName": "tma_fetch_latency_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
+        "MetricExpr": "100 * ( ICACHE_16B.IFDATA_STALL / ( CPU_CLK_UNHALTE=
D.THREAD ) )",
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
NHALTED.THREAD ) + ( ( 10 ) * BACLEARS.ANY / ( CPU_CLK_UNHALTED.THREAD ) ) =
)",
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
+        "MetricExpr": "100 * ( ( 3 ) * IDQ.MS_SWITCHES / ( CPU_CLK_UNHALTE=
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
+        "MetricExpr": "100 * ( max( 0 , ( topdown\\-fe\\-bound / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) - INT_MISC.UOP_DROPPING / ( slots ) ) - ( ( ( 5 ) * IDQ_UOPS_NOT_DE=
LIVERED.CYCLES_0_UOPS_DELIV.CORE - INT_MISC.UOP_DROPPING ) / ( slots ) ) ) =
)",
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
+        "MetricExpr": "100 * ( ( IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK =
) / ( CPU_CLK_UNHALTED.DISTRIBUTED ) / 2 )",
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
+        "MetricExpr": "100 * ( ( IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK ) =
/ ( CPU_CLK_UNHALTED.DISTRIBUTED ) / 2 )",
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
+        "MetricExpr": "100 * ( max( 1 - ( ( topdown\\-fe\\-bound / ( topdo=
wn\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\=
\-bound ) - INT_MISC.UOP_DROPPING / ( slots ) ) + ( topdown\\-be\\-bound / =
( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdow=
n\\-be\\-bound ) + ( ( 5 ) * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=3D0x1\\=
,edge\\=3D0x1@ ) / ( slots ) ) + ( topdown\\-retiring / ( topdown\\-fe\\-bo=
und + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) =
) , 0 ) )",
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
RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT ) ) * ( max( 1 - ( ( topdown\\-=
fe\\-bound / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-reti=
ring + topdown\\-be\\-bound ) - INT_MISC.UOP_DROPPING / ( slots ) ) + ( top=
down\\-be\\-bound / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown=
\\-retiring + topdown\\-be\\-bound ) + ( ( 5 ) * cpu@INT_MISC.RECOVERY_CYCL=
ES\\,cmask\\=3D0x1\\,edge\\=3D0x1@ ) / ( slots ) ) + ( topdown\\-retiring /=
 ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdo=
wn\\-be\\-bound ) ) ) , 0 ) ) )",
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
+        "MetricExpr": "100 * ( max( 0 , ( max( 1 - ( ( topdown\\-fe\\-boun=
d / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + to=
pdown\\-be\\-bound ) - INT_MISC.UOP_DROPPING / ( slots ) ) + ( topdown\\-be=
\\-bound / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiri=
ng + topdown\\-be\\-bound ) + ( ( 5 ) * cpu@INT_MISC.RECOVERY_CYCLES\\,cmas=
k\\=3D0x1\\,edge\\=3D0x1@ ) / ( slots ) ) + ( topdown\\-retiring / ( topdow=
n\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\=
-bound ) ) ) , 0 ) ) - ( ( BR_MISP_RETIRED.ALL_BRANCHES / ( BR_MISP_RETIRED=
.ALL_BRANCHES + MACHINE_CLEARS.COUNT ) ) * ( max( 1 - ( ( topdown\\-fe\\-bo=
und / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + =
topdown\\-be\\-bound ) - INT_MISC.UOP_DROPPING / ( slots ) ) + ( topdown\\-=
be\\-bound / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-reti=
ring + topdown\\-be\\-bound ) + ( ( 5 ) * cpu@INT_MISC.RECOVERY_CYCLES\\,cm=
ask\\=3D0x1\\,edge\\=3D0x1@ ) / ( slots ) ) + ( topdown\\-retiring / ( topd=
own\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be=
\\-bound ) ) ) , 0 ) ) ) ) )",
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
+        "MetricExpr": "100 * ( topdown\\-be\\-bound / ( topdown\\-fe\\-bou=
nd + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) + (=
 ( 5 ) * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@ ) / (=
 slots ) )",
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
PORTS_UTIL + ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\=
\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * EXE_ACTIVITY.2_POR=
TS_UTIL ) + EXE_ACTIVITY.BOUND_ON_STORES ) ) * ( topdown\\-be\\-bound / ( t=
opdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\=
-be\\-bound ) + ( ( 5 ) * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=3D0x1\\,ed=
ge\\=3D0x1@ ) / ( slots ) ) )",
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
 ) ) ) + L1D_PEND_MISS.FB_FULL_PERIODS ) ) * ( ( CYCLE_ACTIVITY.STALLS_L1D_=
MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) ) )",
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
( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + L1D_PEND_MISS.FB_FULL_PERIODS ) ) * ( =
( CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / ( CPU_=
CLK_UNHALTED.THREAD ) ) ) ) - ( min( ( ( ( ( 1 - ( ( ( 19 * ( MEM_LOAD_L3_M=
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
RED.L1_MISS ) ) ) ) + L1D_PEND_MISS.FB_FULL_PERIODS ) ) * ( ( CYCLE_ACTIVIT=
Y.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.TH=
READ ) ) ) ) ) if ( ( 1000000 ) * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + M=
EM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else 0 ) ) , ( 1 )=
 ) ) ) ) , ( 1 ) ) )",
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
RED.L1_MISS ) ) ) ) + L1D_PEND_MISS.FB_FULL_PERIODS ) ) * ( ( CYCLE_ACTIVIT=
Y.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.TH=
READ ) ) ) ) ) if ( ( 1000000 ) * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + M=
EM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else 0 ) ) , ( 1 )=
 ) )",
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
+        "MetricExpr": "100 * ( max( 0 , ( topdown\\-be\\-bound / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) + ( ( 5 ) * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=3D0x1\\,edge\\=
=3D0x1@ ) / ( slots ) ) - ( ( ( CYCLE_ACTIVITY.STALLS_MEM_ANY + EXE_ACTIVIT=
Y.BOUND_ON_STORES ) / ( CYCLE_ACTIVITY.STALLS_TOTAL + ( EXE_ACTIVITY.1_PORT=
S_UTIL + ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-sp=
ec + topdown\\-retiring + topdown\\-be\\-bound ) ) * EXE_ACTIVITY.2_PORTS_U=
TIL ) + EXE_ACTIVITY.BOUND_ON_STORES ) ) * ( topdown\\-be\\-bound / ( topdo=
wn\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\=
\-bound ) + ( ( 5 ) * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=3D0x1\\,edge\\=
=3D0x1@ ) / ( slots ) ) ) ) )",
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
+        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired. Ideally=
; all pipeline slots would be attributed to the Retiring category.  Retirin=
g of 100% would indicate the maximum Pipeline_Width throughput was achieved=
.  Maximizing Retiring typically increases the Instructions-per-cycle (see =
IPC metric). Note that a high Retiring value does not necessary mean there =
is no room for more performance.  For example; Heavy-operations or Microcod=
e Assists are categorized under Retiring. They often indicate suboptimal pe=
rformance and can often be optimized or avoided. ",
+        "MetricExpr": "( 100 * ( topdown\\-retiring / ( topdown\\-fe\\-bou=
nd + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) )=
 + ( 0 * slots )",
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
+        "MetricExpr": "100 * ( max( 0 , ( topdown\\-retiring / ( topdown\\=
-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bo=
und ) ) - ( ( ( ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\=
-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) /=
 UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( slots ) ) + ( topdown\\-retiring / ( t=
opdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\=
-be\\-bound ) ) * ( UOPS_DECODED.DEC0 - cpu@UOPS_DECODED.DEC0\\,cmask\\=3D0=
x1@ ) / IDQ.MITE_UOPS ) ) )",
+        "MetricGroup": "Retire;TmaL2;m_tma_retiring_percent",
+        "MetricName": "tma_light_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired). Note t=
his metric's value may exceed its parent due to use of \"Uops\" CountDomain=
 and FMA double-counting.",
+        "MetricExpr": "100 * ( ( ( topdown\\-retiring / ( topdown\\-fe\\-b=
ound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) )=
 * UOPS_EXECUTED.X87 / UOPS_EXECUTED.THREAD ) + ( ( FP_ARITH_INST_RETIRED.S=
CALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) / ( ( topdown\\-retiri=
ng / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + t=
opdown\\-be\\-bound ) ) * ( slots ) ) ) + ( min( ( ( FP_ARITH_INST_RETIRED.=
128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_IN=
ST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + =
FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACKE=
D_SINGLE ) / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-ba=
d\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) ) , =
( 1 ) ) ) )",
+        "MetricGroup": "HPC;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_fp_arith_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "MetricExpr": "100 * ( ( max( 0 , ( topdown\\-retiring / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) ) - ( ( ( ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown=
\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) )=
 / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( slots ) ) + ( topdown\\-retiring / (=
 topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown=
\\-be\\-bound ) ) * ( UOPS_DECODED.DEC0 - cpu@UOPS_DECODED.DEC0\\,cmask\\=
=3D0x1@ ) / IDQ.MITE_UOPS ) ) ) * MEM_INST_RETIRED.ANY / INST_RETIRED.ANY )=
",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_memory_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions.",
+        "MetricExpr": "100 * ( ( max( 0 , ( topdown\\-retiring / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) ) - ( ( ( ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown=
\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) )=
 / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( slots ) ) + ( topdown\\-retiring / (=
 topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown=
\\-be\\-bound ) ) * ( UOPS_DECODED.DEC0 - cpu@UOPS_DECODED.DEC0\\,cmask\\=
=3D0x1@ ) / IDQ.MITE_UOPS ) ) ) * BR_INST_RETIRED.ALL_BRANCHES / ( ( topdow=
n\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-re=
tiring + topdown\\-be\\-bound ) ) * ( slots ) ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_branch_instructions_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions. Compilers often use NOPs f=
or certain address alignments - e.g. start address of a function or loop bo=
dy.",
+        "MetricExpr": "100 * ( ( max( 0 , ( topdown\\-retiring / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) ) - ( ( ( ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown=
\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) )=
 / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( slots ) ) + ( topdown\\-retiring / (=
 topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown=
\\-be\\-bound ) ) * ( UOPS_DECODED.DEC0 - cpu@UOPS_DECODED.DEC0\\,cmask\\=
=3D0x1@ ) / IDQ.MITE_UOPS ) ) ) * INST_RETIRED.NOP / ( ( topdown\\-retiring=
 / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + top=
down\\-be\\-bound ) ) * ( slots ) ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_nop_instructions_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes. May undercount due to FMA double counting",
+        "MetricExpr": "100 * ( max( 0 , ( max( 0 , ( topdown\\-retiring / =
( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdow=
n\\-be\\-bound ) ) - ( ( ( ( ( topdown\\-retiring / ( topdown\\-fe\\-bound =
+ topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( =
slots ) ) / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( slots ) ) + ( topdown\\-ret=
iring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring =
+ topdown\\-be\\-bound ) ) * ( UOPS_DECODED.DEC0 - cpu@UOPS_DECODED.DEC0\\,=
cmask\\=3D0x1@ ) / IDQ.MITE_UOPS ) ) ) - ( ( ( ( topdown\\-retiring / ( top=
down\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-b=
e\\-bound ) ) * UOPS_EXECUTED.X87 / UOPS_EXECUTED.THREAD ) + ( ( FP_ARITH_I=
NST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) / ( ( top=
down\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\=
-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) ) + ( min( ( ( FP_ARITH_=
INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE =
+ FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PAC=
KED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIR=
ED.512B_PACKED_SINGLE ) / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( s=
lots ) ) ) , ( 1 ) ) ) ) + ( ( max( 0 , ( topdown\\-retiring / ( topdown\\-=
fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bou=
nd ) ) - ( ( ( ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-=
bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) / =
UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( slots ) ) + ( topdown\\-retiring / ( to=
pdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-=
be\\-bound ) ) * ( UOPS_DECODED.DEC0 - cpu@UOPS_DECODED.DEC0\\,cmask\\=3D0x=
1@ ) / IDQ.MITE_UOPS ) ) ) * MEM_INST_RETIRED.ANY / INST_RETIRED.ANY ) + ( =
( max( 0 , ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-=
spec + topdown\\-retiring + topdown\\-be\\-bound ) ) - ( ( ( ( ( topdown\\-=
retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiri=
ng + topdown\\-be\\-bound ) ) * ( slots ) ) / UOPS_ISSUED.ANY ) * IDQ.MS_UO=
PS / ( slots ) ) + ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\=
\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( UOPS_DECOD=
ED.DEC0 - cpu@UOPS_DECODED.DEC0\\,cmask\\=3D0x1@ ) / IDQ.MITE_UOPS ) ) ) * =
BR_INST_RETIRED.ALL_BRANCHES / ( ( topdown\\-retiring / ( topdown\\-fe\\-bo=
und + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) =
* ( slots ) ) ) + ( ( max( 0 , ( topdown\\-retiring / ( topdown\\-fe\\-boun=
d + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) - =
( ( ( ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spe=
c + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) / UOPS_ISSU=
ED.ANY ) * IDQ.MS_UOPS / ( slots ) ) + ( topdown\\-retiring / ( topdown\\-f=
e\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-boun=
d ) ) * ( UOPS_DECODED.DEC0 - cpu@UOPS_DECODED.DEC0\\,cmask\\=3D0x1@ ) / ID=
Q.MITE_UOPS ) ) ) * INST_RETIRED.NOP / ( ( topdown\\-retiring / ( topdown\\=
-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bo=
und ) ) * ( slots ) ) ) ) ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_other_light_ops_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences. This highly-correlates with the =
uop length of these instructions/sequences.",
+        "MetricExpr": "100 * ( ( ( ( ( topdown\\-retiring / ( topdown\\-fe=
\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound=
 ) ) * ( slots ) ) / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( slots ) ) + ( topd=
own\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-=
retiring + topdown\\-be\\-bound ) ) * ( UOPS_DECODED.DEC0 - cpu@UOPS_DECODE=
D.DEC0\\,cmask\\=3D0x1@ ) / IDQ.MITE_UOPS )",
+        "MetricGroup": "Retire;TmaL2;m_tma_retiring_percent",
+        "MetricName": "tma_heavy_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number of=
 uops in such instructions.",
+        "MetricExpr": "100 * ( ( ( ( ( ( topdown\\-retiring / ( topdown\\-=
fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bou=
nd ) ) * ( slots ) ) / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( slots ) ) + ( to=
pdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\=
\-retiring + topdown\\-be\\-bound ) ) * ( UOPS_DECODED.DEC0 - cpu@UOPS_DECO=
DED.DEC0\\,cmask\\=3D0x1@ ) / IDQ.MITE_UOPS ) - ( ( ( ( topdown\\-retiring =
/ ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topd=
own\\-be\\-bound ) ) * ( slots ) ) / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( sl=
ots ) ) )",
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
+        "MetricExpr": "100 * ( ( ( ( topdown\\-retiring / ( topdown\\-fe\\=
-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound )=
 ) * ( slots ) ) / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( slots ) )",
+        "MetricGroup": "MicroSeq;TmaL3;m_tma_heavy_operations_percent",
+        "MetricName": "tma_microcode_sequencer_percent",
+        "ScaleUnit": "1%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/memory.json b/tools/pe=
rf/pmu-events/arch/x86/icelakex/memory.json
index 58b03a8a1b95..48e8d1102b9d 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
@@ -306,7 +306,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the local socket's L1, L2, or L3 caches.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.L3_MISS",
@@ -317,7 +317,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the local socket's L1, L2, or L3 caches and were supplied=
 by the local socket.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and w=
ere supplied by the local socket.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
@@ -328,7 +328,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that mis=
sed the L3 Cache and were supplied by the local socket (DRAM or PMM), wheth=
er or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM or DRAM ac=
cesses that are controlled by the close or distant SNC Cluster.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that missed the L3 Cache and were supplied by the local socket (DRAM or=
 PMM), whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PM=
M or DRAM accesses that are controlled by the close or distant SNC Cluster.=
",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL_SOCKET",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/other.json b/tools/per=
f/pmu-events/arch/x86/icelakex/other.json
index c9bf6808ead7..919e620e7db8 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/other.json
@@ -44,7 +44,6 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts responses to snoops indicating the li=
ne will now be (I)nvalidated: removed from this core's cache, after the dat=
a is forwarded back to the requestor and indicating the data was found unmo=
dified in the (FE) Forward or Exclusive State in this cores caches cache.  =
A single snoop response from the core counts on all hyperthreads of the cor=
e.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -56,7 +55,6 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts responses to snoops indicating the li=
ne will now be (I)nvalidated: removed from this core's caches, after the da=
ta is forwarded back to the requestor, and indicating the data was found mo=
dified(M) in this cores caches cache (aka HitM response).  A single snoop r=
esponse from the core counts on all hyperthreads of the core.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -68,7 +66,6 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts responses to snoops indicating the li=
ne will now be (I)nvalidated in this core's caches without being forwarded =
back to the requestor. The line was in Forward, Shared or Exclusive (FSE) s=
tate in this cores caches.  A single snoop response from the core counts on=
 all hyperthreads of the core.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -80,7 +77,6 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts responses to snoops indicating that t=
he data was not found (IHitI) in this core's caches. A single snoop respons=
e from the core counts on all hyperthreads of the Core.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -92,7 +88,6 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts responses to snoops indicating the li=
ne may be kept on this core in the (S)hared state, after the data is forwar=
ded back to the requestor, initially the data was found in the cache in the=
 (FS) Forward or Shared state.  A single snoop response from the core count=
s on all hyperthreads of the core.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x40"
     },
     {
@@ -104,7 +99,6 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts responses to snoops indicating the li=
ne may be kept on this core in the (S)hared state, after the data is forwar=
ded back to the requestor, initially the data was found in the cache in the=
 (M)odified state.  A single snoop response from the core counts on all hyp=
erthreads of the core.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -116,7 +110,6 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts responses to snoops indicating the li=
ne was kept on this core in the (S)hared state, and that the data was found=
 unmodified but not forwarded back to the requestor, initially the data was=
 found in the cache in the (FSE) Forward, Shared state or Exclusive state. =
 A single snoop response from the core counts on all hyperthreads of the co=
re.",
         "SampleAfterValue": "1000003",
-        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -428,7 +421,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e any type of response.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that have any type of response.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
@@ -439,7 +432,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.DRAM",
@@ -450,7 +443,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC)=
 Mode.  In SNC Mode counts only those DRAM accesses that are controlled by =
the close SNC Cluster.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA =
Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are co=
ntrolled by the close SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
@@ -461,7 +454,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by PMM attached to this socket, unless in Sub NUMA Cluster(SNC) =
Mode.  In SNC Mode counts only those PMM accesses that are controlled by th=
e close SNC Cluster.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by PMM attached to this socket, unless in Sub NUMA C=
luster(SNC) Mode.  In SNC Mode counts only those PMM accesses that are cont=
rolled by the close SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.LOCAL_PMM",
@@ -472,7 +465,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM attached to this socket, whether or not in Sub NUMA Clus=
ter(SNC) Mode.  In SNC Mode counts DRAM accesses that are controlled by the=
 close or distant SNC Cluster.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, whether or not in S=
ub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are contr=
olled by the close or distant SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
@@ -483,7 +476,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by PMM attached to this socket, whether or not in Sub NUMA Clust=
er(SNC) Mode.  In SNC Mode counts PMM accesses that are controlled by the c=
lose or distant SNC Cluster.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by PMM attached to this socket, whether or not in Su=
b NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM accesses that are control=
led by the close or distant SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_PMM",
@@ -494,7 +487,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the local socket's L1, L2, or L3 caches and were supplied=
 by a remote socket.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and w=
ere supplied by a remote socket.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.REMOTE",
@@ -505,7 +498,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM attached to another socket.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to another socket.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
@@ -516,7 +509,18 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by PMM attached to another socket.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM or PMM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x731800477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by PMM attached to another socket.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.REMOTE_PMM",
@@ -527,7 +531,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM on a distant memory controller of this socket when the s=
ystem is in SNC (sub-NUMA cluster) mode.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM on a distant memory controller of this socke=
t when the system is in SNC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.SNC_DRAM",
@@ -538,7 +542,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by PMM on a distant memory controller of this socket when the sy=
stem is in SNC (sub-NUMA cluster) mode.",
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by PMM on a distant memory controller of this socket=
 when the system is in SNC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.SNC_PMM",
@@ -558,5 +562,16 @@
         "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Hard=
ware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted =
in a store to Memory (DRAM or PMM)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.WRITE_ESTIMATE.MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0xFBFF80822",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/icelakex/pipeline.json
index 95c1008ef057..396868f70004 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
@@ -214,6 +214,18 @@
         "SampleAfterValue": "50021",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RET",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
+        "SampleAfterValue": "50021",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Cycle counts are evenly distributed between a=
ctive threads in the Core.",
         "CollectPEBSRecord": "2",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json b/=
tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json
index bc43ea855840..d70864da5c67 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json
@@ -266,4 +266,4 @@
         "Speculative": "1",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index aae90ece2013..727631ce1a57 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -11,6 +11,7 @@ GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-(3C|45|46),v31,haswell,core
 GenuineIntel-6-3F,v25,haswellx,core
 GenuineIntel-6-(7D|7E|A7),v1.14,icelake,core
+GenuineIntel-6-6[AC],v1.15,icelakex,core
 GenuineIntel-6-3A,v18,ivybridge,core
 GenuineIntel-6-3E,v19,ivytown,core
 GenuineIntel-6-2D,v20,jaketown,core
@@ -31,8 +32,6 @@ GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55-[01234],v1,skylakex,core
 GenuineIntel-6-8[CD],v1,tigerlake,core
-GenuineIntel-6-6A,v1,icelakex,core
-GenuineIntel-6-6C,v1,icelakex,core
 GenuineIntel-6-86,v1,tremontx,core
 GenuineIntel-6-8F,v1,sapphirerapids,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
--=20
2.37.1.359.gd136c6c3e2-goog

