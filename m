Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C134D6467
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348604AbiCKPSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiCKPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:18:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CBC1C57D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:17:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 349D361345
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49187C340E9;
        Fri, 11 Mar 2022 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647011819;
        bh=yuTtYxDajTF7ZwmS4lcWNRF0tIn2IUBk3CqlQiAaSgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PXGrmZRq+1Li57wui8ScyM01As/weEjowyfgP+Bbztgxa3gm2+zY08CDVQJiZqWBe
         tC9a9Do8Lp1qaMKAXLw6ADvu+lsjPW04Pfg40pUuZBqgy10peoAuEC57uAM0k3Ni42
         nivbYmwKvEO40//HT1SnY7/s8h7B0U3zTPBQ5j1Eceq6usmYd6YYUXfF+PAIm494tR
         0rR+picLeN9fBN06Tv3m//EhAChbam5P3l4jdcLSUs/L5hNpKmWRc+GA1d6XyJod+C
         seYekE8QHwzGvlCr83Fh+Vj/rvpHAUuMcb58eUimAK3PAAeACZNq0GwkGbBnr6CC7y
         2tnxYdXcW2WOg==
Date:   Fri, 11 Mar 2022 16:16:56 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     nicolas saenz julienne <nsaenz@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 19/19] context_tracking: Exempt
 CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK from non-active tracking
Message-ID: <20220311151656.GA227315@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-20-frederic@kernel.org>
 <e193b98f2e6a6de2178aa0e68325e54a62c804ec.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e193b98f2e6a6de2178aa0e68325e54a62c804ec.camel@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 05:15:14PM +0100, nicolas saenz julienne wrote:
> Hi Frederic,
> 
> On Wed, 2022-03-02 at 16:48 +0100, Frederic Weisbecker wrote:
> > Since a CPU may save the state of the context tracking using
> > exception_enter() before calling into schedule(), we need all CPUs in
> > the system to track user <-> kernel transitions and not just those that
> > really need it (nohz_full CPUs).
> > 
> > The following illustrates the issue that could otherwise happen:
> > 
> >      CPU 0 (not tracking)                       CPU 1 (tracking)
> >      -------------------                       --------------------
> >      // we are past user_enter()
> >      // but this CPU is always in
> >      // CONTEXT_KERNEL
> >      // because it doesn't track user <-> kernel
> > 
> >      ctx = exception_enter(); //ctx == CONTEXT_KERNEL
> >      schedule();
> >      ===========================================>
> >                                                return from schedule();
> >                                                exception_exit(ctx);
> >                                                //go to user in CONTEXT_KERNEL
> > 
> > However CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK doesn't play those
> > games because schedule() can't be called between user_enter() and
> > user_exit() under such config. In this situation we can spare context
> > tracking on the CPUs that don't need it.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > Cc: Marcelo Tosatti <mtosatti@redhat.com>
> > Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > Cc: Yu Liao<liaoyu15@huawei.com>
> > Cc: Phil Auld <pauld@redhat.com>
> > Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
> > Cc: Alex Belits <abelits@marvell.com>
> > ---
> >  kernel/context_tracking.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> > index 87e7b748791c..b1934264f77f 100644
> > --- a/kernel/context_tracking.c
> > +++ b/kernel/context_tracking.c
> > @@ -374,7 +374,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
> >  			 * when the CPU runs in userspace.
> >  			 */
> >  			ct_kernel_exit(true, RCU_DYNTICKS_IDX + state);
> > -		} else {
> > +		} else if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK)) {
> 
> user entry code assumes that state will be kept on all CPUs as long as context
> tracking is enabled. See kernel/entry/common.c:
> 
>    static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
>    {
>            arch_check_user_regs(regs);
>            lockdep_hardirqs_off(CALLER_ADDR0);
>            
>            CT_WARN_ON(ct_state() != CONTEXT_USER); <-- NOT HAPPY ABOUT THIS
>            CHANGE

Good point!

So I need to do:

#ifdef CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK
#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled_this_cpu() && (cond))
#else
#define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
#endif

Thanks.

>            user_exit_irqoff();
>            
>            instrumentation_begin();
>            trace_hardirqs_off_finish();
>            instrumentation_end();
>    }
> 
> Regards,
> Nicolas
