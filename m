Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A2553E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiFUWWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiFUWWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:22:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A5313A8;
        Tue, 21 Jun 2022 15:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFBBFB80F63;
        Tue, 21 Jun 2022 22:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9832C3411C;
        Tue, 21 Jun 2022 22:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655850150;
        bh=+LDrpMW5F5RDM2q1wns9vXxnEsqe5NQxpcRzI5APDKA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YwzDP11isyZc1xND9GaXPAtCehQu34skfBQgY0x8q2LePgl5JItSK+XpV98bgd9of
         gaYv8hAIdJo5Kx58pcY3pHlty18g5FF7Zkm2/27TXBc0qOhr4xtVN/6UjugHbvN44E
         PlyIjOPe/oVDLBOLakgtveLCn+tVTLSRgvjXJakdGMcOyxIv1hHphlNmaunTiliZxR
         urBq0ggdNVhdJT47OkvdpU9YvRPUyRUATf8hPJOitmqIsEEvAAcI4hdtV1plzdCvYl
         FDpks0RqdPdUlUx1g6PqCevAuokuh7BgQfRKAl/4il93UczFxzrTHj3AouSkS9qoRo
         3ANeAsj38rnPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B1A35C0AE0; Tue, 21 Jun 2022 15:22:30 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:22:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [PATCH rcu 03/12] rcu: Add rnp->cbovldmask check in
 rcutree_migrate_callbacks()
Message-ID: <20220621222230.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-3-paulmck@kernel.org>
 <0b503f77-1269-7fef-7c70-0e572f7e5907@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b503f77-1269-7fef-7c70-0e572f7e5907@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:27:28AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> > From: Zqiang <qiang1.zhang@intel.com>
> > 
> > Currently, the rcu_node structure's ->cbovlmask field is set in call_rcu()
> > when a given CPU is suffering from callback overload.  But if that CPU
> > goes offline, the outgoing CPU's callbacks is migrated to the running
> > CPU, which is likely to overload the running CPU.  However, that CPU's
> > bit in its leaf rcu_node structure's ->cbovlmask field remains zero.
> > 
> > Initially, this is OK because the outgoing CPU's bit remains set.
> > However, that bit will be cleared at the next end of a grace period,
> > at which time it is quite possible that the running CPU will still
> > be overloaded.  If the running CPU invokes call_rcu(), then overload
> > will be checked for and the bit will be set.  Except that there is no
> > guarantee that the running CPU will invoke call_rcu(), in which case the
> > next grace period will fail to take the running CPU's overload condition
> > into account.  Plus, because the bit is not set, the end of the grace
> > period won't check for overload on this CPU.
> > 
> > This commit therefore adds a call to check_cb_ovld_locked() in
> > check_cb_ovld_locked() to set the running CPU's ->cbovlmask bit
> 
> Nit: s/check_cb_ovld_locked/rcutree_migrate_callbacks/

Good catch, fixed!

> > appropriately.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> 
> Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Thank you, applied.

							Thanx, Paul

> Thanks
> Neeraj
> 
> >   kernel/rcu/tree.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c19d5926886fb..f4a37f2032664 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4491,6 +4491,7 @@ void rcutree_migrate_callbacks(int cpu)
> >   	needwake = needwake || rcu_advance_cbs(my_rnp, my_rdp);
> >   	rcu_segcblist_disable(&rdp->cblist);
> >   	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) != !rcu_segcblist_n_cbs(&my_rdp->cblist));
> > +	check_cb_ovld_locked(my_rdp, my_rnp);
> >   	if (rcu_rdp_is_offloaded(my_rdp)) {
> >   		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
> >   		__call_rcu_nocb_wake(my_rdp, true, flags);
