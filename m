Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2EB4A68E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbiBBABQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:01:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35166 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiBBABP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:01:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42A5DB82FB7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 00:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AB9C340ED;
        Wed,  2 Feb 2022 00:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643760073;
        bh=qUVF7kTyEancPlf3zp+fG1Apgn/5q8QCxp97FRG2MdY=;
        h=From:To:Cc:Subject:Date:From;
        b=LAdzJN/By+BPbYN6+X/5P6s6zE1Cy8Lk2GUCFfuZd4D4U68XWXy3Fv05MIKqetlTl
         U/SAIcBOf/QgTkD1a9rPNAB0o96LsmXiY8J0em+yqIHjvLCnpxuGbQKg5g9dmpKc1F
         jXfwdDhwhD9/4h9/MWXzjusebQe3qUnYwO3uAGiDdmnfH563eGM7ceerK9J2pHJf0m
         IK77uxEl/onQ37MjegMAufFG5/6bKlJNEfdPRxFjyYG0QeswflQT/J6b/3iFVAcuPj
         VwjB8WnuFT6DKgbWoWMlYgRO2pcAqDwHQvk+zrsw9WzBh+Fv2oRzxpdJLqWB/Zso8Z
         0lxkqh3LdwI9A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] tick: Detect and fix jiffies update stall
Date:   Wed,  2 Feb 2022 01:01:07 +0100
Message-Id: <20220202000107.416695-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some rare cases, the timekeeper CPU may be delaying its jiffies
update duty for a while. Known causes include:

* The timekeeper is waiting on stop_machine in a MULTI_STOP_DISABLE_IRQ
  or MULTI_STOP_RUN state. Disabled interrupts prevent from timekeeping
  updates while waiting for the target CPU to complete its
  stop_machine() callback.

* The timekeeper vcpu has VMEXIT'ed for a long while due to some overload
  on the host.

Detect and fix these situations with emergency timekeeping catchups.

Original-patch-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/tick-sched.c | 17 +++++++++++++++++
 kernel/time/tick-sched.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 17a283ce2b20..c89f50a7e690 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -169,6 +169,8 @@ static ktime_t tick_init_jiffy_update(void)
 	return period;
 }
 
+#define MAX_STALLED_JIFFIES 5
+
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu = smp_processor_id();
@@ -196,6 +198,21 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	if (tick_do_timer_cpu == cpu)
 		tick_do_update_jiffies64(now);
 
+	/*
+	 * If jiffies update stalled for too long (timekeeper in stop_machine()
+	 * or VMEXIT'ed for several msecs), force an update.
+	 */
+	if (ts->last_tick_jiffies != jiffies) {
+		ts->stalled_jiffies = 0;
+		ts->last_tick_jiffies = READ_ONCE(jiffies);
+	} else {
+		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
+			tick_do_update_jiffies64(now);
+			ts->stalled_jiffies = 0;
+			ts->last_tick_jiffies = READ_ONCE(jiffies);
+		}
+	}
+
 	if (ts->inidle)
 		ts->got_idle_tick = 1;
 }
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index d952ae393423..504649513399 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -49,6 +49,8 @@ enum tick_nohz_mode {
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @next_timer:		Expiry time of next expiring timer for debugging purpose only
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
+ * @last_tick_jiffies:	Value of jiffies seen on last tick
+ * @stalled_jiffies:	Number of stalled jiffies detected across ticks
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
@@ -77,6 +79,8 @@ struct tick_sched {
 	u64				next_timer;
 	ktime_t				idle_expires;
 	atomic_t			tick_dep_mask;
+	unsigned long			last_tick_jiffies;
+	unsigned int			stalled_jiffies;
 };
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
-- 
2.25.1

