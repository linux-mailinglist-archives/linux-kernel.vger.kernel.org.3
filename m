Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67044FFD78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiDMSJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiDMSJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:09:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B3D4C79C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CCD5CCE2262
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46931C385A4;
        Wed, 13 Apr 2022 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649873230;
        bh=tSvzwTIx8wtDLjqMEI1/ahaBRJn4S+5/ueHjYbPB5kI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LxQQ7XnAutc4QNuCM66b8mGUUDF1/aacifxp4chO4PnkquHdWNdul6Hw13veN/m18
         9+kM01YboCq9KlquO75ka3l1GKmkEg0KnV0fl7YwAOqW1+1cQd6sO7WOvzJt2N9pHl
         mcEol1s+OEpThG1zbGpLgzXxcEnKK0fx2fwFztq8LvhW20S+qx5GXIhr0rYXsvDL9K
         2IcKeZxc4ydIlF0sh5T0CEf3/x7hkGW3PcNB3ai4ItUxYr1eLvaez9du+Cpbpo2iUv
         omdD+5uhQNoSXi967FV9tUrkh5AxgNCBz7Ta0xgk6Z4jUayIrctcVjhUUq86TGn5FJ
         FzDPuh4QHByrw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DC91F5C013A; Wed, 13 Apr 2022 11:07:09 -0700 (PDT)
Date:   Wed, 13 Apr 2022 11:07:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220413180709.GN4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
 <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
 <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1>
 <20220409071740.6024-1-hdanton@sina.com>
 <20220413113711.1263-1-hdanton@sina.com>
 <20220413140729.GL4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTmZnk_kFw48HeyyFTXZzfj1cPdw+BaOra14JiWJh6kNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTmZnk_kFw48HeyyFTXZzfj1cPdw+BaOra14JiWJh6kNg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 01:21:20PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> 
> On Wed, Apr 13, 2022 at 8:07 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Apr 13, 2022 at 07:37:11PM +0800, Hillf Danton wrote:
> > > On Sat, 9 Apr 2022 08:56:12 -0700 Paul E. McKenney wrote:
> > > > On Sat, Apr 09, 2022 at 03:17:40PM +0800, Hillf Danton wrote:
> > > > > On Fri, 8 Apr 2022 10:53:53 -0700 Kalesh Singh wrote
> > > > > > Thanks for the discussion everyone.
> > > > > >
> > > > > > We didn't fully switch to kthread workers to avoid changing the
> > > > > > behavior for users that dont need this low latency exp GPs. Another
> > > > > > (and perhaps more important) reason is because kthread_worker offers
> > > > > > reduced concurrency than workqueues which Pual reported can pose
> > > > > > issues on systems with a large number of CPUs.
> > > > >
> > > > > A second ... what issues were reported wrt concurrency, given the output
> > > > > of grep -nr workqueue block mm drivers.
> > > > >
> > > > > Feel free to post a URL link to the issues.
> > > >
> > > > The issues can be easily seen by inspecting kthread_queue_work() and
> > > > the functions that it invokes.  In contrast, normal workqueues uses
> > > > per-CPU mechanisms to avoid contention, as can equally easily be seen
> > > > by inspecting queue_work_on() and the functions that it invokes.
> > >
> > > The worker from kthread_create_worker() roughly matches unbound workqueue
> > > that can get every CPU overloaded, thus the difference in implementation
> > > details between kthread worker and WQ worker (either bound or unbound) can
> > > be safely ignored if the kthread method works, given that prioirty is barely
> > > a cure to concurrency issues.
> >
> > Please look again, this time taking lock contention in to account,
> > keeping in mind that systems with several hundred CPUs are reasonably
> > common and that systems with more than a thousand CPUs are not unheard of.
> 
> You are talking about lock contention in the kthread_worker infra
> which unbound WQ does not suffer from, right? I don't think the worker
> lock contention will be an issue unless several
> synchronize_rcu_expedited() calls are trying to queue work at the same
> time. Did I miss something? Considering synchronize_rcu_expedited()
> can block in the normal case (blocking is a pretty heavy operation
> involving the scheduler and load balancers), I don't see how
> contending on the worker infra locks can be an issue. If it was
> call_rcu() , then I can relate to any contention since that executes
> much more often.

Think in terms of a system with 1536 CPUs (which IBM would be extremely
happy to sell you, last I checked).  This has 96 leaf rcu_node structures.
Keeping that in mind, take another look at that code.

And in the past there have been real systems with 256 leaf rcu_node
structures.

> I think the argument about too many things being RT is stronger though.

Fair enough.  Except that this could be dealt with by conditionally
setting SCHED_FIFO.  But the lock contention would remain.

							Thanx, Paul

> Thanks,
> 
> Joel
> 
> 
> >
> >
> >                                                         Thanx, Paul
> >
> > > Hillf
> > > >
> > > > Please do feel free to take a look.
> > > >
> > > > If taking a look does not convince you, please construct some in-kernel
> > > > benchmarks to test the scalability of these two mechanisms.  Please note
> > > > that some care will be required to make sure that you are doing a valid
> > > > apples-to-apples comparison.
> > > >
> > > >                                                     Thanx, Paul
> > > >
