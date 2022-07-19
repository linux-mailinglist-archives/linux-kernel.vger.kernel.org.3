Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3757A206
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbiGSOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239645AbiGSOlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA08A40BF6;
        Tue, 19 Jul 2022 07:38:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3701B617DA;
        Tue, 19 Jul 2022 14:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D190C341CB;
        Tue, 19 Jul 2022 14:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658241511;
        bh=pGf1YmN+o/VpKXgM03koQq4c5xvoYJDJMg48G91Fs5A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mauTgrih6Ao+I8qPQF/CnqucCGeA9rOuIh7GuSnMETgQ7UqsGeI921C1ASGNR6K3W
         nMQuQvS+07b+gyeVTVbiqVoUwnKBeLi0iJsslde8RQSEI3GXLtmUgNU8lqQBoJduM4
         cvulXe7PXF/kcfqk6jZ65IWz+ODz5BolKky64zY2nPWtuzSTRgDxyROF0Y00BSB8XP
         OdeZZqRpfKYJ06sW0ZhzOktJlKzH9fBNYV0pvQXa1CLgZSpu1vmKKT1UaqypmefqUw
         7ONoJona0VYF/igaLoHNCOT9Z13QasZTLtwsmMSg1wRMgqHlmrPMTgp+IM6GO2FSYP
         /lGCr3cJX9nYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DFC8C5C0813; Tue, 19 Jul 2022 07:38:30 -0700 (PDT)
Date:   Tue, 19 Jul 2022 07:38:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rcu-tasks: Make RCU Tasks Trace checking for
 userspace execution
Message-ID: <20220719143830.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220718001610.263700-1-qiang1.zhang@intel.com>
 <20220718152132.GE1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58805ADED62CE2AF94647967DA8C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220719002604.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880375F53618C19D944EB06DA8F9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB5880375F53618C19D944EB06DA8F9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:34:58AM +0000, Zhang, Qiang1 wrote:
> On Mon, Jul 18, 2022 at 11:54:53PM +0000, Zhang, Qiang1 wrote:
> > On Mon, Jul 18, 2022 at 08:16:10AM +0800, Zqiang wrote:
> > > For RCU tasks trace, the userspace execution is also a valid 
> > > quiescent state, if the task is in userspace, the 
> > > ->trc_reader_nesting should be zero and if the 
> > > ->trc_reader_special.b.need_qs is not set, set the tasks 
> > > ->trc_reader_special.b.need_qs is TRC_NEED_QS_CHECKED, this cause grace-period kthread remove it from holdout list if it remains here.
> > > 
> > > This commit add rcu_tasks_trace_qs() to rcu_flavor_sched_clock_irq() 
> > > when the kernel built with no PREEMPT_RCU.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >The looks plausible to me, but can you tell me how this avoids the 
> > >following sequence of events?
> > >
> > >o	CPU 0 takes a scheduling-clock interrupt.  Just before this
> > >	point CPU 0 was running in user context, thus as you say
> > >	should not be in an RCU Tasks quiescent state.
> > >
> > >o	CPU 0 enters an RCU Tasks Trace read-side critical section.
> >                
> >  if I understand correctly, you mean that CPU0 enters an RCU Tasks 
> > Trace  read-side critical section in scheduling-clock interrupt context.
> >
> >Exactly, as might happen if one of the functions in the scheduling-clock interrupt hander were traced/instrumented.
> >
> > >o	CPU 1 starts a new RCU Tasks Trace grace period.
> > 
> > The grace period kthread will scan running tasks on each CPU, The 
> > tasks currently running on CPU0 will be recorded in the holdout list.
> >
> >Yes, very good.
> >
> > >o	CPU 0 reaches the newly added rcu_note_voluntary_context_switch().
> > 
> > In this time, if CPU0 still in RCU Tasks Trace read-side critical 
> > section, the tasks which running on CPU0 will insert CPU0 blocked 
> > list. when this tasks exit RCU Tasks Trace read-side critical section, this task will remove from CPU0 block list.
> > 
> > Did I understand the scenario described above correctly?
> >
> >Looks like it to me.
> >
> >Could you please resend the patch with this explained in the commit log?  Possibly for the benefit of your future self.  ;-)
> >
> 
> Hi Paul, 
> 
> I have resent v3 again, but maybe still need your wording 😊.

I do see both copies, thank you.  And yes, I am deferring the wordsmithing
to  a time when I am awake.  ;-)

							Thanx, Paul

> Thanks
> Zqiang
> 
> >							Thanx, Paul
> >
> > Thanks
> > Zqiang
> > 
> > >
> > >	Except that the quiescent state implied by userspace execution
> > >	was before the new grace period, and thus does not apply to it.
> > >
> > >(Yes, I know, if this is a bug in this patch, the bug already exists 
> > >due to the call in rcu_flavor_sched_clock_irq() for !PREEMPT kernels, 
> > >but if this change is safe, it should be possible to explain why.)
> > >
> > >							Thanx, Paul
> > >
> > > ---
> > >  v1->v2:
> > >  Fix build error due to undeclared rcu_tasks_trace_qs(), note in 
> > > no-PREEMPT_RCU  kernel, the RCU Tasks is replaced by RCU, so 
> > > rcu_note_voluntary_context_switch()
> > >  only include rcu_tasks_trace_qs().
> > > 
> > >  kernel/rcu/tree_plugin.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h 
> > > index 4152816dd29f..5fb0b2dd24fd 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -976,7 +976,7 @@ static void rcu_flavor_sched_clock_irq(int user)
> > >  		 * neither access nor modify, at least not while the
> > >  		 * corresponding CPU is online.
> > >  		 */
> > > -
> > > +		rcu_note_voluntary_context_switch(current);
> > >  		rcu_qs();
> > >  	}
> > >  }
> > > --
> > > 2.25.1
> > > 
