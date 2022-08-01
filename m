Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE44F587449
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbiHAXOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiHAXOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5119029;
        Mon,  1 Aug 2022 16:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E697860ECC;
        Mon,  1 Aug 2022 23:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A437C433D6;
        Mon,  1 Aug 2022 23:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659395656;
        bh=msSXp5V27pNk50E/Kq/KnIJFDJAirrWbgafjytNaEEQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RyeV7ydZRJ/cuCBTk5T9QRA/OBFQWkdvl7MI+6tndxfmy0nz+HaDcPFpabXjEAyhV
         YBROw+S6LdnOwW3HfytOcmpWj+dR/Ri4HPFkFnwDKR8Wwon3wrtZCh8QvgBpEE4BiW
         wz+zKnkVAvH4ADCarY/eg39+Pvauism0oGpuT8aXfCF8g3Nsogo8pbTsSMYCIdJiQJ
         WKJUfoIbAE8yMK059NpdpknnOQoKRH2BdD+2KodQz5JDJyJu7Lyk364TkdYaKmO1ka
         O4IPrTrWLRT/JCxAOGM4zWF7ZaJds5TlcsCtRQdyVZF544YVPE153jzfHhOwBbUXMW
         GAI6vlJM2Pacw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E1F7F5C0D2B; Mon,  1 Aug 2022 16:14:15 -0700 (PDT)
Date:   Mon, 1 Aug 2022 16:14:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rcu/exp: Use NMI to get the backtrace of
 cpu_curr(other_cpu) first
Message-ID: <20220801231415.GC2860372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220730102330.1255-1-thunder.leizhen@huawei.com>
 <20220730102330.1255-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730102330.1255-2-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 06:23:28PM +0800, Zhen Lei wrote:
> The backtrace of cpu_curr(other_cpu) is unwinded based on the 'fp' saved
> during its last switch-out. For the most part, it's out of date. So try
> to use NMI to get the backtrace first, just like those functions in
> "tree_stall.h" did. Such as rcu_dump_cpu_stacks().
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Much better, thank you!

> ---
>  kernel/rcu/tree_exp.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 0f70f62039a9090..21381697de23f0b 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -665,7 +665,8 @@ static void synchronize_rcu_expedited_wait(void)
>  				mask = leaf_node_cpu_bit(rnp, cpu);
>  				if (!(READ_ONCE(rnp->expmask) & mask))
>  					continue;
> -				dump_cpu_task(cpu);
> +				if (!trigger_single_cpu_backtrace(cpu))
> +					dump_cpu_task(cpu);

But why not just leave this unchanged, rather than adding the call to
trigger_single_cpu_backtrace() in this patch and then removing it in
the next patch?

							Thanx, Paul

>  			}
>  		}
>  		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
> -- 
> 2.25.1
> 
