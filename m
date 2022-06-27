Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9555C66A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbiF0XnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbiF0XnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:43:02 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E041D9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:43:01 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31780ad7535so100576107b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDH8nCKE+Rk+mLLCcRc/EY/phPcC3Vah5J9OCcFx0Hc=;
        b=I2H7+Imgyei3TLEIV0b8EayiG3a6fOGNwNzhw7YUzdJsrJx5Sa+Xv5+nANIRZOzhK1
         PiNsAMtuoeRxW826kqYTKzhANa8gUBX2PWFtRA/S8KrjDylzzxI2RZbd9hm+GYiOGYBP
         ntmm7PUaEsiIBcwR3N+5qVU3IYOP/O7ghGb3gJtKWJh+lZV+aYhfuYWaUZaGyMwiqE1K
         bWM6NACMYDOgLeDlqLzqFo71nOQ8Wz1MkkOtnsgiQ+9/YXq8y7rw7SHZ9ygmrkFLelKj
         TGVR32SR6IlTZnrcyeqdELcHrpS36icVuAhgUmrQfXXYjZlWR0/N95pZVilY+gR1Mjg2
         Miig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDH8nCKE+Rk+mLLCcRc/EY/phPcC3Vah5J9OCcFx0Hc=;
        b=OmSGyJ7rmCsmtVgOZ6m2Mun1eTDeanry9ke5WGXnv5B71ya5N2GmqcvDJyELexjkgN
         QmWMJflQDJ33Gy3cE4my2SPZ9cryrJpCja+LVk3dDxy5V0Hq7TZwYL1bq93yU7fsPUcY
         +jPKlB97EuN94bTwqSPMdXA1ylDAfT+VQix1tdlr7y1eHTDDwK/ZSlkzZQ+ztFifHFaU
         y/QnOW8H0DsbFPmw/XBJ8HEGgMkovysabY36LL62lzhBUAsG4AOb8TMmPrwaLo0RzOI3
         cqTQ/iFTeBwRgFsLIJaoahGxBv2bVOMtP+C2gQacHYtZ7kfZvFsSQhxu2QMXYBdtEq0w
         gwJA==
X-Gm-Message-State: AJIora/gQAoL6JQGXd+5qTWEt2/seXNJFvNVzGl9o84jSA5t9jdsJdtZ
        9EDqrjkrOJ4PWGkK8F1bnZmpMkLVW8mrjO/h58dc7A==
X-Google-Smtp-Source: AGRyM1vtgukrH0lPIavGy6PN09frlla89CCezcO1MR/XP83gOvqGwAyv7x7NutAEcpEgkFlUPEHftFmdKQtCznwxE/s=
X-Received: by 2002:a81:19ca:0:b0:31b:732c:15e9 with SMTP id
 193-20020a8119ca000000b0031b732c15e9mr17210855ywz.167.1656373380221; Mon, 27
 Jun 2022 16:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220619120451.95251-1-wuyun.abel@bytedance.com> <20220619120451.95251-5-wuyun.abel@bytedance.com>
In-Reply-To: <20220619120451.95251-5-wuyun.abel@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 27 Jun 2022 16:42:49 -0700
Message-ID: <CABk29NuXvCTkbQ=MdX5F+YswhOAPZSAQTAXn7B_uuKRr4=XVnQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] sched/fair: remove useless check in select_idle_core
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sun, Jun 19, 2022 at 5:05 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> The function only gets called when sds->has_idle_cores is true which can
> be possible only when sched_smt_present is enabled.
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index aba1dad19574..1cc86e76e38e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6256,9 +6256,6 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>         bool idle = true;
>         int cpu;
>
> -       if (!static_branch_likely(&sched_smt_present))
> -               return __select_idle_cpu(core, p);
> -

The static branch is basically free; although you're right that we
currently don't take !smt_present branch direction here, it doesn't
seem harmful to leave this check in case assumptions change about when
we call select_idle_core().

>         for_each_cpu(cpu, cpu_smt_mask(core)) {
>                 if (!available_idle_cpu(cpu)) {
>                         idle = false;
> --
> 2.31.1
>
