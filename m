Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154784BFF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiBVQ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiBVQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:59:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A99D16C4D1;
        Tue, 22 Feb 2022 08:59:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E65096117D;
        Tue, 22 Feb 2022 16:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C92DC340F1;
        Tue, 22 Feb 2022 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645549141;
        bh=mcVbNA4RiJ6SesKl5tKDIPRvmxcaUwbH9SGtI9DHx2A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mlC2ADN585kEmAHpiwY+yeVr1D5KH7GlEtOp7uX8ZY0EuBj91LKIPWUTvSRYxI5V1
         UGYqp3pfbW8hp3gJ0XSRUYJoIsnzAl0Ogu3eFPkFwzBnMxruaRTnOY3cs6w+MBI0op
         PFEKVeBqSMqhu+ETgleHpFT+kvkcAnDpgimpCr5pr5Qc9w8kmkm9ktp4mrL+LRz2c3
         aRZvEucigtS9FeQUvqV6hDToh1OClD/Shvs/zX1TNBOE5OoqJUIReTBcifmNt36Q4d
         1VUCTxvmok8FNV10x+dD+cBLfA4tkZoQmRZK9UICCT/aTkGEw4Fst2pOgh8n8W16Fy
         Vn3OU69omUNVA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E61465C031F; Tue, 22 Feb 2022 08:59:00 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:59:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        frederic@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH] srcu: Ensure snp nodes tree is fully initialized before
 traversal
Message-ID: <20220222165900.GI4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220222060901.24531-1-quic_neeraju@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222060901.24531-1-quic_neeraju@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:39:01AM +0530, Neeraj Upadhyay wrote:
> For configurations where snp node tree is not initialized at
> init time (SRCU_SIZING_IS_INIT() is false), srcu_funnel_gp_start()
> and srcu_funnel_exp_start() can potential traverse and observe
> the snp nodes' transient (uninitialized) states. This can potentially
> happen, when init_srcu_struct_nodes() initialization of sdp->mynode
> races with srcu_funnel_gp_start() and srcu_funnel_exp_start()
> 
> Consider the case below where srcu_funnel_gp_start() observes
> sdp->mynode to be not NULL and uses an uninitialized sdp->grpmask
> 
>           P1                                  P2
> 
> init_srcu_struct_nodes()           void srcu_funnel_gp_start(...)
> {
> for_each_possible_cpu(cpu) {
>   ...
>   sdp->mynode = &snp_first[...];
>   for (snp = sdp->mynode;...)       struct srcu_node *snp_leaf =
>                                        smp_load_acquire(&sdp->mynode)
>     ...                             if (snp_leaf) {
>                                       for (snp = snp_leaf; ...)
>                                         ...
> 					if (snp == snp_leaf)
>                                          snp->srcu_data_have_cbs[idx] |=
>                                            sdp->grpmask;
>     sdp->grpmask =
>       1 << (cpu - sdp->mynode->grplo);
>   }
> }
> 
> Similarly, init_srcu_struct_nodes() and srcu_funnel_exp_start() can
> race, where srcu_funnel_exp_start() could observe state of snp lock
> before spin_lock_init().
> 
>           P1                                      P2
> 
> init_srcu_struct_nodes()               void srcu_funnel_exp_start(...)
> {
>   srcu_for_each_node_breadth_first(ssp, snp) {      for (; ...) {
>                                                       spin_lock_...(snp, )
> 	spin_lock_init(&ACCESS_PRIVATE(snp, lock));
>     ...
>   }
>   for_each_possible_cpu(cpu) {
>     ...
>     sdp->mynode = &snp_first[...];
> 
> To avoid these issues, ensure that snp node tree initialization is
> complete i.e. after SRCU_SIZE_WAIT_BARRIER srcu_size_state is reached,
> before traversing the tree. Given that srcu_funnel_gp_start() and
> srcu_funnel_exp_start() are called within SRCU read side critical
> sections, this check is safe, in the sense that all callbacks are
> enqueued on CPU0 srcu_cblist until SRCU_SIZE_WAIT_CALL is entered,
> and these read side critical sections (containing srcu_funnel_gp_start()
> and srcu_funnel_exp_start()) need to complete, before SRCU_SIZE_WAIT_CALL
> is reached.
> 
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Good catch, and a hard one to hit!  Thank you for chasing this down!!!

I have queued this for testing and review.  I am beginning to suspect
that the SRCU branch might not be ready for mainline, so I will also redo
the merge to pull it in separately.  This allows deferring the decision
on whether it goes into the upcoming merge window or the next one.

After all, although the size of the srcu_struct can be annoying, random
bugs can be even more annoying.

							Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index e3cb84649b2a..c6ba40370c2c 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -818,9 +818,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
>  	int idx = rcu_seq_ctr(s) % ARRAY_SIZE(sdp->mynode->srcu_have_cbs);
>  	unsigned long sgsne;
>  	struct srcu_node *snp;
> -	struct srcu_node *snp_leaf = smp_load_acquire(&sdp->mynode);
> +	struct srcu_node *snp_leaf;
>  	unsigned long snp_seq;
>  
> +	/* Ensure that snp node tree is fully initialized before traversing it */
> +	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> +		snp_leaf = NULL;
> +	else
> +		snp_leaf = sdp->mynode;
> +
>  	if (snp_leaf)
>  		/* Each pass through the loop does one level of the srcu_node tree. */
>  		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
> @@ -1008,6 +1014,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  	bool needgp = false;
>  	unsigned long s;
>  	struct srcu_data *sdp;
> +	struct srcu_node *sdp_mynode;
>  
>  	check_init_srcu_struct(ssp);
>  	idx = srcu_read_lock(ssp);
> @@ -1031,10 +1038,17 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
>  		needexp = true;
>  	}
>  	spin_unlock_irqrestore_rcu_node(sdp, flags);
> +
> +	/* Ensure that snp node tree is fully initialized before traversing it */
> +	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
> +		sdp_mynode = NULL;
> +	else
> +		sdp_mynode = sdp->mynode;
> +
>  	if (needgp)
>  		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
>  	else if (needexp)
> -		srcu_funnel_exp_start(ssp, smp_load_acquire(&sdp->mynode), s);
> +		srcu_funnel_exp_start(ssp, sdp_mynode, s);
>  	srcu_read_unlock(ssp, idx);
>  	return s;
>  }
> -- 
> 2.17.1
> 
