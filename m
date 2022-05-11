Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040C3523529
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbiEKOPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244471AbiEKOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:15:15 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F1A6B679;
        Wed, 11 May 2022 07:15:13 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id r1so4256137ybo.7;
        Wed, 11 May 2022 07:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UrXsXYy6M//zNzEGaa3ePaijRBCwEV3iZbCY12Czp0=;
        b=ayt90iGjxzzujL7sjILXhC8ZxtKQvUl2rLhBjlitF6igPuaE8djjhMYU9/mI9WtQeJ
         K1Xj6+LqiDVjvOs6yyratmcM0G+b3wDGQlVe8rbzoqCXxkhovKzWI4fcls240qiaKRAz
         lMAH9PGqmLAGPHQdEAqfBrrzgeC3ZkxGMImpPs37hMYPmsmL+bO33w4DeHkhD6AjVVle
         67zK/TNFMroYvWVLd2ADMDf29WQT4XBtGd0pmaxA+ygHCfqTDkC//OnZER/Z1jZRWLc5
         qmL2FgvNuu+8XHZ0qJeKnEsmgGrC6Mz7TzB1voMAw2Tjm9oyyAmP/B4m2BJjVVcqfsB7
         hA3g==
X-Gm-Message-State: AOAM5324iQdIj3l8XcooHeO3OLSpOwmI0dm4SsOcEgpRdKqMZUTfejSC
        M4zkXacq/oSqWg2lieJXyoDiPocU0LNmucp4k4M=
X-Google-Smtp-Source: ABdhPJwtPC7qiUkK5mKXa6SK0vRcLSJ3+elfOqI7rHeE7T2vpFDnDLnrs+VtPqa7RzXl66HncJLx/JK+aN2V44jYahU=
X-Received: by 2002:a25:3795:0:b0:648:fa25:5268 with SMTP id
 e143-20020a253795000000b00648fa255268mr25291511yba.153.1652278512727; Wed, 11
 May 2022 07:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510154236.88753-1-schspa@gmail.com>
In-Reply-To: <20220510154236.88753-1-schspa@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 16:15:00 +0200
Message-ID: <CAJZ5v0gcOmd8fXG9_BYxr6rN7ncUWnfki7K9S5wK2Vvh9SxUCA@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
To:     Schspa Shi <schspa@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 5:42 PM Schspa Shi <schspa@gmail.com> wrote:
>
> When cpufreq online failed, policy->cpus are not empty while
> cpufreq sysfs file available, we may access some data freed.
>
> Take policy->clk as an example:
>
> static int cpufreq_online(unsigned int cpu)
> {
>   ...
>   // policy->cpus != 0 at this time
>   down_write(&policy->rwsem);
>   ret = cpufreq_add_dev_interface(policy);
>   up_write(&policy->rwsem);
>
>   down_write(&policy->rwsem);
>   ...
>   /* cpufreq nitialization fails in some cases */
>   if (cpufreq_driver->get && has_target()) {
>     policy->cur = cpufreq_driver->get(policy->cpu);
>     if (!policy->cur) {
>       ret = -EIO;
>       pr_err("%s: ->get() failed\n", __func__);
>       goto out_destroy_policy;
>     }
>   }
>   ...
>   up_write(&policy->rwsem);
>   ...
>
>   return 0;
>
> out_destroy_policy:
>         for_each_cpu(j, policy->real_cpus)
>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>     up_write(&policy->rwsem);
> ...
> out_exit_policy:
>   if (cpufreq_driver->exit)
>     cpufreq_driver->exit(policy);
>       clk_put(policy->clk);
>       // policy->clk is a wild pointer
> ...
>                                     ^
>                                     |
>                             Another process access
>                             __cpufreq_get
>                               cpufreq_verify_current_freq
>                                 cpufreq_generic_get
>                                   // acces wild pointer of policy->clk;
>                                     |
>                                     |
> out_offline_policy:                 |
>   cpufreq_policy_free(policy);      |
>     // deleted here, and will wait for no body reference
>     cpufreq_policy_put_kobj(policy);
> }
>
> We can fix it by clear the policy->cpus mask.
> Both show_scaling_cur_freq and show_cpuinfo_cur_freq will return an
> error by checking this mask, thus avoiding UAF.

So the UAF only happens if something is freed by ->offline() or
->exit() and I'm not sure where the mask is checked in the
scaling_cur_freq() path.

Overall, the patch is really two changes in one IMO.

> Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> ---
>
> Changelog:
> v1 -> v2:
>         - Fix bad critical region enlarge which causes uninitialized
>           unlock.
> v2 -> v3:
>         - Remove the missed down_write() before
>           cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 80f535cc8a75..d93958dbdab8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1337,12 +1337,12 @@ static int cpufreq_online(unsigned int cpu)
>                 down_write(&policy->rwsem);
>                 policy->cpu = cpu;
>                 policy->governor = NULL;
> -               up_write(&policy->rwsem);
>         } else {
>                 new_policy = true;
>                 policy = cpufreq_policy_alloc(cpu);
>                 if (!policy)
>                         return -ENOMEM;
> +               down_write(&policy->rwsem);
>         }
>
>         if (!new_policy && cpufreq_driver->online) {
> @@ -1382,7 +1382,6 @@ static int cpufreq_online(unsigned int cpu)
>                 cpumask_copy(policy->related_cpus, policy->cpus);
>         }
>
> -       down_write(&policy->rwsem);
>         /*
>          * affected cpus must always be the one, which are online. We aren't
>          * managing offline cpus here.

The first change, which could and probably should be a separate patch,
ends here.

You prevent the rwsem from being dropped in the existing policy case
and acquire it right after creating a new policy.

This way ->online() always runs under the rwsem, which definitely
sounds like a good idea, and policy->cpus is manipulated under the
rwsem which IMV is required.

As a side-effect, ->init() is also run under the rwsem, but that
shouldn't be a problem as per your discussion with Viresh.

So the above would be patch 1 in a series.

The change below is a separate one and it addresses the particular
race you've discovered, as long as patch 1 above is present.  It would
be patch 2 in the series.

> @@ -1533,7 +1532,7 @@ static int cpufreq_online(unsigned int cpu)
>         for_each_cpu(j, policy->real_cpus)
>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>
> -       up_write(&policy->rwsem);
> +       cpumask_clear(policy->cpus);

It is OK to clear policy->cpus here, because ->offline() and ->exit()
are called with policy->cpus clear from cpufreq_offline() and
cpufreq_remove_dev(), so they cannot assume policy->cpus to be
populated when they are invoked.  However, this needs to be stated in
the changelog of patch 2.

>  out_offline_policy:
>         if (cpufreq_driver->offline)
> @@ -1542,6 +1541,7 @@ static int cpufreq_online(unsigned int cpu)
>  out_exit_policy:
>         if (cpufreq_driver->exit)
>                 cpufreq_driver->exit(policy);
> +       up_write(&policy->rwsem);

It is consistent to run ->offline() and ->exit() under the rwsem, so
this change is OK too.

>  out_free_policy:
>         cpufreq_policy_free(policy);
> --

That said, there still are races that are not addressed by the above,
so I would add patch 3 changing show() to check policy_is_inactive()
under the rwsem.

Thanks!
