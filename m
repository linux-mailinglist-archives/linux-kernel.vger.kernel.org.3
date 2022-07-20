Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF52A57BA80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiGTPgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiGTPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:36:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E672FFE1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:36:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so1608493wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFzxx0z8pNKG8GQJAfngz4sVC9qlk18q5vOjkBqe41U=;
        b=DYrPq68GLvItPSkdP1iRNBYH4r5u/VU/4hctkVb0AVbcaQWnJsmyhV+rknu569NDUk
         o7570gvxSR4qDT3uhb+ulSVY+WSiEdCJbZadpKchRpy6M635wQ9YE67mAnZUAWX1PnNI
         DjNpTzN0Y0TYNZC3PGOvGwGPqMFNmf4cPeuBrU+UtoTwmSoU4uFqkOb6Q23CbwC31DYm
         6Auh+eOKqXfChxALoWTNJB43P4J40PWWdA3VkjuZAUxIw8SVlAQTZTV1vhkY+PvURc4J
         UMWq3tKkmc5PYODk1J3VfQ1VSqbU6F5BnYiUhV36SYcKWKqn21Xj+zFl5lBXYXLRh/7e
         lihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFzxx0z8pNKG8GQJAfngz4sVC9qlk18q5vOjkBqe41U=;
        b=BrEf2L0/XHiV6uxBLBSslCxQf9BhByw17gausx5/xlfG/ujDJkc6a4fXOJ0IcwBN9o
         nv6l5k2vY9wMw5p9v9QLe52Yt4TZU451JTiBufIBk6CQ41eB4g0zEb7VbG33CFvoSC0e
         e3J1oYiT/HTkuQQqFc4Gp4xOpYaG/rscEGWw5MN6P7qGthVbcToepj99rC6mFoeOBKV5
         sPa9P2dGnks8sBaWrG8oD7HQiGO5K+SDyYd4ZTrweZFZVkJmfbM+WJd7Ckfs6igxriqP
         fZ8znkxyaWkxAbBAE68niud5VXiMaK5tnSzc9hhYG5cS0tZISEJtU6i3LjCLc9frGqmJ
         b4TA==
X-Gm-Message-State: AJIora/qXrfz3rfNmtG+UtZltx8IvcbtsrtHnoSu68P+9KiXYQa8d2Lp
        QuuRGVGR64RtTn6VhxlrVBfbXvg7DpX7LfZx7DPSOA==
X-Google-Smtp-Source: AGRyM1sLPBoh5pqmDtw4wPynZIZtaL2Bw4Asqc9TmCk9ZgFTDI88pTO3drYJSFHLXbjukiaxsv4+tBmZLSdj518/fak=
X-Received: by 2002:a05:600c:2854:b0:3a3:1551:d7d with SMTP id
 r20-20020a05600c285400b003a315510d7dmr4199687wmb.174.1658331391068; Wed, 20
 Jul 2022 08:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-11-elver@google.com>
In-Reply-To: <20220704150514.48816-11-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:36:18 -0700
Message-ID: <CAP-5=fX7DoS0eDk=FS14CRjU_UPinH2+0+uD1JPXFMtrb7o1eA@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] locking/percpu-rwsem: Add percpu_is_write_locked()
 and percpu_is_read_locked()
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

On Mon, Jul 4, 2022 at 8:07 AM Marco Elver <elver@google.com> wrote:
>
> Implement simple accessors to probe percpu-rwsem's locked state:
> percpu_is_write_locked(), percpu_is_read_locked().
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2:
> * New patch.
> ---
>  include/linux/percpu-rwsem.h  | 6 ++++++
>  kernel/locking/percpu-rwsem.c | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index 5fda40f97fe9..36b942b67b7d 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -121,9 +121,15 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
>         preempt_enable();
>  }
>
> +extern bool percpu_is_read_locked(struct percpu_rw_semaphore *);
>  extern void percpu_down_write(struct percpu_rw_semaphore *);
>  extern void percpu_up_write(struct percpu_rw_semaphore *);
>
> +static inline bool percpu_is_write_locked(struct percpu_rw_semaphore *sem)
> +{
> +       return atomic_read(&sem->block);
> +}
> +
>  extern int __percpu_init_rwsem(struct percpu_rw_semaphore *,
>                                 const char *, struct lock_class_key *);
>
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index 5fe4c5495ba3..213d114fb025 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -192,6 +192,12 @@ EXPORT_SYMBOL_GPL(__percpu_down_read);
>         __sum;                                                          \
>  })
>
> +bool percpu_is_read_locked(struct percpu_rw_semaphore *sem)
> +{
> +       return per_cpu_sum(*sem->read_count) != 0;
> +}
> +EXPORT_SYMBOL_GPL(percpu_is_read_locked);
> +
>  /*
>   * Return true if the modular sum of the sem->read_count per-CPU variable is
>   * zero.  If this sum is zero, then it is stable due to the fact that if any
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
