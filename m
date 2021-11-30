Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDAE464210
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhK3XMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345210AbhK3XMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EED7C061758;
        Tue, 30 Nov 2021 15:08:50 -0800 (PST)
Date:   Tue, 30 Nov 2021 23:08:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MuwhsLqljfDbeysx6ljVqBdiGwFON5yWEWY1f1xkLt4=;
        b=ObhiFx8LRzzzrwFvX0VzWd1v5sLAZ4satdliHqUMI7vFUUcnzba95xi/Hz8taz+wSoSjp1
        E5rJ7jnFkALxdmVufkrv7axCTL7gVM7A93hrv1NJKmw2ZuhRNJtzwUCaCXZ4JrdM8KC8NX
        Bn6UJwHQ7SFiTdDea7MXtaYWNPKberbvdjYAhjWk0p/CfZ1LVPhSTUn4irZGQ0j5gfd75y
        pvMaoyNrkcHGScJzDjKktfwO4IOGNkAjkWs+39sDqcTBNLo37pGaVTd++JFF1SCmyyw3Lt
        J/qqNxPXUpUBtdD18aravmSfWhFHSeVMHuHS2uc2v5VMmx+NGqDwe0YcCdjutw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MuwhsLqljfDbeysx6ljVqBdiGwFON5yWEWY1f1xkLt4=;
        b=6PrAL+lZIAtVso7D+buBKi0Ie1/v7Q2able4+WZyCtcFxe0i0UcVl52eUBgFWRoyEZbUGL
        /cP5FNNKIpmT6rDg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] thread_info: Add helpers to snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-2-mark.rutland@arm.com>
References: <20211129130653.2037928-2-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831372740.11128.1099016936986607543.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     7ad639840acf2800b5f387c495795f995a67a329
Gitweb:        https://git.kernel.org/tip/7ad639840acf2800b5f387c495795f995a67a329
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:43 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:43 +01:00

thread_info: Add helpers to snapshot thread flags

In <linux/thread_info.h> there are helpers to manipulate individual thread
flags, but where code wants to check several flags at once, it must open
code reading current_thread_info()->flags and operating on a snapshot.

As some flags can be set remotely it's necessary to use READ_ONCE() to get
a consistent snapshot even when IRQs are disabled, but some code forgets to
do this. Generally this is unlike to cause a problem in practice, but it is
somewhat unsound, and KCSAN will legitimately warn that there is a data
race.

To make it easier to do the right thing, and to highlight that concurrent
modification is possible, add new helpers to snapshot the flags, which
should be used in preference to plain reads. Subsequent patches will move
existing code to use the new helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marco Elver <elver@google.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20211129130653.2037928-2-mark.rutland@arm.com

---
 include/linux/thread_info.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index ad0c4e0..73a6f34 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -118,6 +118,15 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 	return test_bit(flag, (unsigned long *)&ti->flags);
 }
 
+/*
+ * This may be used in noinstr code, and needs to be __always_inline to prevent
+ * inadvertent instrumentation.
+ */
+static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti)
+{
+	return READ_ONCE(ti->flags);
+}
+
 #define set_thread_flag(flag) \
 	set_ti_thread_flag(current_thread_info(), flag)
 #define clear_thread_flag(flag) \
@@ -130,6 +139,11 @@ static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
 	test_and_clear_ti_thread_flag(current_thread_info(), flag)
 #define test_thread_flag(flag) \
 	test_ti_thread_flag(current_thread_info(), flag)
+#define read_thread_flags() \
+	read_ti_thread_flags(current_thread_info())
+
+#define read_task_thread_flags(t) \
+	read_ti_thread_flags(task_thread_info(t))
 
 #ifdef CONFIG_GENERIC_ENTRY
 #define set_syscall_work(fl) \
