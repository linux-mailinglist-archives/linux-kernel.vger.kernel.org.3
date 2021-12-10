Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4F946F7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhLJAMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbhLJAMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:12:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BF4C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 16:09:13 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so8196751pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 16:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYhEGWCDClAWGwpkQQdIwrtQzcXKRI06FajBL4XOjBk=;
        b=M0qqFN19Gk1tA4x9fSObuTLXNEVR2zELetmtzyeM+YN7CyFQqZh8FCME8SPcZuaQNH
         qSOD4hIlayhhBJysd2ZI4ZaYRG2NmL33b8cVf1RoYnnwr/mq02FcOPUZnEohxxzc1NDj
         oKtAYyUEiYCiziVDkzpMrZ61ZH4fr38xQqyLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYhEGWCDClAWGwpkQQdIwrtQzcXKRI06FajBL4XOjBk=;
        b=ROpF1C9NLON/8QMHKMfMzs5EDcr0mrPDreneBQe0hbb+fn+5ugNK9ELqDwHluLd/4i
         nQ5tDivyUfqiwpuvahv+jNtF6wIFz9CIGui79T5z68UTaoEp6cLVZinaNTlWccddd3r+
         g7+SmTVvZtVdKm7zDz+Tcg78E02jHgYMQjbX6Nea8OsJNebnAfx/i4tCgz8dr+vKnzbg
         LnFbbTrIoN3qx05HqHFUjtKn7A3m2GYxYfQM3CXu1ShCd+X7B0k8ISDrg2fwemI2ELzc
         KHq5o2J8TyaTEyzCAnN1QMn7wxs+7tvErObxWJuY/oU1+Zgc3tjRVfTXjjFZgFpN75Lb
         JYgg==
X-Gm-Message-State: AOAM532Dze/Kr5o+lrAlqjA/ZM7Bq2cEJlMePWYlqap1vn44BmvbN+Zg
        oY2q0aSmhRV/py6+1RQ/iQuauw==
X-Google-Smtp-Source: ABdhPJzyj+0v4GjpP8v6n76+3MfaiA00zzb+uhFCVkCSTGyjSheOzUY9SjpVuogLNj/g9B7y2WkciA==
X-Received: by 2002:a17:902:ed89:b0:141:f601:d6a with SMTP id e9-20020a170902ed8900b00141f6010d6amr71299439plj.77.1639094953189;
        Thu, 09 Dec 2021 16:09:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pf15sm11139718pjb.40.2021.12.09.16.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 16:09:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] Kconfig.debug: Make DEBUG_INFO selectable from a choice
Date:   Thu,  9 Dec 2021 16:09:10 -0800
Message-Id: <20211210000910.3597609-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7583; h=from:subject; bh=UPgRbnYv7Ry4qA/dTIwI6goS9rwfFcq+cyW1y+42CEw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhspql1U9fllRDfMVcShN6txLNBqfElbfSX6NZVt3M FowR88+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYbKapQAKCRCJcvTf3G3AJn+9D/ 0QoJX5ibmxD8+34mdtECJpexAGJVG8Qr1Xlut0qDxSOrn7crIwAPfdD9AA2zSL3S52Ymm3x0+ie2Nn VAFKcvGzeWqT6R1xcR5W3tRkym8EiyWY6dPoGsysptdtOBa5/JqIf3YKkH7RMSDrTYLxJ+5/XiEWcd jqpIkyDhLGgfoC6qCVM1GqEboY3iCrinJOGErLxnxyHNNCV5rsk1ivYDs70QyAHDQeJ+2R9NkApelO ll95+V91DhRqsOkezvwAjtWL3Jv0MStGTx6FQRaRh0JIB5qI8DkvYk123UV8c1dXEII8B+dsF/memo JwAan41AmcBwKh0SUUVSLPfc38CGWIBoP79fK7XLZPrplm/ZFKfsmPPDcWQgMUFImLBZCQ0vgc4aFV 8R9qW8v8jn5H4P2RRYTDJ2Os5WNnREKQ5iIqMrAWwPLhZTNfCsqkjPvkCCNcYcVyGA4rLRjGW79elO ITnZyN1qf2tLJei2YwGfCTbb469MT5VvxIPXMtdGmEolczm22ArwCks7sL5cNNo19MxFGIZBdBi1/z RFeJkqJpN8rpHoS/G41oNKtHpIu5AQm1PeUTmdhFr/KBNKzZBGhytd1KA0rWBMXlHCyoljs/61SE38 jPBr0L5iaSijxqRzOpj3MgzIPN+0ITGrOtk7/GORJE9csyKhD8e1n3T3tsXw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it's not possible to enable DEBUG_INFO for an all*config
build, since it is marked as "depends on !COMPILE_TEST". This generally
makes sense because a debug build of an all*config target ends up taking
much longer and the output is much larger. Having this be "default off"
makes sense. However, there are cases where enabling DEBUG_INFO for such
builds is useful for doing treewide A/B comparisons of build options,
etc.

Make DEBUG_INFO selectable from any of the DWARF version choice options,
with DEBUG_INFO_NONE being the default for COMPILE_TEST. The mutually
exclusive relationship between DWARF5 and BTF must be inverted, but the
result remains the same. Additionally moves DEBUG_KERNEL and DEBUG_MISC
up to the top of the menu because was enabling features _above_ it,
making it weird to navigate menuconfig.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug | 142 +++++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 66 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5c12bde10996..70ef47e92681 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -208,20 +208,89 @@ config DEBUG_BUGVERBOSE
 
 endmenu # "printk and dmesg options"
 
+config DEBUG_KERNEL
+	bool "Kernel debugging"
+	help
+	  Say Y here if you are developing drivers or trying to debug and
+	  identify kernel problems.
+
+config DEBUG_MISC
+	bool "Miscellaneous debug code"
+	default DEBUG_KERNEL
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here if you need to enable miscellaneous debug code that should
+	  be under a more specific debug option but isn't.
+
 menu "Compile-time checks and compiler options"
 
 config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL && !COMPILE_TEST
+	bool
 	help
-	  If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
+	  A kernel debug info option other than "None" has been selected
+	  in the "Debug information" choice below, indicating that debug
+	  information will be generated for build targets.
+
+choice
+	prompt "Debug information"
+	depends on DEBUG_KERNEL
+	default DEBUG_INFO_NONE if COMPILE_TEST
+	default DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT if DEBUG_KERNEL
+	help
+	  Selecting something other than "None" results in a kernel image
+	  that will include debugging info resulting in a larger kernel image.
 	  This adds debug symbols to the kernel and modules (gcc -g), and
 	  is needed if you intend to use kernel crashdump or binary object
 	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
-	  Say Y here only if you plan to debug the kernel.
 
-	  If unsure, say N.
+	  Choose which version of DWARF debug info to emit. If unsure,
+	  select "Toolchain default".
+
+config DEBUG_INFO_NONE
+	bool "Disable debug information"
+	help
+	  Do not build the kernel with debugging information, which will
+	  result in a faster and smaller build.
+
+config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
+	bool "Rely on the toolchain's implicit default DWARF version"
+	select DEBUG_INFO
+	help
+	  The implicit default version of DWARF debug info produced by a
+	  toolchain changes over time.
+
+	  This can break consumers of the debug info that haven't upgraded to
+	  support newer revisions, and prevent testing newer versions, but
+	  those should be less common scenarios.
+
+config DEBUG_INFO_DWARF4
+	bool "Generate DWARF Version 4 debuginfo"
+	select DEBUG_INFO
+	help
+	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
+
+	  If you have consumers of DWARF debug info that are not ready for
+	  newer revisions of DWARF, you may wish to choose this or have your
+	  config select this.
+
+config DEBUG_INFO_DWARF5
+	bool "Generate DWARF Version 5 debuginfo"
+	select DEBUG_INFO
+	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
+	help
+	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
+	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
+	  draft features until 7.0), and gdb 8.0+.
+
+	  Changes to the structure of debug info in Version 5 allow for around
+	  15-18% savings in resulting image and debug info section sizes as
+	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
+	  extensions such as accelerators for symbol indexing and the format
+	  for fission (.dwo/.dwp) files. Users may not want to select this
+	  config if they rely on tooling that has not yet been updated to
+	  support DWARF Version 5.
+
+endchoice # "Debug information"
 
 if DEBUG_INFO
 
@@ -267,55 +336,11 @@ config DEBUG_INFO_SPLIT
 	  to know about the .dwo files and include them.
 	  Incompatible with older versions of ccache.
 
-choice
-	prompt "DWARF version"
-	help
-	  Which version of DWARF debug info to emit.
-
-config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
-	bool "Rely on the toolchain's implicit default DWARF version"
-	help
-	  The implicit default version of DWARF debug info produced by a
-	  toolchain changes over time.
-
-	  This can break consumers of the debug info that haven't upgraded to
-	  support newer revisions, and prevent testing newer versions, but
-	  those should be less common scenarios.
-
-	  If unsure, say Y.
-
-config DEBUG_INFO_DWARF4
-	bool "Generate DWARF Version 4 debuginfo"
-	help
-	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
-
-	  If you have consumers of DWARF debug info that are not ready for
-	  newer revisions of DWARF, you may wish to choose this or have your
-	  config select this.
-
-config DEBUG_INFO_DWARF5
-	bool "Generate DWARF Version 5 debuginfo"
-	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
-	depends on !DEBUG_INFO_BTF
-	help
-	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
-	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
-	  draft features until 7.0), and gdb 8.0+.
-
-	  Changes to the structure of debug info in Version 5 allow for around
-	  15-18% savings in resulting image and debug info section sizes as
-	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
-	  extensions such as accelerators for symbol indexing and the format
-	  for fission (.dwo/.dwp) files. Users may not want to select this
-	  config if they rely on tooling that has not yet been updated to
-	  support DWARF Version 5.
-
-endchoice # "DWARF version"
-
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
+	depends on !DEBUG_INFO_DWARF5
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
@@ -584,21 +609,6 @@ source "lib/Kconfig.kcsan"
 
 endmenu
 
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config DEBUG_MISC
-	bool "Miscellaneous debug code"
-	default DEBUG_KERNEL
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here if you need to enable miscellaneous debug code that should
-	  be under a more specific debug option but isn't.
-
-
 menu "Memory Debugging"
 
 source "mm/Kconfig.debug"
-- 
2.30.2

