Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000414CC331
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiCCQuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiCCQuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:50:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E437C151C5D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:49:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82C246136C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 16:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97231C004E1;
        Thu,  3 Mar 2022 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646326158;
        bh=DHN2loWZ8dEbq2bpRF30ogIu8WNUzkahzY2QdqhHG9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlilN3vckIPOI5jhYxbYVLe2OJjQfn6+Psk3P8x0SGkpy9NjNrzQm1pTQt9S4y5Id
         vy3KgYwZ6fWIlVSjzv9gWKk3+8LQno4FnscL7yo+OJBwzeiZ7PUijZm2b06EMPLpRr
         uGdIuf8brUU1+fQO4Vr7vEYnHJ1Ig61yrViWwJmjvNoOvd/lDWLLeewXYy7ZELkkVq
         GdT/CeJSi+XfXYDoKccV9FUeIGMA5NpFBq1Iew0Upm2QBou5UBPwR9PVYmEVY2jg6t
         Fv4iHRwgJD9K5c0WyiuOtvXJ7JRT2vnxFl5hISq1c/SnVOFcMwLguLmb7sB/6dkzBV
         ZONiJfsUBu32w==
Date:   Thu, 3 Mar 2022 17:49:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] rcu/nocb: Clear rdp offloaded flags when rcuop/rcuog
 kthreads spawn failed
Message-ID: <20220303164914.GA87151@lothringen>
References: <20220228093629.3746473-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228093629.3746473-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 05:36:29PM +0800, Zqiang wrote:
> When CONFIG_RCU_NOCB_CPU is enabled and 'rcu_nocbs' is set, the rcuop
> and rcuog kthreads is created. however the rcuop or rcuog kthreads
> creation may fail, if failed, clear rdp offloaded flags.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_nocb.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 46694e13398a..94b279147954 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1246,7 +1246,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  				"rcuog/%d", rdp_gp->cpu);
>  		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
>  			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> -			return;
> +			goto end;
>  		}
>  		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
>  		if (kthread_prio)
> @@ -1258,12 +1258,22 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  	t = kthread_run(rcu_nocb_cb_kthread, rdp,
>  			"rcuo%c/%d", rcu_state.abbr, cpu);
>  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
> -		return;
> +		goto end;
>  
>  	if (kthread_prio)
>  		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
>  	WRITE_ONCE(rdp->nocb_cb_kthread, t);
>  	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
> +	return;
> +end:
> +	if (cpumask_test_cpu(cpu, rcu_nocb_mask)) {
> +		rcu_segcblist_offload(&rdp->cblist, false);
> +		rcu_segcblist_clear_flags(&rdp->cblist,
> +				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
> +		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_LOCKING);
> +		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
> +	}

Thanks you, consequences are indeed bad otherwise because the target is considered
offloaded but nothing actually handles the callbacks.

A few issues though:

* The rdp_gp kthread may be running concurrently. If it's iterating this rdp and
  the SEGCBLIST_LOCKING flag is cleared in the middle, rcu_nocb_unlock() won't
  release (among many other possible issues).

* we should clear the cpu from rcu_nocb_mask or we won't be able to later
  re-offload it.

* we should then delete the rdp from the group list:

     list_del_rcu(&rdp->nocb_entry_rdp);

So ideally we should call rcu_nocb_rdp_deoffload(). But then bear in mind:

1) We must lock rcu_state.barrier_mutex and hotplug read lock. But since we
   are calling rcutree_prepare_cpu(), we maybe holding hotplug write lock
   already.

   Therefore we first need to invert the locking dependency order between
   rcu_state.barrier_mutex and hotplug lock and then just lock the barrier_mutex
   before calling rcu_nocb_rdp_deoffload() from our failure path.
   

2) On rcu_nocb_rdp_deoffload(), handle non-existing nocb_gp and/or nocb_cb
   kthreads. Make sure we are holding nocb_gp_kthread_mutex.

I'm going to take your patch and adapt it along those lines.

Thanks!
