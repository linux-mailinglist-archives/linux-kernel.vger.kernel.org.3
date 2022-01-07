Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96848487CA9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiAGS6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:58:02 -0500
Received: from aposti.net ([89.234.176.197]:59818 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231931AbiAGS53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:57:29 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        list@opendingux.net, Paul Cercueil <paul@crapouillou.net>,
        kernel test robot <lkp@intel.com>,
        Nick Terrell <terrelln@fb.com>
Subject: [PATCH] MIPS: compressed: Fix build with ZSTD compression
Date:   Fri,  7 Jan 2022 18:57:22 +0000
Message-Id: <20220107185722.78693-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build issues:

mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `FSE_buildDTable_internal':
 decompress.c:(.text.FSE_buildDTable_internal+0x2cc): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `BIT_initDStream':
   decompress.c:(.text.BIT_initDStream+0x7c): undefined reference to `__clzdi2'
   mips64el-linux-ld: decompress.c:(.text.BIT_initDStream+0x158): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `ZSTD_buildFSETable_body_default.constprop.0':
 decompress.c:(.text.ZSTD_buildFSETable_body_default.constprop.0+0x2a8): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `FSE_readNCount_body_default':
 decompress.c:(.text.FSE_readNCount_body_default+0x130): undefined reference to `__ctzdi2'
 mips64el-linux-ld: decompress.c:(.text.FSE_readNCount_body_default+0x1a4): undefined reference to `__ctzdi2'
 mips64el-linux-ld: decompress.c:(.text.FSE_readNCount_body_default+0x2e4): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `HUF_readStats_body_default':
 decompress.c:(.text.HUF_readStats_body_default+0x184): undefined reference to `__clzdi2'
 mips64el-linux-ld: decompress.c:(.text.HUF_readStats_body_default+0x1b4): undefined reference to `__clzdi2'
   mips64el-linux-ld: arch/mips/boot/compressed/decompress.o: in function `ZSTD_DCtx_getParameter':
 decompress.c:(.text.ZSTD_DCtx_getParameter+0x60): undefined reference to `__clzdi2'

Fixes: a510b616131f ("MIPS: Add support for ZSTD-compressed kernels")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Nick Terrell <terrelln@fb.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/compressed/Makefile  | 2 +-
 arch/mips/boot/compressed/clz_ctz.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/compressed/clz_ctz.c

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index f27cf31b4140..38e233f7fd7a 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -52,7 +52,7 @@ endif
 
 vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o
 
-vmlinuzobjs-$(CONFIG_KERNEL_ZSTD) += $(obj)/bswapdi.o $(obj)/ashldi3.o
+vmlinuzobjs-$(CONFIG_KERNEL_ZSTD) += $(obj)/bswapdi.o $(obj)/ashldi3.o $(obj)/clz_ctz.o
 
 targets := $(notdir $(vmlinuzobjs-y))
 
diff --git a/arch/mips/boot/compressed/clz_ctz.c b/arch/mips/boot/compressed/clz_ctz.c
new file mode 100644
index 000000000000..b4a1b6eb2f8a
--- /dev/null
+++ b/arch/mips/boot/compressed/clz_ctz.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../../../lib/clz_ctz.c"
-- 
2.34.1

