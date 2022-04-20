Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307BD508FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381658AbiDTTLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381649AbiDTTLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:11:08 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B90403CD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:08:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bg9so2483466pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RadBw9TnGKHb+r+fDSXV2TygRfs0ByPhIe2F4r3TF0c=;
        b=IDkxaISVk3SUWOfbx+6bVOy7mRc1IVLHC770O/5XdOZpiT8SRL8Gnf5TyoprEbVqZY
         pg4mCHFqQaAHKDb47gttBgPA6Dg7EgGGMCOrdnrsV9B86MbbOHkJhGV5bTK2oSCNduwq
         YkugE3XoA2k77uq4E9qSiLZa4Glsmnjn2KipkU1kU9ao18KnEY6TAoXFub54/r80eP6I
         iU9tAINcD2P5is2llPFIIQP23o5CvDZ+Yp4FuHSjCD05z3BJCD9JaqVckxfenMapdFik
         oAzqNFLWEQtTrgJ7xbXHEz5F1OCXVgH8842lGCPb8d2rKWN10rnI5jF+U+LZ46QQ/w5R
         eYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RadBw9TnGKHb+r+fDSXV2TygRfs0ByPhIe2F4r3TF0c=;
        b=qQXKyYunlip4gGpTd332SdCnTwqcdVf/k8wpf8soS6iGMQfBppsXeGK2LEQ2RQbhRY
         5bqLl//ojEr09mQ/UPQGqXCaVvbdpD9hPzB5zETTOIMlT/upPCRRYzFH7WxQQlAlILLh
         GaILR6qVJElTbVlMaq1OqVCqtnBpr78gVWYf13amJA1PpX7ApuDG/1vS0xpENJ9Neotm
         JAab3vdI8ceFQUEM7A7gkMrARulI+5sTyGdfh7Hj9dA05ZejVt6x7vAi1GQOq/QJed3q
         gfoAJguScQ1JxqBRSrISqSvLg/rP0PQRV7a3WUUi1kA/U/XfIIGCsprZQEgLaeSfTYyM
         tplQ==
X-Gm-Message-State: AOAM532lj/JaRUNu3Bg6nV3XUTW0mKngjr/kdmjUAHq0cHXGKS7O8BLe
        403Ba57yrEnEgEYooXW0PfA=
X-Google-Smtp-Source: ABdhPJzw1rqj/LW/kXZsZnZslHvtT9sak9FRpKjjM0AKIQVKs2olDv+lfCvqPIzZV9PIB5dMkbJYAQ==
X-Received: by 2002:a63:8bc7:0:b0:3aa:7a8b:cf67 with SMTP id j190-20020a638bc7000000b003aa7a8bcf67mr2185090pge.402.1650481700643;
        Wed, 20 Apr 2022 12:08:20 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:daec:60d:88f6:798a])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b0050a90fd59d5sm8263004pfh.50.2022.04.20.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 12:08:20 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] xtensa: enable KCSAN
Date:   Wed, 20 Apr 2022 12:08:05 -0700
Message-Id: <20220420190805.152533-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
Changes v1->v2:

- fix __wmb definition to use __mb instead of mb
- provide __smp_{,r,w}mb definitions because definitions from the
  asm-generic use mb/rmb/wmb instead of __mb/__rmb/__wmb, thus
  doubling KCSAN instrumentation.

  Both changes fix a few failures in the KCSAN testsuite.

 arch/xtensa/Kconfig               |  1 +
 arch/xtensa/boot/lib/Makefile     |  1 +
 arch/xtensa/include/asm/barrier.h | 12 +++++--
 arch/xtensa/include/asm/bitops.h  | 10 +++---
 arch/xtensa/lib/Makefile          |  2 ++
 arch/xtensa/lib/kcsan-stubs.c     | 54 +++++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 7 deletions(-)
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
index d6f8d4ddc2bc..898ea397e9bc 100644
--- a/arch/xtensa/include/asm/barrier.h
+++ b/arch/xtensa/include/asm/barrier.h
@@ -11,9 +11,15 @@
 
 #include <asm/core.h>
 
-#define mb()  ({ __asm__ __volatile__("memw" : : : "memory"); })
-#define rmb() barrier()
-#define wmb() mb()
+#define __mb()  ({ __asm__ __volatile__("memw" : : : "memory"); })
+#define __rmb() barrier()
+#define __wmb() __mb()
+
+#ifdef CONFIG_SMP
+#define __smp_mb() __mb()
+#define __smp_rmb() __rmb()
+#define __smp_wmb() __wmb()
+#endif
 
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

