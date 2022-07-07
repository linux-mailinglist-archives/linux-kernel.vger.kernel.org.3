Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25C556A53B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiGGORa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiGGOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:17:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE9E2F39A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:17:27 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3137316bb69so171020287b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=us6Q5aikYcrmiRiOWxBbZbMsA+WpOB/VZorpFyxB4Hw=;
        b=MKSIY8mahq5nm8JhXhs8XsRaXkWb4dVRQlYxKfLUQfnDh/Ny4ae8WlcMQqlrdLT95W
         12rp4/ksy4BOWERsnQ+b+OYrsPWI2Rfk+GN+CvKRizDUSoKghRaLfrbMiNOUgnJfBPIc
         zXnd26qKou63E+m2RHlMQP+CK+NhrOLIwPqQC/9T2ITewTlpndKswNtATay8oOGIMxJJ
         Cd5qZTTebV00AZVOPf6O9pb2fk804+0c+zo0hUOlDWl+c/Nko51BIG+i4RAr1YBPecuz
         R+nSgWH1ARNTgXH+bpnV+THNRSForgJ72qzhcip/dS9oLZURJvLO3sP3fbbY3JG4Kn3B
         +o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=us6Q5aikYcrmiRiOWxBbZbMsA+WpOB/VZorpFyxB4Hw=;
        b=YdVbrA+3C4L1CvHRiNJZVaz3Y5L2WrglAHepDnuynjv8Oijacw8YD8BK53vzOiJSn2
         j9zskrOsEna7IlP2Y5XbQhm8HorEciOHY6I6TVM0ziD4qzT1NK1AKx2LmiU1lL9B6J22
         xzfhOIpq+BKZdAUIoSlcEWetHKnhj5xyNciq6CqzKkalC0O2zxhmf5dEO219Tzz46Z0i
         vMU7Y9kfjuOXnlilXwUSK/HM+YjQMqJuDDv4dysBo5qU27Pb1Aop4C7EVMAw9EL5zXw0
         r8k/fvAZrhetju1bRoI7aTDBIzxUaKr5y51vGLTvTnm1qWKJhakwa4bkExTocHYX/d6z
         cwqw==
X-Gm-Message-State: AJIora+uE/aqbFlpuU1E02KqC1G/qz+V9By9Y0q4PBiSTitcCzNvgjZk
        uwy90RpEmPPGMSBHiwI0lUQ84hSmp4NwMvvSpAbnCw==
X-Google-Smtp-Source: AGRyM1vHeWZ0AEAoMnN3QpBi+o3m4BSTACQIDrfqxLFrs5yTyNy+J+JyYszq0d6dYC9DW54vLzgWIVHLKsSPUn9I8qg=
X-Received: by 2002:a81:4891:0:b0:31d:db7:7ea9 with SMTP id
 v139-20020a814891000000b0031d0db77ea9mr2755414ywa.228.1657203446129; Thu, 07
 Jul 2022 07:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220707034143.37991-1-jiahao.os@bytedance.com>
In-Reply-To: <20220707034143.37991-1-jiahao.os@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 7 Jul 2022 16:17:14 +0200
Message-ID: <CAKfTPtAb==WjCpmqOaVdwna6c+yxxskkRKwBKB7_EuJC9SrmJA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Remove unused parameter idle of _nohz_idle_balance()
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 at 05:42, Hao Jia <jiahao.os@bytedance.com> wrote:
>
> Since commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu
> loop of ILB") was merged. The parameter idle of _nohz_idle_balance()

The description of the commit should be in a single line.

commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB")

> is not used anymore so we can remove it.
>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77b2048a9326..8d4be2a95e37 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10682,8 +10682,7 @@ static bool update_nohz_stats(struct rq *rq)
>   * can be a simple update of blocked load or a complete load balance with
>   * tasks movement depending of flags.
>   */
> -static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
> -                              enum cpu_idle_type idle)
> +static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
>  {
>         /* Earliest time when we have to do rebalance again */
>         unsigned long now = jiffies;
> @@ -10798,7 +10797,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
>         if (idle != CPU_IDLE)
>                 return false;
>
> -       _nohz_idle_balance(this_rq, flags, idle);
> +       _nohz_idle_balance(this_rq, flags);
>
>         return true;
>  }
> @@ -10818,7 +10817,7 @@ void nohz_run_idle_balance(int cpu)
>          * (ie NOHZ_STATS_KICK set) and will do the same.
>          */
>         if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
> -               _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
> +               _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
>  }
>
>  static void nohz_newidle_balance(struct rq *this_rq)
> --
> 2.32.0
>
