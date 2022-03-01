Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887B54C896C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiCAKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiCAKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:39:00 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B2312AFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:38:19 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id y24so2265285ljh.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Omz5gzwo4aJlILXVhXK03oGpHG1ApzpOAfyGCi5xOHM=;
        b=qGMMfoYqfanaKo2fc2sZLShhCfqBXms0+/0P9nAD+fwPyDrn+Rj0L85pyvcaQFmFGm
         hAv4RxXp3kx4LjgY7giQfALYTr/ekGZCab/NZ2FCGmzK9jxy4QJCQuW5i0TzKaI159S0
         QGbX8NCQBm9y2cUVMm6HgeyftsApenBKIuSQtlX+d+z5PCZCHHolWlw0plzDIWj4Usaj
         hdvkuZnwEmA++s5vrIOZK6BRaaqE2pNbLn4F31PtOK3J9U+uxSDFAJfC70jZxtdnnCLQ
         AGpomoJJc8JkXbhWqRD4RgXXLMxOPkDmjhZENhLnVYf4gZqLOIANScXfqfsZMJEsqFHx
         TMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Omz5gzwo4aJlILXVhXK03oGpHG1ApzpOAfyGCi5xOHM=;
        b=XDApUYmKaXdqMExLFCeuursOScMPazwzAi5NKvXPqGbtD2S7ifTp9RL8iTsjv3vWTA
         Mouw+fFiODMC8fIPfuvIuSsSml6WtlNwtkie+rOgQHF+JdXvURaPUM5YQ2sXjbapkqbm
         qBcXvTv2KSiX7ELHqIxAweikqtWaGtYxdGbIZgYqbf/POXWx1Jlx/7SycIWzykPNbihi
         2GTiOb/3Gs8z9E/LiHMOJV09hZ/PRSL9ZzcQby970kaiI6CV/ZjsLGghdeFsmf2xnSZu
         xvdz4NcgDSDyuqRwMfgVA06fJ6UoftoE91BKCzvPOFUqYQTGKtt8OF9kUgTpwSh8kVdZ
         RS+A==
X-Gm-Message-State: AOAM531OUZH5AwdTpwD6PaarW7es/FvzwuXQWJCMO58Sz25+Yg5juk77
        pNKNYknG0Sh1AIYGMmwy6yobUFDT3Oh7uWIbdbXIuTHvNAA=
X-Google-Smtp-Source: ABdhPJywlPCioo2/+DVdHzNQQkG8kpU+jzVjiPnR1HyRr/ivK6iJFvw1wPBnWBbm1QWeNvd+RMeF6YoCaxZSAavIZ4U=
X-Received: by 2002:a2e:9cc5:0:b0:239:da6e:290d with SMTP id
 g5-20020a2e9cc5000000b00239da6e290dmr17130771ljj.4.1646131097502; Tue, 01 Mar
 2022 02:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20220225064815.444571-1-shawnguo@kernel.org>
In-Reply-To: <20220225064815.444571-1-shawnguo@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Mar 2022 11:37:41 +0100
Message-ID: <CAPDyKFq195ptPe1i71mcQG+VLvLWgrYD0kF8ZNV-KLOqS0td4g@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Fix sleep-in-atomic bug caused by genpd_debug_remove()
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Thierry Strudel <tstrudel@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
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

On Fri, 25 Feb 2022 at 07:48, Shawn Guo <shawnguo@kernel.org> wrote:
>
> From: Shawn Guo <shawn.guo@linaro.org>
>
> When a genpd with GENPD_FLAG_IRQ_SAFE gets removed, the following
> sleep-in-atomic bug will be seen, as genpd_debug_remove() will be called
> with a spinlock being held.
>
> [    0.029183] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1460
> [    0.029204] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper/0
> [    0.029219] preempt_count: 1, expected: 0
> [    0.029230] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc4+ #489
> [    0.029245] Hardware name: Thundercomm TurboX CM2290 (DT)
> [    0.029256] Call trace:
> [    0.029265]  dump_backtrace.part.0+0xbc/0xd0
> [    0.029285]  show_stack+0x3c/0xa0
> [    0.029298]  dump_stack_lvl+0x7c/0xa0
> [    0.029311]  dump_stack+0x18/0x34
> [    0.029323]  __might_resched+0x10c/0x13c
> [    0.029338]  __might_sleep+0x4c/0x80
> [    0.029351]  down_read+0x24/0xd0
> [    0.029363]  lookup_one_len_unlocked+0x9c/0xcc
> [    0.029379]  lookup_positive_unlocked+0x10/0x50
> [    0.029392]  debugfs_lookup+0x68/0xac
> [    0.029406]  genpd_remove.part.0+0x12c/0x1b4
> [    0.029419]  of_genpd_remove_last+0xa8/0xd4
> [    0.029434]  psci_cpuidle_domain_probe+0x174/0x53c
> [    0.029449]  platform_probe+0x68/0xe0
> [    0.029462]  really_probe+0x190/0x430
> [    0.029473]  __driver_probe_device+0x90/0x18c
> [    0.029485]  driver_probe_device+0x40/0xe0
> [    0.029497]  __driver_attach+0xf4/0x1d0
> [    0.029508]  bus_for_each_dev+0x70/0xd0
> [    0.029523]  driver_attach+0x24/0x30
> [    0.029534]  bus_add_driver+0x164/0x22c
> [    0.029545]  driver_register+0x78/0x130
> [    0.029556]  __platform_driver_register+0x28/0x34
> [    0.029569]  psci_idle_init_domains+0x1c/0x28
> [    0.029583]  do_one_initcall+0x50/0x1b0
> [    0.029595]  kernel_init_freeable+0x214/0x280
> [    0.029609]  kernel_init+0x2c/0x13c
> [    0.029622]  ret_from_fork+0x10/0x20
>
> It doesn't seem necessary to call genpd_debug_remove() with the lock, so
> move it out from locking to fix the problem.
>
> Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks for fixing this!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Rafael, I think we should tag this for stable kernels too.

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5db704f02e71..7e8039d1884c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2058,9 +2058,9 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>                 kfree(link);
>         }
>
> -       genpd_debug_remove(genpd);
>         list_del(&genpd->gpd_list_node);
>         genpd_unlock(genpd);
> +       genpd_debug_remove(genpd);
>         cancel_work_sync(&genpd->power_off_work);
>         if (genpd_is_cpu_domain(genpd))
>                 free_cpumask_var(genpd->cpus);
> --
> 2.25.1
>
