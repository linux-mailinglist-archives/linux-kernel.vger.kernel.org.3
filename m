Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39DD4DB38A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356847AbiCPOod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349287AbiCPOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:44:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E056423BD9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C8876157E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5841BC340E9;
        Wed, 16 Mar 2022 14:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647441788;
        bh=vCDDcFPUQSzH6TzPOyC9N+1Fa+Z5jBQqQSiXx5AHDfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTnEfioT1MiaIJDcbMDSF2ozD5jg1PGrdv+V5vQabLfC44BrAsVisMVOxAfF5qGLX
         WU4wQ/uVk92KAamwdJYA0oSlYTDXEZwUbpQgft6ptEPapS96wIa+xpsxtdT8FMhHZ0
         XgCJf7UD27qhqlCpLf1XeKcTPXqEq8tQ4NKaTLgEU99g1mnZBA+KAyekKUp986HQA9
         jAHrtssaz/DzHlR0S2w+aKK/7vhHGgCq268y1f+xHgQAb1mF6imcfQ52Fkpj7VGR0E
         FRnSshQyf04fqbdd25nYZZUc2+Vwc/Q0jpYvne8b1sNAGHTjcI8td01xcEwTMKgJJe
         oDYKtGQ3JX7EA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 4/4] rcu: Name internal polling flag
Date:   Wed, 16 Mar 2022 15:42:55 +0100
Message-Id: <20220316144255.336021-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316144255.336021-1-frederic@kernel.org>
References: <20220316144255.336021-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give a proper self-explanatory name to the expedited grace period
internal polling flag.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h      | 5 +++++
 kernel/rcu/tree.c     | 2 +-
 kernel/rcu/tree_exp.h | 9 +++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index eccbdbdaa02e..8a62bb416ba4 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -30,6 +30,11 @@
 #define RCU_GET_STATE_USE_NORMAL	0x2
 #define RCU_GET_STATE_BAD_FOR_NORMAL	(RCU_GET_STATE_FROM_EXPEDITED | RCU_GET_STATE_USE_NORMAL)
 
+/*
+ * Low-order bit definitions for polled grace-period internals.
+ */
+#define RCU_EXP_SEQ_POLL_DONE 0x1
+
 /*
  * Return the counter portion of a sequence number previously returned
  * by rcu_seq_snap() or rcu_seq_current().
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5da381a3cbe5..b3223b365f9f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4679,7 +4679,7 @@ static void __init rcu_init_one(void)
 			spin_lock_init(&rnp->exp_lock);
 			mutex_init(&rnp->boost_kthread_mutex);
 			raw_spin_lock_init(&rnp->exp_poll_lock);
-			rnp->exp_seq_poll_rq = 0x1;
+			rnp->exp_seq_poll_rq = RCU_EXP_SEQ_POLL_DONE;
 			INIT_WORK(&rnp->exp_poll_wq, sync_rcu_do_polled_gp);
 		}
 	}
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index c4a19c6a83cf..7ccb909d6355 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -910,14 +910,14 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
 	unsigned long s;
 
 	s = READ_ONCE(rnp->exp_seq_poll_rq);
-	if (s & 0x1)
+	if (s & RCU_EXP_SEQ_POLL_DONE)
 		return;
 	while (!sync_exp_work_done(s))
 		__synchronize_rcu_expedited(true);
 	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	s = rnp->exp_seq_poll_rq;
-	if (!(s & 0x1) && sync_exp_work_done(s))
-		WRITE_ONCE(rnp->exp_seq_poll_rq, s | 0x1);
+	if (!(s & RCU_EXP_SEQ_POLL_DONE) && sync_exp_work_done(s))
+		WRITE_ONCE(rnp->exp_seq_poll_rq, s | RCU_EXP_SEQ_POLL_DONE);
 	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
 }
 
@@ -946,7 +946,8 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
 	rnp = rdp->mynode;
 	if (rcu_init_invoked())
 		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
-	if ((rnp->exp_seq_poll_rq & 0x1) || ULONG_CMP_LT(rnp->exp_seq_poll_rq, s)) {
+	if ((rnp->exp_seq_poll_rq & RCU_EXP_SEQ_POLL_DONE) ||
+	    ULONG_CMP_LT(rnp->exp_seq_poll_rq, s)) {
 		WRITE_ONCE(rnp->exp_seq_poll_rq, s);
 		if (rcu_init_invoked())
 			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
-- 
2.25.1

