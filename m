Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7682A4EE19B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbiCaT0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbiCaT0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0E4985BD;
        Thu, 31 Mar 2022 12:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95093619B9;
        Thu, 31 Mar 2022 19:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81E0C340ED;
        Thu, 31 Mar 2022 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648754687;
        bh=2YLPnxnGGpnjAUfupvEro5SVvRCj9YJPBfUDltAJqIw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YyZ/5YPVjV0rxlrttmzBoDbSLVuXSYsZtrLHE/H4kKcjAh/WSG13LEndwH0arm1VC
         1tYjb0GGoALQmOt03LB5eAvZIXe9W8jd6zAXPHJ1DppITqcQm/h2Lpe4Ri8Afae3bT
         4bpna44e+/OBKfTKtWA7k3DdKXNWIvR+hkJmhUgQNKrWq+hO8KMdTqqdN77lEexyC4
         PRflvcrV1sh+zvh5tS7/vO1Wm7mgOSPJIXAy5FVv+Auosw0BwUi2tAZk5yK9vztyVQ
         +oT+NMveHAiAbCF4el9ELzPrpyryeOCXtRqilUzF2MbqLXyqoD50PlKBvio7xvUh1f
         U7tSEYe9LfMiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6E28C5C0A0E; Thu, 31 Mar 2022 12:24:46 -0700 (PDT)
Date:   Thu, 31 Mar 2022 12:24:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu-tasks: Check the atomic variable
 trc_n_readers_need_end again when wait timeout
Message-ID: <20220331192446.GW4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220330112014.2587148-1-qiang1.zhang@intel.com>
 <20220330190556.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880D6B11469266144C58032DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <MW5PR11MB58585FA7332315F46FA36CD0DAE19@MW5PR11MB5858.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB58585FA7332315F46FA36CD0DAE19@MW5PR11MB5858.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 02:03:26AM +0000, Zhang, Qiang1 wrote:
> 
> On Wed, Mar 30, 2022 at 07:20:14PM +0800, Zqiang wrote:
> > When the trc_wait waitqueue timeout, the atomic variable 
> > trc_n_readers_need_end need to be checked again, perhaps the 
> > conditions have been established at this time, avoid invalid stall 
> > information output.
> >
> >But are you actually seeing this invalid stall information?  Either way, please seem my comments and question below.
> >
> >Please don't get me wrong, we do have similar checks for normal vanilla RCU stall warnings, for example, this statement in print_other_cpu_stall() in kernel/rcu/tree_stall.h:
> >
> >	pr_err("INFO: Stall ended before state dump start\n");
> >
> >However, the approach used there did benefit from significant 
> >real-world experience with its absence.  ;-)
> >
> >							Thanx, Paul
> >
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tasks.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index 
> > 65d6e21a607a..b73a2b362d6b 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1544,7 +1544,7 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
> >  				trc_wait,
> >  				atomic_read(&trc_n_readers_need_end) == 0,
> >  				READ_ONCE(rcu_task_stall_timeout));
> 
> >If I understand correctly, this patch is intended to handle a situation where the wait_event_idle_exclusive_timeout() timed out, but where the value of trc_n_readers_need_end decreased to zero just at this point.
> >>
> >>Yes,  this patch is intended to handle a situation.
> 
> >If so, please see my question below.  If not, please show me the exact sequence of events leading up to the problem.
> 
> > -		if (ret)
> > +		if (ret || !atomic_read(&trc_n_readers_need_end))
> >  			break;  // Count reached zero.
> 
> >Couldn't the value of trc_n_readers_need_end decrease to zero right here, still resulting in invalid stall information?
> >
> >>The value of trc_n_readers_need_end decrease to zero right here, indicates that the current grace period has been completed.
> >>Even if we go to print some task with condition 't->trc_reader_special.b.need_qs' as true,  and these task  will not affect the current grace period. Is my understanding correct?
> >>
> 
> Is my commit  information not clear? Is this description more clearly
> 
> When the wait_event_idle_exclusive_timeout() timed out, if the value of
> trc_n_readers_need_end  decrease to zero just at this point
> this indicates that the current grace period is just completed at this point,
> direct break  and  avoid printing stall information.

Lack of clarity is not the problem.  The problem is instead lack of
justification.  My questions were intended to help you understand how
best to justify this sort of change, and also to help you determine on
your own whether or not future changes can be justified.

Please keep in mind that we reach that code when the grace period has
been stalled for ten full -minutes-.  If the system has 64 CPUs, this
means that the interarrival rate of decrements to trc_n_readers_need_end
is roughly 0.1 per second.  The time between the wakeup-timeout test of
trc_n_readers_need_end and the "if (ret)" will normally be small numbers
of microseconds, let's say ten of them.  The probability of this change
making any difference is therefore on the order of one in a million.

And the next step is to traverse the entire tasks list, which could take
quite a few milliseconds.  So there is is something like 1000 times more
likely that the value of trc_n_readers_need_end will change in that loop
than before the "if (ret)" check.

Therefore, I am having a very hard time believing that this change
is worthwhile.

My turn.  Is this explanation clear?  ;-)

							Thanx, Paul

> >>Thanks
> >>Zqiang
> 
> >  		// Stall warning time, so make a list of the offenders.
> >  		rcu_read_lock();
> > --
> > 2.25.1
> > 
