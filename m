Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DBF465A99
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354197AbhLBAYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbhLBAX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:23:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CA1C061574;
        Wed,  1 Dec 2021 16:20:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31535CE2136;
        Thu,  2 Dec 2021 00:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4FAC53FAD;
        Thu,  2 Dec 2021 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404431;
        bh=HsY5D5AZm3MHulZ/zGBkgfyJinMbbykm6U8eWzL/6o8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=CDdsr2j54jBfor009mZrglIQidKHdBsmieSuRSBmgdnLbfS9qprWy+2/dbQd3JH0u
         z2FLfzgvJuxcDESBiE9rBlh5hJjqtWMJvICAoDdUd0aYuSQ6m3Nkn7sM3SBkEB1USx
         wIIWWOfpLTEu1i4PxzYgBiFLLgJj7NRLuWhdtamvCEBdJG/AYR3tc1wGv35tzCTQUW
         rzR/MZOf0EdTF4J/+ku7weGxLDPtc77DlUgoieBAARTGgx1SzJdR11Qne+bbHiBB1C
         Tt5J8XE9YplrFBx41nBZYjM3zw2VF0cNgNq4rTzX5pK3qqujB/YyZ9L/A3xN8PJ3Yt
         xVHzBDzJ5NItg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 236FD5C1107; Wed,  1 Dec 2021 16:20:31 -0800 (PST)
Date:   Wed, 1 Dec 2021 16:20:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH rcu 0/6] Miscellaneous fixes for v5.17
Message-ID: <20211202002031.GA3127068@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains miscellaneous fixes:

1.	Replace ________p1 and _________p1 with __UNIQUE_ID(rcu),
	courtesy of Chun-Hung Tseng.

2.	in_irq() cleanup, courtesy of Changbin Du.

3.	Improve tree_plugin.h comments and add code cleanups, courtesy
	of Zhouyi Zhou.

4.	Avoid running boost kthreads on isolated CPUs, courtesy of Zqiang.

5.	Avoid alloc_pages() when recording stack, courtesy of Jun Miao.

6.	Prevent redundant __srcu_read_unlock() wakeup.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |   50 +++++++++++++++++++++++++--------------------
 b/include/linux/rcutiny.h  |    2 -
 b/include/linux/srcu.h     |    3 +-
 b/kernel/rcu/srcutiny.c    |    2 -
 b/kernel/rcu/tree.c        |    2 -
 b/kernel/rcu/tree_plugin.h |    2 -
 kernel/rcu/tree.c          |    4 +--
 kernel/rcu/tree_plugin.h   |   14 ++++++------
 8 files changed, 43 insertions(+), 36 deletions(-)
