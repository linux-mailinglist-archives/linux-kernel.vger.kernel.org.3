Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED82521F27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbiEJPmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346099AbiEJPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:39:39 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654641F8C5E;
        Tue, 10 May 2022 08:35:04 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y76so31408883ybe.1;
        Tue, 10 May 2022 08:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0b4svRqqLvSjZJ3zoTOM74xlJmN8RWL/PjHlhHodGU=;
        b=icXlApJ+3wo3VZ+9VSoCprhBXao5sABZt9l9EVCZzgUuD8jE5enge46Rx7CJ8e2qO+
         4IOPQCYDoXeceWwfSkX5pPUCUFVoQjrB4W4sOEL/g1JqXUQsSm0F9OATbeV6VQV1rW52
         EzZ6i7KkYnaEXrsgpkOKDP/0Uv9qjqy3+iTx43NPOSEglcHNqQ67seCcV9AIpirVtiNN
         A1cw50ipHgvdD7YF8u+KDqMH/O5VGl7SB6gDE+kuIPFvpIS5auJOMaDfZwITPKwnQR5A
         UB/wsS3MG5b/vCptgGyOAtq+OQzAkKoaPKyIqIXE8Xq6d2cuYFReXNsUIXRX+HCxd3Fa
         gK4w==
X-Gm-Message-State: AOAM5332qhptbjL3OEdOVV2j8N8wI9XrtWgUxkVNT1q37ICpT5GlfEhc
        JOGeuuuc6FxLFhr0QvAC9TKUInlhe9tbdkEoJiQ=
X-Google-Smtp-Source: ABdhPJz5wgor03irFmw2wqgvtOOp8DCo6bgMa19LwGPaMtLH+4JR/3kdDmT65DDU7lOYUnMbwNPbcYQEfRRVWu7ekGc=
X-Received: by 2002:a25:c0d5:0:b0:64a:c6dd:1a00 with SMTP id
 c204-20020a25c0d5000000b0064ac6dd1a00mr10716120ybf.365.1652196901076; Tue, 10
 May 2022 08:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510152811.88071-1-schspa@gmail.com>
In-Reply-To: <20220510152811.88071-1-schspa@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 May 2022 17:34:49 +0200
Message-ID: <CAJZ5v0hj_7tGTQm8q4AVqL6F=Y6FzGP=UV7TkbJ=hJk2LPCN1Q@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: fix race on cpufreq online
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

On Tue, May 10, 2022 at 5:28 PM Schspa Shi <schspa@gmail.com> wrote:
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
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> ---
>
> Changelog:
> v1 -> v2:
>         - Fix bad critical region enlarge which causes uninitialized
>           unlock.
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 80f535cc8a75..8edfa840dd74 100644
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

You seem to have missed the down_write() before the

cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);

statement.

It needs to be removed, because the semaphore is already being held
for writing at that point after the changes above.

> @@ -1533,7 +1533,7 @@ static int cpufreq_online(unsigned int cpu)
>         for_each_cpu(j, policy->real_cpus)
>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
>
> -       up_write(&policy->rwsem);
> +       cpumask_clear(policy->cpus);
>
>  out_offline_policy:
>         if (cpufreq_driver->offline)
> @@ -1542,6 +1542,7 @@ static int cpufreq_online(unsigned int cpu)
>  out_exit_policy:
>         if (cpufreq_driver->exit)
>                 cpufreq_driver->exit(policy);
> +       up_write(&policy->rwsem);
>
>  out_free_policy:
>         cpufreq_policy_free(policy);
> --
