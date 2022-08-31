Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4A5A8551
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiHaSQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHaSQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114833ECE8;
        Wed, 31 Aug 2022 11:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E4D461BF0;
        Wed, 31 Aug 2022 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61809C433D6;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=nicJ2bfIfXKr9ehxtHXUaWlz+sCDzYP0wUG+MHreSZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rM71sH2vJfF1sA33XvJKPk+V+qI+9v3hyKAmEcdC6DyhIFmFs04S0Y84AtpYnr4vn
         kQoMVf2hPUK1NgGecFpGOCuXOKq47a2YBx42HE+QrFPjRwMcFJX9iLsrpwtijBCebF
         KteMGV44w07nU3SCwjyMBVBDID/bsZsMy1h78hCFwkiPR1tLx8GYkE7xOa5n08HSzd
         iVfFSk/hd7jZ1t/VY1Wap9z6w4gcgfeWGhj5rXwLcoNqKTdEG9c5Q3uURSRD/JfEac
         9mziIirxoXUfwMez6hze0LJowlasHucTbCrDULxGGntS+YnnbwN3jUEco8xQQLmzho
         ROeTnNRcyqPbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7BCFB5C0EAC; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 20/25] rcutorture: Adjust rcu_poll_need_2gp() for rcu_gp_oldstate field removal
Date:   Wed, 31 Aug 2022 11:12:05 -0700
Message-Id: <20220831181210.2695080-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that rcu_gp_oldstate can accurately track both normal and
expedited grace periods regardless of system state, rcutorture's
rcu_poll_need_2gp() function need only call for a second grace period
for the old single-unsigned-long grace-period polling APIs
This commit therefore adjusts rcu_poll_need_2gp() accordingly.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8995429c6f1c2..029de67a9da91 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -520,7 +520,7 @@ static void rcu_sync_torture_init(void)
 
 static bool rcu_poll_need_2gp(bool poll, bool poll_full)
 {
-	return poll || (!IS_ENABLED(CONFIG_TINY_RCU) && poll_full && num_online_cpus() <= 1);
+	return poll;
 }
 
 static struct rcu_torture_ops rcu_ops = {
-- 
2.31.1.189.g2e36527f23

