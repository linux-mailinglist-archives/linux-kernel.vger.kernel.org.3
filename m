Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E31589548
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbiHDATg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240322AbiHDAT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:19:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723555F111
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:19:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k13-20020a056902024d00b0066fa7f50b97so14397234ybs.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 17:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=AkJtwhRcSLVgZkh37A6eu06a7Z4MqpcONqLQAvOPp2g=;
        b=EZE9Zwi7vWVtQEUgXTy17gpGuuoCt7uL3gBQelSK2ZkKZl5jS09S9SxpqMPTV32aiO
         hcgjQqRK1ry7/+m9uONtl9KcDgu4JOEU1ysBhgD00MiS1YABSRfNp/P8ElYZRWWXcRxf
         KSQhwDJCpyk+1faCODsXi262V9S67EsMGtGn3YVQkYXSxyXPlzDzrVvLCNfRK6m62AR/
         YaubMKubGJGKfRulZykJWuNix5yo9vhwoQCWI334/k3FicWmWo1PfI2i2pMMoOrFvYfz
         iOOV76xaTapdhXMDd0EJCceol+PoJtpWwEAVcHpAiZHQjwzcx7qdvFwleXXBf2sL1Kd0
         Kbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=AkJtwhRcSLVgZkh37A6eu06a7Z4MqpcONqLQAvOPp2g=;
        b=LREOuHTSo23iviHAC8irWUkYPm0+m8ztqabmO2xiTyUu9mQyJh9RqBxW4qzCVWEfzD
         WZ3Th2mMGT6GQw4Yu3+zmwYD2cv/NV7zu5Wuv71wu4lNWyt9M7ac5jPFD84y9YGPEbnr
         u5qd/NayYojKIyWl2dLbreh+KY75NxugHUsmuz2gcFO24fyGfL/XoDY7ohKog5wipTQW
         7UBxDYyYminhDKoOPLOqbR+krwom2PAXZRkynNVNboHcNGWzhfKE7FAYURe4jSjqGeYZ
         Itx+uej968QtSr0zUUYRRWDxNd9SRiuPMBzcol28oGzSpobUfS9ihQ+PRw9oXxmPL1P9
         m9zw==
X-Gm-Message-State: ACgBeo1vQA0sq1EItchpOSsU8GsTE7WKBAQ6EDtiWKGpdPpMXfYLTUc5
        0z6mLVwlvxEtHMEuEHKQVv9DzF5xzQll
X-Google-Smtp-Source: AA6agR7PGWTN32fihffSvU58hN+kJz2oEoO/Sa66RmWYKkrb7aA9T93jlV1B4clYctCyQ5b+mJxAVOnj8nnP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:dbef:ce2b:2472:e20f])
 (user=irogers job=sendgmr) by 2002:a5b:785:0:b0:671:7708:2f68 with SMTP id
 b5-20020a5b0785000000b0067177082f68mr21176264ybq.96.1659572363719; Wed, 03
 Aug 2022 17:19:23 -0700 (PDT)
Date:   Wed,  3 Aug 2022 17:19:18 -0700
Message-Id: <20220804001920.1544379-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 1/3] perf vendor events: Remove bad broadwellde uncore events
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

Fixes: ef908a192512 ("perf vendor events: Update Intel broadwellde")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/broadwellde/uncore-cache.json    | 455 ------------------
 .../arch/x86/broadwellde/uncore-other.json    |  33 --
 2 files changed, 488 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json b=
/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
index caadbca1b15b..75655478952f 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
@@ -32,72 +32,6 @@
         "PublicDescription": "Counts the number of cycles either the local=
 distress or incoming distress signals are asserted.  Incoming distress inc=
ludes both up and dn.",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Cache Lookups; Any Request",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.ANY",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for any transaction originati=
ng from the IPQ or IRQ.  This does not include lookups originating from the=
 ISMQ.",
-        "UMask": "0x11",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; Data Read Request",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; Lookups that Match NID",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.NID",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Qualify one of the other subevents by=
 the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.nid.   In=
 conjunction with STATE =3D I, it is possible to monitor misses to specific=
 NIDs in the system.",
-        "UMask": "0x41",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; Any Read Request",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.READ",
-        "Filter": "CBoFilter0[22:18]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Read transactions",
-        "UMask": "0x21",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; External Snoop Request",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Filters for only snoop requests comin=
g from the remote socket(s) through the IPQ.",
-        "UMask": "0x9",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; Write Requests",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
-        "Filter": "CBoFilter0[23:17]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22:1=
8] bits correspond to [FMESI] state.; Writeback transactions from L2 to the=
 LLC  This includes all write transactions -- both Cachable and UC.",
-        "UMask": "0x5",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
         "Counter": "0,1,2,3",
@@ -148,17 +82,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x37",
-        "EventName": "UNC_C_LLC_VICTIMS.NID",
-        "Filter": "CBoFilter1[17:10]",
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
         "BriefDescription": "Cbo Misc; DRd hitting non-M with raw CV=3D0",
         "Counter": "0,1,2,3",
@@ -789,17 +712,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Probe Queue Retries; Target Node Filter",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x28",
-        "EventName": "UNC_C_RxR_IPQ_RETRY2.TARGET",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a snoop (probe) request had =
to retry.  Filters exist to cover some of the common cases retries.; Counts=
 the number of times that a request from the IPQ was retried filtered by th=
e Target NodeID as specified in the Cbox's Filter register.",
-        "UMask": "0x40",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Ingress Request Queue Rejects; Address Confli=
ct",
         "Counter": "0,1,2,3",
@@ -840,17 +752,6 @@
         "UMask": "0x20",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Ingress Request Queue Rejects",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x32",
-        "EventName": "UNC_C_RxR_IRQ_RETRY.NID",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Qualify one of the other subevents by a give=
n RTID destination NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER1.n=
id.",
-        "UMask": "0x40",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Ingress Request Queue Rejects; No QPI Credits=
",
         "Counter": "0,1,2,3",
@@ -891,17 +792,6 @@
         "UMask": "0x2",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Ingress Request Queue Rejects; Target Node Fi=
lter",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x29",
-        "EventName": "UNC_C_RxR_IRQ_RETRY2.TARGET",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request fr=
om the IPQ was retried filtered by the Target NodeID as specified in the Cb=
ox's Filter register.",
-        "UMask": "0x40",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "ISMQ Retries; Any Reject",
         "Counter": "0,1,2,3",
@@ -932,17 +822,6 @@
         "UMask": "0x20",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x33",
-        "EventName": "UNC_C_RxR_ISMQ_RETRY.NID",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
-        "UMask": "0x40",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "ISMQ Retries; No QPI Credits",
         "Counter": "0,1,2,3",
@@ -963,17 +842,6 @@
         "UMask": "0x8",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "ISMQ Retries",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x33",
-        "EventName": "UNC_C_RxR_ISMQ_RETRY.WB_CREDITS",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Number of times a transaction flowing throug=
h the ISMQ had to retry.  Transaction pass through the ISMQ as responses fo=
r requests that already exist in the Cbo.  Some examples include: when data=
 is returned or when snoop responses come back from the cores.; Qualify one=
 of the other subevents by a given RTID destination NID.  The NID is progra=
mmed in Cn_MSR_PMON_BOX_FILTER1.nid.",
-        "UMask": "0x80",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "ISMQ Request Queue Rejects; No AD Sbo Credits=
",
         "Counter": "0,1,2,3",
@@ -994,17 +862,6 @@
         "UMask": "0x2",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "ISMQ Request Queue Rejects; Target Node Filte=
r",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A",
-        "EventName": "UNC_C_RxR_ISMQ_RETRY2.TARGET",
-        "Filter": "CBoFilter1[15:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times that a request fr=
om the ISMQ was retried filtered by the Target NodeID as specified in the C=
box's Filter register.",
-        "UMask": "0x40",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Ingress Occupancy; IPQ",
         "EventCode": "0x11",
@@ -1109,17 +966,6 @@
         "UMask": "0x28",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched",
-        "Counter": "0,1,2,3",
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
         "Counter": "0,1,2,3",
@@ -1130,28 +976,6 @@
         "UMask": "0x2A",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcode =
Matched",
-        "Counter": "0,1,2,3",
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
-        "Counter": "0,1,2,3",
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
         "Counter": "0,1,2,3",
@@ -1162,94 +986,6 @@
         "UMask": "0x8A",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opcode=
 Matched",
-        "Counter": "0,1,2,3",
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
-        "Counter": "0,1,2,3",
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
-        "Counter": "0,1,2,3",
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
-        "Counter": "0,1,2,3",
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
-        "Counter": "0,1,2,3",
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
-        "Counter": "0,1,2,3",
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
-        "Counter": "0,1,2,3",
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
-        "Counter": "0,1,2,3",
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
         "Counter": "0,1,2,3",
@@ -1260,17 +996,6 @@
         "UMask": "0x88",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched",
-        "Counter": "0,1,2,3",
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
         "Counter": "0,1,2,3",
@@ -1308,16 +1033,6 @@
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
@@ -1336,26 +1051,6 @@
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
@@ -1365,86 +1060,6 @@
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
@@ -1454,16 +1069,6 @@
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
@@ -1610,66 +1215,6 @@
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
index 71bdf75d8016..24c82ca873bd 100644
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
@@ -1112,17 +1101,6 @@
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
@@ -1133,17 +1111,6 @@
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
         "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
         "Counter": "0,1",
--=20
2.37.1.455.g008518b4e5-goog

