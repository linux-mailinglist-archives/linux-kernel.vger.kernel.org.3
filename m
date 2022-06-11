Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3498454767B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiFKQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiFKQeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:34:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65A62EA;
        Sat, 11 Jun 2022 09:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0630B8015B;
        Sat, 11 Jun 2022 16:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E53C34116;
        Sat, 11 Jun 2022 16:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654965273;
        bh=z3Hrpl1h+fHXQDyv5o6S5RIYzi9IdPIpektKcK8JcZ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pI7cbzpY3UPcatQh+7eXbG+t0QS8KNgat5cO2hv6ErY3Gcbh7VYueQaS6m5Dj1oxp
         HcLqRn65CBidJQ+fypDcyusE+UCKAVDz47UzQtxd8xIW3NwLFkp4+6bXvm6m98uWyO
         dapDHuvvotUpUiHBl8Adx3oo2yL30UXxQsBUhBxpDEbIyLtd34D1XzNYNK3LygGGi4
         hdmJK51fa06k8TGZUfxgH5l1pADr+RqQOS1COwcrousn9dLEcAeTM1/EMGq2ch2Tn6
         +UfxogM4QUjXpGo7qgZs4FNegoDQj4pghBvRBc/zVw6XT1eglg0IW561JMFt8TTF1P
         FPkPvy9xxoD7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C42CD5C0612; Sat, 11 Jun 2022 09:34:32 -0700 (PDT)
Date:   Sat, 11 Jun 2022 09:34:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Li Qiong <liqiong@nfschina.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        hukun@nfschina.com, qixu@nfschina.com, yuzhe@nfschina.com,
        renyu@nfschina.com
Subject: Re: [PATCH] rcu: Handle failure of memory allocation functions
Message-ID: <20220611163432.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220611093055.1473-1-liqiong@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611093055.1473-1-liqiong@nfschina.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 05:30:55PM +0800, Li Qiong wrote:
> Add warning when these functions (eg:kmalloc,vmalloc) fail, handle the
> failure.
> 
> Signed-off-by: Li Qiong <liqiong@nfschina.com>

Good catch, thank you!  However...

> ---
>  kernel/rcu/rcutorture.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 7120165a9342..97f90e304ae3 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1991,6 +1991,10 @@ static void rcu_torture_mem_dump_obj(void)
>  
>  	kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);

As long as we are checking, why not also check this one?

							Thanx, Paul

>  	rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
> +	if (WARN_ON_ONCE(!rhp)) {
> +		kmem_cache_destroy(kcp);
> +		return;
> +	}
>  	pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
>  	pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
>  	mem_dump_obj(ZERO_SIZE_PTR);
> @@ -2007,6 +2011,8 @@ static void rcu_torture_mem_dump_obj(void)
>  	kmem_cache_free(kcp, rhp);
>  	kmem_cache_destroy(kcp);
>  	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> +	if (WARN_ON_ONCE(!rhp))
> +		return;
>  	pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
>  	pr_alert("mem_dump_obj(kmalloc %px):", rhp);
>  	mem_dump_obj(rhp);
> @@ -2014,6 +2020,8 @@ static void rcu_torture_mem_dump_obj(void)
>  	mem_dump_obj(&rhp->func);
>  	kfree(rhp);
>  	rhp = vmalloc(4096);
> +	if (WARN_ON_ONCE(!rhp))
> +		return;
>  	pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
>  	pr_alert("mem_dump_obj(vmalloc %px):", rhp);
>  	mem_dump_obj(rhp);
> -- 
> 2.11.0
> 
