Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88614AA4AB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378548AbiBDXxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378387AbiBDXxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5477C06C946;
        Fri,  4 Feb 2022 15:53:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AC9061CB0;
        Fri,  4 Feb 2022 23:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEE4C004E1;
        Fri,  4 Feb 2022 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018809;
        bh=i+LxFoL2qy6w9Z6qXm97npWTHpaECn1x9fpv8uaHWLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtlIY3rBngLczfbKFTlPCFAj8EvD0haosiuYGppIqRSqygHBkmYjauNpMchkOOV1y
         5wSulHuw57pxs7FDo3hs3RY2XqibxCc4kmaIJwLshAfoiOjegnzMmJ0/yQLiTpaKtu
         tPbZ8GU0PUzdtI5Wek7B75QakcuMXzr2U1DnisoGYmANrWUczcdMGlTnArrg+3PZqe
         Vy6dd5zNSFO/x5xOLHElO/V8YxqtWC/6adSO3Km/PZXidqCjdTxeujHEgepO837r5S
         /HsfTqoKQxAX4p0WgEz9Akz5nCfucv4w6D6eNztNxlx49rnAW/mGzERVKvigg1hIwe
         I+mLJyp9GZmqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 728485C0418; Fri,  4 Feb 2022 15:53:29 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/8] rcutorture: Print message before invoking ->cb_barrier()
Date:   Fri,  4 Feb 2022 15:53:20 -0800
Message-Id: <20220204235327.2948-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various ->cb_barrier() functions, for example, rcu_barrier(),
sometimes cause rcutorture hangs.  But currently, the last console
message is the unenlightening "Stopping rcu_torture_stats".  This commit
therefore prints a message of the form "rcu_torture_cleanup: Invoking
rcu_barrier+0x0/0x1e0()" to help point people in the right direction.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 422f7e4cc08de..00400aef58184 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2905,8 +2905,10 @@ rcu_torture_cleanup(void)
 	int i;
 
 	if (torture_cleanup_begin()) {
-		if (cur_ops->cb_barrier != NULL)
+		if (cur_ops->cb_barrier != NULL) {
+			pr_info("%s: Invoking %pS().\n", __func__, cur_ops->cb_barrier);
 			cur_ops->cb_barrier();
+		}
 		return;
 	}
 	if (!cur_ops) {
@@ -2961,8 +2963,10 @@ rcu_torture_cleanup(void)
 	 * Wait for all RCU callbacks to fire, then do torture-type-specific
 	 * cleanup operations.
 	 */
-	if (cur_ops->cb_barrier != NULL)
+	if (cur_ops->cb_barrier != NULL) {
+		pr_info("%s: Invoking %pS().\n", __func__, cur_ops->cb_barrier);
 		cur_ops->cb_barrier();
+	}
 	if (cur_ops->cleanup != NULL)
 		cur_ops->cleanup();
 
-- 
2.31.1.189.g2e36527f23

