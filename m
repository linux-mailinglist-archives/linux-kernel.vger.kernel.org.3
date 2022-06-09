Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AC544B44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbiFIMFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbiFIMFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:05:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF251C792C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:05:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a15so37623060lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkqNvRH4Nue6fdbta9cxcgqLM1LMKqMxVWrvF9XcLFQ=;
        b=NmOW1JYwMEntHiUINUVDl0Dqc0b5Ifv91b3afpcgMUTllO2Vk8wjRaXnhHQrO4EL13
         y+pSjZl7jRbxnLmO6w9lMAYroYpyWgz3WgnriI2AVqtf6IULDSf44PHZRCoIG0E8PAwJ
         FlaPmoei9Z5Z1mCFfX5QSmcaGtRKNS+xe2dylcc06VmomyauMq5lwi+lSaO6ENDm0cNR
         g8ouhtIEAPKUJbb/lc/1zzl9yqWr4ZwKa3GcLOQle86pbv770EDJ87pB0XcVITQ5s4+0
         AaTI4fENDPfhg5on26HEqv82GuZtGu815FH1flK0dSVpT6ukVM1/bZofmX1MT3pD/hU7
         N1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkqNvRH4Nue6fdbta9cxcgqLM1LMKqMxVWrvF9XcLFQ=;
        b=rw9U1scAQuAxaJH237FHEh3zQTdFYhNOyNyvmamZgDx4goSZHvAO/L9Wzii1rIpGGF
         CsvP3z812ICA4MnDN3X+3DqcIh/o0k5Li0Up8TaTFgqf+1ijoNSXtzf/JyA2BDIHZE+P
         kSfoTv0w+PlibduXBSQqz2rfXuNitNy2yxQUY7GO1oWMxl/WlXEAkWtgV1AtNFyzkyeY
         4l1EvHW4NExSvrWa83/TZWYBa9AFK2ugWHPU3Ao4tM58FFVoFYLbHa0Gq93SaJnHKbUn
         xOxP3J6wS0buYk+FhVKVjkCN9ltCcWkHFByMp4YB1jyn88/NuPry2Sz2Mz40iApIjByj
         wn1Q==
X-Gm-Message-State: AOAM533aQxy1KDyUNSLYDJ/UThENwe5IW79yajgi36Z1Bas9E9sVldFL
        cnXRLIPsLTAAxMspWo8qcqPV9LfzXPp6D3lV1SgOAA==
X-Google-Smtp-Source: ABdhPJzMhrxkLlnUXaKPQpDgRlkqURbWXFX5fn51UX8fc4BcPN/rnIY8a4TDILlakPMcFi5PiU8wbHGT0P/XduV0Syk=
X-Received: by 2002:a05:6512:1588:b0:477:a556:4ab2 with SMTP id
 bp8-20020a056512158800b00477a5564ab2mr24570497lfb.376.1654776307498; Thu, 09
 Jun 2022 05:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-6-elver@google.com>
In-Reply-To: <20220609113046.780504-6-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 14:04:55 +0200
Message-ID: <CACT4Y+Zd0Zd_66DZ-f2HG4tR6ZdraFe9b4iEBJmG9p72+7RMWQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf/hw_breakpoint: Remove useless code related to
 flexible breakpoints
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
>
> Flexible breakpoints have never been implemented, with
> bp_cpuinfo::flexible always being 0. Unfortunately, they still occupy 4
> bytes in each bp_cpuinfo and bp_busy_slots, as well as computing the max
> flexible count in fetch_bp_busy_slots().
>
> This again causes suboptimal code generation, when we always know that
> `!!slots.flexible` will be 0.
>
> Just get rid of the flexible "placeholder" and remove all real code
> related to it. Make a note in the comment related to the constraints
> algorithm but don't remove them from the algorithm, so that if in future
> flexible breakpoints need supporting, it should be trivial to revive
> them (along with reverting this change).
>
> Signed-off-by: Marco Elver <elver@google.com>

Was added in 2009.

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/events/hw_breakpoint.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 5f40c8dfa042..afe0a6007e96 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -46,8 +46,6 @@ struct bp_cpuinfo {
>  #else
>         unsigned int    *tsk_pinned;
>  #endif
> -       /* Number of non-pinned cpu/task breakpoints in a cpu */
> -       unsigned int    flexible; /* XXX: placeholder, see fetch_this_slot() */
>  };
>
>  static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
> @@ -71,7 +69,6 @@ static bool constraints_initialized __ro_after_init;
>  /* Gather the number of total pinned and un-pinned bp in a cpuset */
>  struct bp_busy_slots {
>         unsigned int pinned;
> -       unsigned int flexible;
>  };
>
>  /* Serialize accesses to the above constraints */
> @@ -213,10 +210,6 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
>
>                 if (nr > slots->pinned)
>                         slots->pinned = nr;
> -
> -               nr = info->flexible;
> -               if (nr > slots->flexible)
> -                       slots->flexible = nr;
>         }
>  }
>
> @@ -299,7 +292,8 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
>  }
>
>  /*
> - * Constraints to check before allowing this new breakpoint counter:
> + * Constraints to check before allowing this new breakpoint counter. Note that
> + * flexible breakpoints are currently unsupported -- see fetch_this_slot().
>   *
>   *  == Non-pinned counter == (Considered as pinned for now)
>   *
> @@ -366,7 +360,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
>         fetch_this_slot(&slots, weight);
>
>         /* Flexible counters need to keep at least one slot */
> -       if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
> +       if (slots.pinned > hw_breakpoint_slots_cached(type))
>                 return -ENOSPC;
>
>         ret = arch_reserve_bp_slot(bp);
> --
> 2.36.1.255.ge46751e96f-goog
>
