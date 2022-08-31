Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA245A853F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiHaSOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiHaSNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91296F14FE;
        Wed, 31 Aug 2022 11:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4DA0CE1EA8;
        Wed, 31 Aug 2022 18:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AB3C433D6;
        Wed, 31 Aug 2022 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969527;
        bh=qlD6PiN5oNaKRenh0ue19Tcym26xYgZfF1mk6pNSa+8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=b/LI+sV3g/X8yGBznI+mXYDTQ48hV6MxxYOHd0Vmoo0IQReqd8alHoOEqXmqjjerN
         qUHi1FE9F0aNBO6ghYfISaEiZ/WpWyeSbsYBwluoZOeVeym3nQv5YuxTOCNpewe0Ss
         Vw8IYu61mcNhqnpS23atznJcDwJZAd58IUPIBVI3N3+cG87lHCiSzqfBW+lEWCm2DC
         9k7FPNE15joI4Qy11wACqcJC3WGi1zl5sD9Tga42O46ao8Z8Kv0SBMyUMZYPeN4FY4
         2jB1RuG2NVeNwphGnOGjAX0FxUIX35mNTYFk7FPIiun3HikGOGsiiFsf0Ls+2sohuB
         sLKuw/P2LCv6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2C0DE5C015D; Wed, 31 Aug 2022 11:12:07 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:12:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] Polled grace-period updates for v6.1
Message-ID: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series adds support for full-state polled RCU grace periods, both
normal and expedited:

1.	Add full-sized polling for get_completed*() and poll_state*().

2.	Add full-sized polling for get_state().

3.	Abstract synchronous and polled API testing.

4.	Allow per-RCU-flavor polled double-GP check.

5.	Verify RCU reader prevents full polling from completing.

6.	Remove redundant RTWS_DEF_FREE check.

7.	Verify long-running reader prevents full polling from completing.

8.	Add full-sized polling for start_poll().

9.	Add full-sized polling for start_poll_expedited().

10.	Remove blank line from poll_state_synchronize_rcu() docbook
	header.

11.	Add full-sized polling for cond_sync_full().

12.	Add full-sized polling for cond_sync_exp_full().

13.	Disable run-time single-CPU grace-period optimization.

14.	Set rcu_data structures' initial ->gpwrap value to true.

15.	rcu-tasks: Remove grace-period fast-path rcu-tasks helper.

16.	Make synchronize_rcu() fast path update ->gp_seq counters.

17.	Remove expedited grace-period fast-path forward-progress helper.

18.	Make synchronize_rcu_expedited() fast path update
	.expedited_sequence.

19.	Remove ->rgos_polled field from rcu_gp_oldstate structure.

20.	Adjust rcu_poll_need_2gp() for rcu_gp_oldstate field removal.

21.	Make synchronize_rcu() fastpath update only boot-CPU counters.

22.	Use 1-suffixed variable in rcu_torture_write_types() check.

23.	Expand rcu_torture_write_types() first "if" statement.

24.	Add functions to compare grace-period state values.

25.	Limit read-side polling-API testing.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    3 
 b/include/linux/rcutiny.h  |    9 
 b/include/linux/rcutree.h  |    8 
 b/kernel/rcu/rcutorture.c  |    9 
 b/kernel/rcu/tiny.c        |   10 +
 b/kernel/rcu/tree.c        |   76 +++++++-
 b/kernel/rcu/tree_exp.h    |   18 +
 include/linux/rcupdate.h   |   21 ++
 include/linux/rcutiny.h    |   41 ++++
 include/linux/rcutree.h    |   34 +++
 kernel/rcu/rcutorture.c    |  412 +++++++++++++++++++++++++++++++++------------
 kernel/rcu/tree.c          |  230 +++++++++++++++++--------
 kernel/rcu/tree_exp.h      |   35 +++
 13 files changed, 720 insertions(+), 186 deletions(-)
