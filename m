Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DDC506079
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiDSAGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbiDSAGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B2F220F8;
        Mon, 18 Apr 2022 17:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8DC06123D;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC447C385B3;
        Tue, 19 Apr 2022 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326605;
        bh=ujAyuo2Re7IiLXwCepAV8QiIbPdUJSCn6Diz0hsqCNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AV0vI7xIYHF0tgRnGAl6JjQxa7Y2KKctEbDxKMBJx83p4cePocEWqio+4xmY4T6P+
         MqN69opFiefUgRsSTFCrdMkxRGY+axXe7VVG6LTMbpu0mKqN/fT4wiA9jNO+TvypyF
         7iIvn2+9qxdZ31k7PL3dlrUXNy+esLOuYLY897kGFESzxAuOwj9dTLyWsUNKzeglsV
         4TUC4YkNaExhdwkIAJPKLhR2d8rrUuRer0HzOHcIdJARAXvS89vmpHOqoCfcBmBqFe
         Ij/zXN4vr8gC/7Pvps0ZyQfrVLcRfspT8xsb+fZd0lQTuRJsc9WQ3XRcCTNU/7PA5n
         CxMfi90UHq4nA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5B7A05C121E; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 08/21] srcu: Compute snp_seq earlier in srcu_funnel_gp_start()
Date:   Mon, 18 Apr 2022 17:03:09 -0700
Message-Id: <20220419000322.3948903-8-paulmck@kernel.org>
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

Currently, srcu_funnel_gp_start() tests snp->srcu_have_cbs[idx] and then
separately assigns it to the snp_seq local variable.  This commit does
the assignment earlier to simplify the code a bit.  While in the area,
this commit also takes advantage of the 100-character line limit to put
the call to srcu_schedule_cbs_sdp() on a single line.

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0874e3be6a5a..fec608f69962 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -697,15 +697,13 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
 				return; /* GP already done and CBs recorded. */
 			spin_lock_irqsave_rcu_node(snp, flags);
-			if (ULONG_CMP_GE(snp->srcu_have_cbs[idx], s)) {
-				snp_seq = snp->srcu_have_cbs[idx];
+			snp_seq = snp->srcu_have_cbs[idx];
+			if (ULONG_CMP_GE(snp_seq, s)) {
 				if (snp == snp_leaf && snp_seq == s)
 					snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
 				spin_unlock_irqrestore_rcu_node(snp, flags);
 				if (snp == snp_leaf && snp_seq != s) {
-					srcu_schedule_cbs_sdp(sdp, do_norm
-								   ? SRCU_INTERVAL
-								   : 0);
+					srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0);
 					return;
 				}
 				if (!do_norm)
-- 
2.31.1.189.g2e36527f23

