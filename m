Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A774D23B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350525AbiCHV6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344765AbiCHV6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:58:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8918655BE3;
        Tue,  8 Mar 2022 13:57:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A82A6190F;
        Tue,  8 Mar 2022 21:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011FCC340F6;
        Tue,  8 Mar 2022 21:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646776625;
        bh=cZHVvYurJxQgFY5AgNyvVfreqItHQzRF163PJAcCkJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwBiCBszTgq6qEM/tl6vNQkyX5wXU23YrjiCWnPo/9gGIDDjyS3HCdCXKpp6n7RTc
         7Zn4CPsVkpKvl1KsuzYPJACqh6OBvBuDJcMFWF2J7NjMY1poqdPrkdjbC2o8T11wJ6
         PhLSzCZxp74RdLLseLMB3zPXh/caO3tcLkqzKGgE+ZIOe/6digHFiXhtEoQKGIv4DD
         VN3FbYcvOo2UvV+GKhNYpuSvnHXdxOAe26XGkECxdWC9mfG5xAmVfFX7yrKtykYCuE
         puIbTzWgiauvCB8R3LVNpwbjkHHkDL7SrOHwQ/SWzqot80IrpqQlbD8qXRF5CiHqnM
         IkTE6siqH113A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     alexs@kernel.org, arnd@arndb.de, arnd@kernel.org, dsterba@suse.com,
        elver@google.com, jani.nikula@intel.com, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, mark.rutland@arm.com,
        ndesaulniers@google.com, ojeda@kernel.org,
        torvalds@linux-foundation.org, Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH 3/4] [v4] Kbuild: move to -std=gnu11
Date:   Tue,  8 Mar 2022 22:56:14 +0100
Message-Id: <20220308215615.14183-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220308215615.14183-1-arnd@kernel.org>
References: <20220308215615.14183-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

During a patch discussion, Linus brought up the option of changing
the C standard version from gnu89 to gnu99, which allows using variable
declaration inside of a for() loop. While the C99, C11 and later standards
introduce many other features, most of these are already available in
gnu89 as GNU extensions as well.

An earlier attempt to do this when gcc-5 started defaulting to
-std=gnu11 failed because at the time that caused warnings about
designated initializers with older compilers. Now that gcc-5.1 is
the minimum compiler version used for building kernels, that is no
longer a concern. Similarly, the behavior of 'inline' functions changes
between gnu89 using gnu_inline behavior and gnu11 using standard c99+
behavior, but this was taken care of by defining 'inline' to include
__attribute__((gnu_inline)) in order to allow building with clang a
while ago.

Nathan Chancellor reported a new -Wdeclaration-after-statement
warning that appears in a system header on arm, this still needs a
workaround.

The differences between gnu99, gnu11, gnu1x and gnu17 are fairly
minimal and mainly impact warnings at the -Wpedantic level that the
kernel never enables. Between these, gnu11 is the newest version
that is supported by all supported compiler versions, though it is
only the default on gcc-5, while all other supported versions of
gcc or clang default to gnu1x/gnu17.

Link: https://lore.kernel.org/lkml/CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com/
Link: https://github.com/ClangBuiltLinux/linux/issues/1603
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Marco Elver <elver@google.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: David Sterba <dsterba@suse.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Alex Shi <alexs@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
[v4]
 - split -Wno-shift-negative-value into a separate patch

[v3]
 - split out USERCFLAGS to a separate patch
 - add -Wdeclaration-after-statement patch from Mark Rutland
 - leave out C17 reference
 - more rewording the descrption

[v2]
 - added -std=gnu11 back, rather than just relying on the default
 - minor changes to changelog text
---
 Documentation/process/programming-language.rst              | 6 +++---
 .../translations/it_IT/process/programming-language.rst     | 4 ++--
 .../translations/zh_CN/process/programming-language.rst     | 3 +--
 .../translations/zh_TW/process/programming-language.rst     | 3 +--
 Makefile                                                    | 4 ++--
 arch/arm64/kernel/vdso32/Makefile                           | 2 +-
 6 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/process/programming-language.rst b/Documentation/process/programming-language.rst
index ec474a70a02f..5fc9160ca1fa 100644
--- a/Documentation/process/programming-language.rst
+++ b/Documentation/process/programming-language.rst
@@ -5,9 +5,9 @@ Programming Language
 
 The kernel is written in the C programming language [c-language]_.
 More precisely, the kernel is typically compiled with ``gcc`` [gcc]_
-under ``-std=gnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO C90
-(including some C99 features). ``clang`` [clang]_ is also supported, see
-docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
+under ``-std=gnu11`` [gcc-c-dialect-options]_: the GNU dialect of ISO C11.
+``clang`` [clang]_ is also supported, see docs on
+:ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
 
 This dialect contains many extensions to the language [gnu-extensions]_,
 and many of them are used within the kernel as a matter of course.
diff --git a/Documentation/translations/it_IT/process/programming-language.rst b/Documentation/translations/it_IT/process/programming-language.rst
index 41db2598ce11..c1a9b481a6f9 100644
--- a/Documentation/translations/it_IT/process/programming-language.rst
+++ b/Documentation/translations/it_IT/process/programming-language.rst
@@ -10,8 +10,8 @@ Linguaggio di programmazione
 
 Il kernel è scritto nel linguaggio di programmazione C [it-c-language]_.
 Più precisamente, il kernel viene compilato con ``gcc`` [it-gcc]_ usando
-l'opzione ``-std=gnu89`` [it-gcc-c-dialect-options]_: il dialetto GNU
-dello standard ISO C90 (con l'aggiunta di alcune funzionalità da C99).
+l'opzione ``-std=gnu11`` [it-gcc-c-dialect-options]_: il dialetto GNU
+dello standard ISO C11.
 Linux supporta anche ``clang`` [it-clang]_, leggete la documentazione
 :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
 
diff --git a/Documentation/translations/zh_CN/process/programming-language.rst b/Documentation/translations/zh_CN/process/programming-language.rst
index 2a47a1d2ec20..fabdc338dbfb 100644
--- a/Documentation/translations/zh_CN/process/programming-language.rst
+++ b/Documentation/translations/zh_CN/process/programming-language.rst
@@ -9,8 +9,7 @@
 ============
 
 内核是用C语言 :ref:`c-language <cn_c-language>` 编写的。更准确地说，内核通常是用 :ref:`gcc <cn_gcc>`
-在 ``-std=gnu89`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C90的 GNU 方言（
-包括一些C99特性）
+在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <cn_gcc-c-dialect-options>` 下编译的：ISO C11的 GNU 方言
 
 这种方言包含对语言 :ref:`gnu-extensions <cn_gnu-extensions>` 的许多扩展，当然，它们许多都在内核中使用。
 
diff --git a/Documentation/translations/zh_TW/process/programming-language.rst b/Documentation/translations/zh_TW/process/programming-language.rst
index 54e3699eadf8..144bdaf81a41 100644
--- a/Documentation/translations/zh_TW/process/programming-language.rst
+++ b/Documentation/translations/zh_TW/process/programming-language.rst
@@ -12,8 +12,7 @@
 ============
 
 內核是用C語言 :ref:`c-language <tw_c-language>` 編寫的。更準確地說，內核通常是用 :ref:`gcc <tw_gcc>`
-在 ``-std=gnu89`` :ref:`gcc-c-dialect-options <tw_gcc-c-dialect-options>` 下編譯的：ISO C90的 GNU 方言（
-包括一些C99特性）
+在 ``-std=gnu11`` :ref:`gcc-c-dialect-options <tw_gcc-c-dialect-options>` 下編譯的：ISO C11的 GNU 方言
 
 這種方言包含對語言 :ref:`gnu-extensions <tw_gnu-extensions>` 的許多擴展，當然，它們許多都在內核中使用。
 
diff --git a/Makefile b/Makefile
index c791bfd5a471..1ba8dc523952 100644
--- a/Makefile
+++ b/Makefile
@@ -517,7 +517,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror=implicit-function-declaration -Werror=implicit-int \
 		   -Werror=return-type -Wno-format-security \
-		   -std=gnu89
+		   -std=gnu11
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
@@ -785,7 +785,7 @@ KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
-# The kernel builds with '-std=gnu89' so use of GNU extensions is acceptable.
+# The kernel builds with '-std=gnu11' so use of GNU extensions is acceptable.
 KBUILD_CFLAGS += -Wno-gnu
 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
 # source of a reference will be _MergedGlobals and not on of the whitelisted names.
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index f46457f1f4f0..ed181bedbffc 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -69,7 +69,7 @@ VDSO_CFLAGS += -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                -Werror-implicit-function-declaration \
                -Wno-format-security \
                -Wdeclaration-after-statement \
-               -std=gnu89
+               -std=gnu11
 VDSO_CFLAGS  += -O2
 # Some useful compiler-dependent flags from top-level Makefile
 VDSO_CFLAGS += $(call cc32-option,-Wdeclaration-after-statement,)
-- 
2.29.2

