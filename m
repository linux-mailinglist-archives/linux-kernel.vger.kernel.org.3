Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009E0583530
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiG0WLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiG0WKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:10:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B765F11C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s14-20020a5b044e000000b00672caf96368so203867ybp.21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 15:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AEiEijAM0zyPnkPkjfgFhy8pcFffCGogSSbyE0J4G3c=;
        b=FoDWU3jVrch6668DSR6r9iHcQIr1MQEPcWYEbODlc2yVoEEWLvU0/OaMbIN11izyyl
         Q2C+zmTfBRhRQ/N3wl7j15QWy8pC868t2LnRvDlYUndLS6ZGhCaU4KXQZzdWh3aZcIMW
         E7tmk+8nMxe6h+b9vCDptaRHM+NfzR9YXI6jj8IUzMNR8Hwo6rzoRuM93evUJa7WUC/z
         If72S8WIRV/dFs4jFIgyoi3ucrGlGQ+6mIERbLdd3IZAjT+8JgSlSkxR+AcPfXtei+Kj
         XMSosocfFa0wUDKfs21kpJnMOvORM1CI4t6JALuU/Ehe3TDWyrTENkZuyGn/GmodMTxA
         agkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AEiEijAM0zyPnkPkjfgFhy8pcFffCGogSSbyE0J4G3c=;
        b=kfzdoBYSfePRambDITo5nJ0Kjnbwol5BUaqQ2zZWJgmLeUxd0u4z8wL9UXuLsmUCG0
         CfR654MqJi479hv7ymj6RzBBQPeH7UaLk5O8k0uTCMLQlYbB8gapZ72I023Rf+NaQu0S
         HleAKOuQ/g8hPNtAzAnMg7dymsg2yA3409pKR/a/0sIwmcDsU8li9IrRmHlBb8HXWUE8
         tOq7MYnPNIlHcygCc5KsNda7atSrxS/G88E9BqTzDvsrgyLcskSlLlpTVONk3UsN5zVL
         kZniBN1VkDKBo7HmJKZ1lqukneqlxV59hRRZe+yYhu7cSv5EgK1CPBm2bJUGtR2StZnC
         hlCA==
X-Gm-Message-State: AJIora++qHeE79Hx7gvPSPGdB8yiutp+ug7lrTsv9cuTy/C64maWj0m8
        2Zeywd1/a80geXpaD7mo170rfo2MHtmH
X-Google-Smtp-Source: AGRyM1sR8vAj536NC4PnqS7RZPj98/xaY+/TEoNNChCEqSftHkeEs3MfDTliEXGIdIF07OuPD0kaHsaGkmqq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:882a:af57:8cb6:6f9e])
 (user=irogers job=sendgmr) by 2002:a25:9f05:0:b0:671:5aca:b0c4 with SMTP id
 n5-20020a259f05000000b006715acab0c4mr10702328ybq.29.1658959772304; Wed, 27
 Jul 2022 15:09:32 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:08:20 -0700
In-Reply-To: <20220727220832.2865794-1-irogers@google.com>
Message-Id: <20220727220832.2865794-19-irogers@google.com>
Mime-Version: 1.0
References: <20220727220832.2865794-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3 18/30] perf vendor events: Add Intel meteorlake
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

Events are v1.00, there are no metrics yet.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the events and metrics. Manually copy
the meteorlake files into perf and update mapfile.csv.

Tested on a non-meteorlake with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
 .../pmu-events/arch/x86/meteorlake/cache.json | 262 ++++++++++++++++++
 .../arch/x86/meteorlake/frontend.json         |  24 ++
 .../arch/x86/meteorlake/memory.json           | 185 +++++++++++++
 .../pmu-events/arch/x86/meteorlake/other.json |  46 +++
 .../arch/x86/meteorlake/pipeline.json         | 254 +++++++++++++++++
 .../arch/x86/meteorlake/virtual-memory.json   |  46 +++
 7 files changed, 818 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index cc42946cacd3..52e4d063ca6b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -16,6 +16,7 @@ GenuineIntel-6-3A,v22,ivybridge,core
 GenuineIntel-6-3E,v21,ivytown,core
 GenuineIntel-6-2D,v21,jaketown,core
 GenuineIntel-6-(57|85),v9,knightslanding,core
+GenuineIntel-6-AA,v1.00,meteorlake,core
 GenuineIntel-6-1E,v2,nehalemep,core
 GenuineIntel-6-1F,v2,nehalemep,core
 GenuineIntel-6-1A,v2,nehalemep,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
new file mode 100644
index 000000000000..32b2aa9b1475
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -0,0 +1,262 @@
+[
+    {
+        "BriefDescription": "Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "200003",
+        "UMask": "0x41",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cacheable memory requests that access the LLC. Counts on a per core basis.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4f",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "200003",
+        "UMask": "0x81",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of store ops retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "200003",
+        "UMask": "0x82",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled.",
+        "CollectPEBSRecord": "3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "TakenAlone": "1",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of  stores uops retired same as MEM_UOPS_RETIRED.ALL_STORES",
+        "CollectPEBSRecord": "3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
+        "PEBS": "2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L2 code requests",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_CODE_RD",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Demand Data Read access L2 cache",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that missed L3  (Except hardware prefetches to the L3)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.MISS",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x41",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core-originated cacheable requests that refer to L3 (Except hardware prefetches to the L3)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2e",
+        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4f",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired load instructions.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired store instructions.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_INST_RETIRED.ALL_STORES",
+        "L1_Hit_Indication": "1",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82",
+        "Unit": "cpu_core"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
new file mode 100644
index 000000000000..9657768fc95a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -0,0 +1,24 @@
+[
+    {
+        "BriefDescription": "Counts every time the code stream enters into a new cache line by walking sequential from the previous line or being redirected by a jump.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.ACCESSES",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "200003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts every time the code stream enters into a new cache line by walking sequential from the previous line or being redirected by a jump and the instruction cache registers bytes are not present. -",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.MISSES",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
new file mode 100644
index 000000000000..15b2294a8ae7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -0,0 +1,185 @@
+[
+    {
+        "BriefDescription": "Counts cacheable demand data reads were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership, including SWPREFETCHW which is an RFO were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 128 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x80",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "1009",
+        "TakenAlone": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 16 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x10",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "20011",
+        "TakenAlone": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 256 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x100",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "503",
+        "TakenAlone": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 32 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x20",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "100007",
+        "TakenAlone": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 4 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x4",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "100003",
+        "TakenAlone": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 512 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x200",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "101",
+        "TakenAlone": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 64 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x40",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "2003",
+        "TakenAlone": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 8 cycles.",
+        "CollectPEBSRecord": "2",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x8",
+        "PEBS": "2",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "50021",
+        "TakenAlone": "1",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Retired memory store access operations. A PDist event for PEBS Store Latency Facility.",
+        "CollectPEBSRecord": "2",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
+        "PEBS": "2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
new file mode 100644
index 000000000000..14273ac54d2c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -0,0 +1,46 @@
+[
+    {
+        "BriefDescription": "Counts cacheable demand data reads Catch all value for any response types - this includes response types not define in the OCR.  If this is set all other response types will be ignored",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership, including SWPREFETCHW which is an RFO Catch all value for any response types - this includes response types not define in the OCR.  If this is set all other response types will be ignored",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
new file mode 100644
index 000000000000..0a7981675b6c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -0,0 +1,254 @@
+[
+    {
+        "BriefDescription": "Counts the total number of branch instructions retired for all branch types.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "200003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the total number of mispredicted branch instructions retired for all branch types.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "200003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "CollectPEBSRecord": "2",
+        "Counter": "33",
+        "EventName": "CPU_CLK_UNHALTED.CORE",
+        "PEBScounters": "33",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycles[This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.CORE_P",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted reference clock cycles",
+        "CollectPEBSRecord": "2",
+        "Counter": "34",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "PEBScounters": "34",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles",
+        "CollectPEBSRecord": "2",
+        "Counter": "33",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "PEBScounters": "33",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted core clock cycles[This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of instructions retired",
+        "CollectPEBSRecord": "2",
+        "Counter": "32",
+        "EventName": "INST_RETIRED.ANY",
+        "PEBS": "1",
+        "PEBScounters": "32",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retirement slots not consumed due to backend stalls",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALL",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of retirement slots not consumed due to front end stalls",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ALL",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of consumed retirement slots.  Similar to UOPS_RETIRED.ALL",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x72",
+        "EventName": "TOPDOWN_RETIRING.ALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "All branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "400009",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "All mispredicted branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "400009",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "34",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "PEBScounters": "34",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x3",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Reference cycles when the core is not in halt state.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Core cycles when the thread is not in halt state",
+        "CollectPEBSRecord": "2",
+        "Counter": "33",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "PEBScounters": "33",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Thread cycles when thread is not in halt state",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event",
+        "CollectPEBSRecord": "2",
+        "Counter": "32",
+        "EventName": "INST_RETIRED.ANY",
+        "PEBS": "1",
+        "PEBScounters": "32",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Number of instructions retired. General Counter - architectural event",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc0",
+        "EventName": "INST_RETIRED.ANY_P",
+        "PEBS": "1",
+        "PEBScounters": "1,2,3,4,5,6,7",
+        "SampleAfterValue": "2000003",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Loads blocked due to overlapping with a preceding store that cannot be forwarded.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "100003",
+        "UMask": "0x82",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
+        "CollectPEBSRecord": "2",
+        "Counter": "35",
+        "EventName": "TOPDOWN.SLOTS",
+        "PEBScounters": "35",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "TMA slots available for an unhalted logical processor. General counter - architectural event",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa4",
+        "EventName": "TOPDOWN.SLOTS_P",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "10000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
new file mode 100644
index 000000000000..3087730cca7b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/virtual-memory.json
@@ -0,0 +1,46 @@
+[
+    {
+        "BriefDescription": "Counts the number of page walks completed due to instruction fetch misses to any page size.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Load miss in all TLB levels causes a page walk that completes. (All page sizes)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Store misses in all TLB levels causes a page walk that completes. (All page sizes)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Code miss in all TLB levels causes a page walk that completes. (All page sizes)",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "100003",
+        "UMask": "0xe",
+        "Unit": "cpu_core"
+    }
+]
-- 
2.37.1.359.gd136c6c3e2-goog

