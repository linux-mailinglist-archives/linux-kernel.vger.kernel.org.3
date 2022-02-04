Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723E64AA47B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378465AbiBDXjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378255AbiBDXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B92E025B35;
        Fri,  4 Feb 2022 15:39:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A8361C36;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A006CC3410A;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=ibhe7XGDHOnx160ajeMSJLi117GE5aB+Eytzu80AjNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsVivvSMsTx3VvTxpYwe6Krv037OLf58VOh6Nv9AN/x7gnf24Zn1ujSSNVXNhJyUx
         zy273elWuiXOz203bRtbmZFBM3P03QzCnOVwI9X8J36zMtmTFhsg4/UqY4xa0xpyLm
         wXTyPawfbuRAjWf252okzpQCyzDBvbUekWH1X9TSO2m4C60D8q1po0ojku4FX9ailn
         Q+j7Un8FH08t+aw8UOaCCWecDrbfYkk0j+91vIfUSlBaoX37SUt9NfpqWquTz1zJ/N
         8oljxwJMBW/48KyvIXNPCre8lCDJdZh2tPcO1US1h7afZB9rGG7X4CBFrhdtEjx2OF
         xHLdO7/DkI+LA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 15F3F5C14AE; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 19/19] srcu: Add contention check to call_srcu() srcu_data ->lock acquisition
Date:   Fri,  4 Feb 2022 15:39:02 -0800
Message-Id: <20220204233902.1902-19-paulmck@kernel.org>
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

This commit increases the sensitivity of contention detection by adding
checks to the acquisition of the srcu_data structure's lock on the
call_srcu() code path.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 45 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c3968e091d019..31a7a9e2445da 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -320,18 +320,13 @@ static void srcu_transition_to_big(struct srcu_struct *ssp)
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
@@ -344,6 +339,38 @@ static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned l
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
@@ -989,7 +1016,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	} else {
 		sdp = raw_cpu_ptr(ssp->sda);
 	}
-	spin_lock_irqsave_rcu_node(sdp, flags);
+	spin_lock_irqsave_sdp_contention(sdp, &flags);
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
-- 
2.31.1.189.g2e36527f23

