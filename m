Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF69464E43
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348428AbhLAM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhLAM6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:58:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B1FC061574;
        Wed,  1 Dec 2021 04:55:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6974B81EA9;
        Wed,  1 Dec 2021 12:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53E8C53FCC;
        Wed,  1 Dec 2021 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638363306;
        bh=pmKIfhrbcsA/n/M1SjDP4i44MGxZbrvPg+xuCfjviak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cZ6auHDW1ro+TA1+yR0PIuNfL2QgL8W1JMC4IJVqH06nbkmPcHZxmacHNbz/HOD48
         cBOJvcC6OCYYCr4g7SWrR7FwoLDQjiCv2Ie8JltHtQpGnLUUi6yhH+XwzX562lhlpm
         DCriXDJv7fZDrWN5+UNh2SXcG78mDMxS6tB3uUV0EPJTNxVGCULDU6tTzusuFKv15k
         cEZ6hWqzrwxjc9Gf4rdjPpm7mGrqeh5hryraRWkvNmLk0Lb25nnOBDHb4eMCNWJAxm
         rkgfN9pkDabZGV13Ab1vhul6UvdqeXuCAJMYj113s2yh5cht9r6NU9JzPSizFTyq4j
         xiks9f044vqCw==
Date:   Wed, 1 Dec 2021 13:55:02 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 1/6] rcu/nocb: Remove rdp from nocb list when de-offloaded
Message-ID: <20211201125502.GA628470@lothringen>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-2-frederic@kernel.org>
 <84ab6b4a-6fc4-be3f-d990-1f46265a46e6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ab6b4a-6fc4-be3f-d990-1f46265a46e6@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 02:55:16PM +0530, Neeraj Upadhyay wrote:
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 2461fe8d0c23..cc1165559177 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -625,7 +625,15 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >   	 * and the global grace-period kthread are awakened if needed.
> >   	 */
> >   	WARN_ON_ONCE(my_rdp->nocb_gp_rdp != my_rdp);
> > -	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
> > +	/*
> > +	 * An rdp can be removed from the list after being de-offloaded or added
> > +	 * to the list before being (re-)offloaded. If the below loop happens while
> > +	 * an rdp is de-offloaded and then re-offloaded shortly afterward, we may
> > +	 * shortcut and ignore a part of the rdp list due to racy list iteration.
> > +	 * Fortunately a new run through the entire loop is forced after an rdp is
> > +	 * added here so that such race get quickly fixed.
> > +	 */
> > +	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
> 
> Can we hit a (unlikely) case where repeated calls to de-offload/offload
> cause this loop to continue for long time?

Probably not, I guess the only situation for that to happen would be:

	 DEOFFLOAD rdp 0
	 OFFLOAD rdp 0
 	 DEOFFLOAD rdp 1
	 OFFLOAD rdp 1
 	 DEOFFLOAD rdp 2
	 OFFLOAD rdp 2
	 etc...

But even then you'd need a very bad luck.

> 
> 
> >   		bool needwake_state = false;
> >   		if (!nocb_gp_enabled_cb(rdp))
> 
> Now that we can probe flags here, without holding the nocb_gp_lock first (
> the case where de-offload and offload happens while we are iterating the
> list); can it cause a WARNING from below code?
> 
> 
> 	WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
> 	rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
> 
> The sequence like this is possible?
> 
> 1. <de-offload>
>     Clear SEGCBLIST_OFFLOADED
> 2. nocb_gp_wait() clears SEGCBLIST_KTHREAD_GP in
> nocb_gp_update_state_deoffloading() and continues to next rdp.
> 3. <offload>
>     rdp_offload_toggle() hasn't been called yet.
> 4. rcuog thread migrates to different CPU, while executing the
> loop in nocb_gp_wait().
> 5. nocb_gp_wait() reaches the tail rdp.
> 6. Current CPU , where  rcog thread is running hasn't observed
> SEGCBLIST_OFFLOADED clearing done in step 1; so, nocb_gp_enabled_cb()
> passes.

This shouldn't happen. If a task migrates from CPU X to CPU Y, CPU Y is
guaranteed to see what CPU X saw due to scheduler ordering.

But you have a good point that checking those flags outside the nocb lock
is asking for trouble. It used to be an optimization but now that the rdp
entries are removed when they are not needed anymore, we should probably
lock unconditionally before the call to nocb_gp_enabled_cb().

Thanks.

> 7. nocb_gp_wait() acquires the rdp's nocb lock and read the state to
> be deoffloaded; however, SEGCBLIST_KTHREAD_GP is not set and
> we hit WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist,
> SEGCBLIST_KTHREAD_GP));
> 
> Thanks
> Neeraj
