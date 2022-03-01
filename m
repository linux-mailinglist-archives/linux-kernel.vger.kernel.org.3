Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D764C8E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiCAPDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiCAPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:03:07 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B40A252D;
        Tue,  1 Mar 2022 07:02:26 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id j2so27825235ybu.0;
        Tue, 01 Mar 2022 07:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFDfDJO6ZGSp0wOxPcBF1+Lx0Ev5xgBLaqunI+gbJ+w=;
        b=ei0GyHu3+yNeOZC8D80ONNfyKcF9PLhBzqrI6R70jED/OwQTF0jJkUtowKZgM3l3EA
         QmrHxjz3Jg08pwsaLIm9qhc+GYymitVVapI+dTfB99l7Wb/XLfVHxux/3pu9j/tstHUK
         6bVt8UMq9d7skDYB3NRfzJqOH0qtVb+RedjDO1nxsEqJRFHpFKJS/Ux0dBMaSYPIImdO
         Nmgvs+c+qpcrG2N0DDFUG5GyYc8ub6wXGAwVKzZk2p8rp18MK8ysTdoCLE5go0f9i6lY
         hfl1v1aKoH4xAKCUEIcr0a6wxHShn32pgs2JRX/Yfo8HoXqpIsR1s+5N0aryu23beZmK
         HqPA==
X-Gm-Message-State: AOAM5316bSJbnU6E8XJE1wlfkCccmq6nAmM8dBk+EEMXoKL74Qvf5lcn
        UujDtRufJkAyUSwy0lb/i1E+hMqRnYea2tGKjgs=
X-Google-Smtp-Source: ABdhPJwzl9rPgcYo3NaPbsfsE79SyzPg9BoEMnp1SxTesYIFS0znZ9/UAaPrMu/8PfymoJTBJTiOrqWhGQoJte9LTro=
X-Received: by 2002:a25:3f47:0:b0:628:7571:b07d with SMTP id
 m68-20020a253f47000000b006287571b07dmr3914531yba.622.1646146945404; Tue, 01
 Mar 2022 07:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20220225064815.444571-1-shawnguo@kernel.org> <CAPDyKFq195ptPe1i71mcQG+VLvLWgrYD0kF8ZNV-KLOqS0td4g@mail.gmail.com>
In-Reply-To: <CAPDyKFq195ptPe1i71mcQG+VLvLWgrYD0kF8ZNV-KLOqS0td4g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 16:02:14 +0100
Message-ID: <CAJZ5v0jAbGDEVz4OYwhnqZErOm1xuGVnr2ufkYXv6x3LCq4QxA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Fix sleep-in-atomic bug caused by genpd_debug_remove()
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Thierry Strudel <tstrudel@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
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

On Tue, Mar 1, 2022 at 11:38 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 25 Feb 2022 at 07:48, Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > From: Shawn Guo <shawn.guo@linaro.org>
> >
> > When a genpd with GENPD_FLAG_IRQ_SAFE gets removed, the following
> > sleep-in-atomic bug will be seen, as genpd_debug_remove() will be called
> > with a spinlock being held.
> >
> > [    0.029183] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1460
> > [    0.029204] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper/0
> > [    0.029219] preempt_count: 1, expected: 0
> > [    0.029230] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc4+ #489
> > [    0.029245] Hardware name: Thundercomm TurboX CM2290 (DT)
> > [    0.029256] Call trace:
> > [    0.029265]  dump_backtrace.part.0+0xbc/0xd0
> > [    0.029285]  show_stack+0x3c/0xa0
> > [    0.029298]  dump_stack_lvl+0x7c/0xa0
> > [    0.029311]  dump_stack+0x18/0x34
> > [    0.029323]  __might_resched+0x10c/0x13c
> > [    0.029338]  __might_sleep+0x4c/0x80
> > [    0.029351]  down_read+0x24/0xd0
> > [    0.029363]  lookup_one_len_unlocked+0x9c/0xcc
> > [    0.029379]  lookup_positive_unlocked+0x10/0x50
> > [    0.029392]  debugfs_lookup+0x68/0xac
> > [    0.029406]  genpd_remove.part.0+0x12c/0x1b4
> > [    0.029419]  of_genpd_remove_last+0xa8/0xd4
> > [    0.029434]  psci_cpuidle_domain_probe+0x174/0x53c
> > [    0.029449]  platform_probe+0x68/0xe0
> > [    0.029462]  really_probe+0x190/0x430
> > [    0.029473]  __driver_probe_device+0x90/0x18c
> > [    0.029485]  driver_probe_device+0x40/0xe0
> > [    0.029497]  __driver_attach+0xf4/0x1d0
> > [    0.029508]  bus_for_each_dev+0x70/0xd0
> > [    0.029523]  driver_attach+0x24/0x30
> > [    0.029534]  bus_add_driver+0x164/0x22c
> > [    0.029545]  driver_register+0x78/0x130
> > [    0.029556]  __platform_driver_register+0x28/0x34
> > [    0.029569]  psci_idle_init_domains+0x1c/0x28
> > [    0.029583]  do_one_initcall+0x50/0x1b0
> > [    0.029595]  kernel_init_freeable+0x214/0x280
> > [    0.029609]  kernel_init+0x2c/0x13c
> > [    0.029622]  ret_from_fork+0x10/0x20
> >
> > It doesn't seem necessary to call genpd_debug_remove() with the lock, so
> > move it out from locking to fix the problem.
> >
> > Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>
> Thanks for fixing this!
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 5.18 material.

> Rafael, I think we should tag this for stable kernels too.

Done.

Thanks!
