Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1088E552742
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbiFTWzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344854AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A721F2C2;
        Mon, 20 Jun 2022 15:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6490AB81649;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B854FC341CE;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=DCcr8ffveBDP9I9ZOK7gOK5AGThXr9rsIz6kzl4bSHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7SNFHoZcqLNtjaLjcXZ4clWYPiSRVTqzrVQ6GA2w9lFJS319wa590Np7nYn6FfbA
         rPdAYDbbNZ0FJLscy/7N4J8SnEZnqEuT6XL3dIcRQMl7teuBlsJelGKs8P9kInSNHC
         KVLI2M0JsMDDXMt4p45nUo7aiL4tiyvZoKGxoI7KqYOiZvOJZFIifKzkBNmSmN1zMz
         UbDbwAAatzwT1QCJ7X8HUmHvs9QTCO7SgvLgC3H1jM6Mz7nCNjLwz1dA8i9e3HII8b
         nlcbSARM2baEyZgz+WtQB/e2aiqm3q/xjjPCCU1LQXQRWZ8z/bdwcDLBrhx2NiZdF5
         Pvz28W92WiiQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 347625C0BCC; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 07/32] rcu-tasks: Make trc_read_check_handler() fetch ->trc_reader_nesting only once
Date:   Mon, 20 Jun 2022 15:53:46 -0700
Message-Id: <20220620225411.3842519-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
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

This commit replaces the pair of READ_ONCE(t->trc_reader_nesting) calls
with a single such call and a local variable.  This makes the code's
intent more clear.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 561d24f7f73cc..8fe78a7fecafd 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1278,6 +1278,7 @@ static void trc_del_holdout(struct task_struct *t)
 /* IPI handler to check task state. */
 static void trc_read_check_handler(void *t_in)
 {
+	int nesting;
 	struct task_struct *t = current;
 	struct task_struct *texp = t_in;
 
@@ -1287,12 +1288,13 @@ static void trc_read_check_handler(void *t_in)
 
 	// If the task is not in a read-side critical section, and
 	// if this is the last reader, awaken the grace-period kthread.
-	if (likely(!READ_ONCE(t->trc_reader_nesting))) {
+	nesting = READ_ONCE(t->trc_reader_nesting);
+	if (likely(!nesting)) {
 		rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
 		goto reset_ipi;
 	}
 	// If we are racing with an rcu_read_unlock_trace(), try again later.
-	if (unlikely(READ_ONCE(t->trc_reader_nesting) < 0))
+	if (unlikely(nesting < 0))
 		goto reset_ipi;
 
 	// Get here if the task is in a read-side critical section.  Set
-- 
2.31.1.189.g2e36527f23

