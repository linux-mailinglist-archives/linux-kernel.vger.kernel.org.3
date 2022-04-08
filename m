Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCAC4F99FF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbiDHQAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiDHQAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:00:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF6AE6A;
        Fri,  8 Apr 2022 08:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 428C6CE2A4D;
        Fri,  8 Apr 2022 15:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98943C385A1;
        Fri,  8 Apr 2022 15:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649433514;
        bh=0w7CX4PrjpdyKdIGRRbs32uv6uKXSuvOdR768kCHqEc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hofeAabyDR6ibecdIuTeVv4ItV78H+h3JySoIZU/YELvkfkhJsWqckY9RabMpVXRh
         FbOqk2qW6ggGrXszDGlIavBvL2hI5CpappCPwb8dVLBc7ZXhFVmHmRY0zvpYWt9ftL
         FncN++P7beuG4N3bSPS52bIbDrIDVoxchA54f10HreJpRTHBP2JN7nRzyRMFsd7lBV
         0QwGDlj0/SQUkTBT+KhQR5MeHpvl9xCQRgQl369iN6Fra//GU8e+Rl4bBxXe1Gn+Ww
         WA/VcHDOcyhkapwuf5IiWgFRoejxUo8iv9uHKL+XzcMjWBHGl2yl0o3qjMeocmRa12
         8oS6lWbUVxz2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 34DAB5C0176; Fri,  8 Apr 2022 08:58:34 -0700 (PDT)
Date:   Fri, 8 Apr 2022 08:58:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220408155834.GI4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YSqY2nFZrn4AjpUzJ+dwZc7jaVMG9RG5gvTyb3zFYWtQA@mail.gmail.com>
 <20220408113946.056c083e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408113946.056c083e@gandalf.local.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:39:46AM -0400, Steven Rostedt wrote:
> On Fri, 8 Apr 2022 06:21:03 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > > +       default !PREEMPT_RT && NR_CPUS <= 32  
> > 
> > What is the benefit of turning it off on PREEMPT_RT, even if
> > PREEMPT_RT does not use expedited GPs much post-boot? I would think in
> > the future if PREEMPT_RT ever uses expedited GPs, they would want this
> > feature even more. I'd rather be future-proof now as I don't see any
> > advantages of disabling it on !PREEMPT_RT (And a drawback that the fix
> > won't apply to those systems). Also will keep the config simple.
> 
> The default kthread priority is 1. This should not affect PREEMPT_RT, as
> PREEMPT_RT users are usually more concerned by the performance of their
> higher priority tasks. Priority 1 is not considered an issue.
> 
> I do not see why PREEMPT_RT is special here. Why was it singled out?

Because I didn't see the point of doing kthread_create_worker() to create
a pair of kthread_worker structuress that were never going to be used
in PREEMPT_RT kernels.

Or are PREEMPT_RT kernels no longer booting with rcupdate.rcu_normal?
Last I knew, they all did this to avoid IPI latencies from expedited
grace periods.  Has this changed?

							Thanx, Paul
