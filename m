Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E95158A488
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiHEBjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiHEBjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:39:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A3A70E63
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 18:39:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f4b76446aso10716217b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 18:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=/Bw7xZEntmnC5F5AQwb6gB76J0eDUDoFI97WBfdwsd0=;
        b=JqSvbW2L9VN59B//8ldDG4p30bqYawHJEHZfZvn3ZYPTuftR3jZVECPGxxm+7iWU8l
         EabOU+1VIaeg/zDflV6TAJOrx7STTTYoe9qoQslHjRWGX6btbc7lB0lGBRK23nIXPufx
         Ex9101ayf+83pngd5FNEW9FCkY3tFgVoyiMHyAdkDvWVaNa6tphf+9/mZAp2Kr1lFeu1
         WqJpoSs6WVVPHF3KoaEQUDAXYTp8053/0w0yra7eFCaTqsglyhKQ+KwrNuU5+RO7c0L/
         c2UVWIU28rf/5ukBdxvJoyvjehmpcHS9NS+sz92KCe1aIc//08ZgIIA1eRKT/A7AAVMh
         NWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=/Bw7xZEntmnC5F5AQwb6gB76J0eDUDoFI97WBfdwsd0=;
        b=ZcwhqC9+zXoDzmvGGHqXMESjumI76kfONcl8xaVQI/coA7TRJ+I+hYJUT7ZzpYf59F
         /FW7kOzVbDCALXbMImhfN/ZGXVOW1mQR/sbOC1prC+nPs5XIPUtavSW1i4cinpxyNyxP
         YBQ+1KKJYQejCBCpc1zRvgOnRCRcg6bMnJ0NgHbORbKagRwHvaRvs5UVYUI8RL/Hrigr
         XkwaPGHCPD6+m39wubTtoO8W7BjTWh/i5MotM7bpKoq2NAiyvFeeA+9zMMO8sSqm+4FT
         NoPr0EFdbmOYFRSeR2Jc/RmCXxIZvqKnmZzpDarHd+mQSJdP4lq+FjCcCz9mWueW4EKU
         mcug==
X-Gm-Message-State: ACgBeo10Joz65TgVCxKfxYVreQBa14hsMZ4/ros+JiCkNQw98aBwtYT1
        62tdcablZQFjJIdk5knzLhKESWl09C+l
X-Google-Smtp-Source: AA6agR4wGJzOxjmuij9cDmq86yyijISi6wJ95RyLSphOcXPSI6nIvIqTVhyoI+1ufpGeAdvMh8wsVG2WSIJE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a0d:dbd2:0:b0:31f:44c5:b162 with SMTP id
 d201-20020a0ddbd2000000b0031f44c5b162mr4146590ywe.118.1659663551055; Thu, 04
 Aug 2022 18:39:11 -0700 (PDT)
Date:   Thu,  4 Aug 2022 18:38:55 -0700
In-Reply-To: <20220805013856.1842878-1-irogers@google.com>
Message-Id: <20220805013856.1842878-3-irogers@google.com>
Mime-Version: 1.0
References: <20220805013856.1842878-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v3 2/3] perf vendor events: Remove bad ivytown uncore events
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

Fixes: 6220136831e3 ("perf vendor events: Update Intel ivytown")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/ivytown/uncore-cache.json        | 90 -------------------
 .../arch/x86/ivytown/uncore-interconnect.json |  1 -
 .../arch/x86/ivytown/uncore-other.json        | 13 ---
 .../arch/x86/ivytown/uncore-power.json        | 19 ----
 4 files changed, 123 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
index 1e53bee8af5c..93e07385eeec 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
@@ -20,7 +20,6 @@
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.ANY",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Filters for any transaction o=
riginating from the IPQ or IRQ.  This does not include lookups originating =
from the ISMQ.",
         "UMask": "0x11",
@@ -31,7 +30,6 @@
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Read transactions",
         "UMask": "0x3",
@@ -42,7 +40,6 @@
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.NID",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Qualify one of the other sube=
vents by the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.n=
id.   In conjunction with STATE =3D I, it is possible to monitor misses to =
specific NIDs in the system.",
         "UMask": "0x41",
@@ -53,7 +50,6 @@
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Filters for only snoop reques=
ts coming from the remote socket(s) through the IPQ.",
         "UMask": "0x9",
@@ -64,7 +60,6 @@
         "Counter": "0,1",
         "EventCode": "0x34",
         "EventName": "UNC_C_LLC_LOOKUP.WRITE",
-        "Filter": "CBoFilter0[23:17]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Writeback transactions from L=
2 to the LLC  This includes all write transactions -- both Cachable and UC.=
",
         "UMask": "0x5",
@@ -105,7 +100,6 @@
         "Counter": "0,1",
         "EventCode": "0x37",
         "EventName": "UNC_C_LLC_VICTIMS.NID",
-        "Filter": "CBoFilter1[15:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.; Qu=
alify one of the other subevents by the Target NID.  The NID is programmed =
in Cn_MSR_PMON_BOX_FILTER.nid.   In conjunction with STATE =3D I, it is pos=
sible to monitor misses to specific NIDs in the system.",
         "UMask": "0x40",
@@ -1034,7 +1028,6 @@
         "Counter": "0,1",
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
@@ -1055,7 +1048,6 @@
         "Counter": "0,1",
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
@@ -1066,7 +1058,6 @@
         "Counter": "0,1",
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
@@ -1087,7 +1078,6 @@
         "Counter": "0,1",
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
@@ -1098,7 +1088,6 @@
         "Counter": "0,1",
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
@@ -1109,7 +1098,6 @@
         "Counter": "0,1",
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
@@ -1120,7 +1108,6 @@
         "Counter": "0,1",
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
@@ -1131,7 +1118,6 @@
         "Counter": "0,1",
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
@@ -1142,7 +1128,6 @@
         "Counter": "0,1",
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
@@ -1153,7 +1138,6 @@
         "Counter": "0,1",
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
@@ -1164,7 +1148,6 @@
         "Counter": "0,1",
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
@@ -1185,7 +1168,6 @@
         "Counter": "0,1",
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
@@ -1232,7 +1214,6 @@
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
@@ -1260,7 +1241,6 @@
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
@@ -1270,7 +1250,6 @@
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
@@ -1289,7 +1268,6 @@
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
@@ -1299,7 +1277,6 @@
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
@@ -1309,7 +1286,6 @@
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
@@ -1319,7 +1295,6 @@
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
@@ -1329,7 +1304,6 @@
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
@@ -1339,7 +1313,6 @@
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
@@ -1349,7 +1322,6 @@
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
@@ -1359,7 +1331,6 @@
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
@@ -1378,7 +1349,6 @@
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
@@ -1520,66 +1490,6 @@
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
         "BriefDescription": "BT Bypass",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.jso=
n b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
index b50685fbde12..b3b1a08d4acf 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
@@ -14,7 +14,6 @@
         "EventCode": "0x38",
         "EventName": "UNC_Q_CTO_COUNT",
         "ExtSel": "1",
-        "Filter": "QPIMask0[17:0],QPIMatch0[17:0],QPIMask1[19:16],QPIMatch=
1[19:16]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of CTO (cluster trigger ou=
ts) events that were asserted across the two slots.  If both slots trigger =
in a given cycle, the event will increment by 2.  You can use edge detect t=
o count the number of cases when both events triggered.",
         "Unit": "QPI LL"
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-other.json
index aa7a5059d79f..af289aa6c98e 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
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
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only those requests t=
hat come from the port specified in the IRP_PmonFilter.OrderingQ register. =
 This register allows one to select one specific queue.  It is not possible=
 to monitor multiple queues at a time.  If this bit is not set, then reques=
ts from all sources will be counted.",
-        "UMask": "0x8",
-        "Unit": "IRP"
-    },
     {
         "BriefDescription": "Inbound Transaction Count: Read Prefetches",
         "Counter": "0,1",
@@ -2274,7 +2263,6 @@
         "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.ENABLE",
-        "Filter": "UBoxFilter[3:0]",
         "PerPkg": "1",
         "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
         "UMask": "0x1",
@@ -2295,7 +2283,6 @@
         "Counter": "0,1",
         "EventCode": "0x41",
         "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
-        "Filter": "UBoxFilter[3:0]",
         "PerPkg": "1",
         "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
         "UMask": "0x4",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index 304d861c368f..0ba63a97ddfa 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -297,7 +297,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1e",
         "EventName": "UNC_P_DEMOTIONS_CORE0",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -307,7 +306,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1f",
         "EventName": "UNC_P_DEMOTIONS_CORE1",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -317,7 +315,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_P_DEMOTIONS_CORE10",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -327,7 +324,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "UNC_P_DEMOTIONS_CORE11",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -337,7 +333,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "UNC_P_DEMOTIONS_CORE12",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -347,7 +342,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x45",
         "EventName": "UNC_P_DEMOTIONS_CORE13",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -357,7 +351,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x46",
         "EventName": "UNC_P_DEMOTIONS_CORE14",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -367,7 +360,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "UNC_P_DEMOTIONS_CORE2",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -377,7 +369,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "UNC_P_DEMOTIONS_CORE3",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -387,7 +378,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_P_DEMOTIONS_CORE4",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -397,7 +387,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x23",
         "EventName": "UNC_P_DEMOTIONS_CORE5",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -407,7 +396,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_P_DEMOTIONS_CORE6",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -417,7 +405,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_P_DEMOTIONS_CORE7",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -427,7 +414,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_P_DEMOTIONS_CORE8",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -437,7 +423,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_P_DEMOTIONS_CORE9",
-        "Filter": "PCUFilter[7:0]",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
@@ -447,7 +432,6 @@
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
@@ -457,7 +441,6 @@
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
@@ -467,7 +450,6 @@
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
@@ -477,7 +459,6 @@
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

