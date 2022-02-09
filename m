Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AEE4B0167
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiBIXid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:38:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiBIXiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:38:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F41E02E500;
        Wed,  9 Feb 2022 15:38:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B73E616B7;
        Wed,  9 Feb 2022 23:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA8C340E7;
        Wed,  9 Feb 2022 23:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644449894;
        bh=KFa4++TEaAXLAeJN/VQvwvpnzo4zYedWhTuwEdr/RBg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=LKykyeSv7GnzxiJou5lpGzYV3DCEIbYLSKi37Nj0oF8LSdWvhvx6GpMG6xjxU43SF
         LygnFVjUlrY/Svo4iTz/gLAkHA3vSQv0bDcFUuw/RGWEgn5c2BPkvN9lHzcYcBrYwI
         G4uISAsfpbjzxcDgZv9kX3598i6879SKnqnIuRj43L+pBfmTQ7RBRRYTD2SiCmttRi
         oxPWxjWK+6EcHDeNtsmzTUObwhvfJUK6Ew1YV4JipsD9zRyAlvggvUfsP8HVPcCVNf
         TrzehjBljVulydJUJzAqO2Bh4jpH675Ye9NiJWvPz0EMMRGBANNMrQXP67WLviCWns
         FSvRoAmtapdhA==
Date:   Thu, 10 Feb 2022 00:38:11 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        quic_mojha@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org,
        tj@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on
 incoming CPUs
Message-ID: <20220209233811.GC557593@lothringen>
Reply-To: 20220204225507.4193113-3-paulmck@kernel.org
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

On Fri, Feb 04, 2022 at 02:55:07PM -0800, Paul E. McKenney wrote:
> Although it is usually safe to invoke synchronize_rcu_expedited() from a
> preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
> between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
> invoke a workqueue handler will hang due to RCU waiting on a CPU that
> the scheduler is not paying attention to.  This commit therefore expands
> use of the existing workqueue-independent synchronize_rcu_expedited()
> from early boot to also include CPUs that are being hotplugged.
> 
> Link: https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
> Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

I'm surprised by this scheduler behaviour.

Since sched_cpu_activate() hasn't been called yet,
rq->balance_callback = balance_push_callback. As a result, balance_push() should
be called at the end of schedule() when the workqueue is picked as the next task.
Then eventually the workqueue should be immediately preempted by the stop task to
be migrated elsewhere.

So I must be missing something. For the fun, I booted the following and it
didn't produce any issue:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 80faf2273ce9..b1e74a508881 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4234,6 +4234,8 @@ int rcutree_online_cpu(unsigned int cpu)
 
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
+	if (cpu != 0)
+		synchronize_rcu_expedited();
 	return 0;
 }
 
