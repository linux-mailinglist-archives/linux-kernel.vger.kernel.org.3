Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9E55E447
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbiF1NRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbiF1NQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:16:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C4731904
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:16:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1EB14CE2013
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED22C341CA;
        Tue, 28 Jun 2022 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422213;
        bh=m7a837xnPBWVYPh88S4uGvZ4chIV7fGUbASUuMsuFik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZsHMsgTUEXOL/Ixf4P2fQTf30z5jaU9kMUR9bKZCVWfS98755GU3DuFU+SXgE9HYE
         kwl7lYGeofK8yp8lVlbbuNPemt1b+IvollpidFSvawhmjB4EP1FCmErznNqpL17fac
         lm2teRrPJbJRRD9YrYlNIIV2F/HCPHQnW2ZK+kcXh+EVbcymYacvgkIotMShFUI7tz
         luaSqozoXY2yNdTU8JoKfZDlUBVSxdTwZPYLfupeoUgOBo4/pobwesgDDv9j/qlyxh
         66sCxRIq0wFALfZxOcfYhLKQjh6JjFXkc39aT0C4sHnyUZvZ9IbYKktBk51za/DbWa
         K7leNb2kZ0zrA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marco Elver <elver@google.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 06/20] context_tracking: Rename context_tracking_cpu_set() to ct_cpu_track_user()
Date:   Tue, 28 Jun 2022 15:16:05 +0200
Message-Id: <20220628131619.2109651-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628131619.2109651-1-frederic@kernel.org>
References: <20220628131619.2109651-1-frederic@kernel.org>
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
specific. Also shorten the prefix to align with the new namespace.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/context_tracking.h | 2 +-
 kernel/context_tracking.c        | 4 ++--
 kernel/time/tick-sched.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 7a5f04ae1758..63259fece7c7 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -11,7 +11,7 @@
 
 
 #ifdef CONFIG_CONTEXT_TRACKING
-extern void context_tracking_cpu_set(int cpu);
+extern void ct_cpu_track_user(int cpu);
 
 /* Called with interrupts disabled.  */
 extern void __ct_user_enter(enum ctx_state state);
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 590c920ad57f..d361bd52e4e1 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -228,7 +228,7 @@ void user_exit_callable(void)
 }
 NOKPROBE_SYMBOL(user_exit_callable);
 
-void __init context_tracking_cpu_set(int cpu)
+void __init ct_cpu_track_user(int cpu)
 {
 	static __initdata bool initialized = false;
 
@@ -258,6 +258,6 @@ void __init context_tracking_init(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		context_tracking_cpu_set(cpu);
+		ct_cpu_track_user(cpu);
 }
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 58a11f859ac7..de192dcff828 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -571,7 +571,7 @@ void __init tick_nohz_init(void)
 	}
 
 	for_each_cpu(cpu, tick_nohz_full_mask)
-		context_tracking_cpu_set(cpu);
+		ct_cpu_track_user(cpu);
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					"kernel/nohz:predown", NULL,
-- 
2.25.1

