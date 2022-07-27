Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E235830B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiG0RlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242763AbiG0RkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:40:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD2288CF1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:51:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u5so25377577wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5ZNMSwdcJkG6KPJIb0W+U74aIz+GfkcDdkzoyBtD9w=;
        b=DtuUl7vBd/Otj8nYy9m3c3yqjafcAXPqKMu3qB2s2dCfiHNTsoCFY0BLFn+P2VhRWz
         A+kJvO+R1p0q4VINv8aN6zYrLZdrb6kWSmSFFg/GRhCMG8oOFOxwsHUYqYgKiL6BPDin
         dbsFQn7Kg/PJc2xgMlPq5gga8WKikxBh7t+NI++fMhNVJUO+ud1HWCHWj6f8bzRTidqv
         aaGErT4rlaxoS5ZN2KiQ7xCzPpFCsu33Bq4cXycoTM/AtP8I67J7M3Nqp6OmycGyrOdP
         OPl21t0AjATITiyAeE9NLycKgkkHfF4EiW/eXDzKpsHNKnvmeJQroi7A3WODdbSj9XpL
         g3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5ZNMSwdcJkG6KPJIb0W+U74aIz+GfkcDdkzoyBtD9w=;
        b=WoGE8aovR7rk0yeiRqOhal6ItZz5RwExjJM0Ljhn4jpA4ITqezAS19yqRh/vVv/vaw
         JpmRxxRuj6rhPmfuanekkp1mnJpcYyNVdzOi+dg42XYtnIYXyLBNNSBeiypw60mTpFJb
         0r4Dx47Ehlt53rHzJLzw5EL5P5QInFuyP4Pww0PlCYG1HdsbbTUps9sSiS096oglYH9y
         m1hdENkUbagc/K+dC2PP/UkFWIoKysJiPKRjwioULO1rRlW1Wp08c0V1ATfwcn6tqABe
         OGJA6KfoNcBLwpKBe7VM2yE5BjgVMPOclmq4pdzRIqp+fXYM17hjzhUbGeqd7pYgvMF4
         M/Gg==
X-Gm-Message-State: AJIora/mK4T4qYBcGjQPKOSZqrkg/ovjCgQ0P1dfCEd+rlpOde+PzBC9
        FwbAckor4s1jpPFdT2RCbzOqL6pi7Zuf+K9QVAY=
X-Google-Smtp-Source: AGRyM1sIh87v+3o0m9fLla1y8MvMvtik1q73gdssrrMAFUVdQrhghOTjUABgwt7OePtZHehkKay3QYN0Gkasazv2mtY=
X-Received: by 2002:a05:6000:81d:b0:21e:939b:a62 with SMTP id
 bt29-20020a056000081d00b0021e939b0a62mr7961197wrb.107.1658940679808; Wed, 27
 Jul 2022 09:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220727110426.19079-1-quic_yingangl@quicinc.com>
In-Reply-To: <20220727110426.19079-1-quic_yingangl@quicinc.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 28 Jul 2022 00:51:08 +0800
Message-ID: <CAJhGHyDXL90aprU2FjF++5DunJb90MiWRcz4VzBeFmJ0xeq-VA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: avoid re-entry of pwq->pool->lock through __queue_work
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 7:04 PM Kassey Li <quic_yingangl@quicinc.com> wrote:
>
> [0:swapper/4]BUG: spinlock recursion on CPU#4, swapper/4/0
> [0:swapper/4]lock: 0xffffff8000c0f400, .magic: dead4ead, .owner:
> swapper/4/0, .owner_cpu: 4
> [0:swapper/4]CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S
> [0:swapper/4]Call trace:
> [0:swapper/4] dump_backtrace.cfi_jt+0x0/0x8
> [0:swapper/4] show_stack+0x1c/0x2c
> [0:swapper/4] dump_stack_lvl+0xd8/0x16c
> [0:swapper/4] spin_dump+0x104/0x278
> [0:swapper/4] do_raw_spin_lock+0xec/0x15c
> [0:swapper/4] _raw_spin_lock+0x28/0x3c
> [0:swapper/4] __queue_work+0x1fc/0x618
> [0:swapper/4] queue_work_on+0x64/0x134
> [0:swapper/4] memlat_hrtimer_handler+0x28/0x3c [memlat]
> [0:swapper/4] __run_hrtimer+0xe8/0x448
> [0:swapper/4] hrtimer_interrupt+0x184/0x40c
> [0:swapper/4] arch_timer_handler_virt+0x5c/0x98
> [0:swapper/4] handle_percpu_devid_irq+0xd8/0x3e0
> [0:swapper/4] __handle_domain_irq+0xd0/0x19c
> [0:swapper/4] gic_handle_irq+0x6c/0x134
> [0:swapper/4] el1_irq+0xe4/0x1c0

It seems it is an unexpected IRQ.

> [0:swapper/4] _raw_spin_unlock_irqrestore+0x2c/0x60
> [0:swapper/4] try_to_wake_up.llvm.14610847381734009831+0x334/0x888
> [0:swapper/4] wake_up_process+0x1c/0x2c
> [0:swapper/4] __queue_work+0x3e8/0x618
> [0:swapper/4] delayed_work_timer_fn+0x24/0x34

delayed_work_timer_fn() should have been invoked with IRQ disabled
since it is TIMER_IRQSAFE.

Could you add some code to check if it is the case if possible, please?

> [0:swapper/4] call_timer_fn+0x58/0x268
> [0:swapper/4] expire_timers+0xe0/0x1c4

Or could you do a "disass expire_timers+0xe0" in GDB?

> [0:swapper/4] __run_timers+0x16c/0x1c4
> [0:swapper/4] run_timer_softirq+0x34/0x60
> [0:swapper/4] efi_header_end+0x198/0x59c
> [0:swapper/4] __irq_exit_rcu+0xdc/0xf0
> [0:swapper/4] irq_exit+0x14/0x50
> [0:swapper/4] __handle_domain_irq+0xd4/0x19c
> [0:swapper/4] gic_handle_irq+0x6c/0x134
> [0:swapper/4] el1_irq+0xe4/0x1c0
> [0:swapper/4] cpuidle_enter_state+0x1b4/0x5dc
> [0:swapper/4] cpuidle_enter+0x3c/0x58
> [0:swapper/4] do_idle.llvm.6296834828977863291+0x1f4/0x2e8
> [0:swapper/4] cpu_startup_entry+0x28/0x2c
> [0:swapper/4] secondary_start_kernel+0x1c8/0x230
>
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  kernel/workqueue.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 1ea50f6be843..f23491f373b1 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1468,10 +1468,10 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>                 } else {
>                         /* meh... not running there, queue here */
>                         raw_spin_unlock(&last_pool->lock);
> -                       raw_spin_lock(&pwq->pool->lock);
> +                       raw_spin_lock_irq(&pwq->pool->lock);
>                 }
>         } else {
> -               raw_spin_lock(&pwq->pool->lock);
> +               raw_spin_lock_irq(&pwq->pool->lock);
>         }
>
>         /*
> @@ -1484,7 +1484,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>          */
>         if (unlikely(!pwq->refcnt)) {
>                 if (wq->flags & WQ_UNBOUND) {
> -                       raw_spin_unlock(&pwq->pool->lock);
> +                       raw_spin_unlock_irq(&pwq->pool->lock);

The patch is hardly correct, __queue_work() is called with irq-disabled,
this code will enable IRQ imbalanced.

>                         cpu_relax();
>                         goto retry;
>                 }
> @@ -1517,7 +1517,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
>         insert_work(pwq, work, worklist, work_flags);
>
>  out:
> -       raw_spin_unlock(&pwq->pool->lock);
> +       raw_spin_unlock_irq(&pwq->pool->lock);
>         rcu_read_unlock();
>  }
>
> --
> 2.17.1
>
