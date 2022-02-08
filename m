Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1134AE490
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377028AbiBHWeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386224AbiBHToD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:44:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14669C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:44:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n23so321745pfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YblOd1MvT8NiXh69QNSwkAqyNRZA5ZxOXoJicXqw4d8=;
        b=oFWxPltJgO7Yyjjqxn8nZJZOd67ZLTQvioVscHLVnXkmdXa7iezFJuEhtQLNA1/g3j
         EFngKn54zgAF+trHsmNcjk3jMcWhVtFT0yX3iEJpoRotKrbKH4Pk7H8n/jr4xIZUF63j
         1dRyduxXMMhbl1Chu1b/1pvRWwQ7iHNFPsqQDUTCePMPICjmZxRsHur+mIbSI5dLw8CO
         Nh1NEeFvfcU4jnVlqed/v6LuOdfRyE+zdlI220FrxUoGpFXvLTWeyB44tDkof33lSASK
         4gPy7MC07EK0zZ/so08sD/vnkTuNpDaSf+5BmQ8QzEbMAwWmmy2HUDdpBKaD0LQuy6XR
         7RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YblOd1MvT8NiXh69QNSwkAqyNRZA5ZxOXoJicXqw4d8=;
        b=w/y3QK/zmnX7BKzFxExT4AGI1A4Q0DHkAIOhF++tTaVTdLiufkPU8CK3F8WPI4xNyp
         pIgmhHtVOyd7drzDYVwqFiZK0vWfL4iwr9r5akrm5Iu4E9JtYdlRO2ha6j+877+SdV+v
         bau1bKx7bvOadtsgMxWqwysnRFPr8FRu9VVfDwCFzHWObm8G5G4KA9xIhdTsDvnAQ66A
         /r1cjKMWwVX1izWZEROSFmjyH1DoNog56zPe1Km670uNBQqVVqtGPq7XZH1stG3hsX38
         //LQyyiZkkRNgdPws454BK7+zYpY4WVXSmdth3UH9Wgg4q+7ti9sZHh581ZVU8KoCI8F
         t7/w==
X-Gm-Message-State: AOAM533nCzwqU9FxSJ+B9onXsIuBeQHzBsUcfEWxKv9cmwE2M2E4vp6K
        37KxEFPOzO3UMc3UubWwMpE=
X-Google-Smtp-Source: ABdhPJwUo0N6U6Zq/adD98J6NPWalNyeAX/ePj0YT7DO2jYUnhPNw4w625Hk8Jxpoa3sLKMzFYhILA==
X-Received: by 2002:a63:a102:: with SMTP id b2mr4753591pgf.459.1644349441578;
        Tue, 08 Feb 2022 11:44:01 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:44:01 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: [PATCH 12/12] locking: Move lock_acquired() from the fast path
Date:   Tue,  8 Feb 2022 11:43:24 -0800
Message-Id: <20220208194324.85333-13-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208194324.85333-1-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock_acquired() function is used by CONFIG_LOCK_STAT to track wait
time for contended locks.  So it's meaningful only if the given lock
is in the slow path (contended).  Let's move the call into the if
block so that we can skip it in the fast path.  This also move the
tracepoint to be called only after lock_contended().

It might affect bounce_acquired stats rarely (if it's on a different
cpu than when you call lock_acquire) but I'm not sure it's possible in
uncontended cases.  Otherwise, this should have no functional changes
in the LOCKDEP and LOCK_STAT.

Userspace tools that use the tracepoint might see the difference, but
I think most of them can handle the missing lock_acquired() in
non-contended case properly as it's the case when using a trylock
function to grab a lock.  At least it seems ok for the perf
tools ('perf lock' command specifically).

Add similar change in the __mutex_lock_common() so that it can call
lock_acquired() only after lock_contended().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 Documentation/locking/lockstat.rst |  4 ++--
 include/linux/lockdep.h            | 12 ++++++------
 kernel/locking/mutex.c             |  4 +---
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/locking/lockstat.rst b/Documentation/locking/lockstat.rst
index 536eab8dbd99..3638ad1113c2 100644
--- a/Documentation/locking/lockstat.rst
+++ b/Documentation/locking/lockstat.rst
@@ -28,11 +28,11 @@ The graph below shows the relation between the lock functions and the various
             |    __contended
             |         |
             |       <wait>
+            |         |
+            |    __acquired
             | _______/
             |/
             |
-       __acquired
-            |
             .
           <hold>
             .
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 4e728d2957db..63b75ad2e17c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -559,8 +559,8 @@ do {								\
 	if (!try(_lock)) {					\
 		lock_contended(&(_lock)->dep_map, _RET_IP_);	\
 		lock(_lock);					\
+		lock_acquired(&(_lock)->dep_map, _RET_IP_);	\
 	}							\
-	lock_acquired(&(_lock)->dep_map, _RET_IP_);			\
 } while (0)
 
 #define LOCK_CONTENDED_RETURN(_lock, try, lock)			\
@@ -569,9 +569,9 @@ do {								\
 	if (!try(_lock)) {					\
 		lock_contended(&(_lock)->dep_map, _RET_IP_);	\
 		____err = lock(_lock);				\
+		if (!____err)					\
+			lock_acquired(&(_lock)->dep_map, _RET_IP_); \
 	}							\
-	if (!____err)						\
-		lock_acquired(&(_lock)->dep_map, _RET_IP_);	\
 	____err;						\
 })
 
@@ -600,8 +600,8 @@ do {								\
 	if (!try(_lock)) {					\
 		lock_contended(&(_lock)->dep_map, _RET_IP_);	\
 		lock(_lock);					\
+		lock_acquired(&(_lock)->dep_map, _RET_IP_);	\
 	}							\
-	lock_acquired(&(_lock)->dep_map, _RET_IP_);		\
 } while (0)
 
 #define LOCK_CONTENDED_RETURN(_lock, try, lock)			\
@@ -610,9 +610,9 @@ do {								\
 	if (!try(_lock)) {					\
 		lock_contended(&(_lock)->dep_map, _RET_IP_);	\
 		____err = lock(_lock);				\
+		if (!____err)					\
+			lock_acquired(&(_lock)->dep_map, _RET_IP_); \
 	}							\
-	if (!____err)						\
-		lock_acquired(&(_lock)->dep_map, _RET_IP_);	\
 	____err;						\
 })
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index f8bc4ae312a0..e67b5a16440b 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -605,8 +605,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	if (__mutex_trylock(lock) ||
 	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
-		/* got the lock, yay! */
-		lock_acquired(&lock->dep_map, ip);
 		if (ww_ctx)
 			ww_mutex_set_context_fastpath(ww, ww_ctx);
 		preempt_enable();
@@ -708,10 +706,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	debug_mutex_free_waiter(&waiter);
 
-skip_wait:
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
 
+skip_wait:
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
-- 
2.35.0.263.gb82422642f-goog

