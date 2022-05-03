Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE77518FA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiECVED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiECVD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:03:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F0417061;
        Tue,  3 May 2022 14:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15D59B82111;
        Tue,  3 May 2022 21:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C137C385A4;
        Tue,  3 May 2022 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651611622;
        bh=jG5NBe0VkysUk7BMP5WD520VsUNwgrPLYkUUmUPeozo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1wcxbBYimTMdtoumwVcAZVCdLEKES1lQEQkee+tUvdBk/R+L56BWMgjsy3lVMJvo
         JagGZV/gP4Aicex8w4Ypc1vASl2EfYt520FJ/6lEurULXU54FFa2/dx+9JNn1UHcdw
         aTDV+CCRBJwXVhS96RjLTy9pU34JuvTycfY+OBZmGHKAHTqSMkRnmhAvWp9hRxzNgH
         l9FJDSoVDn0wFjkucJF3tKr7iXImavj99R1yB6zd6ZmwzKEMLuoys97fAyGyeaF6A2
         7u2qWhGhJ3aA58/79pP6VX2OV0bsUE/Mq1RDNxJdvcQ4uouFl7lZp5vZ3MlUeZJobf
         fnMOQ3B3fCkiw==
Date:   Tue, 3 May 2022 23:00:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Delete local variable 'need_rcu_nocb_mask' in
 rcu_init_nohz()
Message-ID: <20220503210019.GB2801234@lothringen>
References: <20220426073626.967-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426073626.967-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:36:26PM +0800, Zhen Lei wrote:
> The local variable 'need_rcu_nocb_mask' is true only if CONFIG_NO_HZ_FULL
> is defined. So branch "if (need_rcu_nocb_mask)" can be moved within the
> scope of "#if defined(CONFIG_NO_HZ_FULL)". At this point, using variable
> 'need_rcu_nocb_mask' is not necessary, so delete it.
> 
> No functional changes, but the code looks a little more concise.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/rcu/tree_nocb.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 636d0546a4e932e..1e334e217f0afb7 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1165,15 +1165,10 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> -	bool need_rcu_nocb_mask = false;
>  	struct rcu_data *rdp;
>  
>  #if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
> -		need_rcu_nocb_mask = true;
> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
> -
> -	if (need_rcu_nocb_mask) {
> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {

Thanks! I suspect though that the introduction of
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL has made this patch unecessary.


>  		if (!cpumask_available(rcu_nocb_mask)) {
>  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
>  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
> @@ -1182,6 +1177,7 @@ void __init rcu_init_nohz(void)
>  		}
>  		rcu_nocb_is_setup = true;
>  	}
> +#endif /* #if defined(CONFIG_NO_HZ_FULL) */
>  
>  	if (!rcu_nocb_is_setup)
>  		return;
> -- 
> 2.26.0.106.g9fadedd
> 
