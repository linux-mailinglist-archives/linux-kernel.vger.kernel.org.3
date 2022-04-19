Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D564506082
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbiDSAHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbiDSAGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F33D22505;
        Mon, 18 Apr 2022 17:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFFB2612CA;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B38C385B5;
        Tue, 19 Apr 2022 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=IXnjpPJm5PvwKH+ze2uBeBae2XPGQCkrZNv5KgoR3iE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sE7mPbknUKd2kgvgS4LIp9J7AQpXwU12+h9xsTt3Ii/k34v1PqRuI/Xu4yfLMgekZ
         5xYTJ/aSuFSJeuvwZ0gpWPApd48IfTprpi6vT4evKuNeUNwnQ/yD0JlttT2fxwDeqr
         N0OBsXoW3pFOU9CA6uSMbhLB0CSFcWsESFijAVMhpdfk3VOpFVaww/dlTsRvpjpgQv
         ih5KcMI//fGqfVzPnNfiThQOujBaBT21662y+PFnb7YTisfhOTlkTVFALBjX9dvpcT
         KSUsii5rLCDEqUgGAtI5jdhynWmsv7IG/2ldVWYA8gAlAatvwNG9kSdrylC+Vgpd8j
         ZmdNkFlfMwnBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5F2335C1308; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/21] srcu: Ensure snp nodes tree is fully initialized before traversal
Date:   Mon, 18 Apr 2022 17:03:11 -0700
Message-Id: <20220419000322.3948903-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
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

From: Neeraj Upadhyay <quic_neeraju@quicinc.com>

For configurations where snp node tree is not initialized at
init time (added in subsequent commits), srcu_funnel_gp_start()
and srcu_funnel_exp_start() can potential traverse and observe
the snp nodes' transient (uninitialized) states. This can potentially
happen, when init_srcu_struct_nodes() initialization of sdp->mynode
races with srcu_funnel_gp_start() and srcu_funnel_exp_start()

Consider the case below where srcu_funnel_gp_start() observes
sdp->mynode to be not NULL and uses an uninitialized sdp->grpmask

          P1                                  P2

init_srcu_struct_nodes()           void srcu_funnel_gp_start(...)
{
for_each_possible_cpu(cpu) {
  ...
  sdp->mynode = &snp_first[...];
  for (snp = sdp->mynode;...)       struct srcu_node *snp_leaf =
                                       smp_load_acquire(&sdp->mynode)
    ...                             if (snp_leaf) {
                                      for (snp = snp_leaf; ...)
                                        ...
					if (snp == snp_leaf)
                                         snp->srcu_data_have_cbs[idx] |=
                                           sdp->grpmask;
    sdp->grpmask =
      1 << (cpu - sdp->mynode->grplo);
  }
}

Similarly, init_srcu_struct_nodes() and srcu_funnel_exp_start() can
race, where srcu_funnel_exp_start() could observe state of snp lock
before spin_lock_init().

          P1                                      P2

init_srcu_struct_nodes()               void srcu_funnel_exp_start(...)
{
  srcu_for_each_node_breadth_first(ssp, snp) {      for (; ...) {
                                                      spin_lock_...(snp, )
	spin_lock_init(&ACCESS_PRIVATE(snp, lock));
    ...
  }
  for_each_possible_cpu(cpu) {
    ...
    sdp->mynode = &snp_first[...];

To avoid these issues, ensure that snp node tree initialization is
complete i.e. after SRCU_SIZE_WAIT_BARRIER srcu_size_state is reached,
before traversing the tree. Given that srcu_funnel_gp_start() and
srcu_funnel_exp_start() are called within SRCU read side critical
sections, this check is safe, in the sense that all callbacks are
enqueued on CPU0 srcu_cblist until SRCU_SIZE_WAIT_CALL is entered,
and these read side critical sections (containing srcu_funnel_gp_start()
and srcu_funnel_exp_start()) need to complete, before SRCU_SIZE_WAIT_CALL
is reached.

Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 155c430c6a73..2e7ed67646db 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -705,9 +705,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	int idx = rcu_seq_ctr(s) % ARRAY_SIZE(sdp->mynode->srcu_have_cbs);
 	unsigned long sgsne;
 	struct srcu_node *snp;
-	struct srcu_node *snp_leaf = smp_load_acquire(&sdp->mynode);
+	struct srcu_node *snp_leaf;
 	unsigned long snp_seq;
 
+	/* Ensure that snp node tree is fully initialized before traversing it */
+	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
+		snp_leaf = NULL;
+	else
+		snp_leaf = sdp->mynode;
+
 	if (snp_leaf)
 		/* Each pass through the loop does one level of the srcu_node tree. */
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
@@ -889,10 +895,13 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	bool needgp = false;
 	unsigned long s;
 	struct srcu_data *sdp;
+	struct srcu_node *sdp_mynode;
+	int ss_state;
 
 	check_init_srcu_struct(ssp);
 	idx = srcu_read_lock(ssp);
-	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_CALL)
+	ss_state = smp_load_acquire(&ssp->srcu_size_state);
+	if (ss_state < SRCU_SIZE_WAIT_CALL)
 		sdp = per_cpu_ptr(ssp->sda, 0);
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
@@ -912,10 +921,17 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		needexp = true;
 	}
 	spin_unlock_irqrestore_rcu_node(sdp, flags);
+
+	/* Ensure that snp node tree is fully initialized before traversing it */
+	if (ss_state < SRCU_SIZE_WAIT_BARRIER)
+		sdp_mynode = NULL;
+	else
+		sdp_mynode = sdp->mynode;
+
 	if (needgp)
 		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
 	else if (needexp)
-		srcu_funnel_exp_start(ssp, smp_load_acquire(&sdp->mynode), s);
+		srcu_funnel_exp_start(ssp, sdp_mynode, s);
 	srcu_read_unlock(ssp, idx);
 	return s;
 }
-- 
2.31.1.189.g2e36527f23

