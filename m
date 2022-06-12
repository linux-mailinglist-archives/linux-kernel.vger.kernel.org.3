Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC68754783B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 04:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiFLCCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 22:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiFLCCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 22:02:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE74D110F;
        Sat, 11 Jun 2022 19:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654999362; x=1686535362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iKrCwgb9uS93jd0NsZKfGCrvtHPpYo5dR2R538MRcS8=;
  b=WKULbeeQbrxnQxSgbwhW5IFNydULTA8Yeja5OZlbAKLztMEGgpFxaKMd
   gU6pQn0HFl3fDkvsiDswGME7NsIF/VtSw1DhvJzXauet/+vpR2+6543PD
   Tc/QkWoadmJie6p0AQPlkMghRc76WDAcxZF8y6q5lippypI7Pm/+GC2GC
   SiTNMx3xWwIVBL1dF8ZW1vXjgzWpIZvSALqgNYRlXojjYhEI27GqnWq46
   NICgFlaNEZ9ejTkMy5iTddZLIqtuV/vcDquiJqXF1BI8OK0i6lNFI8nt0
   4+nqFeenzAj6XilPAIyrfT2+YLXd+h7JsHHBq9JmiRtxEOat93BTwxM43
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="276748766"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="276748766"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 19:02:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="638955602"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 19:02:39 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     joel@joelfernandes.org, paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] refscale: Convert test_lock spinlock to raw_spinlock
Date:   Sun, 12 Jun 2022 10:02:25 +0800
Message-Id: <20220612020225.3098239-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In PREEMPT_RT kernel, the spinlock are replaced by sleepable rt_mutex.
in a critical section where preemption is disabled this will trigger
calltrace like the following:

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

Convert spinlock to raw_spinlock to fix it.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/refscale.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 909644abee67..435c884c02b5 100644
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
2.25.1

