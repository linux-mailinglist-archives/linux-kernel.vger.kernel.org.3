Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3E94AE4A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388172AbiBHWc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386219AbiBHTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:59 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E651C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id qe15so135630pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+nDZJr8SEJtsWfN1yVA4KOFdHwD0VQADvkkthoRg+M=;
        b=KIWKaeu5lVDhyRByVq+Pe2NXQKxY7H7Aa5F2qlk9aEux7BT74ca5PXzOVfwTMs8G0d
         aIQ/1GcK0JRJBaF5uURR1HltBeHPcOSTkM+qj2Wy2E2pVBP2v1/zaiXMgUvue/Uo5xt+
         YABUPItp8vr+PKjsZfQRekvc/Uo4MSz6cnYvNxWYFCmDeQdeWEcIV2qwsZgCZQNazxRB
         7GjDpffuHBV+YJNDTRnZViM6bl+vVxv1pwIxFmP8Qfps1Dk3ZcJAflTlrUHisnm9REo2
         Cyb3jnnlNXscoB2YoKpvgdpT9OeYaWYj3SlrnSkaA+OTsgpqORsrfdmey/0HhrZ83jE/
         vQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=m+nDZJr8SEJtsWfN1yVA4KOFdHwD0VQADvkkthoRg+M=;
        b=tt3zlOjdFyQ7I7WpbmLzKqKbO1Ib0EEm4OwUZPC8Pt6jkdoSh9PZ00zZNas2DfnYKu
         plSQ58XHLPik5VqdxTd/BoCXrel35aHu+FkOalGJ/E/oX7Zr3+3JadMU+kCCrNIVFshQ
         I29bAXo3bx6y7ybZupDNeIuJE/LZPZQT1f3DpejJsFRbYyX+n+FaF8zZvZsFMtiENnxO
         vRmG+jKQUtcJb/82h9Xt/+cpHUFUTA0MStQwjINi8MHTognm3WEmP5mZ6WveWs2IiXxz
         hSm/YutCDBdKI9qMGO6OoosG5pJ54NReQ21Bk+zyRIxyfE3SxYpDKfpt2Lkejp9qg5sQ
         GJTQ==
X-Gm-Message-State: AOAM5306b2Iw4TKUY+7dSgR11Us3B0yGfxXE/Un7qkYi8L24Tv5PdgyI
        qUrZ3cxurCKPYlUU8YtIDnk=
X-Google-Smtp-Source: ABdhPJxfAWIl+DPBI2EOdOQgu6DTp1/Md6wPiyy/z2kttS9Zsr3fF3IE+mW+xojQu5VQE4/u/rovaw==
X-Received: by 2002:a17:90b:3b42:: with SMTP id ot2mr3048087pjb.147.1644349437992;
        Tue, 08 Feb 2022 11:43:57 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:57 -0800 (PST)
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
Subject: [PATCH 11/12] locking/mutex: Revive fast functions for CONFIG_LOCK_TRACEPOINTS
Date:   Tue,  8 Feb 2022 11:43:23 -0800
Message-Id: <20220208194324.85333-12-namhyung@kernel.org>
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

The CONFIG_LOCK_TRACEPOINTS used the same path as CONFIG_DEBUG_ALLOC
or CONFIG_LOCKDEP but it caused performance impact on mutex as it
removes _fast variants at the beginning.

I'm not entirely sure why it removed the fast versions when lockdep is
on.  It seems easy to add the required annotation when the fast
version is succeeded as far as the tracpoints are concerned.

It reduces around 2% of elapsed time when I ran a micro-benchmark.  It
was `perf bench sched messaging -p -l 1000000` and it had a pretty low
lock contention rate (under 1% of total lock acquisition).  So the
improvement should come from the fast path.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/mutex.h  |  2 +-
 kernel/locking/mutex.c | 30 ++++++++++++++++++++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index b2d018250a41..49bde305453e 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -172,7 +172,7 @@ do {							\
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
  */
-#ifdef CONFIG_LOCK_INFO
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
 extern void _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest_lock);
 
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 8733b96ce20a..f8bc4ae312a0 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -149,7 +149,7 @@ static inline bool __mutex_trylock(struct mutex *lock)
 	return !__mutex_trylock_common(lock, false);
 }
 
-#ifndef CONFIG_LOCK_INFO
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * Lockdep annotations are contained to the slow paths for simplicity.
  * There is nothing that would stop spreading the lockdep annotations outwards
@@ -245,7 +245,7 @@ static void __mutex_handoff(struct mutex *lock, struct task_struct *task)
 	}
 }
 
-#ifndef CONFIG_LOCK_INFO
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * We split the mutex lock/unlock logic into separate fastpath and
  * slowpath functions, to reduce the register pressure on the fastpath.
@@ -281,6 +281,8 @@ void __sched mutex_lock(struct mutex *lock)
 
 	if (!__mutex_trylock_fast(lock))
 		__mutex_lock_slowpath(lock);
+	else
+		mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 }
 EXPORT_SYMBOL(mutex_lock);
 #endif
@@ -533,9 +535,11 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  */
 void __sched mutex_unlock(struct mutex *lock)
 {
-#ifndef CONFIG_LOCK_INFO
-	if (__mutex_unlock_fast(lock))
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
+	if (__mutex_unlock_fast(lock)) {
+		mutex_release(&lock->dep_map, _RET_IP_);
 		return;
+	}
 #endif
 	__mutex_unlock_slowpath(lock, _RET_IP_);
 }
@@ -591,7 +595,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		if (ww_ctx->acquired == 0)
 			ww_ctx->wounded = 0;
 
-#ifdef CONFIG_LOCK_INFO
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 		nest_lock = &ww_ctx->dep_map;
 #endif
 	}
@@ -778,7 +782,7 @@ int ww_mutex_trylock(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
 }
 EXPORT_SYMBOL(ww_mutex_trylock);
 
-#ifdef CONFIG_LOCK_INFO
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __sched
 mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 {
@@ -937,7 +941,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	wake_up_q(&wake_q);
 }
 
-#ifndef CONFIG_LOCK_INFO
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * Here come the less common (and hence less performance-critical) APIs:
  * mutex_lock_interruptible() and mutex_trylock().
@@ -964,8 +968,10 @@ int __sched mutex_lock_interruptible(struct mutex *lock)
 {
 	might_sleep();
 
-	if (__mutex_trylock_fast(lock))
+	if (__mutex_trylock_fast(lock)) {
+		mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 		return 0;
+	}
 
 	return __mutex_lock_interruptible_slowpath(lock);
 }
@@ -988,8 +994,10 @@ int __sched mutex_lock_killable(struct mutex *lock)
 {
 	might_sleep();
 
-	if (__mutex_trylock_fast(lock))
+	if (__mutex_trylock_fast(lock)) {
+		mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 		return 0;
+	}
 
 	return __mutex_lock_killable_slowpath(lock);
 }
@@ -1078,7 +1086,7 @@ int __sched mutex_trylock(struct mutex *lock)
 }
 EXPORT_SYMBOL(mutex_trylock);
 
-#ifndef CONFIG_LOCK_INFO
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
 int __sched
 ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
@@ -1087,6 +1095,7 @@ ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	if (__mutex_trylock_fast(&lock->base)) {
 		if (ctx)
 			ww_mutex_set_context_fastpath(lock, ctx);
+		mutex_acquire(&lock->base.dep_map, 0, 0, _RET_IP_);
 		return 0;
 	}
 
@@ -1102,6 +1111,7 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	if (__mutex_trylock_fast(&lock->base)) {
 		if (ctx)
 			ww_mutex_set_context_fastpath(lock, ctx);
+		mutex_acquire(&lock->base.dep_map, 0, 0, _RET_IP_);
 		return 0;
 	}
 
-- 
2.35.0.263.gb82422642f-goog

