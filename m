Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C869C5721BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiGLR2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGLR2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:28:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EA12CCB4;
        Tue, 12 Jul 2022 10:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 157B9B817DD;
        Tue, 12 Jul 2022 17:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E6FC3411C;
        Tue, 12 Jul 2022 17:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657646922;
        bh=6V3py4JdRtZVLT0SVQG+SwX7LLWJGayQeurQftr33Uc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DYuXySmuxySZlJ4GZf7gGCP1drKvmk7uJU71uGJTCppt3TttxXQ5toHVZ3SX0A5Nq
         VgPY+9wbtLiMqPuelS/SdL+B4VUIiEmlJ1OkPjd82aha4KwSNuLnPRdyMy2i946lGa
         5V2Kh9k7KkVdCpfQ92EIOsCon1TMFgKHHJ1Wc4vV38jMW7IEtiPev0z6Uu8nY3VzHv
         /HPnni2/j0uUiv/+C0Gj1lFR/s+CCSB36lUEk6snJvgrLgE4U5h8yKcZXp4BRt5ByX
         8Psle8Q1ulWF2qrduABAidSyODiKv0wkJIhxt2t+CdHuGPNKLJuAzX2gPaRiTK9n9s
         0rlCbpqEDKbyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 679D35C08C7; Tue, 12 Jul 2022 10:28:42 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:28:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rcu-tasks: Convert RCU_LOCKDEP_WARN() to WARN_ONCE()
Message-ID: <20220712172842.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220712082606.3662616-1-qiang1.zhang@intel.com>
 <20220712082606.3662616-2-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712082606.3662616-2-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:26:05PM +0800, Zqiang wrote:
> For kernel build with CONFIG_PROVE_RCU=y and CONFIG_DEBUG_LOCK_ALLOC=y,
> when the synchronize_rcu_tasks_generic() called occurs during the
> rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE, the warnings
> will be trigger, however the warnings is not actually triggered because
> the debug_lockdep_rcu_enabled() return false(the rcu_scheduler_active !=
> RCU_SCHEDULER_INACTIVE condition is false).
> 
> This commit replace RCU_LOCKDEP_WARN() with WARN_ONCE() to trigger
> warnings.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch, thank you!

Queued with wordsmithing as follows.  As always, please check to see
if I wordsmithed something out of existence.

						Thanx, Paul

------------------------------------------------------------------------

commit 4dbfea53caf3e226e3273fc5947e9041e2ad34ab
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Tue Jul 12 16:26:05 2022 +0800

    rcu-tasks: Convert RCU_LOCKDEP_WARN() to WARN_ONCE()
    
    Kernels built with CONFIG_PROVE_RCU=y and CONFIG_DEBUG_LOCK_ALLOC=y
    attempt to emit a warning when the synchronize_rcu_tasks_generic()
    function is called during early boot while the rcu_scheduler_active
    variable is RCU_SCHEDULER_INACTIVE.  However the warnings is not
    actually be printed because the debug_lockdep_rcu_enabled() returns
    false, exactly because the rcu_scheduler_active variable is still equal
    to RCU_SCHEDULER_INACTIVE.
    
    This commit therefore replaces RCU_LOCKDEP_WARN() with WARN_ONCE()
    to force these warnings to actually be printed.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 83c7e6620d403..469bf2a3b505e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -560,7 +560,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 {
 	/* Complain if the scheduler has not started.  */
-	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
 			 "synchronize_rcu_tasks called too soon");
 
 	// If the grace-period kthread is running, use it.
