Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB74DB38C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356830AbiCPOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356818AbiCPOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:44:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47D23BD3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A48B81BF9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC6FC340F0;
        Wed, 16 Mar 2022 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647441786;
        bh=+MPNWmYaV22ZBHxQaIDswT0l2QT2UXXflRMR8tnJfho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lt/yHnmWLDYkpm1P5DbK9fKk0I5ZrK80pJrO0ZaZUHBMoTl+TjmIqQxDSmQGLCXg3
         89pYhEsXau9n/j5BwolMB2sOidW3N9+ZNIB04iPEEYmHqYJMd92HOVFzsj/pS3OChH
         orrSJaVostvTj9KgsEdhj1f5HaYvZONauYzircQ51fzuGxYKJGhCUfhHK52ydZLoEh
         TXkAH/OfGRXOudwWFXp97dqbKJ4G1vXI4upUk62nPyQ4KmGhWQOVAYdHKbLawuxqWI
         uxPEwxmwhSgUnOZ8mEteez2DO9/B9yyGpl/LOWprGsF7I/7X3m7xD8oR4WZt006OFs
         WRhYH6jx0W5ug==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/4] rcu: Perform early sequence fetch for polling locklessly
Date:   Wed, 16 Mar 2022 15:42:54 +0100
Message-Id: <20220316144255.336021-4-frederic@kernel.org>
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

The workqueue ordering guarantees that the work sees all the accesses
of the task prior to its call to the corresponding queue_work().

Therefore the sequence to poll can be retrieved locklessly.

The only downside is that it is then possible to miss the 0x1 flag set
by a prior work. But this could already happen concurrently anyway after
the exp_poll_lock is unlocked. In the worst case the slow path involving
synchronize_rcu_expedited() takes care of the situation.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 kernel/rcu/tree_exp.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 763ec35546ed..c4a19c6a83cf 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -909,9 +909,7 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
 	struct rcu_node *rnp = container_of(wp, struct rcu_node, exp_poll_wq);
 	unsigned long s;
 
-	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
-	s = rnp->exp_seq_poll_rq;
-	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
+	s = READ_ONCE(rnp->exp_seq_poll_rq);
 	if (s & 0x1)
 		return;
 	while (!sync_exp_work_done(s))
@@ -919,7 +917,7 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
 	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	s = rnp->exp_seq_poll_rq;
 	if (!(s & 0x1) && sync_exp_work_done(s))
-		rnp->exp_seq_poll_rq |= 0x1;
+		WRITE_ONCE(rnp->exp_seq_poll_rq, s | 0x1);
 	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
 }
 
@@ -949,7 +947,7 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
 	if (rcu_init_invoked())
 		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	if ((rnp->exp_seq_poll_rq & 0x1) || ULONG_CMP_LT(rnp->exp_seq_poll_rq, s)) {
-		rnp->exp_seq_poll_rq = s;
+		WRITE_ONCE(rnp->exp_seq_poll_rq, s);
 		if (rcu_init_invoked())
 			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
 	}
-- 
2.25.1

