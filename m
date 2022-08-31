Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3E5A8544
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiHaSPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiHaSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FCDEEF1B;
        Wed, 31 Aug 2022 11:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 74B7DCE2059;
        Wed, 31 Aug 2022 18:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BCCC43153;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=KuPCDZDlslpAEicML1omMI9g8VsZjZDGBIoeSeH7tzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBc4SVsEXrVsOj6xMNA3CYQyJFu9AR0xAAs28Yo3gMF1s3LSF0KP6yZs3MXh0OyP8
         Ix+9avzZ8WbyJZdnRzKsCcP+yqwPw16zDsMThPMZDdwZkTl6deL8Ha4CjuoTJuaiFw
         mB0TwfbBRKVLkQdFH1FQu6YKYMOt6ZPKY5CPlmbqJqt87bMOaCIX4sK3lCuICvYzvQ
         EwmgKwS8g6zESqR4HeKJ5z6B9N9QSinbv/TOVNwG6pevr1eHKe+Xmj7vvO5FdfHK5b
         2Cr4Btr59ccKfQ9qCr6eFl3nzfO9yBvAUXM0DD1vOz73DnMng6I+v8C/f2W8GGcA6L
         IE4tdmDh7FVxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 734A35C0DA6; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 15/25] rcu-tasks: Remove grace-period fast-path rcu-tasks helper
Date:   Wed, 31 Aug 2022 11:12:00 -0700
Message-Id: <20220831181210.2695080-15-paulmck@kernel.org>
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

Now that the grace-period fast path can only happen during the
pre-scheduler portion of early boot, this fast path can no longer block
run-time RCU Tasks and RCU Tasks Trace grace periods.  This commit
therefore removes the conditional cond_resched_tasks_rcu_qs() invocation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03b089184b37e..0ff7d5eaa3761 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3492,8 +3492,6 @@ void synchronize_rcu(void)
 		// which allows reuse of ->gp_seq_polled_snap.
 		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_snap);
 		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_snap);
-		if (rcu_init_invoked())
-			cond_resched_tasks_rcu_qs();
 		return;  // Context allows vacuous grace periods.
 	}
 	if (rcu_gp_is_expedited())
-- 
2.31.1.189.g2e36527f23

