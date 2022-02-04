Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36404AA472
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378282AbiBDXjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378232AbiBDXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BE7E025B2E;
        Fri,  4 Feb 2022 15:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B44F761C9C;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C04EC340F0;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=GaED8m6moSZlPrHrLk8hrW3KCvJ5yaGPsNW+YksLZx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpIdZnCZJNa73OinJU/3Iy56uJGqrXp8ZqUVTIPqZW2UKLRfCudhWojiaCRrZHUC2
         JGVW8by03zoCJa6vtIlgiejEw5MBnl4Ezb9sS/kYGmbCs4IaUG33uAu3N9hKNPOrTc
         EwWgRQ0CD3tozPzFefyjIhEp3VMWexcdNQEo0wWe8POh+PAZH/s3dB+k3X/6A6V+Yw
         PMUcahYkqi3LBsk/kIRrzIi63hjK9QEihjhjHMt5G4KsMNE+ZzfnyCqA2Gctzuevag
         ARpUyqT2YBUbHW/nDmHilUPaju8s7nXAG9K+U5Y1+tPkxkpVq3/pxP7NA5NrYZ95hS
         jKRsMt4i8UAGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EB8B35C08B7; Fri,  4 Feb 2022 15:39:03 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/19] srcu: Make srcu_funnel_gp_start() cache ->mynode in snp_leaf
Date:   Fri,  4 Feb 2022 15:38:46 -0800
Message-Id: <20220204233902.1902-3-paulmck@kernel.org>
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
index d30e4db04506a..7d13e35e5d277 100644
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

