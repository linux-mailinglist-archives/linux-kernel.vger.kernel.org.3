Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61B58877F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbiHCGj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiHCGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:39:16 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A4158B41
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:39:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3238ce833beso120954267b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=HM9Y6luXfwFUerrjmKCpgde4C7lpk431K7Onz1rc2oY=;
        b=FngfkXs3v9+te22GzlBewc3EAEpfIPRkBuSdUfLsd2/vWVQKJsvQWvoLXrFmmgURQk
         c/oXObBg80p8zg7bK3C1e2sNpq8bdOk3CMAtZiM9MOabrOaKQkfUZ6hLg1PX+EiA4bg3
         Q6rt9aZ4nKkSSCIi18uU+HWKt3w3KHYJlyPZwrxAJr1J+n/xbIeorNQqvvloq/YiVjAN
         Vk/HoBtvRAU5NXU+9e+rv+1U1wUmnFTcwXlKHZ4zt/VNjxTGUvOM4eGg/8vFiqUIy1Gz
         BigK6tz5tTlQdCvuSS7Y6mKmyuEeUPwqqhiFbH8vJ+nEf/s9pa62iJVxqOMp4vtCrOj1
         zaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=HM9Y6luXfwFUerrjmKCpgde4C7lpk431K7Onz1rc2oY=;
        b=pycGjBuSJm7EwwJkm73fR45UulzEtWo1Z+QX84ZLNqYbhlQqr3B3UGXdxd0LNxR3Bx
         ljRqpiS/L2ISSxcHuOV9lKvQMeN3TzOtilWZdnpNnwZqFXkocL8eA6s2cOgRzjMDN5es
         5XH9ArY4+Y/sU7VnQNSMCNPmT3iyFETF/0EaviiaQ6z/HKcLasptn8kIZs2j3bCfTN2j
         ls8xBZt+yh772CCHgTjatWd6pDYHBOS5IFIuCVZiwJttFoBXCwFfr7cf+YoHriCte5Qp
         h/PYhZGyK9yNYIIt2s+FTDWqGH2PG44vTWm3DITLMqtP8+uHM9oK4isXil/g0SKyhSb+
         WTIg==
X-Gm-Message-State: ACgBeo34K3EgSFzxig16YRIgGMUYBS7RTtMBegQxWJ16FlpT7wNtQ3G/
        7dLtLzatB08oEdzHHiBDfo2vBM3V4Pax
X-Google-Smtp-Source: AA6agR4S6J6boB/bA7+yBQ2oUdMc3iWTQ0IoSdsmZ/89rGg8Zb1ke2xZ7PZBaOCqk+AEUSq3AT/7tqmgc/Sl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:dbef:ce2b:2472:e20f])
 (user=irogers job=sendgmr) by 2002:a81:50d4:0:b0:31f:5f85:566a with SMTP id
 e203-20020a8150d4000000b0031f5f85566amr22414341ywb.218.1659508752830; Tue, 02
 Aug 2022 23:39:12 -0700 (PDT)
Date:   Tue,  2 Aug 2022 23:38:19 -0700
In-Reply-To: <20220803063820.1345011-1-irogers@google.com>
Message-Id: <20220803063820.1345011-2-irogers@google.com>
Mime-Version: 1.0
References: <20220803063820.1345011-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v1 2/3] perf vendor events: Remove bad ivytown uncore events
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
such events using the updated patch:
https://github.com/intel/event-converter-for-linux-perf/pull/15/commits/485=
e42418d4f520a641994a1b041c149bb34f4a6

Fixes: 6220136831e3 ("perf vendor events: Update Intel ivytown")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/ivytown/uncore-cache.json        | 378 ------------------
 .../arch/x86/ivytown/uncore-interconnect.json |  11 -
 .../arch/x86/ivytown/uncore-other.json        |  35 +-
 .../arch/x86/ivytown/uncore-power.json        | 190 ---------
 4 files changed, 1 insertion(+), 613 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
index 1e53bee8af5c..85bc9c76c0cc 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
@@ -15,61 +15,6 @@
         "PublicDescription": "Since occupancy counts can only be captured =
in the Cbo's 0 counter, this event allows a user to capture occupancy relat=
ed information by filtering the Cb0 occupancy count captured in Counter 0. =
  The filtering available is found in the control register - threshold, inv=
ert and edge detect.   E.g. setting threshold to 1 can effectively monitor =
how many cycles the monitored queue has an entry.",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Cache Lookups; Any Request",
-        "Counter": "0,1",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.ANY",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Filters for any transaction o=
riginating from the IPQ or IRQ.  This does not include lookups originating =
from the ISMQ.",
-        "UMask": "0x11",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; Data Read Request",
-        "Counter": "0,1",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Read transactions",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; Lookups that Match NID",
-        "Counter": "0,1",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.NID",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Qualify one of the other sube=
vents by the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.n=
id.   In conjunction with STATE =3D I, it is possible to monitor misses to =
specific NIDs in the system.",
-        "UMask": "0x41",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; External Snoop Request",
-        "Counter": "0,1",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Filters for only snoop reques=
ts coming from the remote socket(s) through the IPQ.",
-        "UMask": "0x9",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; Write Requests",
-        "Counter": "0,1",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:17] bits correspond to [M'FMESI] state.; Writeback transactions from L=
2 to the LLC  This includes all write transactions -- both Cachable and UC.=
",
-        "UMask": "0x5",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
         "Counter": "0,1",
@@ -100,17 +45,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
-        "Counter": "0,1",
-        "EventCode": "0x37",
-        "EventName": "UNC_C_LLC_VICTIMS.NID",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.; Qu=
alify one of the other subevents by the Target NID.  The NID is programmed =
in Cn_MSR_PMON_BOX_FILTER.nid.   In conjunction with STATE =3D I, it is pos=
sible to monitor misses to specific NIDs in the system.",
-        "UMask": "0x40",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Lines Victimized; Lines in S State",
         "Counter": "0,1",
@@ -1029,17 +963,6 @@
         "UMask": "0x28",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by locally HOMed=
 memory.",
-        "UMask": "0x21",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Inserts; Misses to Local Memory",
         "Counter": "0,1",
@@ -1050,28 +973,6 @@
         "UMask": "0x2A",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcode =
Matched",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode, inserted into the TOR that are satisifed by locally HOMed=
 memory.",
-        "UMask": "0x23",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; Miss Opcode Match",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match an opcode.",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Inserts; Misses to Remote Memory",
         "Counter": "0,1",
@@ -1082,94 +983,6 @@
         "UMask": "0x8A",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opcode=
 Matched",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, satisi=
fed by an opcode,  inserted into the TOR that are satisifed by remote cache=
s or remote memory.",
-        "UMask": "0x83",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID Matched",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matches =
an RTID destination) transactions inserted into the TOR.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it is=
 possible to monitor misses to specific NIDs in the system.",
-        "UMask": "0x48",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID Matched Evictions",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tran=
sactions inserted into the TOR.",
-        "UMask": "0x44",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID Matched Miss All",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss requ=
ests that were inserted into the TOR.",
-        "UMask": "0x4A",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
-        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inserte=
d into the TOR that match a NID and an opcode.",
-        "UMask": "0x43",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID and Opcode Matched",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
-        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match a NID and an opcode.",
-        "UMask": "0x41",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID Matched Writebacks",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_WB",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write transac=
tions inserted into the TOR.",
-        "UMask": "0x50",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; Opcode Match",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted int=
o the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Inserts; Remote Memory",
         "Counter": "0,1",
@@ -1180,17 +993,6 @@
         "UMask": "0x88",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH and=
 set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satisif=
ed by an opcode,  inserted into the TOR that are satisifed by remote caches=
 or remote memory.",
-        "UMask": "0x81",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Inserts; Writebacks",
         "Counter": "0,1",
@@ -1228,16 +1030,6 @@
         "UMask": "0x28",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Occupancy; Local Memory - Opcode Matched"=
,
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by locally HOMed memory.",
-        "UMask": "0x21",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Occupancy; Miss All",
         "EventCode": "0x36",
@@ -1256,26 +1048,6 @@
         "UMask": "0x2A",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Occupancy; Misses to Local Memory - Opcod=
e Matched",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by locally HOMed memory.",
-        "UMask": "0x23",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; Miss Opcode Match",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
for miss transactions that match an opcode. This generally means that the r=
equest was sent to memory or MMIO.",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Occupancy",
         "EventCode": "0x36",
@@ -1285,86 +1057,6 @@
         "UMask": "0x8A",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Occupancy; Misses to Remote Memory - Opco=
de Matched",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss transactions, satisifed by an opcode, in the TOR that are sa=
tisifed by remote caches or remote memory.",
-        "UMask": "0x83",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID Matched",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_ALL",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of NI=
D matched outstanding requests in the TOR.  The NID is programmed in Cn_MSR=
_PMON_BOX_FILTER.nid.In conjunction with STATE =3D I, it is possible to mon=
itor misses to specific NIDs in the system.",
-        "UMask": "0x48",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID Matched Evictions",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_EVICTION",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding NID matched eviction transactions in the TOR .",
-        "UMask": "0x44",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID Matched",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID.",
-        "UMask": "0x4A",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE",
-        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding Miss requests in the TOR that match a NID and an opcode.",
-        "UMask": "0x43",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_OPCODE",
-        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match a NID and an opcode.",
-        "UMask": "0x41",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID Matched Writebacks",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_WB",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); NID matched =
write transactions int the TOR.",
-        "UMask": "0x50",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; Opcode Match",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entries =
that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc).",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Occupancy",
         "EventCode": "0x36",
@@ -1374,16 +1066,6 @@
         "UMask": "0x88",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Occupancy; Remote Memory - Opcode Matched=
",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
-        "Filter": "CBoFilter1[28:20]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select MIS=
S_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of ou=
tstanding  transactions, satisifed by an opcode,  in the TOR that are satis=
ifed by remote caches or remote memory.",
-        "UMask": "0x81",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Occupancy; Writebacks",
         "EventCode": "0x36",
@@ -1520,66 +1202,6 @@
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
index b50685fbde12..abd1e11af7fd 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
@@ -8,17 +8,6 @@
         "PublicDescription": "Counts the number of clocks in the QPI LL.  =
This clock runs at 1/8th the GT/s speed of the QPI link.  For example, a 8G=
T/s link will have qfclk or 1GHz.  JKT does not support dynamic link speeds=
, so this frequency is fixed.",
         "Unit": "QPI LL"
     },
-    {
-        "BriefDescription": "Count of CTO Events",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x38",
-        "EventName": "UNC_Q_CTO_COUNT",
-        "ExtSel": "1",
-        "Filter": "QPIMask0[17:0],QPIMatch0[17:0],QPIMask1[19:16],QPIMatch=
1[19:16]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of CTO (cluster trigger ou=
ts) events that were asserted across the two slots.  If both slots trigger =
in a given cycle, the event will increment by 2.  You can use edge detect t=
o count the number of cases when both events triggered.",
-        "Unit": "QPI LL"
-    },
     {
         "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egres=
s Credits",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-other.json
index aa7a5059d79f..df4046a9d7f1 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
@@ -247,24 +247,13 @@
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
         "EventCode": "0x15",
         "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.",
+        "PublicDescription": "Counts the number of \\Inbound\\ transaction=
s from the IRP to the Uncore.  This can be filtered based on request type i=
n addition to the source queue.  Note the special filtering equation.  We d=
o OR-reduction on the request type.  If the SOURCE bit is set, then we also=
 do AND qualification based on the source portID.",
         "UMask": "0x4",
         "Unit": "IRP"
     },
@@ -2269,17 +2258,6 @@
         "UMask": "0x2",
         "Unit": "UBOX"
     },
-    {
-        "BriefDescription": "Filter Match",
-        "Counter": "0,1",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
-        "Filter": "UBoxFilter[3:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x1",
-        "Unit": "UBOX"
-    },
     {
         "BriefDescription": "Filter Match",
         "Counter": "0,1",
@@ -2290,17 +2268,6 @@
         "UMask": "0x8",
         "Unit": "UBOX"
     },
-    {
-        "BriefDescription": "Filter Match",
-        "Counter": "0,1",
-        "EventCode": "0x41",
-        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
-        "Filter": "UBoxFilter[3:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Filter match per thread (w/ or w/o Filter En=
able).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID.",
-        "UMask": "0x4",
-        "Unit": "UBOX"
-    },
     {
         "BriefDescription": "IDI Lock/SplitLock Cycles",
         "Counter": "0,1",
diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/too=
ls/perf/pmu-events/arch/x86/ivytown/uncore-power.json
index 304d861c368f..e0cb4cf09743 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
@@ -292,196 +292,6 @@
         "PublicDescription": "Number of times that a deep C state was requ=
ested, but the delayed C state algorithm rejected the deep sleep state.  In=
 other words, a wake event occurred before the timer expired that causes a =
transition into the deeper C state.",
         "Unit": "PCU"
     },
-    {
-        "BriefDescription": "Core 0 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x1e",
-        "EventName": "UNC_P_DEMOTIONS_CORE0",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 1 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x1f",
-        "EventName": "UNC_P_DEMOTIONS_CORE1",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 10 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x42",
-        "EventName": "UNC_P_DEMOTIONS_CORE10",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 11 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x43",
-        "EventName": "UNC_P_DEMOTIONS_CORE11",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 12 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x44",
-        "EventName": "UNC_P_DEMOTIONS_CORE12",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 13 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x45",
-        "EventName": "UNC_P_DEMOTIONS_CORE13",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 14 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x46",
-        "EventName": "UNC_P_DEMOTIONS_CORE14",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 2 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x20",
-        "EventName": "UNC_P_DEMOTIONS_CORE2",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 3 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x21",
-        "EventName": "UNC_P_DEMOTIONS_CORE3",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 4 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x22",
-        "EventName": "UNC_P_DEMOTIONS_CORE4",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 5 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x23",
-        "EventName": "UNC_P_DEMOTIONS_CORE5",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 6 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x24",
-        "EventName": "UNC_P_DEMOTIONS_CORE6",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 7 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x25",
-        "EventName": "UNC_P_DEMOTIONS_CORE7",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 8 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x40",
-        "EventName": "UNC_P_DEMOTIONS_CORE8",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Core 9 C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x41",
-        "EventName": "UNC_P_DEMOTIONS_CORE9",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xb",
-        "EventName": "UNC_P_FREQ_BAND0_CYCLES",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xc",
-        "EventName": "UNC_P_FREQ_BAND1_CYCLES",
-        "Filter": "PCUFilter[15:8]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xd",
-        "EventName": "UNC_P_FREQ_BAND2_CYCLES",
-        "Filter": "PCUFilter[23:16]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
-        "Unit": "PCU"
-    },
-    {
-        "BriefDescription": "Frequency Residency",
-        "Counter": "0,1,2,3",
-        "EventCode": "0xe",
-        "EventName": "UNC_P_FREQ_BAND3_CYCLES",
-        "Filter": "PCUFilter[31:24]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles that the uncore =
was running at a frequency greater than or equal to the frequency that is c=
onfigured in the filter.  One can use all four counters with this event, so=
 it is possible to track up to 4 configurable bands.  One can use edge dete=
ct in conjunction with this event to track the number of times that we tran=
sitioned into a frequency greater than or equal to the configurable frequen=
cy. One can also use inversion to track cycles when we were less than the c=
onfigured frequency.",
-        "Unit": "PCU"
-    },
     {
         "BriefDescription": "Current Strongest Upper Limit Cycles",
         "Counter": "0,1,2,3",
--=20
2.37.1.455.g008518b4e5-goog

