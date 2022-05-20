Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10F52E56F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346080AbiETGzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242373AbiETGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:54:57 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A14614E2F9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:54:56 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ff39b44b06so77657607b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=S8eKdPVJU8XZRt7HQU1VfWz2aFNqGg6i7oky+n97/rU=;
        b=UuzDDIUmGiToBt/3nWSbb1ELw+fqQ0gdv2dEaNLYZE1Rn2fv6kD43b73QQaIvVyhXS
         JgTkAxDOClkIrfevR03cBVUyWdfXjZNU0fxT7TFgg8Df0Um6xGmS5y67Xs/bkgN38RVs
         nGtqfrSpsiBD8Ht5WU5heNZFGD5aWauP3YEu5/4Gw5URfu3UtjtgRgGEjPx5WjCUhVot
         sv2Qh/5yc+RSQtIP4RGi6F/2AOq5ZX8yZxWU1wKXpTDSmAcRLfuG6GfDKHwStvINZAsr
         L4VqO+5LY67tu/1l6bn6DxGny6zRdG5arm2n/vElIewNc68xIkLYtPPOqEDY1nWGDKZW
         9OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=S8eKdPVJU8XZRt7HQU1VfWz2aFNqGg6i7oky+n97/rU=;
        b=tkVMkICmzmeqxstDOjKGoIG1Ehdnr3rKTFAXzc6bYIsMzLpBcmGSjwsvYq4ekNIV++
         p1ha8YCBe1Fk8Tdi8WTTcybVO0GSFYReOVNbw2C48y0wR4r3df6EFw/u9Yr0h66P5jaL
         v2LqmEz+YokvSSMhGc+xnD+YjxBLuvsqQ6m9Eq4738Bgph06X+CbDuKza/hN7UdJ2ok0
         3dkkQ0OjsdfCYmf0JeZ+M0sikGxU3nElQV7RFC+J8C6rsiAekKTKUNRCeEEEh8YZqZRM
         4PiItlyZD88ZSVp1AtL38o9Jh+NmsJR3iKQ3Djov1YIdD2qyCHOvAmPPCDgWFxC/BD8L
         1C3A==
X-Gm-Message-State: AOAM531+oms/K5nuX9mnxSH1QsIrIpgzJMeuTC2U8Z65didp753RGi1t
        YqJvKzDGaV2NikSZT/97E3qaE0XbBKADC05oHjg=
X-Google-Smtp-Source: ABdhPJxxsGu2y4JZd2GxLLJM/FAn7kccOKOc3yL/ODdczf+IOsVimlJu69GRFtfBLQT7dMbj2i+D85MuTCwcrNjEV58=
X-Received: by 2002:a81:5593:0:b0:2ff:2663:ea7f with SMTP id
 j141-20020a815593000000b002ff2663ea7fmr8739981ywb.224.1653029695663; Thu, 19
 May 2022 23:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220303131942.12030-1-henrybear327@gmail.com>
In-Reply-To: <20220303131942.12030-1-henrybear327@gmail.com>
From:   Henry Tseng <henrybear327@gmail.com>
Date:   Fri, 20 May 2022 08:54:44 +0200
Message-ID: <CAA5xa-==1d2UATF1Q1YnijD4_j-sBY=E5P52qrigX4rKFjbMxw@mail.gmail.com>
Subject: Re: [PATCH v3] sched: Simplify __sched_init runtime checks
To:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com, christian@brauner.io,
        linux-kernel@vger.kernel.org, Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A friendly ping on this patch!

On Thu, Mar 3, 2022 at 2:19 PM Chun-Hung Tseng <henrybear327@gmail.com> wrote:
>
> Improve runtime checks in __sched_init(void) by replacing if conditional
> checks with preprocessor directives.
>
> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
> ---
>  kernel/sched/core.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9745613d531c..003e8677f6ba 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9317,28 +9317,29 @@ void __init sched_init(void)
>  #ifdef CONFIG_RT_GROUP_SCHED
>         ptr += 2 * nr_cpu_ids * sizeof(void **);
>  #endif
> -       if (ptr) {
> -               ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
> +
> +#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
> +       ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -               root_task_group.se = (struct sched_entity **)ptr;
> -               ptr += nr_cpu_ids * sizeof(void **);
> +       root_task_group.se = (struct sched_entity **)ptr;
> +       ptr += nr_cpu_ids * sizeof(void **);
>
> -               root_task_group.cfs_rq = (struct cfs_rq **)ptr;
> -               ptr += nr_cpu_ids * sizeof(void **);
> +       root_task_group.cfs_rq = (struct cfs_rq **)ptr;
> +       ptr += nr_cpu_ids * sizeof(void **);
>
> -               root_task_group.shares = ROOT_TASK_GROUP_LOAD;
> -               init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
> +       root_task_group.shares = ROOT_TASK_GROUP_LOAD;
> +       init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  #ifdef CONFIG_RT_GROUP_SCHED
> -               root_task_group.rt_se = (struct sched_rt_entity **)ptr;
> -               ptr += nr_cpu_ids * sizeof(void **);
> -
> -               root_task_group.rt_rq = (struct rt_rq **)ptr;
> -               ptr += nr_cpu_ids * sizeof(void **);
> +       root_task_group.rt_se = (struct sched_rt_entity **)ptr;
> +       ptr += nr_cpu_ids * sizeof(void **);
>
> +       root_task_group.rt_rq = (struct rt_rq **)ptr;
> +       ptr += nr_cpu_ids * sizeof(void **);
>  #endif /* CONFIG_RT_GROUP_SCHED */
> -       }
> +#endif /* CONFIG_FAIR_GROUP_SCHED || CONFIG_RT_GROUP_SCHED */
> +
>  #ifdef CONFIG_CPUMASK_OFFSTACK
>         for_each_possible_cpu(i) {
>                 per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> --
> 2.35.1
>


-- 
Best wishes,
Henry
