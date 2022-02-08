Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4614AE129
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiBHSnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385203AbiBHSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:42:41 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB91C0613CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:42:40 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c10so1544162pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YblOd1MvT8NiXh69QNSwkAqyNRZA5ZxOXoJicXqw4d8=;
        b=NmS6X3F31vgYNbuvcdntXgrQDZoNYzdGA3tlzav9IIoi3N7XJZD9ch+GwUFveURRO2
         SROdeY6g0phlVdCYFSm7tHfzc2bnxucgeidgKsbSPIVqIz82VL7kjq/jujlpBo1zW8Yj
         0FVqx74858ngYvm1FafXinri2hKxU80QWAMRlgCnzjAEQ+eZg2iB2DUR9g9ASjrWe3XH
         ti0FdUij8/Y/YQLdin+Ha1/OlT2Wx+0V066N4D8JrADhJr5fR6hfdtC3YZ6I2mgF8cQZ
         hO5cb/8pEB5tL8YHGqxPPWbviDFmHcbCcpf3dQWE1K8kn6sFJq+P6BocsRXus8tVxji+
         EFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YblOd1MvT8NiXh69QNSwkAqyNRZA5ZxOXoJicXqw4d8=;
        b=dihZTktS99yy6VhodAYac5asmp4Gb6Po14ZXBWcDeJ0PNw16lxe2dAvHJOt0DGd6d6
         ucLKbuu5gDhsRj/Kwrhuej+cte5hStNvZO8T+738+KZHjeM++aH93TwkIiwFn2ratJHE
         01ownudYJ1TjXZuIr7+EmZZY1lE7aWZ6qgt8+oE6Vq9eIONN1kl1d0GrG7d9Wikg46Xk
         Wcm2eLxl3rh7Yfuu1/aKzRhDd1yGV4ThlOGpshiQnbM8GiVwdaX3zc8jmXWf6t9ZODW1
         Fx2vxHHbr9GtFW2ii46SJqjkn+LJHhnoN6ihEERYdE0igfdjEus5axN7MA2zkmlcKRz6
         Sv7Q==
X-Gm-Message-State: AOAM532hBCIxcjY0KKYwMymzhOVpMx8HcNBAb1H1GQlWa5fEqsXvmmld
        Z49W7dGzANDkRFB36e86EtA=
X-Google-Smtp-Source: ABdhPJxQBzd9hdEXIalI27JyMmk9v8rfHzVUxtK1Qw9o5ag3vEDO7T2BDzJVlNsoq2zRUL9/fCbNdw==
X-Received: by 2002:a63:ec58:: with SMTP id r24mr4592854pgj.353.1644345760093;
        Tue, 08 Feb 2022 10:42:40 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id l14sm3517027pjf.1.2022.02.08.10.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:42:39 -0800 (PST)
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
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: [PATCH 12/12] locking: Move lock_acquired() from the fast path
Date:   Tue,  8 Feb 2022 10:42:08 -0800
Message-Id: <20220208184208.79303-13-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184208.79303-1-namhyung@kernel.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
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

