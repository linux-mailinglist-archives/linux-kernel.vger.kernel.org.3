Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA14D8615
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbiCNNjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbiCNNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359ADBC2D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 394676118A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC3EC340F4;
        Mon, 14 Mar 2022 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647265080;
        bh=nF/6Lmz1r80SPWKXpwqXTgYh6Kwp/g/JtR3krTnNLFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMt8EzGg6jjebnIXApidbamvN96dj89DXDxybsVMYWVpADdfqZbMgK0L+NMXH6ljc
         OnNS/oOBBYEsOrwFaa4cJ9hMH+TJioRwBbSCvL7CSdNyAVPS60mFZ2gykQhicQDPhr
         vRJ68rfOoJs1ItVfSLXQCSDfefnMzthgHhsuQtil8owAw2MFLchrEhDbzS5zC+0Efb
         qe1PBnzYW4TTqkEQzIASN/T6X5STNDdu9xRev2pnakFlHYzFBHRM5p/4dOuwxn7GA+
         ZXh6mdpwVeS4V0sAkfw0MVr5rMDxnoIrYhoDbc+ZuddUqj5VW4H95khNFu39k2PcqK
         CcxeH9K2aE2Mw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/3] rcu: Fix preemption mode check on synchronize_rcu[_expedited]()
Date:   Mon, 14 Mar 2022 14:37:38 +0100
Message-Id: <20220314133738.269522-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314133738.269522-1-frederic@kernel.org>
References: <20220314133738.269522-1-frederic@kernel.org>
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

An early check on synchronize_rcu[_expedited]() tries to determine if
the current CPU is in UP mode on an SMP no-preempt kernel, in which case
there is no need to start a grace period since the current assumed
quiescent state is all we need.

However the preemption mode doesn't take into account the boot selected
preemption mode under CONFIG_PREEMPT_DYNAMIC=y, missing a possible
early return if the running flavour is "none" or "voluntary".

Use the shiny new preempt mode accessors to fix this.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d2db709f83d9..8fe2f9843139 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3769,7 +3769,7 @@ static int rcu_blocking_is_gp(void)
 {
 	int ret;
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
+	if (preempt_mode_full() || preempt_mode_rt())
 		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
 	might_sleep();  /* Check for RCU read-side critical section. */
 	preempt_disable();
-- 
2.25.1

