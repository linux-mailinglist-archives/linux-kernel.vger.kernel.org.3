Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1374E6692
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349927AbiCXQBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbiCXQBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:01:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B922AEE;
        Thu, 24 Mar 2022 09:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E1CDB8244B;
        Thu, 24 Mar 2022 16:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E065C340EC;
        Thu, 24 Mar 2022 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648137602;
        bh=q79PIwzbW5QyaiQJBSuk3Pa/tpfdQBQe9SrvS827vms=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k5Na4eSW+izeWfyLYrfuSc5u8bEfOXsp9mr+vV3qSgmWRiCPBwiXmxkg/2bmdzaiS
         3NC/6ee9I+k8oy1xsC1EFNIWjakUKiQ2jUc5L3nMncOM1qNuzpSuI43Oj8n/wCbfCw
         XXjy8MaVA9Hga2onOxhQzR2Uh1KDLht2iOaZd6CuEQy/1Sdtx1eFHZ2TZEx3wS6ENr
         1hc/6l0Bmjvar4MK75StKp2fzJTO6CWhvxSXXL4b0Ift6SwLahCoIYkFI2/g/rijiw
         RP40SpJdeoW841Hf7bwo8Pf2SVAlyhUA8hDCjgJu9sGcKXhrlul1PTLRvqz3ekMacH
         a52HvOQylyBBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 823E75C0192; Thu, 24 Mar 2022 09:00:01 -0700 (PDT)
Date:   Thu, 24 Mar 2022 09:00:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Check the validity of the boost_kthread_task pointer
Message-ID: <20220324160001.GW4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220324111515.1810160-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324111515.1810160-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 07:15:15PM +0800, Zqiang wrote:
> The boost kthreads may spawn failed, although the probability of
> creation failure is very low, in consideration of the robustness
> of the code, add boost_kthread_task pointer detection.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch!  As you say, rare, but definitely worth fixing.

I could not resist a bit of wordsmithing.  Could you please check
to see if I messed something up?

							Thanx, Paul

------------------------------------------------------------------------

commit ad3c438e248cbc41fe30a41287621c3dbfcdf51c
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Thu Mar 24 19:15:15 2022 +0800

    rcu: Check for successful spawn of ->boost_kthread_task
    
    For the spawning of the priority-boost kthreads can fail, improbable
    though this might seem.  This commit therefore refrains from attemoting
    to initiate RCU priority boosting when The ->boost_kthread_task pointer
    is NULL.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6b9bcd45c7b2..d58f6d6073bf 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1125,7 +1125,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	__releases(rnp->lock)
 {
 	raw_lockdep_assert_held_rcu_node(rnp);
-	if (!rcu_preempt_blocked_readers_cgp(rnp) && rnp->exp_tasks == NULL) {
+	if (!rnp->boost_kthread_task ||
+	    (!rcu_preempt_blocked_readers_cgp(rnp) && !rnp->exp_tasks)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
