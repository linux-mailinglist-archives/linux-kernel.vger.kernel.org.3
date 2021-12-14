Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EB1474DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbhLNWF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58754 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbhLNWEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6CB3CE1AFB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9DFC34625;
        Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=bHQuoPR51a0Ft1BCAEW/J697y7UT5QEVCJMT/27U+XY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhmOnGy0UAOieFt7R7UPjJB/azacf3m53KaapXMx2Vta5fa3kGqL7Ef/9Pi2UOfJq
         7gBjvPB7Usw7hC0Tg7o7bd16B3EjvbCA99F5r19FUBm90xlwrA4qNSTfUJu54xfV/a
         S8BOKKw7/Nk2Ietk5fKRWYpWdToaSJOwzNvTfxsN59xp9NsQEuuHbJPd80q0vlB+KS
         jbCupuzz/bYHDc9Jig/IUnBKTygLBXodC6ESaaXKprnyvxIyO52Bfk8VuPErxOH8xa
         eNRRv8WIKORoM+oI8JbH/77D/BaPi8+iOZ+/Pe6ea1bO0oOX1eC7Zt1LdoCnYuUxc2
         x798m+lq8DSdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 76D005C193A; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 15/29] locking/barriers, kcsan: Support generic instrumentation
Date:   Tue, 14 Dec 2021 14:04:25 -0800
Message-Id: <20211214220439.2236564-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Thus far only smp_*() barriers had been defined by asm-generic/barrier.h
based on __smp_*() barriers, because the !SMP case is usually generic.

With the introduction of instrumentation, it also makes sense to have
asm-generic/barrier.h assist in the definition of instrumented versions
of mb(), rmb(), wmb(), dma_rmb(), and dma_wmb().

Because there is no requirement to distinguish the !SMP case, the
definition can be simpler: we can avoid also providing fallbacks for the
__ prefixed cases, and only check if `defined(__<barrier>)`, to finally
define the KCSAN-instrumented versions.

This also allows for the compiler to complain if an architecture
accidentally defines both the normal and __ prefixed variant.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/asm-generic/barrier.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 27a9c9edfef66..02c4339c8eebf 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -21,6 +21,31 @@
 #define nop()	asm volatile ("nop")
 #endif
 
+/*
+ * Architectures that want generic instrumentation can define __ prefixed
+ * variants of all barriers.
+ */
+
+#ifdef __mb
+#define mb()	do { kcsan_mb(); __mb(); } while (0)
+#endif
+
+#ifdef __rmb
+#define rmb()	do { kcsan_rmb(); __rmb(); } while (0)
+#endif
+
+#ifdef __wmb
+#define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
+#endif
+
+#ifdef __dma_rmb
+#define dma_rmb()	do { kcsan_rmb(); __dma_rmb(); } while (0)
+#endif
+
+#ifdef __dma_wmb
+#define dma_wmb()	do { kcsan_wmb(); __dma_wmb(); } while (0)
+#endif
+
 /*
  * Force strict CPU ordering. And yes, this is required on UP too when we're
  * talking to devices.
-- 
2.31.1.189.g2e36527f23

