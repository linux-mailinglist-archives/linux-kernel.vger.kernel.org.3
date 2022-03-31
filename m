Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2B04EE45F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242690AbiCaW4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242684AbiCaW4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:56:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F06516F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:54:14 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m67so1993949ybm.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4K1DYo6POxyHa7P+r+PclGm7rs5TWXKiHdrqnC5dzk=;
        b=l6l3R4RPJBfrQ5v9o/l3WbtqAvsavb7WlXlcj+rdQGaIyoPa45SjS3yqRb58aBIOL4
         N2CFmZvPSeUEVQeR0I39B+b8LXyBy7s9otM341m/V/LKv75BQU5+824n4leoIwepKTl3
         6//ffE486OzkiGY/gkrVzLypYftNuGZsdgi4LkBPxqW9spQeY34J57XbRcw2JvP9iyJq
         7/V+sXc2HD4k7+6fIXv8CUmT1u8uQEk0vKGKRKKwluevG16JV3LJ8Q5KP8DORZZbLpM0
         rk27Wyj6yL+1utx0TkD2jgMzcVaMy2tkqyVG+osrQgn+X2vmvYUQxO8h2BJlpoY+EFqI
         W9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4K1DYo6POxyHa7P+r+PclGm7rs5TWXKiHdrqnC5dzk=;
        b=oKsoxhFr5eKD2zX2XqmsORbSOw6KOFg5IIwISWCnf9DfNWejAPbQ0Q888qtVX8vb2B
         U1aexXFZMQuOkAU/rHct2zip3chU/qKDUhE9V7/gRn/sggnnm1sI50Xly9JQb7cxSjKI
         qzJvfubZ/AHrTsj8EqFyhALEXA1wN7d5Bz9neHRwGD6IDqThau3y3My47jfih5il2/x2
         W/6k6RvAG4M8KNn5egRPFvMJ497L5ow2R1+H5VH99y4LjPg7220bIjXTl96th2kakglZ
         MSc9SVbRKrKPMk+ytQoCgHVRqzP64zcgBxp8fT6fpj8NwosztzP3U3yIUBP50Ra75hRC
         D05w==
X-Gm-Message-State: AOAM533F5ypSan0G2tpwqQhuOMZVk6KwZkgiBTaXnRF56p6KbdQZzdpV
        b1H5/A47pALfcdUII9J7BINmER7E7heFy7wxF/N3JQeMlN5LSA==
X-Google-Smtp-Source: ABdhPJyTi1Dl8DEWCrTYMWNrm45yUrNjTNISCWkuE3ZvvgV+PX4z6oQdN5GJaJ0YEWVm/ZDFWqTWJKfneiAcG5Y4yHI=
X-Received: by 2002:a5b:7c6:0:b0:60b:a0ce:19b with SMTP id t6-20020a5b07c6000000b0060ba0ce019bmr6042995ybq.407.1648767253585;
 Thu, 31 Mar 2022 15:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com>
 <20220331224222.GY4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220331224222.GY4285@paulmck-ThinkPad-P17-Gen-1>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 31 Mar 2022 15:54:02 -0700
Message-ID: <CANn89iJjyp7s1fYB6VCqLhUnF+mmEXyw8GMpFC9Vi22usBsgAQ@mail.gmail.com>
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

On Thu, Mar 31, 2022 at 3:42 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Mar 31, 2022 at 02:45:25PM -0700, Eric Dumazet wrote:
> > Hi Paul
> >
> > It seems you assume per cpu ptr for arbitrary indexes (< nr_cpu_ids) are valid.
>
> Gah!  I knew I was forgetting something...
>
> But just to check, is this a theoretical problem or something you hit
> on real hardware?  (For the rest of this email, I am assuming the latter.)

Code review really...

>
> > What do you think of the (untested) following patch ?
>
> One issue with this patch is that the contention could be unpredictable,
> or worse, vary among CPU, especially if the cpu_possible_mask was oddly
> distributed.
>
> So might it be better to restrict this to all on CPU 0 on the one hand
> and completely per-CPU on the other?  (Or all on the boot CPU, in case
> I am forgetting some misbegotten architecture that can run without a
> CPU 0.)

If I understand correctly, cblist_init_generic() could setup
percpu_enqueue_shift
to something smaller than order_base_2(nr_cpu_ids)

Meaning that we could reach a non zero idx in (smp_processor_id() >>
percpu_enqueue_shift)

So even if CPU0 is always present (I am not sure this is guaranteed,
but this seems reasonable),
we could still attempt a per_cpu_ptr(PTR,  not_present_cpu), and get garbage.



> > Thanks.
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 99cf3a13954cfb17828fbbeeb884f11614a526a9..df3785be4022e903d9682dd403464aa9927aa5c2
> > 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -273,13 +273,17 @@ static void call_rcu_tasks_generic(struct
> > rcu_head *rhp, rcu_callback_t func,
> >         bool needadjust = false;
> >         bool needwake;
> >         struct rcu_tasks_percpu *rtpcp;
> > +       int ideal_cpu, chosen_cpu;
> >
> >         rhp->next = NULL;
> >         rhp->func = func;
> >         local_irq_save(flags);
> >         rcu_read_lock();
> > -       rtpcp = per_cpu_ptr(rtp->rtpcpu,
> > -                           smp_processor_id() >>
> > READ_ONCE(rtp->percpu_enqueue_shift));
> > +
> > +       ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
> > +       chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_online_mask);
> > +
> > +       rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
> >         if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
> >                 raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
> >                 j = jiffies;
