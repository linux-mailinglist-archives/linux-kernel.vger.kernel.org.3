Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85B3465A76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354134AbhLBAOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:14:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44000 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354099AbhLBANl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:13:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7C043CE213C;
        Thu,  2 Dec 2021 00:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4198C53FAD;
        Thu,  2 Dec 2021 00:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403816;
        bh=l6F0UUyJGfEPuhPwaZ/wG8MXGs/L4QfIA7d3p/g3qA0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=eO8fZnl6j/J40wvHxBDroGJtsY9Q7CdK8p3yxGZ5xWoyKPgk/ya9MTpuW9MPZsmWv
         Y/1Tm8/smGwx+IFn2ePX1F4Q+h1BsGKm1CjV9F8Kfctso51KSlwjh2Qhsw/+gNAZQu
         IwgHokg/CZAut2PxU5bFzJCTUpjuB8mAH77GlTfAqbKLHgITmgVUI4fAcYm1g9DpH5
         TTe93oC/flPLTp7rBfFS0cPavYjLotTuXNIS1QvfmCwLCktZBYYtlwRHSPnt17mB7T
         kCzSmI65l8y86Hig7c1bbwN04UzekuWdQ4W/a83ycVZLvDUin87ArunhkFv7DOdb94
         5y0qXCIP/dSOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 685455C1107; Wed,  1 Dec 2021 16:10:16 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:10:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/7] Expedited-grace-period updates for v5.17
Message-ID: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides updates for RCU expedited grace periods, most
notably 7/7 fixing a low-probability grace-period hang.

1.	Ignore rdp.cpu_no_qs.b.exp on preemptible RCU's rcu_qs(),
	courtesy of Frederic Weisbecker.

2.	Move rcu_data.cpu_no_qs.b.exp reset to rcu_export_exp_rdp(),
	courtesy of Frederic Weisbecker.

3.	Remove rcu_data.exp_deferred_qs and convert to rcu_data.cpu
	no_qs.b.exp, courtesy of Frederic Weisbecker.

4.	Mark sync_sched_exp_online_cleanup() ->cpu_no_qs.b.exp load.

5.	Prevent expedited GP from enabling tick on offline CPU.

6.	Make idle entry report expedited quiescent states.

7.	Mark current CPU as exp-QS in IPI loop second pass, courtesy of
	Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree.c        |    2 +-
 b/kernel/rcu/tree.h        |    1 -
 b/kernel/rcu/tree_exp.h    |    1 +
 b/kernel/rcu/tree_plugin.h |    6 +++++-
 kernel/rcu/tree_exp.h      |   13 ++++++++-----
 kernel/rcu/tree_plugin.h   |   31 ++++++++++++++++++++-----------
 6 files changed, 35 insertions(+), 19 deletions(-)
