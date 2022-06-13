Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06EA54A2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 01:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiFMXiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 19:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiFMXh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:37:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CEF2CE1E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 16:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2683AB81141
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3E7C34114;
        Mon, 13 Jun 2022 23:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655163473;
        bh=vuXGxZZ88TW14WVzxq5CMsRe0jE/E6Zf1LdRz8XhWdI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r/Wspq9BOtpSHdmFtE5IEVuCjQdr89DIbK/UePgGUXsDP90qOsAIPYjZ8MvorhljE
         iyZ/v3Nf0Xd0Z8hnFlOj35ZEGZ7lVUcZqVqZ2YukWdeQ7nnk+634oVYoV7luEkyMNM
         UumX5L02+aJS5C+o+YiX6EvBYZNtGdvcfrvRH07mmbFCpJT2bFhM5vADLpUub8ShSq
         jlBS+i6RoEpnj0e6bOwarICY/uRRs+S0q96cqyDdwOkDd7Lgzqj/WsM3yve7BAmvgq
         Wic68CC4Zfgjj0Gx3v9ogr5ZN6ewdXBonyfXtdhqAn8O0KIGBsFLUew95MEY2H+0Sf
         mR+IzXqMuv2jg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3D1C65C02F9; Mon, 13 Jun 2022 16:37:53 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:37:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING in exit_tasks_rcu_finish
Message-ID: <20220613233753.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <000000000000e2fc3f05e141f930@google.com>
 <87bkux1yn4.fsf@email.froward.int.ebiederm.org>
 <20220612202204.GX1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588027C1A486FCED7885C500DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220613152337.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880EB4D4F2B7D91C88BC852DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880EB4D4F2B7D91C88BC852DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:26:47PM +0000, Zhang, Qiang1 wrote:
> On Mon, Jun 13, 2022 at 01:55:31PM +0000, Zhang, Qiang1 wrote:
> > > syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com> writes:
> > > 
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    6d0c80680317 Add linux-next specific files for 20220610
> > > > git tree:       linux-next
> > > > console output: 
> > > > https://syzkaller.appspot.com/x/log.txt?x=13b52c2ff00000
> > > > kernel config:  
> > > > https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > I don't understand what is going on in linux-next kernel/rcu/tasks.h 
> > > looks different than in Linus's tree.  Paul does that mean you have 
> > > some staged rcu changes?
> > 
> > >Less than 100 RCU-related patches in -rcu, so not all that bad.  ;-)
> > >
> > >But yes, this could possibly be an issue in one of those patches.
> > 
> > > Eric
> > > 
> > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664 
> > > > exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
> > > > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664
> > > > exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
> > 
> > >The usual way for this warning to trigger is for these a task to exit while in an RCU Tasks Trace read-side critical section:
> > >
> > >	rcu_read_lock_trace();
> > >	do_something_that_causes_task_exit();
> > >
> > 
> > Hi Paul, wether the following scenarios be considered
> > 
> > rcu_read_unlock_trace_special
> >    ->if (trs.b.blocked)
> >        ->raw_spin_lock_irqsave_rcu_node
> >        ->list_del_init(&t->trc_blkd_node)
> >        ->WRITE_ONCE(t->trc_reader_special.b.blocked, false)
> >        ->raw_spin_unlock_irqrestore_rcu_node
> >                      ->Inerrrupt
> >                             ->schedule
> >                                 ->rcu_note_context_switch
> >                                     ->rcu_tasks_trace_qs
> >                                          If (___rttq_nesting && !READ_ONCE((t)->trc_reader_special.b.blocked) 
> >                                                         /*___rttq_nesting  ==1    &&  (t)->trc_reader_special.b.blocked =false*/
> > 				rcu_tasks_trace_qs_blkd(t)     
> >    ->WRITE_ONCE(t->trc_reader_nesting, 0)
> >     .......
> >    -> exit_tasks_rcu_finish
> > 
> > Whether the following patch can fix it, or what am I missing?
> > Any thoughts?
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index 
> > f1209ce621c5..c607e4c914d3 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1247,6 +1247,7 @@ void rcu_read_unlock_trace_special(struct task_struct *t)
> >         struct rcu_tasks_percpu *rtpcp;
> >         union rcu_special trs;
> > 
> > +       WRITE_ONCE(t->trc_reader_nesting, 0);
> >         // Open-coded full-word version of rcu_ld_need_qs().
> >         smp_mb(); // Enforce full grace-period ordering.
> >         trs = smp_load_acquire(&t->trc_reader_special);
> > @@ -1267,7 +1268,6 @@ void rcu_read_unlock_trace_special(struct task_struct *t)
> >                 WRITE_ONCE(t->trc_reader_special.b.blocked, false);
> >                 raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> >         }
> > -       WRITE_ONCE(t->trc_reader_nesting, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
> 
> >Thank you for looking into this!
> >
> >You do have what I believe to be the correct failure scenario, but the above fix would break nested RCU Tasks Trace read-side critical sections.
> 
> Hi Paul
> 
> Break nested RCU Tasks Trace read-side critical sections?  
> Does it mean the following?
> 
> rcu_read_unlock_trace
>     -> WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
>          /* t->trc_reader_special.s  == 0*/
>     -> if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting)
>           -> Interrupt
>               -> schedule
>                  -> rcu_note_context_switch
>                      -> rcu_tasks_trace_qs
>                               /*___rttq_nesting  == INT_MIN    &&  (t)->trc_reader_special.b.blocked == false*/
>                           ->rcu_tasks_trace_qs_blkd(t)     
>              /*nesting == 0*/
>          -> WRITE_ONCE(t->trc_reader_nesting, nesting);
>          -> return;
>  .........
>  exit_tasks_rcu_finish
>      trigger Warnings
> 
> Or where am I misunderstanding?

I suspect that you do in fact understand it.  Let's walk through the
failure scenario again and see.

If that READ_ONCE(t->trc_reader_special.s) return zero as you suggest,
and then the interrupt and schedule happen as you suggest, then
rcu_tasks_trace_qs_blkd() will see a non-zero ->trc_reader_nesting and
a zero .b.blocked.  It queues the task, but rcu_read_unlock_trace()
won't check again.  It will set ->trc_reader_nesting to zero and
continue.  As you noted, if the task exits in that state, then
exit_tasks_rcu_finish_trace() will trigger its WARN_ON_ONCE().

Your change won't affect this because rcu_read_unlock_trace_special()
never gets called.

Hence the approach in the patch below.

Do you see any failure modes given the below patch?

> Thanks
> Zqiang
> 
> >
> >But would you be willing to try out the patch shown below?
> 
> I will try to test it.

Thank you very much!

						Thanx, Paul

> >------------------------------------------------------------------------
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h index 08059d8d4f5a7..937a58b3266bf 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -184,7 +184,7 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
>  		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
>  		    likely(!___rttq_nesting)) {					\
>  			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
> -		} else if (___rttq_nesting &&					\
> +		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
>  			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
>  			rcu_tasks_trace_qs_blkd(t);				\
>  		}								\
> diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h index 6f9c358173989..9bc8cbb33340b 100644
> --- a/include/linux/rcupdate_trace.h
> +++ b/include/linux/rcupdate_trace.h
> @@ -75,7 +75,7 @@ static inline void rcu_read_unlock_trace(void)
>  	nesting = READ_ONCE(t->trc_reader_nesting) - 1;
>  	barrier(); // Critical section before disabling.
>  	// Disable IPI-based setting of .need_qs.
> -	WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
> +	WRITE_ONCE(t->trc_reader_nesting, INT_MIN + nesting);
>  	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
>  		WRITE_ONCE(t->trc_reader_nesting, nesting);
>  		return;  // We assume shallow reader nesting.
