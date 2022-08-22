Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF059C438
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiHVQeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 12:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbiHVQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 12:34:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6EA3E75E;
        Mon, 22 Aug 2022 09:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD548B815FA;
        Mon, 22 Aug 2022 16:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB1CC433C1;
        Mon, 22 Aug 2022 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661186051;
        bh=Sdn5r6QikL4jluue7U4GUaFlfJWYvo0Gnhk3nReb2OM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I2D7PuFgDfrAAmTjAd4D2MzrsgdpKfvbxbORYCNdTCVs1Rnkp3a/VLO7yQhDIBDrf
         nddPlo6TNTBBQrSEpNiYa/cVAUxqpbs8YHBdlgDGuxXYWYzN2tTK4rOCH//bSHP5s7
         RVfaBH6Y7c2qHZMi8NKgSzGKyqJs8BLzJBKlpo//Ek29sLxq2ObbAWXwDlJBYV4VpN
         T2ah6tLj3QL2x06qRPiroPLBj48N9hX8g/1vBlQe00clctK9Kn/9ZWtURIPEexYy12
         3PEpUuCwd6p406RH/d1OQlrwHyAaL15qNc4X1sU4M2pS/REEleaSrREHA/8jDiFiBW
         Z+6SNd5NGV7LQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0875D5C03F3; Mon, 22 Aug 2022 09:34:11 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:34:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] rcu: Eliminate rcu_state.nocb_is_setup
Message-ID: <20220822163411.GF6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220817014253.1982-1-thunder.leizhen@huawei.com>
 <20220817014253.1982-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817014253.1982-2-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 09:42:52AM +0800, Zhen Lei wrote:
> 'rcu_state.nocb_is_setup' is initialized to true only if 'rcu_nocb_mask'
> successfully allocates memory. So it can be replaced by
> 'cpumask_available(rcu_nocb_mask)'. More importantly, the latter is more
> intuitive, and it has been used in several places.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

One of the implementations of cpumask_available() does indeed check
for NULL.  But here is the other one:

static inline bool cpumask_available(cpumask_var_t mask)
{
	return true;
}

So I have to ask...  In a kernel built with CONFIG_CPUMASK_OFFSTACK=n,
will this change really work?

Another important question is "Do all of the existing uses of
cpumask_available() really work?"  Yes, I do believe that they do
work, but it would be good to get another set of eyes on that code.
"All software developers are blind!"  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/tree.h      | 1 -
>  kernel/rcu/tree_nocb.h | 8 +++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index d4a97e40ea9c3e2..06f659c63d2d192 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -375,7 +375,6 @@ struct rcu_state {
>  	arch_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
>  						/* Synchronize offline with */
>  						/*  GP pre-initialization. */
> -	int nocb_is_setup;			/* nocb is setup from boot */
>  };
>  
>  /* Values for rcu_state structure's gp_flags field. */
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 0a5f0ef41484518..ff763e7dc53551f 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -69,7 +69,6 @@ static int __init rcu_nocb_setup(char *str)
>  			cpumask_setall(rcu_nocb_mask);
>  		}
>  	}
> -	rcu_state.nocb_is_setup = true;
>  	return 1;
>  }
>  __setup("rcu_nocbs", rcu_nocb_setup);
> @@ -1215,7 +1214,7 @@ void __init rcu_init_nohz(void)
>  	struct rcu_data *rdp;
>  
>  #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
> -	if (!rcu_state.nocb_is_setup) {
> +	if (!cpumask_available(rcu_nocb_mask)) {
>  		need_rcu_nocb_mask = true;
>  		offload_all = true;
>  	}
> @@ -1235,10 +1234,9 @@ void __init rcu_init_nohz(void)
>  				return;
>  			}
>  		}
> -		rcu_state.nocb_is_setup = true;
>  	}
>  
> -	if (!rcu_state.nocb_is_setup)
> +	if (!cpumask_available(rcu_nocb_mask))
>  		return;
>  
>  #if defined(CONFIG_NO_HZ_FULL)
> @@ -1299,7 +1297,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  	struct task_struct *t;
>  	struct sched_param sp;
>  
> -	if (!rcu_scheduler_fully_active || !rcu_state.nocb_is_setup)
> +	if (!rcu_scheduler_fully_active || !cpumask_available(rcu_nocb_mask))
>  		return;
>  
>  	/* If there already is an rcuo kthread, then nothing to do. */
> -- 
> 2.25.1
> 
