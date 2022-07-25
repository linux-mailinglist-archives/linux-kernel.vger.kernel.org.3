Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A3C58078C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiGYWih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbiGYWiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:38:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1979B2613E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e9b1be83eso78886577b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=UVk1yVZESihPOlg43D+/4qqNzqVaigmIdUelDdGLpF4=;
        b=k2zzToYbpu08wWitGoqkPdkXdpcKUCWAcHrOndEEXi3vxXZF84afGJ2Xl2TOFTYriy
         vAvOKWn09rZDDEabYFWMBKimAtuz/WuCq4N+bmFB0oasGFRcMYA0MTUFdOXd9ap7lkLt
         mxA6QflJf+XhbNDAXEFh0jQFL2Gn4WyzaDzh2XbA2gTW/t1csUFNvNgwdVql9J9V3pmj
         jJqJojsFtJ1OCcm3Cey2cCPQNJjBehYNiw1FNvvrG2pEGQJYCt3gJ1FMsFe6TdTT5wjZ
         VZkM7d+cwIs0Hrhovgxs0F0jQLZPg4C5Q9CQbhdknM8o3V9fRM6yVft2xUR4SJCR/sJG
         QGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=UVk1yVZESihPOlg43D+/4qqNzqVaigmIdUelDdGLpF4=;
        b=ojiiMd51IANv9WS2yC3u8PuVevdM3I3aaHAnzcuTN+5Zwyer+K2gEav2xGTqmONDu+
         IadwR0J1u6DIhu+sakOkvGTx1VQKe69c7YmwIBDsEp7Ll1BhOAmWKw40AGF3sX63WmHI
         2xd02yISAK5METQPf7OY98jFOEyYsDee5YCC0Fupb0AKkPB5nwDsON5LdbYQXOM/cJoH
         +zuDK3o9Dht/0v3V/7xhMj62H1sEccAjiIiqf+DYTE0hK8lM/7gpFw0Z5aUkBBsJaKu2
         Zu6o+iBbLVw9yAuBZcBGuNMSkJog8j25MgAlL82vkxsoHL6nn7uWuOh5LLJIjT/CHUqH
         6vjg==
X-Gm-Message-State: AJIora/94B/lnUB7yAL1jObcFpbPqfzxTNR1Oeir6BfdZtWJ4ZqVwbMy
        IFDvMKpXp/VsON05BsRawcyWdWDWH5tm
X-Google-Smtp-Source: AGRyM1tBn+ugqEDgegxDXF/48SFBHXQSUs9Vi545Jtp4MjQzflpwMbq+P7l1K520TZeOr+9MSyTuJGVjSkxD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:e083:0:b0:66f:cc60:c790 with SMTP id
 x125-20020a25e083000000b0066fcc60c790mr10921784ybg.636.1658788634036; Mon, 25
 Jul 2022 15:37:14 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:12 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-12-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 11/32] perf vendor events: Update Intel haswell
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to v31, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the haswell files into perf and update mapfile.csv.

Tested on a non-haswell with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/haswell/cache.json    | 78 +++++++----------
 .../arch/x86/haswell/floating-point.json      |  2 +-
 .../pmu-events/arch/x86/haswell/frontend.json |  2 +-
 .../arch/x86/haswell/hsw-metrics.json         | 85 +++++++++++++------
 .../pmu-events/arch/x86/haswell/memory.json   | 75 ++++++----------
 .../pmu-events/arch/x86/haswell/other.json    |  2 +-
 .../pmu-events/arch/x86/haswell/pipeline.json |  9 +-
 .../arch/x86/haswell/uncore-other.json        |  7 +-
 .../arch/x86/haswell/virtual-memory.json      |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  4 +-
 10 files changed, 125 insertions(+), 141 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswell/cache.json b/tools/perf=
/pmu-events/arch/x86/haswell/cache.json
index 91464cfb9615..3b0f3a264246 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/cache.json
@@ -556,7 +556,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "All retired load uops.",
+        "BriefDescription": "Retired load uops.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
@@ -564,11 +564,12 @@
         "EventCode": "0xD0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
         "PEBS": "1",
+        "PublicDescription": "Counts all retired load uops. This event acc=
ounts for SW prefetch uops of PREFETCHNTA or PREFETCHT0/1/2 or PREFETCHW.",
         "SampleAfterValue": "2000003",
         "UMask": "0x81"
     },
     {
-        "BriefDescription": "All retired store uops.",
+        "BriefDescription": "Retired store uops.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "Data_LA": "1",
@@ -577,6 +578,7 @@
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
         "L1_Hit_Indication": "1",
         "PEBS": "1",
+        "PublicDescription": "Counts all retired store uops.",
         "SampleAfterValue": "2000003",
         "UMask": "0x82"
     },
@@ -790,20 +792,19 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch code reads hit i=
n the L3 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded",
+        "BriefDescription": "Counts all demand & prefetch code readshit in=
 the L3 and the snoops to sibling cores hit in either E/S state and the lin=
e is not forwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_HIT.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0244",
+        "MSRValue": "0x4003C0244",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch code reads hit =
in the L3 and the snoops to sibling cores hit in either E/S state and the l=
ine is not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch data reads hit i=
n the L3 and the snoop to one of the sibling cores hits the line in M state=
 and the line is forwarded",
+        "BriefDescription": "Counts all demand & prefetch data readshit in=
 the L3 and the snoop to one of the sibling cores hits the line in M state =
and the line is forwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -811,20 +812,18 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads hit =
in the L3 and the snoop to one of the sibling cores hits the line in M stat=
e and the line is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch data reads hit i=
n the L3 and the snoops to sibling cores hit in either E/S state and the li=
ne is not forwarded",
+        "BriefDescription": "Counts all demand & prefetch data readshit in=
 the L3 and the snoops to sibling cores hit in either E/S state and the lin=
e is not forwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_HIT.HIT_OTHER_CORE_N=
O_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0091",
+        "MSRValue": "0x4003C0091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads hit =
in the L3 and the snoops to sibling cores hit in either E/S state and the l=
ine is not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -837,7 +836,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C07F7",
         "Offcore": "1",
-        "PublicDescription": "hit in the L3 and the snoop to one of the si=
bling cores hits the line in M state and the line is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -848,14 +846,13 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_HIT.HIT_OTHER_CORE_NO_=
FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C07F7",
+        "MSRValue": "0x4003C07F7",
         "Offcore": "1",
-        "PublicDescription": "hit in the L3 and the snoops to sibling core=
s hit in either E/S state and the line is not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all requests hit in the L3",
+        "BriefDescription": "Counts all requestshit in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -863,12 +860,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C8FFF",
         "Offcore": "1",
-        "PublicDescription": "Counts all requests hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch RFOs hit in the =
L3 and the snoop to one of the sibling cores hits the line in M state and t=
he line is forwarded",
+        "BriefDescription": "Counts all demand & prefetch RFOshit in the L=
3 and the snoop to one of the sibling cores hits the line in M state and th=
e line is forwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -876,25 +872,23 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0122",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs hit in the=
 L3 and the snoop to one of the sibling cores hits the line in M state and =
the line is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch RFOs hit in the =
L3 and the snoops to sibling cores hit in either E/S state and the line is =
not forwarded",
+        "BriefDescription": "Counts all demand & prefetch RFOshit in the L=
3 and the snoops to sibling cores hit in either E/S state and the line is n=
ot forwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_HIT.HIT_OTHER_CORE_NO_FW=
D",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0122",
+        "MSRValue": "0x4003C0122",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs hit in the=
 L3 and the snoops to sibling cores hit in either E/S state and the line is=
 not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads hit in the L3 an=
d the snoop to one of the sibling cores hits the line in M state and the li=
ne is forwarded",
+        "BriefDescription": "Counts all demand code readshit in the L3 and=
 the snoop to one of the sibling cores hits the line in M state and the lin=
e is forwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -902,25 +896,23 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0004",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads hit in the L3 a=
nd the snoop to one of the sibling cores hits the line in M state and the l=
ine is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads hit in the L3 an=
d the snoops to sibling cores hit in either E/S state and the line is not f=
orwarded",
+        "BriefDescription": "Counts all demand code readshit in the L3 and=
 the snoops to sibling cores hit in either E/S state and the line is not fo=
rwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_HIT.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0004",
+        "MSRValue": "0x4003C0004",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads hit in the L3 a=
nd the snoops to sibling cores hit in either E/S state and the line is not =
forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads hit in the L3 and th=
e snoop to one of the sibling cores hits the line in M state and the line i=
s forwarded",
+        "BriefDescription": "Counts demand data readshit in the L3 and the=
 snoop to one of the sibling cores hits the line in M state and the line is=
 forwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -928,25 +920,23 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0001",
         "Offcore": "1",
-        "PublicDescription": "Counts demand data reads hit in the L3 and t=
he snoop to one of the sibling cores hits the line in M state and the line =
is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads hit in the L3 and th=
e snoops to sibling cores hit in either E/S state and the line is not forwa=
rded",
+        "BriefDescription": "Counts demand data readshit in the L3 and the=
 snoops to sibling cores hit in either E/S state and the line is not forwar=
ded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_COR=
E_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0001",
+        "MSRValue": "0x4003C0001",
         "Offcore": "1",
-        "PublicDescription": "Counts demand data reads hit in the L3 and t=
he snoops to sibling cores hit in either E/S state and the line is not forw=
arded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) hit in t=
he L3 and the snoop to one of the sibling cores hits the line in M state an=
d the line is forwarded",
+        "BriefDescription": "Counts all demand data writes (RFOs)hit in th=
e L3 and the snoop to one of the sibling cores hits the line in M state and=
 the line is forwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -954,25 +944,23 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10003C0002",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) hit in =
the L3 and the snoop to one of the sibling cores hits the line in M state a=
nd the line is forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) hit in t=
he L3 and the snoops to sibling cores hit in either E/S state and the line =
is not forwarded",
+        "BriefDescription": "Counts all demand data writes (RFOs)hit in th=
e L3 and the snoops to sibling cores hit in either E/S state and the line i=
s not forwarded",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.HIT_OTHER_CORE_NO=
_FWD",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x04003C0002",
+        "MSRValue": "0x4003C0002",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) hit in =
the L3 and the snoops to sibling cores hit in either E/S state and the line=
 is not forwarded",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads hit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code readshit in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -980,12 +968,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0040",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads hit in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
readshit in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -993,12 +980,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0010",
         "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs hit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOshit in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1006,12 +992,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0020",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads hit in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code readshit in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1019,12 +1004,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0200",
         "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads hit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data readshit in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1032,12 +1016,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0080",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs hit in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOshit in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -1045,7 +1028,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3F803C0100",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs hit in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -1058,4 +1040,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json b/t=
ools/perf/pmu-events/arch/x86/haswell/floating-point.json
index 55cf5b96464e..7cf203a90a74 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/floating-point.json
@@ -100,4 +100,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x10"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/frontend.json b/tools/p=
erf/pmu-events/arch/x86/haswell/frontend.json
index 0c8d5ccf1276..c45a09abe5d3 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/frontend.json
@@ -301,4 +301,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/tool=
s/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
index 3ade2c19533e..75dc6dd9a7bc 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
@@ -111,17 +111,11 @@
         "MetricName": "CoreIPC_SMT"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is at least 1 uop executed)",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per-core",
         "MetricExpr": "( UOPS_EXECUTED.CORE / 2 / (( cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1=
@) ) if #SMT_on else UOPS_EXECUTED.CORE / (( cpu@UOPS_EXECUTED.CORE\\,cmask=
\\=3D1@ / 2 ) if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@)",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "ILP"
     },
-    {
-        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts",
-        "MetricName": "IpMispredict"
-    },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
         "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 + CPU_CLK_U=
NHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
@@ -170,6 +164,12 @@
         "MetricGroup": "Summary;TmaL1",
         "MetricName": "Instructions"
     },
+    {
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
+        "MetricGroup": "Pipeline;Ret",
+        "MetricName": "Retire"
+    },
     {
         "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
         "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS + LSD.UOPS + IDQ.MIT=
E_UOPS + IDQ.MS_UOPS ) )",
@@ -177,11 +177,16 @@
         "MetricName": "DSB_Coverage"
     },
     {
-        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load instructions (in core cycles)",
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_UOPS_RETIRED.L1_=
MISS + mem_load_uops_retired.hit_lfb )",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
-        "MetricName": "Load_Miss_Real_Latency",
-        "PublicDescription": "Actual Average Latency for L1 data-cache mis=
s demand load instructions (in core cycles). Latency may be overestimated f=
or multi-load instructions - e.g. repeat strings."
+        "MetricName": "Load_Miss_Real_Latency"
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss. Per-Logical Proces=
sor)",
@@ -189,24 +194,6 @@
         "MetricGroup": "Mem;MemoryBound;MemoryBW",
         "MetricName": "MLP"
     },
-    {
-        "BriefDescription": "Average data fill bandwidth to the L1 data ca=
che [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L1D_Cache_Fill_BW"
-    },
-    {
-        "BriefDescription": "Average data fill bandwidth to the L2 cache [=
GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L2_Cache_Fill_BW"
-    },
-    {
-        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
-        "MetricGroup": "Mem;MemoryBW",
-        "MetricName": "L3_Cache_Fill_BW"
-    },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
         "MetricExpr": "1000 * MEM_LOAD_UOPS_RETIRED.L1_MISS / INST_RETIRED=
.ANY",
@@ -238,6 +225,48 @@
         "MetricGroup": "Mem;MemoryTLB_SMT",
         "MetricName": "Page_Walks_Utilization_SMT"
     },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration=
_time",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 / duration_time)=
",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW_1T"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 / duration_time)=
",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW_1T"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "(64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duratio=
n_time)",
+        "MetricGroup": "Mem;MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW_1T"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "0",
+        "MetricGroup": "Mem;MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW_1T"
+    },
     {
         "BriefDescription": "Average CPU Utilization",
         "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/per=
f/pmu-events/arch/x86/haswell/memory.json
index 8b69493e3726..9e5a1e0966d9 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -225,7 +225,7 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch code reads miss =
in the L3",
+        "BriefDescription": "Counts all demand & prefetch code readsmiss i=
n the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -233,25 +233,23 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00244",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch code reads miss=
 in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch code reads miss =
the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch code readsmiss t=
he L3 and the data is returned from local dram",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_CODE_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100400244",
+        "MSRValue": "0x100400244",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch code reads miss=
 the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch data reads miss =
in the L3",
+        "BriefDescription": "Counts all demand & prefetch data readsmiss i=
n the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -259,20 +257,18 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads miss=
 in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch data reads miss =
the L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch data readsmiss t=
he L3 and the data is returned from local dram",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_DATA_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100400091",
+        "MSRValue": "0x100400091",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch data reads miss=
 the L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -285,7 +281,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC007F7",
         "Offcore": "1",
-        "PublicDescription": "miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -296,14 +291,13 @@
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_READS.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x01004007F7",
+        "MSRValue": "0x1004007F7",
         "Offcore": "1",
-        "PublicDescription": "miss the L3 and the data is returned from lo=
cal dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all requests miss in the L3",
+        "BriefDescription": "Counts all requestsmiss in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -311,12 +305,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC08FFF",
         "Offcore": "1",
-        "PublicDescription": "Counts all requests miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch RFOs miss in the=
 L3",
+        "BriefDescription": "Counts all demand & prefetch RFOsmiss in the =
L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -324,25 +317,23 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00122",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs miss in th=
e L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand & prefetch RFOs miss the L3=
 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand & prefetch RFOsmiss the L3 =
and the data is returned from local dram",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.ALL_RFO.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100400122",
+        "MSRValue": "0x100400122",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand & prefetch RFOs miss the L=
3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads miss in the L3",
+        "BriefDescription": "Counts all demand code readsmiss in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -350,25 +341,23 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00004",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads miss in the L3"=
,
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand code reads miss the L3 and =
the data is returned from local dram",
+        "BriefDescription": "Counts all demand code readsmiss the L3 and t=
he data is returned from local dram",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_CODE_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100400004",
+        "MSRValue": "0x100400004",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand code reads miss the L3 and=
 the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads miss in the L3",
+        "BriefDescription": "Counts demand data readsmiss in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -376,25 +365,23 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00001",
         "Offcore": "1",
-        "PublicDescription": "Counts demand data reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts demand data reads miss the L3 and the =
data is returned from local dram",
+        "BriefDescription": "Counts demand data readsmiss the L3 and the d=
ata is returned from local dram",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_DATA_RD.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100400001",
+        "MSRValue": "0x100400001",
         "Offcore": "1",
-        "PublicDescription": "Counts demand data reads miss the L3 and the=
 data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) miss in =
the L3",
+        "BriefDescription": "Counts all demand data writes (RFOs)miss in t=
he L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -402,25 +389,23 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00002",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) miss in=
 the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all demand data writes (RFOs) miss the=
 L3 and the data is returned from local dram",
+        "BriefDescription": "Counts all demand data writes (RFOs)miss the =
L3 and the data is returned from local dram",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
         "EventName": "OFFCORE_RESPONSE.DEMAND_RFO.L3_MISS.LOCAL_DRAM",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x0100400002",
+        "MSRValue": "0x100400002",
         "Offcore": "1",
-        "PublicDescription": "Counts all demand data writes (RFOs) miss th=
e L3 and the data is returned from local dram",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code reads miss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) code readsmiss in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -428,12 +413,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00040",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) code reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to L2) data =
reads miss in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to L2) data =
readsmiss in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -441,12 +425,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00010",
         "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to L2) data=
 reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOs miss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to L2) R=
FOsmiss in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -454,12 +437,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00020",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to L2) =
RFOs miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code reads miss in the L3",
+        "BriefDescription": "Counts prefetch (that bring data to LLC only)=
 code readsmiss in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -467,12 +449,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00200",
         "Offcore": "1",
-        "PublicDescription": "Counts prefetch (that bring data to LLC only=
) code reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data reads miss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) data readsmiss in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -480,12 +461,11 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00080",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) data reads miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOs miss in the L3",
+        "BriefDescription": "Counts all prefetch (that bring data to LLC o=
nly) RFOsmiss in the L3",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
         "EventCode": "0xB7, 0xBB",
@@ -493,7 +473,6 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x3FFFC00100",
         "Offcore": "1",
-        "PublicDescription": "Counts all prefetch (that bring data to LLC =
only) RFOs miss in the L3",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -681,4 +660,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/other.json b/tools/perf=
/pmu-events/arch/x86/haswell/other.json
index 4c6b9d34325a..7ca34f09b185 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/other.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/other.json
@@ -40,4 +40,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/haswell/pipeline.json
index a53f28ec9270..42f6a8100661 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
@@ -1035,7 +1035,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -1056,7 +1055,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 1.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -1117,7 +1115,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 4.",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -1138,7 +1135,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 5.",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
@@ -1159,7 +1155,6 @@
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "EventCode": "0xA1",
         "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted in p=
ort 6.",
         "SampleAfterValue": "2000003",
         "UMask": "0x40"
     },
@@ -1295,11 +1290,11 @@
         "BriefDescription": "Cycles with less than 10 actually retired uop=
s.",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3",
-        "CounterMask": "10",
+        "CounterMask": "16",
         "EventCode": "0xC2",
         "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
         "Invert": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/haswell/uncore-other.json
index 8f2ae2891042..56c4b380dc95 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/uncore-other.json
@@ -19,11 +19,11 @@
         "Unit": "ARB"
     },
     {
-        "BriefDescription": "Each cycle count number of all Core outgoing =
valid entries. Such entry is defined as valid from it's allocation till fir=
st of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-cohe=
rent traffic.",
+        "BriefDescription": "Each cycle counts number of all Core outgoing=
 valid entries. Such entry is defined as valid from its allocation till fir=
st of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-cohe=
rent traffic.",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Each cycle count number of all Core outgoing=
 valid entries. Such entry is defined as valid from it's allocation till fi=
rst of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coh=
erent traffic.",
+        "PublicDescription": "Each cycle counts number of all Core outgoin=
g valid entries. Such entry is defined as valid from its allocation till fi=
rst of IDI0 or DRS0 messages is sent out. Accounts for Coherent and non-coh=
erent traffic.",
         "UMask": "0x01",
         "Unit": "ARB"
     },
@@ -34,6 +34,7 @@
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.CYCLES_WITH_ANY_REQUEST",
         "PerPkg": "1",
+        "PublicDescription": "Cycles with at least one request outstanding=
 is waiting for data return from memory controller. Account for coherent an=
d non-coherent requests initiated by IA Cores, Processor Graphics Unit, or =
LLC.\n",
         "UMask": "0x01",
         "Unit": "ARB"
     },
@@ -64,6 +65,6 @@
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
         "PublicDescription": "This 48-bit fixed counter counts the UCLK cy=
cles.",
-        "Unit": "NCU"
+        "Unit": "CLOCK"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json b/t=
ools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
index ba3e77a9f9a0..57d2a6452fec 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
@@ -481,4 +481,4 @@
         "SampleAfterValue": "100003",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index a2991906b51c..66d54c879a3e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -8,9 +8,7 @@ GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
 GenuineIntel-6-96,v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-3C,v24,haswell,core
-GenuineIntel-6-45,v24,haswell,core
-GenuineIntel-6-46,v24,haswell,core
+GenuineIntel-6-(3C|45|46),v31,haswell,core
 GenuineIntel-6-3F,v17,haswellx,core
 GenuineIntel-6-3A,v18,ivybridge,core
 GenuineIntel-6-3E,v19,ivytown,core
--=20
2.37.1.359.gd136c6c3e2-goog

