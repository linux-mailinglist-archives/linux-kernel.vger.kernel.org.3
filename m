Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC7B4F8F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiDHHUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiDHHUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:20:04 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D93E21F746
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:18:02 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2ebebe631ccso1762537b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1eAc+/ZTYosIlDGpvTMl5b2fSKIdNvBP3h/M7XqTbM=;
        b=Ir9TzH9EwGidF3qd4S3sWxRXlCY8hHDid3Xkww9Q4bSw+ofszVekY/3BS6Gd6eHF/M
         nCKvNwNFpazqtIavhHX4+BHZ/n9t2e0k2/f8iPQIkTvhkKVgiYlcuKWqw5Ae9vaDqrPB
         2Jvwq6xOgQYCJ02SUBcQd5w9i9+XRmjPRQeWPGYU6kDqxK2saC8Vn7JXESwa+coF+oqD
         +/MHQAIXvmptSHEq/PIkCRfpyVBeveDIixO7rBakqb+IIkCFqX+mI+wDOYqxyIWBsWHr
         3ntvCeGf0t6q+SBKRRCwIp1beMO67oLZghNmYsOfutOQB9m9pzDaN08j+lWJN/EKKcKk
         n/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1eAc+/ZTYosIlDGpvTMl5b2fSKIdNvBP3h/M7XqTbM=;
        b=0r8YFEqFZvTP3jawXFo8uAY0p/VB47sqsbraL7aD34IFOCpCZybmxQ9f9+M9AnweG3
         XQl/2hYIY/0sJ6iN6yT7k45HaZ7jzKZFv7vpTD61GQM2u7XWrVdkBZPb6u7RcZx7ZYPP
         OemMV+zVpf8pm5no7xYrdClrNznrrDhMA6/b0tBlBQaHyGt+lz1sL4eQjtM+svNttTx1
         9oI8pklLNuO1+WCYV5WBpoxBwCs/bGvvv0SvWgw+1KR3UZmvx91OWWKxxk6k/vnOmy2G
         K40f3wWwIINIrUHiQC1vwuzue3tkK7lS2CfH0GiQsnxG1e2FTjayPEX0mjQowXpvcbxn
         qTLg==
X-Gm-Message-State: AOAM530R5paZHAyfOcjbf/7o/L5EmN/pyKXthefdlT7ZpE93NH/4guvn
        1xY/LIFIl2YSt/DeAwOsoxl0EPZ7+BF4HZgEIyntqA==
X-Google-Smtp-Source: ABdhPJw6ynzTGftsrf/Xfed6r3eZH/mqtNaepkmKZxdABE0Ve2pztP5M9pS84NPguk9D1Mg5cjTDeIvI9mgNmrmh+/A=
X-Received: by 2002:a81:59d7:0:b0:2eb:7156:40bc with SMTP id
 n206-20020a8159d7000000b002eb715640bcmr14774847ywb.67.1649402281380; Fri, 08
 Apr 2022 00:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220407021729.16655-1-zhouchengming@bytedance.com>
In-Reply-To: <20220407021729.16655-1-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Apr 2022 09:17:50 +0200
Message-ID: <CAKfTPtCNNJsT8fqG2eT0AZVFvNdxkyMzy8SdXajsHFqSH-PZ-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
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

On Thu, 7 Apr 2022 at 04:17, Chengming Zhou <zhouchengming@bytedance.com> wrote:
>
> Since commit 23127296889f ("sched/fair: Update scale invariance of PELT")
> change to use rq_clock_pelt() instead of rq_clock_task(), we should also
> use rq_clock_pelt() for throttled_clock_task_time and throttled_clock_task
> accounting.
>
> Fixes: 23127296889f ("sched/fair: Update scale invariance of PELT")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..e6fa5d1141b4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4846,7 +4846,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>
>         cfs_rq->throttle_count--;
>         if (!cfs_rq->throttle_count) {
> -               cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
> +               cfs_rq->throttled_clock_task_time += rq_clock_pelt(rq) -
>                                              cfs_rq->throttled_clock_task;
>
>                 /* Add cfs_rq with load or one or more already running entities to the list */
> @@ -4864,7 +4864,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>
>         /* group is entering throttled state, stop time */
>         if (!cfs_rq->throttle_count) {
> -               cfs_rq->throttled_clock_task = rq_clock_task(rq);
> +               cfs_rq->throttled_clock_task = rq_clock_pelt(rq);
>                 list_del_leaf_cfs_rq(cfs_rq);
>         }
>         cfs_rq->throttle_count++;
> @@ -5308,7 +5308,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
>         pcfs_rq = tg->parent->cfs_rq[cpu];
>
>         cfs_rq->throttle_count = pcfs_rq->throttle_count;
> -       cfs_rq->throttled_clock_task = rq_clock_task(cpu_rq(cpu));
> +       cfs_rq->throttled_clock_task = rq_clock_pelt(cpu_rq(cpu));
>  }
>
>  /* conditionally throttle active cfs_rq's from put_prev_entity() */
> --
> 2.35.1
>
