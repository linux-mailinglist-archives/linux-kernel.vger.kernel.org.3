Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3347C4D1FDF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349449AbiCHSO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbiCHSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:14:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7BF424B8;
        Tue,  8 Mar 2022 10:13:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54E01B818A0;
        Tue,  8 Mar 2022 18:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED91CC340EB;
        Tue,  8 Mar 2022 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646763236;
        bh=utWdFLKhIY9H7mCT5rLTLSg7JMStuWY6SjN2JIaKlVY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=shOITVqGGgNqINBi9zc5HslKM4Y8NOHES1H3f6bMlYNGCChX94dzTRc+j3+IdjOOD
         BY5p7Ej0E/mKJgfpgVokRGWMLsCuadsqJSTLBVqdvsc7hlJ+wWPsXX/75Hj9Y7wits
         LgyrScl08vuechGdexgJy7Nra2pADNgDbzcO3kyriIiBSnu0uT90gDMn+dRJR85hfD
         95zQDbuQqnrbuKvib1sqv2X1AfLMUHhrHPsEk0i33CTSsuzj0pcW04xhU86pnN0qL1
         z1YU0BSs5C/JZGw3do8AHnq1fe34+zDxQ0kWTfwDyyr373yX4VVos516AuUzZXzHl7
         cWVjkGYAp1G9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 934F85C08A0; Tue,  8 Mar 2022 10:13:55 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:13:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com
Subject: Re: [PATCH] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Message-ID: <20220308181355.GW4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220304092631.4123188-1-qiang1.zhang@intel.com>
 <81f69dd4-6ca9-760c-bec5-5cb27afbe788@quicinc.com>
 <PH0PR11MB5880026EBBE3E195549E2245DA089@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220307191512.GN4285@paulmck-ThinkPad-P17-Gen-1>
 <YieapfzKvy2chaHT@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YieapfzKvy2chaHT@pc638.lan>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 07:04:21PM +0100, Uladzislau Rezki wrote:
> > On Mon, Mar 07, 2022 at 02:03:17AM +0000, Zhang, Qiang1 wrote:
> > > On 3/4/2022 2:56 PM, Zqiang wrote:
> > > > When RCU_BOOST is enabled, the boost kthreads will boosting readers
> > > > who are blocking a given grace period, if the current reader tasks
> > > > have a higher priority than boost kthreads(the boost kthreads priority
> > > > not always 1, if the kthread_prio is set), boosting is useless, skip
> > > > current task and select next task to boosting, reduce the time for a
> > > > given grace period.
> > > > 
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > 
> > Adding to CC to get more eyes on this.  I am not necessarily opposed to
> > it, but I don't do that much RT work myself these days.
> > 
> > 							Thanx, Paul
> > 
> > > > ---
> > > >   kernel/rcu/tree_plugin.h | 10 +++++++++-
> > > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > > index c3d212bc5338..d35b6da66bbd 100644
> > > > --- a/kernel/rcu/tree_plugin.h
> > > > +++ b/kernel/rcu/tree_plugin.h
> > > > @@ -12,6 +12,7 @@
> > > >    */
> > > >   
> > > >   #include "../locking/rtmutex_common.h"
> > > > +#include <linux/sched/deadline.h>
> > > >   
> > > >   static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> > > >   {
> > > > @@ -1065,13 +1066,20 @@ static int rcu_boost(struct rcu_node *rnp)
> > > >   	 * section.
> > > >   	 */
> > > >   	t = container_of(tb, struct task_struct, rcu_node_entry);
> > > > +	if (!rnp->exp_tasks && (dl_task(t) || t->prio <= current->prio)) {
> > > > +		tb = rcu_next_node_entry(t, rnp);
> > > > +		WRITE_ONCE(rnp->boost_tasks, tb);
> > > > +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > > +		goto end;
> > > > +	}
> > > > +
> Why do you bypass the expedited grace period and boost any tasks anyway?
> Same way the expedited gp can be blocked by higher prior tasks SCHED_DEADLINE
> or SCHED_FIFO.

Just to make sure that I understand...

Are you pointing out that a SCHED_DEADLINE task might have exhausted
its budget, so that boosting might nonetheless be helpful?

Me, I honestly don't know what happens in that case, so I am just asking
the question.  And adding Juri on CC.  ;-)

							Thanx, Paul
