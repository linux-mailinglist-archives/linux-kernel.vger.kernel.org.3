Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A50C52638A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbiEMOOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiEMOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:14:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAC6E0D4;
        Fri, 13 May 2022 07:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD75462112;
        Fri, 13 May 2022 14:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159C2C34100;
        Fri, 13 May 2022 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652451286;
        bh=J0Cl4mXGgT8rgZPubGxu6kkMwNidiS6O+73+RhxIujQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MugHpPrbZcsmTJOodu+YZohAOEPU44MayaczpjCJS8yged8f23jozV9dbnCI0PEDr
         bwpIXWsebvpUffFp4Wf8RSbWttwYtRSciZtWsbfCnprslqqfMpuarZ/CQ714SGmok/
         Tm8aa5oPOwmGPFw6tCBrfEa2RoIbwUzcZ/cjjoGMY9d6gdJzl1HgawxP/wHRG+lI07
         /dBKzV7eb/WYHE0d2TjISBAW7Ie29voV6EotVbPjidn3CSjIFnTbGVjjTofpqdnCby
         juZqS1lqlinP1YlO0nTqyxvdQDEE4ymPYGmcqJGfmX25qV4waD6fNvR5A66gMDeS0V
         HArZXlUaELCHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF8E95C0342; Fri, 13 May 2022 07:14:45 -0700 (PDT)
Date:   Fri, 13 May 2022 07:14:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Direct boosting gp_tasks for strict grace periods
Message-ID: <20220513141445.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220513004256.465233-1-qiang1.zhang@intel.com>
 <20220513010651.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588012EC5E5DFD3FFDA49401DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB588012EC5E5DFD3FFDA49401DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:17:16PM +0000, Zhang, Qiang1 wrote:
> 
> On Fri, May 13, 2022 at 08:42:55AM +0800, Zqiang wrote:
> > If the CONFIG_RCU_STRICT_GRACE_PERIOD option is enabled, the normal 
> > grace period will be treated as expedited grace period, the gp_tasks 
> > that block current grace period needs to be boosted unconditionally, 
> > therefore this commit adds Kconfig check in rcu_initiate_boost().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> >Good eyes!  I have queued this for further review and testing, thank you!
> >
> >What sorts of tests did you run on it?
> 
> Hi Paul
> 
> I didn't think of  suitable test method,
> Can you provide me with a test method to test it, I will be happy to test.

Here is one possibility:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60 --configs "TREE01 TREE02 TREE03 TREE04 TREE05 TREE07 TREE09 TREE10" --kconfig "CONFIG_NR_CPUS=4 CONFIG_RCU_STRICT_GRACE_PERIOD=y" --trust-make

On a 16-CPU system, this will do eight kernel builds and run about two
hours of testing.

							Thanx, Paul

> Thanks,
> Zqiang
> 
> >
> >As usual, I could not resist the urge to wordsmith, so could you please check the version shown below?
> >
> >							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 079e0f894c5d887c678f94332c1fa7287abfd6bc
> Author: Zqiang <qiang1.zhang@intel.com>
> Date:   Fri May 13 08:42:55 2022 +0800
> 
>     rcu: Immediately boost preempted readers for strict grace periods
>     
>     The intent of the CONFIG_RCU_STRICT_GRACE_PERIOD Konfig option is to
>     cause normal grace periods to complete quickly in order to better catch
>     errors resulting from improperly leaking pointers from RCU read-side
>     critical sections.  However, kernels built with this option enabled still
>     wait for some hundreds of milliseconds before boosting RCU readers that
>     have been preempted within their current critical section.  The value
>     of this delay is set by the CONFIG_RCU_BOOST_DELAY Kconfig option,
>     which defaults to 500 milliseconds.
>     
>     This commit therefore causes kernels build with strict grace periods
>     to ignore CONFIG_RCU_BOOST_DELAY.  This causes rcu_initiate_boost()
>     to start boosting immediately after all CPUs on a given leaf rcu_node
>     structure have passed through their quiescent states.
>     
>     Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index 99cde4c947699..b4ab952f04ea6 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1159,7 +1159,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
>  	    (rnp->gp_tasks != NULL &&
>  	     rnp->boost_tasks == NULL &&
>  	     rnp->qsmask == 0 &&
> -	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
> +	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld ||
> +	      IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)))) {
>  		if (rnp->exp_tasks == NULL)
>  			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
