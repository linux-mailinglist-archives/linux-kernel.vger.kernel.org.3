Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5160552AF90
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiERBDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiERBDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A175A53E23;
        Tue, 17 May 2022 18:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BBAC61500;
        Wed, 18 May 2022 01:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950EEC385B8;
        Wed, 18 May 2022 01:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652835796;
        bh=Aad3FvNG8f1IOJNzdY4J3bfreB6ONcOeWJBpa+/vJqQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LKN3Rrkr+IosL+ZpSPpclcjFsWCeV+z4X1e0dUoi+zOJja3YIRETBXXGcsYWUrmUC
         z9R4xRpoL6GXd3Fyx4vmEuXpWsFc9MXyLMcI2NzwfP+jpL8J1IiyrytbBpKXQPo/LB
         CfIRlN5Ql26yrpudu1klxwfYuypX83Qb5d8sV8PTKYGj888JJ4RFUIrRr3LC8DtAHm
         axOzZfWJFiNlXtXSvSklQ0RHd0ab1h5RVDdTzULASOJXPBW8pXkSptpNC/s3djbtTv
         AmzZ8TK+SeFryjInLR6B0T43Gu0K9cHud/srxkcNRKm6FNqejpCrfUn1Gj+LaUbRXx
         MxAn087s/J5wQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2F7DE5C051B; Tue, 17 May 2022 18:03:16 -0700 (PDT)
Date:   Tue, 17 May 2022 18:03:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Direct boosting gp_tasks for strict grace periods
Message-ID: <20220518010316.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220513004256.465233-1-qiang1.zhang@intel.com>
 <20220513010651.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588012EC5E5DFD3FFDA49401DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220513141445.GF1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58802D034A41626D88F44BEEDACE9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58802D034A41626D88F44BEEDACE9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 12:32:10PM +0000, Zhang, Qiang1 wrote:
> On Fri, May 13, 2022 at 01:17:16PM +0000, Zhang, Qiang1 wrote:
> > 
> > On Fri, May 13, 2022 at 08:42:55AM +0800, Zqiang wrote:
> > > If the CONFIG_RCU_STRICT_GRACE_PERIOD option is enabled, the normal 
> > > grace period will be treated as expedited grace period, the gp_tasks 
> > > that block current grace period needs to be boosted unconditionally, 
> > > therefore this commit adds Kconfig check in rcu_initiate_boost().
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > 
> > >Good eyes!  I have queued this for further review and testing, thank you!
> > >
> > >What sorts of tests did you run on it?
> > 
> > Hi Paul
> > 
> > I didn't think of  suitable test method, Can you provide me with a 
> > test method to test it, I will be happy to test.
> >
> >Here is one possibility:
> >
> >tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60 --configs "TREE01 TREE02 TREE03 TREE04 TREE05 TREE07 TREE09 TREE10" --kconfig "CONFIG_NR_CPUS=4 CONFIG_RCU_STRICT_GRACE_PERIOD=y" --trust-make
> >
> >On a 16-CPU system, this will do eight kernel builds and run about two hours of testing.
> 
> Hi Paul
> 
> I tested according to the above command, and the results are as follows:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60 --configs TREE01 TREE02 TREE03 TREE04 TREE05 TREE07 TREE09 TREE10 --kconfig CONFIG_NR_CPUS=4 CONFIG_RCU_STRICT_GRACE_PERIOD=y --trust-make
> TREE01 ------- 154236 GPs (42.8433/s) [rcu: g1986553 f0x0 total-gps=496930]
> :CONFIG_NR_CPUS=4: improperly set
> :CONFIG_RCU_STRICT_GRACE_PERIOD=y: improperly set

This one didn't cooperate because other Kconfig setting force a minimum
CONFIG_NR_CPUS of 8192, so OK.

> TREE02 ------- 410546 GPs (114.041/s) [rcu: g196373325 f0x2 total-gps=49093612] n_max_cbs: 805081
> TREE03 ------- 160648 GPs (44.6244/s) [rcu: g128673793 f0x0 total-gps=32168735] n_max_cbs: 646284
> TREE04 ------- 347059 GPs (96.4053/s) [rcu: g539425233 f0x2 total-gps=134856594] n_max_cbs: 205907
> TREE05 ------- 360973 GPs (100.27/s) [rcu: g77594645 f0x0 total-gps=19398951] n_max_cbs: 31033
> :CONFIG_RCU_FANOUT_LEAF=6: improperly set

This is harmless -- CONFIG_RCU_STRICT_GRACE_PERIOD sets an upper limit
of 3 for CONFIG_RCU_FANOUT_LEAF.

> TREE07 ------- 355903 GPs (98.8619/s) [rcu: g639182469 f0x0 total-gps=159795908] n_max_cbs: 259737
> TREE09 ------- 305700 GPs (84.9167/s) [rcu: g9668841 f0x0 total-gps=2417506] n_max_cbs: 2498623
> :CONFIG_NR_CPUS=4: improperly set
> :CONFIG_RCU_STRICT_GRACE_PERIOD=y: improperly set

This one is because TREE09 does not define CONFIG_RCU_EXPERT, on which
CONFIG_RCU_STRICT_GRACE_PERIOD depends.

> TREE10 ------- 220566 GPs (61.2683/s) [rcu: g3456465 f0x0 total-gps=864409] n_max_cbs: 507348
> :CONFIG_RCU_STRICT_GRACE_PERIOD=y: improperly set

This one is because TREE10 also does not define CONFIG_RCU_EXPERT,
on which CONFIG_RCU_STRICT_GRACE_PERIOD depends.

So very good, and thank you!

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >							Thanx, Paul
> 
> > Thanks,
> > Zqiang
> > 
> > >
> > >As usual, I could not resist the urge to wordsmith, so could you please check the version shown below?
> > >
> > >							Thanx, Paul
> > 
> > ----------------------------------------------------------------------
> > --
> > 
> > commit 079e0f894c5d887c678f94332c1fa7287abfd6bc
> > Author: Zqiang <qiang1.zhang@intel.com>
> > Date:   Fri May 13 08:42:55 2022 +0800
> > 
> >     rcu: Immediately boost preempted readers for strict grace periods
> >     
> >     The intent of the CONFIG_RCU_STRICT_GRACE_PERIOD Konfig option is to
> >     cause normal grace periods to complete quickly in order to better catch
> >     errors resulting from improperly leaking pointers from RCU read-side
> >     critical sections.  However, kernels built with this option enabled still
> >     wait for some hundreds of milliseconds before boosting RCU readers that
> >     have been preempted within their current critical section.  The value
> >     of this delay is set by the CONFIG_RCU_BOOST_DELAY Kconfig option,
> >     which defaults to 500 milliseconds.
> >     
> >     This commit therefore causes kernels build with strict grace periods
> >     to ignore CONFIG_RCU_BOOST_DELAY.  This causes rcu_initiate_boost()
> >     to start boosting immediately after all CPUs on a given leaf rcu_node
> >     structure have passed through their quiescent states.
> >     
> >     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index 
> > 99cde4c947699..b4ab952f04ea6 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -1159,7 +1159,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
> >  	    (rnp->gp_tasks != NULL &&
> >  	     rnp->boost_tasks == NULL &&
> >  	     rnp->qsmask == 0 &&
> > -	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
> > +	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld ||
> > +	      IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)))) {
> >  		if (rnp->exp_tasks == NULL)
> >  			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
> >  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
