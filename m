Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B8D4F1FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239901AbiDDXJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbiDDXIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:08:22 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F193336C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 15:37:27 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id g9so10623566ybj.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 15:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=071e1Ar7RhANSeSw/1hQ+tK1Zd4T0V5uudDG6xLAnzo=;
        b=PyH2232EmsU58Z+R1iqZEHNkD3HcH6VC0n1E7TFXAytpae2eL9gGeY68qcr4MCe6/P
         Z8Sj2Mj+PRvy9klnrPg0RVEa6pEbDkPXlePrOemMfPjhD4bss9AjK8OcKZRWqElq+Xmm
         yH1Txn3/jp/ca41Vv1J1Gi9GthjLk5LBg6O4Ir1va4r63O2Iu8HW7AUqMmwiVHY5W7gC
         Vjkg5zvn8hTC7jt+4ePQUrs7w1jSp+LQ9AHwOEOkxoNdfFcHC6QkOwkfWfgT3FTKbuGR
         c385svZ+/Y2dhHgn//zC/KQMICL5fNcDUEb/+4pEPNDPUVqy7IOTmQho9KWMbrJ7jqsl
         rVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=071e1Ar7RhANSeSw/1hQ+tK1Zd4T0V5uudDG6xLAnzo=;
        b=TQ1sAqmqbSFM9cpW4PGdmTbAScnX/9j7Fp5uYpAAZUHI2fAvo0XRfBK/r2K5wFjcZo
         f6O0OslYvoHQkjUxlyQb75MlIYXx5l/27Ah/NOFTKSHgx4aupdfVWA4sDCudoTxm4ALI
         dkskGBN+L2/GoxVtGTtzvIMgdj7mkoiGW50WzZuou3LvhotzdXMkmTH8/NXAR7ICvgz9
         QPjK0uNUvD24MmnAmoq/PawPFPn0mBn9NfbozJCho5XGf9SNNmwtp+zFtCGTpbAwycsd
         b0/FO3+kbTlHd4pPt7po8zakj5M0yguatxH5RcE+LUPmI7LVtsZ2WCgsv6KiM5pgkg27
         OgYQ==
X-Gm-Message-State: AOAM531eFtY2gfHkGwU5uHrE1tnJUTF2pqp8P+wEcMk3yOQodhWOk8AQ
        SX7OjYEqHsFY+KWLWppUWOnS+q4tKw/YwJ2gDzfwQjGg0Tw=
X-Google-Smtp-Source: ABdhPJz/lO398ROC2M2dnVSGIQ1Y9wodWcPKigPHKMRMgTtd1IVyaswxHFk5f6rTKzecrfXTrp1CG6uSo0OF4cjkCnY=
X-Received: by 2002:a25:f441:0:b0:611:4f60:aab1 with SMTP id
 p1-20020a25f441000000b006114f60aab1mr498388ybe.598.1649111845841; Mon, 04 Apr
 2022 15:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com>
 <20220331224222.GY4285@paulmck-ThinkPad-P17-Gen-1> <CANn89iJjyp7s1fYB6VCqLhUnF+mmEXyw8GMpFC9Vi22usBsgAQ@mail.gmail.com>
 <20220404194907.GA133884@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220404194907.GA133884@paulmck-ThinkPad-P17-Gen-1>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 4 Apr 2022 15:37:14 -0700
Message-ID: <CANn89i+sPBuWKvg3hzZtqHJDx69F54OG8rs=FVxM2SQXAwWHww@mail.gmail.com>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
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

On Mon, Apr 4, 2022 at 12:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 03:54:02PM -0700, Eric Dumazet wrote:
> > On Thu, Mar 31, 2022 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Mar 31, 2022 at 02:45:25PM -0700, Eric Dumazet wrote:
> > > > Hi Paul
> > > >
> > > > It seems you assume per cpu ptr for arbitrary indexes (< nr_cpu_ids) are valid.
> > >
> > > Gah!  I knew I was forgetting something...
> > >
> > > But just to check, is this a theoretical problem or something you hit
> > > on real hardware?  (For the rest of this email, I am assuming the latter.)
> >
> > Code review really...
> >
> > >
> > > > What do you think of the (untested) following patch ?
> > >
> > > One issue with this patch is that the contention could be unpredictable,
> > > or worse, vary among CPU, especially if the cpu_possible_mask was oddly
> > > distributed.
> > >
> > > So might it be better to restrict this to all on CPU 0 on the one hand
> > > and completely per-CPU on the other?  (Or all on the boot CPU, in case
> > > I am forgetting some misbegotten architecture that can run without a
> > > CPU 0.)
> >
> > If I understand correctly, cblist_init_generic() could setup
> > percpu_enqueue_shift
> > to something smaller than order_base_2(nr_cpu_ids)
> >
> > Meaning that we could reach a non zero idx in (smp_processor_id() >>
> > percpu_enqueue_shift)
> >
> > So even if CPU0 is always present (I am not sure this is guaranteed,
> > but this seems reasonable),
> > we could still attempt a per_cpu_ptr(PTR,  not_present_cpu), and get garbage.
>
> And the problem with my wish to provide load balancing is that a
> sparse cpumask could be sparse any which way that it wants to be.
> Another problem is that, unlike TREE SRCU, Tasks RCU doesn't have an
> efficient way to find all the CPUs with callbacks queued.  Yes, I could
> add that information, but the benefit does not seem worth the complexity.
>
> So I took your patch after all, but changed from cpu_online_mask to
> cpu_possible_mask.  Thank you for bearing with me on this one!
>
> Are you OK with your Signed-off-by on this patch as shown below?

Absolutely, thanks Paul for taking care of this.

>
>                                                 Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit b77b2981bb22c4449a0a6e86eeb9fbab36a2beae
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Mon Apr 4 12:30:18 2022 -0700
>
>     rcu-tasks: Handle sparse cpu_possible_mask
>
>     If the rcupdate.rcu_task_enqueue_lim kernel boot parameter is set to
>     something greater than 1 and less than nr_cpu_ids, the code attempts to
>     use a subset of the CPU's RCU Tasks callback lists.  This works, but only
>     if the cpu_possible_mask is contiguous.  If there are "holes" in this
>     mask, the callback-enqueue code might attempt to access a non-existent
>     per-CPU ->rtcpu variable for a non-existent CPU.  For example, if only
>     CPUs 0, 4, 8, 12, 16 and so on are in cpu_possible_mask, specifying
>     rcupdate.rcu_task_enqueue_lim=4 would cause the code to attempt to
>     use callback queues for non-existent CPUs 1, 2, and 3.  Because such
>     systems have existed in the past and might still exist, the code needs
>     to gracefully handle this situation.
>
>     This commit therefore checks to see whether the desired CPU is present
>     in cpu_possible_mask, and, if not, searches for the next CPU.  This means
>     that the systems administrator of a system with a sparse cpu_possible_mask
>     will need to account for this sparsity when specifying the value of
>     the rcupdate.rcu_task_enqueue_lim kernel boot parameter.  For example,
>     setting this parameter to the value 4 will use only CPUs 0 and 4, which
>     CPU 4 getting three times the callback load of CPU 0.
>
>     This commit assumes that bit (nr_cpu_ids - 1) is always set in
>     cpu_possible_mask.
>
>     Link: https://lore.kernel.org/lkml/CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com/
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 65d6e21a607a..44977c6a1cb8 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -273,7 +273,9 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
>  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>                                    struct rcu_tasks *rtp)
>  {
> +       int chosen_cpu;
>         unsigned long flags;
> +       int ideal_cpu;
>         unsigned long j;
>         bool needadjust = false;
>         bool needwake;
> @@ -283,8 +285,9 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
>         rhp->func = func;
>         local_irq_save(flags);
>         rcu_read_lock();
> -       rtpcp = per_cpu_ptr(rtp->rtpcpu,
> -                           smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift));
> +       ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
> +       chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_possible_mask);
> +       rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
>         if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
>                 raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
>                 j = jiffies;
