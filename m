Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9475AA73E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiIBF32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBF3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:29:24 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04BD6580C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:29:23 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so2259125fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 22:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=q6wq+A6pCLZYiwmdMLVt66DYhPMTmpKmbDQR4DJbOX8=;
        b=ZchAN8UR/w4n2tL5DF95cMHVOMZ6ngBlSzTZr2My48NZR2iIVRBBCFgDY6HXMbT29I
         2FUVFev32TkMLWjqGIsDsDj++ZIDYQC+XZRqTiSAoeK+6+J2ZiZPEifYMmf510i2OYv9
         b8iQBPB9MQ6lBDQfWzB5AdQFIFSdS6uZGAK6olpvQ3EQOnz6JU9+AEVhwQdpnRmE5Dp0
         SzWykMQ/NO1782ntbMPSNXfGXLNk+mg9spZDb/hWKvxoZ5IDr+Bu8El8Z3H3D2tKrr95
         0rZKd2nmyCFffb2L6XWIeTEqH7dhb5j+2LQLXXbUZrlVSMW4HOotGLjWk7oNjra7daec
         iBeg==
X-Gm-Message-State: ACgBeo3AH4a2VPpKWPhN22XOpwzhH+8QsD2VW8fGZGtTEw4dKOxk8uZ8
        wGKYa+gRyYsNgXvviOhVuHMcpHd0pr/nKO+4vJJsMH6F
X-Google-Smtp-Source: AA6agR6fFcfHxtyxvAdHAgVf7PcMfb/cja6sBLHxtlY5lUkxCdOPaKKfji0KQzDrLzUM9TmWENgkZHAsrSFQxxqyM58=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr1397433oaf.5.1662096562934; Thu, 01 Sep
 2022 22:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220901130959.1285717-1-kan.liang@linux.intel.com> <20220901130959.1285717-5-kan.liang@linux.intel.com>
In-Reply-To: <20220901130959.1285717-5-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Sep 2022 22:29:12 -0700
Message-ID: <CAM9d7cgbgjz-X9Hv1o+kik+-QBAyDTShO4ChRiHehNFW+d_gOA@mail.gmail.com>
Subject: Re: [PATCH V2 4/6] perf: Use sample_flags for weight
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 6:10 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Use the new sample_flags to indicate whether the weight field is filled
> by the PMU driver.
>
> Remove the weight field from the perf_sample_data_init() to minimize the
> number of cache lines touched.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/powerpc/perf/core-book3s.c |  5 +++--
>  arch/x86/events/intel/ds.c      | 10 +++++++---
>  include/linux/perf_event.h      |  3 +--
>  kernel/events/core.c            |  3 +++
>  4 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 1ad1efdb33f9..a5c95a2006ea 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2305,9 +2305,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>                         ppmu->get_mem_data_src(&data.data_src, ppmu->flags, regs);
>
>                 if (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE &&
> -                                               ppmu->get_mem_weight)
> +                                               ppmu->get_mem_weight) {
>                         ppmu->get_mem_weight(&data.weight.full, event->attr.sample_type);
> -
> +                       data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
> +               }
>                 if (perf_event_overflow(event, &data, regs))
>                         power_pmu_stop(event, 0);
>         } else if (period) {
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 5dcfd2de6ef8..f66a4905cc87 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1535,8 +1535,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>         /*
>          * Use latency for weight (only avail with PEBS-LL)
>          */
> -       if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE))
> +       if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE)) {
>                 data->weight.full = pebs->lat;
> +               data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
> +       }
>
>         /*
>          * data.data_src encodes the data source
> @@ -1628,9 +1630,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>
>         if (x86_pmu.intel_cap.pebs_format >= 2) {
>                 /* Only set the TSX weight when no memory weight. */
> -               if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll)
> +               if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll) {
>                         data->weight.full = intel_get_tsx_weight(pebs->tsx_tuning);
> -
> +                       data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
> +               }
>                 if (sample_type & PERF_SAMPLE_TRANSACTION)
>                         data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
>                                                               pebs->ax);
> @@ -1772,6 +1775,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>                                 data->weight.var1_dw = (u32)(weight & PEBS_LATENCY_MASK) ?:
>                                         intel_get_tsx_weight(meminfo->tsx_tuning);
>                         }
> +                       data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;

I was thinking about splitting PERF_SAMPLE_WEIGHT and
PERF_SAMPLE_WEIGHT_STRUCT but it'd just add complexity
unnecessarily?

Thanks,
Namhyung

>                 }
>
>                 if (sample_type & PERF_SAMPLE_DATA_SRC)
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1e12e79454e0..06a587b5faa9 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1012,7 +1012,6 @@ struct perf_sample_data {
>         u64                             addr;
>         struct perf_raw_record          *raw;
>         u64                             period;
> -       union perf_sample_weight        weight;
>         u64                             txn;
>         union  perf_mem_data_src        data_src;
>
> @@ -1021,6 +1020,7 @@ struct perf_sample_data {
>          * perf_{prepare,output}_sample().
>          */
>         struct perf_branch_stack        *br_stack;
> +       union perf_sample_weight        weight;
>
>         u64                             type;
>         u64                             ip;
> @@ -1063,7 +1063,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>         data->addr = addr;
>         data->raw  = NULL;
>         data->period = period;
> -       data->weight.full = 0;
>         data->data_src.val = PERF_MEM_NA;
>         data->txn = 0;
>  }
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 104c0c9f4e6f..f0af45db02b3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7408,6 +7408,9 @@ void perf_prepare_sample(struct perf_event_header *header,
>                 header->size += size;
>         }
>
> +       if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
> +               data->weight.full = 0;
> +
>         if (sample_type & PERF_SAMPLE_REGS_INTR) {
>                 /* regs dump ABI info */
>                 int size = sizeof(u64);
> --
> 2.35.1
>
