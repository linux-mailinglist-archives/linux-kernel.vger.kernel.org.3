Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF85741F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 05:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiGNDhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 23:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiGNDhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 23:37:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937B6113;
        Wed, 13 Jul 2022 20:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FE6EB82284;
        Thu, 14 Jul 2022 03:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C6AC34114;
        Thu, 14 Jul 2022 03:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657769839;
        bh=3YBXEGIoFqhOrxSmmYzSrJlGdc7ekAfO4Uiq2ymx4R8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cTxaATepM/+YZrLKhGS8yKyYzbzEnaOQ18gJ6rW8GpyVHqA1/spYgy0dUXHRgDlMl
         GJIH5vqNpnQERcNDfv4CbaApPNxn/2wylVJ3aM/rJFWW3N5NUxk8b3yYezveAou8oS
         tDD/w79uicGI5bb9JC+VWvm9tr/LxXmX7XYFtqDAFjWYLaz0Oiq1oBSNducPQVf/+t
         TuYN4R8BedJ1NJeggEkY3XB/3JtUiCtdsuMcaoP49SJhCEsjEfPxJ2ZAGGZ8/6RTve
         EtEIMZ0s0h5DRUw7JQip93p73aN58/zIW06jeEUaK2voW4Lb6Mwz169t1xUSVzdwrx
         NRjTk9+z8Bt6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ECF7A5C03B9; Wed, 13 Jul 2022 20:37:18 -0700 (PDT)
Date:   Wed, 13 Jul 2022 20:37:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rcu-tasks: Make synchronize_rcu_tasks_generic()
 no-ops on early booting
Message-ID: <20220714033718.GT1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220712082606.3662616-1-qiang1.zhang@intel.com>
 <20220712082606.3662616-3-qiang1.zhang@intel.com>
 <20220712173709.GX1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588067B6DC5195CBE1DDA7BFDA889@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB588067B6DC5195CBE1DDA7BFDA889@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:53:20AM +0000, Zhang, Qiang1 wrote:
> 
> On Tue, Jul 12, 2022 at 04:26:06PM +0800, Zqiang wrote:
> > When the rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE and not
> > yet converted to RCU_SCHEDULER_INIT, there is only idle task, any legal
> > call synchronize_rcu_tasks_generic() is a quiescent state. this commit
> > make synchronize_rcu_tasks_generic() no-ops when the rcu_scheduler_active
> > variable is RCU_SCHEDULER_INACTIVE.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> 
> >It looks like this would be a good way to provide early boot access
> >to synchronize_rcu_tasks(), synchronize_rcu_tasks_rude(), and
> >synchronize_rcu_tasks_trace().
> >
> >But do we really need early boot access to these functions?  As in has
> >the below WARN_ON() actually triggered?
> 
> when the rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE,
> invoke synchronize_rcu_tasks_generic(), in addition to triggering a warning, 
> also need to make it return directly, if not, the rcu_tasks_one_gp() will be
> called directly, but due to the rtp structure's -> pregp_func is not initialized,
> A null pointer bug will appear.
> 
> But like said, I don't see the need to call synchronize_rcu_tasks_generic() on 
> early booting.  maybe this change is  not necessary.

Not yet, anyway.  And adding this would require more testing.

However, if the current warning does trigger, and the caller has a
legitimate reason for invoking this function so early, please remember
this patch.  ;-)

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >And if it has triggered, and in a context that means that these functions
> >really are needed during early boot, how should the testing strategy
> >change to test these at the relevant portions of the boot sequence?
> >
> >>From what I know, hitting these during early boot would indicate that
> >something was removing a trace during early boot, and I know of no way
> >to make that happen.  Hence my skepticism.  ;-)
> >
> >But *if* this was really needed, this looks to be a reasonable way to
> >implement it.
> >
> >							Thanx, Paul
> 
> >  kernel/rcu/tasks.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 469bf2a3b505..0237e765c28e 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -560,8 +560,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> >  static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
> >  {
> >  	/* Complain if the scheduler has not started.  */
> > -	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
> > -			 "synchronize_rcu_tasks called too soon");
> > +	if (WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
> > +			 "synchronize_rcu_tasks called too soon"))
> > +		return;
> >  
> >  	// If the grace-period kthread is running, use it.
> >  	if (READ_ONCE(rtp->kthread_ptr)) {
> > -- 
> > 2.25.1
> > 
