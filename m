Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1675089CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379205AbiDTNyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiDTNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:54:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF5E1FA49;
        Wed, 20 Apr 2022 06:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD5B8B81ED6;
        Wed, 20 Apr 2022 13:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6901FC385A0;
        Wed, 20 Apr 2022 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650462670;
        bh=kp0Myyrbg/hgc2Wwm1GIWEG+XTpQhAnDrkbTaoAWrPE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R2D1tHtrK9bz3k17VvLIEcv4PB7Pve9HS9YFXCqB7g1TpeVcYg/MSsYGRAd2ypPKa
         7soh7HxWahirb2rwOEfWJQ7H6GTHIKz9ysntedXWKdzPolfYK5TXWbTqlIqCELKsUr
         3CmadNhqJeODL+U2Ua737VGIWuoRtK5Wj7y7QuDSKDOl4ZQgBoFdBgv3WaMOV+b/RL
         tzPhfDetyVY9l5+PQIwJTURK7y95Z/Qtsz3rX2C/8OLHGWInr6kuvXeTakQC36uopR
         EgQ4yESwYEpNO2ISn3AaV8N6PiBStbyJFJh6r+qhzYGIk+Fk6SEa3jtE1D1pNCZnYX
         kftCcD+U0Vb+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 06A9F5C0269; Wed, 20 Apr 2022 06:51:10 -0700 (PDT)
Date:   Wed, 20 Apr 2022 06:51:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Vineeth Pillai <vineethrp@gmail.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v4 rcu/dev] rcu/nocb: Add an option to offload all CPUs
 on boot
Message-ID: <20220420135109.GA3017070@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220419200823.2790490-1-joel@joelfernandes.org>
 <CAEXW_YS7cdrfP58Qvbt_WS2QRNkV=wVrwY6iTWmEH5qBxyStxQ@mail.gmail.com>
 <20220419235626.GW4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419235626.GW4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 04:56:26PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 19, 2022 at 04:10:33PM -0400, Joel Fernandes wrote:
> > On Tue, Apr 19, 2022 at 4:08 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > From: Joel Fernandes <joel@joelfernandes.org>
> > >
> > > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > > which ends up not offloading any CPU. This patch removes a dependency
> > > from the bootloader having to know about RCU and about how to provide
> > > the mask.
> > >
> > > With the new option enabled, all CPUs will be offloaded on boot unless
> > > rcu_nocbs= or rcu_nohz_full= kernel parameters provide a CPU list.
> > >
> > > Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> > 
> > Oops, forgot to add Reviewed-by tags:
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
> > 
> > Paul, would you mind doing so, so I don't have to resend? Apologies.
> 
> OK, but only because it passed an allmodconfig build this time.  ;-)

But the rcutorture TASKS03 scenario failed to build.  Kernel test robot
saw similar issues here:

https://lore.kernel.org/all/202204201732.oTzYh0Xo-lkp@intel.com/

Next version!  ;-)

							Thanx, Paul

> > Thanks,
> > 
> > Joel
> > 
> > 
> > > ---
> > > v4: Rebased on rcu/dev, fixed conflict with Frederick's patch changing
> > >     location of nocb_is_setup variable.
> > >
> > >  Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
> > >  kernel/rcu/Kconfig                              | 13 +++++++++++++
> > >  kernel/rcu/tree_nocb.h                          | 13 +++++++++++++
> > >  3 files changed, 32 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 789ef586009b..1e82ecb7a649 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3572,6 +3572,9 @@
> > >                         just as if they had also been called out in the
> > >                         rcu_nocbs= boot parameter.
> > >
> > > +                       Note that this argument takes precedence over
> > > +                       the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> > > +
> > >         noiotrap        [SH] Disables trapped I/O port accesses.
> > >
> > >         noirqdebug      [X86-32] Disables the code which attempts to detect and
> > > @@ -4475,6 +4478,9 @@
> > >                         no-callback mode from boot but the mode may be
> > >                         toggled at runtime via cpusets.
> > >
> > > +                       Note that this argument takes precedence over
> > > +                       the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
> > > +
> > >         rcu_nocb_poll   [KNL]
> > >                         Rather than requiring that offloaded CPUs
> > >                         (specified by rcu_nocbs= above) explicitly
> > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > index 1c630e573548..27aab870ae4c 100644
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -262,6 +262,19 @@ config RCU_NOCB_CPU
> > >           Say Y here if you need reduced OS jitter, despite added overhead.
> > >           Say N here if you are unsure.
> > >
> > > +config RCU_NOCB_CPU_DEFAULT_ALL
> > > +       bool "Offload RCU callback processing from all CPUs by default"
> > > +       depends on RCU_NOCB_CPU
> > > +       default n
> > > +       help
> > > +         Use this option to offload callback processing from all CPUs
> > > +         by default, in the absence of the rcu_nocbs or nohz_full boot
> > > +         parameter. This also avoids the need to use any boot parameters
> > > +         to achieve the effect of offloading all CPUs on boot.
> > > +
> > > +         Say Y here if you want offload all CPUs by default on boot.
> > > +         Say N here if you are unsure.
> > > +
> > >  config TASKS_TRACE_RCU_READ_MB
> > >         bool "Tasks Trace RCU readers use memory barriers in user and idle"
> > >         depends on RCU_EXPERT && TASKS_TRACE_RCU
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 4cf9a29bba79..9f29f25a0cbc 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -1197,11 +1197,21 @@ void __init rcu_init_nohz(void)
> > >  {
> > >         int cpu;
> > >         bool need_rcu_nocb_mask = false;
> > > +       bool offload_all = false;
> > >         struct rcu_data *rdp;
> > >
> > > +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> > > +       if (!rcu_state.nocb_is_setup) {
> > > +               need_rcu_nocb_mask = true;
> > > +               offload_all = true;
> > > +       }
> > > +#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
> > > +
> > >  #if defined(CONFIG_NO_HZ_FULL)
> > >         if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> > >                 need_rcu_nocb_mask = true;
> > > +               offload_all = false; /* NO_HZ_FULL has its own mask. */
> > > +       }
> > >  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
> > >
> > >         if (need_rcu_nocb_mask) {
> > > @@ -1222,6 +1232,9 @@ void __init rcu_init_nohz(void)
> > >                 cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
> > >  #endif /* #if defined(CONFIG_NO_HZ_FULL) */
> > >
> > > +       if (offload_all)
> > > +               cpumask_setall(rcu_nocb_mask);
> > > +
> > >         if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
> > >                 pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
> > >                 cpumask_and(rcu_nocb_mask, cpu_possible_mask,
> > > --
> > > 2.36.0.rc0.470.gd361397f0d-goog
> > >
