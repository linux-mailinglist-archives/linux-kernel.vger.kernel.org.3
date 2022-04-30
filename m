Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE0515ED9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382984AbiD3PmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382964AbiD3Plh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:41:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E428A144C
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 08:38:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o69so8082224pjo.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=PhfY9SC+wYhs3i/pCnS1F0qe7XGea8rOjY/kEhC+LrE=;
        b=sCDHVOiLVN32Y8ICH+ZkCKw/InoCrY43xa27irUukeSvGPghb/JBYOw6oTCkeIBkNa
         +H/XBYvBx7CV0nBuiGA7CSeqpBzMXbIkhHwzR01gcHQLnmqthIK6PG5GbP5QbH/LT2af
         9Em8Bhs6r45/fJ462zBxoDeJfmyc3zQOXCJQOLKUa7NZyWoNpE+p5rq+evLX48Wxqz7Z
         8QuGzNeewDVFwR94Xv+ACR39i3XWraOwk4MmDN7l7tVP+OXZvX8sxAPK4yys2j11psjV
         Aa1jdjYTmV+9Er+vvhIB/vTozu0gkGHHg2IByGGcQHC5KnFPIj4uZM2dHaqz/yWVmr+t
         6dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=PhfY9SC+wYhs3i/pCnS1F0qe7XGea8rOjY/kEhC+LrE=;
        b=tWamvwph9pbHaBdnmWZK1Iwwmtl9B4H7VvW8Al5rv1sMB6+wJqHH6hssQ8xGFGOxl+
         pvnZZGCrt8JOPy0dWcOk/oisFDX70sWWGXOfb/wKOWIcD7Q6D8yTm6YU1C66XlUAC5m5
         yBbb88lezh4rgBHXczvnouCRlHJ45tT6bktnYY6i2+WzeHUOJPdNei4SR9F2wIlY3pzR
         DRgaUOW60e3IgxjxQtu3p6IeYpEs0p5bZ5j7t8UuhpSlL+Gdj8l1aNjd6VcX4cGO0CFK
         /kOFmZVhBXpqZNJbFR4jOknx+5VHM3P3J98JJknPtBK9iCwr8S7pnvXeMM/+U7LZOMb3
         dAyg==
X-Gm-Message-State: AOAM530Rdsjsgu/6S90w9KTQ+k7BsDx36tlfb4rZgr/HKnRIRlSM/Ooj
        BKrfqg/ucVGAG+yqMvWWOLaqsw==
X-Google-Smtp-Source: ABdhPJyQzZr23BkCwG1+xSArqcEmCk72rbg9rU3h9fy701WXzCXMfDWtm+qk2uXLdC5yg4y6n4z3Nw==
X-Received: by 2002:a17:902:b789:b0:15b:5d52:7542 with SMTP id e9-20020a170902b78900b0015b5d527542mr4396814pls.26.1651333079791;
        Sat, 30 Apr 2022 08:37:59 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x5-20020aa793a5000000b0050dc7628201sm1677478pff.219.2022.04.30.08.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 08:37:59 -0700 (PDT)
Subject: [PATCH v4 6/7] RISC-V: Move to queued RW locks
Date:   Sat, 30 Apr 2022 08:36:25 -0700
Message-Id: <20220430153626.30660-7-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430153626.30660-1-palmer@rivosinc.com>
References: <20220430153626.30660-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

Now that we have fair spinlocks we can use the generic queued rwlocks,
so we might as well do so.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig                      |  1 +
 arch/riscv/include/asm/Kbuild           |  2 +
 arch/riscv/include/asm/spinlock.h       | 99 -------------------------
 arch/riscv/include/asm/spinlock_types.h | 24 ------
 4 files changed, 3 insertions(+), 123 deletions(-)
 delete mode 100644 arch/riscv/include/asm/spinlock.h
 delete mode 100644 arch/riscv/include/asm/spinlock_types.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 00fd9c548f26..f8a55d94016d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
 	select ARCH_SUPPORTS_HUGETLBFS if MMU
 	select ARCH_USE_MEMTEST
+	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index c3f229ae8033..504f8b7e72d4 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -3,6 +3,8 @@ generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
 generic-y += parport.h
+generic-y += spinlock.h
+generic-y += spinlock_types.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
 generic-y += user.h
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
deleted file mode 100644
index 88a4d5d0d98a..000000000000
--- a/arch/riscv/include/asm/spinlock.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Regents of the University of California
- * Copyright (C) 2017 SiFive
- */
-
-#ifndef _ASM_RISCV_SPINLOCK_H
-#define _ASM_RISCV_SPINLOCK_H
-
-/* This is horible, but the whole file is going away in the next commit. */
-#define __ASM_GENERIC_QRWLOCK_H
-
-#include <linux/kernel.h>
-#include <asm/current.h>
-#include <asm/fence.h>
-#include <asm-generic/spinlock.h>
-
-static inline void arch_read_lock(arch_rwlock_t *lock)
-{
-	int tmp;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bltz	%1, 1b\n"
-		"	addi	%1, %1, 1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		: "+A" (lock->lock), "=&r" (tmp)
-		:: "memory");
-}
-
-static inline void arch_write_lock(arch_rwlock_t *lock)
-{
-	int tmp;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bnez	%1, 1b\n"
-		"	li	%1, -1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		: "+A" (lock->lock), "=&r" (tmp)
-		:: "memory");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *lock)
-{
-	int busy;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bltz	%1, 1f\n"
-		"	addi	%1, %1, 1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		"1:\n"
-		: "+A" (lock->lock), "=&r" (busy)
-		:: "memory");
-
-	return !busy;
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *lock)
-{
-	int busy;
-
-	__asm__ __volatile__(
-		"1:	lr.w	%1, %0\n"
-		"	bnez	%1, 1f\n"
-		"	li	%1, -1\n"
-		"	sc.w	%1, %1, %0\n"
-		"	bnez	%1, 1b\n"
-		RISCV_ACQUIRE_BARRIER
-		"1:\n"
-		: "+A" (lock->lock), "=&r" (busy)
-		:: "memory");
-
-	return !busy;
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *lock)
-{
-	__asm__ __volatile__(
-		RISCV_RELEASE_BARRIER
-		"	amoadd.w x0, %1, %0\n"
-		: "+A" (lock->lock)
-		: "r" (-1)
-		: "memory");
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *lock)
-{
-	smp_store_release(&lock->lock, 0);
-}
-
-#endif /* _ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm/spinlock_types.h
deleted file mode 100644
index f2f9b5d7120d..000000000000
--- a/arch/riscv/include/asm/spinlock_types.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2015 Regents of the University of California
- */
-
-#ifndef _ASM_RISCV_SPINLOCK_TYPES_H
-#define _ASM_RISCV_SPINLOCK_TYPES_H
-
-/* This is horible, but the whole file is going away in the next commit. */
-#define __ASM_GENERIC_QRWLOCK_TYPES_H
-
-#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
-# error "please don't include this file directly"
-#endif
-
-#include <asm-generic/spinlock_types.h>
-
-typedef struct {
-	volatile unsigned int lock;
-} arch_rwlock_t;
-
-#define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
-
-#endif /* _ASM_RISCV_SPINLOCK_TYPES_H */
-- 
2.34.1

