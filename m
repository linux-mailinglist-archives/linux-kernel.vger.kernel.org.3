Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B162E54448D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiFIHNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiFIHNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:13:51 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A77243193
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654758830; x=1686294830;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=MqnDWa9hb1BNXwcubVcQqz0JEhAKWxPZLGViLqbL+6g=;
  b=L+QXlyz0ts2dCpP6RcOQ7E89VK0iIGv/wioxTAmF69TRUUb6+hTzhZFg
   HC6kvmPtn4o3EUhF3bufH/UHlFx10fx/lJmnY1gOmU99PMfyJyLLAEUWN
   fIbAKe5rkB6BP1zfXhdLK7EFYbAwWWPUpB9Bsp++Buqsr/DyPQTwyZbKg
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jun 2022 00:13:50 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 00:13:50 -0700
Received: from localhost (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 9 Jun 2022
 00:13:48 -0700
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
To:     <paulmck@kernel.org>, <frederic@kernel.org>,
        <josh@joshtriplett.org>, <rostedt@goodmis.org>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <joel@joelfernandes.org>
CC:     <linux-kernel@vger.kernel.org>, <boqun.feng@gmail.com>,
        <urezki@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH] rcu/tree: Add comment to describe GP done condition in fqs loop
Date:   Thu, 9 Jun 2022 12:43:40 +0530
Message-ID: <20220609071340.30375-1-quic_neeraju@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment to explain why !rcu_preempt_blocked_readers_cgp() condition
is required on root rnp node, for GP completion check in rcu_gp_fqs_loop().

Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
---
 kernel/rcu/tree.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a93c5f4d7e09..9cd1ba512fdc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2083,7 +2083,17 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 		rcu_gp_torture_wait();
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
 		/* Locking provides needed memory barriers. */
-		/* If grace period done, leave loop. */
+		/*
+		 * If grace period done, leave loop. rcu_preempt_blocked_readers_cgp(rnp)
+		 * check is required for the case where we only have single node in the
+		 * rcu_node tree; so, root rcu node is also the leaf node, where readers
+		 * blocking current gp are queued. For multi-node tree, checking ->qsmask
+		 * on the root node is sufficient, as root rcu node's ->qsmask is only
+		 * cleared, when all leaf rcu nodes have propagated their quiescent
+		 * state to their parent node, which happens only after both ->qsmask
+		 * and rcu_preempt_blocked_readers_cgp(rnp_leaf) are cleared for those
+		 * leaf nodes.
+		 */
 		if (!READ_ONCE(rnp->qsmask) &&
 		    !rcu_preempt_blocked_readers_cgp(rnp))
 			break;
-- 
2.17.1

