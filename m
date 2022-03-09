Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1D4D3BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiCIVIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiCIVID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:08:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A386910A7C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59F2CB823D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4C7C340E8;
        Wed,  9 Mar 2022 21:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646860021;
        bh=gJmctXUQiX1gCcm73GlTrzc5LAq6lquAv++b2dFj0Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kEnlFUHqSXr3jKm7gQ5sb8P08GDFIoF81vvvLpBhB3KNAmI0x9MNiHewuAOIk47Ec
         yocus+nL8obUkN5YG/AsoUzfV+Cdy2RzlfP3izGPzvpLnlKoujzHRruX7HaEu+fVhx
         Go2AyTFQvRdQ2c5qcNuvTk7EA/4qYqR7gv0NmB6OgARAsYh8sSXQC8PnBAaKiVNO1X
         WTzLA9Ujw4liYAWEBlKZ9b9bhQXusHntQ7bcjm+bL4MKfgUgkMLjhWxUWePd8FrAG8
         zax4UN4gSqYlpKzIGCYQRj9uG0TX4gsKKKXXF+J/SFUPjOefToVJlK3wfPl1oDmCjG
         vMSKRvbNMVdJw==
Date:   Wed, 9 Mar 2022 22:06:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] rcu/nocb: Clear rdp offloaded flags when rcuop/rcuog
 kthreads spawn failed
Message-ID: <20220309210657.GA68899@lothringen>
References: <20220228093629.3746473-1-qiang1.zhang@intel.com>
 <20220303164914.GA87151@lothringen>
 <PH0PR11MB5880F450C2DDD04D4C76F814DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880F450C2DDD04D4C76F814DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 07:37:24AM +0000, Zhang, Qiang1 wrote:
> 
> On Mon, Feb 28, 2022 at 05:36:29PM +0800, Zqiang wrote:
> > When CONFIG_RCU_NOCB_CPU is enabled and 'rcu_nocbs' is set, the rcuop 
> > and rcuog kthreads is created. however the rcuop or rcuog kthreads 
> > creation may fail, if failed, clear rdp offloaded flags.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree_nocb.h | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index 
> > 46694e13398a..94b279147954 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1246,7 +1246,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
> >  				"rcuog/%d", rdp_gp->cpu);
> >  		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
> >  			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> > -			return;
> > +			goto end;
> >  		}
> >  		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
> >  		if (kthread_prio)
> > @@ -1258,12 +1258,22 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
> >  	t = kthread_run(rcu_nocb_cb_kthread, rdp,
> >  			"rcuo%c/%d", rcu_state.abbr, cpu);
> >  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
> > -		return;
> > +		goto end;
> >  
> >  	if (kthread_prio)
> >  		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> >  	WRITE_ONCE(rdp->nocb_cb_kthread, t);
> >  	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
> > +	return;
> > +end:
> > +	if (cpumask_test_cpu(cpu, rcu_nocb_mask)) {
> > +		rcu_segcblist_offload(&rdp->cblist, false);
> > +		rcu_segcblist_clear_flags(&rdp->cblist,
> > +				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
> > +		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_LOCKING);
> > +		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
> > +	}
> >>
> >>Thanks you, consequences are indeed bad otherwise because the target is considered offloaded but nothing actually handles the callbacks.
> >>
> >>A few issues though:
> >>
> >>* The rdp_gp kthread may be running concurrently. If it's iterating this rdp and
> >>  the SEGCBLIST_LOCKING flag is cleared in the middle, rcu_nocb_unlock() won't
> >>  release (among many other possible issues).
> >>
> >>* we should clear the cpu from rcu_nocb_mask or we won't be able to later
> >>  re-offload it.
> >>
> >>* we should then delete the rdp from the group list:
> >>
> >>     list_del_rcu(&rdp->nocb_entry_rdp);
> >>
> >>So ideally we should call rcu_nocb_rdp_deoffload(). But then bear in mind:
> >>
> >>1) We must lock rcu_state.barrier_mutex and hotplug read lock. But since we
> >>   are calling rcutree_prepare_cpu(), we maybe holding hotplug write lock
> >>   already.
> >>
> >>   Therefore we first need to invert the locking dependency order between
> >>   rcu_state.barrier_mutex and hotplug lock and then just lock the barrier_mutex
> >>   before calling rcu_nocb_rdp_deoffload() from our failure path.
> >>   
> >>
> >>2) On rcu_nocb_rdp_deoffload(), handle non-existing nocb_gp and/or nocb_cb
> >>   kthreads. Make sure we are holding nocb_gp_kthread_mutex.
> 
> Sorry for my late reply,  Is the nocb_gp_kthread_mutex really necessary?
> Because the cpu online/offline is serial operation,  It is protected by  cpus_write_lock()

And you're right! But some people are working on making cpu_up() able to work
in parallel for faster bring-up on boot.
