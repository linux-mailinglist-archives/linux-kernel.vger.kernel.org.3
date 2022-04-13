Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF02C50008E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbiDMVHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiDMVHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:07:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3747AFA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d11b6259adso26593347b3.19
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+gtnTZ0Ui0fjQ6PlMfk1tXFCeUDxgDy5EJOsSSiIAT8=;
        b=QTH9GSoYVXDl+zc3aHBzUQJEePfxKGQq/b70vqCjHezgfMlhlFi1/myc7r4pphxiyU
         3m+4j6YIFLj2KoWCVpe5MsxGq+PX9vbszgO2pvqGNm2PTUYsGYaUjNFW0RWaGt0lVTAb
         qNtdvkAvpv77ywxxTKz1GQF27OU/H8uCC8uHlS6c3AvB3q3VWP9Qjw1BKY/kc8R4Bexs
         Z7NlqNfjMkLd4zyqtyezB4SOijaRTJSlIUB0LACXbLzBOXyFoPEupsZzu9KecazhfYn8
         J2iBNnZbvMx2uu+fHAg+B1NlXbnYy2KxL+Hj3MYK4fqmgKl+xNhmsVn6+4D7xaqoW26k
         FmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+gtnTZ0Ui0fjQ6PlMfk1tXFCeUDxgDy5EJOsSSiIAT8=;
        b=qfZqvDrbNWnBMs71+XbFIXS6Jd+h3mx3iPIvNmPVSp//N7YMocqsnxJC4BArLz9wGd
         Q4Ez9GdfXmkIUpx/WNDhyIyDqN/mjuK4xOkkASanT/y6yLH+zwliMgEcc4yGQ3b1ZGfl
         FuLqIk3IMhnHl/J5ZMT4xxUonX6S29Z2zA+qm+DZf03Z3m6RH76w3VGG/X71X8vQ4msv
         VmUZwAZjsdNxe1PmOAd0dMC5BgE0G47MNkqOGLO/BzlXo802jj2n5KgDuoYcwyAfvRoX
         db7svrX6K7KgmWHydCQcvrpt0sVQ89xj+y9YGXchABcJMZD4AEHtuEv33ZABgIp8XEEv
         zZ7g==
X-Gm-Message-State: AOAM532gYvnyxn2bZJiWvT2fPKgFHCcVRLZUPZjPyjsQPZ31IJ8X6+YR
        pPwcnNenyR4ALWB1FFxoM53tU+Ptfp7H
X-Google-Smtp-Source: ABdhPJxyuLtqGum779Qh86iA+H17LMM84j42h7x5EVbV+81rRO6GJnQ53JlY6GldT5LGCkLVwVYMF7MU+9mB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9135:da53:a8a2:bf11])
 (user=irogers job=sendgmr) by 2002:a25:3b8b:0:b0:63d:f010:ed04 with SMTP id
 i133-20020a253b8b000000b0063df010ed04mr611621yba.591.1649883914400; Wed, 13
 Apr 2022 14:05:14 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:04:53 -0700
In-Reply-To: <20220413210503.3256922-1-irogers@google.com>
Message-Id: <20220413210503.3256922-4-irogers@google.com>
Mime-Version: 1.0
References: <20220413210503.3256922-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 04/14] perf vendor events intel: Update CLX uncore to v1.14
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

JSON uncore events are generated for CascadeLake Server for v1.14
with events from:
https://download.01.org/perfmon/CLX/

New event names are added, that match the original json names,
due to an update to:
https://github.com/intel/event-converter-for-linux-perf/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/cascadelakex/uncore-memory.json  | 61 ++++++++++++
 .../arch/x86/cascadelakex/uncore-other.json   | 92 +++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
index 2600fd8d7a54..a416515d41da 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
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
@@ -89,6 +109,15 @@
         "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Intel Optane DC persistent memory bandwidth read (MB/sec)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M_PMM_RPQ_INSERTS",
+        "PerPkg": "1",
+        "ScaleUnit": "6.103515625E-5MB/sec",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Intel Optane DC persistent memory bandwidth write (MB/sec). Derived from unc_m_pmm_wpq_inserts",
         "Counter": "0,1,2,3",
@@ -98,6 +127,15 @@
         "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Intel Optane DC persistent memory bandwidth write (MB/sec)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE7",
+        "EventName": "UNC_M_PMM_WPQ_INSERTS",
+        "PerPkg": "1",
+        "ScaleUnit": "6.103515625E-5MB/sec",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Intel Optane DC persistent memory bandwidth total (MB/sec). Derived from unc_m_pmm_rpq_inserts",
         "Counter": "0,1,2,3",
@@ -109,6 +147,17 @@
         "ScaleUnit": "6.103515625E-5MB/sec",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Intel Optane DC persistent memory bandwidth total (MB/sec)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE3",
+        "EventName": "UNC_M_PMM_RPQ_INSERTS",
+        "MetricExpr": "UNC_M_PMM_RPQ_INSERTS + UNC_M_PMM_WPQ_INSERTS",
+        "MetricName": "UNC_M_PMM_BANDWIDTH.TOTAL",
+        "PerPkg": "1",
+        "ScaleUnit": "6.103515625E-5MB/sec",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Read Pending Queue Occupancy of all read requests for Intel Optane DC persistent memory",
         "Counter": "0,1,2,3",
@@ -130,6 +179,18 @@
         "UMask": "0x1",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "Intel Optane DC persistent memory read latency (ns)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xE0",
+        "EventName": "UNC_M_PMM_RPQ_OCCUPANCY.ALL",
+        "MetricExpr": "UNC_M_PMM_RPQ_OCCUPANCY.ALL / UNC_M_PMM_RPQ_INSERTS / UNC_M_CLOCKTICKS",
+        "MetricName": "UNC_M_PMM_READ_LATENCY",
+        "PerPkg": "1",
+        "ScaleUnit": "6000000000ns",
+        "UMask": "0x1",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "DRAM Page Activate commands sent due to a write request",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
index 7f1cf4d8f0fa..03575ef9f4c3 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-other.json
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
         "BriefDescription": "PCI Express bandwidth writing at IIO, part 0",
         "Counter": "0,1",
@@ -176,6 +238,21 @@
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
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "MetricName": "LLC_MISSES.PCIE_WRITE",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x01",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "PCI Express bandwidth reading at IIO, part 0",
         "Counter": "0,1",
@@ -239,6 +316,21 @@
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
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2 + UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "MetricName": "LLC_MISSES.PCIE_READ",
+        "PerPkg": "1",
+        "PortMask": "0x01",
+        "ScaleUnit": "4Bytes",
+        "UMask": "0x04",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Core Cross Snoops Issued; Multiple Core Requests",
         "Counter": "0,1,2,3",
-- 
2.36.0.rc0.470.gd361397f0d-goog

