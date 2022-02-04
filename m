Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5472F4AA44A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378144AbiBDXYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:24:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45782 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378103AbiBDXYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B08A8CE24C1;
        Fri,  4 Feb 2022 23:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02851C340EF;
        Fri,  4 Feb 2022 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017048;
        bh=lXaKWM2nPsvGaA4M3xknAyaLNPy151HXLW17hO5rkR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnImF1IPtt2zc7pNIiSc2VDYAKsr5iB+XuE8GMXgIErTZEXiwud2gsJLyx82dKXSJ
         gr5xTuvTk3XW7wT32rpThhKRiTROaVolrxdCn2HnTeQn9gmHJpp7T5b4R9W4UXtzDo
         chgLeBoJvXe711StkHFdLSA7zfQ92UsTxAq7hhbIbu8ap5YHXXfUDvSwXccd+980Nn
         SVtPd+GXllM9hQQ1yEL36+SOyBAOoMmvRY4G8xzujEKG6p2ikTSS7s79+QmEvw9+5W
         3lT9H2Wmntc1Wxfz0Bv7dOv8ueWgry79JhnhLpG/K6iKm/NIInF7PDsdkYHpF9ITm7
         ILyofZD1mdihA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C3B355C08B7; Fri,  4 Feb 2022 15:24:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/10] rcu: Remove unused rcu_state.boost
Date:   Fri,  4 Feb 2022 15:23:59 -0800
Message-Id: <20220204232406.814-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h        | 5 ++---
 kernel/rcu/tree_plugin.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 24dd4b0d805f1..e9990945483f1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -304,9 +304,8 @@ struct rcu_state {
 
 	/* The following fields are guarded by the root rcu_node's lock. */
 
-	u8	boost ____cacheline_internodealigned_in_smp;
-						/* Subject to priority boost. */
-	unsigned long gp_seq;			/* Grace-period sequence #. */
+	unsigned long gp_seq ____cacheline_internodealigned_in_smp;
+						/* Grace-period sequence #. */
 	unsigned long gp_max;			/* Maximum GP duration in */
 						/*  jiffies. */
 	struct task_struct *gp_kthread;		/* Task for grace periods. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c5b45c2f68a15..109429e70a642 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1175,8 +1175,6 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
 		return;
 
-	rcu_state.boost = 1;
-
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (WARN_ON_ONCE(IS_ERR(t)))
-- 
2.31.1.189.g2e36527f23

