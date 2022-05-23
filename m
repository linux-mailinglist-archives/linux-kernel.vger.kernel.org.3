Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B03531F28
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiEWXSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiEWXSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:18:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08022BF4;
        Mon, 23 May 2022 16:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE4746153D;
        Mon, 23 May 2022 23:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09265C385A9;
        Mon, 23 May 2022 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653347918;
        bh=mgBH/XhMdPrqPt2ZcMqBzq6LLfTvOnzdJhX9QH8tjR4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PBZwqhtJQ+JapHXo0HRl8UOmPRrt6E5xwxOapWM01Nqfl13ABKlOYI5VPpjKdAIXu
         Q0xDQJtdk/DwrR0bX1RmFkvy7K5YUL5anFoDecCtioxW3q6tAOHb6EJuSVKqfHKPFl
         oyPERmpDw5zdYikKs5oGlY78CO/k24we5oF+3A5Av5kx1j44NaFvan3/FXjQZLXjC6
         6vlPqq3WMvhP5lzwlQtN85+60YwClBGpBpw1PaiUgNuTS6auDzo8ZjCbaIkYTMuaMM
         k/oaQro5JuyvA9svhX/4NE/aELjUktTVZaQFgQg46YtuLADZYz5zfeP/+2QGPG/9/5
         +1O0IsSkf+5EQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 94CD15C032C; Mon, 23 May 2022 16:18:37 -0700 (PDT)
Date:   Mon, 23 May 2022 16:18:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/rcuscale: Fix using smp_processor_id() in
 preemptible warnings
Message-ID: <20220523231837.GH1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220521065626.1815175-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521065626.1815175-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 02:56:26PM +0800, Zqiang wrote:
> BUG: using smp_processor_id() in preemptible [00000000] code: rcu_scale_write/69
> CPU: 0 PID: 66 Comm: rcu_scale_write Not tainted 5.18.0-rc7-next-20220517-yoctodev-standard+
> caller is debug_smp_processor_id+0x17/0x20
> Call Trace:
> <TASK>
> dump_stack_lvl+0x49/0x5e
> dump_stack+0x10/0x12
> check_preemption_disabled+0xdf/0xf0
> debug_smp_processor_id+0x17/0x20
> rcu_scale_writer+0x2b5/0x580
> kthread+0x177/0x1b0
> ret_from_fork+0x22/0x30
> </TASK>
> 
> Reproduction method:
> runqemu kvm slirp nographic qemuparams="-m 4096 -smp 8" bootparams="isolcpus=2,3
> nohz_full=2,3 rcu_nocbs=2,3 rcutree.dump_tree=1 rcuscale.shutdown=false
> rcuscale.gp_async=true" -d
> 
> when the CONFIG_DEBUG_PREEMPT is enabled, this_cpu_ptr() will call
> debug_smp_processor_id() get current CPU number, this warning is triggered by
> is_percpu_thread() in debug_smp_processor_id(), the is_percpu_thread() need to
> check whether 'current->nr_cpus_allowed  == 1' and 'current->flags & PF_NO_SETAFFINITY',
> invoke set_cpus_allowed_ptr() only set kthreads->nr_cpus_allowed, but the
> PF_NO_SETAFFINITY is not set to kthread->flags, so add PF_NO_SETAFFINITY flags
> setting.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch!  Queued for v5.20 (or v6.0, as Linus decides), thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 277a5bfb37d4..3ef02d4a8108 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -419,6 +419,7 @@ rcu_scale_writer(void *arg)
>  	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
>  	WARN_ON(!wdpp);
>  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> +	current->flags |= PF_NO_SETAFFINITY;
>  	sched_set_fifo_low(current);
>  
>  	if (holdoff)
> -- 
> 2.25.1
> 
