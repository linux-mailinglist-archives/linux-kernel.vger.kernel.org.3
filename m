Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CC059C5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiHVSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiHVSIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:08:51 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90D41D0DA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:08:49 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h78so8971191iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WgzWzZj00zOWLrpbCwQ4WTwiDIwDcKzbwKa8iAf7tLg=;
        b=OWC1nKVBtluEW62ASQUxzNEKPaHq+xaPILPsqberXSM3ZYA8aUQyGYB7lYfxVvO3Kx
         02oQPI4Hbh1a3fXkORCfP/LGkRxymrN2VbrNgvOeSz6RdEkVVWDFzSS/DH1ojr0uBAqu
         IGw2jTYyP8dKkaI73RXI091fqraCH6NvcfoR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WgzWzZj00zOWLrpbCwQ4WTwiDIwDcKzbwKa8iAf7tLg=;
        b=rIZbmXTV83zE3oAk2LDZuQiHeQov9+pzX+HFlIXp/xgqsBGMxJkgX3RzLO4u74E8/R
         8SGRFkQGMZCSvo5GxmTkHo40op6plEpFTQYf3vzlxearB0RVFVXyEJqOe54zuJHeZntQ
         otMqI5UHO3+F03f89R0ehfG8baJauBCFIqQMrcGXfpF0VxWElmeY/JeXiQiKuGWuz9l6
         MWwf0/oQgZ23SlrD3Gjp5n0mazm3lV3AFnXvj/ebci9LTk2bIPVzKdjRUOmQjCt938tN
         +LrqdkKNS2/0w8AxBy2t2rWD3y1NC45vsvPHzWhSazXZYw5l4mw7J4ygISncC4QKbXJu
         jo7g==
X-Gm-Message-State: ACgBeo3G7h20yAtX6mnx22mYYKHv8ukWytBVTD1fOjQx9mGl+op3Y+za
        t61pqJGaJGcRZR+KQdUjB1glVUEoBw7qJTiqo/od/A==
X-Google-Smtp-Source: AA6agR7cV0NmQ6+Pqp4g7/80o66iJ+BRcBW4jtTnfFVQmkwALzchwVQ5BWOGJnuehHgZpFba5YCOnN125O5Tw0wa6SA=
X-Received: by 2002:a5d:9914:0:b0:67c:2039:caff with SMTP id
 x20-20020a5d9914000000b0067c2039caffmr9103230iol.201.1661191729339; Mon, 22
 Aug 2022 11:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220822021520.6996-1-kernelfans@gmail.com> <20220822021520.6996-7-kernelfans@gmail.com>
In-Reply-To: <20220822021520.6996-7-kernelfans@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 22 Aug 2022 14:08:38 -0400
Message-ID: <CAEXW_YRH11xFg-0nQfvv59SMFCW=SNTEEL0oHJKTs1X45wGr7w@mail.gmail.com>
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
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

On Sun, Aug 21, 2022 at 10:16 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> In order to support parallel, rcu_state.n_online_cpus should be
> atomic_dec()

What does Parallel mean? Is that some kexec terminology?

Thanks,

 - Joel

>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Price <steven.price@arm.com>
> Cc: "Peter Zijlstra
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> To: linux-kernel@vger.kernel.org
> To: rcu@vger.kernel.org
> ---
>  kernel/cpu.c      | 1 +
>  kernel/rcu/tree.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 1261c3f3be51..90debbe28e85 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1872,6 +1872,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
>                 .name                   = "RCU/tree:prepare",
>                 .startup.single         = rcutree_prepare_cpu,
>                 .teardown.single        = rcutree_dead_cpu,
> +               .support_kexec_parallel = true,
>         },
>         /*
>          * On the tear-down path, timers_dead_cpu() must be invoked
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 79aea7df4345..07d31e16c65e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2168,7 +2168,8 @@ int rcutree_dead_cpu(unsigned int cpu)
>         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>                 return 0;
>
> -       WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> +       /* Hot remove path allows parallel, while Hot add races against remove on lock */
> +       atomic_dec((atomic_t *)&rcu_state.n_online_cpus);
>         /* Adjust any no-longer-needed kthreads. */
>         rcu_boost_kthread_setaffinity(rnp, -1);
>         // Stop-machine done, so allow nohz_full to disable tick.
> --
> 2.31.1
>
