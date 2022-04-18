Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C576E506002
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiDRW5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiDRW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D745A2D1C5;
        Mon, 18 Apr 2022 15:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24BEDB8114B;
        Mon, 18 Apr 2022 22:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EBDC385B7;
        Mon, 18 Apr 2022 22:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322441;
        bh=4F6D4WuqV0uCGvWLKe5pephkIMgIflKcXAmI/XqzuiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOM59wfhUB1kqFMcXsEmM5bKcvdKaiD3+q6Zib+RPbrKMoVMSsuOr7RBuFLCQzYl/
         5+cBSz2UNlUw+GQSAdi+bKckBf/ElV1qLqwk4vW08TqWfzLC8yZC9kTeTlDjfvyhi2
         DZg0x/NSb3mgB9+i+MtZbwtFB92ZhtyEMoCam64HW3uVeiBGKvQNJKX592R/+JI+W9
         1f9hnn36lb5tKosT29CjONUO/Awx+GE5csr2m0E+Npo7G5a8Ac4HevL/8gTRIMEbjT
         ZPw/VPOsG6OMbnwFTSEZ4bY2b232I5+4bYEA/33JKw1Wa5vdydGeaufkSIMb+QSU6F
         0r8VixORs1C0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EAF665C0DFD; Mon, 18 Apr 2022 15:54:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH rcu 07/11] rcu: Fix preemption mode check on synchronize_rcu[_expedited]()
Date:   Mon, 18 Apr 2022 15:53:55 -0700
Message-Id: <20220418225359.3945217-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225345.GA3945110@paulmck-ThinkPad-P17-Gen-1>
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

From: Frederic Weisbecker <frederic@kernel.org>

An early check on synchronize_rcu[_expedited]() tries to determine if
the current CPU is in UP mode on an SMP no-preempt kernel, in which case
there is no need to start a grace period since the current assumed
quiescent state is all we need.

However the preemption mode doesn't take into account the boot selected
preemption mode under CONFIG_PREEMPT_DYNAMIC=y, missing a possible
early return if the running flavour is "none" or "voluntary".

Use the shiny new preempt mode accessors to fix this.  However,
avoid invoking them during early boot because doing so triggers a
WARN_ON_ONCE().

[ paulmck: Update for mainlined API. ]

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 29669070348e..d3caa82b9954 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3741,7 +3741,9 @@ static int rcu_blocking_is_gp(void)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
+	// Invoking preempt_model_*() too early gets a splat.
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE ||
+	    preempt_model_full() || preempt_model_rt())
 		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
 	might_sleep();  /* Check for RCU read-side critical section. */
 	preempt_disable();
-- 
2.31.1.189.g2e36527f23

