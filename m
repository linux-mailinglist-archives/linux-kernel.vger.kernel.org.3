Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D290B5890F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiHCRGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCRGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:06:21 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D7713F4D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:06:18 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id j2so12038236vsp.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UGINXU/taTMAnWaPqn0Zzywa2ip/7aly8GoDfwMUC1M=;
        b=SQU1pVK6DFBIEqgg+se0LDUVw2BPSBkuoxr3+SHyqLndytkmZgm4S/7W926k7TA5bJ
         6G9CeoEfTXQ+eW2e4F7euvfQd7udcIE4VFJvzGos2gViWmKCW/pdTVM5J3wcGLW0ou9z
         k/hoAhFJaqETPaYl1U4kYyphrNpnE9fG0iBasMc72Rl31MEy0UgDfxv851IplFeyz+UC
         tG6DRGE1G2n8UO/qik2DDhv1oH6gejgYcLoUOfZApzWstddvwPrzr3pFJ3/OaGy3K694
         Q0KP4wY4HgU8sMyBqF4tLbZrN7FHD478cVWMrqlpaXfKIikxZDaWqhYgYnjCBCSjjhcX
         GkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UGINXU/taTMAnWaPqn0Zzywa2ip/7aly8GoDfwMUC1M=;
        b=jWVqcNMBIQ0oPtSWjOUictvvETuD0NxT2jaK1YU8vWQsvKl1K/omrejd2own/uSnI0
         tK9ZNKX4zbG/sglzNudf/nQHUrYDimLVXOpjb7ldQCGHlXjup93M1+cXqKQntlC6cp51
         0vmRjeuYjup6eFQO5OUPUun73Z1dEwrRPZQGcUcoG3ozpO3npN8+2FwpR0fEjyJPSbxF
         gL+Fhx9SRFI9QXe7GH0oepTM4bTDT0AX0ECZsbyy6Fm/ksFlgHYm36Fy2MD+jpYpDrDX
         6yW29QdRVmIIUktdnG3e9Cu3cB46W8wxLeXmxRbCVG/9mq1g3QEBuJ3P6SObs0aNnGgn
         VI4g==
X-Gm-Message-State: ACgBeo3VggZcrPJaD8uvQFLW24FtPkqJTPe+cCXYHiXkFAFdSEflVHWV
        boLytg2+poM/fMl93UEdnr4u96GJm2EPiXiuCoJq2khgMUlxTQ==
X-Google-Smtp-Source: AA6agR4JmgH9wJaMCYbjOLrYDaHjOcx2MHRx2DiG9wPEhgnI5LSwjbR8tlUE0ALMtur2qRXLTQwkqoaRwoEHULSCqIU=
X-Received: by 2002:a67:e243:0:b0:387:3666:4e67 with SMTP id
 w3-20020a67e243000000b0038736664e67mr5158360vse.47.1659546376549; Wed, 03 Aug
 2022 10:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220803063820.1345011-1-irogers@google.com> <e3c3de8f-d285-963c-9a23-abe2616210fb@linux.intel.com>
In-Reply-To: <e3c3de8f-d285-963c-9a23-abe2616210fb@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 Aug 2022 10:06:03 -0700
Message-ID: <CAP-5=fWtnraWWbcFLGOnnjoMG+BaFspsn0CpH9G4WS0RdLqogg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf vendor events: Remove bad broadwellde uncore events
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
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

On Wed, Aug 3, 2022 at 6:33 AM Liang, Kan <kan.liang@linux.intel.com> wrote=
:
>
>
>
> On 2022-08-03 2:38 a.m., Ian Rogers wrote:
> > The event converter scripts at:
> > https://github.com/intel/event-converter-for-linux-perf
> > passes Filter values from data on 01.org that is bogus in a perf comman=
d
> > line and can cause perf to infinitely recurse in parse events. Remove
> > such events using the updated patch:
> > https://github.com/intel/event-converter-for-linux-perf/pull/15/commits=
/485e42418d4f520a641994a1b041c149bb34f4a6
> >
> > Fixes: ef908a192512 ("perf vendor events: Update Intel broadwellde")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../arch/x86/broadwellde/uncore-cache.json    | 455 ------------------
> >  .../arch/x86/broadwellde/uncore-other.json    |  33 --
> >  2 files changed, 488 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.js=
on b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> > index caadbca1b15b..75655478952f 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> > @@ -32,72 +32,6 @@
> >          "PublicDescription": "Counts the number of cycles either the l=
ocal distress or incoming distress signals are asserted.  Incoming distress=
 includes both up and dn.",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "Cache Lookups; Any Request",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x34",
> > -        "EventName": "UNC_C_LLC_LOOKUP.ANY",
> > -        "Filter": "CBoFilter0[23:17]",
>
>
> The bogus Filter value is introduced from the previous commit ef908a19251=
2.
>
> +    {
> +        "BriefDescription": "Cache Lookups; Any Request",
>          "Counter": "0,1,2,3",
>          "EventCode": "0x34",
>          "EventName": "UNC_C_LLC_LOOKUP.ANY",
> -        "Filter": "filter_state=3D0x1",
> +        "Filter": "CBoFilter0[23:17]",
>          "PerPkg": "1",
> -        "ScaleUnit": "64Bytes",
> +        "PublicDescription": "Counts the number of times the LLC was
> accessed - this includes code, data, prefetches and hints coming from
> L2.  This has numerous filters available.  Note the non-standard
> filtering equation.  This event will count requests that lookup the
> cache multiple times with multiple increments.  One must ALWAYS set
> umask bit 0 and select a state or states to match.  Otherwise, the event
> will count nothing.   CBoGlCtrl[22:18] bits correspond to [FMESI]
> state.; Filters for any transaction originating from the IPQ or IRQ.
> This does not include lookups originating from the ISMQ.",
>          "UMask": "0x11",
>          "Unit": "CBO"
>      },
>
> If I recall correctly, the event list in the 01.org should always have
> Filter value CBoFilter0[23:17]. It probably be the converter tool to
> change it to "filter_state=3D0x1". I'm not sure why the converter tool
> doesn't do it now.
>
> If that's the case, I think we should fix the current converter tool,
> rather than simply delete the event.
>
> Also, it seems the bogus Filter value is not captured by the perf test.
> I think it's better to improve the perf test to test it.
>
>
> Thanks,
> Kan

Thanks Kan,

There is an existing CHAFilter drop, which skips a bunch of events on
more recent architectures than broadwellde/Ivytown/jaketown:
https://github.com/intel/event-converter-for-linux-perf/blob/master/uncore_=
csv_json.py#L243

I would like to include these events too, but I don't believe 1 is the
correct constant in all cases, there is also the difference between
filter_state and filter_opc, etc. I spent some time looking into this
but couldn't convince myself anything I'd do would be correct.

These changes fix an issue that causes perf to crash at
startup/parse-events PMU initialization on these models. I think we
should prioritize landing this fix and then follow up with the
corrected events. Correcting them can also fix the CHAFilter issue
too, which would have a wider impact.

Thanks,
Ian

> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of times the LLC was a=
ccessed - this includes code, data, prefetches and hints coming from L2.  T=
his has numerous filters available.  Note the non-standard filtering equati=
on.  This event will count requests that lookup the cache multiple times wi=
th multiple increments.  One must ALWAYS set umask bit 0 and select a state=
 or states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[=
22:18] bits correspond to [FMESI] state.; Filters for any transaction origi=
nating from the IPQ or IRQ.  This does not include lookups originating from=
 the ISMQ.",
> > -        "UMask": "0x11",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "Cache Lookups; Data Read Request",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x34",
> > -        "EventName": "UNC_C_LLC_LOOKUP.DATA_READ",
> > -        "Filter": "CBoFilter0[23:17]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of times the LLC was a=
ccessed - this includes code, data, prefetches and hints coming from L2.  T=
his has numerous filters available.  Note the non-standard filtering equati=
on.  This event will count requests that lookup the cache multiple times wi=
th multiple increments.  One must ALWAYS set umask bit 0 and select a state=
 or states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[=
22:18] bits correspond to [FMESI] state.; Read transactions",
> > -        "UMask": "0x3",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "Cache Lookups; Lookups that Match NID",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x34",
> > -        "EventName": "UNC_C_LLC_LOOKUP.NID",
> > -        "Filter": "CBoFilter0[23:17]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of times the LLC was a=
ccessed - this includes code, data, prefetches and hints coming from L2.  T=
his has numerous filters available.  Note the non-standard filtering equati=
on.  This event will count requests that lookup the cache multiple times wi=
th multiple increments.  One must ALWAYS set umask bit 0 and select a state=
 or states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[=
22:18] bits correspond to [FMESI] state.; Qualify one of the other subevent=
s by the Target NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTER.nid. =
  In conjunction with STATE =3D I, it is possible to monitor misses to spec=
ific NIDs in the system.",
> > -        "UMask": "0x41",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "Cache Lookups; Any Read Request",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x34",
> > -        "EventName": "UNC_C_LLC_LOOKUP.READ",
> > -        "Filter": "CBoFilter0[22:18]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of times the LLC was a=
ccessed - this includes code, data, prefetches and hints coming from L2.  T=
his has numerous filters available.  Note the non-standard filtering equati=
on.  This event will count requests that lookup the cache multiple times wi=
th multiple increments.  One must ALWAYS set umask bit 0 and select a state=
 or states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[=
22:18] bits correspond to [FMESI] state.; Read transactions",
> > -        "UMask": "0x21",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "Cache Lookups; External Snoop Request",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x34",
> > -        "EventName": "UNC_C_LLC_LOOKUP.REMOTE_SNOOP",
> > -        "Filter": "CBoFilter0[23:17]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of times the LLC was a=
ccessed - this includes code, data, prefetches and hints coming from L2.  T=
his has numerous filters available.  Note the non-standard filtering equati=
on.  This event will count requests that lookup the cache multiple times wi=
th multiple increments.  One must ALWAYS set umask bit 0 and select a state=
 or states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[=
22:18] bits correspond to [FMESI] state.; Filters for only snoop requests c=
oming from the remote socket(s) through the IPQ.",
> > -        "UMask": "0x9",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "Cache Lookups; Write Requests",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x34",
> > -        "EventName": "UNC_C_LLC_LOOKUP.WRITE",
> > -        "Filter": "CBoFilter0[23:17]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of times the LLC was a=
ccessed - this includes code, data, prefetches and hints coming from L2.  T=
his has numerous filters available.  Note the non-standard filtering equati=
on.  This event will count requests that lookup the cache multiple times wi=
th multiple increments.  One must ALWAYS set umask bit 0 and select a state=
 or states to match.  Otherwise, the event will count nothing.   CBoGlCtrl[=
22:18] bits correspond to [FMESI] state.; Writeback transactions from L2 to=
 the LLC  This includes all write transactions -- both Cachable and UC.",
> > -        "UMask": "0x5",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "Lines Victimized; Lines in E state",
> >          "Counter": "0,1,2,3",
> > @@ -148,17 +82,6 @@
> >          "UMask": "0x1",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "Lines Victimized; Victimized Lines that M=
atch NID",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x37",
> > -        "EventName": "UNC_C_LLC_VICTIMS.NID",
> > -        "Filter": "CBoFilter1[17:10]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of lines that were vic=
timized on a fill.  This can be filtered by the state that the line was in.=
; Qualify one of the other subevents by the Target NID.  The NID is program=
med in Cn_MSR_PMON_BOX_FILTER.nid.   In conjunction with STATE =3D I, it is=
 possible to monitor misses to specific NIDs in the system.",
> > -        "UMask": "0x40",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "Cbo Misc; DRd hitting non-M with raw CV=
=3D0",
> >          "Counter": "0,1,2,3",
> > @@ -789,17 +712,6 @@
> >          "UMask": "0x1",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "Probe Queue Retries; Target Node Filter",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x28",
> > -        "EventName": "UNC_C_RxR_IPQ_RETRY2.TARGET",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Number of times a snoop (probe) request =
had to retry.  Filters exist to cover some of the common cases retries.; Co=
unts the number of times that a request from the IPQ was retried filtered b=
y the Target NodeID as specified in the Cbox's Filter register.",
> > -        "UMask": "0x40",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "Ingress Request Queue Rejects; Address Co=
nflict",
> >          "Counter": "0,1,2,3",
> > @@ -840,17 +752,6 @@
> >          "UMask": "0x20",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "Ingress Request Queue Rejects",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x32",
> > -        "EventName": "UNC_C_RxR_IRQ_RETRY.NID",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Qualify one of the other subevents by a =
given RTID destination NID.  The NID is programmed in Cn_MSR_PMON_BOX_FILTE=
R1.nid.",
> > -        "UMask": "0x40",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "Ingress Request Queue Rejects; No QPI Cre=
dits",
> >          "Counter": "0,1,2,3",
> > @@ -891,17 +792,6 @@
> >          "UMask": "0x2",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "Ingress Request Queue Rejects; Target Nod=
e Filter",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x29",
> > -        "EventName": "UNC_C_RxR_IRQ_RETRY2.TARGET",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of times that a reques=
t from the IPQ was retried filtered by the Target NodeID as specified in th=
e Cbox's Filter register.",
> > -        "UMask": "0x40",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "ISMQ Retries; Any Reject",
> >          "Counter": "0,1,2,3",
> > @@ -932,17 +822,6 @@
> >          "UMask": "0x20",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "ISMQ Retries",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x33",
> > -        "EventName": "UNC_C_RxR_ISMQ_RETRY.NID",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Number of times a transaction flowing th=
rough the ISMQ had to retry.  Transaction pass through the ISMQ as response=
s for requests that already exist in the Cbo.  Some examples include: when =
data is returned or when snoop responses come back from the cores.; Qualify=
 one of the other subevents by a given RTID destination NID.  The NID is pr=
ogrammed in Cn_MSR_PMON_BOX_FILTER1.nid.",
> > -        "UMask": "0x40",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "ISMQ Retries; No QPI Credits",
> >          "Counter": "0,1,2,3",
> > @@ -963,17 +842,6 @@
> >          "UMask": "0x8",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "ISMQ Retries",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x33",
> > -        "EventName": "UNC_C_RxR_ISMQ_RETRY.WB_CREDITS",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Number of times a transaction flowing th=
rough the ISMQ had to retry.  Transaction pass through the ISMQ as response=
s for requests that already exist in the Cbo.  Some examples include: when =
data is returned or when snoop responses come back from the cores.; Qualify=
 one of the other subevents by a given RTID destination NID.  The NID is pr=
ogrammed in Cn_MSR_PMON_BOX_FILTER1.nid.",
> > -        "UMask": "0x80",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "ISMQ Request Queue Rejects; No AD Sbo Cre=
dits",
> >          "Counter": "0,1,2,3",
> > @@ -994,17 +862,6 @@
> >          "UMask": "0x2",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "ISMQ Request Queue Rejects; Target Node F=
ilter",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x2A",
> > -        "EventName": "UNC_C_RxR_ISMQ_RETRY2.TARGET",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of times that a reques=
t from the ISMQ was retried filtered by the Target NodeID as specified in t=
he Cbox's Filter register.",
> > -        "UMask": "0x40",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "Ingress Occupancy; IPQ",
> >          "EventCode": "0x11",
> > @@ -1109,17 +966,6 @@
> >          "UMask": "0x28",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "TOR Inserts; Local Memory - Opcode Matche=
d",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.LOCAL_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, sat=
isifed by an opcode,  inserted into the TOR that are satisifed by locally H=
OMed memory.",
> > -        "UMask": "0x21",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "TOR Inserts; Misses to Local Memory",
> >          "Counter": "0,1,2,3",
> > @@ -1130,28 +976,6 @@
> >          "UMask": "0x2A",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "TOR Inserts; Misses to Local Memory - Opc=
ode Matched",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sa=
tisifed by an opcode, inserted into the TOR that are satisifed by locally H=
OMed memory.",
> > -        "UMask": "0x23",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Inserts; Miss Opcode Match",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.MISS_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions ins=
erted into the TOR that match an opcode.",
> > -        "UMask": "0x3",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "TOR Inserts; Misses to Remote Memory",
> >          "Counter": "0,1,2,3",
> > @@ -1162,94 +986,6 @@
> >          "UMask": "0x8A",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "TOR Inserts; Misses to Remote Memory - Op=
code Matched",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions, sa=
tisifed by an opcode,  inserted into the TOR that are satisifed by remote c=
aches or remote memory.",
> > -        "UMask": "0x83",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Inserts; NID Matched",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.NID_ALL",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched (matc=
hes an RTID destination) transactions inserted into the TOR.  The NID is pr=
ogrammed in Cn_MSR_PMON_BOX_FILTER.nid.  In conjunction with STATE =3D I, i=
t is possible to monitor misses to specific NIDs in the system.",
> > -        "UMask": "0x48",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Inserts; NID Matched Evictions",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.NID_EVICTION",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched eviction =
transactions inserted into the TOR.",
> > -        "UMask": "0x44",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Inserts; NID Matched Miss All",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_ALL",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All NID matched miss =
requests that were inserted into the TOR.",
> > -        "UMask": "0x4A",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Inserts; NID and Opcode Matched Miss"=
,
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.NID_MISS_OPCODE",
> > -        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Miss transactions ins=
erted into the TOR that match a NID and an opcode.",
> > -        "UMask": "0x43",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Inserts; NID and Opcode Matched",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.NID_OPCODE",
> > -        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted=
 into the TOR that match a NID and an opcode.",
> > -        "UMask": "0x41",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Inserts; NID Matched Writebacks",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.NID_WB",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; NID matched write tra=
nsactions inserted into the TOR.",
> > -        "UMask": "0x50",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Inserts; Opcode Match",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; Transactions inserted=
 into the TOR that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc)"=
,
> > -        "UMask": "0x1",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "TOR Inserts; Remote Memory",
> >          "Counter": "0,1,2,3",
> > @@ -1260,17 +996,6 @@
> >          "UMask": "0x88",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "TOR Inserts; Remote Memory - Opcode Match=
ed",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x35",
> > -        "EventName": "UNC_C_TOR_INSERTS.REMOTE_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of entries successfuly=
 inserted into the TOR that match  qualifications specified by the subevent=
.  There are a number of subevent 'filters' but only a subset of the subeve=
nt combinations are valid.  Subevents that require an opcode or NID match r=
equire the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set.  If, for exam=
ple, one wanted to count DRD Local Misses, one should select MISS_OPC_MATCH=
 and set Cn_MSR_PMON_BOX_FILTER.opc  to DRD (0x182).; All transactions, sat=
isifed by an opcode,  inserted into the TOR that are satisifed by remote ca=
ches or remote memory.",
> > -        "UMask": "0x81",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "TOR Inserts; Writebacks",
> >          "Counter": "0,1,2,3",
> > @@ -1308,16 +1033,6 @@
> >          "UMask": "0x28",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; Local Memory - Opcode Matc=
hed",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.LOCAL_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number o=
f outstanding  transactions, satisifed by an opcode,  in the TOR that are s=
atisifed by locally HOMed memory.",
> > -        "UMask": "0x21",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "TOR Occupancy; Miss All",
> >          "EventCode": "0x36",
> > @@ -1336,26 +1051,6 @@
> >          "UMask": "0x2A",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; Misses to Local Memory - O=
pcode Matched",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number o=
f outstanding Miss transactions, satisifed by an opcode, in the TOR that ar=
e satisifed by locally HOMed memory.",
> > -        "UMask": "0x23",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; Miss Opcode Match",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entr=
ies for miss transactions that match an opcode. This generally means that t=
he request was sent to memory or MMIO.",
> > -        "UMask": "0x3",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "TOR Occupancy",
> >          "EventCode": "0x36",
> > @@ -1365,86 +1060,6 @@
> >          "UMask": "0x8A",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; Misses to Remote Memory - =
Opcode Matched",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number o=
f outstanding Miss transactions, satisifed by an opcode, in the TOR that ar=
e satisifed by remote caches or remote memory.",
> > -        "UMask": "0x83",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; NID Matched",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_ALL",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number o=
f NID matched outstanding requests in the TOR.  The NID is programmed in Cn=
_MSR_PMON_BOX_FILTER.nid.In conjunction with STATE =3D I, it is possible to=
 monitor misses to specific NIDs in the system.",
> > -        "UMask": "0x48",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; NID Matched Evictions",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_EVICTION",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number o=
f outstanding NID matched eviction transactions in the TOR .",
> > -        "UMask": "0x44",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; NID Matched",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_ALL",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number o=
f outstanding Miss requests in the TOR that match a NID.",
> > -        "UMask": "0x4A",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; NID and Opcode Matched Mis=
s",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_MISS_OPCODE",
> > -        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number o=
f outstanding Miss requests in the TOR that match a NID and an opcode.",
> > -        "UMask": "0x43",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; NID and Opcode Matched",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_OPCODE",
> > -        "Filter": "CBoFilter1[28:20], CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entr=
ies that match a NID and an opcode.",
> > -        "UMask": "0x41",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; NID Matched Writebacks",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.NID_WB",
> > -        "Filter": "CBoFilter1[15:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); NID matc=
hed write transactions int the TOR.",
> > -        "UMask": "0x50",
> > -        "Unit": "CBO"
> > -    },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; Opcode Match",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); TOR entr=
ies that match an opcode (matched by Cn_MSR_PMON_BOX_FILTER.opc).",
> > -        "UMask": "0x1",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "TOR Occupancy",
> >          "EventCode": "0x36",
> > @@ -1454,16 +1069,6 @@
> >          "UMask": "0x88",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "TOR Occupancy; Remote Memory - Opcode Mat=
ched",
> > -        "EventCode": "0x36",
> > -        "EventName": "UNC_C_TOR_OCCUPANCY.REMOTE_OPCODE",
> > -        "Filter": "CBoFilter1[28:20]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "For each cycle, this event accumulates t=
he number of valid entries in the TOR that match qualifications specified b=
y the subevent.   There are a number of subevent 'filters' but only a subse=
t of the subevent combinations are valid.  Subevents that require an opcode=
 or NID match require the Cn_MSR_PMON_BOX_FILTER.{opc, nid} field to be set=
.  If, for example, one wanted to count DRD Local Misses, one should select=
 MISS_OPC_MATCH and set Cn_MSR_PMON_BOX_FILTER.opc to DRD (0x182); Number o=
f outstanding  transactions, satisifed by an opcode,  in the TOR that are s=
atisifed by remote caches or remote memory.",
> > -        "UMask": "0x81",
> > -        "Unit": "CBO"
> > -    },
> >      {
> >          "BriefDescription": "TOR Occupancy; Writebacks",
> >          "EventCode": "0x36",
> > @@ -1610,66 +1215,6 @@
> >          "UMask": "0x8",
> >          "Unit": "CBO"
> >      },
> > -    {
> > -        "BriefDescription": "QPI Address/Opcode Match; AD Opcodes",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x20",
> > -        "EventName": "UNC_H_ADDR_OPC_MATCH.AD",
> > -        "Filter": "HA_OpcodeMatch[5:0]",
> > -        "PerPkg": "1",
> > -        "UMask": "0x4",
> > -        "Unit": "HA"
> > -    },
> > -    {
> > -        "BriefDescription": "QPI Address/Opcode Match; Address",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x20",
> > -        "EventName": "UNC_H_ADDR_OPC_MATCH.ADDR",
> > -        "Filter": "HA_AddrMatch0[31:6], HA_AddrMatch1[13:0]",
> > -        "PerPkg": "1",
> > -        "UMask": "0x1",
> > -        "Unit": "HA"
> > -    },
> > -    {
> > -        "BriefDescription": "QPI Address/Opcode Match; AK Opcodes",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x20",
> > -        "EventName": "UNC_H_ADDR_OPC_MATCH.AK",
> > -        "Filter": "HA_OpcodeMatch[5:0]",
> > -        "PerPkg": "1",
> > -        "UMask": "0x10",
> > -        "Unit": "HA"
> > -    },
> > -    {
> > -        "BriefDescription": "QPI Address/Opcode Match; BL Opcodes",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x20",
> > -        "EventName": "UNC_H_ADDR_OPC_MATCH.BL",
> > -        "Filter": "HA_OpcodeMatch[5:0]",
> > -        "PerPkg": "1",
> > -        "UMask": "0x8",
> > -        "Unit": "HA"
> > -    },
> > -    {
> > -        "BriefDescription": "QPI Address/Opcode Match; Address & Opcod=
e Match",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x20",
> > -        "EventName": "UNC_H_ADDR_OPC_MATCH.FILT",
> > -        "Filter": "HA_AddrMatch0[31:6], HA_AddrMatch1[13:0], HA_Opcode=
Match[5:0]",
> > -        "PerPkg": "1",
> > -        "UMask": "0x3",
> > -        "Unit": "HA"
> > -    },
> > -    {
> > -        "BriefDescription": "QPI Address/Opcode Match; Opcode",
> > -        "Counter": "0,1,2,3",
> > -        "EventCode": "0x20",
> > -        "EventName": "UNC_H_ADDR_OPC_MATCH.OPC",
> > -        "Filter": "HA_OpcodeMatch[5:0]",
> > -        "PerPkg": "1",
> > -        "UMask": "0x2",
> > -        "Unit": "HA"
> > -    },
> >      {
> >          "BriefDescription": "BT Cycles Not Empty",
> >          "Counter": "0,1,2,3",
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.js=
on b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
> > index 71bdf75d8016..24c82ca873bd 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-other.json
> > @@ -416,17 +416,6 @@
> >          "UMask": "0x10",
> >          "Unit": "IRP"
> >      },
> > -    {
> > -        "BriefDescription": "Inbound Transaction Count; Select Source"=
,
> > -        "Counter": "0,1",
> > -        "EventCode": "0x16",
> > -        "EventName": "UNC_I_TRANSACTIONS.ORDERINGQ",
> > -        "Filter": "IRPFilter[4:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Counts the number of Inbound transaction=
s from the IRP to the Uncore.  This can be filtered based on request type i=
n addition to the source queue.  Note the special filtering equation.  We d=
o OR-reduction on the request type.  If the SOURCE bit is set, then we also=
 do AND qualification based on the source portID.; Tracks only those reques=
ts that come from the port specified in the IRP_PmonFilter.OrderingQ regist=
er.  This register allows one to select one specific queue.  It is not poss=
ible to monitor multiple queues at a time.  If this bit is not set, then re=
quests from all sources will be counted.",
> > -        "UMask": "0x40",
> > -        "Unit": "IRP"
> > -    },
> >      {
> >          "BriefDescription": "Inbound Transaction Count; Other",
> >          "Counter": "0,1",
> > @@ -1112,17 +1101,6 @@
> >          "UMask": "0x2",
> >          "Unit": "UBOX"
> >      },
> > -    {
> > -        "BriefDescription": "Filter Match",
> > -        "Counter": "0,1",
> > -        "EventCode": "0x41",
> > -        "EventName": "UNC_U_FILTER_MATCH.ENABLE",
> > -        "Filter": "UBoxFilter[3:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Filter match per thread (w/ or w/o Filte=
r Enable).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID=
.",
> > -        "UMask": "0x1",
> > -        "Unit": "UBOX"
> > -    },
> >      {
> >          "BriefDescription": "Filter Match",
> >          "Counter": "0,1",
> > @@ -1133,17 +1111,6 @@
> >          "UMask": "0x8",
> >          "Unit": "UBOX"
> >      },
> > -    {
> > -        "BriefDescription": "Filter Match",
> > -        "Counter": "0,1",
> > -        "EventCode": "0x41",
> > -        "EventName": "UNC_U_FILTER_MATCH.U2C_ENABLE",
> > -        "Filter": "UBoxFilter[3:0]",
> > -        "PerPkg": "1",
> > -        "PublicDescription": "Filter match per thread (w/ or w/o Filte=
r Enable).  Specify the thread to filter on using NCUPMONCTRLGLCTR.ThreadID=
.",
> > -        "UMask": "0x4",
> > -        "Unit": "UBOX"
> > -    },
> >      {
> >          "BriefDescription": "Cycles PHOLD Assert to Ack; Assert to ACK=
",
> >          "Counter": "0,1",
