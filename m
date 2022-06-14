Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2958954B2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbiFNN7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245328AbiFNN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:59:13 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD683334C;
        Tue, 14 Jun 2022 06:59:12 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-30ce6492a60so30351447b3.8;
        Tue, 14 Jun 2022 06:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DiRdL8duDyIHD6Nrt/s9DO6S9xYvs+pewZXGWKr83oU=;
        b=F7+lDjB1LY8+C+uCiKKFDC/cJqlxZAcGXl7nB/Q5PoIFZOgo9quo68RClHJmF2F5/O
         vtifMor1FWSdVJNUQ1m3+8O3M3TKDk9+VqDosQYUFqsDykdMwwB3ZmNEJjBpdQAS533w
         0esdkmVWCl0t0JlUP6gNxnCpJOKlRFWbNVCwgZ4owuhOxmlp+3EtSgi7pjJ/cvDCU7qD
         3Hr8ziTpXLn7d10RjU7YJr5lvVIQatu1y2N+1NN+a66EuXd8wjxDYv/2pPw74ONBLEE0
         DrtPJ+v93x7zkg3gYkAsyCQhnC3ayWy8zyBqmThlkh5iazDVnQsAmfWFBJb1MGtWv8h9
         /7wQ==
X-Gm-Message-State: AJIora/qv8vYmiV6nkCsDJK51EfEpDBlBUKnkuh+77c1YYOOGKI0XnqN
        /umtXsQNjRq0ywMeK+co39EqBdTNqtZKpTYSKAygV8q0/0w=
X-Google-Smtp-Source: AGRyM1sFQuBs2xBokqAiNhHO7MCfL0HvIR4LcShp/DTuYO2FaLXtI5Mr+Cz8F2WU2HiJkgoLukiKankCmyFZUXoLeYA=
X-Received: by 2002:a81:260a:0:b0:2f4:ca82:a42f with SMTP id
 m10-20020a81260a000000b002f4ca82a42fmr5931264ywm.149.1655215151897; Tue, 14
 Jun 2022 06:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <8c3d50faf8811e86136fb3f9c459e43fc3c50bc0.1653565641.git.viresh.kumar@linaro.org>
 <426bf6edc80b2e944d459fa7b8dffbe8b73bb3d9.1653623526.git.viresh.kumar@linaro.org>
In-Reply-To: <426bf6edc80b2e944d459fa7b8dffbe8b73bb3d9.1653623526.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jun 2022 15:59:01 +0200
Message-ID: <CAJZ5v0gswDEdK9-gC1dPr9BFPv3G9rs+JYe-7=1JZ11OMoBb-g@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] cpufreq: Panic if policy is active in cpufreq_policy_free()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, May 27, 2022 at 5:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> With the new design in place, to avoid potential races show() and
> store() callbacks check if the policy is active or not before proceeding
> any further. And in order to guarantee that cpufreq_policy_free() must
> be called after clearing the policy->cpus mask, i.e. by marking it
> inactive.
>
> Lets make sure we don't get a bug around this later and catch this early
> by putting a BUG_ON() within cpufreq_policy_free().
>
> Also update cpufreq_online() a bit to make sure we clear the cpus mask
> for each error case before calling cpufreq_policy_free().
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2: Update cpufreq_online() and changelog.
>
>  drivers/cpufreq/cpufreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e24aa5d4bca5..0f8245731783 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1284,6 +1284,12 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>         unsigned long flags;
>         int cpu;
>
> +       /*
> +        * The callers must ensure the policy is inactive by now, to avoid any
> +        * races with show()/store() callbacks.
> +        */
> +       BUG_ON(!policy_is_inactive(policy));

I'm not a super-big fan of this change.

First off, crashing the kernel outright here because of possible races
appears a bit excessive to me.

Second, it looks like we are worrying about the code running before
the wait_for_completion() call in cpufreq_policy_put_kobj(), because
after that call no one can be running show() or store().  So why don't
we reorder the wait_for_completion() call with respect to the code in
question instead?

> +
>         /* Remove policy from list */
>         write_lock_irqsave(&cpufreq_driver_lock, flags);
>         list_del(&policy->policy_list);
> @@ -1538,8 +1544,6 @@ static int cpufreq_online(unsigned int cpu)
>         for_each_cpu(j, policy->real_cpus)
>                 remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
>
> -       cpumask_clear(policy->cpus);
> -
>  out_offline_policy:
>         if (cpufreq_driver->offline)
>                 cpufreq_driver->offline(policy);
> @@ -1549,6 +1553,7 @@ static int cpufreq_online(unsigned int cpu)
>                 cpufreq_driver->exit(policy);
>
>  out_free_policy:
> +       cpumask_clear(policy->cpus);
>         up_write(&policy->rwsem);
>
>         cpufreq_policy_free(policy);
> --
> 2.31.1.272.g89b43f80a514
>
