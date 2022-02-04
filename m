Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944A64AA476
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378341AbiBDXjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47898 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378234AbiBDXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B4BF61CAA;
        Fri,  4 Feb 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74553C340F8;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=pFRvJEGkCMqV8E4Iw4z3sZVDAdjH8/YPUIbC9N1Jb60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEh5G3viP0ymeb00w5uxfJRn8WqEk0daLHPUYdN3xB1um/Aq+jnPjLew2Ll1aRHUa
         wpIiHFWKCR/25DdfD9x6BCmW+aA5qlmrbW2e0PIH0jI6PVqmQTANgM1va1Zmw8NWEA
         ZTkBOA4aXCTBI2BQv11ggzw/7Pi063/NceP+F8tfDqM9Ov6PTLKSE1bZjL3VGQnHVP
         HziYI69YkL6oAPB1w6/wBQF371seS0BiklxpnZMjVU3nP0NBE4KvxqRtjlkU8I71So
         jF65D0ZRbCY48rE4F7ERPhw2X/DhVDnr18uauGBxnxlQMJyFiHPLlpJA3i62l72g9j
         XLELH21C9vg0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0511B5C0BCB; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/19] srcu: Compute snp_seq earlier in srcu_funnel_gp_start()
Date:   Fri,  4 Feb 2022 15:38:53 -0800
Message-Id: <20220204233902.1902-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, srcu_funnel_gp_start() tests snp->srcu_have_cbs[idx] and then
separately assigns it to the snp_seq local variable.  This commit does
the assignment earlier to simplify the code a bit.  While in the area,
this commit also takes advantage of the 100-character line limit to put
the call to srcu_schedule_cbs_sdp() on a single line.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d1f1ff930acf5..8f55967b58a74 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -708,15 +708,13 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
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

