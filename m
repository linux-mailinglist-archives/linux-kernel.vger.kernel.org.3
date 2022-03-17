Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5B4DCD92
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiCQSbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiCQSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:31:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88366E9CBD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e4-20020a056902034400b00633691534d5so5076286ybs.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gnkVNXRwpItYkOrqz46oL2chMQsJgSaGJoWho/NmMis=;
        b=YI3AvzQTkogxPDdiIj/+RzCOTUyCJ88hQl4NXWYLjZjemg83w5R17ujjNEM8V9JAxU
         hX4ZgYQR0v4tFmfJ8iAJH004yDgrkRSN3J6hTAbjATM4u519i9/dnU/whB3VhTT8MziD
         F9dMBVqJa2yKmwn43IZsUg2y3EKB7csr8aTxm1Z4fB+6MvQgGNOAv3fwHPDLgd7R+F0B
         Gx3DhZEBOr3niPggW8C8KvkyvgQp4N4wJiWzM2N6s/4wRD76YrfXZ4DGxIdJe5LuG/yU
         kWfZVUy7kCRD/3cL8qj/tm6vRnadhwteKHxGPe2hWSnhPBWiG5a9VyHc0FXOZhbr1nng
         G7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gnkVNXRwpItYkOrqz46oL2chMQsJgSaGJoWho/NmMis=;
        b=QqwqCrf1Hy3klA945sRjQDfctEhP2PGnLbfXgz7DNLeygD84sPn/ZgIVUHTSHvGSys
         MYnbhyiYLUcg+Z2nXnsxy41iRnPf4OB4DnUHS+wHiJPqXoZkwZSoivdj7OvhuixjR8LQ
         dkRSRyERpwhZ/s7GbnRuLBOrPGHipla6OCvBhaeKHRbFLDggUB87HQ/n029Xks0tpAqK
         qgijxE1oFiKZuDixMFddmfgWA5lKR/yzUSQ2Ehb5zZEo6uJEcwDrdKzfqtw6uvucYQu3
         fb5xCnCldEN3v1biFVp/F89rt1rNIjKhh+khFLaLRmT47b2PNE8qRLMpg1xCUuNEnBa3
         yh5A==
X-Gm-Message-State: AOAM531vxD/L9rSt4v/JwIQstkdAj5jhbvnR+LhPVVBJSHnn5UbWxgfI
        hliQyQKbjtK6K5pqdYQNTdL6uIGnQ9ZG
X-Google-Smtp-Source: ABdhPJwG7KilWiR4b5N372CVJhO6garmO3lmZYo657yxgBeL5DrAS6dg72sSQCD/RV0p7p8ebFanQV4ss7H3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6811:1685:e3b9:7904])
 (user=irogers job=sendgmr) by 2002:a25:5090:0:b0:628:b76b:b9d3 with SMTP id
 e138-20020a255090000000b00628b76bb9d3mr6321465ybb.128.1647541780744; Thu, 17
 Mar 2022 11:29:40 -0700 (PDT)
Date:   Thu, 17 Mar 2022 11:28:55 -0700
In-Reply-To: <20220317182858.484474-1-irogers@google.com>
Message-Id: <20220317182858.484474-5-irogers@google.com>
Mime-Version: 1.0
References: <20220317182858.484474-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH 5/8] perf vendor events: Update events for Skylake
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
https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e394eed6a1ebd909c9f649d3ed3ef
moved certain "other" type of events in to the cache topic. Update the
perf json files for this change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/skylake/cache.json    | 36 +++++++++++++++++++
 .../pmu-events/arch/x86/skylake/other.json    | 36 -------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/cache.json b/tools/perf/pmu-events/arch/x86/skylake/cache.json
index 529c5e6e117f..c5d9a4ed10d7 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/cache.json
@@ -2937,5 +2937,41 @@
         "PublicDescription": "Counts the number of cache line split locks sent to the uncore.",
         "SampleAfterValue": "100003",
         "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.NTA",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.T0",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "Counter": "0,1,2,3",
+        "CounterHTOff": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x32",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x4"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/skylake/other.json b/tools/perf/pmu-events/arch/x86/skylake/other.json
index 5c0e81f76a5b..4f4839024915 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/other.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/other.json
@@ -16,41 +16,5 @@
         "EventName": "MEMORY_DISAMBIGUATION.HISTORY_RESET",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.NTA",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHW instructions executed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x8"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.T0",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
-        "Counter": "0,1,2,3",
-        "CounterHTOff": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x32",
-        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x4"
     }
 ]
\ No newline at end of file
-- 
2.35.1.894.gb6a874cedc-goog

