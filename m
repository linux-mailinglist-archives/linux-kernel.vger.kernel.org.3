Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FE65A851F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiHaSLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiHaSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:10:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FCADF663;
        Wed, 31 Aug 2022 11:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74B41B8220A;
        Wed, 31 Aug 2022 18:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4078EC433D6;
        Wed, 31 Aug 2022 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969363;
        bh=Bw8UbnSJg6wjZnrx3ZkAFqEfYqJl3xi80KpmA3oTN54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNtR+99a6pCu8Pd6K/iw3aCwUat6AcpmMLyF1ZNf/fKnFUKFzrT37aMjtrK0iX/sX
         XmekCbTDMvCjmjU3s9U1Hy3nqqWBQ81fp40+4/gCqu2VNf98/x3yq9j5qJzMoSf6W7
         7Dw/xAy3kL+LTtkmzuTGMTS8//E9IlXLCacXvUMOcJs3rYvIdw0Q6T5OzX9nyffska
         nDbMxj1vGh5hYF1+BJ5lXSkTAamfT1ef6fL6bnNd7EgZkZoXrfJ9bh64/V5k6qDeQ7
         hplhn+cLi19czp440QeuleuF/4+AbhXef4ijxQE92OoXj67vqWVsmD+sjSak/+D4cS
         F2RoRfkuvsu2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0064C5C015D; Wed, 31 Aug 2022 11:09:22 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH rcu 1/3] rcu: Back off upon fill_page_cache_func() allocation failure
Date:   Wed, 31 Aug 2022 11:09:19 -0700
Message-Id: <20220831180921.2694017-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831180916.GA2693797@paulmck-ThinkPad-P17-Gen-1>
References: <20220831180916.GA2693797@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

The fill_page_cache_func() function allocates couple of pages to store
kvfree_rcu_bulk_data structures. This is a lightweight (GFP_NORETRY)
allocation which can fail under memory pressure. The function will,
however keep retrying even when the previous attempt has failed.

This retrying is in theory correct, but in practice the allocation is
invoked from workqueue context, which means that if the memory reclaim
gets stuck, these retries can hog the worker for quite some time.
Although the workqueues subsystem automatically adjusts concurrency, such
adjustment is not guaranteed to happen until the worker context sleeps.
And the fill_page_cache_func() function's retry loop is not guaranteed
to sleep (see the should_reclaim_retry() function).

And we have seen this function cause workqueue lockups:

kernel: BUG: workqueue lockup - pool cpus=93 node=1 flags=0x1 nice=0 stuck for 32s!
[...]
kernel: pool 74: cpus=37 node=0 flags=0x1 nice=0 hung=32s workers=2 manager: 2146
kernel:   pwq 498: cpus=249 node=1 flags=0x1 nice=0 active=4/256 refcnt=5
kernel:     in-flight: 1917:fill_page_cache_func
kernel:     pending: dbs_work_handler, free_work, kfree_rcu_monitor

Originally, we thought that the root cause of this lockup was several
retries with direct reclaim, but this is not yet confirmed.  Furthermore,
we have seen similar lockups without any heavy memory pressure.  This
suggests that there are other factors contributing to these lockups.
However, it is not really clear that endless retries are desireable.

So let's make the fill_page_cache_func() function back off after
allocation failure.

Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 79aea7df4345e..eb435941e92fd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3183,15 +3183,16 @@ static void fill_page_cache_func(struct work_struct *work)
 		bnode = (struct kvfree_rcu_bulk_data *)
 			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
-		if (bnode) {
-			raw_spin_lock_irqsave(&krcp->lock, flags);
-			pushed = put_cached_bnode(krcp, bnode);
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+		if (!bnode)
+			break;
 
-			if (!pushed) {
-				free_page((unsigned long) bnode);
-				break;
-			}
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		pushed = put_cached_bnode(krcp, bnode);
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+		if (!pushed) {
+			free_page((unsigned long) bnode);
+			break;
 		}
 	}
 
-- 
2.31.1.189.g2e36527f23

