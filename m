Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF754B91D5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbiBPTzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:55:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiBPTzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:55:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A712A2B102A;
        Wed, 16 Feb 2022 11:55:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36733618EA;
        Wed, 16 Feb 2022 19:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97472C004E1;
        Wed, 16 Feb 2022 19:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645041308;
        bh=Fj3UWxjV9XWJYiEhuSSxup1YiZMb8KRq8pwYLIGWps0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qKTvPz7iNaM2s/9mScgqoOQKapzR6Vz1ZJEilHsKjvOLbVpGvB/CMBb3DNbFbSLA7
         64Qe4vFgYXt4OsU9sWOHQ4ZwfZxPBAJWKRwrKfdPcF9bh0hdTukjJdhzA2u1g7zNOx
         zlsT1Aj/+LCJ+mFLypxRQyfDSIDRnhnInwJonSKAJ0j+nMykmjZjETxfPwUPOksEVu
         CK2TS44ubCJNmuoMD4XKZwwF7yVRtkJU9Ze05r1cKpZuiZZ3Ul2buiaIKfLSpoCouC
         Xivyspp3jwsXjy4dce+GU5Tk+day1NMhalpsINbRVuA+fNbxsjaYIMwEcJAh2dQp9t
         RfIhdmEPQI0OA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 56C645C064D; Wed, 16 Feb 2022 11:55:08 -0800 (PST)
Date:   Wed, 16 Feb 2022 11:55:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>
Subject: Re: [PATCH 1/1] rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
Message-ID: <20220216195508.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220216135209.3070-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216135209.3070-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 02:52:09PM +0100, Uladzislau Rezki (Sony) wrote:
> From: Uladzislau Rezki <uladzislau.rezki@sony.com>
> 
> Currently for both expedited and regular grace periods stall
> warnings are emitted based on one timeout value that is defined
> in seconds. The problem is that, a stall timeout in seconds for
> expedited grace period is a way long.
> 
> The idea of expedited grace period is to force CPUs to report
> their quiescent states as fast as possible. If in RCU read-side
> critical section, it will request the next rcu_read_unlock() to
> record the quiescent state. If not either it reports immediately
> or set TIF_NEED_RESCHED to initiate the task switch.
> 
> Therefore introduce the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT kernel
> configuration that is set to 20 msec. It also can be changed in
> run-time via: /sys/.../parameters/rcu_exp_cpu_stall_timeout.
> 
> Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Nice, thank you!

I have queued this, with the usual wordsmithing.

I also changed the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT kconfig option's
default to be 20 milliseconds only no CONFIG_ANDROID=y kernel builds.  For
one, rcutorture gets expedited stall warnings even at 200 milliseconds,
and for another, larger systems often have longer-running readers.
It might be a very good thing to decrease the non-Android default
expedited stall warning timeout, but 20 milliseconds is not likely the
place to start that effort.  Though it would be one way to find out
when in the process large-system users started testing.  ;-)

My guess is that this change will result in some breakage even on Android,
and that adjustments will be needed.  Once that effort is complete,
it would probably make sense to take another look at the non-Android
default for CONFIG_RCU_EXP_CPU_STALL_TIMEOUT.

							Thanx, Paul

> ---
>  Documentation/RCU/stallwarn.rst               | 18 +++++++++++++
>  .../admin-guide/kernel-parameters.txt         |  6 +++++
>  kernel/rcu/Kconfig.debug                      | 12 +++++++++
>  kernel/rcu/rcu.h                              |  2 ++
>  kernel/rcu/tree_exp.h                         |  4 +--
>  kernel/rcu/tree_stall.h                       | 26 +++++++++++++++++++
>  kernel/rcu/update.c                           |  2 ++
>  7 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index 78404625bad2..b9ce89980779 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -162,6 +162,24 @@ CONFIG_RCU_CPU_STALL_TIMEOUT
>  	Stall-warning messages may be enabled and disabled completely via
>  	/sys/module/rcupdate/parameters/rcu_cpu_stall_suppress.
>  
> +CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
> +--------------------------------
> +
> +	Same as the CONFIG_RCU_CPU_STALL_TIMEOUT parameter but only for
> +	the expedited grace period. This parameter defines the period of
> +	time that RCU will wait from the beginning of an expedited grace
> +	period until it issues an RCU CPU stall warning. This time period
> +	is normally 20 milliseconds.
> +
> +	This configuration parameter may be changed at runtime via the
> +	/sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout, however
> +	this parameter is checked only at the beginning of a cycle. If you
> +	are in a current stall cycle, setting it to a new value will change
> +	the timeout for the -next- stall.
> +
> +	Stall-warning messages may be enabled and disabled completely via
> +	/sys/module/rcupdate/parameters/rcu_cpu_stall_suppress.
> +
>  RCU_STALL_DELAY_DELTA
>  ---------------------
>  
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9ab6a4a5be06..9a32030f5d1e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4817,6 +4817,12 @@
>  	rcupdate.rcu_cpu_stall_timeout= [KNL]
>  			Set timeout for RCU CPU stall warning messages.
>  
> +	rcupdate.rcu_exp_cpu_stall_timeout= [KNL]
> +			Set timeout for expedited RCU CPU stall warning messages.
> +			The value is in milliseconds and a maximum allowed parameter
> +			is 21000 milliseconds. Please note, a set value is adjusted
> +			to an arch timer tick resolution.
> +
>  	rcupdate.rcu_expedited= [KNL]
>  			Use expedited grace-period primitives, for
>  			example, synchronize_rcu_expedited() instead
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 4fd64999300f..e0f2c5edef44 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -91,6 +91,18 @@ config RCU_CPU_STALL_TIMEOUT
>  	  RCU grace period persists, additional CPU stall warnings are
>  	  printed at more widely spaced intervals.
>  
> +config RCU_EXP_CPU_STALL_TIMEOUT
> +	int "Expedited RCU CPU stall timeout in milliseconds"
> +	depends on RCU_STALL_COMMON
> +	range 1 21000
> +	default 20
> +
> +	help
> +	  If a given expedited RCU grace period extends more than the
> +	  specified number of milliseconds, a CPU stall warning is printed.
> +	  If the RCU grace period persists, additional CPU stall warnings
> +	  are printed at more widely spaced intervals.
> +
>  config RCU_TRACE
>  	bool "Enable tracing for RCU"
>  	depends on DEBUG_KERNEL
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 819f9d979e61..f8ec1df4b91e 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -217,7 +217,9 @@ static inline bool rcu_stall_is_suppressed_at_boot(void)
>  extern int rcu_cpu_stall_ftrace_dump;
>  extern int rcu_cpu_stall_suppress;
>  extern int rcu_cpu_stall_timeout;
> +extern int rcu_exp_cpu_stall_timeout;
>  int rcu_jiffies_till_stall_check(void);
> +int rcu_exp_jiffies_till_stall_check(void);
>  
>  static inline bool rcu_stall_is_suppressed(void)
>  {
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 404198808683..30f05fd080ca 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -496,7 +496,7 @@ static void synchronize_rcu_expedited_wait(void)
>  	struct rcu_node *rnp_root = rcu_get_root();
>  
>  	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
> -	jiffies_stall = rcu_jiffies_till_stall_check();
> +	jiffies_stall = rcu_exp_jiffies_till_stall_check();
>  	jiffies_start = jiffies;
>  	if (tick_nohz_full_enabled() && rcu_inkernel_boot_has_ended()) {
>  		if (synchronize_rcu_expedited_wait_once(1))
> @@ -571,7 +571,7 @@ static void synchronize_rcu_expedited_wait(void)
>  				dump_cpu_task(cpu);
>  			}
>  		}
> -		jiffies_stall = 3 * rcu_jiffies_till_stall_check() + 3;
> +		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
>  	}
>  }
>  
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 0c5d8516516a..84b812a3ab44 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -25,6 +25,32 @@ int sysctl_max_rcu_stall_to_panic __read_mostly;
>  #define RCU_STALL_MIGHT_DIV		8
>  #define RCU_STALL_MIGHT_MIN		(2 * HZ)
>  
> +int rcu_exp_jiffies_till_stall_check(void)
> +{
> +	int cpu_stall_timeout = READ_ONCE(rcu_exp_cpu_stall_timeout);
> +	int exp_stall_delay_delta = 0;
> +	int till_stall_check;
> +
> +	/*
> +	 * Limit check must be consistent with the Kconfig limits for
> +	 * CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, so check the allowed range.
> +	 * The minimum clamped value is "2UL", because at least one full
> +	 * tick has to be guaranteed.
> +	 */
> +	till_stall_check = clamp(msecs_to_jiffies(cpu_stall_timeout), 2UL, 21UL * HZ);
> +
> +	if (jiffies_to_msecs(till_stall_check) != cpu_stall_timeout)
> +		WRITE_ONCE(rcu_exp_cpu_stall_timeout, jiffies_to_msecs(till_stall_check));
> +
> +#ifdef CONFIG_PROVE_RCU
> +	/* Add extra ~25% out of till_stall_check. */
> +	exp_stall_delay_delta = ((till_stall_check * 25) / 100) + 1;
> +#endif
> +
> +	return till_stall_check + exp_stall_delay_delta;
> +}
> +EXPORT_SYMBOL_GPL(rcu_exp_jiffies_till_stall_check);
> +
>  /* Limit-check stall timeouts specified at boottime and runtime. */
>  int rcu_jiffies_till_stall_check(void)
>  {
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 180ff9c41fa8..fc7fef575606 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -506,6 +506,8 @@ EXPORT_SYMBOL_GPL(rcu_cpu_stall_suppress);
>  module_param(rcu_cpu_stall_suppress, int, 0644);
>  int rcu_cpu_stall_timeout __read_mostly = CONFIG_RCU_CPU_STALL_TIMEOUT;
>  module_param(rcu_cpu_stall_timeout, int, 0644);
> +int rcu_exp_cpu_stall_timeout __read_mostly = CONFIG_RCU_EXP_CPU_STALL_TIMEOUT;
> +module_param(rcu_exp_cpu_stall_timeout, int, 0644);
>  #endif /* #ifdef CONFIG_RCU_STALL_COMMON */
>  
>  // Suppress boot-time RCU CPU stall warnings and rcutorture writer stall
> -- 
> 2.30.2
> 
