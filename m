Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4473543FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiFHXZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFHXZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:25:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0C1C592E;
        Wed,  8 Jun 2022 16:25:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3789461972;
        Wed,  8 Jun 2022 23:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A66EC3411F;
        Wed,  8 Jun 2022 23:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654730700;
        bh=/54/gVROgLr5qQY4rtAyH8h2zB+YMwZbBjyQWM6yJhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EdXRWBo3vDGGkyj7q0RpwIrHZdCCcBcdsfOMi9y4ZhSdjtrbG89YAxJf3d+RpUjBI
         8UNED3ptlpX5TlC06t0hGeHH6HaCbHXYwcF9cD3o5xZyUDYUCUwQSqm3Y3Pygb+6l/
         8ipD71kISWSYGO9DVz7FY+e32W0bBdUnE1FLd/GTVgp68qzLQLb+SDyTcW4sBoeR9H
         TNYwcVWeNGLj1C6BK4fGv+ETDGZu51gom2nqlXCRNZZ4ne5Ifsf1iOf9vRVqbFV6JL
         dqh9S6VETsKGAmMad6yOHkRhyifTXSPF8kBpXosG95n4UH/8J4bJimZc9evra/3wlK
         ek5re1NXcwDeg==
Received: by mail-vs1-f44.google.com with SMTP id g6so2824803vsb.2;
        Wed, 08 Jun 2022 16:25:00 -0700 (PDT)
X-Gm-Message-State: AOAM531zEa3zhZJL1XzFjoRdU3FRoiQ9V+xQ4UgT8lt8Dg7LSc2VTgiT
        Vrxmqe8Qyzt2DJh0DPl+gI2bC02P2PYQl7y8pg==
X-Google-Smtp-Source: ABdhPJzWxQGJAMhtx0Dvcq9Zk0kOqrOKJJk3dNMlgHPH0V9YOCpLsXowpyLL92Uc9tkUpq8g15bZX3gmqCPo1juG31o=
X-Received: by 2002:a67:d38c:0:b0:349:d028:c8ea with SMTP id
 b12-20020a67d38c000000b00349d028c8eamr16309163vsj.6.1654730699492; Wed, 08
 Jun 2022 16:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220608224353.1176079-1-irogers@google.com> <20220608224353.1176079-3-irogers@google.com>
In-Reply-To: <20220608224353.1176079-3-irogers@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 8 Jun 2022 17:24:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+rWB7AYr4THs2Dg98ss8cuL38QVuvTbQNwar2ePqwuww@mail.gmail.com>
Message-ID: <CAL_Jsq+rWB7AYr4THs2Dg98ss8cuL38QVuvTbQNwar2ePqwuww@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf: Align user space counter reading with code
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 4:44 PM Ian Rogers <irogers@google.com> wrote:
>
> Align the user space counter reading documentation with the code in
> perf_mmap__read_self. Previously the documentation was based on the perf
> rdpmc test, but now general purpose code is provided by libperf.

IMO, this copy of not quite right code should just be removed perhaps
with a pointer to perf_mmap__read_self(). It will just get out of date
again. For example, the read loop might get rewritten with restartable
sequences.

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/uapi/linux/perf_event.h       | 32 ++++++++++++++++-----------
>  tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++-----------
>  2 files changed, 38 insertions(+), 26 deletions(-)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index d37629dbad72..3b84e0ad0723 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
>          *
>          *     if (pc->cap_usr_time && enabled != running) {
>          *       cyc = rdtsc();

Kind of x86 specific.

> -        *       time_offset = pc->time_offset;
>          *       time_mult   = pc->time_mult;
>          *       time_shift  = pc->time_shift;
> +        *       time_offset = pc->time_offset;
> +        *       if (pc->cap_user_time_short) {
> +        *         time_cycles = pc->time_cycles;
> +        *         time_mask = pc->time_mask;
> +        *       }

This still misses the need for READ_ONCE().

>          *     }
>          *
>          *     index = pc->index;
> @@ -548,6 +552,9 @@ struct perf_event_mmap_page {
>          *     if (pc->cap_user_rdpmc && index) {
>          *       width = pc->pmc_width;
>          *       pmc = rdpmc(index - 1);
> +        *       pmc <<= 64 - width;
> +        *       pmc >>= 64 - width;
> +        *       count += pmc;
>          *     }
>          *
>          *     barrier();
> @@ -590,25 +597,24 @@ struct perf_event_mmap_page {
>          * If cap_usr_time the below fields can be used to compute the time
>          * delta since time_enabled (in ns) using rdtsc or similar.
>          *
> -        *   u64 quot, rem;
> -        *   u64 delta;
> -        *
> -        *   quot = (cyc >> time_shift);
> -        *   rem = cyc & (((u64)1 << time_shift) - 1);
> -        *   delta = time_offset + quot * time_mult +
> -        *              ((rem * time_mult) >> time_shift);
> +        *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> +        *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);

For documentation purposes, the original code was easier to read and
this is just an optimization. What does mul_u64_u32_shr() do exactly?
It's not documented.

>          *
>          * Where time_offset,time_mult,time_shift and cyc are read in the
>          * seqcount loop described above. This delta can then be added to
> -        * enabled and possible running (if index), improving the scaling:
> +        * enabled and possible running (if index) to improve the scaling. Due
> +        * to event multiplexing, running maybe zero and so care is needed to
> +        * avoid division by zero.
>          *
>          *   enabled += delta;
> -        *   if (index)
> +        *   if (idx)
>          *     running += delta;
>          *
> -        *   quot = count / running;
> -        *   rem  = count % running;
> -        *   count = quot * enabled + (rem * enabled) / running;
> +        *   if (running != 0) {
> +        *     quot = count / running;
> +        *     rem  = count % running;
> +        *     count = quot * enabled + (rem * enabled) / running;
> +        *   }
>          */
>         __u16   time_shift;
>         __u32   time_mult;
