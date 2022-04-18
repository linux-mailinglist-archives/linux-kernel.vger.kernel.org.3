Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77793505FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiDRW5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119EC2CE2E;
        Mon, 18 Apr 2022 15:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE5CFB81142;
        Mon, 18 Apr 2022 22:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0FBC385AB;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=2yulGwLtnjKwidHWmy2CXBtr+UjTlFlstTStV9RGdkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5prFdd1O9kNCDUHafYTSelzXQvBRmxsKjrM5bINh+/dbNrG5LkZcVG2y3hZsNTpI
         fUAQfCzM3FL9fM8zYUIkF0DDTtqgaG4Tc22gSIW6ygdVx1nUh8YDosQlHA5FNoGfPn
         Hph+Ix1YTlXHNfIQx1l4ENnVDS8wvJlvX/I4opIBzEkBX30Rpfp3xdYXfGGJIDKg8f
         /BJCjeYEajg2nXef0EgdCtI/pR77hh0agRbl9XGQxMSZunqjVVJ7RP9nKeH4JZ0jRp
         Qw5sm5RWCf+asGz5EVy0rrj+4WG21W9DCswCXyhMVKsSaJh31oKXgm/ALeIIaplRSj
         tv18NyrhzEC0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E726B5C0A23; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH rcu 05/11] rcu: Add comments to final rcu_gp_cleanup() "if" statement
Date:   Mon, 18 Apr 2022 15:53:53 -0700
Message-Id: <20220418225359.3945217-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The final "if" statement in rcu_gp_cleanup() has proven to be rather
confusing, straightforward though it might have seemed when initially
written.  This commit therefore adds comments to its "then" and "else"
clauses to at least provide a more elevated form of confusion.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Frederic Weisbecker <frederic@kernel.org>
Reported-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Reported-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a5ea67454640..29669070348e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2098,14 +2098,29 @@ static noinline void rcu_gp_cleanup(void)
 	/* Advance CBs to reduce false positives below. */
 	offloaded = rcu_rdp_is_offloaded(rdp);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
+
+		// We get here if a grace period was needed (“needgp”)
+		// and the above call to rcu_accelerate_cbs() did not set
+		// the RCU_GP_FLAG_INIT bit in ->gp_state (which records
+		// the need for another grace period).  The purpose
+		// of the “offloaded” check is to avoid invoking
+		// rcu_accelerate_cbs() on an offloaded CPU because we do not
+		// hold the ->nocb_lock needed to safely access an offloaded
+		// ->cblist.  We do not want to acquire that lock because
+		// it can be heavily contended during callback floods.
+
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
-		trace_rcu_grace_period(rcu_state.name,
-				       rcu_state.gp_seq,
-				       TPS("newreq"));
+		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("newreq"));
 	} else {
-		WRITE_ONCE(rcu_state.gp_flags,
-			   rcu_state.gp_flags & RCU_GP_FLAG_INIT);
+
+		// We get here either if there is no need for an
+		// additional grace period or if rcu_accelerate_cbs() has
+		// already set the RCU_GP_FLAG_INIT bit in ->gp_flags. 
+		// So all we need to do is to clear all of the other
+		// ->gp_flags bits.
+
+		WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags & RCU_GP_FLAG_INIT);
 	}
 	raw_spin_unlock_irq_rcu_node(rnp);
 
-- 
2.31.1.189.g2e36527f23

