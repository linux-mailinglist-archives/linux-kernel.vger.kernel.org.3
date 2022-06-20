Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2D552721
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344203AbiFTWvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiFTWvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA436193FF;
        Mon, 20 Jun 2022 15:51:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8609261377;
        Mon, 20 Jun 2022 22:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C6AC3411B;
        Mon, 20 Jun 2022 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765489;
        bh=+YDomq1JbpU1cTyl2aMrZb8rRzcO4wsZsjbv08+dOoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxXKwJBWG4W5qPpryO8+xqbv60ARCzB1fmBWmn1ORbit6EhxtDRRl5vgRWWlxiXdX
         DG7kt0oByEjUbymSGbdSSaxG79Os8YGFgdmjR2e+tJBB0AIFURgFueIU3N6HcZq/7t
         D2wkoNo4Q4rOAdY+2J7oVpcIzXZam7xWl4WS6YMbcKRZi55LTUEDLWLRungF9Z2Czz
         cUQLvs9VYq+byhkd8MXFlZnNeqc5fUJAN3Lb79QJ8U1o9+QPaNPv4mrYEu6abIJ/ZO
         g7irDHz0fDM7awq8x/QykWX/FIDwX80gAuwGIM402T1Zjbjmz3/9DZUALyRlVxRoND
         68kNr42sFbLjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 930C55C05B9; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH rcu 01/12] rcu: Make normal polling GP be more precise about sequence numbers
Date:   Mon, 20 Jun 2022 15:51:17 -0700
Message-Id: <20220620225128.3842050-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
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

Currently, poll_state_synchronize_rcu() uses rcu_seq_done() to check
whether the specified grace period has completed.  However, rcu_seq_done()
does a simple comparison that reserves have of the sequence-number space
for uncompleted grace periods.  This has the unfortunate side-effect
of not handling sequence-number wrap gracefully.  Of course, one can
argue that if someone has already waited for half of the full range of
grace periods, they can wait for the other half, but why wait at all in
this case?

This commit therefore creates a rcu_seq_done_exact() that counts as
uncompleted only the two grace periods during which the sequence number
might have been handed out, while still being uncompleted.  This way,
if sequence-number wrap happens to hit that range, at most two additional
grace periods need be waited for.

This commit is in preparation for polled expedited grace periods.

Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h  | 12 ++++++++++++
 kernel/rcu/tree.c |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4916077119f3f..0adb55941aeb3 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -119,6 +119,18 @@ static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
 	return ULONG_CMP_GE(READ_ONCE(*sp), s);
 }
 
+/*
+ * Given a snapshot from rcu_seq_snap(), determine whether or not a
+ * full update-side operation has occurred, but do not allow the
+ * (ULONG_MAX / 2) safety-factor/guard-band.
+ */
+static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
+{
+	unsigned long cur_s = READ_ONCE(*sp);
+
+	return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
+}
+
 /*
  * Has a grace period completed since the time the old gp_seq was collected?
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c25ba442044a6..ec28e259774e7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3911,7 +3911,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  *
  * Yes, this function does not take counter wrap into account.
  * But counter wrap is harmless.  If the counter wraps, we have waited for
- * more than 2 billion grace periods (and way more on a 64-bit system!).
+ * more than a billion grace periods (and way more on a 64-bit system!).
  * Those needing to keep oldstate values for very long time periods
  * (many hours even on 32-bit systems) should check them occasionally
  * and either refresh them or set a flag indicating that the grace period
@@ -3924,7 +3924,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  */
 bool poll_state_synchronize_rcu(unsigned long oldstate)
 {
-	if (rcu_seq_done(&rcu_state.gp_seq, oldstate)) {
+	if (rcu_seq_done_exact(&rcu_state.gp_seq, oldstate)) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
-- 
2.31.1.189.g2e36527f23

