Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0344D1CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348274AbiCHQQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiCHQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:16:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B0450B3A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:15:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C559B61732
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB32CC340EB;
        Tue,  8 Mar 2022 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646756121;
        bh=+htKKJNLw9NtpDuPtuUuoT1gIimxC0altMLNxb3wEic=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ozm/KzIwn9NRfML4FyZVIvVJbj6f6Z3AMGLrYmg0zKi2race3QVIASUdVg3OTPoCk
         UqckTffEniisMRrBd16YTPoZMTRRi6LWwsiyKn1KQT5xdGviZlfyxx7KUCj3U9NWZE
         x9wHn66mfeyi3fAQDsQ/23rt1DTj1zNaU7umCYDJ5EywXirpsaWtMww/Smrnozds/v
         z/Z8sVfip8lsuMLDPNxpkrkmQeZUK1QnWeGg7pTT0TbExiSO5PDtLfjzYFxli2EzXx
         d6MLm49J4JcmYf5FaPmYF4WkfA2oeS9G1B7M9zsDzrwHxPNhZYw3FK4ZtkXLpAvU9X
         0kY8IiH8AvwKg==
Message-ID: <e193b98f2e6a6de2178aa0e68325e54a62c804ec.camel@kernel.org>
Subject: Re: [PATCH 19/19] context_tracking: Exempt
 CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK from non-active tracking
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Date:   Tue, 08 Mar 2022 17:15:14 +0100
In-Reply-To: <20220302154810.42308-20-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
         <20220302154810.42308-20-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On Wed, 2022-03-02 at 16:48 +0100, Frederic Weisbecker wrote:
> Since a CPU may save the state of the context tracking using
> exception_enter() before calling into schedule(), we need all CPUs in
> the system to track user <-> kernel transitions and not just those that
> really need it (nohz_full CPUs).
> 
> The following illustrates the issue that could otherwise happen:
> 
>      CPU 0 (not tracking)                       CPU 1 (tracking)
>      -------------------                       --------------------
>      // we are past user_enter()
>      // but this CPU is always in
>      // CONTEXT_KERNEL
>      // because it doesn't track user <-> kernel
> 
>      ctx = exception_enter(); //ctx == CONTEXT_KERNEL
>      schedule();
>      ===========================================>
>                                                return from schedule();
>                                                exception_exit(ctx);
>                                                //go to user in CONTEXT_KERNEL
> 
> However CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK doesn't play those
> games because schedule() can't be called between user_enter() and
> user_exit() under such config. In this situation we can spare context
> tracking on the CPUs that don't need it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Cc: Yu Liao<liaoyu15@huawei.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
> Cc: Alex Belits <abelits@marvell.com>
> ---
>  kernel/context_tracking.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 87e7b748791c..b1934264f77f 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -374,7 +374,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
>  			 * when the CPU runs in userspace.
>  			 */
>  			ct_kernel_exit(true, RCU_DYNTICKS_IDX + state);
> -		} else {
> +		} else if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK)) {

user entry code assumes that state will be kept on all CPUs as long as context
tracking is enabled. See kernel/entry/common.c:

   static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
   {
           arch_check_user_regs(regs);
           lockdep_hardirqs_off(CALLER_ADDR0);
           
           CT_WARN_ON(ct_state() != CONTEXT_USER); <-- NOT HAPPY ABOUT THIS CHANGE
           user_exit_irqoff();
           
           instrumentation_begin();
           trace_hardirqs_off_finish();
           instrumentation_end();
   }

Regards,
Nicolas
