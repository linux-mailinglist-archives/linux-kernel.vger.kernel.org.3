Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68B24AA480
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378533AbiBDXjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39394 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378252AbiBDXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25D41B83978;
        Fri,  4 Feb 2022 23:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F668C340FE;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=YN9frrNfF3TNUCGWsBeNYaG+rDwqFVcfd14+/Fo20Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PjK+j/73QG6IlGAiD5JlVVRmH6wiDABPzi4FaSPGtxoTDAclRBs7ZcklPNAFHfV+6
         OM0HoFpgK8/MZtbXYBytOM1pgCniSPJGvVX0ZPNhK+CqCwZpG3FccpYesNhuhyQNY9
         RsXmvKCE1wALd8AvBTu18ExVHxaQXH33Sf1FQRtNRY4gO2JLZ4lsKE4dWdDzaFkE/s
         Wa7WixFfyWFK6co9bcZ8C4qZaeEGLlhXkXVnCPKFR73T9SsC7tpwwxwu+T2G+9mIHh
         LRN82d8P/7fwwmjw3UYst6MxbtNGPe8Qd2zzXMXgPPkQvpscehT/rmteaCMLYvX2ag
         848KAyZG8nVGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0C9B75C0FCA; Fri,  4 Feb 2022 15:39:04 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 14/19] srcu: Explain srcu_funnel_gp_start() call to list_add() is safe
Date:   Fri,  4 Feb 2022 15:38:57 -0800
Message-Id: <20220204233902.1902-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a comment explaining why an unprotected call to
list_add() from srcu_funnel_gp_start() can be safe.  TL;DR: It is only
called during very early boot when we don't have no steeking concurrency!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 39dc3015dfeba..d16104405c8f9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -757,6 +757,12 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
+
+		// And how can that list_add() in the "else" clause
+		// possibly be safe for concurrent execution?  Well,
+		// it isn't.  And it does not have to be.  After all, it
+		// can only be executed during early boot when there is only
+		// the one boot CPU running with interrupts still disabled.
 		if (likely(srcu_init_done))
 			queue_delayed_work(rcu_gp_wq, &ssp->work,
 					   srcu_get_delay(ssp));
-- 
2.31.1.189.g2e36527f23

