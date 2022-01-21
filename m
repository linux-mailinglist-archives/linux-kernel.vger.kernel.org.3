Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFA7495739
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378350AbiAUAMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378214AbiAUAMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:12:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02252C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 16:12:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso12133975pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 16:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l9ZmN4zfb/HWIDPYqQoHKM8YHncwPREdExMif4xKc1M=;
        b=hkzV1e0lSQKitlOFnDn9e7B/6g7NCFEf4lyLaZEAHmh+Gnqf0HbDtz73fDiBas3D3j
         f06XOMdiReN2+U84GyH1Rwo7BZ4GC+kHx/T7TfFHn4XoQ2eT/5tFC6JDJsSnx3klL98O
         bEyz5Plgs0tTzlxdvEu/KRTYgCtIjMuYBRmmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l9ZmN4zfb/HWIDPYqQoHKM8YHncwPREdExMif4xKc1M=;
        b=oi7byzHqEN1/iGU45pCmboZC/ef0RJKf6Nixan1EPMfALECSHYXlmn/JunnsHFpIEu
         xm1gllNe7wyefZqznbuPpFoYrWJ4oUcsMNnEh6hXmZXsRHazPrswCg3YQxVEBKwSoKuv
         klcPxhioThUTZSnwD5MlgrwfIRjbSkU2DOIUozBEIZrxNGHj9BX5fZLwUbnIcLMnC2Vw
         b1Co5oF57k4C2TTQLErFwMr1oYIhL8wEyxiCogd/pvD6wtB/mQTZRqad1c4PyvkjkF07
         XWLx0/d/D2I3JUfEA+Ym1tpbPEoU4i8/+m6FTqvw4iel3kVn+MvO9iSAoCsyuCWrZRsb
         OJQg==
X-Gm-Message-State: AOAM531UmBbLRenCbLo+06OS1VrFnZdlD21DfwNr1/YCMEfSYgsAH/Fo
        u/dluVmZieBMI/JHKzs8rM+b5w==
X-Google-Smtp-Source: ABdhPJx5rb0yxfThjcW0UDYnpSANkDDdgNHCSQluLjAmAX9cSSX1o85atqhWnUi5hsteD0L6Vva8Yw==
X-Received: by 2002:a17:90b:3a87:: with SMTP id om7mr13861381pjb.16.1642723928508;
        Thu, 20 Jan 2022 16:12:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm4555482pfu.35.2022.01.20.16.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 16:12:07 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Helge Deller <deller@gmx.de>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] Kconfig.debug: Make DEBUG_INFO selectable from a choice
Date:   Thu, 20 Jan 2022 16:12:04 -0800
Message-Id: <20220121001204.4023842-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8106; h=from:subject; bh=1slPfpPmdfue8efo6hKdNtZnzF08JztveJdrRH/kK5c=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh6fpT4Q6jMaxDCeZdV+PXgJG7B9Jt6/AuwDj5a+NG j3jAz+iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYen6UwAKCRCJcvTf3G3AJobVEA Cq3L0eyAx5dp3vUS/vvZlx1+5LeJfbQ7R9LLvorrAM4F1R3A8TZ+52Mwsvn0UO3QZauavNcSFY4IT0 8hKvDz09852hdgzMer4zp5pAHFfIXKZyyapXc/01nmklisFJ3hbJbzvP0n1KdSloz/nvlYqudUbORN vTCEsCow/murx97/C1zTYCmdpi/aRouwK2srDVX7DcH3h7bdDYW8ADkOLKi8pw6r8TAdqvmwx8Y7un pp1VWihPeTYuC9dsl+oPAaNYUQ7DLxp5qu2wjnV1/IQ4gstPi16oH1uAIB21wXUO+XXxJCpcMJxHw4 QJN0WhanMqQ7DvdaAthYVk73ViOffqU8VT0OS4de5bCQkKKnTrmVpICmx3zhVp4dPOFMkts49ukDKi ltDTpBsgW3YHI66yjMVFDqOC06Ym/EdpyiFqKVqTecyNIijyEMJRBC64s22xAFBLLaTX+rszNfEfN5 im1R8UgF69ILzjgGpds6J0jlrLbclbbUCXFGCn+2nMtdoW/Zbp6sU46XD1Jx7DMRzehShzge17yYdH Go3rERmrg0Tprj3U4HIAxpzqXdqvc3av06hj83pX3zSFKif60fPRry+M7HCaU3yQYRMma2wZss9g0T ftVGMyy7yREDd7BSsREJVuSwRg9+tw8N8rEQZtCfJ+pI762lredDwjzuX/Qw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it's not possible to enable DEBUG_INFO for an all*config build,
since it is marked as "depends on !COMPILE_TEST". This generally makes
sense because a debug build of an all*config target ends up taking much
longer and the output is much larger. Having this be "default off" makes
sense. However, there are cases where enabling DEBUG_INFO for such builds
is useful for doing treewide A/B comparisons of build options, etc.

Make DEBUG_INFO selectable from any of the DWARF version choice options,
with DEBUG_INFO_NONE being the default for COMPILE_TEST. The mutually
exclusive relationship between DWARF5 and BTF must be inverted, but the
result remains the same. Additionally moves DEBUG_KERNEL and DEBUG_MISC
up to the top of the menu because they were enabling features _above_
it, making it weird to navigate menuconfig.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20211210000910.3597609-1-keescook@chromium.org/
v2:
 - simplify default vs COMPILE_TEST (Arnd, Masahiro)
 - add Reviewed/Tested-by tags
---
 lib/Kconfig.debug | 141 ++++++++++++++++++++++++----------------------
 1 file changed, 75 insertions(+), 66 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5c12bde10996..3be525ad0013 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -208,20 +208,88 @@ config DEBUG_BUGVERBOSE
 
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
+config DEBUG_INFO_NONE
+	bool "Disable debug information"
+	help
+	  Do not build the kernel with debugging information, which will
+	  result in a faster and smaller build.
+
+endchoice # "Debug information"
 
 if DEBUG_INFO
 
@@ -267,55 +335,11 @@ config DEBUG_INFO_SPLIT
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
@@ -584,21 +608,6 @@ source "lib/Kconfig.kcsan"
 
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

