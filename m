Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42F589546
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiHDAT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbiHDATP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:19:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22265F991
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:19:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p10so19184703wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 17:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gjXqENmEieRLC+nRlaKL8pgUHBeFOFbvp6sQkf0bdJI=;
        b=iB7LJbWd/jptoq8Em+9Q3J1+3XLozqkCu4QsSWUWFitznJt1fKbV2D7InjN/I8MofW
         IZrMVRH0VWo34lOmpY6c/f/0c1Mh3sxiqx9yBEAo2EzOFghFv5NgFQjpVr7qRmuH3HhE
         vNsPIb3xi4ByWc1tDZJktXQ+xc2JQ7ncant+VSpibr/P/UFvzsQacMyqc6VexQh06zWW
         pXLBREcb7kY2BAQEbCU0/vEgKX8jjjZT/NRtn6YGCPsJTH0zOjRHpIGCPzlwyiPBAg7h
         E+A0yaTDlC28nhwJ6MNPP0BrfgtQV8dZ8EV0itS1isFqI2lNuWHpcicfKT5CVQz8TaMT
         /oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gjXqENmEieRLC+nRlaKL8pgUHBeFOFbvp6sQkf0bdJI=;
        b=LvcHcax2beeH8XzaYe7z1SFtGfh7q0i300ssSa0lFskBICH3onIpewPCOZVFtOw+cB
         f5Anpn5OAZ9eXlWktDRdwFxVA92fMzaU/aKhBfgUVgJi0ffTHT16qCUCPrFXAdOOGzCe
         TPrSqRrgmIFIubbtGpX4YJUJGASyq3V3+HLZRWPMID9hhJLCMS8wIZl8vqOXWOS2vlSW
         V7/UR8jw8A+o0LUyqRoU6ZVF5HI2bP5HNWVmi50e3oRheRaFbGYAlzoMNAgRe24NOCn1
         dsLyTJvWFj1ojXDbKZNKuGoSNUOUbVuemA7He2Y/zgTM0VC5gH6f6QZbIbKgGtj2nl3t
         WtXQ==
X-Gm-Message-State: ACgBeo0wb9p+NyWGRp+S1i9RFbfAbVU0JKf7lHmrs1Sey+EZz6bejbmG
        u/Gyzhox3fpjqg3lj2y1NRMl/uku2y5kdsehO3K+/Q==
X-Google-Smtp-Source: AA6agR4lDBFem3E4rieZDyGLngiaChhHWaC3hGkCutLTdzxVIpFAo1z9SAxNW/tCnb3Enepz61ANVc90ZBVL9RgZR74=
X-Received: by 2002:a5d:6d4e:0:b0:21e:660e:55bf with SMTP id
 k14-20020a5d6d4e000000b0021e660e55bfmr16732058wri.343.1659572340469; Wed, 03
 Aug 2022 17:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220803063820.1345011-1-irogers@google.com> <20220803063820.1345011-2-irogers@google.com>
In-Reply-To: <20220803063820.1345011-2-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 Aug 2022 17:18:47 -0700
Message-ID: <CAP-5=fU=BtodUXw0OkCY4Zqw4r3etW624QBAB1SXtRy3VqmY-Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf vendor events: Remove bad ivytown uncore events
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
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 11:39 PM Ian Rogers <irogers@google.com> wrote:
>
> The event converter scripts at:
> https://github.com/intel/event-converter-for-linux-perf
> passes Filter values from data on 01.org that is bogus in a perf command
> line and can cause perf to infinitely recurse in parse events. Remove
> such events using the updated patch:
> https://github.com/intel/event-converter-for-linux-perf/pull/15/commits/4=
85e42418d4f520a641994a1b041c149bb34f4a6
>
> Fixes: 6220136831e3 ("perf vendor events: Update Intel ivytown")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../arch/x86/ivytown/uncore-cache.json        | 378 ------------------
>  .../arch/x86/ivytown/uncore-interconnect.json |  11 -
>  .../arch/x86/ivytown/uncore-other.json        |  35 +-
>  .../arch/x86/ivytown/uncore-power.json        | 190 ---------
>  4 files changed, 1 insertion(+), 613 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
> index 1e53bee8af5c..85bc9c76c0cc 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
> @@ -15,61 +15,6 @@
>          "PublicDescription": "Since occupancy counts can only be capture=
d in the Cbo's 0 counter, this event allows a user to capture occupancy rel=
ated information by filtering the Cb0 occupancy count captured in Counter 0=
.   The filtering available is found in the control register - threshold, i=
nvert and edge detect.   E.g. setting threshold to 1 can effectively monito=
r how many cycles the monitored queue has an entry.",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "Cache Lookups; Any Request",
> -        "Counter": "0,1",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.ANY",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set filter mask bit 0 and select a s=
tate or states to match.  Otherwise, the event will count nothing.   CBoGlC=
trl[22:17] bits correspond to [M'FMESI] state.; Filters for any transaction=
 originating from the IPQ or IRQ.  This does not include lookups originatin=
g from the ISMQ.",
> -        "UMask": "0x11",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "Cache Lookups; Data Read Request",
> -        "Counter": "0,1",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set filter mask bit 0 and select a s=
tate or states to match.  Otherwise, the event will count nothing.   CBoGlC=
trl[22:17] bits correspond to [M'FMESI] state.; Read transactions",
> -        "UMask": "0x3",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "Cache Lookups; Lookups that Match NID",
> -        "Counter": "0,1",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.NID",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set filter mask bit 0 and select a s=
tate or states to match.  Otherwise, the event will count nothing.   CBoGlC=
trl[22:17] bits correspond to [M'FMESI] state.; Qualify one of the other su=
bevents by the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER=
.nid.   In conjunction with STATE =3D I, it is possible to monitor misses t=
o specific NIDs in the system.",
> -        "UMask": "0x41",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "Cache Lookups; External Snoop Request",
> -        "Counter": "0,1",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set filter mask bit 0 and select a s=
tate or states to match.  Otherwise, the event will count nothing.   CBoGlC=
trl[22:17] bits correspond to [M'FMESI] state.; Filters for only snoop requ=
ests coming from the remote socket(s) through the IPQ.",
> -        "UMask": "0x9",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "Cache Lookups; Write Requests",
> -        "Counter": "0,1",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set filter mask bit 0 and select a s=
tate or states to match.  Otherwise, the event will count nothing.   CBoGlC=
trl[22:17] bits correspond to [M'FMESI] state.; Writeback transactions from=
 L2 to the LLC  This includes all write transactions -- both Cachable and U=
C.",
> -        "UMask": "0x5",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "Lines Victimized; Lines in E state",
>          "Counter": "0,1",
> @@ -100,17 +45,6 @@
>          "UMask": "0x1",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "Lines Victimized; Victimized Lines that Mat=
ch NID",
> -        "Counter": "0,1",
> -        "EventCode": "0x37",
> -        "EventName": "UNC_C_LLC_VICTIMS.NID",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of lines that were victi=
mized on a fill.  This can be filtered by the state that the line was in.; =
Qualify one of the other subevents by the Target NID.  The NID is programme=
d in Cn_MSR_PMON_BOX_FILTER.nid.   In conjunction with STATE =3D I, it is p=
ossible to monitor misses to specific NIDs in the system.",
> -        "UMask": "0x40",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "Lines Victimized; Lines in S State",
>          "Counter": "0,1",
> @@ -1029,17 +963,6 @@
>          "UMask": "0x28",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched"=
,
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satis=
ifed by an opcode,  inserted into the TOR that are satisifed by locally HOM=
ed memory.",
> -        "UMask": "0x21",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "TOR Inserts; Misses to Local Memory",
>          "Counter": "0,1",
> @@ -1050,28 +973,6 @@
>          "UMask": "0x2A",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcod=
e Matched",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sati=
sifed by an opcode, inserted into the TOR that are satisifed by locally HOM=
ed memory.",
> -        "UMask": "0x23",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Inserts; Miss Opcode Match",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inser=
ted into the TOR that match an opcode.",
> -        "UMask": "0x3",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "TOR Inserts; Misses to Remote Memory",
>          "Counter": "0,1",
> @@ -1082,94 +983,6 @@
>          "UMask": "0x8A",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opco=
de Matched",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sati=
sifed by an opcode,  inserted into the TOR that are satisifed by remote cac=
hes or remote memory.",
> -        "UMask": "0x83",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Inserts; NID Matched",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matche=
s an RTID destination) transactions inserted into the TOR.  The NID is prog=
rammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, it =
is possible to monitor misses to specific NIDs in the system.",
> -        "UMask": "0x48",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Inserts; NID Matched Evictions",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction tr=
ansactions inserted into the TOR.",
> -        "UMask": "0x44",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Inserts; NID Matched Miss All",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss re=
quests that were inserted into the TOR.",
> -        "UMask": "0x4A",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
> -        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions inser=
ted into the TOR that match a NID and an opcode.",
> -        "UMask": "0x43",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Inserts; NID and Opcode Matched",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
> -        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted i=
nto the TOR that match a NID and an opcode.",
> -        "UMask": "0x41",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Inserts; NID Matched Writebacks",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.NID_WB",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write trans=
actions inserted into the TOR.",
> -        "UMask": "0x50",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Inserts; Opcode Match",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted i=
nto the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)",
> -        "UMask": "0x1",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "TOR Inserts; Remote Memory",
>          "Counter": "0,1",
> @@ -1180,17 +993,6 @@
>          "UMask": "0x88",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched=
",
> -        "Counter": "0,1",
> -        "EventCode": "0x35",
> -        "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of entries successfuly i=
nserted into the TOR that match  qualifications specified by the subevent. =
 There are a number of subevent 'filters' but only a subset of the subevent=
 combinations are valid.  Subevents that require an opcode or NID match req=
uire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exampl=
e, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH a=
nd set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, satis=
ifed by an opcode,  inserted into the TOR that are satisifed by remote cach=
es or remote memory.",
> -        "UMask": "0x81",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "TOR Inserts; Writebacks",
>          "Counter": "0,1",
> @@ -1228,16 +1030,6 @@
>          "UMask": "0x28",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Occupancy; Local Memory - Opcode Matche=
d",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisifed by an opcode,  in the TOR that are sat=
isifed by locally HOMed memory.",
> -        "UMask": "0x21",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "TOR Occupancy; Miss All",
>          "EventCode": "0x36",
> @@ -1256,26 +1048,6 @@
>          "UMask": "0x2A",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Occupancy; Misses to Local Memory - Opc=
ode Matched",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisifed by an opcode, in the TOR that are =
satisifed by locally HOMed memory.",
> -        "UMask": "0x23",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Occupancy; Miss Opcode Match",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entrie=
s for miss transactions that match an opcode. This generally means that the=
 request was sent to memory or MMIO.",
> -        "UMask": "0x3",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "TOR Occupancy",
>          "EventCode": "0x36",
> @@ -1285,86 +1057,6 @@
>          "UMask": "0x8A",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Occupancy; Misses to Remote Memory - Op=
code Matched",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss transactions, satisifed by an opcode, in the TOR that are =
satisifed by remote caches or remote memory.",
> -        "UMask": "0x83",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Occupancy; NID Matched",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_ALL",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
NID matched outstanding requests in the TOR.  The NID is programmed in Cn_M=
SR_PMON_BOX_FILTER.nid.In conjunction with STATE =3D I, it is possible to m=
onitor misses to specific NIDs in the system.",
> -        "UMask": "0x48",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Occupancy; NID Matched Evictions",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_EVICTION",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding NID matched eviction transactions in the TOR .",
> -        "UMask": "0x44",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Occupancy; NID Matched",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss requests in the TOR that match a NID.",
> -        "UMask": "0x4A",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Occupancy; NID and Opcode Matched Miss"=
,
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE",
> -        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding Miss requests in the TOR that match a NID and an opcode.",
> -        "UMask": "0x43",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_OPCODE",
> -        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entrie=
s that match a NID and an opcode.",
> -        "UMask": "0x41",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Occupancy; NID Matched Writebacks",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_WB",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); NID matche=
d write transactions int the TOR.",
> -        "UMask": "0x50",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "TOR Occupancy; Opcode Match",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entrie=
s that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc).",
> -        "UMask": "0x1",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "TOR Occupancy",
>          "EventCode": "0x36",
> @@ -1374,16 +1066,6 @@
>          "UMask": "0x88",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Occupancy; Remote Memory - Opcode Match=
ed",
> -        "EventCode": "0x36",
> -        "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
> -        "Filter": "CBoFilter1[28:20]",
> -        "PerPkg": "1",
> -        "PublicDescription": "For each cycle, this event accumulates the=
 number of valid entries in the TOR that match qualifications specified by =
the subevent.   There are a number of subevent 'filters' but only a subset =
of the subevent combinations are valid.  Subevents that require an opcode o=
r NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set. =
 If, for example, one wanted to count DRD Local Misses, one should select M=
ISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number of =
outstanding  transactions, satisifed by an opcode,  in the TOR that are sat=
isifed by remote caches or remote memory.",
> -        "UMask": "0x81",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "TOR Occupancy; Writebacks",
>          "EventCode": "0x36",
> @@ -1520,66 +1202,6 @@
>          "UMask": "0x8",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "QPI Address/Opcode Match; AD Opcodes",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x20",
> -        "EventName": "UNC_H_ADDR_OPC_MATCH.AD",
> -        "Filter": "HA_OpcodeMatch[5:0]",
> -        "PerPkg": "1",
> -        "UMask": "0x4",
> -        "Unit": "HA"
> -    },
> -    {
> -        "BriefDescription": "QPI Address/Opcode Match; Address",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x20",
> -        "EventName": "UNC_H_ADDR_OPC_MATCH.ADDR",
> -        "Filter": "HA_AddrMatch0[31:6], HA_AddrMatch1[13:0]",
> -        "PerPkg": "1",
> -        "UMask": "0x1",
> -        "Unit": "HA"
> -    },
> -    {
> -        "BriefDescription": "QPI Address/Opcode Match; AK Opcodes",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x20",
> -        "EventName": "UNC_H_ADDR_OPC_MATCH.AK",
> -        "Filter": "HA_OpcodeMatch[5:0]",
> -        "PerPkg": "1",
> -        "UMask": "0x10",
> -        "Unit": "HA"
> -    },
> -    {
> -        "BriefDescription": "QPI Address/Opcode Match; BL Opcodes",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x20",
> -        "EventName": "UNC_H_ADDR_OPC_MATCH.BL",
> -        "Filter": "HA_OpcodeMatch[5:0]",
> -        "PerPkg": "1",
> -        "UMask": "0x8",
> -        "Unit": "HA"
> -    },
> -    {
> -        "BriefDescription": "QPI Address/Opcode Match; Address & Opcode =
Match",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x20",
> -        "EventName": "UNC_H_ADDR_OPC_MATCH.FILT",
> -        "Filter": "HA_AddrMatch0[31:6], HA_AddrMatch1[13:0], HA_OpcodeMa=
tch[5:0]",
> -        "PerPkg": "1",
> -        "UMask": "0x3",
> -        "Unit": "HA"
> -    },
> -    {
> -        "BriefDescription": "QPI Address/Opcode Match; Opcode",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x20",
> -        "EventName": "UNC_H_ADDR_OPC_MATCH.OPC",
> -        "Filter": "HA_OpcodeMatch[5:0]",
> -        "PerPkg": "1",
> -        "UMask": "0x2",
> -        "Unit": "HA"
> -    },
>      {
>          "BriefDescription": "BT Bypass",
>          "Counter": "0,1,2,3",
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.j=
son b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
> index b50685fbde12..abd1e11af7fd 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
> @@ -8,17 +8,6 @@
>          "PublicDescription": "Counts the number of clocks in the QPI LL.=
  This clock runs at 1/8th the GT/s speed of the QPI link.  For example, a =
8GT/s link will have qfclk or 1GHz.  JKT does not support dynamic link spee=
ds, so this frequency is fixed.",
>          "Unit": "QPI LL"
>      },
> -    {
> -        "BriefDescription": "Count of CTO Events",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x38",
> -        "EventName": "UNC_Q_CTO_COUNT",
> -        "ExtSel": "1",
> -        "Filter": "QPIMask0[17:0],QPIMatch0[17:0],QPIMask1[19:16],QPIMat=
ch1[19:16]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of CTO (cluster trigger =
outs) events that were asserted across the two slots.  If both slots trigge=
r in a given cycle, the event will increment by 2.  You can use edge detect=
 to count the number of cases when both events triggered.",
> -        "Unit": "QPI LL"
> -    },
>      {
>          "BriefDescription": "Direct 2 Core Spawning; Spawn Failure - Egr=
ess Credits",
>          "Counter": "0,1,2,3",
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
> index aa7a5059d79f..df4046a9d7f1 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-other.json
> @@ -247,24 +247,13 @@
>          "UMask": "0x2",
>          "Unit": "IRP"
>      },
> -    {
> -        "BriefDescription": "Inbound Transaction Count; Select Source",
> -        "Counter": "0,1",
> -        "EventCode": "0x15",
> -        "EventName": "UNC_I_TRANSACTIONS.ORDERINGQ",
> -        "Filter": "IRPFilter[4:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of Inbound transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.; Tracks only those requests=
 that come from the port specified in the IRP_PmonFilter.OrderingQ register=
.  This register allows one to select one specific queue.  It is not possib=
le to monitor multiple queues at a time.  If this bit is not set, then requ=
ests from all sources will be counted.",
> -        "UMask": "0x8",
> -        "Unit": "IRP"
> -    },
>      {
>          "BriefDescription": "Inbound Transaction Count: Read Prefetches"=
,
>          "Counter": "0,1",
>          "EventCode": "0x15",
>          "EventName": "UNC_I_TRANSACTIONS.PD_PREFETCHES",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of Inbound transactions =
from the IRP to the Uncore.  This can be filtered based on request type in =
addition to the source queue.  Note the special filtering equation.  We do =
OR-reduction on the request type.  If the SOURCE bit is set, then we also d=
o AND qualification based on the source portID.",
> +        "PublicDescription": "Counts the number of \\Inbound\\ transacti=
ons from the IRP to the Uncore.  This can be filtered based on request type=
 in addition to the source queue.  Note the special filtering equation.  We=
 do OR-reduction on the request type.  If the SOURCE bit is set, then we al=
so do AND qualification based on the source portID.",

Sorry, this needs to be manually fixed. I'll send a v2 with it corrected.

Thanks,
Ian

>          "UMask": "0x4",
>          "Unit": "IRP"
>      },
> @@ -2269,17 +2258,6 @@
>          "UMask": "0x2",
>          "Unit": "UBOX"
>      },
> -    {
> -        "BriefDescription": "Filter Match",
> -        "Counter": "0,1",
> -        "EventCode": "0x41",
> -        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
> -        "Filter": "UBoxFilter[3:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Filter match per thread (w/ or w/o Filter =
Enable).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID."=
,
> -        "UMask": "0x1",
> -        "Unit": "UBOX"
> -    },
>      {
>          "BriefDescription": "Filter Match",
>          "Counter": "0,1",
> @@ -2290,17 +2268,6 @@
>          "UMask": "0x8",
>          "Unit": "UBOX"
>      },
> -    {
> -        "BriefDescription": "Filter Match",
> -        "Counter": "0,1",
> -        "EventCode": "0x41",
> -        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
> -        "Filter": "UBoxFilter[3:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Filter match per thread (w/ or w/o Filter =
Enable).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID."=
,
> -        "UMask": "0x4",
> -        "Unit": "UBOX"
> -    },
>      {
>          "BriefDescription": "IDI Lock/SplitLock Cycles",
>          "Counter": "0,1",
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> index 304d861c368f..e0cb4cf09743 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> @@ -292,196 +292,6 @@
>          "PublicDescription": "Number of times that a deep C state was re=
quested, but the delayed C state algorithm rejected the deep sleep state.  =
In other words, a wake event occurred before the timer expired that causes =
a transition into the deeper C state.",
>          "Unit": "PCU"
>      },
> -    {
> -        "BriefDescription": "Core 0 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x1e",
> -        "EventName": "UNC_P_DEMOTIONS_CORE0",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 1 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x1f",
> -        "EventName": "UNC_P_DEMOTIONS_CORE1",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 10 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x42",
> -        "EventName": "UNC_P_DEMOTIONS_CORE10",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 11 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x43",
> -        "EventName": "UNC_P_DEMOTIONS_CORE11",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 12 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x44",
> -        "EventName": "UNC_P_DEMOTIONS_CORE12",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 13 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x45",
> -        "EventName": "UNC_P_DEMOTIONS_CORE13",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 14 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x46",
> -        "EventName": "UNC_P_DEMOTIONS_CORE14",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 2 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x20",
> -        "EventName": "UNC_P_DEMOTIONS_CORE2",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 3 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x21",
> -        "EventName": "UNC_P_DEMOTIONS_CORE3",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 4 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x22",
> -        "EventName": "UNC_P_DEMOTIONS_CORE4",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 5 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x23",
> -        "EventName": "UNC_P_DEMOTIONS_CORE5",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 6 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x24",
> -        "EventName": "UNC_P_DEMOTIONS_CORE6",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 7 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x25",
> -        "EventName": "UNC_P_DEMOTIONS_CORE7",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 8 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x40",
> -        "EventName": "UNC_P_DEMOTIONS_CORE8",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Core 9 C State Demotions",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x41",
> -        "EventName": "UNC_P_DEMOTIONS_CORE9",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times when a configur=
able cores had a C-state demotion",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Frequency Residency",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xb",
> -        "EventName": "UNC_P_FREQ_BAND0_CYCLES",
> -        "Filter": "PCUFilter[7:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles that the uncor=
e was running at a frequency greater than or equal to the frequency that is=
 configured in the filter.  One can use all four counters with this event, =
so it is possible to track up to 4 configurable bands.  One can use edge de=
tect in conjunction with this event to track the number of times that we tr=
ansitioned into a frequency greater than or equal to the configurable frequ=
ency. One can also use inversion to track cycles when we were less than the=
 configured frequency.",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Frequency Residency",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xc",
> -        "EventName": "UNC_P_FREQ_BAND1_CYCLES",
> -        "Filter": "PCUFilter[15:8]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles that the uncor=
e was running at a frequency greater than or equal to the frequency that is=
 configured in the filter.  One can use all four counters with this event, =
so it is possible to track up to 4 configurable bands.  One can use edge de=
tect in conjunction with this event to track the number of times that we tr=
ansitioned into a frequency greater than or equal to the configurable frequ=
ency. One can also use inversion to track cycles when we were less than the=
 configured frequency.",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Frequency Residency",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xd",
> -        "EventName": "UNC_P_FREQ_BAND2_CYCLES",
> -        "Filter": "PCUFilter[23:16]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles that the uncor=
e was running at a frequency greater than or equal to the frequency that is=
 configured in the filter.  One can use all four counters with this event, =
so it is possible to track up to 4 configurable bands.  One can use edge de=
tect in conjunction with this event to track the number of times that we tr=
ansitioned into a frequency greater than or equal to the configurable frequ=
ency. One can also use inversion to track cycles when we were less than the=
 configured frequency.",
> -        "Unit": "PCU"
> -    },
> -    {
> -        "BriefDescription": "Frequency Residency",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xe",
> -        "EventName": "UNC_P_FREQ_BAND3_CYCLES",
> -        "Filter": "PCUFilter[31:24]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles that the uncor=
e was running at a frequency greater than or equal to the frequency that is=
 configured in the filter.  One can use all four counters with this event, =
so it is possible to track up to 4 configurable bands.  One can use edge de=
tect in conjunction with this event to track the number of times that we tr=
ansitioned into a frequency greater than or equal to the configurable frequ=
ency. One can also use inversion to track cycles when we were less than the=
 configured frequency.",
> -        "Unit": "PCU"
> -    },
>      {
>          "BriefDescription": "Current Strongest Upper Limit Cycles",
>          "Counter": "0,1,2,3",
> --
> 2.37.1.455.g008518b4e5-goog
>
