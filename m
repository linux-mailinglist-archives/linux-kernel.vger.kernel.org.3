Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0238E57B1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbiGTHji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiGTHje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:39:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D90B68732
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:39:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v15so16405934ljc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0ANUNTkZ26RWQnY3pfsOcSO7yiU6627Cy5vXCioKjM=;
        b=e3ipkMk6gbei7k0d57pbubdR2vAQBIeY1vd8JcfVskwhrXvyIktfprcrNkHZ8/r4B4
         FmvmCfAuH+/wHOVJNAyo38eBG4ndNTXicZ6lq+owQqKnw0c1F3l2Df/UBO0Q9HSpQdJE
         KCloIr/YcaJLqYtSYZtwbJ/o2ygTRmHvBODGIbAL3uZ88Ay1rM/5yi7cXSjc9zxWn4dc
         pYMIXCojfYA0o69nAt0jvMQFvE6S3mGl38qon6btGG8PY2EMEBqUGVPvoGjv2gebDAau
         VSUtt7UBtO5nQkx+mjS7xe2a0AgmQuAirUGuXEraeeUfVCZ6wV7dpdKr5Wexv60nVGWA
         FzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0ANUNTkZ26RWQnY3pfsOcSO7yiU6627Cy5vXCioKjM=;
        b=Gc7z/ya4WvmmJPwsq0cXA+sOHaxhoAbeHHoBHGDSE1s9AEXyscxYtgsxpKPNQ/J3tH
         uF4J23xqC/Q7qRuDxb5WnW9k/0rw6OXmNVgLtj6RnC7fGh7U6nzmlrUEuCzXO6TB0Hla
         5pUrmGLoqi17cSK+/sHONnjYUOay5mP6MpJK+GZ0Ft+xldGpadXNIKLfEOF9jpiPboyx
         8I6lAtvyZtq0za7fD6yWrlbxawqIg8eLALi3sHCvt3ZtciKhVgi04y+JvJyJXdU5vZ/M
         9XIbkzdRw/u8xETSgpzIX6sipjA8R4LEdGf8HCucBa8fFTbU2xc9z4IcsBYptbyW1S0c
         NVMg==
X-Gm-Message-State: AJIora/+TLne+2czWy2ZU4vJVvf8WasM9UIHA5/o0pXq4YJuWCNoiMuz
        BAva9saGGa98IdmQxH/7d5Lip7kqxz3gnH/1yD0=
X-Google-Smtp-Source: AGRyM1towGeJkXn/nsplStsr2X3bSKxpaLxD52Bok2fNLaYIrNgB1JzBfS7VDIDSp2P/bzPZ62HinJaBN+pLftXYZn4=
X-Received: by 2002:a2e:a595:0:b0:25d:a8c6:21cc with SMTP id
 m21-20020a2ea595000000b0025da8c621ccmr9575819ljp.416.1658302772009; Wed, 20
 Jul 2022 00:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194632.1117723-1-qais.yousef@arm.com> <20220629194632.1117723-8-qais.yousef@arm.com>
In-Reply-To: <20220629194632.1117723-8-qais.yousef@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 20 Jul 2022 15:39:20 +0800
Message-ID: <CAB8ipk9=EEfArTTQ_w10+Df0WqMinFvjbmfFEBLg1zUYcHkOPw@mail.gmail.com>
Subject: Re: [PATCH 7/7] sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s
 early exit condition
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais

On Thu, Jun 30, 2022 at 3:48 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> If the utilization of the woken up task is 0, we skip the energy
> calculation because it has no impact.
>
> But if the task is boosted (uclamp_min != 0) will have an impact on task
> placement and frequency selection. Only skip if the util is truly
> 0 after applying uclamp values.
>
> Change uclamp_task_cpu() signature to avoid unnecessary additional calls
> to uclamp_eff_get(). feec() is the only user now.
>
> Fixes: 732cd75b8c920 ("sched/fair: Select an energy-efficient CPU on task wake-up")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/fair.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 499ef7a7288c..a112ca45864c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4057,14 +4057,16 @@ static inline unsigned long task_util_est(struct task_struct *p)
>  }
>
>  #ifdef CONFIG_UCLAMP_TASK
> -static inline unsigned long uclamp_task_util(struct task_struct *p)
> +static inline unsigned long uclamp_task_util(struct task_struct *p,
> +                                            unsigned long uclamp_min,
> +                                            unsigned long uclamp_max)
>  {
> -       return clamp(task_util_est(p),
> -                    uclamp_eff_value(p, UCLAMP_MIN),
> -                    uclamp_eff_value(p, UCLAMP_MAX));
> +       return clamp(task_util_est(p), uclamp_min, uclamp_max);
>  }
>  #else
> -static inline unsigned long uclamp_task_util(struct task_struct *p)
> +static inline unsigned long uclamp_task_util(struct task_struct *p,
> +                                            unsigned long uclamp_min,
> +                                            unsigned long uclamp_max)
>  {
>         return task_util_est(p);
>  }
> @@ -6913,7 +6915,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>         target = prev_cpu;
>
>         sync_entity_load_avg(&p->se);
> -       if (!task_util_est(p))
> +       if (!uclamp_task_util(p, p_util_min, p_util_max))

Is it not enough to just replace the task_util_est with the
uclamp_task_util? If change the definition of uclamp_task_util,
that means it have to get task's uclamp first if user want to call the
function, may increase the code complex farther more?

>                 goto unlock;
>
>         for (; pd; pd = pd->next) {
> --
> 2.25.1
>

BR
---
xuewen.yan
