Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E905526E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbiFTWVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244457AbiFTWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934801B7BA;
        Mon, 20 Jun 2022 15:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4421B8164A;
        Mon, 20 Jun 2022 22:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3CEC341C4;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=BzfEqP9ZYAPt1rGlIDWKlmdtdWPBu8au1LUFkZLPWlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHVBE8KNv/cZfZZ+GP0GVSaJkI0CWNmwoGVW4IkSqhdIU1gj3ueXFrCicOqFBcpy6
         z1RtdbYlRukO8rO81rMfaZiLjkluSmlKJf2Y0ZlXgc97fIv+hbW6LsPbJA3bA/UPIV
         ESpCpICh1e4FCA7uf8XuwzxC7lNhoD2J5Yct/uUP3XU+PtndgEkZfl+PTQheYREKjS
         E/uIBMHEcFzHjxvhBYm9bB8cgG9onuwpFH2/MLpx6FVMKLso+AvL7PsuBoVlnAK8po
         KNyDv6CCW1iu93u9FeMo7V8mfjHG/vA3Gv57P8HBTYIoD+htSRsSc0LC4pfG/2rF3g
         1RfDROIS/WBcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 03B8C5C0A33; Mon, 20 Jun 2022 15:20:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/12] rcu: Immediately boost preempted readers for strict grace periods
Date:   Mon, 20 Jun 2022 15:20:24 -0700
Message-Id: <20220620222032.3839547-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

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
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 440d9e02a26e0..53d05eb804121 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1140,7 +1140,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	    (rnp->gp_tasks != NULL &&
 	     rnp->boost_tasks == NULL &&
 	     rnp->qsmask == 0 &&
-	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
+	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld ||
+	      IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)))) {
 		if (rnp->exp_tasks == NULL)
 			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-- 
2.31.1.189.g2e36527f23

