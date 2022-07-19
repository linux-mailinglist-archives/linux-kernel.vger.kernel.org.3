Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57349578F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiGSA0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiGSA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:26:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D2A33E3E;
        Mon, 18 Jul 2022 17:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4B7615F2;
        Tue, 19 Jul 2022 00:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84B8C341CA;
        Tue, 19 Jul 2022 00:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658190364;
        bh=g57rRM5qayf+HbUqWmyaj2hyK8CHEC1BKZBGNCwrYm0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LNgst9mKG0W6gwKI76XymhMD0t4/CU49VAObkFntA1YNJte/qxVcH/CVBa4aIEcj/
         KKJCjhTupwm55FURGPv4X4QEIft3mJEH4qNvaD2el+yavD9n79xBeY1jDKx8lqIU+J
         WdLoCXXQku5Ky3VDK8sdi0yTwt8+JNqOqtzijbGnRUO2vCSl07d6UPNgEiL0VOm7dl
         5slPEasg1WzlhB7lfWcTbCzYJlM+nHETh6rgrP47W0Ihd1IN7S/L08xfRoJqwRG6jK
         vCpGe2/LktEqSFng5nor91Vg4YG+imJAVQbuz2w2kUthrTVEy8B1tCapX9j8lwRuaT
         A8ToTQbf1Wczw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 437BF5C04D0; Mon, 18 Jul 2022 17:26:04 -0700 (PDT)
Date:   Mon, 18 Jul 2022 17:26:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu-tasks: Make RCU Tasks Trace checking for
 userspace execution
Message-ID: <20220719002604.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220718001610.263700-1-qiang1.zhang@intel.com>
 <20220718152132.GE1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58805ADED62CE2AF94647967DA8C9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58805ADED62CE2AF94647967DA8C9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 11:54:53PM +0000, Zhang, Qiang1 wrote:
> On Mon, Jul 18, 2022 at 08:16:10AM +0800, Zqiang wrote:
> > For RCU tasks trace, the userspace execution is also a valid quiescent
> > state, if the task is in userspace, the ->trc_reader_nesting should be
> > zero and if the ->trc_reader_special.b.need_qs is not set, set the
> > tasks ->trc_reader_special.b.need_qs is TRC_NEED_QS_CHECKED, this cause
> > grace-period kthread remove it from holdout list if it remains here.
> > 
> > This commit add rcu_tasks_trace_qs() to rcu_flavor_sched_clock_irq()
> > when the kernel built with no PREEMPT_RCU.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >The looks plausible to me, but can you tell me how this avoids the
> >following sequence of events?
> >
> >o	CPU 0 takes a scheduling-clock interrupt.  Just before this
> >	point CPU 0 was running in user context, thus as you say
> >	should not be in an RCU Tasks quiescent state.
> >
> >o	CPU 0 enters an RCU Tasks Trace read-side critical section.
>                
>  if I understand correctly, you mean that CPU0 enters an RCU Tasks Trace
>  read-side critical section in scheduling-clock interrupt context.

Exactly, as might happen if one of the functions in the scheduling-clock
interrupt hander were traced/instrumented.

> >o	CPU 1 starts a new RCU Tasks Trace grace period.
> 
> The grace period kthread will scan running tasks on each CPU, 
> The tasks currently running on CPU0 will be recorded in the holdout list.

Yes, very good.

> >o	CPU 0 reaches the newly added rcu_note_voluntary_context_switch().
> 
> In this time, if CPU0 still in RCU Tasks Trace read-side critical section, the tasks
> which running on CPU0 will insert CPU0 blocked list. when this tasks exit 
> RCU Tasks Trace read-side critical section, this task will remove from CPU0 block list.
> 
> Did I understand the scenario described above correctly?

Looks like it to me.

Could you please resend the patch with this explained in the commit
log?  Possibly for the benefit of your future self.  ;-)

							Thanx, Paul

> Thanks
> Zqiang
> 
> >
> >	Except that the quiescent state implied by userspace execution
> >	was before the new grace period, and thus does not apply to it.
> >
> >(Yes, I know, if this is a bug in this patch, the bug already exists
> >due to the call in rcu_flavor_sched_clock_irq() for !PREEMPT kernels,
> >but if this change is safe, it should be possible to explain why.)
> >
> >							Thanx, Paul
> >
> > ---
> >  v1->v2:
> >  Fix build error due to undeclared rcu_tasks_trace_qs(), note in no-PREEMPT_RCU
> >  kernel, the RCU Tasks is replaced by RCU, so rcu_note_voluntary_context_switch()
> >  only include rcu_tasks_trace_qs().
> > 
> >  kernel/rcu/tree_plugin.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 4152816dd29f..5fb0b2dd24fd 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -976,7 +976,7 @@ static void rcu_flavor_sched_clock_irq(int user)
> >  		 * neither access nor modify, at least not while the
> >  		 * corresponding CPU is online.
> >  		 */
> > -
> > +		rcu_note_voluntary_context_switch(current);
> >  		rcu_qs();
> >  	}
> >  }
> > -- 
> > 2.25.1
> > 
