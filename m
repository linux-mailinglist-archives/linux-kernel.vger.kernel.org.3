Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC15195A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbiEDC4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344116AbiEDC4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:56:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D451A3AE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 19:52:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so163209ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 19:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=7r5RqE4sd1zS9sJRxaFDR6zDwpqcY4irsfhFJp2MHdE=;
        b=hXqL5xB4bwbyh0dBc5TvcGedotp9Cc89J6CUPjw/65RUx9qdA/QWJF+Xh2AgHo/JEW
         sbDy2hbaIJj5NKqscHmat6iJV+cAtTg+Elp7qLLH+v4nLRnRtLX0b5R4g+oKK+Qos6m8
         jzduawXpzXJ1IvbuXKDo5MxZwI2+iy6wIKie3HwIx8JP5P3TEsD4EfZM4Xb6rbK8G7m1
         S43zHDYvkxNHO8V95r/7sicz1WW3OR0zKyRuhC96iD1ukuBDpJ7g37Y/GqGU1/ieb2jN
         JPHJUZusbs8OWHjrydzoLMLiy7lohGN6Gf5GObz11AkmhzRvCEbEmtGbD9Tx2Nkn/lGa
         EooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=7r5RqE4sd1zS9sJRxaFDR6zDwpqcY4irsfhFJp2MHdE=;
        b=8BcGAY1I1lOb5yIGEss8KkDKjlhWY3jcW7Xd65C4KK4btwis4f2PdOvDx6ujU5ocJ4
         sP2QnxJOohVaP558DwTmp1tSKtyanTzW7OH/mTdCIcPQN6L72qXmfaVQzMyIbRwXqNC0
         vLh5m2/yRqm/kvb/oLQfsURLn1GK0p2jPfdRz/snAHJMHqcdmHu6fbOKWbaHM5xt+Mst
         53S0Qfh/0I+FcLlSHqULQc/240V8nqBwWQbpzT094pxxt5qCE2GDX3O47+gOdmOWOE4X
         Jy3ZHDBNoTM/Fe90smb7aziZzzT3adpwcHDRJG1yZKxSKce8Y/oHApuFqmH9PnFtHZdo
         o1vw==
X-Gm-Message-State: AOAM530sGhiN7HJuVsW/wqdctgHCRRvZiz6qifa2CupP9TBCdpIy8zN7
        z/J3RUr/JWJT4I90AJsXixn0ItQ7bWVo
X-Google-Smtp-Source: ABdhPJwSVwiuxpslJ+w+AY4CiHJf4xTzp7MS/WUvspfhLau/jOL1s1XsaIGFelj164FeIYtms0zqrMPZATdc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:51c7:3b17:aa10:ed9b])
 (user=irogers job=sendgmr) by 2002:a25:ba45:0:b0:648:4989:d505 with SMTP id
 z5-20020a25ba45000000b006484989d505mr15985350ybj.304.1651632748672; Tue, 03
 May 2022 19:52:28 -0700 (PDT)
Date:   Tue,  3 May 2022 19:52:19 -0700
In-Reply-To: <20220504025220.2754910-1-irogers@google.com>
Message-Id: <20220504025220.2754910-2-irogers@google.com>
Mime-Version: 1.0
References: <20220504025220.2754910-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 2/3] perf vendor events: Update alderlake to v1.10
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Events from:
https://download.01.org/perfmon/ADL/

Converted to perf json using:
https://github.com/intel/event-converter-for-linux-perf/pull/11

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 70 ++++++++++++++--
 .../pmu-events/arch/x86/alderlake/cache.json  | 42 ++++++----
 .../arch/x86/alderlake/frontend.json          | 17 +++-
 .../pmu-events/arch/x86/alderlake/memory.json | 22 ++---
 .../pmu-events/arch/x86/alderlake/other.json  | 27 ++-----
 .../arch/x86/alderlake/pipeline.json          | 81 +++++++++++++++++--
 .../arch/x86/alderlake/uncore-other.json      |  4 +-
 .../arch/x86/alderlake/virtual-memory.json    |  4 +-
 8 files changed, 205 insertions(+), 62 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 4d172687f936..27a60e183c61 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -190,7 +190,7 @@
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "UOPS_ISSUED.ANY / cpu_core@UOPS_ISSUED.ANY\\,cmask\=
\=3D1@",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "Fetch_UpC",
         "Unit": "cpu_core"
@@ -435,6 +435,66 @@
         "MetricName": "IpFarBranch",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "C1 residency percent per core",
+        "MetricExpr": "(cstate_core@c1\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C1_Core_Residency"
+    },
+    {
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency"
+    },
+    {
+        "BriefDescription": "C7 residency percent per core",
+        "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Core_Residency"
+    },
+    {
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C3 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C3_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C7 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C8 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c8\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C8_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C9 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c9\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C9_Pkg_Residency"
+    },
+    {
+        "BriefDescription": "C10 residency percent per package",
+        "MetricExpr": "(cstate_pkg@c10\\-residency@ / msr@tsc@) * 100",
+        "MetricGroup": "Power",
+        "MetricName": "C10_Pkg_Residency"
+    },
     {
         "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
         "MetricExpr": "TOPDOWN_FE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
@@ -461,7 +521,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
+        "MetricExpr": "(TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)=
)",
         "MetricGroup": "TopdownL1",
         "MetricName": "Backend_Bound_Aux",
         "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that UOPS mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.  All of these s=
ubevents count backend stalls, in slots, due to a resource limitation.   Th=
ese are not cycle based events and therefore can not be precisely added or =
subtracted from the Backend_Bound subevents which are cycle based.  These s=
ubevents are supplementary to Backend_Bound and can be used to analyze resu=
lts from a resource perspective at allocation.  ",
@@ -538,14 +598,14 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricGroup": " ",
         "MetricName": "IpBranch",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
         "MetricGroup": " ",
         "MetricName": "IpCall",
@@ -644,7 +704,7 @@
     },
     {
         "BriefDescription": "Estimated Pause cost. In percent",
-        "MetricExpr": "100 * SERIALIZATION.NON_C01_MS_SCB / ( 5 * CPU_CLK_=
UNHALTED.CORE )",
+        "MetricExpr": "100 * SERIALIZATION.NON_C01_MS_SCB / (5 * CPU_CLK_U=
NHALTED.CORE)",
         "MetricGroup": " ",
         "MetricName": "Estimated_Pause_Cost",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index b83ed129c454..ea973ff5a216 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -1,6 +1,6 @@
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
@@ -11,7 +11,7 @@
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
@@ -22,7 +22,7 @@
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
@@ -33,7 +33,7 @@
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
@@ -88,7 +88,7 @@
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
@@ -101,7 +101,7 @@
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
@@ -114,7 +114,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache.",
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xd1",
@@ -202,6 +202,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
         "PEBS": "2",
@@ -218,6 +219,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
         "PEBS": "2",
@@ -234,6 +236,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
         "PEBS": "2",
@@ -250,6 +253,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
         "PEBS": "2",
@@ -266,6 +270,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
         "PEBS": "2",
@@ -282,6 +287,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
         "PEBS": "2",
@@ -298,6 +304,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
         "PEBS": "2",
@@ -314,6 +321,7 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
+        "L1_Hit_Indication": "1",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
         "PEBS": "2",
@@ -324,7 +332,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts all the retired split loads.",
+        "BriefDescription": "Counts the number of retired split load uops.=
",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
@@ -338,11 +346,13 @@
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
@@ -350,7 +360,7 @@
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
@@ -983,7 +993,7 @@
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
@@ -993,8 +1003,8 @@
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
@@ -1005,7 +1015,7 @@
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
@@ -1137,4 +1147,4 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/alderlake/frontend.json
index 908588f63314..2c27d5806625 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
@@ -294,6 +294,21 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "TBD",
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
@@ -488,4 +503,4 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index 1d4d1ebe2a74..95ff71c9b176 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -1,24 +1,28 @@
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
@@ -29,7 +33,7 @@
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
@@ -40,7 +44,7 @@
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
@@ -63,7 +67,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -74,7 +78,7 @@
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
@@ -295,7 +299,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -306,7 +310,7 @@
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
@@ -315,4 +319,4 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index dc810f093fb0..7a03b6bc0d44 100644
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
@@ -33,18 +33,7 @@
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
+        "BriefDescription": "TBD",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
@@ -100,7 +89,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -111,7 +100,7 @@
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
@@ -122,7 +111,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -143,4 +132,4 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index de2c6e0ef654..eb5e5a889eed 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -23,7 +23,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and Interrupt call and ret=
urn.",
+        "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
@@ -108,7 +108,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of instructions retired. (F=
ixed event)",
+        "BriefDescription": "Counts the total number of instructions retir=
ed. (Fixed event)",
         "CollectPEBSRecord": "2",
         "Counter": "32",
         "EventName": "INST_RETIRED.ANY",
@@ -182,7 +182,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.PAGE_FAULT",
-        "PEBS": "1",
         "PEBScounters": "0,1,2,3,4,5",
         "SampleAfterValue": "20003",
         "UMask": "0x20",
@@ -211,7 +210,7 @@
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
@@ -555,7 +554,18 @@
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
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.IDIV_ACTIVE",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
@@ -566,6 +576,17 @@
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
+        "UMask": "0x1f",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
         "CollectPEBSRecord": "2",
@@ -756,6 +777,39 @@
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
+        "UMask": "0x70",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycle counts are evenly distributed between a=
ctive threads in the Core.",
         "CollectPEBSRecord": "2",
@@ -981,6 +1035,17 @@
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
+        "UMask": "0x80",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Instruction decoders utilized in a cycle",
         "CollectPEBSRecord": "2",
@@ -1244,7 +1309,7 @@
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
-        "PEBScounters": "0,1,2,3",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1256,7 +1321,7 @@
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
-        "PEBScounters": "0,1,2,3",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -1718,4 +1783,4 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
index 50de82c29944..acc6cab7ab3c 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -3,10 +3,10 @@
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les",
         "Counter": "Fixed",
         "CounterType": "PGMABLE",
-	"EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
-        "Unit": "CLOCK"
+        "UMask": "0x01",
+        "Unit": "NCU"
     },
     {
         "BriefDescription": "Counts the number of coherent and in-coherent=
 requests initiated by IA cores, processor graphic units, or LLC",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index 1cc39aa032e1..85516c64b9c0 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -22,7 +22,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a DTLB miss when load subse=
quently retires.",
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DTLB=
 miss.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
@@ -255,4 +255,4 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     }
-]
\ No newline at end of file
+]
--=20
2.36.0.464.gb9c8b46e94-goog

