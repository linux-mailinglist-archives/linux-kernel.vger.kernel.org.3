Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F26552745
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbiFTWzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344873AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD61EECB;
        Mon, 20 Jun 2022 15:54:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B15C8614A1;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D84C36AFF;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=oeqjPlwjXE63AEix275I757EvtUPI3KuTQHjdeOt3rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QuY9SbaL8NzO3lPK63bQn0eFr9sIRkeWHEA1QPThf964NXExo2VU/8eb0z9Eo9KdT
         KxqeLO7npg+6A7HQU/eMUcG9z7JccQoJrgqNzWtB/zgQvGqrFbM37Tgr6tO8vRrLho
         XHC7vRUUFQYRrBNvHu/kgH942BK4y2767T2kOIDN1Nki0OP7868lDQbUaGKUWdnyY9
         xvnURwlQqyOptaDdK+xFwSSog/L7pNcQbkzHYUnUOB6xcrVbmmcnrCunX1BcmJzmfC
         Ibc5brAzk3iMR/MA4JZFx+31izJ8UQdpGN8NVgpuw9xXzz6klip/SL/6LGpZ+2EwZJ
         dIgoIBYT1lsbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5BFFE5C164C; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 27/32] rcu-tasks: Maintain a count of tasks blocking RCU Tasks Trace grace period
Date:   Mon, 20 Jun 2022 15:54:06 -0700
Message-Id: <20220620225411.3842519-27-paulmck@kernel.org>
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

This commit maintains a new n_trc_holdouts counter that tracks the number
of tasks blocking the RCU Tasks grace period.  This counter is useful
for debugging, and its value has been added to a diagostic message.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fe0552086ccfc..9d7d6fd4b8a79 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1206,6 +1206,7 @@ static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 static unsigned long n_heavy_reader_attempts;
 static unsigned long n_heavy_reader_updates;
 static unsigned long n_heavy_reader_ofl_updates;
+static unsigned long n_trc_holdouts;
 
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
@@ -1299,6 +1300,7 @@ static void trc_add_holdout(struct task_struct *t, struct list_head *bhp)
 	if (list_empty(&t->trc_holdout_list)) {
 		get_task_struct(t);
 		list_add(&t->trc_holdout_list, bhp);
+		n_trc_holdouts++;
 	}
 }
 
@@ -1308,6 +1310,7 @@ static void trc_del_holdout(struct task_struct *t)
 	if (!list_empty(&t->trc_holdout_list)) {
 		list_del_init(&t->trc_holdout_list);
 		put_task_struct(t);
+		n_trc_holdouts--;
 	}
 }
 
@@ -1760,7 +1763,8 @@ void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "h:%lu/%lu/%lu",
+	sprintf(buf, "N%lu h:%lu/%lu/%lu",
+		data_race(n_trc_holdouts),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
 		data_race(n_heavy_reader_attempts));
-- 
2.31.1.189.g2e36527f23

