Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B29A4664F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358427AbhLBOQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358416AbhLBOQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:16:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD60AC06174A;
        Thu,  2 Dec 2021 06:12:39 -0800 (PST)
Date:   Thu, 02 Dec 2021 14:12:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638454357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csYVQafTdx01GSKRuFhZr2eIZc8k+6uIMaIRkhSBh50=;
        b=RWhfHfHA6dW7wwUc0L5BV7wftRYqCWcBwwVtxZe7RfGTAcHsQIO9yN+41TEOmukAuW4xAm
        TWGlQ9MXglyxv0FHlAHggKuArIfvcG1NeMnnAYdj3izvpuj8PJ4EcuBxPtD5hV+R/td8PC
        s2bh4hc+50cyzAQL0oLcXxq7isensfdCY5MbQBJ2PdJ1JX42MLfGsbJDKhsInBzWyte8Y+
        hf28xIsGwI+VFjuEk7X/zgT6KW9r2NIoghgeMsxaFXHgYwSqNlDBTf35oFgkCzroa1HW4s
        l5sCglI/HmgU8PR79KIBVPE3QUGosEUFAmayvmCOkSqn0YVhDqyo26dghhjQsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638454357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csYVQafTdx01GSKRuFhZr2eIZc8k+6uIMaIRkhSBh50=;
        b=q8FzAcrHB0XzAzvGgAUKM03qIKOoAOWn7ORUcmIfuEv8jpjloHLdsUmBpBUwYcMHtQN2fj
        r9oTR2+uIcS+C/Aw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/nohz: Last resort update jiffies on
 nohz_full IRQ entry
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026141055.57358-2-frederic@kernel.org>
References: <20211026141055.57358-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <163845435662.11128.144783670493021780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     53e87e3cdc155f20c3417b689df8d2ac88d79576
Gitweb:        https://git.kernel.org/tip/53e87e3cdc155f20c3417b689df8d2ac88d79576
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 26 Oct 2021 16:10:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 02 Dec 2021 15:07:22 +01:00

timers/nohz: Last resort update jiffies on nohz_full IRQ entry

When at least one CPU runs in nohz_full mode, a dedicated timekeeper CPU
is guaranteed to stay online and to never stop its tick.

Meanwhile on some rare case, the dedicated timekeeper may be running
with interrupts disabled for a while, such as in stop_machine.

If jiffies stop being updated, a nohz_full CPU may end up endlessly
programming the next tick in the past, taking the last jiffies update
monotonic timestamp as a stale base, resulting in an tick storm.

Here is a scenario where it matters:

0) CPU 0 is the timekeeper and CPU 1 a nohz_full CPU.

1) A stop machine callback is queued to execute somewhere.

2) CPU 0 reaches MULTI_STOP_DISABLE_IRQ while CPU 1 is still in
   MULTI_STOP_PREPARE. Hence CPU 0 can't do its timekeeping duty. CPU 1
   can still take IRQs.

3) CPU 1 receives an IRQ which queues a timer callback one jiffy forward.

4) On IRQ exit, CPU 1 schedules the tick one jiffy forward, taking
   last_jiffies_update as a base. But last_jiffies_update hasn't been
   updated for 2 jiffies since the timekeeper has interrupts disabled.

5) clockevents_program_event(), which relies on ktime_get(), observes
   that the expiration is in the past and therefore programs the min
   delta event on the clock.

6) The tick fires immediately, goto 3)

7) Tick storm, the nohz_full CPU is drown and takes ages to reach
   MULTI_STOP_DISABLE_IRQ, which is the only way out of this situation.

Solve this with unconditionally updating jiffies if the value is stale
on nohz_full IRQ entry. IRQs and other disturbances are expected to be
rare enough on nohz_full for the unconditional call to ktime_get() to
actually matter.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20211026141055.57358-2-frederic@kernel.org

---
 kernel/softirq.c         | 3 ++-
 kernel/time/tick-sched.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 322b65d..41f4709 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -595,7 +595,8 @@ void irq_enter_rcu(void)
 {
 	__irq_enter_raw();
 
-	if (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET))
+	if (tick_nohz_full_cpu(smp_processor_id()) ||
+	    (is_idle_task(current) && (irq_count() == HARDIRQ_OFFSET)))
 		tick_irq_enter();
 
 	account_hardirq_enter(current);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6bffe5a..17a283c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1375,6 +1375,13 @@ static inline void tick_nohz_irq_enter(void)
 	now = ktime_get();
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
+	/*
+	 * If all CPUs are idle. We may need to update a stale jiffies value.
+	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
+	 * alive but it might be busy looping with interrupts disabled in some
+	 * rare case (typically stop machine). So we must make sure we have a
+	 * last resort.
+	 */
 	if (ts->tick_stopped)
 		tick_nohz_update_jiffies(now);
 }
