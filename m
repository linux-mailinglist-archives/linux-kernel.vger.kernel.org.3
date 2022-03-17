Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0914DCD91
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbiCQSbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiCQSa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:30:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBDAE9CAB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h83-20020a25d056000000b0063380d246ceso5120695ybg.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=EA16R3dKqwcPhViQJ1LcaGRyBbUhpG9MKsQKLXaN+Ks=;
        b=ezR2Ns/MFQUvFO6DE9cOk629MCt5TRNO6pRxy71A8CKrGtKU2x+WKrX2jp+xrDCBOt
         FUIlThVOkiMWKsbvCS264jMThzsZUJQAy9DT9djYClh1AM0mu+d1kb0cMTeaIN8Zhkxt
         47vDC/Ju6LiH3QvKYjhBmc8dWSwdCVq+V6njuqualy9i68tb0Q/2Fx0T0vSojoaY9RhB
         YxUV/PHgl9GGZf7/TMYtbAyAWhL1OOOJFKPodVSxUdUJ6RtDsBji9RdRpKhWfnnqUtt3
         TxJ77nQeIVZK2bAGiB2iRic5FhqW2ANp2Ce6cBc4LST5hqm6pkxFN6heBTLUA8GNaSOx
         3UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=EA16R3dKqwcPhViQJ1LcaGRyBbUhpG9MKsQKLXaN+Ks=;
        b=dHOUnCw7Wb9jszJj6e7uxSO17veggm6dUNWrzceLSI6a32HoAB0pSWe0mufUOAdZin
         FDOFZpMevMCRGBR/2l2WNdVHgA56aqJ2faoD4YZIyri8whW4rFD9R9yLFja6WrYvZFN0
         dTdVOk5JYztKY1xMXsAAIWey/gl5Ys/BFQip2ZuiHGe0CYW7Yg/aAk2ONAl6hjdwqawr
         O4DoeTnc+vw0kAeJlpg35LPe/FEMAXAFV6QiDdXaPcY7zXhFjUrSIaLBpMu1uYFCJznP
         pZ2SSehfBNPGh7y0K5WZxxYHl/PsvnxVfEPUc7JcoIoDslTgCfeY6AYJGguqALgOZpUc
         hKAw==
X-Gm-Message-State: AOAM533bwVxzTrRlGKN7hwp2iV1n5B75mwNiawvncSwng+5DXlIrpRad
        FDzUgtjMNq+io9jwfJuLQYNeJIAcjrCa
X-Google-Smtp-Source: ABdhPJzScK1GOEcToBf4ZPMX25KY2YkQsYsRgzH+FW+YXnFfhXWRg8QisaYT9lwlTbq3363iLXQUib6oVc5a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6811:1685:e3b9:7904])
 (user=irogers job=sendgmr) by 2002:a5b:1cf:0:b0:628:ba68:30e4 with SMTP id
 f15-20020a5b01cf000000b00628ba6830e4mr6228265ybp.629.1647541777900; Thu, 17
 Mar 2022 11:29:37 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:28:54 -0700
In-Reply-To: <20220317182858.484474-1-irogers@google.com>
Message-Id: <20220317182858.484474-4-irogers@google.com>
Mime-Version: 1.0
References: <20220317182858.484474-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH 4/8] perf vendor events: Update events for IcelakeX
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from v1.11 to v1.12.
The change:
https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e=
394eed6a1ebd909c9f649d3ed3ef
moved certain "other" type of events in to the cache, memory and
pipeline topics. Update the perf json files for this change.

Tested:
```
...
  6: Parse event definition strings                                  : Ok
...
 91: perf all PMU test                                               : Ok
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/icelakex/cache.json   | 252 +++++++++++++++
 .../pmu-events/arch/x86/icelakex/memory.json  |  26 +-
 .../pmu-events/arch/x86/icelakex/other.json   | 287 ++----------------
 .../arch/x86/icelakex/pipeline.json           |  35 +++
 4 files changed, 324 insertions(+), 276 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/cache.json b/tools/per=
f/pmu-events/arch/x86/icelakex/cache.json
index 104409fd8647..3c4da0371df9 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/cache.json
@@ -657,6 +657,30 @@
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit in the L3 or were snooped from another co=
re's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0004",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that resulted in a snoop hit a modified line in an=
other core's caches which forwarded the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0004",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a modified line in a distant L3 Cache or =
were snooped from a distant core's L1/L2 caches on this socket when the sys=
tem is in SNC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
@@ -681,6 +705,54 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that hit in the L3 o=
r were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0001",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit a modified line in another core's caches which forwarded the data.=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop that hit in another core, which did not forward the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0001",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another core's caches which forwarded the unmodified data to th=
e requesting core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y a cache on a remote socket where a snoop hit a modified line in another c=
ore's caches which forwarded the data.",
         "Counter": "0,1,2,3",
@@ -729,6 +801,30 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit in=
 the L3 or were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0002",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that result=
ed in a snoop hit a modified line in another core's caches which forwarded =
the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
modified line in a distant L3 Cache or were snooped from a distant core's L=
1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mod=
e.",
         "Counter": "0,1,2,3",
@@ -753,6 +849,102 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit in the L3 or were snooped fro=
m another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0400",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t hit in the L3 or were snooped from another core's caches on the same sock=
et.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L3.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x80082380",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware and software prefetches to al=
l cache levels that hit in the L3 or were snooped from another core's cache=
s on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.PREFETCHES.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C27F0",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hit=
 in the L3 or were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F003C0477",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop hit a modified line in another core's caches which forward=
ed the data.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0477",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop that hit in another core, which did not forward the data."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0477",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop hit in another core's caches which forwarded the unmodifie=
d data to the requesting core.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0477",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by a cache on a remote socket where a snoop was sent and data wa=
s returned (Modified or Not Modified).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1830000477",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by a cache on a remote socket where a snoop hit a modified line =
in another core's caches which forwarded the data.",
         "Counter": "0,1,2,3",
@@ -801,6 +993,18 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts streaming stores that hit in the L3 or=
 were snooped from another core's caches on the same socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.STREAMING_WR.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x80080800",
+        "Offcore": "1",
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
@@ -947,5 +1151,53 @@
         "SampleAfterValue": "100003",
         "Speculative": "1",
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
+        "Speculative": "1",
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
+        "Speculative": "1",
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
+        "Speculative": "1",
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
+        "Speculative": "1",
+        "UMask": "0x4"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/memory.json b/tools/pe=
rf/pmu-events/arch/x86/icelakex/memory.json
index 9ebcd442e6d3..c10a1bbc66b1 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
@@ -169,7 +169,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F8CC00004",
+        "MSRValue": "0x3F84400004",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
@@ -193,7 +193,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F8CC00001",
+        "MSRValue": "0x3F84400001",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
@@ -217,7 +217,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F0CC00002",
+        "MSRValue": "0x3F04400002",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
@@ -241,7 +241,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F8CC00400",
+        "MSRValue": "0x3F84400400",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
@@ -301,7 +301,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.OTHER.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F8CC08000",
+        "MSRValue": "0x3F84408000",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
@@ -313,7 +313,7 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.PREFETCHES.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F8CC027F0",
+        "MSRValue": "0x3F844027F0",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
@@ -337,7 +337,19 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F0CC00477",
+        "MSRValue": "0x3F04400477",
+        "Offcore": "1",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that mis=
sed the L3 Cache and were supplied by the local socket (DRAM or PMM), wheth=
er or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM or DRAM ac=
cesses that are controlled by the close or distant SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL_SOCKET",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x70CC00477",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/other.json b/tools/per=
f/pmu-events/arch/x86/icelakex/other.json
index 43524f274307..1246b22769da 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/other.json
@@ -156,31 +156,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit in the L3 or were snooped from another co=
re's caches on the same socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0004",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that resulted in a snoop hit a modified line in an=
other core's caches which forwarded the data.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0004",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that the DRAM attached to this socket supplied the=
 request.",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM attached to this socket=
, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM=
 accesses that are controlled by the close SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
@@ -228,55 +204,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads that hit in the L3 o=
r were snooped from another core's caches on the same socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0001",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit a modified line in another core's caches which forwarded the data.=
",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0001",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that resulted in a s=
noop that hit in another core, which did not forward the data.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x4003C0001",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another core's caches which forwarded the unmodified data to th=
e requesting core.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x8003C0001",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that the DRAM attach=
ed to this socket supplied the request.",
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
@@ -288,7 +216,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y PMM attached to this socket.",
+        "BriefDescription": "Counts demand data reads that were supplied b=
y PMM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SN=
C Mode counts only those PMM accesses that are controlled by the close SNC =
Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.LOCAL_PMM",
@@ -384,31 +312,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit in=
 the L3 or were snooped from another core's caches on the same socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0002",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that result=
ed in a snoop hit a modified line in another core's caches which forwarded =
the data.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0002",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that the DR=
AM attached to this socket supplied the request.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mo=
de.  In SNC Mode counts only those DRAM accesses that are controlled by the=
 close SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
@@ -420,7 +324,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by PMM attached to this socket.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by PMM attached to this socket, unless in Sub NUMA Cluster(SNC) Mod=
e.  In SNC Mode counts only those PMM accesses that are controlled by the c=
lose SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.LOCAL_PMM",
@@ -492,19 +396,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit in the L3 or were snooped fro=
m another core's caches on the same socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0400",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that the DRAM attached to this socket =
supplied the request.",
+        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that were supplied by DRAM attached to=
 this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts onl=
y those DRAM accesses that are controlled by the close SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.HWPF_L1D_AND_SWPF.LOCAL_DRAM",
@@ -527,18 +419,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t hit in the L3 or were snooped from another core's caches on the same sock=
et.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L3.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x80082380",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t were not supplied by the local socket's L1, L2, or L3 caches and the cach=
eline was homed in a remote socket.",
         "Counter": "0,1,2,3",
@@ -575,18 +455,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts hardware and software prefetches to al=
l cache levels that hit in the L3 or were snooped from another core's cache=
s on the same socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.PREFETCHES.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C27F0",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e any type of response.",
         "Counter": "0,1,2,3",
@@ -612,72 +480,48 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hit=
 in the L3 or were snooped from another core's caches on the same socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.READS_TO_CORE.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F003C0477",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop hit a modified line in another core's caches which forward=
ed the data.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0477",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop that hit in another core, which did not forward the data."=
,
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC)=
 Mode.  In SNC Mode counts only those DRAM accesses that are controlled by =
the close SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x4003C0477",
+        "MSRValue": "0x104000477",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that res=
ulted in a snoop hit in another core's caches which forwarded the unmodifie=
d data to the requesting core.",
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by PMM attached to this socket, unless in Sub NUMA Cluster(SNC) =
Mode.  In SNC Mode counts only those PMM accesses that are controlled by th=
e close SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_PMM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x8003C0477",
+        "MSRValue": "0x100400477",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that the=
 DRAM attached to this socket supplied the request.",
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM attached to this socket, whether or not in Sub NUMA Clus=
ter(SNC) Mode.  In SNC Mode counts DRAM accesses that are controlled by the=
 close or distant SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104000477",
+        "MSRValue": "0x70C000477",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by PMM attached to this socket.",
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by PMM attached to this socket, whether or not in Sub NUMA Clust=
er(SNC) Mode.  In SNC Mode counts PMM accesses that are controlled by the c=
lose or distant SNC Cluster.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.READS_TO_CORE.LOCAL_PMM",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_PMM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x100400477",
+        "MSRValue": "0x700C00477",
         "Offcore": "1",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
@@ -754,100 +598,5 @@
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts streaming stores that hit in the L3 or=
 were snooped from another core's caches on the same socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.STREAMING_WR.L3_HIT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x80080800",
-        "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
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
-        "Speculative": "1",
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
-        "Speculative": "1",
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
-        "Speculative": "1",
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
-        "Speculative": "1",
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
-        "Speculative": "1",
-        "UMask": "0x2"
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
-        "Speculative": "1",
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
-        "Speculative": "1",
-        "UMask": "0x1"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/icelakex/pipeline.json
index 9a0b4907cb3a..068a3d46b443 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
@@ -728,6 +728,41 @@
         "Speculative": "1",
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
+        "Speculative": "1",
+        "UMask": "0x2"
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
+        "Speculative": "1",
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
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Number of uops decoded out of instructions ex=
clusively fetched by decoder 0",
         "CollectPEBSRecord": "2",
--=20
2.35.1.894.gb6a874cedc-goog

