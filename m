Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26D7505FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiDRW4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627B92CE20;
        Mon, 18 Apr 2022 15:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 779E161037;
        Mon, 18 Apr 2022 22:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C13C385B9;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=hK5x6BVv25qP8BKNXoIb9LDR8AFOXkO1p5pr+bQzLFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Maic1LuAc80j57STgy7M0pyeJzX0a0C1VVbSKtTsh+079xE+aljXM6mk7Hqsx6ECA
         NZjLS4axQBYrFAY34jG7MWH3loaP6nFvMDbUP81auvSKrwA/59Y6Je0ng4u04YcAwa
         re/pU06wwSXkeFGMS1QlTJME5q340n2ntNCBkd/SZwEicb7O8Nn23jQiR8/ZY7l+2i
         Uv/f4U56agz3e70dhA9hzBooMgAQ2F7JIOP3ZGFTCeEyTWiRIqg0GMcF14UFTEk12a
         wdhWcQrFf5ZP+HQSuSrIkwcVqP2LAe0ubWTJ2RVWnPFQ4anWYl2zlqRca7dAotBCvR
         x+QPnAl/OvL9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE8B15C12AB; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/11] rcu: Check for successful spawn of ->boost_kthread_task
Date:   Mon, 18 Apr 2022 15:53:57 -0700
Message-Id: <20220418225359.3945217-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
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

For the spawning of the priority-boost kthreads can fail, improbable
though this might seem.  This commit therefore refrains from attemoting
to initiate RCU priority boosting when The ->boost_kthread_task pointer
is NULL.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 176639c6215f..5c23aceecd62 100644
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
-- 
2.31.1.189.g2e36527f23

