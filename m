Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4457A076
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbiGSOGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbiGSOF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:05:59 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A1E48C94
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:20:27 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31bf3656517so140111457b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCaDJzWeU7u8SxY7kO+KY73YKoXoX8uh6F8cVhpLoJ4=;
        b=JyTkRXsWldJMf4Kc2h0+DBT+fb4TjT7xeSUptHrwXQ0PsExdUVAlc+SGa7KmXlF/aq
         SutXy06HPfDy4RsHcBmPEQOEYhjOjLE+6rvXu4UHyUQpQyAKWj/3UhQWXMjcSLHbAN6r
         kp87t3bQdqUeTuGub86nQa6lCG0m01RKQ9qJaOCeBgGFYkUuWEChXexT0TmhwSytPO3M
         RJKOpgbwK+Ct2nyTnwxDjUg0SgzRDyjMXB4us5OSm0TnBQuc3olkuIEBgbKfg1vO9hF7
         bWoOpoRf9aQ3CTj4v71lfm5+z97CW3aPbLNyu8C+ajLDVs4BFL+vCUJoAub9lbhg60I2
         aR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCaDJzWeU7u8SxY7kO+KY73YKoXoX8uh6F8cVhpLoJ4=;
        b=C96V77DrPYkcvw2g+Rwjc5t/ue7K8EhVS5x6dD/ULlSM/dylqRfGdmlmcyhejRv3mu
         nOhCDRaNszGkYOZAiz91ojcFqC9bpSWaR8GAcGXfte1bc8H/KXYWK1CXZ2FiI7YsGzgt
         KS2iYIR5MYnBkrkyTeX7ajiNAkYY88PKQ8fyw/1l4M7QfMwWJP9x3P289T1ST8l6mKXU
         5qMP6tNyWBiD26YJ/lVaXBxI6/Hp6d/hZo13Y/sgGTKJFqBBb9I7YY3GpHUZC4O5bYU5
         r6Iy39CqvIXLVNB7os3gcECvGDWnK+pIxs98ULpuXjc6PCQLYFEtU/Fh7nznxxaYwpMK
         dHxg==
X-Gm-Message-State: AJIora9e78214RJOKOOkx7RgRoNOq6z9SeJenjIhcuQl6b0xOqgn3rD0
        PzdRq5fLLeCGQIhs1zqXO9E3iFsJfMvG3bW1e1HxSg==
X-Google-Smtp-Source: AGRyM1viAeflIwl0eENCVwMmQhdXDabw4S7in28vlLgYCLYwjfaUXlKuovg6aLnKhZE6Wh0CIPws9eerh6CedpgcfNM=
X-Received: by 2002:a81:4319:0:b0:31d:92c4:9e5f with SMTP id
 q25-20020a814319000000b0031d92c49e5fmr35705592ywa.359.1658236826480; Tue, 19
 Jul 2022 06:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220713040430.25778-1-zhouchengming@bytedance.com> <20220713040430.25778-10-zhouchengming@bytedance.com>
In-Reply-To: <20220713040430.25778-10-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Jul 2022 15:20:15 +0200
Message-ID: <CAKfTPtC4r1pon_QxHaa=3r85v4u1DL32_9FbTwL0zBZT017E-g@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] sched/fair: stop load tracking when task switched_from_fair()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 at 06:05, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> The same reason as the previous commit, if we don't reset the
> sched_avg last_update_time to 0, after a while in switched_to_fair():
>
> switched_to_fair
>   attach_task_cfs_rq
>     attach_entity_cfs_rq
>       update_load_avg
>         __update_load_avg_se(now, cfs_rq, se)
>
> The delta (now - sa->last_update_time) will wrongly contribute/decay
> sched_avg depends on the task running/runnable status at that time.

I think that we always decay the time spent in !fair class and never contribute

This one is a bit more complex than the new task one. Generally
speaking, I would say that we should decay the load while running in
!fair case because the value becomes less and less relevant over time.
What's the meaning of pelt values when the task has run seconds as a
fifo ? The only case that would need a particular attention, is the pi
boost case but there is no way to now how long is runs and sleep when
!fair

>
> This patch reset it's sched_avg last_update_time to 0, stop load
> tracking for !fair task, later in switched_to_fair() ->
> update_load_avg(), we can use its saved sched_avg.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 50f65a2ede32..576028f5a09e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11552,6 +11552,11 @@ static void attach_task_cfs_rq(struct task_struct *p)
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
>  {
>         detach_task_cfs_rq(p);
> +
> +#ifdef CONFIG_SMP
> +       /* Stop load tracking for !fair task */
> +       p->se.avg.last_update_time = 0;
> +#endif
>  }
>
>  static void switched_to_fair(struct rq *rq, struct task_struct *p)
> --
> 2.36.1
>
