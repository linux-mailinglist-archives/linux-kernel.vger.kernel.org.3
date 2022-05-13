Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEA152593C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376291AbiEMBG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376288AbiEMBGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:06:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3B4B85E;
        Thu, 12 May 2022 18:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B82FBB82C27;
        Fri, 13 May 2022 01:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DB9C385B8;
        Fri, 13 May 2022 01:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652404011;
        bh=FoLn8p1rIVJzm+8vcP0quDOYymFUzJqV3NNi2X/rVrs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kfuZsA31u11/Vyux9BRFnyit1LtRGc4TxvfPzig1UxTU+72HPJKNPkVIkipU6bXDM
         wL3QN7qusSN/bJSFw6SNywcVsyA8DtyQfrY7acuTINBCzQjpXPRTsOUIBUJqvTjCgg
         pHeUv7BY4jHnuPkD2yyi1azZ1Ftst+fMygPFqC1kEsBGs8zLW5CdP1f9F6dDk7Dfxz
         cfIaj7X087uil9VSm9h9DiDCRNQLvBWPQ3GyyIU496DNem3SStImIxFRR+njaMXvkD
         DeAHNPfUlgF3lWr4wax2oFJAfFhbf4jDgRp+TBXJw4H/rwLzxLBskg1dOc9eaVi196
         +pcHUG7uNJhzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 18CAC5C051B; Thu, 12 May 2022 18:06:51 -0700 (PDT)
Date:   Thu, 12 May 2022 18:06:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Direct boosting gp_tasks for strict grace periods
Message-ID: <20220513010651.GD1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220513004256.465233-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513004256.465233-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 08:42:55AM +0800, Zqiang wrote:
> If the CONFIG_RCU_STRICT_GRACE_PERIOD option is enabled, the normal grace
> period will be treated as expedited grace period, the gp_tasks that block
> current grace period needs to be boosted unconditionally, therefore this
> commit adds Kconfig check in rcu_initiate_boost().
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good eyes!  I have queued this for further review and testing, thank you!

What sorts of tests did you run on it?

As usual, I could not resist the urge to wordsmith, so could you please
check the version shown below?

							Thanx, Paul

------------------------------------------------------------------------

commit 079e0f894c5d887c678f94332c1fa7287abfd6bc
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Fri May 13 08:42:55 2022 +0800

    rcu: Immediately boost preempted readers for strict grace periods
    
    The intent of the CONFIG_RCU_STRICT_GRACE_PERIOD Konfig option is to
    cause normal grace periods to complete quickly in order to better catch
    errors resulting from improperly leaking pointers from RCU read-side
    critical sections.  However, kernels built with this option enabled still
    wait for some hundreds of milliseconds before boosting RCU readers that
    have been preempted within their current critical section.  The value
    of this delay is set by the CONFIG_RCU_BOOST_DELAY Kconfig option,
    which defaults to 500 milliseconds.
    
    This commit therefore causes kernels build with strict grace periods
    to ignore CONFIG_RCU_BOOST_DELAY.  This causes rcu_initiate_boost()
    to start boosting immediately after all CPUs on a given leaf rcu_node
    structure have passed through their quiescent states.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 99cde4c947699..b4ab952f04ea6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1159,7 +1159,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	    (rnp->gp_tasks != NULL &&
 	     rnp->boost_tasks == NULL &&
 	     rnp->qsmask == 0 &&
-	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
+	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld ||
+	      IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)))) {
 		if (rnp->exp_tasks == NULL)
 			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
