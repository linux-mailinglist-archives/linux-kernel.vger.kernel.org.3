Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B02E50607A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiDSAGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiDSAGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE2213F97;
        Mon, 18 Apr 2022 17:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C5261297;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39B9C385AB;
        Tue, 19 Apr 2022 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326604;
        bh=ZZ4EmnWyc2TdVDNKqE6NcBxGvAGwflG6QiNpPkNuJC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ha8RHPGuMI1zI4mVn5mllWh3XNLkKtKmVxZkmbdYEj3racbDox6/QJSbdtbphKH7w
         J5yRCFmzYQ4cQuerZfTFTZ6p1q6oSCH8ILXrvuVSzRobUd4iJLLBPJfKj2z+wqAIR7
         OCjjGDYwqjHsjqyzlDQJsk3ahHbXuPVy7jfH2cNGWOkd5cOg2qV9lauDnC3oguxf+/
         qhdamWDMhyrYRbbT1p5GnNg/mRepxLEJ4o4TIlcx8kCLGQhnf1M1YI011qEr4MoLjr
         l+iCpEnPPsfPOaIe8CLojQKBVEys3MbM/lHaxeAL02c6JflakzOzcltqQyycCp21rA
         NghOTjSwwCSDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 51EFD5C0848; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/21] srcu: Make srcu_funnel_gp_start() cache ->mynode in snp_leaf
Date:   Mon, 18 Apr 2022 17:03:04 -0700
Message-Id: <20220419000322.3948903-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
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

Currently, the srcu_funnel_gp_start() walks its local variable snp up the
tree and reloads sdp->mynode whenever it is necessary to check whether
it is still at the leaf srcu_node level.  This works, but is a bit more
obtuse than absolutely necessary.  In addition, upcoming commits will
dynamically size srcu_struct structures, in which case sdp->mynode will
no longer necessarily be a constant, and this commit helps prepare for
that dynamic sizing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d30e4db04506..7d13e35e5d27 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -632,20 +632,21 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 {
 	unsigned long flags;
 	int idx = rcu_seq_ctr(s) % ARRAY_SIZE(sdp->mynode->srcu_have_cbs);
-	struct srcu_node *snp = sdp->mynode;
+	struct srcu_node *snp;
+	struct srcu_node *snp_leaf = sdp->mynode;
 	unsigned long snp_seq;
 
 	/* Each pass through the loop does one level of the srcu_node tree. */
-	for (; snp != NULL; snp = snp->srcu_parent) {
-		if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != sdp->mynode)
+	for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
+		if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
 			return; /* GP already done and CBs recorded. */
 		spin_lock_irqsave_rcu_node(snp, flags);
 		if (ULONG_CMP_GE(snp->srcu_have_cbs[idx], s)) {
 			snp_seq = snp->srcu_have_cbs[idx];
-			if (snp == sdp->mynode && snp_seq == s)
+			if (snp == snp_leaf && snp_seq == s)
 				snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
 			spin_unlock_irqrestore_rcu_node(snp, flags);
-			if (snp == sdp->mynode && snp_seq != s) {
+			if (snp == snp_leaf && snp_seq != s) {
 				srcu_schedule_cbs_sdp(sdp, do_norm
 							   ? SRCU_INTERVAL
 							   : 0);
@@ -656,7 +657,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 			return;
 		}
 		snp->srcu_have_cbs[idx] = s;
-		if (snp == sdp->mynode)
+		if (snp == snp_leaf)
 			snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
 		if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
 			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
-- 
2.31.1.189.g2e36527f23

