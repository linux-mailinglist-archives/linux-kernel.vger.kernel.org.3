Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5F5AC68D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiIDVBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDVBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:01:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5261B2870C;
        Sun,  4 Sep 2022 14:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE88561018;
        Sun,  4 Sep 2022 21:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA58DC433D6;
        Sun,  4 Sep 2022 21:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662325296;
        bh=eMJUB1gy+kxLJqRVw1Z/bd/e2b4QxmsudxdCqmT87wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MG3gYYfZAXBsoxy72zSrFZEDlCJ/iKqdbn1FOuYNJQOnd+yT/5wmCcfLNN0IlTmp1
         qK7LNbnuGbRO6CbCrddF5DMAa75abGY2H+39oSFoQGMMXVmVHqeUzCst0XQW3QwbcI
         nIpnVgVXeHUUGdJUZf8PgU7ZbsAfhgJbKWaP7WcZiN84hqCygVdUOW//UZQNX+e6PQ
         WvEzk/JeZy60hbZqF1jAj6Q+pZ34eqv7YN2AINuk3wt2I6+m8YsjjctLk8yRABGtGY
         FaBIWXQGa4BHayy5JzG9qBGyZZQFweTC2D68x+o82GrjD1Ycao9VgnqTmoXgmBq1vn
         XLHT/M/Oame6Q==
Date:   Sun, 4 Sep 2022 23:01:33 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220904210133.GA149888@lothringen>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <YxPOfVMzRWEa7xqf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxPOfVMzRWEa7xqf@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 10:00:29PM +0000, Joel Fernandes wrote:
> On Fri, Sep 02, 2022 at 05:21:32PM +0200, Frederic Weisbecker wrote:
> +
> +	raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);

This is locking during the whole group iteration potentially contending call_rcu(),
idle loop, resume to userspace on all rdp in the group...

How about not overwriting timers instead and only set the RCU_NOCB_WAKE_LAZY
timer when it is previously in RCU_NOCB_WAKE_NOT state? After all if the timer is armed,
it's because we have regular callbacks queued and thus we don't need to wait
before processing the lazy callbacks since we are going to start a grace period
anyway.

Thanks.


>  	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
>  		bool needwake_state = false;
>  		bool flush_bypass = false;
> @@ -855,14 +870,15 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  		// If bypass list only has lazy CBs. Add a deferred
>  		// lazy wake up.
>  		if (lazy && !bypass) {
> -			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
> +			wake_nocb_gp_defer_locked(my_rdp, RCU_NOCB_WAKE_LAZY,
>  					TPS("WakeLazyIsDeferred"));
>  		// Otherwise add a deferred bypass wake up.
>  		} else if (bypass) {
> -			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
> +			wake_nocb_gp_defer_locked(my_rdp, RCU_NOCB_WAKE_BYPASS,
>  					TPS("WakeBypassIsDeferred"));
>  		}
>  	}
> +	raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
>  
>  	if (rcu_nocb_poll) {
>  		/* Polling, so trace if first poll in the series. */
> -- 
> 2.37.2.789.g6183377224-goog
> 
