Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D136A59D29A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbiHWHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240751AbiHWHt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:49:57 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7568765260
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:49:56 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-333b049f231so358340767b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=W4yJx9S8mFfWH0v+ukIx1ED5012zS2zZvLgaX95wtyo=;
        b=hC/lT+0OpnJ9SOvA0o3nWPBpG1gZlRIQmycndxhYoKnT/I8/0ulu3Ru4mXPWjtb30O
         TNGS4IvJXvnpD9M7fS1fEWqpDWzfZIcCuZB7biQrdFzlxUPDHlbOnkYLqyWZievFqJ8l
         Whjj8Xb99f7Jnn4CSy8GwuwHa02ld7xEXISE74mevYZU+87FPOPKtSqeFbRmpIAbWZry
         sPJHlauhaK0iNe9+7PUSLfLWhldnOKPIxvh5CIVFyI0VN4aExoGDX/kS3K+hXEDgMBt1
         gfYskJT4/+ocjQq40aBHkUsGnk+zwYY/RKWEPLCcX2W6jf8aMChJHOMd1N9xAdC6quKD
         Ek0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=W4yJx9S8mFfWH0v+ukIx1ED5012zS2zZvLgaX95wtyo=;
        b=XpgpNB+qvMpMbrF5CP3kwLP57FXr97GfhR4XIwZuE/QWu9twqdQPTBWOWTUcmWhOJu
         MgHMMPCEKlbAXyEIPom4j/MOkTQt64heVvrvDdoIFSpfLnOLW68GiSvbVIAtx77/hn+i
         faAMMM81SOMTcynh2n2i85EEYo3ufvRe5GUGQ4lpwyNHupSCo6dAUe6ABtQI/+ipEnk3
         8OAdwBRgz+VEI2ExzEzBHxhKebPwXpQXMOa13aFsFXK1rVwPKtxEM8A+gCDiL8/ax0ko
         56yIxTeYIG86aeHHNFEWgixJ7h0ddNcSdvci4V/kh0s0GoZt8WxMZLyR2NRR4zLYE75J
         MX1g==
X-Gm-Message-State: ACgBeo0srM5PG8iOp5hSWdgfqDKD0y+sZZtQdgTrcaDXqWU4SEjELPIq
        F25QuU/8srXVgNYYqvaMt1AzLaRkwp1x1mc/lqICqw==
X-Google-Smtp-Source: AA6agR7U6iEwtgMUk1oElngi4DHHxtoTYFOR3PFuFVvu4hdX8DvQOZiBTde13trDl0s0CzmDqZ/jrc9FJn3I0eMEgI4=
X-Received: by 2002:a05:6902:91d:b0:672:e583:9ed9 with SMTP id
 bu29-20020a056902091d00b00672e5839ed9mr22966153ybb.225.1661240995694; Tue, 23
 Aug 2022 00:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220818124805.601-1-zhouchengming@bytedance.com> <20220818124805.601-10-zhouchengming@bytedance.com>
In-Reply-To: <20220818124805.601-10-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Aug 2022 09:49:44 +0200
Message-ID: <CAKfTPtBvJha6Lt3411awLv9DukBWgObt8=4WtMM0c-Fusx2=-Q@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] sched/fair: don't init util/runnable_avg for !fair task
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, tj@kernel.org
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

On Thu, 18 Aug 2022 at 14:48, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> post_init_entity_util_avg() init task util_avg according to the cpu util_avg
> at the time of fork, which will decay when switched_to_fair() some time later,
> we'd better to not set them at all in the case of !fair task.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 93d7c7b110dd..621bd19e10ae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -833,20 +833,6 @@ void post_init_entity_util_avg(struct task_struct *p)
>         long cpu_scale = arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)));
>         long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
>
> -       if (cap > 0) {
> -               if (cfs_rq->avg.util_avg != 0) {
> -                       sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> -                       sa->util_avg /= (cfs_rq->avg.load_avg + 1);
> -
> -                       if (sa->util_avg > cap)
> -                               sa->util_avg = cap;
> -               } else {
> -                       sa->util_avg = cap;
> -               }
> -       }
> -
> -       sa->runnable_avg = sa->util_avg;
> -
>         if (p->sched_class != &fair_sched_class) {
>                 /*
>                  * For !fair tasks do:
> @@ -861,6 +847,20 @@ void post_init_entity_util_avg(struct task_struct *p)
>                 se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
>                 return;
>         }
> +
> +       if (cap > 0) {
> +               if (cfs_rq->avg.util_avg != 0) {
> +                       sa->util_avg  = cfs_rq->avg.util_avg * se->load.weight;
> +                       sa->util_avg /= (cfs_rq->avg.load_avg + 1);
> +
> +                       if (sa->util_avg > cap)
> +                               sa->util_avg = cap;
> +               } else {
> +                       sa->util_avg = cap;
> +               }
> +       }
> +
> +       sa->runnable_avg = sa->util_avg;
>  }
>
>  #else /* !CONFIG_SMP */
> --
> 2.37.2
>
