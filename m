Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB39A5A83F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiHaRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiHaRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A8FDEA75;
        Wed, 31 Aug 2022 10:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5317661A28;
        Wed, 31 Aug 2022 17:00:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B56C433D6;
        Wed, 31 Aug 2022 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661965245;
        bh=Zhjh7G7sPVKRPFjsonBsqBM5O5A+diJMnILvCS3tHeo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LXMpglWCbk+7CT2yhdwvVQ18LK0yJyJpH3ems6RSUVbZJWZPL1lh1XHtsngBmCu36
         WXOC0G3IpNreNt4ZGsMLbMrLr+HeKe6h6WE4MF+X2hLN31qSCUTfCNS1dEvzUgkzvA
         uKGOqAKA7DCnS3+oCCodorVbpCTgJnepL1HQNnRqVvkWr3+EsJWp0SvilI5S7SwXQJ
         7h0mT+CnDBse0TKj0IsdNBTkJXB4QtquKIzr8SzbBNTuBs2OvVLiDaz8dezMQmC3yp
         DgMq3k+KvpvBXOcaz7E21KDkf+BPzdu+dPc1Oz0I+Q0fM0wCeMxz1plXjFu6aqDU6E
         fyWAnz53b1Azg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 37EAF5C015D; Wed, 31 Aug 2022 10:00:45 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:00:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Remove duplicate RCU exp QS report from
 rcu_report_dead()
Message-ID: <20220831170045.GL6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220830083151.396561-1-qiang1.zhang@intel.com>
 <20220830090623.GR6159@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58809A3EB14FDBD408292446DA799@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58809A3EB14FDBD408292446DA799@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 11:30:39AM +0000, Zhang, Qiang1 wrote:
> On Tue, Aug 30, 2022 at 04:31:51PM +0800, Zqiang wrote:
> > For PREEMPT_RCU, the rcu_report_dead() is invoked means that the
> > outgoing CPU mask is clear from leaf rcu_node and has no further
> > need of RCU, so invoke rcu_preempt_depth() return value is always
> > zero in rcu_report_dead(), if the current outgoing CPU rcu_data
> > structure's cpu_no_qs.b.exp is true, the rcu_preempt_deferred_qs()
> > will invoke rcu_report_exp_rdp() to report exp QS.
> > 
> > for non-PREEMPT_RCU, the rcu_preempt_deferred_qs() is equivalent to
> > rcu_report_exp_rdp().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >Nice!  
> >
> >One question... Currently, for PREEMPT_RCU, the outgoing CPU silently
> >reports a quiescent state even if there was a bug that resulted in that
> >CPU still being in an RCU read-side critical section.  With your change,
> >the outgoing CPU would silently refuse to report a quiescent state.
> >
> >Is there something along the CPU-offline code path that already complains
> >about this situation?  If not, I believe that the first WARN_ON_ONCE()
> >in rcu_implicit_dynticks_qs() would complain.
> 
> In the following code, the current CPU will report QS if (rnp->qsmask & mask) return true.
> it means that the WARN_ON_ONCE(!rcu_rdp_cpu_online(rdp)) is not trigger.
> 
> if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
>                 /* Report quiescent state -before- changing ->qsmaskinitnext! */
>                 rcu_disable_urgency_upon_qs(rdp);
>                 rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
>                 raw_spin_lock_irqsave_rcu_node(rnp, flags);
>         }
>  WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
> 
> >
> >Could you please try this, just so we know what happens in this case?
> >One way of forcing this would be to do rcu_read_lock() just before the
> >call to rcu_report_dead(), though other diagnostics might require that
> >rcu_read_lock() to be earlier in the code.
> >
> >
> >Another question in both cases...  There is a more subtle change where the
> >old code ignores rdp->cpu_no_qs.b.exp (thus invoking rcu_report_exp_rdp()
> >unconditionally) and the new code avoids invoking rcu_report_exp_rdp()
> >unless this is set.  How does this interact with a new expedited
> >grace period that starts just as this CPU calls rcu_report_dead()?
> 
> 1.When a new expedited grace period that starts just as this CPU call rcu_report_dead(),
> if in this time, this CPU rcu_data structure's cpu_no_qs.b.exp is not set true, 
> the rcu_preempt_deferred_qs() will not call rcu_report_exp_rdp().  but when call
> rcu_report_dead(),  this CPU have been offline(cpu_is_offline(this CPU) return true).
> 
> 2.In __sync_rcu_exp_select_node_cpus(), invoke smp_call_function_single() for this
> CPU will return -ENXIO,  and then check  (rnp->qsmaskinitnext & mask) and (rnp->expmask & mask) 
> 
> 3.If in this time, the rcu_report_dead() has not yet clear CPU mask from rnp->qsmaskinitnext,
> we will redo 2 step,  recall smp_call_function_single(), but is always return -ENXIO, 
> and recheck (rnp->qsmaskinitnext & mask) and (rnp->expmask & mask), until rcu_report_dead()
> clear CPU mask from rnp->qsmaskinitnext.  
> 
> Therefore, the __sync_rcu_exp_select_node_cpus() will call rcu_report_exp_cpu_mult()
> to report this offline CPU's exp QS 

Very good, thank you!

Please see below for the newly applied patch with the usual wordsmithing.
As always, please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit d51fbcdfb30dbe6e2e9c5874b9821f2c78092b2e
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Tue Aug 30 16:31:51 2022 +0800

    rcu: Remove duplicate RCU exp QS report from rcu_report_dead()
    
    The rcu_report_dead() function invokes rcu_report_exp_rdp() in order
    to force an immediate expedited quiescent state on the outgoing
    CPU, and then it invokes rcu_preempt_deferred_qs() to provide any
    required deferred quiescent state of either sort.  Because the call to
    rcu_preempt_deferred_qs() provides the expedited RCU quiescent state if
    requested, the call to rcu_report_exp_rdp() is potentially redundant.
    
    One possible issue is a concurrent start of a new expedited RCU
    grace period, but this situation is already handled correctly
    by __sync_rcu_exp_select_node_cpus().  This function will detect
    that the CPU is going offline via the error return from its call
    to smp_call_function_single().  In that case, it will retry, and
    eventually stop retrying due to rcu_report_exp_rdp() clearing the
    ->qsmaskinitnext bit corresponding to the target CPU.  As a result,
    __sync_rcu_exp_select_node_cpus() will report the necessary quiescent
    state after dealing with any remaining CPU.
    
    This change assumes that control does not enter rcu_report_dead() within
    an RCU read-side critical section, but then again, the surviving call
    to rcu_preempt_deferred_qs() has always made this assumption.
    
    This commit therefore removes the call to rcu_report_exp_rdp(), thus
    relying on rcu_preempt_deferred_qs() to handle both normal and expedited
    quiescent states.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6bb8e72bc8151..0ca21ac0f0648 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4276,8 +4276,6 @@ void rcu_report_dead(unsigned int cpu)
 	// Do any dangling deferred wakeups.
 	do_nocb_deferred_wakeup(rdp);
 
-	/* QS for any half-done expedited grace period. */
-	rcu_report_exp_rdp(rdp);
 	rcu_preempt_deferred_qs(current);
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
