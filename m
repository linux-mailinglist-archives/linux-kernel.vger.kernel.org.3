Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7152E50009F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbiDMVIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbiDMVHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:07:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1D750E3B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j129-20020a252387000000b00641e1faafecso1126213ybj.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=LKB7i4Zj5dX1qXiIg2WxQ7z1X6s6ZcW7RXiWq03uXUI=;
        b=Onp4JqNW8oj7SPxPL/5IEt2X/QEamQi3ktQTxlBvlBFofnJAtfHr7HVCh5siCjERSd
         1/M1kxFnxdkgy6q/bWmGOTA23Z/wXuqkEnFDyDqiPhDF5Fv09zX/LrmjZXKPaLi2gGZ9
         PWZvUy3o53mt58URyIN4aM9sfM6TOJIOl4dUT5Jndh7w3XO+XiyCTXxE54ySM3VTDixC
         uA9KvePG4RAuHmKRdBj0EenRQPd9MNuGM73vwDxUyl81KwXgZBcrDEkIXD2SQ9s9NGUo
         ybxQRMw9nH8Prwz/8Dlbeze545OqOC9lFBleX0eJBm/edXGOp0SfbhNLmt0FKw0dXOVm
         41UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=LKB7i4Zj5dX1qXiIg2WxQ7z1X6s6ZcW7RXiWq03uXUI=;
        b=kynyo0mgbomKMGlXnM7SebFkS7XPN3zpqyAlMVWkOlS4RLVZzzeu7E69BKHoIs34aP
         uVRpY6aMsi3n/x+j6Eu5SM0aymJEeylKPflJs3SAwYuwsed5VmIPi5qlgWfAqUxi69VS
         qValqTNmY3p1K+FfN0c102NYpV2v0igoSHoGt1hXQxaD4c60xnTcdgo2uBJJLpM6WlrG
         V5hMv348DJmfQyNIugKn/0n7ekZrgWdiw25JDmy8+idLY5lvoM9rZAEbNnc6dxbsrTqF
         ePuTZGhNOKvKmPXBDdwrWNqEsjYJFGzz3s+wpDYwG6NGtA1YhgdTaXtIv6I0ZXApqies
         e2eQ==
X-Gm-Message-State: AOAM533rOHsb++bJdEEE6ecnqXQen32gsXONeT6fY4u3x23VFjEYhyGg
        cTqLSSsAMr3t5f8vLSWsSn4xhsD4Om/m
X-Google-Smtp-Source: ABdhPJzMCb/N6OHh6lopCZE+Ygof+hGZVe5y+tCk3yFzm12/mxAP9em0ykCmnO1fq/yz1eOno0n/ImgSggTb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a25:cf4c:0:b0:641:15d2:54a3 with SMTP id
 f73-20020a25cf4c000000b0064115d254a3mr683281ybg.626.1649883909552; Wed, 13
 Apr 2022 14:05:09 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:51 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-2-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 02/14] perf vendor events intel: Fix icelakex cstate metrics
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

Apply cstate fix from:
https://github.com/intel/event-converter-for-linux-perf/
so that metrics for cstates that exist on the particular architecture
are generated. This corrects issues with metric testing.

Also correct topic of ASSISTS.ANY event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/icelakex/cache.json   | 31 +-------
 .../arch/x86/icelakex/icx-metrics.json        | 24 +------
 .../pmu-events/arch/x86/icelakex/memory.json  | 21 +-----
 .../pmu-events/arch/x86/icelakex/other.json   | 70 ++++---------------
 .../arch/x86/icelakex/pipeline.json           | 14 +++-
 5 files changed, 33 insertions(+), 127 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/cache.json b/tools/per=
f/pmu-events/arch/x86/icelakex/cache.json
index 3c4da0371df9..95fcbec188f8 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/cache.json
@@ -665,7 +665,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -677,7 +676,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -689,7 +687,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -701,7 +698,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -713,7 +709,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -725,7 +720,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -737,7 +731,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -749,7 +742,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -761,7 +753,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1030000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -773,7 +764,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x830000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -785,7 +775,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -797,7 +786,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -809,7 +797,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -821,7 +808,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -833,7 +819,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -845,7 +830,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -857,7 +841,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -869,7 +852,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80082380",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -881,7 +863,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C27F0",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -893,7 +874,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F003C0477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -905,7 +885,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -917,7 +896,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x4003C0477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -929,7 +907,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x8003C0477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -941,7 +918,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1830000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -953,7 +929,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1030000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -965,7 +940,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x830000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -977,7 +951,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x1008000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -989,7 +962,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x808000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1001,7 +973,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x80080800",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1200,4 +1171,4 @@
         "Speculative": "1",
         "UMask": "0x4"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index a737fa40feb0..be70672bfdb0 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -475,10 +475,10 @@
         "MetricName": "IpFarBranch"
     },
     {
-        "BriefDescription": "C3 residency percent per core",
-        "MetricExpr": "(cstate_core@c3\\-residency@ / msr@tsc@) * 100",
+        "BriefDescription": "C1 residency percent per core",
+        "MetricExpr": "(cstate_core@c1\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
-        "MetricName": "C3_Core_Residency"
+        "MetricName": "C1_Core_Residency"
     },
     {
         "BriefDescription": "C6 residency percent per core",
@@ -486,34 +486,16 @@
         "MetricGroup": "Power",
         "MetricName": "C6_Core_Residency"
     },
-    {
-        "BriefDescription": "C7 residency percent per core",
-        "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Core_Residency"
-    },
     {
         "BriefDescription": "C2 residency percent per package",
         "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C2_Pkg_Residency"
     },
-    {
-        "BriefDescription": "C3 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
-        "MetricGroup": "Power",
-        "MetricName": "C3_Pkg_Residency"
-    },
     {
         "BriefDescription": "C6 residency percent per package",
         "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
         "MetricGroup": "Power",
         "MetricName": "C6_Pkg_Residency"
-    },
-    {
-        "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/memory.json b/tools/pe=
rf/pmu-events/arch/x86/icelakex/memory.json
index c10a1bbc66b1..58b03a8a1b95 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
@@ -159,7 +159,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -171,7 +170,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84400004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -183,7 +181,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -195,7 +192,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -207,7 +203,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FC00002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -219,7 +214,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F04400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -231,7 +225,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC00400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -243,7 +236,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84400400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -255,7 +247,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x94002380",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -267,7 +258,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84002380",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -279,7 +269,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -291,7 +280,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FBFC08000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -303,7 +291,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F84408000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -315,7 +302,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F844027F0",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -327,7 +313,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FC00477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -339,7 +324,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F04400477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -351,7 +335,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x70CC00477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -363,7 +346,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x94000800",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -375,7 +357,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x84000800",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -565,4 +546,4 @@
         "Speculative": "1",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/other.json b/tools/per=
f/pmu-events/arch/x86/icelakex/other.json
index 1246b22769da..c9bf6808ead7 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/other.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/other.json
@@ -1,16 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
-        "CollectPEBSRecord": "2",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xc1",
-        "EventName": "ASSISTS.ANY",
-        "PEBScounters": "0,1,2,3,4,5,6,7",
-        "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware Examples include AD (page Access Dirty=
), FP and AVX related assists.",
-        "SampleAfterValue": "100003",
-        "Speculative": "1",
-        "UMask": "0x7"
-    },
     {
         "BriefDescription": "Core cycles where the core was running in a m=
anner where Turbo may be clipped to the Non-AVX turbo schedule.",
         "CollectPEBSRecord": "2",
@@ -139,7 +127,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -151,7 +138,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x73C000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -163,7 +149,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -175,7 +160,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x708000004",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -187,7 +171,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -199,7 +182,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x73C000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -211,7 +193,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -223,7 +204,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -235,7 +215,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x703C00001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -247,7 +226,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x730000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -259,7 +237,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x703000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -271,19 +248,17 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x708000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads that (IC) were suppl=
ied by PMM on a distant memory controller of this socket when the system is=
 in SNC (sub-NUMA cluster) mode.",
+        "BriefDescription": "Counts demand data reads that were supplied b=
y PMM on a distant memory controller of this socket when the system is in S=
NC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_DATA_RD.SNC_PMM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x700800001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -295,7 +270,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FFC0002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -307,7 +281,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x73C000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -319,7 +292,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -331,7 +303,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -343,7 +314,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x703C00002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -355,7 +325,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x703000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -367,19 +336,17 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x708000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that (IC) w=
ere supplied by PMM on a distant memory controller of this socket when the =
system is in SNC (sub-NUMA cluster) mode.",
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by PMM on a distant memory controller of this socket when the syste=
m is in SNC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.DEMAND_RFO.SNC_PMM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x700800002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -391,7 +358,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x73C000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -403,7 +369,17 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000400",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts hardware prefetch (which bring data to=
 L2) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xB7, 0xBB",
+        "EventName": "OCR.HWPF_L2.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10070",
+        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -415,7 +391,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x12380",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -427,7 +402,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90002380",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -439,7 +413,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x90000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -451,7 +424,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x18000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -463,7 +435,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F3FFC0477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -475,7 +446,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x73C000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -487,7 +457,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x104000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -499,7 +468,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x100400477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -511,7 +479,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x70C000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -523,7 +490,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x700C00477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -535,7 +501,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F33000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -547,7 +512,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x730000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -559,7 +523,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x703000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -571,19 +534,17 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x708000477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that (IC=
) were supplied by PMM on a distant memory controller of this socket when t=
he system is in SNC (sub-NUMA cluster) mode.",
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by PMM on a distant memory controller of this socket when the sy=
stem is in SNC (sub-NUMA cluster) mode.",
         "Counter": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OCR.READS_TO_CORE.SNC_PMM",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x700800477",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -595,8 +556,7 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/icelakex/pipeline.json
index 068a3d46b443..95c1008ef057 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
@@ -12,6 +12,18 @@
         "Speculative": "1",
         "UMask": "0x9"
     },
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
+        "Speculative": "1",
+        "UMask": "0x7"
+    },
     {
         "BriefDescription": "All branch instructions retired.",
         "CollectPEBSRecord": "2",
@@ -1076,4 +1088,4 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
--=20
2.36.0.rc0.470.gd361397f0d-goog

