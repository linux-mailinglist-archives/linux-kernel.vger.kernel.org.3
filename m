Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA12D4DCD93
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiCQSbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbiCQSay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:30:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC736E9C92
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so5075217ybp.19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=A+msfJQLO1eO4WSU4Y9hbZfcZ3Rp804XSA/2x5CYE34=;
        b=jgM0uFKm+WbHhFhCEEnpECHk5lOkx1tzj/g68PRCbyXIRMukAb/r+QE6VmuEeoqYWK
         coCTBEbVRaxuremnLu5WzO85gI8PW+HTigm97Zg0KHVJum6PMQ2mJlk2tShhotJ/tYRP
         0bD/l9dOOXTs6G8MKo8Z61sKMThq3SKhK2FkLqNALelIxDLv/nuxNUuf/TbDFCWyv35z
         XE4Oi/vdbFfEstg5acVHpgbw8P2IUFa2sqgHgp30Z27xMeOlHLKA9PvZE/WEYgvF2btN
         2li7/YwjihIP42fql7LI+EW5HKpCNH/QL7EJcb/lJ+h7khZCctsCTxkfDBOFwonXrCPk
         +7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=A+msfJQLO1eO4WSU4Y9hbZfcZ3Rp804XSA/2x5CYE34=;
        b=lNjP7FD4e1mX/96GUjP3n6QtuRdejPpV0bs/L5RnJpftEY/C1PYd4JZUk/AEaq39Q8
         38TXyy4sPXMQUpodydJ7ysht8/d8J5oUE7EOGP3qxMJjWZttvfmBW9C9wAm45AduklQ/
         kp7sh1RCWKVrlk+33WaEQl9mD/aJIZsQ/k0QyolaQgKSYumDzifyFfqDIPQI4SMPFA0T
         JWn+5fk3cE2bJlXbgUZJDS7Ayqk+ePNZDigCzeNmDBAzMiuMkEBUCg6KjFr3s6C6zglg
         +1MOob4WdQbObWTWpLJXOjQ9ya1VUyuPIZD0NbUY+n2fxj/CyBSj4b6fSs/cM/iIthyW
         runA==
X-Gm-Message-State: AOAM530y39HNihnUgx0r+gPqczva19sYtnP+9RMpd0ECsAzxKs1fv7nt
        7SqTFr/it0oD/gIVwfNaiv5eWFKNl+bx
X-Google-Smtp-Source: ABdhPJwTpJOTy+tFiaycPFgmmpDPm1QeRssq2BqMn46WzituYf1t6YfXHXwdYX2d/EfzgM5C1xTncA8X7FH6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6811:1685:e3b9:7904])
 (user=irogers job=sendgmr) by 2002:a25:4252:0:b0:633:8580:c8e4 with SMTP id
 p79-20020a254252000000b006338580c8e4mr6122507yba.640.1647541774861; Thu, 17
 Mar 2022 11:29:34 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:28:53 -0700
In-Reply-To: <20220317182858.484474-1-irogers@google.com>
Message-Id: <20220317182858.484474-3-irogers@google.com>
Mime-Version: 1.0
References: <20220317182858.484474-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH 3/8] perf vendor events: Update events for Icelake
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

The change:
https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e=
394eed6a1ebd909c9f649d3ed3ef
moved certain "other" type of events in to the cache and pipeline topic.
Update the perf json files for this change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/icelake/cache.json    | 633 +++++++++++++++
 .../pmu-events/arch/x86/icelake/other.json    | 752 +-----------------
 .../pmu-events/arch/x86/icelake/pipeline.json |  47 ++
 3 files changed, 716 insertions(+), 716 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelake/cache.json b/tools/perf=
/pmu-events/arch/x86/icelake/cache.json
index 96dcd387c70e..375ce490833c 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/cache.json
@@ -553,6 +553,591 @@
         "SampleAfterValue": "50021",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was s=
ent or not.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.ANY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FC03C0004",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop hit i=
n another cores caches, data forwarding is required as the data is modified=
.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0004",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop hit i=
n another core, data forwarding is not required.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0004",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was s=
ent but no other cores had the data.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0004",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was n=
ot needed to satisfy the request.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0004",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was s=
ent.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_SENT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1E003C0004",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was sent or not.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.ANY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FC03C0001",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
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
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop hit in another core, data forwarding is not requir=
ed.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0001",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was sent but no other cores had the data.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0001",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was not needed to satisfy the request.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0001",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was sent.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_SENT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1E003C0001",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was sent or not.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.ANY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FC03C0002",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
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
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop hit in another core, data forwarding is n=
ot required.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0002",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was sent but no other cores had the data.=
",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0002",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was not needed to satisfy the request.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0002",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was sent.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_SENT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1E003C0002",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit a cacheline in the L3 where a=
 snoop was sent or not.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.ANY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FC03C0400",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit a cacheline in the L3 where a=
 snoop was sent but no other cores had the data.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0400",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit a cacheline in the L3 where a=
 snoop was not needed to satisfy the request.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0400",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was sent or n=
ot.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.ANY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FC03C0010",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop hit in anothe=
r cores caches, data forwarding is required as the data is modified.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0010",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop hit in anothe=
r core, data forwarding is not required.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0010",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was sent but =
no other cores had the data.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0010",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was not neede=
d to satisfy the request.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0010",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was sent.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_SENT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1E003C0010",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was sent or not.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.ANY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FC03C0020",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop hit in another cores=
 caches, data forwarding is required as the data is modified.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0020",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop hit in another core,=
 data forwarding is not required.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0020",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was sent but no othe=
r cores had the data.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0020",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was not needed to sa=
tisfy the request.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0020",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was sent.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_SENT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1E003C0020",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t hit a cacheline in the L3 where a snoop was sent or not.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L3.L3_HIT.ANY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FC03C2380",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop hit in=
 another core, data forwarding is not required.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C8000",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop was se=
nt but no other cores had the data.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.OTHER.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C8000",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop was no=
t needed to satisfy the request.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C8000",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop was se=
nt.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.OTHER.L3_HIT.SNOOP_SENT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1E003C8000",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that hit a cacheline =
in the L3 where a snoop was sent or not.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.STREAMING_WR.L3_HIT.ANY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FC03C0800",
+        "Offcore": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Demand and prefetch data reads",
         "CollectPEBSRecord": "2",
@@ -674,5 +1259,53 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/icelake/other.json b/tools/perf=
/pmu-events/arch/x86/icelake/other.json
index 10e8582774ce..08f6321025e8 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/other.json
@@ -78,418 +78,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was s=
ent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.ANY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FC03C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop hit i=
n another cores caches, data forwarding is required as the data is modified=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop hit i=
n another core, data forwarding is not required.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x4003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was s=
ent but no other cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was n=
ot needed to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit a cacheline in the L3 where a snoop was s=
ent.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_SENT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1E003C0004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000004",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that DRAM supplied t=
he request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.ANY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FC03C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
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
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop hit in another core, data forwarding is not requir=
ed.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x4003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was sent but no other cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was not needed to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that hit a cacheline=
 in the L3 where a snoop was sent.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_SENT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1E003C0001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that DRAM supplied t=
he request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that DRAM s=
upplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT.ANY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FC03C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
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
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop hit in another core, data forwarding is n=
ot required.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x4003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was sent but no other cores had the data.=
",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was not needed to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit a =
cacheline in the L3 where a snoop was sent.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_SENT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1E003C0002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that DRAM s=
upplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000002",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that have any type of response.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10400",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that DRAM supplied the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L1D_AND_SWPF.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000400",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit a cacheline in the L3 where a=
 snoop was sent or not.",
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that DRAM supplied the request.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.ANY",
+        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FC03C0400",
+        "MSRValue": "0x184000004",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -498,13 +93,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit a cacheline in the L3 where a=
 snoop was sent but no other cores had the data.",
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_MISS",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2003C0400",
+        "MSRValue": "0x10001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -513,13 +108,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that hit a cacheline in the L3 where a=
 snoop was not needed to satisfy the request.",
+        "BriefDescription": "Counts demand data reads that DRAM supplied t=
he request.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_NOT_NEEDED",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1003C0400",
+        "MSRValue": "0x184000001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -528,13 +123,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that DRAM supplied the request.",
+        "BriefDescription": "Counts demand data reads that DRAM supplied t=
he request.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L1D_AND_SWPF.LOCAL_DRAM",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000400",
+        "MSRValue": "0x184000001",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -543,13 +138,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that have any type of response.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10010",
+        "MSRValue": "0x10002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -558,13 +153,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that DRAM supplied the request.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that DRAM s=
upplied the request.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000010",
+        "MSRValue": "0x184000002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -573,13 +168,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was sent or n=
ot.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that DRAM s=
upplied the request.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.ANY",
+        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FC03C0010",
+        "MSRValue": "0x184000002",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -588,13 +183,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop hit in anothe=
r cores caches, data forwarding is required as the data is modified.",
+        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that have any type of response.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0010",
+        "MSRValue": "0x10400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -603,13 +198,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop hit in anothe=
r core, data forwarding is not required.",
+        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that DRAM supplied the request.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x4003C0010",
+        "MSRValue": "0x184000400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -618,13 +213,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was sent but =
no other cores had the data.",
+        "BriefDescription": "Counts L1 data cache prefetch requests and so=
ftware prefetches (except PREFETCHW) that DRAM supplied the request.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2003C0010",
+        "MSRValue": "0x184000400",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -633,13 +228,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was not neede=
d to satisfy the request.",
+        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that have any type of response.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1003C0010",
+        "MSRValue": "0x10010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -648,13 +243,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that hit a cacheline in the L3 where a snoop was sent.",
+        "BriefDescription": "Counts hardware prefetch data reads (which br=
ing data to L2)  that DRAM supplied the request.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_SENT",
+        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1E003C0010",
+        "MSRValue": "0x184000010",
         "Offcore": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
@@ -707,96 +302,6 @@
         "Speculative": "1",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.ANY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FC03C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop hit in another cores=
 caches, data forwarding is required as the data is modified.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop hit in another core,=
 data forwarding is not required.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x4003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was sent but no othe=
r cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was not needed to sa=
tisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that hit a cacheline in the L3 where a snoop was sent.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_SENT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1E003C0020",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts hardware prefetch RFOs (which bring da=
ta to L2) that DRAM supplied the request.",
         "CollectPEBSRecord": "2",
@@ -812,21 +317,6 @@
         "Speculative": "1",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts hardware prefetches to the L3 only tha=
t hit a cacheline in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.HWPF_L3.L3_HIT.ANY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FC03C2380",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that have any type of response.",
         "CollectPEBSRecord": "2",
@@ -857,66 +347,6 @@
         "Speculative": "1",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop hit in=
 another core, data forwarding is not required.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x4003C8000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop was se=
nt but no other cores had the data.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.OTHER.L3_HIT.SNOOP_MISS",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2003C8000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop was no=
t needed to satisfy the request.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1003C8000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that hit a cacheline in the L3 where a snoop was se=
nt.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.OTHER.L3_HIT.SNOOP_SENT",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1E003C8000",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O an=
d un-cacheable accesses that DRAM supplied the request.",
         "CollectPEBSRecord": "2",
@@ -962,21 +392,6 @@
         "Speculative": "1",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts streaming stores that hit a cacheline =
in the L3 where a snoop was sent or not.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xB7, 0xBB",
-        "EventName": "OCR.STREAMING_WR.L3_HIT.ANY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3FC03C0800",
-        "Offcore": "1",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores that DRAM supplied th=
e request.",
         "CollectPEBSRecord": "2",
@@ -991,100 +406,5 @@
         "SampleAfterValue": "100003",
         "Speculative": "1",
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
-        "Speculative": "1",
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
diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/icelake/pipeline.json
index 2b305bdc8cfc..573ac7ac8879 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
@@ -730,6 +730,53 @@
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
+        "Speculative": "1",
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

