Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD04F887E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiDGUdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiDGUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:33:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54148F707
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:17:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37F41B82988
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601C1C385A4;
        Thu,  7 Apr 2022 20:17:47 +0000 (UTC)
Date:   Thu, 7 Apr 2022 16:17:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
Message-ID: <20220407161745.7d6754b3@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[
  This is an RFC patch. As we hit a few bugs were del_timer() is called
  instead of del_timer_sync() before the timer is freed, and there could
  be bugs where even del_timer_sync() is used, but the timer gets rearmed,
  I decided to introduce a "del_timer_free()" function that can be used
  instead. This will at least educate developers on what to call before they
  free a structure that holds a timer.

  In this RFC, I modified hci_qca.c as a use case, even though that change
  needs some work, because the workqueue could still rearm it (I'm looking
  to see if I can trigger the warning).

  If this approach is acceptable, then I will remove the hci_qca.c portion
  from this patch, and create a series of patches to use the
  del_timer_free() in all the locations in the kernel that remove the timer
  before freeing.
]

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

We are hitting a common bug were a timer is being triggered after it is
freed. This causes a corruption in the timer link list and crashes the
kernel. Unfortunately it is not easy to know what timer it was that was
freed. Looking at the code, it appears that there are several cases that
del_timer() is used when del_timer_sync() should have been.

Add a del_timer_free() that not only does a del_timer_sync() but will mark
the timer as freed in case it gets rearmed, it will trigger a WARN_ON. The
del_timer_free() is more likely to be used by developers that are about to
free a timer, then using del_timer_sync() as the latter is not as obvious
to being needed for freeing. Having the word "free" in the name of the
function will hopefully help developers know that that function needs to
be called before freeing.

The added bonus is the marking of the timer as being freed such that it
will trigger a warning if it gets rearmed. At least that way if the system
crashes on a freed timer, at least we may see which timer it was that was
freed.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/bluetooth/hci_qca.c |  4 ++--
 include/linux/timer.h       |  8 ++++---
 kernel/time/timer.c         | 42 +++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f6e91fb432a3..8b3e57fd0f9f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -696,8 +696,8 @@ static int qca_close(struct hci_uart *hu)
 	skb_queue_purge(&qca->tx_wait_q);
 	skb_queue_purge(&qca->txq);
 	skb_queue_purge(&qca->rx_memdump_q);
-	del_timer(&qca->tx_idle_timer);
-	del_timer(&qca->wake_retrans_timer);
+	del_timer_free(&qca->tx_idle_timer);
+	del_timer_free(&qca->wake_retrans_timer);
 	destroy_workqueue(qca->workqueue);
 	qca->hu = NULL;
 
diff --git a/include/linux/timer.h b/include/linux/timer.h
index fda13c9d1256..cc76ab0659f3 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -67,11 +67,12 @@ struct timer_list {
 #define TIMER_DEFERRABLE	0x00080000
 #define TIMER_PINNED		0x00100000
 #define TIMER_IRQSAFE		0x00200000
+#define TIMER_FREED		0x00400000
 #define TIMER_INIT_FLAGS	(TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
-#define TIMER_ARRAYSHIFT	22
-#define TIMER_ARRAYMASK		0xFFC00000
+#define TIMER_ARRAYSHIFT	23
+#define TIMER_ARRAYMASK		0xFF800000
 
-#define TIMER_TRACE_FLAGMASK	(TIMER_MIGRATING | TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
+#define TIMER_TRACE_FLAGMASK	(TIMER_MIGRATING | TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE | TIMER_FREED)
 
 #define __TIMER_INITIALIZER(_function, _flags) {		\
 		.entry = { .next = TIMER_ENTRY_STATIC },	\
@@ -170,6 +171,7 @@ static inline int timer_pending(const struct timer_list * timer)
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
 extern int del_timer(struct timer_list * timer);
+extern int del_timer_free(struct timer_list *timer);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer_pending(struct timer_list *timer, unsigned long expires);
 extern int timer_reduce(struct timer_list *timer, unsigned long expires);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 85f1021ad459..0477e8237a0a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -966,6 +966,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 
 	BUG_ON(!timer->function);
 
+	WARN_ON(timer->flags & TIMER_FREED);
+
 	/*
 	 * This is a common optimization triggered by the networking code - if
 	 * the timer is re-modified to have the same timeout or ends up in the
@@ -1392,6 +1394,46 @@ int del_timer_sync(struct timer_list *timer)
 EXPORT_SYMBOL(del_timer_sync);
 #endif
 
+/**
+ * del_timer_free - Release the timer for freeing
+ * @timer: the timer to be deactivated for freeing
+ *
+ * This is the same as del_timer_sync() but should be called
+ * instead if the timer is to be freed afterward. If the
+ * timer gets rearmed before freeing, it will trigger a WARN_ON().
+ *
+ * The function returns whether it has deactivated a pending timer or not.
+ */
+int del_timer_free(struct timer_list *timer)
+{
+	struct timer_base *base;
+	unsigned long flags;
+	int ret;
+
+	debug_assert_init(timer);
+
+	for (;;) {
+		ret = -1;
+		base = lock_timer_base(timer, &flags);
+
+		if (base->running_timer != timer)
+			ret = detach_if_pending(timer, base, true);
+
+		if (ret >= 0) {
+			timer->flags |= TIMER_FREED;
+			raw_spin_unlock_irqrestore(&base->lock, flags);
+			break;
+		}
+
+		raw_spin_unlock_irqrestore(&base->lock, flags);
+
+		del_timer_wait_running(timer);
+		cpu_relax();
+	}
+
+	return ret;
+}
+
 static void call_timer_fn(struct timer_list *timer,
 			  void (*fn)(struct timer_list *),
 			  unsigned long baseclk)
-- 
2.35.1

