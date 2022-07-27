Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78F5583516
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbiG0WJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiG0WI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:08:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED952FEB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:08:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so198287yba.22
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zhZsxseHXW9u6Ny5ZCwSNa42vDAFAXbcGxTs3FNJMl4=;
        b=PPsS2tosDBYu8bmWHssyH4aUAK70DygbQQRKWRmLZEsMiSTGSL2tBmGD82TX54n0tH
         y25ALAiPKiHbf9lEVWtwLQNgeg5QrSS3JavRVEibGet44k3RN7X4FqJXeKQJmOqh5TtQ
         GzARF0i6qsg1lxzkSMYgR6moo3R8XZCug1xPkHqdC9cATrCfln/ILVe+rjbwiZzCaKhY
         AikT1ZoLfpSE53WZ11maIjXN0p944k66V2JJe/d4bqINTYbraFckixPw3lQI4pufC25I
         YoiYicc6Lnx2aeti8h+9X82K8wTK1oI3IaUyHjexHAb/I9FSjdASUijcRlQ45XymQJCh
         u8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zhZsxseHXW9u6Ny5ZCwSNa42vDAFAXbcGxTs3FNJMl4=;
        b=r3oYGsFngex35TMGUcVkRt5rX9ZVH3Iea+4EM8p5Oj8u/lg19OQqV7AOO/1MLcK8Ft
         U7ukJhsRYJKxU+aRQdPn0X+gKe0ub8UNS1hheXvCF+aPCwcHZB7E9wOwIVo/dVBEQPXm
         OWTf0rFfoEhNFSr1PXHEtNdQXAp9D9Yk9MGX0Mj3g/plDwkrt3v6hydoFqCU0pvtrwvb
         XMRBSzSHPH1arDsgl0yK8PIxe2gE3ghEXWWkxB9tFlbGSlwF+iQdkw8d5dHhAUc5B3u+
         6FTqa3s0C3xryWY0/rU0YoBYLm0Rk+kLhwJv9MtWBWy2FXCg+/+feJsSzm+unwm+ynL+
         XEwA==
X-Gm-Message-State: AJIora9EVFOqmcrtqlM9uC9VGHzbQGLF7HUq/clrLI1KxpKluDodswRy
        NkRDUXAUBcnZOB/irn0J6vjybZD/sJiX
X-Google-Smtp-Source: AGRyM1sQCyHcrzza6I7JUAOu3JjWL1KLAN9tQKBIOA86rafN0aWXgwlU/J7VoSB2hMEvny0ht8dDz15N8lEp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a25:c087:0:b0:673:e09d:7e9 with SMTP id
 c129-20020a25c087000000b00673e09d07e9mr1461236ybf.534.1658959734597; Wed, 27
 Jul 2022 15:08:54 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:06 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-5-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 04/30] perf vendor events: Update Intel alderlake
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to v1.13, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

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
 .../pmu-events/arch/x86/alderlake/cache.json  |  33 +-
 .../pmu-events/arch/x86/alderlake/other.json  |  54 ++++
 .../arch/x86/alderlake/pipeline.json          | 285 +++++++++++++++++-
 .../arch/x86/alderlake/uncore-other.json      |   2 +-
 .../arch/x86/alderlake/virtual-memory.json    |  36 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +-
 7 files changed, 398 insertions(+), 19 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index f8bdf7812b51..095dd8c7f161 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -592,13 +592,13 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
         "MetricName": "IpBranch",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number means higher occurrence rate)",
+        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
         "MetricName": "IpCall",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
index c6062c44ca75..887dce4dfeba 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -505,6 +505,18 @@
         "UMask": "0x1f",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cache lines that have been L2 hardware prefetched but not used by demand accesses",
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
     {
         "BriefDescription": "All accesses to L2 cache[This event is alias to L2_RQSTS.REFERENCES]",
         "CollectPEBSRecord": "2",
@@ -722,7 +734,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "LONGEST_LAT_CACHE.MISS",
+        "BriefDescription": "Core-originated cacheable requests that missed L3  (Except hardware prefetches to the L3)",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
@@ -734,7 +746,19 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "All retired load instructions.",
+        "BriefDescription": "Core-originated cacheable requests that refer to L3 (Except hardware prefetches to the L3)",
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
@@ -747,7 +771,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "All retired store instructions.",
+        "BriefDescription": "Retired store instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -1140,6 +1164,7 @@
         "BriefDescription": "This event is deprecated. Refer to new event OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
+        "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
         "PEBScounters": "0,1,2,3",
@@ -1153,6 +1178,7 @@
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "CounterMask": "1",
+        "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
         "PEBScounters": "0,1,2,3",
@@ -1178,6 +1204,7 @@
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
+        "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "PEBScounters": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/perf/pmu-events/arch/x86/alderlake/other.json
index b575275654a2..67a9c13cc71d 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -125,6 +125,60 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty for the thread.",
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
+        "BriefDescription": "Counts end of periods where the Reservation Station (RS) was empty.",
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
+        "BriefDescription": "This event is deprecated. Refer to new event RS.EMPTY_COUNT",
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
+        "BriefDescription": "This event is deprecated. Refer to new event RS.EMPTY",
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
     {
         "BriefDescription": "XQ.FULL_CYCLES",
         "CollectPEBSRecord": "2",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
index e0d1495202af..d02e078a90c9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -22,6 +22,30 @@
         "UMask": "0xf9",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of retired JCC (Jump on Conditional Code) branch instructions retired, includes both taken and not taken branches.",
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
+        "BriefDescription": "Counts the number of taken JCC (Jump on Conditional Code) branch instructions retired.",
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
     {
         "BriefDescription": "Counts the number of far branch instructions retired, includes far jump, far call and return, and interrupt call and return.",
         "CollectPEBSRecord": "2",
@@ -34,6 +58,54 @@
         "UMask": "0xbf",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP and near indirect CALL branch instructions retired.",
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
+        "BriefDescription": "Counts the number of near indirect CALL branch instructions retired.",
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
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.INDIRECT_CALL",
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
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.COND",
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
         "BriefDescription": "Counts the number of near CALL branch instructions retired.",
         "CollectPEBSRecord": "2",
@@ -46,6 +118,66 @@
         "UMask": "0xf9",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of near RET branch instructions retired.",
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
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.INDIRECT",
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
+        "BriefDescription": "Counts the number of near relative CALL branch instructions retired.",
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
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.NEAR_RETURN",
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
+        "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.COND_TAKEN",
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
         "BriefDescription": "Counts the total number of mispredicted branch instructions retired for all branch types.",
         "CollectPEBSRecord": "2",
@@ -57,10 +189,118 @@
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted JCC (Jump on Conditional Code) branch instructions retired.",
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
+        "BriefDescription": "Counts the number of mispredicted taken JCC (Jump on Conditional Code) branch instructions retired.",
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
+        "BriefDescription": "Counts the number of mispredicted near indirect JMP and near indirect CALL branch instructions retired.",
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
+        "BriefDescription": "Counts the number of mispredicted near indirect CALL branch instructions retired.",
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
+        "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.INDIRECT_CALL",
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
+        "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.COND",
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
+        "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.INDIRECT",
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
+        "BriefDescription": "Counts the number of mispredicted near RET branch instructions retired.",
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
+        "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.COND_TAKEN",
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
         "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
         "CollectPEBSRecord": "2",
-        "Counter": "33",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PEBScounters": "33",
         "SampleAfterValue": "2000003",
@@ -82,7 +322,7 @@
     {
         "BriefDescription": "Counts the number of unhalted reference clock cycles at TSC frequency. (Fixed event)",
         "CollectPEBSRecord": "2",
-        "Counter": "34",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PEBScounters": "34",
         "SampleAfterValue": "2000003",
@@ -93,7 +333,7 @@
     {
         "BriefDescription": "Counts the number of unhalted core clock cycles. (Fixed event)",
         "CollectPEBSRecord": "2",
-        "Counter": "33",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PEBScounters": "33",
         "SampleAfterValue": "2000003",
@@ -115,7 +355,7 @@
     {
         "BriefDescription": "Counts the total number of instructions retired. (Fixed event)",
         "CollectPEBSRecord": "2",
-        "Counter": "32",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PEBScounters": "32",
@@ -123,6 +363,17 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the total number of instructions retired.",
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
         "BriefDescription": "This event is deprecated. Refer to new event LD_BLOCKS.ADDRESS_ALIAS",
         "CollectPEBSRecord": "2",
@@ -769,7 +1020,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "number of branch instructions retired that were mispredicted and taken. Non PEBS",
+        "BriefDescription": "number of branch instructions retired that were mispredicted and taken.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
@@ -915,7 +1166,7 @@
     {
         "BriefDescription": "Reference cycles when the core is not in halt state.",
         "CollectPEBSRecord": "2",
-        "Counter": "34",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PEBScounters": "34",
         "SampleAfterValue": "2000003",
@@ -923,10 +1174,22 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt state.",
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
         "BriefDescription": "Core cycles when the thread is not in halt state",
         "CollectPEBSRecord": "2",
-        "Counter": "33",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PEBScounters": "33",
         "SampleAfterValue": "2000003",
@@ -1124,7 +1387,7 @@
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
         "CollectPEBSRecord": "2",
-        "Counter": "32",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PEBScounters": "32",
@@ -1155,7 +1418,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Number of all retired NOP instructions.",
+        "BriefDescription": "Retired NOP instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
@@ -1168,7 +1431,7 @@
     {
         "BriefDescription": "Precise instruction retired with PEBS precise-distribution",
         "CollectPEBSRecord": "2",
-        "Counter": "32",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PEBScounters": "32",
@@ -1532,7 +1795,7 @@
     {
         "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
         "CollectPEBSRecord": "2",
-        "Counter": "35",
+        "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
         "PEBScounters": "35",
         "SampleAfterValue": "10000003",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
index 50de82c29944..b1ae349f5f21 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -3,7 +3,7 @@
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
         "Counter": "Fixed",
         "CounterType": "PGMABLE",
-	"EventCode": "0xff",
+        "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
         "Unit": "CLOCK"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index c5676f11d863..12baf768ad8d 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -23,6 +23,42 @@
         "UMask": "0xe",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of page walks initiated by a instruction fetch that missed the first and second level TLBs.",
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
+        "BriefDescription": "Counts the number of page walks due to an instruction fetch that miss the PDE (Page Directory Entry) cache.",
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
+        "BriefDescription": "Counts the number of page walks completed due to instruction fetch misses to any page size.",
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
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a DTLB miss.",
         "CollectPEBSRecord": "2",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index dd1d24d3cb65..2842f23db82a 100644
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
 GenuineIntel-6-86,v1,snowridgex,core
 GenuineIntel-6-96,v1,elkhartlake,core
-GenuineIntel-6-97,v1,alderlake,core
-GenuineIntel-6-9A,v1,alderlake,core
 GenuineIntel-6-8F,v1,sapphirerapids,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-- 
2.37.1.359.gd136c6c3e2-goog

