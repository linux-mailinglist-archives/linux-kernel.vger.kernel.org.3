Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD84615DE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377401AbhK2NMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:12:25 -0500
Received: from foss.arm.com ([217.140.110.172]:38454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377456AbhK2NKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:10:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49B54113E;
        Mon, 29 Nov 2021 05:07:06 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 017103F766;
        Mon, 29 Nov 2021 05:07:02 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, efuller@redhat.com,
        elver@google.com, ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, michal.simek@xilinx.com,
        mingo@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
        paulmck@kernel.org, paulus@samba.org, peterz@infradead.org,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: [PATCH v8 01/11] thread_info: add helpers to snapshot thread flags
Date:   Mon, 29 Nov 2021 13:06:43 +0000
Message-Id: <20211129130653.2037928-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129130653.2037928-1-mark.rutland@arm.com>
References: <20211129130653.2037928-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In <linux/thread_info.h> there are helpers to manipulate individual
thread flags, but where code wants to check several flags at once, it
must open code reading current_thread_info()->flags and operating on a
snapshot.

As some flags can be set remotely it's necessary to use READ_ONCE() to
get a consistent snapshot even when IRQs are disabled, but some code
forgets to do this. Generally this is unlike to cause a problem in
practice, but it is somewhat unsound, and KCSAN will legitimately warn
that there is a data race.

To make it easier to do the right thing, and to highlight that
concurrent modification is possible, add new helpers to snapshot the
flags, which should be used in preference to plain reads. Subsequent
patches will move existing code to use the new helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marco Elver <elver@google.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/linux/thread_info.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index ad0c4e041030..73a6f34b3847 100644
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
-- 
2.30.2

