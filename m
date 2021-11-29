Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E468E462675
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhK2Wwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhK2Wud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:50:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA16C0C236C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:48:31 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638208109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OcYBBI8nkxMxvHSK/28zWbxuxTQ3Tjbu26Do7H3X1/A=;
        b=VhxPzAF1WxBK9iA2/4rDbAYy6YZPRQ7rCQnnJGVs/nOSviSCa1zd3JDmBbp24UNTAcY5MB
        d0iXEnI8Yrs7nGzEQltJW5SFxQdA+QN3OEx94TsgP8z8FWdMNkWg26a8QvcmwC3mYEexDV
        ojpecsNcamZiczd9LbBo3dgGdy+vYuM7/QLneUSERpPbnP6T1vTt/ON1qvm2eIdbBkWYiJ
        iju+hcRf8gT1dbw5liNphLRmQ8O8IKjrnaaC8fC3XVMwJp2LWmG0GW+tEewIEQ/lUF7T1w
        hkf8sLUUsFbD7Ka6qy73qJXVR5NxHAn/GtC1Ce4WrKQvBA2rLuCR7sI6NJpArA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638208109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OcYBBI8nkxMxvHSK/28zWbxuxTQ3Tjbu26Do7H3X1/A=;
        b=LPt7OXqlk5nEStmSGjO3PyoggsA9G63QtZY/vox0XOcuJpt4oD2Mh7QktlgN2FsG88zwP4
        gBEg3gxFdNZBmuCQ==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 09/11] lockdep/selftests: Adapt ww-tests for PREEMPT_RT
Date:   Mon, 29 Nov 2021 18:46:52 +0100
Message-Id: <20211129174654.668506-10-bigeasy@linutronix.de>
In-Reply-To: <20211129174654.668506-1-bigeasy@linutronix.de>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ww-mutex selftest operates directly on ww_mutex::base and assumes
its type is struct mutex. This isn't true on PREEMPT_RT which turns the
mutex into a rtmutex.

Add a ww_mutex_base_ abstraction which maps to the relevant mutex_ or
rt_mutex_ function.
Change the CONFIG_DEBUG_MUTEXES ifdef to DEBUG_WW_MUTEXES. The latter is
true for the MUTEX and RTMUTEX implementation of WW-MUTEX. The
assignment is required in order to pass the tests.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/locking-selftest.c | 76 +++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 9031f50905aed..8d24279fad055 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1700,6 +1700,22 @@ static void ww_test_fail_acquire(void)
 #endif
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+#define ww_mutex_base_lock(b)			rt_mutex_lock(b)
+#define ww_mutex_base_trylock(b)		rt_mutex_trylock(b)
+#define ww_mutex_base_lock_nest_lock(b, b2)	rt_mutex_lock_nest_lock(b, b2)
+#define ww_mutex_base_lock_interruptible(b)	rt_mutex_lock_interruptible(b)
+#define ww_mutex_base_lock_killable(b)		rt_mutex_lock_killable(b)
+#define ww_mutex_base_unlock(b)			rt_mutex_unlock(b)
+#else
+#define ww_mutex_base_lock(b)			mutex_lock(b)
+#define ww_mutex_base_trylock(b)		mutex_trylock(b)
+#define ww_mutex_base_lock_nest_lock(b, b2)	mutex_lock_nest_lock(b, b2)
+#define ww_mutex_base_lock_interruptible(b)	mutex_lock_interruptible(b)
+#define ww_mutex_base_lock_killable(b)		mutex_lock_killable(b)
+#define ww_mutex_base_unlock(b)			mutex_unlock(b)
+#endif
+
 static void ww_test_normal(void)
 {
 	int ret;
@@ -1714,50 +1730,50 @@ static void ww_test_normal(void)
=20
 	/* mutex_lock (and indirectly, mutex_lock_nested) */
 	o.ctx =3D (void *)~0UL;
-	mutex_lock(&o.base);
-	mutex_unlock(&o.base);
+	ww_mutex_base_lock(&o.base);
+	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx !=3D (void *)~0UL);
=20
 	/* mutex_lock_interruptible (and *_nested) */
 	o.ctx =3D (void *)~0UL;
-	ret =3D mutex_lock_interruptible(&o.base);
+	ret =3D ww_mutex_base_lock_interruptible(&o.base);
 	if (!ret)
-		mutex_unlock(&o.base);
+		ww_mutex_base_unlock(&o.base);
 	else
 		WARN_ON(1);
 	WARN_ON(o.ctx !=3D (void *)~0UL);
=20
 	/* mutex_lock_killable (and *_nested) */
 	o.ctx =3D (void *)~0UL;
-	ret =3D mutex_lock_killable(&o.base);
+	ret =3D ww_mutex_base_lock_killable(&o.base);
 	if (!ret)
-		mutex_unlock(&o.base);
+		ww_mutex_base_unlock(&o.base);
 	else
 		WARN_ON(1);
 	WARN_ON(o.ctx !=3D (void *)~0UL);
=20
 	/* trylock, succeeding */
 	o.ctx =3D (void *)~0UL;
-	ret =3D mutex_trylock(&o.base);
+	ret =3D ww_mutex_base_trylock(&o.base);
 	WARN_ON(!ret);
 	if (ret)
-		mutex_unlock(&o.base);
+		ww_mutex_base_unlock(&o.base);
 	else
 		WARN_ON(1);
 	WARN_ON(o.ctx !=3D (void *)~0UL);
=20
 	/* trylock, failing */
 	o.ctx =3D (void *)~0UL;
-	mutex_lock(&o.base);
-	ret =3D mutex_trylock(&o.base);
+	ww_mutex_base_lock(&o.base);
+	ret =3D ww_mutex_base_trylock(&o.base);
 	WARN_ON(ret);
-	mutex_unlock(&o.base);
+	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx !=3D (void *)~0UL);
=20
 	/* nest_lock */
 	o.ctx =3D (void *)~0UL;
-	mutex_lock_nest_lock(&o.base, &t);
-	mutex_unlock(&o.base);
+	ww_mutex_base_lock_nest_lock(&o.base, &t);
+	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx !=3D (void *)~0UL);
 }
=20
@@ -1770,7 +1786,7 @@ static void ww_test_two_contexts(void)
 static void ww_test_diff_class(void)
 {
 	WWAI(&t);
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	t.ww_class =3D NULL;
 #endif
 	WWL(&o, &t);
@@ -1834,7 +1850,7 @@ static void ww_test_edeadlk_normal(void)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	o2.ctx =3D &t2;
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
=20
@@ -1850,7 +1866,7 @@ static void ww_test_edeadlk_normal(void)
=20
 	o2.ctx =3D NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 	WWU(&o);
=20
 	WWL(&o2, &t);
@@ -1860,7 +1876,7 @@ static void ww_test_edeadlk_normal_slow(void)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx =3D &t2;
=20
@@ -1876,7 +1892,7 @@ static void ww_test_edeadlk_normal_slow(void)
=20
 	o2.ctx =3D NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 	WWU(&o);
=20
 	ww_mutex_lock_slow(&o2, &t);
@@ -1886,7 +1902,7 @@ static void ww_test_edeadlk_no_unlock(void)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	o2.ctx =3D &t2;
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
=20
@@ -1902,7 +1918,7 @@ static void ww_test_edeadlk_no_unlock(void)
=20
 	o2.ctx =3D NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
=20
 	WWL(&o2, &t);
 }
@@ -1911,7 +1927,7 @@ static void ww_test_edeadlk_no_unlock_slow(void)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx =3D &t2;
=20
@@ -1927,7 +1943,7 @@ static void ww_test_edeadlk_no_unlock_slow(void)
=20
 	o2.ctx =3D NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
=20
 	ww_mutex_lock_slow(&o2, &t);
 }
@@ -1936,7 +1952,7 @@ static void ww_test_edeadlk_acquire_more(void)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx =3D &t2;
=20
@@ -1957,7 +1973,7 @@ static void ww_test_edeadlk_acquire_more_slow(void)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx =3D &t2;
=20
@@ -1978,11 +1994,11 @@ static void ww_test_edeadlk_acquire_more_edeadlk(vo=
id)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx =3D &t2;
=20
-	mutex_lock(&o3.base);
+	ww_mutex_base_lock(&o3.base);
 	mutex_release(&o3.base.dep_map, _THIS_IP_);
 	o3.ctx =3D &t2;
=20
@@ -2004,11 +2020,11 @@ static void ww_test_edeadlk_acquire_more_edeadlk_sl=
ow(void)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx =3D &t2;
=20
-	mutex_lock(&o3.base);
+	ww_mutex_base_lock(&o3.base);
 	mutex_release(&o3.base.dep_map, _THIS_IP_);
 	o3.ctx =3D &t2;
=20
@@ -2029,7 +2045,7 @@ static void ww_test_edeadlk_acquire_wrong(void)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx =3D &t2;
=20
@@ -2054,7 +2070,7 @@ static void ww_test_edeadlk_acquire_wrong_slow(void)
 {
 	int ret;
=20
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx =3D &t2;
=20
--=20
2.34.0

