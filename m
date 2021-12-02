Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1E046699B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376553AbhLBSOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbhLBSOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:14:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF50DC06174A;
        Thu,  2 Dec 2021 10:10:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CEB662775;
        Thu,  2 Dec 2021 18:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB81C00446;
        Thu,  2 Dec 2021 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638468643;
        bh=CkCfHiYoyPWJgpr/6rkRitpkFqNjSvuV+yEJkRwlAwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXoZFUbn3LP33RkEdVB9vNcTxzdb83ZUnPL14JSUUx5n8QE8cOtg6FB0aJj2HhmnB
         DzMzedYV4DAcnadWLkRwcOqvL8jj/kJb/7ETLntynpPBI+sH2AZboU9WGN1hoq9BFZ
         3am1W5yc11pO29PcpwfljNmegTPy5WImKDamTsQou6lfXqx2Ll6t9ws+qSwZ3qkg+H
         UUGTFn9KrB4bajXhxA7h4bXQBFN29dFrDTR+djXI/bBKKscpS1HKHN61EuJUz7u9Gi
         knL3/ZsQ0IuR6t3/THxlFrsmLfVzOO3n2sx28dfdsGiqx2k99iKG7Xf9iHB/gDzVyL
         5BqIWTOO16M+Q==
Date:   Thu, 2 Dec 2021 19:10:39 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/6] rcu/nocb: Optimize kthreads and rdp initialization
Message-ID: <20211202181039.GD648659@lothringen>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-4-frederic@kernel.org>
 <20211125003026.GT641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125003026.GT641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:30:26PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 23, 2021 at 01:37:05AM +0100, Frederic Weisbecker wrote:
> > Currently cpumask_available() is used to prevent from unwanted
> > NOCB initialization. However if neither "rcu_nocbs=" nor "nohz_full="
> > parameters are passed but CONFIG_CPUMASK_OFFSTACK=n, the initialization
> > path is still taken, running through all sorts of needless operations
> > and iterations on an empty cpumask.
> > 
> > Fix this with relying on a real initialization state instead. This
> > also optimize kthreads creation, sparing iteration over all online CPUs
> > when nocb isn't initialized.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree_nocb.h | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index e1cb06840454..d8ed3ee47a67 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -60,6 +60,9 @@ static inline bool rcu_current_is_nocb_kthread(struct rcu_data *rdp)
> >   * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
> >   * If the list is invalid, a warning is emitted and all CPUs are offloaded.
> >   */
> > +
> > +static bool rcu_nocb_is_setup;
> 
> I am taking this as is for now (modulo wordsmithing), but should this
> variable instead be in the rcu_state structure?  The advantage of putting
> it there is keeping the state together.  The corresponding disadvantage
> is that the state is globally visible within RCU.
> 
> Thoughts?

Yes good point, will do!

Thanks!
