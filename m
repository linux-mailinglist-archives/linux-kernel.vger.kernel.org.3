Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5474AA4A8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiBDXxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:53:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45758 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378359AbiBDXxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13AA2B83975;
        Fri,  4 Feb 2022 23:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35BBC340F1;
        Fri,  4 Feb 2022 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018809;
        bh=gMEkExdEIHtGZYJMcRMC5CtUw2Kr5Mwkvh0M24YUqF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KhV/RYYSsjDjI0qNGqJ2DYRoSz3pTf8cKxagRcd+9QoYKmI3uUV7Mam1AktBDSs6K
         6y8L3f429/ykLR6JpaWRKCrcJEqzKXn8T9jmM6VKzwJ7QbbZDGU69Z0ErpSS6J489J
         bqvvHrLbHICjkSINdERcgRtIuHeE6DCFtvsEyn2b4xW3rU50bZp5dTAHw7JxZ1eeNx
         hYc2itObZwxmBahnDjoGJD9HoPbcZrU95Nm5omIRgNjdsMGAIDObXCcHlSmRD3vN/h
         toLSPJFe5M/VX/kf22JQRro5foc+1Y3DnQWzp7hGFEG7e0uv2DCiJ8rEvz46O2CfhS
         gnX/siPw5wkQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 78C555C08B7; Fri,  4 Feb 2022 15:53:29 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/8] rcutorture: Increase visibility of forward-progress hangs
Date:   Fri,  4 Feb 2022 15:53:22 -0800
Message-Id: <20220204235327.2948-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a few pr_alert() calls to rcutorture's forward-progress
testing in order to better diagnose shutdown-time hangs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 00400aef58184..fefc3fa1a9c2a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2281,6 +2281,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 	unsigned long stopat;
 	static DEFINE_TORTURE_RANDOM(trs);
 
+	pr_alert("%s: Starting forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
 	if (!cur_ops->sync)
 		return; // Cannot do need_resched() forward progress testing without ->sync.
 	if (cur_ops->call && cur_ops->cb_barrier) {
@@ -2325,6 +2326,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 	if (selfpropcb) {
 		WRITE_ONCE(fcs.stop, 1);
 		cur_ops->sync(); /* Wait for running CB to complete. */
+		pr_alert("%s: Waiting for CBs: %pS() %d\n", __func__, cur_ops->cb_barrier, rfp->rcu_fwd_id);
 		cur_ops->cb_barrier(); /* Wait for queued callbacks. */
 	}
 
@@ -2353,6 +2355,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	unsigned long stopat;
 	unsigned long stoppedat;
 
+	pr_alert("%s: Starting forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
 	if (READ_ONCE(rcu_fwd_emergency_stop))
 		return; /* Get out of the way quickly, no GP wait! */
 	if (!cur_ops->call)
@@ -2414,6 +2417,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	n_launders_cb_snap = READ_ONCE(rfp->n_launders_cb);
 	cver = READ_ONCE(rcu_torture_current_version) - cver;
 	gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
+	pr_alert("%s: Waiting for CBs: %pS() %d\n", __func__, cur_ops->cb_barrier, rfp->rcu_fwd_id);
 	cur_ops->cb_barrier(); /* Wait for callbacks to be invoked. */
 	(void)rcu_torture_fwd_prog_cbfree(rfp);
 
-- 
2.31.1.189.g2e36527f23

