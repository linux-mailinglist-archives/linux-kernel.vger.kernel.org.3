Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D85A4D3110
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiCIOia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiCIOi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:38:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0951C638B;
        Wed,  9 Mar 2022 06:37:29 -0800 (PST)
Date:   Wed, 9 Mar 2022 15:37:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646836648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XeKLByoAc1u1XmlVztQtMK5+4qmQfYNGgQmNQElVMMk=;
        b=HsVGXHRr+wYG4KIGe+6DuqwL4WzDm5dLlE6VrJ18PiONJuKrlxViig0oIn4etMvMy5icgy
        Z6ctbOgl6yBrUjGfRWoC/uw1ru1cYFTuG6+xh/PqfBFDl6KDKzJnwM/VGw6aZy8s4AUwTT
        mjePrir8nZ/5lHZy02YWHXltTLegSn5dcuFMfQtqgbBgvjtdpAEaYhoJ67D500IVDKb2fd
        RNTuVV7ciEqb521x6RG5DEC9DVHXU4u+o6Eb3rPu7tkFF9qGoAF+S63wfVntFk6RxhQfsr
        u3A3ovdYhtBukkqrNGAxmbY/OW+fOlJh8QpZUkGejITc74sc5TFBLfxw+F0IzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646836648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XeKLByoAc1u1XmlVztQtMK5+4qmQfYNGgQmNQElVMMk=;
        b=XwF3eNMiyInmTZx6J4TA6B0vO6bajBmxJdioGXo7pG1P8SZ0MIRGMG3TRELPTZIW6J9DTk
        cK1bpLRmA9Kz6+CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.17-rc7-rt13
Message-ID: <Yii7pvkj7o8L1uTQ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.17-rc7-rt13 patch set. 

Changes since v5.17-rc7-rt12:

  - Instead of spawning ksoftirqd early, adjust the RCU-tasks timeout
    after discussion with upstream.

Known issues
     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.17-rc7-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/incr/patch-5.17-rc7-rt12-rt13.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.17-rc7-rt13

The RT patch against v5.17-rc7 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patch-5.17-rc7-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.17/older/patches-5.17-rc7-rt13.tar.xz

Sebastian

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index e286e6b6fdf9b..db4a23d07a571 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -600,7 +600,6 @@ asmlinkage void __do_softirq(void);
 
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
-extern void softirq_spawn_ksoftirqd(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
 
 extern void raise_softirq_irqoff(unsigned int nr);
diff --git a/init/main.c b/init/main.c
index a0014b8bae203..65fa2e41a9c09 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1598,7 +1598,6 @@ static noinline void __init kernel_init_freeable(void)
 
 	init_mm_internals();
 
-	softirq_spawn_ksoftirqd();
 	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
 	lockup_detector_init();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f804afb304135..e99f9e61cc7a3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -630,12 +630,15 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	while (!list_empty(&holdouts)) {
 		bool firstreport;
 		bool needreport;
+		ktime_t exp;
 		int rtst;
 
 		/* Slowly back off waiting for holdouts */
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
-		schedule_timeout_idle(fract);
-
+		exp = jiffies_to_nsecs(fract);
+		__set_current_state(TASK_IDLE);
+		schedule_hrtimeout_range(&exp, jiffies_to_nsecs(HZ / 2),
+					 HRTIMER_MODE_REL_HARD);
 		if (fract < HZ)
 			fract++;
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 32c1c503b9d65..22948c2109f5b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -1037,14 +1037,17 @@ static struct smp_hotplug_thread timer_threads = {
         .thread_comm            = "ktimers/%u",
 };
 
-__init void softirq_spawn_ksoftirqd(void)
+static __init int spawn_ksoftirqd(void)
 {
 	cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
 				  takeover_tasklets);
 	BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		BUG_ON(smpboot_register_percpu_thread(&timer_threads));
+
+	return 0;
 }
+early_initcall(spawn_ksoftirqd);
 
 /*
  * [ These __weak aliases are kept in a separate compilation unit, so that
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
