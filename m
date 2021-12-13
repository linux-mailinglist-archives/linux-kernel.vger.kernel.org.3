Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D796472146
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhLMHCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:02:16 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:29673 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230448AbhLMHCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639378935; x=1670914935;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JaG/DFFZFJrBkI6fs+X0z1whBY96eJ6Ijc9JSXwC+PY=;
  b=kjrhWofwZtiKkKKBuRHlBEGkgjaNRikhy+CILYkloYcvrJRT2/9q1217
   GOLr7HwL1nj8CidEmcQrLtUIlxudVkmTf771RQjaWBg7PWUFEir1NNSK/
   kammjPsb6LROGUJe/I5qKq6lmQ6aMXctoEHjINd8aCMqp78bcd46TYcrB
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Dec 2021 23:02:15 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 23:02:13 -0800
Received: from localhost (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 12 Dec
 2021 23:02:12 -0800
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
To:     <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <urezki@gmail.com>, <frederic@kernel.org>, <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH] rcu: Remove unused rcu_state.boost
Date:   Mon, 13 Dec 2021 12:32:09 +0530
Message-ID: <20211213070209.7464-1-quic_neeraju@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
---
 kernel/rcu/tree.h        | 5 ++---
 kernel/rcu/tree_plugin.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4b889081f4f4..caea946700f3 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -303,9 +303,8 @@ struct rcu_state {
 
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
index 1439cb3680eb..54ef0e8c8742 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1174,8 +1174,6 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
 		goto out;
 
-	rcu_state.boost = 1;
-
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (WARN_ON_ONCE(IS_ERR(t)))
-- 
2.17.1

