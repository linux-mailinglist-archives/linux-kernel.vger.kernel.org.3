Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A1F50606B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiDSADR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiDSAC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172F913CDC;
        Mon, 18 Apr 2022 17:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 758FC612A0;
        Tue, 19 Apr 2022 00:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAE3C385B4;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326416;
        bh=d8BookNJh/O4qU39WT4SVwBgry0u2pt1lr7SQzvjnkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTmmCdR/7pN5hzrQK2g+6jsxLyKLU+7QwtwM+OzzNSX3KNYpZPdA3BqGL/NEypEhZ
         wI18v5qZESaM1SFEBTKsgIPmDOfkmjSoR5I1qFpbOO4BsNglKmgPo37SfTWbxjGiwi
         alMc4vTUdNB0mKBxmrPt2ygaONntkH9q2v5jsGP/ojmu51XbTR/tWEYGNPrAZN6S6b
         3lhGhOKz/OtDxBOxAu5vwy8bj7huAGyZ4tsW7U87iTY2Wy8MK8LNYBRgKrYvlI5xxw
         sLfcSZGbyNRwL9UqboiohZOSN3O3JjVc/E+fxc14EP3tIXC9gENeQ21jfvFsN1Rh68
         iPAx3FGXDSCvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E12025C0B86; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 6/9] rcu-tasks: Restore use of timers for non-RT kernels
Date:   Mon, 18 Apr 2022 17:00:11 -0700
Message-Id: <20220419000014.3948512-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
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

The use of hrtimers for RCU-tasks grace-period delays works well in
general, but can result in excessive grace-period delays for some
corner-case workloads.  This commit therefore reverts to the use of
timers for non-RT kernels to mitigate those grace-period delays.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 71fe340ab82a..405614039515 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -654,9 +654,13 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 
 		// Slowly back off waiting for holdouts
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
-		exp = jiffies_to_nsecs(fract);
-		__set_current_state(TASK_IDLE);
-		schedule_hrtimeout_range(&exp, jiffies_to_nsecs(HZ / 2), HRTIMER_MODE_REL_HARD);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			schedule_timeout_idle(fract);
+		} else {
+			exp = jiffies_to_nsecs(fract);
+			__set_current_state(TASK_IDLE);
+			schedule_hrtimeout_range(&exp, jiffies_to_nsecs(HZ / 2), HRTIMER_MODE_REL_HARD);
+		}
 
 		if (fract < HZ)
 			fract++;
-- 
2.31.1.189.g2e36527f23

