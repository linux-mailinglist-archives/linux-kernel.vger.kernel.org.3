Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F765A854B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiHaSP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiHaSOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:14:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D109CF14D0;
        Wed, 31 Aug 2022 11:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 472AFB8227B;
        Wed, 31 Aug 2022 18:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE8DC43158;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=eQALP+6nah6BViSpqOqdrb0bckX7LhhhIQ1zzCaGtj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUw0kg02gBGahufpc1gIh/nb9EO9XNC7nAWI5q7q2vVZnLEvkRjnxf767al2tzBkc
         q5trO0bg9kzNhL8CVsVxK3i7jAzNVfd4IA3diA8jhGRljGvcLJmcP9B3bYPyWpg55F
         CYw2DTZVY2ibr4CpqZebAOBEGRfZ/Gx8YK1NW8qBZ0tfOHhBk+5IDDSxfZromczsag
         GlgnPpZacHM0suz1jrBAD5Hm++vk+xIb2PySR6wI7qMuGe+khV+ErT+afp+DD1+HmF
         OblFBJu2ts9txXwN1WDKOg3GlmroqXzao84g8m7Yc7aNQkI0oFsIkZKY7r8G+pc8u9
         9+JOOJJ6PHasQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 76B585C0DF4; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 17/25] rcu: Remove expedited grace-period fast-path forward-progress helper
Date:   Wed, 31 Aug 2022 11:12:02 -0700
Message-Id: <20220831181210.2695080-17-paulmck@kernel.org>
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

Now that the expedited grace-period fast path can only happen during
the pre-scheduler portion of early boot, this fast path can no longer
block run-time RCU Trace grace periods.  This commit therefore removes
the conditional cond_resched() invocation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 9c0ae834ef076..1a51f9301ebff 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -924,8 +924,6 @@ void synchronize_rcu_expedited(void)
 		// them, which allows reuse of ->gp_seq_polled_exp_snap.
 		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_exp_snap);
 		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_exp_snap);
-		if (rcu_init_invoked())
-			cond_resched();
 		return;  // Context allows vacuous grace periods.
 	}
 
-- 
2.31.1.189.g2e36527f23

