Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A54BF1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiBVGJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:09:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiBVGJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:09:31 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC6098F6C;
        Mon, 21 Feb 2022 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645510147; x=1677046147;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=djX8wxkJFxPlSpPJqVXmWAPqMbtb4YNhhuMTE7AdUmc=;
  b=I/lGYDoTLYHU76oNYYOVmMG3tzFedl1KnVwgbotYEbmzJtESAjvQrHgZ
   cLcNMKLVjRd0h2Vw2efPWwPap6MPcyKh3kNVyWIgxXV+uN6htLU32hSbw
   IN9Qxd8OL4AEt6C1vLpoDtXjcTVc3Krq7AkGXuvkKMzB27ha7UFWAJcOC
   I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Feb 2022 22:09:06 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 22:09:06 -0800
Received: from localhost (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 21 Feb
 2022 22:09:05 -0800
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
To:     <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <urezki@gmail.com>, <frederic@kernel.org>, <boqun.feng@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH] srcu: Ensure snp nodes tree is fully initialized before traversal
Date:   Tue, 22 Feb 2022 11:39:01 +0530
Message-ID: <20220222060901.24531-1-quic_neeraju@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For configurations where snp node tree is not initialized at
init time (SRCU_SIZING_IS_INIT() is false), srcu_funnel_gp_start()
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
---
 kernel/rcu/srcutree.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e3cb84649b2a..c6ba40370c2c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -818,9 +818,15 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
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
@@ -1008,6 +1014,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	bool needgp = false;
 	unsigned long s;
 	struct srcu_data *sdp;
+	struct srcu_node *sdp_mynode;
 
 	check_init_srcu_struct(ssp);
 	idx = srcu_read_lock(ssp);
@@ -1031,10 +1038,17 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		needexp = true;
 	}
 	spin_unlock_irqrestore_rcu_node(sdp, flags);
+
+	/* Ensure that snp node tree is fully initialized before traversing it */
+	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
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
2.17.1

