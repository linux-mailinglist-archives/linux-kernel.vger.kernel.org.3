Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7484EE450
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbiCaWoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242648AbiCaWoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:44:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A948A23EC55
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A672B82250
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30878C340EE;
        Thu, 31 Mar 2022 22:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648766543;
        bh=8hmaQ8bK0qDSdukzI7NQ+DyrV1swRkMPVgfng2e6haI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bU43DUZW9qxj0O2Iru6CzIBjtgq5G1zbBtuVMDvmsOriaLvdwk1KIOZ1QFh9n6Y5e
         B+g8m3YHqi78woX177JQQ65MHdg4um1j9PgfZd+gyGxGYKOiQjn+SMKotNtJOQVvS4
         huThatyJHMcluD2L+bsyJTiIkEmPugtw1SN1WAXh0NBbC1yZRv8AoRYWkRGk/ujaR8
         /KnFH1Jdgh5KQR0VCXnS6SJck5l9PXjvKaw56xHjO1j+yG9UdTMIt6MLr5JPGQJLCy
         fe3UEgk6nF7WbDo7DSKgrOEDi9/9JFy5cJtN6j9sKMmVIDPgyc9qD+cmNOP+6JCPEy
         uUmfZ3BSS6frg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C311B5C0A0E; Thu, 31 Mar 2022 15:42:22 -0700 (PDT)
Date:   Thu, 31 Mar 2022 15:42:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] rcu-tasks : should take care of sparse cpu masks
Message-ID: <20220331224222.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKaNEwyNZ=L_PQnkH0LP_XjLYrr_dpyRKNNoDJaWKdrmg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 02:45:25PM -0700, Eric Dumazet wrote:
> Hi Paul
> 
> It seems you assume per cpu ptr for arbitrary indexes (< nr_cpu_ids) are valid.

Gah!  I knew I was forgetting something...

But just to check, is this a theoretical problem or something you hit
on real hardware?  (For the rest of this email, I am assuming the latter.)

> What do you think of the (untested) following patch ?

One issue with this patch is that the contention could be unpredictable,
or worse, vary among CPU, especially if the cpu_possible_mask was oddly
distributed.

So might it be better to restrict this to all on CPU 0 on the one hand
and completely per-CPU on the other?  (Or all on the boot CPU, in case
I am forgetting some misbegotten architecture that can run without a
CPU 0.)

							Thanx, Paul

> Thanks.
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 99cf3a13954cfb17828fbbeeb884f11614a526a9..df3785be4022e903d9682dd403464aa9927aa5c2
> 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -273,13 +273,17 @@ static void call_rcu_tasks_generic(struct
> rcu_head *rhp, rcu_callback_t func,
>         bool needadjust = false;
>         bool needwake;
>         struct rcu_tasks_percpu *rtpcp;
> +       int ideal_cpu, chosen_cpu;
> 
>         rhp->next = NULL;
>         rhp->func = func;
>         local_irq_save(flags);
>         rcu_read_lock();
> -       rtpcp = per_cpu_ptr(rtp->rtpcpu,
> -                           smp_processor_id() >>
> READ_ONCE(rtp->percpu_enqueue_shift));
> +
> +       ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
> +       chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_online_mask);
> +
> +       rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
>         if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
>                 raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
>                 j = jiffies;
