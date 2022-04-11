Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378604FC119
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348097AbiDKPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbiDKPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:43:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA713A727;
        Mon, 11 Apr 2022 08:41:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F30FFB816C8;
        Mon, 11 Apr 2022 15:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C66DC385A9;
        Mon, 11 Apr 2022 15:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649691669;
        bh=npFtzkXL9USbwxc64uUOhv5ZdsUEMzFWqJDnGZ7iBGw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HH3/N7+vsaNjto7aVHZmveOHTYoh/M8ahb1OZiT0kA6zuSWE8N+vITBUo2NMABJsD
         3guCebWhcV7Ppvw3uSR5E4yg/1UiQRKpZJZeUTzi9F8MYkBoNiwWejcsZUP0DhHIZi
         nudCOsM0n/EK3PR+7R16NBa4MWHQgvU2lFcKoBf10SDCRX8CNDF8GNGNZJfVwTYKZF
         WCfAqeG9UrTaP7vMnLHl7Fhoe8r7C6BK8Ha6pFFGzNnJMnSLYpLKZgtnByPfwYvVaz
         Llzs5E+O0fSczABA8nHpn3l7fbXFAvj/jtuaP/gZ8qed9FW4c4pu0t8imDp78W0ohn
         DRGeuwpqOEUVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F9165C03AE; Mon, 11 Apr 2022 08:41:09 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:41:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220407210734.2548973-1-joel@joelfernandes.org>
 <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
 <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:17:02AM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Fri, Apr 8, 2022 at 4:54 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > > > > > > > And is it really all -that- hard to specify an additional boot parameter
> > > > > > > > > across ChromeOS devices?  Android seems to manage it.  ;-)
> > > > > > > >
> > > > > > > > That's not the hard part I think. The hard part is to make sure a
> > > > > > > > future Linux user who is not an RCU expert does not forget to turn it
> > > > > > > > on. ChromeOS is not the only OS that I've seen someone forget to do it
> > > > > > > > ;-D. AFAIR, there were Android devices too in the past where I saw
> > > > > > > > this forgotten. I don't think we should rely on the users doing the
> > > > > > > > right thing (as much as possible).
> > > > > > > >
> > > > > > > > The single kernel binary point makes sense but in this case, I think
> > > > > > > > the bigger question that I'd have is what is the default behavior and
> > > > > > > > what do *most* users of RCU want. So we can keep sane defaults for the
> > > > > > > > majority and reduce human errors related to configuration.
> > > > > > >
> > > > > > > If both the ChromeOS and Android guys need it, I could reinstate the
> > > > > > > old RCU_NOCB_CPU_ALL Kconfig option.  This was removed due to complaints
> > > > > > > about RCU Kconfig complexity, but I believe that Reviewed-by from ChromeOS
> > > > > > > and Android movers and shakers would overcome lingering objections.
> > > > > > >
> > > > > > > Would that help?
> > > > > >
> > > > > > Yes, I think I would love for such a change. I am planning to add a
> > > > > > test to ChromeOS to check whether config options were correctly set
> > > > > > up. So I can test for both the RCU_NOCB_CPU options.
> > > > >
> > > > > Very good!
> > > > >
> > > > > Do you love such a change enough to create the patch and to collect
> > > > > convincing Reviewed-by tags?
> > > >
> > > > Yes sure, just so I understand - basically I have to make the code in
> > > > my patch run when RCU_NOCB_CPU_ALL option is passed (and keep the
> > > > option default disabled), but otherwise default to the current
> > > > behavior, right?
> > >
> > > Sorry rephrasing, "make the code in my patch run when the new
> > > CONFIG_RCU_NOCB_CPU_ALL is enabled".
> >
> > Here is what I believe you are proposing:
> >
> >
> >                                 ---     rcu_nocbs       rcu_nocbs=???
> >
> > CONFIG_RCU_NOCB_CPU_ALL=n       [1]     [2]             [3]
> >
> > CONFIG_RCU_NOCB_CPU_ALL=y       [4]     [4]             [3]
> 
> It is always a pleasure to read your well thought out emails ;-)
> 
> >
> > [1]     No CPUs are offloaded at boot.  CPUs cannot be offloaded at
> >         runtime.
> >
> > [2]     No CPUs are offloaded at boot, but any CPU can be offloaded
> >         (and later de-offloaded) at runtime.
> >
> > [3]     The set of CPUs that are offloaded at boot are specified by the
> >         mask, represented above with "???".  The CPUs that are offloaded
> >         at boot can be de-offloaded and offloaded at runtime.  The CPUs
> >         not offloaded at boot cannot be offloaded at runtime.
> 
> Hmm, in other words you are saying that in current code, if only
> select CPUs are offloaded at boot - then only those can be toggled,
> but the others are deemed not offload-able? I am happy to leave that
> quirk/behavior alone as I don't care much right now (for our use
> cases) for runtime toggling.

That is intentional behavior.  To see why, suppose that only CPU 0 was
offloaded at boot.  Now try offloading some other CPU.  A large quantity
of previously read-only data becomes read-write.  Synchronization is
not pretty.

On the other hand, default-enabling (de-)offloading on all CPUs creates
lots of unneeded rcuo kthreads.

So we didn't get here by accident.  ;-)

If this becomes a problem, I would be thinking in terms of an additional
kernel-boot parameter that made all CPUs offloadable by default.  But if
you have a better idea, please do not keep it a secret!

> > [4]     All CPUs are offloaded at boot, and any CPU can be de-offloaded
> >         and offloaded at runtime.  This is the same behavior that
> >         you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
> >         rcu_nocbs=0-N.
> 
> Yes, this is the behavior I intend. So then there would not be a need
> to pass a mask (and I suspect for a large number of users, it
> simplifies boot params).

Very good, and from what I can see, this should work for everyone.

> > I believe that Steve Rostedt's review would carry weight for ChromeOS,
> > however, I am suffering a senior moment on the right person for Android.
> 
> I think for Android, Kalesh Singh is in the kernel team and Tim Murray
> is the performance lead. They could appropriately represent their RCU
> needs.

Sounds good!  Please collect a Reviewed-by from one or both of them.

							Thanx, Paul
