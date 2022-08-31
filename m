Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA35A8500
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiHaSIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiHaSID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:08:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3137A61F0;
        Wed, 31 Aug 2022 11:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AFA2B8220A;
        Wed, 31 Aug 2022 18:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EC4C433D6;
        Wed, 31 Aug 2022 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969280;
        bh=rLG/mQy3Ku4SfN0uXPbJ6aRpcVree5gJPvZ+rfp2amg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=lXvzA+ZiWnlEUR2YvgbztAUXEcUByyxyseul97cKCTPQey/ALQC/LeiUpFpdqkqiU
         Q/ji5ZzxBfhFkEUpNM2iGaKag0nyg4VbwQ4uApRE6Bef9PbnqFKezzozEPuKJpvMBn
         cX8ZAGa5H5s28bkCZDUCU9sHLtiFNomjihyxi/V7VNMxS4c70t9DfM5pqi8QGjoT9C
         rNfZ7Q156eiKJwrKkc+om1GE8kNqDe3p0fyAa9gHjjbZmMza/CYVFjnR2GYfEZ2wQF
         gMhqO4FwyrVY0URtgw1QQpPxFqU1jsppEkCdmBo0H6sln/ApXf4TRYXuzVcDWj7mpi
         cimMz0fdDHORw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A49D15C015D; Wed, 31 Aug 2022 11:07:59 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:07:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] Miscellaneous fixes for v6.1
Message-ID: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
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

This series contains miscellaneous fixes:

1.	Fix rcu_read_unlock_strict() strict QS reporting, courtesy
	of Zqiang.

2.	Update rcu_preempt_deferred_qs() comments for !PREEMPT kernels,
	courtesy of Zqiang.

3.	Add QS check in rcu_exp_handler() for non-preemptible kernels,
	courtesy of Zqiang.

4.	Make tiny RCU support leak callbacks for debug-object errors,
	courtesy of Zqiang.

5.	Document reason for rcu_all_qs() call to preempt_disable().

6.	Update rcu_access_pointer() header for
	rcu_dereference_protected().

7.	Try trigger_single_cpu_backtrace(cpu) in dump_cpu_task(),
	courtesy of Zhen Lei.

8.	Show the registers of 'current' in dump_cpu_task(), courtesy of
	Zhen Lei.

9.	Avoid triggering strict-GP irq-work when RCU is idle, courtesy
	of Zqiang.

10.	Exclude outgoing CPU when it is the last to leave.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |   18 +++++++++++++-----
 b/kernel/rcu/tiny.c        |   17 ++++++++++++++++-
 b/kernel/rcu/tree_exp.h    |    4 +++-
 b/kernel/rcu/tree_plugin.h |    1 +
 b/kernel/rcu/tree_stall.h  |    5 ++---
 b/kernel/sched/core.c      |    3 +++
 b/kernel/smp.c             |    3 +--
 kernel/rcu/tree_plugin.h   |   21 ++++++++++++++-------
 kernel/sched/core.c        |   11 +++++++++++
 9 files changed, 64 insertions(+), 19 deletions(-)
