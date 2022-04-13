Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14059500090
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbiDMVHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiDMVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:07:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC204BBAA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ec1914e315so26412417b3.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4LdCm2LQ8QCCRGCZyoOA7ym+iNo+PUnyUQ+rUu7M50A=;
        b=YfoJJnbg1Nqy29ie3R1xerMB3Px4QxQ0zzwsUMdXr8xyeEAOzqBbtuRqi9KK61Ttfq
         WK7ZOpaL3k+GkRHN1Atov1hd008AutBXq+wzYpcGOS/p+q9w5+CA8w2gkFoUyQm0vlF7
         4kmJ24MlFOGqhmLOacLllLooikJHFrQiS8g1Pf7OEgYQkbqD6p43eRMZrmO2xFW1cIpD
         dqmel/GvrUWjNhL1KxwK4qXty2LJ9x5ucrqF67BNjGyHg424rUZ6FAs2W7Tynnjky5m8
         XLjRU8CD1iFmcZtOGegPskugaCEotq6OECfF7oQlRymN21yA9Q8eDJXQs+KSq5qeETbw
         5YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4LdCm2LQ8QCCRGCZyoOA7ym+iNo+PUnyUQ+rUu7M50A=;
        b=5HzPs0iPciQ6lBdaJNOVjyYO/66oevTYTgFH5DueFSfy16HOImqwnV/MVtpvS5koWD
         PPZtGcOqlgZG5b8PBehJQnl+3+/+cd5h4e/CrQTHP8XBrv5+0pXkkyEYqF2BZ0ulD1NG
         fYmC+URvIz9AMFzvnIGksBtQZ454qbo66+EHFLXmm7SEcLApT0US15+OAo6FDivrrD+O
         LFNbkSJUyT/vH1IgLB7idWLrVRnFnmUQz9UTIPthggDqDnMfRZQMNOlYiWMuGZXxm/+T
         ZayvY2CaVMW6XXqjXyyquee2HEhWjO4v17K2vR35ov7hVZ3SE7yEmnfpncV+2C1mhKfQ
         4OqA==
X-Gm-Message-State: AOAM532wrrmtQ4CELDmth8toAiUZ+JWUbWYcpLPhrnSFKCjckkOrdAes
        fTtNTGR4zbN0W/AvMpf69UJPJnMnErf/
X-Google-Smtp-Source: ABdhPJy98j+Y9ioxho7SxE9VlvWgNuQDW180FjLRq0gjFKBOOy5Sqbq2mrtTxyotwobZ7xF91NafDV+VMPul
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a81:748a:0:b0:2eb:e6c0:981b with SMTP id
 p132-20020a81748a000000b002ebe6c0981bmr707127ywc.71.1649883906883; Wed, 13
 Apr 2022 14:05:06 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:50 -0700
Message-Id: <20220413210503.3256922-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 01/14] perf vendor events intel: Fix icelake cstate metrics
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply cstate fix from:
https://github.com/intel/event-converter-for-linux-perf/
so that metrics for cstates that exist on the particular architecture
are generated. This corrects issues with metric testing.

Also correct topic of ASSISTS.ANY event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/icelake/icl-metrics.json         | 24 ++++++++++++++-----
 .../pmu-events/arch/x86/icelake/other.json    | 14 +----------
 .../pmu-events/arch/x86/icelake/pipeline.json | 14 ++++++++++-
 3 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index 4af23c04dc18..ea73bc1889ba 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -408,12 +408,6 @@
         "MetricGroup": "Branches;OS",
         "MetricName": "IpFarBranch"
     },
-    {
-        "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
-        "MetricGroup": "Power",
-        "MetricName": "C3_Core_Residency"
-    },
     {
         "BriefDescription": "C6 residency percent per core",
         "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
@@ -449,5 +443,23 @@
         "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C7_Pkg_Residency"
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
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/other.json b/tools/perf/pmu-events/arch/x86/icelake/other.json
index 08f6321025e8..2e177f95a9cb 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/other.json
@@ -1,16 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xc1",
-        "EventName": "ASSISTS.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware Examples include AD (page Access Dirty), FP and AVX related assists.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x7"
-    },
     {
         "BriefDescription": "Core cycles where the core was running in a manner where Turbo may be clipped to the Non-AVX turbo schedule.",
         "CollectPEBSRecord": "2",
@@ -407,4 +395,4 @@
         "Speculative": "1",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
index 573ac7ac8879..2b58cfaaaf39 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
@@ -12,6 +12,18 @@
         "Speculative": "1",
         "UMask": "0x9"
     },
+    {
+        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.ANY",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware Examples include AD (page Access Dirty), FP and AVX related assists.",
+        "SampleAfterValue": "100003",
+        "Speculative": "1",
+        "UMask": "0x7"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
         "CollectPEBSRecord": "2",
@@ -1102,4 +1114,4 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
-- 
2.36.0.rc0.470.gd361397f0d-goog

