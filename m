Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6573A506003
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiDRW72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiDRW7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675392CE3C;
        Mon, 18 Apr 2022 15:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1375611CA;
        Mon, 18 Apr 2022 22:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E177C385A7;
        Mon, 18 Apr 2022 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322604;
        bh=W+quTVxJ1vAv3v7CzdiXe19ytpEERvKdahUOk+MXpvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=As1R+lzJ0X7Uph9qPJB5XuxNH0+Ej+ucJ7AZO9bBoEK+mFRkqZKVk+4LpRW5n0sYv
         OroTAnTDDCPOCBLHGn0F+2OTFpzUYBPt7KQRY4QuqiS6eZid2Pg4lUVVJY0yyZXpii
         qALEBlOjViE0nij2uU8HeoxY2kkXVcxyg34PvpVbxz6GUJgwMD5ejLntYpX3kfZHww
         w/iW43mNdJ2f/nupn1sRZ2pu3SA0+Vcg7aBHir0DogDEOjFvnTw26zDh5O57PoCVDO
         3NlKCqTHlGFFSm8pU2YE6nb0Cw3zejh556NnNQCVp9ajfXnPKcVvpfdRS8pJ7JBfbT
         cG7tEV4C+aIpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0A8B45C04BD; Mon, 18 Apr 2022 15:56:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/5] rcu: Remove rcu_is_nocb_cpu()
Date:   Mon, 18 Apr 2022 15:56:38 -0700
Message-Id: <20220418225642.3945539-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225633.GA3945428@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225633.GA3945428@paulmck-ThinkPad-P17-Gen-1>
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

From: Frederic Weisbecker <frederic@kernel.org>

The rcu_is_nocb_cpu() function is no longer used, so this commmit
removes it.

Reported-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h       | 2 --
 kernel/rcu/tree_nocb.h | 8 --------
 2 files changed, 10 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 24b5f2c2de87..4c53a2ccf711 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -538,10 +538,8 @@ extern struct workqueue_struct *rcu_par_gp_wq;
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
 #ifdef CONFIG_RCU_NOCB_CPU
-bool rcu_is_nocb_cpu(int cpu);
 void rcu_bind_current_to_nocb(void);
 #else
-static inline bool rcu_is_nocb_cpu(int cpu) { return false; }
 static inline void rcu_bind_current_to_nocb(void) { }
 #endif
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 636d0546a4e9..02e1d05a11fc 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -215,14 +215,6 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 	init_swait_queue_head(&rnp->nocb_gp_wq[1]);
 }
 
-/* Is the specified CPU a no-CBs CPU? */
-bool rcu_is_nocb_cpu(int cpu)
-{
-	if (cpumask_available(rcu_nocb_mask))
-		return cpumask_test_cpu(cpu, rcu_nocb_mask);
-	return false;
-}
-
 static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 			   struct rcu_data *rdp,
 			   bool force, unsigned long flags)
-- 
2.31.1.189.g2e36527f23

