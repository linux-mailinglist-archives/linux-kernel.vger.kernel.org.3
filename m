Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C94DCD95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiCQSb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiCQSbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:31:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F525E9CBD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j5-20020a056902020500b00628ab64be30so5040345ybs.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=wQVEsql9KFSlhmmWcTx1opzuixg3YJ5WlocmdM2V+LU=;
        b=tLNhxJAcV22YEk5k1V/UUZiUWRD3rj9tx5xz7kelNdNcfJP3h0/nJn3BItEJC0v0zi
         n7cpyEeHQ328VpE8oiIVkEZQm5cIH0JFbORx4FSQ9MRXAb26SYn9uu8p8q5MNnMgLwk4
         LkmwZYYpFjXJ+UMMBsOm20mwHFGfliXDzEyoGNxjojIrLuv50psuU9vYxUN292JBtRtd
         wJJJCafxKY8o3ZmlqAw6lnXwdS0GNZpH+5jgTGkXjeciqnYvot1YLwHQToajfhadhdhJ
         SybLUcR0nIinv9N+Y7BOSiqn2zHGqQGa/zXKP4y28uECaEfdxzaWEc9b7QZd4456ukP6
         FFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=wQVEsql9KFSlhmmWcTx1opzuixg3YJ5WlocmdM2V+LU=;
        b=nPaLQdAr5sWrtQGKM7QJxsOHwS6o6ywqZzsKjtj4p/tg/PUG7wKAtjF2y8WO1uaiVm
         SOogAb52BpXeJCpm+KwZtYWYcym8jMTX+algKwqBh+Z6iVd92sEaj6U82Br7uDpZOXCZ
         a1TKYlH67vqzO1muU9Wi4pNLNv6GuDB8gIVn8e6x55bS9wdkCs73ximUaKgMi3uCY8mE
         snTdXyyy6jRDXG1O05g8xp5BC5S2wNQDiJoBOx30dahQvHpiyj/sR7/S5eHoOswv/w5t
         vjr/KyFDkX6+eWEk1HM0heoyxhCPfzaL43Ot8sVGYRXCvhwbkJFfywtEx0dMhaSCbgZR
         mnsw==
X-Gm-Message-State: AOAM531LZWsPHzFsZSykENuEtv7Vx2ixQdTAWFbXVc+xIq5RaO9Nban6
        TZU7Hyna/1XF9q7vwYBBJtuoXC7a3uy5
X-Google-Smtp-Source: ABdhPJz2aS2l3vhMmQnY5No+CljTwVI/LVhB/4k7TVYOquWkVZqgv2t3MizuYkO6Dbr3D9+39RK/uZADx0ab
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6811:1685:e3b9:7904])
 (user=irogers job=sendgmr) by 2002:a25:4052:0:b0:628:cdca:afb7 with SMTP id
 n79-20020a254052000000b00628cdcaafb7mr6358043yba.81.1647541786207; Thu, 17
 Mar 2022 11:29:46 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:28:57 -0700
In-Reply-To: <20220317182858.484474-1-irogers@google.com>
Message-Id: <20220317182858.484474-7-irogers@google.com>
Mime-Version: 1.0
References: <20220317182858.484474-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH 7/8] perf vendor events: Update events for Tigerlake
From:   Ian Rogers <irogers@google.com>
To:     Kan Liang <kan.liang@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change:
https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e=
394eed6a1ebd909c9f649d3ed3ef
moved certain "other" type of events in to the cache and pipeline topics.
Update the perf json files for this change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/tigerlake/cache.json  |  86 ++++++++++++
 .../pmu-events/arch/x86/tigerlake/other.json  | 129 ------------------
 .../arch/x86/tigerlake/pipeline.json          |  43 ++++++
 3 files changed, 129 insertions(+), 129 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/tigerlake/cache.json
index 543a3298f86f..0569b2c704ca 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
@@ -493,6 +493,48 @@
         "SampleAfterValue": "50021",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop hit in another cores caches, data forwarding is re=
quired as the data is modified.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD"=
,
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop hit in another cores caches, data forward=
ing is required as the data is modified.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Demand and prefetch data reads",
         "CollectPEBSRecord": "2",
@@ -627,5 +669,49 @@
         "PublicDescription": "Counts the cycles for which the thread is ac=
tive and the superQ cannot take any more entries.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
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
+        "EventCode": "0x32",
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
+        "EventCode": "0x32",
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
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/tigerlake/other.json
index b1143fe74246..304cd09fe159 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
@@ -43,48 +43,6 @@
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
-    {
-        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop hit in another cores caches, data forwarding is re=
quired as the data is modified.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD"=
,
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x8003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop hit in another cores caches, data forward=
ing is required as the data is modified.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "CollectPEBSRecord": "2",
@@ -98,92 +56,5 @@
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.NTA",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHW instructions executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x8"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.T0",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "TMA slots where no uops were being issued due=
 to lack of back-end resources.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa4",
-        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Counts the number of Top-down Microarchitect=
ure Analysis (TMA) method's  slots where no micro-operations were being iss=
ued from front-end to back-end of the machine due to lack of back-end resou=
rces.",
-        "SampleAfterValue": "10000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa4",
-        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by branch mispredictions. This event estimates number=
 of operations that were issued but not retired from the specualtive path a=
s well as the out-of-order engine recovery past a branch misprediction.",
-        "SampleAfterValue": "10000003",
-        "UMask": "0x8"
-    },
-    {
-        "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "Fixed counter 3",
-        "EventName": "TOPDOWN.SLOTS",
-        "PEBScounters": "35",
-        "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
-        "SampleAfterValue": "10000003",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa4",
-        "EventName": "TOPDOWN.SLOTS_P",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
-        "SampleAfterValue": "10000003",
-        "UMask": "0x1"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/tigerlake/pipeline.json
index 4dc3a16e3da4..d436775c80db 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
@@ -711,6 +711,49 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "TMA slots where no uops were being issued due=
 to lack of back-end resources.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of Top-down Microarchitect=
ure Analysis (TMA) method's  slots where no micro-operations were being iss=
ued from front-end to back-end of the machine due to lack of back-end resou=
rces.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by branch mispredictions. This event estimates number=
 of operations that were issued but not retired from the specualtive path a=
s well as the out-of-order engine recovery past a branch misprediction.",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x8"
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
     {
         "BriefDescription": "Number of uops decoded out of instructions ex=
clusively fetched by decoder 0",
         "CollectPEBSRecord": "2",
--=20
2.35.1.894.gb6a874cedc-goog

