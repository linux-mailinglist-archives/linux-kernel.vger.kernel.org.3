Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308824AA481
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378537AbiBDXjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378223AbiBDXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79936E025B3B;
        Fri,  4 Feb 2022 15:39:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20F62B83977;
        Fri,  4 Feb 2022 23:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7566EC36AE5;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=lU9KtK+rLNOMgb4Dp6EanwjYkdwCh9D21wVszXVcZ0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9vQOuQV/hPVAKCM+QM4Ue/aNi2hZxtOs+ra0ra8/8FiUR2TlvVcno4pn9WO6RkUD
         98gWGGVtL972aeGl9/WNG+tAxwFP3uXwPeIRiIt0Lk7pLZaR/j5yhQ4AncpTOEEvro
         I9+ke7F/mrPRu9QO1Ek1MR00OYtKnhlSFOPWMrKUZcVn/hz2eeOunpDqaAsQf5YrUo
         HFq8CBDQgOwQGPSkMeDhck6ur5ffjYpj3yVfBs6tWpmYlRf6/Xo3a9pqVFpeJWs1xk
         uezZxUwoHE149z1Sh8yvubgGIPcvXGms528GEiZVTByY34hO0M6n3e9lM9FhXviTxz
         DaElMQ2ChKvqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 06DE05C0DB8; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/19] srcu: Use invalid initial value for srcu_node GP sequence numbers
Date:   Fri,  4 Feb 2022 15:38:54 -0800
Message-Id: <20220204233902.1902-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, tree SRCU relies on the srcu_node structures being initialized
at the same time that the srcu_struct itself is initialized, and thus
use the initial grace-period sequence number as the initial value for
the srcu_node structure's ->srcu_have_cbs[] and ->srcu_gp_seq_needed_exp
fields.  Although this has a high probability of also working when the
srcu_node array is allocated and initialized at some random later time,
it would be better to avoid leaving such things to chance.

This commit therefore initializes these fields with 0x1, which is a
recognizable invalid value.  It then adds the required checks for this
invalid value in order to avoid confusion on long-running kernels
(especially those on 32-bit systems) that allocate and initialize
srcu_node arrays late in life.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 8f55967b58a74..4201815744d85 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -150,10 +150,10 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 		WARN_ON_ONCE(ARRAY_SIZE(snp->srcu_have_cbs) !=
 			     ARRAY_SIZE(snp->srcu_data_have_cbs));
 		for (i = 0; i < ARRAY_SIZE(snp->srcu_have_cbs); i++) {
-			snp->srcu_have_cbs[i] = 0;
+			snp->srcu_have_cbs[i] = 0x1;
 			snp->srcu_data_have_cbs[i] = 0;
 		}
-		snp->srcu_gp_seq_needed_exp = 0;
+		snp->srcu_gp_seq_needed_exp = 0x1;
 		snp->grplo = -1;
 		snp->grphi = -1;
 		if (snp == &ssp->node[0]) {
@@ -397,8 +397,7 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
  */
 static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 {
-	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
-			 READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
+	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
 		return 0;
 	return SRCU_INTERVAL;
 }
@@ -572,6 +571,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	int idx;
 	unsigned long mask;
 	struct srcu_data *sdp;
+	unsigned long sgsne;
 	struct srcu_node *snp;
 	int ss_state;
 
@@ -605,7 +605,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 				cbs = snp->srcu_have_cbs[idx] == gpseq;
 			snp->srcu_have_cbs[idx] = gpseq;
 			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
-			if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
+			sgsne = snp->srcu_gp_seq_needed_exp;
+			if (rcu_seq_state(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
 				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
 			mask = snp->srcu_data_have_cbs[idx];
 			snp->srcu_data_have_cbs[idx] = 0;
@@ -663,14 +664,17 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 				  unsigned long s)
 {
 	unsigned long flags;
+	unsigned long sgsne;
 
 	if (snp)
 		for (; snp != NULL; snp = snp->srcu_parent) {
+			sgsne = READ_ONCE(snp->srcu_gp_seq_needed_exp);
 			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
-			    ULONG_CMP_GE(READ_ONCE(snp->srcu_gp_seq_needed_exp), s))
+			    (!rcu_seq_state(sgsne) && ULONG_CMP_GE(sgsne, s)))
 				return;
 			spin_lock_irqsave_rcu_node(snp, flags);
-			if (ULONG_CMP_GE(snp->srcu_gp_seq_needed_exp, s)) {
+			sgsne = snp->srcu_gp_seq_needed_exp;
+			if (!rcu_seq_state(sgsne) && ULONG_CMP_GE(sgsne, s)) {
 				spin_unlock_irqrestore_rcu_node(snp, flags);
 				return;
 			}
@@ -698,6 +702,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 {
 	unsigned long flags;
 	int idx = rcu_seq_ctr(s) % ARRAY_SIZE(sdp->mynode->srcu_have_cbs);
+	unsigned long sgsne;
 	struct srcu_node *snp;
 	struct srcu_node *snp_leaf = smp_load_acquire(&sdp->mynode);
 	unsigned long snp_seq;
@@ -724,7 +729,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 			snp->srcu_have_cbs[idx] = s;
 			if (snp == snp_leaf)
 				snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
-			if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
+			sgsne = snp->srcu_gp_seq_needed_exp;
+			if (!do_norm && (rcu_seq_state(sgsne) || ULONG_CMP_LT(sgsne, s)))
 				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
 			spin_unlock_irqrestore_rcu_node(snp, flags);
 		}
-- 
2.31.1.189.g2e36527f23

