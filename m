Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538E258A486
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbiHEBjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiHEBjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:39:11 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE41371BF3
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:39:08 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id t9-20020a056a00138900b0052dc8a1b97dso526239pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 18:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=pfm95azuBdr2ny/LB4mhRD8oHtnvYc5LnmHdg1daaNY=;
        b=qh4Sb5DHlYflFI3gydpelNENz9eje8EKDKs+TeBF5hZL/UNPHhwctNEx3Dix5UZhG7
         OQyxmyYEzUElG9dCh+ojXD/7d4q8/RRG5TpAfaZ40peYx2R/qTZOO0imHIasisOA6T2N
         wHSAZGCe/qYA2zBrYS+++ZVF1521j9bwmwNgbIQwIZR2LEV8tclBMN7G+JCbmj0WMaJ7
         +C8IsWCC3LCQt1FofhUxbgo0Fx3m9HnEsVd31MX5c1WA5NoBDKcDQqFqT44K0XXXVlFq
         ZTAX3jjILlFHyavi5iBapCRqJdd8VL73c1Rl2f6ClXlyVzNxisKQhh+fnCeuNJppC8HZ
         ue7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=pfm95azuBdr2ny/LB4mhRD8oHtnvYc5LnmHdg1daaNY=;
        b=Hb/70XfSgAXk4hvPjEvoxE6kLXEM7u3l4rt7wY6mICwn17b75tU/YnnN4UpWrGfW8s
         Ii537Q4UHGO8CNZFcVrn5WzTX3fgcSZX1k6roE6SGzn4YPAtmOYbefjbsRFqJ3DKsnFO
         EllGxd+EzK1lXw8GTAOszzj4QTGcow7csBUxAJCxKoqV0QckkoEIFOKqDxsndFnl2Cg6
         BpAy0r9hLMkZK7/XCXkjXveVlfXN9pX/Y4G1/2GFIL7REWq25chtWdIpj6dca6trZ5ii
         QV3HVxeGz9/7sDdUlvuRjG/TxuaAn7WNh7CFp6u1qE0ACpsXMZXSapA8aGaJ0jemANC/
         I+NQ==
X-Gm-Message-State: ACgBeo2G5WjGIftUEGhMQ4B/izwZCgtcHgTNuWjmDE7GTr2FFXWTPbFS
        v/ULSDCCXhv1MSlaaQVGcXQEDK1snIRy
X-Google-Smtp-Source: AA6agR4PPZk8JHhZyUfUzp37w9ZQiLqyOV+xBLbWcfxVe0XfqaWGGRSRi9N+EeGOYg9jCB6S+GJ+XqBOkQ0F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2401:b0:52b:cd67:d997 with SMTP
 id z1-20020a056a00240100b0052bcd67d997mr4396207pfh.70.1659663548220; Thu, 04
 Aug 2022 18:39:08 -0700 (PDT)
Date:   Thu,  4 Aug 2022 18:38:54 -0700
In-Reply-To: <20220805013856.1842878-1-irogers@google.com>
Message-Id: <20220805013856.1842878-2-irogers@google.com>
Mime-Version: 1.0
References: <20220805013856.1842878-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 1/3] perf vendor events: Remove bad broadwellde uncore events
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

Fixes: ef908a192512 ("perf vendor events: Update Intel broadwellde")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellde/uncore-cache.json    | 97 -------------------
 .../arch/x86/broadwellde/uncore-other.json    | 13 ---
 2 files changed, 110 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index caadbca1b15b..c4d154944ab6 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -37,7 +37,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for any transaction originati=
ng from the IPQ or IRQ.  This does not include lookups originating from the=
 ISMQ.",
         "UMask": "0x11",
@@ -48,7 +47,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
         "UMask": "0x3",
@@ -59,7 +57,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.NID",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Qualify one of the other subevents by=
 the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.nid.   In=
 conjunction with STATE =3D I, it is possible to monitor misses to specific=
 NIDs in the system.",
         "UMask": "0x41",
@@ -70,7 +67,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.READ",
-        "Filter": "CBoFilter0[22:18]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
         "UMask": "0x21",
@@ -81,7 +77,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for only snoop requests comin=
g from the remote socket(s) through the IPQ.",
         "UMask": "0x9",
@@ -92,7 +87,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.WRITE",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Writeback transactions from L2 to the=
 LLC  This includes all write transactions -- both Cachable and UC.",
         "UMask": "0x5",
@@ -153,7 +147,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.NID",
-        "Filter": "CBoFilter1[17:10]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.; Qu=
alify one of the other subevents by the Target NID.  The NID is programmed =
in Cn_MSR_PMON_BOX_FILTER.nid.   In conjunction with STATE =3D I, it is pos=
sible to monitor misses to specific NIDs in the system.",
         "UMask": "0x40",
@@ -794,7 +787,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "UNC_C_RxR_IPQ_RETRY2.TARGET",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request from the IPQ was retried filtered by th=
e Target NodeID as specified in the Cbox's Filter register.",
         "UMask": "0x40",
@@ -845,7 +837,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_C_RxR_IRQ_RETRY.NID",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Qualify one of the other subevents by a give=
n RTID destination NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER1.n=
id.",
         "UMask": "0x40",
@@ -896,7 +887,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x29",
         "EventName": "UNC_C_RxR_IRQ_RETRY2.TARGET",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried filtered by the Target NodeID as specified in the Cb=
ox's Filter register.",
         "UMask": "0x40",
@@ -937,7 +927,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.NID",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
         "UMask": "0x40",
@@ -968,7 +957,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_C_RxR_ISMQ_RETRY.WB_CREDITS",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
         "UMask": "0x80",
@@ -999,7 +987,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2A",
         "EventName": "UNC_C_RxR_ISMQ_RETRY2.TARGET",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried filtered by the Target NodeID as specified in the C=
box's Filter register.",
         "UMask": "0x40",
@@ -1114,7 +1101,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by locally HOMed=
 memory.",
         "UMask": "0x21",
@@ -1135,7 +1121,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode, inserted into the TOR that are satisifed by locally HOMed=
 memory.",
         "UMask": "0x23",
@@ -1146,7 +1131,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
         "UMask": "0x3",
@@ -1167,7 +1151,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
         "UMask": "0x83",
@@ -1178,7 +1161,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches =
an RTID destination) transactions inserted into the TOR.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it is=
 possible to monitor misses to specific NIDs in the system.",
         "UMask": "0x48",
@@ -1189,7 +1171,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tran=
sactions inserted into the TOR.",
         "UMask": "0x44",
@@ -1200,7 +1181,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss requ=
ests that were inserted into the TOR.",
         "UMask": "0x4A",
@@ -1211,7 +1191,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
-        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match a NID and an opcode.",
         "UMask": "0x43",
@@ -1222,7 +1201,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
-        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match a NID and an opcode.",
         "UMask": "0x41",
@@ -1233,7 +1211,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.NID_WB",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transac=
tions inserted into the TOR.",
         "UMask": "0x50",
@@ -1244,7 +1221,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
         "UMask": "0x1",
@@ -1265,7 +1241,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by remote caches=
 or remote memory.",
         "UMask": "0x81",
@@ -1312,7 +1287,6 @@
         "BriefDescription": "TOR Occupancy; Local Memory - Opcode Matched"=
,
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by locally HOMed memory.",
         "UMask": "0x21",
@@ -1340,7 +1314,6 @@
         "BriefDescription": "TOR Occupancy; Misses to Local Memory - Opcod=
e Matched",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by locally HOMed memory.",
         "UMask": "0x23",
@@ -1350,7 +1323,6 @@
         "BriefDescription": "TOR Occupancy; Miss Opcode Match",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
for miss transactions that match an opcode. This generally means that the r=
equest was sent to memory or MMIO.",
         "UMask": "0x3",
@@ -1369,7 +1341,6 @@
         "BriefDescription": "TOR Occupancy; Misses to Remote Memory - Opco=
de Matched",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by remote caches or remote memory.",
         "UMask": "0x83",
@@ -1379,7 +1350,6 @@
         "BriefDescription": "TOR Occupancy; NID Matched",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_ALL",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of NI=
D matched outstanding requests in the TOR.  The NID is programmed in Cn_MSR=
_PMON_BOX_FILTER.nid.In conjunction with STATE =3D I, it is possible to mon=
itor misses to specific NIDs in the system.",
         "UMask": "0x48",
@@ -1389,7 +1359,6 @@
         "BriefDescription": "TOR Occupancy; NID Matched Evictions",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_EVICTION",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding NID matched eviction transactions in the TOR .",
         "UMask": "0x44",
@@ -1399,7 +1368,6 @@
         "BriefDescription": "TOR Occupancy; NID Matched",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID.",
         "UMask": "0x4A",
@@ -1409,7 +1377,6 @@
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE",
-        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID and an opcode.",
         "UMask": "0x43",
@@ -1419,7 +1386,6 @@
         "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_OPCODE",
-        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match a NID and an opcode.",
         "UMask": "0x41",
@@ -1429,7 +1395,6 @@
         "BriefDescription": "TOR Occupancy; NID Matched Writebacks",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.NID_WB",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); NID matched =
write transactions int the TOR.",
         "UMask": "0x50",
@@ -1439,7 +1404,6 @@
         "BriefDescription": "TOR Occupancy; Opcode Match",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc).",
         "UMask": "0x1",
@@ -1458,7 +1422,6 @@
         "BriefDescription": "TOR Occupancy; Remote Memory - Opcode Matched=
",
         "EventCode": "0x36",
         "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
         "PerPkg": "1",
         "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by remote caches or remote memory.",
         "UMask": "0x81",
@@ -1610,66 +1573,6 @@
         "UMask": "0x8",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "QPI Address/Opcode Match; AD Opcodes",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x20",
-        "EventName": "UNC_H_ADDR_OPC_MATCH.AD",
-        "Filter": "HA_OpcodeMatch[5:0]",
-        "PerPkg": "1",
-        "UMask": "0x4",
-        "Unit": "HA"
-    },
-    {
-        "BriefDescription": "QPI Address/Opcode Match; Address",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x20",
-        "EventName": "UNC_H_ADDR_OPC_MATCH.ADDR",
-        "Filter": "HA_AddrMatch0[31:6], HA_AddrMatch1[13:0]",
-        "PerPkg": "1",
-        "UMask": "0x1",
-        "Unit": "HA"
-    },
-    {
-        "BriefDescription": "QPI Address/Opcode Match; AK Opcodes",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x20",
-        "EventName": "UNC_H_ADDR_OPC_MATCH.AK",
-        "Filter": "HA_OpcodeMatch[5:0]",
-        "PerPkg": "1",
-        "UMask": "0x10",
-        "Unit": "HA"
-    },
-    {
-        "BriefDescription": "QPI Address/Opcode Match; BL Opcodes",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x20",
-        "EventName": "UNC_H_ADDR_OPC_MATCH.BL",
-        "Filter": "HA_OpcodeMatch[5:0]",
-        "PerPkg": "1",
-        "UMask": "0x8",
-        "Unit": "HA"
-    },
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
-    {
-        "BriefDescription": "QPI Address/Opcode Match; Opcode",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x20",
-        "EventName": "UNC_H_ADDR_OPC_MATCH.OPC",
-        "Filter": "HA_OpcodeMatch[5:0]",
-        "PerPkg": "1",
-        "UMask": "0x2",
-        "Unit": "HA"
-    },
     {
         "BriefDescription": "BT Cycles Not Empty",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
index 71bdf75d8016..fc7e0867fcc5 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
@@ -416,17 +416,6 @@
         "UMask": "0x10",
         "Unit": "IRP"
     },
-    {
-        "BriefDescription": "Inbound Transaction Count; Select Source",
-        "Counter": "0,1",
-        "EventCode": "0x16",
-        "EventName": "UNC_I_TRANSACTIONS.ORDERINGQ",
-        "Filter": "IRPFilter[4:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only those requests t=
hat come from the port specified in the IRP_PmonFilter.OrderingQ register. =
 This register allows one to select one specific queue.  It is not possible=
 to monitor multiple queues at a time.  If this bit is not set, then reques=
ts from all sources will be counted.",
-        "UMask": "0x40",
-        "Unit": "IRP"
-    },
     {
         "BriefDescription": "Inbound Transaction Count; Other",
         "Counter": "0,1",
@@ -1117,7 +1106,6 @@
         "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.ENABLE",
-        "Filter": "UBoxFilter[3:0]",
         "PerPkg": "1",
         "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
         "UMask": "0x1",
@@ -1138,7 +1126,6 @@
         "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
-        "Filter": "UBoxFilter[3:0]",
         "PerPkg": "1",
         "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
         "UMask": "0x4",
--=20
2.37.1.559.g78731f0fdb-goog

