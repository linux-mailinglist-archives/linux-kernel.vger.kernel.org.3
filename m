Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BB850608A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiDSAHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbiDSAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096292316D;
        Mon, 18 Apr 2022 17:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8E6AB81144;
        Tue, 19 Apr 2022 00:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CC9C385B7;
        Tue, 19 Apr 2022 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=iyJn1yotRTIEBfPDSDKM1gy8KIt7R7cfA59bZDZBO2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=euaXErJ69GFH6SlFDJuLr/ePnr2+HVSW6yPG5axeuTidfP0r4h446YoAGVF+1aaFK
         v1TwbP6g2eZEUJ7g3uI8kn6tQ9qDCvifV8SwrwgwblmqimBV8xSvzKADlweP8kn8pE
         FdjUWroN4Y0ijSlueKAaBvnoekeFZnUn4ZVUywtaDTWKQkoyomaRQVJnkLaO/N7yH3
         7kVhatnB2aCpLoG5OTtofT6JrRP8513O8lD7+MwEhIVLL0CUSBfFQGvlRGfCEV8JZi
         TQy5t5a3g3+ODBEbCezLyF+7854E+6Z5fY/8F0geBH7c12WfgZV+uNLgtj0PxOHPLl
         uJ23XKnhP/1+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D4CB5C12AB; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 09/21] srcu: Use invalid initial value for srcu_node GP sequence numbers
Date:   Mon, 18 Apr 2022 17:03:10 -0700
Message-Id: <20220419000322.3948903-9-paulmck@kernel.org>
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

Currently, tree SRCU relies on the srcu_node structures being initialized
at the same time that the srcu_struct itself is initialized, and thus
use the initial grace-period sequence number as the initial value for
the srcu_node structure's ->srcu_have_cbs[] and ->srcu_gp_seq_needed_exp
fields.  Although this has a high probability of also working when the
srcu_node array is allocated and initialized at some random later time,
it would be better to avoid leaving such things to chance.

This commit therefore initializes these fields with 0x2, which is a
recognizable invalid value.  It then adds the required checks for this
invalid value in order to avoid confusion on long-running kernels
(especially those on 32-bit systems) that allocate and initialize
srcu_node arrays late in life.

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index fec608f69962..155c430c6a73 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -107,6 +107,18 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 	}
 }
 
+/* Invalid seq state, used during snp node initialization */
+#define SRCU_SNP_INIT_SEQ		0x2
+
+/*
+ * Check whether sequence number corresponding to snp node,
+ * is invalid.
+ */
+static inline bool srcu_invl_snp_seq(unsigned long s)
+{
+	return rcu_seq_state(s) == SRCU_SNP_INIT_SEQ;
+}
+
 /*
  * Allocated and initialize SRCU combining tree.  Returns @true if
  * allocation succeeded and @false otherwise.
@@ -139,10 +151,10 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp)
 		WARN_ON_ONCE(ARRAY_SIZE(snp->srcu_have_cbs) !=
 			     ARRAY_SIZE(snp->srcu_data_have_cbs));
 		for (i = 0; i < ARRAY_SIZE(snp->srcu_have_cbs); i++) {
-			snp->srcu_have_cbs[i] = 0;
+			snp->srcu_have_cbs[i] = SRCU_SNP_INIT_SEQ;
 			snp->srcu_data_have_cbs[i] = 0;
 		}
-		snp->srcu_gp_seq_needed_exp = 0;
+		snp->srcu_gp_seq_needed_exp = SRCU_SNP_INIT_SEQ;
 		snp->grplo = -1;
 		snp->grphi = -1;
 		if (snp == &ssp->node[0]) {
@@ -386,8 +398,7 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
  */
 static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 {
-	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
-			 READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
+	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
 		return 0;
 	return SRCU_INTERVAL;
 }
@@ -561,6 +572,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	int idx;
 	unsigned long mask;
 	struct srcu_data *sdp;
+	unsigned long sgsne;
 	struct srcu_node *snp;
 	int ss_state;
 
@@ -594,7 +606,8 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 				cbs = snp->srcu_have_cbs[idx] == gpseq;
 			snp->srcu_have_cbs[idx] = gpseq;
 			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
-			if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
+			sgsne = snp->srcu_gp_seq_needed_exp;
+			if (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
 				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
 			mask = snp->srcu_data_have_cbs[idx];
 			snp->srcu_data_have_cbs[idx] = 0;
@@ -652,14 +665,17 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 				  unsigned long s)
 {
 	unsigned long flags;
+	unsigned long sgsne;
 
 	if (snp)
 		for (; snp != NULL; snp = snp->srcu_parent) {
+			sgsne = READ_ONCE(snp->srcu_gp_seq_needed_exp);
 			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
-			    ULONG_CMP_GE(READ_ONCE(snp->srcu_gp_seq_needed_exp), s))
+			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
 				return;
 			spin_lock_irqsave_rcu_node(snp, flags);
-			if (ULONG_CMP_GE(snp->srcu_gp_seq_needed_exp, s)) {
+			sgsne = snp->srcu_gp_seq_needed_exp;
+			if (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)) {
 				spin_unlock_irqrestore_rcu_node(snp, flags);
 				return;
 			}
@@ -687,6 +703,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 {
 	unsigned long flags;
 	int idx = rcu_seq_ctr(s) % ARRAY_SIZE(sdp->mynode->srcu_have_cbs);
+	unsigned long sgsne;
 	struct srcu_node *snp;
 	struct srcu_node *snp_leaf = smp_load_acquire(&sdp->mynode);
 	unsigned long snp_seq;
@@ -698,7 +715,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 				return; /* GP already done and CBs recorded. */
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
-			if (ULONG_CMP_GE(snp_seq, s)) {
+			if (!srcu_invl_snp_seq(snp_seq) && ULONG_CMP_GE(snp_seq, s)) {
 				if (snp == snp_leaf && snp_seq == s)
 					snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
 				spin_unlock_irqrestore_rcu_node(snp, flags);
@@ -713,7 +730,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 			snp->srcu_have_cbs[idx] = s;
 			if (snp == snp_leaf)
 				snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
-			if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
+			sgsne = snp->srcu_gp_seq_needed_exp;
+			if (!do_norm && (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, s)))
 				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
 			spin_unlock_irqrestore_rcu_node(snp, flags);
 		}
-- 
2.31.1.189.g2e36527f23

