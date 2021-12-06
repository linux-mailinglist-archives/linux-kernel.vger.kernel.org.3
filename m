Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08820469D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386583AbhLFP34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:29:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42950 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357826AbhLFPTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:13 -0500
Date:   Mon, 06 Dec 2021 15:15:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3JVTMca/k1nDDpzsFRV3vwUWptGyDY0wAwOhtbI4+g=;
        b=OtWmjedSNsP11aH40Q2b6kz/ma7yc4EnmZjI/kSW9jwSP2HQJZ+Z9h/EhOBpFRlBaOpcRx
        KGoRgRx2PDFJ7VmWGeRc3YeSiyxTUYN8sw3fhbAknGNNervhfEPzd9Db3F6ufiEkW6cIrB
        IwhOYP3n5nVuuU0n/y14py+7D+dzxxGEnL7jWz8/rxgFVmqYT+chMseZ9km36lD+LdrsOI
        6NZHHkvHXuL5c36J2OCXXiuY4yEk/Fpuvsd3D0Vu43QompTIDZFglVr24UEEuoa9RJd/Kf
        Hp22HpNSh121QoLmoptZiYyiTzRNalOuqAL4vFRm7k8YBlr+c+LeQFthuIZmgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j3JVTMca/k1nDDpzsFRV3vwUWptGyDY0wAwOhtbI4+g=;
        b=fxBbE+LW3oYXAfaAIAMR2ShRwhFGniWeiRiXU3WtdaBj/sQIX1tul1PFmQl37sEjVu5h6s
        OPVpAWAwX6r4UvAQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftests: Adapt ww-tests for PREEMPT_RT
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-10-bigeasy@linutronix.de>
References: <20211129174654.668506-10-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163880374273.11128.11714453177859720428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9a75bd0c52df6cff44735f73dfb9d00e67969fc5
Gitweb:        https://git.kernel.org/tip/9a75bd0c52df6cff44735f73dfb9d00e67969fc5
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:24 +01:00

lockdep/selftests: Adapt ww-tests for PREEMPT_RT

The ww-mutex selftest operates directly on ww_mutex::base and assumes
its type is struct mutex. This isn't true on PREEMPT_RT which turns the
mutex into a rtmutex.

Add a ww_mutex_base_ abstraction which maps to the relevant mutex_ or
rt_mutex_ function.
Change the CONFIG_DEBUG_MUTEXES ifdef to DEBUG_WW_MUTEXES. The latter is
true for the MUTEX and RTMUTEX implementation of WW-MUTEX. The
assignment is required in order to pass the tests.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211129174654.668506-10-bigeasy@linutronix.de
---
 lib/locking-selftest.c | 76 ++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 9031f50..8d24279 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1700,6 +1700,22 @@ static void ww_test_fail_acquire(void)
 #endif
 }
 
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
 
 	/* mutex_lock (and indirectly, mutex_lock_nested) */
 	o.ctx = (void *)~0UL;
-	mutex_lock(&o.base);
-	mutex_unlock(&o.base);
+	ww_mutex_base_lock(&o.base);
+	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* mutex_lock_interruptible (and *_nested) */
 	o.ctx = (void *)~0UL;
-	ret = mutex_lock_interruptible(&o.base);
+	ret = ww_mutex_base_lock_interruptible(&o.base);
 	if (!ret)
-		mutex_unlock(&o.base);
+		ww_mutex_base_unlock(&o.base);
 	else
 		WARN_ON(1);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* mutex_lock_killable (and *_nested) */
 	o.ctx = (void *)~0UL;
-	ret = mutex_lock_killable(&o.base);
+	ret = ww_mutex_base_lock_killable(&o.base);
 	if (!ret)
-		mutex_unlock(&o.base);
+		ww_mutex_base_unlock(&o.base);
 	else
 		WARN_ON(1);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* trylock, succeeding */
 	o.ctx = (void *)~0UL;
-	ret = mutex_trylock(&o.base);
+	ret = ww_mutex_base_trylock(&o.base);
 	WARN_ON(!ret);
 	if (ret)
-		mutex_unlock(&o.base);
+		ww_mutex_base_unlock(&o.base);
 	else
 		WARN_ON(1);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* trylock, failing */
 	o.ctx = (void *)~0UL;
-	mutex_lock(&o.base);
-	ret = mutex_trylock(&o.base);
+	ww_mutex_base_lock(&o.base);
+	ret = ww_mutex_base_trylock(&o.base);
 	WARN_ON(ret);
-	mutex_unlock(&o.base);
+	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx != (void *)~0UL);
 
 	/* nest_lock */
 	o.ctx = (void *)~0UL;
-	mutex_lock_nest_lock(&o.base, &t);
-	mutex_unlock(&o.base);
+	ww_mutex_base_lock_nest_lock(&o.base, &t);
+	ww_mutex_base_unlock(&o.base);
 	WARN_ON(o.ctx != (void *)~0UL);
 }
 
@@ -1770,7 +1786,7 @@ static void ww_test_two_contexts(void)
 static void ww_test_diff_class(void)
 {
 	WWAI(&t);
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	t.ww_class = NULL;
 #endif
 	WWL(&o, &t);
@@ -1834,7 +1850,7 @@ static void ww_test_edeadlk_normal(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	o2.ctx = &t2;
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 
@@ -1850,7 +1866,7 @@ static void ww_test_edeadlk_normal(void)
 
 	o2.ctx = NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 	WWU(&o);
 
 	WWL(&o2, &t);
@@ -1860,7 +1876,7 @@ static void ww_test_edeadlk_normal_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -1876,7 +1892,7 @@ static void ww_test_edeadlk_normal_slow(void)
 
 	o2.ctx = NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 	WWU(&o);
 
 	ww_mutex_lock_slow(&o2, &t);
@@ -1886,7 +1902,7 @@ static void ww_test_edeadlk_no_unlock(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	o2.ctx = &t2;
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 
@@ -1902,7 +1918,7 @@ static void ww_test_edeadlk_no_unlock(void)
 
 	o2.ctx = NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 
 	WWL(&o2, &t);
 }
@@ -1911,7 +1927,7 @@ static void ww_test_edeadlk_no_unlock_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -1927,7 +1943,7 @@ static void ww_test_edeadlk_no_unlock_slow(void)
 
 	o2.ctx = NULL;
 	mutex_acquire(&o2.base.dep_map, 0, 1, _THIS_IP_);
-	mutex_unlock(&o2.base);
+	ww_mutex_base_unlock(&o2.base);
 
 	ww_mutex_lock_slow(&o2, &t);
 }
@@ -1936,7 +1952,7 @@ static void ww_test_edeadlk_acquire_more(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -1957,7 +1973,7 @@ static void ww_test_edeadlk_acquire_more_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -1978,11 +1994,11 @@ static void ww_test_edeadlk_acquire_more_edeadlk(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
-	mutex_lock(&o3.base);
+	ww_mutex_base_lock(&o3.base);
 	mutex_release(&o3.base.dep_map, _THIS_IP_);
 	o3.ctx = &t2;
 
@@ -2004,11 +2020,11 @@ static void ww_test_edeadlk_acquire_more_edeadlk_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
-	mutex_lock(&o3.base);
+	ww_mutex_base_lock(&o3.base);
 	mutex_release(&o3.base.dep_map, _THIS_IP_);
 	o3.ctx = &t2;
 
@@ -2029,7 +2045,7 @@ static void ww_test_edeadlk_acquire_wrong(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
@@ -2054,7 +2070,7 @@ static void ww_test_edeadlk_acquire_wrong_slow(void)
 {
 	int ret;
 
-	mutex_lock(&o2.base);
+	ww_mutex_base_lock(&o2.base);
 	mutex_release(&o2.base.dep_map, _THIS_IP_);
 	o2.ctx = &t2;
 
