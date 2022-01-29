Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424D94A2BBC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 06:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiA2FRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 00:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiA2FRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 00:17:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE761C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 21:17:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79B14B80D99
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 05:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D2FC340E5;
        Sat, 29 Jan 2022 05:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643433469;
        bh=xWogAawKdWadHt6LCDtsrbOOebPsDsCNfGzHPC9DZ3k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sZ6FzsHmRp95A8EzcFmNSyp3Ru/N51pwM8yHCKhuaUJ5A09T7xa8SQDTByZOw7ekV
         EMExjpr4D95BpH6wVyE0W/ADRVPrfLsQzMjgcq4Zj6J7d0ch9+PEmOn8H4zrVD1cMM
         gPqs2/6Jj78N8x+B3PsP8IvCCb5OYzn/GqlEvBKemnLWhYwD63DVY/vZItdjN98d6H
         rl9sBhozxl0PyQLzi162/OWxJBqiMbQqrGir5p1pHnJGW3Tfesfmp6SkE2sorkSrRH
         LS8FF8dwEFp4FJvpRfn7g16QEwq22eawO6GNvOEDVqCanzR8Lc2XLh1HdUao1r8VpX
         wlspuKP2Fqu4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 982C55C0439; Fri, 28 Jan 2022 21:17:48 -0800 (PST)
Date:   Fri, 28 Jan 2022 21:17:48 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: When rcuog kthreads is in polling mode, wakeup
 waitqueue is not requried
Message-ID: <20220129051748.GP4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220128031346.157961-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128031346.157961-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 11:13:46AM +0800, Zqiang wrote:
> When grace period cleanup, the rcuog kthreads that waiting in sq
> waitqueue will be awakened, however if the 'rcu_nocb_poll' is set,
> the sq waitqueue always empty, so if 'rcu_nocb_poll' is set, return
> directly.

This does decrease grace-period-cleanup overhead in kernels built with
CONFIG_RCU_NOCB_CPU=y and booted with the rcu_nocb_poll kernel boot
parameter set.  On the other hand, it increases grace-period-cleanup
overhead in kernels built with CONFIG_RCU_NOCB_CPU=y but booted without
the rcu_nocb_poll kernel boot parameter set.

Last I checked, more kernels were booted without the rcu_nocb_poll kernel
boot parameter set.  If this is still the case, this patch would slow
things down for most systems.

Or are there now lots of systems booted with rcu_nocb_poll?

							Thanx, Paul

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_nocb.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 636d0546a4e9..9e106c590e56 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -201,6 +201,8 @@ static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
>   */
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
>  {
> +	if (rcu_nocb_poll)
> +		return;
>  	swake_up_all(sq);
>  }
>  
> -- 
> 2.25.1
> 
