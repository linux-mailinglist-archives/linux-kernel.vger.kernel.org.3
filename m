Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDBE57E9B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbiGVWdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiGVWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:33:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65953A894B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e53d82c77so49355307b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=saTH64VonVF5MJo3Bw1ZZ6te4pe6tDVFlY3diXJsMLs=;
        b=JP1OPqkzj9R2UfzITSSNsRi4A93ZuA2lM3XqHsYRxBwzjTb899zYx1jwqT7lFUP/6D
         edGcvyCykL3NwMaxTpnpCyRMP3PoWGF0Al4+p3eECyh4+KeS6XEaD2FGh2GRmOzJUwit
         BoJI72uRnxZMGo+XMFnGg3r03dqCbKnqSYpame1Xu3yjI4fVL3CBYKF+JyIvmeEKN6Nh
         7E2ztrY7Psyya5ZFay8U5cpduRG3BKk5yzdh34qyEhX4cAY0HOHf+xpEnCZxTe+gRb4k
         QcjdKR71/LMwCLa/m7+g5fQtfjkVut6XqWUKA85O2cPoQGYJBHe1pRQEe3hAJQWSp8rS
         /Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=saTH64VonVF5MJo3Bw1ZZ6te4pe6tDVFlY3diXJsMLs=;
        b=JZV87BlPKAcEILD/Dxo1w2MU3Pvj7oT30HED6sSsHUWc6i6LszOJ8f4lA313MBzNQ5
         LEZhM/XxeCkXkEyqebQZOVA3B0qqtq99axhpp0fI3s0/4BYriuI5UlQd0pV1Ors4b60g
         aDNIZeSdNAvgV9lafDpa8Q+nBVXnz8KgHisxUb1keBO0a9J4S+VHB7B5cwlkDWroOOnv
         qKX8BPoQHrnK1WrT84OC4clkk8mgnlg8Gubm5rispa6W3CSuMP1PU3LAWAcg9fpFLbdW
         fcC/7+TYoVwpC/hsB1CBkhwP+Eq7rWi8qLqwVYuHy9dxK+B92CfXxcX6vciYikrK+vhu
         ec6w==
X-Gm-Message-State: AJIora+z1lFfD7SFz6t1MNGA5L2D506a0Lbzf2rNZogFTfmycbtEwuBC
        hbCUyN69GCLvqGLt76vDATbEjtTyYgWZ
X-Google-Smtp-Source: AGRyM1skEwNgrhrC/rlSDTVW2/RyxyEOrHTBngaQMiecv4WIGdr2WuuQgOVbGvlkBVDNgZU+cB32WBjhfTHr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7543:ead8:55fa:3980])
 (user=irogers job=sendgmr) by 2002:a25:8507:0:b0:670:6460:e4d8 with SMTP id
 w7-20020a258507000000b006706460e4d8mr1815165ybk.174.1658529184666; Fri, 22
 Jul 2022 15:33:04 -0700 (PDT)
Date:   Fri, 22 Jul 2022 15:32:14 -0700
In-Reply-To: <20220722223240.1618013-1-irogers@google.com>
Message-Id: <20220722223240.1618013-6-irogers@google.com>
Mime-Version: 1.0
References: <20220722223240.1618013-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v1 05/31] perf vendor events: Update Intel alderlake
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
the alderlake files into perf and update mapfile.csv.

Tested on a non-alderlake with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       |   4 +-
 .../pmu-events/arch/x86/alderlake/cache.json  | 178 +++++-
 .../arch/x86/alderlake/floating-point.json    |  19 +-
 .../arch/x86/alderlake/frontend.json          |  38 +-
 .../pmu-events/arch/x86/alderlake/memory.json |  40 +-
 .../pmu-events/arch/x86/alderlake/other.json  |  97 +++-
 .../arch/x86/alderlake/pipeline.json          | 507 ++++++++++++++++--
 .../arch/x86/alderlake/uncore-other.json      |   2 +-
 .../arch/x86/alderlake/virtual-memory.json    |  63 ++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 10 files changed, 837 insertions(+), 114 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index f8bdf7812b51..095dd8c7f161 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -592,13 +592,13 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricName": "IpBranch",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
         "MetricName": "IpCall",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index b83ed129c454..887dce4dfeba 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -1,45 +1,49 @@
 [
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or tlb miss which hit in the L2, LLC, DRAM o=
r MMIO (Non-DRAM).",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM o=
r MMIO (Non-DRAM).",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x38",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or tlb miss which hit in DRAM or MMIO (Non-D=
RAM).",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non-D=
RAM).",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_DRAM_HIT",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or tlb miss which hit in the L2 cache.",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2 cache.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or tlb miss which hit in the last level cach=
e or other core with HITE/F/M.",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the LLC or other co=
re with HITE/F/M.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_atom"
     },
@@ -51,6 +55,7 @@
         "EventName": "MEM_BOUND_STALLS.LOAD",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x7",
         "Unit": "cpu_atom"
     },
@@ -62,6 +67,7 @@
         "EventName": "MEM_BOUND_STALLS.LOAD_DRAM_HIT",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
@@ -73,6 +79,7 @@
         "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
@@ -84,11 +91,12 @@
         "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of load ops retired that hi=
t in DRAM.",
+        "BriefDescription": "Counts the number of load uops retired that h=
it in DRAM.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
@@ -101,7 +109,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L2 cache.",
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L2 cache.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
@@ -114,9 +122,10 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache.",
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
         "PEBS": "1",
@@ -133,6 +142,7 @@
         "EventName": "MEM_SCHEDULER_BLOCK.ALL",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x7",
         "Unit": "cpu_atom"
     },
@@ -144,6 +154,7 @@
         "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
@@ -155,6 +166,7 @@
         "EventName": "MEM_SCHEDULER_BLOCK.RSV",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
@@ -166,6 +178,7 @@
         "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
@@ -202,6 +215,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
@@ -218,6 +232,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
@@ -234,6 +249,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
@@ -250,6 +266,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
@@ -266,6 +283,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
@@ -282,6 +300,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
@@ -298,6 +317,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
@@ -314,6 +334,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
@@ -324,7 +345,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts all the retired split loads.",
+        "BriefDescription": "Counts the number of retired split load uops.=
",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
@@ -338,11 +359,13 @@
     },
     {
         "BriefDescription": "Counts the number of stores uops retired. Cou=
nts with or without PEBS enabled.",
-        "CollectPEBSRecord": "2",
+        "CollectPEBSRecord": "3",
         "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
-        "PEBS": "1",
+        "L1_Hit_Indication": "1",
+        "PEBS": "2",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
@@ -350,7 +373,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -367,9 +390,22 @@
         "EventName": "TOPDOWN_FE_BOUND.ICACHE",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "L1D.HWPF_MISS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "L1D.HWPF_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of cache lines replaced in =
L1 data cache.",
         "CollectPEBSRecord": "2",
@@ -378,6 +414,7 @@
         "EventName": "L1D.REPLACEMENT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -389,6 +426,7 @@
         "EventName": "L1D_PEND_MISS.FB_FULL",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -402,6 +440,7 @@
         "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -413,6 +452,7 @@
         "EventName": "L1D_PEND_MISS.L2_STALL",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -424,6 +464,7 @@
         "EventName": "L1D_PEND_MISS.L2_STALLS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -435,6 +476,7 @@
         "EventName": "L1D_PEND_MISS.PENDING",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -447,6 +489,7 @@
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -458,17 +501,31 @@
         "EventName": "L2_LINES_IN.ALL",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1f",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "All L2 requests.[This event is alias to L2_RQ=
STS.REFERENCES]",
+        "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.USELESS_HWPF",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_RQSTS.REFERENCES]",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xff",
         "Unit": "cpu_core"
     },
@@ -480,6 +537,7 @@
         "EventName": "L2_REQUEST.MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x3f",
         "Unit": "cpu_core"
     },
@@ -491,17 +549,19 @@
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe4",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Demand Data Read requests",
+        "BriefDescription": "Demand Data Read access L2 cache",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe1",
         "Unit": "cpu_core"
     },
@@ -513,9 +573,22 @@
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x27",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "L2_RQSTS.ALL_HWPF",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_HWPF",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0xf0",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "RFO requests to L2 cache.",
         "CollectPEBSRecord": "2",
@@ -524,6 +597,7 @@
         "EventName": "L2_RQSTS.ALL_RFO",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe2",
         "Unit": "cpu_core"
     },
@@ -535,6 +609,7 @@
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc4",
         "Unit": "cpu_core"
     },
@@ -546,6 +621,7 @@
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x24",
         "Unit": "cpu_core"
     },
@@ -557,20 +633,34 @@
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Demand Data Read miss L2, no rejects",
+        "BriefDescription": "Demand Data Read miss L2 cache",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x21",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "L2_RQSTS.HWPF_MISS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HWPF_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x30",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_REQUEST.MISS]",
         "CollectPEBSRecord": "2",
@@ -579,17 +669,19 @@
         "EventName": "L2_RQSTS.MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x3f",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "All L2 requests.[This event is alias to L2_RE=
QUEST.ALL]",
+        "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_REQUEST.ALL]",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xff",
         "Unit": "cpu_core"
     },
@@ -601,6 +693,7 @@
         "EventName": "L2_RQSTS.RFO_HIT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc2",
         "Unit": "cpu_core"
     },
@@ -612,6 +705,7 @@
         "EventName": "L2_RQSTS.RFO_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x22",
         "Unit": "cpu_core"
     },
@@ -623,6 +717,7 @@
         "EventName": "L2_RQSTS.SWPF_HIT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc8",
         "Unit": "cpu_core"
     },
@@ -634,22 +729,36 @@
         "EventName": "L2_RQSTS.SWPF_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x28",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x41",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "All retired load instructions.",
+        "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x4f",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -662,7 +771,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "All retired store instructions.",
+        "BriefDescription": "Retired store instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -764,6 +873,7 @@
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xfd",
         "Unit": "cpu_core"
     },
@@ -961,7 +1071,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x44",
@@ -983,7 +1093,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another cores caches, data forwarding is required as the data i=
s modified.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -993,8 +1103,8 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "DEMAND_DATA_RD & L3_HIT & SNOOP_HIT_WITH_FWD"=
,
-        "Counter": "0,1,2,3",
+        "BriefDescription": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD"=
,
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1005,7 +1115,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that resulte=
d in a snoop hit in another cores caches, data forwarding is required as th=
e data is modified.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1015,13 +1125,14 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
@@ -1033,6 +1144,7 @@
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -1044,6 +1156,7 @@
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1051,22 +1164,26 @@
         "BriefDescription": "This event is deprecated. Refer to new event =
OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
+        "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA=
_RD",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
+        "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -1079,17 +1196,20 @@
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
+        "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -1101,6 +1221,7 @@
         "EventName": "SW_PREFETCH_ACCESS.NTA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1112,6 +1233,7 @@
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -1123,6 +1245,7 @@
         "EventName": "SW_PREFETCH_ACCESS.T0",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -1134,7 +1257,8 @@
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
index 310c2a8f3e6b..48a4605fc057 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
@@ -7,6 +7,7 @@
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
@@ -23,7 +24,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "ARITH.FPDIV_ACTIVE",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
@@ -31,6 +32,7 @@
         "EventName": "ARITH.FPDIV_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -42,50 +44,55 @@
         "EventName": "ASSISTS.FP",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "ASSISTS.SSE_AVX_MIX",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.SSE_AVX_MIX",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -155,4 +162,4 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/alderlake/frontend.json
index 908588f63314..2cfa70b2d5e1 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
@@ -7,6 +7,7 @@
         "EventName": "BACLEARS.ANY",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
@@ -18,6 +19,7 @@
         "EventName": "ICACHE.ACCESSES",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
@@ -29,6 +31,7 @@
         "EventName": "ICACHE.MISSES",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
@@ -40,6 +43,7 @@
         "EventName": "DECODE.LCP",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -51,6 +55,7 @@
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -294,6 +299,21 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "FRONTEND_RETIRED.MS_FLOWS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.MS_FLOWS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
         "CollectPEBSRecord": "2",
@@ -310,7 +330,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
@@ -332,6 +352,7 @@
         "EventName": "ICACHE_DATA.STALLS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -343,6 +364,7 @@
         "EventName": "ICACHE_TAG.STALLS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -355,6 +377,7 @@
         "EventName": "IDQ.DSB_CYCLES_ANY",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -367,6 +390,7 @@
         "EventName": "IDQ.DSB_CYCLES_OK",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -378,6 +402,7 @@
         "EventName": "IDQ.DSB_UOPS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -390,6 +415,7 @@
         "EventName": "IDQ.MITE_CYCLES_ANY",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -402,6 +428,7 @@
         "EventName": "IDQ.MITE_CYCLES_OK",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -413,6 +440,7 @@
         "EventName": "IDQ.MITE_UOPS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -425,6 +453,7 @@
         "EventName": "IDQ.MS_CYCLES_ANY",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
@@ -438,6 +467,7 @@
         "EventName": "IDQ.MS_SWITCHES",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
@@ -449,6 +479,7 @@
         "EventName": "IDQ.MS_UOPS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
@@ -460,6 +491,7 @@
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -472,6 +504,7 @@
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -485,7 +518,8 @@
         "Invert": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index 1d4d1ebe2a74..586fb961e46d 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -1,52 +1,61 @@
 [
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck, on a load that retires.",
+        "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ANY_AT_RET",
+        "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xff",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a core bound stall includin=
g a store address match, a DTLB miss or a page walk that detains the load f=
rom retiring.",
-        "Counter": "0,1,2,3",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.L1_BOUND_AT_RET",
+        "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xf4",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to other block cases when load=
 subsequently retires when load subsequently retires.",
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to other =
block cases.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.OTHER_AT_RET",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xc0",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a pagewalk when load subseq=
uently retires.",
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a page=
walk.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.PGWALK_AT_RET",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xa0",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a store address match when =
load subsequently retires.",
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a stor=
e address match.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ST_ADDR_AT_RET",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x84",
         "Unit": "cpu_atom"
     },
@@ -58,12 +67,13 @@
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -74,7 +84,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -92,6 +102,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x6",
         "Unit": "cpu_core"
     },
@@ -103,6 +114,7 @@
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -115,6 +127,7 @@
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -127,11 +140,12 @@
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MEMORY_ACTIVITY.STALLS_L2_MISS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "5",
@@ -139,11 +153,12 @@
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x5",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MEMORY_ACTIVITY.STALLS_L3_MISS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "9",
@@ -151,6 +166,7 @@
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
@@ -283,7 +299,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Retired instructions with at least 1 store uo=
p. This PEBS event is the trigger for stores sampled by the PEBS Store Faci=
lity.",
+        "BriefDescription": "Retired memory store access operations. A PDi=
st event for PEBS Store Latency Facility.",
         "CollectPEBSRecord": "2",
         "Data_LA": "1",
         "EventCode": "0xcd",
@@ -295,7 +311,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -306,7 +322,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -315,4 +331,4 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index dc810f093fb0..67a9c13cc71d 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -1,7 +1,7 @@
 [
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -12,7 +12,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -23,7 +23,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -33,74 +33,68 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xc1",
-        "EventName": "ASSISTS.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1f",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Count all other microcode assist beyond FP, A=
VX_TILE_MIX and A/D assists (counted by their own sub-events). This include=
s assists at uop writeback like AVX* load/store (non-FP) assists, Null Assi=
st in SNC (due to lack of FP precision format convert with FMA3x3 uarch) or=
 assists generated by ROB (like assists to due to Missprediction for FSW re=
gister - fixed in SNC)",
+        "BriefDescription": "ASSISTS.HARDWARE",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.HARDWARE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "ASSISTS.PAGE_FAULT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.PAGE_FAULT",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "CORE_POWER.LICENSE_1",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_1",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "CORE_POWER.LICENSE_2",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_2",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "CORE_POWER.LICENSE_3",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_3",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -111,7 +105,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -122,7 +116,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -132,7 +126,61 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_COUNT",
+        "Invert": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY_COUNT",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS_EMPTY.COUNT",
+        "Invert": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS_EMPTY.CYCLES",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x7",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "XQ.FULL_CYCLES",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
@@ -140,7 +188,8 @@
         "EventName": "XQ.FULL_CYCLES",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index de2c6e0ef654..d02e078a90c9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -23,7 +23,31 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and Interrupt call and ret=
urn.",
+        "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of taken JCC (Jump on Condi=
tional Code) branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
@@ -34,6 +58,54 @@
         "UMask": "0xbf",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.IND_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.JCC",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
         "CollectPEBSRecord": "2",
@@ -46,6 +118,66 @@
         "UMask": "0xf9",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfd",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_RETURN",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.RETURN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND_TAKEN",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN_JCC",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "CollectPEBSRecord": "2",
@@ -57,13 +189,122 @@
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted JCC (Jump o=
n Conditional Code) branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT_CALL",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.IND_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.JCC",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7e",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.RETURN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xf7",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND_TAKEN",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es. (Fixed event)",
         "CollectPEBSRecord": "2",
-        "Counter": "33",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PEBScounters": "33",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
@@ -75,25 +316,28 @@
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency. (Fixed event)",
         "CollectPEBSRecord": "2",
-        "Counter": "34",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PEBScounters": "34",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es. (Fixed event)",
         "CollectPEBSRecord": "2",
-        "Counter": "33",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PEBScounters": "33",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
@@ -105,12 +349,13 @@
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of instructions retired. (F=
ixed event)",
+        "BriefDescription": "Counts the total number of instructions retir=
ed. (Fixed event)",
         "CollectPEBSRecord": "2",
-        "Counter": "32",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PEBScounters": "32",
@@ -118,6 +363,17 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the total number of instructions retir=
ed.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
LD_BLOCKS.ADDRESS_ALIAS",
         "CollectPEBSRecord": "2",
@@ -162,6 +418,7 @@
         "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
@@ -173,6 +430,7 @@
         "EventName": "MACHINE_CLEARS.MRN_NUKE",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x80",
         "Unit": "cpu_atom"
     },
@@ -182,9 +440,9 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.PAGE_FAULT",
-        "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_atom"
     },
@@ -196,6 +454,7 @@
         "EventName": "MACHINE_CLEARS.SLOW",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x6f",
         "Unit": "cpu_atom"
     },
@@ -207,17 +466,19 @@
         "EventName": "MACHINE_CLEARS.SMC",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots not consumed=
 due to a micro-sequencer (MS) scoreboard, which stalls the front-end from =
issuing uops from the UROM until a specified older uop retires.",
+        "BriefDescription": "Counts the number of issue slots not consumed=
 by the backend due to a micro-sequencer (MS) scoreboard, which stalls the =
front-end from issuing from the UROM until a specified older uop retires.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x75",
         "EventName": "SERIALIZATION.NON_C01_MS_SCB",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
@@ -229,6 +490,7 @@
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "Unit": "cpu_atom"
     },
     {
@@ -239,6 +501,7 @@
         "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
@@ -250,6 +513,7 @@
         "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x3",
         "Unit": "cpu_atom"
     },
@@ -261,6 +525,7 @@
         "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
@@ -272,6 +537,7 @@
         "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
@@ -283,6 +549,7 @@
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "Unit": "cpu_atom"
     },
     {
@@ -293,6 +560,7 @@
         "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
@@ -304,6 +572,7 @@
         "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
@@ -315,6 +584,7 @@
         "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
@@ -326,6 +596,7 @@
         "EventName": "TOPDOWN_BE_BOUND.REGISTER",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_atom"
     },
@@ -337,6 +608,7 @@
         "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_atom"
     },
@@ -348,6 +620,7 @@
         "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_atom"
     },
@@ -359,6 +632,7 @@
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "Unit": "cpu_atom"
     },
     {
@@ -369,6 +643,7 @@
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
@@ -380,6 +655,7 @@
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_atom"
     },
@@ -391,6 +667,7 @@
         "EventName": "TOPDOWN_FE_BOUND.CISC",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
@@ -402,6 +679,7 @@
         "EventName": "TOPDOWN_FE_BOUND.DECODE",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
@@ -413,17 +691,19 @@
         "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8d",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to latency related stalls inclu=
ding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to a latency related stalls inc=
luding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x72",
         "Unit": "cpu_atom"
     },
@@ -435,6 +715,7 @@
         "EventName": "TOPDOWN_FE_BOUND.ITLB",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_atom"
     },
@@ -446,6 +727,7 @@
         "EventName": "TOPDOWN_FE_BOUND.OTHER",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x80",
         "Unit": "cpu_atom"
     },
@@ -457,6 +739,7 @@
         "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
@@ -527,6 +810,7 @@
         "EventName": "ARITH.DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
@@ -539,6 +823,7 @@
         "EventName": "ARITH.DIV_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
@@ -551,11 +836,24 @@
         "EventName": "ARITH.FP_DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "This event counts the cycles the integer divi=
der is busy.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.IDIV_ACTIVE",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
@@ -563,9 +861,22 @@
         "EventName": "ARITH.INT_DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.ANY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1f",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
         "CollectPEBSRecord": "2",
@@ -709,7 +1020,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken. Non PEBS",
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
@@ -756,6 +1067,42 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C01",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C02",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x70",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycle counts are evenly distributed between a=
ctive threads in the Core.",
         "CollectPEBSRecord": "2",
@@ -764,6 +1111,7 @@
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -775,22 +1123,24 @@
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "25003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
@@ -798,6 +1148,7 @@
         "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
@@ -808,26 +1159,41 @@
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
         "CollectPEBSRecord": "2",
-        "Counter": "34",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PEBScounters": "34",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
         "CollectPEBSRecord": "2",
-        "Counter": "33",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PEBScounters": "33",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -839,6 +1205,7 @@
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "Unit": "cpu_core"
     },
     {
@@ -850,6 +1217,7 @@
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -862,6 +1230,7 @@
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -874,6 +1243,7 @@
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
@@ -886,6 +1256,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xc",
         "Unit": "cpu_core"
     },
@@ -898,6 +1269,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x5",
         "Unit": "cpu_core"
     },
@@ -910,6 +1282,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -921,6 +1294,7 @@
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -932,6 +1306,7 @@
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -943,6 +1318,7 @@
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -954,6 +1330,7 @@
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
@@ -966,6 +1343,7 @@
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x21",
         "Unit": "cpu_core"
     },
@@ -978,9 +1356,22 @@
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles no uop executed while RS was not empty=
, the SB was not full and there was no outstanding load.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Instruction decoders utilized in a cycle",
         "CollectPEBSRecord": "2",
@@ -989,13 +1380,14 @@
         "EventName": "INST_DECODED.DECODERS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
         "CollectPEBSRecord": "2",
-        "Counter": "32",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PEBScounters": "32",
@@ -1015,7 +1407,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INST_RETIRED.MACRO_FUSED",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
@@ -1026,7 +1418,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Number of all retired NOP instructions.",
+        "BriefDescription": "Retired NOP instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
@@ -1039,7 +1431,7 @@
     {
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
         "CollectPEBSRecord": "2",
-        "Counter": "32",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PEBScounters": "32",
@@ -1048,7 +1440,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INST_RETIRED.REP_ITERATION",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
@@ -1066,6 +1458,7 @@
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
@@ -1077,11 +1470,12 @@
         "EventName": "INT_MISC.RECOVERY_CYCLES",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
@@ -1090,6 +1484,7 @@
         "MSRValue": "0x7",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "TakenAlone": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
@@ -1102,11 +1497,12 @@
         "EventName": "INT_MISC.UOP_DROPPING",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.128BIT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -1117,7 +1513,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.256BIT",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -1150,7 +1546,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.MUL_256",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -1161,7 +1557,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -1172,7 +1568,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -1183,7 +1579,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
@@ -1201,6 +1597,7 @@
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -1212,6 +1609,7 @@
         "EventName": "LD_BLOCKS.NO_SR",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x88",
         "Unit": "cpu_core"
     },
@@ -1223,6 +1621,7 @@
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x82",
         "Unit": "cpu_core"
     },
@@ -1234,6 +1633,7 @@
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1244,8 +1644,9 @@
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
-        "PEBScounters": "0,1,2,3",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1256,8 +1657,9 @@
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
-        "PEBScounters": "0,1,2,3",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1269,6 +1671,7 @@
         "EventName": "LSD.UOPS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1282,6 +1685,7 @@
         "EventName": "MACHINE_CLEARS.COUNT",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1293,17 +1697,19 @@
         "EventName": "MACHINE_CLEARS.SMC",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "MISC2_RETIRED.LFENCE",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "400009",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
@@ -1326,6 +1732,7 @@
         "EventName": "RESOURCE_STALLS.SB",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -1337,6 +1744,7 @@
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -1348,6 +1756,7 @@
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -1357,6 +1766,7 @@
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -1366,27 +1776,30 @@
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
         "CollectPEBSRecord": "2",
-        "Counter": "35",
+        "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
         "PEBScounters": "35",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -1398,17 +1811,19 @@
         "EventName": "TOPDOWN.SLOTS_P",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "UOPS_DECODED.DEC0_UOPS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.DEC0_UOPS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1420,6 +1835,7 @@
         "EventName": "UOPS_DISPATCHED.PORT_0",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1431,6 +1847,7 @@
         "EventName": "UOPS_DISPATCHED.PORT_1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -1442,6 +1859,7 @@
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -1453,6 +1871,7 @@
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
@@ -1464,6 +1883,7 @@
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
@@ -1475,6 +1895,7 @@
         "EventName": "UOPS_DISPATCHED.PORT_6",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
@@ -1486,6 +1907,7 @@
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
@@ -1498,6 +1920,7 @@
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -1510,6 +1933,7 @@
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -1522,6 +1946,7 @@
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -1534,6 +1959,7 @@
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -1546,6 +1972,7 @@
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1558,6 +1985,7 @@
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1570,6 +1998,7 @@
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1582,6 +2011,7 @@
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1595,6 +2025,7 @@
         "Invert": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1608,6 +2039,7 @@
         "Invert": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1619,6 +2051,7 @@
         "EventName": "UOPS_EXECUTED.THREAD",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1630,6 +2063,7 @@
         "EventName": "UOPS_EXECUTED.X87",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
@@ -1641,6 +2075,7 @@
         "EventName": "UOPS_ISSUED.ANY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
@@ -1657,7 +2092,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
@@ -1668,7 +2103,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "TBD",
+        "BriefDescription": "UOPS_RETIRED.MS",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
@@ -1718,4 +2153,4 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
index 50de82c29944..b1ae349f5f21 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -3,7 +3,7 @@
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
         "Counter": "Fixed",
         "CounterType": "PGMABLE",
-	"EventCode": "0xff",
+        "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
         "Unit": "CLOCK"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index 1cc39aa032e1..12baf768ad8d 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -7,6 +7,7 @@
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe",
         "Unit": "cpu_atom"
     },
@@ -18,17 +19,55 @@
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0xe",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a DTLB miss when load subse=
quently retires.",
+        "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks due to an ins=
truction fetch that miss the PDE (Page Directory Entry) cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3,4,5",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DTLB=
 miss.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.DTLB_MISS_AT_RET",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x90",
         "Unit": "cpu_atom"
     },
@@ -40,6 +79,7 @@
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
@@ -52,6 +92,7 @@
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
@@ -63,6 +104,7 @@
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
@@ -74,6 +116,7 @@
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -85,6 +128,7 @@
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -96,6 +140,7 @@
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -107,6 +152,7 @@
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
@@ -118,6 +164,7 @@
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
@@ -130,6 +177,7 @@
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
@@ -141,6 +189,7 @@
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
@@ -152,6 +201,7 @@
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
@@ -163,6 +213,7 @@
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -174,6 +225,7 @@
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -185,6 +237,7 @@
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
@@ -196,6 +249,7 @@
         "EventName": "ITLB_MISSES.STLB_HIT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
@@ -208,6 +262,7 @@
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
@@ -219,6 +274,7 @@
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0xe",
         "Unit": "cpu_core"
     },
@@ -230,6 +286,7 @@
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
@@ -241,6 +298,7 @@
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
@@ -252,7 +310,8 @@
         "EventName": "ITLB_MISSES.WALK_PENDING",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index ebb7fc8fc576..1fe376b3624d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,4 +1,5 @@
 Family-model,Version,Filename,EventType
+GenuineIntel-6-9[7A],v1.13,alderlake,core
 GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v23,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
@@ -41,8 +42,6 @@ GenuineIntel-6-6A,v1,icelakex,core
 GenuineIntel-6-6C,v1,icelakex,core
 GenuineIntel-6-86,v1,tremontx,core
 GenuineIntel-6-96,v1,elkhartlake,core
-GenuineIntel-6-97,v1,alderlake,core
-GenuineIntel-6-9A,v1,alderlake,core
 GenuineIntel-6-8F,v1,sapphirerapids,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
--=20
2.37.1.359.gd136c6c3e2-goog

