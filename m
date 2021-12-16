Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29134775E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbhLPP0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:26:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54278 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhLPP0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:26:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2D03B82493;
        Thu, 16 Dec 2021 15:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AB5C36AE0;
        Thu, 16 Dec 2021 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639668407;
        bh=I/UYQIV5rYUZG3ErJBA/lBZM/6VD1Lk/X9BQBb8BaQo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g+sy5zpX+pNUoj3+3Hjv6QhZjzFIB1G1nvXUybvKZWy4RrAUyr59JIP8Dn7aUrli4
         h19vrmH8pJn/r9QzF+9iMisZIwdDbIUiPgvWk+E1EQ5hPfNxdpatVCIG8BN4lH3MeI
         HNPxXaU13lpHbkdznXJci1SYL8kWU9H2D5AFOXjdiD82VfsVcDCpRFHkQT9lPhWTgn
         vnXFcIqKfD1axENcsOeYyshaGbIwG4RkGfLTCZahgOBZu91v9Jxzp/xdQrh4kVDEcE
         GoNPljhki2sxHE44dtWgE5leCv/SnE/AFbyDuPg0l4XKWob5j0lMCsqaL6ZrRswJc1
         3ejenVXZyW3Bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 590535C0C69; Thu, 16 Dec 2021 07:26:47 -0800 (PST)
Date:   Thu, 16 Dec 2021 07:26:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] rcu/nocb: clean up some inconsistent indenting
Message-ID: <20211216152647.GM641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211216091057.28675-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216091057.28675-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:10:57PM +0800, Jiapeng Chong wrote:
> Eliminate the follow smatch warning:
> 
> kernel/rcu/tree_nocb.h:1262 rcu_spawn_cpu_nocb_kthread() warn:
> inconsistent indenting.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Good catch, but kernel test robot beat you to it:

7512661668d7 ("rcu/nocb: Handle concurrent nocb kthreads creation")

						Thanx, Paul

> ---
>  kernel/rcu/tree_nocb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index dd4753219dca..936badfffcee 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1259,7 +1259,8 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  		}
>  		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
>  	}
> -	 mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> +
> +	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
>  
>  	/* Spawn the kthread for this CPU. */
>  	t = kthread_run(rcu_nocb_cb_kthread, rdp,
> -- 
> 2.20.1.7.g153144c
> 
