Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A304D8F97
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245641AbiCNWgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbiCNWgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ACF30F73
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:35:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D8C6140C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BC4C340E9;
        Mon, 14 Mar 2022 22:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647297304;
        bh=hbsjHiLQ5g+4nDSjuI4RnOLjrnPpRYYdrxZhXbxfh3o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fAGJa7jO/QZRtaMpck6eVyC47pTxDnID33LYKFxdVZ70KBD8v42ysyfKAw0nX32fo
         O+JabTjjeQqKroVmhfICVTyzVTEd4n4dKAKN+BJfFw++ebJqrbA1Rx6A7W7MMpQY5i
         FrduoPAwWMvd0L0r2Hj7QCSs5TqKge4vloxnBlG39VKiygIdcQq27qABr4m39yDbvS
         U8GdSQichZyU82J5M9UdiN6upesZ8vi+357wvaSHWbMjAJplu5UTlHwLOkRE9DiBRO
         nZl+RngXipWUOkxWEwKgcfgMCtPmQKDy2mvVE2rK0P+evgNOnwgegqI585BOopjYhp
         OwhY/CHu2sp5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 507E85C023F; Mon, 14 Mar 2022 15:35:04 -0700 (PDT)
Date:   Mon, 14 Mar 2022 15:35:04 -0700
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
Message-ID: <20220314223504.GA1150279@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220314133738.269522-1-frederic@kernel.org>
 <20220314202610.GW4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220314202610.GW4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 01:26:10PM -0700, Paul E. McKenney wrote:
> On Mon, Mar 14, 2022 at 02:37:35PM +0100, Frederic Weisbecker wrote:
> > 
> > A few fixes especially for expedited GP polling causing a stall on TREE07,
> > as reported by Paul.
> > 
> > We may still want to optimize start_poll_synchronize_rcu_expedited() on
> > UP-no-preempt but I think Paul may be implying this while doing other
> > fixes.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> > 	rcu/dev
> > 
> > HEAD: 6e5fd7e614fd5c8f0fffeaa140b7ea697bfeb096
> > 
> > Thanks,
> > 	Frederic
> 
> I have pulled these in for review and testing, thank you!!!  I have
> started a ~90-minute test and will let you know how that goes.

And TREE05 doesn't like this much.  I get too-short grace periods.
TREE05 is unusual in being the one with the kernel build with
CONFIG_PREEMPT_NONE=y but also with CONFIG_PREEMPT_DYNAMIC=n.

Running tests of the commits individually.

							Thanx, Paul

> > ---
> > 
> > Frederic Weisbecker (2):
> >       rcu: Fix expedited GP polling against UP/no-preempt environment
> 
> I have some concerns with this one due to the fact that it acquires locks
> in cases where the old code would not.  (I did have problems with this
> in both recent SRCU changes and the normal-grace-period counterpart to
> this series.)
> 
> But let's see what rcutorture and kbuild test robot think about it.
> 
> >       rcu: Fix preemption mode check on synchronize_rcu[_expedited]()
> 
> This one looks good.
> 
> > Valentin Schneider (1):
> >       preempt/dynamic: Introduce preempt mode accessors
> 
> I am guessing that this one is a compact placeholder for my convenience
> (in which case thank you!).  I will be marking it "EXP" on my next rebase.
> 
> 							Thanx, Paul
> 
> >  include/linux/sched.h | 16 +++++++++++++++
> >  kernel/rcu/tree.c     |  2 +-
> >  kernel/rcu/tree_exp.h | 57 +++++++++++++++++++++++++++++++--------------------
> >  kernel/sched/core.c   | 11 ++++++++++
> >  4 files changed, 63 insertions(+), 23 deletions(-)
