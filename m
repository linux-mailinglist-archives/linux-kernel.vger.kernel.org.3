Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9D544DEA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343914AbiFINmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbiFINmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:42:13 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44397FEF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:42:12 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ef5380669cso241292097b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 06:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSvIszg41YMUB0OV8b/JkbwpxKqkk0pMuRPXoeAKH+s=;
        b=exnnBhW1pJj419qnNLzb1tnxM3GSlbSPoRYEb1L9jaNZ2sz+k4+hHDwNhCPbcteTC4
         IcxBTWH4ttqQnuCRXWBO8tOmUQJWvXGzUHakMo8PfbmyLbd75H0LjnuRd/AscR/Gw/on
         bcpvpSvu9tYB+QsFo0owwUeWj6s+r/MhguqmDehnzbimRxF56PYpecfK4mM76eMwuoez
         hXknX5FlGOhvlBiW9cR/1CbAWqaCTnYMwrw7gIdIUtq5tncePU5skEpL6FoaeMoksJJp
         nmEs4lTh21mHWMTRmQCAhUB651Tc71i5znT2EKPVKMF5xhludwnPWAVL2KcTlV/i1kvi
         18ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSvIszg41YMUB0OV8b/JkbwpxKqkk0pMuRPXoeAKH+s=;
        b=fkYGnPBfI+G228MmHGsPL24dbi58Sz0/Bgs4LAJqJ8gS72AMb64cQXwr/o1TvvMuUl
         +LfNqJTcnpjbdRHjEk+I5hJCxXJARmZY7V4DDMEUjE7gDoCKy3Lvbrp9jkfCADf+N9sW
         6L9bZkrKhkumOhCRuqcUe4MGdWiBgr2qrs7N9wWYPLlxvTjNwbKqjjCFBI9W7nN1Wpa9
         et9U+pflZWj92vi0UmakqNBTIRknOubZcxGfVokOiH4DXjuQPTF8yCeMJEFHOI+S5rb2
         Gc11KRn1+ezVOD+coq84JGoUnRuyyMeyTDrTl5hV1eOHR/HVAjiZUZFv4ckPtp8r5ady
         hpGw==
X-Gm-Message-State: AOAM530ivEIXW7zncnTJxbZQC6V5Hsu8/zqsoQe1+ZL8SjCkGqosde66
        0heGyFWLpA/4fJ6ubhK69Y0jZTqYFJOCB72uHULH8g==
X-Google-Smtp-Source: ABdhPJwCPQezLCT6rFtj/zaqkekbVaYa1FocOh1levOOd/STu2w+RlAm/NCtynyJYSqUMv3ZON7VNEJ72rkD++aEOLE=
X-Received: by 2002:a81:6189:0:b0:2eb:deb5:9f63 with SMTP id
 v131-20020a816189000000b002ebdeb59f63mr41133144ywb.319.1654782131365; Thu, 09
 Jun 2022 06:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220609025515.2086253-1-joshdon@google.com>
In-Reply-To: <20220609025515.2086253-1-joshdon@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Jun 2022 15:41:59 +0200
Message-ID: <CAKfTPtCc4NZ51qruKX1zROFHqg-_MQBadaJfVbYPxT=7c4So=Q@mail.gmail.com>
Subject: Re: [PATCH] sched: allow newidle balancing to bail out of load_balance
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 04:55, Josh Don <joshdon@google.com> wrote:
>
> While doing newidle load balancing, it is possible for new tasks to
> arrive, such as with pending wakeups. newidle_balance() already accounts
> for this by exiting the sched_domain load_balance() iteration if it
> detects these cases. This is very important for minimizing wakeup
> latency.
>
> However, if we are already in load_balance(), we may stay there for a
> while before returning back to newidle_balance(). This is most
> exacerbated if we enter a 'goto redo' loop in the LBF_ALL_PINNED case. A
> very straightforward workaround to this is to adjust should_we_balance()
> to bail out if we're doing a CPU_NEWLY_IDLE balance and new tasks are
> detected.

This one is close to the other tests and I wonder if it should be
better placed before taking the busiest rq lock and detaching some
tasks.

Beside your use case where all other threads can't move in local cpu
and load_balance() loops and clears other cpus, most of the time is
probably spent in fbg() and fbq() so there are more chance that a task
woke in this meantime and I imagine that it becomes useless to take
lock and move tasks from another cpu if the local cpu is no more newly
idle.

Have you tried other places in load_balance() and does this one
provide the lowest wakeup latency ?

That being said, the current patch makes sense.

>
> This was tested with the following reproduction:
> - two threads that take turns sleeping and waking each other up are
>   affined to two cores
> - a large number of threads with 100% utilization are pinned to all
>   other cores
>
> Without this patch, wakeup latency was ~120us for the pair of threads,
> almost entirely spent in load_balance(). With this patch, wakeup latency
> is ~6us.
>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  kernel/sched/fair.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8c5b74f66bd3..5abf30117824 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9834,9 +9834,15 @@ static int should_we_balance(struct lb_env *env)
>         /*
>          * In the newly idle case, we will allow all the CPUs
>          * to do the newly idle load balance.
> +        *
> +        * However, we bail out if we already have tasks or a wakeup pending,
> +        * to optimize wakeup latency.
>          */
> -       if (env->idle == CPU_NEWLY_IDLE)
> +       if (env->idle == CPU_NEWLY_IDLE) {
> +               if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pending)
> +                       return 0;
>                 return 1;
> +       }
>
>         /* Try to find first idle CPU */
>         for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
> --
> 2.36.1.476.g0c4daa206d-goog
>
