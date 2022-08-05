Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6C58A489
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbiHEBjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiHEBjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:39:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8480B71BFD
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:39:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f46b4759bso11068977b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 18:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=dGOcqc2WIfaiBXb536VI0Rx7fwEtR3PoXTHtRaHn/Bs=;
        b=E7AKVS97zUvLb0JHIxmVJ0EJjG5a3eo/vkC+Q2/swrHqsVDcQNNTuL3s/WlCyTcdIQ
         qgPtgZYJws5VbqYGpxUJRHeEr3uMgzgCfp2ZBR3TTc0HUluWF9s2iRuI8D4C7swS+548
         z+3ZtCRNLyhlEuh5owsANJ2xCxza3xuWdQehuk8Y9mMce2z+qR4emL5x8i5cZuCISMPW
         yjGYfoSJxhn7MNKTFSflJHylBLM0m7rNUiyaIUDZYyLE82Y5LEtGo813DLYkdNncbG7n
         qFskrDdgX05XvWC1Um3B4lqqw314N9PhovIsMLDR6L2y3crkRlu5Ax8I66ci/o0Od13k
         Yu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=dGOcqc2WIfaiBXb536VI0Rx7fwEtR3PoXTHtRaHn/Bs=;
        b=enIgGphMwXFuzOHeqUPCmwfc22H+e3f+MDHXDT33YjeiExrjTIxlB2hsEf0yalcJeK
         CcP/I/hx80F9Xl8afMEusMlCFd7wbahUUiol5D5HEY30zKW/21N0KwgU1MJLwjHrVnW3
         wCfVC+1iOk8mo8fLFJSzJcgcNdpt2Woc0BDQGUXmVNSA6s/z8hi3PlZPRmFbmYuzTUS2
         YYK9NQk1dSRoxcJia2eG5pLaQW/zHc/HezRABO6DWAPONCyM9TXK9PZE0f9qwkLwUGF9
         4GXv/QyZv/UFnNeREXcylSVtJUJEI+PiSxUe+0Xy6vxSxtNIHK6djgmy/nzR3DBPN7Rx
         q0zQ==
X-Gm-Message-State: ACgBeo3mB9/d9b5FxplZJoI8WM4p8Pbf9SYacPXKm+VGRRzWsBKY3hn/
        6QTR/aVG2dGJUlEjgTicmnkv/+5rvxYl
X-Google-Smtp-Source: AA6agR6QOtcubIMn/NjbLIZCx9vP4S2tofMovdgucOvV/0lyL5m9FVBGeIHd78sZe6mDsbh/FEBZk5NLd715
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a81:578b:0:b0:324:82ff:12c1 with SMTP id
 l133-20020a81578b000000b0032482ff12c1mr3878783ywb.174.1659663553842; Thu, 04
 Aug 2022 18:39:13 -0700 (PDT)
Date:   Thu,  4 Aug 2022 18:38:56 -0700
In-Reply-To: <20220805013856.1842878-1-irogers@google.com>
Message-Id: <20220805013856.1842878-4-irogers@google.com>
Mime-Version: 1.0
References: <20220805013856.1842878-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 3/3] perf vendor events: Remove bad jaketown uncore events
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

The event converter scripts at:
https://github.com/intel/event-converter-for-linux-perf
passes Filter values from data on 01.org that is bogus in a perf command
line and can cause perf to infinitely recurse in parse events. Remove
such events or filters using the updated patch:
https://github.com/intel/event-converter-for-linux-perf/pull/15/commits/afd=
779df99ee41aac646eae1ae5ae651cda3394d

Fixes: 376d8b581b76 ("perf vendor events: Update Intel jaketown")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/jaketown/uncore-cache.json       | 30 -------------------
 .../arch/x86/jaketown/uncore-other.json       | 13 --------
 .../arch/x86/jaketown/uncore-power.json       | 11 -------
 3 files changed, 54 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
index cf28ffa778ba..351f8b040ed1 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
@@ -20,7 +20,6 @@
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
-        "Filter": "CBoFilter[22:18]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
         "UMask": "0x3",
@@ -31,7 +30,6 @@
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.NID",
-        "Filter": "CBoFilter[22:18], CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
         "UMask": "0x41",
@@ -42,7 +40,6 @@
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
-        "Filter": "CBoFilter[22:18]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
         "UMask": "0x9",
@@ -53,7 +50,6 @@
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.WRITE",
-        "Filter": "CBoFilter[22:18]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
         "UMask": "0x5",
@@ -94,7 +90,6 @@
         "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.NID",
-        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
         "UMask": "0x40",
@@ -613,7 +608,6 @@
         "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "CBoFilter[31:23]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x3",
@@ -624,7 +618,6 @@
         "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
-        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x48",
@@ -635,7 +628,6 @@
         "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
-        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x44",
@@ -646,7 +638,6 @@
         "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
-        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x4a",
@@ -657,7 +648,6 @@
         "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
-        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x43",
@@ -668,7 +658,6 @@
         "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
-        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x41",
@@ -679,7 +668,6 @@
         "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
-        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x50",
@@ -690,7 +678,6 @@
         "Counter": "0,1",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "CBoFilter[31:23]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
         "UMask": "0x1",
@@ -737,7 +724,6 @@
         "BriefDescription": "TOR Occupancy; Miss Opcode Match",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE",
-        "Filter": "CBoFilter[31:23]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x3",
@@ -747,7 +733,6 @@
         "BriefDescription": "TOR Occupancy; NID Matched",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_ALL",
-        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x48",
@@ -757,7 +742,6 @@
         "BriefDescription": "TOR Occupancy; NID Matched Evictions",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_EVICTION",
-        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x44",
@@ -767,7 +751,6 @@
         "BriefDescription": "TOR Occupancy; NID Matched",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
-        "Filter": "CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x4a",
@@ -777,7 +760,6 @@
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE",
-        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x43",
@@ -787,7 +769,6 @@
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_OPCODE",
-        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x41",
@@ -797,7 +778,6 @@
         "BriefDescription": "TOR Occupancy; Opcode Match",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.OPCODE",
-        "Filter": "CBoFilter[31:23]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
         "UMask": "0x1",
@@ -893,16 +873,6 @@
         "UMask": "0x4",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "QPI Address/Opcode Match; Address & Opcode Ma=
tch",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x20",
-        "EventName": "UNC_H_ADDR_OPC_MATCH.FILT",
-        "Filter": "HA_AddrMatch0[31:6], HA_AddrMatch1[13:0], HA_OpcodeMatc=
h[5:0]",
-        "PerPkg": "1",
-        "UMask": "0x3",
-        "Unit": "HA"
-    },
     {
         "BriefDescription": "HA to iMC Bypass; Not Taken",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-other.json
index 99fc673c59e9..588549a668bd 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-other.json
@@ -247,17 +247,6 @@
         "UMask": "0x2",
         "Unit": "IRP"
     },
-    {
-        "BriefDescription": "Inbound Transaction Count; Select Source",
-        "Counter": "0,1",
-        "EventCode": "0x15",
-        "EventName": "UNC_I_TRANSACTIONS.ORDERINGQ",
-        "Filter": "IRPFilter[4:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of 'Inbound' transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
     {
         "BriefDescription": "Inbound Transaction Count; Read Prefetches",
         "Counter": "0,1",
@@ -1378,7 +1367,6 @@
         "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.ENABLE",
-        "Filter": "UBoxFilter[3:0]",
         "PerPkg": "1",
         "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
         "UMask": "0x1",
@@ -1399,7 +1387,6 @@
         "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
-        "Filter": "UBoxFilter[3:0]",
         "PerPkg": "1",
         "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
         "UMask": "0x4",
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index 04228344cb9c..817ea6d7f785 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -92,7 +92,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_P_DEMOTIONS_CORE0",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -102,7 +101,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1f",
         "EventName": "UNC_P_DEMOTIONS_CORE1",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -121,7 +119,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_P_DEMOTIONS_CORE3",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -131,7 +128,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_P_DEMOTIONS_CORE4",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -141,7 +137,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_P_DEMOTIONS_CORE5",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -151,7 +146,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_P_DEMOTIONS_CORE6",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -161,7 +155,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_P_DEMOTIONS_CORE7",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -171,7 +164,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xb",
         "EventName": "UNC_P_FREQ_BAND0_CYCLES",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
         "Unit": "PCU"
@@ -181,7 +173,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xc",
         "EventName": "UNC_P_FREQ_BAND1_CYCLES",
-        "Filter": "PCUFilter[15:8]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
         "Unit": "PCU"
@@ -191,7 +182,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xd",
         "EventName": "UNC_P_FREQ_BAND2_CYCLES",
-        "Filter": "PCUFilter[23:16]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
         "Unit": "PCU"
@@ -201,7 +191,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe",
         "EventName": "UNC_P_FREQ_BAND3_CYCLES",
-        "Filter": "PCUFilter[31:24]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
         "Unit": "PCU"
--=20
2.37.1.559.g78731f0fdb-goog

