Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D8E4D8E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245001AbiCNU12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiCNU11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:27:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A573917E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80387B80FE7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14461C340E9;
        Mon, 14 Mar 2022 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647289571;
        bh=9CS29+T32I+TMcpS8styzHO75+JE2E1H4hCtaXxugCo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Mn55mgnVDnSmww/J8Y1UBj81s5MHWoXrfl7RpaF1LZjVgNAaWNsomIdpdipfI/xyb
         /ZUmzyto56XCK21Q/XSP4j+s6qosm5nuH8IssEhYg7TqUqrz59ku2mq7By3oF2vaAm
         NPZLKlf1Qn4YDyfuz8nC7DCUqo8eTbr6BuWOnZp//C565POnsO/vkn89LSmkm1B3sm
         RApIfb/H11md0Edk/j5lkHNREhtpauYb6rOoWk1Zlk7fuO5v/omL2bgoYfje/lKHa8
         z6YzKgGzHy26zI93Fmik4rFYqpjOGoJTxWvTdDkZpYJMnYZxD9NXTgNPTBcym6IsnD
         nYiN/9Y7KkrVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ACA5E5C4162; Mon, 14 Mar 2022 13:26:10 -0700 (PDT)
Date:   Mon, 14 Mar 2022 13:26:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 0/3] rcu: synchronize_rcu[_expedited]() related fixes
Message-ID: <20220314202610.GW4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220314133738.269522-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314133738.269522-1-frederic@kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 02:37:35PM +0100, Frederic Weisbecker wrote:
> 
> A few fixes especially for expedited GP polling causing a stall on TREE07,
> as reported by Paul.
> 
> We may still want to optimize start_poll_synchronize_rcu_expedited() on
> UP-no-preempt but I think Paul may be implying this while doing other
> fixes.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/dev
> 
> HEAD: 6e5fd7e614fd5c8f0fffeaa140b7ea697bfeb096
> 
> Thanks,
> 	Frederic

I have pulled these in for review and testing, thank you!!!  I have
started a ~90-minute test and will let you know how that goes.

> ---
> 
> Frederic Weisbecker (2):
>       rcu: Fix expedited GP polling against UP/no-preempt environment

I have some concerns with this one due to the fact that it acquires locks
in cases where the old code would not.  (I did have problems with this
in both recent SRCU changes and the normal-grace-period counterpart to
this series.)

But let's see what rcutorture and kbuild test robot think about it.

>       rcu: Fix preemption mode check on synchronize_rcu[_expedited]()

This one looks good.

> Valentin Schneider (1):
>       preempt/dynamic: Introduce preempt mode accessors

I am guessing that this one is a compact placeholder for my convenience
(in which case thank you!).  I will be marking it "EXP" on my next rebase.

							Thanx, Paul

>  include/linux/sched.h | 16 +++++++++++++++
>  kernel/rcu/tree.c     |  2 +-
>  kernel/rcu/tree_exp.h | 57 +++++++++++++++++++++++++++++++--------------------
>  kernel/sched/core.c   | 11 ++++++++++
>  4 files changed, 63 insertions(+), 23 deletions(-)
