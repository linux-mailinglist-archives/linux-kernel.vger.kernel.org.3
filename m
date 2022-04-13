Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6BE50008C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbiDMVHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiDMVHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:07:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8614BBA7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e644c76556so26556497b3.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=2onfR0ldLdqPNQPzlz6oPhyibxCMdzJtDEGKPeihEGk=;
        b=QoK5/QGLMdNof44a1gSVwUSf6grd/sNFjglL7TpRIzxkgOqKacEHwW86kiOPNb3zLG
         Bi4DMqLgq3ZKX5Afp58kBjqtLjWfWZM6dgcn7PpBTcb9aTdDhIEPmsYSyvgT3PN/ksrj
         f3Nrhd4fQKIa9ey2XKSp54T/ndZubWjyOspmwsb/EwFfJI6dsxvCfJxWfe5Cxc/G3ru4
         RC//YLMIf92gHG87B3GIhrKknr6G3YQ0Bzb973X5QRSB/ztjDb9iSGC36k239Ra88q8/
         tpDtR2f30Ke1eUFruSQe9bWpWU/GXuO3oivfWvgk2YgHg4luWou+tD5MLO0fL5W9nS6A
         Og9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=2onfR0ldLdqPNQPzlz6oPhyibxCMdzJtDEGKPeihEGk=;
        b=vbb+9OZeuWjomFcQoxIDSft1o4qECRpdo+mwxFSABjdKslh1HyzjweY1qsybWuildY
         TkkSnCEEKuo7ybnPIkA++hrAkOle88wD/uvqUWAesaYNGZdhKG5btfxKiMhyLfRfgbMJ
         XpE7dJghMWjMUDUY8mrutQ/FanZ2ceuUWAGgsg0ioXfrSON3muHpe8kcvBhqgY7mzOAZ
         71SRZGRSFvTMmFefDIGwmpxI1HkzIOzQHq8Ybze0RQlB9K2vmhSW6ODdL2wMFe9LEWYe
         AeRFDKOBamExOTcNSK9+IVSgQ52tZbyg8F+38d18Zo6F+dw2Jj7tSeEQMm3j1BULYkcY
         WqVQ==
X-Gm-Message-State: AOAM530K5Bl26ukP+ZWZ7PbIs6Xgj5nJ0/QHb09K1HlIbSXpGAbW6mBW
        ISRBquDJyBia8J8vqi8DdrY+HCrUozqD
X-Google-Smtp-Source: ABdhPJySxiKi4FS0LXghaZSSuQsPvAcs3D6RZg5STH/q0HHLYItt5PH9LEyePfQH8gaq+w9VhPdoT69UesNb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a05:6902:12c2:b0:633:85ae:afdb with SMTP
 id j2-20020a05690212c200b0063385aeafdbmr705434ybu.118.1649883912093; Wed, 13
 Apr 2022 14:05:12 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:52 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-3-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 03/14] perf vendor events intel: Add sapphirerapids events
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

Events were generated from 01.org using:
https://github.com/intel/event-converter-for-linux-perf

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    1 +
 .../arch/x86/sapphirerapids/cache.json        | 1083 ++++++++++++++
 .../x86/sapphirerapids/floating-point.json    |  218 +++
 .../arch/x86/sapphirerapids/frontend.json     |  471 ++++++
 .../arch/x86/sapphirerapids/memory.json       |  415 ++++++
 .../arch/x86/sapphirerapids/other.json        |  329 +++++
 .../arch/x86/sapphirerapids/pipeline.json     | 1271 +++++++++++++++++
 .../x86/sapphirerapids/virtual-memory.json    |  225 +++
 8 files changed, 4013 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/cache.jso=
n
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/floating-=
point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.=
json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/memory.js=
on
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/other.jso=
n
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.=
json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-m=
emory.json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 963a76fec277..f5a382421a60 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -44,6 +44,7 @@ GenuineIntel-6-86,v1,tremontx,core
 GenuineIntel-6-96,v1,elkhartlake,core
 GenuineIntel-6-97,v1,alderlake,core
 GenuineIntel-6-9A,v1,alderlake,core
+GenuineIntel-6-8F,v1,sapphirerapids,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
new file mode 100644
index 000000000000..373b28348b57
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -0,0 +1,1083 @@
+[
+    {
+        "BriefDescription": "Counts the number of cache lines replaced in =
L1 data cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "L1D.REPLACEMENT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.FB_FULL",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailablability. Demand requests incl=
ude cacheable/uncacheable demand load, store, lock or SW prefetch accesses.=
",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailablability.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailablability. Demand requests incl=
ude cacheable/uncacheable demand load, store, lock or SW prefetch accesses.=
",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
L1D_PEND_MISS.L2_STALLS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.L2_STALL",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.L2_STALLS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of L1D misses that are outstanding",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.PENDING",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x48",
+        "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "L2 cache lines filling L2",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.ALL",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1f"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.NON_SILENT",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache when triggered by an L2 cache fill.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.SILENT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache when triggered by an L2 cache fill. These lines are ty=
pically in Shared or Exclusive state. A non-threaded event.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "All L2 requests.[This event is alias to L2_RQ=
STS.REFERENCES]",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all L2 requests.[This event is alias =
to L2_RQSTS.REFERENCES]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_RQSTS.MISS]",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_RQSTS.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f"
+    },
+    {
+        "BriefDescription": "L2 code requests",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_CODE_RD",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of L2 code requests.=
",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts (including requests from L1D hardware prefetchers). These loads may hit =
or miss L2 cache. Only non rejected loads are counted.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe1"
+    },
+    {
+        "BriefDescription": "Demand requests that miss L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts demand requests that miss L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x27"
+    },
+    {
+        "BriefDescription": "Demand requests to L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts demand requests to L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe7"
+    },
+    {
+        "BriefDescription": "RFO requests to L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_RFO",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe2"
+    },
+    {
+        "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_HIT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc4"
+    },
+    {
+        "BriefDescription": "L2 cache misses when fetching instructions",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.CODE_RD_MISS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x24"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests that hit L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc1"
+    },
+    {
+        "BriefDescription": "Demand Data Read miss L2, no rejects",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of demand Data Read reques=
ts that miss L2 cache. Only not rejected loads are counted.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_REQUEST.MISS]",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.MISS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_REQUEST.MISS]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3f"
+    },
+    {
+        "BriefDescription": "All L2 requests.[This event is alias to L2_RE=
QUEST.ALL]",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.REFERENCES",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all L2 requests.[This event is alias =
to L2_REQUEST.ALL]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "RFO requests that hit L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_HIT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc2"
+    },
+    {
+        "BriefDescription": "RFO requests that miss L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.RFO_MISS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x22"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that hit L2 cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.SWPF_HIT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc8"
+    },
+    {
+        "BriefDescription": "SW prefetch requests that miss L2 cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.SWPF_MISS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x28"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "All retired load instructions.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions for loads.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81"
+    },
+    {
+        "BriefDescription": "All retired store instructions.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_STORES",
+        "L1_Hit_Indication": "1",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all retired store instructions. This =
event account for SW prefetch instructions and PREFETCHW instruction for st=
ores.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "All retired memory instructions.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ANY",
+        "L1_Hit_Indication": "1",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x83"
+    },
+    {
+        "BriefDescription": "Retired load instructions with locked access.=
",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with locked=
 access.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Retired load instructions that split across a=
 cacheline boundary.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Retired store instructions that split across =
a cacheline boundary.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
+        "L1_Hit_Indication": "1",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "Retired load instructions that miss the STLB.=
",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Retired store instructions that miss the STLB=
.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
+        "L1_Hit_Indication": "1",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x12"
+    },
+    {
+        "BriefDescription": "Completed demand load uops that miss the L1 d=
-cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xfd"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were hits in L3 without snoops required",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
+        "SampleAfterValue": "20011",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions which data sources =
missed L3 but serviced from local dram",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "TBD",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions whose data sources =
was forwarded from a remote cache",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Retired load instructions whose data sources=
 was forwarded from a remote cache.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "TBD",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired load instructions with remote Intel O=
ptane DC persistent memory as the data source where the data request missed=
 all caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with remote=
 Intel Optane DC persistent memory as the data source and the data request =
missed L3.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_MISC_RETIRED.UC",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
+        "SampleAfterValue": "100007",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L2 cache hits =
as data sources",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
+        "SampleAfterValue": "100021",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Retired load instructions with L3 cache hits =
as data sources",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_HIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
+        "SampleAfterValue": "100021",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retired load instructions missed L3 cache as =
data sources",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.L3_MISS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
+        "SampleAfterValue": "50021",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Retired load instructions with local Intel Op=
tane DC persistent memory as the data source where the data request missed =
all caches.",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_RETIRED.LOCAL_PMM",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts retired load instructions with local =
Intel Optane DC persistent memory as the data source and the data request m=
issed L3.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x44",
+        "EventName": "MEM_STORE_RETIRED.L2_HIT",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired memory uops for any access",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe5",
+        "EventName": "MEM_UOP_RETIRED.ANY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit in the L3 or were snooped from another co=
re's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that resulted in a snoop hit a modified line in an=
other core's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a modified line in a distant L3 Cache or =
were snooped from a distant core's L1/L2 caches on this socket when the sys=
tem is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.SNC_CACHE.HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1008000004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that either hit a non-modified line in a distant L=
3 Cache or were snooped from a distant core's L1/L2 caches on this socket w=
hen the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.SNC_CACHE.HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x808000004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that hit in the L3 o=
r were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit a modified line in another core's caches which forwarded the data.=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop that hit in another core, which did not forward the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another core's caches which forwarded the unmodified data to th=
e requesting core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y a cache on a remote socket where a snoop hit a modified line in another c=
ore's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1030000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y a cache on a remote socket where a snoop hit in another core's caches whi=
ch forwarded the unmodified data to the requesting core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x830000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that hit a modified =
line in a distant L3 Cache or were snooped from a distant core's L1/L2 cach=
es on this socket when the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1008000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that either hit a no=
n-modified line in a distant L3 Cache or were snooped from a distant core's=
 L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) m=
ode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x808000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit in=
 the L3 or were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that result=
ed in a snoop hit a modified line in another core's caches which forwarded =
the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
modified line in a distant L3 Cache or were snooped from a distant core's L=
1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mod=
e.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.SNC_CACHE.HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1008000002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that either=
 hit a non-modified line in a distant L3 Cache or were snooped from a dista=
nt core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA c=
luster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.SNC_CACHE.HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x808000002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t hit in the L3 or were snooped from another core's caches on the same sock=
et.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L3.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x80082380",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hit=
 in the L3 or were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F003C4477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop hit a modified line in another core's caches which forward=
ed the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C4477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop that hit in another core, which did not forward the data."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C4477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop hit in another core's caches which forwarded the unmodifie=
d data to the requesting core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C4477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by a cache on a remote socket where a snoop was sent and data wa=
s returned (Modified or Not Modified).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1830004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by a cache on a remote socket where a snoop hit a modified line =
in another core's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1030004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by a cache on a remote socket where a snoop hit in another core'=
s caches which forwarded the unmodified data to the requesting core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x830004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hit=
 a modified line in a distant L3 Cache or were snooped from a distant core'=
s L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) =
mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1008004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that eit=
her hit a non-modified line in a distant L3 Cache or were snooped from a di=
stant core's L1/L2 caches on this socket when the system is in SNC (sub-NUM=
A cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.SNC_CACHE.HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x808004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that hit in the L3 or=
 were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.STREAMING_WR.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x80080800",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Demand and prefetch data reads",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Demand Data Read requests sent to uncore",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.NTA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T0",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
new file mode 100644
index 000000000000..1281f293ca41
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
@@ -0,0 +1,218 @@
+[
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all microcode FP assists.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.FP",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all microcode Floating Point assists.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.SSE_AVX_MIX",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.PORT_0",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.PORT_1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "FP_ARITH_DISPATCHED.PORT_5",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed single =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14=
 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform =
2 calculations per element.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14=
 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calc=
ulations per element. The DAZ and FTZ flags in the MXCSR register need to b=
e set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational 512-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 16 computatio=
n operations, one for each element.  Applies to SSE* and AVX* packed single=
 precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT1=
4 RCP14 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform=
 2 calculations per element.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational 512-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 16 computation oper=
ations, one for each element.  Applies to SSE* and AVX* packed single preci=
sion floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP1=
4 FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 cal=
culations per element. The DAZ and FTZ flags in the MXCSR register need to =
be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TBD",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.128B_PACKED_HALF",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TBD",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.256B_PACKED_HALF",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.512B_PACKED_HALF",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "TBD",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.COMPLEX_SCALAR_HALF",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of all Scalar Half-Precision FP arithm=
etic instructions(1) retired - regular and complex.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.SCALAR",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "TBD",
+        "SampleAfterValue": "100003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "TBD",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.SCALAR_HALF",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of all Vector (also called packed) Hal=
f-Precision FP arithmetic instructions(1) retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcf",
+        "EventName": "FP_ARITH_INST_RETIRED2.VECTOR",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "TBD",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1c"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
new file mode 100644
index 000000000000..3b6fb14fc421
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
@@ -0,0 +1,471 @@
+[
+    {
+        "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x87",
+        "EventName": "DECODE.LCP",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x61",
+        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x1",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x11",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced iTLB tru=
e miss.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x14",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruct=
ion L1 Cache true miss.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L1I_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x12",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.L2_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x13",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvati=
on of at least 1 cycle",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600106",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 128 cycles=
 which was not interrupted by a back-end stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x608006",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 16 cycles =
which was not interrupted by a back-end stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x601006",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions after front-end starvati=
on of at least 2 cycles",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600206",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 256 cycles=
 which was not interrupted by a back-end stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x610006",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 1 bubble-slot for a period of 2=
 cycles which was not interrupted by a back-end stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x100206",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 32 cycles =
which was not interrupted by a back-end stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x602006",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 4 cycles w=
hich was not interrupted by a back-end stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600406",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 512 cycles=
 which was not interrupted by a back-end stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x620006",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 64 cycles =
which was not interrupted by a back-end stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x604006",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 8 cycles w=
hich was not interrupted by a back-end stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x600806",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
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
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.STLB_MISS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x15",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x17",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALLS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_ANY",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles DSB is delivering optimal number of Uo=
ps",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "6",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_CYCLES_OK",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "IDQ.DSB_UOPS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering any Uop",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_ANY",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles MITE is delivering optimal number of U=
ops",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "6",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_CYCLES_OK",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MITE_UOPS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles when uops are being delivered to IDQ w=
hile MS is busy",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_CYCLES_ANY",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Number of switches from DSB or MITE to the MS=
",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_SWITCHES",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Uops delivered to IDQ while MS is busy",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x79",
+        "EventName": "IDQ.MS_UOPS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "6",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x9c",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
+        "Invert": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json b/to=
ols/perf/pmu-events/arch/x86/sapphirerapids/memory.json
new file mode 100644
index 000000000000..4c385d05a0c7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
@@ -0,0 +1,415 @@
+[
+    {
+        "BriefDescription": "Execution stalls while L3 cache miss demand l=
oad is outstanding.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "6",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "2",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "3",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "5",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "9",
+        "EventCode": "0x47",
+        "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
+        "SampleAfterValue": "1009",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
+        "SampleAfterValue": "20011",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
+        "SampleAfterValue": "503",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
+        "SampleAfterValue": "100003",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
+        "SampleAfterValue": "101",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
+        "SampleAfterValue": "2003",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
+        "SampleAfterValue": "50021",
+        "TakenAlone": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Retired instructions with at least 1 store uo=
p. This PEBS event is the trigger for stores sampled by the PEBS Store Faci=
lity.",
+        "CollectPEBSRecord": "2",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the local socket's L1, L=
2, or L3 caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were not suppli=
ed by the local socket's L1, L2, or L3 caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were n=
ot supplied by the local socket's L1, L2, or L3 caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FC00002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t missed the local socket's L1, L2, and L3 caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L3.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x94002380",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t were not supplied by the local socket's L1, L2, or L3 caches and the cach=
eline is homed locally.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L3.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x84002380",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the local socket's L1, L2, or L3 caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FC04477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that mis=
sed the L3 Cache and were supplied by the local socket (DRAM or PMM), wheth=
er or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM or DRAM ac=
cesses that are controlled by the close or distant SNC Cluster.  It does no=
t count misses to the L3 which go to Local CXL Type 2 Memory or Local Non D=
RAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL_SOCKET",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x70CC04477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that missed the local=
 socket's L1, L2, and L3 caches.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.STREAMING_WR.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x94000800",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that were not supplie=
d by the local socket's L1, L2, or L3 caches and the cacheline is homed loc=
ally.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.STREAMING_WR.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x84000800",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 4 categories (e.g. interrupt)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_EVENTS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 4 categories (e.g. interrupt).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to various memory events (e.g. read/write capacity and conflicts)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_MEM",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to various memory events (e.g. read/write capacity and conflict=
s).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to incompatible memory type",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to incompatible memory type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution aborted due =
to HLE-unfriendly instructions",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to HLE-unfriendly instructions.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution successfully=
 committed",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.COMMIT",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of times RTM commit succee=
ded.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of times an RTM execution started.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "RTM_RETIRED.START",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of times we entered an RTM=
 region. Does not count nested transactions.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional reads",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CAPACITY_READ",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Speculatively counts the number of TSX aborts=
 due to a data capacity limitation for transactional writes.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of times a transactional abort was sig=
naled due to a data conflict on a transactionally accessed address",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "TX_MEM.ABORT_CONFLICT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/other.json
new file mode 100644
index 000000000000..e6d4921a42cb
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
@@ -0,0 +1,329 @@
+[
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.PAGE_FAULT",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the cycles where the AMX (Advance Matr=
ix Extension) unit is busy performing an operation.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb7",
+        "EventName": "EXE.AMX_BUSY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM attached to this socket=
, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM=
 accesses that are controlled by the close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM on a distant memory con=
troller of this socket when the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.SNC_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x708000004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y PMM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_PMM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x703000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM on a distant memory controller of this socket when the system is in =
SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.SNC_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x708000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FFC0002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mo=
de.  In SNC Mode counts only those DRAM accesses that are controlled by the=
 close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM on a distant memory controller of this socket when the syst=
em is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.SNC_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x708000002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches (which bring data =
to L2) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L2.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10070",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L3.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x12380",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t were not supplied by the local socket's L1, L2, or L3 caches and the cach=
eline was homed in a remote socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.HWPF_L3.REMOTE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x90002380",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FFC4477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC)=
 Mode.  In SNC Mode counts only those DRAM accesses that are controlled by =
the close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM attached to this socket, whether or not in Sub NUMA Clus=
ter(SNC) Mode.  In SNC Mode counts DRAM accesses that are controlled by the=
 close or distant SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x70C004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by PMM attached to this socket, whether or not in Sub NUMA Clust=
er(SNC) Mode.  In SNC Mode counts PMM accesses that are controlled by the c=
lose or distant SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_PMM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x700C04477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the local socket's L1, L2, or L3 caches and were supplied=
 by a remote socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F33004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM on a distant memory controller of this socket when the s=
ystem is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.SNC_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x708004477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10800",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS_EMPTY.CYCLES",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x2d",
+        "EventName": "XQ.FULL_CYCLES",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
new file mode 100644
index 000000000000..25a12e03cb85
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -0,0 +1,1271 @@
+[
+    {
+        "BriefDescription": "TBD",
+        "EventCode": "0xce",
+        "EventName": "AMX_OPS_RETIRED.BF16",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TBD",
+        "EventCode": "0xce",
+        "EventName": "AMX_OPS_RETIRED.INT8",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.DIV_ACTIVE",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.DIVIDER_ACTIVE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.FPDIV_ACTIVE",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.FP_DIVIDER_ACTIVE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event counts the cycles the integer divi=
der is busy.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.IDIV_ACTIVE",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb0",
+        "EventName": "ARITH.INT_DIVIDER_ACTIVE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.ANY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware Examples include AD (page Access Dirty=
), FP and AVX related assists.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1f"
+    },
+    {
+        "BriefDescription": "All branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all branch instructions retired.",
+        "SampleAfterValue": "400009"
+    },
+    {
+        "BriefDescription": "Conditional branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts conditional branch instructions retir=
ed.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Not taken branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts not taken branch instructions retired=
.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Taken conditional branch instructions retired=
.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Far branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts far branch instructions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Direct and indirect near call instructions re=
tired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Return instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts return instructions retired.",
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Taken branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts taken branch instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "All mispredicted branch instructions retired.=
",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
+        "SampleAfterValue": "400009"
+    },
+    {
+        "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken. Non PEBS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Mispredicted indirect CALL retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
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
+        "SampleAfterValue": "100007",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C01",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C02",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x70"
+    },
+    {
+        "BriefDescription": "Cycle counts are evenly distributed between a=
ctive threads in the Core.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Core crystal clock cycles when this thread is=
 unhalted and the other thread is halted.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
+        "SampleAfterValue": "25003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "TBD",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xec",
+        "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "Fixed counter 2",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "PEBScounters": "34",
+        "PublicDescription": "Counts the number of reference cycles when t=
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
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
+        "CollectPEBSRecord": "2",
+        "Counter": "Fixed counter 1",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "PEBScounters": "33",
+        "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "8",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles while L2 cache miss demand load is out=
standing.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "16",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "12",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "Execution stalls while L2 cache miss demand l=
oad is outstanding.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "5",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5"
+    },
+    {
+        "BriefDescription": "Total execution stalls.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "4",
+        "EventCode": "0xa3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles total of 2 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Cycles total of 3 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Cycles total of 4 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "5",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Cycles where the Store Buffer was full and no=
 loads caused an execution stall.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "2",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Instruction decoders utilized in a cycle",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x75",
+        "EventName": "INST_DECODED.DECODERS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
+        "CollectPEBSRecord": "2",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.ANY",
+        "PEBS": "1",
+        "PEBScounters": "32",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.MACRO_FUSED",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Number of all retired NOP instructions.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.NOP",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
+        "CollectPEBSRecord": "2",
+        "Counter": "Fixed counter 0",
+        "EventName": "INST_RETIRED.PREC_DIST",
+        "PEBS": "1",
+        "PEBScounters": "32",
+        "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.REP_ITERATION",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "TBD",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.MBA_STALLS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.RECOVERY_CYCLES",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
+        "SampleAfterValue": "500009",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x7",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "TMA slots where uops got dropped",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xad",
+        "EventName": "INT_MISC.UOP_DROPPING",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.128BIT",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x13"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.256BIT",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xac"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 128-bit vector instruct=
ions.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_128",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "integer ADD, SUB, SAD 256-bit vector instruct=
ions.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.ADD_256",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.MUL_256",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.SHUFFLES",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_128",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "INT_VEC_RETIRED.VNNI_256",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.NO_SR",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x88"
+    },
+    {
+        "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "Counts the number of demand load dispatches t=
hat hit L1D fill buffer (FB) allocated for software prefetch.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4c",
+        "EventName": "LOAD_HIT_PREFETCH.SWPF",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_ACTIVE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles optimal number of Uops delivered by th=
e LSD, but did not come from the decoder.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "6",
+        "EventCode": "0xa8",
+        "EventName": "LSD.CYCLES_OK",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of Uops delivered by the LSD.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa8",
+        "EventName": "LSD.UOPS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of machine clears (nukes) of any type.=
",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.COUNT",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Self-modifying code (SMC) detected.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC2_RETIRED.LFENCE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "400009",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcc",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa2",
+        "EventName": "RESOURCE_STALLS.SB",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa2",
+        "EventName": "RESOURCE_STALLS.SCOREBOARD",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TMA slots where no uops were being issued due=
 to lack of back-end resources.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation=
s.",
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
+        "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of specualtive operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
+        "CollectPEBSRecord": "2",
+        "Counter": "Fixed counter 3",
+        "EventName": "TOPDOWN.SLOTS",
+        "PEBScounters": "35",
+        "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.SLOTS_P",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x76",
+        "EventName": "UOPS_DECODED.DEC0_UOPS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops executed on port 0",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_0",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Uops executed on port 1",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 2, 3 and 10",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 4 and 9",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_4_9",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 5 and 11",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_5_11",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Uops executed on port 6",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_6",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Uops executed on ports 7 and 8",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "UOPS_DISPATCHED.PORT_7_8",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Number of uops executed on the core.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of uops executed from any =
thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "2",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "4",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "2",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "3",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "4",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.STALLS",
+        "Invert": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_EXECUTED.STALLS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.STALL_CYCLES",
+        "Invert": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.THREAD",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops dispatched.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb1",
+        "EventName": "UOPS_EXECUTED.X87",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of x87 uops executed.",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Uops that RAT issues to RS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.ANY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Cycles with retired uop(s).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.CYCLES",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts cycles where at least one uop has ret=
ired.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.HEAVY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "TBD",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "MSRIndex": "0x3F7",
+        "MSRValue": "0x8",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "TakenAlone": "1",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Retirement slots used.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.SLOTS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the retirement slots used each cycle.=
",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Cycles without actually retired uops.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.STALLS",
+        "Invert": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "This event counts cycles without actually re=
tired uops.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_RETIRED.STALLS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.STALL_CYCLES",
+        "Invert": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
new file mode 100644
index 000000000000..cba69368308e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
@@ -0,0 +1,225 @@
+[
+    {
+        "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 1G page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for a demand=
 load in the PMH each cycle.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Stores that miss the DTLB and hit the STLB.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 1G page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for a store =
in the PMH each cycle.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.STLB_HIT",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for code (instruction fetch) request.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_ACTIVE",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of page walks outstanding for an outst=
anding code request in the PMH each cycle.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_PENDING",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x10"
+    }
+]
--=20
2.36.0.rc0.470.gd361397f0d-goog

