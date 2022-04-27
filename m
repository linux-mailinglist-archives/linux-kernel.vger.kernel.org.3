Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6C7512141
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241872AbiD0QKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242389AbiD0QJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:09:37 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF32405140
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:04:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0B2D7223E7;
        Wed, 27 Apr 2022 16:04:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 61D2D21F9F;
        Wed, 27 Apr 2022 16:04:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1651075447; a=rsa-sha256;
        cv=none;
        b=oE4/eYuVeaJ2KYE9fSE0kD4JCcam6C1aYfdxXTxV44ibAtsvaZyNyu6aMKO/FzKEELIrWa
        YL/RDivFomk6dQ+Pw3a0MRQjGUk3j5M5tUYx7gFaeD/V1N184ckl7HZRB3VvlmuZJMGZjX
        g6oplm2Tf8MellBAQMjG4/EP9iZ9MP9TDb/Y0gZTnhSwvWkPVH0fcRPWxHttQonMDzkTWe
        NgJYpZjpohhCZ/Cm+k7iHyZjPc2GTrw9ffPaWEDzB9RRgZ3jn1RUHwSN9sSUsHrAzV+Gmc
        /7/Y9pTQmWO+QU0LlpE/J58z+sgl/bZ+m9nBM/NuvoQ3X706sO799tgT5FUvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1651075447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=Uvp1MoIDxRwfyiiSGHGRQ4gYo8x9mwyv7eCgEPV1zO0=;
        b=RbHqLHXtEwPcNNv3suFUs6Gp5uNblrlSbNsaioYDCh4WmPM2HLM2TkenlkOTZ2D6T6QNGj
        I435ikvkZp6UnC/rlT+kqGBQt9dgyISDJmjwPz3lIcwLMN3zs8DLZqY4vBQbE8sgn1x/I9
        1SMr20Cp6CA6+GEHuu3YPUdIlIsQNNiev7a7UdZZ4hOND5nJMUdRJe+t6DSJYTAQ7sbGTV
        WDwg0yMhM16qKjP8JSh7wAsBsydxIqPFHXiSol8lgMHKy5z+K6BbcdP+Az2naJFI3qSUeR
        dq+yT92M6l/tEKOFPRUudtxa6keKj43xtNvzX8+H4GgAAVDz67b0yC3b8pl70w==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-bjm76;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.219 (trex/6.7.1);
        Wed, 27 Apr 2022 16:04:09 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Whimsical: 246176ba0657823e_1651075449593_3172805847
X-MC-Loop-Signature: 1651075449593:2693619741
X-MC-Ingress-Time: 1651075449592
Received: from localhost.localdomain (50-203-181-99-static.hfc.comcastbusiness.net [50.203.181.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4KpNpt4rXGz18t;
        Wed, 27 Apr 2022 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1651075446;
        bh=Uvp1MoIDxRwfyiiSGHGRQ4gYo8x9mwyv7eCgEPV1zO0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=WEzxdZn3Ln8nNYYdCh0hV4gGGCq8BWKzLo0IzIcpfHskebXwtGDni8hL+UxuHV+gB
         hxIEm11RkfDo8IkRnQdrJuGJ/QHJAs8n80wMzoSSRI6jqJjRjWIwuqmX8+5HmEDcv0
         JpNrLA+gCcusmGl/1+aWaEHmGuD/NGiGbzUR90yXJ9BcaHE4Do1NcVbw2XCDmng8Fc
         FRP8xQvHEJnnlGesjeywt/m1FrLzmAXi3DfHvJG0ISvQ5r4mSfMj1ZsMRmTrI17oYf
         TXTxzrZee7e4iqI0N0zWi8PJKG9WFfWxX/gPZslTi9YG/8DAfG3W2x/DUNx5FJilu/
         uIgK8ybVHmvOQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     peterz@infradead.org
Cc:     namhyung@kernel.org, longman@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, mingo@kernel.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] locking/rwsem: Teach contention tracing about optimistic spinning
Date:   Wed, 27 Apr 2022 08:52:40 -0700
Message-Id: <20220427155241.26410-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the mutex counterpart, we can further distinguish the
types of contention. Similarly this patch also introduces potentially
various _begin() tracepoints with a single respective _end().

- The original _begin() for down_write() is moved further up,
right after we know optimistic spinning is bust.

- For the scenario that spins after setting the hand-off bit and
failing to grab the lock the code is change to duplicate the
rwsem_try_write_lock() upon a OWNER_NULL, which minimizes the
amounts of _begin() in the wait-loop - but also gets rid of a
goto label and the logic is pretty encapsulated in the branch.
In such cases the common case will be to acquire the lock,
but if it is stolen in that window, this path won't see the
signal_pending() now in the iteration and block. This should
be benign as the check will come in after waking if the lock
can still not be taken.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
rtmutexes' top waiter will also do optimitic spinning, but
I don't think it is worth adding tracepoints here as it
is quite minimal, unlike the osq stuff.

 include/trace/events/lock.h |  4 +++-
 kernel/locking/rwsem.c      | 29 +++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 9ebd081e057e..0f68a3e69a9f 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -15,6 +15,7 @@
 #define LCB_F_RT	(1U << 3)
 #define LCB_F_PERCPU	(1U << 4)
 #define LCB_F_MUTEX	(1U << 5)
+#define LCB_F_RWSEM	(1U << 6)
 
 
 #ifdef CONFIG_LOCKDEP
@@ -115,7 +116,8 @@ TRACE_EVENT(contention_begin,
 				{ LCB_F_WRITE,		"WRITE" },
 				{ LCB_F_RT,		"RT" },
 				{ LCB_F_PERCPU,		"PERCPU" },
-				{ LCB_F_MUTEX,		"MUTEX" }
+				{ LCB_F_MUTEX,		"MUTEX" },
+				{ LCB_F_RWSEM,		"RWSEM" }
 			  ))
 );
 
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 9d1db4a54d34..c38f990cacea 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1057,7 +1057,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	if (!wake_q_empty(&wake_q))
 		wake_up_q(&wake_q);
 
-	trace_contention_begin(sem, LCB_F_READ);
+	trace_contention_begin(sem, LCB_F_RWSEM | LCB_F_READ);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -1101,9 +1101,14 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_can_spin_on_owner(sem) && rwsem_optimistic_spin(sem)) {
-		/* rwsem_optimistic_spin() implies ACQUIRE on success */
-		return sem;
+	if (rwsem_can_spin_on_owner(sem)) {
+		trace_contention_begin(sem,
+				       LCB_F_RWSEM | LCB_F_WRITE | LCB_F_SPIN);
+		if (rwsem_optimistic_spin(sem)) {
+			/* rwsem_optimistic_spin() implies ACQUIRE on success */
+			trace_contention_end(sem, 0);
+			return sem;
+		}
 	}
 
 	/*
@@ -1115,6 +1120,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
 	waiter.handoff_set = false;
 
+	trace_contention_begin(sem, LCB_F_RWSEM | LCB_F_WRITE);
+
 	raw_spin_lock_irq(&sem->wait_lock);
 	rwsem_add_waiter(sem, &waiter);
 
@@ -1137,7 +1144,6 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
-	trace_contention_begin(sem, LCB_F_WRITE);
 
 	for (;;) {
 		if (rwsem_try_write_lock(sem, &waiter)) {
@@ -1161,18 +1167,25 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		if (waiter.handoff_set) {
 			enum owner_state owner_state;
 
+			trace_contention_begin(sem, LCB_F_RWSEM |
+					       LCB_F_WRITE | LCB_F_SPIN);
 			preempt_disable();
 			owner_state = rwsem_spin_on_owner(sem);
 			preempt_enable();
 
-			if (owner_state == OWNER_NULL)
-				goto trylock_again;
+			if (owner_state == OWNER_NULL) {
+				raw_spin_lock_irq(&sem->wait_lock);
+				if (rwsem_try_write_lock(sem, &waiter))
+					break;
+				raw_spin_unlock_irq(&sem->wait_lock);
+			}
+
+			trace_contention_begin(sem, LCB_F_RWSEM | LCB_F_WRITE);
 		}
 
 		schedule();
 		lockevent_inc(rwsem_sleep_writer);
 		set_current_state(state);
-trylock_again:
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.36.0

