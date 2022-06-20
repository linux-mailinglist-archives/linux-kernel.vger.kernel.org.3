Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2031655273F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345496AbiFTWzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344821AbiFTWyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EA3186F3;
        Mon, 20 Jun 2022 15:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C38F61469;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEDCC341D4;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=t0SucPs4EUqfSebYgoCs5grB36mb5mMbrqax8MQNnoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ca7LvN1MBrSMaZ8XpHOVMmko5Jyh4qSJkcm/iJxTi5AuVijio/srtzn+1yvDRt+wa
         TQx1Oaq19c86wpj9wJiAsqUlD+wgeFt7qAv4zKMaOVQy2MCrdi8EWH/XjE8g1TM7Et
         hM7Zs2/Pofow0L3NMzgbPlPPn1rVC3aGIa4iihVKzLis5yW7pf3cOLFEnMrILKKcJG
         HRxwzrYgRn1lKACd3cjF3pIuU7y7+uh/XymucqObH3r5etN2euiWcyVWdTPrMDD4M9
         0SfdJFYj4dLhSmVNS17pT9B3UmmKk1hcTv086/Ia6CRx4yb+93sZ5uMrjMdR1CUwNE
         ynXBgkx2euVEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F1725C0E3F; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 12/32] rcu-tasks: Simplify trc_inspect_reader() QS logic
Date:   Mon, 20 Jun 2022 15:53:51 -0700
Message-Id: <20220620225411.3842519-12-paulmck@kernel.org>
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

Currently, trc_inspect_reader() does one check for nesting less than
or equal to zero, then sorts out the distinctions within this single
"if" statement.  This commit simplifies the logic by providing one
"if" statement for quiescent states (nesting of zero) and another "if"
statement for transitioning from one nesting level to another or the
outermost rcu_read_unlock_trace() (negative nesting).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 554b2e59a1d5a..6b44c69eeca88 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1343,15 +1343,16 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 	// If not exiting a read-side critical section, mark as checked
 	// so that the grace-period kthread will remove it from the
 	// holdout list.
-	if (nesting <= 0) {
-		if (!nesting)
-			rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
-		return nesting ? -EINVAL : 0;  // If in QS, done, otherwise try again later.
+	if (!nesting) {
+		rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
+		return 0;  // In QS, so done.
 	}
+	if (nesting < 0)
+		return -EINVAL; //  QS transitioning, try again later.
 
 	// The task is in a read-side critical section, so set up its
-	// state so that it will awaken the grace-period kthread upon exit
-	// from that critical section.
+	// state so that it will update state upon exit from that critical
+	// section.
 	if (!rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED))
 		trc_add_holdout(t, bhp);
 	return 0;
-- 
2.31.1.189.g2e36527f23

