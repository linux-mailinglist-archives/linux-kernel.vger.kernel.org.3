Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D5C4A64EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242215AbiBATXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiBATXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:23:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD0C061714;
        Tue,  1 Feb 2022 11:23:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F35C3B82F75;
        Tue,  1 Feb 2022 19:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B1EC340EB;
        Tue,  1 Feb 2022 19:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643743430;
        bh=M3qrhQDIRqxRScO7LGC1gbR291jPdGWv35tPpFU2rdo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vi/CLqPBGOIyB3svBAwiwk5US1d7ONryE0jzvt2QceYCMycKkPHuocMzzsO3xjmyT
         GOQzEEct0lOq6QsJAgu4oBa1fTjuG3J83U3L0oHcYmREHhBJgV2CVmdg6uf+/w2g3B
         lsZTD3eEqOavWXe7mtfqbzy9iDtwOz0xvxp5GEZAecKuW+uu6FL+VcHCmX2ES59i6O
         RhAxJ7gqvNoGoD3nMNA0rd+bxBgo6t4xLaKrr4ULOgAncA4v/5Mn++q001+kMsRYEq
         QeOrgKPqQuzl5F9tVDrxkLcDOt2De0YK0jPfh0bpCG0KV7d3BKi9LR8rOfne8D37WZ
         JJFuZUE0P2vHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 80AF55C0326; Tue,  1 Feb 2022 11:23:50 -0800 (PST)
Date:   Tue, 1 Feb 2022 11:23:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] srcu: make srcu_size_state_name static
Message-ID: <20220201192350.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220129034502.73912-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129034502.73912-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 11:45:02AM +0800, Jiapeng Chong wrote:
> This symbol is not used outside of srcutree.c, so marks it static.
> 
> Fixes the following sparse warning:
> 
> kernel/rcu/srcutree.c:1426:12: warning: symbol 'srcu_size_state_name'
> was not declared. Should it be static?
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

And I did queue and push this, good catch, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 4201815744d8..31dbd41332f6 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1423,7 +1423,7 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
>  }
>  EXPORT_SYMBOL_GPL(srcutorture_get_gp_data);
>  
> -const char * const srcu_size_state_name[] =
> +static const char * const srcu_size_state_name[] =
>  {
>  	"SRCU_SIZE_SMALL",
>  	"SRCU_SIZE_ALLOC",
> -- 
> 2.20.1.7.g153144c
> 
