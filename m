Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E545141CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 07:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352340AbiD2Fgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 01:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351502AbiD2Fgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 01:36:52 -0400
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E23095A29
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 22:33:34 -0700 (PDT)
Received: from fstn1-p1.ozlabs.ibm.com. (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 312E58053C;
        Fri, 29 Apr 2022 01:33:31 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nick Terrell <terrelln@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH kernel v2] zstd: Fixing mixed module-builtin objects
Date:   Fri, 29 Apr 2022 15:33:29 +1000
Message-Id: <20220429053329.2278740-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
a situation when files from lib/zstd/common/ are compiled once to be
linked later for ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module)
even though CFLAGS are different for builtins and modules.
So far somehow this was not a problem but enabling LLVM LTO exposes
the problem as:

ld.lld: error: linking module flags 'Code Model': IDs have conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 'ld-temp.o'

This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
POWERPC as explained at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
but the current use of common files is wrong anyway.

This works around the issue by introducing a zstd_common module with
shared code.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* add a new module instead of inlining common bits

---
 lib/zstd/Makefile                | 18 ++++++++----------
 lib/zstd/common/entropy_common.c |  4 +++-
 lib/zstd/common/zstd_common.c    |  7 +++++++
 lib/Kconfig                      |  8 ++++++--
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index fc45339fc3a3..440bd0007ae2 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -10,14 +10,10 @@
 # ################################################################
 obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
 obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
+obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
 
 zstd_compress-y := \
 		zstd_compress_module.o \
-		common/debug.o \
-		common/entropy_common.o \
-		common/error_private.o \
-		common/fse_decompress.o \
-		common/zstd_common.o \
 		compress/fse_compress.o \
 		compress/hist.o \
 		compress/huf_compress.o \
@@ -33,12 +29,14 @@ zstd_compress-y := \
 
 zstd_decompress-y := \
 		zstd_decompress_module.o \
-		common/debug.o \
-		common/entropy_common.o \
-		common/error_private.o \
-		common/fse_decompress.o \
-		common/zstd_common.o \
 		decompress/huf_decompress.o \
 		decompress/zstd_ddict.o \
 		decompress/zstd_decompress.o \
 		decompress/zstd_decompress_block.o \
+
+zstd_common-y := \
+		common/debug.o \
+		common/entropy_common.o \
+		common/error_private.o \
+		common/fse_decompress.o \
+		common/zstd_common.o \
diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
index 53b47a2b52ff..f84612627471 100644
--- a/lib/zstd/common/entropy_common.c
+++ b/lib/zstd/common/entropy_common.c
@@ -15,6 +15,7 @@
 /* *************************************
 *  Dependencies
 ***************************************/
+#include <linux/module.h>
 #include "mem.h"
 #include "error_private.h"       /* ERR_*, ERROR */
 #define FSE_STATIC_LINKING_ONLY  /* FSE_MIN_TABLELOG */
@@ -239,7 +240,7 @@ size_t FSE_readNCount(
 {
     return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr, tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
 }
-
+EXPORT_SYMBOL_GPL(FSE_readNCount);
 
 /*! HUF_readStats() :
     Read compact Huffman tree, saved by HUF_writeCTable().
@@ -255,6 +256,7 @@ size_t HUF_readStats(BYTE* huffWeight, size_t hwSize, U32* rankStats,
     U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
     return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 */ 0);
 }
+EXPORT_SYMBOL_GPL(HUF_readStats);
 
 FORCE_INLINE_TEMPLATE size_t
 HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U32* rankStats,
diff --git a/lib/zstd/common/zstd_common.c b/lib/zstd/common/zstd_common.c
index 3d7e35b309b5..06f62b2026d5 100644
--- a/lib/zstd/common/zstd_common.c
+++ b/lib/zstd/common/zstd_common.c
@@ -13,6 +13,7 @@
 /*-*************************************
 *  Dependencies
 ***************************************/
+#include <linux/module.h>
 #define ZSTD_DEPS_NEED_MALLOC
 #include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free, ZSTD_memset */
 #include "error_private.h"
@@ -59,6 +60,7 @@ void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem)
         return customMem.customAlloc(customMem.opaque, size);
     return ZSTD_malloc(size);
 }
+EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
 
 void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
 {
@@ -71,6 +73,7 @@ void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
     }
     return ZSTD_calloc(1, size);
 }
+EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
 
 void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
 {
@@ -81,3 +84,7 @@ void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
             ZSTD_free(ptr);
     }
 }
+EXPORT_SYMBOL_GPL(ZSTD_customFree);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("Zstd Common");
diff --git a/lib/Kconfig b/lib/Kconfig
index 087e06b4cdfd..33f3a7054cdd 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -333,12 +333,16 @@ config LZ4HC_COMPRESS
 config LZ4_DECOMPRESS
 	tristate
 
+config ZSTD_COMMON
+	select XXHASH
+	tristate
+
 config ZSTD_COMPRESS
-	select XXHASH
+	select ZSTD_COMMON
 	tristate
 
 config ZSTD_DECOMPRESS
-	select XXHASH
+	select ZSTD_COMMON
 	tristate
 
 source "lib/xz/Kconfig"
-- 
2.30.2

