Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC83A4B95B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 02:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiBQBxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 20:53:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiBQBxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:53:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A14238136
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:53:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B310B81FC7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390B1C004E1;
        Thu, 17 Feb 2022 01:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645062813;
        bh=6ryRSu9N46aamU6UzU0Cp29uUh1I1sCa6GGGSV0dCzw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gXUKWs3PQcWwIwvNtLI0m26yhefPfskFvYG6CKSN36b38nB9+Hoj32KJwVnH6IpgK
         aJ/5YIymEMMcdLHGWRdUu/EcqmMqyhMxlMozSoTQDmkz/VoJCd6kCie7+TPN59cQAw
         Y4ek1FISsQ0Ff8K7r2fTMJrxsjRvl+A4K5a1UsClt0Dwomw/F+4tel74zIa2A0M9ZV
         XmQHbJXfaxnsPh2SSiojkm/bzc8B10RivX5vbdnH8/CC20CkYUAO0dkEhH4e86h8pc
         AU0si2ir8hXPhC+Ew9wAPMOUcm6rTBhdEA2OqNHQFpgP5ob5YW5aFg+98AdJJzBpM4
         mgKJ3vAtiJ8dw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E3C285C0248; Wed, 16 Feb 2022 17:53:32 -0800 (PST)
Date:   Wed, 16 Feb 2022 17:53:32 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 2/5] rcu/nocb: Move rcu_nocb_is_setup to rcu_state
Message-ID: <20220217015332.GA2455440@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220216154208.696069-1-frederic@kernel.org>
 <20220216154208.696069-3-frederic@kernel.org>
 <20220216213035.GA2442742@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216213035.GA2442742@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:30:35PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 16, 2022 at 04:42:05PM +0100, Frederic Weisbecker wrote:
> > In order to avoid scattering the global RCU states, move the RCU nocb
> > initialization witness within rcu_state.
> > 
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Build testing for CONFIG_NO_HZ_FULL=n kernels suggested the following
> patch be merged into this one.  Or does this variable need to be used
> somewhere?  Either way, please let me know!

TASKS03, TREE04, and TREE07 don't like this much, according to git
bisect.  They are the ones with nohz_full CPUs, in case that is crucial.
Trying again after reverting this commit locally.

If that works, I would be tempted to try the modification shown below.

Thoughts?

							Thanx, Paul

> ------------------------------------------------------------------------
> 
> commit 1a4f308b3b3841ef10043fe6c3dd12fc872b0400
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Feb 16 13:27:42 2022 -0800
> 
>     squash! rcu/nocb: Move rcu_nocb_is_setup to rcu_state
>     
>     [ paulmck: Remove unused need_rcu_nocb_mask local variable. ]
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 9d6d4786bc703..9d97aa1f4d6ce 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1154,14 +1154,8 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> -	bool need_rcu_nocb_mask = false;
>  	struct rcu_data *rdp;
>  
> -#if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> -		need_rcu_nocb_mask = true;

		rcu_state.nocb_is_setup = true;

> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> -
>  	if (rcu_state.nocb_is_setup) {
>  		if (!cpumask_available(rcu_nocb_mask)) {
>  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
