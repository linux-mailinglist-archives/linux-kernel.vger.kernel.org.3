Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E497855B255
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiFZNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 09:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiFZNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 09:52:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F3D101F5;
        Sun, 26 Jun 2022 06:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B062CE1012;
        Sun, 26 Jun 2022 13:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00EAC34114;
        Sun, 26 Jun 2022 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656251560;
        bh=4ULNrqMWCIKDAsuyKVrcTubv6ihbqmGy0Zneh62+Nzk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JyKCKixIS/rZt8Wjmd5UkfC0hIdtRN/6ofNYSnOk1NrKxe6As4irwYsvEXykuAPhU
         GyAp9jybiCa0CkFPop5ZtCUn7v9m+EInYePcHKqsrjpff8iiHBAwY6V0QZkpdJewWS
         OA2e+9hFo1FSkvdE81KoGNNSfDmc1eFZQgocfjV9XfBgoAAdWs45jdaxgkEieOEtHo
         hhTH7nZiPHIWalLB1G3o+UVLha0sEsHYHcxvHMCYOUsBW1cUHllwWw8qgCppEsK07P
         V1nAsGgsOafrlBOFlmMMwoWpq9HEExq2Xb3ijNcRCsL2VAhMGtwNwr3s1XT7ULwjlT
         zWvuwJ7Dwmyaw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 681025C098A; Sun, 26 Jun 2022 06:52:40 -0700 (PDT)
Date:   Sun, 26 Jun 2022 06:52:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 5/8] rcu/nocb: Wake up gp thread when flushing
Message-ID: <20220626135240.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-7-joel@joelfernandes.org>
 <20220626040622.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yrhi/Jwm0eLmDIGb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrhi/Jwm0eLmDIGb@google.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 01:45:32PM +0000, Joel Fernandes wrote:
> On Sat, Jun 25, 2022 at 09:06:22PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 22, 2022 at 10:50:59PM +0000, Joel Fernandes (Google) wrote:
> > > We notice that rcu_barrier() can take a really long time. It appears
> > > that this can happen when all CBs are lazy and the timer does not fire
> > > yet. So after flushing, nothing wakes up GP thread. This patch forces
> > > GP thread to wake when bypass flushing happens, this fixes the
> > > rcu_barrier() delays with lazy CBs.
> > 
> > I am wondering if there is a bug in non-rcu_barrier() lazy callback
> > processing hiding here as well?
> 
> I don't think so because in both nocb_try_bypass and nocb_gp_wait, we are not
> going to an indefinite sleep after the flush. However, with rcu_barrier() ,
> there is nothing to keep the RCU GP thread awake. That's my theory at least.
> In practice, I have not been able to reproduce this issue with
> non-rcu_barrier().
> 
> With rcu_barrier() I happen to hit it thanks to the rcuscale changes I did.
> That's an interesting story! As I apply call_rcu_lazy() to the file table
> code, turns out that on boot, the initram unpacking code continously triggers
> call_rcu_lazy(). This happens apparently in a different thread than the one
> that rcuscale is running in. In rcuscale, I did rcu_barrier() at init time
> and this stalled for a long time to my surprise, and this patch fixed it.

Cool!

Then should this wake_nocb_gp() instead go into the rcu_barrier()
code path?  As shown below, wouldn't we be doing some spurious wakeups?

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree_nocb.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 2f5da12811a5..b481f1ea57c0 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -325,6 +325,8 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > >  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
> > >  	WRITE_ONCE(rdp->nocb_bypass_first, j);
> > >  	rcu_nocb_bypass_unlock(rdp);
> > > +
> > > +	wake_nocb_gp(rdp, true);
> > >  	return true;
> > >  }
> > >  
> > > -- 
> > > 2.37.0.rc0.104.g0611611a94-goog
> > > 
