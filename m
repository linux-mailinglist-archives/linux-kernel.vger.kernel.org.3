Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2890A50009E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiDMVIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiDMVHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:07:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79C149F9F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ec44c52e7fso27106247b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZOlFKuxf/lhuFEDWiAfN0RvqLsze8Mg1n+AVNQB8APc=;
        b=h4IqUUuRIB9BCsf33iAj+gY58SukDRQHrEYUOjqDXZhbityLf9/otYxynEw6v/hXJ2
         UdOjegwkAUUSuwaBrPemKZk7yLrFhuVnJzKQ8SGgZVqxngOqHRfFIl1RYBRLRkmLIX2q
         h1uShAtvXHhMuquZtYJueiSV5u+rUA0SjiqqUZs0VCeOd2IB50jV/1e3nTK+tbP/4Q0e
         97sN8ZhXucVog2yBTZdAk4h96en5hU0qqjnfpwhdOXrLERQbVVbrM0fnwIQpCGJrSUwW
         S9Lf6kN3YxBlcdTSu+prg9HSoRXm1DKaAhtzcmKSKpHxRE3XlOfJPfy8WkN+z4svNjck
         m0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZOlFKuxf/lhuFEDWiAfN0RvqLsze8Mg1n+AVNQB8APc=;
        b=KH/LHBnvaaoLnfS6L5/UY0+siJDx4NAtkIQwPYlZ41vFVkK2CkqZJyI/ypy9k41dBS
         YGNqLI0ue2SAYJBjgEvsvarZIOmGq7Rb/lTl/H5O/0laWCsdcF/zzoETAMPFgqUe9Xio
         pFbcGCuB5I/crRBGwT001Pwqg+78OW60iMwwJg7Cwq6YAcTOHNUuTgcIJV0Gd9Xtmuio
         oyHRQgsyCpWKmruviAkIy3lEd/hz8pTOTGwcVQPpy4VtRc3sFomJRvznVFhvLTxJCv6N
         rXEe+hO4RrimtN6+I1RisUmFbJNmbQKHEwZyRK/1PvYQdNqNxq+EfCJFewXjXiY/UXLf
         kdSA==
X-Gm-Message-State: AOAM530u30ZBv0lKd8iQTPit3Tw/0ch2fiKIg8LaYnpCglF2L851qnXG
        yj67LlHiSux1/FkhdRFmA/kvi5ucmF8P
X-Google-Smtp-Source: ABdhPJxpIM8npp3wJlNCt6DsX69AV/Zw4h/J7A/ie6JqXuIHh5MLpWojbpdlfEZL76+5eVaahNOIJfT3qRDz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a25:8c10:0:b0:61d:b17e:703d with SMTP id
 k16-20020a258c10000000b0061db17e703dmr706181ybl.154.1649883916904; Wed, 13
 Apr 2022 14:05:16 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:54 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-5-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 05/14] perf vendor events intel: Update SKX uncore
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

JSON uncore events are generated for Skylake Server for v1.26
with events from:
https://download.01.org/perfmon/SKX/

New event names are added, that match the original json names,
due to an update to:
https://github.com/intel/event-converter-for-linux-perf/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/skylakex/uncore-memory.json      | 20 ++++
 .../arch/x86/skylakex/uncore-other.json       | 92 +++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
index 0b66e6af8177..4dcbac887380 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
@@ -9,6 +9,16 @@
         "UMask": "0x3",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "read requests to memory controller",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.RD",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x3",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "write requests to memory controller. Derived from unc_m_cas_count.wr",
         "Counter": "0,1,2,3",
@@ -19,6 +29,16 @@
         "UMask": "0xC",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "write requests to memory controller",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4",
+        "EventName": "UNC_M_CAS_COUNT.WR",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0xC",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Memory controller clock ticks",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
index 06c5ca26ca3f..567d86434839 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-other.json
@@ -16,6 +16,16 @@
         "UMask": "0x21",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "LLC misses - Uncacheable reads (from cpu) ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x40e33",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "MMIO reads. Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -26,6 +36,16 @@
         "UMask": "0x21",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "MMIO reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x40040e33",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "MMIO writes. Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -36,6 +56,16 @@
         "UMask": "0x21",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "MMIO writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x40041e33",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Streaming stores (full cache line). Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -47,6 +77,17 @@
         "UMask": "0x21",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Streaming stores (full cache line)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x41833",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Streaming stores (partial cache line). Derived from unc_cha_tor_inserts.ia_miss",
         "Counter": "0,1,2,3",
@@ -58,6 +99,17 @@
         "UMask": "0x21",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Streaming stores (partial cache line)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "Filter": "config1=0x41a33",
+        "PerPkg": "1",
+        "ScaleUnit": "64Bytes",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "read requests from home agent",
         "Counter": "0,1,2,3",
@@ -113,6 +165,16 @@
         "UMask": "0xf",
         "Unit": "UPI LL"
     },
+    {
+        "BriefDescription": "UPI interconnect send bandwidth for payload",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "ScaleUnit": "7.11E-06Bytes",
+        "UMask": "0xf",
+        "Unit": "UPI LL"
+    },
     {
         "BriefDescription": "PCI Express bandwidth reading at IIO, part 0",
         "Counter": "0,1",
@@ -176,6 +238,21 @@
         "UMask": "0x04",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "PCI Express bandwidth reading at IIO",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "Filter": "ch_mask=0x1f",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 +UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "MetricName": "LLC_MISSES.PCIE_READ",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "PCI Express bandwidth writing at IIO, part 0",
         "Counter": "0,1",
@@ -239,6 +316,21 @@
         "UMask": "0x01",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "PCI Express bandwidth writing at IIO",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "Filter": "ch_mask=0x1f",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 +UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "MetricName": "LLC_MISSES.PCIE_WRITE",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Core Cross Snoops Issued; Multiple Core Requests",
         "Counter": "0,1,2,3",
-- 
2.36.0.rc0.470.gd361397f0d-goog

