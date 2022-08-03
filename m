Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE06D58879E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiHCG5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiHCG5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:57:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4427CEA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:57:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p10so16170647wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jx5SDxq7q+zp2kPThsSQAWvQ8IGRwRyfIOCVLpFcA6s=;
        b=oVwlcr9ZVIinBA3imhbBBybF90UntKbetNuXXa/fScmVudsYLbqNfZ8zjaaT73+O/e
         7x8HTc6qB1M0MhPkxXEzaplIQSnjM7kcC4oy1Q2fohy3Z/qJ8gLZEoLquwqsdOCYDUx8
         ma2BEupXAb1goBx6b6KPcrbvdqEeQTPnp3cvkklR67qXOp9705uy7ICz+aV8/x9M5mde
         ibimbjwEvvm5PMVRjEn+y8cVN8fz+hodJXAKUCP6r7vxapxAa46cXHNAKU3Rrc8YwTPH
         h+8DKw5RhEaWUwRFVM2rv6sEWmXZhvITeU9MdmwuijE/uu2EyHnJIYo1pn16Gpu5S8+E
         MJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jx5SDxq7q+zp2kPThsSQAWvQ8IGRwRyfIOCVLpFcA6s=;
        b=FfbpFohh9ezibiwvzsIFhrFHxg//09uuQZT/ScdiQPY73lacv2z2lpS33cTSfOvfxq
         asMQDpIa+YkH7iqN43R0d2Aa2/e3po/ZLfLn46CXGLp8O+Cs/FSC0DNqugAMqTn8O/cF
         TgEp5DEpyezanWa9n7gXE8rmZpXozImGVmif2K9Pbl7T4yNIR6+0L0zZ4liUwb8Xuet3
         Ye+m0kiuU7Gu7PgjAXu0fhT3aRgwGJR6iSMQJsXovzgQ5vwDXY1MN9qtr61dS4h0WzAN
         jNsbwRJ76kfHNHypiNSKN2/mtzItYUc6yBUrrVRQyOk1N3zuBIZXlUr3SRQ160pNitI4
         GSqg==
X-Gm-Message-State: ACgBeo2ElMpf8EyFBPf5vEeCeIERUWTx+b363Wip7WIa9h3qRo4emqQ3
        dpwoZFXIJsm4319W6BlzFbitBCSL+IUOyAwBgjwYfhGIGO1JoA==
X-Google-Smtp-Source: AA6agR7Mn1xn890U8kK1Ch2iTLkxtBfH8frHEunRse0qiZuuCaHQHM+B1AHncXY4D2Zmncnu0YfETd2xwaXhFCDqvRk=
X-Received: by 2002:a5d:4907:0:b0:21f:bc42:989 with SMTP id
 x7-20020a5d4907000000b0021fbc420989mr11768171wrq.375.1659509830842; Tue, 02
 Aug 2022 23:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220803063820.1345011-1-irogers@google.com>
In-Reply-To: <20220803063820.1345011-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 Aug 2022 23:56:57 -0700
Message-ID: <CAP-5=fWUt7DRhr-DUZXUhsXmwhfk5kO0-Dzy0ViEz6xcg1EFXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf vendor events: Remove bad broadwellde uncore events
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
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
> Fixes: ef908a192512 ("perf vendor events: Update Intel broadwellde")
> Signed-off-by: Ian Rogers <irogers@google.com>

Hi,

I also spotted broken uncore events in Arnaldo's perf/core for SKX and
CLX that are bad, like UNC_CHA_TOR_INSERTS.REM_ALL. This is less of an
issue than these 3 patches as it doesn't break perf's start-up. Those
events are also fixed by:
https://github.com/intel/event-converter-for-linux-perf/pull/15
but I've not sent updated events as it appears Zhengjun is preparing
to update the uncore events for SKX and CLX.

Thanks,
Ian

> ---
>  .../arch/x86/broadwellde/uncore-cache.json    | 455 ------------------
>  .../arch/x86/broadwellde/uncore-other.json    |  33 --
>  2 files changed, 488 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> index caadbca1b15b..75655478952f 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> @@ -32,72 +32,6 @@
>          "PublicDescription": "Counts the number of cycles either the loc=
al distress or incoming distress signals are asserted.  Incoming distress i=
ncludes both up and dn.",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "Cache Lookups; Any Request",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.ANY",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set umask bit 0 and select a state o=
r states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22=
:18] bits correspond to [FMESI] state.; Filters for any transaction origina=
ting from the IPQ or IRQ.  This does not include lookups originating from t=
he ISMQ.",
> -        "UMask": "0x11",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "Cache Lookups; Data Read Request",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set umask bit 0 and select a state o=
r states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22=
:18] bits correspond to [FMESI] state.; Read transactions",
> -        "UMask": "0x3",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "Cache Lookups; Lookups that Match NID",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.NID",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set umask bit 0 and select a state o=
r states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22=
:18] bits correspond to [FMESI] state.; Qualify one of the other subevents =
by the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.nid.   =
In conjunction with STATE =3D I, it is possible to monitor misses to specif=
ic NIDs in the system.",
> -        "UMask": "0x41",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "Cache Lookups; Any Read Request",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.READ",
> -        "Filter": "CBoFilter0[22:18]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set umask bit 0 and select a state o=
r states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22=
:18] bits correspond to [FMESI] state.; Read transactions",
> -        "UMask": "0x21",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "Cache Lookups; External Snoop Request",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set umask bit 0 and select a state o=
r states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22=
:18] bits correspond to [FMESI] state.; Filters for only snoop requests com=
ing from the remote socket(s) through the IPQ.",
> -        "UMask": "0x9",
> -        "Unit": "CBO"
> -    },
> -    {
> -        "BriefDescription": "Cache Lookups; Write Requests",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x34",
> -        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
> -        "Filter": "CBoFilter0[23:17]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times the LLC was acc=
essed - this includes code, data, prefetches and hints coming from L2.  Thi=
s has numerous filters available.  Note the non-standard filtering equation=
.  This event will count requests that lookup the cache multiple times with=
 multiple increments.  One must ALWAYS set umask bit 0 and select a state o=
r states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[22=
:18] bits correspond to [FMESI] state.; Writeback transactions from L2 to t=
he LLC  This includes all write transactions -- both Cachable and UC.",
> -        "UMask": "0x5",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "Lines Victimized; Lines in E state",
>          "Counter": "0,1,2,3",
> @@ -148,17 +82,6 @@
>          "UMask": "0x1",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "Lines Victimized; Victimized Lines that Mat=
ch NID",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x37",
> -        "EventName": "UNC_C_LLC_VICTIMS.NID",
> -        "Filter": "CBoFilter1[17:10]",
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
>          "BriefDescription": "Cbo Misc; DRd hitting non-M with raw CV=3D0=
",
>          "Counter": "0,1,2,3",
> @@ -789,17 +712,6 @@
>          "UMask": "0x1",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "Probe Queue Retries; Target Node Filter",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x28",
> -        "EventName": "UNC_C_RxR_IPQ_RETRY2.TARGET",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Number of times a snoop (probe) request ha=
d to retry.  Filters exist to cover some of the common cases retries.; Coun=
ts the number of times that a request from the IPQ was retried filtered by =
the Target NodeID as specified in the Cbox's Filter register.",
> -        "UMask": "0x40",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "Ingress Request Queue Rejects; Address Conf=
lict",
>          "Counter": "0,1,2,3",
> @@ -840,17 +752,6 @@
>          "UMask": "0x20",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "Ingress Request Queue Rejects",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x32",
> -        "EventName": "UNC_C_RxR_IRQ_RETRY.NID",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Qualify one of the other subevents by a gi=
ven RTID destination NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER1=
.nid.",
> -        "UMask": "0x40",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "Ingress Request Queue Rejects; No QPI Credi=
ts",
>          "Counter": "0,1,2,3",
> @@ -891,17 +792,6 @@
>          "UMask": "0x2",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "Ingress Request Queue Rejects; Target Node =
Filter",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x29",
> -        "EventName": "UNC_C_RxR_IRQ_RETRY2.TARGET",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times that a request =
from the IPQ was retried filtered by the Target NodeID as specified in the =
Cbox's Filter register.",
> -        "UMask": "0x40",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "ISMQ Retries; Any Reject",
>          "Counter": "0,1,2,3",
> @@ -932,17 +822,6 @@
>          "UMask": "0x20",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "ISMQ Retries",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x33",
> -        "EventName": "UNC_C_RxR_ISMQ_RETRY.NID",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Number of times a transaction flowing thro=
ugh the ISMQ had to retry.  Transaction pass through the ISMQ as responses =
for requests that already exist in the Cbo.  Some examples include: when da=
ta is returned or when snoop responses come back from the cores.; Qualify o=
ne of the other subevents by a given RTID destination NID.  The NID is prog=
rammed in Cn_MSR_PMON_BOX_FILTER1.nid.",
> -        "UMask": "0x40",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "ISMQ Retries; No QPI Credits",
>          "Counter": "0,1,2,3",
> @@ -963,17 +842,6 @@
>          "UMask": "0x8",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "ISMQ Retries",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x33",
> -        "EventName": "UNC_C_RxR_ISMQ_RETRY.WB_CREDITS",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Number of times a transaction flowing thro=
ugh the ISMQ had to retry.  Transaction pass through the ISMQ as responses =
for requests that already exist in the Cbo.  Some examples include: when da=
ta is returned or when snoop responses come back from the cores.; Qualify o=
ne of the other subevents by a given RTID destination NID.  The NID is prog=
rammed in Cn_MSR_PMON_BOX_FILTER1.nid.",
> -        "UMask": "0x80",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "ISMQ Request Queue Rejects; No AD Sbo Credi=
ts",
>          "Counter": "0,1,2,3",
> @@ -994,17 +862,6 @@
>          "UMask": "0x2",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "ISMQ Request Queue Rejects; Target Node Fil=
ter",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x2A",
> -        "EventName": "UNC_C_RxR_ISMQ_RETRY2.TARGET",
> -        "Filter": "CBoFilter1[15:0]",
> -        "PerPkg": "1",
> -        "PublicDescription": "Counts the number of times that a request =
from the ISMQ was retried filtered by the Target NodeID as specified in the=
 Cbox's Filter register.",
> -        "UMask": "0x40",
> -        "Unit": "CBO"
> -    },
>      {
>          "BriefDescription": "Ingress Occupancy; IPQ",
>          "EventCode": "0x11",
> @@ -1109,17 +966,6 @@
>          "UMask": "0x28",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Inserts; Local Memory - Opcode Matched"=
,
> -        "Counter": "0,1,2,3",
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
>          "Counter": "0,1,2,3",
> @@ -1130,28 +976,6 @@
>          "UMask": "0x2A",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Inserts; Misses to Local Memory - Opcod=
e Matched",
> -        "Counter": "0,1,2,3",
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
> -        "Counter": "0,1,2,3",
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
>          "Counter": "0,1,2,3",
> @@ -1162,94 +986,6 @@
>          "UMask": "0x8A",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Inserts; Misses to Remote Memory - Opco=
de Matched",
> -        "Counter": "0,1,2,3",
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
> -        "Counter": "0,1,2,3",
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
> -        "Counter": "0,1,2,3",
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
> -        "Counter": "0,1,2,3",
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
> -        "Counter": "0,1,2,3",
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
> -        "Counter": "0,1,2,3",
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
> -        "Counter": "0,1,2,3",
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
> -        "Counter": "0,1,2,3",
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
>          "Counter": "0,1,2,3",
> @@ -1260,17 +996,6 @@
>          "UMask": "0x88",
>          "Unit": "CBO"
>      },
> -    {
> -        "BriefDescription": "TOR Inserts; Remote Memory - Opcode Matched=
",
> -        "Counter": "0,1,2,3",
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
>          "Counter": "0,1,2,3",
> @@ -1308,16 +1033,6 @@
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
> @@ -1336,26 +1051,6 @@
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
> @@ -1365,86 +1060,6 @@
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
> @@ -1454,16 +1069,6 @@
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
> @@ -1610,66 +1215,6 @@
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
>          "BriefDescription": "BT Cycles Not Empty",
>          "Counter": "0,1,2,3",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
> index 71bdf75d8016..24c82ca873bd 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
> @@ -416,17 +416,6 @@
>          "UMask": "0x10",
>          "Unit": "IRP"
>      },
> -    {
> -        "BriefDescription": "Inbound Transaction Count; Select Source",
> -        "Counter": "0,1",
> -        "EventCode": "0x16",
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
> -        "UMask": "0x40",
> -        "Unit": "IRP"
> -    },
>      {
>          "BriefDescription": "Inbound Transaction Count; Other",
>          "Counter": "0,1",
> @@ -1112,17 +1101,6 @@
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
> @@ -1133,17 +1111,6 @@
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
>          "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK",
>          "Counter": "0,1",
> --
> 2.37.1.455.g008518b4e5-goog
>
