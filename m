Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A8F5526E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbiFTWUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244095AbiFTWUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ACE1B792;
        Mon, 20 Jun 2022 15:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E484F611FA;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EC6C341C5;
        Mon, 20 Jun 2022 22:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763634;
        bh=Ev7MJB6+VbSr95NwkxJsx9nVPnwQqYzMCUqVwoydx3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4YeM8PlT4eNafI0SiBQ7QwlQtyA/YRjo9Scwk4seglPe/QhehGEGvXXQokLvspsw
         2KYNYpltfwkTkOyhDhlqpB/ynVQs2yWgYBRnRI6wTYX/RGI9EAmFHFc8up3Fnx+/PS
         CODH6o+apFAqzE3JRJYL/RZS3SlBym6xi2Al3cd+UVF9rxkkozuATx6nGZ6CPZ5hTa
         aeoy3amLtgg9klHtQNF5yX++gCNXbt4NdUwgzm3qANWeVK+KAC0BlnrpIE4AYwjLJI
         7zpcelurrXCEk16saDoTgSSAsbX0hjehg9UeTKH9qJytC/X+Nf9EHgZRiUXWl8M5in
         /vVm/jda2tTcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01D095C0A15; Mon, 20 Jun 2022 15:20:34 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/12] rcu: Add rnp->cbovldmask check in rcutree_migrate_callbacks()
Date:   Mon, 20 Jun 2022 15:20:23 -0700
Message-Id: <20220620222032.3839547-3-paulmck@kernel.org>
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

Currently, the rcu_node structure's ->cbovlmask field is set in call_rcu()
when a given CPU is suffering from callback overload.  But if that CPU
goes offline, the outgoing CPU's callbacks is migrated to the running
CPU, which is likely to overload the running CPU.  However, that CPU's
bit in its leaf rcu_node structure's ->cbovlmask field remains zero.

Initially, this is OK because the outgoing CPU's bit remains set.
However, that bit will be cleared at the next end of a grace period,
at which time it is quite possible that the running CPU will still
be overloaded.  If the running CPU invokes call_rcu(), then overload
will be checked for and the bit will be set.  Except that there is no
guarantee that the running CPU will invoke call_rcu(), in which case the
next grace period will fail to take the running CPU's overload condition
into account.  Plus, because the bit is not set, the end of the grace
period won't check for overload on this CPU.

This commit therefore adds a call to check_cb_ovld_locked() in
check_cb_ovld_locked() to set the running CPU's ->cbovlmask bit
appropriately.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c19d5926886fb..f4a37f2032664 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4491,6 +4491,7 @@ void rcutree_migrate_callbacks(int cpu)
 	needwake = needwake || rcu_advance_cbs(my_rnp, my_rdp);
 	rcu_segcblist_disable(&rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) != !rcu_segcblist_n_cbs(&my_rdp->cblist));
+	check_cb_ovld_locked(my_rdp, my_rnp);
 	if (rcu_rdp_is_offloaded(my_rdp)) {
 		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 		__call_rcu_nocb_wake(my_rdp, true, flags);
-- 
2.31.1.189.g2e36527f23

