Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C174CA984
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiCBPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240947AbiCBPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:49:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20172AE2C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:48:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7112EB81F2D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5583C340F9;
        Wed,  2 Mar 2022 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236112;
        bh=sghz13J/8bJAY7L5jSCMCXvKJR3AKRsJVjaLCKwNr+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOf5HNzu1268TOts63/QhT6/WYeL1qBrOajum/6T8DLGBuwyrJrDT6yIW3H/ChBxJ
         ry6brVwSWJ+Cf6OUqEuXyxDzyB5pvAJ0/WcpfsyLdTjEnzHykYONVFvnrY36FRLFPH
         FoyI6Pt/dB7m6wzpHu6v8zZk/WCSCqDC/EKbF0NeJ4RxrBfA1JAyNl1BXJZblkQQMc
         dotLufc4/OAcdcdRTyyy3jIl0+bN5v8zVDaJiiUjqoZix27oIezjM4oj1HURcz932R
         n+yyRgRn61FeGycIXj8Q1Zb/zyw0+jaBhC6zY9Ij+72W8a056lFzdNw5kAWZSF9NYH
         smDARTytc7zYQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 04/19] context_tracking: Rename context_tracking_cpu_set() to context_tracking_cpu_track_user()
Date:   Wed,  2 Mar 2022 16:47:55 +0100
Message-Id: <20220302154810.42308-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302154810.42308-1-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

context_tracking_cpu_set() is called in order to tell a CPU to track
user/kernel transitions. Since context tracking is going to expand in
to also track transitions from/to idle/IRQ/NMIs, the scope
of this function name becomes too broad and needs to be made more
specific.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 include/linux/context_tracking.h | 2 +-
 kernel/context_tracking.c        | 4 ++--
 kernel/time/tick-sched.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 7a5f04ae1758..40badd62ad56 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -11,7 +11,7 @@
 
 
 #ifdef CONFIG_CONTEXT_TRACKING
-extern void context_tracking_cpu_set(int cpu);
+extern void context_tracking_cpu_track_user(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index e8e58c10f135..7b6643d2075d 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -198,7 +198,7 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init context_tracking_cpu_set(int cpu)
+void __init context_tracking_cpu_track_user(int cpu)
 {
 	static __initdata bool initialized = false;
 
@@ -228,6 +228,6 @@ void __init context_tracking_init(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		context_tracking_cpu_set(cpu);
+		context_tracking_cpu_track_user(cpu);
 }
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2d76c91b85de..794410da3ee1 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -571,7 +571,7 @@ void __init tick_nohz_init(void)
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
-		context_tracking_cpu_set(cpu);
+		context_tracking_cpu_track_user(cpu);
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"kernel/nohz:predown", NULL,
-- 
2.25.1

