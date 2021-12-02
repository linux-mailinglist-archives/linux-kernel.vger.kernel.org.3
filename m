Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB146652C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347284AbhLBO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:26:25 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32869 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbhLBO0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:26:22 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J4dTQ0nd5zcbmH;
        Thu,  2 Dec 2021 22:22:50 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 22:22:57 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 22:22:57 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mark.rutland@arm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] arm64: Enable KCSAN
Date:   Thu, 2 Dec 2021 22:33:31 +0800
Message-ID: <20211202143331.15259-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables KCSAN for arm64, with updates to build rules
to not use KCSAN for several incompatible compilation units.

Resent GCC version(at least GCC10) made outline-atomics as the
default option(unlike Clang), which will cause linker errors
for kernel/kcsan/core.o. Disables the out-of-line atomics by
no-outline-atomics to fix the linker errors.

Meanwhile, as Mark said[1], there is a specific issue on arm64
about ARM64_BTI with Clang 11 if KCSAN enabled, which is fixed
by Clang 12, add CLANG_VERSION check. And also some latent issues
are need to be fixed which isn't just a KCSAN problem, we make
the KCSAN depends on EXPERT for now.

Tested selftest and kcsan_test(built with GCC11 and Clang 13),
and all passed.

[1] https://lkml.org/lkml/2021/12/1/354
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
Tested on Qemu with clang 13 / gcc 11, based on 5.16-rc3.

[    0.221518] kcsan: enabled early
[    0.222422] kcsan: strict mode configured
...
[    5.839223] kcsan: selftest: 3/3 tests passed
...
[  517.895102] # kcsan: pass:24 fail:0 skip:0 total:24
[  517.896393] # Totals: pass:168 fail:0 skip:0 total:168
[  517.897502] ok 1 - kcsan

v3:
- add EXPERT and CLANG_VERSION depends suggested by Mark Rutland
v2:
- tested on GCC11 and disable outline-atomics for kernel/kcsan/core.c
  suggested by Marco Elver

 arch/arm64/Kconfig               | 1 +
 arch/arm64/kernel/vdso/Makefile  | 1 +
 arch/arm64/kvm/hyp/nvhe/Makefile | 1 +
 kernel/kcsan/Makefile            | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4ff73299f8a9..3a7b17742cde 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -150,6 +150,7 @@ config ARM64
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
+	select HAVE_ARCH_KCSAN if EXPERT && (CC_IS_GCC || CLANG_VERSION >= 120000)
 	select HAVE_ARCH_KFENCE
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 700767dfd221..60813497a381 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -32,6 +32,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
 				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT			:= n
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index c3c11974fa3b..24b2c2425b38 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -89,6 +89,7 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI)
 # cause crashes. Just disable it.
 GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
+KCSAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index c2bb07f5bcc7..e893b0e1d62a 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -8,6 +8,7 @@ CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 
 CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
+	$(call cc-option,-mno-outline-atomics) \
 	-fno-stack-protector -DDISABLE_BRANCH_PROFILING
 
 obj-y := core.o debugfs.o report.o
-- 
2.26.2

