Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13E2506084
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiDSAHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiDSAGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D3513F97;
        Mon, 18 Apr 2022 17:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62C6FB8114D;
        Tue, 19 Apr 2022 00:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B42C385C8;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=+VktB+rpP/FYBGfEw3GwNqdjH8hwEOL7Xhn+Gfa9jsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUzfG8mrpV2g9yQ6tQ6arKwCvcEBkkkBxBG8iyPo8sCeFge/2ZcW9LYuAeCmUYTRW
         NokxM8JVd60S0Lg6cMgWebTv2AX1RKsAknyNVYkWIzhlZUzAs88s410yS79yHBOVYW
         ZGn4qHTiNuhX743jmRGvzcsYGfLNPJqz7uxQT7Pr4dxfZ0D02Ey7E3fmT8cxbsRk25
         VsWfL17b68KCAZwi1hHtizNfOr/Zdj2ewBxjzIGlmTRuedgssSf1SHalehPAJZUdhR
         14WHBUuJ1FH2ZIeAe3wjK8ExOT0qvSkWLV7PAIUY3/V5CCqaTULlviY6vtRHBNJymu
         aX+vmwRnsHA2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6EEE85C30E1; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 19/21] srcu: Add contention check to call_srcu() srcu_data ->lock acquisition
Date:   Mon, 18 Apr 2022 17:03:20 -0700
Message-Id: <20220419000322.3948903-19-paulmck@kernel.org>
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

This commit increases the sensitivity of contention detection by adding
checks to the acquisition of the srcu_data structure's lock on the
call_srcu() code path.

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 45 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b9dec26245e0..862008c147b0 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -330,18 +330,13 @@ static void srcu_transition_to_big(struct srcu_struct *ssp)
 }
 
 /*
- * Acquire the specified srcu_struct structure's ->lock, but check for
- * excessive contention, which results in initiation of a transition
- * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
- * parameter permits this.
+ * Check to see if the just-encountered contention event justifies
+ * a transition to SRCU_SIZE_BIG.
  */
-static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
+static void spin_lock_irqsave_check_contention(struct srcu_struct *ssp)
 {
 	unsigned long j;
 
-	if (spin_trylock_irqsave_rcu_node(ssp, *flags))
-		return;
-	spin_lock_irqsave_rcu_node(ssp, *flags);
 	if (!SRCU_SIZING_IS_CONTEND() || ssp->srcu_size_state)
 		return;
 	j = jiffies;
@@ -354,6 +349,38 @@ static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned l
 	__srcu_transition_to_big(ssp);
 }
 
+/*
+ * Acquire the specified srcu_data structure's ->lock, but check for
+ * excessive contention, which results in initiation of a transition
+ * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
+ * parameter permits this.
+ */
+static void spin_lock_irqsave_sdp_contention(struct srcu_data *sdp, unsigned long *flags)
+{
+	struct srcu_struct *ssp = sdp->ssp;
+
+	if (spin_trylock_irqsave_rcu_node(sdp, *flags))
+		return;
+	spin_lock_irqsave_rcu_node(ssp, *flags);
+	spin_lock_irqsave_check_contention(ssp);
+	spin_unlock_irqrestore_rcu_node(ssp, *flags);
+	spin_lock_irqsave_rcu_node(sdp, *flags);
+}
+
+/*
+ * Acquire the specified srcu_struct structure's ->lock, but check for
+ * excessive contention, which results in initiation of a transition
+ * to SRCU_SIZE_BIG.  But only if the srcutree.convert_to_big module
+ * parameter permits this.
+ */
+static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
+{
+	if (spin_trylock_irqsave_rcu_node(ssp, *flags))
+		return;
+	spin_lock_irqsave_rcu_node(ssp, *flags);
+	spin_lock_irqsave_check_contention(ssp);
+}
+
 /*
  * First-use initialization of statically allocated srcu_struct
  * structure.  Wiring up the combining tree is more than can be
@@ -1010,7 +1037,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		sdp = per_cpu_ptr(ssp->sda, 0);
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
-	spin_lock_irqsave_rcu_node(sdp, flags);
+	spin_lock_irqsave_sdp_contention(sdp, &flags);
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
-- 
2.31.1.189.g2e36527f23

