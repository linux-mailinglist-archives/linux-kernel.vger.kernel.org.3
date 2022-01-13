Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940F948DB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiAMPyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbiAMPyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:54:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8D0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 07:54:00 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C5FD1EC05B5;
        Thu, 13 Jan 2022 16:53:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642089238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/fd9171gS6aRSdQTkthqSlNsE/J+vHyEXK5VET1iFc=;
        b=o3aphMzmeR2+ISRD2RjpdhcRSCOJcLx6D7qJ0Oh9sPT6EKiOi/tmWZdZF/dxQlBtpPQ08E
        QaM2PWzJJttMCMsJ6dwVpcTbbEsSjdx2MsGzSzpqYMQejrbbkp3jre3BuB6maIc/zqkOFb
        QYDGRD7Ty70n3qS2yybSZ2Zs9iaBRmA=
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] asm-generic/bitops: Always inline all bit manipulation helpers
Date:   Thu, 13 Jan 2022 16:53:56 +0100
Message-Id: <20220113155357.4706-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220113155357.4706-1-bp@alien8.de>
References: <20220113155357.4706-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Make it consistent with the atomic/atomic-instrumented.h helpers.

And defconfig size is actually going down!

     text    data     bss     dec     hex filename
  22352096        8213152 1917164 32482412        1efa46c vmlinux.x86-64.defconfig.before
  22350551        8213184 1917164 32480899        1ef9e83 vmlinux.x86-64.defconfig.after

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 include/asm-generic/bitops/instrumented-atomic.h | 12 ++++++------
 .../asm-generic/bitops/instrumented-non-atomic.h | 16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index c90192b1c755..4225a8ca9c1a 100644
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
index 37363d570b9b..7ab1ecc37782 100644
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
-- 
2.29.2

