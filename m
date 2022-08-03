Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C8558877E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiHCGjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiHCGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:39:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3F58B46
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:39:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f63772b89so135975877b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=T/n6zfBQTnwpkoyxULSVTg3IOxNOcecIBnbv2VgfNbQ=;
        b=F8Anr5x2tlr5f5YFj3oBY2A8PbUlo+4EhwTLEsizgELqjVd1zevgi8+hHwVeHW2bds
         WwRqo5WWtxDsNnVwVnYRTi3/6tDlgeqQ+3K6LbZhB0hobsVjtHAR+6TuANr9lCRFQvvl
         dGI/IqXs/YQHV2j8qCLeCH90oLHmJ48poi0jMUZVv1Gkjn3QSSOXnEYBgvYps/ItNTXy
         QoCd7fUp1XGeBGSzwyR4Iw+1fyk+ZeLb+dZOEGPosR44m21ew6gQCJ1uiZ4ipzvMllBt
         mZ86ClUK6eYpMVLzocmUZH60FQGzxbLBd0cWQKksUFzlxaaP1Qjp0a7heWxI1e7srW1g
         bR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=T/n6zfBQTnwpkoyxULSVTg3IOxNOcecIBnbv2VgfNbQ=;
        b=SorLWWnRSRSooiYA9C2bAaWNWhRhF2zxjnbcaVoVOGpm041pF1HIM4yzQ5v6dwXXzi
         0FNnnAgfsxRc9jWFKvx7xOmACI2/oMI8jwWj9+09EVkjMFlzqlHmQO1WSSzC7bsYYh0q
         ckLJCsSdbNAZu6d8a/3SWh/WLpZa8N2PBEcyXOwn2pjgQe9sXM/yBrGudau5JCmpHPYr
         DoknroXb/VKacqlPSx0BaXs8AOPvVi2JkbBawNj0wdnLnNOnMYNciCiS3lFwKnpWqjc7
         yPorcLHlFdDY/7DpUYpWi2og3AQPpIGiBdtLAdzDPSXiQqNSGiNhqtTQxT3YDF1m/SUe
         HBJg==
X-Gm-Message-State: ACgBeo2M5coc7wUnPWx7MVCufdY1YjZ5y/hmN9f4dEdexFjzoPrh95Qt
        4Bu86U+eHQcr2mi3mmnC1FWNlpjAuUxL
X-Google-Smtp-Source: AA6agR7f9d8e7NONavrkiCq3nCwTJ1pT62UbTb7FD4d1KsA6GESPSrjywpZILUWmzILWC48rFc+Tsiu7N+Hs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:dbef:ce2b:2472:e20f])
 (user=irogers job=sendgmr) by 2002:a81:a10b:0:b0:31f:5960:4e8c with SMTP id
 y11-20020a81a10b000000b0031f59604e8cmr21309484ywg.67.1659508755211; Tue, 02
 Aug 2022 23:39:15 -0700 (PDT)
Date:   Tue,  2 Aug 2022 23:38:20 -0700
In-Reply-To: <20220803063820.1345011-1-irogers@google.com>
Message-Id: <20220803063820.1345011-3-irogers@google.com>
Mime-Version: 1.0
References: <20220803063820.1345011-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v1 3/3] perf vendor events: Remove bad jaketown uncore events
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

Fixes: 376d8b581b76 ("perf vendor events: Update Intel jaketown")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/jaketown/uncore-cache.json       | 223 ------------------
 .../arch/x86/jaketown/uncore-other.json       |  33 ---
 .../arch/x86/jaketown/uncore-power.json       | 110 ---------
 3 files changed, 366 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
index cf28ffa778ba..4c6600677e7b 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
@@ -15,50 +15,6 @@
         "PublicDescription": "Since occupancy counts can only be captured =
in the Cbo's 0 counter, this event allows a user to capture occupancy relat=
ed information by filtering the Cb0 occupancy count captured in Counter 0. =
  The filtering available is found in the control register - threshold, inv=
ert and edge detect.   E.g. setting threshold to 1 can effectively monitor =
how many cycles the monitored queue has an entry.",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Cache Lookups; Data Read Request",
-        "Counter": "0,1",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
-        "Filter": "CBoFilter[22:18]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; RTID",
-        "Counter": "0,1",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.NID",
-        "Filter": "CBoFilter[22:18], CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
-        "UMask": "0x41",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; External Snoop Request",
-        "Counter": "0,1",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
-        "Filter": "CBoFilter[22:18]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
-        "UMask": "0x9",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "Cache Lookups; Write Requests",
-        "Counter": "0,1",
-        "EventCode": "0x34",
-        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
-        "Filter": "CBoFilter[22:18]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set filter mask bit 0 and select a sta=
te or states to match.  Otherwise, the event will count nothing.   CBoGlCtr=
l[22:18] bits correspond to [FMESI] state.",
-        "UMask": "0x5",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Lines Victimized; Lines in E state",
         "Counter": "0,1",
@@ -89,17 +45,6 @@
         "UMask": "0x1",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "Lines Victimized; Victimized Lines that Match=
 NID",
-        "Counter": "0,1",
-        "EventCode": "0x37",
-        "EventName": "UNC_C_LLC_VICTIMS.NID",
-        "Filter": "CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of lines that were victimi=
zed on a fill.  This can be filtered by the state that the line was in.",
-        "UMask": "0x40",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Lines Victimized; Lines in S State",
         "Counter": "0,1",
@@ -608,94 +553,6 @@
         "UMask": "0xa",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Inserts; Miss Opcode Match",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
-        "Filter": "CBoFilter[31:23]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID Matched",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
-        "Filter": "CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
-        "UMask": "0x48",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID Matched Evictions",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
-        "Filter": "CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
-        "UMask": "0x44",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID Matched Miss All",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
-        "Filter": "CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
-        "UMask": "0x4a",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
-        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
-        "UMask": "0x43",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID and Opcode Matched",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
-        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
-        "UMask": "0x41",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; NID Matched Writebacks",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.NID_WB",
-        "Filter": "CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
-        "UMask": "0x50",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Inserts; Opcode Match",
-        "Counter": "0,1",
-        "EventCode": "0x35",
-        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
-        "Filter": "CBoFilter[31:23]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of entries successfuly ins=
erted into the TOR that match  qualifications specified by the subevent.  T=
here are a number of subevent 'filters' but only a subset of the subevent c=
ombinations are valid.  Subevents that require an opcode or NID match requi=
re the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for example,=
 one wanted to count DRD Local Misses, one should select 'MISS_OPC_MATCH' a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "TOR Inserts; Writebacks",
         "Counter": "0,1",
@@ -733,76 +590,6 @@
         "UMask": "0xa",
         "Unit": "CBO"
     },
-    {
-        "BriefDescription": "TOR Occupancy; Miss Opcode Match",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE",
-        "Filter": "CBoFilter[31:23]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x3",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID Matched",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_ALL",
-        "Filter": "CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x48",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID Matched Evictions",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_EVICTION",
-        "Filter": "CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x44",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID Matched",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
-        "Filter": "CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x4a",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE",
-        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x43",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.NID_OPCODE",
-        "Filter": "CBoFilter[31:23], CBoFilter[17:10]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x41",
-        "Unit": "CBO"
-    },
-    {
-        "BriefDescription": "TOR Occupancy; Opcode Match",
-        "EventCode": "0x36",
-        "EventName": "UNC_C_TOR_OCCUPANCY.OPCODE",
-        "Filter": "CBoFilter[31:23]",
-        "PerPkg": "1",
-        "PublicDescription": "For each cycle, this event accumulates the n=
umber of valid entries in the TOR that match qualifications specified by th=
e subevent.   There are a number of subevent 'filters' but only a subset of=
 the subevent combinations are valid.  Subevents that require an opcode or =
NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  I=
f, for example, one wanted to count DRD Local Misses, one should select 'MI=
SS_OPC_MATCH' and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182)",
-        "UMask": "0x1",
-        "Unit": "CBO"
-    },
     {
         "BriefDescription": "Egress Allocations; AD - Cachebo",
         "Counter": "0,1",
@@ -893,16 +680,6 @@
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
index 99fc673c59e9..05a85c458b3a 100644
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
@@ -1373,17 +1362,6 @@
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
@@ -1394,17 +1372,6 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/to=
ols/perf/pmu-events/arch/x86/jaketown/uncore-power.json
index 04228344cb9c..c89a48f6afe2 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
@@ -87,26 +87,6 @@
         "PublicDescription": "Number of cycles spent performing core C sta=
te transitions.  There is one event per core.",
         "Unit": "PCU"
     },
-    {
-        "BriefDescription": "Core C State Demotions",
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
-        "BriefDescription": "Core C State Demotions",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x1f",
-        "EventName": "UNC_P_DEMOTIONS_CORE1",
-        "Filter": "PCUFilter[7:0]",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
-        "Unit": "PCU"
-    },
     {
         "BriefDescription": "Core C State Demotions",
         "Counter": "0,1,2,3",
@@ -116,96 +96,6 @@
         "PublicDescription": "Counts the number of times when a configurab=
le cores had a C-state demotion",
         "Unit": "PCU"
     },
-    {
-        "BriefDescription": "Core C State Demotions",
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
-        "BriefDescription": "Core C State Demotions",
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
-        "BriefDescription": "Core C State Demotions",
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
-        "BriefDescription": "Core C State Demotions",
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
-        "BriefDescription": "Core C State Demotions",
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

