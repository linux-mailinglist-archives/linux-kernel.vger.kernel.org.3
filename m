Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26561552736
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345166AbiFTWyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344689AbiFTWyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343F817E1D;
        Mon, 20 Jun 2022 15:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21D2861460;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22814C341F3;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=EXjV39XsS2T6HGSSXjJAkW6sJJUdEPaHR9h9fr0f9w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mE1Amf4UtY6YKr22g+rFpZa4m267LU0k8ekcniWUjMnR7mwE96DUaq/R6EpP4WZZH
         SiTHBo952huDrVf6bG3Z+8frtkqX3y5UyEt/BtMgSGSfMf5LHPuuKXm8M2bGTplW0w
         7zLDsB6JlGFVveXkKx8dGQK9Z4uLV9nCWhTXQSUU3E4OWqeKfi43ipRedm3Hzql99+
         BdNleQ+5EyAjEcp8O+NMZC3p70b/xndv+g4ibzWGVmlOI7767Sh7kt/12X5bB36ZGa
         jOotTzfiei8Y/zDsotlUM46FnTiNjjQdtPS5LbU0j92xuqrQ8c29xXCwYVbs8Q+THL
         cJUjuKh95d2Ow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5244E5C1363; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 22/32] rcu-tasks: Avoid rcu_tasks_trace_pertask() duplicate list additions
Date:   Mon, 20 Jun 2022 15:54:01 -0700
Message-Id: <20220620225411.3842519-22-paulmck@kernel.org>
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

This commit adds checks within rcu_tasks_trace_pertask() to avoid
duplicate (and destructive) additions to the holdouts list.  These checks
will be required later due to the possibility of a given task having
blocked while in an RCU Tasks Trace read-side critical section, but now
running on a CPU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 66d8473f1bda1..1aa6a24a9bc2b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1454,9 +1454,10 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 				    struct list_head *hop)
 {
 	// During early boot when there is only the one boot CPU, there
-	// is no idle task for the other CPUs.  Also, the grace-period
-	// kthread is always in a quiescent state.  Either way, just return.
-	if (unlikely(t == NULL) || t == current)
+	// is no idle task for the other CPUs.	Also, the grace-period
+	// kthread is always in a quiescent state.  In addition, just return
+	// if this task is already on the list.
+	if (unlikely(t == NULL) || t == current || !list_empty(&t->trc_holdout_list))
 		return;
 
 	rcu_st_need_qs(t, 0);
-- 
2.31.1.189.g2e36527f23

