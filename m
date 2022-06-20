Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BD552766
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346081AbiFTXAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345982AbiFTW7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E676F193F8;
        Mon, 20 Jun 2022 15:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34BFF614AF;
        Mon, 20 Jun 2022 22:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D57C341D4;
        Mon, 20 Jun 2022 22:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765900;
        bh=9Zhp5Ec7GPy63cX8G5KMm0YQJgk1oYOjZcoCMh4LQv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqYy2wKMAB205/QF/lJ3JXYUejq1GfnIAN3GKxG8IW14qMjnllWXDBoH8NZTM9PFp
         c9lyiz2pq6FudWbzIOYtKA3rW6wvON8NiSoY+kbO/Z0TrtSyyp2K8THai1FSPcSfTe
         9uRd+ebBsJ18B4qQryjEFxKtHrIytc/466F9bJYecJsyXxYbYjfaWQGhjQQEy70UEq
         uoSKmiaqlUEOXJjmf8tq27acBymOY/KcLOk2Okpa/PO6/qwE3wk0p2/PYTyIagyAzL
         +gomfM+Vs5UumLOFouHBCcdqVq1r7gE1blCmYGrb/n86r8OM8uESiiLg4lrla7pXnr
         3utqLi+42B9bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AB12C5C0E3F; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/12] refscale: Convert test_lock spinlock to raw_spinlock
Date:   Mon, 20 Jun 2022 15:58:17 -0700
Message-Id: <20220620225817.3843106-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
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

From: Zqiang <qiang1.zhang@intel.com>

In kernels built with CONFIG_PREEMPT_RT=y, spinlocks are replaced by
rt_mutex, which can sleep.  This means that acquiring a non-raw spinlock
in a critical section where preemption is disabled can trigger the
following BUG:

BUG: scheduling while atomic: ref_scale_reade/76/0x00000002
Preemption disabled at:
ref_lock_section+0x16/0x80
Call Trace:
<TASK>
dump_stack_lvl+0x5b/0x82
dump_stack+0x10/0x12
__schedule_bug.cold+0x9c/0xad
__schedule+0x839/0xc00
schedule_rtlock+0x22/0x40
rtlock_slowlock_locked+0x460/0x1350
rt_spin_lock+0x61/0xe0
ref_lock_section+0x29/0x80
rcu_scale_one_reader+0x52/0x60
ref_scale_reader+0x28d/0x490
kthread+0x128/0x150
ret_from_fork+0x22/0x30
</TASK>

This commit therefore converts spinlock to raw_spinlock.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 909644abee67f..435c884c02b5c 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -385,7 +385,7 @@ static struct ref_scale_ops rwsem_ops = {
 };
 
 // Definitions for global spinlock
-static DEFINE_SPINLOCK(test_lock);
+static DEFINE_RAW_SPINLOCK(test_lock);
 
 static void ref_lock_section(const int nloops)
 {
@@ -393,8 +393,8 @@ static void ref_lock_section(const int nloops)
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		spin_lock(&test_lock);
-		spin_unlock(&test_lock);
+		raw_spin_lock(&test_lock);
+		raw_spin_unlock(&test_lock);
 	}
 	preempt_enable();
 }
@@ -405,9 +405,9 @@ static void ref_lock_delay_section(const int nloops, const int udl, const int nd
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		spin_lock(&test_lock);
+		raw_spin_lock(&test_lock);
 		un_delay(udl, ndl);
-		spin_unlock(&test_lock);
+		raw_spin_unlock(&test_lock);
 	}
 	preempt_enable();
 }
@@ -427,8 +427,8 @@ static void ref_lock_irq_section(const int nloops)
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		spin_lock_irqsave(&test_lock, flags);
-		spin_unlock_irqrestore(&test_lock, flags);
+		raw_spin_lock_irqsave(&test_lock, flags);
+		raw_spin_unlock_irqrestore(&test_lock, flags);
 	}
 	preempt_enable();
 }
@@ -440,9 +440,9 @@ static void ref_lock_irq_delay_section(const int nloops, const int udl, const in
 
 	preempt_disable();
 	for (i = nloops; i >= 0; i--) {
-		spin_lock_irqsave(&test_lock, flags);
+		raw_spin_lock_irqsave(&test_lock, flags);
 		un_delay(udl, ndl);
-		spin_unlock_irqrestore(&test_lock, flags);
+		raw_spin_unlock_irqrestore(&test_lock, flags);
 	}
 	preempt_enable();
 }
-- 
2.31.1.189.g2e36527f23

