Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47A450BA51
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448779AbiDVOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444460AbiDVOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:41:28 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621015BE45;
        Fri, 22 Apr 2022 07:38:35 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ebf4b91212so87470967b3.8;
        Fri, 22 Apr 2022 07:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0Vftok5Nvg9cisIqL5OFcU6eRNBtw4NVj7c2gCi/PY=;
        b=xNBx5ixEw9m0VQD0QmEuq2v1scW9Rdq/IViSkIFqkLsJar+psOm4l6VvlQBBxwcLpr
         7+DFFbeTKP9czNVSKLIN4s19UZLhT+UYrMonc15/sZlAanQ9fyGsQ1zzraTxW4sy3GsK
         55SteBudpS4QhrE+0JmmKnOAm2V6mXhxsmhNa/CxtDi5jeGG/NLR5dlEJzoVl6kY5E9J
         9z/Ljl4686uxpjInGdB8hq1ycrlABYSjnD8lLFVdUG4jeXk3vbGmhdRz5aKi5ysxik6W
         xJw2y9jDLwSGRt2NaMqqxVlkjEMpNaN5+GGj3EYwQpxLf16lU6KEaaDdbhbamm+PCvPA
         RGAg==
X-Gm-Message-State: AOAM533HaJOUdnJnFr4ieV8VBbJPbnBcfIYzgIJFauL1K480X63eO4ff
        KpUdN8GYJsC5+NV0Ftc+e7R2JdsTV+8oO2JYNm8=
X-Google-Smtp-Source: ABdhPJwtcD+GP67nrddpykrQMidPY41LYes/g/zoTRBXgWrqje6WF7feM6ueQL6pY/H9+15vshyAMAKhw+xg5vCnPAw=
X-Received: by 2002:a81:1096:0:b0:2ec:4a46:7e5a with SMTP id
 144-20020a811096000000b002ec4a467e5amr5328668ywq.196.1650638314653; Fri, 22
 Apr 2022 07:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220420191541.99528-1-schspa@gmail.com>
In-Reply-To: <20220420191541.99528-1-schspa@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 16:38:23 +0200
Message-ID: <CAJZ5v0guPiGx-ZnC0RcqVgDEp0bh4DcKC7QYjjO0PF_3kHdVGg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: fix race on cpufreq online
To:     Schspa Shi <schspa@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 9:16 PM Schspa Shi <schspa@gmail.com> wrote:
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
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 80f535cc8a75..0d58b0f8f3af 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1533,8 +1533,6 @@ static int cpufreq_online(unsigned int cpu)
>         for_each_cpu(j, policy->real_cpus)
>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>
> -       up_write(&policy->rwsem);
> -
>  out_offline_policy:
>         if (cpufreq_driver->offline)
>                 cpufreq_driver->offline(policy);
> @@ -1543,6 +1541,9 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->exit)
>                 cpufreq_driver->exit(policy);
>
> +       cpumask_clear(policy->cpus);
> +       up_write(&policy->rwsem);

This change is correct AFAICS, but it doesn't really fix the race,
because show_cpuinfo_cur_freq() uses __cpufreq_get() directly without
locking.

It should use cpufreq_get() instead.

> +
>  out_free_policy:
>         cpufreq_policy_free(policy);
>         return ret;
> --
