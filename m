Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C651D512AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbiD1EwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbiD1EwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:52:02 -0400
X-Greylist: delayed 587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 21:48:48 PDT
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 666127DE21
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 21:48:48 -0700 (PDT)
Received: from fstn1-p1.ozlabs.ibm.com. (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id C92C980536;
        Thu, 28 Apr 2022 00:38:56 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, Tom Rix <trix@redhat.com>,
        Nick Terrell <terrelln@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH kernel] RFC: zstd: Fixing mixed module-builtin objects
Date:   Thu, 28 Apr 2022 14:38:50 +1000
Message-Id: <20220428043850.1706973-1-aik@ozlabs.ru>
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
a situation when files from lib/zstd/common/ are compiled once for
ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module) even though
CFLAGS are different for builtins and modules. So far somehow
this was not a problem until enabling LLVM LTO where it fails:

ld.lld: error: linking module flags 'Code Model': IDs have conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 'ld-temp.o'

This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
POWERPC as explained at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
but the current use of common files is wrong anyway.

This works around the issue by inlining common files and fixing few
conflicts.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I tried fixing it by hacking Makefile to produce a separate .o for "y" and
"m", like this:

+obj-common-y =  common/debug-y.o \
+               common/entropy_common-y.o \
+               common/error_private-y.o \
+               common/fse_decompress-y.o \
+               common/zstd_common-y.o
+obj-common-m =  common/debug-m.o \
+               common/entropy_common-m.o \
+               common/error_private-m.o \
+               common/fse_decompress-m.o \
+               common/zstd_common-m.o
+obj-common-m := $(addprefix $(obj)/, $(obj-common-m))
+obj-common-y := $(addprefix $(obj)/, $(obj-common-y))
+
+$(obj-common-m): $(obj)/%-m.o: %.c FORCE
+        $(call if_changed_dep,cc_o_c)
+$(obj-common-y): $(obj)/%-y.o: %.c FORCE
+        $(call if_changed_dep,cc_o_c)
+

and so on but could not make it work and I suspect there is
a better solution to the problem anyway, what is it?


---
 lib/zstd/Makefile                 | 10 ----------
 lib/zstd/common/error_private.h   |  2 +-
 lib/zstd/common/entropy_common.c  |  4 ++--
 lib/zstd/zstd_compress_module.c   |  6 ++++++
 lib/zstd/zstd_decompress_module.c |  6 ++++++
 5 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
index fc45339fc3a3..ee42f07711ea 100644
--- a/lib/zstd/Makefile
+++ b/lib/zstd/Makefile
@@ -13,11 +13,6 @@ obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
 
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
@@ -33,11 +28,6 @@ zstd_compress-y := \
 
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
diff --git a/lib/zstd/common/error_private.h b/lib/zstd/common/error_private.h
index d14e686adf95..e1570545c6af 100644
--- a/lib/zstd/common/error_private.h
+++ b/lib/zstd/common/error_private.h
@@ -42,7 +42,7 @@ typedef ZSTD_ErrorCode ERR_enum;
 #define ERROR(name) ZSTD_ERROR(name)
 #define ZSTD_ERROR(name) ((size_t)-PREFIX(name))
 
-ERR_STATIC unsigned ERR_isError(size_t code) { return (code > ERROR(maxCode)); }
+ERR_STATIC inline unsigned ERR_isError(size_t code) { return (code > ERROR(maxCode)); }
 
 ERR_STATIC ERR_enum ERR_getErrorCode(size_t code) { if (!ERR_isError(code)) return (ERR_enum)0; return (ERR_enum) (0-code); }
 
diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
index 53b47a2b52ff..863afecb7743 100644
--- a/lib/zstd/common/entropy_common.c
+++ b/lib/zstd/common/entropy_common.c
@@ -28,10 +28,10 @@ unsigned FSE_versionNumber(void) { return FSE_VERSION_NUMBER; }
 
 
 /*===   Error Management   ===*/
-unsigned FSE_isError(size_t code) { return ERR_isError(code); }
+#define FSE_isError  ERR_isError
 const char* FSE_getErrorName(size_t code) { return ERR_getErrorName(code); }
 
-unsigned HUF_isError(size_t code) { return ERR_isError(code); }
+#define HUF_isError  ERR_isError
 const char* HUF_getErrorName(size_t code) { return ERR_getErrorName(code); }
 
 
diff --git a/lib/zstd/zstd_compress_module.c b/lib/zstd/zstd_compress_module.c
index 65548a4bb934..a4ad46fc1f12 100644
--- a/lib/zstd/zstd_compress_module.c
+++ b/lib/zstd/zstd_compress_module.c
@@ -158,3 +158,9 @@ EXPORT_SYMBOL(zstd_end_stream);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Zstd Compressor");
+
+#include "common/debug.c"
+#include "common/entropy_common.c"
+#include "common/error_private.c"
+#include "common/fse_decompress.c"
+#include "common/zstd_common.c"
diff --git a/lib/zstd/zstd_decompress_module.c b/lib/zstd/zstd_decompress_module.c
index f4ed952ed485..21820588835d 100644
--- a/lib/zstd/zstd_decompress_module.c
+++ b/lib/zstd/zstd_decompress_module.c
@@ -103,3 +103,9 @@ EXPORT_SYMBOL(zstd_get_frame_header);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Zstd Decompressor");
+
+#include "common/debug.c"
+#include "common/entropy_common.c"
+#include "common/error_private.c"
+#include "common/fse_decompress.c"
+#include "common/zstd_common.c"
-- 
2.30.2

