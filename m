Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EBC51C906
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385015AbiEETds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351650AbiEETdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:33:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC56B55492;
        Thu,  5 May 2022 12:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50F6ACE3090;
        Thu,  5 May 2022 19:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1C0C385A8;
        Thu,  5 May 2022 19:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651779001;
        bh=vA5c3sAZlsEIF9GVy5xkKqdpy6kiCh58XJGgalns9Zk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Rur4thgH3tGLOLQ3PE4NfuLNRo6KD+P9KN8uPermkSvDV+RSnfCSVeH1+luL/JihO
         nIaKMx8E+70C9NaPk2/MAZdAwmLF4e3A1hfmi9UlnnnoTKQho8krlzE40Wbg6ZaHul
         OYtZXG3IuFld81DJDac/OHvgjqNqhrYnuLwwrWteLOCuvdNc9j5niJJLsBHQ8W0/2y
         z9RZTjaqQRQGFIYZLlW7IPHuyDZpURyxIuE/iYgA47tjeVy6ZJDQCR5NQRf+cScAmZ
         /RwMgI19giflsDT9cLsCAPRy/57WSVwMN2LGVT8+wgD6eawna6yodohAL9eQfWMj7U
         U+VdD4wj/hjYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 43FBA5C2CB7; Thu,  5 May 2022 12:29:56 -0700 (PDT)
Date:   Thu, 5 May 2022 12:29:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Add rnp->cbovldmask check in
 rcutree_migrate_callbacks()
Message-ID: <20220505192956.GX1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220505155236.1559619-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505155236.1559619-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 11:52:36PM +0800, Zqiang wrote:
> Currently, the rnp's cbovlmask is set in call_rcu(). when CPU going
> offline, the outgoing CPU's callbacks is migrated to target CPU, the
> number of callbacks on the my_rdp may be overloaded, if overload and
> there is no call_rcu() call on target CPU for a long time, the rnp's
> cbovldmask is not set in time. in order to fix this situation, add
> check_cb_ovld_locked() in rcutree_migrate_callbacks() to help CPU more
> quickly reach quiescent states.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Doesn't this get set right at the end of the current grace period?
Given that there is a callback overload, there should be a grace
period in progress.

See this code in rcu_gp_cleanup():

		if (rcu_is_leaf_node(rnp))
			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
				rdp = per_cpu_ptr(&rcu_data, cpu);
				check_cb_ovld_locked(rdp, rnp);
			}

So what am I missing here?  Or are you planning to remove the above code?

If so, wouldn't you also need to clear the indication for the CPU that
is going offline, being careful to handle the case where the two CPUs
have different leaf rcu_node structures?

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9dc4c4e82db6..bcc5876c9753 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4577,6 +4577,7 @@ void rcutree_migrate_callbacks(int cpu)
>  	needwake = needwake || rcu_advance_cbs(my_rnp, my_rdp);
>  	rcu_segcblist_disable(&rdp->cblist);
>  	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) != !rcu_segcblist_n_cbs(&my_rdp->cblist));
> +	check_cb_ovld_locked(my_rdp, my_rnp);
>  	if (rcu_rdp_is_offloaded(my_rdp)) {
>  		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
>  		__call_rcu_nocb_wake(my_rdp, true, flags);
> -- 
> 2.25.1
> 
