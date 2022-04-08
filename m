Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388804F9955
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiDHP1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiDHP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:27:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3254C31DD4;
        Fri,  8 Apr 2022 08:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCB4FB82BAC;
        Fri,  8 Apr 2022 15:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE7DC385A1;
        Fri,  8 Apr 2022 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649431515;
        bh=lLdH9Tp31qVuDIwxFUvLKg4vvD9EROe9TrYZvdNywfQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=THHFFrQvwqFwzDRCdt2DzTm841P3QGqq+p7YQ+zaVRrbSElHj4UFnGfdZ4pXn3EhR
         19UN/LqO0/pdPVb5eiOeXwOgTsTeTk6PF7ExmjsVDW2tR3+8DP7/QMW41Nuu4kzMTu
         uo4Ze2BcNIlGXH8sUMfeIw/L4WjC5dLl5lJalT5U2ABIsXnVUDsggQxZjefAS3PksJ
         k9aS+E66brH29s7RwwuEGQKe/AGTHg0g/5ImZkQpEDOfLVPrQzMKlgWdCuX1CGJ9G4
         EdVzIKOPmOfgLjX7RAFNeyMRrSEWo6r3AbiBjueAVCQODho/ydcIk+lSS+9D2/aZvB
         LoKKPJCmtDghg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 457AE5C0176; Fri,  8 Apr 2022 08:25:15 -0700 (PDT)
Date:   Fri, 8 Apr 2022 08:25:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220408152515.GD4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YSqY2nFZrn4AjpUzJ+dwZc7jaVMG9RG5gvTyb3zFYWtQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSqY2nFZrn4AjpUzJ+dwZc7jaVMG9RG5gvTyb3zFYWtQA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 06:21:03AM -0400, Joel Fernandes wrote:
> On Fri, Apr 8, 2022 at 12:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> [..]
> > +config RCU_EXP_KTHREAD
> > +       bool "Perform RCU expedited work in a real-time kthread"
> > +       depends on RCU_BOOST && RCU_EXPERT
> 
> Doesn't this disable the fix if a system is not RCU_EXPERT ?  Please
> see the definition of RCU_EXPERT:
> "This option needs to be enabled if you wish to make expert-level
> adjustments to RCU configuration."
> 
> I don't think a bug fix counts as an expert-level adjustment.

Good catch!

The constraints that this Kconfig option must meet are as follows:

1.	It must not expose innocent bystanders to additional questions
	in response to "make oldconfig" and friends.  So, if you build
	a kernel, then apply this patch, then run "make oldconfig",
	this last must run to completion without waiting for user input.

	This point is not trivial, and everyone who has submitted a
	mainline pull request violating this rule can attest.  ;-)

2.	Enabing RCU_EXPERT should be the exception rather than the
	rule.  (This rule is all too often honored in the breach.)

3.	If a given Kconfig option is to be selected, it must not depend
	on RCU_EXPERT.  (Otherwise, the build system complains.)

So the question is "Does Android already enable RCU_EXPERT?"  If so,
having this depend on RCU_EXPERT, though not great, is OK given that
Android is the only expected user.  If not, another option is to make
this option depend on ANDROID or some similar Kconfig option that Linus
does not enable in his kernel builds.

> > +       default !PREEMPT_RT && NR_CPUS <= 32
> 
> What is the benefit of turning it off on PREEMPT_RT, even if
> PREEMPT_RT does not use expedited GPs much post-boot? I would think in
> the future if PREEMPT_RT ever uses expedited GPs, they would want this
> feature even more. I'd rather be future-proof now as I don't see any
> advantages of disabling it on !PREEMPT_RT (And a drawback that the fix
> won't apply to those systems). Also will keep the config simple.

Current PREEMPT_RT workloads do not care about synchronize_rcu_expedited()
latencies, so much so that they boot with rcupdate.rcu_normal=y.  Plus
the kthread_create_worker() function does not yet have that many users.
So it makes sense to fence in the effects of this change.

Of course, if you are instead saying that ChromeOS also wants low-latency
synchronize_rcu_expedited(), let's figure out the best way to get this
change to ChromeOS users as well as to Android users.  ;-)

							Thanx, Paul

> > +       help
> > +         Use this option to further reduce the latencies of expedited
> > +         grace periods at the expense of being more disruptive.
> > +
> > +         Accept the default if unsure.
> > +
> >  config RCU_NOCB_CPU
> >         bool "Offload RCU callback processing from boot-selected CPUs"
> >         depends on TREE_RCU
> [...]
> 
> Thanks,
> 
>  - Joel
