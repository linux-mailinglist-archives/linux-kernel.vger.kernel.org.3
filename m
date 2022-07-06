Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B8568613
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiGFKr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiGFKr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:47:57 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D896B25EA1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:47:56 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31c9b70c382so73202627b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9xL9KWaUTqMrdx+f7Osk6rXo1uzmACQElKlNn3u2eog=;
        b=nhfPWRRRvCvP5aAchlDGttJViVMrIfcb+HDcZrXhmgSDUftmfwiagtGwbzDPe0HF5u
         cL2ffPrmawLYkANYzB3oyCtGenoVXP5UcxFTiuykAtY8qUrQkTwdjtk2AH85WVi3MEcV
         S6Kas/seBOGP3cYxG7Y+aXt0xWwyLCQbF1BI7vVQmnSxeSrQLsJ7HL5RuFnKFHQ48KB2
         nIxmk9HnDRb8wl+hgqhh4+XBtslXLcmKlN3INqjm9Nkp0EedbnYoZm5lhu66LKtu7axb
         1PDngDuniaDKHDSLHXxlqB2NLnXQT0AvufI9PiS+hcu4DBimN1xq17JCDu8bVwEbqK5N
         3qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xL9KWaUTqMrdx+f7Osk6rXo1uzmACQElKlNn3u2eog=;
        b=OaIpgLWvO42EOfLylwpnm/3n2xyzRgAYmAdKHP7LRUR6PrxZrcIvYtG055s1w+c9EQ
         fO32UeB9j/X5tlkuiGRDaQOsXwJlXHyQNwr5YmVVJrEuRYsVNtscWj9TjUfXqg/2ui72
         fKWpB1O3lTCphSUraYlapT8RQrHGWcq49rxU7uokzOTs62pLpB5mgAEsS/xOiO1p8KjM
         T116PSK/sWXm7nLux954EutoxLSaiiM5JvqgiaQHgnLuSvMOcYMHpurt8HmZhbybszaD
         TnzP4sYWOtU0+DYxw+86BUvcdGbefdRwz87NGXsJjN+etFOPfPLBYzRsRIXJGs8pzTmB
         UT4A==
X-Gm-Message-State: AJIora/R9cXMkFf2xWn7Xwz6tzOiJeGoZs8204Vae0lH5a26pFqBSofC
        Bxp7iQAwPuqdwz/vqO1gjTW7jkC6LOEkvlHSwwrUNQ==
X-Google-Smtp-Source: AGRyM1tgZi26YlDe71+wvt829OlhfEU5/bBddg75/W9qvJIESyH9mF1pPeojhCpjoPRecxZ8inZDuUyA/8n42KSEruM=
X-Received: by 2002:a81:a0c1:0:b0:31c:8963:92e with SMTP id
 x184-20020a81a0c1000000b0031c8963092emr20620003ywg.319.1657104476048; Wed, 06
 Jul 2022 03:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220629122053.287165-1-dietmar.eggemann@arm.com> <20220629122053.287165-4-dietmar.eggemann@arm.com>
In-Reply-To: <20220629122053.287165-4-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Jul 2022 12:47:44 +0200
Message-ID: <CAKfTPtAFC5Pk7nfJvSYTmaQNayDoGy40kTnT9j8-yZpDezKNYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/deadline: Use sched_dl_entity's dl_density in dl_task_fits_capacity()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
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

On Wed, 29 Jun 2022 at 14:21, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> Save a multiplication in dl_task_fits_capacity() by using already
> maintained per-sched_dl_entity (i.e. per-task) `dl_runtime/dl_deadline`
> (dl_density).
>
>   cap_scale(dl_deadline, cap) >= dl_runtime
>
>   dl_deadline * cap >> SCHED_CAPACITY_SHIFT >= dl_runtime
>
>   cap >= dl_runtime << SCHED_CAPACITY_SHIFT / dl_deadline
>
>   with BW_SHIFT = 2 x SCHED_CAPACITY_SHIFT
>
>   cap >= (dl_runtime << BW_SHIFT / dl_deadline) >> SCHED_CAPACITY_SHIFT
>
>   cap >= dl_density >> SCHED_CAPACITY_SHIFT
>
> __sched_setscheduler()->__checkparam_dl() ensures that the 2 corner
> cases (if conditions) `runtime == RUNTIME_INF (-1)` and `period == 0`
> of to_ratio(deadline, runtime) are not met when setting dl_density in
> __sched_setscheduler()-> __setscheduler_params()->__setparam_dl().
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/sched.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 79f65a6799c6..555f58d6c3a6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -324,15 +324,15 @@ struct dl_bw {
>   * Verify the fitness of task @p to run on @cpu taking into account the
>   * CPU original capacity and the runtime/deadline ratio of the task.
>   *
> - * The function will return true if the CPU original capacity of the
> - * @cpu scaled by SCHED_CAPACITY_SCALE >= runtime/deadline ratio of the
> - * task and false otherwise.
> + * The function will return true if the original capacity of @cpu is
> + * greater than or equal to task's deadline density right shifted by
> + * SCHED_CAPACITY_SHIFT and false otherwise.
>   */
>  static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
>  {
>         unsigned long cap = arch_scale_cpu_capacity(cpu);
>
> -       return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
> +       return cap >= p->dl.dl_density >> SCHED_CAPACITY_SHIFT;

There is no direct relation between BW_SHIFT and SCHED_CAPACITY_SHIFT
and we can change one without modifying the other.

Should you use (BW_SHIFT-SCHED_CAPACITY_SHIFT) instead of SCHED_CAPACITY_SHIFT ?

>  }
>
>  extern void init_dl_bw(struct dl_bw *dl_b);
> --
> 2.25.1
>
