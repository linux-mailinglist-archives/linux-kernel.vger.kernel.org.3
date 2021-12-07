Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2014B46BD7A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbhLGOZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:25:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53278 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhLGOZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:25:33 -0500
Date:   Tue, 07 Dec 2021 14:22:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638886921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kh4BiFIG11fYcpyC/V4Ae5ASUWfePQF/KWWAIs+5A8Q=;
        b=Ja7jZWiSSAcmU8DtgIJLACgCXO3mL1eHjXfRXbhZRcofORyjY3oASyFVqhjZL5VnHb0+w1
        EgSnyTNouUebXC0hyqUcr/3JsnfXYnO45c/1vSPAPwKNf2Jn75dFqzhHD2XUq9gr3PKeXN
        NnHtt3f/GRvO2tuuiKkB935QRR9FSYTRWN8uexAlFzBJQB2Vr1puk1zWuGuySnP7HzcLE2
        J3HEU81VYCiPEByQzkJcZ6hbS+TrgO9GW/gcqgHLY4/6t4pnJev2Yxpf0nokfzW95npka8
        kS4pKJ9RnGYGG1sMf2/m4JtCdi3GGY2eZl7VNgtsHqhzGwparAlMfZli/jpTkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638886921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kh4BiFIG11fYcpyC/V4Ae5ASUWfePQF/KWWAIs+5A8Q=;
        b=9linE9wqB7fVKvKGxMtzct9gWjLRwQ/UuNWmEphPjaPAy+WZh1JBC3oILcqvbELRPhvpz7
        6uIykkgK9EafNPAw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Allow to include asm/spinlock_types.h
 from linux/spinlock_types_raw.h
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-12-bigeasy@linutronix.de>
References: <20211129174654.668506-12-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163888692059.11128.2853038419745450564.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     77993b595ada5731e513eb06a0f4bf4b9f1e9532
Gitweb:        https://git.kernel.org/tip/77993b595ada5731e513eb06a0f4bf4b9f1=
e9532
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 29 Nov 2021 18:46:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 07 Dec 2021 15:14:12 +01:00

locking: Allow to include asm/spinlock_types.h from linux/spinlock_types_raw.h

The printk header file includes ratelimit_types.h for its __ratelimit()
based usage. It is required for the static initializer used in
printk_ratelimited(). It uses a raw_spinlock_t and includes the
spinlock_types.h.

PREEMPT_RT substitutes spinlock_t with a rtmutex based implementation and so
its spinlock_t implmentation (provided by spinlock_rt.h) includes rtmutex.h a=
nd
atomic.h which leads to recursive includes where defines are missing.

By including only the raw_spinlock_t defines it avoids the atomic.h
related includes at this stage.

An example on powerpc:

|  CALL    scripts/atomic/check-atomics.sh
|In file included from include/linux/bug.h:5,
|                 from include/linux/page-flags.h:10,
|                 from kernel/bounds.c:10:
|arch/powerpc/include/asm/page_32.h: In function =C3=A2=C2=80=C2=98clear_page=
=C3=A2=C2=80=C2=99:
|arch/powerpc/include/asm/bug.h:87:4: error: implicit declaration of function=
 =C3=A2=3D80=3D98__WARN=C3=A2=3D80=3D99 [-Werror=3D3Dimplicit-function-declar=
ation]
|   87 |    __WARN();    \
|      |    ^~~~~~
|arch/powerpc/include/asm/page_32.h:48:2: note: in expansion of macro =C3=A2=
=C2=80=C2=98WARN_ON=C3=A2=C2=80=3D99
|   48 |  WARN_ON((unsigned long)addr & (L1_CACHE_BYTES - 1));
|      |  ^~~~~~~
|arch/powerpc/include/asm/bug.h:58:17: error: invalid application of =C3=A2=
=C2=80=C2=98sizeof=C3=A2=C2=80=3D99 to incomplete type =C3=A2=C2=80=C2=98stru=
ct bug_entry=C3=A2=C2=80=3D99
|   58 |     "i" (sizeof(struct bug_entry)), \
|      |                 ^~~~~~
|arch/powerpc/include/asm/bug.h:89:3: note: in expansion of macro =C3=A2=C2=
=80=C2=98BUG_ENTRY=C3=A2=C2=80=3D99
|   89 |   BUG_ENTRY(PPC_TLNEI " %4, 0",   \
|      |   ^~~~~~~~~
|arch/powerpc/include/asm/page_32.h:48:2: note: in expansion of macro =C3=A2=
=C2=80=C2=98WARN_ON=C3=A2=C2=80=3D99
|   48 |  WARN_ON((unsigned long)addr & (L1_CACHE_BYTES - 1));
|      |  ^~~~~~~
|In file included from arch/powerpc/include/asm/ptrace.h:298,
|                 from arch/powerpc/include/asm/hw_irq.h:12,
|                 from arch/powerpc/include/asm/irqflags.h:12,
|                 from include/linux/irqflags.h:16,
|                 from include/asm-generic/cmpxchg-local.h:6,
|                 from arch/powerpc/include/asm/cmpxchg.h:526,
|                 from arch/powerpc/include/asm/atomic.h:11,
|                 from include/linux/atomic.h:7,
|                 from include/linux/rwbase_rt.h:6,
|                 from include/linux/rwlock_types.h:55,
|                 from include/linux/spinlock_types.h:74,
|                 from include/linux/ratelimit_types.h:7,
|                 from include/linux/printk.h:10,
|                 from include/asm-generic/bug.h:22,
|                 from arch/powerpc/include/asm/bug.h:109,
|                 from include/linux/bug.h:5,
|                 from include/linux/page-flags.h:10,
|                 from kernel/bounds.c:10:
|include/linux/thread_info.h: In function =C3=A2=3D80=3D98copy_overflow=C3=A2=
=3D80=3D99:
|include/linux/thread_info.h:210:2: error: implicit declaration of function =
=C3=A2=3D80=3D98WARN=C3=A2=3D80=3D99 [-Werror=3D3Dimplicit-function-declarati=
on]
|  210 |  WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
|      |  ^~~~

The WARN / BUG include pulls in printk.h and then ptrace.h expects WARN
(from bug.h) which is not yet complete. Even hw_irq.h has WARN_ON()
statements.

On POWERPC64 there are missing atomic64 defines while building 32bit
VDSO:
|  VDSO32C arch/powerpc/kernel/vdso32/vgettimeofday.o
|In file included from include/linux/atomic.h:80,
|                 from include/linux/rwbase_rt.h:6,
|                 from include/linux/rwlock_types.h:55,
|                 from include/linux/spinlock_types.h:74,
|                 from include/linux/ratelimit_types.h:7,
|                 from include/linux/printk.h:10,
|                 from include/linux/kernel.h:19,
|                 from arch/powerpc/include/asm/page.h:11,
|                 from arch/powerpc/include/asm/vdso/gettimeofday.h:5,
|                 from include/vdso/datapage.h:137,
|                 from lib/vdso/gettimeofday.c:5,
|                 from <command-line>:
|include/linux/atomic-arch-fallback.h: In function =C3=A2=C2=80=C2=98arch_ato=
mic64_inc=C3=A2=C2=80=3D99:
|include/linux/atomic-arch-fallback.h:1447:2: error: implicit declaration of =
function =C3=A2=C2=80=C2=98arch_atomic64_add=C3=A2=C2=80=C2=99; did you mean =
=C3=A2=C2=80=C2=98arch_atomic_add=C3=A2=C2=80=C2=99? [-Werror=3D3Dimpl
|icit-function-declaration]
| 1447 |  arch_atomic64_add(1, v);
|      |  ^~~~~~~~~~~~~~~~~
|      |  arch_atomic_add

The generic fallback is not included, atomics itself are not used. If
kernel.h does not include printk.h then it comes later from the bug.h
include.

Allow asm/spinlock_types.h to be included from
linux/spinlock_types_raw.h.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211129174654.668506-12-bigeasy@linutronix.de
---
 arch/alpha/include/asm/spinlock_types.h          | 2 +-
 arch/arm/include/asm/spinlock_types.h            | 2 +-
 arch/arm64/include/asm/spinlock_types.h          | 2 +-
 arch/csky/include/asm/spinlock_types.h           | 2 +-
 arch/hexagon/include/asm/spinlock_types.h        | 2 +-
 arch/ia64/include/asm/spinlock_types.h           | 2 +-
 arch/powerpc/include/asm/simple_spinlock_types.h | 2 +-
 arch/powerpc/include/asm/spinlock_types.h        | 2 +-
 arch/riscv/include/asm/spinlock_types.h          | 2 +-
 arch/s390/include/asm/spinlock_types.h           | 2 +-
 arch/sh/include/asm/spinlock_types.h             | 2 +-
 arch/xtensa/include/asm/spinlock_types.h         | 2 +-
 include/linux/ratelimit_types.h                  | 2 +-
 include/linux/spinlock_types_up.h                | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/include/asm/spinlock_types.h b/arch/alpha/include/asm=
/spinlock_types.h
index 1d5716b..2526fd3 100644
--- a/arch/alpha/include/asm/spinlock_types.h
+++ b/arch/alpha/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ALPHA_SPINLOCK_TYPES_H
 #define _ALPHA_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/arm/include/asm/spinlock_types.h b/arch/arm/include/asm/spi=
nlock_types.h
index 5976958..0c14b36 100644
--- a/arch/arm/include/asm/spinlock_types.h
+++ b/arch/arm/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/arm64/include/asm/spinlock_types.h b/arch/arm64/include/asm=
/spinlock_types.h
index 18782f0..11ab1c0 100644
--- a/arch/arm64/include/asm/spinlock_types.h
+++ b/arch/arm64/include/asm/spinlock_types.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
=20
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
+#if !defined(__LINUX_SPINLOCK_TYPES_RAW_H) && !defined(__ASM_SPINLOCK_H)
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/csky/include/asm/spinlock_types.h b/arch/csky/include/asm/s=
pinlock_types.h
index 8ff0f6f..db87a12 100644
--- a/arch/csky/include/asm/spinlock_types.h
+++ b/arch/csky/include/asm/spinlock_types.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_CSKY_SPINLOCK_TYPES_H
 #define __ASM_CSKY_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/hexagon/include/asm/spinlock_types.h b/arch/hexagon/include=
/asm/spinlock_types.h
index 19d2334..d5f6649 100644
--- a/arch/hexagon/include/asm/spinlock_types.h
+++ b/arch/hexagon/include/asm/spinlock_types.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_SPINLOCK_TYPES_H
 #define _ASM_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/ia64/include/asm/spinlock_types.h b/arch/ia64/include/asm/s=
pinlock_types.h
index 6e345fe..14b8a16 100644
--- a/arch/ia64/include/asm/spinlock_types.h
+++ b/arch/ia64/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_IA64_SPINLOCK_TYPES_H
 #define _ASM_IA64_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/powerpc/include/asm/simple_spinlock_types.h b/arch/powerpc/=
include/asm/simple_spinlock_types.h
index 0f3cdd8..0824333 100644
--- a/arch/powerpc/include/asm/simple_spinlock_types.h
+++ b/arch/powerpc/include/asm/simple_spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
 #define _ASM_POWERPC_SIMPLE_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include=
/asm/spinlock_types.h
index c5d742f..d5f8a74 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_SPINLOCK_TYPES_H
 #define _ASM_POWERPC_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/riscv/include/asm/spinlock_types.h b/arch/riscv/include/asm=
/spinlock_types.h
index f398e76..5a35a49 100644
--- a/arch/riscv/include/asm/spinlock_types.h
+++ b/arch/riscv/include/asm/spinlock_types.h
@@ -6,7 +6,7 @@
 #ifndef _ASM_RISCV_SPINLOCK_TYPES_H
 #define _ASM_RISCV_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/s390/include/asm/spinlock_types.h b/arch/s390/include/asm/s=
pinlock_types.h
index a2bbfd7..b69695e 100644
--- a/arch/s390/include/asm/spinlock_types.h
+++ b/arch/s390/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/sh/include/asm/spinlock_types.h b/arch/sh/include/asm/spinl=
ock_types.h
index e82369f..907bda4 100644
--- a/arch/sh/include/asm/spinlock_types.h
+++ b/arch/sh/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SH_SPINLOCK_TYPES_H
 #define __ASM_SH_SPINLOCK_TYPES_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
diff --git a/arch/xtensa/include/asm/spinlock_types.h b/arch/xtensa/include/a=
sm/spinlock_types.h
index 64c9389..797aed7 100644
--- a/arch/xtensa/include/asm/spinlock_types.h
+++ b/arch/xtensa/include/asm/spinlock_types.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SPINLOCK_TYPES_H
 #define __ASM_SPINLOCK_TYPES_H
=20
-#if !defined(__LINUX_SPINLOCK_TYPES_H) && !defined(__ASM_SPINLOCK_H)
+#if !defined(__LINUX_SPINLOCK_TYPES_RAW_H) && !defined(__ASM_SPINLOCK_H)
 # error "please don't include this file directly"
 #endif
=20
diff --git a/include/linux/ratelimit_types.h b/include/linux/ratelimit_types.h
index b676aa4..c21c7f8 100644
--- a/include/linux/ratelimit_types.h
+++ b/include/linux/ratelimit_types.h
@@ -4,7 +4,7 @@
=20
 #include <linux/bits.h>
 #include <linux/param.h>
-#include <linux/spinlock_types.h>
+#include <linux/spinlock_types_raw.h>
=20
 #define DEFAULT_RATELIMIT_INTERVAL	(5 * HZ)
 #define DEFAULT_RATELIMIT_BURST		10
diff --git a/include/linux/spinlock_types_up.h b/include/linux/spinlock_types=
_up.h
index c09b640..7f86a20 100644
--- a/include/linux/spinlock_types_up.h
+++ b/include/linux/spinlock_types_up.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_SPINLOCK_TYPES_UP_H
 #define __LINUX_SPINLOCK_TYPES_UP_H
=20
-#ifndef __LINUX_SPINLOCK_TYPES_H
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
 # error "please don't include this file directly"
 #endif
=20
