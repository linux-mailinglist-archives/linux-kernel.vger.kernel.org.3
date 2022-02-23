Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF74C18FD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242955AbiBWQtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiBWQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:49:01 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C045B7DF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:48:33 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2d6923bca1aso209139937b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GLyN3TRZPlqJ5RwOtJrQLG6H3Ss7auyjkJskhRZNtj4=;
        b=b76slybem1Fn/0Dv+dTvp9xRx5aXkmajcuqYCQDwPeHcWYWVIZqMcvkHdDGPXYYYYL
         E0mAd3gR/HZJRFxT2sHbkSOhY1pqjk91n5R30x7EX0hM5QrF876qWoA3q0PCXu/tUJXL
         VamqZfcemmSf+9ivicuS4F8+6O279UZto1Jm1thVODdrapOYftUsA4SAKLtRQwBLLulD
         JgGwmq5OJuKnMjPm57uPT9v9v4Mks5vDETykwXKY/Zbz3BbhN+PV7Lu3UuC0yTWcHLfT
         BQFFDMVJ245zafHtj9x12xnr0ZhxICIQkCOt58NP9YLKAfYKyw3aY5N5G1f9LVE1kYhR
         9Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GLyN3TRZPlqJ5RwOtJrQLG6H3Ss7auyjkJskhRZNtj4=;
        b=t9qB6khsLCsCIxehdUCPrjJ03zsx8KicEWH5YHc+9UuY7T4HVWZKlj++bOue42+ipZ
         /A1tzg6Y1qmFSekADmg8ElGMMUvcaq+xK539L2HNqaA1OXPbEyns1+FFSepYmf5OeEQm
         xf8OuaYTFspsz4i0Y30TL0braYknno0qRDEFAt7vBlN324CgkQM9wlDLkqjYxVnqyfTE
         PBRuUxRsK4bJ59NIm5vGLuMWckv6Z4mOt+coo/BK5JOyofhbnsM7S07r8KZ6NxSKeVgG
         Y9DU2+vQqNJnhENNM0K4/xPmGQuVx/OtdhlS/zJDSYb1M52GseePenUhY8OuzRdC7kU/
         XzAA==
X-Gm-Message-State: AOAM531u5q3TqKb+YRKPaK/tDDnLK1E5bC0jAoBVZRFTHSRivC4VnoVG
        kzSwnB+wifGzOEaMdN50ioBuDZDqkNSI6riuPmoptw==
X-Google-Smtp-Source: ABdhPJwgSVsCB2stPxsXkzt3E/eFSLY1Ukwn5NVLWhMpEDekfQnDELF8ivALo2R2H3M/Tt10RAjk52I/cAzF9PdA/cg=
X-Received: by 2002:a81:57d0:0:b0:2d0:cd0d:6007 with SMTP id
 l199-20020a8157d0000000b002d0cd0d6007mr472771ywb.454.1645634911839; Wed, 23
 Feb 2022 08:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20220223110135.1943210-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220223110135.1943210-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Feb 2022 08:48:19 -0800
Message-ID: <CAP-5=fXWZ1vJqfU4TXedGVYNpj-RjVsQsrtggnGMZQR9C0-Yew@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf vendor events intel: Add uncore event list for Alderlake
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 7:02 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Add JSON uncore events for Alderlake to perf.
>
> Based on JSON list v1.06:
>
> https://download.01.org/perfmon/ADL/

Acked-by: Ian Rogers <irogers@google.com>

Could you post the uncore csv file on:
https://github.com/intel/event-converter-for-linux-perf
For example, the skylakex one is:
https://github.com/intel/event-converter-for-linux-perf/blob/master/perf-un=
core-events-skx.csv

Thanks,
Ian

> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>  .../arch/x86/alderlake/uncore-memory.json     | 222 ++++++++++++++++++
>  .../arch/x86/alderlake/uncore-other.json      |  40 ++++
>  2 files changed, 262 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-memor=
y.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-other=
.json
>
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json =
b/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
> new file mode 100644
> index 000000000000..d82d6f62a6fb
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
> @@ -0,0 +1,222 @@
> +[
> +    {
> +        "BriefDescription": "Number of clocks",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x01",
> +        "EventName": "UNC_M_CLOCKTICKS",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming VC0 read request",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x02",
> +        "EventName": "UNC_M_VC0_REQUESTS_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming VC0 write request",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x03",
> +        "EventName": "UNC_M_VC0_REQUESTS_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming VC1 read request",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x04",
> +        "EventName": "UNC_M_VC1_REQUESTS_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming VC1 write request",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x05",
> +        "EventName": "UNC_M_VC1_REQUESTS_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming read prefetch request from IA",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x0A",
> +        "EventName": "UNC_M_PREFETCH_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Any Rank at Hot state",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x19",
> +        "EventName": "UNC_M_DRAM_THERMAL_HOT",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Any Rank at Warm state",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1A",
> +        "EventName": "UNC_M_DRAM_THERMAL_WARM",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming read request page status is Page H=
it",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1C",
> +        "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming read request page status is Page E=
mpty",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1D",
> +        "EventName": "UNC_M_DRAM_PAGE_EMPTY_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming read request page status is Page M=
iss",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1E",
> +        "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming write request page status is Page =
Hit",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1F",
> +        "EventName": "UNC_M_DRAM_PAGE_HIT_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming write request page status is Page =
Empty",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x20",
> +        "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming write request page status is Page =
Miss",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x21",
> +        "EventName": "UNC_M_DRAM_PAGE_MISS_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Read CAS command sent to DRAM",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x22",
> +        "EventName": "UNC_M_CAS_COUNT_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Write CAS command sent to DRAM",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x23",
> +        "EventName": "UNC_M_CAS_COUNT_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "ACT command for a read request sent to DRAM=
",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x24",
> +        "EventName": "UNC_M_ACT_COUNT_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "ACT command for a write request sent to DRA=
M",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x25",
> +        "EventName": "UNC_M_ACT_COUNT_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "ACT command sent to DRAM",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x26",
> +        "EventName": "UNC_M_ACT_COUNT_TOTAL",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "PRE command sent to DRAM for a read/write r=
equest",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x27",
> +        "EventName": "UNC_M_PRE_COUNT_PAGE_MISS",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "PRE command sent to DRAM due to page table =
idle timer expiration",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x28",
> +        "EventName": "UNC_M_PRE_COUNT_IDLE",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Counts every 64B read  request entering the=
 Memory Controller 0 to DRAM (sum of all channels)",
> +        "CounterType": "FREERUN",
> +        "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Counts every 64B read request entering the =
Memory Controller 1 to DRAM (sum of all channels)",
> +        "Counter": "3",
> +        "CounterType": "FREERUN",
> +        "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Counts every 64B write request entering the=
 Memory Controller 0 to DRAM (sum of all channels). Each write request coun=
ts as a new request incrementing this counter. However, same cache line wri=
te requests (both full and partial) are combined to a single 64 byte data t=
ransfer to DRAM",
> +        "Counter": "1",
> +        "CounterType": "FREERUN",
> +        "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Counts every 64B write request entering the=
 Memory Controller 1 to DRAM (sum of all channels). Each write request coun=
ts as a new request incrementing this counter. However, same cache line wri=
te requests (both full and partial) are combined to a single 64 byte data t=
ransfer to DRAM",
> +        "Counter": "4",
> +        "CounterType": "FREERUN",
> +        "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b=
/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
> new file mode 100644
> index 000000000000..50de82c29944
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
> @@ -0,0 +1,40 @@
> +[
> +    {
> +        "BriefDescription": "This 48-bit fixed counter counts the UCLK c=
ycles",
> +        "Counter": "Fixed",
> +        "CounterType": "PGMABLE",
> +       "EventCode": "0xff",
> +        "EventName": "UNC_CLOCK.SOCKET",
> +        "PerPkg": "1",
> +        "Unit": "CLOCK"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of coherent and in-cohere=
nt requests initiated by IA cores, processor graphic units, or LLC",
> +        "Counter": "0,1",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x81",
> +        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
> +        "PerPkg": "1",
> +        "UMask": "0x01",
> +        "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "Number of requests allocated in Coherency T=
racker",
> +        "Counter": "0,1",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
> +        "PerPkg": "1",
> +        "UMask": "0x01",
> +        "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "Each cycle counts number of all outgoing va=
lid entries in ReqTrk. Such entry is defined as valid from its allocation i=
n ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic"=
,
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x80",
> +        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
> +        "PerPkg": "1",
> +        "UMask": "0x01",
> +        "Unit": "ARB"
> +    }
> +]
> --
> 2.25.1
>
