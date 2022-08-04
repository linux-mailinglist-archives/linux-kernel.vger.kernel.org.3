Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69228589517
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiHDADE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbiHDAC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:02:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFD6371AB;
        Wed,  3 Aug 2022 17:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE307B82349;
        Thu,  4 Aug 2022 00:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BDEC433D6;
        Thu,  4 Aug 2022 00:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659571373;
        bh=5xEubBzmlywwmH2TeKBm671cRbQHoHZuih9T2soCokY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QfQgZYIFeTa5OpF+XxfIwcYCL8gtlVo2TwCLc6mG0Rhaj/69s6mNmoT/IjcR2m2+9
         pWupkOPd7XWD5De0QHqwP6/VN9KECgwVnNDHwi35t0DWip9XYZ/jvJvAlJ5ElcVXNi
         9Yzr0dqBWknNLL4FYQ6IC2wFtUqm+t4GhkyLVWYaaD+HdIYpmW2liDFHltwHwLjlEj
         D+CpB/w0REJIfeLWHB6Ke9zdNC+pP3gWLWpN4oBS1d4Js9i5VC6q7JVw0ISkBQSwN5
         zUJZ/VWPvOPYJM50NMC5ssfRyNj34ENwJwbkpxhVQv7q7/dcbSjDqkRv/1dA/boAD4
         8fFj2xIXgtCdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F12185C092A; Wed,  3 Aug 2022 17:02:52 -0700 (PDT)
Date:   Wed, 3 Aug 2022 17:02:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     frederic@kernel.org, neeraju@quicinc.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu-tasks: Avoid pr_info() with spin lock in
 cblist_init_generic()
Message-ID: <20220804000252.GL2125313@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220802162205.817796-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802162205.817796-1-syoshida@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 01:22:05AM +0900, Shigeru Yoshida wrote:
> pr_info() is called with rtp->cbs_gbl_lock spin lock locked.  Because
> pr_info() calls printk() that might sleep, this will result in BUG
> like below:
> 
> [    0.206455] cblist_init_generic: Setting adjustable number of callback queues.
> [    0.206463]
> [    0.206464] =============================
> [    0.206464] [ BUG: Invalid wait context ]
> [    0.206465] 5.19.0-00428-g9de1f9c8ca51 #5 Not tainted
> [    0.206466] -----------------------------
> [    0.206466] swapper/0/1 is trying to lock:
> [    0.206467] ffffffffa0167a58 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x327/0x4a0
> [    0.206473] other info that might help us debug this:
> [    0.206473] context-{5:5}
> [    0.206474] 3 locks held by swapper/0/1:
> [    0.206474]  #0: ffffffff9eb597e0 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic.constprop.0+0x14/0x1f0
> [    0.206478]  #1: ffffffff9eb579c0 (console_lock){+.+.}-{0:0}, at: _printk+0x63/0x7e
> [    0.206482]  #2: ffffffff9ea77780 (console_owner){....}-{0:0}, at: console_emit_next_record.constprop.0+0x111/0x330
> [    0.206485] stack backtrace:
> [    0.206486] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-00428-g9de1f9c8ca51 #5
> [    0.206488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
> [    0.206489] Call Trace:
> [    0.206490]  <TASK>
> [    0.206491]  dump_stack_lvl+0x6a/0x9f
> [    0.206493]  __lock_acquire.cold+0x2d7/0x2fe
> [    0.206496]  ? stack_trace_save+0x46/0x70
> [    0.206497]  lock_acquire+0xd1/0x2f0
> [    0.206499]  ? serial8250_console_write+0x327/0x4a0
> [    0.206500]  ? __lock_acquire+0x5c7/0x2720
> [    0.206502]  _raw_spin_lock_irqsave+0x3d/0x90
> [    0.206504]  ? serial8250_console_write+0x327/0x4a0
> [    0.206506]  serial8250_console_write+0x327/0x4a0
> [    0.206508]  console_emit_next_record.constprop.0+0x180/0x330
> [    0.206511]  console_unlock+0xf7/0x1f0
> [    0.206512]  vprintk_emit+0xf7/0x330
> [    0.206514]  _printk+0x63/0x7e
> [    0.206516]  cblist_init_generic.constprop.0.cold+0x24/0x32
> [    0.206518]  rcu_init_tasks_generic+0x5/0xd9
> [    0.206522]  kernel_init_freeable+0x15b/0x2a2
> [    0.206523]  ? rest_init+0x160/0x160
> [    0.206526]  kernel_init+0x11/0x120
> [    0.206527]  ret_from_fork+0x1f/0x30
> [    0.206530]  </TASK>
> [    0.207018] cblist_init_generic: Setting shift to 1 and lim to 1.
> 
> This patch moves pr_info() so that it is called without
> rtp->cbs_gbl_lock locked.
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

This patch looks good, except that wasn't this supposed to be fixed
in printk()?  Or am I suffering from wishful thinking?

							Thanx, Paul

> ---
>  kernel/rcu/tasks.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 3925e32159b5..d46dd970bf22 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -227,7 +227,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  	if (rcu_task_enqueue_lim < 0) {
>  		rcu_task_enqueue_lim = 1;
>  		rcu_task_cb_adjust = true;
> -		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
>  	} else if (rcu_task_enqueue_lim == 0) {
>  		rcu_task_enqueue_lim = 1;
>  	}
> @@ -256,6 +255,10 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
>  		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
>  	}
>  	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> +
> +	if (rcu_task_cb_adjust)
> +		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
> +
>  	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
>  }
>  
> -- 
> 2.37.1
> 
