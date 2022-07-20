Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F61557B9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiGTPdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiGTPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:32:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FEE61D6C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:32:58 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id id17so4003525wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXRVB9OIIhdX/URjZNl0v6pVC+o3sTM2QCDmzX1vQJc=;
        b=rtE6DDogJhUh+ZtpN70YLu2ZmXY6CdKqcLHxcq0UtGow0+ie8eT3w/DFXyTOdGk2qn
         9qXeHyATZP9kX/Z6EhXLAEUHnWAYA+EyhDv3lnKJZM12itGYkI5F7A/gGzqqwOL5Zbzc
         fEvl5gpqnwtXWQc1hdvpSjF4JR7aLXOGSfzOGl0nS1bcGnfeYQoFtvJij5eTNji5VBEr
         J0/m6f2HyiaMiPNxbylBgOVgiii6EqD369gArU7xbJglNvg86B3i9b+Z4GrM1mKVvtOm
         P9SinFz14vcVy8P0eoINmmFeh8MAMRMU5MeNvwIOpvYaanl3HotPG62I8xu3ViSvW2zT
         +6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXRVB9OIIhdX/URjZNl0v6pVC+o3sTM2QCDmzX1vQJc=;
        b=S3b6EXdH2CKCxcMm4TwHrTjUHskvPoLkNZw9/op6jsu7aMKYU2K7H3aBDosxjmgewi
         HZRe8oIIsWQ41M1gMe/IRBKcxHh07sSHOaMxcGHsgxjRzPJ7mNET8d/55jGnvuuBCzBW
         UVjmBkN/zEI7wUf2CVvpfNBQDogAy5tp9RmKxFlDOfZnOdn6GsVlm4n+JexKy+zSF1qe
         jbruPylmrTN75HqUMtpmEhqPK26oEXSEBp16895zGok4ChMjInqSAzEF3gOOhAOkhkke
         JMxcMGCRcAUS5Uwv/BheW71oB5zhLw5TUdNXwIc+Duv7cPoMT512E4kuQCs5z3goYu82
         C9rg==
X-Gm-Message-State: AJIora/brs/rUg0/dvNV5m6wyK4YLZOB2VoSzNJxlMTiFGuMXo+emEXg
        5KAlw0aUx3LKrkbQCl/hEiVfO1O8oi0m8rzKukvWYQ==
X-Google-Smtp-Source: AGRyM1uKEr8mdMUyiaQkbnJMsIqtKZlyztLCldKuCxnZuhty8HbuiUhiD4EwDJT4EsNMfKUDzW3f/+pF3GTbtebQt3Y=
X-Received: by 2002:a7b:ce13:0:b0:3a3:102c:23d3 with SMTP id
 m19-20020a7bce13000000b003a3102c23d3mr4328674wmc.67.1658331176588; Wed, 20
 Jul 2022 08:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-8-elver@google.com>
In-Reply-To: <20220704150514.48816-8-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:32:44 -0700
Message-ID: <CAP-5=fWTZ7f4TvJX_S4vZ3os2DBZGWE4qkyu9ro8ufs10A01Ow@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
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
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jul 4, 2022 at 8:06 AM Marco Elver <elver@google.com> wrote:
>
> Due to being a __weak function, hw_breakpoint_weight() will cause the
> compiler to always emit a call to it. This generates unnecessarily bad
> code (register spills etc.) for no good reason; in fact it appears in
> profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:
>
>     ...
>     0.70%  [kernel]       [k] hw_breakpoint_weight
>     ...
>
> While a small percentage, no architecture defines its own
> hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
> which makes the fact it is currently __weak a poor choice.
>
> Change hw_breakpoint_weight()'s definition to follow a similar protocol
> to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
> hw_breakpoint_weight(), we'll use it instead.
>
> The result is that it is inlined and no longer shows up in profiles.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/hw_breakpoint.h | 1 -
>  kernel/events/hw_breakpoint.c | 4 +++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> index a3fb846705eb..f319bd26b030 100644
> --- a/include/linux/hw_breakpoint.h
> +++ b/include/linux/hw_breakpoint.h
> @@ -80,7 +80,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
>  extern int dbg_release_bp_slot(struct perf_event *bp);
>  extern int reserve_bp_slot(struct perf_event *bp);
>  extern void release_bp_slot(struct perf_event *bp);
> -int hw_breakpoint_weight(struct perf_event *bp);
>  int arch_reserve_bp_slot(struct perf_event *bp);
>  void arch_release_bp_slot(struct perf_event *bp);
>  void arch_unregister_hw_breakpoint(struct perf_event *bp);
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 9fb66d358d81..9c9bf17666a5 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -124,10 +124,12 @@ static __init int init_breakpoint_slots(void)
>  }
>  #endif
>
> -__weak int hw_breakpoint_weight(struct perf_event *bp)
> +#ifndef hw_breakpoint_weight
> +static inline int hw_breakpoint_weight(struct perf_event *bp)
>  {
>         return 1;
>  }
> +#endif
>
>  static inline enum bp_type_idx find_slot_idx(u64 bp_type)
>  {
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
