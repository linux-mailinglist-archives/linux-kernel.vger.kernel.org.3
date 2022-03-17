Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEEF4DCD8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiCQSa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiCQSau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:30:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9E9E9C87
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc1ce31261so51686507b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=iYEMBqCZQ2o/VfYUsYIAXt7W67TBJfDGys+ZnFlr4qE=;
        b=NAk25eEyK0iug28x7RVs6xp5/DoTMj+U+XGEqNY1ibIfbtBY6LNx2abw0q1ctSsPJy
         gnHA5f/oQILnAu2AbkchFFNdyHMZqs/JSKmn++TxxvFIJVMkwZHfAaCDMm7iEiAKKqMP
         KL/1qrbpQ++FA5Qxb2wff7819ErLtBLHvb9z/PZiiBvbeOCfLVFHwXW7tKpPpEhcobYJ
         H+aezQqatgYlwGfw2j/xIKcg7eb3f8CiHJT+lme+duyuKPbIHg98VEMYq5gAFiYldYHp
         3I/GwNhyD86Zd0tOJ/t8UmiyoNcG7b9zJJwko2nEwtXoP30tZA/APnbeylvF4EoP8D+v
         zFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=iYEMBqCZQ2o/VfYUsYIAXt7W67TBJfDGys+ZnFlr4qE=;
        b=Bu9Gda+uzdAR7y4977n6VplbUCLS1S+WTjvxsuinQDmhl5xwF5b06G1/40lkNoD5P1
         tGjs9zGp7iIiMBPtfXV+pSe9qa1qMY2IWz1icwe3gfRwYj1/g/TGomQi044v3d+De9km
         6BColv176vDtW6tm144mQ3F9oaBYGrYwRKAn4wLAXsKHbdVjDXgL7wId7B4zGqeQU1rj
         VaCy71FgOq5PnefdGr0Q8EwK0mXoGBZqYQgr4srnBGF/g70FBiA9HRl+hUQEJkaUZ9zz
         kMj5+7bg5/BTJXAgOa80pGzY6Q49d6GAx8kVwC9i8RFyJkPr88p/DSDOfcgzbyTBmLeE
         JzIA==
X-Gm-Message-State: AOAM532Xjoxs1e6/V9A+QuzTkxAqOVIrJUYCE03l4AUF+XUtS313kQau
        1IbfYaCNChMYl4qyAhvTJoGLTcLBlqKJ
X-Google-Smtp-Source: ABdhPJzPFU/sU5+Es5Inv5D47WCFq/ZUWW9NwjWHvwNgLPTx8M1t713FaE61QKOD9v4psYEZom3GHYs3V7Ou
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6811:1685:e3b9:7904])
 (user=irogers job=sendgmr) by 2002:a81:6608:0:b0:2e5:b671:794d with SMTP id
 a8-20020a816608000000b002e5b671794dmr7588712ywc.360.1647541771889; Thu, 17
 Mar 2022 11:29:31 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:28:52 -0700
In-Reply-To: <20220317182858.484474-1-irogers@google.com>
Message-Id: <20220317182858.484474-2-irogers@google.com>
Mime-Version: 1.0
References: <20220317182858.484474-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH 2/8] perf vendor events: Update events for Elkhartlake
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
moved certain "other" type of events in to the pipeline topic. Update the
perf json files for this change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/elkhartlake/other.json           | 241 ------------------
 .../arch/x86/elkhartlake/pipeline.json        | 241 ++++++++++++++++++
 2 files changed, 241 insertions(+), 241 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json b/tools/=
perf/pmu-events/arch/x86/elkhartlake/other.json
index 627691404155..de55b199ba79 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
@@ -179,246 +179,5 @@
         "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x6"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to fast nukes such as memory orde=
ring and memory disambiguation machine clears.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to branch mispredicts.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
TOPDOWN_BAD_SPECULATION.FASTNUKE",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x73",
-        "EventName": "TOPDOWN_BAD_SPECULATION.MONUKE",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to backend stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.ALL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to certain allocation restriction=
s.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stalls in w=
hich a scheduler is not able to accept uops.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC or FPC RAT stalls, which c=
an be due to FIQ or IEC reservation stalls in which the integer, floating p=
oint or SIMD scheduler is not able to accept uops.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x8"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the physical register file una=
ble to accept an entry (marble stalls).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x20"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the reorder buffer being full =
(ROB stalls).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x40"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to scoreboards from the instructi=
on queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x10"
-    },
-    {
-        "BriefDescription": "This event is deprecated.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x74",
-        "EventName": "TOPDOWN_BE_BOUND.STORE_BUFFER",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to frontend stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.ALL",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BACLEARS.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BACLEARS, which occurs when=
 the Branch Target Buffer (BTB) prediction or lack thereof, was corrected b=
y a later branch predictor in the frontend. Includes BACLEARS due to all br=
anch types including conditional and unconditional jumps, returns, and indi=
rect branches.",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTCLEARS.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BTCLEARS, which occurs when=
 the Branch Target Buffer (BTB) predicts a taken branch.",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x40"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to the microcode sequencer (MS)=
.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.CISC",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stalls.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.DECODE",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x8"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ITLB misses.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.ITLB",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to Instruction Table Lookaside=
 Buffer (ITLB) misses.",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x10"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to other common frontend stalls=
 not categorized.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.OTHER",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x80"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to wrong predecodes.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x71",
-        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
-        "PDIR_COUNTER": "na",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "Counts the total number of consumed retiremen=
t slots.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xc2",
-        "EventName": "TOPDOWN_RETIRING.ALL",
-        "PEBS": "1",
-        "PEBScounters": "0,1,2,3",
-        "SampleAfterValue": "1000003"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
index 41e5dfad8f51..31816c6543a8 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
@@ -262,6 +262,247 @@
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "20003"
     },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to fast nukes such as memory orde=
ring and memory disambiguation machine clears.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to branch mispredicts.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
TOPDOWN_BAD_SPECULATION.FASTNUKE",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MONUKE",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to backend stalls.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALL",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to certain allocation restriction=
s.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stalls in w=
hich a scheduler is not able to accept uops.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC or FPC RAT stalls, which c=
an be due to FIQ or IEC reservation stalls in which the integer, floating p=
oint or SIMD scheduler is not able to accept uops.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the physical register file una=
ble to accept an entry (marble stalls).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the reorder buffer being full =
(ROB stalls).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to scoreboards from the instructi=
on queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "This event is deprecated.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.STORE_BUFFER",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to frontend stalls.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ALL",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BACLEARS.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BACLEARS, which occurs when=
 the Branch Target Buffer (BTB) prediction or lack thereof, was corrected b=
y a later branch predictor in the frontend. Includes BACLEARS due to all br=
anch types including conditional and unconditional jumps, returns, and indi=
rect branches.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTCLEARS.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BTCLEARS, which occurs when=
 the Branch Target Buffer (BTB) predicts a taken branch.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to the microcode sequencer (MS)=
.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.CISC",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stalls.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.DECODE",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ITLB misses.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ITLB",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to Instruction Table Lookaside=
 Buffer (ITLB) misses.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to other common frontend stalls=
 not categorized.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.OTHER",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to wrong predecodes.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
+        "PDIR_COUNTER": "na",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the total number of consumed retiremen=
t slots.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc2",
+        "EventName": "TOPDOWN_RETIRING.ALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003"
+    },
     {
         "BriefDescription": "Counts the number of uops that are from compl=
ex flows issued by the micro-sequencer (MS).",
         "CollectPEBSRecord": "2",
--=20
2.35.1.894.gb6a874cedc-goog

