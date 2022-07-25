Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6D58079B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbiGYWj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiGYWiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:38:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2B25E96
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31e6a8e2674so96175817b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=iE4an0EY0imj/bvW+8VIiXmvZp8S96kPHH278Yro1pY=;
        b=ZSCLkGLF2nKonQ17pYDFwHU92+UB9GBafXc+rN0GglKrXRcoIFvJe1MtgEbHIMFOXp
         EG4Sz8HACDFakcGjfs0uVwkOAwE8YZYyWeYDH5mSp5qfCWw7siYifau1Y+Vto/fYDi9s
         xBRpRXZ+8iWIAUDGIIOODYRaBdlni+1CZuMiBcUJ7SUxd4IF0586Me1gxb6+OKPTSl0R
         rAYtkRaSdl69llldbCT5TZ16Er844i6Pd3eYpT6G5mxh1lJJeAnwqMQeqsd8hGS0VfbF
         jmJUg0FCc1MI5M2gafqRJDuziFxOyM7jVIqhXUIYyG8+FSCSXoXE6s4Cwjz9/7f34bfE
         1S4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=iE4an0EY0imj/bvW+8VIiXmvZp8S96kPHH278Yro1pY=;
        b=a0DG+lerUW9mTLSlSUgJPGOT2yrIE5w9d+t8HDZsoLCUVSdC7ZIR4cx7w+xkvenUY0
         0sXEOepkr2j5LwQ/tT7DRRP37HbQPtbzxKY2ZGyVBkL+p21mLMdDCmFjdtMtzWIUhQpq
         CS3pFPm9jQ1cndJPsThrO8rRyYoByIuy8EUf/XUraABFQupBqNUVG+qOTCBIhEYu0c7B
         jbxcQK+z3wQaMvhqPVCsBiZFzxGnQlvaqpGRvX2VpvSc1wWRQsQnaDNLITZ9PzSLyVTU
         M0qutccFVPbQ6JnLG2Is3bR9EM5v1ll+j7HPOsU8gLPdpng+n5TPA2X0QxEbnR2DLT7k
         v4+g==
X-Gm-Message-State: AJIora9jxrPiy/1465u7+zBmGxf1D+rYPC952SNzgQ3ZGJhLF8UzSZgY
        EIg25JECDVIIiKzlDhAbKiGN/7lGVIsY
X-Google-Smtp-Source: AGRyM1u1/Jzdfabi/BEg4TyE0/D9Ofu6fA3tqaKGD7sHJxtvgwhb9TV4ItH8L3Crg2XlueKwf5/jYnoC7Rmj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a05:6902:1207:b0:66e:f2d2:6e91 with SMTP
 id s7-20020a056902120700b0066ef2d26e91mr11329660ybu.153.1658788666047; Mon,
 25 Jul 2022 15:37:46 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:24 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-24-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 23/32] perf vendor events: Update Intel sapphirerapids
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
 .../arch/x86/sapphirerapids/cache.json        | 135 ++++-
 .../x86/sapphirerapids/floating-point.json    |   6 +
 .../arch/x86/sapphirerapids/frontend.json     |  16 +
 .../arch/x86/sapphirerapids/memory.json       |  23 +-
 .../arch/x86/sapphirerapids/other.json        |  68 ++-
 .../arch/x86/sapphirerapids/pipeline.json     |  99 ++-
 .../arch/x86/sapphirerapids/spr-metrics.json  | 566 +++++++++++++++++-
 .../arch/x86/sapphirerapids/uncore-other.json |   9 -
 .../x86/sapphirerapids/virtual-memory.json    |  20 +
 10 files changed, 908 insertions(+), 36 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index eae103022077..0ed0c1ad122b 100644
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
 GenuineIntel-6-86,v1,tremontx,core
-GenuineIntel-6-8F,v1,sapphirerapids,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index 6fa723c9a6f6..348476ce8107 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -1,4 +1,15 @@
 [
+    {
+        "BriefDescription": "L1D.HWPF_MISS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "L1D.HWPF_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of cache lines replaced in =
L1 data cache.",
         "CollectPEBSRecord": "2",
@@ -8,6 +19,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -19,6 +31,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailablability. Demand requests incl=
ude cacheable/uncacheable demand load, store, lock or SW prefetch accesses.=
",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -32,6 +45,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailablability. Demand requests incl=
ude cacheable/uncacheable demand load, store, lock or SW prefetch accesses.=
",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -42,6 +56,7 @@
         "EventName": "L1D_PEND_MISS.L2_STALL",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -53,6 +68,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -64,6 +80,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -76,6 +93,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -87,6 +105,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1f"
     },
     {
@@ -97,6 +116,7 @@
         "EventName": "L2_LINES_OUT.NON_SILENT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -108,17 +128,31 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache when triggered by an L2 cache fill. These lines are ty=
pically in Shared or Exclusive state. A non-threaded event.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x1"
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
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_RQSTS.REFERENCES]",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts all L2 requests.[This event is alias =
to L2_RQSTS.REFERENCES]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_RQSTS.REFERENCES]",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xff"
     },
     {
@@ -130,6 +164,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_RQSTS.MISS]",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x3f"
     },
     {
@@ -141,17 +176,19 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of L2 code requests.=
",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe4"
     },
     {
-        "BriefDescription": "Demand Data Read requests",
+        "BriefDescription": "Demand Data Read access L2 cache",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of demand Data Read reques=
ts (including requests from L1D hardware prefetchers). These loads may hit =
or miss L2 cache. Only non rejected loads are counted.",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe1"
     },
     {
@@ -163,6 +200,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand requests that miss L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x27"
     },
     {
@@ -174,8 +212,20 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand requests to L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe7"
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
+        "UMask": "0xf0"
+    },
     {
         "BriefDescription": "RFO requests to L2 cache",
         "CollectPEBSRecord": "2",
@@ -185,6 +235,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe2"
     },
     {
@@ -196,6 +247,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc4"
     },
     {
@@ -207,6 +259,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x24"
     },
     {
@@ -218,19 +271,32 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc1"
     },
     {
-        "BriefDescription": "Demand Data Read miss L2, no rejects",
+        "BriefDescription": "Demand Data Read miss L2 cache",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of demand Data Read reques=
ts that miss L2 cache. Only not rejected loads are counted.",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x21"
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
+        "UMask": "0x30"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_REQUEST.MISS]",
         "CollectPEBSRecord": "2",
@@ -240,17 +306,19 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_REQUEST.MISS]",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x3f"
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
-        "PublicDescription": "Counts all L2 requests.[This event is alias =
to L2_REQUEST.ALL]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_REQUEST.ALL]",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xff"
     },
     {
@@ -262,6 +330,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc2"
     },
     {
@@ -273,6 +342,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x22"
     },
     {
@@ -284,6 +354,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc8"
     },
     {
@@ -295,20 +366,35 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
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
+        "Speculative": "1",
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
@@ -316,12 +402,12 @@
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
@@ -330,7 +416,7 @@
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
@@ -424,6 +510,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xfd"
     },
     {
@@ -951,6 +1038,17 @@
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
@@ -970,6 +1068,7 @@
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -981,6 +1080,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -992,6 +1092,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1002,6 +1103,7 @@
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -1013,6 +1115,7 @@
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -1024,6 +1127,7 @@
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -1034,6 +1138,7 @@
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -1045,6 +1150,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1056,6 +1162,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -1067,6 +1174,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1078,6 +1186,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
index 53d35dddd313..32074d455691 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
@@ -8,6 +8,7 @@
         "EventName": "ARITH.FPDIV_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -19,6 +20,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts all microcode Floating Point assists.=
",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -29,6 +31,7 @@
         "EventName": "ASSISTS.SSE_AVX_MIX",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -39,6 +42,7 @@
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -49,6 +53,7 @@
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -59,6 +64,7 @@
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
index 04ba0269c73c..44ecf38ad970 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
@@ -8,6 +8,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -19,6 +20,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -313,6 +315,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -324,6 +327,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -336,6 +340,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -348,6 +353,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -359,6 +365,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -371,6 +378,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -383,6 +391,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -394,6 +403,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -406,6 +416,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -419,6 +430,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -430,6 +442,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -441,6 +454,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -453,6 +467,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -466,6 +481,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json b/to=
ols/perf/pmu-events/arch/x86/sapphirerapids/memory.json
index 7436ced3e04e..6e761b628ca4 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
@@ -8,6 +8,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x6"
     },
     {
@@ -19,6 +20,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -30,6 +32,7 @@
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -41,6 +44,7 @@
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x3"
     },
     {
@@ -52,6 +56,7 @@
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x5"
     },
     {
@@ -63,6 +68,7 @@
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x9"
     },
     {
@@ -194,12 +200,13 @@
         "UMask": "0x1"
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
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
         "PEBS": "2",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -269,6 +276,17 @@
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
@@ -388,6 +406,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -399,6 +418,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -410,6 +430,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/other.json
index 7d6f8e25bb10..95dbef8ae80a 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
@@ -7,6 +7,7 @@
         "EventName": "ASSISTS.PAGE_FAULT",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -16,6 +17,7 @@
         "EventName": "EXE.AMX_BUSY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -172,6 +174,17 @@
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
@@ -205,6 +218,17 @@
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
@@ -342,10 +366,51 @@
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
+        "Speculative": "1",
         "UMask": "0x7"
     },
     {
@@ -357,6 +422,7 @@
         "EventName": "XQ.FULL_CYCLES",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index b0920f5b25ed..df4f3d714e6e 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -22,6 +22,7 @@
         "EventName": "ARITH.DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x9"
     },
     {
@@ -34,6 +35,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x9"
     },
     {
@@ -45,6 +47,7 @@
         "EventName": "ARITH.FP_DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -54,8 +57,8 @@
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "ARITH.IDIV_ACTIVE",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -67,6 +70,7 @@
         "EventName": "ARITH.INT_DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -78,6 +82,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware Examples include AD (page Access Dirty=
), FP and AVX related assists.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1f"
     },
     {
@@ -223,7 +228,7 @@
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
@@ -291,6 +296,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -302,6 +308,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -313,6 +320,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x70"
     },
     {
@@ -324,6 +332,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -335,6 +344,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
         "SampleAfterValue": "25003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -345,6 +355,7 @@
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x40"
     },
     {
@@ -356,6 +367,7 @@
         "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x40"
     },
     {
@@ -366,6 +378,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -376,8 +389,21 @@
         "PEBScounters": "34",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
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
@@ -386,6 +412,7 @@
         "PEBScounters": "33",
         "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -396,7 +423,8 @@
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
-        "SampleAfterValue": "2000003"
+        "SampleAfterValue": "2000003",
+        "Speculative": "1"
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
@@ -407,6 +435,7 @@
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -418,6 +447,7 @@
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -429,6 +459,7 @@
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -440,6 +471,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xc"
     },
     {
@@ -451,6 +483,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x5"
     },
     {
@@ -462,6 +495,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -473,6 +507,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -484,6 +519,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -495,6 +531,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -506,6 +543,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -517,6 +555,7 @@
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x21"
     },
     {
@@ -529,6 +568,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x40"
     },
     {
@@ -540,6 +580,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -551,6 +592,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -586,12 +628,13 @@
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
@@ -625,6 +668,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -634,6 +678,7 @@
         "EventName": "INT_MISC.MBA_STALLS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -645,6 +690,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -657,6 +703,7 @@
         "MSRValue": "0x7",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "TakenAlone": "1",
         "UMask": "0x40"
     },
@@ -669,6 +716,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -762,6 +810,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -773,6 +822,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x88"
     },
     {
@@ -784,6 +834,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x82"
     },
     {
@@ -795,6 +846,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -807,6 +859,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -819,6 +872,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -830,6 +884,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -843,6 +898,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -854,6 +910,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -864,6 +921,7 @@
         "EventName": "MISC2_RETIRED.LFENCE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "400009",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -886,6 +944,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -896,6 +955,7 @@
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -907,6 +967,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -916,6 +977,7 @@
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
         "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -925,6 +987,7 @@
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
         "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of specualtive operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -935,6 +998,7 @@
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -945,6 +1009,7 @@
         "PEBScounters": "35",
         "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -956,6 +1021,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -966,6 +1032,7 @@
         "EventName": "UOPS_DECODED.DEC0_UOPS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -977,6 +1044,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -988,6 +1056,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -999,6 +1068,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -1010,6 +1080,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -1021,6 +1092,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -1032,6 +1104,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x40"
     },
     {
@@ -1043,6 +1116,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -1054,6 +1128,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops executed from any =
thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1066,6 +1141,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1078,6 +1154,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1090,6 +1167,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1102,6 +1180,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1114,6 +1193,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1126,6 +1206,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1138,6 +1219,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1150,6 +1232,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1163,6 +1246,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1175,6 +1259,7 @@
         "Invert": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1185,6 +1270,7 @@
         "EventName": "UOPS_EXECUTED.THREAD",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1196,6 +1282,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of x87 uops executed.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -1207,6 +1294,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1222,12 +1310,13 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "UOPS_RETIRED.HEAVY",
+        "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
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
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
index cba69368308e..f591f4fedc0b 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
@@ -8,6 +8,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -20,6 +21,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -31,6 +33,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0xe"
     },
     {
@@ -42,6 +45,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -53,6 +57,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -64,6 +69,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -75,6 +81,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -86,6 +93,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -98,6 +106,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -109,6 +118,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0xe"
     },
     {
@@ -120,6 +130,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -131,6 +142,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -142,6 +154,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -153,6 +166,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -164,6 +178,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -176,6 +191,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -187,6 +203,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0xe"
     },
     {
@@ -198,6 +215,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -209,6 +227,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -220,6 +239,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     }
 ]
--=20
2.37.1.359.gd136c6c3e2-goog

