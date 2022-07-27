Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9B58352D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiG0WMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbiG0WLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:11:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5386E60534
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a11-20020a5b090b000000b00672acbe13c1so257884ybq.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=q5I7cSh1hZ5hUaG9oP/hKj02fl7BLkhlrzGqrEd6Zk4=;
        b=nJjfXSPz9aDkS8Gzy13fCPAHs9P4SlqbTVPQ2mCYQupdphP0riZo47ZrQ/rXSlZRIk
         Bi6q8QUdWF1URVxJo65jMNtEcqsGQBlDLRosp5xeC1i5KUdn+x1+MFDQc3v/td3ukTSd
         NHSLoYqKtzoPs/vXhvI/3TzoJdGdd70NYEMB5XC7OlxmUpyUnJrCEihT4IHYrSY2I+0t
         HhELsjNKqK42eKrF3w22TvXt/YTT4kYjZO09XY5tkcTo/lhLL9VqtEnDatZqiWDOj2zB
         mIir4QMkpA7QVOiuM2+5cxJGMO+Ko+8eH1nPb7zZ0c0z2VmK/+U9fZyq6rRvBmuVlBxb
         XbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=q5I7cSh1hZ5hUaG9oP/hKj02fl7BLkhlrzGqrEd6Zk4=;
        b=LR5T6yOATY6YarZvZmdaNr1EGWuZlwhuhpKxJlZ22Nbc5LkF6vpfLn4s+C4UN6HMiL
         uN0R3//f1ZNVk20BpIACX8L6vCjBEcQPpALE0o/fNPR07XV86eW+YMByz+S+4GXiKMjm
         hthJSEmJiMb8ERnqqpTJpCDR3lnLSEZhO67zPmM98G29ufoKrn3rp+0VROlwM5aTyL3S
         KslUdXx+0XQnpo760Cd8mYHhgJ4sj2ZxENCrNYKNGsO36Eicg0fVAUimiRUVW3b+eZKR
         6s+Q+C7kuEp0cBhlr98cJLvmSB4MxpKigIv2mnYNNYlaQTQNMwlYGzKhOhpx6IVXop1r
         GR8A==
X-Gm-Message-State: AJIora+V7XaHTcST7/1UvtiLEh0LG79MuomJJXsiwTI/Mrm6L26jWDFy
        C3ileL9zcESkktpZmt2VKAlazHHAHhES
X-Google-Smtp-Source: AGRyM1sV3mtDliYqRx5llWVgk0fSsdQWJQnogV327eU583NLLuFz9TfYMV6GF51m/L1vdeQfJGJo2UEbt78N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a05:6902:3c4:b0:670:6a54:dbc2 with SMTP id
 g4-20020a05690203c400b006706a54dbc2mr18617548ybs.576.1658959783369; Wed, 27
 Jul 2022 15:09:43 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:24 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-23-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 22/30] perf vendor events: Update Intel sapphirerapids
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

Update to v1.04, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the sapphirerapids files into perf and update mapfile.csv.

Tested on a non-sapphirerapids with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/sapphirerapids/cache.json        |  46 +-
 .../arch/x86/sapphirerapids/memory.json       |  11 +
 .../arch/x86/sapphirerapids/other.json        |  64 +-
 .../arch/x86/sapphirerapids/pipeline.json     |  18 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  | 566 +++++++++++++++++-
 .../arch/x86/sapphirerapids/uncore-other.json |   9 -
 7 files changed, 691 insertions(+), 25 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 0b56c4a8a3a8..317ae526e376 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -20,6 +20,7 @@ GenuineIntel-6-AA,v1.00,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
+GenuineIntel-6-8F,v1.04,sapphirerapids,core
 GenuineIntel-6-[4589]E,v24,skylake,core
 GenuineIntel-6-A[56],v24,skylake,core
 GenuineIntel-6-37,v13,silvermont,core
@@ -31,7 +32,6 @@ GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55-[01234],v1,skylakex,core
 GenuineIntel-6-8[CD],v1,tigerlake,core
 GenuineIntel-6-86,v1,snowridgex,core
-GenuineIntel-6-8F,v1,sapphirerapids,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index 92c55ef996aa..348476ce8107 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -131,6 +131,18 @@
         "Speculative": "1",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.USELESS_HWPF",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_RQSTS.REFERENCES]",
         "CollectPEBSRecord": "2",
@@ -358,18 +370,31 @@
         "UMask": "0x28"
     },
     {
-        "BriefDescription": "LONGEST_LAT_CACHE.MISS",
+        "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
         "SampleAfterValue": "100003",
         "Speculative": "1",
         "UMask": "0x41"
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
+        "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x4f"
+    },
+    {
+        "BriefDescription": "Retired load instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -377,12 +402,12 @@
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
@@ -391,7 +416,7 @@
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
@@ -1013,6 +1038,17 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO), hard=
ware prefetch RFOs (which bring data to L2), and software prefetches for ex=
clusive ownership (PREFETCHW) that hit to a (M)odified cacheline in the L3 =
or snoop filter.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.RFO_TO_CORE.L3_HIT_M",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F80040022",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts streaming stores that hit in the L3 or=
 were snooped from another core's caches on the same socket.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json b/to=
ols/perf/pmu-events/arch/x86/sapphirerapids/memory.json
index cb861211b7bc..6e761b628ca4 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
@@ -276,6 +276,17 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and t=
he cacheline is homed locally.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F04C04477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that missed the L3 Cache and were supplied by the local socket (DRAM or=
 PMM), whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PM=
M or DRAM accesses that are controlled by the close or distant SNC Cluster.=
  It does not count misses to the L3 which go to Local CXL Type 2 Memory or=
 Local Non DRAM.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/other.json
index acef4a2b8968..95dbef8ae80a 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
@@ -174,6 +174,17 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts data load hardware prefetch requests t=
o the L1 data cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L1D.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10400",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts hardware prefetches (which bring data =
to L2) that have any type of response.",
         "Counter": "0,1,2,3",
@@ -207,6 +218,17 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines and =
streaming stores that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.MODIFIED_WRITE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10808",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that have any type of response.",
         "Counter": "0,1,2,3",
@@ -344,9 +366,49 @@
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa5",
+        "EventName": "RS.EMPTY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x7"
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
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x7"
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
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
         "EventName": "RS_EMPTY.CYCLES",
         "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor.",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x7"
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index bceea0304620..df4f3d714e6e 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -57,7 +57,6 @@
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "ARITH.IDIV_ACTIVE",
         "SampleAfterValue": "1000003",
         "Speculative": "1",
         "UMask": "0x8"
@@ -229,7 +228,7 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken. Non PEBS",
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
@@ -393,6 +392,18 @@
         "Speculative": "1",
         "UMask": "0x3"
     },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
+        "SampleAfterValue": "2000003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
         "CollectPEBSRecord": "2",
@@ -617,12 +628,13 @@
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Number of all retired NOP instructions.",
+        "BriefDescription": "Retired NOP instructions.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
         "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json=
 b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 8f9497838bd4..b9adef1fb72e 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -11,12 +11,6 @@
         "MetricGroup": "Ret;Summary",
         "MetricName": "IPC"
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
@@ -526,5 +520,565 @@
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
+        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000) /=
 duration_time",
+        "MetricGroup": "",
+        "MetricName": "io_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "MetricExpr": "(( UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERT=
S.IO_ITOMCACHENEAR ) * 64 / 1000000) / duration_time",
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
+        "MetricExpr": "100 * ( ( topdown\\-fetch\\-lat / ( topdown\\-fe\\-=
bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) =
- INT_MISC.UOP_DROPPING / ( slots ) ) )",
+        "MetricGroup": "Frontend;TmaL2;m_tma_frontend_bound_percent",
+        "MetricName": "tma_fetch_latency_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
+        "MetricExpr": "100 * ( ICACHE_DATA.STALLS / ( CPU_CLK_UNHALTED.THR=
EAD ) )",
+        "MetricGroup": "BigFoot;FetchLat;IcMiss;TmaL3;m_tma_fetch_latency_=
percent",
+        "MetricName": "tma_icache_misses_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses.",
+        "MetricExpr": "100 * ( ICACHE_TAG.STALLS / ( CPU_CLK_UNHALTED.THRE=
AD ) )",
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
NHALTED.THREAD ) + ( INT_MISC.UNKNOWN_BRANCH_CYCLES / ( CPU_CLK_UNHALTED.TH=
READ ) ) )",
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
+        "MetricExpr": "100 * ( DECODE.LCP / ( CPU_CLK_UNHALTED.THREAD ) )"=
,
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
bound ) - INT_MISC.UOP_DROPPING / ( slots ) ) - ( ( topdown\\-fetch\\-lat /=
 ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdo=
wn\\-be\\-bound ) - INT_MISC.UOP_DROPPING / ( slots ) ) ) ) )",
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
n\\-be\\-bound ) ) + ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) , 0 ) )",
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
+        "MetricExpr": "( 100 * ( topdown\\-br\\-mispredict / ( topdown\\-f=
e\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-boun=
d ) ) ) + ( 0 * slots )",
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
ng + topdown\\-be\\-bound ) ) + ( topdown\\-retiring / ( topdown\\-fe\\-bou=
nd + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) )=
 , 0 ) ) - ( topdown\\-br\\-mispredict / ( topdown\\-fe\\-bound + topdown\\=
-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) )",
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
+        "MetricExpr": "( 100 * ( topdown\\-be\\-bound / ( topdown\\-fe\\-b=
ound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) )=
 ) + ( 0 * slots )",
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
+        "MetricExpr": "( 100 * ( topdown\\-mem\\-bound / ( topdown\\-fe\\-=
bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) =
) ) + ( 0 * slots )",
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
+        "MetricExpr": "100 * ( max( ( EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY=
_ACTIVITY.STALLS_L1D_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) , 0 ) )",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memor=
y_bound_percent",
+        "MetricName": "tma_l1_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 m=
isses/L2 hits) can improve the latency and increase performance.",
+        "MetricExpr": "100 * ( ( MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_=
ACTIVITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) )",
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
+        "MetricExpr": "100 * ( ( MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_A=
CTIVITY.STALLS_L3_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) )",
+        "MetricGroup": "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memor=
y_bound_percent",
+        "MetricName": "tma_l3_bound_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads. Better caching can i=
mprove the latency and increase performance.",
+        "MetricExpr": "100 * ( min( ( ( ( MEMORY_ACTIVITY.STALLS_L3_MISS /=
 ( CPU_CLK_UNHALTED.THREAD ) ) - ( min( ( ( ( ( 1 - ( ( ( 19 * ( MEM_LOAD_L=
3_MISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_R=
ETIRED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * ( 1=
 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_L=
OAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LO=
AD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * ( 1 +=
 ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) ) ) / ( ( 1=
9 * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HI=
T / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + 10 * ( ( MEM_LOAD_L3_MISS_RETIRED.=
LOCAL_DRAM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS )=
 ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * ( 1 + ( MEM_LOAD_RETIRED.F=
B_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) + ( MEM_LOAD_L3_MISS_RETIRED.REM=
OTE_HITM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) )=
 ) ) ) ) + ( 25 * ( ( MEM_LOAD_RETIRED.LOCAL_PMM * ( 1 + ( MEM_LOAD_RETIRED=
.FB_HIT / ( MEM_LOAD_RETIRED.L1_MISS ) ) ) ) ) + 33 * ( ( MEM_LOAD_L3_MISS_=
RETIRED.REMOTE_PMM * ( 1 + ( MEM_LOAD_RETIRED.FB_HIT / ( MEM_LOAD_RETIRED.L=
1_MISS ) ) ) ) ) ) ) ) ) ) * ( MEMORY_ACTIVITY.STALLS_L3_MISS / ( CPU_CLK_U=
NHALTED.THREAD ) ) ) if ( ( 1000000 ) * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_P=
MM + MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else 0 ) ) ,=
 ( 1 ) ) ) ) ) , ( 1 ) ) )",
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
ISS ) ) ) ) ) ) ) ) ) ) * ( MEMORY_ACTIVITY.STALLS_L3_MISS / ( CPU_CLK_UNHA=
LTED.THREAD ) ) ) if ( ( 1000000 ) * ( MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM =
+ MEM_LOAD_RETIRED.LOCAL_PMM ) > MEM_LOAD_RETIRED.L1_MISS ) else 0 ) ) , ( =
1 ) ) )",
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
+        "MetricExpr": "( 100 * ( max( 0 , ( topdown\\-be\\-bound / ( topdo=
wn\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\=
\-bound ) ) - ( topdown\\-mem\\-bound / ( topdown\\-fe\\-bound + topdown\\-=
bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) ) ) + ( 0 * sl=
ots )",
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
+        "MetricExpr": "( 100 * ( ( EXE_ACTIVITY.EXE_BOUND_0_PORTS + ( EXE_=
ACTIVITY.1_PORTS_UTIL + ( topdown\\-retiring / ( topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * cpu@EXE=
_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@ ) ) / ( CPU_CLK_UNHALTED.THREAD ) i=
f ( ARITH.DIVIDER_ACTIVE < ( CYCLE_ACTIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOU=
ND_ON_LOADS ) ) else ( EXE_ACTIVITY.1_PORTS_UTIL + ( topdown\\-retiring / (=
 topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown=
\\-be\\-bound ) ) * cpu@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@ ) / ( CP=
U_CLK_UNHALTED.THREAD ) ) ) + ( 0 * slots )",
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
+        "MetricExpr": "( 100 * ( max( 0 , ( topdown\\-retiring / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) ) - ( topdown\\-heavy\\-ops / ( topdown\\-fe\\-bound + topdown\\-ba=
d\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) ) ) + ( 0 * slot=
s )",
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
CALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2=
.SCALAR ) / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad=
\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) ) + (=
 min( ( ( FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.=
128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_IN=
ST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + =
FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.VECTOR ) =
/ ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + =
topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) ) , ( 1 ) ) ) +=
 ( cpu@AMX_OPS_RETIRED.BF16\\,cmask\\=3D0x1@ / ( ( topdown\\-retiring / ( t=
opdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\=
-be\\-bound ) ) * ( slots ) ) ) )",
+        "MetricGroup": "HPC;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_fp_arith_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired). Vector/Matrix In=
t operations and shuffles are counted. Note this metric's value may exceed =
its parent due to use of \"Uops\" CountDomain.",
+        "MetricExpr": "100 * ( ( ( INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIR=
ED.VNNI_128 ) / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\=
-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) )=
 + ( ( INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 + INT_VEC_RETIRED.=
VNNI_256 ) / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-ba=
d\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) ) + =
( INT_VEC_RETIRED.SHUFFLES / ( ( topdown\\-retiring / ( topdown\\-fe\\-boun=
d + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * =
( slots ) ) ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_int_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "MetricExpr": "100 * ( ( max( 0 , ( topdown\\-retiring / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) ) - ( topdown\\-heavy\\-ops / ( topdown\\-fe\\-bound + topdown\\-ba=
d\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) ) * MEM_UOP_RETI=
RED.ANY / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\=
-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_memory_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions. The instruction pairs of CMP+JCC or DEC+JCC=
 are commonly used examples.",
+        "MetricExpr": "100 * ( ( max( 0 , ( topdown\\-retiring / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) ) - ( topdown\\-heavy\\-ops / ( topdown\\-fe\\-bound + topdown\\-ba=
d\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) ) * INST_RETIRED=
.MACRO_FUSED / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-=
bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) )"=
,
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_fused_instructions_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused. Non-conditi=
onal branches like direct JMP or CALL would count here. Can be used to exam=
ine fusible conditional jumps that were not fused.",
+        "MetricExpr": "100 * ( ( max( 0 , ( topdown\\-retiring / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) ) - ( topdown\\-heavy\\-ops / ( topdown\\-fe\\-bound + topdown\\-ba=
d\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) ) * ( BR_INST_RE=
TIRED.ALL_BRANCHES - INST_RETIRED.MACRO_FUSED ) / ( ( topdown\\-retiring / =
( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdow=
n\\-be\\-bound ) ) * ( slots ) ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_non_fused_branches_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions. Compilers often use NOPs f=
or certain address alignments - e.g. start address of a function or loop bo=
dy.",
+        "MetricExpr": "100 * ( ( max( 0 , ( topdown\\-retiring / ( topdown=
\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-=
bound ) ) - ( topdown\\-heavy\\-ops / ( topdown\\-fe\\-bound + topdown\\-ba=
d\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) ) * INST_RETIRED=
.NOP / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-sp=
ec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) )",
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
n\\-be\\-bound ) ) - ( topdown\\-heavy\\-ops / ( topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) ) - ( (=
 ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + t=
opdown\\-retiring + topdown\\-be\\-bound ) ) * UOPS_EXECUTED.X87 / UOPS_EXE=
CUTED.THREAD ) + ( ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RE=
TIRED.SCALAR_DOUBLE + FP_ARITH_INST_RETIRED2.SCALAR ) / ( ( topdown\\-retir=
ing / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + =
topdown\\-be\\-bound ) ) * ( slots ) ) ) + ( min( ( ( FP_ARITH_INST_RETIRED=
.128B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE +=
 FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARITH_INST_RETIRED.512B_PACK=
ED_SINGLE + FP_ARITH_INST_RETIRED2.VECTOR ) / ( ( topdown\\-retiring / ( to=
pdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-=
be\\-bound ) ) * ( slots ) ) ) , ( 1 ) ) ) + ( cpu@AMX_OPS_RETIRED.BF16\\,c=
mask\\=3D0x1@ / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\=
-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) )=
 ) + ( ( ( INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128 ) / ( ( topdo=
wn\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-r=
etiring + topdown\\-be\\-bound ) ) * ( slots ) ) ) + ( ( INT_VEC_RETIRED.AD=
D_256 + INT_VEC_RETIRED.MUL_256 + INT_VEC_RETIRED.VNNI_256 ) / ( ( topdown\=
\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-reti=
ring + topdown\\-be\\-bound ) ) * ( slots ) ) ) + ( INT_VEC_RETIRED.SHUFFLE=
S / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec =
+ topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots ) ) ) ) + ( ( max=
( 0 , ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec =
+ topdown\\-retiring + topdown\\-be\\-bound ) ) - ( topdown\\-heavy\\-ops /=
 ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdo=
wn\\-be\\-bound ) ) ) ) * MEM_UOP_RETIRED.ANY / ( ( topdown\\-retiring / ( =
topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\=
\-be\\-bound ) ) * ( slots ) ) ) + ( ( max( 0 , ( topdown\\-retiring / ( to=
pdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-=
be\\-bound ) ) - ( topdown\\-heavy\\-ops / ( topdown\\-fe\\-bound + topdown=
\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) ) ) * INST_RE=
TIRED.MACRO_FUSED / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdo=
wn\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( slots )=
 ) ) + ( ( max( 0 , ( topdown\\-retiring / ( topdown\\-fe\\-bound + topdown=
\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) - ( topdown\\=
-heavy\\-ops / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-re=
tiring + topdown\\-be\\-bound ) ) ) ) * ( BR_INST_RETIRED.ALL_BRANCHES - IN=
ST_RETIRED.MACRO_FUSED ) / ( ( topdown\\-retiring / ( topdown\\-fe\\-bound =
+ topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) * ( =
slots ) ) ) + ( ( max( 0 , ( topdown\\-retiring / ( topdown\\-fe\\-bound + =
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) ) - ( to=
pdown\\-heavy\\-ops / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdo=
wn\\-retiring + topdown\\-be\\-bound ) ) ) ) * INST_RETIRED.NOP / ( ( topdo=
wn\\-retiring / ( topdown\\-fe\\-bound + topdown\\-bad\\-spec + topdown\\-r=
etiring + topdown\\-be\\-bound ) ) * ( slots ) ) ) ) ) )",
+        "MetricGroup": "Pipeline;TmaL3;m_tma_light_operations_percent",
+        "MetricName": "tma_other_light_ops_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or microcoded sequences. This highly-correlates with the =
uop length of these instructions/sequences.",
+        "MetricExpr": "( 100 * ( topdown\\-heavy\\-ops / ( topdown\\-fe\\-=
bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) =
) ) + ( 0 * slots )",
+        "MetricGroup": "Retire;TmaL2;m_tma_retiring_percent",
+        "MetricName": "tma_heavy_operations_percent",
+        "ScaleUnit": "1%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number of=
 uops in such instructions.",
+        "MetricExpr": "100 * ( ( topdown\\-heavy\\-ops / ( topdown\\-fe\\-=
bound + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound ) =
) - ( UOPS_RETIRED.MS / ( slots ) ) )",
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
+        "MetricExpr": "100 * ( UOPS_RETIRED.MS / ( slots ) )",
+        "MetricGroup": "MicroSeq;TmaL3;m_tma_heavy_operations_percent",
+        "MetricName": "tma_microcode_sequencer_percent",
+        "ScaleUnit": "1%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.jso=
n b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.json
index 9b8664c50213..495ceee21071 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-other.json
@@ -20,15 +20,6 @@
         "UMaskExt": "0x00000000",
         "Unit": "UPI LL"
     },
-    {
-        "BriefDescription": "Clockticks in the UBOX using a dedicated 48-b=
it Fixed Counter",
-        "Counter": "FIXED",
-        "CounterType": "FIXED",
-        "EventCode": "0xff",
-        "EventName": "UNC_U_CLOCKTICKS",
-        "PerPkg": "1",
-        "Unit": "UBOX"
-    },
     {
         "BriefDescription": "IRP Clockticks",
         "Counter": "0,1",
--=20
2.37.1.359.gd136c6c3e2-goog

