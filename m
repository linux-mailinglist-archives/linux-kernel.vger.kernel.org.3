Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F56F5A857E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiHaS0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiHaSZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:25:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F1A2DAC
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 824F6B82274
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274F7C433D7;
        Wed, 31 Aug 2022 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970110;
        bh=PbgqrlZZosHYbW1nGq71ZuCzDyWkjMJCAl8bHAx5ujs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2hHmhTlnhrQBP23DC4aegtGLyEdtj+cabH/135m81FavzC3rZTMlAUHM0+jOTupX
         b5mjGnFAGF0lle8toXNjpYU4hBkGvv1Pi0g5Du3ag+bYnhfgdmSS4EeJmdb51z+CO7
         Ni6QqW3/Z5M6xQLdJk+iRjSqjcwKr9tpR1nYKoUR+bPXe5QTK3IsElV+GCOtDDDIPV
         GOMi4WtfuOqN3ScnYfbFWYH7D/cQqLrgLizFNGF9mF5Cnz+wbUUanCacq5vqy4ykbN
         cR1Zt786nh3WsneWxtNbhNwr8uGftZrf9ThZfkYO/iufD4hIBLVIMyR6+wzwC/N2el
         Ajq5eRSNJhDpg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D35715C02A9; Wed, 31 Aug 2022 11:21:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/2] rcutorture: Use the barrier operation specified by cur_ops
Date:   Wed, 31 Aug 2022 11:21:31 -0700
Message-Id: <20220831182148.2698489-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
References: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
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

From: Zqiang <qiang1.zhang@intel.com>

The rcutorture_oom_notify() function unconditionally invokes
rcu_barrier(), which is OK when the rcutorture.torture_type value is
"rcu", but unhelpful otherwise.  The purpose of these barrier calls is to
wait for all outstanding callback-flooding callbacks to be invoked before
cleaning up their data.  Using the wrong barrier function therefore
risks arbitrary memory corruption.  Thus, this commit changes these
rcu_barrier() calls into cur_ops->cb_barrier() to make things work when
torturing non-vanilla flavors of RCU.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d8e1b270a065f..08b7b59d5d05b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2600,12 +2600,12 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 	for (i = 0; i < fwd_progress; i++)
 		ncbs += rcu_torture_fwd_prog_cbfree(&rfp[i]);
 	pr_info("%s: Freed %lu RCU callbacks.\n", __func__, ncbs);
-	rcu_barrier();
+	cur_ops->cb_barrier();
 	ncbs = 0;
 	for (i = 0; i < fwd_progress; i++)
 		ncbs += rcu_torture_fwd_prog_cbfree(&rfp[i]);
 	pr_info("%s: Freed %lu RCU callbacks.\n", __func__, ncbs);
-	rcu_barrier();
+	cur_ops->cb_barrier();
 	ncbs = 0;
 	for (i = 0; i < fwd_progress; i++)
 		ncbs += rcu_torture_fwd_prog_cbfree(&rfp[i]);
-- 
2.31.1.189.g2e36527f23

