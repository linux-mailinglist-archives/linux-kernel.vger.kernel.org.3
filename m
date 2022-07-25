Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143B558039D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbiGYRlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGYRlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:41:18 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B1E14D0E;
        Mon, 25 Jul 2022 10:41:17 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31f379a0754so15250787b3.2;
        Mon, 25 Jul 2022 10:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3IhhclTIPbl2mf4VpDDOOj1WY1RyO1WWUZZG7ltuKqA=;
        b=lMAXG3CQzNQ86IggIF+zCZQhm+33FohG7/XYdhD8iXOZinZjmYh6KNZkY0nFF6SKdI
         t16o64jdfklhHp7pvAV3MJ8JI2shJSy+SJPtoTsoYjUvh4OcZnkmjVnWcndGgGeY8RKv
         LnYDXdMVTuI/VuTZV4gIYJGAKPuYqOjE1Q5fliZBWR4fAxPBcQNToKYL6j041+QM8Bmq
         YUE2hUNg/veXYSPGk044RE3RvukD5esKp/iuKxZNgyRVzhscm3mPpaDVmDF7PRjE5PYJ
         r/ao1Q3hRsTNtCeEU1LQWLZu+Lu18QFFTmUhcp4LZFKfRlMGibBLenvxRDV51eCiKb7F
         vwhQ==
X-Gm-Message-State: AJIora8QOJGDzkp6PmEkFT8pHiCeEb7cW3LTltO3BiGb0w65NOmt94Qz
        t2HMTmIhh7LZ6YT5KrhamPaKuJMiAuJt41f6UUY=
X-Google-Smtp-Source: AGRyM1tHl+f3lwTtEqzX/f9XwP9tyLK3+t2hWM95ATK/qXh4QeDQlnZwrVm0LS3uqiJctWDDwMlqHVFs617zoMC8dBM=
X-Received: by 2002:a81:78c6:0:b0:31e:848b:6e2 with SMTP id
 t189-20020a8178c6000000b0031e848b06e2mr11086109ywc.301.1658770876326; Mon, 25
 Jul 2022 10:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220723195932.1302575-1-longman@redhat.com>
In-Reply-To: <20220723195932.1302575-1-longman@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jul 2022 19:41:05 +0200
Message-ID: <CAJZ5v0hL7P2miQjivtirzUhuTzqkM091GYCr+OjQARyi7TXSYQ@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Fix false positive RCU splats due to
 incorrect hardirqs state
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

On Sat, Jul 23, 2022 at 10:00 PM Waiman Long <longman@redhat.com> wrote:
>
> Commit 32d4fd5751ea ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
> uses raw_local_irq_enable/local_irq_disable() around call to
> __intel_idle() in intel_idle_irq().
>
> With interrupt enabled, timer tick interrupt can happen and a
> subsequently call to __do_softirq() may change the lockdep hardirqs state
> of a debug kernel back to 'on'. This will result in a mismatch between
> the cpu hardirqs state (off) and the lockdep hardirqs state (on) causing
> a number of false positive "WARNING: suspicious RCU usage" splats.
>
> Fix that by using local_irq_disable() to disable interrupt in
> intel_idle_irq().
>
> Fixes: 32d4fd5751ea ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied as 5.19-rc material.

Peter, please let me know if you have concerns.

> ---
>  drivers/idle/intel_idle.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index f5c6802aa6c3..907700d1e78e 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -162,7 +162,13 @@ static __cpuidle int intel_idle_irq(struct cpuidle_device *dev,
>
>         raw_local_irq_enable();
>         ret = __intel_idle(dev, drv, index);
> -       raw_local_irq_disable();
> +
> +       /*
> +        * The lockdep hardirqs state may be changed to 'on' with timer
> +        * tick interrupt followed by __do_softirq(). Use local_irq_disable()
> +        * to keep the hardirqs state correct.
> +        */
> +       local_irq_disable();
>
>         return ret;
>  }
> --
> 2.31.1
>
