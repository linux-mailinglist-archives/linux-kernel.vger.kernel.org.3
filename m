Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79EF4F9E73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbiDHU4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiDHU4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62DCCBE6E;
        Fri,  8 Apr 2022 13:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847EC61F24;
        Fri,  8 Apr 2022 20:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B7CC385A6;
        Fri,  8 Apr 2022 20:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649451280;
        bh=aVx+7KRXZiRyoZH9LxFoTN9QELSD9fR7MzxNu6nP+2w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=H1oihdWiRyUUZgaZGwE+yAACPzLClGT7Wvslha58NQudg9qh6dxWSQ7IpG+bqHWRJ
         Wn/tPPjNZXXJMNMMUzXyY6jZvlhj7yjuzyk8N5va1dGtT9UKq5JnSRKp7JpXhixt9O
         xFY/ZJEql7iqGOqbKr890IXJniUMIr59d3He+Qfz4vaWbEyAgqPULyWOZs0Td97NZ6
         SjGosIF/BwW7dhBQcQgmoXmZ/rdNJ7EN3nz9E+4y6ObAQgKQXDbZXdr+lKoqz60YHa
         XLEGL8C0bN53Uyz2blIChXMZigl2HRzak6SVGjJFvyhUoyyFouNyFKfwMuBC8qa22c
         QnBVFSAh4SEsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 616B65C015D; Fri,  8 Apr 2022 13:54:40 -0700 (PDT)
Date:   Fri, 8 Apr 2022 13:54:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        frederic@kernel.org
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220407210734.2548973-1-joel@joelfernandes.org>
 <20220408142232.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQWeqfcKdAKmCn4fFGyWXjOGd=29wvi6bL3k7s2bGkDJw@mail.gmail.com>
 <20220408155002.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQDgSO2XkkVhN3RBBz3vwYdAtTuPz-xYYsAPnwEnbYZPA@mail.gmail.com>
 <20220408174908.GK4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
 <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 02:23:34PM -0400, Joel Fernandes wrote:
> On Fri, Apr 8, 2022 at 2:22 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Apr 8, 2022 at 1:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Apr 08, 2022 at 01:20:02PM -0400, Joel Fernandes wrote:
> > > > On Fri, Apr 8, 2022 at 11:50 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Fri, Apr 08, 2022 at 10:52:21AM -0400, Joel Fernandes wrote:
> > > > > > On Fri, Apr 8, 2022 at 10:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 07, 2022 at 09:07:33PM +0000, Joel Fernandes wrote:
> > > > > > > > On systems with CONFIG_RCU_NOCB_CPU=y, there is no default mask provided
> > > > > > > > which ends up not offloading any CPU. This patch removes yet another
> > > > > > > > dependency from the bootloader having to know about RCU, about how many
> > > > > > > > CPUs the system has, and about how to provide the mask. Basically, I
> > > > > > > > think we should stop pretending that the user knows what they are doing :).
> > > > > > > > In other words, if NO_CB_CPU is enabled, lets make use of it.
> > > > > > > >
> > > > > > > > My goal is to make RCU as zero-config as possible with sane defaults. If
> > > > > > > > user wants to provide rcu_nocbs= or nohz_full= options, then those will
> > > > > > > > take precedence and this patch will have no effect.
> > > > > > > >
> > > > > > > > I tested providing rcu_nocbs= option, ensuring that is preferred over this.
> > > > > > >
> > > > > > > Unless something has changed, this would change behavior relied upon
> > > > > > > the enterprise distros.  Last I checked, they want to supply a single
> > > > > > > binary, as evidenced by the recent CONFIG_PREEMPT_DYNAMIC Kconfig option,
> > > > > > > and they also want the default to be non-offloaded.  That is, given a
> > > > > > > kernel built with CONFIG_RCU_NOCB_CPU=y and without either a nohz_full
> > > > > > > or a nocbs_cpu boot parameter, all of the CPUs must be non-offloaded.
> > > > > >
> > > > > > Just curious, do you have information (like data, experiment results)
> > > > > > on why they want default non-offloaded? Or maybe they haven't tried
> > > > > > the recent work done in NOCB code?
> > > > >
> > > > > I most definitely do.  When I first introduced callback offloading, I
> > > > > made it completely replace softirq callback invocation.  There were some
> > > > > important throughput-oriented workloads that got hit with significant
> > > > > performance degradation due to this change.  Enterprise Java workloads
> > > > > were the worst hit.
> > > > >
> > > > > Android does not run these workloads, and I am not aware of ChromeOS
> > > > > running them, either.
> > > >
> > > > Thanks a lot for mentioning this, I was not aware and will make note
> > > > of it :-). I wonder if the scheduler had something to do with the
> > > > degradation.
> > >
> > > It is all too easy to blame the scheduler and all too easy to forget
> > > that the scheduler has a hard job.  ;-)
> > >
> > > And in this case, the scheduler was just doing what it was told.
> >
> > No was just saying the scheduler has to do more work with NOCB because
> > of the extra threads, so that likely degrades the workloads (context
> > switch, wake ups, etc).
> >
> > > > > > > And is it really all -that- hard to specify an additional boot parameter
> > > > > > > across ChromeOS devices?  Android seems to manage it.  ;-)
> > > > > >
> > > > > > That's not the hard part I think. The hard part is to make sure a
> > > > > > future Linux user who is not an RCU expert does not forget to turn it
> > > > > > on. ChromeOS is not the only OS that I've seen someone forget to do it
> > > > > > ;-D. AFAIR, there were Android devices too in the past where I saw
> > > > > > this forgotten. I don't think we should rely on the users doing the
> > > > > > right thing (as much as possible).
> > > > > >
> > > > > > The single kernel binary point makes sense but in this case, I think
> > > > > > the bigger question that I'd have is what is the default behavior and
> > > > > > what do *most* users of RCU want. So we can keep sane defaults for the
> > > > > > majority and reduce human errors related to configuration.
> > > > >
> > > > > If both the ChromeOS and Android guys need it, I could reinstate the
> > > > > old RCU_NOCB_CPU_ALL Kconfig option.  This was removed due to complaints
> > > > > about RCU Kconfig complexity, but I believe that Reviewed-by from ChromeOS
> > > > > and Android movers and shakers would overcome lingering objections.
> > > > >
> > > > > Would that help?
> > > >
> > > > Yes, I think I would love for such a change. I am planning to add a
> > > > test to ChromeOS to check whether config options were correctly set
> > > > up. So I can test for both the RCU_NOCB_CPU options.
> > >
> > > Very good!
> > >
> > > Do you love such a change enough to create the patch and to collect
> > > convincing Reviewed-by tags?
> >
> > Yes sure, just so I understand - basically I have to make the code in
> > my patch run when RCU_NOCB_CPU_ALL option is passed (and keep the
> > option default disabled), but otherwise default to the current
> > behavior, right?
> 
> Sorry rephrasing, "make the code in my patch run when the new
> CONFIG_RCU_NOCB_CPU_ALL is enabled".

Here is what I believe you are proposing:


				---	rcu_nocbs	rcu_nocbs=???

CONFIG_RCU_NOCB_CPU_ALL=n	[1]	[2]		[3]

CONFIG_RCU_NOCB_CPU_ALL=y	[4]	[4]		[3]


[1]	No CPUs are offloaded at boot.	CPUs cannot be offloaded at
	runtime.

[2]	No CPUs are offloaded at boot, but any CPU can be offloaded
	(and later de-offloaded) at runtime.

[3]	The set of CPUs that are offloaded at boot are specified by the
	mask, represented above with "???".  The CPUs that are offloaded
	at boot can be de-offloaded and offloaded at runtime.  The CPUs
	not offloaded at boot cannot be offloaded at runtime.

[4]	All CPUs are offloaded at boot, and any CPU can be de-offloaded
	and offloaded at runtime.  This is the same behavior that
	you would currently get with CONFIG_RCU_NOCB_CPU_ALL=n and
	rcu_nocbs=0-N.


I am adding Frederic on CC, who will not be shy about correcting any
confusion I be suffering from have with respect to the current code.

Either way, if this is not what you had in mind, what are you suggesting
instead?

I believe that Steve Rostedt's review would carry weight for ChromeOS,
however, I am suffering a senior moment on the right person for Android.

							Thanx, Paul
