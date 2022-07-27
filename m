Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC49A58353A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiG0WLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiG0WKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:10:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B25F98E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317f6128c86so777697b3.22
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QK3ShdNa0rI6xddT9IjDfF/1fuI9KTuI6MjArajlZ3g=;
        b=RYQgdV32UKgIHVVGkPVMlKyyE2lzxe54JtXNdgzXM4KAh5m722x6iC6Y2Y2mJ8GzCg
         FjUP2lOzETy6FtGSF36Yw8X0lTCtubikEbOyEqTZPhzoUzq3g2debZo3x1chAEcSQ66T
         4UtV9hUjvf4cM+qY1q0u7Nju5KgW4heSML0ornaPG8/6Myf61ZCuuBDpll/Wvxk9Hdr0
         t2FJ9mXTmo5jP04EsrkR146pA4Jn4eJfcaKRSPf759sq2pYZY3roEM2NbQMPLA53a+jL
         Ep9Xw9WVnp7l9fYAukSaaamzqGv7Dm4o2TzFBonB5mZx2iSiiwDbaH4arp1WdJb4KDwz
         w0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QK3ShdNa0rI6xddT9IjDfF/1fuI9KTuI6MjArajlZ3g=;
        b=j1BLZJPQnu0DtQ9kUxKz/w3WE8HaWRmDtXZQol+BjAmGAkCHHNvjo2ELAulKy/Nh6g
         pmMkEQboR42qyTqnU7FZbdjPExk0BxM9qgRZBQs1zOmnWVFZMiE6k2ONc8mcW4UtGPlA
         rvWZhdPPtw9shk9Z2Y69A3LWSLaHzm2bRj66gGM8V8MXAvt4qJAk614k0ptVfRfV1C83
         G1u86s05FlEWl3j2AtQRbh9ALshcXAxGZvMEIkR1nfOLJfyi3sHMSkSw6e3ggqJJti+m
         fyJtvIuIutuBSxJeXD2vcPVpctJ1hbKYoWpbZmKhJ5u1Pja84SYRu18LInz1wJA07VRc
         zlhw==
X-Gm-Message-State: AJIora8Oh20RjWwKzL9vFpzg15w/QzBVkTiUs2nMPRbwp/yS7RqMXTTq
        aUdq2da2IQSUNiUHEzd6xyW5l1QH2RKQ
X-Google-Smtp-Source: AGRyM1t0pOHP4lSvxoHVy7o1puENJFiEYen43msokDWuAwzs90kVh5ZPY7F0YMRRrZaFjY/AkApAippddNQY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a81:6503:0:b0:31d:6463:bf1a with SMTP id
 z3-20020a816503000000b0031d6463bf1amr19771913ywb.178.1658959775099; Wed, 27
 Jul 2022 15:09:35 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:21 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-20-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 19/30] perf vendor events: Update Intel nehalemep
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to v3, the are no TMA metrics for nehalemep.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the nehalemep files into perf and update mapfile.csv.

Tested on a non-nehalemep with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv         |  4 +---
 .../perf/pmu-events/arch/x86/nehalemep/cache.json  | 14 +++++++-------
 .../arch/x86/nehalemep/floating-point.json         |  2 +-
 .../pmu-events/arch/x86/nehalemep/frontend.json    |  2 +-
 .../perf/pmu-events/arch/x86/nehalemep/memory.json |  6 +++---
 .../arch/x86/nehalemep/virtual-memory.json         |  2 +-
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 52e4d063ca6b..b9066dceee8d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -17,9 +17,7 @@ GenuineIntel-6-3E,v21,ivytown,core
 GenuineIntel-6-2D,v21,jaketown,core
 GenuineIntel-6-(57|85),v9,knightslanding,core
 GenuineIntel-6-AA,v1.00,meteorlake,core
-GenuineIntel-6-1E,v2,nehalemep,core
-GenuineIntel-6-1F,v2,nehalemep,core
-GenuineIntel-6-1A,v2,nehalemep,core
+GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v2,nehalemex,core
 GenuineIntel-6-[4589]E,v24,skylake,core
 GenuineIntel-6-A[56],v24,skylake,core
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
index bcf74d793ae2..1ee91300baf9 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
@@ -1773,7 +1773,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the IO, CSR, MMIO unit",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the IO, CSR, MMIO unit",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.IO_CSR_MMIO",
@@ -1784,7 +1784,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the LLC and not found in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and not found in a sibling core",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_NO_OTHER_CORE",
@@ -1795,7 +1795,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC and HIT in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC and HIT in a sibling core",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HIT",
@@ -1806,7 +1806,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches satisfied by the LLC  and HITM in a sibling core",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the LLC  and HITM in a sibling core",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LLC_HIT_OTHER_CORE_HITM",
@@ -1861,7 +1861,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HIT in a remote cache",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HIT in a remote cache",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HIT",
@@ -1872,7 +1872,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches that HITM in a remote cache",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches that HITM in a remote cache",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_CACHE_HITM",
@@ -3226,4 +3226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
index 39af1329224a..666e466d351c 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
@@ -226,4 +226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json b/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
index 8ac5c24888c5..c561ac24d91d 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
@@ -23,4 +23,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
index 26138ae639f4..6e95de3f3409 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/memory.json
@@ -286,7 +286,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the local DRAM.",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the local DRAM.",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.LOCAL_DRAM",
@@ -297,7 +297,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Offcore data reads, RFO's and prefetches statisfied by the remote DRAM",
+        "BriefDescription": "Offcore data reads, RFOs, and prefetches satisfied by the remote DRAM",
         "Counter": "2",
         "EventCode": "0xB7",
         "EventName": "OFFCORE_RESPONSE.DATA_IN.REMOTE_DRAM",
@@ -736,4 +736,4 @@
         "SampleAfterValue": "100000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
index 6d3247c55bcd..e88c0802e679 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
@@ -106,4 +106,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

