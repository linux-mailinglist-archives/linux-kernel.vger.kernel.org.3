Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E48B54557F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244078AbiFIUXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFIUXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:23:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C681CB07
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541FF61EB5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 20:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA932C34114;
        Thu,  9 Jun 2022 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654806192;
        bh=74UtdogW17rNnP/hgHR7SeyJGtpVYxWbLy5cOXBsaeg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UXkod7uTbz1Mnreqh9vcNcwI3U2S242x9B3ah7YXIv6EkDqfju53FR8h8zUCWlkW6
         Q1JqJ53Qr4E98DrJOnb6lNqAvyb9+3RM5q0RVXj4YFly8bBLGH5tVGaRXQC03ZmIpD
         Po4Ued/JnN3i+YoId2jTmEiDCK9VG0MAezn5SNB4bEb49GdmYR9rYKM08q/o7EIs9L
         U+D5DkIADMPzMU4iOQePotTGzblDuC4ROR1Cex0SpVD/b6WI4zxjR+TPMiCbP3pewC
         7t9xOI+FZBjW3lqIPJHzKNvIXaNKeBTEA+dtqTTPJlnhAEQ679Egm/mfb0sR2H2kwn
         QEkhFKupqQoKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4456F5C0387; Thu,  9 Jun 2022 13:23:12 -0700 (PDT)
Date:   Thu, 9 Jun 2022 13:23:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     frederic@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, urezki@gmail.com
Subject: Re: [PATCH] rcu/tree: Add comment to describe GP done condition in
 fqs loop
Message-ID: <20220609202312.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220609071340.30375-1-quic_neeraju@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609071340.30375-1-quic_neeraju@quicinc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:43:40PM +0530, Neeraj Upadhyay wrote:
> Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
> is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().
> 
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Thank you, Neeraj!  As usual, I could not resist the urge to wordsmith
as shown below.  Could you please check to see if I messed something up?

							Thanx, Paul

------------------------------------------------------------------------

commit bdf3a744d3ad21336a390bfcc2e41de63f193eaf
Author: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Date:   Thu Jun 9 12:43:40 2022 +0530

    rcu/tree: Add comment to describe GP-done condition in fqs loop
    
    Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
    is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().
    
    Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a93c5f4d7e092..9a941e7ee6109 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2083,7 +2083,15 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 		rcu_gp_torture_wait();
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
 		/* Locking provides needed memory barriers. */
-		/* If grace period done, leave loop. */
+		/*
+		 * Exit the loop if the root rcu_node structure indicates that the grace period
+		 * has ended, leave the loop.  The rcu_preempt_blocked_readers_cgp(rnp) check
+		 * is required only for single-node rcu_node trees because readers blocking
+		 * the current grace period are queued only on leaf rcu_node structures.
+		 * For multi-node trees, checking the root node's ->qsmask suffices, because a
+		 * given root node's ->qsmask bit is cleared only when all CPUs and tasks from
+		 * the corresponding leaf node have passed through their quiescent state.
+		 */
 		if (!READ_ONCE(rnp->qsmask) &&
 		    !rcu_preempt_blocked_readers_cgp(rnp))
 			break;
