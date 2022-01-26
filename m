Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A3C49CAD5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbiAZNal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239526AbiAZNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:30:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06846C06161C;
        Wed, 26 Jan 2022 05:30:30 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:30:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643203829;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rNMvKqp6TbmJtcnjQs6sDK3Ta4IVQWLxcQiMm6ctjc=;
        b=CZZYwfg1lpSEPHLHe7eCfBlpIXv5QOCqZ9Bd4cm7QtSIAnz639e0sAN0tdV54h2Yw/wiN/
        7zPYD5+uUz6eLMSQ2s3e/9RR3HE/6Yl/lDBEG8u//1gM5FlXBOk6cZgBe2Z2x0UTvvBJUV
        nbJsZjUGECHiInRSR1rSg9eKCJIZvme6z7agyNDCtMl3cWmTmrefP200l7IRC5WWU1fkl8
        hTjz3RN9ntHFEu7uny/OaVJAmhgP6+wfxrBukGYhcsQM+bVoHF2RxSvAkqNaKTWsH013Wj
        n1xV71rCbNy4n4h+jx+ToUQ7TA3ibMOkxmMB7Id5qLT1X+JXRAldq8Xr/ETfFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643203829;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rNMvKqp6TbmJtcnjQs6sDK3Ta4IVQWLxcQiMm6ctjc=;
        b=m+klz9ElMHQp0srGo3u0plNCbzCEVFKHdmJaqVWcWGTt6KHjQS0CW3JZnXl2XiyQX7hZj3
        9PaMkhVuoTvcXjBg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] asm-generic/bitops: Always inline all bit
 manipulation helpers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Marco Elver <elver@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220113155357.4706-2-bp@alien8.de>
References: <20220113155357.4706-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164320382800.16921.3688807830220814901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     acb13ea0baf8db8d05a3910c06e997c90825faad
Gitweb:        https://git.kernel.org/tip/acb13ea0baf8db8d05a3910c06e997c90825faad
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 13 Jan 2022 16:53:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jan 2022 22:30:28 +01:00

asm-generic/bitops: Always inline all bit manipulation helpers

Make it consistent with the atomic/atomic-instrumented.h helpers.

And defconfig size is actually going down!

     text    data     bss     dec     hex filename
  22352096        8213152 1917164 32482412        1efa46c vmlinux.x86-64.defconfig.before
  22350551        8213184 1917164 32480899        1ef9e83 vmlinux.x86-64.defconfig.after

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20220113155357.4706-2-bp@alien8.de
---
 include/asm-generic/bitops/instrumented-atomic.h     | 12 ++++----
 include/asm-generic/bitops/instrumented-non-atomic.h | 16 +++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index c90192b..4225a8c 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -23,7 +23,7 @@
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void set_bit(long nr, volatile unsigned long *addr)
+static __always_inline void set_bit(long nr, volatile unsigned long *addr)
 {
 	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_set_bit(nr, addr);
@@ -36,7 +36,7 @@ static inline void set_bit(long nr, volatile unsigned long *addr)
  *
  * This is a relaxed atomic operation (no implied memory barriers).
  */
-static inline void clear_bit(long nr, volatile unsigned long *addr)
+static __always_inline void clear_bit(long nr, volatile unsigned long *addr)
 {
 	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit(nr, addr);
@@ -52,7 +52,7 @@ static inline void clear_bit(long nr, volatile unsigned long *addr)
  * Note that @nr may be almost arbitrarily large; this function is not
  * restricted to acting on a single-word quantity.
  */
-static inline void change_bit(long nr, volatile unsigned long *addr)
+static __always_inline void change_bit(long nr, volatile unsigned long *addr)
 {
 	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_change_bit(nr, addr);
@@ -65,7 +65,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
  *
  * This is an atomic fully-ordered operation (implied full memory barrier).
  */
-static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
@@ -79,7 +79,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
  *
  * This is an atomic fully-ordered operation (implied full memory barrier).
  */
-static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
@@ -93,7 +93,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
  *
  * This is an atomic fully-ordered operation (implied full memory barrier).
  */
-static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(addr + BIT_WORD(nr), sizeof(long));
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index 37363d5..7ab1ecc 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -22,7 +22,7 @@
  * region of memory concurrently, the effect may be that only one operation
  * succeeds.
  */
-static inline void __set_bit(long nr, volatile unsigned long *addr)
+static __always_inline void __set_bit(long nr, volatile unsigned long *addr)
 {
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
@@ -37,7 +37,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
  * region of memory concurrently, the effect may be that only one operation
  * succeeds.
  */
-static inline void __clear_bit(long nr, volatile unsigned long *addr)
+static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
@@ -52,13 +52,13 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
  * region of memory concurrently, the effect may be that only one operation
  * succeeds.
  */
-static inline void __change_bit(long nr, volatile unsigned long *addr)
+static __always_inline void __change_bit(long nr, volatile unsigned long *addr)
 {
 	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
 }
 
-static inline void __instrument_read_write_bitop(long nr, volatile unsigned long *addr)
+static __always_inline void __instrument_read_write_bitop(long nr, volatile unsigned long *addr)
 {
 	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC)) {
 		/*
@@ -90,7 +90,7 @@ static inline void __instrument_read_write_bitop(long nr, volatile unsigned long
  * This operation is non-atomic. If two instances of this operation race, one
  * can appear to succeed but actually fail.
  */
-static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
 	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_set_bit(nr, addr);
@@ -104,7 +104,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  * This operation is non-atomic. If two instances of this operation race, one
  * can appear to succeed but actually fail.
  */
-static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
 	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_clear_bit(nr, addr);
@@ -118,7 +118,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  * This operation is non-atomic. If two instances of this operation race, one
  * can appear to succeed but actually fail.
  */
-static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
+static __always_inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
 	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_change_bit(nr, addr);
@@ -129,7 +129,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static inline bool test_bit(long nr, const volatile unsigned long *addr)
+static __always_inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
 	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
