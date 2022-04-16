Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5550351B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiDPIQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiDPIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:16:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8A24B1DC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:14:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v12so8722465plv.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0bDlxsxRT7vU+fHQb3K3oqWDHlvOU9rQoKkjc4MdmI=;
        b=Rlap9suIxJ5pg8SxUIUWqby4Zk0PwZcTw0rnmzDiRNfw7DDfFBMql9bN4mo61iQR7O
         oB09GqjlZ1IhjjewjddzHXyUOBkc0ytZdIBwn7bIVCyo/lqnmw4anwSEN3ExsFWKc6z0
         qjCJAIEAEXYk9ae9n6s+fIYpAXW6aMEbMz0Igo7Roc7nup3pACEgQVy8aXOW3pmRhnoy
         +pz6IcqdVab3mCwFVQpPDAykEl1Zfx+u7uXegHVsO/TY50n/Vo15FeyBKcIql+F/Xrrl
         5DFXw/VqfnUfMR+GDJ+Qs+vRmf2QPQlman7kb5Bgs/1FwAFjvnydIfDV4hj8mrNokwEK
         VUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0bDlxsxRT7vU+fHQb3K3oqWDHlvOU9rQoKkjc4MdmI=;
        b=onWMYSfpy98WIGssdEjGZjDmZChxqW2xI1LyeS9/LVhUBEiOGhFtf1hCJcdXrPqq4X
         vrlwtgBtXuoroGfzC5fMOJX1tp8j9BKoYi7bJ9aHmaYuQEmp+iE14QkPxTFaXfT8mQkq
         0trRGpWliMRwqUlawqUQxSjHPZxJu4cXFFatF76Hfwgo4MkCsWKiI7D6oSrhwQ52pkJS
         hJA3ilPpbU2fkXYNSW46W/7v4l2XzIDMk8XiLa8Qumw4/nJoHW40lPy/0gQyReEv59xC
         QInkeduXcB2WbHmr/raGbL7N3d6xPtcW+uwzW4GDk0IPcY1ZYO8NdlnGNkTu6mwH67FI
         1bsA==
X-Gm-Message-State: AOAM530OsN/sJb34jIjScHhBYojpXW3r1IMKHRIUQ/97+0/pAyVhf+yH
        DoHv2efYQ6HwAY5QlBbopJE=
X-Google-Smtp-Source: ABdhPJw8riN/Ffc8z7/sPSIKVbYqeRiW6Dfye8+HFmTkixcO+ut+MjIHsd+lzvV6bYTske1bkH+0iQ==
X-Received: by 2002:a17:90a:1c08:b0:1cd:474a:a4f8 with SMTP id s8-20020a17090a1c0800b001cd474aa4f8mr2810056pjs.82.1650096850114;
        Sat, 16 Apr 2022 01:14:10 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:9b6:6aad:72f6:6e16])
        by smtp.gmail.com with ESMTPSA id oa16-20020a17090b1bd000b001c72b632222sm11527623pjb.32.2022.04.16.01.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 01:14:09 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: enable KCSAN
Date:   Sat, 16 Apr 2022 01:13:55 -0700
Message-Id: <20220416081355.2155050-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefix arch-specific barrier macros with '__' to make use of instrumented
generic macros.
Prefix arch-specific bitops with 'arch_' to make use of instrumented
generic functions.
Provide stubs for 64-bit atomics when building with KCSAN.
Disable KCSAN instrumentation in arch/xtensa/boot.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig               |  1 +
 arch/xtensa/boot/lib/Makefile     |  1 +
 arch/xtensa/include/asm/barrier.h |  6 ++--
 arch/xtensa/include/asm/bitops.h  | 10 +++---
 arch/xtensa/lib/Makefile          |  2 ++
 arch/xtensa/lib/kcsan-stubs.c     | 54 +++++++++++++++++++++++++++++++
 6 files changed, 67 insertions(+), 7 deletions(-)
 create mode 100644 arch/xtensa/lib/kcsan-stubs.c

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 797355c142b3..c87f5ab493d9 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -29,6 +29,7 @@ config XTENSA
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
+	select HAVE_ARCH_KCSAN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CONTEXT_TRACKING
diff --git a/arch/xtensa/boot/lib/Makefile b/arch/xtensa/boot/lib/Makefile
index e3d717c7bfa1..162d10af36f3 100644
--- a/arch/xtensa/boot/lib/Makefile
+++ b/arch/xtensa/boot/lib/Makefile
@@ -16,6 +16,7 @@ CFLAGS_REMOVE_inffast.o = -pg
 endif
 
 KASAN_SANITIZE := n
+KCSAN_SANITIZE := n
 
 CFLAGS_REMOVE_inflate.o += -fstack-protector -fstack-protector-strong
 CFLAGS_REMOVE_zmem.o += -fstack-protector -fstack-protector-strong
diff --git a/arch/xtensa/include/asm/barrier.h b/arch/xtensa/include/asm/barrier.h
index d6f8d4ddc2bc..a22d4bb08159 100644
--- a/arch/xtensa/include/asm/barrier.h
+++ b/arch/xtensa/include/asm/barrier.h
@@ -11,9 +11,9 @@
 
 #include <asm/core.h>
 
-#define mb()  ({ __asm__ __volatile__("memw" : : : "memory"); })
-#define rmb() barrier()
-#define wmb() mb()
+#define __mb()  ({ __asm__ __volatile__("memw" : : : "memory"); })
+#define __rmb() barrier()
+#define __wmb() mb()
 
 #if XCHAL_HAVE_S32C1I
 #define __smp_mb__before_atomic()		barrier()
diff --git a/arch/xtensa/include/asm/bitops.h b/arch/xtensa/include/asm/bitops.h
index cd225896c40f..e02ec5833389 100644
--- a/arch/xtensa/include/asm/bitops.h
+++ b/arch/xtensa/include/asm/bitops.h
@@ -99,7 +99,7 @@ static inline unsigned long __fls(unsigned long word)
 #if XCHAL_HAVE_EXCLUSIVE
 
 #define BIT_OP(op, insn, inv)						\
-static inline void op##_bit(unsigned int bit, volatile unsigned long *p)\
+static inline void arch_##op##_bit(unsigned int bit, volatile unsigned long *p)\
 {									\
 	unsigned long tmp;						\
 	unsigned long mask = 1UL << (bit & 31);				\
@@ -119,7 +119,7 @@ static inline void op##_bit(unsigned int bit, volatile unsigned long *p)\
 
 #define TEST_AND_BIT_OP(op, insn, inv)					\
 static inline int							\
-test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)	\
+arch_test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)	\
 {									\
 	unsigned long tmp, value;					\
 	unsigned long mask = 1UL << (bit & 31);				\
@@ -142,7 +142,7 @@ test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)	\
 #elif XCHAL_HAVE_S32C1I
 
 #define BIT_OP(op, insn, inv)						\
-static inline void op##_bit(unsigned int bit, volatile unsigned long *p)\
+static inline void arch_##op##_bit(unsigned int bit, volatile unsigned long *p)\
 {									\
 	unsigned long tmp, value;					\
 	unsigned long mask = 1UL << (bit & 31);				\
@@ -163,7 +163,7 @@ static inline void op##_bit(unsigned int bit, volatile unsigned long *p)\
 
 #define TEST_AND_BIT_OP(op, insn, inv)					\
 static inline int							\
-test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)	\
+arch_test_and_##op##_bit(unsigned int bit, volatile unsigned long *p)	\
 {									\
 	unsigned long tmp, value;					\
 	unsigned long mask = 1UL << (bit & 31);				\
@@ -205,6 +205,8 @@ BIT_OPS(change, "xor", )
 #undef BIT_OP
 #undef TEST_AND_BIT_OP
 
+#include <asm-generic/bitops/instrumented-atomic.h>
+
 #include <asm-generic/bitops/le.h>
 
 #include <asm-generic/bitops/ext2-atomic-setbit.h>
diff --git a/arch/xtensa/lib/Makefile b/arch/xtensa/lib/Makefile
index 5848c133f7ea..d4e9c397e3fd 100644
--- a/arch/xtensa/lib/Makefile
+++ b/arch/xtensa/lib/Makefile
@@ -8,3 +8,5 @@ lib-y	+= memcopy.o memset.o checksum.o \
 	   divsi3.o udivsi3.o modsi3.o umodsi3.o mulsi3.o \
 	   usercopy.o strncpy_user.o strnlen_user.o
 lib-$(CONFIG_PCI) += pci-auto.o
+lib-$(CONFIG_KCSAN) += kcsan-stubs.o
+KCSAN_SANITIZE_kcsan-stubs.o := n
diff --git a/arch/xtensa/lib/kcsan-stubs.c b/arch/xtensa/lib/kcsan-stubs.c
new file mode 100644
index 000000000000..2b08faa62b86
--- /dev/null
+++ b/arch/xtensa/lib/kcsan-stubs.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bug.h>
+#include <linux/types.h>
+
+void __atomic_store_8(volatile void *p, u64 v, int i)
+{
+	BUG();
+}
+
+u64 __atomic_load_8(const volatile void *p, int i)
+{
+	BUG();
+}
+
+u64 __atomic_exchange_8(volatile void *p, u64 v, int i)
+{
+	BUG();
+}
+
+bool __atomic_compare_exchange_8(volatile void *p1, void *p2, u64 v, bool b, int i1, int i2)
+{
+	BUG();
+}
+
+u64 __atomic_fetch_add_8(volatile void *p, u64 v, int i)
+{
+	BUG();
+}
+
+u64 __atomic_fetch_sub_8(volatile void *p, u64 v, int i)
+{
+	BUG();
+}
+
+u64 __atomic_fetch_and_8(volatile void *p, u64 v, int i)
+{
+	BUG();
+}
+
+u64 __atomic_fetch_or_8(volatile void *p, u64 v, int i)
+{
+	BUG();
+}
+
+u64 __atomic_fetch_xor_8(volatile void *p, u64 v, int i)
+{
+	BUG();
+}
+
+u64 __atomic_fetch_nand_8(volatile void *p, u64 v, int i)
+{
+	BUG();
+}
-- 
2.30.2

