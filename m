Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6691552728
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbiFTWwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344321AbiFTWve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420611AF21;
        Mon, 20 Jun 2022 15:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF2F3B8164C;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CADBC341D1;
        Mon, 20 Jun 2022 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=ACS+sZAWFwHojRmPytaLGs4wN/jbPmVYOfPZlRpDk4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gn1KsvXNMGRdicxDsqAIzbRuPBCXQo2cN5bpBKFM9H/uNQbME/J9hfVnnl8rWbIRE
         yD+/ytXlIh1KtC64Ys0pnaf1o2Dsjra8leBCHBSGaNK0UJcBdGsWXGQgDMptwSGvJ7
         ECUxS9WacwoqXF08scCyabhSq1EX3DTbVlNR534hMOx6TAtkZ08qzCXXKF7uOTm/5G
         GX2KJrN44K0XW9TMS32PGlK6+AjPireiQ4F0fCR629uPIQG5+Fa8WboP/8gYVsiPTy
         W8SFU3PC9pIV+I5MwKwFRHKU1+vq80XXcNE2+hxRjPsF5dSOyGdN/Yux16HejKl/dW
         bMvMOkvX4A0OQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A78EF5C0DEB; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/12] rcu: Diagnose extended sync_rcu_do_polled_gp() loops
Date:   Mon, 20 Jun 2022 15:51:27 -0700
Message-Id: <20220620225128.3842050-11-paulmck@kernel.org>
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

This commit dumps out state when the sync_rcu_do_polled_gp() function
loops more than expected.  This is a debugging aid.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f05a15b11fa0c..4c7037b507032 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -970,6 +970,7 @@ EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 static void sync_rcu_do_polled_gp(struct work_struct *wp)
 {
 	unsigned long flags;
+	int i = 0;
 	struct rcu_node *rnp = container_of(wp, struct rcu_node, exp_poll_wq);
 	unsigned long s;
 
@@ -979,8 +980,12 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
 	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
 	if (s == RCU_GET_STATE_COMPLETED)
 		return;
-	while (!poll_state_synchronize_rcu(s))
+	while (!poll_state_synchronize_rcu(s)) {
 		synchronize_rcu_expedited();
+		if (i == 10 || i == 20)
+			pr_info("%s: i = %d s = %lx gp_seq_polled = %lx\n", __func__, i, s, READ_ONCE(rcu_state.gp_seq_polled));
+		i++;
+	}
 	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	s = rnp->exp_seq_poll_rq;
 	if (poll_state_synchronize_rcu(s))
-- 
2.31.1.189.g2e36527f23

