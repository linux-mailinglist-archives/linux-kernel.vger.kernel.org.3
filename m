Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5140A4B2943
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbiBKPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:43:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbiBKPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:43:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24021B5;
        Fri, 11 Feb 2022 07:43:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84F4262018;
        Fri, 11 Feb 2022 15:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CC4C340E9;
        Fri, 11 Feb 2022 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644594226;
        bh=tc9vPw1lHjzGW9lJiQO7bBzDxlY8TMaxbA9HQedzYlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyBGd7Zpz4rKxpWBjcze6Ekj6fkF9awCmwcE3VJtjLY0Tm2aRuEOHQ2Ut6pddPsNO
         Sm3OBbvCfAgF7rxR62j+XDP1kBYeUgIFg+63EhfcWG89uDVAw0xzRrMAWee+TS11Q6
         no9hYTHD9iktK6pnsPk9eMl4cGo1JYmnFtkTSYtC0EhlaNX4xgpvmecWpixz1Uh2ZV
         dX1GTZ2B4GvD4Sud0z8uqYcJ7LUHqAVLBUd9PQPlmBN35UmcFneuA0uyjM086+RW+X
         mGsbi+btOt/nUAu4U0CtBvY6iHCe9AelKuRcdHM1L/muQQ/dIxDDbOisYLalOlPl2K
         n6I+rX6p5vTcA==
Date:   Fri, 11 Feb 2022 16:43:44 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH rcu 3/9] rcu: Add mutex for rcu boost kthread spawning
 and affinity setting
Message-ID: <20220211154344.GD588079@lothringen>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
 <20220204230805.4193767-3-paulmck@kernel.org>
 <20220211145757.GA587320@lothringen>
 <20220211151148.GA588079@lothringen>
 <20220211154203.GB4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211154203.GB4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 07:42:03AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 11, 2022 at 04:11:48PM +0100, Frederic Weisbecker wrote:
> > On Fri, Feb 11, 2022 at 03:57:57PM +0100, Frederic Weisbecker wrote:
> > > On Fri, Feb 04, 2022 at 03:07:59PM -0800, Paul E. McKenney wrote:
> > > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > > 
> > > > As we handle parallel CPU bringup, we will need to take care to avoid
> > > > spawning multiple boost threads, or race conditions when setting their
> > > > affinity. Spotted by Paul McKenney.
> > > > 
> > > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > > Speaking of, we have:
> > > 
> > > rcu_init()
> > >    for_each_online_cpu(cpu) // should be boot CPU only at this stage ?
> > >        rcutree_prepare_cpu(cpu)
> > >            rcu_spawn_one_boost_kthread(cpu)
> > > 
> > > 
> > > early_initcall()
> > >     rcu_spawn_gp_kthread()
> > >         rcu_spawn_boost_kthreads()
> > > 	    rcu_for_each_leaf_node(rnp)
> > > 	        rcu_rnp_online_cpus(rnp) // as above, only boot CPU at this stage.
> > >                     rcu_spawn_one_boost_kthread(cpu)
> > > 
> > > cpu_up()
> > >     rcutree_prepare_cpu(cpu)
> > >         rcu_spawn_one_boost_kthread(cpu)
> > > 
> > > 
> > > My guess is that we could remove rcu_spawn_boost_kthreads() and simplify
> > > rcu_init(). Something like this (untested yet):
> 
> If you also add a WARN_ON() for more than one CPU being online at
> rcu_init() time, I am good with this approach.  The main danger that
> the pre-rcu_init() portion of the boot time becomes the long straw in
> the eternal quest to make systems boot faster, but it is not hard to
> put it back.  Hence the WARN_ON() to make it clear that adjustment
> is needed.  ;-)
> 
> 							Thanx, Paul

Make sense. On my TODO list then.

Thanks!
